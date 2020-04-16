function dydt = Chloroquine_eqns(t ,y, p)

%define parameters from input parameter vector
%infusion vector
q = p(1); %should always be zero because we are modeling a tablet dose
%volumes of compartments
V1 = p(2); %volume of central compartment
V2 = p(3); %volume of peripheral compartment
V3 = p(4); %volume of cleared drug from central compartment
V4 = p(5); %volume of cleared drug from peripheral compartment
%keq for transport
k10= p(6); %clearance from central compartment
k30= p(7); %clearance from peripheral compartment
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
dydt = zeros(8,1); %column vector contains all of the values for the 
dydt(1) = q/V1 + ka*y(4)/V1 - k10*y(1) - k12*y(1) + (V2/V1)*k21*y(2) - k23*y(1) + koff*y(7) - kon*y(1); % CQ central compartment, q is only used in case of IV delivery, but chloroquine is always delivered orally
dydt(2) =(V1/V2)*k12*y(1) - k21*y(2); % CQ peripheral compartment
dydt(3) = k10*y(1)*V1;                % virtual clearance of CQ, only cleared from central compartment
dydt(4) = - ka*y(4);                  % CQ absorption compartment (gut??) will be useful in modeling oral delivery in boluses
dydt(5) = k23*y(1)*V1 + k43*y(6) - (k30*y(5) + k34*y(6)); % conversion of CQ to DCQ, central compartment NEED VOLUME CORRECTIONS??
dydt(6) = k34*y(5) - (V2/V1)*k43*y(6); % DCQ peripheral comparmtent
dydt(7) = kon*y(1); % amount of CQ that is bound to serum proteins
dydt(8) = koff*y(7);% amount of CQ that is coming unbound from serum proteins
dydt(10)= k30*y(5); % virtual clearance of DCQ, is only cleared from central DCQ

% 1 - concentration of drug in central compartment (infusion included here, but typically set to zero in simulations of oral delivery)
% 2 - conceentration of drug in peripheral compartment (clearance included here, but typically set to zero in simulations)
% 3 - amount of drug in virtual clearance compartment. Note unit change here, the terms in the equation have conc*vol form, which means amount 
% not concentration. This eliminates the need to set a volume for this compartment; just need to be careful in the main code to treat it like an
% amount, not a concentration.
% 4 - amount of drug in virtual gut compartment. Again, the units here are in amount, not concentration. Note how y4 is divided by V in equation 1
%...

