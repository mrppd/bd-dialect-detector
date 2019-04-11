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


%% msf_lpcc - Linear Prediction Cepstral Coefficients
%
%   function feat = msf_lpcc(speech,fs,varargin)
%
% given a speech signal, splits it into frames and computes Linear Prediction Cepstral Coefficients for each frame.
%
% * |speech| - the input speech signal, vector of speech samples
% * |fs| - the sample rate of 'speech', integer
%
% optional arguments supported include the following 'name', value pairs 
% from the 3rd argument on:
%
% * |'winlen'| - length of window in seconds. Default: 0.025 (25 milliseconds)
% * |'winstep'| - step between successive windows in seconds. Default: 0.01 (10 milliseconds)
% * |'order'| - the number of coefficients to return. Default: 12
%
% Example usage:
%
%   lpccs = msf_lpcc(signal,16000,'order',10);
%
function feat = msf_lpcc(speech,fs,varargin)
    p = inputParser;   
    addOptional(p,'winlen',      0.025,@(x)gt(x,0));
    addOptional(p,'winstep',     0.01, @(x)gt(x,0));
    addOptional(p,'order',       12,   @(x)ge(x,1));
    addOptional(p,'preemph',     0,    @(x)ge(x,0));
    parse(p,varargin{:});
    in = p.Results;

    frames = msf_framesig(speech,in.winlen*fs,in.winstep*fs,@(x)hamming(x));
    temp = lpc(frames',in.order);
    temp = temp(:,2:end); % ignore leading ones
    feat = cepst(temp);

end

function ccs = cepst(apks)
% ccs = cepst(apks)
% - calculates cepstral coefficients from lpcs
% - apks are the lpc values (without leading 1)
%    - if more than one, apks should be a N by D matrix, where N is the
%    number of lpc vectors, D is the number of lpcs
% - ccs are the cepstral coefficients
% the number of ccs is the same as the number of lpcs
[N P] = size(apks);
ccs = zeros(N,P);

for i = 1:N
    for m = 1:P
        s = 0;
        for k = 1:(m-1)
            s = s + -1*(m - k)*ccs(i,m - k)*apks(i,k);
        end
        ccs(i,m) = -1*apks(i,m) + (1/m)*s;
    end
end
end
