program framedemo;

uses
  Forms,
  framefrm in 'framefrm.pas' {frmMain},
  secondfrm in 'secondfrm.pas' {frmChild};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmChild, frmChild);
  Application.Run;
end.
