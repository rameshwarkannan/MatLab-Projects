%output = PLOT2DOMAINS (equation)
%   Plot the given symbolic equation with 2 MATLAB domains.  The figure
%   handle is returned.  x is the independent variable.

% Student Name 1: Rameshwar Kannan

% Student 1 #: 301300734

% Student 1 userid (email):rkannan@sfu.ca

% Student Name 2: Santhosh Nandakumar

% Student 2 #: 301300261

% Student 2 userid (email):snandaku@sfu.ca 

% Below, edit to list any people who helped you with the assignment, 
%      or put ‘none’ if nobody helped (the two of) you.

% Helpers: _everybody helped us/me with the assignment (list names or put ‘none’)__

function output = plot2domains (equation)  
% This function plots a function over two pre specified domains  

    lowerTitle = 'for -30\pi<x<30\pi';

%Plots the function in the domain -2pi<x<2pi'    
	subplot(2,1,1)
    ezplot(equation,[-2*pi,2*pi])
    hold on
    xlabel('x value')
    ylabel('y value')
    title({char(equation);'for -2\pi<x<2\pi'})
%Plots the function in the domain -30pi<x<30pi'     
	subplot(2,1,2)
    ezplot(equation,[-30*pi,30*pi])
    hold on
    xlabel('x value')
    ylabel('y value')
    title(lowerTitle)
    
    
    
   
  
    % place your work here
    
    output = gcf;
end

