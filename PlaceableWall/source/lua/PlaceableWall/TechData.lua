
local ns2_BuildTechData = BuildTechData

function BuildTechData()

    local techData = ns2_BuildTechData()

    local wallTechData =
    
	{
		[kTechDataId] = kTechId.Wall,
		[kTechDataRequiresPower] = false,
		[kTechDataMapName] = Wall.kMapName,
		[kTechDataDisplayName] = 'WALL',
		[kTechDataCostKey] = 10,
		[kTechDataBuildTime] = 2,
		[kTechDataMaxHealth] = 2000,
		[kTechDataMaxArmor] = 0,
		[kTechDataModel] = Wall.kModelName,
		[kTechDataPointValue] = 3,
		[kTechDataNotOnInfestation] = kPreventMarineStructuresOnInfestation,
		[kTechDataTooltipInfo] = 'A wall that can be placed to block aliens path',
	}
    
   
    for i, k in pairs(wallTechData) do
        table.insert(techData, wallTechData)
    end

    return techData
end