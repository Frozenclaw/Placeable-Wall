-- A placeable wall for marine commander to block off certain routes


Script.Load("lua/Mixins/ClientModelMixin.lua")
Script.Load("lua/LiveMixin.lua")
Script.Load("lua/PointGiverMixin.lua")
Script.Load("lua/AchievementGiverMixin.lua")
Script.Load("lua/GameEffectsMixin.lua")
Script.Load("lua/SelectableMixin.lua")
Script.Load("lua/FlinchMixin.lua")
Script.Load("lua/LOSMixin.lua")
Script.Load("lua/CorrodeMixin.lua")
Script.Load("lua/ConstructMixin.lua")
Script.Load("lua/ResearchMixin.lua")
Script.Load("lua/RecycleMixin.lua")
Script.Load("lua/CommanderGlowMixin.lua")

Script.Load("lua/ScriptActor.lua")
Script.Load("lua/RagdollMixin.lua")
Script.Load("lua/NanoShieldMixin.lua")
Script.Load("lua/ObstacleMixin.lua")
Script.Load("lua/WeldableMixin.lua")
Script.Load("lua/UnitStatusMixin.lua")
Script.Load("lua/DissolveMixin.lua")
Script.Load("lua/PowerConsumerMixin.lua")
Script.Load("lua/GhostStructureMixin.lua")
Script.Load("lua/MapBlipMixin.lua")
Script.Load("lua/CombatMixin.lua")
Script.Load("lua/InfestationTrackerMixin.lua")
Script.Load("lua/SupplyUserMixin.lua")
Script.Load("lua/IdleMixin.lua")
Script.Load("lua/ParasiteMixin.lua")

class 'Wall' (ScriptActor)
Wall.kMapName = 'wall'
Wall.kModelName = PrecacheAsset("models/props/eclipse/eclipse_wallmods01_03.model")

local networkVars = {}

AddMixinNetworkVars(BaseModelMixin, networkVars)
AddMixinNetworkVars(ClientModelMixin, networkVars)
AddMixinNetworkVars(LiveMixin, networkVars)
AddMixinNetworkVars(GameEffectsMixin, networkVars)
AddMixinNetworkVars(FlinchMixin, networkVars)
AddMixinNetworkVars(TeamMixin, networkVars)
AddMixinNetworkVars(LOSMixin, networkVars)
AddMixinNetworkVars(CorrodeMixin, networkVars)
AddMixinNetworkVars(ConstructMixin, networkVars)
AddMixinNetworkVars(ResearchMixin, networkVars)
AddMixinNetworkVars(RecycleMixin, networkVars)
AddMixinNetworkVars(SelectableMixin, networkVars)

AddMixinNetworkVars(NanoShieldMixin, networkVars)
AddMixinNetworkVars(ObstacleMixin, networkVars)
AddMixinNetworkVars(DissolveMixin, networkVars)
AddMixinNetworkVars(PowerConsumerMixin, networkVars)
AddMixinNetworkVars(GhostStructureMixin, networkVars)
AddMixinNetworkVars(CombatMixin, networkVars)
AddMixinNetworkVars(IdleMixin, networkVars)
AddMixinNetworkVars(ParasiteMixin, networkVars)

function Wall:OnCreate()

    ScriptActor.OnCreate(self)
    
    InitMixin(self, BaseModelMixin)
    InitMixin(self, ModelMixin)
    InitMixin(self, LiveMixin)
    InitMixin(self, TeamMixin)
    InitMixin(self, ConstructMixin)
    InitMixin(self, EntityChangeMixin)
    InitMixin(self, ResearchMixin)
    InitMixin(self, RecycleMixin)
    InitMixin(self, CombatMixin)
    InitMixin(self, SelectableMixin)
    InitMixin(self, GhostStructureMixin)
    InitMixin(self, PointGiverMixin)

    self:SetPhysicsType(PhysicsType.Kinematic)

    
   

end

function Wall:OnInitialized()
	 
	ScriptActor.OnInitialized(self)
	InitMixin(self, WeldableMixin)
	InitMixin(self, NanoShieldMixin)
	self:SetModel(Wall.kModelName)
    
	if Server then 
	
		if not HasMixin(self, 'MapBlip') then
			InitMixin(self, MapBlipMixin)
		end 
        
	elseif Client then
		InitMixin(self, UnitStatusMixin)
		InitMixin(self, HiveVisionMixin)
	end 
	
end 

function Wall:GetRecieveStructuralDamage()
	return true
end 

function Wall:GetRequiresPower()
	return true
end 

function Wall:GetDamagedAlertId()
	return kTechId.MarineAlertStructureUnderAttack
end 


function Wall:GetHealthbarOffset()
    return gArmoryHealthHeight
end

if Server then 

	function Wall:OnKill()
	
		self:TriggerEffects('death')
		DestroyEntity(self)
	
	end
	
end 

Shared.LinkClassToMap('Wall', Wall.kMapName, networkVars)
	