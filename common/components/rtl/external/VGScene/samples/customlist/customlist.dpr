program customlist;

uses
  Forms,
  customlistfrm in 'customlistfrm.pas' {frmCustomList};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCustomList, frmCustomList);
  Application.Run;
end.
