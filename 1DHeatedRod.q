\l ascii.q
solve1DHeat:{[u0;alpha;L;T;Nx;Nt]
    dx:L%Nx-1;  
    dt:T%Nt-1;  
    r:alpha*dt%dx*dx;  
    u:u0;

    {[r;u;i]
        .ascii.home[];
        u:u+r*(-2*u) + sum (prev;next)@\:u;
        u:@[u;0;:;1f];
        u:@[u;-1+count u;:;0f];
        .ascii.showColour[enlist u];
        u
    }[r]/[u;1+til Nt-1];
    u
 };

alpha:0.1; 
L:1.0; 
T:1; 
Nx:50; 
Nt:1000;

u0:Nx#0;
.ascii.clear[];
solve1DHeat[u0;alpha;L;T;Nx;Nt];