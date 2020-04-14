% This code was generated using ADiGator version 1.4
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

function sys = deriv_process_7(t,x,flag,u,p)
global ADiGator_deriv_process_7
if isempty(ADiGator_deriv_process_7); ADiGator_LoadData(); end
Gator1Data = ADiGator_deriv_process_7.deriv_process_7.Gator1Data;
% ADiGator Start Derivative Computations
global x10 x20 
%User Line: global
cadaconditional1 = eq(flag,5);
%User Line: cadaconditional1 = flag == 5;
    %User Line: sys = [x10;x20];
    cada1f1du = u.du(1);
    cada1f1 = u.f(1);
    cada1f2dx = x.dx(1);
    cada1f2 = x.f(1);
    cada1td1 = zeros(1,1);
    cada1td1(1) = cada1f2dx;
    sys.dx = cada1td1;
    cada1td1 = zeros(1,1);
    cada1td1(1) = cada1f1du;
    sys.du = cada1td1;
    sys.f = [cada1f1;cada1f2];
    %User Line: sys = [u(1);	   x(1)];
sys.dx_size = [2,4];
sys.dx_location = Gator1Data.Index1;
sys.du_size = 2;
sys.du_location = Gator1Data.Index2;
end


function ADiGator_LoadData()
global ADiGator_deriv_process_7
ADiGator_deriv_process_7 = load('deriv_process_7.mat');
return
end