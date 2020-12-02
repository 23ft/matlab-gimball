
% Hallar los extremos, falta añadir el vector con cada fila.
% Calculos y regla 3 para el seguimiento.

%% Comunicacion Serial.

% Objeto comunicacion serial con STM32.
%serial = serial('/dev/ttyACM0', 'BaudRate', 9600);

% Abrimos la comunicacion serial.
%fopen(serial);


%% Configuracion camara y serial.

clear
% Creamos el objeto webcam.
web = webcam(1)

% Neurona entrenada para quitar ruido en imagenes.
%NeuralNetwork = denoisingNetwork('DnCNN');

% Activamos la previsualizacion camara.
%preview(web);

% Cerramos la previsualizacion camara.
%closePreview(web);      


%cols = [];          % Matriz con la posicion de cada columna.
%mins = [];
%maxs = [];

while(1)
    %% Captura Fotograma
    
    snap = snapshot(web);
    %[row col caps] = size(snap);
    
    %[R G B] = imsplit(snap); 
    
    %% Restado Capas
    
%     img_red = imgor(:, :, :) - G(:, :);
%     img_red = img_red(:, :, :) - B(:, :);
%     img_red = img_red(:, :, :) .* R(:, :);
%     img_red = img_red(:,:,1);
    
    % Separado Capa Roja. 
    ImageRed = snap(:, :, :) - snap(:, :, 2);
    ImageRed = ImageRed(:, :, :) - snap(:, :, 3);
    ImageRed = ImageRed(:, :, 1);
    
    % Separando Capa Verde.
    ImageGreen = snap(:, :, :) - snap(:, :, 1);
    ImageGreen = ImageGreen(:, :, :) - snap(:, :, 3);
    ImageGreen = ImageGreen(:, :, 2);
    
    % Separando Capa Azul.
    ImageBlue = snap(:, :, :) - snap(:, :, 1);
    ImageBlue = ImageBlue(:, :, :) - snap(:, :, 2);
    ImageBlue = ImageBlue(:, :, 3);
    
    %% Tratamiento capa y reconocimiento objetos.
    
%     img_red = imsubtract(imgor(:, :, 1), rgb2gray(imgor));
%     img_red = immultiply(img_red, R);
    
    % Eliminar ruido con iltro Image Processing ToolBox 'medfilt2'
    RedBw = medfilt2(ImageRed);
    GreenBw = medfilt2(ImageGreen);
    BlueBw = medfilt2(ImageBlue);
    
    % Imagen Binaria Capa Roja.
    RedBw = imbinarize(RedBw);
    GreenBw = imbinarize(GreenBw);
    BlueBw = imbinarize(BlueBw);
    
    % Matriz logica de 39x39 de tipo sretl(disk-shaped)
    RedStrel = strel('disk', 20);
    GreenStrel = strel('disk', 20);
    BlueStrel = strel('disk', 20);
    
    % Operacion morfologica de cierre, se le pasa el Strel como segundo
    % parametro.
    RedBw = imclose(RedBw, RedStrel);
    GreenBw = imclose(GreenBw, GreenStrel);
    BlueBw = imclose(BlueBw, BlueStrel);
    
    % Elimina los pixeles menores a 1000.
    %RedBw = bwareaopen(RedBw, 1000);
     
    % Eliminar ruido con deep learning.
    %RedBw = denoiseImage(RedBw, NeuralNetwork);
   
    % Determina la region a dibujar en la imagen binaria.
%     EdgeRed = bwboundaries(RedBw);
%     EdgeGreen = bwboundaries(GreenBw);
%     EdgeBlue = bwboundaries(BlueBw)
    
    
    % Centro de masa de los objetos [x y]
    RedCenter = regionprops(RedBw, 'BoundingBox', 'Centroid');
    GreenCenter = regionprops(GreenBw, 'BoundingBox', 'Centroid');
    BlueCenter = regionprops(BlueBw, 'BoundingBox', 'Centroid');

    % Ubicacion del centro del objeto.
%     if (length(centro) > 0)
%         
%         xval = centro.Centroid(1);
%         yval = centro.Centroid(2);
%         
%         disp(xval);
%         disp(' ');
%         disp(yval);
%         disp(centro);
%     end
    %disp(centro)
  
    
    %% Seguimiento Colores.
    
%     fila = 0;
%     row_s = 1;          % Lleva la columna anterior al finalizar la iteracion.
%     mincont = 0;
%     contextremos = 0;
%     
%     for row = 1:Alto
%         
%         colucont = 0;
%         for col = 1:Ancho
%             
%             if (img_red(row, col) == 255)
%                 colucont = colucont + 1;
%                 if (row ~= row_s)
%                     
%                     fila = fila + 1;
%                 end
%                 cols(colucont) = col;
%                 row_s = row;    
%             end
%             
%         end
%         if (colucont > 0)
%                     
%             contextremos = contextremos + 1;
%             mins(contextremos) = min(cols);
%             maxs(contextremos) = max(cols);
%         end
%     end
%     minimoAbsoluto = min(mins);
%     maximoAbsoluto = max(maxs);


    
    %% Dibujado Y Reconocimiento colores.

    % Imagen original del video.
    imagen = image(snap);
    
    % Previsualizacion de la camara.
    preview(web, imagen);
    
    hold on 
    
    % Dibujar cuadros de objetos rojos.
    for r = 1:length(RedCenter)
        
        % Variable que devuelve la posicion de el cuadrado que enreda toda
        % la area del color.
        Redbb = RedCenter(r).BoundingBox;
        
        % Centoid de cada objeto detectados.
        Redbc = RedCenter(r).Centroid;
        
        % Dibuja un rectangulo tomando como referencia la posicion del
        % BoundingBox
        rectangle('Position', Redbb, 'EdgeColor', 'r', 'LineWidth', 2)
    end
    
    % Dibujar cuadros de objetos verdes.
    for g = 1:length(GreenCenter)
        
        Greenbb = GreenCenter(g).BoundingBox;
        Greenbc = GreenCenter(g).Centroid;
        rectangle('Position', Greenbb, 'EdgeColor', 'g', 'LineWidth', 2)
    end
    
    % Dibujar cuadros de objetos azules.
    for a = 1:length(BlueCenter)
        
        Bluebb = BlueCenter(a).BoundingBox;
        Bluebc = BlueCenter(a).Centroid;
        rectangle('Position', Bluebb, 'EdgeColor', 'b', 'LineWidth', 2)
    end
    
    
    % Metodo de matlab para dibujar los contornos de los objetos.
%     visboundaries(EdgeRed);
    
%     plot(bordes(:,2), bordes(:,1), 'b', 'LineWidth', 2);
    hold off   
end
