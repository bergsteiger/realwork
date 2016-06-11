{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzureBlob;

interface

uses
  AzureUI, System.Classes, Vcl.ComCtrls, Vcl.Controls, DSAzDlgACL, DSAzDlgBlock,
  DSAzDlgBlockBlob, DSAzDlgBlockProps, DSAzDlgCopyBlob, DSAzDlgCreateContainer,
  DSAzDlgMetadata, DSAzDlgPage, DSAzDlgPageBlob, DSAzDlgPageProps,
  DSAzDlgPutBlockList, DSAzDlgSnapshotBlob, DSAzure, System.Generics.Collections,
  Vcl.ImgList, Vcl.Menus, System.SysUtils, Xml.XMLIntf;

type

  TIntSet =  set of 1..100;

  TBTreeNode = class(TTreeNode)
  public
    destructor Destroy; override;
  end;

  TBEnumeration = class abstract
  private
    FRefCount: Integer;
  public
    constructor Create;
  end;

  TBEnumerationItem<T: TBEnumeration> = class abstract
  private
    FEnumeration: T;
  public
    constructor Create(const Parent: T);
    destructor Destroy; override;

    property Enumeration: T read FEnumeration;
  end;

  TBContainer = class;

  TBContainers = class(TBEnumeration)
  private
    FPrefix: String;
    FMarker: String;
    FMaxResult: Integer;
    FContainer: TObjectList<TBContainer>;
    FNextMarker: String;
  public
    constructor Create;
    destructor Destroy; override;

    class function FromXML(Node: IXMLNode): TBContainers;

    property Prefix: String read FPrefix write FPrefix;
    property Marker: String read FMarker write FMarker;
    property MaxResult: Integer read FMaxResult write FMaxResult;
    property Items: TObjectList<TBContainer> read FContainer;
    property NextMarker: String read FNextMarker write FNextMarker;
  end;

  TBContainer = class(TBEnumerationItem<TBContainers>)
  private
    FName: String;
    FURL: String;
    FProperties: TDictionary<String, String>;
    FMetadata: TDictionary<String, String>;

  public
    constructor Create(const Parent: TBContainers);
    destructor Destroy; override;

    function IsRoot: boolean;

    class function FromXML(const Parent: TBContainers; Node: IXMLNode): TBContainer;
    procedure PopulateMeta(Meta: TStrings);
    procedure PopulateProperties(Props: TStrings);

    property Name: String read FName write FName;
    property URL: String read FURL write FURL;
    property Properties: TDictionary<String, String> read FProperties;
    property Metadata: TDictionary<String, String> read FMetadata;
  end;

  TBBlob = class;

  TBBlobs = class(TBEnumeration)
  private
    FContainerName: String;
    FPrefix: String;
    FMarker: String;
    FMaxResults: Integer;
    FDelimiter: String;
    FBlobs: TObjectList<TBBlob>;
    FNextMarker: String;
  public
    constructor Create;
    destructor Destroy; override;

    class function FromXML(const Node: IXMLNode): TBBlobs;

    property ContainerName: String read FContainerName write FContainerName;
    property Prefix: String read FPrefix write FPrefix;
    property Marker: String read FMarker write FMarker;
    property MaxResults: Integer read FMaxResults write FMaxResults;
    property Delimiter: String read FDelimiter write FDelimiter;
    property NextMarker: String read FNextMarker write FNextMarker;
    property Items: TObjectList<TBBlob> read FBlobs;
  end;

  TLeaseItem = class
  private
    FBlobURL: String;
    FLeaseID: String;
    FExpireTime: TDateTime;
  public
    constructor Create; virtual;
    property BlobURL: String read FBlobURL write FBlobURL;
    property LeaseID: String read FLeaseID write FLeaseID;
    property ExpireTime: TDateTime read FExpireTime write FExpireTime;
  end;

  /// <summary> Class which manages the lease information for blobs.
  /// </summary>
  TLeaseManager = class
  private
    FItems: TList<TLeaseItem>;
    function GetLeaseItem(out Success: Boolean; BlobURL: String; LeaseID: String = ''): TLeaseItem;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    /// <summary> Returns the single instance of this class. If none exists yet, it will be created.</summary>
    class function Instance: TLeaseManager;
    /// <summary> Returns the Lease ID for the blob with the given URL.</summary>
    function GetLeaseID(BlobURL: String): String;
    /// <summary> Returns the Lease expire time for the given blob. Only one of the two parameters
    ///    needs to be specified. LeaseID is ignored by default, but if you have that instead of the
    ///    BlobURL then pass in empty string for the url and specify the LeaseID.
    /// </summary>
    function GetLeaseExpireTime(BlobURL: String; LeaseID: String = ''): TDateTime;
    /// <summary> Sets the lease info for the blob with the given URL.</summary>
    procedure SetLeaseInfo(BlobURL, LeaseID: String; ExpireTime: TDateTime);
    /// <summary> Clears the lease information using either the BlobURL or LeaseID.</summary>
    procedure ClearLeaseInfo(BlobURL: String; LeaseID: String = '');
  end;

  TBBlob = class(TBEnumerationItem<TBBlobs>)
  private
    FName: String;
    FSnapshot: String;
    FURL: String;
    FProperties: TDictionary<String, String>;
    FMetadata: TDictionary<String, String>;

    function GetLeaseExpires: TDateTime;
    function GetLeaseID: String;
  public
    constructor Create(const Parent: TBBlobs);
    destructor Destroy; override;

    function IsPageBlob: boolean;
    function IsBlockBlob: boolean;
    function IsSnapshot: boolean;
    function IsLocked: boolean;
    function IsLeaseExpired: boolean;

    procedure SetLeaseInfo(LeaseID: String; LeaseExpires: TDateTime);

    class function FromXML(const Parent: TBBlobs; const Node: IXMLNode): TBBlob;
    procedure PopulateMeta(Meta: TStrings);
    procedure PopulateProperties(Props: TStrings);
    procedure PopulateProperty(const Name, Value: String);

    property Name: String read FName write FName;
    property Snapshot: String read FSnapshot write FSnapshot;
    property URL: String read FURL write FURL;
    property Properties: TDictionary<String, String> read FProperties;
    property Metadata: TDictionary<String, String> read FMetadata;
    property LeaseID: String read GetLeaseID;
    property LeaseExpires: TDateTime read GetLeaseExpires;
  end;

  TBSignedIdentifier = class;

  TBSignedIdentifiers = class(TBEnumeration)
  private
    FPublicAccess: String;
    FIdentifiers: TObjectList<TBSignedIdentifier>;
  public
    constructor Create(const Access: String);
    destructor Destroy; override;

    class function FromXML(const Access: String; const Node: IXMLNode): TBSignedIdentifiers;

    property PublicAccess: String read FPublicAccess write FPublicAccess;
    property Identifiers: TObjectList<TBSignedIdentifier> read FIdentifiers;
  end;

  TBSignedIdentifier = class(TBEnumerationItem<TBSignedIdentifiers>)
  private
    FId: String;
    FACL: TAccessPolicy;
  protected
    function GetPermission: String;
    procedure SetPermission(const rwdl: String);
  public
    constructor Create(const Parent: TBSignedIdentifiers);
    destructor Destroy; override;

    class function FromXML(const Parent: TBSignedIdentifiers; const Node: IXMLNode): TBSignedIdentifier;

    property Id: String read FId write FId;
    property Start: String read FACL.Start write FACL.Start;
    property Expiry: String read FACL.Expiry write FACL.Expiry;
    property Permission: String read GetPermission write SetPermission;
    property AccessPolicy: TAccessPolicy read FACL;
  end;

  TBPageRange = class;

  TBPageList = class(TBEnumeration)
  private
    FContentLength: String;
    FPages: TObjectList<TBPageRange>;

  public
    constructor Create(const Size: String);
    destructor Destroy; override;

    class function FromXML(const Size: String; const Node: IXMLNode): TBPageList;

    property ContentLength: String read FContentLength write FContentLength;
    property Pages: TObjectList<TBPageRange> read FPages;
  end;

  TBPageRange = class(TBEnumerationItem<TBPageList>)
  private
    FStart: String;
    FEnd: String;
  public
    constructor Create(const Parent: TBPageList);
    destructor Destroy; override;

    class function FromXML(const Parent: TBPageList; const Node: IXMLNode): TBPageRange;

    property EndByte: String read FEnd write FEnd;
    property StartByte: String read FStart write FStart;
  end;

  TBBlock = class;

  TBBlockList = class(TBEnumeration)
  private
    FContentLength: String;
    FCommitedBlocks: TObjectList<TBBlock>;
    FUncommitedBlocks: TObjectList<TBBlock>;

  public
    constructor Create(const Size: String);
    destructor Destroy; override;

    class function FromXML(const Size: String; const Node: IXMLNode): TBBlockList;

    property ContentLength: String read FContentLength write FContentLength;
    property CommitedBlocks: TObjectList<TBBlock> read FCommitedBlocks;
    property UncommitedBlocks: TObjectList<TBBlock> read FUncommitedBlocks;
  end;

  TBBlock = class(TBEnumerationItem<TBBlockList>)
  private
    FName: String;
    FSize: String;

  public
    constructor Create(const Parent: TBBlockList);
    destructor Destroy; override;

    class function FromXML(const Parent: TBBlockList; const Node: IXMLNode): TBBlock;

    property Name: String read FName write FName;
    property Size: String read FSize write FSize;
  end;

  TAzureBlobManagement = class(TAzureManagement)
  private
    FRootContainer: TBContainer;
    FRootNode: TTreeNode;
    FMenuNode: TTreeNode;

    FCreateContainer: TAzCreateContainerDlg;
    FBlockBlob: TAzBlockBlob;
    FPageBlob: TAzPageBlob;
    FPage: TAzPage;
    FBlock: TAzBlock;
    FMetadata: TAzMetadata;
    FBlockProps: TAzBlockProps;
    FPageProps: TAzPageProps;
    FACL: TAzACL;
    FSnapshot: TAzSnapshotBlob;
    FCopy: TAzCopyBlob;
    FBlockList: TAzPutBlockList;

    procedure SetActive(Status: boolean);
    function GetActive: boolean;

    procedure SetRootContainer(root: TBContainer);

    procedure PrepareMenu(Menu: TPopupMenu; Invisible: TIntSet; Disabled: TIntSet); overload;
    procedure PrepareMenu(MenuItem: TMenuItem; Invisible: TIntSet; Disabled: TIntSet); overload;
    procedure PrepareMenuVisible(Menu: TPopupMenu; Visible: TIntSet; Disabled: TIntSet); overload;
    procedure PrepareMenuVisible(Menu: TMenuItem; Visible: TIntSet; Disabled: TIntSet); overload;
    procedure CleanExtraSeparators(Menu: TPopupMenu);
    function AsMetadataHeaders(const Metadata: TStrings): TStringList;
    function ContentOf(const FileName: String): TArray<Byte>;
  protected
    { Protected declarations }
    procedure Clear;
    procedure RefreshLoadingNode(Node: TTreeNode);
    function ParseXML(const Xml: String): IXMLNode;
    function BlobService: TAzureBlobService;

    procedure PopulateRootNode(SelectRoot: boolean = false);
    procedure PopulateContainers;
    procedure PopulateContainerWithBlobs(ContainerNode: TTreeNode; const ContainerName: String; const Mark: boolean = false);
    procedure PopulateBlob(BlobNode: TTreeNode);
    procedure PopulateContainerWithACL(ACLNode: TTreeNode; Container: TBContainer);
    procedure PopulatePageList(PageNode: TTreeNode);
    procedure PopulateBlockList(BlockNode: TTreeNode);
    procedure PopulateMetadata(MetaNode: TTreeNode);
    procedure PopulateProperties(PropNode: TTreeNode);
    function  PopulateWithLoadingNode(Node: TTreeNode): TTreeNode;

    procedure PopulateLatestProperties(Container: TBContainer; BlobObj: TBBlob);
    procedure PopulateLatestMetadata(Container: TBContainer; BlobObj: TBBlob);

    procedure DeleteRootContainer;

    procedure MarkAsBusy(Node: TTreeNode);
    procedure MarkAsAvailable(Node: TTreeNode);
    function IsBusy(Node: TTreeNode): boolean;
    function IsAnyParentBusy(Node: TTreeNode): boolean;
    function AsObject(ptr: Pointer): TObject;

    function NeedsLoading(Node: TTreeNode): boolean;
    function IsRootNode(Node: TTreeNode): boolean;
    function IsContainerNode(Node: TTreeNode): boolean;
    function IsBlobNode(Node: TTreeNode): boolean;
    function IsACLNode(Node: TTreeNode): boolean;
    function IsPageRegionsNode(Node: TTreeNode): boolean;
    function IsBlockListNode(Node: TTreeNode): boolean;
    function IsMetadataNode(Node: TTreeNode): boolean;
    function IsPropertiesNode(Node: TTreeNode): boolean;
    function IsSnapshot(Node: TTreeNode): boolean;

    function ContainerOfACL(ACLNode: TTreeNode): TBContainer;
    function ContainerOf(Node: TTreeNode): TBContainer;
    function BlobOf(Node: TTreeNode): TBBlob;
    function SelectedBlob(Node: TTreeNode): TTreeNode;
    function SelectedContainer(Node: TTreeNode): TTreeNode;
    function FirstRootBlob: TTreeNode;
    function PageNodeOf(BlobNode: TTreeNode): TTreeNode;
    function BlockNodeOf(BlobNode: TTreeNode): TTreeNode;
    function MetadataOf(Node: TTreeNode): TTreeNode;
    function PropertiesOf(Node: TTreeNode): TTreeNode;
    function ACLOf(ContainerNode: TTreeNode): TTreeNode;
    function FindContainer(const Name: String): TTreeNode;

    procedure BlobNodeFactory(Sender: TCustomTreeView; var NodeClass: TTreeNodeClass);
    procedure NodeExpandedAction(Sender: TObject; Node: TTreeNode);
    procedure ImageIndexEvent(Sender: TObject; Node: TTreeNode);
    function CreateImageList: TCustomImageList;

    function  CreatePopuMenu: TPopupMenu;
    procedure UpdatePopupMenu(Sender: TObject);
    procedure MenuForRoot(Menu: TPopupMenu);
    procedure MenuForContainer(Menu: TPopupMenu);
    procedure MenuForBlockBlob(Menu: TPopupMenu);
    procedure MenuForPageBlob(Menu: TPopupMenu);
    procedure MenuInitial(Menu: TPopupMenu);
    procedure MenuBusy(Menu: TPopupMenu);

    procedure CreateRootContainerAction(Sender: TObject);
    procedure CreateContainerAction(Sender: TObject);
    procedure DeleteRootContainerAction(Sender: TObject);
    procedure CreateBlockBlobAction(Sender: TObject);
    procedure CreatePageBlobAction(Sender: TObject);
    procedure RefreshAction(Sender: TObject);
    procedure ActivateAction(Sender: TObject);
    procedure ManagePageAction(Sender: TObject);
    procedure ManageBlockAction(Sender: TObject);
    procedure DeleteBlobAction(Sender: TObject);
    procedure DeleteContainerAction(Sender: TObject);
    procedure IsBusyAction(Sender: TObject);
    procedure EditBlobMetadataAction(Sender: TObject);
    procedure EditContainerMetadataAction(Sender: TObject);
    procedure EditBlockPropertiesAction(Sender: TObject);
    procedure EditPagePropertiesAction(Sender: TObject);
    procedure EditACLAction(Sender: TObject);
    procedure CreateSnapshotAction(Sender: TObject);
    procedure CopyBlobAction(Sender: TObject);
    procedure DownloadAction(Sender: TObject);
    procedure CommitBlockListAction(Sender: TObject);
    procedure AcquireLeaseAction(Sender: TObject);
    procedure CopyLeaseAction(Sender: TObject);
    procedure RenewLeaseAction(Sender: TObject);
    procedure ReleaseLeaseAction(Sender: TObject);
    procedure BreakLeaseAction(Sender: TObject);
    procedure UpdateBlockBlobAction(Sender: TObject);

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }
    property Align;
    property Anchors;
    property AutoExpand;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property ChangeDelay;
    property Color;
    property Ctl3D;
    property Constraints;
    property DoubleBuffered;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HotTrack;
    property RightClickSelect;
    property RowSelect;
    property Touch;
    property Visible;

    property ConnectionInfo;
    property Active: boolean read GetActive write SetActive;
  end;

implementation

uses Winapi.ActiveX, Vcl.ClipBrd, System.DateUtils, System.UITypes, Data.DBXClientResStrs, Vcl.Dialogs, Vcl.Graphics, Xml.XMLDoc;

const
  REASONABLE_SIZE = 16*1024;

  CREATE_ROOT_CONTAINER_ITEM = 1;
  REFRESH_ITEM = 2;
  SEP_1 = 3;
  ACTIVATE_ITEM = 4;
  DELETE_ROOT_CONTAINER = 5;
  SEP_2 = 6;
  CREATE_CONTAINER = 7;
  CREATE_BLOCK_BLOB = 8;
  CREATE_PAGE_BLOB = 9;
  PAGE_MANAGEMENT = 10;
  BLOCK_MANAGEMENT = 11;
  SEP_3 = 12;
  DELETE_CONTAINER = 13;
  DELETE_BLOB = 14;
  BUSY_ITEM = 15;
  BLOB_METADATA = 16;
  CONTAINER_METADATA = 17;
  BLOCK_PROPERTIES = 18;
  PAGE_PROPERTIES = 19;
  ACL_ITEM = 20;
  SNAPSHOT_ITEM = 21;
  COPY_BLOB = 22;
  DOWNLOAD_ITEM = 23;
  COMMIT_BLOCK_LIST = 24;
  LEASE_ITEM = 25;
  ACQUIRE_LEASE = 26;
  COPY_LEASE_ID = 27;
  RENEW_LEASE = 28;
  RELEASE_LEASE = 29;
  BREAK_LEASE = 30;
  UPDATE_BLOCK_BLOB = 31;

var
  LeaseManagerInstance: TLeaseManager;

type
  TAnonymousWorker = reference to procedure;

  TAnonymousThread = class(TThread)
  private
    FWorker: TAnonymousWorker;
  public
    constructor Create(Worker: TAnonymousWorker);
    destructor Destroy; override;
    procedure Execute; override;
  end;

{ TAzureBlobManagement }

function TAzureBlobManagement.ACLOf(ContainerNode: TTreeNode): TTreeNode;
begin
  Assert(ContainerNode <> nil);
  // one of the children is a metadata node
  Result := ContainerNode.getFirstChild;
  while Result <> nil do
  begin
    if IsACLNode(Result) then
      exit;
    Result := Result.getNextSibling;
  end
end;

procedure TAzureBlobManagement.CopyLeaseAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  leaseId: String;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);

  leaseId := blob.LeaseID;

  if leaseId <> EmptyStr then
  begin
    Clipboard.AsText := leaseId;
  end;
end;

procedure TAzureBlobManagement.AcquireLeaseAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  containerNode: TTreeNode;
  container: TBContainer;
  leaseId: string;
  leaseExpires: TDateTime;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  MarkAsBusy(blobNode);
  TAnonymousThread.Create(procedure
  var
    duration: Integer;
    LBlobService: TAzureBlobService;
  begin
    LBlobService := BlobService;
    try
      LBlobService.LeaseBlob(container.Name, blob.Name);
      leaseId := LBlobService.ResponseHeader['x-ms-lease-id'];
      duration := 60;
      leaseExpires := IncSecond(Now, duration);
      blob.SetLeaseInfo(leaseId, leaseExpires);
      ShowInformationMessage(Format(SLeaseAcquireNotice, [container.Name, blob.Name, duration]));
      MarkAsAvailable(blobNode);
      LBlobService.Free;
    except
      // display error
      ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);

      MarkAsAvailable(blobNode);
      LBlobService.Free;
    end;
  end);
end;

procedure TAzureBlobManagement.ActivateAction(Sender: TObject);
begin
  Active := true;
end;

function TAzureBlobManagement.AsMetadataHeaders(
  const Metadata: TStrings): TStringList;
var
  I, Count: Integer;
begin
  Result := TStringList.Create;
  Count := Metadata.Count;
  for I := 0 to Count - 1 do
    Result.Values[Format('x-ms-meta-%s', [Metadata.Names[I]])] := Metadata.ValueFromIndex[I];
end;

function TAzureBlobManagement.AsObject(ptr: Pointer): TObject;
begin
  Result := TObject(Pointer((IntPtr(ptr) shr 1) shl 1))
end;

procedure TAzureBlobManagement.BlobNodeFactory(Sender: TCustomTreeView;
  var NodeClass: TTreeNodeClass);
begin
  NodeClass := TBTreeNode;
end;

function TAzureBlobManagement.BlobOf(Node: TTreeNode): TBBlob;
begin
  Assert(Node <> nil);
  Assert(not IsRootNode(Node));
  Result := AsObject(Node.Data) as TBBlob;
end;

function TAzureBlobManagement.BlobService: TAzureBlobService;
begin
  Result := TAzureBlobService.Create(FConnectionInfo);
end;

function TAzureBlobManagement.BlockNodeOf(BlobNode: TTreeNode): TTreeNode;
begin
  Result := BlobNode.getFirstChild;
  while (Result <> nil) and not IsBlockListNode(Result) do
    Result := Result.getNextSibling;
end;

procedure TAzureBlobManagement.BreakLeaseAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  containerNode: TTreeNode;
  container: TBContainer;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  MarkAsBusy(blobNode);
  TAnonymousThread.Create(procedure
  var
    duration: Integer;
    LBlobService: TAzureBlobService;
  begin
    LBlobService := BlobService;
    try
      LBlobService.LeaseBlob(container.Name, blob.Name, 'break', '');
      duration := StrToInt(LBlobService.ResponseHeader['x-ms-lease-time']);
      ShowInformationMessage(Format(SLeaseBreakNotice, [container.Name, blob.Name, duration]));
      MarkAsAvailable(blobNode);
      LBlobService.Free;
    except
      ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);

      MarkAsAvailable(blobNode);
      LBlobService.Free;
    end;
  end);
end;

procedure TAzureBlobManagement.CleanExtraSeparators(Menu: TPopupMenu);
var
  item: TMenuItem;
  hasVizItem: boolean;
begin
  hasVizItem := false;
  for item in Menu.Items do
    if 'N' = Copy(item.Name, 1, 1) then
    begin
      item.Visible := hasVizItem;
      hasVizItem := false;
    end else
      hasVizItem := Item.Visible
end;

procedure TAzureBlobManagement.Clear;
begin
  FreeAndNil(FRootContainer);
  if FRootNode <> nil then
  begin
    MarkAsBusy(FRootNode);
    TThread.Queue(nil, procedure begin
      FRootNode.Delete;
      FRootNode := nil;
    end);
  end;
end;

procedure TAzureBlobManagement.RefreshLoadingNode(Node: TTreeNode);
begin
  MarkAsBusy(FRootNode);
  TThread.Queue(nil, procedure begin
    try
      Node.DeleteChildren;
      PopulateWithLoadingNode(Node);
      Expand(Node);
    finally
      MarkAsAvailable(FRootNode);
    end
  end);
end;

procedure TAzureBlobManagement.ReleaseLeaseAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  containerNode: TTreeNode;
  container: TBContainer;
  LBlobService: TAzureBlobService;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  MarkAsBusy(blobNode);
  TAnonymousThread.Create(procedure
  begin
    LBlobService := BlobService;
    try
      LBlobService.LeaseBlob(container.Name, blob.Name, 'release', blob.LeaseID);
      blob.SetLeaseInfo(EmptyStr, 0);
      ShowInformationMessage(Format(SLeaseReleaseNotice, [container.Name, blob.Name]));
      MarkAsAvailable(blobNode);
      LBlobService.Free;
    except
      ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);

      MarkAsAvailable(blobNode);
      LBlobService.Free;
    end;
  end);
end;

procedure TAzureBlobManagement.RenewLeaseAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  containerNode: TTreeNode;
  container: TBContainer;
  leaseId: String;
  leaseExpires: TDateTime;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  MarkAsBusy(blobNode);
  TAnonymousThread.Create(procedure
  var
    duration: Integer;
    LBlobService: TAzureBlobService;
  begin
    LBlobService := BlobService;
    try
      LBlobService.LeaseBlob(container.Name, blob.Name, 'renew', blob.LeaseID);
      leaseId := LBlobService.ResponseHeader['x-ms-lease-id'];
      duration := 60;
      leaseExpires := IncSecond(Now, duration);
      blob.SetLeaseInfo(leaseId, leaseExpires);
      ShowInformationMessage(Format(SLeaseRenewNotice, [container.Name, blob.Name, duration]));
      MarkAsAvailable(blobNode);
      LBlobService.Free;
    except
      ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
      MarkAsAvailable(blobNode);
      LBlobService.Free;
    end;
  end);
end;

procedure TAzureBlobManagement.CommitBlockListAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  containerNode: TTreeNode;
  container: TBContainer;
  xmlStr: String;
  doc: IXMLNode;
  blockList: TBBlockList;
  size: String;
  i, count, ucount: Integer;
  xmlList, md5, cacheControl, language, contentType, encoding: string;
  metaHeaders: TStringList;
  LBlobService: TAzureBlobService;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  LBlobService := BlobService;
  try
    xmlStr := LBlobService.GetBlockList(container.Name, blob.Name, 'all');
    size := LBlobService.ResponseHeader['x-ms-blob-content-length'];
    LBlobService.Free;
  except
    // display error
    MessageDlg(SErrorGeneric + LBlobService.ResponseText, mtError, [mbOK], 0);
    LBlobService.Free;

    exit;
  end;

  doc := ParseXML(xmlStr);
  blockList := TBBlockList.FromXML(size, doc);

  // open the block list dialog
  FBlockList.Caption := Format(SCommitBlockListCaption, [container.Name, blob.Name]);
  FBlockList.ClearLists;
  count := blockList.CommitedBlocks.Count;
  ucount := blockList.UncommitedBlocks.Count;
  for i := 0 to count - 1 do
  begin
    FBlockList.AddCommittedBlockName(TAzureService.Decode(blockList.CommitedBlocks[i].Name));
    blockList.CommitedBlocks[i].Free;
  end;
  for i := 0 to ucount - 1 do
  begin
    FBlockList.AddUncommittedBlockName(TAzureService.Decode(blockList.UncommitedBlocks[i].Name));
    blockList.UncommitedBlocks[i].Free;
  end;
  if count + ucount = 0 then
    blockList.Free;

  if FBlockList.OKBtn.Enabled then
  begin
    if FBlockList.ShowModal = mrOK then
    begin
      FBlockList.Encode := procedure(const InStr: string; var outStr: string) begin
        outStr := TAzureService.Encode(InStr);
      end;
      xmlList := FBlockList.BlockListAsXML;
      FBlockList.Encode := nil;
      cacheControl := FBlockList.GetCacheControl;
      contentType := FBlockList.GetContentType;
      encoding := FBlockList.GetContentEncoding;
      language := FBlockList.GetContentLanguage;
      md5 := FBlockList.GetContentMD5;
      metaHeaders := AsMetadataHeaders(FBlockList.RawMetadata);

      MarkAsBusy(blobNode);
      TAnonymousThread.Create(procedure
      begin
        try
          // commit the list
          LBlobService := BlobService;
          try
            if not LBlobService.PutBlockList(container.Name, blob.Name, xmlList, '', cacheControl,
                                contentType, encoding, language, md5, blob.LeaseID, metaHeaders) then
            begin
               // display error
               ShowErrorMessage(Format(SCommitBlockListFailure,
                                       [container.Name, blob.Name, LBlobService.ReturnCode]) + LBlobService.ResponseText);
               exit;
            end
          finally
            LBlobService.Free;
          end;

          // populate the tree
          containerNode := BlockNodeOf(blobNode);
          if containerNode <> nil then
            PopulateBlockList(containerNode);
        finally
          metaHeaders.Free;
          MarkAsAvailable(blobNode);
        end;
      end);
    end
  end else
    MessageDlg(Format(SBlockListIsEmpty, [container.Name, blob.Name, SBlobPageItem]),
               mtWarning, [mbOK], 0);
end;

function TAzureBlobManagement.ContainerOf(Node: TTreeNode): TBContainer;
begin
  if IsRootNode(Node) then
    Result := FRootContainer
  else
    Result := TBContainer(Node.Data);
end;

function TAzureBlobManagement.ContainerOfACL(ACLNode: TTreeNode): TBContainer;
begin
  if IsRootNode(ACLNode.Parent) then
    Result := FRootContainer
  else
    Result := TBContainer(ACLNode.Parent.Data);
end;

function TAzureBlobManagement.ContentOf(const FileName: String): TArray<Byte>;
var
  fs: TFileStream;
begin
  if FileName <> EmptyStr then
  begin
    fs := TFileStream.Create(FileName, fmOpenRead);
    SetLength(Result, fs.Size);
    fs.ReadBuffer(Result[0], fs.Size);
    fs.Free;
  end else
    SetLength(Result, 0);
end;

procedure TAzureBlobManagement.CopyBlobAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  containerNode: TTreeNode;
  container: TBContainer;
  metaHeaders: TStringList;
  modSince, unmodSince, match, noMatch: String;
  name: String;
  destCont, destBlob: String;
  destModSince, destUnmodSince, destMatch, destNoMatch: String;
  destContNode: TTreeNode;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  name := blob.Name;
  if blob.IsSnapshot then
    name := Format('%s: snapshot=%s', [blob.Name, blob.Snapshot]);
  FCopy.Caption := Format(SCopyBlobCaption, [container.Name, name]);
  FCopy.DestContainer := container.Name;
  if FCopy.ShowModal = mrOK then
  begin
    destCont := FCopy.GetDestContainer;
    destContNode := FindContainer(destCont);
    if destContNode = nil then
    begin
      MessageDlg(Format(SDestContainerNotFound, [destCont]), mtError, [mbOK], 0);
      exit
    end;

    destBlob := FCopy.GetDestBlob;
    destModSince := FCopy.GetDestModifiedSince;
    destUnmodSince := FCopy.GetDestUnmodifiedSince;
    destMatch := FCopy.GetDestMatch;
    destNoMatch := FCopy.GetDestNoneMatch;
    modSince := FCopy.GetSrcModifiedSince;
    unmodSince := FCopy.GetSrcUnmodifiedSince;
    match := FCopy.GetSrcMatch;
    noMatch := FCopy.GetSrcNoneMatch;
    metaHeaders := AsMetadataHeaders(FCopy.RawMetadata);

    MarkAsBusy(destContNode);
    TAnonymousThread.Create(procedure
    var
      xmlStr: String;
      xmlNode: IXMLNode;
      blobs: TBBlobs;
      LBlobService: TAzureBlobService;
    begin
      LBlobService := BlobService;
      try
        LBlobService.CopyBlob(destCont, destBlob, container.Name, blob.Name, blob.Snapshot,
                     modSince, unmodSince, match, noMatch, destModSince, destUnmodSince,
                     destMatch, destNoMatch, '', '', metaHeaders);
        if NeedsLoading(destContNode) then
          blobs := nil
        else
        begin
          xmlStr := LBlobService.ListBlobs(destCont, ['prefix', 'maxresults', 'include'],
                     [destBlob, '1', 'metadata']);

          CoInitialize(nil);
          xmlNode := ParseXML(xmlStr);
          blobs := TBBlobs.FromXML(xmlNode);
        end;

        metaHeaders.Free;
        LBlobService.Free;
      except
        ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
        LBlobService.Free;
        MarkAsAvailable(destContNode);
        metaHeaders.Free;
        exit;
      end;

      if blobs <> nil then
        TThread.Queue(nil, procedure
        var I: Integer;
          item: TBBlob;
        begin
          Items.BeginUpdate;

          try
            if blobs.Items.Count = 0 then
              blobs.Free
            else
              for I := 0 to blobs.Items.Count - 1 do
              begin
                item := blobs.Items.Items[I];
                PopulateWithLoadingNode(Items.AddChildObject(destContNode, item.Name, Pointer(item)))
              end;
          finally
            Items.EndUpdate;
            MarkAsAvailable(destContNode);
          end
        end)
      else
        MarkAsAvailable(destContNode);
    end);
  end;
end;

constructor TAzureBlobManagement.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCreateContainer := TAzCreateContainerDlg.Create(self);
  FBlockBlob := TAzBlockBlob.Create(self);
  FPageBlob := TAzPageBlob.Create(self);
  FPage := TAzPage.Create(self);
  FBlock := TAzBlock.Create(self);
  FMetadata := TAzMetadata.Create(self);
  FBlockProps := TAzBlockProps.Create(self);
  FPageProps := TAzPageProps.Create(self);
  FACL := TAzACL.Create(self);
  FSnapshot := TAzSnapshotBlob.Create(self);
  FCopy := TAzCopyBlob.Create(self);
  FBlockList := TAzPutBlockList.Create(self);

  ReadOnly := true;
  PopupMenu := CreatePopuMenu;
  RightClickSelect := true;
  Images := CreateImageList;
  OnGetImageIndex := ImageIndexEvent;

  OnCreateNodeClass := BlobNodeFactory;
  OnExpanded := NodeExpandedAction;

  TAzureService.SetUp;
end;

procedure TAzureBlobManagement.CreateBlockBlobAction(Sender: TObject);
var
  act: Integer;
  containerNode: TTreeNode;
  container: TBContainer;
  blobName, contentType, contentEncoding, contentLanguage, contentMD5, location: string;
  metaHeaders: TStringList;
begin
  containerNode := SelectedContainer(FMenuNode);
  if containerNode <> nil then
  begin
    container := ContainerOf(containerNode);
    Assert(container<>nil);
    FBlockBlob.Caption := Format(SCreateBlockBlobCaption, [container.Name]);
    FBlockBlob.RawMetadata.Clear;
    FBlockBlob.BlobName := '';
    FBlockBlob.SetOKCaption(SOKCreateCaption);

    act := FBlockBlob.ShowModal;
    if mrOK = act then
    begin
      blobName := FBlockBlob.GetBlobName;
      metaHeaders := AsMetadataHeaders(FBlockBlob.RawMetadata);
      location := FBlockBlob.GetContentLocation;
      contentType := FBlockBlob.ContentType;
      contentEncoding := FBlockBlob.ContentEncoding;
      contentLanguage := FBlockBlob.ContentLanguage;
      contentMD5 := FBlockBlob.ContentMD5;

      MarkAsBusy(containerNode);
      TAnonymousThread.Create(procedure
      var
        xmlStr: String;
        xmlNode: IXMLNode;
        blobs: TBBlobs;
        content: TArray<Byte>;
        LBlobService: TAzureBlobService;
      begin
        LBlobService := BlobService;
        try
          content := ContentOf(location);
          if Length(content) > REASONABLE_SIZE then
            ShowInformationMessage(SLongTimeOperation);

          LBlobService.PutBlockBlob(container.Name, blobName, content, EmptyStr, metaHeaders,
                       contentType, contentEncoding, contentLanguage, contentMD5);
          xmlStr := LBlobService.ListBlobs(container.Name, ['prefix', 'maxresults', 'include'],
                       [blobName, '1', 'metadata']);

          CoInitialize(nil);
          xmlNode := ParseXML(xmlStr);
          blobs := TBBlobs.FromXML(xmlNode);

          metaHeaders.Free;
          LBlobService.Free;
        except
          ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);

          LBlobService.Free;
          metaHeaders.Free;

          MarkAsAvailable(containerNode);
          exit;
        end;
        TThread.Queue(nil, procedure
        var I: Integer;
          item: TBBlob;
        begin
          Items.BeginUpdate;

          try
            if blobs.Items.Count = 0 then
              blobs.Free
            else
              for I := 0 to blobs.Items.Count - 1 do
              begin
                item := blobs.Items.Items[I];
                PopulateWithLoadingNode(Items.AddChildObject(ContainerNode,item.Name,
                                        Pointer(item)))
              end;
          finally
            Items.EndUpdate;
            MarkAsAvailable(containerNode);
          end
        end);
      end);
    end;
  end;
end;

procedure TAzureBlobManagement.CreateContainerAction(Sender: TObject);
var
  modalAction: Integer;
  metaHeaders: TStringList;
  access, containerName: string;
begin
  FCreateContainer.SetTitle(SCreateNewContainerTitle);
  FCreateContainer.RawMetadata.Clear;
  FCreateContainer.SetContainerName('');

  modalAction := FCreateContainer.ShowModal;
  if mrOK = modalAction then
  begin
    metaHeaders := AsMetadataHeaders(FCreateContainer.RawMetadata);
    access := FCreateContainer.PublicDataAccess;
    containerName := FCreateContainer.GetContainerName;
    MarkAsBusy(FRootNode);
    TAnonymousThread.Create(procedure
    var
      xmlStr: String;
      node: IXMLNode;
      containers: TBContainers;
      LBlobService: TAzureBlobService;
    begin
      try
        CoInitialize(nil);

        // create the root container
        LBlobService := BlobService;
        try
          if not LBlobService.CreateContainer(containerName, metaHeaders, access) then
            raise Exception.Create(Format(SContainerCreateFailure, [containerName, LBlobService.ReturnCode]));
          xmlStr := LBlobService.ListContainers(['prefix', 'maxresults', 'include'], [containerName, '1', 'metadata']);
          LBlobService.Free;
        except
          ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
          LBlobService.Free;
          MarkAsAvailable(FRootNode);
          exit;
        end;

        node := ParseXML(xmlStr);
        containers := TBContainers.FromXML(node);

        TThread.Queue(nil, procedure
        var I: Integer;
          last: TTreeNode;
          item: TBContainer;
        begin
          Items.BeginUpdate;
          try
            for I := 0 to containers.Items.Count - 1 do
            begin
              item := containers.Items.Items[I];
              // find the last container
              if FRootContainer = nil then
                PopulateWithLoadingNode(Items.AddChildObject(FRootNode, item.Name, Pointer(item)))
              else begin
                last := FirstRootBlob;
                if last = nil then
                  PopulateWithLoadingNode(Items.AddChildObject(FRootNode, item.Name, Pointer(item)))
                else
                  PopulateWithLoadingNode(Items.InsertObject(last, item.Name, Pointer(item)))
              end
            end;
            if containers.Items.Count = 0 then
              containers.Free;
          finally
            MarkAsAvailable(FRootNode);
            Items.EndUpdate;
          end
        end);
      finally
        metaHeaders.Free;
      end
    end);
  end
end;

function TAzureBlobManagement.CreateImageList: TCustomImageList;
var
  Images: TCustomImageList;
  BMP: Vcl.Graphics.TBitmap;
begin
  Images := TCustomImageList.Create(Self);

  BMP := GetAzureImage('IMG_AZUREPAGEREGIONS');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREBLOCKLIST');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZURECONTAINER');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREBLOCKBLOB');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREPAGEBLOB');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREBLOBS');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREACL');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREPROP');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREMETA');
  Images.Add(BMP, nil);
  BMP.Free;

  Result := Images;
end;

procedure TAzureBlobManagement.CreatePageBlobAction(Sender: TObject);
var
  act: Integer;
  containerNode: TTreeNode;
  container: TBContainer;
  blobName, contentType, contentEncoding, contentLanguage, contentMD5: string;
  contentLength, seqNb: int64;
  metaHeaders: TStringList;
begin
  containerNode := SelectedContainer(FMenuNode);
  if containerNode <> nil then
  begin
    container := ContainerOf(containerNode);
    Assert(container<>nil);

    FPageBlob.Caption := Format(SCreatePageBlobCaption, [container.Name]);
    FPageBlob.RawMetadata.Clear;
    act := FPageBlob.ShowModal;
    if mrOK = act then
    begin
      blobName := FPageBlob.GetBlobName;
      contentLength := FPageBlob.GetContentLength;
      seqNb := FPageBlob.GetSequenceNumber;
      contentType := FPageBlob.GetContentType;
      contentEncoding := FPageBlob.GetContentEncoding;
      contentLanguage := FPageBlob.GetContentLanguage;
      contentMD5 := FPageBlob.GetContentMD5;
      metaHeaders := AsMetadataHeaders(FBlockBlob.RawMetadata);

      MarkAsBusy(containerNode);
      TAnonymousThread.Create(procedure
      var
        xmlStr: String;
        xmlNode: IXMLNode;
        blobs: TBBlobs;
        LBlobService: TAzureBlobService;
      begin
        blobs := nil;
        LBlobService := BlobService;
        try
          LBlobService.PutPageBlob(container.Name, blobName, contentLength, seqNb, metaHeaders,
                      contentType, contentEncoding, contentLanguage, contentMD5);
          xmlStr := LBlobService.ListBlobs(container.Name, ['prefix', 'maxresults', 'include'],
                       [blobName, '1', 'metadata']);

          CoInitialize(nil);

          xmlNode := ParseXML(xmlStr);
          blobs := TBBlobs.FromXML(xmlNode);
          metaHeaders.Free;
          LBlobService.Free;
        except
          ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
          LBlobService.Free;
          metaHeaders.Free;
          blobs.Free;
          MarkAsAvailable(containerNode);
          exit;
        end;
        TThread.Queue(nil, procedure
        var I: Integer;
          item: TBBlob;
          name: String;
        begin
          Items.BeginUpdate;

          try
            if blobs.Items.Count = 0 then
              blobs.Free
            else
              for I := 0 to blobs.Items.Count - 1 do
              begin
                item := blobs.Items.Items[I];
                name := item.Name;
                PopulateWithLoadingNode(Items.AddChildObject(ContainerNode, name, Pointer(item)))
              end;
          finally
            Items.EndUpdate;
            MarkAsAvailable(containerNode);
          end
        end);
      end);
    end;
  end;
end;

function TAzureBlobManagement.CreatePopuMenu: TPopupMenu;
var
  Item: TMenuItem;
  subItem: TMenuItem;
begin
  Result := TPopupMenu.Create(Self);
  Result.OnPopup := UpdatePopupMenu;

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(CREATE_ROOT_CONTAINER_ITEM);
  Item.Caption := SCreateRootContainer;
  Item.OnClick := CreateRootContainerAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(CREATE_CONTAINER);
  Item.Caption := SCreateContainer;
  Item.OnClick := CreateContainerAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(CREATE_BLOCK_BLOB);
  Item.Caption := SCreateBlockBlob;
  Item.OnClick := CreateBlockBlobAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(CREATE_PAGE_BLOB);
  Item.Caption := SCreatePageBlob;
  Item.OnClick := CreatePageBlobAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(UPDATE_BLOCK_BLOB);
  Item.Caption := SUpdateBlockBlob;
  Item.OnClick := UpdateBlockBlobAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(COPY_BLOB);
  Item.Caption := SCopyBlob;
  Item.OnClick := CopyBlobAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(SNAPSHOT_ITEM);
  Item.Caption := SSnapshotItem;
  Item.OnClick := CreateSnapshotAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(LEASE_ITEM);
  Item.Caption := SLeaseItem;
  Result.Items.Add(Item);

  subItem := Result.CreateMenuItem;
  subItem.Name := 'I' + IntToStr(ACQUIRE_LEASE);
  subItem.Caption := SLeaseAcquire;
  subItem.OnClick := AcquireLeaseAction;
  Item.Add(subItem);

  subItem := Result.CreateMenuItem;
  subItem.Name := 'I' + IntToStr(COPY_LEASE_ID);
  subItem.Caption := SCopyLeaseId;
  subItem.OnClick := CopyLeaseAction;
  Item.Add(subItem);

  subItem := Result.CreateMenuItem;
  subItem.Name := 'I' + IntToStr(RENEW_LEASE);
  subItem.Caption := SLeaseRenew;
  subItem.OnClick := RenewLeaseAction;
  Item.Add(subItem);

  subItem := Result.CreateMenuItem;
  subItem.Name := 'I' + IntToStr(RELEASE_LEASE);
  subItem.Caption := SLeaseRelease;
  subItem.OnClick := ReleaseLeaseAction;
  Item.Add(subItem);

  subItem := Result.CreateMenuItem;
  subItem.Name := 'I' + IntToStr(BREAK_LEASE);
  subItem.Caption := SLeaseBreak;
  subItem.OnClick := BreakLeaseAction;
  Item.Add(subItem);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(DOWNLOAD_ITEM);
  Item.Caption := SDownloadItem;
  Item.OnClick := DownloadAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'N' + IntToStr(SEP_3);
  Item.Caption := '-';
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(BLOCK_PROPERTIES);
  Item.Caption := SProperties;
  Item.OnClick := EditBlockPropertiesAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(PAGE_PROPERTIES);
  Item.Caption := SProperties;
  Item.OnClick := EditPagePropertiesAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(BLOB_METADATA);
  Item.Caption := SMetadataItem;
  Item.OnClick := EditBlobMetadataAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(ACL_ITEM);
  Item.Caption := SACLItem;
  Item.OnClick := EditACLAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(CONTAINER_METADATA);
  Item.Caption := SMetadataItem;
  Item.OnClick := EditContainerMetadataAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(PAGE_MANAGEMENT);
  Item.Caption := SBlobPageItem;
  Item.OnClick := ManagePageAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(BLOCK_MANAGEMENT);
  Item.Caption := SBlobBlockItem;
  Item.OnClick := ManageBlockAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(COMMIT_BLOCK_LIST);
  Item.Caption := SCommitBlockList;
  Item.OnClick := CommitBlockListAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'N' + IntToStr(SEP_1);
  Item.Caption := '-';
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(DELETE_ROOT_CONTAINER);
  Item.Caption := SDeleteRootContainer;
  Item.OnClick := DeleteRootContainerAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(DELETE_CONTAINER);
  Item.Caption := SDeleteContainer;
  Item.OnClick := DeleteContainerAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(DELETE_BLOB);
  Item.Caption := SDeleteBlob;
  Item.OnClick := DeleteBlobAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'N' + IntToStr(SEP_2);
  Item.Caption := '-';
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(REFRESH_ITEM);
  Item.Caption := SRefresh;
  Item.OnClick := RefreshAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(ACTIVATE_ITEM);
  Item.Caption := SActivate;
  Item.OnClick := ActivateAction;
  Result.Items.Add(Item);

  Item := Result.CreateMenuItem;
  Item.Name := 'I' + IntToStr(BUSY_ITEM);
  Item.Caption := SIsBusyItem;
  Item.OnClick := IsBusyAction;
  Result.Items.Add(Item);

end;

procedure TAzureBlobManagement.CreateRootContainerAction(Sender: TObject);
var
  modalAction: Integer;
  metaHeaders: TStringList;
  access: string;
  LBlobService: TAzureBlobService;
begin
  FCreateContainer.SetContainerName('$root', false);
  FCreateContainer.SetTitle(SCreateRootContainerTitle);
  FCreateContainer.RawMetadata.Clear;

  modalAction := FCreateContainer.ShowModal;
  if mrOK = modalAction then
  begin
    metaHeaders := AsMetadataHeaders(FCreateContainer.RawMetadata);
    access := FCreateContainer.PublicDataAccess;

    MarkAsBusy(FRootNode);
    TAnonymousThread.Create(procedure
    begin
      try
        // create the root container
        LBlobService := BlobService;
        try
          if not LBlobService.CreateContainer('$root', metaHeaders, access) then
            raise Exception.Create(Format(SRootContainerCreateFailure, [LBlobService.ReturnCode]));
          LBlobService.Free;
        except
          ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
          LBlobService.Free;
          exit;
        end;
        // refresh the tree
        RefreshLoadingNode(FRootNode);
      finally
        metaHeaders.Free;
        MarkAsAvailable(FRootNode);
      end
    end);
  end
end;

procedure TAzureBlobManagement.CreateSnapshotAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  containerNode: TTreeNode;
  container: TBContainer;
  metaHeaders: TStringList;
  modSince, unmodSince, match, noMatch: String;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  FSnapshot.PopulateWithMetadata(blob.Metadata);
  FSnapshot.Caption := Format(SSnapshotCaption, [container.Name, blob.Name]);
  if FSnapshot.ShowModal = mrOK then
  begin
    modSince := FSnapshot.GetModifiedSince;
    unmodSince := FSnapshot.GetUnmodifiedSince;
    match := FSnapshot.GetMatch;
    noMatch := FSnapshot.GetNoneMatch;
    metaHeaders := AsMetadataHeaders(FSnapshot.RawMetadata);

    MarkAsBusy(containerNode);
    TAnonymousThread.Create(procedure
    var
      snapshot: String;
      xmlStr: String;
      xmlNode: IXMLNode;
      blobs: TBBlobs;
      LBlobService: TAzureBlobService;
    begin
      try
        LBlobService := BlobService;
        try
          snapshot := LBlobService.SnapshotBlob(container.Name, blob.Name, modSince, unmodSince,
                                   match, noMatch, '', metaHeaders);
          xmlStr := LBlobService.ListBlobs(container.Name, ['prefix', 'include', 'include'],
                       [blob.Name, 'metadata', 'snapshots']);

          CoInitialize(nil);
          xmlNode := ParseXML(xmlStr);
          blobs := TBBlobs.FromXML(xmlNode);

          metaHeaders.Free;
          LBlobService.Free;
        except
         ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
         metaHeaders.Free;
         LBlobService.Free;
         exit;
        end;

        TThread.Queue(nil, procedure
        var I: Integer;
          item: TBBlob;
        begin
          Items.BeginUpdate;

          try
            if blobs.Items.Count = 0 then
              blobs.Free
            else
              for I := 0 to blobs.Items.Count - 1 do
              begin
                item := blobs.Items.Items[I];
                if item.IsSnapshot and (item.Snapshot = snapshot) then
                  PopulateWithLoadingNode(Items.AddChildObject(ContainerNode,
                                          Format('%s: snapshot=%s', [item.Name, item.Snapshot]),
                                          Pointer(item)))
                else
                  item.Free;
              end
          finally
            Items.EndUpdate;
            MarkAsAvailable(containerNode);
          end
        end);
      except
        MarkAsAvailable(containerNode)
      end
    end);
  end
end;

procedure TAzureBlobManagement.DeleteBlobAction(Sender: TObject);
var
  blobNode: TTreeNode;
  containerNode: TTreeNode;
  container: TBContainer;
  blob: TBBlob;
  LBlobService: TAzureBlobService;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  if MessageDlg(Format(SDeleteBlobMsg, [blob.Name, container.Name]), mtConfirmation,
                [mbYes, mbNo], 0) = mrYes then
  begin
    MarkAsBusy(blobNode);
    TAnonymousThread.Create(procedure
    begin
      LBlobService := BlobService;
      try
        if not LBlobService.DeleteBlob(container.Name, blob.Name, blob.Snapshot, blob.LeaseID) then
          raise Exception.Create(Format(SDeleteBlobFailure, [container.Name, blob.Name, LBlobService.ReturnCode]));
        LBlobService.Free;
      except
        ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
        LBlobService.Free;
        MarkAsAvailable(blobNode);
        exit;
      end;

      TThread.Queue(nil, procedure
      begin
        Items.BeginUpdate;
        try
          blobNode.Delete;
        finally
          MarkAsAvailable(blobNode);
          Items.EndUpdate;
        end
      end);
    end);
  end
end;

procedure TAzureBlobManagement.DeleteContainerAction(Sender: TObject);
var
  containerNode: TTreeNode;
  container: TBContainer;
  LBlobService: TAzureBlobService;
begin
  containerNode := SelectedContainer(FMenuNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  if MessageDlg(Format(SDeleteContainerMsg, [container.Name]), mtConfirmation,
                [mbYes, mbNo], 0) = mrYes then
  begin
    MarkAsBusy(containerNode);
    TAnonymousThread.Create(procedure
    begin
      LBlobService := BlobService;
      try
        if not LBlobService.DeleteContainer(container.Name) then
        begin
          MarkAsAvailable(containerNode);
          ShowErrorMessage(Format(SDeleteContainerFailure, [container.Name, LBlobService.ReturnCode]) + LBlobService.ResponseText);
          exit;
        end
      finally
        LBlobService.Free;
      end;

      TThread.Queue(nil, procedure
      begin
        Items.BeginUpdate;
        try
          containerNode.Delete;
        finally
          MarkAsAvailable(containerNode);
          Items.EndUpdate;
        end
      end);
    end);
  end
end;

procedure TAzureBlobManagement.DeleteRootContainer;
var
  LBlobService: TAzureBlobService;
begin
  MarkAsBusy(FRootNode);
  TAnonymousThread.Create(procedure
  begin
    CoInitialize(nil);
    LBlobService := BlobService;
    try
      if not LBlobService.DeleteContainer('$root') then
      begin
        MarkAsAvailable(FRootNode);
        ShowErrorMessage(Format(SRootContainerDeleteFailure, [LBlobService.ReturnCode]) + LBlobService.ResponseText);
        exit;
      end;
    finally
      LBlobService.Free;
    end;
    FreeAndNil(FRootContainer);

    TThread.Queue(nil, procedure
    var I: Integer;
      node: TTreeNode;
    begin
      Items.BeginUpdate;
      try
        for I := FRootNode.Count - 1 downto 0 do
        begin
          node := FRootNode.Item[I];
          // remove all blobs, ACL, property and metadata nodes
          if IsACLNode(node) or IsBlobNode(node) or IsPropertiesNode(node) or IsMetadataNode(node) then
            node.Delete
        end;
      finally
        MarkAsAvailable(FRootNode);
        Items.EndUpdate;
      end
    end);
  end);
end;

procedure TAzureBlobManagement.DeleteRootContainerAction(Sender: TObject);
begin
  if MessageDlg(Format(SAreYouSure, ['$root', SContainer]), mtConfirmation,
                [mbYes, mbNo], 0) = mrYes then
    DeleteRootContainer;
end;

destructor TAzureBlobManagement.Destroy;
begin
  FRootContainer.Free;
  inherited;
end;

procedure TAzureBlobManagement.DownloadAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  containerNode: TTreeNode;
  container: TBContainer;
  fsDlg: TSaveDialog;
  location: string;
  stream: TFileStream;
  LBlobService: TAzureBlobService;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  fsDlg := TSaveDialog.Create(self);
  if fsDlg.Execute(Handle) then
  begin
    location := fsDlg.FileName;
    if FileExists(location) then
    begin
      if MessageDlg(Format(SOverrideFile, [location]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        stream := TFileStream.Create(location, fmOpenWrite)
      else
        exit;
    end else
      stream := TFileStream.Create(location, fmCreate);

    MarkAsBusy(blobNode);
    TAnonymousThread.Create(procedure begin
      try
        LBlobService := BlobService;
        try
          if not LBlobService.GetBlob(container.Name, blob.Name, stream, blob.Snapshot) then
            ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
        finally
          LBlobService.Free;
        end
      finally
        MarkAsAvailable(blobNode);
        stream.Free;
      end
    end);
  end
end;

procedure TAzureBlobManagement.EditACLAction(Sender: TObject);
var
  containerNode: TTreeNode;
  container: TBContainer;
  LBlobService: TAzureBlobService;
begin
  containerNode := SelectedContainer(FMenuNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container <> nil);

  MarkAsBusy(containerNode);
  TAnonymousThread.Create(procedure
  var
    access, xmlStr: string;
    doc: IXMLNode;
    identifiers: TBSignedIdentifiers;
  begin
    try
      CoInitialize(nil);
      // get the container acl data from the cloud
      LBlobService := BlobService;
      try
        xmlStr := LBlobService.GetContainerACL(container.Name);
        access := LBlobService.ResponseHeader['x-ms-blob-public-access'];
        LBlobService.Free;
      except
        MarkAsAvailable(containerNode);
        ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
        LBlobService.Free;
        exit;
      end;

      doc := ParseXML(xmlStr);
      identifiers := TBSignedIdentifiers.FromXML(access, doc);

      TThread.Queue(nil, procedure
      var
        i, count: Integer;
        LBlobService: TAzureBlobService;
      begin
        try
          FACL.PublicDataAccess := access;
          count := identifiers.Identifiers.Count;
          for i := 0 to count - 1 do
          begin
            FACL.SetAccessPolicy(i, identifiers.Identifiers[i].Id, identifiers.Identifiers[i].AccessPolicy);
            identifiers.Identifiers[i].Free
          end;
          if count > 0 then
            FACL.MoveToRow(0)
          else
            identifiers.Free;
          FACL.SetBaseline;
          if FACL.ShowModal = mrOK then
          begin
            // save the new ACL list
            count := FACL.Count;
            LBlobService := BlobService;
            try
              for i := 0 to count - 1 do
                if FACL.RawIdentifier[i] <> EmptyStr then
                  if not LBlobService.SetContainerACL(container.Name, FACL.Identifier[i], FACL.AccessPolicy[i],
                                  FACL.PublicDataAccess ) then
                  begin
                    MessageDlg(SErrorGeneric + LBlobService.ResponseText, mtError, [mbOK], 0);
                    exit;
                  end
            finally
              LBlobService.Free;
            end;
            // populate the container tree node ACL list
            PopulateContainerWithACL(ACLOf(containerNode), container);
          end
        finally
          MarkAsAvailable(containerNode);
        end
      end);
    except
      MarkAsAvailable(containerNode);
    end
  end);
end;

procedure TAzureBlobManagement.EditBlobMetadataAction(Sender: TObject);
var
  blobNode: TTreeNode;
  containerNode: TTreeNode;
  container: TBContainer;
  blob: TBBlob;
  meta: TStringList;
  LBlobService: TAzureBlobService;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container <> nil);

  MarkAsBusy(blobNode);
  TAnonymousThread.Create(procedure begin
      // query for metadata
    LBlobService := BlobService;
    try
      if not LBlobService.GetBlobMetadata(container.Name, blob.Name, blob.Snapshot) then
      begin
        MarkAsAvailable(blobNode);
        ShowErrorMessage(Format(SMetadataBlobFailure, [container.Name, blob.Name, LBlobService.ReturnCode]) + LBlobService.ResponseText);
        exit;
      end;
      meta := TStringList.Create;
      LBlobService.PopulateContainer('x-ms-meta-', meta);
    finally
      LBlobService.Free;
    end;
    TThread.Queue(nil, procedure begin
        FMetadata.PopulateContentFromHeader(meta);
        FMetadata.Caption := Format(SMetadataBlobCaption, [container.Name, blob.Name]);
        if FMetadata.ShowModal = mrOK then
        begin
          FMetadata.PopulateHeaderFromContainer(meta);
          try
            LBlobService := BlobService;
            try
              if not LBlobService.SetBlobMetadata(container.Name, blob.Name, meta, blob.LeaseID) then
              begin
                MarkAsAvailable(blobNode);
                MessageDlg(Format(SMetadataBlobFailure, [container.Name, blob.Name, LBlobService.ReturnCode]) +
                           LBlobService.ResponseText, mtError, [mbOK], 0);
                exit;
              end
            finally
              LBlobService.Free;
            end;
            blob.PopulateMeta(meta);
            PopulateMetadata(MetadataOf(blobNode));
          finally
            MarkAsAvailable(blobNode);
            meta.Free;
          end
        end else begin
          MarkAsAvailable(blobNode);
          meta.Free;
        end;
      end);
  end);
end;

procedure TAzureBlobManagement.EditBlockPropertiesAction(Sender: TObject);
var
  blobNode: TTreeNode;
  containerNode: TTreeNode;
  container: TBContainer;
  blob: TBBlob;
  md5, contentType, encoding, language, cache: string;
  LBlobService: TAzureBlobService;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container <> nil);

  MarkAsBusy(blobNode);
  TAnonymousThread.Create(procedure begin
    try
      // query for metadata
      LBlobService := BlobService;
      try
        if not LBlobService.GetBlobProperties(container.Name, blob.Name, blob.Snapshot) then
        begin
          MarkAsAvailable(blobNode);
          ShowErrorMessage(Format(SPropertiesFailure, [container.Name, blob.Name, LBlobService.ReturnCode]) + LBlobService.ResponseText);
          exit;
        end;
        md5 := LBlobService.ResponseHeader['Content-MD5'];
        contentType := LBlobService.ResponseHeader['Content-Type'];
        encoding := LBlobService.ResponseHeader['Content-Encoding'];
        language := LBlobService.ResponseHeader['Content-Language'];
        cache := LBlobService.ResponseHeader['Cache-Control'];
      finally
        LBlobService.Free;
      end;
      TThread.Queue(nil, procedure begin
        FBlockProps.MD5 := md5;
        FBlockProps.ContentType := contentType;
        FBlockProps.Encoding := encoding;
        FBlockProps.Language := language;
        FBlockProps.Cache := cache;
        FBlockProps.Caption := Format(SPropertiesCaption, [container.Name, blob.Name]);
        FBlockProps.SetBaseline;
        if FBlockProps.ShowModal = mrOK then
        begin
          md5 := FBlockProps.MD5;
          contentType := FBlockProps.ContentType;
          encoding := FBlockProps.Encoding;
          language := FBlockProps.Language;
          cache := FBlockProps.Cache;
          try
            LBlobService := BlobService;
            try
              if not LBlobService.SetBlobProperties(container.Name, blob.Name, cache,
                             contentType, encoding, language, md5, blob.LeaseID) then
              begin
                MessageDlg(Format(SPropertiesFailure, [container.Name, blob.Name, LBlobService.ReturnCode]) +
                           LBlobService.ResponseText, mtError, [mbOK], 0);
                exit
              end
            finally
              LBlobService.Free;
            end;
            blob.PopulateProperty('Content-MD5', md5);
            blob.PopulateProperty('Content-Type', contentType);
            blob.PopulateProperty('Content-Encoding', encoding);
            blob.PopulateProperty('Content-Language', language);
            blob.PopulateProperty('Cache-Control', cache);
            PopulateProperties(PropertiesOf(blobNode));
          finally
            MarkAsAvailable(blobNode);
          end
        end else begin
          MarkAsAvailable(blobNode);
        end;
      end);
    except
      MarkAsAvailable(blobNode);
    end
  end);
end;

procedure TAzureBlobManagement.EditContainerMetadataAction(Sender: TObject);
var
  containerNode: TTreeNode;
  container: TBContainer;
  meta: TStringList;
  LBlobService: TAzureBlobService;
begin
  containerNode := SelectedContainer(FMenuNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container <> nil);

  MarkAsBusy(containerNode);
  TAnonymousThread.Create(procedure begin
    try
      // query for metadata
      LBlobService := BlobService;
      try
        if not LBlobService.GetContainerMetadata(container.Name) then
        begin
          MarkAsAvailable(containerNode);
          ShowErrorMessage(Format(SMetadataContainerFailure, [container.Name, LBlobService.ReturnCode]) + LBlobService.ResponseText);
          exit;
        end;
        meta := TStringList.Create;
        LBlobService.PopulateContainer('x-ms-meta-', meta);
      finally
        LBlobService.Free;
      end;
      TThread.Queue(nil, procedure begin
        FMetadata.Caption := Format(SMetadataContainerCaption, [container.Name]);
        FMetadata.PopulateContentFromHeader(meta);
        if FMetadata.ShowModal = mrOK then
        begin
          FMetadata.PopulateHeaderFromContainer(meta);
          try
            LBlobService := BlobService;
            try
              if not LBlobService.SetContainerMetadata(container.Name, meta) then
              begin
                MessageDlg(Format(SMetadataContainerFailure, [container.Name, LBlobService.ReturnCode]) +
                           LBlobService.ResponseText, mtError, [mbOK], 0);
                exit
              end;
            finally
              LBlobService.Free;
            end;
            container.PopulateMeta(meta);
            PopulateMetadata(MetadataOf(containerNode));
          finally
            MarkAsAvailable(containerNode);
            meta.Free;
          end
        end else begin
          MarkAsAvailable(containerNode);
          meta.Free;
        end;
      end);
    except
      MarkAsAvailable(containerNode);
    end
  end);
end;

procedure TAzureBlobManagement.EditPagePropertiesAction(Sender: TObject);
var
  blobNode: TTreeNode;
  containerNode: TTreeNode;
  container: TBContainer;
  blob: TBBlob;
  md5, contentType, encoding, language, cache, length, sequence: string;
  LBlobService: TAzureBlobService;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container <> nil);

  MarkAsBusy(blobNode);
  TAnonymousThread.Create(procedure begin
    try
      // query for metadata
      LBlobService := BlobService;
      try
        if not LBlobService.GetBlobProperties(container.Name, blob.Name, blob.Snapshot) then
        begin
          MarkAsAvailable(blobNode);
          ShowErrorMessage(Format(SPropertiesFailure, [container.Name, blob.Name, LBlobService.ReturnCode]) + LBlobService.ResponseText);
          exit;
        end;
        md5 := LBlobService.ResponseHeader['Content-MD5'];
        contentType := LBlobService.ResponseHeader['Content-Type'];
        encoding := LBlobService.ResponseHeader['Content-Encoding'];
        language := LBlobService.ResponseHeader['Content-Language'];
        cache := LBlobService.ResponseHeader['Cache-Control'];
        length := LBlobService.ResponseHeader['Content-Length'];
        sequence := LBlobService.ResponseHeader['x-ms-blob-sequence-number'];
      finally
        LBlobService.Free;
      end;

      TThread.Queue(nil, procedure begin
        FPageProps.MD5 := md5;
        FPageProps.ContentType := contentType;
        FPageProps.Encoding := encoding;
        FPageProps.Language := language;
        FPageProps.Cache := cache;
        FPageProps.Length := length;
        FPageProps.Sequence := sequence;
        FPageProps.SetBaseline;
        FPageProps.Caption := Format(SPropertiesCaption, [container.Name, blob.Name]);
        if FPageProps.ShowModal = mrOK then
        begin
          LBlobService := BlobService;
          try
            if not LBlobService.SetPageBlobProperties(container.Name, blob.Name, FPageProps.Cache,
                             FPageProps.ContentType, FPageProps.Encoding,
                             FPageProps.Language, FPageProps.MD5, FPageProps.Length,
                             FPageProps.Action, FPageProps.Sequence, blob.LeaseID) then
            begin
              MessageDlg(Format(SPropertiesFailure, [container.Name, blob.Name, LBlobService.ReturnCode]) +
                         LBlobService.ResponseText, mtError, [mbOK], 0);
              exit
            end;
            blob.PopulateProperty('Content-MD5', FPageProps.MD5);
            blob.PopulateProperty('Content-Type', FPageProps.ContentType);
            blob.PopulateProperty('Content-Encoding', FPageProps.Encoding);
            blob.PopulateProperty('Content-Language', FPageProps.Language);
            blob.PopulateProperty('Cache-Control', FPageProps.Cache);
            blob.PopulateProperty('Content-Length', FPageProps.Length);
            blob.PopulateProperty('x-ms-blob-sequence-number', FPageProps.Sequence);

            PopulateProperties(PropertiesOf(blobNode));
          finally
            MarkAsAvailable(blobNode);
            LBlobService.Free;
          end
        end else begin
          MarkAsAvailable(blobNode);
        end;
      end);

    except
      MarkAsAvailable(blobNode);
    end
  end);
end;

function TAzureBlobManagement.FindContainer(const Name: String): TTreeNode;
begin
  if ('$root' = Name) then
    if (FRootContainer <> nil) then
      exit(FRootNode)
    else
      exit(nil);
  Result := FRootNode.getFirstChild;
  while Result <> nil do
  begin
    if IsContainerNode(Result) and (ContainerOf(Result).Name = Name) then
      exit;
    Result := Result.getNextSibling
  end;
end;

function TAzureBlobManagement.FirstRootBlob: TTreeNode;
var
  node: TTreeNode;
begin
  Result := nil;
  node := FRootNode.GetLastChild;
  while node <> nil do
  begin
    if IsContainerNode(node) then
      exit;
    Result := node;
    node := FRootNode.GetPrevChild(node)
  end
end;

function TAzureBlobManagement.GetActive: boolean;
begin
  Result := FRootNode <> nil;
end;

procedure TAzureBlobManagement.ImageIndexEvent(Sender: TObject;
  Node: TTreeNode);
var
  idx: Integer;
begin
  idx := -1;
  if IsContainerNode(Node) then
    idx := 2
  else if IsBlobNode(Node) then
    if TBBlob(AsObject(node.Data)).IsBlockBlob then
      idx := 3
    else
      idx := 4
  else if IsPageRegionsNode(Node) then
    idx := 0
  else if IsBlockListNode(Node) then
    idx := 1
  else if IsRootNode(Node) then
    idx := 5
  else if IsACLNode(Node) then
    idx := 6
  else if IsPropertiesNode(Node) then
    idx := 7
  else if IsMetadataNode(Node) then
    idx := 8;

  Node.ImageIndex := idx;
  Node.SelectedIndex := idx;
end;

function TAzureBlobManagement.IsACLNode(Node: TTreeNode): boolean;
begin
  Result := Node.Text = SACL;
end;

function TAzureBlobManagement.IsAnyParentBusy(Node: TTreeNode): boolean;
begin
  Result := false;
  if Node.Parent <> nil then
    Result := IsBusy(Node.Parent) or
              IsAnyParentBusy(Node.Parent);
end;

function TAzureBlobManagement.IsBlobNode(Node: TTreeNode): boolean;
begin
  Result := (AsObject(Node.Data) <> nil) and
            (AsObject(Node.Data) is TBBlob);
end;

function TAzureBlobManagement.IsBlockListNode(Node: TTreeNode): boolean;
begin
  Result := Node.Text = SBlockList;
end;

function TAzureBlobManagement.IsBusy(Node: TTreeNode): boolean;
begin
  Result := (Node <> nil) and ((IntPtr(Node.Data) and 1) = 1);
end;

procedure TAzureBlobManagement.IsBusyAction(Sender: TObject);
begin
   MessageDlg(SIsBusy, mtInformation, [mbOK], 0)
end;

function TAzureBlobManagement.IsContainerNode(Node: TTreeNode): boolean;
begin
  // is called when the node is not busy
  Result := false;
  if AsObject(Node.Data) <> nil then
    Result := AsObject(Node.Data) is TBContainer;
end;

function TAzureBlobManagement.IsMetadataNode(Node: TTreeNode): boolean;
begin
  Result := AnsiCompareText(Node.Text, SMetadata) = 0;
end;

function TAzureBlobManagement.IsPageRegionsNode(Node: TTreeNode): boolean;
begin
  Result := AnsiCompareText(Node.Text, SPageRegions) = 0;
end;

function TAzureBlobManagement.IsPropertiesNode(Node: TTreeNode): boolean;
begin
  Result := Node.Text = SProperties;
end;

function TAzureBlobManagement.IsRootNode(Node: TTreeNode): boolean;
begin
  Result := Node.Text = SAzureBlobs;
end;

function TAzureBlobManagement.IsSnapshot(Node: TTreeNode): boolean;
begin
  Result := IsBlobNode(Node) and (BlobOf(Node).Snapshot <> EmptyStr)
end;

function TAzureBlobManagement.SelectedBlob(Node: TTreeNode): TTreeNode;
begin
  Assert(Node <> nil);
  if IsBlobNode(Node) then
    exit(Node);
  exit(SelectedBlob(Node.Parent));
end;

function TAzureBlobManagement.SelectedContainer(Node: TTreeNode): TTreeNode;
begin
  if IsContainerNode(Node) then
    exit(Node);
  if IsRootNode(Node) then
    exit(FRootNode);
  exit(SelectedContainer(Node.Parent));
end;

procedure TAzureBlobManagement.ManageBlockAction(Sender: TObject);
var
  act: Integer;
  blobNode: TTreeNode;
  containerNode: TTreeNode;
  container: TBContainer;
  blob: TBBlob;
  blockContent: TArray<Byte>;
  blockId, leaseID, MD5: string;
  LBlobService: TAzureBlobService;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  FBlock.Caption := Format(SBlobPageCaption, [container.Name, blob.Name]);
  FBlock.LeaseId := blob.LeaseID;
  act := FBlock.ShowModal;
  if mrOK = act then
  begin
    blockId := FBlock.BlockId;
    blockContent := FBlock.Content;
    leaseID := FBlock.LeaseId;
    MD5 := FBlock.MD5;

    MarkAsBusy(blobNode);
    TAnonymousThread.Create(procedure
      var
        blockNode: TTreeNode;
      begin
        LBlobService := BlobService;
        try
          if not LBlobService.PutBlock(container.Name, blob.Name, blockId, blockContent, leaseID,
                          MD5) then
          begin
            MarkAsAvailable(blobNode);
            ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
            exit;
          end;
          blockNode := BlockNodeOf(blobNode);
        finally
          LBlobService.Free;
        end;
        if blockNode <> nil then
          TThread.Queue(nil, procedure
          begin
            try
              PopulateWithLoadingNode(blockNode);
              Expand(blockNode);
            finally
              MarkAsAvailable(blobNode);
            end
          end)
        else
          MarkAsAvailable(blobNode);
      end);
    end;
end;

procedure TAzureBlobManagement.ManagePageAction(Sender: TObject);
var
  act: Integer;
  blobNode: TTreeNode;
  containerNode: TTreeNode;
  container: TBContainer;
  blob: TBBlob;
  pageContent: TArray<Byte>;
  firstByte, endByte: Int64;
  pageWrite, contentMD5, leaseID, modifiedSince, unmodifiedSince, ifMatch, ifNoneMatch: string;
  sequenceNumberLte, sequenceNumberLt, sequenceNumberEq: string;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  FPage.Caption := Format(SBlobPageCaption, [container.Name, blob.Name]);
  FPage.SetLeaseID(blob.LeaseID);
  act := FPage.ShowModal;
  if mrOK = act then
  begin
    pageContent := FPage.Content;
    firstByte := FPage.FirstByte;
    endByte := FPage.EndByte;
    pageWrite := FPage.GetPageWrite;
    contentMD5 := FPage.GetContentMD5;
    leaseID := FPage.GetLeaseID;
    modifiedSince := FPage.GetModifiedSince;
    unmodifiedSince := FPage.GetUnmodifiedSince;
    ifMatch := FPage.IfMatch;
    ifNoneMatch := FPage.IfNoneMatch;
    sequenceNumberLte := FPage.GetSequenceNumberLte;
    sequenceNumberLt := FPage.GetSequenceNumberLt;
    sequenceNumberEq := FPage.GetSequenceNumberEq;

    MarkAsBusy(blobNode);
    TAnonymousThread.Create(procedure
      var
        pageNode: TTreeNode;
        LBlobService: TAzureBlobService;
      begin
        LBlobService := BlobService;
        try
          if not LBlobService.PutPage(container.Name, blob.Name, pageContent, firstByte, endByte,
                       pageWrite, contentMD5, leaseID, sequenceNumberLte, sequenceNumberLt,
                       sequenceNumberEq, modifiedSince, unmodifiedSince, ifMatch,
                       ifNoneMatch) then
          begin
            MarkAsAvailable(blobNode);
            ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
            exit;
          end;
          pageNode := PageNodeOf(blobNode);
        finally
          LBlobService.Free;
        end;
        if pageNode <> nil then
          TThread.Queue(nil, procedure
          begin
            try
              PopulateWithLoadingNode(pageNode);
              Expand(pageNode);
            finally
              MarkAsAvailable(blobNode);
            end
          end)
        else
          MarkAsAvailable(blobNode);
      end);
    end;
end;

procedure TAzureBlobManagement.MarkAsAvailable(Node: TTreeNode);
begin
  Node.Data := Pointer((IntPtr(Node.Data) shr 1) shl 1);
end;

procedure TAzureBlobManagement.MarkAsBusy(Node: TTreeNode);
begin
  Node.Data := Pointer(IntPtr(Node.Data) or 1);
end;

procedure TAzureBlobManagement.MenuBusy(Menu: TPopupMenu);
begin
  PrepareMenuVisible(Menu, [BUSY_ITEM], []);
end;

procedure TAzureBlobManagement.MenuForBlockBlob(Menu: TPopupMenu);
var
  inv, dis: TIntSet;
begin
  inv := [BUSY_ITEM, CREATE_ROOT_CONTAINER_ITEM, ACTIVATE_ITEM, DELETE_ROOT_CONTAINER,
          CREATE_CONTAINER, CREATE_PAGE_BLOB, CREATE_BLOCK_BLOB, PAGE_MANAGEMENT,
          DELETE_CONTAINER, CONTAINER_METADATA, PAGE_PROPERTIES, ACL_ITEM];
  if IsSnapshot(FMenuNode) then
    dis := [SNAPSHOT_ITEM, BLOCK_MANAGEMENT, BLOCK_PROPERTIES, BLOB_METADATA,
            COMMIT_BLOCK_LIST, UPDATE_BLOCK_BLOB]
  else
    dis := [];
  if IsBlobNode(FMenuNode) and (BlobOf(FMenuNode).LeaseID <> EmptyStr) and not BlobOf(FMenuNode).IsLeaseExpired then
    dis := dis + [ACQUIRE_LEASE]
  else
  begin
    dis := dis + [RENEW_LEASE, RELEASE_LEASE, COPY_LEASE_ID];
  end;
  PrepareMenu(Menu, inv, dis);
end;

procedure TAzureBlobManagement.MenuForContainer(Menu: TPopupMenu);
var
  inv, dis: TIntSet;
begin
  inv := [BUSY_ITEM, CREATE_ROOT_CONTAINER_ITEM, ACTIVATE_ITEM, DELETE_ROOT_CONTAINER,
          CREATE_CONTAINER, PAGE_MANAGEMENT, BLOCK_MANAGEMENT, DELETE_BLOB, BLOB_METADATA,
          BLOCK_PROPERTIES, PAGE_PROPERTIES, SNAPSHOT_ITEM, COPY_BLOB, DOWNLOAD_ITEM,
          COMMIT_BLOCK_LIST, LEASE_ITEM, UPDATE_BLOCK_BLOB];
  dis := [];
  PrepareMenu(Menu, inv, dis);
end;

procedure TAzureBlobManagement.MenuForPageBlob(Menu: TPopupMenu);
var
  inv, dis: TIntSet;
begin
  inv := [BUSY_ITEM, CREATE_ROOT_CONTAINER_ITEM, ACTIVATE_ITEM, DELETE_ROOT_CONTAINER,
          CREATE_CONTAINER, CREATE_PAGE_BLOB, CREATE_BLOCK_BLOB, BLOCK_MANAGEMENT,
          DELETE_CONTAINER, CONTAINER_METADATA, BLOCK_PROPERTIES, ACL_ITEM, COMMIT_BLOCK_LIST,
          UPDATE_BLOCK_BLOB];
  if IsSnapshot(FMenuNode) then
    dis := [SNAPSHOT_ITEM, PAGE_MANAGEMENT, PAGE_PROPERTIES, BLOB_METADATA]
  else
    dis := [];
  if IsBlobNode(FMenuNode) and (BlobOf(FMenuNode).LeaseID <> EmptyStr) and not BlobOf(FMenuNode).IsLeaseExpired then
    dis := dis + [ACQUIRE_LEASE]
  else
  begin
    dis := dis + [RENEW_LEASE, RELEASE_LEASE, COPY_LEASE_ID];
  end;
  PrepareMenu(Menu, inv, dis);
end;

procedure TAzureBlobManagement.MenuForRoot(Menu: TPopupMenu);
var
  disabled: TIntSet;
begin
  if NeedsLoading(FRootNode) then
    PrepareMenuVisible(Menu, [REFRESH_ITEM], [])
  else begin
    disabled := [];
    if FRootContainer <> nil then
      disabled := disabled + [CREATE_ROOT_CONTAINER_ITEM]
    else
      disabled := disabled + [CREATE_BLOCK_BLOB, CREATE_PAGE_BLOB, DELETE_ROOT_CONTAINER,
                              CONTAINER_METADATA, ACL_ITEM];
    PrepareMenu(Menu, [BUSY_ITEM, ACTIVATE_ITEM, PAGE_MANAGEMENT, BLOCK_MANAGEMENT,
                       DELETE_CONTAINER, DELETE_BLOB, BLOB_METADATA, BLOCK_PROPERTIES,
                       PAGE_PROPERTIES, SNAPSHOT_ITEM, COPY_BLOB, DOWNLOAD_ITEM,
                       COMMIT_BLOCK_LIST, LEASE_ITEM, UPDATE_BLOCK_BLOB], disabled);
  end;
end;

procedure TAzureBlobManagement.MenuInitial(Menu: TPopupMenu);
begin
  PrepareMenuVisible(Menu, [ACTIVATE_ITEM], []);
end;

function TAzureBlobManagement.MetadataOf(Node: TTreeNode): TTreeNode;
begin
  Assert(Node <> nil);
  // one of the children is a metadata node
  Result := Node.getFirstChild;
  while Result <> nil do
  begin
    if IsMetadataNode(Result) then
      exit;
    Result := Result.getNextSibling;
  end
end;

function TAzureBlobManagement.NeedsLoading(Node: TTreeNode): boolean;
var
  loading: TTreeNode;
begin
  loading := Node.getFirstChild;
  Result := false;
  if loading <> nil then
    Result := (loading.getNextSibling = nil) and
                                (loading.Text = SNodeLoading);
end;

procedure TAzureBlobManagement.NodeExpandedAction(Sender: TObject;
  Node: TTreeNode);
begin
  // on (+) is clicked
  if IsBusy(Node) then
    exit;  // nothing if work it is in progress
  if NeedsLoading(Node) then
    if IsRootNode(Node) then
      PopulateContainers
    else if IsContainerNode(Node) then
      PopulateContainerWithBlobs(Node, Node.Text, true)
    else if IsACLNode(Node) then
      PopulateContainerWithACL(Node, ContainerOfACL(Node))
    else if IsBlobNode(Node) then
      PopulateBlob(Node)
    else if IsPageRegionsNode(Node) then
      PopulatePageList(Node)
    else if IsBlockListNode(Node) then
      PopulateBlockList(Node)
    else if IsMetadataNode(Node) then
      PopulateMetadata(Node)
    else if IsPropertiesNode(Node) then
      PopulateProperties(Node);
end;

function TAzureBlobManagement.PageNodeOf(BlobNode: TTreeNode): TTreeNode;
begin
  Result := BlobNode.getFirstChild;
  while (Result <> nil) and not IsPageRegionsNode(Result) do
    Result := Result.getNextSibling;
end;

function TAzureBlobManagement.ParseXML(const Xml: String): IXMLNode;
var
  xmlDoc: IXMLDocument;
begin
  xmlDoc := TXMLDocument.Create(nil);
  xmlDoc.LoadFromXml(xml);
  Result := xmlDoc.DocumentElement;
end;

procedure TAzureBlobManagement.PopulateContainerWithACL(ACLNode: TTreeNode;
  Container: TBContainer);
var
  LBlobService: TAzureBlobService;
begin
  MarkAsBusy(ACLNode);
  TAnonymousThread.Create(procedure
  var
    xmlStr: String;
    doc: IXMLNode;
    identifiers: TBSignedIdentifiers;
    access: String;
  begin
    try
      CoInitialize(nil);

      LBlobService := BlobService;
      try
        xmlStr := LBlobService.GetContainerACL(Container.Name);
        access := LBlobService.ResponseHeader['x-ms-blob-public-access'];
        LBlobService.Free;
      except
        MarkAsAvailable(ACLNode);
        ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
        LBlobService.Free;
        exit;
      end;

      doc := ParseXML(xmlStr);
      identifiers := TBSignedIdentifiers.FromXML(access, doc);

      TThread.Queue(nil, procedure
      var I: Integer;
        item: TBSignedIdentifier;
        siNode: TTreeNode;
      begin
        Items.BeginUpdate;
        ACLNode.DeleteChildren;
        try
          Items.AddChild(ACLNode, Format('%s: %s', [SBlobPublicAccess, access]));
          for I := 0 to identifiers.Identifiers.Count - 1 do
          begin
            item := identifiers.Identifiers.Items[I];
            siNode := Items.AddChildObject(ACLNode, SSignedIdentifier, Pointer(item));
            if Length(item.Start) > 0 then
              Items.AddChild(siNode, item.Start);
            if Length(item.Expiry) > 0 then
              Items.AddChild(siNode, item.Expiry);
            if Length(item.Permission) > 0 then
              Items.AddChild(siNode, item.Permission);
          end;
          if identifiers.Identifiers.Count = 0 then
            identifiers.Free;
          ACLNode.Expand(true);
        finally
          MarkAsAvailable(ACLNode);
          Items.EndUpdate
        end;
      end
      );
    except
      MarkAsAvailable(ACLNode);
    end;
  end);
end;

procedure TAzureBlobManagement.PopulateContainerWithBlobs(ContainerNode: TTreeNode;
  const ContainerName: String; const Mark: boolean);
begin
  if Mark then
    MarkAsBusy(ContainerNode);
  TAnonymousThread.Create(procedure
  var
    xmlStr: String;
    doc: IXMLNode;
    blobs: TBBlobs;
    LBlobService: TAzureBlobService;
  begin
    try
      CoInitialize(nil);

      LBlobService := BlobService;
      try
        xmlStr := LBlobService.ListBlobs(ContainerName, ['include', 'include'], ['metadata', 'snapshots']);
        LBlobService.Free;
      except
        if Mark then
          MarkAsAvailable(ContainerNode);
        ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
        TThread.Synchronize(nil, procedure begin ContainerNode.Collapse(True); end );
        LBlobService.Free;
        exit;
      end;

      doc := ParseXML(xmlStr);
      blobs := TBBlobs.FromXML(doc);

      TThread.Synchronize(nil, procedure
      var I: Integer;
        item: TBBlob;
        name: String;
      begin
        Items.BeginUpdate;
        if Mark then
          ContainerNode.DeleteChildren;
        PopulateWithLoadingNode(Items.AddChildFirst(ContainerNode, SMetadata));
        PopulateWithLoadingNode(Items.AddChildFirst(ContainerNode, SProperties));
        PopulateWithLoadingNode(Items.AddChildFirst(ContainerNode, SACL));

        try
          for I := 0 to blobs.Items.Count - 1 do
          begin
            item := blobs.Items.Items[I];
            if item.IsSnapshot then
              name := Format('%s: snapshot=%s', [item.Name, item.Snapshot])
            else
              name := item.Name;
            PopulateWithLoadingNode(Items.AddChildObject(ContainerNode, name, Pointer(item)))
          end;
          if blobs.Items.Count = 0 then
            blobs.Free;
          ContainerNode.Expand(false);
        finally
          if Mark then
            MarkAsAvailable(ContainerNode);
          Items.EndUpdate
        end;
      end
      );
    except
      if Mark then
        MarkAsAvailable(ContainerNode);
      // call the exception handler
      raise;
    end;
  end);
end;

procedure TAzureBlobManagement.PopulateMetadata(MetaNode: TTreeNode);
var
  data: TObject;
  entity: TTreeNode;
  parentData: TObject;
  meta: TDictionary<String, String>;
begin
  if MetaNode = nil then
    exit;  // node not expanded
  entity := MetaNode.Parent;
  MarkAsBusy(MetaNode);

  TAnonymousThread.Create(procedure
  begin
    try
      CoInitialize(nil);
      try
        if IsRootNode(entity) then
          data := FRootContainer
        else
          data := AsObject(entity.Data);
        Assert(data <> nil, 'Container/Blob not found');

        // figure out what type of node and populate accordingly
        if data is TBContainer then
        begin
          PopulateLatestMetadata((data as TBContainer), nil);
          meta := (data as TBContainer).Metadata;
        end
        else
        begin
          if IsRootNode(entity.Parent) then
            parentData := FRootContainer
          else
            parentData := AsObject(entity.Parent.Data);
          PopulateLatestMetadata((parentData as TBContainer), (data as TBBlob));
          meta := (data as TBBlob).Metadata;
        end;

        TThread.Queue(nil, procedure var
          keys: TDictionary<String, String>.TKeyCollection;
          key: String;
        begin
          try
            MetaNode.DeleteChildren;
            keys := meta.Keys;
            for key in keys.ToArray do
              Items.AddChild(MetaNode, Format('%s: %s', [key, meta.Items[key]]))
          finally
            MetaNode.Expand(true);
            MarkAsAvailable(MetaNode);
          end
        end);
      except
        MarkAsAvailable(MetaNode);

        raise;
      end;
    finally
      CoUninitialize();
    end;
  end);
end;

procedure TAzureBlobManagement.PopulatePageList(PageNode: TTreeNode);
var
  container: String;
  blob: String;
  snapshot: String;

  node: TTreeNode;
begin
  node := PageNode.Parent;
  Assert( node <> nil );
  Assert(AsObject(node.Data) <> nil);
  blob := TBBlob(AsObject(node.Data)).Name;
  snapshot := TBBlob(AsObject(node.Data)).Snapshot;

  node := node.Parent;
  if IsRootNode(node) then
  begin
    Assert(FRootContainer <> nil);
    container := FRootContainer.Name
  end else begin
    Assert(AsObject(node.Data) <> nil);
    container := TBContainer(AsObject(node.Data)).Name;
  end;

  MarkAsBusy(PageNode);
  TAnonymousThread.Create(procedure
  var
    xmlStr: string;
    doc: IXMLNode;
    pageList: TBPageList;
    size: string;
    LBlobService: TAzureBlobService;
  begin
    try
      CoInitialize(nil);

      LBlobService := BlobService;
      try
        xmlStr := LBlobService.GetPageRegions(container, blob, snapshot);
        size := LBlobService.ResponseHeader['x-ms-blob-content-length'];
        LBlobService.Free;
      except
        MarkAsAvailable(PageNode);
        ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
        LBlobService.Free;
        exit;
      end;

      doc := ParseXML(xmlStr);
      pageList := TBPageList.FromXML(size, doc);

      TThread.Queue(nil, procedure
      var I: Integer;
        item: TBPageRange;
      begin
        Items.BeginUpdate;
        PageNode.DeleteChildren;
        try
          Items.AddChild(PageNode, Format('%s: %s', [SContentLength, size]));
          for I := 0 to pageList.Pages.Count - 1 do
          begin
            item := pageList.Pages.Items[I];
            Items.AddChildObject(PageNode, Format('bytes=%s,%s', [item.StartByte, item.EndByte]), Pointer(item));
          end;
          if pageList.Pages.Count = 0 then
            pageList.Free;
          PageNode.Expand(true);
        finally
          MarkAsAvailable(PageNode);
          Items.EndUpdate
        end;
      end
      );
    except
      MarkAsAvailable(PageNode);
      // call the exception handler
      raise;
    end;
  end);
end;

procedure TAzureBlobManagement.PopulateLatestMetadata(Container: TBContainer; BlobObj: TBBlob);
var
  props: TStrings;
  xmlDoc: IXMLDocument;
  Success: Boolean;
  LBlobService: TAzureBlobService;
begin
  xmlDoc := nil;

  if Container <> nil then
  begin
    LBlobService := BlobService;
    try
      if BlobObj <> nil then
        Success := LBlobService.GetBlobMetadata(Container.Name, BlobObj.Name, BlobObj.Snapshot)
      else
        Success := LBlobService.GetContainerMetadata(Container.Name);

      if Success then
      begin
        props := TStringList.Create;
        LBlobService.PopulateContainer('x-ms-meta-', props);

        if BlobObj = nil then
        begin
          Container.PopulateMeta(props);
        end
        else
        begin
          BlobObj.PopulateMeta(props);
        end;
        FreeAndNil(props);
      end;
      LBlobService.Free;
    except
      LBlobService.Free;
    end;
  end;
end;

procedure TAzureBlobManagement.PopulateLatestProperties(Container: TBContainer; BlobObj: TBBlob);
var
  props: TStrings;
  xmlDoc: IXMLDocument;
  Success: Boolean;
  LBlobService: TAzureBlobService;
begin
  xmlDoc := nil;

  if Container <> nil then
  begin
    LBlobService := BlobService;
    try
      if BlobObj <> nil then
        Success := LBlobService.GetBlobProperties(Container.Name, BlobObj.Name, BlobObj.Snapshot)
      else
        Success := LBlobService.GetContainerProperties(Container.Name);

      if Success then
      begin
        props := TStringList.Create;
        LBlobService.PopulateContainerProperties(props);

        if BlobObj = nil then
        begin
          Container.PopulateProperties(props);
        end
        else
        begin
          BlobObj.PopulateProperties(props);
        end;
        FreeAndNil(props);
      end;
      LBlobService.Free;
    except
      LBlobService.Free;
    end;
  end;
end;

procedure TAzureBlobManagement.PopulateProperties(PropNode: TTreeNode);
var
  data: TObject;
  entity: TTreeNode;
  parentData: TObject;
  props: TDictionary<String, String>;
begin
  if PropNode = nil then
    exit;
  entity := PropNode.Parent;
  MarkAsBusy(PropNode);

  TAnonymousThread.Create(procedure
  begin
    try
      CoInitialize(nil);
      try
        if IsRootNode(entity) then
          data := FRootContainer
        else
          data := AsObject(entity.Data);
        Assert(data <> nil, 'Container/Blob not found');

        // figure out what type of node and populate accordingly
        if data is TBContainer then
        begin
          PopulateLatestProperties((data as TBContainer), nil);
          props := (data as TBContainer).Properties;
        end
        else
        begin
          if IsRootNode(entity.Parent) then
            parentData := FRootContainer
          else
            parentData := AsObject(entity.Parent.Data);
          PopulateLatestProperties((parentData as TBContainer), (data as TBBlob));
          props := (data as TBBlob).Properties;
        end;

        TThread.Synchronize(nil, procedure var
          keys: TDictionary<String, String>.TKeyCollection;
          key: String;
        begin
          try
            PropNode.DeleteChildren;
            keys := props.Keys;
            for key in keys.ToArray do
              Items.AddChild(PropNode, Format('%s: %s', [key, props.Items[key]]))
          finally
            PropNode.Expand(true);
            MarkAsAvailable(PropNode);
          end
        end);
      except
        MarkAsAvailable(PropNode);

        raise;
      end;
    finally
      CoUninitialize();
    end;
  end);
end;

function TAzureBlobManagement.PopulateWithLoadingNode(Node: TTreeNode): TTreeNode;
begin
  // should only be called from main thread...
  Items.BeginUpdate;
  Node.DeleteChildren;
  Items.AddChild(Node, SNodeLoading);
  Items.EndUpdate;
  Result := Node;
end;

procedure TAzureBlobManagement.PrepareMenu(Menu: TPopupMenu; Invisible,
  Disabled: TIntSet);
var
  item: TMenuItem;
  id: Integer;
begin
  for item in Menu.Items do
  begin
    id := StrToInt(Copy(item.Name, 2));
    item.Visible := not (id in Invisible);
    item.Enabled := not (id in Disabled);
    PrepareMenu(item, Invisible, Disabled);
  end;
  CleanExtraSeparators(Menu);
end;

procedure TAzureBlobManagement.PrepareMenu(MenuItem: TMenuItem; Invisible,
  Disabled: TIntSet);
var
  item: TMenuItem;
  id, i: Integer;
begin
  for i := 0 to MenuItem.Count - 1 do
  begin
    item := MenuItem.Items[i];
    id := StrToInt(Copy(item.Name, 2));
    item.Visible := not (id in Invisible);
    item.Enabled := not (id in Disabled);
    PrepareMenu(item, Invisible, Disabled);
  end;
end;

procedure TAzureBlobManagement.PrepareMenuVisible(Menu: TMenuItem; Visible,
  Disabled: TIntSet);
var
  item: TMenuItem;
  id, i: Integer;
begin
  for i := 0 to Menu.Count - 1 do
  begin
    item := Menu.Items[i];
    id := StrToInt(Copy(item.Name, 2));
    item.Visible := id in Visible;
    item.Enabled := not (id in Disabled);
  end;
end;

procedure TAzureBlobManagement.PrepareMenuVisible(Menu: TPopupMenu; Visible,
  Disabled: TIntSet);
var
  item: TMenuItem;
  id: Integer;
begin
  for item in Menu.Items do
  begin
    id := StrToInt(Copy(item.Name, 2));
    item.Visible := id in Visible;
    item.Enabled := not (id in Disabled);
    PrepareMenuVisible(item, Visible, Disabled);
  end;
  CleanExtraSeparators(Menu);
end;

function TAzureBlobManagement.PropertiesOf(Node: TTreeNode): TTreeNode;
begin
  Assert(Node <> nil);
  // one of the children is a metadata node
  Result := Node.getFirstChild;
  while Result <> nil do
  begin
    if IsPropertiesNode(Result) then
      exit;
    Result := Result.getNextSibling;
  end
end;

procedure TAzureBlobManagement.PopulateRootNode(SelectRoot: boolean);
begin
  TThread.Queue(nil, procedure begin
    Items.BeginUpdate;
    Items.Clear;
    FRootNode := Items.AddChild(nil, SAzureBlobs);
    PopulateWithLoadingNode(FRootNode);
    Items.EndUpdate;
    if SelectRoot then
    begin
      Select(FRootNode);
      FRootNode.Expand(false);
    end;
  end);
end;

procedure TAzureBlobManagement.PopulateBlob(BlobNode: TTreeNode);
begin
  Assert(IsBlobNode(BlobNode));

  MarkAsBusy(BlobNode);
  TAnonymousThread.Create(procedure
  var
    blobData: TBBlob;
  begin
    try
      CoInitialize(nil);

      blobData := TBBlob(AsObject(BlobNode.Data));

      TThread.Queue(nil, procedure
      begin
        Items.BeginUpdate;
        BlobNode.DeleteChildren;
        try
          PopulateWithLoadingNode(Items.AddChild(BlobNode, SProperties));
          PopulateWithLoadingNode(Items.AddChild(BlobNode, SMetadata));
          if blobData.IsPageBlob then
            PopulateWithLoadingNode(Items.AddChild(BlobNode, SPageRegions))
          else if blobData.IsBlockBlob then
            PopulateWithLoadingNode(Items.AddChild(BlobNode, SBlockList));

          BlobNode.Expand(false);
        finally
          MarkAsAvailable(BlobNode);
          Items.EndUpdate
        end;
      end);
    except
      MarkAsAvailable(BlobNode);
      // call the exception handler
      raise;
    end;
  end);
end;

procedure TAzureBlobManagement.PopulateBlockList(BlockNode: TTreeNode);
var
  container: String;
  blob: String;
  snapshot: String;

  node: TTreeNode;
begin
  MarkAsBusy(BlockNode);

  node := BlockNode.Parent;
  blob := TBBlob(AsObject(node.Data)).Name;
  snapshot := TBBlob(AsObject(node.Data)).Snapshot;

  node := node.Parent;
  if IsRootNode(node) then
    container := '$root'
  else
    container := TBContainer(AsObject(node.Data)).Name;

  TAnonymousThread.Create(procedure
  var
    xmlStr: string;
    doc: IXMLNode;
    blockList: TBBlockList;
    size: string;
    LBlobService: TAzureBlobService;
  begin
    try
      CoInitialize(nil);

      LBlobService := BlobService;
      try
        xmlStr := LBlobService.GetBlockList(container, blob, 'all', snapshot);
        size := LBlobService.ResponseHeader['x-ms-blob-content-length'];
        LBlobService.Free;
      except
        MarkAsAvailable(BlockNode);
        ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
        LBlobService.Free;
        exit;
      end;

      doc := ParseXML(xmlStr);
      blockList := TBBlockList.FromXML(size, doc);

      TThread.Queue(nil, procedure
      var I: Integer;
        item: TBBlock;
        siNode: TTreeNode;
      begin
        Items.BeginUpdate;
        BlockNode.DeleteChildren;
        try
          Items.AddChild(BlockNode, Format('%s: %s', [SContentLength, size]));
          siNode := Items.AddChild(BlockNode, SCommittedBlocks);
          for I := 0 to blockList.CommitedBlocks.Count - 1 do
          begin
            item := blockList.CommitedBlocks.Items[I];
            Items.AddChildObject(siNode, Format('%s: %s bytes', [TAzureService.Decode(item.Name), item.Size]), Pointer(item));
          end;
          siNode := Items.AddChild(BlockNode, SUncommittedBlocks);
          for I := 0 to blockList.UncommitedBlocks.Count - 1 do
          begin
            item := blockList.UncommitedBlocks.Items[I];
            Items.AddChildObject(siNode, Format('%s: %s bytes', [TAzureService.Decode(item.Name), item.Size]), Pointer(item));
          end;
          if (blockList.CommitedBlocks.Count = 0) and (blockList.UncommitedBlocks.Count = 0) then
            blockList.Free;
          BlockNode.Expand(true);
        finally
          MarkAsAvailable(BlockNode);
          Items.EndUpdate
        end;
      end
      );
    except
      MarkAsAvailable(BlockNode);
      // call the exception handler
      raise;
    end;
  end);
end;

procedure TAzureBlobManagement.PopulateContainers;
var
  Service: TAzureBlobService;
begin
  MarkAsBusy(FRootNode);
  TAnonymousThread.Create(procedure
  var
    xmlStr: String;
    doc: IXMLNode;
    containers: TBContainers;
  begin
    try
      CoInitialize(nil);

      try
        Service := BlobService;
      except
        on E : Exception do
        begin
          ShowErrorMessage(E.Message);
          raise;
        end;
      end;

      try
        xmlStr := Service.ListContainers(['include'], ['metadata']);
        Free;
      except
        ShowErrorMessage(SErrorGeneric + Service.ResponseText);
        Service.Free;
        raise;
      end;
      doc := ParseXML(xmlStr);
      containers := TBContainers.FromXML(doc);

      TThread.Synchronize(nil, procedure
      var I: Integer;
        hasRoot: boolean;
        item: TBContainer;
      begin
        Items.BeginUpdate;
        try
          FRootNode.DeleteChildren;
          hasRoot := false;
          for I := 0 to containers.Items.Count - 1 do
          begin
            item := containers.Items.Items[I];
            if not item.IsRoot then
              PopulateWithLoadingNode(Items.AddChildObject(FRootNode, item.Name, Pointer(item)))
            else
            begin
              hasRoot := true;
              SetRootContainer(item);
            end
          end;
          if hasRoot then
            PopulateContainerWithBlobs(FRootNode, '$root')
          else begin
            if containers.Items.Count = 0 then
              containers.Free;
            FRootNode.Expand(false)
          end
        finally
          MarkAsAvailable(FRootNode);
          Items.EndUpdate;
        end
      end
      );
    except
      MarkAsAvailable(FRootNode);
      FullCollapse;
      // call the exception handler
      raise;
    end;
  end);
end;

procedure TAzureBlobManagement.RefreshAction(Sender: TObject);
var
  node: TTreeNode;
begin
  node := FMenuNode;
  if node = nil then
    node := FRootNode;
  while node <> nil do
    if IsRootNode(node) then
    begin
      if NeedsLoading(node) then
        PopulateContainers
      else begin
        Clear;
        PopulateRootNode(true);
      end;
      exit;
    end
    else if IsContainerNode(node) or IsBlobNode(node) or IsACLNode(Node) or IsPageRegionsNode(node) or
      IsBlockListNode(Node) then
    begin
      if NeedsLoading(node) then
        Expand(node)
      else
        RefreshLoadingNode(node);
      exit;
    end
    else node := node.Parent
end;

procedure TAzureBlobManagement.SetActive(Status: boolean);
begin
  // do nothing if no change required
  if Status = GetActive then
    exit;
  // if no connection info, then no change
  if Status and (ConnectionInfo = nil) then
    exit;
  // if busy, ignore
  if (FRootNode <> nil) and IsBusy(FRootNode) then
    exit;

  if Status then
  begin
    if GetActive then
      Clear;
    PopulateRootNode
  end else
    Clear;
end;

procedure TAzureBlobManagement.SetRootContainer(root: TBContainer);
begin
  FreeAndNil(FRootContainer);
  FRootContainer := root;
end;

procedure TAzureBlobManagement.UpdateBlockBlobAction(Sender: TObject);
var
  blobNode: TTreeNode;
  blob: TBBlob;
  containerNode: TTreeNode;
  container: TBContainer;
  metaHeaders: TStringList;
  contentType, contentMD5, contentLanguage, contentEncoding: string;
  content: TArray<Byte>;
  LBlobService: TAzureBlobService;
begin
  blobNode := SelectedBlob(FMenuNode);
  Assert(blobNode <> nil);
  blob := BlobOf(blobNode);
  Assert(blob <> nil);
  containerNode := SelectedContainer(blobNode);
  Assert(containerNode <> nil);
  container := ContainerOf(containerNode);
  Assert(container<>nil);

  FBlockBlob.Caption := Format(SUpdateBlockBlobCaption, [container.Name, blob.Name]);
  FBlockBlob.PopulateWithMetadata(blob.Metadata);
  FBlockBlob.ContentType := blob.Properties['Content-Type'];
  FBlockBlob.ContentLanguage := blob.Properties['Content-Language'];
  FBlockBlob.ContentMD5 := blob.Properties['Content-MD5'];
  FBlockBlob.ContentEncoding := blob.Properties['Content-Encoding'];
  FBlockBlob.BlobName := blob.Name;
  FBlockBlob.SetOKCaption(SOKUpdateCaption);

  if FBlockBlob.ShowModal = mrOK then
  begin
    metaHeaders := AsMetadataHeaders(FBlockBlob.RawMetadata);
    contentType := FBlockBlob.ContentType;
    contentMD5 := FBlockBlob.ContentMD5;
    contentEncoding := FBlockBlob.ContentEncoding;
    contentLanguage := FBlockBlob.ContentLanguage;
    content := ContentOf(FBlockBlob.GetContentLocation);

    MarkAsBusy(blobNode);
    TAnonymousThread.Create(procedure
      var
        xmlStr: String;
        xmlNode: IXMLNode;
        blobs: TBBlobs;
      begin
        LBlobService := BlobService;
        try
          if Length(content) > 16*1024 then
            ShowInformationMessage(SLongTimeOperation);

          if not LBlobService.PutBlockBlob(container.Name, blob.Name, content, blob.LeaseID, metaHeaders,
                       contentType, contentEncoding,
                       contentLanguage, contentMD5) then
          begin
            metaHeaders.Free;
            MarkAsAvailable(blobNode);
            ShowErrorMessage(SErrorGeneric + LBlobService.ResponseText);
            LBlobService.Free;
            exit;
          end;
          xmlStr := LBlobService.ListBlobs(container.Name, ['prefix', 'maxresults'],
                                              [blob.Name, '1']);

          CoInitialize(nil);
          xmlNode := ParseXML(xmlStr);
          blobs := TBBlobs.FromXML(xmlNode);

          metaHeaders.Free;
          LBlobService.Free;
        except
          LBlobService.Free;
          metaHeaders.Free;
          MarkAsAvailable(blobNode);
          exit;
        end;
        TThread.Queue(nil, procedure
        var I: Integer;
          item: TBBlob;
        begin
          Items.BeginUpdate;

          try
            if blobs.Items.Count = 0 then
              blobs.Free
            else
              blobNode.Delete;
              for I := 0 to blobs.Items.Count - 1 do
              begin
                item := blobs.Items.Items[I];
                PopulateWithLoadingNode(Items.AddChildObject(ContainerNode, item.Name, Pointer(item)))
              end;
          finally
            Items.EndUpdate;
            MarkAsAvailable(blobNode);
          end
        end);
      end);
  end
end;

procedure TAzureBlobManagement.UpdatePopupMenu(Sender: TObject);
begin

  if not Active then
  begin
    MenuInitial(PopupMenu);
    exit;
  end;

  FMenuNode := Selected;

  if (FMenuNode <> nil) and (IsBusy(FMenuNode) or IsAnyParentBusy(FMenuNode)) then
  begin
    MenuBusy(PopupMenu);
    exit;
  end;

  // get the context
  if FMenuNode = nil then
  begin
    MenuForRoot(PopupMenu);
    exit;
  end;

  repeat
    if IsRootNode(FMenuNode) then
    begin
      MenuForRoot(PopupMenu);
      exit;
    end;

    if IsContainerNode(FMenuNode) then
    begin
      MenuForContainer(PopupMenu);
      exit;
    end;

    if IsBlobNode(FMenuNode) then
    begin
      if TBBlob(AsObject(FMenuNode.Data)).IsPageBlob then
      begin
        MenuForPageBlob(PopupMenu);
        exit;
      end;
      if TBBlob(AsObject(FMenuNode.Data)).IsBlockBlob then
      begin
        MenuForBlockBlob(PopupMenu);
        exit;
      end;
    end;

    FMenuNode := FMenuNode.Parent;
  until FMenuNode = nil;

end;

{ TAnonymousThread }

constructor TAnonymousThread.Create(Worker: TAnonymousWorker);
begin
  FWorker := Worker;
  FreeOnTerminate := true;
  inherited Create;
end;

destructor TAnonymousThread.Destroy;
begin
  CoUnInitialize;
  inherited;
end;

procedure TAnonymousThread.Execute;
begin
  FWorker;
end;

{ TBContainer }

constructor TBContainer.Create(const Parent: TBContainers);
begin
  inherited Create(Parent);

  FProperties := TDictionary<String, String>.Create;
  FMetadata := TDictionary<String, String>.Create;
end;

destructor TBContainer.Destroy;
begin
  FProperties.Free;
  FMetadata.Free;

  inherited;
end;

class function TBContainer.FromXML(const Parent: TBContainers; Node: IXMLNode): TBContainer;
var
  kid, itr: IXMLNode;
begin
  Assert( Node <> nil);
  Assert( Node.NodeName = 'Container');

  Result := TBContainer.Create(Parent);
  kid := Node.ChildNodes.Nodes['Name'];
  if kid <> nil then
    Result.Name := kid.Text;
  kid := Node.ChildNodes.Nodes['URL'];
  if kid <> nil then
    Result.URL := kid.Text;
  kid := Node.ChildNodes.Nodes['Properties'];
  if kid <> nil then
  begin
    itr := kid.ChildNodes.First;
    while itr <> nil do
    begin
      Result.FProperties.Add(itr.NodeName, itr.Text);
      itr := itr.NextSibling;
    end;
  end;
  kid := Node.ChildNodes.Nodes['Metadata'];
  if kid <> nil then
  begin
    itr := kid.ChildNodes.First;
    while itr <> nil do
    begin
      Result.FMetadata.Add(itr.NodeName, itr.Text);
      itr := itr.NextSibling;
    end;
  end;
end;

function TBContainer.IsRoot: boolean;
begin
  Result := '$root' = FName;
end;

procedure TBContainer.PopulateMeta(Meta: TStrings);
var
  I, Count: Integer;
  key, value: String;
begin
  FMetadata.Clear;
  Count := Meta.Count;
  for I := 0 to Count - 1 do
  begin
    key := Meta.Names[I];
    value := Meta.ValueFromIndex[I];
    if Pos('x-ms-meta-', key) = 1 then
      FMetadata.Add(Copy(key, Length('x-ms-meta-') + 1), value)
  end;
end;

procedure TBContainer.PopulateProperties(Props: TStrings);
var
  I, Count: Integer;
  key, value: String;
begin
  FProperties.Clear;
  Count := Props.Count;
  for I := 0 to Count - 1 do
  begin
    key := Props.Names[I];
    value := Props.ValueFromIndex[I];
    FProperties.Add(key, value)
  end;
end;

{ TBContainers }

constructor TBContainers.Create;
begin
  inherited;

  FContainer := TObjectList<TBContainer>.Create;
  FContainer.OwnsObjects := False;
end;

destructor TBContainers.Destroy;
begin
  FContainer.Free;
  inherited;
end;

class function TBContainers.FromXML(Node: IXMLNode): TBContainers;
var
  kid, itr: IXMLNode;
  max: String;
begin
  Assert(Node <> nil);
  Assert(Node.NodeName = 'EnumerationResults');

  Result := TBContainers.Create;
  kid := Node.ChildNodes.Nodes['Prefix'];
  if kid <> nil then
    Result.Prefix := kid.Text;
  kid := Node.ChildNodes.Nodes['Marker'];
  if kid <> nil then
    Result.Marker := kid.Text;
  kid := Node.ChildNodes.Nodes['MaxResults'];
  if kid <> nil then
  begin
    max := kid.Text;
    if Length(max) > 0 then
      Result.MaxResult := StrToInt(kid.Text)
    else
      Result.MaxResult := 0;
  end;
  kid := Node.ChildNodes.Nodes['Containers'];
  if kid <> nil then
  begin
    itr := kid.ChildNodes.First;
    while itr <> nil do
    begin
      Result.FContainer.Add(TBContainer.FromXML(Result, itr));
      itr := itr.NextSibling;
    end;
  end;
  kid := Node.ChildNodes.Nodes['NextMarker'];
  if kid <> nil then
    Result.NextMarker := kid.Text;
end;

{ TBEnumeration }

constructor TBEnumeration.Create;
begin
  FRefCount := 0;
end;

{ TBEnumerationItem<T> }

constructor TBEnumerationItem<T>.Create(const Parent: T);
begin
  FEnumeration := Parent;
  Inc(FEnumeration.FRefCount);
end;

destructor TBEnumerationItem<T>.Destroy;
begin
  Inc(FEnumeration.FRefCount, -1);
  if FEnumeration.FRefCount = 0 then
    FEnumeration.Free;

  inherited;
end;

{ TBBlob }

constructor TBBlob.Create(const Parent: TBBlobs);
begin
  inherited Create(Parent);

  FProperties := TDictionary<String, String>.Create;
  FMetadata := TDictionary<String, String>.Create;
end;

destructor TBBlob.Destroy;
begin
  FProperties.Free;
  FMetadata.Free;
  inherited;
end;

class function TBBlob.FromXML(const Parent: TBBlobs;
  const Node: IXMLNode): TBBlob;
var
  kid, itr: IXMLNode;
begin
  Assert( Node <> nil);
  Assert( Node.NodeName = 'Blob');

  Result := TBBlob.Create(Parent);
  kid := Node.ChildNodes.Nodes['Name'];
  if kid <> nil then
    Result.Name := kid.Text;
  kid := Node.ChildNodes.Nodes['Url'];
  if kid <> nil then
    Result.URL := kid.Text;
  kid := Node.ChildNodes.Nodes['Snapshot'];
  if kid <> nil then
    Result.Snapshot := kid.Text;
  kid := Node.ChildNodes.Nodes['Properties'];
  if kid <> nil then
  begin
    itr := kid.ChildNodes.First;
    while itr <> nil do
    begin
      Result.FProperties.Add(itr.NodeName, itr.Text);
      itr := itr.NextSibling;
    end;
  end;
  kid := Node.ChildNodes.Nodes['Metadata'];
  if kid <> nil then
  begin
    itr := kid.ChildNodes.First;
    while itr <> nil do
    begin
      Result.FMetadata.Add(itr.NodeName, itr.Text);
      itr := itr.NextSibling;
    end;
  end;
end;

function TBBlob.GetLeaseExpires: TDateTime;
begin
  Result := TLeaseManager.Instance.GetLeaseExpireTime(URL);
end;

function TBBlob.GetLeaseID: String;
begin
  Result := TLeaseManager.Instance.GetLeaseID(URL);
end;

procedure TBBlob.SetLeaseInfo(LeaseID: String; LeaseExpires: TDateTime);
begin
  if LeaseID = EmptyStr then
    TLeaseManager.Instance.ClearLeaseInfo(URL)
  else
    TLeaseManager.Instance.SetLeaseInfo(URL, LeaseID, LeaseExpires);
end;

function TBBlob.IsBlockBlob: boolean;
begin
  Result := false;
  if FProperties.ContainsKey('BlobType') then
    Result := FProperties.Items['BlobType'] = 'BlockBlob';
end;

function TBBlob.IsLeaseExpired: boolean;
begin
  Result := Now > GetLeaseExpires;
end;

function TBBlob.IsLocked: boolean;
begin
  Result := false;
  if FProperties.ContainsKey('LeaseStatus') then
    Result := FProperties.Items['LeaseStatus'] = 'locked';
end;

function TBBlob.IsPageBlob: boolean;
begin
  Result := false;
  if FProperties.ContainsKey('BlobType') then
    Result := FProperties.Items['BlobType'] = 'PageBlob';
end;

function TBBlob.IsSnapshot: boolean;
begin
  Result := Length(FSnapshot) > 0;
end;

procedure TBBlob.PopulateMeta(Meta: TStrings);
var
  I, Count: Integer;
  key, value: String;
begin
  FMetadata.Clear;
  Count := Meta.Count;
  for I := 0 to Count - 1 do
  begin
    key := Meta.Names[I];
    value := Meta.ValueFromIndex[I];
    if Pos('x-ms-meta-', key) = 1 then
      FMetadata.Add(Copy(key, Length('x-ms-meta-') + 1), value)
    else
      FMetadata.Add(key, value);
  end;
end;

procedure TBBlob.PopulateProperties(Props: TStrings);
var
  I, Count: Integer;
  key, value: String;
begin
  //retain any properties held currently but not in the Props
  if FProperties.Count > 0 then
  begin
    for key in FProperties.Keys do
    begin
      if (key <> 'LeaseStatus') and (Props.IndexOf(key) < 0) then
        Props.Values[key] := FProperties.Items[Key];
    end;
  end;

  FProperties.Clear;
  Count := Props.Count;
  for I := 0 to Count - 1 do
  begin
    key := Props.Names[I];
    value := Props.ValueFromIndex[I];

    //addresses inconsistency in the Microsoft Azure REST api, where
    //LeaseStatus key is different when populating a blob than it is when populating just the properties
    if key = 'x-ms-lease-status' then
      key := 'LeaseStatus';
    FProperties.Add(key, value);
  end;
end;

procedure TBBlob.PopulateProperty(const Name, Value: String);
begin
  if Value = EmptyStr then
  begin
    if FProperties.ContainsKey(Name) then
      FProperties.Remove(Name)
  end else begin
    FProperties.AddOrSetValue(Name, Value);
  end;
end;

{ TBBlobs }

constructor TBBlobs.Create;
begin
  FBlobs := TObjectList<TBBlob>.Create(false);
  inherited;
end;

destructor TBBlobs.Destroy;
begin
  FBlobs.Free;
  inherited;
end;

class function TBBlobs.FromXML(const Node: IXMLNode): TBBlobs;
var
  kid, itr: IXMLNode;
  max: String;
begin
  Assert(Node <> nil);
  Assert(Node.NodeName = 'EnumerationResults');

  Result := TBBlobs.Create;
  Result.ContainerName := Node.Attributes['ContainerName'];
  kid := Node.ChildNodes.Nodes['Prefix'];
  if kid <> nil then
    Result.Prefix := kid.Text;
  kid := Node.ChildNodes.Nodes['Marker'];
  if kid <> nil then
    Result.Marker := kid.Text;
  kid := Node.ChildNodes.Nodes['MaxResults'];
  if kid <> nil then
  begin
    max := kid.Text;
    if Length(max) > 0 then
      Result.MaxResults := StrToInt(kid.Text)
    else
      Result.MaxResults := 0;
  end;
  kid := Node.ChildNodes.Nodes['Delimiter'];
  if kid <> nil then
    Result.Delimiter := kid.Text;
  kid := Node.ChildNodes.Nodes['Blobs'];
  if kid <> nil then
  begin
    itr := kid.ChildNodes.First;
    while itr <> nil do
    begin
      if itr.NodeName = 'Blob' then
        Result.FBlobs.Add(TBBlob.FromXML(Result, itr));
      itr := itr.NextSibling;
    end;
  end;
  kid := Node.ChildNodes.Nodes['NextMarker'];
  if kid <> nil then
    Result.NextMarker := kid.Text;
end;

{ TBTreeNode }

destructor TBTreeNode.Destroy;
begin
  if Data <> nil then
  begin
    TObject(Pointer((IntPtr(Data) shr 1) shl 1)).Free;
    Data := nil;
  end;
  inherited;
end;

{ TBSignedIdentifier }

constructor TBSignedIdentifier.Create(const Parent: TBSignedIdentifiers);
begin
  inherited Create(Parent);


end;

destructor TBSignedIdentifier.Destroy;
begin

  inherited;
end;

class function TBSignedIdentifier.FromXML(const Parent: TBSignedIdentifiers;
  const Node: IXMLNode): TBSignedIdentifier;
var
  kid: IXMLNode;
begin
  Assert(Node <> nil);
  Assert(Node.NodeName = 'SignedIdentifier');

  Result := TBSignedIdentifier.Create(Parent);
  kid := Node.ChildNodes.Nodes['Id'];
  if kid <> nil then
    Result.Id := kid.Text;
  kid := Node.ChildNodes.Nodes['AccessPolicy'];
  if kid <> nil then
  begin
    kid := kid.ChildNodes.First;
    while kid <> nil do
    begin
      if 'Start' = kid.NodeName then
        Result.Start := kid.Text
      else if 'Expiry' = kid.NodeName then
        Result.Expiry := kid.Text
      else if 'Permission' = kid.NodeName then
        Result.Permission := kid.Text;
      kid := kid.NextSibling;
    end;
  end;
end;

function TBSignedIdentifier.GetPermission: String;
begin
  Result := FACL.Permission;
end;

procedure TBSignedIdentifier.SetPermission(const rwdl: String);
begin
  FACL.Permission := rwdl;
end;

{ TBSignedIdentifiers }

constructor TBSignedIdentifiers.Create(const Access: String);
begin
  inherited Create;
  FPublicAccess := Access;
  FIdentifiers := TObjectList<TBSignedIdentifier>.Create(false);
end;

destructor TBSignedIdentifiers.Destroy;
begin
  FIdentifiers.Free;

  inherited;
end;

class function TBSignedIdentifiers.FromXML(const Access: String;
  const Node: IXMLNode): TBSignedIdentifiers;
var
  kid: IXMLNode;
begin
  Assert(Node <> nil);
  Assert(Node.NodeName = 'SignedIdentifiers');

  Result := TBSignedIdentifiers.Create(Access);
  kid := Node.ChildNodes.First;
  while kid <> nil do
  begin
    Result.FIdentifiers.Add(TBSignedIdentifier.FromXML(Result, kid));
    kid := kid.NextSibling;
  end;
end;

{ TBPageRange }

constructor TBPageRange.Create(const Parent: TBPageList);
begin
  inherited Create(Parent);
end;

destructor TBPageRange.Destroy;
begin

  inherited;
end;

class function TBPageRange.FromXML(const Parent: TBPageList;
  const Node: IXMLNode): TBPageRange;
var
  kid: IXMLNode;
begin
  Assert(Node <> nil);
  Assert(Node.NodeName = 'PageRange');

  Result := TBPageRange.Create(Parent);
  kid := Node.ChildNodes.Nodes['Start'];
  if kid <> nil then
    Result.StartByte := kid.Text;
  kid := Node.ChildNodes.Nodes['End'];
  if kid <> nil then
    Result.EndByte := kid.Text;
end;

{ TBPageList }

constructor TBPageList.Create(const Size: String);
begin
  inherited Create;

  FContentLength := Size;
  FPages := TObjectList<TBPageRange>.Create(false);
end;

destructor TBPageList.Destroy;
begin
  FPages.Free;

  inherited;
end;

class function TBPageList.FromXML(const Size: String;
  const Node: IXMLNode): TBPageList;
var
  kid: IXMLNode;
begin
  Assert(Node <> nil);
  Assert(Node.NodeName = 'PageList');

  Result := TBPageList.Create(Size);
  kid := Node.ChildNodes.First;
  while kid <> nil do
  begin
    Result.FPages.Add(TBPageRange.FromXML(Result, kid));
    kid := kid.NextSibling;
  end;
end;

{ TBBlock }

constructor TBBlock.Create(const Parent: TBBlockList);
begin
  inherited Create(Parent);
end;

destructor TBBlock.Destroy;
begin

  inherited;
end;

class function TBBlock.FromXML(const Parent: TBBlockList;
  const Node: IXMLNode): TBBlock;
var
  kid: IXMLNode;
begin
  Assert(Node <> nil);
  Assert(Node.NodeName = 'Block');

  Result := TBBlock.Create(Parent);
  kid := Node.ChildNodes.FindNode('Name');
  if kid <> nil then
    Result.Name := kid.Text;
  kid := Node.ChildNodes.FindNode('Size');
  if kid <> nil then
    Result.Size := kid.Text;
end;

{ TBBlockList }

constructor TBBlockList.Create(const Size: String);
begin
  FContentLength := Size;
  FCommitedBlocks := TObjectList<TBBlock>.Create(false);
  FUncommitedBlocks := TObjectList<TBBlock>.Create(false);
end;

destructor TBBlockList.Destroy;
begin
  FCommitedBlocks.Free;
  FUncommitedBlocks.Free;

  inherited;
end;

class function TBBlockList.FromXML(const Size: String;
  const Node: IXMLNode): TBBlockList;
var
  kid: IXMLNode;
begin
  Assert(Node <> nil);
  Assert(Node.NodeName = 'BlockList');

  Result := TBBlockList.Create(Size);

  kid := Node.ChildNodes.FindNode('CommittedBlocks');
  if kid <> nil then
  begin
    kid := kid.ChildNodes.First;
    while kid <> nil do
    begin
      if kid.NodeName = 'Block' then
        Result.FCommitedBlocks.Add(TBBlock.FromXML(Result, kid));
      kid := kid.NextSibling;
    end
  end;
  kid := Node.ChildNodes.FindNode('UncommittedBlocks');
  if kid <> nil then
  begin
    kid := kid.ChildNodes.First;
    while kid <> nil do
    begin
      if kid.NodeName = 'Block' then
        Result.FUncommitedBlocks.Add(TBBlock.FromXML(Result, kid));
      kid := kid.NextSibling;
    end
  end;
end;

{ TLeaseManager }
class function TLeaseManager.Instance: TLeaseManager;
begin
  if LeaseManagerInstance = nil then
    LeaseManagerInstance := TLeaseManager.Create;

  Result := LeaseManagerInstance;
end;

constructor TLeaseManager.Create;
begin
  FItems := TList<TLeaseItem>.Create;

  if LeaseManagerInstance = nil then
    LeaseManagerInstance := Self;
end;

destructor TLeaseManager.Destroy;
var
  Item: TLeaseItem;
begin
  LeaseManagerInstance := nil;
  for Item in FItems do
    Item.Free;  
  FreeAndNil(FItems);
  inherited;
end;

function TLeaseManager.GetLeaseItem(out Success: Boolean; BlobURL: String; LeaseID: String): TLeaseItem;
var
  Item: TLeaseItem;
begin
  Result := nil;
  Success := True;
  for Item in FItems do
  begin
    if (Item.BlobURL = BlobURL) or (Item.LeaseID = LeaseID) then
      Exit(Item);
  end;
  Success := False;
end;

function TLeaseManager.GetLeaseExpireTime(BlobURL, LeaseID: String): TDateTime;
var
  Item: TLeaseItem;
  Success: Boolean;
begin
  Result := 0;
  Item := GetLeaseItem(Success, BlobURL, LeaseID);
  if Success then
    Exit(Item.ExpireTime);
end;

function TLeaseManager.GetLeaseID(BlobURL: String): String;
var
  Item: TLeaseItem;
  Success: Boolean;
begin
  Item := GetLeaseItem(Success, BlobURL);
  if Success then
  begin
    if Now > Item.ExpireTime then
    begin
      ClearLeaseInfo(BlobURL);
      Exit(EmptyStr);
    end;

    Exit(Item.LeaseID);
  end;
end;

procedure TLeaseManager.SetLeaseInfo(BlobURL, LeaseID: String; ExpireTime: TDateTime);
var
  Item: TLeaseItem;
  Success: Boolean;
begin
  Item := GetLeaseItem(Success, BlobURL);
  if Success then
  begin
    Item.LeaseID := LeaseID;
    Item.ExpireTime := ExpireTime;
  end
  else
  begin
    Item := TLeaseItem.Create;
    Item.BlobURL := BlobURL;
    Item.LeaseID := LeaseID;
    Item.ExpireTime := ExpireTime;
    FItems.Add(Item);
  end;
end;

procedure TLeaseManager.ClearLeaseInfo(BlobURL, LeaseID: String);
var
  Item: TLeaseItem;
  Success: Boolean;
begin
  Item := GetLeaseItem(Success, BlobURL);
  if Success then
  begin
    FItems.Remove(Item);
    Item.Free;
  end;
end;

{ TLeaseItem }

constructor TLeaseItem.Create;
begin
  inherited;
end;

initialization
  TLeaseManager.Instance;

finalization
  FreeAndNil(LeaseManagerInstance);

end.
