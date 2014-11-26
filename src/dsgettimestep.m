function r = dsgettimestep(ds)
%
% Returns the timestep of the sampling of data in ds using the parameter
% "timestep_sec" stored in the UserData
%
% Emanuele Ruffaldi - PERCRO SSSA 2012
%
% See Also: dsgetparam
r = dsgetparam(ds,'timestep_sec');
