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


f_rate = false_alarm_rate;
given=size(true_pos_rate, 2);
cnt=1;

while(1)
    s = size(f_rate, 2);
    f_rate = sort(f_rate);

    if(s==given)
        break;
    end;
    
    tt = [];
    for i=1: s
        for j=i+1: s
            if(i==j) 
                continue;
            end;
            tt = [tt; i , j, abs(f_rate(i)-f_rate(j))];
        end;
    end;

    tt = sortrows(tt, [3]);
    tmp_ar = [];
    j=1;
    for i=1: s
        if(i==tt(1,1) || i==tt(1, 2))
            continue;
        end;
        tmp_ar(j) = f_rate(i);
        j = j+1;
    end;
    tmp_ar(j) = (f_rate(tt(1,1)) +  f_rate(tt(1,2)))/2;
    f_rate = tmp_ar;
    cnt = cnt+1;
end;
