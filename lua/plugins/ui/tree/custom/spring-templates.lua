local M = {}

local function get_package_declaration(package_path, subdir)
	if package_path == "" then
		return ""
	end
	if subdir and subdir ~= "" then
		return "package " .. package_path .. "." .. subdir .. ";\n\n"
	end
	return "package " .. package_path .. ";\n\n"
end

local function make_import(package_path, subdir, class_name)
	if package_path == "" then
		return ""
	end
	if subdir and subdir ~= "" then
		return string.format("import %s.%s.%s;\n", package_path, subdir, class_name)
	end
	return string.format("import %s.%s;\n", package_path, class_name)
end

local function to_camel(pascal)
	return pascal:sub(1, 1):lower() .. pascal:sub(2)
end

local function to_snake_case(pascal)
	return pascal
		:gsub("(%u)", function(c)
			return "_" .. c:lower()
		end)
		:sub(2)
end

function M.get_entity_template(class_name, package_path)
	local package_decl = get_package_declaration(package_path)
	local snake = to_snake_case(class_name)
	local table_name = snake .. "s"
	local seq = snake .. "_id_sequence"

	return package_decl
		.. string.format(
			[[
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import java.time.Instant;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Table(name = "%s")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@EntityListeners(AuditingEntityListener.class)
public class %s {

  @Id
  @EqualsAndHashCode.Include
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "%s")
  @SequenceGenerator(
      name = "%s",
      sequenceName = "%s",
      allocationSize = 20)
  private Long id;

  // TODO: Add fields

  @CreatedDate
  @Column(nullable = false, updatable = false)
  private Instant createdAt;

  @LastModifiedDate
  @Column(nullable = false)
  private Instant updatedAt;
}
]],
			table_name,
			class_name,
			seq,
			seq,
			seq
		)
end

function M.get_dao_interface_template(class_name, package_path)
	local package_decl = get_package_declaration(package_path, "dao")
	return package_decl .. string.format(
		[[
public interface %sDao {

  // TODO: Add methods
}
]],
		class_name
	)
end

function M.get_repository_template(class_name, package_path)
	local package_decl = get_package_declaration(package_path, "dao")
	local entity_import = make_import(package_path, nil, class_name)

	return package_decl
		.. entity_import
		.. string.format(
			[[
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface %sRepository extends JpaRepository<%s, Long> {

  // TODO: Add methods
}
]],
			class_name,
			class_name
		)
end

function M.get_jpa_service_template(class_name, package_path)
	local package_decl = get_package_declaration(package_path, "dao")
	return package_decl
		.. string.format(
			[[
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class %sJpaDataAccessService implements %sDao {

  private final %sRepository repository;
}
]],
			class_name,
			class_name,
			class_name
		)
end

function M.get_request_dto_template(class_name, package_path)
	local package_decl = get_package_declaration(package_path, "dto")
	return package_decl
		.. string.format(
			[[
public record %sRequest(
    // TODO: Add fields
    ) {}
]],
			class_name
		)
end

function M.get_response_dto_template(class_name, package_path)
	local package_decl = get_package_declaration(package_path, "dto")
	return package_decl
		.. string.format(
			[[
import lombok.Builder;

@Builder
public record %sResponse(
    Long id
    // TODO: Add fields
    ) {}
]],
			class_name
		)
end

function M.get_mapper_template(class_name, package_path)
	local package_decl = get_package_declaration(package_path, "internal")
	local entity_import = make_import(package_path, nil, class_name)
	local response_import = make_import(package_path, "dto", class_name .. "Response")

	return package_decl
		.. entity_import
		.. response_import
		.. string.format(
			[[
import java.util.List;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface %sMapper {

  %sResponse toResponse(%s entity);

  List<%sResponse> toResponseList(List<%s> entities);
}
]],
			class_name,
			class_name,
			class_name,
			class_name,
			class_name
		)
end

function M.get_service_template(class_name, package_path)
	local package_decl = get_package_declaration(package_path, "service")
	local dao_import = make_import(package_path, "dao", class_name .. "Dao")

	return package_decl
		.. dao_import
		.. string.format(
			[[
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class %sService {

  private final %sDao %sDao;
}
]],
			class_name,
			class_name,
			to_camel(class_name)
		)
end

function M.get_controller_template(class_name, package_path)
	local package_decl = get_package_declaration(package_path)
	local service_import = make_import(package_path, "service", class_name .. "Service")

	return package_decl
		.. service_import
		.. string.format(
			[[
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/vX/%ss")
@RequiredArgsConstructor
public class %sController {

  private final %sService %sService;
}
]],
			to_camel(class_name),
			class_name,
			class_name,
			to_camel(class_name)
		)
end

function M.get_all_templates(class_name, package_path)
	return {
		{ path = "/" .. class_name .. ".java", content = M.get_entity_template(class_name, package_path) },
		{
			path = "/dao/" .. class_name .. "Dao.java",
			content = M.get_dao_interface_template(class_name, package_path),
		},
		{
			path = "/dao/" .. class_name .. "Repository.java",
			content = M.get_repository_template(class_name, package_path),
		},
		{
			path = "/dao/" .. class_name .. "JpaDataAccessService.java",
			content = M.get_jpa_service_template(class_name, package_path),
		},
		{
			path = "/dto/" .. class_name .. "Request.java",
			content = M.get_request_dto_template(class_name, package_path),
		},
		{
			path = "/dto/" .. class_name .. "Response.java",
			content = M.get_response_dto_template(class_name, package_path),
		},
		{
			path = "/internal/" .. class_name .. "Mapper.java",
			content = M.get_mapper_template(class_name, package_path),
		},
		{
			path = "/service/" .. class_name .. "Service.java",
			content = M.get_service_template(class_name, package_path),
		},
		{
			path = "/" .. class_name .. "Controller.java",
			content = M.get_controller_template(class_name, package_path),
		},
	}
end

return M
