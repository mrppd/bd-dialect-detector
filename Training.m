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


function varargout = Training(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Training_OpeningFcn, ...
                   'gui_OutputFcn',  @Training_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function Training_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


function varargout = Training_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function Chittagong_Callback(hObject, eventdata, handles)
clc
path = evalin('base', 'pathname');
obj_name = 'obj_CTG';
%path = 'F:\Work\research work\Dialect research\';
train(obj_name,path);
function Sylhet_Callback(hObject, eventdata, handles)

clc
path = evalin('base', 'pathname');
obj_name = 'obj_Sylhet';
%path = 'F:\Work\research work\Dialect research\';
train(obj_name,path);
    
function Borishal_Callback(hObject, eventdata, handles)

clc
path = evalin('base', 'pathname');
obj_name = 'obj_Borishal';
%path = 'F:\Work\research work\Dialect research\';
train(obj_name,path);

function Noakhali_Callback(hObject, eventdata, handles)

clc
path = evalin('base', 'pathname');
obj_name = 'obj_Noakhali';
%path = 'F:\Work\research work\Dialect research\';
train(obj_name,path);


function Chapai_Callback(hObject, eventdata, handles)
clc
path = evalin('base', 'pathname');
obj_name = 'obj_Chapai';
%path = 'F:\Work\research work\Dialect research\';
train(obj_name,path);



function Back_Callback(hObject, eventdata, handles)
Main;
closereq;


% --- Executes on button press in Chapai.

