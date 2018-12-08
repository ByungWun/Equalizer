function varargout = myeq(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myeq_OpeningFcn, ...
                   'gui_OutputFcn',  @myeq_OutputFcn, ...
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

function myeq_OpeningFcn(hObject, eventdata, handles, varargin)

handles.fs = 44100;%샘플링rate 초기화 audioread를 하면 바뀐다
handles.order = 8;
handles.orders = 2*ones(1,10);
handles.frequencies = [31,63,127,255,511,1023,2047,4095,8191, ...
                    16383]; %조정할 주파수 영역대 10가지
handles.qualityfactors = 1.5*ones(1,10);
handles.gains = zeros(1,10); %입출력 전압 크기비를 전부 0으로 초기화
handles.bandwidth = handles.frequencies ./ handles.qualityfactors;
handles.mPEQ = dsp.BiquadFilter(...
    'SOSMatrixSource','Input port',...
    'ScaleValuesInputPort',false);
%IIR filter 함수를 handle.mPEQ로 씀
[handles.b,handles.a] = designParamEQ(handles.orders, ...
                                      handles.gains,handles.frequencies,handles.bandwidth);
% [B,A] = designParamEQ(N,gain,centerFreq,bandwidth) 입출력 전압의 크기의 비(gain) 중심 주파수 및 대역폭을 갖는 
% Nth- order 파라메트릭 이퀄라이저를 설계, 주파수 magnitude 조절 슬라이드에서 수정될 값들이다.
guidata(hObject, handles); %guide에서 guidata사용 하여 handle 구조체에 myeq데이터 저장하기

handles.output = hObject;

guidata(hObject, handles);

function varargout = myeq_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;

% --- Executes on slider movement.
function s31_Callback(hObject, eventdata, handles)
% hObject    handle to s31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(1) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function s63_Callback(hObject, eventdata, handles)
% hObject    handle to s63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(2) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s63_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function s127_Callback(hObject, eventdata, handles)
% hObject    handle to s127 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(3) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s127_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s127 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function s255_Callback(hObject, eventdata, handles)
% hObject    handle to s255 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(4) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s255_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s255 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function s511_Callback(hObject, eventdata, handles)
% hObject    handle to s511 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(5) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s511_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s511 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function s1k_Callback(hObject, eventdata, handles)
% hObject    handle to s1k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(6) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s1k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s1k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function s2k_Callback(hObject, eventdata, handles)
% hObject    handle to s2k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(7) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s2k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s2k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function s4k_Callback(hObject, eventdata, handles)
% hObject    handle to s4k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(8) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s4k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s4k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function s8k_Callback(hObject, eventdata, handles)
% hObject    handle to s8k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(9) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s8k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s8k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function s16k_Callback(hObject, eventdata, handles)
% hObject    handle to s16k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gains(10) = get(hObject,'Value');
[handles.b,handles.a] = designParamEQ(handles.orders,handles.gains,handles.frequencies,handles.bandwidth);
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function s16k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s16k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in openbutton.
function openbutton_Callback(hObject, eventdata, handles)
% hObject    handle to openbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% MATT the ifs below are judging the members in handles struct,
% MATT if them exist, then release for opening a new file.
% if isfield(handles,'fileReader')
%     release(handles.fileReader)
% end
% if isfield(handles,'mPEQ')
%     release(handles.mPEQ)
% end
% if isfield(handles,'deviceWriter')
%     release(handles.deviceWriter)
% end
[filename,pathname]=uigetfile(...
    {'*.*','All Files(*.*)'}, ...
    'Select a *. file');%불러온 파일을 filename에 저장
if isequal(filename,0)||isequal(pathname,0)
    return;
else
    set(handles.nowplay,'String',filename);%nowplay를 현재 선택된 파일 이름으로 바꿔줌.
end
[wave,fs] = audioread(filename); 
%[wave,fs] = audioread(filename)은 filename이라는 파일에서 데이터를 읽고 
%샘플링된 데이터 wave와 이 데이터의 샘플 레이트 Fs를 반환.
handles.frequencies = handles.frequencies * (2*pi/fs);
handles.bandwidth = handles.bandwidth * (2*pi/fs);

handles.filename = filename;
handles.fs = fs;%audioread로 부터 반환된 샘플링rate를 저장
guidata(hObject, handles);

% --- Executes on button press in playbutton1.
function playbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to playbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
if ~isfield(handles,'filename')
    errordlg('Please select an audio file.','Error');
    return;
end
nowstate = get(handles.pausebutton1,'String');
if  strcmp(nowstate,'Continue')
    set(handles.pausebutton1,'String','Pause');
end
if isfield(handles,'fileReader')
    release(handles.fileReader)
end
if isfield(handles,'mPEQ')
    release(handles.mPEQ)
end
if isfield(handles,'deviceWriter')
    release(handles.deviceWriter)
end

frameLength = 1024;
handles.fileReader = dsp.AudioFileReader(...
    'Filename',handles.filename,...
    'SamplesPerFrame',frameLength);
% 오디오 파일을 스트리밍 해준다
handles.deviceWriter = audioDeviceWriter(...
    'SampleRate',handles.fileReader.SampleRate);
% 오디오 파일을 사운드 카드 버퍼에 올려주고 재생시킨다
setup(handles.deviceWriter,ones(frameLength,2));
guidata(hObject, handles);
while ~isDone(handles.fileReader)&&~flag
    handles.originalSignal = handles.fileReader();
    switch get(handles.eqenable,'Value') %EQ체크박스에 체크가 되면 실행
      case 1
        handles.equalizedSignal = handles.mPEQ(handles.originalSignal,handles.b,handles.a);
        %주파수 magnitude 조정 슬라이드에서 변경된 값들을 통해 변경된 magnitude를 equilizedSignal로 저장
        handles.deviceWriter(handles.equalizedSignal);
        %변경된 신호를 사운드 카드 버퍼에 쓰고 재생
        
      case 0 %EQ체크박스의 체크가 없으면 실행
        handles.deviceWriter(handles.originalSignal);
        %본래 신호대로 출력해준다
    end
    pause(2e-2);
end
flag = 0;
% 버퍼에 쓸 신호가 없다면 읽기와 출력을 멈춘다
if isfield(handles,'fileReader')&&isDone(handles.fileReader)
    release(handles.fileReader)
end
if isfield(handles,'deviceWriter')&&isDone(handles.fileReader)
    release(handles.deviceWriter)
end


% --- Executes on button press in pausebutton1.
function pausebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pausebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nowstate = get(hObject,'String');
if  strcmp(nowstate,'Continue')
    set(hObject,'String','Pause');
    uiresume;
elseif strcmp(nowstate,'Pause')
    set(hObject,'String','Continue');
    uiwait;
end

% --- Executes on button press in stopbutton1.
function stopbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to stopbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% delete(handles.fileReader);
global flag;
flag = 1;
nowstate = get(handles.pausebutton1,'String');
if  strcmp(nowstate,'Continue')
    set(handles.pausebutton1,'String','Pause');
    flag = 0;
end
guidata(hObject, handles);

% --- Executes on button press in exitbutton.
function exitbutton_Callback(hObject, eventdata, handles)
% hObject    handle to exitbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
flag = 1;
close();

% --- Executes during object creation, after setting all properties.
function slideruseless_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slideruseless (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in eqenable.
function eqenable_Callback(hObject, eventdata, handles)
% hObject    handle to eqenable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eqval = get(hObject,'Value');
switch eqval
  case 1
    set(hObject,'String','EQ ON');
  case 0
    set(hObject,'String','EQ OFF');
end
% Hint: get(hObject,'Value') returns toggle state of eqenable

% --- Executes during object creation, after setting all properties.
function stopbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global flag;
flag = 0;

function figure1_CreateFcn(hObject, eventdata, handles)

