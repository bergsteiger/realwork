program PipeOut2;

uses
  Forms,
  evdSchema,
  PipeOutMainForm in 'PipeOutMainForm.pas' {PipeOutForm},

  JwaWinBase in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'W:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
  ;

{$R *.RES}
{$R versioninfo.res} // включаем Version Info

begin
  Application.Initialize;
  Application.Title := '"Архивариус". Утилита экспорта';
  Application.CreateForm(TPipeOutForm, PipeOutForm);
  Application.Run;
end.
