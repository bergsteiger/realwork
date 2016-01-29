program vectorimage;

uses
  Forms,
  vectorimagefrm in 'vectorimagefrm.pas' {frmVectorImage};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmVectorImage, frmVectorImage);
  Application.Run;
end.
