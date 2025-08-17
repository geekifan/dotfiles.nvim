return {
    "samjwill/nvim-unception",
    init = function()
        vim.api.nvim_create_autocmd(
            "User",
            {
                pattern = "UnceptionEditRequestReceived",
                callback = function()
                    -- Toggle the terminal off.
                    require('toggleterm').toggle()
                end
            }
        )
    end
}