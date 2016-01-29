program FlashViewer;

uses
  Forms,
  MainForm in 'MainForm.pas' {fmMain}
  ,
  JwaWinBase in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
  ;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
