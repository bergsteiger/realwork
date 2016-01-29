{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dctslite;

interface
{$I dc.inc}

uses
  classes, controls, comctrls, typinfo, {$IFDEF D4}imglist, {$ENDIF}
  dcsystem, dcgen, dcconsts, dcdreamlib, sysutils;
type

  TComponentSource = class(TTreeSource)
  private
    FLargeImages: TCustomImageList;
    FSmallImages: TCustomImageList;
    FStateImages: TCustomImageList;
    FVersion: TDCVersion;
  protected
    FTreeLink: TPersistent;
    FSelectedObject: integer;
    FRec: TNodeRec;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RefreshEditor; virtual;
    procedure RefreshImages; virtual;
    procedure SetTreeLink(Value: TPersistent); override;
    procedure DoAfterInsert(ObjId, RootId: integer; const Caption: string; InsertType: TNodeAttachMode); virtual;
    procedure CaptionChanged(ObjId: Integer; const Caption: string);
    procedure SetSelectedObject(value: integer); override;
    procedure ObjectInserted(ObjId: integer); override;
    function GetLargeImages: TCustomImageList; override;
    function GetSmallImages: TCustomImageList; override;
    function GetStateImages: TCustomImageList; override;
    procedure SetLargeImages(Value: TCustomImageList); override;
    procedure SetSmallImages(Value: TCustomImageList); override;
    procedure SetStateImages(Value: TCustomImageList); override;
    function GetSelectedObject: integer; override;
    function GetTreeLink: TPersistent; override;

  public // all source methods must be in protected!!! in dcgens source also
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
    function GetStatusLine(ObjId: Integer): string; override;
    procedure SendNotify(WParam, LParam: Longint); //why public
    procedure PostNotify(WParam, LParam: Longint); //why public
    function GetDisplayName(ObjID: integer): string; override;
    function GetAttrCount: Integer; override;
    function GetAttrName(Index: Integer): string; override;
    function GetAttrValue(ObjId, Index: Integer): string; override;
    procedure SetCaption(ObjID: Integer; const Caption: string); override;
    procedure Clear; override;
    function ValidSource: boolean; override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function CanMove(ObjId, DestId: Integer; InsertType: TNodeAttachMode): boolean; override;
    procedure MoveTo(ObjId, DestId: Integer; InsertType: TNodeAttachMode); override;
    procedure Add(ObjID: Integer; const Caption: string; InsertType: TNodeAttachMode); override;
    procedure Edit(ObjId: integer); override;
    function GetSortType: TSortType; override;
    procedure Delete(ObjID: Integer); override;
    function GetInspectorControl(ObjID: Integer): TPersistent; override; // maybe GetInspectorControls that will convert list of items?
    function HasChild(objId: integer): boolean; override;
    function GetParentId(ObjId: integer): integer; override;
    procedure GetItems(ObjID: Integer; Iterator: TIteratorProc); override;
    function ActionAllowed(ObjId: Integer; Action: TActionCode): Boolean; override;
    property LargeImages: TCustomImageList read GetLargeImages write SetLargeImages;
    property SmallImages: TCustomImageList read GetSmallImages write SetSmallImages;
    property StateImages: TCustomImageList read GetStateImages write SetStateImages;
    property SelectedObject: integer read GetSelectedObject write SetSelectedObject;
  published
    property Version: TDCVersion read FVersion write FVersion stored false;
  end;

  TDCPersistentSource = class(TComponentSource)
  protected
    FPropName: string; //why protected. Vars must be in private everywhere. CHeck it!!
    procedure Refresh; virtual; abstract;
    procedure SetPropName(Value: string);
    procedure DoAfterInsert(ObjId, RootId: integer; const Caption: string; InsertType: TNodeAttachMode); override;
    procedure SetTreeLink(Value: TPersistent); override;
  public
    property Link: TPersistent read GetTreeLink write SetTreeLink; //why public
    property PropName: string read FPropName write SetPropName; //why public
  end;

  TCustomDCStringSource = class(TDCPersistentSource)
  private
    FStrings: TStrings;
    procedure SetStrings(Value: Tstrings);
  protected
    procedure Refresh; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure GetItems(ObjID: Integer; Iterator: TIteratorProc); override;
    procedure SetCaption(ObjID: Integer; const Caption: string); override;
    procedure Clear; override;
    procedure MoveTo(ObjId, DestId: Integer; InsertType: TNodeAttachMode); override;
    function ActionAllowed(ObjId: Integer; Action: TActionCode): Boolean; override;
  public
    property Strings: TStrings read FStrings write SetStrings;
  end;

  TDCStringSource = class(TCustomDCStringSource)
  published
    property Link;
    property PropName;
    property LargeImages;
    property SmallImages;
    property StateImages;
  end;

const
  TSIAMGECHANGED = 122; //?

function GetBaseName(C: TPersistent): string;
function GetNodeRec(ObjId, RootId: integer; TreeSource: TTreeSource; Caption: string): TNodeRec;
implementation

function GetBaseName(C: TPersistent): string;
var
  SName: string;
begin
  if Assigned(C) then
  begin
    Sname := C.ClassName;
    if (Sname <> '') and (CompareText(Copy(Sname,1,Length(ClassPrefix)), ClassPrefix) = 0) then
      Delete(Sname, 1, Length(ClassPrefix));
    result := Sname;
  end
  else
    result := '';
end;

{------------------------------------------------------------------}

function GetNodeRec(ObjId, RootId: integer; TreeSource: TTreeSource; Caption: string): TNodeRec;
begin
  result.Caption := '';
  fillChar(result, sizeof(result), 0);
  result.ObjId := ObjId;
  result.RootId := RootId;
  result.Caption := Caption;
  result.TreeSource := TreeSource;
end;

{----------------TComponentSource----------------------------------}

procedure TComponentSource.BeginUpdate;
begin
end;

{------------------------------------------------------------------}

procedure TComponentSource.EndUpdate;
begin
end;

{------------------------------------------------------------------}

function TComponentSource.CanMove(ObjId, DestId: Integer; InsertType: TNodeAttachMode): boolean;
begin
  result := ObjId <> DestId;
end;

{------------------------------------------------------------------}

procedure TComponentSource.MoveTo(ObjId, DestId: Integer; InsertType: TNodeAttachMode);
begin
  DesignerModified(FtreeLink);
end;

{------------------------------------------------------------------}

procedure TComponentSource.Add(ObjID: Integer; const Caption: string; InsertType: TNodeAttachMode);
begin
  //
end;

{------------------------------------------------------------------}

procedure TComponentSource.Edit(ObjId: integer);
begin
end;

{------------------------------------------------------------------}

function TComponentSource.GetSortType: TSortType;
begin
  result := stNone;
end;

{------------------------------------------------------------------}

procedure TComponentSource.Delete(ObjID: Integer);
var
  R: TNodeRec;
begin
  if ActionAllowed(ObjId, acCanDelete) then
  begin
    FSelectedObject := 0;
    R.ObjId := ObjId;
    R.Data := nil;
    SendNotify(Integer(@R), TSDELETE);
    DesignerModified(FTreeLink);
  end;
end;

{------------------------------------------------------------------}

function TComponentSource.GetInspectorControl(ObjID: Integer): TPersistent;
begin
  result := nil;
end;

{------------------------------------------------------------------}

function TComponentSource.HasChild(objId: integer): boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

function TComponentSource.GetParentId(ObjId: integer): integer;
begin
  result := 0;
end;

{------------------------------------------------------------------}

procedure TComponentSource.SetSelectedObject(value: integer);
begin
  FSelectedObject := Value;
  if Value <> 0 then
  begin
    FRec.Caption := '';
    fillChar(FRec, sizeof(FRec), 0);
    FRec.Data := Self;
    PostNotify(integer(@FRec), TSSELCHANGED);
  end;
end;

{------------------------------------------------------------------}

procedure TComponentSource.ObjectInserted(ObjId: integer);
begin
end;

{------------------------------------------------------------------}

procedure TComponentSource.GetItems(ObjID: Integer; Iterator: TIteratorProc);
begin
  //
end;

{------------------------------------------------------------------}

constructor TComponentSource.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  RegisterNotifier(Self);
end;

{------------------------------------------------------------------}

destructor TComponentSource.Destroy;
begin
  UnRegisterNotifier(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TComponentSource.CaptionChanged(ObjId: Integer; const Caption: string);
var
  Lst: TList;
begin
  if ObjId = 0 then
    exit;
  Lst := TList.Create;
  try
    Lst.Add(TObject(ObjID));
    BroadcastToNotifiers(Self, CM_PROPCHANGED, Integer(Lst), integer(pchar(Caption)));
  finally
    Lst.Free;
  end;
  DesignerModified(FTreeLink);
end;

{------------------------------------------------------------------}

procedure TComponentSource.DoAfterInsert(ObjId, RootId: integer; const Caption: string; InsertType: TNodeAttachMode);
var
  R: TNodeRec;
begin
  Fillchar(R, Sizeof(R), 0);
  R.ObjId := ObjId;
  if RootId <> 0 then
    R.RootId := RootId
  else
    R.RootId := integer(FTreeLink);
  R.TreeSource := Self;
  R.InsertType := InsertType;
  if Caption <> '' then
    R.Caption := Caption
  else
    R.Caption := GetDisplayName(ObjId);
  SendNotify(integer(@R), TSINSERT);
  SetCaption(ObjId, R.Caption);
  DesignerModified(FTreeLink);
end;

{------------------------------------------------------------------}

procedure TComponentSource.SetCaption(ObjID: Integer; const Caption: string);
var
  R: TNodeRec;
  Lst: TList;
begin
  Lst := TList.Create;
  try
    Fillchar(R, Sizeof(R), 0);
    R.Caption := Caption;
    R.ObjId := ObjID;
    Lst.Add(@R);
    SendNotify(integer(Lst), TSOBJECTCHANGED);
  finally
    Lst.Free;
  end;
  DesignerModified(FtreeLink);
end;

{------------------------------------------------------------------}

function TComponentSource.GetStatusLine(ObjId: Integer): string;
begin
  if ObjId <> 0 then
    result := TObject(ObjId).ClassName
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TComponentSource.SetTreeLink(Value: TPersistent);
begin
  if FTreeLink <> Value then
  begin
    FTreeLink := Value;
    if FtreeLink is TComponent then
      TComponent(FtreeLink).FreeNotification(Self);
    if not (csDestroying in ComponentState) then
    begin
      RefreshEditor;
      RefreshImages;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TComponentSource.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (operation = opRemove) then
  begin
    if Acomponent = FTreeLink then
    begin
      SetTreeLink(nil);
      BroadCastToNotifiers(Self, CM_SOURCEEMPTY, integer(Self), 0)
    end;
    if AComponent = FLargeImages then
      FLargeImages := nil;
    if AComponent = FSmallImages then
      FSmallImages := nil;
    if AComponent = FStateImages then
      FStateImages := nil;
  end;
end;

{------------------------------------------------------------------}

function TComponentSource.GetDisplayName(ObjID: integer): string;
begin
  result := GetBaseName(TPersistent(ObjId));
end;

{------------------------------------------------------------------}

function TComponentSource.GetAttrCount: Integer;
begin
  result := 0;
end;

{------------------------------------------------------------------}

function TComponentSource.GetAttrName(Index: Integer): string;
begin
  result := ''
end;

{------------------------------------------------------------------}

function TComponentSource.GetAttrValue(ObjId, Index: Integer): string;
begin
  result := '';
end;

{------------------------------------------------------------------}

function TComponentSource.ValidSource: boolean;
begin
  if FtreeLink is TComponent then
    result := (TComponent(FtreeLink).ComponentState * [csDestroying] = [])
  else
    result := (FtreeLink <> nil);
end;

{------------------------------------------------------------------}

procedure TComponentSource.RefreshImages;
var
  R: TNodeRec;
begin
  R.ObjId := 0;
  SendNotify(integer(@R), TSIAMGECHANGED);
end;

{------------------------------------------------------------------}

procedure TComponentSource.RefreshEditor;
var
  R: TNodeRec;
begin
  R.ObjId := 0;
  SendNotify(integer(@R), TSREFRESH);
end;

{------------------------------------------------------------------}

procedure TComponentSource.Clear;
var
  R: TNodeRec;
begin
  R.ObjId := integer(FTreeLink);
  R.Data := Pointer(1);
  SendNotify(integer(@R), TSDELETE);
  DesignerModified(FTreeLink);
end;

{------------------------------------------------------------------}

function TComponentSource.ActionAllowed(ObjId: Integer; Action: TActionCode): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

procedure TComponentSource.SendNotify(WParam, LParam: Longint);
begin
  GetTreeNotifiers.NotifyEvents(Self, wParam, lParam);
end;

{------------------------------------------------------------------}

procedure TComponentSource.PostNotify(WParam, LParam: Longint);
begin
  GetTreeNotifiers.PostMessage(CM_TSNOTIFY, WParam, LParam);
end;

{------------------------------------------------------------------}

function TComponentSource.GetLargeImages: TCustomImageList;
begin
  result := FLargeImages;
end;

{------------------------------------------------------------------}

function TComponentSource.GetSmallImages: TCustomImageList;
begin
  result := FSmallImages;
end;

{------------------------------------------------------------------}

function TComponentSource.GetStateImages: TCustomImageList;
begin
  result := FStateImages;
end;

{------------------------------------------------------------------}

procedure TComponentSource.SetLargeImages(Value: TCustomImageList);
begin
  if FLargeImages <> Value then
  begin
    FLargeImages := Value;
    RefreshImages;
  end;
end;

{------------------------------------------------------------------}

procedure TComponentSource.SetSmallImages(Value: TCustomImageList);
begin
  if FSmallImages <> Value then
  begin
    FSmallImages := Value;
    RefreshImages;
  end;
end;

{------------------------------------------------------------------}

procedure TComponentSource.SetStateImages(Value: TCustomImageList);
begin
  if FStateImages <> Value then
  begin
    FStateImages := Value;
    RefreshImages;
  end;
end;

{------------------------------------------------------------------}

function TComponentSource.GetSelectedObject: integer;
begin
  result := FSelectedObject;
end;

{------------------------------------------------------------------}

function TComponentSource.GetTreeLink: TPersistent;
begin
  result := FTreeLink;
end;

{----------------TDCPersistentSource------------------------------------}

procedure TDCPersistentSource.SetTreeLink(Value: TPersistent);
begin
  if FTreeLink <> Value then
  begin
    inherited;
    Refresh;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPersistentSource.DoAfterInsert(ObjId, RootId: integer; const Caption: string; InsertType: TNodeAttachMode);
begin
  if RootId = 0 then
    RootId := -1;
  inherited DoAfterInsert(ObjId, RootId, Caption, InsertType);
end;

{------------------------------------------------------------------}

procedure TDCPersistentSource.SetPropName(Value: string);
begin
  if FpropName <> Value then
  begin
    FPropName := Value;
    Refresh;
  end;
end;

{----------------TCustomDCStringSource------------------------------------}

procedure TCustomDCStringSource.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (operation = opRemove) and (Acomponent = FTreeLink) then
    FStrings := nil;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCStringSource.SetStrings(Value: Tstrings);
begin
  if FStrings <> Value then
  begin
    FStrings := Value;
    RefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCStringSource.Refresh;
var
  Info: PPropInfo;
begin
  FStrings := nil;
  if Assigned(Link) then
  begin
    Info := GetPropInfo(Link.ClassInfo, FPropName);
    if Assigned(Info) then
      FStrings := TStrings(GetOrdProp(Link, Info));
  end;
  RefreshEditor;
end;

{------------------------------------------------------------------}

procedure TCustomDCStringSource.GetItems(ObjID: Integer; Iterator: TIteratorProc);
var
  i: integer;
begin
  if not Assigned(FStrings) then
    Exit;
  if ObjId = 0 then
    with FStrings do
      for i := 0 to Count - 1 do
        Iterator(GetNodeRec(i + 1, -1, Self, Strings[i]));
end;

{------------------------------------------------------------------}

procedure TCustomDCStringSource.SetCaption(ObjID: Integer; const Caption: string);
begin
  if Assigned(FStrings) and (ObjID <> 0) then
  begin
    FStrings[ObjId - 1] := Caption;
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCStringSource.Clear;
begin
  if Assigned(FStrings) then
  begin
    Fstrings.Clear;
    inherited;
  end;
end;

{------------------------------------------------------------------}

function TCustomDCStringSource.ActionAllowed(ObjId: Integer; Action: TActionCode): Boolean;
begin
  result := (Action in [acCanClear, acCanAdd, acCanEdit, acMultiSelect, acShowToolBar, acCanDrag,
    acShowSourceinPopup, acShowTreeview])
end;

{------------------------------------------------------------------}

procedure TCustomDCStringSource.MoveTo(ObjId, DestId: Integer; InsertType: TNodeAttachMode);
var
  Index: integer;
  R: TNodeRec;
begin
  if Assigned(FStrings) and CanMove(ObjId, DestId, InsertType) then
  begin
    if InsertType = naInsert then
    begin
      Fstrings.InsertObject(DestID - 1, Strings[ObjId - 1], FStrings.Objects[ObjId - 1]);
      Index := DestId;
    end
    else
      with Fstrings do
      begin
        AddObject(Strings[ObjId - 1], FStrings.Objects[ObjId - 1]);
        Index := Count;
      end;
    if ObjId > DestId then
      Inc(ObjId)
    else
      Dec(Index);
    FStrings.Delete(ObjId - 1);
    RefreshEditor;
    R.Data := Self;
    R.ObjId := Index;
    SendNotify(integer(@R), TSSELCHANGED);
  end;
  inherited;
end;

end.
