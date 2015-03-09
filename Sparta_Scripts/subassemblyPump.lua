--"wand" defined in wand.lua
require("osgFX")
local addRemoveBtn = gadget.DigitalInterface("WMButtonPlus")
local subBtn = gadget.DigitalInterface("WMButtonMinus")

function UserEnterExit()
	return subBtn.justPressed
end


function UserAddRemove()
	if addRemoveBtn.justPressed and wand.hovering  then
		return wand:getHover()
	else
		return nil
	end
end

local GraphicsNode = osgFX.Scribe()
GraphicsNode:setWireframeLineWidth(5)

function addSubassembly(my_parts)
	pump_sub = Subassembly{
		parts = my_parts,
		EnterExitFunc = UserEnterExit,
		AddRemoveFunc = UserAddRemove,
		graphics_node = GraphicsNode
	}
	return pump_sub
end

