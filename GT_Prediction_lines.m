%% 把test数据集里面的原始点与经过网络的得到的点进行比较，做出线段，并画在一张图上，最后输出到文件中
% 其中红色点代表预测得到的点，绿色点代表GT
%% Project to perspective views
% read image
image_input = 'matdata\PanoContext\pctest_img';
image_output = 'GT_prediction\test_line';
Img_Path = dir(fullfile(image_input,'*mat'));

%read GT_points
points_GT = 'data_sup_\PanoContext\pctest_cor_location';
GT_path = dir(fullfile(points_GT,'*mat'));

%read Pre_points
points_Prediction = 'prediction_points\location';
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
    location_Pre = location_Pre.point_location;
    
    PanoEdgePath = fullfile(PanoEdge_line,PanoEdge_Path(number).name);
    PanoEdgeC = open(PanoEdgePath);
    PanoEdgeC = PanoEdgeC.panoEdgeC;
    locations = zeros(8,2);
    if size(location_Pre,2) == 8
        for i = 1:8
            location(i,1) = location_Pre(i).x;
            location(i,2) = location_Pre(i).y;
        end
        pointUV = coords2uv(location,1024,512);
        points = uv2xyzN(pointUV);
        firstID = [5 6 7 8 1 2 3 4 5 6 7 8];
        secndID = [6 7 8 5 2 3 4 1 1 2 3 4];
        lines = lineFromTwoPoint(points(firstID,:), points(secndID,:));
        panoEdgeC = paintParameterLine(lines, 1024, 512, PanoEdgeC);
        save_path_img=fullfile(image_output,strcat('\',num2str(FILEreal_number),'_.png'));
        imshow(panoEdgeC);hold on
        for i = 1:size(location_Pre,2)
            scatter(location_Pre(i).x, location_Pre(i).y, 100, [1 0 0],'fill','s');
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
    end
    
end