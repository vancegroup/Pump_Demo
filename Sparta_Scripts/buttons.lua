require "AddAppDirectory"
require("Actions")
require("TransparentGroup")
AddAppDirectory()

runfile[[helperFunctions.lua]]


local function bindButtonsToModelSwitch(model_switch,buttons)
	doWhen(buttonJustPressed(gadget.DigitalInterface("JSButton"..buttons[1])), setSingleChildOn(model_switch,0))
	doWhen(buttonJustPressed(gadget.DigitalInterface("JSButton"..buttons[2])), setSingleChildOn(model_switch,1))
	doWhen(buttonJustPressed(gadget.DigitalInterface("JSButton"..buttons[3])), setSingleChildOn(model_switch,2))
end