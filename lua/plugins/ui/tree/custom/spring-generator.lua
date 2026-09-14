local M = {}

local function to_pascal_case(input)
	local parts = {}
	for word in input:gmatch("%S+") do
		parts[#parts + 1] = word:sub(1, 1):upper() .. word:sub(2):lower()
	end
	return table.concat(parts)
end

local function to_snake_lower(input)
	local parts = {}
	for word in input:gmatch("%S+") do
		parts[#parts + 1] = word:lower()
	end
	return table.concat(parts)
end

function M.create_module(state)
	local node = state.tree:get_node()
	local path = node:get_id()
	if node.type == "file" then
		path = vim.fn.fnamemodify(path, ":h")
	end
	vim.ui.input({ prompt = "Module name (e.g., Offering, Master Booking): " }, function(module_name)
		if not module_name or module_name == "" then
			return
		end
		local class_name = to_pascal_case(module_name)
		local dir_name = to_snake_lower(module_name)
		local base_path = path .. "/" .. dir_name
		M.create_directories(base_path)
		local package_path = M.get_package_path(base_path)
		M.create_files(base_path, class_name, package_path)
		require("neo-tree.sources.manager").refresh("filesystem")
		vim.notify("Created Spring module: " .. class_name, vim.log.levels.INFO)
	end)
end

function M.get_package_path(full_path)
	local src_pattern = ".*/(src/main/java/)"
	local test_pattern = ".*/(src/test/java/)"
	local _, src_end = full_path:find(src_pattern)
	if not src_end then
		_, src_end = full_path:find(test_pattern)
	end
	if src_end then
		local package_part = full_path:sub(src_end + 1)
		return package_part:gsub("/", ".")
	end
	return ""
end

function M.create_directories(base_path)
	local dirs = {
		base_path,
		base_path .. "/dao",
		base_path .. "/dto",
		base_path .. "/internal",
		base_path .. "/interservice",
		base_path .. "/event",
		base_path .. "/service",
	}
	for _, dir in ipairs(dirs) do
		vim.fn.mkdir(dir, "p")
	end
end

function M.create_files(base_path, class_name, package_path)
	local templates = require("spring-templates")
	local files = templates.get_all_templates(class_name, package_path)
	for _, file_config in ipairs(files) do
		local full_path = base_path .. file_config.path
		local file = io.open(full_path, "w")
		if file then
			file:write(file_config.content)
			file:close()
		end
	end
end

return M
