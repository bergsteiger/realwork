program Balalayka;

uses
  Forms,
  evdSchema,
  mainform in 'mainform.pas' {PravosudForm},
  Format5Reader in 'Format5Reader.pas',
  Format5Const in 'Format5Const.pas',
  Format5HTMLReader in 'Format5HTMLReader.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Импорт документов Право-Суд';
  Application.CreateForm(TPravosudForm, PravosudForm);
  Application.Run;
end.
