function varargout = gui2_umbral(varargin)
% GUI2_UMBRAL MATLAB code for gui2_umbral.fig
%      GUI2_UMBRAL, by itself, creates a new GUI2_UMBRAL or raises the existing
%      singleton*.
%
%      H = GUI2_UMBRAL returns the handle to a new GUI2_UMBRAL or the handle to
%      the existing singleton*.
%
%      GUI2_UMBRAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI2_UMBRAL.M with the given input arguments.
%
%      GUI2_UMBRAL('Property','Value',...) creates a new GUI2_UMBRAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui2_umbral_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui2_umbral_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui2_umbral

% Last Modified by GUIDE v2.5 22-Oct-2020 10:03:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui2_umbral_OpeningFcn, ...
                   'gui_OutputFcn',  @gui2_umbral_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before gui2_umbral is made visible.
function gui2_umbral_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui2_umbral (see VARARGIN)

% Choose default command line output for gui2_umbral
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui2_umbral wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui2_umbral_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function boton1_Callback(hObject, eventdata, handles)
img = imread('lenna_gris.png');
axes(handles.grafico1);
imshow(img);

umbral = str2num(get(handles.umbraltxt, 'String'));

img_gray = imbinarize(img, umbral / 255);
axes(handles.grafico2);
imshow(img_gray);


function umbraltxt_Callback(hObject, eventdata, handles)
% hObject    handle to umbraltxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umbraltxt as text
%        str2double(get(hObject,'String')) returns contents of umbraltxt as a double


% --- Executes during object creation, after setting all properties.
function umbraltxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umbraltxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
