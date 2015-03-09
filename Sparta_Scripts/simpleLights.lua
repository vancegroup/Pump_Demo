require("getScriptFilename")
fn = getScriptFilename()


--RelativeTo.World:addChild(robot)

ss = RelativeTo.World:getOrCreateStateSet()
--RelativeTo.World:addChild(Sphere{radius=.23, position = {0,3,-5}})
--RelativeTo.World:addChild(Sphere{radius=.23, position = {1.5,2,-6}})
function doLight1()

	l1 = osg.Light()
	l1:setAmbient(osg.Vec4(0.1, 0.1, 0.1, 0))
	-- l1:setSpecular(osg.Vec4(.2, .2, .2, 0))
	ls1 = osg.LightSource()
	ls1:setLight(l1)
	ls1:setLocalStateSetModes(osg.StateAttribute.Values.ON)
	ss:setAssociatedModes(l1, osg.StateAttribute.Values.ON)
	RelativeTo.Room:addChild(
		ls1
	)

	l1:setPosition(osg.Vec4(0, .25, 0, 1))
end

function doLight1_5()

	l3 = osg.Light()
	l3:setLightNum(3)
	l3:setAmbient(osg.Vec4(.2, .2, .2, 0))
	
	ls3 = osg.LightSource()
	ls3:setLight(l3)
	ls3:setLocalStateSetModes(osg.StateAttribute.Values.ON)

	ss:setAssociatedModes(l3, osg.StateAttribute.Values.ON)
	
	RelativeTo.Room:addChild(
		ls3
	)
	l3:setPosition(osg.Vec4(1.5, .25, 0,0))
end

function doLight2()

	l2 = osg.Light()
	l2:setLightNum(1)
	l2:setAmbient(osg.Vec4(.1, .1, .1, 0))
	-- l2:setSpecular(osg.Vec4(.2, .2, .2, 0))
	-- l2:setDiffuse(osg.Vec4(.8, .8, .8, 0))
	
	ls2 = osg.LightSource()
	ls2:setLight(l2)
	ls2:setLocalStateSetModes(osg.StateAttribute.Values.ON)

	ss:setAssociatedModes(l2, osg.StateAttribute.Values.ON)
	
	RelativeTo.Room:addChild(
		ls2
	)
	l2:setPosition(osg.Vec4(3, 3,3 , 1))
end

doLight1()
doLight2()
doLight1_5()
