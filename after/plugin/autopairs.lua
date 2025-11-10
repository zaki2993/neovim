local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then return end

npairs.setup({
  check_ts = true, -- use treesitter for better pairing
  fast_wrap = {},
})


