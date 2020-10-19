v2 = double(noise);
y =  double(audio);

N = length(audio);
tau = [0 1 2 3 4 5 6 7 8 9];

r_v2 = zeros(1,length(tau));
r_v1_v2 = zeros(1,length(tau));

for i = 1:10
    for n = tau(i)+1:N
        r_v2(i) = r_v2(i) + (v2(n)*v2(n-tau(i)));
        r_v1_v2(i) = r_v1_v2(i)+(y(n)*v2(n-tau(i)));
    end
    r_v2(i) = r_v2(i)/(N-tau(i));
    r_v1_v2(i) = r_v1_v2(i)/(N-tau(i));
end