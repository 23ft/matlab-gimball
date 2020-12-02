
function varargout = gui(varargin)

    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @gui_OpeningFcn, ...
                       'gui_OutputFcn',  @gui_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})

        gui_State.gui_Callback = str2func(varargin{1});

    end

    if nargout

        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});

    else

        gui_mainfcn(gui_State, varargin{:});

end

function gui_OpeningFcn(hObject, eventdata, handles, varargin)
    
    handles.output = hObject;
    guidata(hObject, handles);
    

function varargout = gui_OutputFcn(hObject, eventdata, handles) 

    varargout{1} = handles.output;

   
%Gui - 2020


function buscar_Callback (hObject, eventdata, handles)

    [FileName, Path] = uigetfile({'*.jpg;*.bmp;*.png'},'Abrir Imagen');

    if isequal(FileName,0)
        return
    else
        disp(FileName);
        disp(Path);
    end
    handles.direccion = strcat(Path,FileName);
    guidata(hObject,handles);

%Funcion caracteristicas principales.
function cargar_Callback (hObject, eventdata, handles)
    
    imagen = imread(handles.direccion);
    [Row Col Cap] = size(imagen);
    
    handles.filas = Row;
    handles.columnas = Col;
    handles.capas = Cap;
    
    if Cap == 3
        handles.imagen = imagen;

        %imagen en escala grises.
        imagen_gris = rgb2gray(handles.imagen);
        colormap(gray(255));
        handles.gris = imagen_gris;

        %Capas.
        [Red Green Blue] = imsplit(handles.imagen);

        handles.red = Red;
        handles.Green = Green;
        handles.Blue = Blue;
        
         image(imagen);
        axis image;  
    else
        handles.gris = imagen;
        image(imagen);
        colormap(gray(255));
        axis image;
    end
    
    guidata(hObject, handles);

%Textos-Decoracion-Tratamientos.
function tratamiento1_Callback(hObject, eventdata, handles)

    image(handles.gris);
    disp(size(handles.gris))
    axis image;

    guidata(hObject, handles);
    
function text3_CreateFcn(hObject, eventdata, handles)

    set(hObject, 'String', 'Gui-Matlab')
    set(hObject, 'FontName', 'Console', 'FontWeight','bold')
    set(hObject, 'ForegroundColor', 'r') 
        

function pushbutton7_Callback(hObject, eventdata, handles)
    
   imagen_rojo = handles.red .* handles.gris;
   imagen = imagen_rojo .* handles.imagen;
   image(imagen);
   axis image;
   
   guidata(hObject, handles);


function pushbutton8_Callback(hObject, eventdata, handles)
    
   imagen_verde = handles.Green .* handles.gris;
   imagen = imagen_verde .* handles.imagen;
   image(imagen);
   axis image;
   
   guidata(hObject, handles);

function pushbutton9_Callback(hObject, eventdata, handles)
    
    imagen_azul = handles.Blue .* handles.gris;
    imagen = imagen_azul .* handles.imagen;
    image(imagen);
    axis image;
    
    guidata(hObject, handles);
    
function pushbutton11_Callback(hObject, eventdata, handles)

    image(handles.imagen);
    axis image;
    

%Paneles
    
function uipanel4_CreateFcn(hObject, eventdata, handles)
    
    set(hObject, 'Title', 'Tratamientos',...
                    'ForegroundColor','black' ,...
                    'BackgroundColor','white',...
                    'FontName', 'Console')
                    

function uipanel1_CreateFcn(hObject, eventdata, handles)

    
    set(hObject,'Title', 'Trat. RGB',...
                'ForegroundColor','black' ,...
                'BackgroundColor','white')
            
function uipanel2_CreateFcn(hObject, eventdata, handles)
    
    set(hObject,'Title', 'Trat. Gray Scale',...
                'ForegroundColor','black' ,...
                'BackgroundColor','white')
    
function uipanel3_CreateFcn(hObject, eventdata, handles)

    set(hObject,'Title', 'Load Image',...
                'ForegroundColor','black' ,...
                'BackgroundColor','white')

% Seleccion escala grises.

function pushbutton13_Callback(hObject, eventdata, handles)
    
    umbral = inputdlg({'Seleccione umbral!'}, 'Customer', [1 10]); % Ventana emergente para seleccion umbral.
    val = umbral{1,1};
    img = handles.gris;
    
    umbraln = str2num(val); % Get the information in box text

    img_gray = imbinarize(img, umbraln / 255); % binarizamos la imagen sabiendo que el umbral lo medimos 'graythresh' (devuelve valores entre 0 y 1 siendo 1 255)
    axes(handles.axes2)
    imshow(img_gray)
    
    guidata(hObject, handles);
