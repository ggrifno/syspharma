function dydt = Chloroquine_eqns(t ,y, p)

% 1 - concentration of drug in central compartment (infusion included here, 
% but typically set to zero in simulations of oral delivery)
% 2 - conceentration of drug in peripheral compartment (clearance included 
% here, but typically set to zero in simulations)
% 3 - amount of drug in virtual clearance compartment. Note unit change
% here, the terms in the equation have conc*vol form, which means amount 
% not concentration. This eliminates the need to set a volume for this
% compartment; just need to be careful in the main code to treat it like an
% amount, not a concentration.
% 4 - amount of drug in virtual gut compartment. Again, the units here are
% in amount, not concentration. Note how y4 is divided by V in equation 1
%...
%define parameters from input parameter vector
q=p(1);
V1=p(2);
V2=p(3);
V3=p(4);
V4=p(5);
kc1=p(6);
kc2=p(7);
k12=p(8);
k21=p(9);
ka =p(10);

%two-compartment model of Chloroquine ORIGINAL
%question: model drawing implies that drug is only cleared from blood, not
%from peripheral tissues...
dydt = zeros(7,1);
dydt(1) = q/V1 + ka*y(4)/V1 - k10*y(1) - k12*y(1) + (V2/V1)*k21*y(2); % CQ central compartment, q is only used in case of IV delivery, but chloroquine is always delivered orally
dydt(2) =                   (V1/V2)*k12*y(1) - k21*y(2); % CQ peripheral compartment
dydt(3) =                     kc1*y(1)*V1; % virtual clearance of CQ, only cleared from central compartment
dydt(4) =      - ka*y(4); %CQ absorption compartment (gut??) will be useful in modeling oral delivery in boluses
dydt(5) = k23*y(1)*V1 + k43*y(6) - (k30*y(5) + k34*y(6)); % conversion of CQ to DCQ, central compartment NEED VOLUME CORRECTIONS??
dydt(6) = k34*y(5) - k43*y(6); % DCQ peripheral comparmtent
dydt(7) = k30*y(5); % virtual clearance of DCQ, is only cleared from central DCQ

%two-compartment model of Vancomycin ORIGINAL
% dydt = zeros(3,1);
% dydt(1) = qinf/VD1 + (VD2/VD1)*k21*y(2) - k12*y(1) -kcl*y(1); %drug in central compartment
% dydt(2) =            (VD1/VD2)*k12*y(1) - k21*y(2);           %drug in peripheral compartment
% dydt(3) =                                           kcl*y(1); %cleared compartment

% %two-compartment model of Vancomycin NEW
% dydt = zeros(3,1);
% dydt(1) = qinf/VD1 + k21*y(2) - (VD2/VD1)*k12*y(1) -(kcl/VD1)*y(1); %drug in central compartment
% dydt(2) =            k12*y(1) - (VD1/VD2)*k21*y(2);                 %drug in peripheral compartment
% dydt(3) =                                           kcl*y(1);       %cleared compartment

