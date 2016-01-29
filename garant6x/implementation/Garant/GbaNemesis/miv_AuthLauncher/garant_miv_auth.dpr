program garant_miv_auth;

uses
  Forms,
  MobileInternetVersionMenuForm_Unit in 'Forms\MobileInternetVersionMenuForm_Unit.pas' {MobileInternetVersionMenuForm},
  vtHoverButton,
  vtPngImgList,
  LocaleMessages in '..\launcher\i18n\LocaleMessages.pas',
  mivLauncher_Unit,
  mivUtils in 'mivUtils.pas',
  md5 in 'md5.pas',
  Classes,
  mivAuthSupport in 'mivAuthSupport.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.Title := '√¿–¿Õ“';
  Application.Run;
  TmivLauncher.Run;
end.
