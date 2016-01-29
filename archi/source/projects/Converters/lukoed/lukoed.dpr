program lukoed;

uses
  Forms,
  evdSchema,
  mainform in 'mainform.pas' {SDFImportForm},
  lukSDFReader in 'lukSDFReader.pas',
  lukIDGenerator in 'lukIDGenerator.pas',
  lukTextBeautyfier in 'lukTextBeautyfier.pas',
  lukAutoBlockFilter in 'lukAutoBlockFilter.pas',
  lukDocumentFilter in 'lukDocumentFilter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Импорт документов ЛУКойл';
  Application.CreateForm(TSDFImportForm, SDFImportForm);
  Application.Run;
end.
