
local ns2_InitTechTree = MarineTeam.InitTechTree
function MarineTeam:InitTechTree()
    ns2_InitTechTree(self)
    self.techTree:AddUpgradeNode(kTechId.Wall)
    self.techTree:SetComplete()
end