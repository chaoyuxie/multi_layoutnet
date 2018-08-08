%% this program process Pano images
% find the max value in pano
image_input = 'myresults_output\pred_kp_Sec4';
%image_output = 'myresults_output\pred_kp_Sec4_points';
image_output = 'myresults_output\pano_algin_new_';
Path = dir(fullfile(image_input,'*mat'));
height = 512;
width = 1024;
for number = 1:numel(Path)
    pano = zeros(2,height,width);
    imPath = fullfile(image_input,Path(number).name);
    FILEname = Path(number).name;
    FILEreal_number = str2num(FILEname(regexp(FILEname,'\d')));
    Pano = open(imPath);
    pano_sp = Pano.Pano;
    temp_1 = squeeze(pano_sp(1,1,:,:));
    temp_2 = squeeze(pano_sp(1,2,:,:));
    temp_3 = squeeze(pano_sp(1,3,:,:));
    temp_4 = squeeze(pano_sp(1,4,:,:));
    temp_5 = squeeze(pano_sp(1,5,:,:));
    temp_6 = squeeze(pano_sp(1,6,:,:));
    temp_7 = squeeze(pano_sp(1,7,:,:));
    temp_8 = squeeze(pano_sp(1,8,:,:));
    temp_9 = squeeze(pano_sp(1,9,:,:));
    temp_10 = squeeze(pano_sp(1,10,:,:));
    temp_11 = squeeze(pano_sp(1,11,:,:));
    temp_12 = squeeze(pano_sp(1,12,:,:));
    
    TEMP_1 = zeros(512,1024);
    TEMP_1(:,1:128) = temp_1(:,897:1024);
    TEMP_1(:,129:256) = temp_1(:,1:128);
    
    TEMP_2 = zeros(512,1024);
    TEMP_2(:,1:128) = temp_2(:,897:1024);
    TEMP_2(:,129:342) = temp_2(:,1:214);
    Temp_1 = TEMP_1;
    Temp_2 = TEMP_2;
    Temp_1(Temp_1~=0) = 1;
    Temp_2(Temp_2~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_1+Temp_2;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*TEMP_1(j,y(number))/d+(y(number)-y(1))*TEMP_2(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = TEMP_1(j,y(number))+TEMP_2(j,y(number));
            end
        end
    end
    TEMP__ = zeros(512,1024);
    TEMP__(:,897:1024) = TEMP(:,1:128);
    TEMP__(:,1:214) = TEMP(:,129:342);
    T_TEMP = TEMP__;
    
    Temp_ = T_TEMP;
    Temp_3 = temp_3;
    Temp_(Temp_~=0) = 1;
    Temp_3(Temp_3~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_3;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_3(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_3(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
    Temp_ = T_TEMP;
    Temp_4= temp_4;
    Temp_(Temp_~=0) = 1;
    Temp_4(Temp_4~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_4;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_4(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_4(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
    Temp_ = T_TEMP;
    Temp_5= temp_5;
    Temp_(Temp_~=0) = 1;
    Temp_5(Temp_5~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_5;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_5(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_5(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
     Temp_ = T_TEMP;
    Temp_6= temp_6;
    Temp_(Temp_~=0) = 1;
    Temp_6(Temp_6~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_6;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_6(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_6(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
         Temp_ = T_TEMP;
    Temp_7= temp_7;
    Temp_(Temp_~=0) = 1;
    Temp_7(Temp_7~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_7;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_7(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_7(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
             Temp_ = T_TEMP;
    Temp_8= temp_8;
    Temp_(Temp_~=0) = 1;
    Temp_8(Temp_8~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_8;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_8(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_8(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
    Temp_ = T_TEMP;
    Temp_9= temp_9;
    Temp_(Temp_~=0) = 1;
    Temp_9(Temp_9~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_9;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_9(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_9(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
        Temp_ = T_TEMP;
    Temp_10= temp_10;
    Temp_(Temp_~=0) = 1;
    Temp_10(Temp_10~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_10;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_10(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_10(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
    Temp_ = T_TEMP;
    Temp_11= temp_11;
    Temp_(Temp_~=0) = 1;
    Temp_11(Temp_11~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_11;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_11(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_11(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
    
    Temp_ = T_TEMP;
    temp_12(:,1:50) = 0;
    Temp_12= temp_12;
    
    Temp_(Temp_~=0) = 1;
    Temp_12(Temp_12~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_12;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_12(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_12(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    pano(1,:,:) = T_TEMP;
    imagesc(T_TEMP);
    set(gca,'position',[0 0 1 1])
    grid off
    axis normal
    axis off
    save_path_img_=fullfile(image_output,strcat('\',num2str(FILEreal_number),'_1.png'));
    saveas(gcf,save_path_img_);
    clf;
    
    
    temp_1 = squeeze(pano_sp(2,1,:,:));
    temp_2 = squeeze(pano_sp(2,2,:,:));
    temp_3 = squeeze(pano_sp(2,3,:,:));
    temp_4 = squeeze(pano_sp(2,4,:,:));
    temp_5 = squeeze(pano_sp(2,5,:,:));
    temp_6 = squeeze(pano_sp(2,6,:,:));
    temp_7 = squeeze(pano_sp(2,7,:,:));
    temp_8 = squeeze(pano_sp(2,8,:,:));
    temp_9 = squeeze(pano_sp(2,9,:,:));
    temp_10 = squeeze(pano_sp(2,10,:,:));
    temp_11 = squeeze(pano_sp(2,11,:,:));
    temp_12 = squeeze(pano_sp(2,12,:,:));
    
    TEMP_1 = zeros(512,1024);
    TEMP_1(:,1:128) = temp_1(:,897:1024);
    TEMP_1(:,129:256) = temp_1(:,1:128);
    
    TEMP_2 = zeros(512,1024);
    TEMP_2(:,1:128) = temp_2(:,897:1024);
    TEMP_2(:,129:342) = temp_2(:,1:214);
    Temp_1 = TEMP_1;
    Temp_2 = TEMP_2;
    Temp_1(Temp_1~=0) = 1;
    Temp_2(Temp_2~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_1+Temp_2;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*TEMP_1(j,y(number))/d+(y(number)-y(1))*TEMP_2(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = TEMP_1(j,y(number))+TEMP_2(j,y(number));
            end
        end
    end
    TEMP__ = zeros(512,1024);
    TEMP__(:,897:1024) = TEMP(:,1:128);
    TEMP__(:,1:214) = TEMP(:,129:342);
    T_TEMP = TEMP__;
    
    Temp_ = T_TEMP;
    Temp_3 = temp_3;
    Temp_(Temp_~=0) = 1;
    Temp_3(Temp_3~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_3;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_3(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_3(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
    Temp_ = T_TEMP;
    Temp_4= temp_4;
    Temp_(Temp_~=0) = 1;
    Temp_4(Temp_4~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_4;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_4(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_4(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
    Temp_ = T_TEMP;
    Temp_5= temp_5;
    Temp_(Temp_~=0) = 1;
    Temp_5(Temp_5~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_5;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_5(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_5(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
     Temp_ = T_TEMP;
    Temp_6= temp_6;
    Temp_(Temp_~=0) = 1;
    Temp_6(Temp_6~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_6;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_6(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_6(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
         Temp_ = T_TEMP;
    Temp_7= temp_7;
    Temp_(Temp_~=0) = 1;
    Temp_7(Temp_7~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_7;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_7(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_7(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
             Temp_ = T_TEMP;
    Temp_8= temp_8;
    Temp_(Temp_~=0) = 1;
    Temp_8(Temp_8~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_8;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_8(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_8(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
    Temp_ = T_TEMP;
    Temp_9= temp_9;
    Temp_(Temp_~=0) = 1;
    Temp_9(Temp_9~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_9;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_9(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_9(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
        Temp_ = T_TEMP;
    Temp_10= temp_10;
    Temp_(Temp_~=0) = 1;
    Temp_10(Temp_10~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_10;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_10(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_10(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
    Temp_ = T_TEMP;
    Temp_11= temp_11;
    Temp_(Temp_~=0) = 1;
    Temp_11(Temp_11~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_11;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_11(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_11(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    
      
    Temp_ = T_TEMP;
    temp_12(:,1:50) = 0;
    Temp_12= temp_12;
    
    Temp_(Temp_~=0) = 1;
    Temp_12(Temp_12~=0) = 1;
    temp__ = zeros(512,1024);
    temp__ = Temp_+Temp_12;
    TEMP = zeros(512,1024);
    for j = 1:512
        [x,y] = find(temp__(j,:) == 2);
        if(size(x,2)>0)
            d = y(end)-y(1);
            for number = 1:size(y,2)
                TEMP(j,y(number)) = (y(end)-y(number))*T_TEMP(j,y(number))/d+(y(number)-y(1))*temp_12(j,y(number))/d;
            end
        end
    end
    
    for j = 1:512
        [x,y] = find(temp__(j,:) == 1);
        if(size(x,2)>0)
            for number = 1:size(y,2)
                TEMP(j,y(number)) = T_TEMP(j,y(number))+temp_12(j,y(number));
            end
        end
    end
    T_TEMP = TEMP;
    pano(2,:,:) = T_TEMP;
    imagesc(T_TEMP);
    set(gca,'position',[0 0 1 1])
    grid off
    axis normal
    axis off
    save_path_img_=fullfile(image_output,strcat('\',num2str(FILEreal_number),'_2.png'));
    saveas(gcf,save_path_img_);
    clf;
    
    
    save_path_mat = fullfile(image_output,strcat('\',num2str(FILEreal_number),'.mat'));
    save(save_path_mat,'pano');
end

