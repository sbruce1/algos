// Rayleigh-Taylor Instability
\l plt.q
// Constants
Nx:100;
Ny:100;
Lx:1;
Ly:1;
dx:`real$Lx%Nx; dy:`real$Ly%Ny;
dt:0.0001e;
T:10; 
g:9.81e;
rho1:1.0e;
rho2:1.1e;
mu:0.001e;

u:v:p:(Nx;Ny)#0e;
rho:(Nx;Ny)#1e;
rho[::;a+til a:"j"$Ny%2]:rho2;
rho+:`real$(rho2-rho1)*0.005*sin[2*(`real$3.1415926535)*(til Nx)%Nx-1];

up:{1_x,enlist first x};
down:{(enlist last x),-1_x};
left:{y@/:x}[;up];
right:{y@/:x}[;down];


f:.plt.gifhm[1];
.plt.hmupd[f;flip rho];
t:0;

do["i"$T%dt;
    u+:`real$dt*(neg[u]*(up[u]-down[u])%2*dx)+(neg[v]*(left[u]-right[u])%2*dy)+(neg (up[p]-down[p])%2*dx*rho)+mu*((up[u]+down[u]-2*u)%dx*dx)+(left[u]+right[u]-2*u)%dy*dy;
    u[::;0]:0e;u[0;::]:0e;u[-1+count u;::]:0e;u[::;-1+count first u]:0e;
    v+:`real$dt*(neg[u]*(up[v]-down[v])%2*dx)+(neg[v]*(left[v]-right[v])%2*dy)+(neg (left[p]-right[p])%2*dy*rho)+(mu*((up[v]+down[v]-2*v)%dx*dx)+(left[v]+right[v]-2*v)%dy*dy)+neg[g]*(rho-rho1)%((rho2+rho1)%2);
    v[::;0]:0.e;v[0;::]:0e;v[-1+count v;::]:0e;v[::;-1+count first v]:0e;
    d:((up[u]-down[u])%2*dx)+(left[v]-right[v])%2*dy;
    do[50;
        p:`real$0.25*up[p]+down[p]+left[p]+right[p]-dx*dy*d%dt;
        p[0;::]:p[1;::];p[::;0]:p[::;1];p[-1+count p;::]:p[-2+count p;::];p[::;-1+count first p]:p[::;-2+count first p]];

    u-:`real$dt*(up[p]-down[p])%2*dx*rho;
    v-:`real$dt*(left[p]-right[p])%2*dy*rho;

    rho-:`real$dt*((u*up[rho]-down[rho])%2*dx)+v*(left[rho]-right[rho])%2*dy;
    if[0="i"$mod[div[t;dt];500];
        if[t>1;.plt.hmupd[f;flip rho]];
        0N!string[t],"/",string[T]];
    t+:dt];

.plt.close[f];
exit 0;