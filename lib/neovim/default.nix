{ lib, ... }:
{
  # Transform a list of keymaps into an attribute set.
  #
  # `transformKeymaps` converts a list of attribute sets, where each attribute set
  # represents a neovim key binding, and returns an attrset of key->value pairs where
  # key is the keybinding and value is the corresponding action.
  # 
  # This is useful for `startup` neovim plugin where bindings are displayed in start screen.
  #
  # Args:
  #   keymaps (list of attr sets): A list of attribute sets where each item contains at least
  #                                a 'key' and an 'action' attribute.
  # Returns:
  #   attr set: An attribute set where each key is a string representing the key binding, and
  #             the value is the corresponding action as a string.
  # Example:
  # ```nix
  #   transformKeymaps [
  #     { key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<CR>"; }
  #     { key = "gd"; action = "<cmd>Telescope lsp_definitions<CR>"; }
  #   ]
  #   # This would result in:
  #   {
  #     "gD" = "<cmd>lua vim.lsp.buf.declaration()<CR>";
  #     "gd" = "<cmd>Telescope lsp_definitions<CR>";
  #   }
  # ```
  transformKeymaps =
    keymaps:
    lib.foldl' (
      acc: elem:
      let
        key = lib.attrByPath [ "key" ] "" elem;
        action = lib.attrByPath [ "action" ] "" elem;
      in
      # Ignore entries without key or action
      if key == "" || action == "" then acc else lib.attrsets.recursiveUpdate acc { ${key} = action; }
    ) { } keymaps;

  # Transform a list of keymaps into a list of lists for startup.nvim.
  #
  # `transformKeymaps` converts a list of attribute sets, where each attribute set
  # represents a neovim key binding, and returns a list of lists where each sublist
  # contains the description, action, and key binding.
  #
  # This is useful for the `startup` neovim plugin where bindings are displayed in the start screen.
  #
  # Args:
  #   keymaps (list of attr sets): A list of attribute sets where each item contains at least
  #                                a 'key', 'action', and 'options.desc' attribute.
  # Returns:
  #   list of lists: A list where each element is a list containing the description, action, and key binding as strings.
  # Example:
  # ```nix
  #   transformKeymaps [
  #     {
  #       key = "<leader>ff";
  #       action = "Telescope find_files";
  #       options = {
  #         desc = "Find File";
  #       };
  #     }
  #     {
  #       key = "<leader>lg";
  #       action = "Telescope live_grep";
  #       options = {
  #         desc = "Find Word";
  #       };
  #     }
  #   ]
  #   # This would result in:
  #   [
  #     [ "Find File" "Telescope find_files" "<leader>ff" ]
  #     [ "Find Word" "Telescope live_grep" "<leader>lg" ]
  #   ]
  # ```
  # transformKeymapsToList =
  #   keymaps:
  #   lib.mapAttrsToList
  #     (
  #       name: elem:
  #       let
  #         key = lib.attrByPath [ "key" ] "" elem;
  #         action = lib.attrByPath [ "action" ] "" elem;
  #         desc = lib.attrByPath [
  #           "options"
  #           "desc"
  #         ] "No description" elem;
  #       in
  #       [
  #         desc
  #         action
  #         key
  #       ]
  #     )
  #     (
  #       lib.listToAttrs (
  #         lib.mapAttrsToList (x: y: {
  #           name = x;
  #           value = y;
  #         }) keymaps
  #       )
  #     );

  transformKeymapsToList =
    keymaps:
    builtins.map (
      keymap:
      let
        key = lib.attrByPath [ "key" ] "" keymap;
        action = lib.attrByPath [ "action" ] "" keymap;
        desc = lib.attrByPath [
          "options"
          "desc"
        ] "No description" keymap;
      in
      [
        desc
        action
        key
      ]
    ) keymaps;
}
