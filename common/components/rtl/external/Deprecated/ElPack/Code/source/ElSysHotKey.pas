{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

unit ElSysHotKey;

{ Application single instance monitor }

interface

uses
  Windows,
  Classes,
  SysUtils,
  Messages,
  ElTools,
  Menus,
{$ifdef VCL_6_USED}
  Types,
{$endif}
  ElBaseComp;

type

  TElSysHotKey = class(TElBaseComponent)
  protected
    fID      : word;
    FOnPress : TNotifyEvent;
    FShortcut: TShortcut;
    procedure TriggerPress; virtual;
    procedure DoSetEnabled(AEnabled : boolean); override;
    procedure WMHotKey(var Message: TMessage); message WM_HOTKEY;
    procedure SetShortcut(Value: TShortcut);
  public
    destructor Destroy; override;
    constructor Create(AOwner : TComponent); override;
  published
    property Enabled;
    property OnPress: TNotifyEvent read FOnPress write FOnPress;
    property Shortcut: TShortcut read FShortcut write SetShortcut;
  end; { TElOneInstance }

implementation

uses ElList;

var KeyIdList : TElList;

procedure TElSysHotKey.DoSetEnabled(AEnabled : boolean);
var i, aKey : word;
    aShift  : TShiftState;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if AEnabled then
    begin
      if FShortCut <> 0 then
      begin
        ShortcutToKey(FShortcut, aKey, aShift);
        i := 0;
        if ssAlt in aShift then
          i := i or MOD_ALT;
        if ssCtrl in aShift then
          i := i or MOD_CONTROL;
        if ssShift in aShift then
          i := i or MOD_SHIFT;
        RegisterHotKey(Handle, fID, i, aKey);
      end
      else
        Enabled := false;
    end
    else
      UnregisterHotKey(Handle, fID);
  end;
end;

destructor TElSysHotKey.Destroy;
begin
  Enabled := false;
  inherited;
end; { Destroy }

procedure TElSysHotKey.TriggerPress;
begin
  if assigned(FOnPress) then FOnPress(Self);
end;

procedure TElSysHotKey.WMHotKey(var Message: TMessage);
begin
  inherited;
  TriggerPress;
end;

procedure TElSysHotKey.SetShortcut(Value: TShortcut);
begin
  if FShortcut <> Value then
  begin
    FShortcut := Value;
    if Enabled then
    begin
      Enabled := false;
      if FShortcut <> 0 then
        Enabled := true;
    end;
  end;
end;

constructor TElSysHotKey.Create(AOwner : TComponent);
var i : integer;
begin
  inherited;
  repeat
    i := Random($BFFF);
    if KeyIDList.IndexOf(Pointer(i)) = -1 then
    begin
      KeyIDList.Add(Pointer(i));
      fID := i;
      break;
    end;
  until false;
end;

initialization
  KeyIdList := TElList.Create;

finalization
  KeyIdList.Free;

end.
