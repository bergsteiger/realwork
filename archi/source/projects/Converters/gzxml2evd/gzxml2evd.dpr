program gzxml2evd;

uses
  Forms,
  evdSchema,
  xmlform in 'xmlform.pas' {ConverterForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TConverterForm, ConverterForm);
  Application.Run;
end.
