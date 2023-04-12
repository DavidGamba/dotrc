local status_ok, select_ease = pcall(require, "SelectEase") -- ziontee113/SelectEase
if not status_ok then
	return
end

local lua_query = [[
	;; query
	((identifier) @cap)
	("string_content" @cap)
	((true) @cap)
	((false) @cap)
]]

local python_query = [[
	;; query
	((identifier) @cap)
	((string) @cap)
	((true) @cap)
	((false) @cap)
	((attribute) @cap)
]]

local go_query = [[
    ;; query
    ((selector_expression) @cap) ; Method call
    ((field_identifier) @cap) ; Method names in interface

    ; Identifiers
    ((identifier) @cap)
    ((expression_list) @cap) ; pseudo Identifier
    ((int_literal) @cap)
    ((interpreted_string_literal) @cap)

    ; Types
    ((type_identifier) @cap)
    ((pointer_type) @cap)
    ((slice_type) @cap)

    ; Keywords
    ((true) @cap)
    ((false) @cap)
    ((nil) @cap)
]]

local rust_query = [[
	;; query
	((boolean_literal) @cap)
	((string_literal) @cap)
	; Identifiers
	((identifier) @cap)
	((field_identifier) @cap)
	((field_expression) @cap)
	((scoped_identifier) @cap)
	((unit_expression) @cap)
	; Types
	((reference_type) @cap)
	((primitive_type) @cap)
	((type_identifier) @cap)
	((generic_type) @cap)
	; Calls
	((call_expression) @cap)
]]
local c_query = [[
	;; query
	((string_literal) @cap)
	((system_lib_string) @cap)
	; Identifiers
	((identifier) @cap)
	((struct_specifier) @cap)
	((type_identifier) @cap)
	((field_identifier) @cap)
	((number_literal) @cap)
	((unary_expression) @cap)
	((pointer_declarator) @cap)
	; Types
	((primitive_type) @cap)
	; Expressions
	(assignment_expression
		right: (_) @cap)
]]
local cpp_query = [[
	;; query
	; Identifiers
	((namespace_identifier) @cap)
]] .. c_query

local queries = {
	lua = lua_query,
	python = python_query,
	go = go_query,
	rust = rust_query,
	c = c_query,
	cpp = cpp_query,
}

-- M-d (k)
vim.keymap.set({ "n", "s", "i" }, "<A-k>", function()
	select_ease.select_node({
		queries = queries,
		direction = "previous",
		vertical_drill_jump = true,
		-- visual_mode = true, -- if you want Visual Mode instead of Select Mode
		fallback = function()
			-- if there's no target, this function will be called
			select_ease.select_node({ queries = queries, direction = "previous" })
		end,
	})
end, {})

-- M-s (j)
vim.keymap.set({ "n", "s", "i" }, "<A-j>", function()
	select_ease.select_node({
		queries = queries,
		direction = "next",
		vertical_drill_jump = true,
		-- visual_mode = true, -- if you want Visual Mode instead of Select Mode
		fallback = function()
			-- if there's no target, this function will be called
			select_ease.select_node({ queries = queries, direction = "next" })
		end,
	})
end, {})

-- M-a (h)
vim.keymap.set({ "n", "s", "i" }, "<A-h>", function()
	select_ease.select_node({
		queries = queries,
		direction = "previous",
		current_line_only = true,
		-- visual_mode = true, -- if you want Visual Mode instead of Select Mode
	})
end, {})

-- M-f (l)
vim.keymap.set({ "n", "s", "i" }, "<A-l>", function()
	select_ease.select_node({
		queries = queries,
		direction = "next",
		current_line_only = true,
		-- visual_mode = true, -- if you want Visual Mode instead of Select Mode
	})
end, {})

-- previous / next node that matches query
vim.keymap.set({ "n", "s", "i" }, "<A-p>", function()
	select_ease.select_node({ queries = queries, direction = "previous" })
end, {})
vim.keymap.set({ "n", "s", "i" }, "<A-n>", function()
	select_ease.select_node({ queries = queries, direction = "next" })
end, {})
