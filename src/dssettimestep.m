% sets the timestep associated to the dataset
function ds = dssettimestep(ds,Ts)

ds = dssetparam(ds,'timestep_sec',Ts);