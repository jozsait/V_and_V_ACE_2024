% Define the folder containing the PNG images
folderPath = './pic/';  % Change this to your folder path

% Get a list of all PNG files in the folder
imageFiles = dir(fullfile(folderPath, '*.png'));
numFiles = length(imageFiles);

% Check if there are any PNG files in the folder
if numFiles == 0
    error('No PNG files found in the specified folder.');
end

% Create a VideoWriter object
outputVideo = VideoWriter('outputVideo.avi');
outputVideo.FrameRate = 10; % Set the frame rate to 10 fps
open(outputVideo);

% Loop through each image and add it to the video
for i = 1:numFiles
    % Read the current image
    img = imread(fullfile(folderPath, imageFiles(i).name));
    
    % Convert to a frame and write to the video
    writeVideo(outputVideo, img);
end

% Close the video file
close(outputVideo);

disp('Video creation complete. The file is saved as outputVideo.avi');
