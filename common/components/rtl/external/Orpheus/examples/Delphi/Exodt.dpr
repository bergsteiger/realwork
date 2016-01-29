program ExOdt;

uses
  Forms,
  exodtu in 'exodtu.pas' {frmOwnerDrawTabs};

{$R *.RES}

begin
  Application.CreateForm(TfrmOwnerDrawTabs, frmOwnerDrawTabs);
  Application.Run;
end.
