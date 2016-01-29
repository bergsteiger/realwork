program garant_miv;

uses
  Forms,
  MobileInternetVersionMenuForm_Unit in 'Forms\MobileInternetVersionMenuForm_Unit.pas' {MobileInternetVersionMenuForm},
  vtHoverButton,
  vtPngImgList,
  LocaleMessages in '..\launcher\i18n\LocaleMessages.pas',
  JwaWinBase in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas',
  mivLauncher_Unit;
{$R *.res}

begin
  Application.Initialize;
  Application.Title := '√¿–¿Õ“';
  Application.Run;
  TmivLauncher.Run;
end.
