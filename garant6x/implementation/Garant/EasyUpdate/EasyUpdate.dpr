program EasyUpdate;

uses
 Forms
 , SysUtils
 //
 , EasyUpdateForm in 'forms\EasyUpdateForm.pas' {EasyUpdateForm}
 //
 , EasyUpdateAdminForm in 'forms\EasyUpdateAdminForm.pas' {EasyUpdateAdminForm}
 , EasyUpdateMailForm in 'forms\EasyUpdateMailForm.pas' {EasyUpdateMailForm}
 , EasyUpdateParamsForm in 'forms\EasyUpdateParamsForm.pas' {EasyUpdateParamsForm}
 //
 , EasyUpdateSupport
 //
 , LocaleMessages in 'i18n\LocaleMessages.pas'
 , JwaWinBase in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas'
 , JwaNtStatus in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas'
 , JwaWinNT in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas'
 , JwaWinType in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
 ;

{$R *.res}

begin
 SetCurrentLocale(TEasyUpdateSupport.Instance.Locale);
 //
 Application.Initialize;
 Application.Title := '√¿–¿Õ“'; // fake title (not used)
 //
 with TEasyUpdateSupport do
 begin
  SetApplicationTitle(GetCurrentLocaleMessage(c_ApplicationTitle));
  SetApplicationHelpFile(ChangeFileExt(ExtractFileName(ParamStr(0)), '.chm'));
  //
  RestoreJobFile;
  //
  if (IsSystemCompatible and IsDownloadTuned) then
  begin
   Application.CreateForm(TEasyUpdateForm, g_EasyUpdateForm);
   //
   Application.CreateForm(TEasyUpdateAdminForm, g_EasyUpdateAdminForm);
   Application.CreateForm(TEasyUpdateMailForm, g_EasyUpdateMailForm);
   Application.CreateForm(TEasyUpdateParamsForm, g_EasyUpdateParamsForm);
   //
   Application.Run;
  end;
 end;
end.
