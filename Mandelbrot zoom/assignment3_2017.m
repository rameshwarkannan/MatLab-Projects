% ENSC180-Assignment3

% Student Name 1: Rameshwar Kannan

% Student 1 #: 301300734

% Student 1 userid (email): rkannan@sfu.ca

% Student Name 2: Santhosh Nandakumar

% Student 2 #: 301300261

% Student 2 userid (email): snandaku@sfu.ca

% Below, edit to list any people who helped you with the assignment, 
%      or put ‘none’ if nobody helped (the two of) you.

% Helpers: Jerry, Jose, Tal, Seli, Cyrus, Laurent, The TA's and Craig

% Instructions:
% * Put your name(s), student number(s), userid(s) in the above section.
% * Edit the "Helpers" line.  
% * Your group name should be "A3_<userid1>_<userid2>" (eg. A3_stu1_stu2)
% * Form a group 
%   as described at:  https://courses.cs.sfu.ca/docs/students
% * You will submit THIS file (assignment3_2017.m),    
%   and your video file (assignment3.avi or possibly similar).
% Craig Scratchley, Spring 2017


function frameArray = assignment3_2017

MAX_FRAMES = 950; % you can change this and consider increasing it.
RESOLUTION = 1000; % you can change this and consider increasing it.
DURATION = 60; % Duration of video -- you can change this if you want
% Colors
MAX_DEPTH = 256; % you will probably need to increase this.
CMAP=colormap(flipud(jet(256))); %change the colormap as you want.

WRITE_VIDEO_TO_FILE = true; % change this as you like (true/false)
DO_IN_PARALLEL = false; %change this as you like (true/false)

if DO_IN_PARALLEL
    startClusterIfNeeded
end

if WRITE_VIDEO_TO_FILE
    openVideoFile
end

if DO_IN_PARALLEL || ~WRITE_VIDEO_TO_FILE 
    %preallocate struct array
    %frameArray=struct('cdata',cell(1,MAX_FRAMES),'colormap',cell(1,MAX_FRAMES));
end

% the path "around" the mandelbrot set, associating centres of frames
%     with zoom (magnification) levels.  

%           index  centre      number of times to zoom in by 2
% indexArray = [0:50:1000]
% zoomMagnificationArray = [0:2:

PATH_POINTS =[100,   -0.5+0.000i,      2;
	          200,   -0.5+0.000i,      2;
			  300,   -0.5+0.000i,      2;
			  400,    -0.5+0.000i,     2;
	          500,    -0.088+0.654i,     2^2;
	          600,   -0.088+0.654i,      2^4;
 			  700,   -0.088+0.654i,       2^6;
              800,    -0.088+0.654i,     2^8;
			  900,    -0.07383539+0.660382716i,    2^10;
			  1000,-0.07383539+0.660382716i,2^12;
			  1100,-0.07383539+0.660382716i,2^14;
 			  1200,-0.073792371+0.660370983i,2^16;
 			  1300,-0.073795402+0.660364584i,2^18;
			  1400,-0.07383539+0.660382716i,2^16;
			  1500,-0.07383539+0.660382716i,2^14;
			  1600,-0.07383539+0.660382716i,2^12;
			  1700,-0.07383539+0.660382716i,2^10;
			  1800,-0.07383539+0.660382716i,2^8;
			  1900,-0.07383539+0.660382716i,2^6;
			  2000,-0.07383539+0.660382716i,2^4;
			  2100,-0.07383539+0.660382716i,2^2;
			  2200,-1.5+0.00i,1;
			  2300,-0.735833333+0.15i,2^4;
% 			  2100,-0.742083333+0.15i,2^6;
 		      2400,-0.746619623586+0.15i,2^8;
			  2500,-0.746619623586+0.1043163488489i,2^8;
 			  2600,-0.746619623586+0.0803060849181i,2^8;
			  2700,-0.746619623586+0.0498350438421i,2^8;
			  2800,-0.75308040066+0.0498350438421i,2^8;
			  2900,-0.75308040066+0.0498350438421i,2^4;
			  3000,-0.762427907992+0.0819098238988i,2^6;
			  3100,-0.762611192449+0.08933284442661i,2^11;
			  3200,-0.762563760436076+0.08955998112244675i,2^15;
			 3300,-0.7625597331896955+0.0895543429775146i,2^17;
			 3400,-0.76255+0.08955i,2^14;
			 3500,-0.76255+0.08955i,2^10;
			 3600,-0.76255+0.08955i,2^6;
			 3700,-0.76255+0.08955i,2^2;
			 3800,-0.5+0.00i,1];
% 			  
SIZE_0 = 1.5; % the "size" from the centre of a frame with no zooming.

% scale indexes to number of frames.
scaledIndexArray = PATH_POINTS(:, 1).*((MAX_FRAMES-1)/PATH_POINTS(end, 1));

% interpolate centres and zoom levels.
interpArray = interp1(scaledIndexArray, PATH_POINTS(:, 2:end), 0:(MAX_FRAMES-1), 'pchip');

zoomArray = interpArray(:,2); % zoom level of each frame

% ***** modify the below line to consider zoom levels.
sizeArray =  ones(MAX_FRAMES,1)./zoomArray; % size from centre of each frame.
% sizeArray=linspace(3.0000,0.0125,100);
% sizeArray=transpose(sizeArray);

centreArray = interpArray(:,1);  % centre of each frame

iterateHandle = @iterate;

tic % begin timing
if DO_IN_PARALLEL
    parfor frameNum = 1:MAX_FRAMES
        %evaluate function iterate with handle iterateHandle
        frameArray(frameNum) = feval(iterateHandle, frameNum);
    end
else
    for frameNum = 1:MAX_FRAMES
        if WRITE_VIDEO_TO_FILE
            %frame has already been written in this case
            iterate(frameNum);
        else
            frameArray(frameNum) = iterate(frameNum);
        end
    end
end

if WRITE_VIDEO_TO_FILE
    if DO_IN_PARALLEL
        writeVideo(vidObj, frameArray);
    end
    close(vidObj);
    toc %end timing
else
    toc %end timing
    %clf;
    set(gcf, 'Position', [100, 100, RESOLUTION + 10, RESOLUTION + 10]);
    axis off;
    shg; % bring the figure to the top to be seen.
    movie(gcf, frameArray, 1, MAX_FRAMES/DURATION, [5, 5, 0, 0]);
end

    function frame = iterate (frameNum)
       centreX = real(centreArray(frameNum)); 
        centreY = imag(centreArray(frameNum)); 
        size = sizeArray(frameNum);
%         size=centreX*exp(-frameNum/b);
        x = linspace(centreX-size , centreX+size, RESOLUTION);
        %you can modify the aspect ratio if you want.
        y =linspace(centreY-size, centreY+size, RESOLUTION);
        
        % the below might work okay unless you want to further optimize
        % Create the two-dimensional complex grid using meshgrid
        [X,Y] = (meshgrid(x,y));
		
        z0 = X + 1i*Y;
        
        % Initialize the iterates and counts arrays.
        z = z0;
		%z = zeros(RESOLUTION, RESOLUTION);
        
        % needed for mex, assumedly to make z elements separate
        %in memory from z0 elements.
        z(1,1) = z0(1,1); 
        
        % make c of type uint16 (unsigned 16-bit integer)
        c = zeros(RESOLUTION, RESOLUTION, 'uint16');
        
        % Here is the Mandelbrot iteration.
        c(abs(z) < 2) = 1;
        
        % below line turns warning off for MATLAB R2015b and similar
        %   releases of MATLAB.  Those releases have a bug causing a 
        %   warning for mex invocations like ours.  
        % warning( 'off', 'MATLAB:lang:badlyScopedReturnValue' );

        depth=MAX_DEPTH+frameNum; % you can make depth dynamic if you want.
        
        for k = 1:depth
            [z,c] = mandelbrot_step(z,c,z0,k);
            % mandelbrot_step is a c-mex file that does one step of:
              z = z.^2 + z0;
              %c(abs(z) < 2) = k;
		end
		if frameNum >= 0 && frameNum <= 125 
			  CMAP=colormap(flipud(jet(256)));
        end
        if frameNum > 125 && frameNum <= 250
          CMAP=colormap(flipud(parula(256)));
          end
          if frameNum > 250 && frameNum <= 475
           CMAP=colormap(flipud(hsv(256)));
		  end
            if frameNum > 475
            CMAP=colormap(flipud(jet(256)));
              end
			
        % create an image from c and then convert to frame.  Use CMAP
		frame = im2frame(ind2rgb(c, CMAP));
        if WRITE_VIDEO_TO_FILE && ~DO_IN_PARALLEL
            writeVideo(vidObj, frame);
        end
        
        disp(['frame=' num2str(frameNum)]);
    end

    function startClusterIfNeeded
        myCluster = parcluster('local');
        if isempty(myCluster.Jobs) || ~strcmp(myCluster.Jobs(1).State, 'running')
            PHYSICAL_CORES = feature('numCores');
            
            % "hyperthreads" per physical core
            LOGICAL_PER_PHYSICAL = 2; %valid for the i7 on Craig's desktop
            
            % you can change the NUM_WORKERS calculation below if you want.
            NUM_WORKERS = (LOGICAL_PER_PHYSICAL + 1) * PHYSICAL_CORES;
            myCluster.NumWorkers = NUM_WORKERS;
            saveProfile(myCluster);
            disp('This may take a while when needed!')
            parpool(NUM_WORKERS);
        end
    end

    function openVideoFile
        % create video object
        vidObj = VideoWriter('assignment3');
%        vidObj.Quality = 100; % or consider changing
        vidObj.FrameRate = MAX_FRAMES/DURATION;
        open(vidObj);
    end

% What are the benefit of using C code over matlab scripts
% C code is compiled and run directly, where as matlab scripts 
% are interpreted by an interpretor which is a slow processes
% Where as C code is compiled. Therefore using C code would give a
% much quicker run time. The amount of speed improvements is dependant
% upon the relative amount of time consumed by built-in
% functions and the matlab code itself.

% Our objective was to create a nice video which zoomed into some points in
% the mandelbrot set.
% The changes we made were to the path points, zoom array values to allow
% us to zoom, the colour at certain points to enhance beauty and
% interest



end


