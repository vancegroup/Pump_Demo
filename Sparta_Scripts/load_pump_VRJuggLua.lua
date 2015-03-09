--required -using relative paths
require "AddAppDirectory"
AddAppDirectory()
-- runfile[[simpleLights.lua]]
runfile[[helperFunctions.lua]]
-- runfile[[wand.lua]]
-- runfile[[load_pump.lua]]
-- runfile[[stateChecker.lua]]
-- runfile[[McFly.lua]]
-- runfile[[loadGraph.lua]]
local applyPhongToStateSet = function(stateset,lightnum)
	local lightnum = lightnum or 0
    local vert = osg.Shader(osg.Shader.Type.VERTEX, [[
        varying vec3 N;
        varying vec3 v;
        void main(void)  
        {     
           v = vec3(gl_ModelViewMatrix * gl_Vertex);       
           N = normalize(gl_NormalMatrix * gl_Normal);
           gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;  
        }
    ]])
 
    local frag = osg.Shader(osg.Shader.Type.FRAGMENT, [[
        varying vec3 N;
        varying vec3 v;    
        void main (void)  
        {  
           vec3 L = normalize(gl_LightSource[]]..lightnum..[[].position.xyz - v);   
           vec3 E = normalize(-v); // we are in Eye Coordinates, so EyePos is (0,0,0)  
           vec3 R = normalize(-reflect(L,N));  
         
           //calculate Ambient Term:  
           vec4 Iamb = gl_FrontLightProduct[0].ambient;    
 
           //calculate Diffuse Term:  
           vec4 Idiff = gl_FrontLightProduct[0].diffuse * max(dot(N,L), 0.0);
           Idiff = clamp(Idiff, 0.0, 1.0);     
           
           // calculate Specular Term:
           vec4 Ispec = gl_FrontLightProduct[0].specular 
                        * pow(max(dot(R,E),0.0),0.3*gl_FrontMaterial.shininess);
           Ispec = clamp(Ispec, 0.0, 1.0); 
           // write Total Color:  
           gl_FragColor = gl_FrontLightModelProduct.sceneColor + Iamb + Idiff + Ispec;     
        }
    ]])
 
    local program = osg.Program()
    program:addShader(vert)
    program:addShader(frag)
    stateset:setAttributeAndModes(program, osg.StateAttribute.Values.ON)
end
 
 
colorTable = {
	E = {0/255, 154/255, 150/255,255/255},
	Es = {238/255, 154/255, 0/255,255/255},
	H = {97/255, 135/255, 241/255,255/255},
	K = {255/255,192/255,203/255,255/255},
	R = {25/255, 25/255, 112/255,255/255},
	S = {0/255, 204/255, 102/255,255/255},
	Sh = {176/255, 23/255, 31/255,255/255},
	Sp = {231/255, 226/255, 0/255,255/255},
	Spi = {199/255, 84/255, 230/255,255/255},
}

local function loadPumpModelsOSG(a)
	
	local scale = a.scale or 2
	--Endcap
	E_osg = Transform{scale = scale, Model[[../OSGModels/E.osg]]}
	changeTransformColor(E_osg, colorTable.E)
	
	--Endcap Screws
	Es_osg = Transform{scale = scale, Model[[../OSGModels/Es.osg]]}
	changeTransformColor(Es_osg, colorTable.Es)

	--Housing
	H_osg = Transform{scale = scale, Model[[../OSGModels/H.osg]]}
	changeTransformColor(H_osg, colorTable.H)

	--Kit
	K_osg = Transform{scale = scale, Model[[../OSGModels/K.osg]]}
	changeTransformColor(K_osg, colorTable.K)

	--Retaining Ring
	R_osg = Transform{scale = scale, Model[[../OSGModels/R.osg]]}
	changeTransformColor(R_osg, colorTable.R)

	--Spring
	S_osg = Transform{scale = scale, Model[[../OSGModels/S.osg]]}
	changeTransformColor(S_osg, colorTable.S)

	--Shaft
	Sh_osg = Transform{scale = scale, Model[[../OSGModels/Sh.osg]]}
	changeTransformColor(Sh_osg, colorTable.Sh)

	--Swash Plate
	Sp_osg = Transform{scale = scale, Model[[../OSGModels/Sp.osg]]}
	changeTransformColor(Sp_osg, colorTable.Sp)

	--Servo Piston
	Spi_osg = Transform{scale = scale, Model[[../OSGModels/Spi.osg]]}
	changeTransformColor(Spi_osg, colorTable.Spi)
	
end

function applyPhong()
	applyPhongToStateSet(Es_osg:getOrCreateStateSet())
	applyPhongToStateSet(E_osg:getOrCreateStateSet())
	applyPhongToStateSet(K_osg:getOrCreateStateSet())
	applyPhongToStateSet(H_osg:getOrCreateStateSet())
	applyPhongToStateSet(R_osg:getOrCreateStateSet())
	applyPhongToStateSet(S_osg:getOrCreateStateSet())
	applyPhongToStateSet(Sh_osg:getOrCreateStateSet())
	applyPhongToStateSet(Sp_osg:getOrCreateStateSet())
	applyPhongToStateSet(Spi_osg:getOrCreateStateSet())
end

loadPumpModelsOSG({})
local allParts_osg = Transform{E_osg,Es_osg,H_osg,K_osg,R_osg,S_osg,Sh_osg,Sp_osg,Spi_osg}
RelativeTo.World:addChild(allParts_osg)