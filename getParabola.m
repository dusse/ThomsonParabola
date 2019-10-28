function [ X,Y ] = getParabola( q,m,proton_energy_min,proton_energy_max,proton_rest_energy,angle )

electr_field = -20.0e3;

%all lengths in meters
magnet_radius=0.03;
Lo=0.20;Lb=2*magnet_radius;Leb=0.04;Le=0.1;Ls=0.1;
L=Lo+Lb+Leb+Le+Ls;
step_number = 1000;
energy_step_number=2000;
c=3e8;%light velocity(meter/sec)
%initialize fields
Ex_arr = zeros(step_number+1);
lenght_B = 0:1:176;%mm
mag_field=[.402,.402,.401,.4,.397,.394,.389,.379,.371,.359,.346,.324,.283,.242,.202,.150,.104,.058,.028,.008,.004,-.012,-.020,-.024,-.026,-.028,-.028,-.028,-.026,-.025,-.024,-.022,-.022,-.020,-.020,-.018,-.018,-.016,-.016,-.014,-.014,-.012,-.012,-.012,-.010,-.010,-.010,-.010,-.008,-.008,-.008,-.008,-.008,-.006,-.006,-.006,-.006,-.006,-.006,-.006,-.004,-.004,-.004,-.004,-.004,-.004,-.004,-.004,-.004,-.004,-.004,-.004,-.004,-.002,-.002,-.002,-.002,-.002,-.002,-.002,-.002,-.002,-.002,-.002,-.002,-.002,-.002,-.002,0];
Bx_arr = zeros(1,size(lenght_B,2));
Bx_arr(1:2:end)=mag_field(:);
for i=2:2:(size(Bx_arr,2)-1)
    Bx_arr(i) = (Bx_arr(i-1)+Bx_arr(i+1))/2;
end

Ex_arr(1:step_number+1) =electr_field/0.025;% Volt/meters
X=zeros(1, energy_step_number+1);
Y=zeros(1, energy_step_number+1);
qm_ratio = q/m;
current_proton_energy=proton_energy_min;
delta_E=(proton_energy_max-proton_energy_min)/energy_step_number;

for j=1:energy_step_number+1
    Vz=c*sqrt(1-(proton_rest_energy/(current_proton_energy+proton_rest_energy))^2);%meter/sec
    x_curr=0;
    y_curr=0;
    Vx_curr = 0;
    Vy_curr=Vz*sin(angle);
    Vz = Vz*cos(angle);
    max_B_lenght = max(lenght_B(1,:))/1000;
    for i=0:step_number
        z=i*L/step_number;
        Ex=0;Bx=0;
        delta_r = sqrt((z-Lo-Lb/2)^2+y_curr^2);%meter
        if delta_r < max_B_lenght
            [near,near_idx] = min(abs(lenght_B(1,:)/1000-delta_r));
            Bx = Bx_arr(near_idx);
        end
        if( z > (Lo+Lb+Leb) && z < (Lo+Lb+Leb+Le) )
            Ex = Ex_arr(i+1);
        end
        delta_t=L/step_number/Vz;
        
        x_curr = x_curr+Vx_curr*delta_t+0.5*(delta_t^2)*qm_ratio*Ex;
        Vx_curr = Vx_curr+delta_t*qm_ratio*Ex;
        
        y_curr = y_curr+Vy_curr*delta_t+0.5*(delta_t^2)*qm_ratio*Vz*Bx;
        Vy_curr = Vy_curr+delta_t*qm_ratio*Vz*Bx;
    end
    X(j)=x_curr;
    Y(j)=y_curr;
    current_proton_energy=current_proton_energy+delta_E;
end
end

