program TextMistakeViewver;

uses
  Forms,
  evdSchema,
  MainForm in 'MainForm.pas' {fmMain},
  tmvInterfaces in 'tmvInterfaces.pas',
  tmvController in 'tmvController.pas',
  tmvRecord in 'tmvRecord.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.

