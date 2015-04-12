***Default Donotedit-Code for GUI.Detail code not included for this part***
function varargout = MAIN(varargin)
function MAIN_OpeningFcn(hObject, eventdata, handles, varargin)
function varargout = MAIN_OutputFcn(hObject, eventdata, handles)
function edit1_Callback(hObject, eventdata, handles)
function edit1_CreateFcn(hObject, eventdata, handles)
function edit2_Callback(hObject, eventdata, handles)
function edit2_CreateFcn(hObject, eventdata, handles)
function edit6_Callback(hObject, eventdata, handles)
function edit6_CreateFcn(hObject, eventdata, handles)
function edit9_Callback(hObject, eventdata, handles)
function edit9_CreateFcn(hObject, eventdata, handles)
function popupmenu1_Callback(hObject, eventdata, handles)
function popupmenu1_CreateFcn(hObject, eventdata, handles)

********************Code to get input from GUI**************************

#Height of the dielectric
 function HEIGHT_Callback(hObject, eventdata, handles)
handles.metricdata.ht=str2double(get(hObject,'String')) ;
guidata(hObject,handles)
 function HEIGHT_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end
#Frequency of Operation
 function Freq_Callback(hObject, eventdata, handles)
handles.metricdata.Freq=str2double(get(hObject,'String')) ;
guidata(hObject,handles)
 function Freq_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end
#Permitivity of the Dielectric
 function DIELECTRIC_Callback(hObject, eventdata, handles)
 function DIELECTRIC_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end
#Number of iteration
 function ITRTN_Callback(hObject, eventdata, handles)
handles.metricdata.ITERATION=str2double(get(hObject,'String')) ;
guidata(hObject,handles)
 function ITRTN_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end
#Number of swarms
 function SWARM_Callback(hObject, eventdata, handles)
handles.metricdata.SWRM=str2double(get(hObject,'String')) ;
guidata(hObject,handles)
 function SWARM_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

*****************************MAIN Function****************************
 function START_Callback(hObject, eventdata, handles)
freq=handles.metricdata.Freq;
h=handles.metricdata.ht;
e=get(handles.DIELECTRIC, 'Value');
switch e
case 1
er=2.4;
case 2
er=2.7;
case 3
er=3;
case 4
er=3.5;
case 5
er=4.2;
case 6
er=7;
end
fre=freq;
c=3*10^11;
freq=freq*10^9;
lamda= c/freq;
k=(2*3.14)/lamda;
#defining the upper and lower limits of the design parameters
wmax=lamda/2;
wmin=lamda/3;
#maximum and minimum value of width of the patch
erefflmx=((er+1.0)/2.0) + (er-1)/(2*sqrt(1.0+12.0*(h/wmax)));
dllmx=(0.412*h*((erefflmx+0.3)*((wmax/h)+0.264)))/((erefflmx-0.258)*((wmax/h)+0.8));
lmin=(lamda/(2*sqrt(erefflmx)))- (2*dllmx);
erefflm=((er+1.0)/2.0) + (er-1)/(2*sqrt(1.0+12.0*(h/wmin)));
dllm=(0.412*h*((erefflm+0.3)*((wmin/h)+0.264)))/((erefflm-0.258)*((wmin/h)+0.8));
lmax=(lamda/(2*sqrt(erefflm)))- (2*dllm);
#maximum and minimum value of length of the patch
gmx=(wmax*( 1- (((k*h)^2))/24))/(120*lamda);
rinmx=1/(2*gmx);
fmax=(acos(sqrt(50/rinmx))*lmax)/3.14;
gmn=(wmin*( 1- (((k*h)^2))/24))/(120*lamda);
rinmn=1/(2*gmn);
fmin=(acos(sqrt(50/rinmn))*lmin)/3.14;
#maximum and minimum value of the feed position
n=handles.metricdata.ITERATION;
s=handles.metricdata.SWRM;
#n is the number of iterations and s equals number of swarms
l=ones(1,s);
w=ones(1,s);
fp=ones(1,s);
#Creating Swarms
d=rand(1,s);
u=rand(1,s);
o=rand(1,s);
csvwrite('C:\RAND1.txt',d);
csvwrite('C:\RAND2.txt',u);
csvwrite('C:\RAND3.txt',o);
for i=1:s
l(i)= lmin + (lmax-lmin)*d(i);
w(i)= wmin + (wmax-wmin)*u(i);
fp(i)=fmin + (fmax-fmin)*o(i);
end
#Initial random distribution of swarms
z=ones(1,s);
u=ones(1,n);
q=ones(1,n);
k=1;
for j=1:n
for i=1:s
z(i)=diffcalc(l(i),w(i),fp(i),h,fre); #function diffcalc defined later
end
u(j)=min(z);
[a,b]=min(z);
q(j)=(sum(z)/s)+50;
A=w(b);
B=fp(b);
C=l(b);
if j < (n)
for i=1:s
w(i) = w(i) + 2*rand(1)*(A-w(i));
fp(i)= fp(i) + 2*rand(1)*(B-fp(i));
l(i)=l(i) + 2*rand(1)*(C-l(i));
end
#velocity function
for i=1:s
if w(i)>wmax
w(i)=wmax-rand(1);
end
if w(i)<wmin
w(i)=wmin+rand(1);
end
35
if fp(i)>fmax
fp(i)=fmax-rand(1);
end
if fp(i)<fmin
fp(i)=fmin+rand(1);
end
if l(i)<lmin
l(i)=lmin+rand(1);
end
if l(i)>lmax
l(i)=lmax-rand(1);
end
end
end
#Rebounce Functions
axes(handles.axes1);
cla;
plot3(l,w,fp,'*');
xlim([lmin,lmax]);
ylim([wmin,wmax]);
zlim([fmin,fmax]);
grid on;
pause(1);
#3D plot
end
axes(handles.axes3);
cla;
r=1:1:n;
plot(r,u,'--rs','LineWidth',2,...
'MarkerEdgeColor','k',...
'MarkerFaceColor','g',...
'MarkerSize',3)
xlabel('Iteration Number');
ylabel('Fitness Function ');
grid on;
#2D plot of fitness function vs Iteration
axes(handles.axes5);
cla;
r=1:1:n;
plot(r,q,'--rs','LineWidth',2,...
'MarkerEdgeColor','k',...
'MarkerFaceColor','g',...
'MarkerSize',3)
36
xlabel('Iteration Number');
ylabel('Average Impedance ');
grid on;
#2D plot of average impedance vs Iteration
set(handles.LR,'String',l(b));
set(handles.WR,'String',w(b));
set(handles.FR,'String',fp(b));
#Display of the result
zx=[ l(b) w(b) fp(b)];
csvwrite('C:\z.txt',zx);
#Storing of the data
******Additional function for GUI.Detail program not included.*******
 function LOADDESIGN_Callback(hobject,eventdata,handles)
 function SAVEDATA_Callback(hObject, eventdata, handles)
 function CHECKINPUT_Callback(hObject, eventdata, handles)
 function pushbutton9_Callback(hObject, eventdata, handles)
