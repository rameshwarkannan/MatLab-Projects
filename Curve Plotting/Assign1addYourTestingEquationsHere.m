%% ENSC180 Assignment1 script where you can add your tests

% Student Name 1: student1

% Student 1 #: 123456781

% Student 1 userid (email): stu1 (stu1@sfu.ca)

% Student Name 2: student2

% Student 2 #: 123456782

% Student 2 userid (email): stu2 (stu2@sfu.ca)

% Below, edit to list any people who helped you with the assignment, 
%      or put ‘none’ if nobody helped (the two of) you.

% Helpers: _everybody helped us/me with the assignment (list names or put ‘none’)__
%% Initialization
clear
syms x;          
%% Question 1
equation = (0.2*x^5)+(2*x^4)-(11*x^3)+(24*x)+48;           
 plot2domains(equation);
equation = exp((0.82*x)+15)-1.75^(1.85*x);
 plot2domains(equation);
equation = (0.25*sin(pi*x))+(4*x*cos(0.5*x));
 plot2domains(equation);
equation = log(abs(0.25*x^1.5-0.75*x+.45))-0.05*x^2+1.35*x;            
 plot2domains(equation);
%% Question 2
 Q2;
%% Question 3
equation = 2*(x+3)^3+10;
 auto_plot(equation); 
equation = 0.2*x^6-5*x^4+30*x^2;
 auto_plot(equation);
equation = 3*x^8 + x^3/(x^2+0.1)^2;
 auto_plot(equation);
equation = (2*x^4-x^2+x-1)/(x^2-2);
 auto_plot(equation);
equation = ((3*x^2)+(6*x)-1)/((x^2)+x-3);
 auto_plot(equation);
% add more tests here.
% ...
