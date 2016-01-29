{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

(*

Version History

05/27/2001 (c) Akzhan Abdulin

    This component fixes Color property design-time storing issue
    of its ancestor, TLabel (clWindow not stored)

*)
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
unit ElCLabel;

interface

uses
  Classes,
  ElVCLUtils,
  ElUxTheme,
  ElTmSchema,
  ElStrUtils,
{$ifdef ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$ENDIF}
  Forms,
  Controls,
  Messages,
  Windows,
  StdCtrls;

type
  TCustomElLabel = class(TCustomLabel)
  protected
    FUseXPThemes: Boolean;
    {$ifdef ELPACK_UNICODE}
    FHint: TElFString;
    {$endif}
    FCaption: TElFString;

    {$IFDEF ELPACK_USE_STYLEMANAGER}
    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FEndEllipsis: Boolean;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure StyleMgrChange(Sender : TObject);
    procedure UpdateStyle;
    {$endif}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetUseXPThemes(Value: Boolean);

    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;

    {$ifdef ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);

    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$endif}
    procedure Loaded; override;
    procedure SetCaption(Value: TElFString);
    {$IFDEF ELPACK_USE_STYLEMANAGER}
    procedure SetEndEllipsis(Value: Boolean);
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default false;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    {$ifdef ELPACK_USE_STYLEMANAGER}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    {$endif}
    property UseXPThemes: Boolean read FUseXPThemes write SetUseXPThemes default
        true;
    {$ifdef ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
    {$endif}
    property Caption: TElFString read FCaption write SetCaption;

    property Color nodefault;
    property Transparent default true;
  end;

implementation

{ TElCustomLabel }

procedure TCustomElLabel.Loaded;
begin
  inherited;
  if ParentColor then
  begin
    ParentColor := False;
    ParentColor := True;
  end;
end;

constructor TCustomElLabel.Create(AOwner: TComponent);
begin
  inherited;
  Transparent := true;
  FUseXPThemes := true;
{$IFDEF ELPACK_USE_STYLEMANAGER}
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
{$ENDIF}
end;

destructor TCustomElLabel.Destroy;
begin
{$ifdef ELPACK_USE_STYLEMANAGER}
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
{$ENDIF}
  inherited;
end;

procedure TCustomElLabel.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
{$ifdef ELPACK_USE_STYLEMANAGER}
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
{$ENDIF}
end; { Notification }

{$ifdef ELPACK_USE_STYLEMANAGER}
procedure TCustomElLabel.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    {$ifdef VCL_5_USED}
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    {$endif}
    if FStyleManager <> nil then
       FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TCustomElLabel.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TCustomElLabel.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TCustomElLabel.UpdateStyle;
begin
  if FStyleManager <> nil then
  begin
    if (Parent <> nil) and Parent.HandleAllocated then
      SendMessage(Parent.Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if (Parent <> nil) and Parent.HandleAllocated then
    begin
      SendMessage(Parent.Handle, WM_SETREDRAW, 1, 0);
      Invalidate;
    end;
  end;
end;
{$endif}

procedure TCustomElLabel.SetUseXPThemes(Value: Boolean);
begin
  if FUseXPThemes <> Value then
  begin
    FUseXPThemes := Value;
    if ThemesAvailable then Invalidate;
  end;
end;

procedure TCustomElLabel.CMTextChanged(var Message: TMessage);
begin
  if string(Caption) <> inherited Caption then
  begin
    Caption := inherited Caption;
    {$ifdef VCL_4_USED}
    AdjustBounds;
    {$endif}
  end;
  inherited;
end;

{$ifdef ELPACK_UNICODE}
procedure TCustomElLabel.CMHintShow(var Message: TMessage);
var T: WideChar;
  HintInfo : PHintInfo;
  l : integer;
  S : String;
  WS: WideString;
begin
  inherited;
  HintInfo := PHintInfo(Message.lParam);
  if Length(FHint) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := GetShortHintW(FHint);
  end
  else
  begin
    S := FHint;
    WS := FHint;
  end;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;

procedure TCustomElLabel.SetHint(Value: TElFString);
var S : String;
    i,
    l : integer;
    T : WideChar;
begin
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;
end;

{$endif}

procedure TCustomElLabel.SetCaption(Value: TElFString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    inherited Caption := Value;
    Perform(CM_TEXTCHANGED, 0, 0);
  end;
end;

{$IFDEF ELPACK_USE_STYLEMANAGER}
procedure TCustomElLabel.SetEndEllipsis(Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    Invalidate;
  end;
end;
{$ENDIF}

end.
