function colisionFilter(item, other)
  --if other.class.name == "corner" or other.class.name == "padL" or other.class.name == "padR" then
    return "bounce";
  --end
end

--function tableName(tbl)
--  assert(type(tbl)=="table", "tbl must be a table")
--    for n, v in getfenv() do
--        if v == tbl then
--            return n
--        end
--    end
--    return nil
--end


function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end