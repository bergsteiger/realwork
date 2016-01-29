{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dctsrc;

interface
{$I dc.inc}

uses
  windows,graphics,classes,sysutils,controls,forms,messages,menus,dialogs,
  comctrls, commctrl,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  typinfo,dcsystem,dcgen, dccommon, {$IFDEF D4}imglist,{$ENDIF}
  dcconsts, dcstdctl, dctslite, dcdreamlib, dchook ;


type
  TDCTreeData = class(TPersistent) // in implementation
  private
    FLink:TPersistent;
  protected
    function  GetCaption:string ;virtual;abstract;
    function  GetImageIndex:integer;virtual;
    function  GetSelectedIndex:integer;virtual;
    function  GetStateIndex:Integer;virtual;
  public
    constructor Create(Link:TPersistent);
    property Link:TPersistent read Flink write FLink;
    {$IFDEF D3}
    function GetNamePath:String;override;
    {$ENDIF}
  end;

  TListData=class(TDCTreeData) // in implementation
  protected
    function  GetImageIndex:integer;override;
    function  GetCaption:string; override;
    function  GetStateIndex:Integer;override;
    function  GetSubItems:TStrings;
    procedure SetImageIndex(value:integer);
    procedure SetCaption(value:string);
    procedure SetStateIndex(value:Integer);
    procedure SetSubItems(value:TStrings);
  published
    property Caption:string read GetCaption write SetCaption;
    property ImageIndex:Integer read GetImageIndex write SetImageIndex;
    property StateIndex :integer read GetStateIndex write SetStateIndex;
    property SubItems: TStrings read GetSubItems write SetSubItems;
  end;

  TTreeNodeData=class(TDCTreeData)//in implementation
   protected
    function  GetImageIndex:integer;override;
    function  GetCaption:string; override;
    function  GetStateIndex:Integer;override;
    function  GetSelectedIndex:integer;override;
    procedure SetImageIndex(value:integer);
    procedure SetCaption(value:string);
    procedure SetSelectedIndex(value:integer);
    procedure SetStateIndex(value:Integer);
  published
    property ImageIndex:integer read GetImageIndex write SetImageIndex;
    property Text:string read GetCaption write SetCaption;
    property SelectedIndex:integer read GetSelectedIndex write SetSelectedIndex;
    property StateIndex :integer read GetStateIndex write SetStateIndex;
  end;

  TTreeDataList =class(TSortedList)
    function CompareWithKey(Item,Key:Pointer):Integer;override;
    function Compare(Item1,Item2:Pointer):Integer;override;
  end;

  TFakeTreeSource=  class(TComponentSource)
  protected
    FTReeData:TTreeDataList; //why not in private
    function IsMyItem(C:TPersistent):boolean; //why not in private
    procedure CMPROPCHANGED(var M:TMessage); message CM_PROPCHANGED;
    procedure SetTreeLink(Value:TPersistent);override;
    function  FindLink(objId:Integer):TDCTreeData; //why not in private
  public
    constructor Create(Aowner:TComponent);override;
    destructor  Destroy;override;
    function    GetInspectorControl(ObjID:Integer):TPersistent;override;
    procedure   ObjectDeleted(ObjId:integer);
  end;

  TDCDefaultEditSource = class(TComponentSource)
    procedure Edit(ObjId:integer);override;
  end;


  TDCMenuSource = class(TDCDefaultEditSource)
   private
     procedure SetMenu(Value:TMenu);
     function  GetMenu:TMenu;
   protected
     procedure CMPROPCHANGED(var M:TMessage); message CM_PROPCHANGED;
     function  IsMyItem(C:TPersistent):boolean;
   public
     procedure GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
     procedure SetCaption(ObjID:Integer; const Caption:string);override;
     procedure Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
     procedure Clear;override;
     procedure Delete(ObjID:Integer);override;
     function  CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;override;
     procedure MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);override;
     function  GetInspectorControl(ObjID:Integer):TPersistent;override;
     function  ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
     function  HasChild(objId:integer):boolean;override;
     function  GetParentId(ObjId:integer):integer;override;
   published
     property Menu:TMenu read GetMenu write SetMenu;
     property  LargeImages;
     property  SmallImages;
     property  StateImages;

   end;

  TDCListViewSource = class(TFakeTreeSource)
   private
     procedure SetListView(Value:TCustomListView);
     function  GetListView:TCustomListView;
   public
     procedure   GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
     procedure   SetCaption(ObjID:Integer; const Caption:string);override;
     procedure   Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
     procedure   Clear;override;
     procedure   Delete(ObjID:Integer);override;
     procedure   MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);override;
     function    ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
     function    GetSortType:TSortType;override;
     function    ValidSource:boolean; override;
     function    HasChild(objId:integer):boolean;override;
     procedure   ObjectInserted(ObjId:integer); override;
     function    GetLargeImages:TCustomImageList;override;
     function    GetSmallImages:TCustomImageList;override;
     function    GetStateImages:TCustomImageList;override;
   published
     property ListView:TCustomListView read GetListView write SetListView;
   end;

  TCustomDCTreeViewSource = class(TFakeTreeSource)
   private
     procedure SetTreeView(Value:TCustomTreeView);
     function  GetTreeView:TCustomTreeView;
   public
     procedure  GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
     procedure  SetCaption(ObjID:Integer; const Caption:string);override;
     procedure  Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
     procedure  Clear;override;
     procedure  Delete(ObjID:Integer);override;
     function   CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;override;
     procedure  MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);override;
     function   ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
     function   GetSortType:TSortType;override;
     function   ValidSource:boolean; override;
     function   HasChild(objId:integer):boolean;override;
     function   GetParentId(ObjId:integer):integer;override;
     procedure  ObjectInserted(ObjId:integer);override;
     function   GetSmallImages:TCustomImageList;override;
     function   GetLargeImages:TCustomImageList;override;
     function   GetStateImages:TCustomImageList;override;
   public
    property TreeView:TCustomTreeView read GetTreeView write SetTreeView;
  end;

  TDCTreeViewSource =class(TCustomDCTreeViewSource)
  published
    property TreeView;
  end;


  TCustomDCCollectSource = class(TDCPersistentSource)
  private
    FCollection:TCollection;
    FDisableNotify : boolean;
    procedure SetCollection(Value :TCollection);
  protected
    procedure Refresh;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
    procedure ItemNotification(Instance : TObject);
    procedure AddNotification(Instance : TObject);
    procedure RemoveNotification;

    procedure CMPROPCHANGED(var M:TMessage); message CM_PROPCHANGED;
    function  IsMyItem(C:TPersistent):boolean;
    function  GetItemName(Item : TCollectionItem) : string; virtual;
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
    function   GetAttrCount: Integer; override;
    function   GetAttrName(Index: Integer): string; override;
    function   GetAttrValue(ObjId , Index : Integer): string; override;
    destructor Destroy; override;
    function   HasChild(objId:integer):boolean;override;
    property   Collection: TCollection read FCollection write SetCollection ;
  end;

  TDCCollectSource = class(TCustomDCCollectSource)
  published
    property  Link;
    property  PropName;
    property  LargeImages;
    property  SmallImages;
    property  StateImages;
  end;


  
  TCompViewOption  = (voHideEmpty,voShowRoot,voShowClassname,voCanEdit);
  TCompViewOptions = Set of TCompViewOption;

  TCustomCompViewSource = class(TDCDefaultEditSource)
  private
    FOptions:TCompViewOptions;
    FSourceList:TList;
    procedure   GetSubItems(Cmp:TComponent;Iterator:TIteratorProc);
    procedure   SetOptions(Value :TCompViewOptions);
    procedure   SetRoot(Value : TComponent);
    function    GetRoot : TComponent;
  protected
    procedure   Notification(AComponent: TComponent; Operation: TOperation);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure   GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    procedure   SetCaption(ObjID:Integer; const Caption:string);override;
    procedure   Edit(ObjId:integer);override;
    procedure   Clear;override;
    procedure   Delete(ObjID:Integer);override;
    function    GetInspectorControl(ObjID:Integer):TPersistent;override;
    function    ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    function    CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;override;
    function    HasChild(objId:integer):boolean;override;
  public
    property Root : TComponent read GetRoot write SetRoot;
    property Options : TCompViewOptions read FOptions write SetOptions;
  end;

  TDCCompViewSource = class(TCustomCompViewSource)
  published
    property Root;
    property Options;
    property  LargeImages;
    property  SmallImages;
    property  StateImages;
  end;

  TDCFormSource= class(TCustomCompViewSource)
  protected
  public
    constructor Create(AOwner:TComponent);override;
    procedure   Edit(ObjId:integer);override;
    procedure   GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    function    GetStatusLine(ObjId:Integer):String;override;
    function    ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    function    HasChild(objId:integer):boolean;override;
  end;


  TDCResViewSource = class(TCustomDCTreeViewSource)
  private
    FFilename:string;
    FSmallImages:TCustomImageList;
    FLargeImages:TCustomImageList;
    Fmodule   : THandle;
    procedure SetFileName(Value:string);
    procedure LoadModule;
    procedure UnloadModule;
    procedure FillTree;
  public
    constructor Create(Aowner:TComponent);override;
    procedure   Edit(ObjId:integer); override;
    procedure   SetCaption(ObjID:Integer; const Caption:string);override;
    function    ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    function    CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;override;
    procedure   Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
    procedure   Delete(ObjID:Integer);override;
    procedure   Clear;override;
    function    GetStatusLine(ObjId:Integer):String;override;
    function    GetLargeImages:TCustomImageList;override;
    function    GetSmallImages:TCustomImageList;override;
  published
    property    FileName :string read FFileName write SetFileName;
  end;

  TDCMultiItem = class(TCollectionItem)
  private
    FCaption :string;
    FImageIndex : integer;
    FSelectedIndex:integer;
    FStateIndex:integer;
    FSlaveSource:TComponentSource;
    procedure SetSlaveSource(Value:TComponentSource);
    procedure SetCaption(Value:string);
  protected
    {$IFDEF D3}
    function GetDisplayName: string; override;
    {$ENDIF}
  public
    RootSource:TTreeSource;  //to private
    RootId:integer;//to private create property if needed
  published
    property Caption :string read FCaption write SetCaption;
    property ImageIndex : integer read FImageIndex write FImageIndex;
    property SelectedIndex:integer read FSelectedIndex write FSelectedIndex;
    property StateIndex:integer read  FStateIndex write FStateIndex;
    property SlaveSource:TComponentSource read FSlaveSource write SetSlaveSource;
  end;

  TDCMultiSource =class;
  TDCMultiItems = class(TCollection)
  private
    FOwnerSource:TDCMultiSource;
    function GetMultiItem(Index: Integer)  : TDCMultiItem;
    procedure SetMultiItem(Index: Integer; Value: TDCMultiItem);
  protected
    {$IFDEF D3}
    function GetOwner: TPersistent; override;
    {$ENDIF}
  public
    constructor Create(ASource:TDCMultiSource ;CollectionItemClass:TCollectionItemClass);
    function   Add:TDCMultiItem;
    property   Items[Index: Integer]: TDCMultiItem read GetMultiItem write SetMultiItem;
  end;

  TDCMultiSource = class(TComponentSource)
  private
    FSources: TDCMultiItems;
    FHideEmptyItems : boolean;
    procedure SetSources(Value :TDCMultiItems);
    procedure SetHideEmptyItems(Value : boolean);
  protected
    procedure  Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure  Loaded; override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure   GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    function    ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    function    HasChild(objId:integer):boolean;override;
    function    GetInspectorControl(ObjID:Integer):TPersistent;override;
    procedure   Delete(ObjID:Integer);override;
    procedure   Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
  published
    property  Sources : TDCMultiItems read  FSources write SetSources;
    property  HideEmptyItems : boolean read FHideEmptyItems write SetHideEmptyItems;
    property  LargeImages;
    property  SmallImages;
    property  StateImages;
  end;

  TImageOption = (ioCrop,ioStretch,ioCenter);

  TDCImageInfo = class(TPersistent)
  protected
    FImages:TCustomImageList;
    FImageIndex:integer;
    FBitmap:TBitmap;
    FTransparentColor:TColor;
    FOriginBitmap:TBitmap;
    FFillColor:TColor;
    FOptions:TImageOption;
    procedure  SetOptions(Value:TImageOption);
    procedure  SetBitmap(Value:TBitmap);
    procedure  SetFillColor(Value:TColor);
    function   GetTransparentColor:TColor;
    procedure  SetTransparentColor(Value:TColor);
    procedure  UpdateBitmap(UpdateImage:boolean);
  public
    disabledormant : boolean;
    constructor CreateInfo(Images:TCustomImageList;ImageIndex:integer);
    destructor  Destroy;override;
    procedure   AddBitmap(Bmp:TBitmap;Stretched:boolean);
  published
    property Bitmap:TBitmap read FBitmap write SetBitmap ;
    property TransparentColor:TColor read GetTransparentColor write SetTransparentColor;
    property FillColor:TColor read FFillColor write SetFillColor;
    property Options:TImageOption read FOptions write SetOptions;
  end;

  TInfoList =class(TSortedList)
    function CompareWithKey(Item,Key:Pointer):Integer;override;
    function Compare(Item1,Item2:Pointer):Integer;override;
  end;

  TDCImgListSource = class(TComponentSource)
  private
    FExtractAll:Boolean;
    FInfoList:TList;
    procedure SeTCustomImageList(Value:TCustomImageList);
    function  GeTCustomImageList:TCustomImageList;
    procedure ProcessBitmap(FName:String);
    function  ProcessIcon(FName:String):integer;
    procedure StrechBitmap(Bmp:TBitmap;arise:boolean);
    function  FindLink(ObjId:integer):TDCImageInfo;
    procedure DecImageIndex(Index:integer);
  protected
    procedure SetSelectedObject(value:integer);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure   GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    procedure   SetCaption(ObjID:Integer; const Caption:string);override;
    procedure   Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
    procedure   Clear;override;
    procedure   Delete(ObjID:Integer);override;
    procedure   MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);override;
    function    ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    function    GetInspectorControl(ObjID:Integer):TPersistent;override;
    function    GetLargeImages:TCustomImageList;override;
    function    GetSmallImages:TCustomImageList;override;
  published
    property   ImageList:TCustomImageList read GeTCustomImageList write SetCustomImageList;
  end;

{  TPagesList = class(TSortedList)
    function Compare(Item1, Item2: Pointer):integer;override;
    function CompareWithKey(Item,Key:Pointer):Integer;override;
    function FindInList(PageIndex:integer;var Index : integer) : boolean;
  end;

  TPageListItem = class
    PageIndex : integer;
    Index : integer;
    Caption:String;
    ClassPtr:TClass;
    Page:String;
    ImageIndex : integer;
    procedure Assign(Source: TPageListItem);
  end;


  TFillItemsProc=procedure(Items:TPagesList);

  TDCPageItemsSource = class(TDCPersistentSource)
  private
    FPages       : TStrings;
    FItemsConfig : TStrings;
    FFillProc    : string;
    FImageList   : TImageList;
    FProc        : TFillItemsProc;
    FPagesList    : TPagesList;
    FBitmap      : TBitmap;
//    function  FindAction(Category : string):integer;
    procedure SetItemsConfig(Value : TStrings);
    procedure SetFillProc(Value : string);
    procedure InterSectPages;
    procedure SortPages;
    function  AddBitmapForClass(AClass:TClass) : integer;
  protected
    procedure Refresh;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy ; override;
    procedure GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    procedure SetCaption(ObjID:Integer; const Caption:string);override;
    procedure Clear;override;
    procedure Delete(ObjID:Integer);override;
    function  ValidSource:boolean;override;
    function  CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;override;
    procedure MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);override;
    function  ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    function  HasChild(objId:integer):boolean;override;
    function  GetStatusLine(ObjId:Integer):String; override;
    function  GetDisplayName(ObjID:integer):string;override;
    function  GetParentId(ObjId:integer):integer;override;
    property  ItemsConfig : TStrings read FItemsConfig write SetItemsConfig;
    function  GetLargeImages:TCustomImageList;override;
    function  GetSmallImages:TCustomImageList;override;
  published
    property FillProc   : String read FFillProc write SetFillProc;
    property Link;
    property PropName;
  end;
 }
  TPersistSourceClass = Class of TDCPersistentSource;

  TMenuNameEditor = class(TStringProperty)
  public
    procedure SetValue(const Value: string);override;
  end;

implementation

{$R DcTree.RES}

var
  ImageMap: array[1..22] of Byte = (4,5,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);

{----------Common fuctions-------------------------------------------}

function GetIdent(Cmp:TComponent ; ShowClassName:boolean):string;
begin
  result := Cmp.Name;
  if ShowClassName then
    if result <>'' then
      result := result + ' : '+ Cmp.Classname;
  if result = '' then
     result:=Cmp.ClassName;
end;

{------------------------------------------------------------------}

function GetFormIdent(F:TCustomForm):string;
begin
  result:='';
  if Assigned(F)  then
    if F.Caption <>'' then
      result:=F.Caption
    else
      result:=GetIdent(F,true);
end;

{------------------------------------------------------------------}

function ValidName(const Caption,Name:string):string;
begin
  result:=RemoveCharSet([' ','&'],Caption);
  if not ( IsValidIdent(result) and  (Length(Name) >0)  and (Name[1] ='N')  and
     (StrToIntDef(copy(Name,2,Length(Name)-1),-1) <> -1) )  then
    result:='';
end;

{------------------------------------------------------------------}

procedure SetMenuItemName(Item:TMenuItem);
var
  Sname:string;
begin
  with Item do
  begin
    Sname:=ValidName(Caption,Name);
    if (Sname <>'')  and Assigned(Owner) then
      Name:=UniqueName(Owner,Sname);
  end;
end;

{------------------------------------------------------------------}

procedure FillBitmap(Bmp:TBitmap;Value:TColor);
begin
  with Bmp,Canvas do
  begin
    Brush.Color:=Value;
    FillRect(Rect(0,0,Width,Height));
  end;
end;

{----------------TDCTreeData---------------------------------------}

constructor TDCTreeData.Create(Link:TPersistent);
begin
  inherited Create;
  Flink:=Link;
end;

{------------------------------------------------------------------}

{$IFDEF D3}
function TDCTreeData.GetNamePath:String;
begin
  Result:='';
end;
{$ENDIF}

{------------------------------------------------------------------}

function  TDCTreeData.GetImageIndex:integer;
begin
  result:= 0;
end;

{------------------------------------------------------------------}

function  TDCTreeData.GetSelectedIndex:integer;
begin
  result:= 0;
end;

{------------------------------------------------------------------}

function  TDCTreeData.GetStateIndex:Integer;
begin
  result:= -1;
end;

{----------------TListData-----------------------------------------}

function TListData.GetImageIndex:integer;
begin
  if Assigned(FLink) then
    result:= TListItem(Flink).ImageIndex
  else
    result:=0;
end;

{------------------------------------------------------------------}

function TListData.GetCaption:string;
begin
  if Assigned(FLink) then
    result:=TListItem(Flink).Caption
  else
    result:='';
end;

{------------------------------------------------------------------}

function TListData.GetStateIndex:Integer;
begin
  if Assigned(FLink) then
   result:=TListItem(Flink).StateIndex
  else
   result:=0;
end;

{------------------------------------------------------------------}

procedure TListData.SetImageIndex(value:integer);
begin
  if Assigned(FLink) then
    TListItem(Flink).ImageIndex:=Value;
end;

{------------------------------------------------------------------}

procedure TListData.SetCaption(value:string);
begin
  if Assigned(FLink) then
    TListItem(Flink).Caption:=value;
end;

{------------------------------------------------------------------}

procedure TListData.SetStateIndex(value:Integer);
begin
  if Assigned(FLink) then
    TListItem(Flink).StateIndex:=Value;
end;

{------------------------------------------------------------------}

function TListData.GetSubItems:TStrings;
begin
  if Assigned(FLink) then
    result:=TListItem(Flink).SubItems
  else
    result:=nil;
end;

{------------------------------------------------------------------}

procedure TListData.SetSubItems(value:TStrings);
begin
  if Assigned(FLink) then
   TListItem(Flink).SubItems.Assign(value);
end;

{----------------TTreeNodeData------------------------------------}

function TTreeNodeData.GetImageIndex:integer;
begin
  if Assigned(FLink) then
    result:= TTreeNode(Flink).ImageIndex
  else
    result:=0;
end;

{------------------------------------------------------------------}

function TTreeNodeData.GetCaption:string;
begin
  if Assigned(FLink) then
    result:=TTreeNode(Flink).Text
  else
    result:='';
end;

{------------------------------------------------------------------}

function TTreeNodeData.GetSelectedIndex:integer;
begin
  if Assigned(FLink) then
    result:=TTreeNode(Flink).SelectedIndex
  else
    result:=0;
end;

{------------------------------------------------------------------}

function TTreeNodeData.GetStateIndex:Integer;
begin
  if Assigned(FLink) then
    result:=TTreeNode(Flink).StateIndex
  else
    result:=0;
end;

{------------------------------------------------------------------}


procedure TTreeNodeData.SetImageIndex(value:integer);
begin
  if Assigned(FLink) then
     TTreeNode(Flink).ImageIndex:=Value;
end;

{------------------------------------------------------------------}

procedure TTreeNodeData.SetCaption(value:string);
begin
  if Assigned(FLink) then
    TTreeNode(Flink).Text:=value;
end;

{------------------------------------------------------------------}

procedure TTreeNodeData.SetSelectedIndex(value:integer);
begin
  if Assigned(FLink) then
    TTreeNode(Flink).SelectedIndex:=value;
end;

{------------------------------------------------------------------}

procedure TTreeNodeData.SetStateIndex(value:Integer);
begin
  if Assigned(FLink) then
    TTreeNode(Flink).StateIndex:=Value;
end;

{--------------TFakeTreeSource-------------------------------------}

function TTreeDataList.Compare(Item1,Item2:Pointer):Integer;
begin
  result := integer(TDCTreeData(Item1).Flink) - integer(TDCTreeData(Item2).Flink);
end;

{------------------------------------------------------------------}

function  TTreeDataList.CompareWithKey(Item,Key:Pointer):Integer;
begin
  result :=  integer(TDCTreeData(Item).Flink) - Integer(Key);
end;

{------------------------------------------------------------------}

constructor TFakeTreeSource.Create(Aowner:TComponent);
begin
  inherited Create(Aowner);
  FTReeData:=TTReeDataList.Create;
end;

{------------------------------------------------------------------}

destructor TFakeTreeSource.Destroy;
begin
  FreeSortedList(FTreeData,FTreeData);
  Inherited Destroy;
end;

{------------------------------------------------------------------}

procedure  TFakeTreeSource.SetTreeLink(Value:TPersistent);
begin
  if FtreeLink <> Value then
  begin
    ClearSortedList(FTreeData);
    inherited;
  end;
end;

{------------------------------------------------------------------}

function TFakeTreeSource.FindLink(objId:Integer):TDCTreeData;
var
  index:integer;
begin
  with FTreeData do
    if FindByKey(Pointer(ObjId),Index) then
      result := TDCTreeData(Items[Index])
    else
      result := nil;
end;

{------------------------------------------------------------------}

function TFakeTreeSource.IsMyItem(C:TPersistent):boolean;
begin
  result := (C is TDCTreeData) and (FtreeData.IndexOf(C)>=0);
end;

{------------------------------------------------------------------}

procedure TFakeTreeSource.CMPROPCHANGED(var M:TMessage);
var
  R:PNodeRec;
  Item:TPersistent;
  i:integer;
  Lst:TList;
begin
  if  M.LParam = 0 then
    exit;
  Lst:=TList.Create;
  try
    for i:= 0 to TList(M.wparam).Count-1 do
    begin
      Item:=TList(M.wparam).Items[i];
      if  IsMyItem(Item)  then
        with TDCTreeData(Item) do
        begin
          new(R);
          FillChar(R^,sizeOf(R^),0);
          R^.Caption:=GetCaption;
          R^.ImageIndex:=GetImageIndex;
          R^.SelectedIndex:=GetSelectedIndex;
          R^.StateIndex:=GetStateIndex;
          R^.ObjId:=integer(TDCTreeData(Item).FLink);
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

function TFakeTreeSource.GetInspectorControl(ObjID:Integer):TPersistent;
begin
  result:=FindLink(objId);
end;

{------------------------------------------------------------------}

procedure  TFakeTreeSource.ObjectDeleted(ObjId:integer);
begin
  RemoveSortedItem(FtreeData,FindLink(ObjId));
end;

{--------------TDCDefaultEditSource--------------------------------------------}

procedure TDCDefaultEditSource.Edit(ObjId:integer);
var
  CE:TDCDsgnComp;
  D:TFormDesigner;
begin
  if ValidSource and (TObject(ObjID) is TComponent) then
  begin
    D:=GetFormDesigner(FTreeLink);
    if D = nil then
      D:= GetFormDesigner(TComponent(ObjId));
    if Assigned(D) then
    begin
      CE:=GetComponentEditor(TComponent(ObjId),D);
      if Assigned(CE) then
        try
          CE.Edit;
        finally
          {$IFNDEF D6}
          CE.Free;
          {$ENDIF}
        end;
    end;
  end;
end;

{----------------TDCListViewSource------------------------------------}

procedure TDCListViewSource.SetListView(Value:TCustomListView);
begin
  SetTreeLink(Value);
end;

{------------------------------------------------------------------}

function  TDCListViewSource.GetListView:TCustomListView;
begin
  result:=TCustomListView(FTreeLink);
end;

{------------------------------------------------------------------}

function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
  Result := byte(Item1.Index>Item2.Index);
end;

{------------------------------------------------------------------}

procedure  TDCListViewSource.ObjectInserted(ObjId:integer);
begin
  if FindLink(ObjId) = nil then
     FtreeData.Add(TListData.Create(TListItem(ObjId)));
end;

{------------------------------------------------------------------}

procedure  TDCListViewSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
   i:integer;
   R:TNodeRec;
begin
  if not ValidSource  then
    Exit;
  inherited;
  with TListView(ListView) do
  if ObjId=0 then
  begin
    fillchar(R,SizeOf(R),0);
    R.TreeSource := Self;
    R.RootId := -1;
    for i:=0 to Items.Count-1 do
      with Items[i] do
      begin
        R.ObjId :=integer(Items[i]);
        R.Caption:=Caption;
        R.ImageIndex:=ImageIndex;
        R.StateIndex:=StateIndex;
        Iterator(R);
        ObjectInserted(integer(Items[i]));
    end;
  end;
end;

{------------------------------------------------------------------}

procedure  TDCListViewSource.SetCaption(ObjID:Integer; const Caption:string);
begin
  if ObjID<>0 then
  begin
    TListItem(ObjID).Caption:=Caption;
    CaptionChanged(Integer(FindLink(ObjId)),'Caption'); // don't resource
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListViewSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
var
   Ind:Integer;
   result:integer;
begin
  result:=0;
  if  ValidSource then
  with  TListView(ListView) do
  begin
    if (ObjId<>0)  then
      Ind:=TListItem(ObjId).Index
    else
      Ind:=0;
    case InsertType of
      naInsert :
        result:=integer(Items.Insert(ind));
      naAddFirst, naAdd:
        result:=integer(Items.Add);
      naAddChildFirst,naAddChild:
        result:=0;
    end;
    if result <> 0 then
    begin
      FtreeData.Add(TListData.Create(TListItem(result)));
      CustomSort(@CustomSortProc, 0);
      DoAfterInsert(result,ObjId,Caption,InsertType);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListViewSource.Clear;
begin
  if ValidSource then
  begin
    TListView(ListView).Items.Clear;
    ClearSortedList(FtreeData);
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListViewSource.Delete(ObjID:Integer);
begin
  FSelectedObject:=0;
  if ValidSource and (ObjID<>0)  then
  begin
    ObjectDeleted(ObjId);
    TListItem(ObjID).Delete;
  end;
  inherited;
end;


{------------------------------------------------------------------}

procedure TDCListViewSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  R:TNodeRec;
begin
  if ValidSource then
    if (ObjID<>0) and (DestId<>0) and CanMove(ObjID,DestID,InsertType) then
    begin
      MoveListItem(TListItem(ObjId),TListItem(DestId),InsertType);
      ListView.CustomSort(@CustomSortProc, 0);
      with (TListItem(ObjId)) do
      begin
        FillChar(R,SizeOf(R),0);
        R.ObjId  := ObjId;
        R.DestId := DestId;
        R.InsertType:=InsertType;
        R.Caption:=Caption;
        R.ImageIndex:=ImageIndex;
        R.StateIndex:=StateIndex;
        SendNotify(integer(@R),TSMOVETO);
      end;
    end;
    inherited;
end;

{------------------------------------------------------------------}

function  TDCListViewSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := not (Action in [acShowListView,acRefreshDelete,acCanHaveChild,
                            acCanAddChild,acShowLines,acShowModal]);
end;

{------------------------------------------------------------------}

function  TDCListViewSource.GetSortType:TSortType;
begin
  if ValidSource then
    result:=  TListView(ListView).SortType
  else
      result:=StNone;
end;

{------------------------------------------------------------------}

function  TDCListViewSource.HasChild(objId:integer):boolean;
begin
  if ObjId =0 then
    result := Assigned(ListView) and (TListView(ListView).Items.Count <>0)
  else
   result:= false;
end;

{------------------------------------------------------------------}

function TDCListViewSource.ValidSource:boolean;
begin
  result:= inherited ValidSource;
  if result then
     ListView.HandleNeeded;
end;
{------------------------------------------------------------------}

function  TDCListViewSource.GetLargeImages:TCustomImageList;
begin
  if ValidSource then
    result := TListView(ListView).LargeImages
  else
    result := nil;
end;

{------------------------------------------------------------------}

function  TDCListViewSource.GetSmallImages:TCustomImageList;
begin
 if ValidSource then
    result := TListView(ListView).SmallImages
  else
    result := nil;
end;

{------------------------------------------------------------------}

function   TDCListViewSource.GetStateImages:TCustomImageList;
begin
 if ValidSource then
    result := TListView(ListView).StateImages
  else
    result := nil;
  if (result <> nil) and (result.Name = SCheckImages) then
    result := nil;
end;



{----------------TCustomDCTReeViewSource------------------------------------}

procedure TCustomDCTReeViewSource.SetTreeView(Value:TCustomTreeView);
begin
  SetTreeLink(Value);
end;

{------------------------------------------------------------------}

function  TCustomDCTReeViewSource.GetTreeView:TCustomTreeView;
begin
  result:= TCustomTreeView(FTreeLink);
end;

{------------------------------------------------------------------}

procedure  TCustomDCTReeViewSource.ObjectInserted(ObjId:integer);
begin
  if FindLink(ObjId) = nil then
     FtreeData.Add(TTreeNodeData.Create(TTreeNode(ObjId)));
end;

{------------------------------------------------------------------}

procedure TCustomDCTReeViewSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
  Node:TTreeNode;
  R:TNodeRec;

  procedure TreeIterator(Node:TTreeNode);
  begin
    with Node do
      begin
        R.ObjId :=integer(Node);
        R.Caption:=Text;
        R.ImageIndex:=ImageIndex;
        R.SelectedIndex:=SelectedIndex;
        R.StateIndex:=StateIndex;
      end;
    Iterator(R);
    ObjectInserted(integer(Node))
  end;
begin
  if not ValidSource  then
     Exit;
  inherited;
  Fillchar(R,sizeof(R),0);
  R.TreeSource:=Self;
  R.RootId := -1;
  if ObjId =0 then
    with TTreeView(TreeView) do
    begin
      Node:=Items.GetFirstNode;
      while Assigned(Node) do
      begin
        TreeIterator(Node);
        Node:=Node.GetNextSibling;
      end;
    end
  else
    with TTreeNode(ObjId) do
      if Count <>0 then
      begin
        Node:=Item[0];
        while Assigned(Node) do
        begin
          TreeIterator(Node);
          Node:=Node.GetNextSibling;
        end;
      end;
end;
{------------------------------------------------------------------}

procedure TCustomDCTReeViewSource.SetCaption(ObjID:Integer; const Caption:string);
begin
  if ObjID<>0 then
  begin
    TTreeNode(ObjID).Text:=Caption;
    CaptionChanged(Integer(FindLink(ObjId)),'Text'); //don't resource
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCTReeViewSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
var
   Node:TTreeNode;
   result:integer;
begin
  result:=0;
  if ValidSource then
  with TtreeView(TreeView) do
  begin
    if (ObjId<>0)  then
      Node:= TTreeNode(ObjId)
    else
      Node:=nil;
    with Items do
    case InsertType of
      naInsert:         result:=integer(Insert(Node,''));
      naAddFirst:       result:=integer(AddFirst(Node,''));
      naAdd:            result:=integer(Add(Node,''));
      naAddChildFirst:  result:=integer(AddChildFirst(Node,''));
      naAddChild:       result:=integer(AddChild(Node,''));
    end;
    if result <> 0 then
    begin
      FtreeData.Add(TTreeNodeData.Create(TTreeNode(result)));
      DoAfterInsert(result,ObjId,Caption,InsertType);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCTReeViewSource.Clear;
begin
  if ValidSource then
  begin
    TTreeView(TReeView).Items.Clear;
    ClearSortedList(FtreeData);
    inherited;
  end;
end;


{------------------------------------------------------------------}

procedure TCustomDCTReeViewSource.Delete(ObjID:Integer);
begin
  FSelectedObject:=0;
  if  ValidSource and (ObjID<>0) then
  begin
    ObjectDeleted(ObjId);
    TTreeNode(ObjID).Delete;
  end;
  inherited;
end;

{------------------------------------------------------------------}

function  TCustomDCTReeViewSource.CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;
begin
  result := not(TTreeNode(DestId).HasAsParent(TTreeNode(objId))) and (DestId <> ObjID);
end;

{------------------------------------------------------------------}

procedure TCustomDCTReeViewSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  R:TNodeRec;
begin
  if ValidSource then
    if (ObjID<>0) and (DestId<>0) and CanMove(ObjID,DestID,InsertType) then
    begin
      TTreeNode(ObjId).MoveTo(TTreeNode(DestId),InsertType);
      with (TTreeNode(ObjId)) do
      begin
        FillChar(R,Sizeof(R),0);
        R.ObjId  := ObjId;
        R.DestId := DestId;
        R.InsertType:=InsertType;
        R.Caption:=Text;
        R.ImageIndex:=ImageIndex;
        R.SelectedIndex:=SelectedIndex;
        R.StateIndex:=StateIndex;
        SendNotify(integer(@R),TSMOVETO);
      end;
    end;
    inherited;
end;


{------------------------------------------------------------------}

function  TCustomDCTReeViewSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := not (Action in [acRefreshDelete,acShowModal]);
end;


{------------------------------------------------------------------}

function  TCustomDCTReeViewSource.GetSortType:TSortType;
begin
  if ValidSource then
    result:=   TTreeView(TreeView).SortType
  else
    result:=StNone;
end;

{------------------------------------------------------------------}

function  TCustomDCTReeViewSource.ValidSource:boolean;
begin
  result:= inherited ValidSource;
  if result  then
    TreeView.HandleNeeded;
end;

{------------------------------------------------------------------}

function  TCustomDCTReeViewSource.HasChild(objId:integer):boolean;
begin
  if ObjId =0 then
    result := Assigned(TreeView) and (TTreeView(TreeView).Items.Count <>0)
  else
   result:= TTreeNode(ObjId).Count >0 ;
end;

{------------------------------------------------------------------}

function   TCustomDCTReeViewSource.GetParentId(ObjId:integer):integer;
begin
  if ObjId <> 0 then
    result := Integer(TTreeNode(ObjId).Parent)
  else
    result := inherited GetParentId(ObjId);
end;

{------------------------------------------------------------------}

function   TCustomDCTReeViewSource.GetLargeImages:TCustomImageList;
begin
  result :=GetSmallImages;
end;

{------------------------------------------------------------------}

function  TCustomDCTReeViewSource.GetSmallImages:TCustomImageList;
begin
  if ValidSource then
    result := TTreeView(TreeView).Images
  else
    result := nil;
end;

{------------------------------------------------------------------}

function TCustomDCTReeViewSource.GetStateImages:TCustomImageList;
begin
  if ValidSource then
    result := TTreeView(TreeView).StateImages
  else
    result := nil;
  if (result <> nil) and (result.Name = SCheckImages) then
    result := nil;
end;

{----------------TDCMenuSource------------------------------------}

procedure TDCMenuSource.SetMenu(Value:TMenu);
begin
  SetTreeLink(Value);
end;

{------------------------------------------------------------------}

function  TDCMenuSource.GetMenu:TMenu;
begin
  result:=TMenu(FTreeLink);
end;

{------------------------------------------------------------------}

procedure TDCMenuSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
    i:integer;
    RootItem:TMenuItem;
begin
  if not ValidSource then
    Exit;
  if ObjID<>0 then
    RootItem:=TMenuItem(ObjID)
  else
    RootItem:=Menu.Items;
   with RootItem do
    for i:= 0 to Count-1 do
      Iterator(GetNodeRec(Integer(Items[i]),-1,Self,Items[i].Caption));
end;

{------------------------------------------------------------------}

procedure TDCMenuSource.SetCaption(ObjID:Integer; const Caption:string);
begin
  if ObjID<>0 then
  begin
    TMenuItem(ObjID).Caption:=Caption;
    if Caption <> GetBaseName(TMenuItem(ObjID)) then
      SetMenuItemName(TMenuItem(ObjID));
    CaptionChanged(ObjId,Caption);
    inherited;
  end;
end;

{------------------------------------------------------------------}

function TDCMenuSource.IsMyItem(C:TPersistent):boolean;
begin
  result := (C is TMenuItem) and IsChildMenu(TMenuItem(C),Menu)
end;

{------------------------------------------------------------------}

procedure TDCMenuSource.CMPROPCHANGED(var M:TMessage);
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
      if  IsMyItem(Item) and (CompareText(pchar(M.LParam),'Caption')=0) then // don't resource
      begin
        new(R);
        fillchar(R^,sizeof(R^),0);
        R^.Caption:=TMenuItem(Item).Caption;
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

procedure TDCMenuSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
var
    NewItem: TMenuItem;
    RootItem:TMenuItem;
    result:integer;
  function GetParent(Item:TMenuItem):TMenuItem;
  begin
   if Item = Menu.Items then
     result:=Item
   else
     result:=Item.Parent;
  end;
begin
  if not ValidSource then
    Exit;
  if ObjID<>0 then
    RootItem:=TMenuItem(ObjID)
  else
    RootItem:=Menu.Items;
  NewItem:=TMenuItem.Create(Menu.Owner);
  NewItem.Caption:=Caption;
  NewItem.Name:=UniqueName(Menu.Owner,'N');
  with RootItem do
    case InsertType of
      naAddFirst     : GetParent(RootItem).Insert(0,NewItem);
      naAdd          : GetParent(RootItem).Add(NewItem);
      naInsert       : if MenuIndex >=0 then
                          GetParent(RootItem).Insert(MenuIndex,NewItem)
                        else
                          GetParent(RootItem).Insert(0,NewItem);
      naAddChildFirst: Insert(0,NewItem);
      naAddChild     : Add(NewItem);
    end;
  result:=integer(NewItem);
  if result <> 0 then
    DoAfterInsert(result,ObjId,Caption,InsertType);
end;

{------------------------------------------------------------------}

procedure TDCMenuSource.Clear;
begin
  if ValidSource then
  begin
    ClearMenuSubItems(Menu.Items,false);
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenuSource.Delete(ObjID:Integer);
begin
  FSelectedObject:=0;
  TMenuItem(ObjID).Free;
  inherited;
end;

{------------------------------------------------------------------}

function  TDCMenuSource.CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;
begin
  with TMenuItem(objID) do
    result:= not (TMenuItem(objID) = TMenuItem(DestID).Parent) and (ObjId <> DestId);
end;

{------------------------------------------------------------------}

procedure TDCMenuSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  R:TNodeRec;
begin
  if ValidSource then
  begin
    if (ObjID<>0) and Assigned(TMenuItem(ObjID).Parent) and
       (DestId<>0) and CanMove(ObjID,DestID,InsertType) then
    begin
      TMenuItem(ObjID).Parent.Remove(TMenuItem(ObjID));
      with TMenuItem(DestID) do
        if InsertType = naInsert then
           Parent.Insert(MenuIndex,TMenuItem(ObjID))
        else
           Parent.Add(TMenuItem(ObjID));
        FillChar(R,Sizeof(R),0);
        R.ObjId  := ObjId;
        R.DestId := DestId;
        R.InsertType:=InsertType;
        R.Caption:=TMenuItem(ObjID).Caption;
        SendNotify(integer(@R),TSMOVETO);
    end;
  end;
  inherited;
end;

{------------------------------------------------------------------}

function TDCMenuSource.GetInspectorControl(ObjID:Integer):TPersistent;
begin
  result:=TMenuItem(ObjId);
end;

{------------------------------------------------------------------}

function  TDCMenuSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := not (Action in [acRefreshDelete,acShowModal,acShowListView]);
end;

{------------------------------------------------------------------}

function  TDCMenuSource.HasChild(objId:integer):boolean;
begin
  if ObjId =0 then
    result := Assigned(Menu) and (Menu.Items.Count <>0)
  else
    result := TMenuItem(ObjId).Count > 0;
end;

{------------------------------------------------------------------}

function  TDCMenuSource.GetParentId(ObjId:integer):integer;
begin
  if Objid <> 0 then
    result := integer(TMenuItem(ObjId).Parent)
  else
    result := inherited GetParentId(ObjId);
end;


{----------------TCustomDCCollectSource--------------------------------}

procedure TCustomDCCollectSource.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (operation= opRemove)  and (Acomponent = FTreeLink) then
    FCollection := nil;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.ItemNotification(Instance : TObject);
var
  R : TNodeRec;
begin
  if not FDisableNotify then
  begin
    R.Data := nil;
    R.ObjId := integer(Instance);
    SendNotify(Integer(@R), TSDELETE);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.RemoveNotification;
var
  i : integer;
begin
  if Collection <> nil then
    for i := Collection.Count - 1 downto 0 do
      dcRemoveFreeNotification(Collection.Items[i], ItemNotification);
end;

{------------------------------------------------------------------}

destructor TCustomDCCollectSource.Destroy;
begin
  RemoveNotification;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.Refresh;
var
   Info: PPropInfo;
begin
  FCollection:=nil;
  if Assigned (Link) then
  begin
    Info:=GetPropInfo(Link.ClassInfo,FPropName);
    if Assigned(Info) then
      FCollection:=TCollection(GetOrdProp(Link,Info));
  end;
  RefreshEditor;
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.SetCollection(Value :TCollection);
begin
  if FCollection <> Value then
  begin
    RemoveNotification;
    FCollection := Value;
    RefreshEditor;
  end;
end;

{------------------------------------------------------------------}

function  TCustomDCCollectSource.GetItemName(Item : TCollectionItem) : string;
begin
  result := GetColItemDisplayName(Item);
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
    i:integer;
begin
  if not Assigned(FCollection) then
    Exit;
  if ObjId=0 then
    With FCollection do
      for i:= 0 to Count-1 do
      begin
        Iterator(GetNodeRec(integer(Items[i]),-1,Self, GetDisplayName(integer(Items[i]))));
        AddNotification(Items[i]);
      end;
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.AddNotification(Instance : TObject);
begin
  dcRemoveFreeNotification(Instance, ItemNotification);
  dcAddFreeNotification(Instance, ItemNotification);
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.SetCaption(ObjID:Integer; const Caption:string);
begin
  if ObjID<>0 then
  begin
    SetColItemDisplayName(TCollectionItem(ObjId),Caption);
    //DesignerModified(Link);
    inherited;
  end;
end;

{------------------------------------------------------------------}

function TCustomDCCollectSource.IsMyItem(C:TPersistent):boolean;
begin
  result := (C is TCollectionItem) and (TCollectionItem(C).Collection=FCollection);
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.CMPROPCHANGED(var M:TMessage);
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
      if IsMyItem(Item) then
      begin
        New(R);
        FillChar(R^,sizeof(R^),0);
        R^.Caption:= GetDisplayName(integer(Item));
        R^.ObjId:= integer(Item);
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

procedure TCustomDCCollectSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
var
  ind:integer;
  Item:TCollectionItem;
  result:integer;
begin
  result:=0;
  ind:=0;
  if not Assigned(FCollection) then
     Exit;
  if ObjID<>0 then
    ind:=TCollectionItem(ObjId).Index;
  case InsertType of
    naInsert :
    begin
      Item:=FCollection.Add;
      Item.Index:=ind;
      result:=integer(Item);
    end;
    naAddFirst, naAdd:
      result:=integer(FCollection.Add);
    naAddChildFirst,naAddChild:
      result:=0;
  end;
  if result <> 0 then
  begin
    AddNotification(TObject(result));
    DoAfterInsert(result,ObjId,Caption,InsertType);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.Clear;
begin
  if Assigned(FCollection) then
  begin
    FDisableNotify := true;
    try
      FCollection.Clear;
    finally
      FDisableNotify := false;
    end;
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.Delete(ObjID:Integer);
begin
  FSelectedObject:=0;
  FDisableNotify := true;
  try
    TCollectionItem(ObjID).Free;
  finally
    FDisableNotify := false;
  end;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCCollectSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  R:TNodeRec;
begin
  if Assigned(FCollection) then
  begin
    if (ObjID<>0) and (DestId<>0)  and CanMove(ObjID,DestID,InsertType) then
    begin
      with TCollectionItem(ObjID) do
        if InsertType = naInsert then
        begin
          if Index<TCollectionItem(DestID).Index then
            Index:=TCollectionItem(DestID).Index-1
          else
            Index:=TCollectionItem(DestID).Index;
        end
        else
          Index:=FCollection.Count-1;
      FillChar(R,Sizeof(R),0);
      R.ObjId  := ObjId;
      R.DestId := DestId;
      R.InsertType:=InsertType;
      R.Caption:=GetDisplayName(integer(ObjID));
      SendNotify(integer(@R),TSMOVETO);
    end;
  end;
  inherited;
end;

{------------------------------------------------------------------}

function TCustomDCCollectSource.GetInspectorControl(ObjID:Integer):TPersistent;
begin
  result:=TCollectionItem(ObjId);
end;

{------------------------------------------------------------------}

function  TCustomDCCollectSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := not (Action in [acShowTreeView,acRefreshDelete,acCanHaveChild,acCanAddChild,acShowLines,acCanEdit,acShowModal]);
end;


{------------------------------------------------------------------}

function  TCustomDCCollectSource.HasChild(objId:integer):boolean;
begin
  if ObjId = 0 then
    result := Assigned(FCollection) and (FCollection.Count >=0)
 else
   result:=false;
end;

{------------------------------------------------------------------}

function  TCustomDCCollectSource.GetDisplayName(ObjID:integer):string;
var
  s : string;
  i : integer;
begin
   result:=GetItemName(TCollectionItem(ObjId));
   s := '';
   for i := 0 to GetAttrCount - 1 do
   begin
     if s = '' then
       s := s + GetAttrValue(ObjId, i)
     else
       s := s + '|' + GetAttrValue(ObjId, i);
   end;
   if s <> '' then
     result := result + '|' + s;
end;

{------------------------------------------------------------------}

type
  TMCollection = class(TCollection);

function   TCustomDCCollectSource.GetAttrCount: Integer;
begin
  result := inherited GetAttrCount;
  {$IFDEF D3}
  if Assigned(FCollection) then
    result := TMCollection(FCollection).GetAttrCount;
  {$ENDIF}
end;

{------------------------------------------------------------------}

function   TCustomDCCollectSource.GetAttrName(Index: Integer): string;
begin
  result := inherited GetAttrName(Index);
  {$IFDEF D3}
  if Assigned(FCollection) then
    result := TMCollection(FCollection).GetAttr(Index);
  {$ENDIF}
end;

{------------------------------------------------------------------}

function   TCustomDCCollectSource.GetAttrValue(ObjId , Index : Integer): string;
begin
  result := inherited GetAttrValue(ObjId , Index);
  {$IFDEF D3}
  if Assigned(FCollection) and (ObjId <> 0)then
    result := TMCollection(FCollection).GetItemAttr(Index, TCollectionItem(ObjId).Index);
  {$ENDIF}

end;

{----------------TCustomCompViewSource--------------------------------}

constructor TCustomCompViewSource.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FSourceList:=TList.Create;
end;

{------------------------------------------------------------------}

destructor TCustomCompViewSource.Destroy;
begin
  FreeList(FSourceList,FSourceList);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure   TCustomCompViewSource.SetRoot(Value : TComponent);
begin
  SetTreeLink(Value);
end;

{------------------------------------------------------------------}

function    TCustomCompViewSource.GetRoot : TComponent;
begin
  result:= TComponent(GetTreeLink);
end;

{------------------------------------------------------------------}

procedure TCustomCompViewSource.Notification(AComponent: TComponent; Operation: TOperation);
var
  R:TNodeRec;
begin
  inherited;
  if  (operation= opRemove) then
  begin
    R.Data:= nil;
    R.ObjId:=integer(Acomponent);
    SendNotify(Integer(@R),TSDELETE);
  end;
end;

{------------------------------------------------------------------}

procedure   TCustomCompViewSource.Edit(ObjId:integer);
begin
  if voCanEdit in Options then
     inherited;
end;

{------------------------------------------------------------------}

procedure   TCustomCompViewSource.SetOptions(Value :TCompViewOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    RefreshEditor;
  end;
end;

{------------------------------------------------------------------}
type
  TMSource = class (TComponentSource);

procedure TCustomCompViewSource.GetSubItems(Cmp:TComponent;Iterator:TIteratorProc);

 {--------------------------------------------------}

  procedure InternalIterator(C:TComponent);
  var
    AClass:TTreeSourceClass;
    Index:Integer;
    i:integer;
  begin
    AClass:=GetRegisteredTreeSource(C.ClassType,'');
    if  AClass <> nil then
    begin
      Index:=-1;
      for i:= 0 to FSourceList.Count -1 do
        if (TObject(FSourceList.Items[i]) is Aclass) and
        (TMSource(FSourceList.Items[i]).FtreeLink = C) then
        begin
          Index:= i;
          break;
        end;
      if Index = -1 then
        Index:= FSourceList.Add(Aclass.Create(Self));
      TMSource(FSourceList.Items[Index]).FTreeLink := C;
      Iterator(GetNodeRec(integer(C),0,FSourceList.Items[Index],GetIdent(C,voShowClassname in Options)));
    end
    else
      Iterator(GetNodeRec(integer(C),-1,Self,GetIdent(C,voShowClassname in Options)));
    C.FreeNotification(Self);
  end;

  {--------------------------------------------------}
  procedure IterateScreen(C:TScreen);
  var
    i:integer;
  begin
     with C do
     begin
       for i:= 0 to ScreenFormCount-1 do
         with  ScreenForms(i) do
           if (Owner <> C) and (Owner<> FTreeLink)
           and  not ((voHideEmpty in Options) and  (Name= '')) then
             InternalIterator(ScreenForms(i));
       for i:= 0 to DataModuleCount -1 do
         with DataModules[i] do
           if (Owner <> C) and (Owner<> FTreeLink)
           and  not ((voHideEmpty in Options) and  (Name= '')) then
             InternalIterator(DataModules[i]);
     end;
  end;

  {--------------------------------------------------}
  procedure InsertRoot(C: TComponent);
  var
    I: integer;
  begin
    if C is TScreen then
      IterateScreen(TScreen(C))
    else
    if not (C is TMenu ) then
      with C do
        for I := 0 to ComponentCount - 1 do
          if ((Components[i].GetParentComponent = nil) or (Components[i].GetParentComponent = C)) and
          not ( (Components[i] is THintWindow ) or (CompareText(Components[i].Classname,'TDDeMgr')=0)) then  // don't resource
            InternalIterator(Components[I]);
  end;

   {--------------------------------------------------}
  procedure InsertChildrens(C: TComponent);
  var
    I: integer;
  begin
    if not assigned(C.Owner) then
      exit;
    if (C is TWinControl) then
    begin
      with TWinControl(C) do
        for I := 0 to ControlCount -1 do
          if Controls[I].Owner <> C then
             InternalIterator(Controls[I])
    end
    else
      with C.Owner do
        for I := 0 to ComponentCount - 1 do
          if (Components[I].GetParentComponent = C)  then
            InternalIterator(Components[I]);
  end;
begin
  InsertRoot(Cmp);
  InsertChildrens(Cmp);
end;

{------------------------------------------------------------------}

procedure TCustomCompViewSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
begin
  if (ObjId<>0)  then
  begin
    if TObject(ObjId) is TComponent then
      GetSubItems(TComponent(ObjId),Iterator);
  end
  else
  if ValidSource then
  begin
    if VoShowRoot in Options then
      Iterator(GetNodeRec(Integer(FTreeLink),-1,Self,GetIdent(Root,voShowClassname in Options)));
    GetSubItems(Root,Iterator);
    if FTreeLink = Application then
      GetSubItems(Screen,Iterator);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomCompViewSource.SetCaption(ObjID:Integer; const Caption:string);
begin
  if ObjID<>0 then
  begin
    TComponent(ObjID).Name:=Caption;
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomCompViewSource.Clear;
begin
  if ValidSource then
  begin
    with FTreeLink do
      while ComponentCount > 0 do
        Components[0].Free;
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomCompViewSource.Delete(ObjID:Integer);
begin
  if  ValidSource and (ObjID<>0) then
    TComponent(ObjID).Free;
  inherited;
end;

{------------------------------------------------------------------}

function TCustomCompViewSource.GetInspectorControl(ObjID:Integer):TPersistent;
begin
  result:=TComponent(ObjId);
end;

{------------------------------------------------------------------}

function  TCustomCompViewSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result :=  (Action in [acShowTreeView,acShowListView,acSelectInspector,acShowPopup,
                        acCanHaveChild,AcShowLines,acShowToolbar,acMultiSelect]);
end;

{------------------------------------------------------------------}

function  TCustomCompViewSource.HasChild(objId:integer):boolean;
var
  i : integer;
begin
  if ObjId = 0 then
    result := Assigned(FTreeLink) and HasChild(integer(FTreeLink))
  else
  if (integer(FtreeLink) = objId) and (voShowRoot in Options) then
    result := false
  else
  begin
    with FSourceList do
      for i := 0 to Count -1 do
        if integer(TMSource(TTreeSource(Items[i])).FTreeLink) = ObjID then
        begin
          result := TTreeSource(Items[i]).HasChild(0);
          exit;
        end;
    result :=
          ( ( (Tobject(ObjId) is TWinControl ) and (TWinControl(ObjID).ControlCount >0) ) or
            ( (Tobject(ObjId) is TScreen   ) and ((ScreenFormCount >0) or (TScreen(ObjID).DataModuleCount >0) ) ) or
            ( (Tobject(ObjId) is TComponent) and (TComponent(ObjID).ComponentCount > 0) and not (TComponent(ObjId) is TMenuItem) ) );
  end;
end;

{------------------------------------------------------------------}

function TCustomCompViewSource.CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;
begin
  result:=false;
end;

{---------TDCFormSource---------------------------------------------------}

constructor TDCFormSource.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  Root:=Screen;
end;

{------------------------------------------------------------------}

procedure TDCFormSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
  i:integer;
  S:string;
  F:TCustomForm;
begin
  if ObjId=0 then
  if FTreeLink is TScreen then
     with TScreen(FTreeLink) do
     begin
       Application.FreeNotification(Self);
       for i:= 0 to ScreenFormCount-1 do
       begin
         F:= ScreenForms(i);
         if  IsWindowVisible(F.Handle) then
         begin
           S:=GetFormIdent(F);
           if voShowClassName in Options then
             S:=S+':'+F.ClassName;
           Iterator(GetNodeRec(integer(F),-1,Self,S));
           if (F.Owner <> Application)  then
             F.FreeNotification(self);
         end;
       end;
     end;
end;

{------------------------------------------------------------------}

procedure TDCFormSource.Edit(ObjId:integer);
  procedure  FindForm(F:TCustomForm);
  var
    i:integer;
  begin
    with TScreen(FTreeLink) do
      for i:= 0 to ScreenFormCount-1 do
        if ScreenForms(i) = F then
        begin
          ShowFormEx(F,sw_show);
          break;
        end;
  end;
begin
  if (FTreeLink is TScreen) then
     FindForm(TCustomForm(ObjID));
end;

{------------------------------------------------------------------}

function  TDCFormSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result :=  (Action in [acShowModal]);
end;

{------------------------------------------------------------------}

function  TDCFormSource.GetStatusLine(ObjId:Integer):String;
begin
  result:='';
end;

{------------------------------------------------------------------}

function  TDCFormSource.HasChild(objId:integer):boolean;
begin
  result:= false;
end;

{----------------TResViewSource------------------------------------}

type
  TMTreeView = class(TCustomTReeView);

{------------------------------------------------------------------}

function EnumResNamesProc(hModule : THandle; restype, resname : PChar; Tree:TMtreeView) : integer; stdcall;
var
  s:string;
begin
  if restype = RT_CURSOR then
    s := IntToStr(32768-integer(resname))
  else
    s := StringFromRName(resname);

  if Assigned(Tree) then
    with Tree.Items.AddChild(Tree.Selected,S) do
      begin
        ImageIndex := ImageMap[integer(restype)];
        SelectedIndex := ImageIndex;
      end;
      
  result := 1;
end;

{------------------------------------------------------------------}

function EnumTypesProc(hModule : THandle; rtype : pchar; Tree:TMTreeView) : integer; stdcall;
begin
  if Assigned(Tree) then
    with Tree do
    begin
      Selected:= Items.AddObject(Items.GetFirstNode,StringFromRType(Rtype),RType);
      EnumResourceNames(hModule, rtype, @EnumResNamesProc, integer(Tree));
      if Selected.Count = 0 then
        Items.Delete(Selected);
    end;
  result := 1;
end;

{------------------------------------------------------------------}

constructor TDCResViewSource.Create(Aowner:TComponent);
begin
  inherited Create(Aowner);
  FSmallImages := TImageList.Create(self);
  FLargeImages := TImageList.Create(self);
  with TImageList(FLargeImages) do
  begin
    Height := 32;
    Width := 32;
  end;
  FSmallImages.ResourceLoad(rtBitmap, 'SmallImages', clOlive); //don't resource
  FLargeImages.ResourceLoad(rtBitmap, 'LargeImages', clOlive); //don't resource
  TreeView:= TTreeView.Create(Self);
  TreeView.ControlStyle := TreeView.ControlStyle + [CsNoDesignVisible];
  with TTreeView(TreeView) do
  begin
    Visible:=false;
    if Aowner is TWinControl then
      Parent:=TWinControl(AOwner);
    Images:=TImageList(FSmallImages);
  end;
end;

{------------------------------------------------------------------}

procedure   TDCResViewSource.Edit(ObjId:integer);
var
  DesData:TDesignResFormData;
begin
  if (ObjId <> 0) and (TTreeNode(ObjId).Parent <> nil)  then
  begin
    DesData.ResName:=TTreeNode(ObjId).text;
    DesData.ResType:=(TTreeNode(ObjId).Parent.Data);
    if integer(DesData.ResType) <> integer(rtCursor) then
      BroadCastToNotifiers(self,CM_DESIGNRESFORM,Integer(PCHar(FFileName)),integer(@DesData));
  end;
end;

{------------------------------------------------------------------}

procedure TDCResViewSource.SetFileName(Value:string);
begin
  if FFileName <> Value then
  begin
    FFileName:=Value;
    try
      FillTree;
    finally
      RefreshEditor;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCResViewSource.FillTree;
begin
  TTreeView(TreeView).Items.Clear;
  LoadModule;
  try
    if Fmodule <> 0 then
      EnumResourceTypes(Fmodule, @EnumTypesProc, integer(Self.TreeView))
  finally
    UnloadModule;
  end;
end;

{------------------------------------------------------------------}

procedure TDCResViewSource.LoadModule;
begin
  Fmodule := LoadLibraryEx(PChar(FFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
end;

{------------------------------------------------------------------}

procedure TDCResViewSource.UnloadModule;
begin
  if Fmodule <> 0 then
    FreeLibrary(Fmodule);
  Fmodule:=0;
end;

{------------------------------------------------------------------}

procedure   TDCResViewSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
begin
//
end;

{------------------------------------------------------------------}

procedure   TDCResViewSource.Delete(ObjID:Integer);
begin
//
end;

{------------------------------------------------------------------}

procedure   TDCResViewSource.Clear;
begin
//
end;

{------------------------------------------------------------------}

procedure  TDCResViewSource.SetCaption(ObjID:Integer; const Caption:string);
begin
  if ObjID<>0 then
  begin
    inherited;
    pchar(ObjID):=pchar(Caption);
  end;
end;

{------------------------------------------------------------------}

function  TDCResViewSource.GetStatusLine(ObjId:Integer):String;
begin
  result:='';
end;

{------------------------------------------------------------------}

function  TDCResViewSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := (Action in [acShowLines,acShowTreeView,acCanHaveChild]);
end;

{------------------------------------------------------------------}

function   TDCResViewSource.CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;
begin
  result:=false;
end;

{------------------------------------------------------------------}

function  TDCResViewSource.GetLargeImages:TCustomImageList;
begin
  result := FLargeImages;
end;

{------------------------------------------------------------------}

function  TDCResViewSource.GetSmallImages:TCustomImageList;
begin
 result := FSmallImages;
end;


{----------TDCMultiItems---------------------------------------------}

procedure TDCMultiItem.SetSlaveSource(Value:TComponentSource);
var
  R:TNodeRec;
begin
  if FSlaveSource <> Value then
  begin
    FSlaveSource:= Value;
    with TDCMultiItems(Collection) do
    begin
      if FOwnerSource.FHideEmptyItems then
      begin
        R.ObjId := 0;
        FOwnerSource.SendNotify(integer(@R),TSREFRESH);
      end;
      R.ObjId := integer(Self);
      FOwnerSource.SendNotify(integer(@R),TSREFRESH);
      R.ObjId:=integer(Self);
      FOwnerSource.SendNotify(integer(@R),TSSELEXPANDED);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCMultiItem.SetCaption(Value:string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    with TDCMultiItems(Collection) do
      TDCMultiSource(FOwnerSource).SetCaption(integer(Self),Value);
  end;
end;

{------------------------------------------------------------------}
{$IFDEF D3}

function TDCMultiItem.GetDisplayName: string;
begin
  result := FCaption;
  if result = '' then
    result := ClassName;
end;
{$ENDIF}
{------------------------------------------------------------------}

constructor TDCMultiItems.Create(ASource:TDCMultiSource; CollectionItemClass :TCollectionItemClass);
begin
  inherited Create(CollectionItemClass);
  FOwnerSource := ASource;
end;

{------------------------------------------------------------------}

{$IFDEF D3}
function TDCMultiItems.GetOwner: TPersistent;
begin
  Result := FOwnerSource;
end;
{$ENDIF}

{------------------------------------------------------------------}

function TDCMultiItems.Add:TDCMultiItem;
begin
  Result := TDCMultiItem(inherited Add);
end;

{------------------------------------------------------------------}

function TDCMultiItems.GetMultiItem(Index:integer)  : TDCMultiItem;
begin
  Result := TDCMultiItem(inherited Items[Index]);
end;

{------------------------------------------------------------------}

procedure TDCMultiItems.SetMultiItem(Index: Integer; Value: TDCMultiItem);
begin
  Items[Index].Assign(Value);
end;

{-------------TDCMultiSource---------------------------------------}

constructor TDCMultiSource.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FTreeLink := Application;
  FSources:= TDCMultiItems.Create(Self,TDCMultiItem);
end;

{------------------------------------------------------------------}

destructor TDCMultiSource.Destroy;
begin
  FSources.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure  TDCMultiSource.Loaded;
begin
  inherited;
  RefreshEditor;
end;

{------------------------------------------------------------------}

procedure  TDCMultiSource.Notification(AComponent: TComponent; Operation: TOperation);
var
  i : integer;
  R : TNodeRec;
begin
  inherited Notification(AComponent, Operation);
  if (AComponent <> Self) and (AComponent is TComponentSource) and (OPeration = opRemove) then
    with FSources do
      for i := 0 to Count - 1 do
        if Items[i].FSlaveSource = AComponent then
        begin
          Items[i].FSlaveSource := nil;
          if FHideEmptyItems then
          begin
            R.Data:= nil;
            R.ObjId:=integer(ITems[i]);
            SendNotify(Integer(@R),TSDELETE);
          end;  
        end;
end;

{------------------------------------------------------------------}

procedure TDCMultiSource.SetSources(Value :TDCMultiItems);
begin
  FSources.Assign(Value);
end;

{------------------------------------------------------------------}

procedure TDCMultiSource.SetHideEmptyItems(Value : boolean);
begin
  if FHideEmptyItems <> Value then
  begin
    FHideEmptyItems := Value;
    RefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure  TDCMultiSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
  i:integer;
  R:TNodeRec;
begin
  fillchar(R,SizeOf(R),0);
  if ObjId = 0 then
    for i:= 0 to FSources.Count-1 do
      with FSources.Items[i] do
        if (not FHideEmptyItems) or Assigned(SlaveSource) then
        begin
          R.ObjId := integer(FSources.ITems[i]);
          R.Caption := Caption;
          R.ImageIndex := ImageIndex;
          R.SelectedIndex := SelectedIndex;
          R.TreeSource := SlaveSource;
          Iterator(R);
        end;
end;

{------------------------------------------------------------------}

procedure   TDCMultiSource.Delete(ObjID:Integer);
begin
  if (ObjId <> 0)  then
  with TDCMultiITem(ObjID) do
    begin
      if  Assigned(SlaveSource)  then
        TMSource(SlaveSource).FtreeLink := nil;
      TDCMultiITem(ObjID).Free;
    end;
  inherited;
end;

{------------------------------------------------------------------}

procedure TDCMultiSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
begin
  if (ObjId <> 0) and Assigned(TDCMultiItem(Objid).SlaveSource) then
    with TDCMultiItem(Objid).SlaveSource do
      Add(0,'',InsertType);
end;


{------------------------------------------------------------------}

function   TDCMultiSource.HasChild(objId:integer):boolean;
begin
  if ObjId = 0 then
    result := FSources.Count >0
  else
    result := (TDCMultiItem(ObjId).SlaveSource <> nil) and
              (TDCMultiItem(ObjId).SlaveSource.HasChild(0));
end;

{------------------------------------------------------------------}

function    TDCMultiSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
    result := not (Action in [acRefreshDelete,acCanClear,acCanEdit,acShowModal]);
end;

{------------------------------------------------------------------}

function    TDCMultiSource.GetInspectorControl(ObjID:Integer):TPersistent;
begin
  result :=TDCMultiItem(ObjId);
end;

{------------------------------------------------------------------}

function TInfoList.CompareWithKey(Item,Key:Pointer):Integer;
begin
  result :=  TDCImageInfo(Item).FImageIndex - Integer(Key);
end;

{------------------------------------------------------------------}

function TInfoList.Compare(Item1,Item2:Pointer):Integer;
begin
  result := TDCImageInfo(Item1).FImageIndex - TDCImageInfo(Item2).FImageIndex
end;

{----------TDCImageInfo------------------------------------------------}

constructor TDCImageInfo.CreateInfo(Images:TCustomImageList;ImageIndex:integer);
begin
  inherited Create;
  FImages:=Images;
  Fbitmap:=TBitmap.Create;
  FOriginBitmap:=TBitmap.Create;
  FImageIndex:=ImageIndex;
end;

{------------------------------------------------------------------}

destructor TDCImageInfo.destroy;
begin
  Fbitmap.Free;
  FOriginBitmap.Free;
  Inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCImageInfo.SetFillColor(Value:TColor);
begin
  if FFillColor <> Value then
  begin
    FFillColor:=value;
    UpdateBitmap(true);
  end;
end;

{------------------------------------------------------------------}

function TDCImageInfo.GetTransparentColor:TColor;
begin
  Result:= FTransparentColor ;
  Result := Result and not $02000000;
end;

{------------------------------------------------------------------}

procedure TDCImageInfo.SetTransparentColor(Value:TColor);
begin
  {$IFDEF D3}
  FOriginBitmap.TransparentColor:=Value;
  {$ENDIF}
  FTransparentColor:=Value;
  UpdateBitmap(true);
end;

{------------------------------------------------------------------}

procedure TDCImageInfo.AddBitmap(Bmp:TBitmap;Stretched:boolean);
begin
  FTransparentColor:=Bmp.TransparentColor;
  FOriginBitmap.Assign(Bmp);
  if Assigned (FImages) then
    with TImageList(FImages) do
    begin
      FBitmap.Height:=Height;
      FBitmap.Width:=Width;
    end;
  FFillColor:=TransparentColor;
  if Stretched then
    FOptions:=ioStretch;
  UpdateBitmap(false);
end;
{------------------------------------------------------------------}

procedure TDCImageInfo.SetOptions(Value:TImageOption);
begin
  if Foptions <> value then
  begin
    FOptions:=Value;
    UpdateBitmap(true);
  end;
end;

{------------------------------------------------------------------}

procedure TDCImageInfo.UpdateBitmap(UpdateImage:boolean);
var
  left:integer;
  top:integer;

begin
  with FBitmap,Canvas do
  begin
    FillBitmap(FBitmap,clNone);
    case FOptions of
      ioCrop:   Draw(0,0,FOriginBitmap);
      ioStretch: StretchDraw(Rect(0,0,Width,Height),FOriginBitmap);
      ioCenter:
              begin
                left:=(FOriginBitmap.Width-Width) div 2;
                top:=(FOriginBitmap.Height-Height) div 2;
                CopyRect(Rect(0,0,Width,Height),FOriginBitmap.Canvas, Rect(left,top,Width+left,Height+top));
              end;
    end;
  end;
  if Assigned(FImages) and UpdateImage and (FImageIndex in [0..FImages.Count-1] ) then
     ChangeImageList(FImages,FBitmap,TransparentColor,FImageIndex);
  FOriginBitmap.Dormant;
  if not disabledormant then
    FBitmap.Dormant;
end;
{------------------------------------------------------------------}

procedure TDCImageInfo.SetBitmap(Value:TBitmap);
begin
 FBitmap.Assign(Value);
 UpdateBitmap(true);
end;

{--------------TDCImgListSource-----------------------------------------}

constructor TDCImgListSource.Create(AOwner:TComponent);
begin
  Inherited Create(AOwner);
  FInfoList:=TList.Create;
end;

{------------------------------------------------------------------}

destructor  TDCImgListSource.Destroy;
begin
  FreeList(FInfoList,FInfoList);
  Inherited Destroy;
end;

{------------------------------------------------------------------}

function TDCImgListSource.FindLink(ObjId:integer):TDCImageInfo;
var
  i:integer;
begin
  result:=nil;
  with FInfoList do
    for i:= 0 to Count -1 do
     if TDCImageInfo(Items[i]).FImageIndex = ObjId then
     begin
       Result := Items[i];
       break;
     end;
end;

{------------------------------------------------------------------}

procedure TDCImgListSource.SeTCustomImageList(Value:TCustomImageList);
begin
  if FtreeLink <> value then
     ClearList(FInfoList);
  SetTreeLink(Value);
end;

{------------------------------------------------------------------}

function TDCImgListSource.GeTCustomImageList:TCustomImageList;
begin
  result:=TCustomImageList(FTreeLink);
end;

{------------------------------------------------------------------}

procedure TDCImgListSource.SetSelectedObject(value:integer);
begin
  inherited;
  if Value = 0 then
  begin
    FRec.Caption := '';
    fillChar(FRec,sizeof(FRec),0);
    FRec.Data := Self;
    PostNotify(integer(@FRec),TSSELCHANGED);
  end;
end;

{------------------------------------------------------------------}

procedure TDCImgListSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
  i:integer;
  R:TNodeRec;
begin
  if not ValidSource  then
    Exit;
  with ImageList do
    if ObjId=0 then
      for i:=0 to Count-1 do
      begin
        FillChar(R,SizeOf(R),0);
        R.Caption:=IntToStr(i);
        R.ImageIndex:=i;
        R.ObjID:=i;
        Iterator(R)
     end;
end;

{------------------------------------------------------------------}

procedure TDCImgListSource.SetCaption(ObjID:Integer; const Caption:string);
begin
end;

{------------------------------------------------------------------}

function ExtractFName(var FNames: string): string;
begin
 result:='';
 while  (FNames<>'') do
 begin
   if FNames[1] = #13 then
   begin
     delete(Fnames,1,2);
     break;
   end;
   result:=result+FNames[1];
   delete(Fnames,1,1);
 end;
end;

{------------------------------------------------------------------}

procedure TDCImgListSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
var
  FNames:string;
  FName: string;
begin
  FNames:=Caption;
  try
    while FNames <> '' do
    begin
      FName:=ExtractFName(FNames);
      if CompareText(ExtractFileExt(FName),'.bmp')=0 then //don't resource
        ProcessBitmap(FName)
      else
        ProcessIcon(FName);
    end;
  finally
    FExtractAll:=false;
    RefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure  TDCImgListSource.StrechBitmap(Bmp:TBitmap;arise:boolean);
begin
  with TImageList(ImageList) do
    begin
      if (arise and (Bmp.Height<Height)) or (not arise and (Bmp.Height>Height)) then
        Bmp.Height:=Height;
      if (arise and (Bmp.Width<Width))  or (not arise and (Bmp.Width>Width)) then
        Bmp.Width:=Width;
    end;    
end;

{------------------------------------------------------------------}

function TDCImgListSource.ProcessIcon(FName:String):integer;
var
  Icon:TIcon;
begin
  Icon:=TIcon.Create;
  try
    Icon.LoadFromFile(FName);
    result:=ImageList.AddIcon(Icon);
  finally
    Icon.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCImgListSource.ProcessBitmap(FName:String);
var
   Bitmap,bmp:TBitmap;
   OldColor:TColor;
   OldCount:integer;
   ImageInfo:TDCImageInfo;
   FExtract:Boolean;
  begin
   FExtract:=false;
   Bitmap:=TBitmap.Create;
   Bmp:=TBitmap.Create;
   try
     Bmp.LoadFromFile(FName);
     Bitmap.Assign(Bmp);
     with Bitmap do
     if not (FExtractAll) and ((Width div TImageList(ImageList).Width>1) or (Height div TImageList(ImageList).Height>1)) then
     begin
       case MessageDlg(Format(SAskSeparateBitmaps,[FName,(Width div TImageList(ImageList).Width)]),
         mtConfirmation,[mbYes,mbNo,mbAll],0) of
         mrYes:FExtract:=true;
         mrAll:FExtractAll:=true;
         mrNo:
           begin
             StrechBitmap(Bitmap,false);
             Bitmap.Canvas.StretchDraw(Rect(0,0,TImageList(ImageList).Width,TImageList(ImageList).Height),Bmp);
           end;
       end;
     end;
     OldColor:=Bitmap.TransparentColor;
     OldCount:=ImageList.Count;
     StrechBitmap(Bitmap,true);
     ImageList.AddMasked(Bitmap,OldColor);
     while OldCount < ImageList.Count do
     begin
       ImageInfo:= TDCImageInfo.CreateInfo(ImageList,OldCount);
       if FExtract or FExtractAll then
       begin
         FillBitmap(Bmp,clNone);
         ImageList.GetBitmap(OldCount,Bmp);
       end;
       ImageInfo.AddBitmap(Bmp,not (FExtract or FExtractAll));
       FInfoList.Add(ImageInfo);
       Inc(OldCount);
     end;
   finally
     Bitmap.Free;
     Bmp.Free;
   end;
end;

{------------------------------------------------------------------}

procedure  TDCImgListSource.Clear;
begin
  ClearList(FInfoList);
  ImageList.Clear;
end;

{------------------------------------------------------------------}

procedure TDCImgListSource.DecImageIndex(Index:integer);
var
  i:integer;
  Info:TDCImageInfo;
begin
  with FInfoList do
    for i:=0 to Count-1 do
    begin
      Info:=Items[i];
      if Info.FImageIndex > Index then
         Dec(Info.FImageIndex);
    end;
end;

{------------------------------------------------------------------}

procedure TDCImgListSource.Delete(ObjID:Integer);
begin
  RemoveItem(FInfoList,FindLink(ObjID));
  DecImageIndex(ObjId);
  ImageList.Delete(ObjID);
  inherited;
end;

{------------------------------------------------------------------}

procedure  TDCImgListSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  Bmp:TBitmap;
  i:integer;
  Info:TDCIMageInfo;
  R:TNodeRec;
begin
  if CanMove(ObjId,DestId,InsertType) and not(InsertType in [naAddChild,naAddChildFirst]) then
  begin
    Bmp:=TBitmap.Create;
    try
      ImageList.GetBitmap(ObjId,Bmp);
       case InsertType of
        naInsert: ImageList.InsertMasked(DestId,Bmp,Bmp.TransparentColor);
        naAdd,naAddFirst:
        begin
          DestId := ImageList.Count;
          ImageList.AddMasked(Bmp,Bmp.TransparentColor);
        end;
      end;
      if ObjId > DestId then
        Inc(ObjId)
      else
        Dec(DestId);
      ImageList.Delete(ObjId);
      for i:= 0 to FInfoList.Count-1 do
      begin
        Info:= FInfoList.Items[i];
        with Info do
          if (FImageIndex >= min(ObjId,DestId)) and (FImageIndex <= max(ObjId,DestId)) then
          begin
            if FImageIndex = ObjId then
              FImageIndex:=DestId
            else if ObjId > DestId then
              inc(FImageIndex)
            else
              dec(FImageIndex);
          end;
      end;
      RefreshEditor;
      R.Data:=Self;
      R.ObjId := DestId;
      SendNotify(integer(@R),TSSELCHANGED);
    finally
      Bmp.Free;
    end;
  end;
  inherited;
end;

{------------------------------------------------------------------}

function  TDCImgListSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := not (Action in [acShowTreeView,acCanHaveChild,acShowLines,acSelectInspector ]);
end;

{------------------------------------------------------------------}

function TDCImgListSource.GetInspectorControl(ObjID:Integer):TPersistent;
begin
  result:=FindLink(objId);
end;

{------------------------------------------------------------------}

function    TDCImgListSource.GetLargeImages:TCustomImageList;
begin
  result := ImageList;
end;

{------------------------------------------------------------------}

function    TDCImgListSource.GetSmallImages:TCustomImageList;
begin
  result := ImageList;
end;

{-------------TMenuNameEditor------------------------------------------}

procedure TMenuNameEditor.SetValue(const Value: string);
begin
  inherited;
  if  GetComponent(0) is TMenuItem  then
     SetMenuItemName(TMenuItem(GetComponent(0)));
end;


(*


{---------TCompPaletteIntf-----------------------------------------}
{
procedure TNewFormIntf.GetRegisteredItems(Items:TPagesEditorItems);
var
  i : integer;
  procedure ProcessPage(Sheet : TTabSheet);
  var
    i : integer;
    j : integer;
    Item : TPagesEditorItem;
  begin
    with Sheet do
      for i:= 0 to ControlCount - 1 do
        if Controls[i] is TListView then
          for j := 0 to TListView(Controls[i]).Items.Count -1 do
            with TListView(Controls[i]).Items[j] do
            begin
              Item := Items.Add;
              Item.Caption := Caption;
              Item.ID := Caption;
              Item.ImageIndex := ImageIndex;
              Item.Page := Sheet.Caption;
            end;
  end;

begin

  Items.Clear;
  if NewFormControl <> nil then
    for i := 0 to NewFormControl.PageCount - 1 do
      ProcessPage(NewFormControl.Pages[i]);
end;
 }


{
procedure TCompPaletteIntf.GetRegisteredItems(Items:TPagesEditorItems);
var
  i : integer;

  procedure ProcessPage(Sheet : TTabSheet);
  var
    i : integer;
    Item : TPagesEditorItem;
  begin
    with Sheet do
      for i:= 0 to ControlCount - 1 do
        if Controls[i] is TDCPaletteButton then
          with TDCPaletteButton(Controls[i]) do
            if Tag <> -1 then
            begin
              Item := Items.Add;
              Item.Caption := ClassPrefix + Hint;
              Item.ID := Name;
              Item.ImageIndex := ImageIndex;
              Item.Page := Sheet.Caption;
            end;
  end;
begin
  Items.Clear;
  if CompPal <> nil then
    for i := 0 to CompPal.PageCount - 1 do
      ProcessPage(CompPal.Pages[i]);
end;
}
{------------------------------------------------------------------}

{
procedure  TDCPageSource.ApplyChanges;
var
  i   : integer;
  j   : integer;
  str : string;
  PageItems : TPagesEditorItems;
begin
  if ValidSource and  (FIntf.PredefinedPages <> nil) then
    with  FIntf.PredefinedPages do
    begin
      BeginUpdate;
      try
        Clear;
        for i := 0 to FPages.Count -1 do
        begin
          str := '';
          PageItems := TPagesEditorItems(FPages.Objects[i]);
          if PageItems <> nil then
            for j:= 0 to PageItems.Count - 1 do
              if str = '' then
                str := PageItems.Items[j].Caption
              else
                str := str + ',' + PageItems.Items[j].Caption;
          if str <> '' then
            str := '=' + str;
          Add(FPages[i]+str);
        end;
      finally
        EndUpdate;
      end;
    end;
end;
}

{---------TPageListItem----------------------------------------}

procedure TPageListItem.Assign(Source: TPageListItem);
begin
  with Source do
  begin
    Self.PageIndex  := PageIndex;
    Self.Index      := Index;
    Self.Caption    := Caption;
    Self.ClassPtr   := ClassPtr;
    Self.Page       := Page;
    Self.ImageIndex := ImageIndex;
  end;
end;

{--------TPagesList-------------------------------------------------}

function TPagesList.Compare(Item1, Item2: Pointer):integer;
begin
  result := TPageListItem(Item1).PageIndex - TPageListItem(Item2).PageIndex;
  if result = 0 then
    result := TPageListItem(Item1).Index - TPageListItem(Item2).Index;
end;

{------------------------------------------------------------------}

function TPagesList.CompareWithKey(Item,Key:Pointer):Integer;
begin
  result := TPageListItem(Item).PageIndex - integer(key);
end;

{------------------------------------------------------------------}

function TPagesList.FindInList(PageIndex:integer;var Index : integer) : boolean;
begin
  result := FindByKey(Pointer(PageIndex),Index);
  if result then
    while (Index > 0) and (TPageListItem(Items[Index-1]).PageIndex = PageIndex) do
      dec(Index);
end;

{------------------------------------------------------------------}

var
  FillItems : TList;
type
  TFillListItem = class
  public
    ProcName : string ;
    Proc : TFillItemsProc;
    constructor Create(const AProcName :string; AProc:TFillItemsProc);
  end;

{------------------------------------------------------------------}

constructor TFillListItem.Create(const AProcName :string; AProc:TFillItemsProc);
begin
  inherited Create;
  ProcName := AProcName;
  Proc     := AProc;
end;

{------------------------------------------------------------------}

procedure RegisterFillItemsProc(const ProcName : string; Proc:TFillItemsProc);
begin
  FillItems.Add(TFillListItem.Create(ProcName,Proc));
end;

{------------------------------------------------------------------}

function GetRegisteredProc(const AProcName : string) : TFillItemsProc;
var
  i: integer;
begin
  result := nil;
  with FillItems do
    for i := Count-1 downto 0 do
      if TFillListItem(Items[i]).ProcName = AProcName then
      begin
        result := TFillListItem(Items[i]).Proc;
        break;
      end;
end;

const
  sBegID = 100;

{------------------------------------------------------------------}
function GetID(Id:integer) : integer;
begin
  result:= -(sBegId + Id);
end;

{----------TDCPageItemsSource-------------------------------------}

constructor TDCPageItemsSource.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FBitmap := TBitmap.Create;
  FPages := TStringList.Create;
  FPagesList := TPagesList.Create;
  FImageList :=  TImageList.Create(Self);
  with FImageList do
  begin
    Width := 24;
    Height := 24;
  end;
end;

{------------------------------------------------------------------}

destructor TDCPageItemsSource.Destroy ;
begin
  FPages.Free;
  FreeList(FPagesList);
  FBitmap.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (operation= opRemove)  and (Acomponent = FTreeLink) then
     FItemsConfig := nil;
  inherited;
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.Refresh;
var
   Info: PPropInfo;
begin
  FItemsConfig:=nil;
  if Assigned (Link) then
  begin
    Info:=GetPropInfo(Link.ClassInfo,FPropName);
    if Assigned(Info) then
      FItemsConfig:=TStrings(GetOrdProp(Link,Info));
  end;
  RefreshEditor;
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.SetItemsConfig(Value : TStrings);
begin
  FItemsConfig := Value;
  RefreshEditor;
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.SetFillProc(Value : string);
begin
  if FFillProc <> Value then
  begin
    FFillProc := Value;
    FProc := GetRegisteredProc(Value);
    RefreshEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.SortPages;
var
  i     : integer;
  idx   : integer;
  AName : string;

  {---------------------------------------------------}

  procedure UpdatePos(i,j:integer);
  var
    AString : string;
    AObject : TObject;
    cnt : integer;

  begin
    with FPages do
    begin
      AString := Strings[i];
      AObject := Objects[i];
      Delete(i);
      InsertObject(j,Astring,AObject);
      with  FPagesList do
        for cnt := 0 to Count - 1 do
          with TPageListItem(Items[cnt]) do
            if PageIndex = i then
               PageIndex := j;

    end;
  end;

  {---------------------------------------------------}
begin
  for i:=0 to FItemsConfig.Count-1 do
  begin
    with FItemsConfig do
    begin
      AName := Names[i];
      if AName = '' then
        AName := Strings[i];
    end;
    idx := FPages.IndexOf(AName);
    if (i >= 0) and (i < FPages.Count) and (idx >= 0) and (idx < FPages.Count) then
      UpdatePos(idx,i);
  end;
end;

{------------------------------------------------------------------}

function TDCPageItemsSource.AddBitmapForClass(AClass:TClass) : integer;
begin
  LoadBitmapForClass(FBitmap,AClass);
  FImageList.AddMasked(FBitmap,FBitmap.TransparentColor);
  result := FImageList.Count -1 ;
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.InterSectPages;
var
  i         : integer;
  idx       : integer;
  Sl        : TStringList;
  lastfound : integer;
  Item      : TPageListItem;
  {----------------------------------------------------------}

  function LastIndexOf(S:string) : integer;
  begin
    if (LastFound < FPages.Count) and (Fpages[LastFound] = S) then
        result := lastFound
    else
    begin
      result := FPages.IndexOf(S);
      LastFound := result;
    end;
  end;
  {----------------------------------------------------------}
begin
  FPages.Clear;
  lastfound := 0;
  Sl := CreateSortedStringList;
  try
    FImageList.Clear;
    ConvertPalettePages(ItemsConfig,Sl);
    ClearList(FPagesList);
    FProc(FPagesList);
    with FPagesList do
      for i:= 0 to Count - 1 do
      begin
        idx :=  LastIndexOf(TPageListItem(Items[i]).Page);
        if idx <0 then
        begin
          idx := FPages.Add(TPageListItem(Items[i]).Page);
          lastFound := idx;
        end;
        Item := Items[i];
        Item.Assign(Items[i]);
        Item.PageIndex := idx;
        Item.Index := i;
        if Sl.Find(Item.Caption,idx) and (Sl.Objects[idx] <> nil) then
          Item.Page := TItemRec(Sl.Objects[idx]).Page;
      end;
    finally
      Sl.Free;
    end;
    //SortPages;
end;


{------------------------------------------------------------------}

procedure TDCPageItemsSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
  i      : integer;
  R      : TNodeRec;
  found  : boolean;
  Idx  : integer;
  PIndex : integer;
begin
  if not ValidSource then
    Exit;
  if ObjId = 0 then
  begin
    FPagesList.Sorted := true;
    try
      InterSectPages;
    finally
      FPagesList.Sorted := true;
    end;
    for i:= 0 to FPages.Count - 1 do
    begin
      R:= GetNodeRec(GetID(i), -1, Self,FPages.Strings[i]);
      R.FontStyle := [fsBold];
      R.ImageIndex := -1 ;
      R.SelectedIndex := -1 ;
      Iterator(R);
    end;
  end
  else
  if ObjID < 0 then
    with FPagesList do
    begin
      PIndex := GetID(ObjId);
      found := FindInList(PIndex,Idx);
      if found then
        while (Idx < Count) do
          with TPageListItem(Items[Idx]) do
            if  PageIndex = PIndex then
            begin
              R := GetNodeRec(integer(Items[idx]), -1, Self, Caption);
              if ImageIndex = - 1 then
                ImageIndex := AddBitmapForClass(ClassPtr);
              R.ImageIndex := ImageIndex;
              R.SelectedIndex := ImageIndex;
              Iterator(R);
              inc(idx);
            end
            else
              break;
    end;
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.SetCaption(ObjID:Integer; const Caption:string);
var
  Lst : TList;
  R   : TNodeRec;
begin
  if ObjID <= 0 then
  begin
    Lst:=TList.Create;
    try
      Fillchar(R,Sizeof(R),0);
      R.Caption:=Caption;
      R.ObjId := ObjID;
      R.FontStyle := [fsBold];
      Lst.Add(@R);
      SendNotify(integer(Lst),TSOBJECTCHANGED);
    finally
      Lst.Free;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.Clear;
begin
  if ValidSource then
  begin
    ClearStrings(FPages);
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.Delete(ObjID:Integer);

  //s: string;
begin
  if (ObjId > 0) and ValidSource then
  begin
    //s := TCustomAction(ObjId).CateGory;
    
    FPagesList.Remove(Pointer(ObjID));
    TObject(ObjId).Free;
//    SetSelectedObject(0);
    inherited;
    {if FIndAction(s) < 0  then
      Refresheditor;}
  end;
end;

{------------------------------------------------------------------}

function  TDCPageItemsSource.CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;
begin
  result := (objId >0) and (destId >0) and (ObjId <> DestId);
end;

{------------------------------------------------------------------}

procedure TDCPageItemsSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
{var
  R:TNodeRec;}
begin
{  if ValidSource and CanMove(ObjID,DestID,InsertType) then
  begin
    with TCollectionItem(ObjID) do
    begin
      if InsertType in [itInsert,ItInsertFirst] then
      begin
        if Index<TCollectionItem(DestID).Index then
          Index:=TCollectionItem(DestID).Index-1
        else
          Index:=TCollectionItem(DestID).Index;
      end
      else
        Index:=TCollectionItem(ObjId).Collection.Count-1;
    end;
    TPagesEditorItem(ObjID).Category := TPagesEditorItem(DestID).Category;
    FillChar(R,Sizeof(R),0);
    R.ObjId  := ObjId;
    R.DestId := DestId;
    R.InsertType:=InsertType;
    R.Caption:=(TPagesEditorItem(ObjID).Caption);
    SendNotify(integer(@R),TSMOVETO);
  end;
  inherited;}
end;


{------------------------------------------------------------------}

function  TDCPageItemsSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  result := not (Action in [acRefreshDelete,acShowModal,acShowListView,acCanAdd,acCanAddChild])
end;

{------------------------------------------------------------------}

{function TDCPageItemsSource.FindAction(Category : string):integer;
var
  i:integer;
begin
  result := -1;
  if CompareText(Category,SDefaultCategory) =0 then
    Category := '';
  if ValidSource then
    with ActionList do
      for i:= 0 to ActionCount - 1 do
        if Actions[i].Category = Category then
        begin
          result := i;
          break;
        end;
end;
 }
{------------------------------------------------------------------}

function  TDCPageItemsSource.HasChild(objId:integer):boolean;
var
  idx: integer;
begin
  if ObjId = 0 then
    result := FPages.Count > 0
  else
    result := (ObjId < 0) and FPagesList.FindInList(GetID(objId),Idx);
end;

{------------------------------------------------------------------}

function  TDCPageItemsSource.GetStatusLine(ObjId:Integer):String;
begin
  if ObjId >= 0 then
    result := inherited GetStatusLine(ObjId)
  else
    result := FPages[GetID(ObjId)];
end;

{------------------------------------------------------------------}

function  TDCPageItemsSource.GetDisplayName(ObjID:integer):string;
begin
  if ObjId >= 0 then
    result := inherited GetDisplayName(ObjId)
  else
    result := FPages[GetID(ObjId)];
end;

{------------------------------------------------------------------}

function  TDCPageItemsSource.ValidSource:boolean;
begin
  result := Assigned(FItemsConfig) and Assigned(FProc);
end;

{------------------------------------------------------------------}

function  TDCPageItemsSource.GetParentId(ObjId:integer):integer;
begin
  if ObjId >0 then
    result := GetId(TPageListItem(ObjId).PageIndex)
  else
    result := 0;
end;

{------------------------------------------------------------------}

function  TDCPageItemsSource.GetLargeImages:TCustomImageList;
begin
  result := FImageList;
end;

{------------------------------------------------------------------}

function  TDCPageItemsSource.GetSmallImages:TCustomImageList;
begin
  result := FImageList;
end;

type
  TFillProcPropEditor = class(TStringProperty)
    function  GetAttributes : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{------------------------------------------------------------------}

function  TFillProcPropEditor.GetAttributes : TPropertyAttributes;
begin
  result := inherited GetAttributes;
  include(result,paValueList);
end;

{------------------------------------------------------------------}

procedure TFillProcPropEditor.GetValues(Proc: TGetStrProc);
var
  i: integer;
begin
  with FillItems do
    for i := 0 to Count-1  do
      Proc(TFillListItem(Items[i]).ProcName)
end;

{------------------------------------------------------------------}

procedure FillPaletteItem(AItems:TPagesList);
var
  i : integer;
  LItem : TPageListItem;
begin
  With App.ClassItems do
    for i:=0 to Count-1 do
      With TClassItem(Items[i]) do
        if (Categories * [icNoIcon, icShowinPalette] = [icShowInPalette]) and ClassPtr.InheritsFrom(TComponent) then
        begin
          LItem := TPageListItem.Create;
          LItem.ClassPtr := ClassPtr;
          with LItem do
          begin
            Caption :=  ClassPtr.ClassName;
            Page := PalettePage;
            ImageIndex := -1;
            Index := i;
          end;
          AItems.Add(LItem);
        end;

end;
  *)

{------------------------------------------------------------------}

//BeginSkipConst
procedure _Register;
begin
  RegisterDefaultTreeSource(TMenu,TDCMenuSource,'Items');
  RegisterDefaultTreeSource(TListView,TDCListViewSource,'Items');
  RegisterDefaultTreeSource(TTreeView,TDCTreeViewSource,'Items');
  RegisterTreeSource(TCollection,TDCCollectSource,'');
  RegisterTreeSource(TApplication,TDCCompViewSource,SVerbIdeInspector);
end;

{------------------------------------------------------------------

procedure _InstantRegister;
begin
  RegisterPropertyEditor(TypeInfo(string),TMenuItem,'Caption',TMenuNameEditor);
end;

//EndSkipConst
{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
//  RegisterForInstant(_InstantRegister);
end;

{------------------------------------------------------------------}

initialization
  CheckTrialVersion;
  Runregister;
end.
