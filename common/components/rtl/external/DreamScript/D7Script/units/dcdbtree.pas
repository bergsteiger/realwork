{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DcDbTree;

interface
{$I dc.inc}
{$I dcDBTree.inc}
uses
  Windows, dbconsts, SysUtils, Classes, Dialogs, Messages, Forms,
  Controls, comctrls, dcgen, dcConsts,
  dcsystem, Db, DbCtrls, dctree, dcdreamlib, Dctsrc, dctslite, treemod,
  newfield, dbgrids, dctreeed, typinfo {$IFDEF D4},imglist{$ENDIF}
  {$IFDEF USEBDE},dbtables{$IFNDEF D3},bde{$ENDIF}{$ENDIF}
  {$IFDEF D6} ,Variants {$ENDIF}
  ;

type
  TDCFieldSource = class(TDCDefaultEditSource)
  private
    procedure SetDataset(Value:TDataset);
    function  GetDataset:TDataset;
    function  NewField(Dataset:TDataset):TField;
  protected
    procedure CMPROPCHANGED(var M:TMessage); message CM_PROPCHANGED;
    function  IsMyItem(C:TPersistent):boolean;
  public
    procedure  GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    procedure  SetCaption(ObjID:Integer; const Caption:string);override;
    procedure  Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
    procedure  Clear;override;
    procedure  Delete(ObjID:Integer);override;
    procedure  MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);override;
    function   GetInspectorControl(ObjID:Integer):TPersistent;override;
    function   ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    function   GetDisplayName(ObjID:integer):string;override;
    function   HasChild(objId:integer):boolean;override;
    procedure  BeginDesign;
    procedure  EndDesign;
  published
    property   Dataset:TDataset read GetDataset write SetDataset;
    property   LargeImages;
    property   SmallImages;
    property   StateImages;
  end;

  {$IFDEF WITHPARAMS}

  TDCParamSource = class(TFakeTreeSource)
  private
    FParams:TParams;
    FPropName:string;
    procedure _Refresh;
    procedure  SetPropName (Value:string);
    procedure  SetParams(Value : TParams);
    function   GetLink : TPersistent;
    procedure  SetLink(Value : TPersistent);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
  public
    procedure   GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    procedure   SetCaption(ObjID:Integer; const Caption:string);override;
    procedure   Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
    procedure   Clear;override;
    procedure   Delete(ObjID:Integer);override;
    function    ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    function    CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;override;
    function    GetDisplayName(ObjID:integer):string;override;
    procedure   ObjectInserted(ObjId:integer);override;
    property    Params :TParams read FParams write SetParams;
  published
    property   Link:TPersistent read GetLink write SetLink;
    property   PropName:string read FPropName write SetPropName;
    property  LargeImages;
    property  SmallImages;
    property  StateImages;
  end;

  {$ENDIF}

  TBookRec = Class
  public
    BookMark:TBookMarkStr;
    Id:integer;
    ParentId:integer;
    constructor Create(ObjId,Parent:Integer;Mark:TBookMarkStr);
  end;

  TBookList = class(TSortedList)
    function CompareWithKey(Item,Key:Pointer):Integer;override;
    function Compare(Item1, Item2: Pointer):integer;override;
  end;

  TDCDataSetSource = class(TComponentSource)
  private
    FDataset:TDataset;
    FDisplayField:string;
    FRootIndexField:string;
    FObjectIndexField:string;
    FImageIndexField:string;
    FSelectedIndexField:string;
    FStateIndexField:string;
    FUpdateCount:integer;
    FDataLink:TFieldDataLink;
    FBookMarkList : TBookList;
    FInsertFlag:boolean;
    FEditFlag : boolean;
    FRoot:integer;
    R1:TNodeRec;
    R2:TNodeRec;
    FSelRec : TBookRec;
    FMultiColumn : boolean;
    function  GetDataSource:TDatasource;
    procedure SetDataSource(Value:TDatasource);
    procedure SetDisplayField(Value:string);
    procedure SetRootIndexField(Value:string);
    procedure SetObjectIndexField(Value:string);
    procedure SetImageIndexField(Value:string);
    procedure SetSelectedIndexField(Value:string);
    procedure SetStateIndexField(Value:string);
    procedure SetRoot(Value:integer);
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    procedure ActiveChanged(Sender: TObject);
    function  GetParentIndex(ObjId:integer):integer;
    function  GetBookRecFromId(Id:integer):TBookRec;
    procedure _DoSelectChanged(ObjId:integer);
    procedure _DoEditChanged(ObjId:integer);
    procedure _DoAfterDelete(ObjId:integer);
    procedure _DoAfterInsert(ObjId:integer);
    procedure SetImageInfo(var R:TNodeRec);
    procedure CheckBookRec(B:TBookrec);
    procedure InternalMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
    procedure ObjectChanged(ObjID:Integer; const Caption:string);
    procedure SmartRefreshEditor;
    function  GetDisplayText : string; virtual;
    procedure SetDisplayText(Value : string);
    procedure SetRootIndex(Value : integer);
    procedure SetObjectIndex(Value : integer);
    function  GetRootIndex   : integer;
    function  GetObjectIndex : integer;
    procedure SetMultiColumn(Value : boolean);
    procedure CheckAttrIndex(var Index : integer);
  protected               
    procedure SetSelectedObject(value:integer);override;
    function  GetSelectedObject : integer ; override;
    procedure ObjectDeleted(ObjId:integer);
    procedure Loaded; override;
    function  FindBookRec(Id:integer):TBookRec;
    property  UpdateCount : integer read FUpdateCount;
  public
    MaxKeyFieldValue:integer;
    procedure   BeginUpdate ; override;
    procedure   EndUpdate ; override;
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure   GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    procedure   SetCaption(ObjID:Integer; const Caption:string);override;
    procedure   Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
    procedure   Clear;override;
    procedure   Delete(ObjID:Integer);override;
    function    ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    procedure   MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);override;
    function    GetDisplayName(ObjID:integer):string;override;
    function    ValidSource:boolean;override;
    function    ValidFields:Boolean;
    function    HasChild(objId:integer):boolean;override;
    function    GetParentId(ObjId:integer):integer;override;
    function    CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;override;
    property    DisplayText : string read GetDisplayText write SetDisplayText;
    property    RootIndex  : integer read GetRootIndex write SetRootIndex;
    property    ObjectIndex : integer read GetObjectIndex write SetObjectIndex;
    property    BookMarkList : TBookList read FBookMarkList;
    function    GetAttrCount: Integer; override;
    function    GetAttrName(Index: Integer): string; override;
    function    GetAttrValue(ObjId , Index : Integer): string; override;

  published
    property  Root :integer read FRoot write SetRoot;
    property  Datasource :TDataSource read GetDataSource write SetDataSource;
    property  DisplayField:string read FDisplayField write SetDisplayField;
    property  RootIndexField:string read FRootIndexField write SetRootIndexField;
    property  ObjectIndexField:string read FObjectIndexField write SetObjectIndexField;
    property  ImageIndexField:string read FImageIndexField write SetImageIndexField;
    property  SelectedIndexField:string read FSelectedIndexField write SetSelectedIndexField;
    property  StateIndexField:string read FStateIndexField write SetStateIndexField;
    property  MultiColumn : boolean read FMultiColumn write SetMultiColumn;
    property  LargeImages;
    property  SmallImages;
    property  StateImages;
  end;

  TDCDBTreeView =class(TCustomDcTreeView)
  private
    FDSSource : TDCDataSetSource;
    FVersion  : TDCVersion;
    procedure SetRoot(Value : integer);
    procedure SetDataSource(Value : TDataSource);
    procedure SetDisplayField(Value :string);
    procedure SetRootIndexField(Value :string);
    procedure SetObjectIndexField(Value :string);
    procedure SetImageIndexField(Value :string);
    procedure SetSelectedIndexField(Value :string);
    procedure SetStateIndexField(Value :string);
    procedure SetImages(Value :  TCustomImageList);
    procedure SetStateImages(Value : TCustomImageList);

    function  GetRoot : integer;
    function  GetDataSource : TDataSource;
    function  GetDisplayField : string;
    function  GetRootIndexField : string;
    function  GetObjectIndexField : string;
    function  GetImageIndexField : string;
    function  GetSelectedIndexField : string;
    function  GetStateIndexField : string;
    function  GetImages : TCustomImageList;
    function  GetStateImages : TCustomImageList;

  public
    constructor Create(AOwner:TComponent);override;
  published
    property Root :integer read GetRoot write SetRoot;
    property Datasource :TDataSource read GetDataSource write SetDataSource;
    property DisplayField:string read GetDisplayField write SetDisplayField;
    property RootIndexField:string read GetRootIndexField write SetRootIndexField;
    property ObjectIndexField:string read GetObjectIndexField write SetObjectIndexField;
    property ImageIndexField:string read GetImageIndexField write SetImageIndexField;
    property SelectedIndexField:string read GetSelectedIndexField write SetSelectedIndexField;
    property StateIndexField:string read GetStateIndexField write SetStateIndexField;
    property Images : TCustomImageList  read GetImages write SetImages;
    property StateImages : TCustomImageList read GetStateImages write SetStateImages;

    property ShowButtons;
    property BorderStyle;
    property DragCursor;
    property ShowLines;
    property ShowRoot;
    property ReadOnly;
    property Version : TDCVersion read FVersion write FVersion stored false;
    {$IFDEF D3}
    property RightClickSelect;
    {$ENDIF}
    property DragMode;
    property HideSelection;
    property Indent;
    property OnEditing;
    property OnEdited;
    property OnExpanding;
    property OnExpanded;
    property OnCollapsing;
    property OnCompare;
    property OnCollapsed;
    property OnChanging;
    property OnChange;
    property OnDeletion;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property Align;
    property Enabled;
    property Font;
    property Color;
    property ParentColor;
    property ParentCtl3D;
    property Ctl3D;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property PopupMenu;
    property ParentFont;
    property ParentShowHint;
    property SelectDelay;
    property ShowHint;
    property MultiSelect;
    property Options;
    property ToolTips;
    property HotTrack;
    property RowSelect;
    property CheckBoxes;
    property AllowGrayed;
    property AutoScroll;
    property ExpandOnDrag;
    property DragExpandDelay;
    property SelectOnlySiblings;
    property OnSelectionChanged;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnClickCheck;
    {$IFDEF D4}
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderWidth;
    property ChangeDelay;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}

  end;

  TDCDBListView =class(TCustomDcListView)
  private
    FDSSource : TDCDataSetSource;
    FVersion  : TDCVersion;
    procedure SetRoot(Value : integer);
    procedure SetDataSource(Value : TDataSource);
    procedure SetDisplayField(Value :string);
    procedure SetRootIndexField(Value :string);
    procedure SetObjectIndexField(Value :string);
    procedure SetImageIndexField(Value :string);
    procedure SetSelectedIndexField(Value :string);
    procedure SetStateIndexField(Value :string);
    procedure SetLargeImages(Value : TCustomImageList );
    procedure SetSmallImages(Value : TCustomImageList );
    procedure SetStateImages(Value : TCustomImageList );

    function  GetRoot : integer;
    function  GetDataSource : TDataSource;
    function  GetDisplayField : string;
    function  GetRootIndexField : string;
    function  GetObjectIndexField : string;
    function  GetImageIndexField : string;
    function  GetSelectedIndexField : string;
    function  GetStateIndexField : string;
    function  GetLargeImages : TCustomImageList;
    function  GetSmallImages : TCustomImageList;
    function  GetStateImages : TCustomImageList;

  public
    constructor Create(AOwner:TComponent);override;
  published
    property Root :integer read GetRoot write SetRoot;
    property Datasource :TDataSource read GetDataSource write SetDataSource;
    property DisplayField:string read GetDisplayField write SetDisplayField;
    property RootIndexField:string read GetRootIndexField write SetRootIndexField;
    property ObjectIndexField:string read GetObjectIndexField write SetObjectIndexField;
    property ImageIndexField:string read GetImageIndexField write SetImageIndexField;
    property SelectedIndexField:string read GetSelectedIndexField write SetSelectedIndexField;
    property StateIndexField:string read GetStateIndexField write SetStateIndexField;

    property LargeImages : TCustomImageList read GetLargeImages write SetLargeImages;
    property SmallImages : TCustomImageList read GetSmallImages write SetSmallImages;
    property StateImages : TCustomImageList read GetStateImages write SetStateImages;

    property Align;
    property BorderStyle;
    property Color;
    property ColumnClick;
    property OnClick;
    property OnDblClick;
    property Columns;
    property Ctl3D;
    property DragMode;
    property ReadOnly default False;
    property Enabled;
    property Font;
    {$IFDEF D3}
    property GridLines;
    property HotTrack;
    property Checkboxes;
    property RowSelect;
    {$ENDIF}
    property HideSelection;
    property IconOptions;
    property AllocBy;
    property MultiSelect;
    property OnChange;
    property OnChanging;
    property OnColumnClick;
    property OnCompare;
    property OnDeletion;
    property OnEdited;
    property OnEditing;
    property OnEnter;
    property OnExit;
    property OnInsert;
    property OnDragDrop;
    property OnDragOver;
    property DragCursor;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnSelectionChanged;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property TabOrder;
    property TabStop default True;
    property Regional;
    property ViewStyle;
    property Visible;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property Options;
    property FlatScrollBars;
    property FullDrag;
    property HotTrackStyles;
    property Version : TDCVersion read FVersion write FVersion stored false;
    {$IFDEF D4}
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property Constraints;
    property DragKind;
    property OwnerData;
    property OwnerDraw;
    property ParentBiDiMode;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDrawItem;
    property OnEndDock;
    property OnResize;
    property OnSelectItem;
    property OnStartDock;
    {$ENDIF}

  end;

  TDCGridSource= class(TDCCollectSource)
  public
    procedure GetItems(ObjID:Integer;Iterator:TIteratorProc); override;
    procedure Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
    function  ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
  end;

{  TDBGridCollEdit   = class(TDCTreeEdit)
  public
    function  GetValue : string; override;
    procedure Edit; override;
  end;
}

procedure EditDatasetFields(Dataset : TDataset);
procedure AddFields(Comp:TPersistent);
procedure AddAllColumns(Comp:TPersistent);
procedure RestoreDefault(Comp:TPersistent);
procedure EditFields(Comp:TPersistent);
function  ValidBookmark(Dataset:TDataset;Mark:Pointer):boolean;

implementation

type
  TDCGrid= class(TCustomDbGrid);

function ValidBookmark(Dataset:TDataset;Mark:Pointer):boolean;
begin
  {$IFDEF D3}
    result := (Mark <> nil) and Dataset.BookmarkValid(Mark);
  {$ELSE}
  with Dataset do
  begin
    Result := (Mark <> nil) and (Handle <> nil);
    if Result then
    begin
      CursorPosChanged;
      Result := (DbiSetToBookmark(Handle, Mark) = DBIERR_NONE) and
      (DbiGetRecord(Handle, dbiNOLOCK, nil, nil) = DBIERR_NONE)
    end;
  end;
  {$ENDIF}
end;

{------------------------------------------------------------------}

function BookmarksCompare(Dataset:TDataset;Bookmark1,Bookmark2:Pointer):integer;
begin
  {$IFDEF D3}
    result := Dataset.CompareBookmarks(Bookmark1,Bookmark2);
  {$ELSE}
    DbiCompareBookmarks(Dataset.Handle, Bookmark1,Bookmark2,result);
    if result = 2 then
      result:=0;
  {$ENDIF}
end;


{$IFDEF WITHPARAMS}
type

  TParamData=class(TDCTreeData)
  private
    FIsNull:boolean;
  public
    procedure SetIsNull(Value:Boolean);
    function GetDataType:TFieldType;
    procedure SetDataType(Value:TFieldType);
    function GetCaption:string; override;
    procedure SetCaption(Value:string);
    function GetParamType:TParamType;
    procedure SetParamType(Value:TParamType);
    function GetText:string;
    procedure SetText(Value:string);
  published
    property DataType:TFieldType Read GetDatatype Write SetDataType;
    property IsNull:boolean Read FIsNull Write SetIsNull Stored False;
    property Name :string Read GetCaption Write SetCaption;
    property ParamType:TParamType Read GetParamType Write SetParamType;
    property Text:string Read GetText Write SetText;
  end;


{----------TParamData----------------------------------------------}

procedure TParamData.SetIsNull(Value:Boolean);
begin
  if Assigned(Link) and Value  then
     TParam(Link).Clear;
  FIsNull:=Value;
end;

{------------------------------------------------------------------}

function TParamData.GetDataType:TFieldType;
begin
  if Assigned(Link) then
    result:=TParam(Link).DataType
  else
    result:=ftUnknown;
end;

{------------------------------------------------------------------}

procedure TParamData.SetDataType(Value:TFieldType);
begin
  if Assigned(Link) then
    TParam(Link).DataType:=Value;
end;

{------------------------------------------------------------------}


function TParamData.GetCaption:string;
begin
   if Assigned(Link) then
     result:=TParam(link).Name
   else
     result:='';
end;

{------------------------------------------------------------------}

procedure TParamData.SetCaption(Value:string);
begin
  if Assigned(Link) then
    TParam(link).Name:=Value;
end;

{------------------------------------------------------------------}

function TParamData.GetParamType:TParamType;
begin
  if Assigned(Link) then
    result:=TParam(link).ParamType
  else
    result:=ptUnknown;
end;

{------------------------------------------------------------------}

procedure TParamData.SetParamType(Value:TParamType);
begin
  if Assigned(Link) then
    TParam(link).ParamType:=Value;
end;

{------------------------------------------------------------------}

function TParamData.GetText:string;
begin
  if Assigned(Link) then
    result:=TParam(link).Text
  else
    result:='';
end;

{------------------------------------------------------------------}

procedure TParamData.SetText(Value:string);
begin
  if Assigned(Link) then
    TParam(link).Text:=Value;
end;

{----------------TDCParamSource------------------------------------}

procedure TDCParamSource.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (operation= opRemove)  and (Acomponent = GetTreeLink) then
    FParams := nil;
  inherited;
end;

{------------------------------------------------------------------}

procedure  TDCParamSource.SetParams(Value : TParams);
begin
  if FParams <> Value then
  begin
    FParams :=Value;
    RefreshEditor;
  end;
end;

{---to avoid c++builder1 internal error in compile process---------}

function   TDCParamSource.GetLink : TPersistent;
begin
  result := GetTreeLink;
end;

{------------------------------------------------------------------}

procedure  TDCParamSource.SetLink(Value : TPersistent);
begin
  SetTreeLink(Value);
end;

{------------------------------------------------------------------}

procedure TDCParamSource.SetPropName(Value:string);
begin
  if FpropName <> Value then
  begin
    FPropName:=Value;
    _Refresh;
  end;
end;

{------------------------------------------------------------------}

procedure TDCParamSource._Refresh;
var
  Info: PPropInfo;
begin
   FParams:=nil;
   ClearSortedList(FTreeData);
  if Link <> nil  then
   begin
     Info:=GetPropInfo(Link.ClassInfo,FPropName);
     if Assigned(Info) then
       FParams:=TParams(GetOrdProp(Link,Info));
   end;
   RefreshEditor;
end;


{------------------------------------------------------------------}

procedure  TDCParamSource.ObjectInserted(ObjId:integer);
begin
  if FindLink(ObjId) = nil then
     FtreeData.Add(TParamData.Create(TPersistent(ObjId)));
end;

{------------------------------------------------------------------}

procedure TDCParamSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
  i:integer;
begin
  if not Assigned(FParams) then
    Exit;
  inherited;
  if ObjId=0 then
    with FParams do
       for i:= 0 to Count-1 do
       begin
          Iterator(GetNodeRec(integer(Items[i]),-1,Self,Items[i].Name));
          ObjectInserted(integer(Items[i]));
       end;
end;

{------------------------------------------------------------------}

procedure TDCParamSource.SetCaption(ObjID:Integer; const Caption:string);
begin
  if ObjID<>0 then
  begin
    TParam(ObjId).Name:=Caption;
    inherited;
  end;
end;

{------------------------------------------------------------------}

function NewParamname(Params:TParams):String;
Var
  Number:Integer;

  function PName:String;
  begin
    Result:='Param'+IntToStr(Number) //don't resource
  end;

  function ParamFound(Const ParamName:String):Boolean;
  Var
    i:Integer;
  begin
    Result:=False;
    For i:=0 to Params.Count-1 do
      If CompareText(Params[i].Name,ParamName)=0 then
      begin
        Result:=True;
        break;
      end;
  end;

begin
  Number:=1;
  While ParamFound(PName) do
    inc(Number);
  Result:=PName;
end;

{------------------------------------------------------------------}

procedure TDCParamSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
var
  Param:TParam;
  result:integer;
begin
  if FParams = nil then
    exit;
  case InsertType of
    naAddFirst, naAdd:
    begin
      Param:=TParam.Create(FParams, ptUnknown);
      Param.Name:=NewParamName(FParams);
      result:=integer(Param);
    end
    else
      result:=0;
  end;
  if result <> 0 then
  begin
    FTreeData.Add(TParamData.Create(TPersistent(result)));
    DoAfterInsert(result,ObjId,Caption,InsertType);
  end;
end;

{------------------------------------------------------------------}

procedure TDCParamSource.Clear;
begin
  ClearSortedList(FTreeData);
  if Assigned(FParams) then
  begin
    while FParams.Count >0 do
      FParams.Items[0].Free;
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TDCParamSource.Delete(ObjID:Integer);
begin
  SetSelectedObject(0);
  if objId<>0 then
  begin
    RemoveSortedItem(FTreeData,(FindLink(ObjId)));
    TParam(ObjID).Free;
  end;
  inherited;
end;

{------------------------------------------------------------------}

function  TDCParamSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := not (Action in [acShowListView,acRefreshDelete,acCanHaveChild,acCanAddChild,
                             acShowLines,acCanDrag, acShowModal,acMultiSelect]);
end;

{------------------------------------------------------------------}

function  TDCParamSource.CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;
begin
  result:=true;
end;

{------------------------------------------------------------------}

function  TDCParamSource.GetDisplayName(ObjID:integer):string;
begin
  if ObjId <>0 then
    result:=TParam(ObjId).Name
  else
    result:='';
end;

{$ENDIF}

{------------------------------------------------------------------}
type
  TMColumn = class(TColumn);

procedure TDCGridSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
  i:integer;
begin
  if not Assigned(Collection) then
    Exit;
  if ObjId=0 then
    With Collection do
      for i:= 0 to Count-1 do
       {$IFDEF D4}
         if  TMColumn(Items[i]).IsStored then
       {$ELSE}
         if  CompareText(Items[i].Classname , 'TPassthroughColumn') <>0 then //don't resource
       {$ENDIF}
          Iterator(GetNodeRec(integer(Items[i]),-1,Self,GetColItemDisplayName(Items[i])));
end;

{------------------------------------------------------------------}

procedure TDCGridSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
begin
  if InsertType in  [naAddChildFirst,naAddChild] then
    AddAllColumns(Self)
  else
    inherited;
end;

{------------------------------------------------------------------}

function  TDCGridSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := inherited ActionAllowed(ObjId,Action) or  (Action = acCanAddChild);
end;

{----------------TDCFieldSource------------------------------------}

function GetDsDesigner(Dataset : TDataset):TDataSetDesigner;
begin
  result := Dataset.Designer;
  if result = nil then
    result := TDataSetDesigner.Create(DataSet);
end;

{------------------------------------------------------------------}

procedure TDCFieldSource.BeginDesign;
begin
  GetDsDesigner(Dataset).BeginDesign;
end;

{------------------------------------------------------------------}

procedure TDCFieldSource.EndDesign;
begin
  GetDsDesigner(Dataset).EndDesign;
end;

{------------------------------------------------------------------}

procedure TDCFieldSource.SetDataset(Value:TDataset);
begin
  SetTreeLink(Value);
end;
{------------------------------------------------------------------}

function  TDCFieldSource.GetDataset:TDataset;
begin
  result:=TDataset(GetTreeLink);
end;

{------------------------------------------------------------------}

procedure TDCFieldSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
    i:integer;
begin
  if not ValidSource then
    Exit;
  if ObjId=0 then
    with Dataset do
    begin
      BeginDesign;
      try
        for i:= 0 to FieldCount-1 do
          Iterator(GetNodeRec(integer(Fields[i]),-1,Self,Fields[i].DisplayName));
      finally
        EndDesign;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFieldSource.SetCaption(ObjID:Integer; const Caption:string);
begin
  if ObjID<>0 then
  begin
    TField(ObjId).DisplayLabel:=Caption;
    inherited;
  end;
end;


{------------------------------------------------------------------}

function TDCFieldSource.IsMyItem(C:TPersistent):boolean;
begin
  result := (C is TField) and (TField(C).Dataset = Dataset)
end;

{------------------------------------------------------------------}

procedure TDCFieldSource.CMPROPCHANGED(var M:TMessage);
var
  Item:TPersistent;
  R:PNodeRec;
  i:integer;
  Lst:TList;
begin
  if  M.LParam = 0 then
    exit;
  Lst:=TList.Create;
  try
    for i:= 0 to TList(M.wparam).Count-1 do
    begin
      Item:=TPersistent(TList(M.wparam).Items[i]);
      if IsMyItem(Item) and
      ((CompareText(pchar(M.LParam),'FieldName')=0) or (CompareText(pchar(M.LParam),'DisplayLabel')=0))then  //don't resource
      begin
        new(R);
        FillChar(R^,SizeOf(R^),0);
        R^.Caption:=TField(Item).DisplayName;
        R^.ObjId:=integer(Item);
        Lst.Add(R);
       end;
    end;
    if Lst.Count >0 then
      SendNotify(integer(Lst),TSOBJECTCHANGED);
  finally
    DisposeList(Lst);
  end;
end;

{------------------------------------------------------------------}

function AddFieldToDataSet(DSet:TDataset;F:TField):TField;
begin
  With F do
    Name:=UniqueName(DSet.Owner,DSet.Name + RemoveNonIdentChars(FieldName));
  result:=F;
end;

{------------------------------------------------------------------}

procedure AddFields(Comp:TPersistent);
Var
  U:TStringList;
  i:Integer;
  DataSet:TDataSet;
begin
  if not (Comp is TDCFieldSource) then
    Exit;
  DataSet:=TDCFieldSource(Comp).DataSet;
  if not Assigned(Dataset) then
    Exit;
  U:=TStringList.Create;
  With Dataset do
  begin
    FieldDefs.Update;
    GetDsDesigner(Dataset).BeginDesign;
    try
      for i := 0 to FieldDefs.Count - 1 do
        if FindField(FieldDefs[i].Name) = nil then
          U.AddObject(FieldDefs[i].Name, FieldDefs[i]);
      If FilterStringsForm(U,SCapAddFields,0,[uoSelectAll]) then
        for i := 0 to U.Count - 1 do
          with TFieldDef(U.Objects[i]) do
             AddFieldToDataSet(Dataset,CreateField(DataSet.Owner));
    finally
      U.Free;
      GetDsDesigner(Dataset).EndDesign;
    end;
    TDCFieldSource(Comp).RefreshEditor;
  end;
end;

{------------------------------------------------------------------}

function TDCFieldSource.NewField(Dataset:TDataset):TField;
Var
  AClass : TFieldClass;
  F : TField;
begin
  result:=nil;
  if not Assigned(Dataset) then
    Exit;
  With TNewFieldForm.Create(Application) do
  try
    If (ShowModal=mrOk)  then
    begin
      BeginDesign;
      try
        AClass := TFieldClass(FindClass(ClassPrefix + FieldTypeCombo.Text + 'Field' )); //don't resource
        if AClass <> nil then
          with Dataset do
          begin
            if FindField(FieldNameEdit.Text) <> nil then
              raise Exception.Create(Format(serrNameAlredyExists,[FieldNameEdit.Text]));
            F:=AClass.Create(Owner);
            F.FieldName := FieldNameEdit.Text;
            F.Dataset:=Dataset;
            result:=AddFieldToDataSet(DataSet,F);
          end;
      finally
        EndDesign;
      end;
    end;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFieldSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
var
   ind:integer;
   Field:TField;
   result:integer;
begin
  result:=0;
  ind:=0;
  if not ValidSource then
     Exit;
  if ObjID<>0 then
    ind:=TField(ObjId).Index;
  case InsertType of
    naInsert:
    begin
      Field:=NewField(DataSet);
      if Assigned(Field) then
        Field.Index:=ind;
      result:=integer(Field);
    end;
    naAddFirst, naAdd:
      result:=integer(NewField(DataSet));
    naAddChildFirst,naAddChild:
    begin
      AddFields(self);
      result:=0;
    end;
  end;
  if result <> 0 then
    DoAfterInsert(result,ObjId,Caption,InsertType);
end;


{------------------------------------------------------------------}

procedure TDCFieldSource.Clear;
begin
  if ValidSource then
  with Dataset do
  begin
    BeginDesign;
    try
      while FieldCount > 0 do
        Fields[0].Free;
    finally
      EndDesign;
    end;
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFieldSource.Delete(ObjID:Integer);
begin
  SetSelectedObject(0);
  try
    if objId<>0 then
    begin
      BeginDesign;
      try
        TField(ObjID).Free;
      finally
        EndDesign;
      end;
    end;
  finally
    inherited;
  end;  
end;

{------------------------------------------------------------------}


procedure TDCFieldSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  R:TNodeRec;
begin
  if ValidSource then
  begin
    if (ObjID<>0) and (DestId<>0)  and CanMove(ObjID,DestID,InsertType) then
    if InsertType = naInsert then
    begin
      if TField(ObjID).Index<TField(DestID).Index then
         TField(ObjID).Index:=TField(DestID).Index-1
      else
         TField(ObjID).Index:=TField(DestID).Index;
    end
    else
      TField(ObjID).Index:=Dataset.FieldCount-1;
    R.Caption := '';
    FillChar(R,sizeOf(R),0);
    R.ObjId  := ObjId;
    R.DestId := DestId;
    R.InsertType:=InsertType;
    R.Caption:=TField(ObjID).DisplayName;
    SendNotify(integer(@R),TSMOVETO);
 end;
 inherited;
end;

{------------------------------------------------------------------}

function TDCFieldSource.GetInspectorControl(ObjID:Integer):TPersistent;
begin
  result:=TField(ObjId);
end;

{------------------------------------------------------------------}

function  TDCFieldSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := not (Action in [acShowListView,acRefreshDelete,acCanHaveChild,{acCanAddChild,}
                           acShowLines,acShowModal]);
end;

{------------------------------------------------------------------}

function  TDCFieldSource.GetDisplayName(ObjID:integer):string;
begin
  if ObjId <>0 then
    result:=TField(ObjId).DisplayName
  else
    result:='';
end;

{------------------------------------------------------------------}

function  TDCFieldSource.HasChild(objId:integer):boolean;
begin
  result:=false;
  if ValidSource and (ObjId = 0) then
    result:= Dataset.FieldCount > 0;
end;

{-----------------TDCDataSetSource----------------------------------}

function TBookList.CompareWithKey(Item,Key:Pointer):Integer;
begin
  result :=  TBookRec(Item).Id - Integer(Key);
end;

{------------------------------------------------------------------}

function TBookList.Compare(Item1, Item2: Pointer):integer;
begin
  result :=  TBookRec(Item1).Id - TBookRec(Item2).Id;
end;

{------------------------------------------------------------------}

type
  TFDataset = class(TDataset);

constructor TBookRec.Create(ObjId,Parent:Integer;Mark:TBookMarkStr);
begin
  inherited Create;
  Id:=ObjId;
  ParentId:=Parent;
  BookMark:=Mark;
end;

{------------------------------------------------------------------}

constructor TDCDataSetSource.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FRoot:=-1;
  FBookMarkList := TBookList.Create;
  FDataLink := TFieldDataLink.Create;
  FSelRec := TBookRec.Create(0,0,'');
  with FDatalink do
  begin
    OnDataChange := DataChange;
    OnEditingChange := EditingChange;
    OnUpdateData := UpdateData;
    OnActiveChange:=ActiveChanged;
  end;
end;

{------------------------------------------------------------------}

destructor TDCDataSetSource.Destroy;
begin
  FreeSortedlist(FBookMarkList,FBookMarkList);
  FDataLink.Free;
  FDataLink := nil;
  FSelRec.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.Loaded;
begin
  inherited;
  SmartRefreshEditor;
end;

{------------------------------------------------------------------}

procedure  TDCDataSetSource.SmartRefreshEditor;
begin
  if ComponentState *[csReading,csLoading] = [] then
  begin
    RefreshEditor;
    if ValidFields then
      _DoSelectChanged(ObjectIndex);
  end;
end;


{------------------------------------------------------------------}

procedure TDCDataSetSource.SetRoot(Value:integer);
begin
  if Froot<> Value then
  begin
    FRoot:=Value;
    SmartRefreshEditor;
  end;
end;

{------------------------------------------------------------------}

function TDCDataSetSource.GetDataSource:TDatasource;
begin
  result := TDataSource(GetTreeLink);
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetDataSource(Value:TDatasource);
begin
  if FTreeLink <> Value then
  begin
    SetTreeLink(Value);
    if Value <> nil then
      FDataset := Value.Dataset;
    FDataLink.DataSource := Value;
    ClearSortedList(FBookMarkList);
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetDisplayField(Value:string);
begin
  if  FDisplayField  <>  Value then
  begin
    FDisplayField:= Value;
    FDataLink.FieldName := Value;
    SmartRefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetRootIndexField(Value:string);
begin
  if  FRootIndexField  <>  Value then
  begin
    FRootIndexField:= Value;
    SmartRefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetObjectIndexField(Value:string);
begin
  if  FObjectIndexField  <>  Value then
  begin
    FObjectIndexField:= Value;
    SmartRefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetImageIndexField(Value:string);
begin
  if  FImageIndexField  <>  Value then
  begin
    FImageIndexField:= Value;
    SmartRefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetSelectedIndexField(Value:string);
begin
  if  FSelectedIndexField  <>  Value then
  begin
    FSelectedIndexField:= Value;
    SmartRefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetStateIndexField(Value:string);
begin
  if  FStateIndexField  <>  Value then
  begin
    FStateIndexField:= Value;
    SmartRefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetDisplayText(Value : string);
begin
  Fdataset.FieldByName(FDisplayField).AsString := Value;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetRootIndex(Value : integer);
begin
  Fdataset.FieldByName(FRootIndexField).AsInteger := Value;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetObjectIndex(Value : integer);
begin
  Fdataset.FieldByName(FObjectIndexField).AsInteger := Value;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.GetRootIndex   : integer;
begin
  result := Fdataset.FieldByName(FRootIndexField).AsInteger;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.GetObjectIndex : integer;
begin
  result := Fdataset.FieldByName(FObjectIndexField).AsInteger;
end;

{------------------------------------------------------------------}

function TDCDataSetSource.GetAttrCount : integer;
begin
  if MultiColumn and (FDataSet <> nil) then
    result := Datasource.Dataset.FieldCount - 1
  else
    result := 0;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.CheckAttrIndex(var Index : integer);
begin
  if MultiColumn and ValidFields then
    with FDataSet do
      if FieldByName(DisplayField).Index <= Index  then
        inc(Index);
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetMultiColumn(Value : boolean);
begin
  if FMultiColumn <> Value then
  begin
    FMultiColumn := Value;
    SmartRefreshEditor;
  end;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.GetAttrName(Index: Integer): string;
begin
  if MultiColumn and (FDataSet <> nil) then
    with FDataSet do
    begin
      CheckAttrIndex(Index);
      result := Fields[Index].FieldName
    end
  else
    result := '';
end;

{------------------------------------------------------------------}

function   TDCDataSetSource.GetAttrValue(ObjId , Index : Integer): string;
begin
  result := '';
  if MultiColumn and ValidFields and (ObjId <> 0) then
    with FDataset do
    begin
      CheckAttrIndex(Index);
      if ObjectIndex = TBookRec(ObjId).Id then
        result := Fields[Index].AsString
      else
        result := Lookup(ObjectIndexField, TBookRec(ObjId).Id, Fields[Index].FieldName)
  end
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.GetDisplayText : string;
var
  s : string;
  i : integer;
begin
  result := FDataset.FieldByName(FDisplayField).AsString;
  if MultiColumn then
  begin
    s := '';
    for i := 0 to GetAttrCount - 1 do
    begin
      if s = '' then
        s := s + GetAttrValue(SelectedObject, i)
      else
        s := s + '|' + GetAttrValue(SelectedObject, i);
    end;
    if s <> '' then
      result := result + '|' + s;
  end;    
end;


function  TDCDataSetSource.GetBookRecFromId(Id:integer):TBookRec;
var
  b:TBookMarkStr;
begin
  result:=nil;
  if ValidFields then
    with FDataset do
    begin
      if ObjectIndex = Id then
        result := TBookRec.Create(Id,RootIndex,BookMark)
      else
      begin
        B:=BookMark;
        BeginUpdate;
        try
          if Locate(FObjectIndexField,id,[]) then
            result := TBookRec.Create(Id,RootIndex,BookMark);
        finally
          BookMark:=B;
          EndUpdate;
        end;
      end;  
    end;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.FindBookRec(Id:integer):TBookRec;
var
  Index:integer;
  B:TBookRec;
begin
 result := nil;
 with FBookMarkList do
 begin
   if not FindByKey(Pointer(Id),Index) then
   begin
     B:=GetBookRecFromId(Id);
     if B <> nil then
       result:= Items[Add(B)];
   end
   else
     result := Items[Index];
 end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.SetImageInfo(var R:TNodeRec);
var
  F:TField;
begin
  with FDataset do
  begin
    F:= FindField(FImageIndexField);
    if (F <> nil) and not F.IsNull then
       R.ImageIndex := F.Value;
    F:=FindField(FSelectedIndexField);
    if (F <> nil) and not F.IsNull then
       R.SelectedIndex := F.Value;
    F:=FindField(FStateIndexField);
    if (F <> nil) and not F.IsNull then
       R.StateIndex := F.Value;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);

{-------------------------------------------------------}

  procedure IterateLevel(RootID:integer);
  var
    OldFilter   : string;
    Fs          : string;
    OldFiltered : boolean;
    B           : TBookMarkStr;
    R           : TNodeRec;
  begin
    with FDataset do
      begin
        CheckBrowseMode;
        OldFilter:= Filter;
        OldFiltered:=Filtered;
        B:=BookMark;
        try
          Fs := FRootIndexField +'='+ IntToStr(RootId);
          if OldFiltered  and (OldFilter <> '') then
            Filter := '(' + OldFilter + ')' + ' and ' + '(' + Fs + ')' //don't resource
          else
            Filter:= Fs;
          Filtered:=true;
          first;
          while not eof do
          begin
            R:=GetNodeRec(integer(FindBookRec(ObjectIndex)),-1,Self, DisplayText);
            SetImageInfo(R);
            Iterator(R);
            next;
          end;
        finally
          Filtered:=OldFiltered;
          Filter:=OldFilter;
          if ValidBookmark(Fdataset,Pointer(B)) and (BookmarksCompare(Fdataset,Pointer(BookMark), Pointer(B)) <>0) then
            BookMark:=B;
          EnableControls;
        end;
      end;
  end;

  {-------------------------------------------------------}

begin
  if  ValidFields  then
    with FDataset do
    begin
      BeginUpdate;
      try
        if ObjId=0 then
          IterateLevel(FRoot)
        else
        if HasChild(ObjId) then
          IterateLevel(TBookRec(ObjId).Id);
      finally
        EndUpdate;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.ObjectChanged(ObjID:Integer; const Caption:string);
var
  R:TNodeRec;
  Lst:TList;
begin
   Lst:=TList.Create;
   try
     Fillchar(R,Sizeof(R),0);
     R.Caption:=Caption;
     R.ObjId:=ObjID;
     SetImageInfo(R);
     Lst.Add(@R);
     SendNotify(integer(Lst),TSOBJECTCHANGED);
   finally
     Lst.Free;
   end;
   DesignerModified(GettreeLink);
end;

{------------------------------------------------------------------}

procedure  TDCDataSetSource.SetCaption(ObjID:Integer; const Caption:string);
var
  B:TBookMarkStr;
  s : string;
begin
  s:=caption;
  if ValidFields and (ObjId <> 0 ) then
    with FDataset do
      if ValidBookMark(Fdataset,Pointer(TBookRec(ObjId).BookMark)) then
      begin
        B:=BookMark;
        try
          Bookmark:= TBookRec(ObjId).BookMark;
          try
            Edit;
            DisplayText := Caption;
            Post;
          except
            Cancel;
            raise;
          end;
        finally
          if (BookmarksCompare(FDataset,Pointer(BookMark), Pointer(B)) <>0) then
            BookMark:=B;
        end;
        ObjectChanged(ObjId,s);
      end;
end;

{------------------------------------------------------------------}

procedure  TDCDataSetSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
var
  ParentIndex:integer;
begin
  if ValidFields  then
    with FDataset do
    begin
     if ObjId = 0 then
       ParentIndex := FRoot
     else
     if InsertType in [naAddFirst, naAdd, naInsert] then
        ParentIndex:=Lookup(FObjectIndexField,TBookRec(ObjId).Id,FRootIndexField)
     else
        ParentIndex:=TBookRec(ObjId).Id;
      Insert;
      RootIndex := ParentIndex;
      DisplayText := Caption;
      if FieldByName(FObjectIndexField).IsNull then
         ObjectIndex := MaxKeyFieldValue;
      inc(MaxKeyFieldValue);
      Post;
    end;

end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.Clear;
begin
  if ValidSource then
    with FDataset do
    begin
      BeginUpdate;
      try
        first;
        while not(eof) do delete;
      finally
        EndUpdate;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.Delete(ObjID:Integer);

  {-------------------------------------------------------}

  procedure DeleteWithChild(Id:integer;Mark:TBookMarkStr);
  var
    B:TBookMarkStr;
    curid : integer;
  begin
    with FDataset do
    begin
      B:=BookMark;
      while Locate(FRootIndexField,Id,[]) do
        DeleteWithChild(ObjectIndex,B);
      curid :=ObjectIndex;
      FDataset.Delete;
      ObjectDeleted(curid);
      if ValidBookMark(Fdataset,Pointer(Mark)) then
        BookMark:=Mark;
    end;
  end;

  {-------------------------------------------------------}

begin
  if ValidSource and (ObjId <> 0) then
    with FDataset  do
      if ValidBookMark(FDataset,Pointer(TBookRec(ObjId).BookMark)) then
      begin
        BeginUpdate;
        try
          BookMark := TBookRec(ObjId) .BookMark;
          with TBookRec(ObjId) do
            DeleteWithChild(ID,BookMark);
          inherited;
        finally
          EndUpdate;
        end;
      end;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
var
  res : boolean;
begin
  result := not (Action in [acRefreshDelete,acShowModal,acSelectInspector]);
  if not result then
    exit;
  res := not (Action in [acCanClear, acCanDelete,acCanAdd,acCanAddChild,acCanDrag,acCanEdit]);
  if FDataset <> nil then
  begin
    if not FDataset.CanModify  then
      result := res;
    if not result then
      exit;
  end
  else
    result := res;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.InternalMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  R:TNodeRec;
begin
  FillChar(R,sizeOf(R),0);
  R.ObjId  := ObjId;
  R.DestId := DestId;
  R.InsertType:=InsertType;
  R.Caption:=DisplayText;
  SendNotify(integer(@R),TSMOVETO);
end;

{------------------------------------------------------------------}

procedure  TDCDataSetSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  ParentIndex: integer;
begin
  if ValidFields and (ObjID<>0) and (DestId<>0)  and CanMove(ObjID,DestID,InsertType) then
    with FDataset do
    begin
      if DestId = 0 then
        ParentIndex := FRoot
      else
      if InsertType in [naAddFirst, naAdd, naInsert] then
         ParentIndex:=Lookup(FObjectIndexField,TBookRec(DestId).Id,FRootIndexField)
      else
         ParentIndex:=TBookRec(DestId).Id;
      BeginUpdate;
      try
        BookMark := TBookRec(ObjId).BookMark;
        Edit;
        RootIndex := ParentIndex;
        Post;
        TBookRec(ObjId).BookMark:=BookMark;
        TBookRec(ObjId).ParentId :=ParentIndex;
      finally
        EndUpdate;
      end;
      InternalMove(ObjId,DestId,InsertType);
    end;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.GetDisplayName(ObjID:integer):string;
begin
  result:='';
  if ValidFields and (ObjId<> 0)then
    with FDataset do
      result:= Lookup(FObjectIndexField,TBookRec(ObjId).Id,FDisplayField);
end;


{------------------------------------------------------------------}

function  TDCDataSetSource.ValidSource:boolean;
begin
  result:= (inherited  ValidSource) and Assigned(FDataset) and FDataset.Active;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.ValidFields:Boolean;
begin
  result := ValidSource;
  if Result then
    with FDataset do
      result:= (FDataset.FindField(FRootIndexField)<> nil)  and  (FindField(FDisplayField)<> nil)
        and (FindField(FObjectIndexField) <> nil );
end;


{------------------------------------------------------------------}

procedure  TDCDataSetSource.SetSelectedObject(value:integer);
begin
  inherited;
  if ValidFields and (Value <> 0 ) and (FUpdateCount <= 0)  then
    with FDataset do
      if  (ValidBookMark(FDataset,Pointer(TBookRec(Value).BookMark)) ) and
          (BookmarksCompare(FDataset,Pointer(BookMark),Pointer(TBookRec(Value).BookMark)) <> 0 ) then
          BookMark:=TBookRec(Value).BookMark;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.GetSelectedObject : integer ;
begin
  if ValidFields then
    result := integer(FindBookRec(ObjectIndex))
  else
    result := inherited GetSelectedObject;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.HasChild(objId:integer):boolean;
var
  V:Variant;
begin
  result:=false;
  if (ValidFields)  then
    with FDataset  do
      if ObjId = 0 then
        result:=Lookup(FRootIndexField,FRoot,FObjectIndexField)<> Null
      else
      begin
        V:= Lookup(FRootIndexField,TBookRec(ObjId).Id,FObjectIndexField);
        result := (V <> Null) and (V <>TBookRec(ObjId).Id);
      end;

end;

{------------------------------------------------------------------}
procedure TDCDataSetSource.BeginUpdate ;
begin
  inc(FUpdateCount);
  if ValidSource then
    FDataset.DisableControls;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.EndUpdate ;
begin
  if ValidSource and FDataset.ControlsDisabled then
    FDataset.EnableControls;
  dec(FUpdateCount);
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.ObjectDeleted(ObjId:integer);
var
  Index:integer;
begin
  with FBookMarkList do
   if (objId <> 0 ) and FindByKey(Pointer(ObjId),Index) then
   begin
     TObject(Items[Index]).Free;
     Delete(Index);
   end;
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.GetParentId(ObjId:integer):integer;
var
  B:TBookRec;
begin
  result := 0;
  if (ValidFields) and (ObjId <> 0) then
    with FDataset, FBookMarkList do
    begin
      B:=FindBookRec(TBookRec(ObjId).Id);
      if B <> nil then
        result := Integer(FindBookRec(B.ParentId));
    end;
end;

{------------------------------------------------------------------}

function TDCDataSetSource.CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;
begin
  result := inherited CanMove(ObjId,DestId,InsertType) and
  (ObjId <> 0) and (DestId <> 0) and
  ((InsertType in [naAddChild, naAddChildFirst]) or (TBookRec(ObjId).ParentID <> TBookRec(DestId).ParentID));
end;

{------------------------------------------------------------------}

function  TDCDataSetSource.GetParentIndex(ObjId:integer):integer;
var
  V:Variant;
begin
  result := 0;
  if (ObjId = ObjectIndex) and (ObjId <> RootIndex)  then
    result := RootIndex
  else
    with FDataset do
    begin
      V:= Lookup(FObjectIndexField,ObjId,FRootIndexField);
      if (V <> Null) and (V  <> ObjId) then
        result := V;
    end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource._DoAfterInsert(ObjId:integer);
var
  RootIdx : integer;
  Index   : integer;
begin
  if ValidFields and (ObjId <> 0) then
  begin
    RootIdx := GetParentIndex(ObjId);
    if (RootIdx = FRoot) or FBookMarkList.FindByKey(Pointer(RootIdx),Index) then
      with FDataset do
      begin
        R1.Caption := '';
        fillchar(R1,sizeOf(R1),0);
        with R1 do
        begin
          TreeSource:=Self;
          Data := Self;
          if RootIdx <> FRoot then
          begin
             RootId := integer(FindBookRec(RootIdx));
             InsertType :=naAddChild
          end
          else
          begin
            InsertType  := naAdd;
            RootId:= -1;
          end;
          Caption := DisplayText;
        end;
        R1.ObjId  := integer(FindBookRec(ObjId));
        PostNotify(integer(@R1),TSINSERT);
        PostNotify(integer(@R1),TSSELCHANGED);
      end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource._DoSelectChanged(ObjId:integer);
begin
  R2.Caption := '';
  fillChar(R2,sizeof(R2),0);
  R2.Data := Self;
  R2.ObjId:= Integer(FindBookRec(ObjId));
  PostNotify(integer(@R2),TSSELCHANGED);
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.CheckBookRec(B:TBookrec);
var
  FirstChild : integer;
begin
  with FDataset do
  begin
    if B.Id <> ObjectIndex then
    begin
      FBookMarkList.Remove(B);
      B.Id := ObjectIndex;
      FBookMarkList.Add(B);
    end;
    B.BookMark := BookMark;
    if B.ParentId <> RootIndex then
    begin
      BeginUpdate;
      try
        if RootIndex <> FRoot then
          InternalMove(integer(B),integer(FindBookRec(RootIndex )),naAddChild)
        else
        begin
          FirstChild := Lookup(FRootIndexField,FRoot,FObjectIndexField);
          InternalMove(integer(B),integer(FindBookRec(FirstChild)),naAdd);
        end;
        B.ParentId := RootIndex;
      finally
        EndUpdate;
      end;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource._DoEditChanged(ObjId:integer);
var
  R:TNodeRec;
  Index:Integer;
  Lst:TList;
begin
  if  ValidSource then
  begin
    Lst:=TList.Create;
    try
      with FDataset,FBookMarkList do
        if FindByKey(Pointer(ObjId),Index) then
        begin
          fillchar(R,SizeOf(R),0);
          R.Caption:=DisplayText;
          R.ObjId:=Integer(Items[Index]);
          SetImageInfo(R);
          Lst.Add(@R);
          SendNotify(integer(Lst),TSOBJECTCHANGED);
          CheckBookRec(Items[Index]);
        end;
    finally
      Lst.Free;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource._DoAfterDelete(ObjId:integer);
var
  Index:integer;
  R:TNodeRec;
begin
  with FBookMarkList do
    if FindByKey(Pointer(ObjId),Index) then
    begin
      R.Data := nil;
      R.ObjId:=integer(Items[Index]);
      SendNotify(Integer(@R),TSDELETE);
    end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.DataChange(Sender: TObject);
begin
  if not ValidFields  then
   exit;
  if FUpdateCount<=0   then
    with FDataset do
    begin
      case State of
        DsInsert: FInsertFlag:= true;
        DsBrowse:
          begin
            inc(FUpdateCount);
            try
              if FInsertFlag then
                _DoAfterInsert(ObjectIndex)
              else
              if FEditFlag then
                _DoEditChanged(FSelRec.Id)
              else
              with FSelRec do
                if ( Pointer(BookMark) <> nil) and not ValidBookMark(Fdataset,Pointer(BookMark)) then
                begin
                  _DoAfterDelete(Id);
                  _DoSelectChanged(ObjectIndex);
                end
              else
              if ObjectIndex <> FSelRec.ID then
                _DoSelectChanged(ObjectIndex);
              FInsertFlag := false;
              FEditFlag := false;
            finally
              dec(FUpdateCount);
            end;
          end;
      end;
    end;
  if FDataset.State = dsBrowse then
    with FSelRec do
    begin
      Id := ObjectIndex;
      BookMark := FDataset.BookMark;
    end;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.EditingChange(Sender: TObject);
begin
  if (ValidFields) and not (FDataset.State in [dsInsert,dsEdit]) and not FInsertFlag then
    FEditFlag := true;
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.UpdateData(Sender: TObject);
begin
// showmessage('update data ');
end;

{------------------------------------------------------------------}

procedure TDCDataSetSource.ActiveChanged(Sender: TObject);
begin
  if Assigned(DataSource) then
    FDataset := DataSource.Dataset
  else
    FDataset := nil;
  ClearSortedList(FBookMarkList); 
  SmartRefreshEditor;
end;

{--------------TDCDBTreeView-----------------------------------------}

constructor TDCDBTreeView.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FDSSource := TDCDataSetSource.Create(Self);
  Source := FDSSource;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetRoot(Value : integer);
begin
  FDSSource.Root := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetDataSource(Value : TDataSource);
begin
  FDSSource.Datasource:=Value;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetDisplayField(Value :string);
begin
  FDSSource.DisplayField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetRootIndexField(Value :string);
begin
  FDSSource.RootIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetObjectIndexField(Value :string);
begin
  FDSSource.ObjectIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetImageIndexField(Value :string);
begin
  FDSSource.ImageIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetSelectedIndexField(Value :string);
begin
  FDSSource.SelectedIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetStateIndexField(Value :string);
begin
  FDSSource.StateIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetImages(Value : TCustomImageList);
begin
  FDSSource.LargeImages := Value;
  FDSSource.SmallImages := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBTreeView.SetStateImages(Value : TCustomImageList);
begin
  FDSSource.StateImages := Value;
end;

{------------------------------------------------------------------}

function TDCDBTreeView.GetRoot : integer;
begin
  result := FDSSource.Root;
end;

{------------------------------------------------------------------}

function TDCDBTreeView.GetDataSource : TDataSource;
begin
  result := FDSSource.Datasource;
end;

{------------------------------------------------------------------}

function TDCDBTreeView.GetDisplayField : string;
begin
  result := FDSSource.DisplayField;
end;

{------------------------------------------------------------------}

function TDCDBTreeView.GetRootIndexField : string;
begin
  result := FDSSource.RootIndexField;
end;

{------------------------------------------------------------------}

function TDCDBTreeView.GetObjectIndexField : string;
begin
  result := FDSSource.ObjectIndexField;
end;

{------------------------------------------------------------------}

function TDCDBTreeView.GetImageIndexField : string;
begin
  result := FDSSource.ImageIndexField;
end;

{------------------------------------------------------------------}

function TDCDBTreeView.GetSelectedIndexField : string;
begin
  result := FDSSource.SelectedIndexField;
end;

{------------------------------------------------------------------}

function TDCDBTreeView.GetStateIndexField : string;
begin
  result := FDSSource.StateIndexField;
end;

{------------------------------------------------------------------}

function  TDCDBTreeView.GetImages : TCustomImageList;
begin
  result := FDSSource.LargeImages;
end;

{------------------------------------------------------------------}

function  TDCDBTreeView.GetStateImages : TCustomImageList;
begin
  result := FDSSource.StateImages;
end;

{--------------TDCDBListView-----------------------------------------}

constructor TDCDBListView.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FDSSource := TDCDataSetSource.Create(Self);
  Source := FDSSource;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetRoot(Value : integer);
begin
  FDSSource.Root := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetDataSource(Value : TDataSource);
begin
  FDSSource.Datasource:=Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetDisplayField(Value :string);
begin
  FDSSource.DisplayField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetRootIndexField(Value :string);
begin
  FDSSource.RootIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetObjectIndexField(Value :string);
begin
  FDSSource.ObjectIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetImageIndexField(Value :string);
begin
  FDSSource.ImageIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetSelectedIndexField(Value :string);
begin
  FDSSource.SelectedIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetStateIndexField(Value :string);
begin
  FDSSource.StateIndexField := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetLargeImages(Value : TCustomImageList);
begin
  FDSSource.LargeImages := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetSmallImages(Value : TCustomImageList);
begin
  FDSSource.SmallImages := Value;
end;

{------------------------------------------------------------------}

procedure TDCDBListView.SetStateImages(Value : TCustomImageList);
begin
  FDSSource.StateImages := Value;
end;

{------------------------------------------------------------------}

function TDCDBListView.GetRoot : integer;
begin
  result := FDSSource.Root;
end;

{------------------------------------------------------------------}

function TDCDBListView.GetDataSource : TDataSource;
begin
  result := FDSSource.Datasource;
end;

{------------------------------------------------------------------}

function TDCDBListView.GetDisplayField : string;
begin
  result := FDSSource.DisplayField;
end;

{------------------------------------------------------------------}

function TDCDBListView.GetRootIndexField : string;
begin
  result := FDSSource.RootIndexField;
end;

{------------------------------------------------------------------}

function TDCDBListView.GetObjectIndexField : string;
begin
  result := FDSSource.ObjectIndexField;
end;

{------------------------------------------------------------------}

function TDCDBListView.GetImageIndexField : string;
begin
  result := FDSSource.ImageIndexField;
end;

{------------------------------------------------------------------}

function TDCDBListView.GetSelectedIndexField : string;
begin
  result := FDSSource.SelectedIndexField;
end;

{------------------------------------------------------------------}

function TDCDBListView.GetStateIndexField : string;
begin
  result := FDSSource.StateIndexField;
end;

{------------------------------------------------------------------}

function  TDCDBListView.GetLargeImages : TCustomImageList;
begin
  result := FDSSource.LargeImages;
end;

{------------------------------------------------------------------}

function  TDCDBListView.GetSmallImages : TCustomImageList;
begin
  result := FDSSource.SmallImages;
end;

{------------------------------------------------------------------}

function  TDCDBListView.GetStateImages : TCustomImageList;
begin
  result := FDSSource.StateImages;
end;

{-------Common Function----------------------------------------------}

procedure LoadDefaultValue(DbGrid:TCustomDbGrid;ColIndex:Integer);
begin
  if (ColIndex >=0) and (ColIndex<TDCGrid(DbGrid).Columns.Count) then
    with TDCGrid(DbGrid).Columns[ColIndex] do
     begin
       Alignment:=DefaultAlignment;
       Color:=DefaultColor;
       Font.Assign(DefaultFont);
       {$IFDEF D3}
       ImeMode:=DefaultImeMode;
       ImeName:=DefaultImeName;
       {$ENDIF}
       ReadOnly:=DefaultReadOnly;
       Width:=DefaultWidth;
     end;
end;

{------------------------------------------------------------------}

procedure RestoreDefault(Comp:TPersistent);
var
  DbGrid:TCustomDbGrid;
  Column:TColumn;
begin
  if (Comp is TDCGridSource) and (TDCGridSource(Comp).Collection is TDbGridColumns) then
    with TDCGridSource(Comp) do
    begin
      DbGrid:=TDbGridColumns(Collection).Grid;
      Column:=TColumn(GetSelectedObject);
      if Assigned (dbGrid) and Assigned(Column)  then
      begin
        LoadDefaultValue(DbGrid,Column.Index);
        DesignerModified(DbGrid);
      end;
    end;
end;

{------------------------------------------------------------------}

procedure AddAllColumns(Comp:TPersistent);
var
  i:integer;
  Ds:TDataset;
  DbGrid:TDCGrid;
  Collect : TCollection;
  function PassColumns(Columns:TDbGridColumns) : boolean;
  var
    i:integer;
  begin
    result := true;
    for i := 0 to Columns.Count-1 do
     {$IFDEF D4}
     if  TMColumn(Columns.Items[i]).IsStored then
     {$ELSE}
     if  CompareText(Columns.Items[i].Classname , 'TPassthroughColumn') <>0 then //don't resource
     {$ENDIF}
      begin
        result := false;
        break;
      end;
  end;

begin
  if (Comp is TDCGridSource) and (TDCGridSource(Comp).Collection is TDbGridColumns) then
  begin
    Collect :=TDCGridSource(Comp).Collection;
    DbGrid:=TDCGrid(TDbGridColumns(Collect).Grid);
  end
  else
  begin
    Collect:= nil;
    DbGrid:=nil;
  end;
  if not ( Assigned(DbGrid) and Assigned(DbGrid.DataSource)and Assigned(DbGrid.DataSource.DataSet)) then
    Exit;
  if not PassColumns(TDbGridColumns(Collect))  then
  case MessageDlg(SReplaceColumns,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
    mrYes:
    begin
      BroadCastToNotifiers(Comp, CM_SELECTIONCHANGED, 0 , 0);
      for  i:=DbGrid.Columns.Count-1 downto 0 do
         DbGrid.Columns[i].Free;
    end;
    mrCancel:Exit;
  end;
  Ds:=DbGrid.DataSource.DataSet;
  for i:= 0 to Ds.FieldCount-1 do
   with DbGrid.Columns.Add do
   begin
     FieldName:=DS.Fields[i].FieldName;
     Title.Caption:=DS.Fields[i].FieldName;
     Alignment:=DefaultAlignment;
     Color:=DefaultColor;
     Font.Assign(DefaultFont);
     {$IFDEF D3}
     ImeMode:=DefaultImeMode;
     ImeName:=DefaultImeName;
     {$ENDIF}
     ReadOnly:=DefaultReadOnly;
     Width:=DefaultWidth;
   end;
   TDCGridSource(Comp).RefreshEditor;
end;


{---------TDBGridCollEdit---------------------------------------------------}

{function  TDBGridCollEdit.GetValue : string;
begin
  result := '(TDbGridColumns)'; //don't resource
end;}

{------------------------------------------------------------------}

procedure EditFields(Comp:TPersistent);
begin
  if Comp is TDataset then
    EditObject(TDataset(Comp),'Fields'); //don't resource
end;

{------------------------------------------------------------------}

procedure EditDatasetFields(Dataset : TDataset);
begin
  EditFields(Dataset);
end;

end.
