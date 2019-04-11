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


%% msf_mfcc - Mel Frequency Cepstral Coefficients
%
%   function feat = msf_mfcc(speech,fs,varargin)
%
% given a speech signal, splits it into frames and computes Mel frequency cepstral coefficients for each frame.
% For a tutorial on MFCCs, see <http://www.practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/ MFCC tutorial>.
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
% * |'ncep'| - the number of cepstral coeffients to use. Default: 13
% * |'liftercoeff'| - liftering coefficient, 0 is no lifter. Default: 22
% * |'appendenergy'| - if true, replaces 0th cep coeff with log of total frame energy. Default: true
% * |'mean_threshold'| - default value 1.1. It will replace low energy frame from fower spectrum. If value provided 0, then it will be remain inactive.
%
% Example usage:
%
%   mfccs = msf_mfcc(signal,16000,'nfilt',40,'ncep',12);
%
function mfccs = msf_mfcc(speech,fs,varargin)
    p = inputParser;   
    addOptional(p,'winlen',      0.025,@(x)gt(x,0));
    addOptional(p,'winstep',     0.01, @(x)gt(x,0));
    addOptional(p,'nfilt',       26,   @(x)ge(x,1));
    addOptional(p,'lowfreq',     0,    @(x)ge(x,0));
    addOptional(p,'highfreq',    fs/2, @(x)ge(x,0));
    addOptional(p,'nfft',        512,  @(x)gt(x,0));
    addOptional(p,'ncep',        13,   @(x)ge(x,1));          
    addOptional(p,'liftercoeff', 22,   @(x)ge(x,0));          
    addOptional(p,'appendenergy',true, @(x)ismember(x,[true,false]));          
    addOptional(p,'preemph',     0,    @(x)ge(x,0)); 
    addOptional(p,'mean_threshold',     1.1,    @isnumeric);
    parse(p,varargin{:});
    in = p.Results;
    
    H = msf_filterbank(in.nfilt, fs, in.lowfreq, in.highfreq, in.nfft);
    %assignin('base', 'filterbank', H);
    pspec = msf_powspec(speech, fs, 'winlen', in.winlen, 'winstep', in.winstep, 'nfft', in.nfft, 'mean_threshold', in.mean_threshold);
    
    %assignin('base', 'power', pspec);
    %figure, plot(pspec), title('power spectrum 3');
    
    en = sum(pspec,2); % energy in each frame
    %assignin('base', 'en', en);
    
    filter_pspec = log(H*pspec');
    %assignin('base', 'filter_power', filter_pspec);
    feat = dct(filter_pspec)';
    %assignin('base', 'DCT_values', feat);
    %figure, plot(feat), title('DCT');
    
    mfccs = lifter(feat(:,1:in.ncep), in.liftercoeff);
    %assignin('base', 'DCT_values_lifter', mfccs);
    %figure, plot(mfccs), title('DCT_lift');
    
    if in.appendenergy
        mfccs(:,1) = log10(en);
    end
    
    CepCoeff = mfccs(:,2:size(mfccs,2));
    delta = find_delta_delta(CepCoeff, 2);
    delta_delta = find_delta_delta(delta, 2);
    mfccs = [mfccs, delta, delta_delta];
    
end


function delta = find_delta_delta(mfccs, N)
    [R C] = size(mfccs);
    delta = zeros(R, C);
    de=0;
    for n=1:N
        de = de + 2*n*n;
    end;
    for i=1: R    
        for n=1:N
            if(i-n<1 && i+n>R)
                delta(i, :) = delta(i, :) + n*(mfccs(R, :)-mfccs(1, :)); %illogical possibility. Not needed.
            elseif(i-n<1 && i+n<=R)
                delta(i, :) = delta(i, :) + n*(mfccs(i+n, :)-mfccs(1, :));    
            elseif(i-n>=1 && i+n>R)
                delta(i, :) = delta(i, :) + n*(mfccs(R, :)-mfccs(i-n, :));
            else
                delta(i, :) = delta(i, :) + n*(mfccs(i+n, :)-mfccs(i-n, :));
            end;
        end; 
    end;
    delta = delta/de;
end



function lcep = lifter(cep,L)
    [N,D] = size(cep);
    n = 0:D-1;
    lift = 1 + (L/2)*sin(pi*n/L);
    lcep = cep .* repmat(lift,N,1);
end
