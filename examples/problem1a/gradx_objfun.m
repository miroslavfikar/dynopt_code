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

function fun = gradx_objfun(t,x,u,p)
global ADiGator_gradx_objfun
if isempty(ADiGator_gradx_objfun); ADiGator_LoadData(); end
Gator1Data = ADiGator_gradx_objfun.gradx_objfun.Gator1Data;
% ADiGator Start Derivative Computations
x2.dx = x.dx(2);
x2.f = x.f(2);
fun.dx = x2.dx; fun.f = x2.f;
fun.dx_size = 2;
fun.dx_location = Gator1Data.Index1;
end


function ADiGator_LoadData()
global ADiGator_gradx_objfun
ADiGator_gradx_objfun = load('gradx_objfun.mat');
return
end