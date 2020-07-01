function tray = trajectoria(PX, Pe, Ps)

PH =transl(0, 0, 250)*troty(pi);
Pap = transl(Pe(1), Pe(2), 250)*troty(pi);
Pre = transl(Pe(1), Pe(2), Pe(3))*troty(pi);
Pel =transl(Pe(1), Pe(2), 250)*troty(pi);
Pde = transl(Ps(1), Ps(2), 250)*troty(pi);
Pen = transl(Ps(1), Ps(2), Ps(3))*troty(pi);


q0 = PX.ikunc(PH);
q1 = PX.ikunc(Pap);
q2 = PX.ikunc(Pre);
q3 = PX.ikunc(Pel);
q4 = PX.ikunc(Pde);
q5 = PX.ikunc(Pen);

tray0 = jtraj (q0, q1, 20);
tray1 = jtraj (q1, q2, 20);
tray2 = jtraj (q2, q3, 20);
tray3 = jtraj (q3, q4, 20);
tray4 = jtraj (q4, q5, 20);

tray = [tray0; tray1; tray2; tray3; tray4];
end