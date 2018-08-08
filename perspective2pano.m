%% perspective image to panorano image
clear all
add_path;


%% Project to perspective views
% read image
PCTEST_IMG = 'myresults\pred_kp_Sec4_noave';
PCTEST_IMG_OUT = 'myresults_output\pred_kp_Sec4_noave';
Path = dir(fullfile(PCTEST_IMG,'*mat'));
TEMP = 0;
height = 512;
width = 1024;
image_number = 12;
Pano = zeros(2, image_number, height, width);
for number = 1:numel(Path)
    %imPath = fullfile(PCTEST_IMG,Path(number).name);
    FILEname = Path(number).name;
    underline = regexp(FILEname,'_');
    dot = regexp(FILEname,'m');
    %if size(underline,2) == 3
        imPath = fullfile(PCTEST_IMG,strcat(num2str(FILEname(1:underline(1)-1)),'_',num2str(FILEname(underline(1)+1:dot(1)-2)),'.mat'));
        kp = open(imPath);
        kp = kp.kp;
%         save_path_GPimg_1 = fullfile(PCTEST_IMG,strcat('\pctest_',num2str(FILEname(underline(1)+1:underline(2)-1)),'__',num2str(FILEname(underline(3)+1:dot(1)-2)),'_1.png'));
%         imwrite(squeeze(GP(1,:,:)),save_path_GPimg_1);
%         save_path_GPimg_2 = fullfile(PCTEST_IMG,strcat('\pctest_',num2str(FILEname(underline(1)+1:underline(2)-1)),'__',num2str(FILEname(underline(3)+1:dot(1)-2)),'_2.png'));
%         imwrite(squeeze(GP(2,:,:)),save_path_GPimg_2);
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

        IMAGE = zeros(cutSize, cutSize);
        sepScene(image_number) = struct('img',[],'vx',[],'vy',[],'fov',[],'sz',[]);
        for i = 1:image_number
            sepScene(i).img = IMAGE;
            sepScene(i).vx = x(i);
            sepScene(i).vy = y(i);
            sepScene(i).fov = fov;
            sepScene(i).sz = 320;
        end
        temp = squeeze(kp(1,:,:,1));
%         FlattenedData = temp(:)';
%         MappedFlattened = mapminmax(FlattenedData, 0, 1);
%         temp = reshape(MappedFlattened, size(temp));
        sepScene(str2num(FILEname(underline(1)+1:dot(1)-2))).img = temp;
        [ panoout_1 ] = combineViews( sepScene, width, height );
%         Pano = zeros(2, 12, cutSize, sutSize);
%         Pano(1,str2num(FILEname(underline(3)+1:dot(1)-2)),:,:) = panoout;
        temp = squeeze(kp(1,:,:,2));
%         FlattenedData = temp(:)';
%         MappedFlattened = mapminmax(FlattenedData, 0, 1);
%         temp = reshape(MappedFlattened, size(temp));
        sepScene(str2num(FILEname(underline(1)+1:dot(1)-2))).img = temp;
        [ panoout_2 ] = combineViews( sepScene, width, height );
%         Pano(2,str2num(FILEname(underline(3)+1:dot(1)-2)),:,:) = panoout;
%         save_path_mat = fullfile(PCTEST_IMG_OUT,strcat('\',num2str(FILEname(underline(1)+1:underline(2)-1)),'.mat'));
%         save(save_path_mat,'Pano');
%         save_path_img_1 = fullfile(PCTEST_IMG_OUT,strcat('\',num2str(FILEname(underline(1)+1:underline(2)-1)),'__',num2str(FILEname(underline(3)+1:dot(1)-2)),'_1.png'));
%         imwrite(squeeze(Pano(1,:,:)),save_path_img_1);
%         save_path_img_2 = fullfile(PCTEST_IMG_OUT,strcat('\',num2str(FILEname(underline(1)+1:underline(2)-1)),'__',num2str(FILEname(underline(3)+1:dot(1)-2)),'_2.png'));
%         imwrite(squeeze(Pano(2,:,:)),save_path_img_2);
                
        Pano(1,str2num(FILEname(underline(1)+1:dot(1)-2)),:,:) = double(panoout_1);
        Pano(2,str2num(FILEname(underline(1)+1:dot(1)-2)),:,:) = double(panoout_2);
        TEMP = TEMP + 1;
        save_path_mat = fullfile(PCTEST_IMG_OUT,strcat('\',num2str(FILEname(1:underline(1)-1)),'.mat'));
        if TEMP == image_number
            save(save_path_mat,'Pano');
            TEMP = 0;
            Pano = zeros(2, image_number, height, width);
        end 
    %end
end
