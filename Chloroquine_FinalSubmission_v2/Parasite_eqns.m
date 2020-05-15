function dydt = Parasite_eqns(t,P,a)

% function outputts the current number of parasites based on a diffeq
% model for parasite increases versus decreases
kP = a(1);% kP is the clearance rate of parasites
r = a(2);% r = growth rate of parasites, assuming a doubling rate of 24 hrs

%P is the current 
dydt = zeros(3,1); %initialize the dydt object as a column to avoid throwing errors in ode45
dydt(1) = r*P(1) - kP*P(1);%parasite balance, total # of parasites in blood
dydt(2) = -kP*P(1) ;  % parasite clearance only
dydt(3) = r*P(1);    % parasite growth only
