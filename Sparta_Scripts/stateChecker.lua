require("Actions")
require "AddAppDirectory"
AddAppDirectory()

-- dofile(vrjLua.findInModelSearchPath([[loadBurrPuzzle.lua]]))
-- dofile(vrjLua.findInModelSearchPath([[..\graph\loadGraphFiles.lua]]))



local assemblyPos = nil
local OSGBodies = {}
local SimulationBodies = {}
local BodyIDTable = {}

local function initiatePartStates(a)
	assemblyPos = a.assemblyPos or osg.Vec3d(1.5,1.5,1.5)
	 
	for _,body in ipairs(a.parts) do
		BodyIDTable[body] = body.id
		table.insert(SimulationBodies,body)
	end
end

local function getTransformForCoordinateFrame(coordinateFrame, node)
	if node == nil then node = assert(knownInView(coordinateFrame)) end
	if node:isSameKindAs(osg.MatrixTransform()) then
		return node
	else
		return getTransformForCoordinateFrame(coordinateFrame, node.Child[1])
	end
end
 
local function getOSGBodyFromCoordinateFrame(body)
	if OSGBodies[body] ~= nil then
		 return OSGBodies[body]
	else
		OSGBodies[body] = getTransformForCoordinateFrame(body).Child[1]
		return OSGBodies[body]
	end
end
 
local function PartInAssembley(body,assemblyCenter)
	-- local assemblyCenter = part_positions[H]
	local bodyPos = getOSGBodyFromCoordinateFrame(body):getMatrix():getTrans()
	-- local bodyPos = part_positions[body]
	local distance = (assemblyCenter - bodyPos):length()
	if distance < threshold then
		return true
	else
		return false
	end
end

function getCurrentState()
	local state=""
	local bodies_in_state = {}
	for _,body in ipairs(SimulationBodies) do
		if(PartInAssembley(body,assemblyPos)) then
			table.insert(bodies_in_state,BodyIDTable[body])
		end
	end
	table.sort(bodies_in_state)
	for _,bodyid in ipairs(bodies_in_state) do
		state = state..bodyid
	end
	return state
end

function getCurrentStateFromSubassembly()
	local state=""
	local bodies_in_state = {}
	for _,body in ipairs(pump_sub.subassembly_bodies) do
		table.insert(bodies_in_state,BodyIDTable[body])
	end
	table.sort(bodies_in_state)
	for _,bodyid in ipairs(bodies_in_state) do
		state = state..bodyid
	end
	return state
end

function KeepTrackofState()
	local counter = 0
	local state = getStateMethod()
	while true do
		if counter > 25 then
			local newState = getStateMethod()
			if state ~= newState and g:getNode(newState) ~= nil then
				print("State change:"..newState)
				g:updateCurrentState(newState)
				--only save when going down
				if #newState < #state then
					print("keeping track of states: saving a down point - hope you aren't using Subassembly")
					time_travel:savePoint()
				end
				state = newState
			end
			counter = 0
		end
		counter = counter + 1
		Actions.waitForRedraw()
	end
end

function fa()
	KeepTrackofState()
end

addStateCheckerActionFrame = function(a)
	subassembly = a.subassembly or nil
	if subassembly then
		print("going with a sub")
		getStateMethod = getCurrentStateFromSubassembly
	else
		print("just the normal way!")
		getStateMethod = getCurrentState
	end
	threshold = a.threshold or .25
	initiatePartStates(a)
	Actions.addFrameAction(fa)
end

			
		