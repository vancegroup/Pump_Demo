local myrotate = function(xform,axis,degree,degreeperdt,dt)
	A = {x=0,y=0,z=0}
	if A[axis] == nil then 
		error("error: second argument must be x,y, or z", 2)
	end
	A[axis] = (degree/math.abs(degree))
	local theAxis = Axis{A.x,A.y,A.z}
	-- local dt = Actions.waitForRedraw()
	local function rotateAction()
		local dt = Actions.waitForRedraw()
		local angle = 0
		while true do
			angle = angle + degreeperdt * dt
			xform:preMult(
				osg.Matrixd(
					AngleAxis(Degrees(degreeperdt * dt), theAxis)
				)
			)
			dt = Actions.waitForRedraw()
		end
	end
	return rotateAction
end

function changeTransformColor(xform, color)
	local mat = osg.Material()
	mat:setColorMode(0x1201);
	mat:setAmbient (0x0408, osg.Vec4(color[1], color[2], color[3], color[4]))
	mat:setDiffuse (0x0408, osg.Vec4(0.2, 0.2, 0.2, 1.0))
	mat:setSpecular(0x0408, osg.Vec4(0.2, 0.2, 0.2, 1.0))
	mat:setShininess(0x0408, 1)
	local ss = xform:getOrCreateStateSet()
	ss:setAttributeAndModes(mat, osg.StateAttribute.Values.ON+osg.StateAttribute.Values.OVERRIDE);
end

function getFactoryModel()
	factory = Transform{
		orientation = AngleAxis(Degrees(-90), Axis{1.0, 0.0, 0.0}),
		scale = ScaleFrom.inches,
		Model([[OSGModels/basicfactory.ive]])
	}
	return factory
end

function addRotatingFrameAction(PumpAsMatrixTransform)
	rotFunc = myrotate(PumpAsMatrixTransform,"y",190,30)
	Actions.addFrameAction(rotFunc)
end


function doWhen(condition, actionToTake)
	Actions.addFrameAction(function()
			while true do
				if condition() then
					actionToTake()
					Actions.waitForRedraw()
				else
					Actions.waitForRedraw()
				end
			end
		end)
end
function simplePrintFunction(mystr)
	local f = function()
		print(mystr)
	end
	return f
end

function buttonPressed(button)
	local f = function()
		return button.pressed
	end
	return f
end

function buttonJustPressed(button)
	local f = function()
		return button.justPressed
	end
	return f
end

function notButtonPressed(button)
	local f = function()
		return not button.pressed
	end
	return f
end

function setSwitchOff(xform)
	local f = function()
		xform:setAllChildrenOff()
	end
	return f
end

function setSwitchOn(xform)
	local f = function()
		xform:setAllChildrenOn()
	end
	return f
end

function setSingleChildOn(xform,childNumber)
	local f = function()
		xform:setSingleChildOn(childNumber)
	end
	return f
end