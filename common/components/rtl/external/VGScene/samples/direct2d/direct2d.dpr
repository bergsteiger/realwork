program direct2d;

uses
  Forms,
  direct2dfrm in 'direct2dfrm.pas' {frmD2D};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmD2D, frmD2D);
  Application.Run;
end.
