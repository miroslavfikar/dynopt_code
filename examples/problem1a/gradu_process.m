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

function sys = gradu_process(t,x,u,p,flag)
global ADiGator_gradu_process
if isempty(ADiGator_gradu_process); ADiGator_LoadData(); end
Gator1Data = ADiGator_gradu_process.gradu_process.Gator1Data;
% ADiGator Start Derivative Computations
% parameters can be set through global variables :
global x10 x20 
% do not modify the individual IF,ELSE conditions !!
cadaconditional1 = eq(flag,7);
cadaconditional2 = eq(flag,5);
if cadaconditional1
    % mass matrix
    sys.f =  [];
    sys.du = zeros(2,1);
    sys.f(2,1) = 0;
elseif cadaconditional2
    % initial conditions for ODE system x0 can be scalar or vector:
    cadainput2_1.f = [x10;x20];
    cadaoutput2_1 = ADiGator_initial_conditions(cadainput2_1);
    sys.f = cadaoutput2_1.f;
    sys.du = zeros(2,1);
else
    % ODE system :
    x1.f = x(1);
    x2.f = x(2);
    cada1f1 = x1.f^2;
    cada1f2du = 2.*u.f.^(2-1).*u.du;
    cada1f2 = u.f^2;
    cada1f3du = cada1f2du;
    cada1f3 = cada1f1 + cada1f2;
    cada1td1 = zeros(2,1);
    cada1td1(1) = u.du;
    cada1td1(2) = cada1f3du;
    sys.du = cada1td1;
    sys.f = [u.f;cada1f3];
end
sys.du_size = 2;
sys.du_location = Gator1Data.Index1;
end
function init = ADiGator_initial_conditions(x0)
global ADiGator_gradu_process
Gator1Data = ADiGator_gradu_process.ADiGator_initial_conditions.Gator1Data;
% ADiGator Start Derivative Computations
init.f = x0.f;
end


function ADiGator_LoadData()
global ADiGator_gradu_process
ADiGator_gradu_process = load('gradu_process.mat');
return
end