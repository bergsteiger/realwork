program KPageTest2;

uses
  Forms,
  KPagetTest2 in 'KPagetTest2.pas' {Form1},
  Contents in 'Contents.pas',
  Contents_int in 'Contents_int.pas',
  GenerationContents in 'GenerationContents.pas',
  GenerationContents_int in 'GenerationContents_int.pas',
  RootSrv in 'RootSrv.pas',
  RootSrv_int in 'RootSrv_int.pas',
  SecuritySrv in 'SecuritySrv.pas',
  SecuritySrv_int in 'SecuritySrv_int.pas',
  SecuritySrvComm in 'SecuritySrvComm.pas',
  SecuritySrvComm_int in 'SecuritySrvComm_int.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
