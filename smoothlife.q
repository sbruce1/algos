\l plt.q

ngrid:25;
s:0.2;
nn:`long$ngrid%s;
xx:nn#enlist s*neg[div[nn;2]]+til nn;
yy:reverse flip xx;

// SmoothLife
// Constants
b1:0.278;b2:0.365;d1:0.267;d2:0.445;an:0.028;am:0.147; // paper
// b1:0.257; b2:0.336;d1:0.365; d2:0.549;am:0.028; an:0.147; // alternatives

ra:3*ri:1;
/ ra:6*ri:2;
/ dt:0.1;
dt:0.05;
// Sigmoids
s1:{[x;a;al]1%(1+exp neg 4*(x-a)%al)};
s2:{[x;a;b;an] s1[x;a;an]*(1-s1[x;b;an])};
sm:{[x;y;m;am] (x*(1-s1[m;0.5;am])) + y*s1[m;0.5;am]};
sd:{[n;m]s2[n;sm[b1;d1;m;am];sm[b2;d2;m;am];an]}
s:{[n;m] neg[1]+2*sd[n;m]};
// Normalization constants // TODO calculate once everything to the rhs of >
M:(sum/)@'' Mmask:ri>''circs:((xx-/:first xx)*(xx-/:first xx))+\:/:((yy-/:first xx)*(yy-/:first xx));
N:(sum/)@'' Nmask:neg[Mmask]+''ra>''circs;
/ unew:u + dt*s[n;m]*u
uold:0.5*4>(xx*xx)+yy*yy;
/ uold:0.5+0.5*4>(xx*xx)+yy*yy;
/ uold:(nn;nn)#(nn*nn)?1e;

maxIter:100;
f:.plt.gifhm[1];
.plt.hmupd[f;uold];

do[maxIter;
    n:(sum/)@''.[{x%y};] peach flip ((Nmask*nn#enlist nn#enlist uold);N);
    m:(sum/)@''.[{x%y};] peach flip ((Mmask*nn#enlist nn#enlist uold);M);
    unew:uold + dt*s[n;m]*uold;
    uold:unew;
    .plt.hmupd[f;uold];
 ];
.plt.close[f];
exit 0;