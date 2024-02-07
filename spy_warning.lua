--[[
  github: mcdonaldsfan

  For LMAOBOX.net
]]
local function get_class_entity(class_int, enemy_only)
    local class_ents = {}
    local players = entities.FindByClass("CTFPlayer")
    local localplayer = entities.GetLocalPlayer()
    for _, v in pairs(players) do
        local ent_classes = v:GetPropInt("m_iClass")
        local team_num = v:GetPropInt("m_iTeamNum")
        if enemy_only and team_num == localplayer:GetPropInt("m_iTeamNum") then goto continue end
        if ent_classes ~= class_int then goto continue end
        table.insert(class_ents, v)
        ::continue::
    end
    return class_ents
end

local screen_x, screen_y = draw.GetScreenSize()
local font_calibri = draw.CreateFont("calibri", 20, 40)

local function paint_spy()
    local spies = get_class_entity(8, true)
    local localplayer = entities.GetLocalPlayer()
    for i, v in pairs(spies) do
        local spy_origin = v:GetAbsOrigin()
        local local_origin = localplayer:GetAbsOrigin()
        local distance = vector.Distance(spy_origin, local_origin)
        if distance > 350 then goto continue end
        draw.SetFont(font_calibri)
        local str = string.format("A spy is nearby! - %s[%s]", v:GetName(), math.floor(distance))
        local text_x, text_y = draw.GetTextSize(str)
        draw.Color(255, 0, 0, 255)
        draw.Text(screen_x / 2 - math.floor(text_x / 2), math.floor(screen_y / 1.9) + 16 * i, str)
        ::continue::
    end
end

callbacks.Register("Draw", "paint_spy_draw", paint_spy)
