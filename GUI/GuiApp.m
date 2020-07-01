function varargout = GuiApp(varargin)
% GUIAPP MATLAB code for GuiApp.fig
%      GUIAPP, by itself, creates a new GUIAPP or raises the existing
%      singleton*.
%
%      H = GUIAPP returns the handle to a new GUIAPP or the handle to
%      the existing singleton*.
%
%      GUIAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIAPP.M with the given input arguments.
%
%      GUIAPP('Property','Value',...) creates a new GUIAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GuiApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GuiApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GuiApp

% Last Modified by GUIDE v2.5 27-Jun-2020 18:52:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GuiApp_OpeningFcn, ...
                   'gui_OutputFcn',  @GuiApp_OutputFcn, ...
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


% --- Executes just before GuiApp is made visible.
function GuiApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GuiApp (see VARARGIN)

% Choose default command line output for GuiApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GuiApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GuiApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rossutdounw;
rosinit;

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in Inicio.
function Inicio_Callback(hObject, eventdata, handles)
% hObject    handle to Inicio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Start the conection with ROS Master
rosshutdown;
rosinit;

    set(handles.waitText,'visible', 'on'); %Indicators
    set(handles.movText,'visible', 'off');
    drawnow;
    
l1 = 42;
l2 = 105;
l3 = 105;
l4 = 110;
 
L(1) = Link('revolute', 'alpha',0,'a',0          ,...
            'd',              0,'offset',     0,'modified');        
L(2) = Link('revolute', 'alpha', pi/2,'a',0          ,...
            'd',              0,'offset',     pi/2,'modified');
L(3) = Link('revolute', 'alpha', 0,'a',l2          ,...
            'd',              0,'offset',     0,'modified');
L(4) = Link('revolute', 'alpha', 0,'a',l3          ,...
            'd',              0,'offset',     0,'modified');
        
        
PX= SerialLink(L,'name','PhantomX');
PX.tool = [0 0 1 l4; 1 0 0 0; 0 1 0 0; 0 0 0 1];


Pap = transl(200, 200, 250)*troty(pi);
Pre = transl(200, 200, 30)*troty(pi);
Pel = transl(200, 200, 250)*troty(pi);
Pde = transl(-200, 150, 250)*troty(pi);
Pen = transl(-200, 150, 50)*troty(pi);

% PH = transl(PH);
% Pap = transl(Pap);
% Pre = transl(Pre);
% Pel = transl(Pel);
% Pde = transl(Pde);
% Pen = transl(Pen);

%q0 = PX.ikunc(PH);
q1 = PX.ikunc(Pap);
q2 = PX.ikunc(Pre);
q3 = PX.ikunc(Pel);
q4 = PX.ikunc(Pde);
q5 = PX.ikunc(Pen);

%tray0 = jtraj (q0, q1, 20);
tray1 = jtraj (q1, q2, 20);
tray2 = jtraj (q2, q3, 20);
tray3 = jtraj (q3, q4, 20);
tray4 = jtraj (q4, q5, 20);

PH =transl(0, 0, 250)*troty(pi);
q0 = PX.ikunc(PH);
for i=1:1:4
     if i == 1
                pub = '/phantom_sim/joint1_position_controller/command';
            elseif i == 2
                pub = '/phantom_sim/joint2_position_controller/command';
            elseif i == 3
                pub = '/phantom_sim/joint3_position_controller/command';
            elseif i == 4
                pub = '/phantom_sim/joint4_position_controller/command';
            elseif i == 5
                pub = '/phantom_sim/joint5_position_controller/command';
     end

     chatpub = rospublisher(pub,'std_msgs/Float64');
     msg = rosmessage(chatpub);

     msg.Data = q0(i);
     send(chatpub,msg);
     pause(0.2);
     
     
end

msgPose = rostopic("echo","/gazebo/link_states");
PoseLink4 = msgPose.Pose(6);
PositionLink4 =  PoseLink4.Position;
OrientationLink4 = PoseLink4.Orientation;
cuad = [OrientationLink4.X, OrientationLink4.Y, OrientationLink4.Z, OrientationLink4.W];
    [yaw, pitch, roll] = quat2angle(cuad);

    handles.X.String = num2str(PositionLink4.X);
    handles.Y.String = num2str(PositionLink4.Y);
    handles.Z.String = num2str(PositionLink4.Z);
    handles.Roll.String = num2str(roll);
    handles.Pitch.String = num2str(pitch);
    handles.Yaw.String = num2str(yaw);



% Hint: get(hObject,'Value') returns toggle state of Inicio



function q1_Callback(hObject, eventdata, handles)
% hObject    handle to q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q1 as text
%        str2double(get(hObject,'String')) returns contents of q1 as a double


% --- Executes during object creation, after setting all properties.
function q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q2_Callback(hObject, eventdata, handles)
% hObject    handle to q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q2 as text
%        str2double(get(hObject,'String')) returns contents of q2 as a double


% --- Executes during object creation, after setting all properties.
function q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q3_Callback(hObject, eventdata, handles)
% hObject    handle to q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q3 as text
%        str2double(get(hObject,'String')) returns contents of q3 as a double


% --- Executes during object creation, after setting all properties.
function q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q4_Callback(hObject, eventdata, handles)
% hObject    handle to q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q4 as text
%        str2double(get(hObject,'String')) returns contents of q4 as a double


% --- Executes during object creation, after setting all properties.
function q4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gripper_Callback(hObject, eventdata, handles)
% hObject    handle to gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gripper as text
%        str2double(get(hObject,'String')) returns contents of gripper as a double


% --- Executes during object creation, after setting all properties.
function gripper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X_Callback(hObject, eventdata, handles)
% hObject    handle to X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X as text
%        str2double(get(hObject,'String')) returns contents of X as a double


% --- Executes during object creation, after setting all properties.
function X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_Callback(hObject, eventdata, handles)
% hObject    handle to Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y as text
%        str2double(get(hObject,'String')) returns contents of Y as a double


% --- Executes during object creation, after setting all properties.
function Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z_Callback(hObject, eventdata, handles)
% hObject    handle to Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z as text
%        str2double(get(hObject,'String')) returns contents of Z as a double


% --- Executes during object creation, after setting all properties.
function Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Roll_Callback(hObject, eventdata, handles)
% hObject    handle to Roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Roll as text
%        str2double(get(hObject,'String')) returns contents of Roll as a double


% --- Executes during object creation, after setting all properties.
function Roll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pitch_Callback(hObject, eventdata, handles)
% hObject    handle to Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pitch as text
%        str2double(get(hObject,'String')) returns contents of Pitch as a double


% --- Executes during object creation, after setting all properties.
function Pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Yaw_Callback(hObject, eventdata, handles)
% hObject    handle to Yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Yaw as text
%        str2double(get(hObject,'String')) returns contents of Yaw as a double


% --- Executes during object creation, after setting all properties.
function Yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Manual.
function Manual_Callback(hObject, eventdata, handles)
% hObject    handle to Manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%joint1

chatpub1 = rospublisher('/phantom_sim/joint1_position_controller/command','std_msgs/Float64');
msg1S = rosmessage(chatpub1);

msg1S.Data = 0.0;
send(chatpub1,msg1S);

%
%joint2

chatpub2 = rospublisher('/phantom_sim/joint2_position_controller/command','std_msgs/Float64');
msg2S = rosmessage(chatpub2);

msg2S.Data = 0.0;
send(chatpub2,msg2S);



%
%joint3

chatpub3 = rospublisher('/phantom_sim/joint3_position_controller/command','std_msgs/Float64');
msg3S = rosmessage(chatpub3);

msg3S.Data = 0.0;
send(chatpub3,msg3S);

%
%joint4

chatpub4 = rospublisher('/phantom_sim/joint4_position_controller/command','std_msgs/Float64');
msg4S = rosmessage(chatpub4);

msg4S.Data = 0.0;
send(chatpub4,msg4S);


%
%joint5

chatpub5 = rospublisher('/phantom_sim/joint5_position_controller/command','std_msgs/Float64');
msg5S = rosmessage(chatpub5);

msg5S.Data = 0.0;
send(chatpub5,msg5S);

%

%joint6

chatpub6 = rospublisher('/phantom_sim/joint6_position_controller/command','std_msgs/Float64');
msg6S = rosmessage(chatpub6);

msg6S.Data = 0.0;
send(chatpub6,msg6S);


%
stop = false;

startTime = datetime('now');

step = 0.5;


while ~stop
    
    msgR = rostopic("echo","/joy");
    A = msgR.Buttons(1);
    B = msgR.Buttons(2);
    X = msgR.Buttons(3);
    Y = msgR.Buttons(4);
    LB = msgR.Buttons(5);
    RB = msgR.Buttons(6);
    CUA = msgR.Buttons(7);
    LIN = msgR.Buttons(8);
    
    UD = msgR.Axes(8);
    LR = msgR.Axes(7);
   

    %home
    if LR > 0
        
        msg1S.Data = 0.0;
        send(chatpub1,msg1S);
    
        msg2S.Data = 0.0;
        send(chatpub2,msg2S);
        
        msg3S.Data = 0.0;
        send(chatpub3,msg3S);
        
        msg4S.Data = 0.0;
        send(chatpub4,msg4S);
        
        msg5S.Data = 0.0;
        send(chatpub5,msg5S);
        
        msg6S.Data = 0.0;
        send(chatpub6,msg6S);
        
        
    end
    
    
    
    
    %link 1
    
    if A == B
    elseif A == 1
        msg1S.Data = msg1S.Data +step;
    else
        msg1S.Data = msg1S.Data -step;
    end    
     
    send(chatpub1,msg1S);
    
    
    
    
    %link 2
    
    if X == Y
    elseif X == 1
        msg2S.Data = msg2S.Data +step;
    else
        msg2S.Data = msg2S.Data -step;
    end    
     
    send(chatpub2,msg2S);
    
    
        
    
    
    %link 3
    
    if LB == RB
    elseif RB == 1
        msg3S.Data = msg3S.Data +step;
    else
        msg3S.Data = msg3S.Data -step;
    end    
     
    send(chatpub3,msg3S);
    
    
    %link 4
    
    if CUA == LIN
    elseif LIN == 1
        msg4S.Data = msg4S.Data +step;
    else
        msg4S.Data = msg4S.Data -step;
    end    
     
    send(chatpub4,msg4S);
    
    %
    %
    
    
    %link 5
    
    if UD == 1 && msg5S.Data <= 0.225
        msg5S.Data = msg5S.Data +step/4;
        
        if  msg5S.Data >= 0.225
            msg5S.Data = 0.225; 
        end 
        
    elseif UD == -1 && msg5S.Data >= 0
        msg5S.Data = msg5S.Data -step/4;
              
        if  msg5S.Data <= 0
            msg5S.Data = 0; 
        end 
        
    end   
    
    msg6S.Data = msg5S.Data; 
    
    send(chatpub6,msg6S);  
    send(chatpub5,msg5S);
    
    

    
     %link 6
    
%     if LR == 1
%         msg6S.Data = msg6S.Data +step;
%     elseif LR == -1
%         msg6S.Data = msg6S.Data -step;
%     end    
%      
%     send(chatpub6,msg6S);  
    
    
       
    
    
    % Se detiene
    stop = msgR.Buttons(9);
    
end


msgPose = rostopic("echo","/gazebo/link_states");
PoseLink4 = msgPose.Pose(6);
PositionLink4 =  PoseLink4.Position;
OrientationLink4 = PoseLink4.Orientation;
cuad = [OrientationLink4.X, OrientationLink4.Y, OrientationLink4.Z, OrientationLink4.W];
    [yaw, pitch, roll] = quat2angle(cuad);

    handles.X.String = num2str(PositionLink4.X);
    handles.Y.String = num2str(PositionLink4.Y);
    handles.Z.String = num2str(PositionLink4.Z);
    handles.Roll.String = num2str(roll);
    handles.Pitch.String = num2str(pitch);
    handles.Yaw.String = num2str(yaw);



% Hint: get(hObject,'Value') returns toggle state of Manual


% --- Executes on button press in Auto.
function Auto_Callback(hObject, eventdata, handles)
% hObject    handle to Auto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

l1 = 42;
l2 = 105;
l3 = 105;
l4 = 110;
 
L(1) = Link('revolute', 'alpha',0,'a',0          ,...
            'd',              0,'offset',     0,'modified');        
L(2) = Link('revolute', 'alpha', pi/2,'a',0          ,...
            'd',              0,'offset',     pi/2,'modified');
L(3) = Link('revolute', 'alpha', 0,'a',l2          ,...
            'd',              0,'offset',     0,'modified');
L(4) = Link('revolute', 'alpha', 0,'a',l3          ,...
            'd',              0,'offset',     0,'modified');
        
        
PX= SerialLink(L,'name','PhantomX');
PX.tool = [0 0 1 l4; 1 0 0 0; 0 1 0 0; 0 0 0 1];


Pentrada = [200, 200, 50];
Psalida1 = [200, 200, 50];
Psalida2 = [200, 200, 50];
Psalida3 = [200, 200, 50];

salida1 = trajectoria(PX, Pentrada,Psalida1);
salida2 = trajectoria(PX, Pentrada,Psalida2);
salida3 = trajectoria(PX, Pentrada,Psalida3);

i=5
handles.q1.String = num2str(salida1(1,1));
handles.q2.String = num2str(salida1(1,2));
handles.q3.String = num2str(salida1(1,3));
handles.q3.String = num2str(salida1(1,4));

set(handles.waitText,'visible', 'off');
    set(handles.movText,'visible', 'on');
    drawnow;

PH =transl(0, 0, 250)*troty(pi);
q0 = PX.ikunc(PH);
for i=1:1:4
     if i == 1
                pub = '/phantom_sim/joint1_position_controller/command';
            elseif i == 2
                pub = '/phantom_sim/joint2_position_controller/command';
            elseif i == 3
                pub = '/phantom_sim/joint3_position_controller/command';
            elseif i == 4
                pub = '/phantom_sim/joint4_position_controller/command';
            elseif i == 5
                pub = '/phantom_sim/joint5_position_controller/command';
     end

     chatpub = rospublisher(pub,'std_msgs/Float64');
     msg = rosmessage(chatpub);

     msg.Data = q0(i);
     send(chatpub,msg);
     pause(0.2);
     
     
end
    handles.q1.String = num2str(q0(1));
    handles.q2.String = num2str(q0(2));
    handles.q3.String = num2str(q0(3));
    handles.q3.String = num2str(q0(4));

for n=1:1:80
    for i=1:1:4
        %[chatpub,msg]=enviar(rec(n,i),i);
        %send(chatpub,msg);
        junta=i;
          if junta == 1
                pub = '/phantom_sim/joint1_position_controller/command';
            elseif junta == 2
                pub = '/phantom_sim/joint2_position_controller/command';
            elseif junta == 3
                pub = '/phantom_sim/joint3_position_controller/command';
            elseif junta == 4
                pub = '/phantom_sim/joint4_position_controller/command';
            elseif junta == 5
                pub = '/phantom_sim/joint5_position_controller/command';
         end

        chatpub = rospublisher(pub,'std_msgs/Float64');
        msg = rosmessage(chatpub);

        msg.Data = salida1(n,i);
        send(chatpub,msg);
    end
    if n == 20
        chatpub = rospublisher('/phantom_sim/joint5_position_controller/command','std_msgs/Float64');
        msg = rosmessage(chatpub);

        msg.Data = 0.255;
        send(chatpub,msg);
    elseif n==80
        chatpub = rospublisher('/phantom_sim/joint5_position_controller/command','std_msgs/Float64');
        msg = rosmessage(chatpub);

        msg.Data = 0;
        send(chatpub,msg);
    end
    pause(0.2);
    
     msgPose = rostopic("echo","/gazebo/link_states");
    PoseLink4 = msgPose.Pose(6);
    PositionLink4 =  PoseLink4.Position;
    OrientationLink4 = PoseLink4.Orientation;
    cuad = [OrientationLink4.X, OrientationLink4.Y, OrientationLink4.Z, OrientationLink4.W];
    [yaw, pitch, roll] = quat2angle(cuad);
    
    handles.X.String = num2str(PositionLink4.X);
    handles.Y.String = num2str(PositionLink4.Y);
    handles.Z.String = num2str(PositionLink4.Z);
    handles.Roll.String = num2str(roll);
    handles.Pitch.String = num2str(pitch);
    handles.Yaw.String = num2str(yaw);

end
    set(handles.waitText,'visible', 'on');
    set(handles.movText,'visible', 'off');
    drawnow;
av="ya corri"

% Hint: get(hObject,'Value') returns toggle state of Auto


% --- Executes on selection change in Salida.
function Salida_Callback(hObject, eventdata, handles)
% hObject    handle to Salida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Salida contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Salida
    l1 = 42;
    l2 = 105;
    l3 = 105;
    l4 = 110;

    L(1) = Link('revolute', 'alpha',0,'a',0          ,...
                'd',              0,'offset',     0,'modified');        
    L(2) = Link('revolute', 'alpha', pi/2,'a',0          ,...
                'd',              0,'offset',     pi/2,'modified');
    L(3) = Link('revolute', 'alpha', 0,'a',l2          ,...
                'd',              0,'offset',     0,'modified');
    L(4) = Link('revolute', 'alpha', 0,'a',l3          ,...
                'd',              0,'offset',     0,'modified');
        
        
PX= SerialLink(L,'name','PhantomX');
PX.tool = [0 0 1 l4; 1 0 0 0; 0 1 0 0; 0 0 0 1];

    contents = cellstr(get(hObject,'String'));
    opc = contents{get(hObject,'Value')};
    
    
    Pentrada = [200, 200, 50];
    Psalida1 = [200, 200, 50];
    Psalida2 = [200, -200, 50];
    Psalida3 = [150, 150, 50];

    salida1 = trajectoria(PX, Pentrada,Psalida1);
    salida2 = trajectoria(PX, Pentrada,Psalida2);
    salida3 = trajectoria(PX, Pentrada,Psalida3);
    
    if opc == "Punto 1"
        rec = salida1;
    elseif opc == "Punto 2"
        rec = salida2;
    elseif opc == "Punto 3"
        rec = salida3;
    end
    
    set(handles.waitText,'visible', 'off');
    set(handles.movText,'visible', 'on');
    drawnow;
    PH =transl(0, 0, 250)*troty(pi);
    q0 = PX.ikunc(PH);
    
for i=1:1:4
     if i == 1
                pub = '/phantom_sim/joint1_position_controller/command';
            elseif i == 2
                pub = '/phantom_sim/joint2_position_controller/command';
            elseif i == 3
                pub = '/phantom_sim/joint3_position_controller/command';
            elseif i == 4
                pub = '/phantom_sim/joint4_position_controller/command';
            elseif i == 5
                pub = '/phantom_sim/joint5_position_controller/command';
     end

     chatpub = rospublisher(pub,'std_msgs/Float64');
     msg = rosmessage(chatpub);

     msg.Data = q0(i);
     send(chatpub,msg);
     pause(0.2);
end
  
    
for n=1:1:80
    for i=1:1:4
        %[chatpub,msg]=enviar(rec(n,i),i);
        %send(chatpub,msg);
        junta=i;
          if junta == 1
                pub = '/phantom_sim/joint1_position_controller/command';
            elseif junta == 2
                pub = '/phantom_sim/joint2_position_controller/command';
            elseif junta == 3
                pub = '/phantom_sim/joint3_position_controller/command';
            elseif junta == 4
                pub = '/phantom_sim/joint4_position_controller/command';
            elseif junta == 5
                pub = '/phantom_sim/joint5_position_controller/command';
         end

        chatpub = rospublisher(pub,'std_msgs/Float64');
        msg = rosmessage(chatpub);

        msg.Data = rec(n,i);
        send(chatpub,msg);
    end
    if n == 20
        chatpub = rospublisher('/phantom_sim/joint5_position_controller/command','std_msgs/Float64');
        msg = rosmessage(chatpub);

        msg.Data = 0.255;
        send(chatpub,msg);
    elseif n==80
        chatpub = rospublisher('/phantom_sim/joint5_position_controller/command','std_msgs/Float64');
        msg = rosmessage(chatpub);

        msg.Data = 0;
        send(chatpub,msg);
    end
    
    handles.q1.String = num2str(rec(n,1));
    handles.q2.String = num2str(rec(n,2));
    handles.q3.String = num2str(rec(n,3));
    handles.q4.String = num2str(rec(n,4));
    pause(0.2)
     
    msgPose = rostopic("echo","/gazebo/link_states");
    PoseLink4 = msgPose.Pose(6);
    PositionLink4 =  PoseLink4.Position;
    OrientationLink4 = PoseLink4.Orientation;
    cuad = [OrientationLink4.X, OrientationLink4.Y, OrientationLink4.Z, OrientationLink4.W]
    [yaw, pitch, roll] = quat2angle(cuad);
    
    handles.X.String = num2str(PositionLink4.X);
    handles.Y.String = num2str(PositionLink4.Y);
    handles.Z.String = num2str(PositionLink4.Z);
    handles.Roll.String = num2str(roll);
    handles.Pitch.String = num2str(pitch);
    handles.Yaw.String = num2str(yaw);

    
end
    set(handles.waitText,'visible', 'on');
    set(handles.movText,'visible', 'off');
    drawnow;

av="acabamos"
    
    
    

% --- Executes during object creation, after setting all properties.
function Salida_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Salida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
