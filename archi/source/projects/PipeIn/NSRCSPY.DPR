program nsrcspy;

{$I projectdefine.inc}

uses
  Forms,
  evdSchema,
  MainForm in 'MainForm.pas' {SpyForm},
  
  JwaWinBase in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'W:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
  ;

{$R *.RES}
{$R versioninfo.res} // включаем Version Info

begin
  {$IFDEF OneInit}
  GlobalInit;
  {$ENDIF}
  Application.Title := '"Архивариус". Утилита импорта';
  Application.CreateForm(TSpyForm, SpyForm);
  Application.Run;
end.
