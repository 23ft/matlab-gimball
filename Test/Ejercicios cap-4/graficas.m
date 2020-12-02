x = [0:2:18]
y = [0:2:18]
plot(x, y)
grid on

x = [0:pi/100:2*pi];
y1 = cos(x*4);
plot(x, y1)
y2 = sin(x)
hold on % Habilita para rayar plot actual o añadir mas graficas al mismo.
plot(x, y2)
hold off % Cierra el uso con la ventana actual.
y3 = x;
plot(x, y3)

% Ejercicios 5.1

x = [0:0.1*pi:2*pi];
y = sin(x);
plot(x, y, ':ok');
title('Grafica 1');
xlabel('Pi');
ylabel('Sin(x)');


x = [0:0.1*pi:2*pi];
y1 = sin(x);
y2 = cos(x);
plot(x, y1, '--xr', x, y2, ':ok');
title('Graica 2');
xlabel('Pi');
ylabel('Y1-Y2');
legend('Y1', 'Y2');


x = [0:0.1*pi:2*pi];
y1 = sin(x);
y2 = cos(x);
subplot(2, 1, 1) % (filas, columnas, posicion gracia)
plot(x, y1, '--xr');
title('grafica 1')
hold on
plot(x, y2, ':ok');
hold off
subplot(2, 1, 2)
plot(x, y2, '--xk');
title('grafica 2');




