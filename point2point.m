clear all
add_path;

% read points
PCTEST_IMG = 'data_sup_\Stanford2D-3D\st_area6_cor_location';
PCTEST_IMG_OUT = 'data_sup_points2points\90\Stanford2D-3D\st_area6_cor_location';
Path = dir(fullfile(PCTEST_IMG,'*mat'));
% PCTEST_IMG = 'data_sup_output_test\PanoContext\pcval_cor_location';
% PCTEST_IMG_OUT = 'data_spp_60_test\PanoContext\pcval_cor_location';
% Path = dir(fullfile(PCTEST_IMG,'*mat'));
height = 512;
width = 1024;

for number = 1:numel(Path)
    imPath = fullfile(PCTEST_IMG,Path(number).name);
    FILEname = Path(number).name;
    FILEreal_number = str2num(FILEname(regexp(FILEname,'\d')));
    location = open(imPath);
    %panoImg = imread(imPath);
    %imwrite(panoImg.x,strcat(PCTEST_IMG,'/',num2str(FILEreal_number),'.jpg'));
    %panoImg = panoImg.panoEdgeC;
    location = location.location;
    panoImg = zeros(height, width);
    for numbers = 1:size(location,1)
        drawId = sub2ind([height width], location(numbers,2), location(numbers,1));
        panoImg(drawId) = 1;        
    end
    %imshow(panoImg);
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
        %imwrite(sepScene(image_number).img,save_path_img);
        save_path_mat=fullfile(PCTEST_IMG_OUT,strcat(num2str(FILEreal_number),'_',num2str(image_number),'.mat'));
        save_path_mat_=fullfile(PCTEST_IMG_OUT,strcat(num2str(FILEreal_number),'__',num2str(image_number),'.mat'));
        image = sepScene(image_number).img;
        %image(image >= 0) = 1;
        %image(image < 0) = 0;
        %imwrite(image,save_path_img_);
        %[I, J] = ind2sub(size(image),find(image>0.5));
        
        image_L = image;
        image_L(image_L>0) = 1;
        [L_image, L_num] = bwlabel(image_L);
        point_location = struct('x',[],'y',[],'up_or_down',[]);
        for i = 1:L_num
            [iuwav,oawv] = find(L_image == i);
            max = 0;
            for j = 1:size(iuwav,1)
                if image(iuwav(j),oawv(j)) > max
                    max = image(iuwav(j),oawv(j)); 
                    point_location(i).x = iuwav(j);
                    point_location(i).y = oawv(j);
                end
            end
            if image_number <=12
                if point_location(i).x < 160
                    point_location(i).up_or_down = 1;
                else
                    point_location(i).up_or_down = -1;
                end
            elseif image_number >= 19
                point_location(i).up_or_down = -1;
            else
                point_location(i).up_or_down = 1;
            end
        end

        %save(save_path_mat,'image');
        save(save_path_mat_,'point_location');
    end
end