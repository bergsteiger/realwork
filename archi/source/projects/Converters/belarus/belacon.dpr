program belacon;

uses
  Forms,
  bcMain in 'bcMain.pas' {MainForm},
  bcReader in 'bcReader.pas',
  DT_Err,
  HT_DLL,
  bcSettings in 'bcSettings.pas',
  bcLinksFilter in 'bcLinksFilter.pas',
  bcInterfaces in 'bcInterfaces.pas',
  bcAngleBracketsFilter in 'bcAngleBracketsFilter.pas',
  bcHTMLReader in 'bcHTMLReader.pas';

{$R *.res}

begin
  Application.Initialize;
  //HT(htGlobalInit(HInstance));
  try
   Application.CreateForm(TMainForm, MainForm);
  finally
   //htGlobalShut;
  end;
  Application.Run;
end.
