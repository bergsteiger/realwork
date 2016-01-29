program Everest;

uses
  evWriterToPrinter,
  Forms,
  stdRes in 'stdRes.pas' {dmStdRes: TDataModule},
  Main in 'Main.pas' {evpMain: TvcmMainForm},
  moDocument in 'Document\moDocument.pas' {evpDocument: TvcmModule},
  enText in 'Document\enText.pas' {evpText: TvcmEntityForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ёверест';
  Application.CreateForm(TdmStdRes, dmStdRes);
  Application.CreateForm(TevpMain, evpMain);
  Application.Run;
end.
