\l plt.q

n:10;
s:1;
nn:`long$n%s;
xx:nn#enlist s*neg[div[nn;2]]+til nn;
yy:reverse flip xx;

// unit circle
// x^2 + y^2 <= 1
circ:100>(xx*xx)+yy*yy;
.plt.hm[circ]

// SmoothLife
// Constants
b1:0.278;b2:0.365;d1:0.267;d2:0.445;an:0.028;am:0.147;
ra:3*ri:1;
dt:0.1;
u:circ;
// Sigmoids
s1:{[x;a;al]1%(1+exp neg 4*(x-a)%al)};
s2:{[x;a;b;an] s1[x;a;an]*1-s1[x;b;an]};
sm:{[x;y;m;am] x*(1-s1[m;0.5;am]) + y*s1[m;0.5;am]};
s:{[am;an;n;m] neg[1]+2*s2[n;sm[b1;d1;m;am];sm[b2;d2;m;am];an]}[am;an];

/ unew:u + dt*s[n;m]*u

(sum/) 10>(xx*xx)+yy*yy;
10>(xx*xx)+yy*yy;
