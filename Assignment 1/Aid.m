close all
clc
gamma = 1;
Delta_t = 10^(-2);
omega = 3;
beta = 0.8;

den = (1 + gamma * Delta_t + (omega * Delta_t)^2);
b1 = -(2 + gamma * Delta_t) / den;
b2 = 1 / den;
b3 = (Delta_t^2 * beta) / den;

z = tf('z',Delta_t);

H = b3 / (1+b1*z^-1+b2*z^-2);

step(H);

N = 10^4;
L = 30;

x = zeros(N,L);
w = zeros(N,L);

for l = 1:L
    for k = 3:N
        w_k = normrnd(0,1);
        x_k = b3 * w_k - b1 * x(k-1,l) - b2 * x(k-2,l);
        x(k,l)=x_k;
        w(k,l)=w_k;
    end
end
time=linspace(0,N*Delta_t,N);
plot(time, x)

% autocorr(x(:,1), N-1)
subplot(2,1,1)
hold on
for j = 1:L
[xc,lags] = xcorr(x(:,j), w(:,j), 1000);
plot(lags(round(length(lags)/2):end),xc(round(length(lags)/2):end))
end
hold off
subplot(2,1,2)
impulse(H);

% Differences Equation
M = idpoly(H.Denominator, H.Numerator, 'NoiseVariance',0);
