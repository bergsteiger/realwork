program Signature;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Password in 'Password.pas' {frmPassword};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmPassword, frmPassword);
  Application.Run;
end.
