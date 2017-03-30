% This code was generated using ADiGator version 1.3
% ©2010-2014 Matthew J. Weinstein and Anil V. Rao
% ADiGator may be obtained at https://sourceforge.net/projects/adigator/ 
% Contact: mweinstein@ufl.edu
% Bugs/suggestions may be reported to the sourceforge forums
%                    DISCLAIMER
% ADiGator is a general-purpose software distributed under the GNU General
% Public License version 3.0. While the software is distributed with the
% hope that it will be useful, both the software and generated code are
% provided 'AS IS' with NO WARRANTIES OF ANY KIND and no merchantability
% or fitness for any purpose or application.

function [c,ceq] = gradt_confun(t,x,u,p,flag)
global ADiGator_gradt_confun
if isempty(ADiGator_gradt_confun); ADiGator_LoadData(); end
Gator1Data = ADiGator_gradt_confun.gradt_confun.Gator1Data;
% ADiGator Start Derivative Computations
cadaconditional1 = eq(flag,0);
cadaconditional2 = eq(flag,1);
cadaconditional3 = eq(flag,2);
if cadaconditional1
    c.f =  [];
    ceq.f =  [];
elseif cadaconditional2
    c.f =  [];
    ceq.f =  [];
elseif cadaconditional3
    c.f =  [];
    ceq.f =  [];
else
end
end


function ADiGator_LoadData()
global ADiGator_gradt_confun
ADiGator_gradt_confun = load('gradt_confun.mat');
return
end