r = sqrt(0.97); % amplitude reflectivity of a mirror 
L = 0.5; % cavity length
FSR = 3e8/(2*L); 
finesse = pi/(2*asin((1-r^2)/(2*r)));
linewidth = FSR/finesse; 

s = linspace(-1.05*finesse, 1.05*finesse, 5000);
signal = zeros(1,length(s));

% for i = 1:length(s)
    f = s*linewidth;
    %cavity reflectivity
    phase_term = exp(-1i*2*pi*f/FSR);
    ref = r*(1-phase_term)./(1-r^2*phase_term);
    amp = abs(ref);
    phase = angle(ref);
 for i = 1:length(phase)
    product = abs(imag(hgmr00*ref(i))+0.01*hgmr01).^2;
    signal(i) = sum(sum(product(:,1:101)))-sum(sum(product(:,101:201)));
 end
    
figure()
plot(s,signal,'.-')
grid on

