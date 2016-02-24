%% Pichon Antoine - Portelli Florian

function [x0,y0] = correlationPhase(A1,A2)

% On calcule les TF de 2 d'entre elles et calculons la puissance
% crois�e ; les coordonn�es du Dirac correspondent � la valeur du vecteur
% translation.


[h,w]=size(A1); % hauteur - h / largeur - w, de l'image

[A1x,A1y]=size(A1);
TF1=fft2(A1); % TF de la premi�re image

[A2x,A2y]=size(A2);
TF2=fft2(A2); % TF de la deuxi�me image

P12=(TF2.*conj(TF1))./abs(TF2.*conj(TF1)); % Transform�e de Fourier de la puissance crois�e
p12=ifft2(P12); % Puissance crois�e
figure(5), surf(p12)
title('Pic de Dirac de la translation')
xlabel('freq_x')
ylabel('freq_y')
zlabel('Puissance crois�e')
figure(6), imshow(p12)
title('Repr�sentation de p12')
xlabel('freq_x')
ylabel('freq_y')
zlabel('Puissance crois�e')

[~,ydir]=max(max(p12)); % ydir : ordonn�e du dirac
[~,max_dir]=max(p12(:,ydir)); % On cherche l'ordonn�e pour laquelle p est max

max_dir=max_dir-1;
ydir=ydir-1;

if max_dir < floor(h/2) 
    if ydir < floor(w/2) % Cadran 1
        x0=-max_dir;
        y0=-ydir;
    elseif ydir > floor(w/2) % Cadran 2
        x0=-max_dir;
        y0=-(ydir - w);
    end
elseif max_dir > floor(h/2)
    if ydir < floor(w/2) % Cadran 3
        x0=-(max_dir - h);
        y0=-ydir;
    elseif ydir > floor(w/2) % Cadran 4
        x0=-(max_dir - h);
        y0=-(ydir - w);
    end
end
end