--required -using relative paths
require "AddAppDirectory"
AddAppDirectory()
 
colorTable = {
	E = {0/255, 154/255, 150/255,255/255},
	Es = {238/255, 154/255, 0/255,255/255},
	H = {25/255, 25/255, 112/255,255/255},
	K = {255/255,192/255,203/255,255/255},
	R = {97/255, 135/255, 241/255,255/255},
	S = {0/255, 204/255, 102/255,255/255},
	Sh = {176/255, 23/255, 31/255,255/255},
	Sp = {231/255, 226/255, 0/255,255/255},
	Spi = {199/255, 84/255, 230/255,255/255},
}

local function loadPumpModelsOSG(a)
	-- local subdirectory = a.subdirectory or [[../OSGModels/]]
	local subdirectory = a.subdirectory or [[../OSGModels/newModelRevision/]]
	local scale = a.scale or 2
	local rotation = AngleAxis(Degrees(-45),Axis{0.0,1.0,0.0})
	-- local rotation = AngleAxis(Degrees(0),Axis{0.0,1.0,0.0})
	--Endcap
	E_osg = Transform{orientation = rotation, scale = scale, Model(subdirectory..[[E.osg]])}
	changeTransformColor(E_osg, colorTable.E)
	
	--Endcap Screws
	Es_osg = Transform{orientation = rotation, scale = scale, Model(subdirectory..[[Es.osg]])}
	changeTransformColor(Es_osg, colorTable.Es)

	--Housing
	H_osg = Transform{orientation = rotation, scale = scale, Model(subdirectory..[[H.osg]])}
	changeTransformColor(H_osg, colorTable.H)

	--Kit
	K_osg = Transform{orientation = rotation, scale = scale, Model(subdirectory..[[K.osg]])}
	changeTransformColor(K_osg, colorTable.K)

	--Retaining Ring
	R_osg = Transform{orientation = rotation, scale = scale, Model(subdirectory..[[R.osg]])}
	changeTransformColor(R_osg, colorTable.R)

	--Spring
	S_osg = Transform{orientation = rotation, scale = scale, Model(subdirectory..[[S.osg]])}
	changeTransformColor(S_osg, colorTable.S)

	--Shaft
	Sh_osg = Transform{orientation = rotation, scale = scale, Model(subdirectory..[[Sh.osg]])}
	changeTransformColor(Sh_osg, colorTable.Sh)

	--Swash Plate
	Sp_osg = Transform{orientation = rotation, scale = scale, Model(subdirectory..[[Sp.osg]])}
	changeTransformColor(Sp_osg, colorTable.Sp)

	--Servo Piston
	Spi_osg = Transform{orientation = rotation, scale = scale, Model(subdirectory..[[Spi.osg]])}
	changeTransformColor(Spi_osg, colorTable.Spi)
	
end

function addPumpToSpartaAndReturnParts(a)

	local scale = a.scale or 2
	loadPumpModelsOSG{scale = 2}

	local voxSize = a.voxSize or 0.003
	local density = a.density or 100
	local pos = a.pos or {1.5,1.5,1.5}

	local function addEs()
		Es = addObject{
			voxelsize = voxSize,
			position = pos,
			density = density*5,
			Es_osg,
		}
	end
	
	local function addE()
		E = addObject{
			voxelsize = voxSize,
			position = pos,
			density = density,
			E_osg,
		}
	end


	local function addH()
		H = addObject{
			voxelsize = voxSize,
			position = pos,
			density = density,
			H_osg,
			fixed = true,
			selectable = false
		}
	end

	local function addK()
		K = addObject{
			voxelsize = voxSize,
			position = pos,
			density = density,
			K_osg,
		}
	end

	local function addR()
		R = addObject{
			voxelsize = voxSize,
			position = pos,
			density = density*65,
			R_osg,
		}
	end

	local function addS()
		S = addObject{
			voxelsize = voxSize,
			position = pos,
			density = density*5,
			S_osg,
		}
	end

	local function addSh()
		Sh = addObject{
			voxelsize = voxSize,
			position = pos,
			density = density*2,
			Sh_osg,
		}
	end

	local function addSp()
		Sp = addObject{
			voxelsize = voxSize,
			position = pos,
			density = density*5,
			Sp_osg,
		}
	end

	local function addSpi()
		Spi = addObject{
			voxelsize = voxSize,
			position = pos,
			density = density*25,
			Spi_osg,
		}
	end

	local function addAllPartsToSparta()
		addEs() --0
		addE()  --1
		addH()  --2
		addK()  --3
		addR()  --4
		addS()  --5
		addSh() --6
		addSp() --7
		addSpi()--8
	end
	
	addAllPartsToSparta()
	local allParts = {E,Es,H,K,R,S,Sh,Sp,Spi}
	return allParts
end

function addPumpSingleObject(a)
	local scale = a.scale or 2
	loadPumpModelsOSG{scale = 2}
	local voxSize = a.voxSize or 0.003
	local density = a.density or 60
	local pos = a.pos or {1.5,1.5,1.5}
	local allOSGParts = Transform{position = {0,-1,0}, E_osg,Es_osg,H_osg,K_osg,R_osg,S_osg,Sh_osg,Sp_osg,Spi_osg}
	pumpBODY = addObject{
		voxelsize = voxSize,
		position = pos,
		density = density*1,
		allOSGParts,
	}
	return {pumpBody}
end