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

function sys = gradp_process(t,x,flag,u,p)
global ADiGator_gradp_process
if isempty(ADiGator_gradp_process); ADiGator_LoadData(); end
Gator1Data = ADiGator_gradp_process.gradp_process.Gator1Data;
% ADiGator Start Derivative Computations
% do not modify the individual IF,ELSE conditions !!
cadaconditional1 = eq(flag,7);
cadaconditional2 = eq(flag,5);
if cadaconditional1
    % mass matrix
    sys.f =  [];
    sys.f(4,1) = 0;
elseif cadaconditional2
    % initial conditions for ODE system:
    x10.f =  0;
    x20.f =  -1;
    x30.f =  -sqrt(5);
    x40.f =  0;
    cadainput2_1.f = [x10.f;x20.f;x30.f;x40.f];
    cadaoutput2_1 = ADiGator_initial_conditions(cadainput2_1);
    sys.f = cadaoutput2_1.f;
else
    % ODE system :
    cada1f1 = x(2);
    cada1f2 = x(3);
    cada1f3 = uminus(cada1f2);
    cada1f4 = u(1);
    cada1f5 = cada1f3*cada1f4;
    cada1f6 = 16*t;
    cada1f7 = cada1f5 + cada1f6;
    cada1f8 = cada1f7 - 8;
    cada1f9 = x(1);
    cada1f10 = cada1f9^2;
    cada1f11 = x(2);
    cada1f12 = cada1f11^2;
    cada1f13 = cada1f10 + cada1f12;
    cada1f14 = x(2);
    cada1f15 = 16*t;
    cada1f16 = cada1f14 + cada1f15;
    cada1f17 = cada1f16 - 8;
    cada1f18 = x(3);
    cada1f19 = 0.1*cada1f18;
    cada1f20 = u(1);
    cada1f21 = cada1f20^2;
    cada1f22 = cada1f19*cada1f21;
    cada1f23 = cada1f17 - cada1f22;
    cada1f24 = cada1f23^2;
    cada1f25 = 0.0005*cada1f24;
    cada1f26 = cada1f13 + cada1f25;
    sys.f = [cada1f1;cada1f8;u;cada1f26];
end
end
function init = ADiGator_initial_conditions(x0)
global ADiGator_gradp_process
Gator1Data = ADiGator_gradp_process.ADiGator_initial_conditions.Gator1Data;
% ADiGator Start Derivative Computations
init.f = x0.f;
end


function ADiGator_LoadData()
global ADiGator_gradp_process
ADiGator_gradp_process = load('gradp_process.mat');
return
end