%La fonction de mesure du gyro, soumise à un bruit et à un biais
function omegam=mesureGyro(omega, b)
global sigmagyro;
omegam=omega+b+sigmagyro*randn(1,3);
end