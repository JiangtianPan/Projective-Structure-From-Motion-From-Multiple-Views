# Projective-Structure-From-Motion-From-Multiple-Views
In this project, I use SIFT and Projective Structure from Motion to automatically recover the 3D structure from part of the given images. The procedures as below are followed:

1, Image process:
read all the images from the file folder according to the folder name. And then, those images are transferred from RGB images to Gray images by using “rgb2gray(.)”.

2, Feature detect:
First, matches two images by using sift algorithm and obtain the feature frame of each of them. The feature frame is [x; y; s; th], where x, y is the center of the frame, s is the scale.

Then, input the rest of the images by using sift algorithm, match them and Select matched points. Thus we can obtain the matrix D from the rest of the images, and the matrix U, W, V can be obtained from the SVD algorithm. So, we can use equation “D(2m*n)=M(2m*4)P(4*n)=UWV' ” to calculate M and P. Now, we can obtain the camera parameters.

3, Construct the 3D model
Based on the step2, we can further find out point tracks across all views. Then, we need to Refine the 3-D world points and store them. Then, exclude noisy 3-D points is necessary. Finally, we can display the 3-D points. We add the dense points in the view set one by one by tracking the points across all views.
