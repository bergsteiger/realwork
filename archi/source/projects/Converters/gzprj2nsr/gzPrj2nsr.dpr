program gzPrj2nsr;

uses
  Forms,
  gzNSRForm in 'gzNSRForm.pas' {ConverterForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TConverterForm, ConverterForm);
  Application.Run;
end.
