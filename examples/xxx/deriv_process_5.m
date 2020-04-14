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

function sys = deriv_process_5(t,x,flag,u,p)
global ADiGator_deriv_process_5
if isempty(ADiGator_deriv_process_5); ADiGator_LoadData(); end
Gator1Data = ADiGator_deriv_process_5.deriv_process_5.Gator1Data;
% ADiGator Start Derivative Computations
global x10 x20 
%User Line: global
cadaconditional1 = eq(flag,5);
%User Line: cadaconditional1 = flag == 5;
    sys.f = [x10;x20];
    %User Line: sys = [x10;x20];
    %User Line: sys = [u(1);	   x(1)];
end


function ADiGator_LoadData()
global ADiGator_deriv_process_5
ADiGator_deriv_process_5 = load('deriv_process_5.mat');
return
end