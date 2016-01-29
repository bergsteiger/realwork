program souConverter;

uses
  Forms,
  souConverterForm in 'souConverterForm.pas' {souMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Простановка ссылок и КТ';
  Application.CreateForm(TsouMainForm, souMainForm);
  Application.Run;
end.
