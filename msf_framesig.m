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


%% msf_framesig - break a signal into frames
%
%   function win_frames = msf_framesig(signal, frame_len, frame_step, winfunc)
%
% Takes a 1 by N signal, and breaks it up into frames. Each frame starts
% _frame_step_ samples after the start of the previous frame. Each frame is
% windowed by wintype.
%
% - to specify window, use e.g. @hamming, @(x)chebwin(x,30), @(x)ones(x,1), etc.
%
% * |signal| - the input signal, vector of audio samples
% * |frame_len| - length of window in samples.
% * |frame_step| - step between successive windows in seconds. In samples.
% * |winfunc| - A function to be applied to each window.
%
% Example usage with hamming window:
%
%   frames = msf_framesig(speech, winlen*fs, winstep*fs, @(x)hamming(x));
%
function win_frames = msf_framesig(signal, frame_len, frame_step, winfunc)  
    if size(signal,1) ~= 1
        signal = signal';
    end
    
    signal_len = length(signal);
    if signal_len <= frame_len  % if very short frame, pad it to frame_len
        num_frames = 1;
    else
        num_frames = 1 + ceil((signal_len - frame_len)/frame_step);
    end
    padded_len = (num_frames-1)*frame_step + frame_len;
    % make sure signal is exactly divisible into N frames
    pad_signal = [signal, zeros(1,padded_len - signal_len)];
    
    % build array of indices
    indices = repmat(1:frame_len, num_frames, 1) + ...
        repmat((0: frame_step: num_frames*frame_step-1)', 1, frame_len);
    frames = pad_signal(indices);
    
    win = repmat(winfunc(frame_len)', size(frames, 1), 1);
    % apply window
    win_frames = frames .* win;
end