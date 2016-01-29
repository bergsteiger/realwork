program gzPrj;

uses
  Forms,
  gzForm in 'gzForm.pas' {ConverterForm};

{$R *.res}
{$R versioninfo.res} // включаем Version Info

begin
  Application.Initialize;
  Application.CreateForm(TConverterForm, ConverterForm);
  Application.Run;
end.
