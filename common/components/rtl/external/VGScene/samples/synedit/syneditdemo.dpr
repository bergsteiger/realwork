program syneditdemo;

uses
  Forms,
  syneditfrm in 'syneditfrm.pas' {frmSynEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSynEdit, frmSynEdit);
  Application.Run;
end.
