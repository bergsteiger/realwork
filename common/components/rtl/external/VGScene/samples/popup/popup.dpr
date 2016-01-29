program popup;

uses
  Forms,
  popupfrm in 'popupfrm.pas' {frmPopup};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPopup, frmPopup);
  Application.Run;
end.
