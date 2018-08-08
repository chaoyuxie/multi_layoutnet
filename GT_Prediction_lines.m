%% 把test数据集里面的原始点与经过网络的得到的点进行比较，做出线段，并画在一张图上，最后输出到文件中
% 其中红色点代表预测得到的点，绿色点代表GT
clear all;
add_path;
% read image
image_input = 'matdata\PanoContext\pctest_img';
image_output = 'GT_prediction\pt4';
Img_Path = dir(fullfile(image_input,'*mat'));

%read GT_points
points_GT = 'data_sup_\PanoContext\pctest_cor_location';
GT_path = dir(fullfile(points_GT,'*mat'));

%read Pre_points
points_Prediction = 'prediction_points\pt3';
Pre_Path = dir(fullfile(points_Prediction,'*mat'));

%read panoedeg;
PanoEdge_line = 'data_sup_output\PanoContext\pctest_cor_location';
PanoEdge_Path = dir(fullfile(PanoEdge_line,'*mat'));

for number = 1:numel(Img_Path)
    imPath = fullfile(image_input,Img_Path(number).name);
    FILEname = Img_Path(number).name;
    FILEreal_number = str2num(FILEname(regexp(FILEname,'\d')));
    panoImg = open(imPath);
    %imwrite(panoImg.x,strcat(PCTEST_IMG,'/',num2str(FILEreal_number),'.jpg'));
    panoImg = im2double(panoImg.x);%% Get region inside a polygon
    
    POINTS_TG_Path = fullfile(points_GT,GT_path(number).name);
    location_GT = open(POINTS_TG_Path);
    location_GT = location_GT.location;
    
    POINTS_Pre_Path = fullfile(points_Prediction,Pre_Path(number).name);
    location_Pre = open(POINTS_Pre_Path);
    location = location_Pre.pt;
%     location = pt;
    PanoEdgePath = fullfile(PanoEdge_line,PanoEdge_Path(number).name);
    PanoEdgeC = open(PanoEdgePath);
    PanoEdgeC = PanoEdgeC.panoEdgeC;
    %locations = zeros(8,2);
    %if FILEreal_number == 3||FILEreal_number == 11||FILEreal_number == 28||FILEreal_number == 32||FILEreal_number == 34||FILEreal_number == 40
%         for i = 1:8
%             location(i,1) = location_Pre(i).x;
%             location(i,2) = location_Pre(i).y;
%         end
        pointUV = coords2uv(location,1024,512);
        points = uv2xyzN(pointUV);
        firstID = [2 4 6 8 1 3 5 7 2 4 6 8];
        secndID = [4 6 8 2 3 5 7 1 1 3 5 7];
        lines = lineFromTwoPoint(points(firstID,:), points(secndID,:));
        panoEdgeC = paintParameterLine(lines, 1024, 512, PanoEdgeC);
        save_path_img=fullfile(image_output,strcat('\',num2str(FILEreal_number),'_.png'));
        imshow(panoEdgeC);hold on
        for i = 1:size(location,1)
            scatter(location(i,1), location(i,2), 100, [1 0 0],'fill','s');
        end
        
        for i = 1:8
            scatter(location_GT(i,1), location_GT(i,2), 100, [0 1 0],'fill','o');
        end
        set(gca,'position',[0 0 1 1])
        grid off
        axis normal
        axis off
        saveas(gcf,save_path_img);
        clf;
    %end
    
end