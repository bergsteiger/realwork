{*******************************************************}
{                                                       }
{               Web Application Debugger                }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

program webappdbg;

uses
  Vcl.Forms,
  System.SysUtils,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  SvrMainForm in 'SvrMainForm.pas' {WebAppDbgMainForm},
  SvrPropDlg in 'SvrPropDlg.pas' {DlgProperties},
  SockAppReg,
  SvrLog in 'SvrLog.pas',
  SvrLogFrame in 'SvrLogFrame.pas' {LogFrame: TFrame},
  SvrLogDetailDlg in 'SvrLogDetailDlg.pas' {LogDetail},
  SvrLogDetailFrame in 'SvrLogDetailFrame.pas' {LogDetailFrame: TFrame},
  SvrLogColSettingsFrame in 'SvrLogColSettingsFrame.pas' {LogColSettingsFrame: TFrame},
  SvrStatsFrame in 'SvrStatsFrame.pas' {StatsFrame: TFrame},
  HTTPParse in 'HTTPParse.pas',
  SvrConst in 'SvrConst.pas',
  WebAppDbgAbout in 'WebAppDbgAbout.pas' {AboutBox},
  SockRequestInterpreter,
  SvrSockRequest in 'SvrSockRequest.pas',
  SvrHTTPIndy in 'SvrHTTPIndy.pas';

{$R *.res}

{$IFDEF MSWINDOWS}
var
  Mutex: THandle;
  PrevWnd: THandle;
begin
  Mutex := CreateMutex(nil, False, 'LaunchWebSnapSvrMutex'); { Do not localize }
  try
    if WaitForSingleObject(Mutex, 10000) = WAIT_TIMEOUT then
      Exit;
    PrevWnd := FindWindow(PChar(string(TWebAppDbgMainForm.ClassName)), nil);
    if IsWindow(PrevWnd) then
    begin
      if PrevWnd <> 0 then
      begin
        SetForeGroundWindow(PrevWnd);
        if IsIconic(PrevWnd) then
          ShowWindow(PrevWnd, SW_SHOWNORMAL);
        exit;
      end;
    end;
    Application.Initialize;
    Application.CreateForm(TWebAppDbgMainForm, WebAppDbgMainForm);
  finally
    ReleaseMutex(Mutex);
    CloseHandle(Mutex);
  end;
{$ENDIF}
{$IFDEF LINUX}
begin
  Application.Initialize;
  Application.CreateForm(TWebAppDbgMainForm, WebAppDbgMainForm);
{$ENDIF}
  Application.Run;
end.
