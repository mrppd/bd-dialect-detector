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


function varargout = Test(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Test_OpeningFcn, ...
                   'gui_OutputFcn',  @Test_OutputFcn, ...
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

function Test_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


function varargout = Test_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function SampleData_Callback(hObject, eventdata, handles)
    clc
    format long g;
    pathname = evalin('base', 'pathname');
    pathname = strcat(pathname, '\Voice\Testing');
    [FileName,PathName] = uigetfile({'*.wav';'*.*'},'Select an audio', 'MultiSelect', 'on', pathname);
    progressbar % Init single bar
    FileName = cellstr(FileName);
    n=size(FileName,2);
     progressbar(.40);
    for i=1:n
        str1 = strcat(PathName, FileName(i)); 
        [d,sr] = wavread(char(str1), [1 1280001]);
         progressbar(.50);
        mfccdd = msf_mfcc(d,sr);    
    end;
    %assignin('base', 'd', d);
    %assignin('base', 'sr', sr);
    assignin('base', 'mfccdd', mfccdd);
    progressbar(1.00);

% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
Main;
closereq;


% --- Executes on button press in PDF.
function PDF_Callback(hObject, eventdata, handles)
Pdf;



% --- Executes on button press in FinalResult.
function FinalResult_Callback(hObject, eventdata, handles)
FinalResult;
