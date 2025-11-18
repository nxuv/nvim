-- Borders
local M = {}

M.normal = { "┌", " ", "┐", " ", "┘", " ", "└", " " }
M.normal_full = {"┌", "─", "┐", "│", "┘", "─", "└" , "│" }
M.telescope = { " ", " ", " ", " ", "┌", "┐", "┘", "└" }
M.telescope_bottom = { " ", " ", " ", " ", "├", "┤", "┘", "└" }
M.telescope_top = { " ", " ", " ", " ", "┌", "┐", " ", " " }
M.winsep = {"─", "│", "┌", "┐", "└" ,"┘" }
M.winsep_no_corners = {"─", "│", "├", "┤", "├" ,"┤" }

return M


