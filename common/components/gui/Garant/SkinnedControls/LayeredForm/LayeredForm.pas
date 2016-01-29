unit LayeredForm;

interface
Uses Windows, SysUtils, Forms, Controls, Graphics, Classes, Dialogs;

type
 TLayeredForm = class(TCustomForm)
 protected
  procedure DoCreate; override;
  procedure CreateParams(var Params: TCreateParams); override;
 public
  constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
 end;

const
 cTransparentColor = $FFFEFF;

implementation

constructor TLayeredForm.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
 inherited CreateNew(AOwner);
end;

procedure TLayeredForm.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
 Params.Style := Params.Style or WS_POPUP;
end;

procedure TLayeredForm.DoCreate;
begin
 BorderStyle := bsNone;
 if SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED) = 0 then
  ShowMessage(SysErrorMessage(GetLastError));
 if not SetLayeredWindowAttributes(Handle, cTransparentColor, 0, LWA_COLORKEY) then
  ShowMessage(SysErrorMessage(GetLastError));  
 inherited ;
end;

end.
