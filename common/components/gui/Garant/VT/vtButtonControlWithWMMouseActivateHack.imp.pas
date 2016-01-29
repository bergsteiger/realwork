
{$IfNDef vtButtonControlWithWMMouseActivateHackImpl}

  {$Define vtButtonControlWithWMMouseActivateHackImpl}
 _vtButtonControlWithWMMouseActivateHack_ = class(_vtButtonControlWithWMMouseActivateHack_Parent_)
 private
  procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
  procedure WMLButtonDown(var Msg : TMessage); message WM_LBUTTONDOWN;
 protected
  procedure DoClick; virtual; abstract;
  function CanFocus: Boolean; override;
  procedure WndProc(var Message: TMessage); override;
 end;

{$Else vtButtonControlWithWMMouseActivateHackImpl}


{ _UnicodeButtonControl_ }

procedure _vtButtonControlWithWMMouseActivateHack_.WMMouseActivate(var Message: TMessage);
 {message WM_MOUSEACTIVATE;}
begin
 if not (csDesigning in ComponentState) then
  Message.Result := MA_NOACTIVATE
 else
  inherited;
end;

procedure _vtButtonControlWithWMMouseActivateHack_.WMLButtonDown(var Msg : TMessage);
 {message WM_LBUTTONDOWN;}
begin
 if not (csDesigning in ComponentState) then
  //Checked := not Checked
  DoClick
 else
  inherited;
end;

function _vtButtonControlWithWMMouseActivateHack_.CanFocus: Boolean;
 {override;}
begin
 if not (csDesigning in ComponentState) then
  Result := false
 else
  Result := inherited CanFocus;
end;

procedure _vtButtonControlWithWMMouseActivateHack_.WndProc(var Message: TMessage);
 {override;}
begin
 case Message.Msg of
   {WM_LBUTTONDOWN, }WM_LBUTTONDBLCLK:
     if not (csDesigning in ComponentState) then
     begin
      //Checked := not Checked;
      DoClick;
      Exit;
     end;//not (csDesigning in ComponentState)
 end;//case Message.Msg
 inherited;
end;

{$EndIf vtButtonControlWithWMMouseActivateHackImpl}
