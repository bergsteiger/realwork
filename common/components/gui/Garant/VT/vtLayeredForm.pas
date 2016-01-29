unit vtLayeredForm;

{$I vtDefine.inc }

interface

Uses Windows, SysUtils, Dialogs, Forms, Classes, Controls,
  vtPanel
  ;

type
 TvtLayeredForm = class({$IfDef vtLayeredFormIsForm}TCustomForm{$Else}TvtPanel{$ENdIf})
 protected
  procedure {$IfDef vtLayeredFormIsForm}DoCreate;{$Else}CreateWnd;{$ENdIf} override;
  procedure CreateParams(var Params: TCreateParams); override;
 public
  constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0);
  {$IfDef vtLayeredFormIsForm}override;{$Else}virtual;{$EndIf}
 end;

const
 cTransparentColor = $FFFEFF;

implementation

constructor TvtLayeredForm.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
 {$IfDef vtLayeredFormIsForm}
 inherited CreateNew(AOwner);
 {$Else  vtLayeredFormIsForm}
 Create(aOwner);
 BorderStyle := bsNone;
 {$EndIf vtLayeredFormIsForm}
end;

procedure TvtLayeredForm.CreateParams(var Params: TCreateParams);
begin
 inherited;
 {$IfDef vtLayeredFormIsForm}
 Params.Style := Params.Style or WS_POPUP;
 {$EndIf vtLayeredFormIsForm}
end;

procedure TvtLayeredForm.{$IfDef vtLayeredFormIsForm}DoCreate{$Else}CreateWnd{$EndIf};
begin
 {$IfNDef vtLayeredFormIsForm}
 inherited;
 {$EndIf  vtLayeredFormIsForm}
 {$IfDef vtLayeredFormIsForm}
 BorderStyle := bsNone;
 {$EndIf vtLayeredFormIsForm}
 if SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED) = 0 then
  RaiseLastOSError;
  //ShowMessage(SysErrorMessage(GetLastError));
 if not SetLayeredWindowAttributes(Handle, cTransparentColor, 0, LWA_COLORKEY) then
  RaiseLastOSError;
  //ShowMessage(SysErrorMessage(GetLastError));
 {$IfDef vtLayeredFormIsForm}
 inherited;
 {$EndIf vtLayeredFormIsForm}
end;

end.
