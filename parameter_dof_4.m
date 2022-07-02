clc;clear;
m1=4; m2=1; m3=3; m4=2;
invm1=1/m1; invm2=1/m2; invm3=1/m3; invm4=1/m4;
k1=1;k2=1;k3=1;k4=1;k5=1;k6=1;
c1=2;c2=1;c3=1;

k=[k1+k2+k3+k4,-k2,-k4,-k5;
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
A=[zeros(dof,dof), eye(dof,dof);-inv(m)*k,-inv(m)*c];
B=[zeros(dof,dof);inv(m)];
C=[eye(dof),zeros(dof)];
D=zeros(dof,dof);