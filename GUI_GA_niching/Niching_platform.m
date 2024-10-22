function varargout = Niching_platform(varargin)
% NICHING_PLATFORM M-file for Niching_platform.fig
%      NICHING_PLATFORM, by itself, creates a new NICHING_PLATFORM or raises the existing
%      singleton*.
%
%      H = NICHING_PLATFORM returns the handle to a new NICHING_PLATFORM or the handle to
%      the existing singleton*.
%
%      NICHING_PLATFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NICHING_PLATFORM.M with the given input arguments.
%
%      NICHING_PLATFORM('Property','Value',...) creates a new NICHING_PLATFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Niching_platform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Niching_platform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Niching_platform

% Last Modified by GUIDE v2.5 20-Nov-2013 16:50:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Niching_platform_OpeningFcn, ...
                   'gui_OutputFcn',  @Niching_platform_OutputFcn, ...
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


% --- Executes just before Niching_platform is made visible.
function Niching_platform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Niching_platform (see VARARGIN)

% Choose default command line output for Niching_platform
handles.output = hObject;
set(handles.saveas,'enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Niching_platform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Niching_platform_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla
%%%%
popsize  = str2num(get(handles.pop_size,'String'));
num_iter = str2num(get(handles.gene_size,'String'));
stringlength = str2num(get(handles.chrome_size,'String'));
range_low    = str2num(get(handles.range_low,'String'));
range_high   = str2num(get(handles.range_high,'String'));
option   = get(handles.function1,'Value');
if get(handles.function2,'Value')
    option = 4;
elseif get(handles.function3,'Value')
    option = 6;
elseif ~get(handles.function1,'Value')&~get(handles.function2,'Value')&get(handles.function3,'Value')
    warndlg('Please choose Function!');
    return;
end
pc       = str2num(get(handles.cross_rate,'String'))/100;
pm       = str2num(get(handles.mutation_rate,'String'))/100;
crowd    = get(handles.crowding,'Value');
shar     = get(handles.sharing,'Value');
sigmash  = str2num(get(handles.sigma,'String'));
alpha    = str2num(get(handles.alpha,'String'));
[pop Fmax Fmin Faver fun] = genetic(popsize, stringlength, range_low, range_high, option, pc, pm, num_iter, crowd, shar, sigmash, alpha,handles);
handles.population        = pop;
handles.Fmaxvalue         = Fmax;
handles.Fminvalue         = Fmin;
handles.Faverage          = Faver;
set(handles.saveas,'enable','on');

% --- Executes on button press in saveas.
function saveas_Callback(hObject, eventdata, handles)
% hObject    handle to saveas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
population_file = handles.population;




% --- Executes on button press in function1.
function function1_Callback(hObject, eventdata, handles)
% hObject    handle to function1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of function1


% --- Executes on button press in function2.
function function2_Callback(hObject, eventdata, handles)
% hObject    handle to function2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of function2


% --- Executes on button press in function3.
function function3_Callback(hObject, eventdata, handles)
% hObject    handle to function3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of function3



function pop_size_Callback(hObject, eventdata, handles)
% hObject    handle to pop_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pop_size as text
%        str2double(get(hObject,'String')) returns contents of pop_size as a double


% --- Executes during object creation, after setting all properties.
function pop_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gene_size_Callback(hObject, eventdata, handles)
% hObject    handle to gene_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gene_size as text
%        str2double(get(hObject,'String')) returns contents of gene_size as a double


% --- Executes during object creation, after setting all properties.
function gene_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gene_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cross_rate_Callback(hObject, eventdata, handles)
% hObject    handle to cross_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cross_rate as text
%        str2double(get(hObject,'String')) returns contents of cross_rate as a double


% --- Executes during object creation, after setting all properties.
function cross_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cross_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mutation_rate_Callback(hObject, eventdata, handles)
% hObject    handle to mutation_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mutation_rate as text
%        str2double(get(hObject,'String')) returns contents of mutation_rate as a double


% --- Executes during object creation, after setting all properties.
function mutation_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mutation_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sharing.
function sharing_Callback(hObject, eventdata, handles)
% hObject    handle to sharing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sharing


% --- Executes on button press in crowding.
function crowding_Callback(hObject, eventdata, handles)
% hObject    handle to crowding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of crowding



function sigma_Callback(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma as text
%        str2double(get(hObject,'String')) returns contents of sigma as a double


% --- Executes during object creation, after setting all properties.
function sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range_low_Callback(hObject, eventdata, handles)
% hObject    handle to range_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range_low as text
%        str2double(get(hObject,'String')) returns contents of range_low as a double


% --- Executes during object creation, after setting all properties.
function range_low_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range_high_Callback(hObject, eventdata, handles)
% hObject    handle to range_high (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range_high as text
%        str2double(get(hObject,'String')) returns contents of range_high as a double


% --- Executes during object creation, after setting all properties.
function range_high_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range_high (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function chrome_size_Callback(hObject, eventdata, handles)
% hObject    handle to chrome_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chrome_size as text
%        str2double(get(hObject,'String')) returns contents of chrome_size as a double


% --- Executes during object creation, after setting all properties.
function chrome_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chrome_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


