-- Function to load bundle of plugins
function load_bundle(bundle_name)
    local plugin_files = vim.api.nvim_get_runtime_file("lua/plugins/" .. bundle_name .. "/*.lua", true)

    local plugin_names = {}
    for _, plugin_file in ipairs(plugin_files) do
        table.insert(plugin_names, plugin_file:match(".+/([^/]+)%.lua"))
    end

    -- Load all plugins before sourcing configs
    -- Configs might require other plugins in the bundle to be loaded
    for _, plugin_name in ipairs(plugin_names) do
        vim.api.nvim_command("packadd " .. plugin_name)
    end

    for _, plugin_name in ipairs(plugin_names) do
        require("plugins." .. bundle_name .. "." .. plugin_name)
    end
end

-- Commands to load a bundle of plugins along with the bundles it is based on
vim.api.nvim_create_user_command("LoadCore", function()
    load_bundle("core")
end, {})
vim.api.nvim_create_user_command("LoadDev", function()
    load_bundle("core")
    load_bundle("dev")
end, {})

