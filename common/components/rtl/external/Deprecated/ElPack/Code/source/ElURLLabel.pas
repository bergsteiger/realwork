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

(*

Version History

11/07/2002

  Fixed mouse hovering behaviour in design-time

04/08/2002

  ShowURLInHint functionality was spoiled in Unicode mode. Fixed.

03/06/2002

  Added unicode hint

12/21/2001

  Now the shortcuts can be used not only to focus the linked controls, but also
  to fire OnClick event

05/27/2001 (c) Akzhan Abdulin

    Fixed Color property design-time storing issue (clWindow not stored)

*)

unit ElURLLabel;

interface

uses
  ElHandPt,
  SysUtils,
  Classes,
  ElVCLUtils,
  Windows,
  Messages,
  Controls,
  Graphics,
  ExtCtrls,
  Forms,
{$ifdef VCL_6_USED}
Types,
{$endif}

  ElCLabel, ShellAPI, Menus;

const
 cDefJumpToURLMenuName = '&Jump to URL'; //morozov
 cDefCopyURLMenuName = '&Copy URL';      //morozov

type
  TElURLLabel = class(TCustomElLabel)
  private
    FShowURLInHint : Boolean;
    FVisited : Boolean;
    FVisitedColor : TColor;
//    FPopupMenu : TPopupMenu;
    FURI : string;
    FHyperLinkColour, FOldColour : TColor; //mc
    FHyperLinkStyle, FOldStyle : TFontStyles; //mc
    FUsePopupMenu: Boolean;     //morozov
    FJumpToURLMenuName: String; //morozov
    FCopyToURLMenuName: String; //morozov
    FOnJumpToURL: TNotifyEvent; //morozov

    {$ifdef ELPACK_UNICODE}
    {$endif}
    procedure SetHyperLinkStyle(const Value : TFontStyles); //mc
    procedure SetHyperLinkColour(const Value : TColor); //mc
    procedure SetVisitedColor(newValue : TColor);
    procedure SetVisited(newValue : boolean);
    // vcl message handlers                                             //mc
    procedure CMMouseEnter(var Msg : TMessage); message cm_MouseEnter; //mc
    procedure CMMouseLeave(var Msg : TMessage); message cm_MouseLeave; //mc
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure SetUsePopupMenu(const Value: Boolean); //morozov
  protected
    { Protected declarations }
    function GetPopupMenu : TPopupMenu; override;
    procedure OnOpen(Sender : TObject);
    procedure OnCopy(Sender : TObject);

    {$ifdef ELPACK_UNICODE}
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$else}
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$endif}

  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    procedure Click; override;
    procedure GotoURL; virtual; //morozov
    procedure CopyURL; virtual; //morozov
    //destructor Destroy; override;
  published
    property OnJumpToURL: TNotifyEvent read FOnJumpToURL write FOnJumpToURL;              //morozov 
    property JumpToURLMenuName: String read FJumpToURLMenuName write FJumpToURLMenuName;  //morozov
    property CopyToURLMenuName: String read FCopyToURLMenuName write FCopyToURLMenuName;  //morozov
    property UsePopupMenu: Boolean read FUsePopupMenu write SetUsePopupMenu default True; //morozov
    property URL : string read FURI write FURI;
    property VisitedColor : TColor read FVisitedColor write SetVisitedColor;
    property Visited : boolean read FVisited write SetVisited;
    property HyperLinkColor : TColor read FHyperLinkColour write SetHyperLinkColour default clBlue; //mc
    property HyperLinkStyle : TFontStyles read FHyperLinkStyle write SetHyperLinkStyle; //mc
    property ShowURLInHint : Boolean read FShowURLInHint write FShowURLInHint default True;

    property Align;
    property Alignment;
{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DragKind;
{$ENDIF}
    property AutoSize;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ShowHint;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property Transparent;
    {$ifdef VCL_3_USED}
    property Layout;
    {$endif}
    property Visible;
    property WordWrap;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

implementation

uses
  ElStrUtils,
  ElShellUtils,
  ClipBrd;

(*

function Regkey (Root: HKey; const Key: string;
                    var ValRes: string): Boolean;
  var
    H: HKey;
    Buf: array [0..255] of char;
    Size: DWORD;
begin
  H := 0;
  Result := FALSE;
  Size := sizeof (Buf);

  try
    if  (RegOpenKeyEx (Root, PChar (Key), 0,
              KEY_QUERY_VALUE, H) = ERROR_SUCCESS)
    AND (RegQueryValueEx (H, nil, nil, nil, @Buf, @Size) =
                          ERROR_SUCCESS)        then
    begin
      while (Size > 0) AND (Buf [Size - 1] = #0) do dec (Size);

      SetString (ValRes, Buf, Size);
      Result := TRUE;
    end;
  finally
    if  H <> 0    then  RegCloseKey (H);
  end;
end;
*)
{-----------}

constructor TElURLLabel.Create(AOwner : TComponent);
begin
  inherited;
  Font.Style := Font.Style + [fsUnderline];
  Font.Color := clBlue;
  VisitedColor := Font.Color;
  Cursor := crURLCursor;
  AutoSize := true;
  FShowURLInHint := True;
  HyperLinkStyle := [fsUnderline];
  HyperlinkColor := clBlue;
  FUsePopupMenu := True; //morozov
  FJumpToURLMenuName := cDefJumpToURLMenuName; //morozov
  FCopyToURLMenuName := cDefCopyURLMenuName; //morozov
end;

procedure TElURLLabel.Click;
begin
  inherited;
  if FURI <> '' then
    GotoURL;
end;

procedure TElURLLabel.GotoURL;
var
  Param : AnsiString;
begin
  if Enabled then
  begin
    Param := FURI;
    FireURL(Param);
    FVisited := true;
    Font.Color := VisitedColor;
  end;
end;

procedure TElURLLabel.SetVisited(newValue : boolean);
begin
  if (FVisited <> newValue) then
  begin
    FVisited := newValue;
    Repaint;
  end; {if}
end;

procedure TElURLLabel.SetVisitedColor(newValue : TColor);
begin
  if (FVisitedColor <> newValue) then
  begin
    FVisitedColor := newValue;
    if FVisited then Font.Color := newValue;
    Repaint;
  end; {if}
end; {SetVisitedColor}
(*
destructor TElURLLabel.Destroy;
begin
  if Assigned(FPopupMenu) then FPopupMenu.Free;
  inherited;
end;
*)
procedure TElURLLabel.CopyURL;
var
  CB : TClipboard;
begin
  CB := TClipboard.Create;
  CB.Open;
  CB.AsText := URL;
  CB.Close;
  CB.Free;
end;

procedure TElURLLabel.OnOpen(Sender : TObject);
begin
  if not Assigned(FOnJumpToURL) then //morozov
   GotoURL
  else                               //morozov
   FOnJumpToURL(Self);               //morozov
end;

procedure TElURLLabel.OnCopy(Sender : TObject);
begin
  CopyURL;
end;

function TElURLLabel.GetPopupMenu : TPopupMenu;
  procedure AddMI (const Caption: string; OnClick: TNotifyEvent);
  var
    Item : TMenuItem;
  begin
    Item := TMenuItem.Create(self);
    Item.Caption := Caption;
    Item.OnClick := OnClick;
    Result.Items.Add(Item);
  end;

begin
  Result := nil; //morozov
  if FUsePopupMenu then //morozov
  begin //morozov
   Result := inherited GetPopupMenu;
   if not Assigned(Result) and not (csDesigning in ComponentState) then
   begin
     Result := TPopupMenu.Create(self);
     AddMI (FJumpToURLMenuName, OnOpen); //morozov
     AddMI (FCopyToURLMenuName, OnCopy); //morozov
   end;
  end; //morozov
end; {GetPopupMenu}

procedure TElURLLabel.CMMouseEnter(var Msg : TMessage);
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    fOldStyle := font.Style;
    fOldColour := font.color;
    font.Style := FHyperLinkStyle;
    font.color := FHyperLinkColour;
  end;
end;

procedure TElURLLabel.CMMouseLeave(var Msg : TMessage);
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    font.Style := fOldStyle;
    font.color := fOldColour;
  end;
end;

procedure TElURLLabel.SetHyperLinkStyle(const Value : TFontStyles);
begin
  FHyperLinkStyle := Value;
end;

procedure TElURLLabel.SetHyperLinkColour(const Value : TColor);
begin
  FHyperLinkColour := Value;
end;

procedure TElURLLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if Enabled and ShowAccelChar and IsAccel(Message.CharCode, Caption) then
  begin
    if (FocusControl <> nil) then
      with FocusControl do
        if CanFocus then
        begin
          SetFocus;
          Message.Result := 1;
        end
    else
      Click;
  end;
end;

{$ifdef ELPACK_UNICODE}
procedure TElURLLabel.CMHintShow(var Message: TMessage);
var T: WideChar;
  HintInfo : PHintInfo;
  l : integer;
  S : String;
  WS: WideString;
begin
  inherited;
  HintInfo := PHintInfo(Message.lParam);
  WS := FHint;

  if HintInfo.HintControl = Self then
  begin
    if (Hint = '') and ShowURLInHint then
      WS := Self.URL;
  end;

  if WS = '' then
  begin
    HintInfo.HintStr := '';
    exit;
  end;

  if HintInfo.HintStr = GetShortHint(inherited Hint) then
  begin
    WS := GetShortHintW(WS);
    S := WS;
  end
  else
    S := WS;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;
{$else}
procedure TElURLLabel.CMHintShow(var Message: TMessage);
var HintInfo : PHintInfo;
begin
  inherited;
  {$ifndef D_2}
  HintInfo := PHintInfo(Message.lParam);
  if HintInfo.HintControl = Self then
  begin
    if (Hint = '') and ShowURLInHint then
      HintInfo.HintStr := Self.URL;
  end;
  {$endif}
end;
{$endif}

//morozov begin
procedure TElURLLabel.SetUsePopupMenu(const Value: Boolean);
begin
 FUsePopupMenu := Value;
end;
//morozov end

end.
