function dydt = Parasite_eqns(t,kP, r)

% function outputts the current number of parasites based on a diffeq
% model for parasite increases versus decreases

% r = growth rate of parasites, assuming a doubling rate of 24 hrs
% kP is the clearance rate of parasites 

%P is the current 
dydt(1) = P*exp(-kP*t)*(-kP) -P*exp(r*t)*r ; %parasite balance, total # of parasites in blood
dydt(3) = P*exp(-kP*t)*(-kP) ;  % parasite clearance only
dydt(3) = -P*exp(r*t)*r;        % parasite growth only