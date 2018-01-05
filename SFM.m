function[D] =  SFM(images_gray, lengthFiles)

Image_a = images_gray{173};
Image_b = images_gray{174};

[fa, da] = vl_sift(Image_a) ;
[fb, db] = vl_sift(Image_b) ;
[matches, scores] = vl_ubcmatch(da, db) ;

[drop, perm] = sort(scores, 'descend') ;
                                        
matches = matches(:, perm) ;          
scores  = scores(perm) ;               

matchNum = 1800;
D = zeros(2*lengthFiles,matchNum);

% fa is the feature frame [x;y;s;th]
% x,y is the center of the frame,s is the scale 
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
    I = images_gray{172+i};
    [f, d] = vl_sift(I) ;
   
    [matches, scores] = vl_ubcmatch(d, prev_d) ;
    [drop, perm] = sort(scores, 'descend') ;
    matches = matches(:, perm) ;          
    
    x = f(1,matches(1,:)) ;         
    y = f(2,matches(1,:)) ;
    
    % add one row to D
    rowD = [x(1:matchNum);y(1:matchNum)];
    D(2*i-1,:) = rowD(1,:);
    D(2*i+2,:) = rowD(2,:);
    
    if mod(i,3)==0
        prev_match = matches;
        prev_d = d;
    end
end

end







