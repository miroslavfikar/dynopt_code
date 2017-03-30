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

function fun = gradp_objfun(t,x,u,p)
global ADiGator_gradp_objfun
if isempty(ADiGator_gradp_objfun); ADiGator_LoadData(); end
Gator1Data = ADiGator_gradp_objfun.gradp_objfun.Gator1Data;
% ADiGator Start Derivative Computations
x2.f = x(2);
fun.f = x2.f;
end


function ADiGator_LoadData()
global ADiGator_gradp_objfun
ADiGator_gradp_objfun = load('gradp_objfun.mat');
return
end