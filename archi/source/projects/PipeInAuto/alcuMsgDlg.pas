unit alcuMsgDlg;

interface

uses
 Dialogs;

function alcuMsgDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

implementation

function alcuMsgDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  Result := MessageDlg(Msg, DlgType, Buttons, HelpCtx);
end;

end.
