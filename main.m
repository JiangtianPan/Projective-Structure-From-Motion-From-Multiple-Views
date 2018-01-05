
files = dir(fullfile('./images/','*.jpg'));
% lengthFiles = floor(length(files)/20);
lengthFiles = floor(length(files)/3+2);
images = cell(1, lengthFiles);
for i = 1:length(files)
    Img = imread(strcat('./images/',files(i).name));
    images{i} = single(rgb2gray(Img));
end

[D] =  SFM(images,lengthFiles);
matchNum = 1800;
[P] = P_D(D);
figure;
for i=1:matchNum
    xx = P(1,i);
    yy = P(2,i);
    zz = P(3,i);
    h = plot3(xx,yy,zz,'*');
    set(h,'color','b');
    %grid on;
    hold on;
end