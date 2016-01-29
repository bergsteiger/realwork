unit AdvMenus;

{ $Id: AdvMenus.pas,v 1.7 2004/05/11 07:40:03 voba Exp $ }

// $Log: AdvMenus.pas,v $
// Revision 1.7  2004/05/11 07:40:03  voba
// no message
//
// Revision 1.6  2001/04/05 08:52:17  law
// - cleanup: использование модулей WinTypes и WinProcs заменен на Windows.
//
// Revision 1.5  2001/02/20 13:22:13  voba
// no message
//
// Revision 1.4  2001/01/17 11:58:20  voba
// no message
//
// Revision 1.3  2000/12/15 15:36:28  law
// - вставлены директивы Log.
//

interface

uses Forms, Windows, SysUtils, Menus, Classes, Messages;

type
  EMenuError = class(Exception);

  TSystemMenuItem = class(TComponent)
  private
    FAdded: Boolean;
    FParentHandle: HMENU;
    FPosInParent: Integer;
    FBreak: TMenuBreak;
    FPopUp,
    FChecked,
    FEnabled: Boolean;
    FItems: TList;
    FCaption: string;
    FHandle: HMENU;
    FOnClick: TNotifyEvent;
    function AppendTo(Menu: HMENU; Position: Word): Boolean;
    procedure RedrawItem;
    procedure SetBreak(Value: TMenuBreak);
    procedure SetCaption(Value: string);
    procedure SetChecked(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetSubMenu(Value: Boolean);
    {function HandleExists(Menu: HMENU): Boolean;}
    function ItemExists(AItem: TSystemMenuItem): Boolean;
  protected
    function GetHandle: HMENU; virtual;
    function GetItem(Index: Integer): TSystemMenuItem;
    function GetCount: Integer;
    procedure Click(Sender: TObject); virtual;
    function GetItemFromHandle(Menu: HMenu): TSystemMenuItem;
  public
    procedure Add(AItem: TSystemMenuItem; Position: Word);
    procedure Remove(AItem: TSystemMenuItem);
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    property Items[Index: Integer]: TSystemMenuItem read GetItem; default;
    property Handle: HMenu read GetHandle;
    property Count: Integer read GetCount;
  published
    property Break: TMenuBreak read FBreak write SetBreak default mbNone;
    property Caption: string read FCaption write SetCaption;
    property Checked: Boolean read FChecked write SetChecked default False;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property IsSubMenu: Boolean read FPopUp write SetSubMenu;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TSystemMenu = class(TComponent)
  private
    FAutoHandled: Boolean;
    {FHandle: HMenu;}
    FItems: TSystemMenuItem;
    FWindowHandle: HWND;
    procedure SetWindowHandle(Value: HWND);
    procedure SetAutoHandled(Value: Boolean);
  protected
    function GetHandle: HMenu; virtual;
    procedure ClearHandles(AItem: TSystemMenuItem);
  public
    property Items: TSystemMenuItem read FItems write FItems;
    property WindowHandle: HWND read FWindowHandle write SetWindowHandle;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure HandleEvents(Msg: TMsg; FirstItem: TSystemMenuItem); virtual;
    procedure ClearAll;
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
  published
    property AutoHandled: Boolean read FAutoHandled write SetAutoHandled;
  end;

 function SystemMenuItemToMenuItem(AItem: TSystemMenuItem): TMenuItem;
 function MenuItemToSystemMenuItem(AItem: TMenuItem): TSystemMenuItem;

 Type
  TLinkPopUpMenu = class(TPopUpMenu)
  private
    FPrimaryPopUpMenu : TPopUpMenu;
    FPrimaryMenuItem  : TMenuItem;
    FActive: Boolean;
    FOnAppend: TNotifyEvent;
    FOnRemove: TNotifyEvent;
    Inserted: TList;
    Done: Boolean;
    function   CopyMenu(src: TMenuItem) : TMenuItem;
    Procedure  SetActive(Value : Boolean);
    Procedure  SetPrimaryPopUpMenu(Value : TPopUpMenu);
  protected
    procedure DoPopup(Item: TObject); reintroduce;
  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   AddPopup;
    procedure   Popup(X, Y: Integer); override;
    property    PrimaryMenuItem : TMenuItem read FPrimaryMenuItem write FPrimaryMenuItem;
  published
    Property PrimaryPopUpMenu : TPopUpMenu Read FPrimaryPopUpMenu Write SetPrimaryPopUpMenu;
    property Active: Boolean read FActive write SetActive;
    property OnAppend: TNotifyEvent read FOnAppend write FOnAppend;
    property OnRemove: TNotifyEvent read FOnRemove write FOnRemove;
  end;

procedure Register;

implementation

{var
  HSystemMenu: HMENU;}
Uses ImgList;  

Type
{$HINTS OFF}
THackMenuItem = class(TComponent)
 {$IfDef VER130}
  private
    FCaption: string;
    FHandle: HMENU;
    FChecked: Boolean;
    FEnabled: Boolean;
    FDefault: Boolean;
    FAutoHotkeys: TMenuItemAutoFlag;
    FAutoLineReduction: TMenuItemAutoFlag;
    FRadioItem: Boolean;
    FVisible: Boolean;
    FGroupIndex: Byte;
    FImageIndex: TImageIndex;
    FActionLink: TMenuActionLink;
    FBreak: TMenuBreak;
    FBitmap: TBitmap;
    FCommand: Word;
    FHelpContext: THelpContext;
    FHint: string;
    FItems: TList;
    FShortCut: TShortCut;
    FParent: TMenuItem;
 end;
{$else}
  private
    FBreak: TMenuBreak;
    FCaption: PString;
    FChecked: Boolean;
    FEnabled: Boolean;
    FHandle: HMENU;
    FHelpContext: THelpContext;
    FHint: PString;
    FItems: TList;
    FShortCut: TShortCut;
    FVisible: Boolean;
    FGroupIndex: Byte;
    FOnChange: TMenuChangeEvent;
    FOnClick: TNotifyEvent;
    FCommand: Word;
    FParent: TMenuItem;
    FMerged: TMenuItem;
end;
{$endif}
{$HINTS ON}

function SystemMenuItemToMenuItem(AItem: TSystemMenuItem): TMenuItem;
begin
  Result := TMenuItem.Create(Application);
  Result.Caption := AItem.Caption;
  Result.Enabled := AItem.Enabled;
  Result.Checked := AItem.Checked;
  Result.Break := AItem.Break;
  Result.OnClick := AItem.OnClick;
end;

function  MenuItemToSystemMenuItem(AItem: TMenuItem): TSystemMenuItem;
begin
  Result := TSystemMenuItem.Create(Application);
  Result.Caption := AItem.Caption;
  Result.Enabled := AItem.Enabled;
  Result.Checked := AItem.Checked;
  Result.Break := AItem.Break;
  Result.OnClick := AItem.OnClick;
end;

{TSystemMenuItem}
constructor TSystemMenuItem.Create(AOwner: TComponent);
begin
  FEnabled := True;
  FBreak := mbNone;
  FPopUp := False;
  FCaption := '';
  FAdded := False;
  inherited Create(AOwner);
end;

destructor TSystemMenuItem.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TSystemMenuItem.Click(Sender: TObject);
begin
  if Assigned(FOnClick) then FOnClick(Self);
end;

function TSystemMenuItem.GetHandle: HMenu;
begin
  if FHandle = 0 then FHandle := CreateMenu;
  Result := FHandle;
end;

function TSystemMenuItem.AppendTo(Menu: HMenu; Position: Word): Boolean;
const
  Breaks: array[TMenuBreak] of Longint = (0, MF_MENUBREAK, MF_MENUBARBREAK);
  Checks: array[Boolean] of LongInt = (MF_UNCHECKED, MF_CHECKED);
  Enables: array[Boolean] of LongInt = (MF_DISABLED or MF_GRAYED, MF_ENABLED);
  PopUps: array[Boolean] of LongInt = (0, MF_POPUP);
  Separators: array[Boolean] of LongInt = (MF_STRING, MF_SEPARATOR);
var
  NewFlags: Word;
  CCaption: array [0..255] of Char;
begin
  NewFlags := Breaks[FBreak] or Checks[FChecked] or Enables[FEnabled]
              or PopUps[FPopUp] or Separators[FCaption = '-'] or MF_BYPOSITION;
  StrPCopy(CCaption, FCaption);
  Result := InsertMenu(Menu, Position, NewFlags, GetHandle, CCaption);
  FPosInParent := Position;
  FParentHandle := Menu;
  FAdded := True;
end;

procedure TSystemMenuItem.Add(AItem: TSystemMenuItem; Position: Word);
begin
  if ItemExists(AItem) then
  begin
    raise EMenuError.Create('Menu inserted twice');
    exit;
  end;
  if not AItem.AppendTo(Handle, Position) then
  begin
    raise EMenuError.Create('Unable insert menu item');
    exit;
  end;
  if FItems = nil then
     FItems := TList.Create;
  FItems.Insert(Position, AItem);
end;

procedure TSystemMenuItem.Remove(AItem: TSystemMenuItem);
begin
  DeleteMenu(AItem.FParentHandle, AItem.FPosInParent, MF_BYPOSITION);
  FItems.Remove(AItem);
  if FItems.Count = 0 then IsSubMenu := False;
  AItem.Free;
end;

function TSystemMenuItem.GetItem(Index: Integer): TSystemMenuItem;
begin
  if FItems = nil
   then Result := nil
   else Result := FItems[Index];
end;

function TSystemMenuItem.GetCount: Integer;
begin
  if FItems = nil then Result := 0
  else Result := FItems.Count;
end;

procedure TSystemMenuItem.RedrawItem;
const
  Breaks: array[TMenuBreak] of Longint = (0, MF_MENUBREAK, MF_MENUBARBREAK);
  Checks: array[Boolean] of LongInt = (MF_UNCHECKED, MF_CHECKED);
  Enables: array[Boolean] of LongInt = (MF_DISABLED or MF_GRAYED, MF_ENABLED);
  PopUps: array[Boolean] of LongInt = (0, MF_POPUP);
  Separators: array[Boolean] of LongInt = (MF_STRING, MF_SEPARATOR);
var
  NewFlags: Word;
  {Item: TSystemMenuItem;}
  CCaption: array [0..255] of Char;

begin
  NewFlags := Breaks[FBreak] or Checks[FChecked] or Enables[FEnabled]
              or PopUps[FPopUp] or Separators[FCaption = '-'] or MF_BYPOSITION;
  StrPCopy(CCaption, FCaption);
  if not ModifyMenu(FParentHandle, FPosInParent, NewFlags, FHandle, CCaption)
  then raise EMenuError.Create('Error modifing menu');
end;

procedure TSystemMenuItem.SetBreak(Value: TMenuBreak);
begin
  if FBreak <> Value then
  begin
    FBreak := Value;
    if FAdded then RedrawItem;
  end;
end;

procedure TSystemMenuItem.SetCaption(Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    if FAdded then RedrawItem;
  end;
end;

procedure TSystemMenuItem.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    if FAdded then RedrawItem;
  end;
end;

procedure TSystemMenuItem.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if FAdded then RedrawItem;
  end;
end;

procedure TSystemMenuItem.SetSubMenu(Value: Boolean);
begin
  if FPopUp <> Value then
  begin
    FPopUp := Value;
    if FAdded then RedrawItem;
  end;
end;

{function TSystemMenuItem.HandleExists(Menu: HMenu): Boolean;
var
  i: integer;
  AItem: TSystemMenuItem;
begin
  if FItems = nil then
  begin
    Result := False;
    exit;
  end else
  for i := 0 to FItems.Count - 1 do
  begin
    AItem := FItems[i];
    if (Menu = AItem.FHandle) then
    begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;
}

function TSystemMenuItem.ItemExists(AItem: TSystemMenuItem): Boolean;
var
  i: integer;
begin
  if FItems = nil then
  begin
    Result := False;
    exit;
  end else
  for i := 0 to FItems.Count - 1 do
  begin
    if AItem = FItems[i] then
    begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function TSystemMenuItem.GetItemFromHandle(Menu: HMenu): TSystemMenuItem;
var
  i: integer;
  AItem: TSystemMenuItem;
begin
  if FItems = nil then
  begin
    Result := nil;
    exit;
  end else
  for i := 0 to FItems.Count - 1 do
  begin
    AItem := FItems[i];
    if Menu = AItem.FHandle then
    begin
      Result := AItem;
      exit;
    end;
  end;
  Result := nil;
end;


{TSystemMenu}
constructor TSystemMenu.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  FItems := TSystemMenuItem.Create(Self);
  FAutoHandled := True;
end;

destructor TSystemMenu.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TSystemMenu.GetHandle: HMenu;
begin
  Result := FItems.GetHandle;
end;

procedure TSystemMenu.HandleEvents(Msg: TMsg; FirstItem: TSystemMenuItem);
var
  i: integer;
begin
  if not Assigned(FirstItem)
         then FirstItem := Items;
  if not Assigned(FirstItem)
         then exit;
  for i := 0 to FirstItem.Count - 1 do
  begin
    if FirstItem.Items[i].Handle = LongWord(Msg.WParam)
       then FirstItem.Items[i].OnClick(Self);
    HandleEvents(Msg, FirstItem.Items[i]);
  end;
end;

procedure TSystemMenu.ClearAll;
begin
  GetSystemMenu(Application.MainForm.Handle, True);
  ClearHandles(FItems);
  FItems.Free;
  FItems := TSystemMenuItem.Create(Self);
end;

procedure TSystemMenu.SetAutoHandled(Value: Boolean);
begin
  if FAutoHandled <> Value then FAutoHandled := Value;
  if FAutoHandled then Application.OnMessage := AppMessage
  else Application.OnMessage := nil;
end;

procedure TSystemMenu.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  HandleEvents(Msg, nil);
end;

procedure TSystemMenu.ClearHandles(AItem: TSystemMenuItem);
var
  i: integer;
begin
  for i := 0 to AItem.Count - 1 do
  begin
    AItem[i].FHandle := 0;
    ClearHandles(AItem[i]);
  end;
end;

procedure TSystemMenu.SetWindowHandle(Value: HWND);
begin
  FWindowHandle := Value;
  FItems.FHandle := GetSystemMenu(FWindowHandle, False);
end;

{TLinkPopUpMenu}
function TLinkPopUpMenu.CopyMenu(src: TMenuItem) : TMenuItem;
// Var
//  NSM : TMenuItem;
//  i: Integer;
 Begin
  {NSM := NewItem(src.Caption, src.ShortCut, src.Checked,
                 src.Enabled, src.OnClick, src.HelpContext,
                 src.Name + 'Item');

  If src.Count <> 0 then
   For i := 0 to src.Count - 1 do
    NSM.Add(CopyMenu(src.Items[i]));

  Result := NSM;}

  Result:=Src;
  Inserted.Add(Result);
 end;

Procedure TLinkPopUpMenu.SetActive(Value : Boolean);
 Begin
  If FActive = Value then exit;
  FActive:=Value;
  AddPopup;
 end;

Procedure TLinkPopUpMenu.SetPrimaryPopUpMenu(Value : TPopUpMenu);
 Begin
  If FPrimaryPopUpMenu = Value then exit;
  FPrimaryPopUpMenu := Value;
  If FPrimaryMenuItem = Nil then
   FPrimaryMenuItem := FPrimaryPopUpMenu.Items;

  AddPopup;
 end;

procedure TLinkPopUpMenu.DoPopup(Item: TObject);
 var
  lOnPopup: TNotifyEvent;
 begin
  lOnPopup := OnPopUp;
  if Assigned(lOnPopup) then lOnPopup(Item);
 end;

procedure TLinkPopUpMenu.Popup(X, Y: Integer);
 Var
  SaveActive : Boolean;
 Begin
  SaveActive := Active;
  Active := True;

  DoPopup(Self);
  if FPrimaryPopUpMenu = Nil then
   inherited Popup(X, Y)
  else
  begin
   FPrimaryPopUpMenu.PopupComponent:=PopupComponent;
   FPrimaryPopUpMenu.Popup(X, Y);
  end;

  Active := SaveActive;
 end;

constructor TLinkPopUpMenu.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  Inserted := TList.Create;
  Done := False;
end;

destructor TLinkPopUpMenu.Destroy;
begin
  Inserted.Free;
  inherited Destroy;
end;

procedure TLinkPopUpMenu.AddPopup;
 var
  i, k: Integer;
  mi_x, mi_y: TMenuItem;
 begin
  {inherited Popup(X, Y);}

  if Assigned(FPrimaryMenuItem) then
   begin
    if fActive then
     begin
      if Assigned(FOnAppend) then FOnAppend(Self);
      if not Done then
      begin
        for i := 0 to Items.Count - 1 do
         {FPrimaryMenuItem.Add(CopyMenu(Items[i]));}
         FPrimaryMenuItem.Insert(i,CopyMenu(Items[i]));
        Done := True;
      end;
     end
    else
     begin  
      ///if Assigned(FPrimaryMenuItem)then
      /// begin
        if Assigned(FOnRemove) then FOnRemove(Self);
        for i := FPrimaryMenuItem.Count - 1 downto 0 do
         begin
          mi_x := FPrimaryMenuItem.Items[i];
          for k := Inserted.Count - 1 downto 0 do
           begin
            mi_y := Inserted.Items[k];
            if mi_x = mi_y
             then
              Begin
               FPrimaryMenuItem.Remove(mi_x {FPrimaryMenuItem.Items[i]});
               THackMenuItem(mi_x).FParent := Items;
               Inserted.Delete(k);
              end;
           end;
         end;
        Done := False;
       ///end;
     end;
   end;
 end;

procedure Register;
begin
  RegisterComponents('Custom', [TLinkPopUpMenu]);
  RegisterComponents('Custom', [TSystemMenuItem]);
  RegisterComponents('Custom', [TSystemMenu]);
end;


end.
