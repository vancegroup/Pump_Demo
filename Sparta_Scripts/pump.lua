require "AddAppDirectory"
AddAppDirectory()
switchToBasicFactory()

runfile[[simpleLights.lua]]
runfile[[helperFunctions.lua]]
runfile[[wand.lua]]
runfile[[load_pump.lua]]
runfile[[stateChecker.lua]]
runfile[[McFly.lua]]
runfile[[loadGraph.lua]]
-- runfile[[subassemblyPump.lua]]

--for web interface
vrjKernel.loadConfigFile(vrjLua.findInModelSearchPath([[json_vrpn.jconf]]))

-- local head_position = gadget.PositionInterface("VJHead").position:y()
local head_position = 1.905
local oneFootInMeters = 0.3048 -- 1 * ScaleFrom.Feet
local pump_position = {2,head_position - oneFootInMeters,1.5}
local graph_position = {1, 2.15, 0}
-- part_positions = {}

-- parts = addPumpSingleObject({pos = pump_position})

parts = addPumpToSpartaAndReturnParts({pos = pump_position})
-- local pump_sub = addSubassembly(parts)

-- g is graph object, gxform is transform containing root osg (for graph)
g, gxform = createAndReturnGraphVisualization{pos = graph_position}

local function highlightPath()
	g:getEdge("012345678","12345678"):setColor({0,1,0,1})
	g:getEdge("12345678", "1235678"):setColor({0,1,0,1})
	g:getEdge("1235678", "235678"):setColor({0,1,0,1})
	g:getEdge("235678", "23678"):setColor({0,1,0,1})
	g:getEdge("23678", "2678"):setColor({0,1,0,1})
	g:getEdge("2678", "278"):setColor({0,1,0,1})
	g:getEdge("278", "28"):setColor({0,1,0,1})
	g:getEdge("28", "2"):setColor({0,1,0,1})
end

local function unHighlightPath()
	g:getEdge("012345678","12345678"):setColor({(75/255),(75/255),(75/255),1})
	g:getEdge("12345678", "1235678"):setColor({(75/255),(75/255),(75/255),1})
	g:getEdge("1235678", "235678"):setColor({(75/255),(75/255),(75/255),1})
	g:getEdge("235678", "23678"):setColor({(75/255),(75/255),(75/255),1})
	g:getEdge("23678", "2678"):setColor({(75/255),(75/255),(75/255),1})
	g:getEdge("2678", "278"):setColor({(75/255),(75/255),(75/255),1})
	g:getEdge("278", "28"):setColor({(75/255),(75/255),(75/255),1})
	g:getEdge("28", "2"):setColor({(75/255),(75/255),(75/255),1})
end

--for reset / time travel options
time_travel = McFly{parts = parts}
--update state for graph visualization (to come)
addStateCheckerActionFrame{parts = parts , assemblyPos = osg.Vec3d(unpack(pump_position))}

--add graph to scene
function addGraphToScene()
	gxform:setScale(Vec(1.5,1.5,1.5))
	gxform = Switch{gxform}
	gxform:setAllChildrenOn()
	RelativeTo.World:addChild(gxform)
end
addGraphToScene()

local function bindButtonsToModelSwitch()
	local function resetParts()
		local resetFunc = function()
			time_travel:reset()
		end
		local f = function()
			simulation:runFunctionWithSimulationPaused(resetFunc)
			Actions.waitForRedraw()
		end
		return f
	end
	
	local function goBack1()
			local back1Func = function()
				time_travel:goBack(1)
			end
		local f = function()
			simulation:runFunctionWithSimulationPaused(back1Func)
			Actions.waitForRedraw()
		end
		return f
	end
	-- highlight path on graph WEB INTERFACE (Leif)
	doWhen(buttonJustPressed(gadget.DigitalInterface("JSButton3")), highlightPath)
	doWhen(buttonJustPressed(gadget.DigitalInterface("JSButton4")), unHighlightPath)
	-- hide/show graph WEB INTERFACE (Leif)
	doWhen(buttonJustPressed(gadget.DigitalInterface("JSButton5")), setSwitchOn(gxform,0))
	doWhen(buttonJustPressed(gadget.DigitalInterface("JSButton6")), setSwitchOff(gxform,0))
	-- reset parts/goBack WEB INTERFACE (Leif)
	doWhen(buttonJustPressed(gadget.DigitalInterface("JSButton1")), resetParts())
	doWhen(buttonJustPressed(gadget.DigitalInterface("JSButton2")), goBack1())
	-- reset parts/goBack WIIMOTE (User)
	doWhen(buttonJustPressed(gadget.DigitalInterface("WMButtonHome")), resetParts())
	doWhen(buttonJustPressed(gadget.DigitalInterface("WMButtonLeft")), goBack1())
end

bindButtonsToModelSwitch()
		
--required: start the Sparta Simulation
simulation:startInSchedulerThread()