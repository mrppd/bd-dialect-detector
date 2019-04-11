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


clc
c = evalin('base','Chittagong');
s = evalin('base','Sylhet');
b = evalin('base','Borishal');
n = evalin('base','Noakhali');
cha = evalin('base','Chapai');
Recognition_Table = [cellstr('Chittagong'), c; cellstr('Sylhet'), s; cellstr('Borishal'), b; cellstr('Noakhali'), n; cellstr('Chapai'), cha];
Recognition_Table=sortrows(Recognition_Table, -2);

f = figure('Position',[400 400 500 250]);
uitable(f, 'Data', Recognition_Table, 'ColumnName', {'Dialect', 'nlog_value'}, 'Position', [20 70 450 150]);
detection = char(Recognition_Table(1,1));
h = uicontrol(f,'Style','text', 'String', strcat('Detected Dialect:_  ', detection), 'Position',[30 20 400 30]);
set(h,'Foregroundcolor','r','FontSize',16,'Fontname','Helvetica','Fontweight','bold');

assignin('base', 'c', c);
assignin('base', 's', s);
assignin('base', 'b', b);
assignin('base', 'n', n);
assignin('base', 'cha', cha);

assignin('base','Recognition_Table',Recognition_Table);
