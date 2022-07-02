%% 四自由度，任意激励（含动画）
%% 设定系统参数
clc;clear;
t=0:0.01:50;
t=t';
m1=4; m2=1; m3=3; m4=2;

k1=1;k2=1;k3=1;k4=1;k5=1;k6=1;
c1=2;c2=1;c3=1;

k=[k1+k2+k4+k5,-k2,-k4,-k5;
        -k2,      k2+k3,    -k3,     0;
        -k4,       -k3,      k3+k4,  0;
        -k5,       0,         0,     k5+k6];
    
c=[c1+c2,-c2,0,0;
   -c2,c2+c3,-c3,0;
   0,-c3,c3,0;
   0,0,0,0];
   
m=[m1,0,0,0;
    0,m2,0,0;
    0,0,m3,0;
    0,0,0,m4];

dof=size(m,1); %判断有多少自由度

A=[zeros(dof,dof),eye(dof,dof);-inv(m)*k,-inv(m)*c];
B=[0;0;0;0;0;0;0;1/m4];
C=[eye(dof),zeros(dof)];
D=zeros(dof,1);

sys=ss(A,B,C,D);
%% 定义初始条件
x0=[1;1;1;1;10;10;10;10];  %初始条件 z1,z2,z3,z4,z1_dot,z2_dot,z3_dot,z4_dot

u=sin(1*t);%可以任意设定其他激励
%% 求解
y=lsim(sys,u,t,x0); %含初始条件、激励
% y=step(sys,t);
x1=y(:,1);
x2=y(:,2);
x3=y(:,3);
x4=y(:,4);

%% 绘图
figure(1);
subplot(4,2,1);
plot(t,x1);
grid on;
title('x1,x2,x3,x4响应');
ylabel('x1/m');

subplot(4,2,3);
plot(t,x2);
grid on;
ylabel('x2/m');

subplot(4,2,5);
plot(t,x3);
grid on;
ylabel('x3/m');

subplot(4,2,7);
plot(t,x4);
grid on;
xlabel('t/s');
ylabel('x4/m');

%将z1,z2,z3放在一张图中对比
subplot(1,2,2);
plot(t,x1,'r',t,x2,'b',t,x3,'m',t,x4,'c');
hold on
title('x1,x2,x3,x4对比图');
legend('x1','x2','x3','x4');
xlabel('t/s');
ylabel('x/m')

hold on
p1=plot(t(1),x1(1),'o','MarkerFaceColor','r');
p2=plot(t(1),x2(1),'o','MarkerFaceColor','b');
p3=plot(t(1),x3(1),'o','MarkerFaceColor','m');
p4=plot(t(1),x4(1),'o','MarkerFaceColor','c');
hold off
axis manual
for k = 2:length(t)
    p1.XData = t(k);
    p1.YData = x1(k);
    p2.XData=t(k);
    p2.YData=x2(k);
    p3.XData=t(k);
    p3.YData=x3(k);
    p4.XData=t(k);
    p4.YData=x4(k);   
    drawnow
end

