program MosReader;

uses
  Forms,
  evdSchema,
  MOSReaderForm in 'MOSReaderForm.pas' {Form1},
  ddMOSReader in 'ddMOSReader.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
