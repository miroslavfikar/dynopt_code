Adigator in DYNOPT :

1.) what needs to be changed in dynopt.m 
       user defined function for process, objective function and constraints 
       are now : 
       a) objective function     : objfun_function.m
       b) process model function : process_function.m
       c) constraintes function  : confun_function.m
       
2.) automatic gradients were tested on examples from the current dynopt manual 
    available on tbxmanager. 
    a) chapter 3 examples : 3.1.1, 3.1.2, 3.1.3, 3.1.4, 3.1.6
    b) chapter 5 examples : problem -- 4,5,6,7
    c) own examples       : test_nocontrol, test_membrane
       
3.) not working : 
    a) 3.1.5 -- not working -- problem with the extra entry in the objective 
       function "objfun.m". 
    b) examples with the Mass matrix (example 3.2.1)
    
