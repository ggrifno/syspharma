function dydt = Chloroquine_eqns(t ,y, p)
%define parameters from input parameter vector
%infusion vector
q = p(1); %should always be zero because we are modeling a tablet dose
%volumes of compartments
V1 = p(2); %volume of central compartment
V2 = p(3); %volume of peripheral compartment
V3 = p(4); %volume of cleared CQ from central compartment
V4 = p(5); %volume of cleared CDQ from central compartment
%keq for transport
k10= p(6); %CQ clearance from central compartment
k30= p(7); %DCQ clearance from central compartment
k12= p(8); %transfer of CQ from central to peripheral
k21= p(9); %transfer of CQ from central to peripheral
k23= p(10); %tranfer of CQ to DCQ in the central compartment
k34= p(11); %transfer of DCQ from central to peripheral
k43= p(12); %transfer of DCQ from central to peripheral
ka = p(13);  %absorption from gut to central compartment
%protein binding of CQ in the peripheral compartment
% kon = p(14);
% koff= p(15);

%two-compartment model of Chloroquine ORIGINAL
%question: model drawing implies that drug is only cleared from blood, not
%from peripheral tissues...
dydt = zeros(7,1); %column vector contains all of the values for the 
dydt(1) = q/V1 + ka*y(3)/V1 - k10*y(1) - k12*y(1) + (V2/V1)*k21*y(2) - k23*y(1); % CQ central compartment, q is only used in case of IV delivery, but chloroquine is always delivered orally

dydt(2) = (V1/V2)*k12*y(1) - k21*y(2); % CQ peripheral compartment

dydt(3) = -ka*y(3); % GUT CQ absorption compartment --> set the initial condition of y(4) to the bolus tablet amount D0 to model oral delivery

dydt(4) = k23*y(1)*(V1/V3) + (V4/V3)*k43*y(5) - (k30*y(4) + k34*y(4)); % conversion of CQ to DCQ, central compartment
dydt(5) = (V3/V4)*k34*y(4) - k43*y(5); % DCQ peripheral comparmtent

dydt(6) = k10*y(1)*V1; % virtual clearance of CQ from central compartment
dydt(7) = k30*y(4)*V3; % virtual clearance of DCQ, is only cleared from central DCQ

% 1 - concentration of CQ in central compartment (infusion included here, but typically set to zero in simulations of oral delivery)
% 2 - concentration of CQ in peripheral compartment (clearance included here, but typically set to zero in simulations)
% 3 - amount of drug in virtual GUT compartment --> set the initial condition of y(4) to the bolus tablet 
% 4 - conversion of CQ to DCQ, central compartment
% 5 - DCQ peripheral comparmtent
% 6 - virtual clearance of CQ from central compartment. Note unit change here, the terms in the equation have conc*vol form, which means amount 
% not concentration. This eliminates the need to set a volume for this compartment; just need to be careful in the main code to treat it like an
% amount, not a concentration.
% 7 - virtual clearance of DCQ, is only cleared from central DCQ. 

%CLEARANCE COMPARTMENTS: Note unit change
% here, the terms in the equation have conc*vol form, which means amount 
% not concentration. This eliminates the need to set a volume for this
% compartment; just need to be careful in the main code to treat it like an
% amount, not a concentration.

%% COMPARISON TO ACET_EQNS
% function dydt = Acet_eqns(t,y,p)
% % equations describing the pharmacokinetics of acetaminophen, delivered
% % orally, in a two-compartment model with absorption from the gut and
% % clearance from the central compartment
% 
% q=p(1);
% V1=p(2);
% V2=p(3);
% kc1=p(4);
% kc2=p(5);
% k12=p(6);
% k21=p(7);
% ka =p(8);
% dydt = zeros(4,1);    % use a column vector 
%  
% %% EQUATIONS
% % 1 - concentration of drug in central compartment (infusion included here, 
% % but typically set to zero in simulations of oral delivery)
% % 2 - conceentration of drug in peripheral compartment (clearance included 
% % here, but typically set to zero in simulations)
% % 3 - amount of drug in virtual clearance compartment. Note unit change
% % here, the terms in the equation have conc*vol form, which means amount 
% % not concentration. This eliminates the need to set a volume for this
% % compartment; just need to be careful in the main code to treat it like an
% % amount, not a concentration.
% % 4 - amount of drug in virtual gut compartment. Again, the units here are
% % in amount, not concentration. Note how y4 is divided by V in equation 1
% 
%  dydt(1) = q/V1 + ka*y(4)/V1 - kc1*y(1) - k12*y(1) + (V2/V1)*k21*y(2);
%  dydt(2) =                   - kc2*y(2) + (V1/V2)*k12*y(1) - k21*y(2);
%  dydt(3) =                     kc1*y(1)*V1 + kc2*y(2)*V2;
%  dydt(4) =      - ka*y(4);
%  
%  
% 
