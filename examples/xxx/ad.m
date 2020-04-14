at = adigatorCreateDerivInput([1 1],'t');
ax = adigatorCreateDerivInput([1 4],'x');
au = adigatorCreateDerivInput([1 1],'u');
ap = adigatorCreateDerivInput([0 1],'p');

for flag = [0 5 7]
  adigator('process',{at,ax,flag,au,ap},['deriv_process_',num2str(flag),],adigatorOptions('overwrite',1));
end