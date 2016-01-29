(************************************************************
Author: Deepak Shenoy
        shenoy@agnisoft.com
Copyright (C) 2000 Agni Software Pvt. Ltd.
All Rights Reserved.
http://www.agnisoft.com
********************************************************)
program comptest;

uses
  Forms,
  testingform in 'testingform.pas' {Form1},
  AgOpenDialog in 'AgOpenDialog.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
