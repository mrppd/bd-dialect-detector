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

% The methodology and experimental details have been published in following paper:
% Bangladeshi Dialect Recognition using Mel Frequency Cepstral Coefficient, 
% Delta, Delta-delta and Gaussian Mixture Model, DOI: 10.1109/ICACI.2016.7449852
% https://ieeexplore.ieee.org/abstract/document/7449852


function main()
    clc
    format long g;
    [FileName,PathName] = uigetfile({'*.wav';'*.*'},'Select an audio', 'MultiSelect', 'on','F:\Work\research work\Dialect research\Voice\');
    FileName = cellstr(FileName);
    n=size(FileName,2);
    for i=1:n
        str1 = strcat(PathName, FileName(i)); 
        [d,sr] = wavread(char(str1), [1 1280001]);
        mfccdd = msf_mfcc(d,sr);    
    end;
    %X_ctg = pdf(obj_ctg, mfccdd);
    

    
    assignin('base', 'd', d);
    assignin('base', 'd', d);
    assignin('base', 'sr', sr);
    assignin('base', 'mfccdd', mfccdd);
    %assignin('base', 'X_ctg', X_ctg);
    %assignin('base', 'Y_syl', Y_syl);
    
    %{
    [ctg nlog] = posterior(obj_ctg, mfccdd);
    [syl nlog2] = posterior(obj_syl, mfccdd);
    [w1 pc1 ev1] = princomp(double(ctg));
    [w2 pc2 ev2] = princomp(double(syl));
    c = sum(pc1);
    s = sum(pc2);
    max(s(1,1), c(1,1))
    %}
end