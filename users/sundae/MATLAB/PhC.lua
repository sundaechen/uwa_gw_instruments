
lattice_param = 0.415
lambda = 1.2607
angle_phi = -2.9167
angle_theta = 0
s_polarization = 1
p_polarization = 0
holeradius = 0.1465
thickness = 0.2
epsilon_real = 3.9299
epsilon_imag = 0
norders = 20
tempfile = io.open("tempfile.txt", "a")
S = S4.NewSimulation()
S:SetLattice({2*lattice_param,0}, {0,2*lattice_param})
S:SetNumG(norders)
S:AddMaterial("PhCMaterial", {epsilon_real,epsilon_imag})
S:AddMaterial("Vacuum", {1,0})
S:AddLayer("AirAbove", 0 , "Vacuum")
S:AddLayer("Slab", thickness, "PhCMaterial")
S:SetLayerPatternCircle("Slab", "Vacuum", {0,0}, holeradius)
S:SetLayerPatternCircle("Slab", "Vacuum", {lattice_param,0}, holeradius)
S:SetLayerPatternCircle("Slab", "Vacuum", {0,lattice_param}, holeradius)
S:AddLayerCopy("AirBelow", 0, "AirAbove")
S:SetLayerThickness("Slab", thickness)
S:SetExcitationPlanewave({angle_phi,angle_theta},{s_polarization,0},{p_polarization,0})
S:SetFrequency(1./lambda)
refl = 1. - S:GetPowerFlux("AirBelow")
tempfile:write(lambda .. " " .. refl .. "\n")
io.input():close()
