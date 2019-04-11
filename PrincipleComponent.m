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


clc
[w1 pc1 ev1] = princomp(double(evalin('base','Chittagong')));
[w2 pc2 ev2] = princomp(double(evalin('base','Sylhet')));
[w3 pc3 ev3] = princomp(double(evalin('base','Borishal')));
[w4 pc4 ev4] = princomp(double(evalin('base','Noakhali')));
[w5 pc5 ev5] = princomp(double(evalin('base','Rongpur')));
assignin('base', 'pc1', pc1);
assignin('base', 'pc2', pc2);
assignin('base', 'pc3', pc3);
assignin('base', 'pc4', pc4);
assignin('base', 'pc5', pc5);
