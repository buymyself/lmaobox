--[[
    animated hitlog recoded

    remade animation

    github: mcdonaldsfan
]]

local queue = {}
local floor = math.floor
local x, y = draw.GetScreenSize()
local font_calibri = draw.CreateFont("Calibri", 18, 18)

local function event_hook(ev)
    if ev:GetName() ~= "player_hurt" then return end -- only allows player_hurt event go through
    --declare variables
    --to get all structures of event: https://wiki.alliedmods.net/Team_Fortress_2_Events#player_hurt
    
    local victim_entity = entities.GetByUserID(ev:GetInt("userid"))
    local attacker = entities.GetByUserID(ev:GetInt("attacker"))
    local localplayer = entities.GetLocalPlayer()
    local damage = ev:GetInt("damageamount")
    local iscrit = ev:GetString("crit") == 1 and true or false
    local health = ev:GetInt("health")
    local ping = entities.GetPlayerResources():GetPropDataTableInt("m_iPing")[victim_entity:GetIndex()]

    if attacker ~= localplayer then return end
    --insert table
    table.insert(queue, {
        string = string.format("Hit %s for %d damage (%d health remaining) [crit=%s;ping=%s;]", victim_entity:GetName(), damage, health, iscrit, ping),
        delay = globals.RealTime() + 5.5,
        alpha = 0,
    })

    printc(100, 255, 100, 255, string.format("[LMAOBOX] Hit %s for %d damage (%d health remaining) [crit=%s;ping=%s;]", victim_entity:GetName(), damage, health, iscrit, ping))
end

local function paint_logs()
    draw.SetFont(font_calibri)
    for i, v in pairs(queue) do
        local alpha = floor(v.alpha)
        local text = v.string
        local y_pos = floor(y / 2) + (i * 20)
        draw.Color(255, 255, 255, alpha)
        draw.Text(7, y_pos, text)
    end
end

local function anim()
    for i, v in pairs(queue) do
        if globals.RealTime() < v.delay then --checks if delay is over or not
            v.alpha = math.min(v.alpha + 1, 255) --fade in animation
        else
            v.string = string.sub(v.string, 1, string.len(v.string) - 1) --removes last character
            if 0 >= string.len(v.string) then
                table.remove(queue, i) --if theres no text left, remove the table
            end
        end
    end
end

local function draw_handler()
    paint_logs()
    anim()
end

callbacks.Register("Draw", "unique_draw_hook", draw_handler)
callbacks.Register("FireGameEvent", "unique_event_hook", event_hook)
