unit alcuShowMessage;

interface

uses
 Dialogs;

procedure alcuShowMsg(const Msg: string);

implementation

procedure alcuShowMsg(const Msg: string);
begin
 ShowMessage(Msg);
end;

end.
