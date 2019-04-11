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


function train(obj_name,path)

    clc
    format long g;
    [FileName,PathName] = uigetfile({'*.wav';'*.*'},'Select an audio', 'MultiSelect', 'on',strcat(path, '\Voice\Training\'));
    FileName = cellstr(FileName);
    n=size(FileName,2);

progressbar(0.0, 0.0); % Init single bar
progressbar('Completion','Uploading Voice Samples');

    for i=1:n
        str1 = strcat(PathName, FileName(i)); 
        [d,sr] = wavread(char(str1), [1 1280001]);
        %sound(d, sr);
        mfccdd = msf_mfcc(d,sr, 'mean_threshold', .5);
        
        if(i==1)
            mfcc_f = mfccdd;
        else
            mfcc_f = [mfcc_f; mfccdd]; 
        end;
        
        if(i==n)
            progressbar(0.5, i/n);
        else
            progressbar(0, i/n);
        end;
    end;
    
    %mf = [mfcc_f(:,1),mfcc_f(:,2)]
    %figure, scatter(mfcc_f(:,1),mfcc_f(:,2),[],'d')
    %hold on;
    
    progressbar(0.5, 0.0);
    %wait = waitbar(.5,'Please wait...Training is on going...');
    options = statset('Display','final', 'MaxIter', 500);
    obj = gmdistribution.fit(mfcc_f, n,'Options',options);
    %close(wait);
    progressbar(1.0, 1.0);
    %figure, ezsurf(@(x,y)pdf(obj,[x y]),[-3 1.5],[-30 70])
    %ezcontour(@(x,y)pdf(obj,[x y]));
    
    assignin('base', obj_name, obj);
    save(strcat(path, 'ProjectV1\TrainedData\', obj_name, '.mat'), 'obj');
%    assignin('base', 'TimeSpent', TimeSpent);
end
