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
wait = waitbar(.5,'Done PDF');
try
    Chittagong  = mean(log(pdf(evalin('base','obj_CTG'), evalin('base','mfccdd'))));
catch
    Chittagong = -99999999;
end

try
    Sylhet = mean(log(pdf(evalin('base','obj_Sylhet'),evalin('base', 'mfccdd'))));
catch
    Sylhet = -99999999;
end

try
    Borishal = mean(log(pdf(evalin('base','obj_Borishal'),evalin('base', 'mfccdd'))));
catch
    Borishal = -99999999;
end

try
    Noakhali = mean(log(pdf(evalin('base','obj_Noakhali'),evalin('base', 'mfccdd'))));
catch
    Noakhali = -99999999;
end

try
    Chapai   = mean(log(pdf(evalin('base','obj_Chapai'),evalin('base', 'mfccdd'))));
catch
    Chapai = -99999999;
end

%[Chittagong nlog1] = posterior(evalin('base','obj_CTG'), evalin('base','mfccdd'));
%[Sylhet nlog2] = posterior(evalin('base','obj_Sylhet'),evalin('base', 'mfccdd'));
%[Borishal nlog3] = posterior(evalin('base','obj_Borishal'),evalin('base', 'mfccdd'));
%[Noakhali nlog4] = posterior(evalin('base','obj_Noakhali'),evalin('base', 'mfccdd'));
%[Rongpur nlog5] = posterior(evalin('base','obj_Rongpur'),evalin('base', 'mfccdd'));

assignin('base', 'Chittagong', Chittagong);
assignin('base', 'Sylhet', Sylhet);
assignin('base', 'Borishal', Borishal);
assignin('base', 'Noakhali', Noakhali);
assignin('base', 'Chapai', Chapai);

close(wait);
%assignin('base', 'nlog1', nlog1);
%assignin('base', 'nlog2', nlog2);
%assignin('base', 'nlog3', nlog3);
%assignin('base', 'nlog4', nlog4);
%assignin('base', 'nlog5', nlog5);
