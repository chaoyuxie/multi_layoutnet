%% a demo of PanoBasic
clear all
add_path;

%% Project to perspective views
% read image
IMG_data = 'matdata\PanoContext\pcval_img';
IMG_data_OUT = 'data_sup_output_test\PanoContext\pcval_cor_location';
IMG_Path = dir(fullfile(IMG_data,'*mat'));

%read points
POINTS_data = 'data_sup_\PanoContext\pcval_cor_location';
POINTS_path = dir(fullfile(POINTS_data,'*mat'));
for number = 1:numel(IMG_Path)
    imPath = fullfile(IMG_data,IMG_Path(number).name);
    FILEname = IMG_Path(number).name;
    FILEreal_number = str2num(FILEname(regexp(FILEname,'\d')));
    panoImg = open(imPath);
    %imwrite(panoImg.x,strcat(PCTEST_IMG,'/',num2str(FILEreal_number),'.jpg'));
    panoImg = im2double(panoImg.x);%% Get region inside a polygon
    
    POINTSPath = fullfile(POINTS_data,POINTS_path(number).name);
    location = open(POINTSPath);
    location = location.location;
    %load('data_sup_\PanoContext\pctest_cor_location\39.mat'); % load room corner
    %load('./icosahedron2sphere/uniformvector_lvl8.mat'); % load vectors uniformly on sphere
    %vcs = uv2coords(xyz2uvN(coor), 1024, 512); % transfer vectors to image coordinates
    %coords = uv2coords(xyz2uvN(points), 1024, 512);
    %location = [132,192;131,322;439,305;441,215;625,218;628,303;873,306;880,201];
    location([1,2],:) = location([2,1],:);
    location([5,6],:) = location([6,5],:);
    %locations = zeros(8,2);
    %locations() = location();
    pointUV = coords2uv(location,1024,512);
    points = uv2xyzN(pointUV);
    
    %% Reconstruct a box, assuming perfect upperright cuboid
%    D3point = zeros(8,3);
    %pointUV = xyz2uvN(points);
%    floor = -160;
    
%     floorPtID = [2 3 6 7 2];
%     ceilPtID = [1 4 5 8 1];
%     for i = 1:4
%         D3point(floorPtID(i),:) = LineFaceIntersection( [0 0 floor], [0 0 1], [0 0 0], points(floorPtID(i),:) );
%         D3point(ceilPtID(i),3) = D3point(floorPtID(i),3)/tan(pointUV(floorPtID(i),2))*tan(pointUV(ceilPtID(i),2));
%     end
%     ceiling = mean(D3point(ceilPtID,3));
%     for i = 1:4
%         D3point(ceilPtID(i),:) = LineFaceIntersection( [0 0 ceiling], [0 0 1], [0 0 0], points(ceilPtID(i),:) );
%     end
%     figure(9);
%     plot3(D3point(floorPtID,1), D3point(floorPtID,2), D3point(floorPtID,3)); hold on
%     plot3(D3point(ceilPtID,1), D3point(ceilPtID,2), D3point(ceilPtID,3));
%     for i = 1:4
%         plot3(D3point([floorPtID(i) ceilPtID(i)],1), D3point([floorPtID(i) ceilPtID(i)],2), D3point([floorPtID(i) ceilPtID(i)],3));
%     end
%     title('Basic 3D reconstruction');
%     
%    figure(10);
    firstID = [1 4 5 8 2 3 6 7 1 4 5 8];
    secndID = [4 5 8 1 3 6 7 2 2 3 6 7];
    lines = lineFromTwoPoint(points(firstID,:), points(secndID,:));
    panoEdgeC = paintParameterLine(lines, 1024, 512, panoImg);
        %imwrite(sepScene(image_number).img,strcat('matdata_output/PanoContext/pctest_img',strcat(num2str(FILEreal_number),'_',num2str(image_number),'.jpg');
        save_path_img=fullfile(IMG_data_OUT,strcat(num2str(FILEreal_number),'.png'));
        imwrite(panoEdgeC,save_path_img);
        save_path_mat=fullfile(IMG_data_OUT,strcat(num2str(FILEreal_number),'.mat'));
        %image = sepScene(image_number).img;
        save(save_path_mat,'panoEdgeC');
    %imshow(paintParameterLine(lines, 1024, 512, panoImg)); hold on
    %for i = 1:8
    %    scatter(location(i,1), location(i,2), 100, [1 0 0],'fill','s');
    %end
    %title('Get lines by two points');
end