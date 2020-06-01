
local ns2_GetMaterialXYOffset = GetMaterialXYOffset
function GetMaterialXYOffset(techId)
    if techId == kTechId.Wall then
        techId = kTechId.Armory
    end
    return ns2_GetMaterialXYOffset(techId)
end