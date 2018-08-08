%% 把test数据集里面的原始点与经过网络的得到的点进行比较，并画在一张图上，最后输出到文件中
% 其中红色点代表预测得到的点，绿色点代表GT
clf;
clear all;
add_path;
image_input = 'matdata\PanoContext\pctest_img';
points_GT = 'data_sup_\PanoContext\pctest_cor_location';
points_Prediction = 'myresults_output\location_new';
image_output = 'GT_prediction\test';
Img_Path = dir(fullfile(image_input,'*mat'));
GT_Path = dir(fullfile(points_GT,'*mat'));
Pre_Path = dir(fullfile(points_Prediction,'*mat'));
for number = 1:numel(Img_Path)
    imPath = fullfile(image_input,Img_Path(number).name);
    FILEname = Img_Path(number).name;
    FILEreal_number = str2num(FILEname(regexp(FILEname,'\d')));
    panoImg = open(imPath);
    panoImg = panoImg.x;
    
    POINTS_GT_Path = fullfile(points_GT,GT_Path(number).name);
    location_GT = open(POINTS_GT_Path);
    location_GT = location_GT.location;
    
    POINTS_Pre_Path = fullfile(points_Prediction,Pre_Path(number).name);
    location_Pre = open(POINTS_Pre_Path);
    location_Pre = location_Pre.location;
    imshow(panoImg);hold on
    for i = 1:size(location_Pre,1)
        scatter(location_Pre(i,1), location_Pre(i,2), 100, [1 0 0],'fill','s');
    end
    for i = 1:8
        scatter(location_GT(i,1), location_GT(i,2), 100, [0 1 0],'fill','o');
    end
    set(gca,'position',[0 0 1 1])
    grid off
    axis normal
    axis off
    save_path_img_=fullfile(image_output,strcat('\',num2str(FILEreal_number),'_.png'));
    saveas(gcf,save_path_img_);
    clf;
end