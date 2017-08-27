%output = Q2 
%   Plot the required equation with its first and second derivatives, 
%   local maxima, local minima, inflection points, and vertical asymptotes.  
%   The figure handle is returned.

% Student Name 1: RameshwarKannan

% Student 1 #: 301300734

% Student 1 userid (email): rkannan@sfu.ca

% Student Name 2: Santhosh Nandakumar

% Student 2 #: 301300261

% Student 2 userid (email): snandaku@sfu.ca

% Below, edit to list any people who helped you with the assignment, 
%      or put ‘none’ if nobody helped (the two of) you.

% Helpers: _everybody helped us/me with the assignment (All the TAs and Prof.)__

function output = Q2

% This function plots an equation, its first and second derivative as well
% as its local extrema, inflection points and vertical asymptotes
syms x;
denom=x^2-2
y=(2*x^4-x^2+x-1)/(x^2-2)
%Plots the function of y 
title(char(y))
fplot((2*x^4-x^2+x-1)/(x^2-2))
xlim([-3,3])
ylim([-200,200])
grid on
hold on
xlabel('x value')
ylabel('value')
%Plots the first derivative 
title(char(y))
dy=diff(y)
fplot(dy)
%Plots the second derivative
ddy=diff(dy)
fplot(ddy)
%Second derivative test is performed to obtain local extrema
z=solve(dy)
convertdouble=double(z)
reallocal=real(convertdouble)
isreal=convertdouble==reallocal
realloc=convertdouble(isreal)
%Solving second derivative to find inflection points
s=(solve(ddy))
convertdouble1=double(s)
realconcave=real(convertdouble1)
isreal1=convertdouble1==realconcave
realcon=convertdouble1(isreal1)
%Completetion of the second derivative test by finding
%the x and y values of the extrema
loc1=double(subs(ddy,realloc(1,1)))
loc2=double(subs(ddy,realloc(3,1)))
loc3=double(subs(ddy,realloc(2,1)))
l1=double(subs(y,realloc(1,1)))
l3=double(subs(y,realloc(2,1)))
l2=double(subs(y,realloc(3,1)))
%Solving the denominator of the function to obtain the vertical asymptotes
v2=double(solve(denom))

%Checking if each local extrema is either a maximum or minimum and plotting
%with correspondence to colour 
XL1=[realloc(1,1),realloc(3,1)]
YL1=[l1,l2]
XL2=[realloc(2,1)]
YL2=[l3]
plot(XL2,YL2,'ro')
plot(XL1,YL1,'bo')
c1=double(subs(y,realcon(1,1)))
c2=double(subs(y,realcon(2,1)))
YC=[c1,c2];
XC=[realcon(1,1),realcon(2,1)];
plot(XC,YC,'go')
hold on
plot(v2,[0 0],'kx')
legend('y','dy','ddy','Local Maxima','Local Minima','Inflection Points','Vert. Asymptotes','Location', 'north')



output = gcf;