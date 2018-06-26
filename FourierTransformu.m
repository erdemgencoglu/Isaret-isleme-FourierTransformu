clear;
clc
% Erdem Gençoðlu
% 12253030

% wav dosyalarýný okuma
[x,fs]=audioread('winter-is-coming.wav',[24120 25930]);
[y,fss]=audioread('ufleme-sesi.wav',[24120 25930]);
[a,fsss]=audioread('karismis.wav',[24120 25930]);

% sinyallerin fourier transformunun alýnmasý
Y=fft(x.*hamming(length(x)));
YY=fft(y.*hamming(length(y)));
XY=fft(a.*hamming(length(a)));


% 1000hz lik sinyal oluþturduk
hz1000=1000*length(Y)/fs;
f=(0:hz1000)*fs/length(Y);

%winter is coming sinyali
subplot(4,1,1)
plot(f,20*log10(abs(Y(1:length(f)))+eps),'blue');
hold on
grid
legend('Fourier Spek.');
xlabel('Frekans (Hz)');
ylabel('Genlik b.(dB)');
title('Winter is coming sinyali')

%ufleme sinyali
subplot(4,1,2)
plot(f,20*log10(abs(YY(1:length(f)))+eps),'red');
grid
legend('Fourier Spek.');
xlabel('Frekans (Hz)');
ylabel('Genlik b.(dB)');
title('Üfleme sinyali')

%Sinyallerin birbirine eklenmiþ halinin sinyali
subplot(4,1,3)
plot(f,20*log10(abs(XY(1:length(f)))+eps),'green');
grid
legend('Fourier Spek.');
xlabel('Frekans (Hz)');
ylabel('Genlik b.(dB)');
title('Karismis Hali')

%Filtre Kýsmý
Ws = 2*pi*fss ;% Radyan cinsinden örnekleme frekansý = Ws 
Ts = 1/fss ;% Ts = 2e-4 saniye
N =4; % Derece N 
fc = 5000; % Kesim frekansý fc
Wc = 2*pi*fc; % Radyan cinsinden kesim frekansý = Wc
Wn = Wc/(Ws/7); % Wc'nin Ws/2'ye göre normalize edilmiþi
[num, den] = butter(N, Wn, 'low'); % Filtreyi tasarla
sysFilt = tf(num,den,Ts);
u = a;
g = filter(num,den,u);
subplot(4,1,4)
plot(f,20*log10(abs(g(1:length(f)))+eps),'blue');
grid
title('Filtre')
xlabel('Frekans (Hz)');
ylabel('Genlik b.(dB)');
legend('Filtrelenmiþ ses');
