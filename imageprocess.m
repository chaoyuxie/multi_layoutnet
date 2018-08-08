% a demo of PanoBasic
clear all
add_path;

%% Project to perspective views
% read image
PCTEST_IMG = 'matdata\PanoContext\pctest_cor';
PCTEST_IMG_OUT = 'data_spp_90_point\PanoContext\pctest_cor_location';
Path = dir(fullfile(PCTEST_IMG,'*mat'));
% PCTEST_IMG = 'data_sup_output_test\PanoContext\pcval_cor_location';
% PCTEST_IMG_OUT = 'data_spp_60_test\PanoContext\pcval_cor_location';
% Path = dir(fullfile(PCTEST_IMG,'*mat'));
for number = 1:numel(Path)
    imPath = fullfile(PCTEST_IMG,Path(number).name);
    FILEname = Path(number).name;
    FILEreal_number = str2num(FILEname(regexp(FILEname,'\d')));
    panoImg = open(imPath);
    %panoImg = imread(imPath);
    %imwrite(panoImg.x,strcat(PCTEST_IMG,'/',num2str(FILEreal_number),'.jpg'));
    %panoImg = panoImg.panoEdgeC;
    panoImg = panoImg.x;
    panoImg(panoImg<1) = 0;
    %panoImg = im2double(panoImg);
    
    % project it to multiple perspective views
    cutSize = 320; % size of perspective views
    fov = pi/2; % horizontal field of view of perspective views
    xh = -pi:(pi/6):(5/6*pi);
    yh = zeros(1, length(xh));
    xp = [-3/3 -2/3 -1/3 +0/3 +1/3 +2/3 -3/3 -2/3 -1/3 +0/3 +1/3 +2/3] * pi;
    %xp = [-2/2 -1/2 0/2 1/2 -2/2 -1/2 0/2 1/2 -2/2 -1/2 0/2 1/2] * pi;
    yp = [ 1/4  1/4  1/4  1/4  1/4  1/4 -1/4 -1/4 -1/4 -1/4 -1/4 -1/4] * pi;
    %yp = [ 1/2  1/2  1/2  1/2  1/2  1/2 -1/2 -1/2 -1/2 -1/2 -1/2 -1/2] * pi;
    x = [xh xp 0     0];
    y = [yh yp +pi/2 -pi/2]; % viewing direction of perspective views
    
    [sepScene] = separatePano( panoImg, fov, x, y, cutSize);
    for image_number = 1:12
        %imwrite(sepScene(image_number).img,strcat('matdata_output/PanoContext/pctest_img',strcat(num2str(FILEreal_number),'_',num2str(image_number),'.jpg');
        save_path_img=fullfile(PCTEST_IMG_OUT,strcat(num2str(FILEreal_number),'_',num2str(image_number),'.png'));
        %save_path_img_=fullfile(PCTEST_IMG_OUT,strcat(num2str(FILEreal_number),'___',num2str(image_number),'.png'));
        imwrite(sepScene(image_number).img,save_path_img);
        save_path_mat=fullfile(PCTEST_IMG_OUT,strcat(num2str(FILEreal_number),'_',num2str(image_number),'.mat'));
        image = sepScene(image_number).img;
        %image(image >= 0) = 1;
        %image(image < 0) = 0;
        %imwrite(image,save_path_img_);
        save(save_path_mat,'image');
    end
end