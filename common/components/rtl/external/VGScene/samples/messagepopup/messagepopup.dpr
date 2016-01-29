program messagepopup;

uses
  Forms,
  messagepopupfrm in 'messagepopupfrm.pas' {frmMessagePopup};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMessagePopup, frmMessagePopup);
  Application.Run;
end.
