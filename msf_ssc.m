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


%% msf_ssc - Spectral Subband Centroids
%
%   function feat = msf_ssc(speech,fs,varargin)
%
% given a speech signal, splits it into frames and computes Spectral Subband Centroids for each frame.
%
% * |speech| - the input speech signal, vector of speech samples
% * |fs| - the sample rate of 'speech', integer
%
% optional arguments supported include the following 'name', value pairs 
% from the 3rd argument on:
%
% * |'winlen'| - length of window in seconds. Default: 0.025 (25 milliseconds)
% * |'winstep'| - step between successive windows in seconds. Default: 0.01 (10 milliseconds)
% * |'nfilt'| - the number filterbanks to use. Default: 26
% * |'lowfreq'| - the lowest filterbank edge. In Hz. Default: 0    
% * |'highfreq'| - the highest filterbank edge. In Hz. Default: fs/2
% * |'nfft'| - the FFT size to use. Default: 512
%
% Example usage:
%
%   sscs = msf_ssc(signal,16000,'nfilt',40,'ncep',12);
%
function feat = msf_ssc(speech,fs,varargin)
    p = inputParser;   
    addOptional(p,'winlen',      0.025,@(x)gt(x,0));
    addOptional(p,'winstep',     0.01, @(x)gt(x,0));
    addOptional(p,'nfilt',       26,   @(x)ge(x,1));
    addOptional(p,'lowfreq',     0,    @(x)ge(x,0));
    addOptional(p,'highfreq',    fs/2, @(x)ge(x,0));
    addOptional(p,'nfft',        512,  @(x)gt(x,0));       
    addOptional(p,'preemph',     0,    @(x)ge(x,0));    
    parse(p,varargin{:});
    in = p.Results;
    H = msf_filterbank(in.nfilt,fs,in.lowfreq,in.highfreq,in.nfft);
    pspec = msf_powspec(speech,fs,'winlen',in.winlen,'winstep',in.winstep,'nfft',in.nfft);
    R = repmat(linspace(0,fs/2,in.nfft/2),size(pspec,1),1);
    feat = ((R.*pspec)*H')./ (pspec*H');
end
