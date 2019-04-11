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


%% msf_filterbank - return a mel-spaced filterbank
%
%   function fbank = msf_filterbank(nfilt,fs,lowfreq,highfreq,nfft)
%
% returns a mel-spaced filterbank for use with filterbank energies, mfccs, sscs etc.
%
% * |nfilt| - the number filterbanks to use. 
% * |fs| - the sample rate of 'speech', integer
% * |lowfreq| - the lowest filterbank edge. In Hz.
% * |highfreq| - the highest filterbank edge. In Hz.
% * |nfft| - the FFT size to use.
%
% Example usage:
%
%   lpcs = msf_filterbank(26,16000,0,16000,512);
%
function fbank = msf_filterbank(nfilt,fs,lowfreq,highfreq,nfft)
    % compute points evenly spaced in mels
    lowmel = hz2mel(lowfreq);
    highmel = hz2mel(highfreq);
    melpoints = linspace(lowmel,highmel,nfilt+2);
    % our points are in Hz, but we use fft bins, so we have to convert from Hz to fft bin number
    bin = 1+floor((nfft-1)*mel2hz(melpoints)/fs);

    fbank = zeros(nfilt,nfft/2);
    for j = 1:nfilt
        for i = bin(j):bin(j+1)
            fbank(j,i) = (i - bin(j))/(bin(j+1)-bin(j));
        end
        for i = bin(j+1):bin(j+2)
            fbank(j,i) = (bin(j+2)-i)/(bin(j+2)-bin(j+1));
        end
    end
end

function hz = mel2hz(mel)
    hz = 700*(10.^(mel./2595) -1);
end

function mel = hz2mel(hz)
    mel = 2595*log10(1+hz./700);
end
