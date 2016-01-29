program SplashScreen;

uses
  Windows,
  Classes,
  SysUtils,
  Forms,
  l3ExceptionsLog,
  l3Base,
  SplashServerInterfaces,
  nsSplashInfo,
  enSplash in 'enSplash.pas' {en_SplashForm: TForm},
  JwaWinBase in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
  ;

{$E run}

{$R F1SplashScreen.res}
{$R main_icon2.res} // вторая иконка приложения

procedure SetTitle(const anApp: TApplication; aTitle: String);
begin
 anApp.Title := aTitle;
end;

var
 l_Info: InsSplashInfo;

begin
 l_Info := TnsSplashInfo.Make;
 try
  if l_Info.IsValid then
  begin
   with Application do
    if (Handle <> HWND(0)) then
     SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
       WS_EX_TOOLWINDOW);
   Application.Initialize;
   SetTitle(Application, l_Info.ApplicationTitle);
   Application.CreateForm(Ten_SplashForm, en_SplashForm);
   en_SplashForm.InitSplash(l_Info);
   Application.Run;
  end;
 finally
  l_Info := nil;
 end;
end.
