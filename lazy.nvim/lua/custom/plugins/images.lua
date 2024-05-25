return {
  {
    "vhyrro/luarocks.nvim",
    -- priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
    ft = { "markdown", "asciidoc" },
  },
  {
    "3rd/image.nvim",
    ft = { "markdown", "asciidoc" },
    dependencies = { "luarocks.nvim" },
    config = function()
      require("image").setup {
        integrations = {
          markdown = {
            resolve_image_path = function(document_path, image_path, fallback)
              -- document_path is the path to the file that contains the image
              -- image_path is the potentially relative path to the image. for
              -- markdown it's `![](this text)`

              -- you can call the fallback function to get the default behavior
              return fallback(document_path, image_path)
            end,
          },
        },
      }
    end,
  },
}
