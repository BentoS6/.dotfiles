function replay_subtitle()
    local substart = mp.get_property_number("sub-start")
    if substart then
        local suboffset = mp.get_property_number("sub-delay", 0)
        mp.set_property_number("time-pos", substart + suboffset)
    else
        mp.commandv("sub-seek", -1)
    end
end

function step_subtitle()
    local subend = mp.get_property_number("sub-end")
    if subend then
        local suboffset = mp.get_property_number("sub-delay", 0)
        mp.set_property_number("time-pos", subend + suboffset)
    else
        mp.commandv("sub-seek", 1)
    end
end

mp.add_key_binding(nil, "replay-subtitle", replay_subtitle)
mp.add_key_binding(nil, "step-subtitle", step_subtitle)
