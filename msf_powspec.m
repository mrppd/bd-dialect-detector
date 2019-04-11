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


%% msf_powspec - Compute power spectrum of audio frames
%
%   function pspec = msf_powspec(speech,fs,varargin)
%
% given a speech signal, splits it into frames and computes the power spectrum for each frame.
%
% * |speech| - the input speech signal, vector of speech samples
% * |fs| - the sample rate of 'speech', integer
%
% optional arguments supported include the following 'name', value pairs 
% from the 3rd argument on:
%
% * |'winlen'| - length of window in seconds. Default: 0.025 (25 milliseconds)
% * |'winstep'| - step between successive windows in seconds. Default: 0.01 (10 milliseconds)
% * |'nfft'| - the FFT size to use. Default: 512
%
% Example usage:
%
%   lpcs = msf_powspec(signal,16000,'winlen',0.5);
%
function pspec = msf_powspec(speech,fs,varargin)
    p = inputParser;   
    addOptional(p,'winlen',0.025,@isnumeric);
    addOptional(p,'winstep',0.01,@isnumeric);
    addOptional(p,'nfft',512,@isnumeric);
    addOptional(p,'mean_threshold',1.1,@isnumeric); 
    parse(p,varargin{:});
    in = p.Results;
   
    frames = msf_framesig(speech,in.winlen*fs,in.winstep*fs,@(x)hamming(x));
    %assignin('base', 'frames', frames);
    
    pspec = 1/(in.winlen*fs)*abs(fft(frames,in.nfft,2)).^2;
    %assignin('base', 'power1', pspec);
    %figure, plot(pspec), title('power spectrum 1');
    
    ps = sum(pspec, 2);
    threshold = in.mean_threshold*mean(ps);
    %assignin('base', 'ps1', ps);
    
    ps(ps<threshold) = 0;
    %assignin('base', 'ps2', ps);
    
    jj=1;
    for ii=1: size(pspec, 1)
        if(ps(ii))
            pspec2(jj, 1:in.nfft) = pspec(ii, 1:in.nfft);
            jj = jj + 1;
        end;
    end;
    %assignin('base', 'power1_tranc', pspec2);
    %figure, plot(pspec2), title('power truncated spectrum 2');
     
    pspec = pspec2(:,1:in.nfft/2);
    %assignin('base', 'power', pspec);
    %figure, plot(pspec), title('power spectrum 3');
end
