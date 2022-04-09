local render = {}

local floor = math.floor

function render:line(x1, y1, x2, y2, r, g, b, a)
    draw.Color(floor(r), floor(g), floor(b), floor(a))
    draw.Line(x1, y1, x2, y2)
end

function render:filledrect(x1, y1, x2, y2, r, g, b, a)
    draw.Color(floor(r), floor(g), floor(b), floor(a))
    draw.FilledRect(x1, y1, x2, y2)
end

function render:outlinerect(x1, y1, x2, y2, r, g, b, a)
    draw.Color(floor(r), floor(g), floor(b), floor(a))
    draw.OutlinedRect(x1, y1, x2, y2)
end

function render:text(x, y, text, r, g, b, a, font, centered)
    draw.Color(floor(r), floor(g), floor(b), floor(a))
    draw.SetFont(font)
    local textsize = draw.GetTextSize(text)
    local center_x = 0
    if centered then
        center_x = textsize / 2
    end
    draw.Text(floor(x - center_x), floor(y), text)
end

function render:textoutline(x, y, text, r, g, b, a, font, centered)
    self:text(x - 1, y, text, 0, 0, 0, a, font, centered)
    self:text(x + 1, y, text, 0, 0, 0, a, font, centered)
    self:text(x, y - 1, text, 0, 0, 0, a, font, centered)
    self:text(x, y + 1, text, 0, 0, 0, a, font, centered)
    self:text(x, y, text, r, g, b, a, font, centered)
end

function render:textshadow(x, y, text, r, g, b, a, font, centered)
    self:text(x + 1, y + 1, text, 0, 0, 0, a, font, centered)
    self:text(x, y + 1, text, r, g, b, a, font, centered)
end

return render
