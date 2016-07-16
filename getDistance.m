% -----------------------------------------------------------------------------------
% AeroGA: Genetic Algorithm used to optimize the shape of small-scale airplane wings
% Copyright (C) 2016  Daniel Kneipp de Sá Veira
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/gpl-3.0.html>.
% -----------------------------------------------------------------------------------

function [dist] = getDistance(Cl, Clmax, Cp)
%GETDISTANCE returns the traveled distance by the plane. 
    
    S = 0.745;
    B = 2.3;
    b = -0.8;
    a = 29.5;
    G = 9.78;
    ro = 1.225;
    CDmin = 0.027;
    mi_s = 0.03;
    M0 = 2.448;
    d = 69.1;
    e = 0.735;
    h = 0.196;
    
    phi = getPhi(h, B);
    AR = getAR(B, S);
    M = getM(M0, Cp);
    W = getW(M, G);
    Vestol = getVestol(W, ro, S, Clmax);
    V = getV(Vestol);
    Cdi = getCdi(CDmin, phi, Cl, e, AR);
    A = getA(ro, S, mi_s, Cl, Cdi);
    C = getC(a, mi_s, W);
    
    delta = sqrt(4 * A * C - b.^2);
    num = 2 * b * (atan(b / delta) - atan((b + 2 * A * V) / delta));
    dist = M / (2 * A) * (real(num / delta) - log(C) + log(C + V * (b + A * V)));
end

function [r] = getPhi(h, B)
    num = ((16 * h) / B).^2;
    den = 1 + num;
    r = num / den;
end

function [r] = getAR(B, S)
    r = B.^2 / S;
end

function [r] = getVestol(W, ro, S, Clmax)
    num = 2 * W;
    den = ro * S * Clmax;
    r = sqrt(num / den);
end

function [r] = getV(Vestol)
    r = 1.2 * Vestol;
end

function [r] = getW(M, G)
    r = M * G;
end

function [r] = getM(M0, Cp)
    r = M0 + Cp;
end

function [r] = getCdi(CDmin, phi, Cl, e, AR)
    Clmd = 0.324;
    
    num = (Cl - Clmd).^2;
    den = e * AR * pi;
    r = CDmin + phi * (num / den);
end

function [r] = getA(ro, S, mi_s, Cl, Cdi)
    r = 0.5 * ro * S * (mi_s * Cl - Cdi);
end

function [r] = getC(a, mi_s, W)
    r = a - mi_s * W;
end
