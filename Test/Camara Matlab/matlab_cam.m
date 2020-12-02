% 'webcamlist' -> Lista de webcams.
% 'imaghwinfo' -> Info toolbox matlab.
clear
mycam = webcam(2); % Objeto WEBCAM!
preview(mycam); % Tomar captura de la camara.
closePreview(mycam);

cont = 0;

while (1)

   im = snapshot(mycam);
   image(im)
   cont = cont + 1;
   disp(cont)
    
end     
