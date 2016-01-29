program bbspy;

uses
  Forms,
  HT_Const,
  HT_DLL,
  bbsMain in 'bbsMain.pas' {MainForm};

{$R *.res}

procedure Intro; stdcall;
var
 sInit: INIT;
begin
 htGlobalInit(hInstance);
 FillChar(sInit, sizeof(sInit), #0);
 sInit.nTaskCnt := 10;
 sInit.nHtCnt := 20;
 sInit.gHeapCtrl := 200000;
 sInit.nTrsMode := TRS_OFF;
 htInit(@sInit, sizeof(sInit));
end;


procedure Extro; stdcall;
begin
 htShut;
 htGlobalShut;
end;

begin
 Application.Initialize;
 Intro;
 Application.CreateForm(TMainForm, MainForm);
 Application.Run;
 Extro;
end.
