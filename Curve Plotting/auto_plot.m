%output = AUTO_PLOT (e...   *** finish the help comments ***
% ... The figure
% handle is returned.

% Student Name 1: Rameshwar Kannan

% Student 1 #: 301300734

% Student 1 userid (email): rkannan@sfu.ca

% Student Name 2: Santhosh Nandakumar

% Student 2 #: 301300261

% Student 2 userid (email): snandaku@sfu.ca

% Below, edit to list any people who helped you with the assignment, 
%      or put ‘none’ if nobody helped (the two of) you.

% Helpers: _everybody helped us/me with the assignment (Seli,All the TAs)__


function output = auto_plot (equation)
%Plots a function and displays interesting points such as,
%Local maxima and minima, inflection points, vertical and horizontal asymptotes
%User input required
syms x;
finalVA1=0
no_VA=0
n=0
n1=0
legendarray=[0,0,0,0]
string={}
    y=equation
    
    fplot(y)
	string={'y'}
    hold on
    grid on
	title(char(y))
    dy=diff(y)
    ddy=diff(dy)
    xlabel('x value')
    ylabel('y value')
%Using second derivative test to find local extrema    
	z=solve(dy);
    convertdouble=double(z);
    reallocal=real(convertdouble);
    isreal=convertdouble==reallocal
    realloc=convertdouble(isreal)
   
    s=solve(ddy)
    convertdouble1=double(s)
    realconcave=real(convertdouble1)
    isreal1=convertdouble1==realconcave
    realcon=convertdouble1(isreal1)
	realcon1=transpose(realcon)
    concave=numel(realcon)
    par_1=1
    par_2=1
for i =1:length(realloc)
locTest=double(subs(ddy,realloc))
l1=double(subs(equation,realloc))
    if locTest(i)<0
       locmax(par_1)=realloc(i)
       locmay(par_1)=l1(i)
       par_1=par_1+1
	   legendarray(1)=1
	   
    end
    if locTest(i)>0
        locmix(par_2)=realloc(i)
        locmiy(par_2)=l1(i)
        par_2=par_2+1
		legendarray(2)=1
		
	end
	if locTest(i)==0
    locmax(i)=0
	locmay(i)=0
	locmix(i)=0
	locmiy(i)=0
   end
 i=i+1
end
if legendarray(1)==1
 plot(locmax,locmay,'ro')
 string=[string,{'Local Maxima'}]

end

if legendarray(2)==1
 plot(locmix,locmiy,'bo')
 string=[string,{'Local Minima'}]
 n1=numel(locmix)

end
n2=n+n1

   c1=double(subs(equation,realcon))
   plot(realcon,c1,'go')
   string=[string,{'Inflection Points'}]

%Plotting and checking for the existence of vertical asymptotes
[nu,d]= numden(equation)

if (symvar(d))==x
pVA = solve(d)
dVA = double(pVA)
realVA= real(dVA)
isreal3=dVA==realVA
finalVA=dVA(isreal3)
finalVA1=transpose(finalVA)
no_VA=numel(finalVA)
plot(finalVA,zeros(no_VA),'kx')
string=[string,{'Vert. Asymptotes'}]
end
%Determinig domain displayed by the graph
combined=horzcat(locmix,locmax,finalVA1,realcon1)
    interestingpts=concave+n2+no_VA
    if interestingpts==0
		xmin=-20*pi
		xmax=20*pi
        xlim([-20*pi,20*pi])
	end
    if interestingpts==1
		combined=nonzeros(combined)
		xmin=combined-20*pi
		xmax=combined+20*pi
        xlim([xmin,xmax])
	
	else
		xmin = min(combined) - (3/14)*(max(combined)-min(combined));
		xmax = max(combined) + (3/14)*(max(combined)-min(combined));
		xlim([xmin,xmax])
	end  
	


legend(string,'location','best')
	
	
		
		
		
		
    
    
    
 

    output = gcf;