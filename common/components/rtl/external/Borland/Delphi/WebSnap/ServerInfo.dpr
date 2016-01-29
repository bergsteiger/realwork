program serverinfo;

{$APPTYPE GUI}

uses
  QForms,
  SockApp,
  SvrInfoConsole in 'SvrInfoConsole.pas' {Form1},
  SvrInfoModule in 'SvrInfoModule.pas' {WebModule2: TWebModule},
  SvrInfoConst in 'SvrInfoConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
