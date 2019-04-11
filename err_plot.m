% This file is part of Bangladeshi Dialect Detector program which was
% developed during Bangladeshi dialect recognition research.

% Bangladeshi Dialect Detector is free software: you can redistribute 
% it and/or modify it under the terms of the GNU General Public License 
% as published by the Free Software Foundation, either version 3 of the 
% License, or (at your option) any later version.

% Bangladeshi Dialect Detector is distributed in the hope that it 
% will be useful, but WITHOUT ANY WARRANTY; without even the implied 
% warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
% See the GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with Bangladeshi Dialect Detector.  
% If not, see <https://www.gnu.org/licenses/>.

% The methodology and experimental details have been published in the following paper:
% Bangladeshi Dialect Recognition using Mel Frequency Cepstral Coefficient, 
% Delta, Delta-delta and Gaussian Mixture Model, DOI: 10.1109/ICACI.2016.7449852
% https://ieeexplore.ieee.org/abstract/document/7449852


%{
m_tot=size(m_rate, 2);
f_tot=m_tot;
min_dist = [];
for i=1: m_tot
    j=i;
    %for j=1: f_tot
        min_dist = [min_dist; f_rate(j), m_rate(i), abs(f_rate(j)-m_rate(i)), (f_rate(j)+m_rate(i))/2];
    %end;
end;

min_dist = sortrows(min_dist, [3]);
%}
m_d = [];
for i=1:size(op, 1)
    m_d = [m_d; fp(i), mr(i), abs(fp(i)- mr(i)), (fp(i)+ mr(i))/2];
end;

m_d = sortrows(m_d, [3]);
