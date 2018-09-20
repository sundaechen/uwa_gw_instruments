% maple('with','orthopoly')%not needed in matlab2009
[x,y]=meshgrid(-0.5:0.005:.5,-.5:0.005:.5);
%% move matrix%%
xmove = 0; % move horizontal
ymove = 0;   % move vertical
xm = x-xmove;
ym = y-ymove;
%% Rotate matrix %%
theta = 30;% rotate angle
rotate_angle = theta/180*pi;
r = [cos(rotate_angle),-sin(rotate_angle);sin(rotate_angle),cos(rotate_angle)];
 
xmr = ones(size(xm,1),size(xm,2));
ymr = ones(size(ym,1),size(ym,2));

for m = 1:size(x,1)
    for n = 1:size(x,2)
        xytemp = [xm(m,n);ym(m,n)];
        Rtemp= r*xytemp;
        xmr(m,n) = Rtemp(1);
        ymr(m,n) = Rtemp(2);
    end
end
%% membrane resonant mode%%
mb= [];
for i = 1:12
    for j = 1:12
        mbtemp = sin(i*pi*(x+.5)/1).*sin(j*pi*(y+.5)/1);
        mb(:,:,i,j) = mbtemp;
    end
end

    
% mb11=sin(1*pi*(x+.5)/3).*sin(1*pi*(y+.5)/3);
% mb12=sin(1*pi*(x+.5)/3).*sin(2*pi*(y+.5)/3);
% mb13=sin(1*pi*(x+.5)/3).*sin(3*pi*(y+.5)/3);
% mb14=sin(1*pi*(x+.5)/3).*sin(4*pi*(y+.5)/3);
% mb15=sin(1*pi*(x+.5)/3).*sin(5*pi*(y+.5)/3);
% mb16=sin(1*pi*(x+.5)/3).*sin(6*pi*(y+.5)/3);
% mb23=sin(2*pi*(x+.5)/3).*sin(3*pi*(y+.5)/3);
% mb22=sin(2*pi*(x+.5)/1).*sin(2*pi*(y+.5)/1);
% mb33=sin(3*pi*(x+.5)/1).*sin(3*pi*(y+.5)/1);
% mb43=sin(4*pi*(x+.5)/1).*sin(3*pi*(y+.5)/1);
% mb24=sin(2*pi*(x+.5)/1).*sin(4*pi*(y+.5)/1);
% mb25=sin(2*pi*(x+.5)/1).*sin(5*pi*(y+.5)/1);
% mb34=sin(3*pi*(x+.5)/1).*sin(4*pi*(y+.5)/1);
% mb44=sin(4*pi*(x+.5)/1).*sin(4*pi*(y+.5)/1);
% mb45=sin(4*pi*(x+1.5)/3).*sin(5*pi*(y+1.5)/3);
% mb55=sin(5*pi*(x+1.5)/3).*sin(5*pi*(y+1.5)/3);
% mb410=sin(4*pi*(x+1.5)/3).*sin(10*pi*(y+1.5)/3);
% mb210=sin(2*pi*(x+1.5)/3).*sin(10*pi*(y+1.5)/3);
%maple('with','orthopoly') %to use Hermite functions
% hg00=HG(0,0,0.131,x,y); %HG00 mode field distribution waist=0.131mm
% hg11=HG(1,1,0.131,x,y); %HG11 mode field distribution waist=0.131mm
% hg02=HG(0,2,0.131,x,y); %HG02 mode field distribution waist=0.131mm
% hg20=HG(2,0,0.131,x,y); %HG20 mode field distribution waist=0.131mm
% hg40=HG(4,0,0.131,x,y); %HG40 mode field distribution waist=0.131mm
% hg22=HG(2,2,0.131,x,y); %HG22 mode field distribution waist=0.131mm
% hg13=HG(1,3,0.131,x,y); %HG13 mode field distribution waist=0.131mm
% hg01=HG(0,1,0.131,x,y); %HG01 mode field distribution waist=0.131mm
% hg03=HG(0,3,0.131,x,y); %HG02 mode field distribution waist=0.131mm
% hg12=HG(1,2,0.131,x,y); %HG12 mode field distribution waist=0.131mm

hgmr00=HG(0,0,0.131,xmr,ymr); %HG00 mode field distribution waist=0.131mm

hgmr01=HG(0,1,0.131,xmr,ymr); %HG01 mode field distribution waist=0.131mm
hgmr10=HG(1,0,0.131,xmr,ymr); %HG01 mode field distribution waist=0.131mm

hgmr02=HG(0,2,0.131,xmr,ymr); %HG02 mode field distribution waist=0.131mm
hgmr20=HG(2,0,0.131,xmr,ymr); %HG20 mode field distribution waist=0.131mm
hgmr11=HG(1,1,0.131,xmr,ymr); %HG11 mode field distribution waist=0.131mm

hgmr03=HG(0,3,0.131,xmr,ymr); %HG03 mode field distribution waist=0.131mm
hgmr30=HG(3,0,0.131,xmr,ymr); %HG30 mode field distribution waist=0.131mm
hgmr12=HG(1,3,0.131,xmr,ymr); %HG12 mode field distribution waist=0.131mm
hgmr21=HG(2,1,0.131,xmr,ymr); %HG21 mode field distribution waist=0.131mm

hgmr04=HG(0,4,0.131,xmr,ymr); %HG04 mode field distribution waist=0.131mm
hgmr40=HG(4,0,0.131,xmr,ymr); %HG40 mode field distribution waist=0.131mm
hgmr13=HG(1,3,0.131,xmr,ymr); %HG13 mode field distribution waist=0.131mm
hgmr31=HG(3,1,0.131,xmr,ymr); %HG31 mode field distribution waist=0.131mm
hgmr22=HG(2,2,0.131,xmr,ymr); %HG22 mode field distribution waist=0.131mm

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hgmrr40= [];
for i = 1:10
    for j = 1:11-i
        ni = i-1;
        nj = j-1;
        hgmrtemp=HG(ni,nj,0.131,xmr,ymr); %HGij mode field distribution waist=0.131mm
        hgmrr40(:,:,i,j) = hgmrtemp;
    end
end

overlapmbr40 = [];
overlaplightr40 = [];
% mass = [];
clear m n i j;
for m = 1:10
    for n = 1:11-m
        for i = 1:10
            for j = 1:10
                   
        clear a b c d e f;
        a=sum(sum(hgmr(:,:,1,1).*hgmr(:,:,m,n).*mb(:,:,i,j)))*0.005*0.005;
        b=sum(sum(hgmr(:,:,m,n).*hgmr(:,:,m,n)))*0.005*0.005;
        c=sum(sum(mb(:,:,i,j).*mb(:,:,i,j)))*0.005*0.005;
        d=sum(sum(hgmr(:,:,1,1).*hgmr(:,:,1,1)))*0.005*0.005;
        e=size(x);
        f=(e(1)-1)*(e(2)-1)*0.005*0.005;
        overlaptemp=a^2*f/(b*c*d);
        overlapmbr40(m,n,i,j) = overlaptemp;
        overlaplightr40(i,j,m,n) = overlaptemp;
%         mass(i,j) = c; 
        
            end
        end
    end
end

for i = 1:10;
    for j = 1:10;
        wtemp = overlapmb(:,:,i,j);
        sheetname = ['mb',num2str(i),'_',num2str(j)];
        [sus,mes] = xlswrite('overlap.xlsx',wtemp,sheetname)
    end
end

for m = 1:10
    for n = 1:11-m
        wtemp = overlaplight(:,:,m,n);
        sheetname = ['laser',num2str(m),'_',num2str(n)];
        [sus,mes] = xlswrite('overlap.xlsx',wtemp,sheetname)
        disp(sheetname);
    end
end
        
        
%%
        
mass = [];
for i = 1:10
    for j = 1:10
        c=sum(sum(abs(mb(:,:,i,j)).*abs(mb(:,:,i,j))))*0.005*0.005;
        e=size(x);
        f=(e(1)-1)*(e(2)-1)*0.005*0.005;
        mass(i,j) = 1/c;
    end
end
        
        
%hg22=HG(2,2,0.383,x,y); %HG22 mode field distribution waist=0.383mm
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%
overlap01 = [];
for i = 1:10
    for j = 1:10
        clear a b c d e f;
        a=sum(sum(hgmr00.*hgmr01.*mb(:,:,i,j)))*0.005*0.005;
        b=sum(sum(hgmr01.*hgmr01))*0.005*0.005;
        c=sum(sum(mb(:,:,i,j).*mb(:,:,i,j)))*0.005*0.005;
        d=sum(sum(hgmr00.*hgmr00))*0.005*0.005;
        e=size(x);
        f=e(1)*e(2)*0.005*0.005;
        overlaptemp=a^2*f/(b*c*d);
        overlap01(i,j) = overlaptemp;
    end
end
% save overlap01.txt overlap01 -ascii;

overlap10 = [];
for i = 1:10
    for j = 1:10
        clear a b c d e f;
        a=sum(sum(hgmr00.*hgmr10.*mb(:,:,i,j)))*0.005*0.005;
        b=sum(sum(hgmr10.*hgmr10))*0.005*0.005;
        c=sum(sum(mb(:,:,i,j).*mb(:,:,i,j)))*0.005*0.005;
        d=sum(sum(hgmr00.*hgmr00))*0.005*0.005;
        e=size(x);
        f=e(1)*e(2)*0.005*0.005;
        overlaptemp=a^2*f/(b*c*d);
        overlap10(i,j) = overlaptemp;
    end
end
% save overlap10.txt overlap10 -ascii;

%%
overlap02 = [];
for i = 1:10
    for j = 1:10
        clear a b c d e f;
        a=sum(sum(hgmr00.*hgmr02.*mb(:,:,i,j)))*0.005*0.005;
        b=sum(sum(hgmr02.*hgmr02))*0.005*0.005;
        c=sum(sum(mb(:,:,i,j).*mb(:,:,i,j)))*0.005*0.005;
        d=sum(sum(hgmr00.*hgmr00))*0.005*0.005;
        e=size(x);
        f=e(1)*e(2)*0.005*0.005;
        overlaptemp=a^2*f/(b*c*d);
        overlap02(i,j) = overlaptemp;
    end
end
save overlap02.txt overlap02 -ascii;


overlap20 = [];
for i = 1:8
    for j = 1:8
        clear a b c d e f;
        a=sum(sum(hg00.*hg20.*mb(:,:,i,j)))*0.005*0.005;
        b=sum(sum(hg20.*hg20))*0.005*0.005;
        c=sum(sum(mb(:,:,i,j).*mb(:,:,i,j)))*0.005*0.005;
        d=sum(sum(hg00.*hg00))*0.005*0.005;
        e=size(x);
        f=e(1)*e(2)*0.005*0.005;
        overlaptemp=a^2*f/(b*c*d);
        overlap20(i,j) = overlaptemp;
    end
end
save overlap20.txt overlap20 -ascii;

%%
overlap03 = [];
for i = 1:10
    for j = 1:10
        clear a b c d e f;
        a=sum(sum(hgmr00.*hgmr03.*mb(:,:,i,j)))*0.005*0.005;
        b=sum(sum(hgmr03.*hgmr03))*0.005*0.005;
        c=sum(sum(mb(:,:,i,j).*mb(:,:,i,j)))*0.005*0.005;
        d=sum(sum(hgmr00.*hgmr00))*0.005*0.005;
        e=size(x);
        f=e(1)*e(2)*0.005*0.005;
        overlaptemp=a^2*f/(b*c*d);
        overlap03(i,j) = overlaptemp;
    end
end
save overlap03.txt overlap03 -ascii;

overlap30 = [];
for i = 1:10
    for j = 1:10
        clear a b c d e f;
        a=sum(sum(hgmr00.*hgmr30.*mb(:,:,i,j)))*0.005*0.005;
        b=sum(sum(hgmr30.*hgmr30))*0.005*0.005;
        c=sum(sum(mb(:,:,i,j).*mb(:,:,i,j)))*0.005*0.005;
        d=sum(sum(hgmr00.*hgmr00))*0.005*0.005;
        e=size(x);
        f=e(1)*e(2)*0.005*0.005;
        overlaptemp=a^2*f/(b*c*d);
        overlap30(i,j) = overlaptemp;
    end
end
save overlap30.txt overlap30 -ascii;
%overlap22=aa^2*f/(bb*c*d)

overlap12 = [];
for i = 1:10
    for j = 1:10
        clear a b c d e f;
        a=sum(sum(hgmr00.*hgmr12.*mb(:,:,i,j)))*0.005*0.005;
        b=sum(sum(hgmr12.*hgmr12))*0.005*0.005;
        c=sum(sum(mb(:,:,i,j).*mb(:,:,i,j)))*0.005*0.005;
        d=sum(sum(hgmr00.*hgmr00))*0.005*0.005;
        e=size(x);
        f=e(1)*e(2)*0.005*0.005;
        overlaptemp=a^2*f/(b*c*d);
        overlap12(i,j) = overlaptemp;
    end
end
save overlap12.txt overlap12 -ascii;

overlap40 = [];
for i = 1:8
    for j = 1:8
        clear a b c d e f;
        a=sum(sum(hg00.*hg40.*mb(:,:,i,j)))*0.005*0.005;
        b=sum(sum(hg40.*hg40))*0.005*0.005;
        c=sum(sum(mb(:,:,i,j).*mb(:,:,i,j)))*0.005*0.005;
        d=sum(sum(hg00.*hg00))*0.005*0.005;
        e=size(x);
        f=e(1)*e(2)*0.005*0.005;
        overlaptemp=a^2*f/(b*c*d);
        overlap40(i,j) = overlaptemp;
    end
end
save overlap40.txt overlap40 -ascii;

% 
% cry = [];
% for i = 1:3
%     for j = 1:3-i+1
%         trytemp = sin(i*pi*(x+.5)/1).*sin(j*pi*(y+.5)/1);
%         cry(:,:,i,j) = trytemp;
%     end
% end
%% %
c = 0;
for i = 1:(size(x,1)-1)
    j = i+1;
    ctemp = sqrt(0.005^2+(mb(101,i,3,3)-mb(101,j,3,3))^2);
    c = c+ctemp;
end
   
%% 
mbc = mb(:,:,3,3);
s = 0;
% A = [];
% B = [];
% C = [];
% D = [];
% E = [];
% F = [];
% S1 = [];
% S2 = [];
% S = [];
for i = 1:(size(x,1)-1)
    for j = 1:(size(x,2)-1)
        a = sqrt(0.005*0.005+(mbc(i,j)-mbc(i,j+1))^2);
        b = sqrt(0.005*0.005+(mbc(i,j)-mbc(i+1,j))^2);
        c = sqrt(0.005*0.005+(mbc(i,j+1)-mbc(i+1,j+1))^2);
        d = sqrt(0.005*0.005+(mbc(i+1,j)-mbc(i+1,j+1))^2);
        e = sqrt(0.005*0.005+(mbc(i,j+1)-mbc(i+1,j))^2);
        s1 = 1/4*sqrt((a+b+e)*(-a+b+e)*(a-b+e)*(a+b-e));
        s2 = 1/4*sqrt((c+d+e)*(-c+d+e)*(c-d+e)*(c+d-e));
        s = s+s1+s2;
%         A(i,j) = a;
%         B(i,j) = b;
%         C(i,j) = e;
%         D(i,j) = -c+d+e;
%         E(i,j) = c-d+e;
%         F(i,j) = c+d-e;
%         S1(i,j) = s1;
%         S2(i,j) = s2;
%         S(i,j) = s1+s2;
    end
end
%%
% for i = 1:(size(x,1)-1)
%     for j = 1:(size(x,2)-1)
%         a = sqrt(0.005*0.005+(mbc(i,j)-mbc(i,j+1))^2);
%         A(i,j) = a;
%     end
% end
