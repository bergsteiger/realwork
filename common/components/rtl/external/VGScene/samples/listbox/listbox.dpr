program listbox;

uses
  Forms,
  listboxfrm in 'listboxfrm.pas' {frmListBoxDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmListBoxDemo, frmListBoxDemo);
  Application.Run;
end.
