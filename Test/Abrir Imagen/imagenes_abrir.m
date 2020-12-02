imagen  = imread('1200px-Synthese+.svg.png');
disp(size(imagen));
imagen_grises = rgb2gray(imagen); % pasar escala grises 1 capa: rg2gray(imagen)
disp(size(imagen_grises));