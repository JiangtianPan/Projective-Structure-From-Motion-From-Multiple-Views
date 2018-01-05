startup;

files = dir(fullfile('./images/','*.jpg'));
lengthFiles = floor(length(files)/3+2);

images = cell(1, lengthFiles);
for i = 1:length(files)
    Img = imread(strcat('./images/',files(i).name));
    images{i} = single(rgb2gray(Img));
end

Ia = images{173};
Ib = images{174};
[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db) ;

[drop, perm] = sort(scores, 'descend') ;
                                        
matches = matches(:, perm) ;          
scores  = scores(perm) ;                

matchNum = 1800;
D = zeros(2*lengthFiles,matchNum);

%fa is a feature frame [x;y;s;th],where x,y is the center of the frame,s is the scale; 
xa = fa(1,matches(1,:));            
xb = fb(1,matches(2,:));            

ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

rowD =[xa(1:matchNum);ya(1:matchNum)];
D(1,:)=rowD(1,:);
D(2,:)=rowD(2,:);
rowD =[xb(1:matchNum);yb(1:matchNum)];
D(3,:)=rowD(1,:);
D(4,:)=rowD(2,:);

prev_d = db;
prev_match = matches;

prev_d = prev_d(:,prev_match(2,:));

for i=3:lengthFiles
    I = images{172+i};
    [f, d] = vl_sift(I) ;
    

    [matches, scores] = vl_ubcmatch(d, prev_d) ;
    [drop, perm] = sort(scores, 'descend') ;
                                            
    matches = matches(:, perm) ;          
    
    
    x = f(1,matches(1,:)) ;         
    y = f(2,matches(1,:)) ;
    
   
    rowD = [x(1:matchNum);y(1:matchNum)];
    D(2*i-1,:) = rowD(1,:);
    D(2*i+2,:) = rowD(2,:);
    
    if mod(i,3)==0
        prev_match = matches;
        prev_d = d;
    end
end

[U,W,V] = svd(D);
V=V';
W=W(1:3,1:3);
V=V(1:3,:);
P = W.^(0.5) * V;

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

