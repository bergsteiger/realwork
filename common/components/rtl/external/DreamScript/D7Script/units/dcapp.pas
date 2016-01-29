{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcapp;
{$I dc.inc}
interface
uses
  dcdreamlib, classes, sysutils,

  {$IFNDEF CLX}
  windows,
  messages,
  forms,
  controls,
  buttons,
  comctrls,
  dialogs,
  menus,
  {$ELSE}
  QForms,
  QControls,
  QButtons,
  QComctrls,
  QDialogs,
  QMenus,
  {$ENDIF}

  typinfo, dcconsts, dcapi, dcsystem, dccommon;

type
  TSkipException = class(Exception);

  TCompoundIDEObject = class;
  TCompoundIDEObjectClass = class of TCompoundIDEObject;

  TSaveObject = class;

  TSaveObjectClass=class of TSaveObject;

  TIDEObjectParam=(opNoRecentFile,opNoSmartOpen{,opCanBeOnlyOne});
  TIDEObjectParams=set of TIDEObjectParam;

  TCustomIDEProject=class;

  {somehow register copy from clipboard procedures for the ideobject? }
  TIDEObject = class(_TIDEObject)
  private
    FFilerID:TFilerID;
    FFileName:TFileName;
    FOldFilename:TFileName;
    FOldFilerID:TFilerID;
    FWasSaved:boolean;
    FSaveClass:TSaveObjectClass;
    FRefCount:Integer;
    FClosed:boolean;
    FModifiedDuringOpen:boolean;
    procedure SetVisible(Value:boolean);
    procedure SetFocusedValue(Value:boolean);
    procedure SetClosed(Value:boolean);
  protected
    function GetModifiedDuringOpen:boolean;virtual;
    procedure SetFileName(const Value:TFileName);virtual;
    procedure SetFilerID(const Value:TFilerID);virtual;
    function GetVisible:boolean;virtual;
    function GetObjectParams:TIDEObjectParams;virtual; //!!!
    procedure SetModifiedFalse;virtual;
    procedure InternalCreate(const FileName:TFileName; const FilerID:TFilerID);virtual;
    function GetFileExt:String;virtual;
    function GetDisplayName:String;virtual;
    function GetDefaultSaveClass:TSaveObjectClass;virtual;
    function GetObjectName:String;virtual;
    function GetModified:boolean;virtual;
    function GetFocused:boolean;virtual;
//    procedure BeforeClose;virtual;
    procedure ObjectCreated; virtual;
  public
    function HasEqualFileName(IDEObject:TIDEObject):boolean;
    function OldNameIsSame:boolean;
    procedure FixupReferences;virtual;

    function GetObjectProps:String;virtual;
    procedure PropsChanged;

    function GetInstance:TComponent;virtual;
    procedure RemoveFrom(IDEObject:TCompoundIDEObject);virtual;
    procedure Hide;virtual;
    procedure Show;

    procedure CreateFromStream(Stream:TStream);virtual;
    procedure UseObjects(ObjectList:TList);virtual;
    function CanUseObject(IDEObject:TIDEObject):boolean;virtual;
    procedure GetUsedObjects(UsedObjects:TStrings);virtual;
    procedure GetReferencedObjects(RefObjects:TList);virtual;
    procedure AddTo(IDEObject:TCompoundIDEObject);virtual;
    procedure SetFocused;virtual;
    function ExportTo(const FileName:TFileName; const FilerID:TFilerID;SaveClass:TSaveObjectClass):boolean;virtual;
    function SaveTo(const FileName:TFileName; const FilerID:TFilerID;SaveClass:TSaveObjectClass):boolean;

    function ValidObjectName(const ObjName:String):boolean;virtual;
    constructor Create(AOwner:TComponent);override;
    constructor CreateFrom(const FileName:TFileName; const FilerID:TFilerID);virtual;
    constructor CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);virtual;
    function CanClose:boolean;virtual;
    destructor Destroy;override;
    procedure CutToClipboard;virtual;
    procedure PasteFromClipboard;virtual;
    procedure CopyToClipboard;virtual;
    procedure DeleteSelection;virtual;
    procedure SelectAll;virtual;
    procedure Undo;virtual;
    procedure Redo;virtual;
    procedure Print;virtual;
    function CanPrint:boolean;virtual;
    procedure BrowseProperties;virtual;

    property ModifiedDuringOpen:boolean Read GetModifiedDuringOpen Write FModifiedDuringOpen;
    property FilerID:TFIlerID Read FFilerID write SetFilerID;
    property FileName:TFileName Read FFileName write SetFileName;
    property DisplayName:String Read GetDisplayName;
    property ObjectName:String Read GetObjectName;
    property FileExt:String read GetFileExt;
    property WasSaved:boolean Read FWasSaved;
    property Modified:boolean Read GetModified;
    property Closed:boolean Read FClosed Write SetClosed;
    property Focused:boolean Read GetFocused Write SetFocusedValue;
    property RefCount:Integer Read FRefCount;
    property Visible:boolean Read GetVisible Write SetVisible;
  published
  end;

  TIDEObjectClass = class of TIDEObject;

  TSaveObject = class
  private
    FIDEObject:TIDEObject;
  public
    constructor Create(IDEObject:TIDEObject);virtual;
    procedure SaveProc(const FileName:TFileName; const FilerID:TFilerID);virtual;abstract;
    property IDEObject:TIDEObject Read FIDEObject;
  end;

  TOpenObject = class
  private
    FCompound:TCompoundIDEObject;
  public
    constructor Create(Compound:TCompoundIDEObject);virtual;
    function OpenFrom(const FileName:TFileName;
            const FilerID:TFilerID):TIDEObject;virtual;abstract;
    property Compound:TCompoundIDEObject Read FCompound;
  end;


  TCustomOpenIDEObject = class(TOpenObject)
  protected
    function GetIDEObjectClass:TIDEObjectClass;virtual;abstract;
  public
    function OpenFrom(const FileName:TFileName;
            const FilerID:TFilerID):TIDEObject;override;
  end;

  TOpenIDEObject=class(TCustomOpenIDEObject)
  end;

  TOpenIDEObjectClass=class of TOpenIDEObject;
  TOpenObjectClass = class of TOpenObject;

  TSaveWithBackup=class(TSaveObject)
  public
    procedure SaveToStream(S:TStream);virtual;abstract;
    procedure SaveProc(const FileName:TFileName; const FilerID:TFilerID);override;
  end;

  TSaveAsQueryEvent=procedure (var FileName:String;var FilerID:TFilerID;
                       SaveTypes:TStrings;var SaveClass:TSaveObjectClass) of object;

  TOpenQueryEvent=procedure(FileNames:TStrings;var FilerID:TFilerID;
                       OpenTypes:TStrings;var OpenClass:TOpenObjectClass;Var OkToOpen:boolean) of object;

  TIDEObjectListItem=class(TDCNamedItem)
  private
    FFileName:TFileName;
    FFilerID:TFilerID;
    FClassName:String;
    function GetShortName:String;
  public
    function RelatedObject:TIDEObject;
    property ShortName:String Read GetShortName;
  published
    property FileName:TFileName Read FFileName Write FFileName;
    property FilerID:TFilerID Read FFilerID Write FFilerID;
    property ObjectClassName:String Read FClassname Write FClassName;
  end;

  TIDEObjectList=class(TDCNamedItems)
  private
    function GetItem(Index:Integer):TIDEObjectListItem;
  public
    function AddObject(IDEObject:TIDEObject):TIDEObjectListItem;virtual;
    function RemoveObject(IDEObject:TIDEObject):TIDEObjectListItem;virtual;
    procedure MakePathsRelative(const AFileName:String; const AFilerID:string);
    procedure MakePathsAbsolute(const AFileName:String; const AFilerID:string);
    function  IndexOfOldObject(IDEObject:TIDEObject):Integer;
    function  IndexOfFileName(const AFileName:TFileName;const AFilerID:TFilerID):Integer;
    function  IndexOfObject(IDEObject:TIDEObject;CheckOld:boolean):Integer;
    property  Items[Index:Integer]:TIDEObjectListItem Read GetItem;default;
  end;

  TIDEProjectItem = class(TIDEObjectListItem)
  private
    FOpened:boolean;
    FObjectProps:String;
  protected
  public
    function GetPropValue(const PropName:String):String;
    destructor Destroy;override;
  published
    property ObjectOpened:boolean Read FOpened Write FOpened;
    property ObjectProps:String Read FObjectProps Write FObjectProps;
  end;

  TIDEProjectItems = class(TIDEObjectList)
  public
    procedure Update(Item: TCollectionItem); override;
    procedure UpdateObjectProps;
    function AllObjectsOpened:boolean;
    function AddObject(IDEObject:TIDEObject):TIDEObjectListItem;override;
  end;

  TRecentInfoKind=(rkWorkSpace,rkProject,rkFile);

  TRecentInfo=class(TIDEObjectListItem)
  private
    FInfoKind:TRecentInfoKind;
  published
    property InfoKind:TRecentInfoKind Read FInfoKind Write FInfoKind;
  end;

  TRecentInfoClass=class of TRecentInfo;

  TRecentInfos=class(TIDEObjectList)
  public
    function AddObject(IDEObject:TIDEObject):TIDEObjectListItem;override;
    function AddToRecentMenu(MenuItem:TMenuItem;AInfoKind:TRecentInfoKind;
                OnClick:TNotifyEvent;StartHotKey:Integer):Integer;
  end;

  TRecentCount=5..20;

  TIDEWorkSpace=class;

  TOnNewObjectEvent = procedure(Sender : TObject; AObject : TIDEObject) of object;

  TSaveMethod = function (const FileName:TFileName; const FilerID:TFilerID; SaveClass:TSaveObjectClass):boolean of object;

  TCompoundIDEObject = class(TIDEObject)
  private
    FAllFilesExt:String;
    FActiveProject:TCustomIDEProject;
    FMaxRecent:TRecentCount;
    FRecentFiles:TMenuItem;
    FRecentSpaces:TMenuItem;
    FIDEClass:TIDEObjectClass;
    FRecentInfos:TRecentInfos;
    FDefaultFileSystem:string;
    FSaveAsQuery:TSaveAsQueryEvent;
    FOpenQuery:TOpenQueryEvent;
    FObjectList:TList;
    FFixupList:TIDEProjectItems;
    FSaveAll : boolean;
    FNeedSaveAll : boolean;
    FOnNewObjectAdd : TOnNewObjectEvent;
    FOnObjectCreated : TOnNewObjectEvent;
    procedure SetActiveProject(IDEProject:TCustomIDEProject);
    function GetActiveProject:TCustomIDEProject;
// ---------------- recent items support -------------------------

    procedure RecentMenuOnClick(Sender:TObject);
    procedure SetRecentInfos(Value:TRecentInfos);
    procedure DeleteExtraRecentItems(Infos:TRecentInfos;NewCount:Integer);
    procedure SetMaxRecentItems(Value:TRecentCount);
    procedure UpdateRecentSpacesMenu;
    procedure UpdateRecentFilesMenu;
    procedure RecentInfosChanged;
    procedure SetRecentFiles(Value:TMenuItem);
    procedure SetRecentSpaces(Value:TMenuItem);

// ---------------- different iterators -------------------------

    procedure ReleaseIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure SetModifiedFalseIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure CloseWithClassIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure FixupIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure SetFocusedIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure SaveAllIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure SaveAllQuestionIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure GetModifiedIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure GetModifiedDuringOpenIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure HideIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure CanCloseIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
    procedure GetVisibleIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);

    function OpenTypesIterator(Item:TObjectParamListItem;const AParams:Array of variant;
               Var Finish:boolean):Variant;
    function SaveTypesIterator(Item:TObjectParamListItem;const AParams:Array of variant;
               Var Finish:boolean):Variant;

    procedure ReleaseObjects;
    function GetObject(Index:Integer):TIDEObject;
    function GetObjectCount:Integer;
    function GetActiveObject:TIDEObject;
    function SaveAsQuery(var FileName:String;var FilerID:TFilerID;
               SaveTypes:TStrings):TSaveObjectClass;
    function SaveAsQueryEx(var FileName:String;var FilerID:TFilerID;
               SaveTypes:TStrings; const DialogTitle: string):TSaveObjectClass;
    function OpenQuery(FileNames:TStrings;var FilerID:TFilerID;
               OpenTypes:TStrings;var OpenClass:TOpenObjectClass):boolean;
  protected
    function DoWithObjects(List:TList;Iterator:TListIteratorProc):boolean;
    function CanSaveObjList(List:TList):boolean;
    procedure FixupClosedObjects;
    function  CloseObjectsWithClass(IDEClass:TIDEObjectClass):boolean;
    procedure SaveWorkSpace;virtual;
    function  SaveAllWithQuestion:boolean;
    procedure ChangeActiveObject(ANext:Boolean);virtual;
    function  GetVisible:boolean;override;
    procedure SetModifiedFalse;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure InternalCreate(const FileName:TFileName;const FilerID:TFilerID);override;
    function GetFocused:boolean;override;
    function GetModified:boolean;override;
    function CloseProject(IDEProject:TCustomIDEProject):boolean;
    function GetModifiedDuringOpen:boolean;override;
    procedure NewObjectAdded(AObject : TIDEObject); virtual;
    procedure IDEObjectCreated(AObject : TIDEObject); virtual;
    property OnSaveAsQuery:TSaveAsQueryEvent Read FSaveAsQuery Write FSaveAsQuery;
    property OnOpenQuery:TOpenQueryEvent Read FOpenQuery Write FOpenQuery;
  public
    function CanPrint:boolean;override;
    procedure Print;override;

    procedure GetSaveTypes(IDEClass:TIDEObjectClass;SaveTypes:TStrings);
    procedure GetOpenTypes(OpenClass:TOpenObjectClass;OpenTypes:TStrings);

    procedure FixupReferences;override;
    procedure ShortNamesToObjList(ShortNames:TStrings;ObjectList:TList);
    function ProjectItemByShortName(const ShortName:String):TIDEProjectItem;

    function AddToActiveProject:TIDEObject;
    function AddToProject(Project:TCustomIDEProject):TIDEObject;

    function UniqueObjectName(const BaseName:String):String;
    function UniqueObjectNumber(const BaseName:String):Integer;
    function IsMemberOfProject(IDEObject:TIDEObject;
               ExceptProject:TCustomIDEProject;CheckOld:boolean):boolean;

    procedure SetObjectOrder(IDEObject:TIDEObject;NewOrder:Integer);
    procedure SetFocused;override;

    procedure AddRecentInfo(IDEObject:TIDEObject);
    procedure RemoveRecentInfo(IDEObject:TIDEObject);
    procedure Hide;override;

    procedure AddObject(IDEObject:TIDEObject);
    function IsActiveCompound:boolean;
    procedure CompoundNextObject;
    procedure CompoundPreviousObject;
    function ActiveObjectIndex:Integer;


    function FindObjectWithClass(IDEClass:TIDEObjectClass):TIDEObject;
    function ObjectByName(const ObjectName:String):TIDEObject;{return object with specific name (name is filename without path and extension) }
    function ObjectByFileName(const FileName:TFileName;const FilerID:TFilerID):TIDEObject;

// ------------ use objects methods -----------------

    procedure GetReferencedObjects(RefObjects:TList);override;
    function IsObjectUsed(IDEObject:TIDEObject):boolean;
    procedure UseObjects(ObjectList:TList);override;
    function CanUseObject(IDEObject:TIDEObject):boolean;override;
    procedure GetUsedObjects(UsedObjects:TStrings);override;

// ------------ new methods -----------------

    function NewIDEObject(Item:TObjectParamListItem;
               ASetVisible:boolean):TIDEObject;
//    function New:TIDEObject;

    function NewObjectOfClass(IDEClass:TIDEObjectClass;
               const BaseName:string; ASetVisible:boolean):TIDEObject;

    function NewRegisteredIDEObject(IDEClass:TIDEObjectClass;
               ASetVisible:boolean):TIDEObject;
// ------------ open methods -----------------

    function OpenFileAs(const FileName:String;
               const FilerID:TFilerID;OpenClass:TOpenObjectClass;
               ASetVisible:boolean):TIDEObject; // need to create new if can't open

    function Open:TIDEObject;
    function OpenFile(const FileName:String;const FilerID:TFilerID;
               ASetVisible:boolean):TIDEObject;
    procedure OpenFiles(FileNames:TStrings;const FilerID:TFilerID);
    function OpenWin32File(const FileName:String):TIDEObject;
    procedure OpenWin32Files(FileNames:TStrings);
    procedure OpenCommandLineFiles;
    function OpenLimited(OpenTypes:TStrings):TIDEObject;
    function OpenLimitedType(OpenClass:TOpenObjectClass):TIDEObject;


// ------------ save methods -----------------

    function UnivSaveObject(IDEObject:TIDEObject; Method: TSaveMethod; const DialogTitle: string):boolean;
    function SaveWithQuestion(IDEObject:TIDEObject):boolean;
    function CanSaveObject(IDEObject:TIDEObject):boolean;{ Return true if object can be saved }
    function SaveObjectAs(IDEObject:TIDEObject):boolean;    { Call this function to "save as" object. User will be asked where to save Return true if success }
    function ExportObjectTo(IDEObject:TIDEObject):boolean;  { Call this function to "export to" object. User will be asked where to save Return true if success }
    function SaveObjectsWithQuestion(ObjList:TList):boolean;
    function SaveObject(IDEObject:TIDEObject):boolean;{ Call this function to save object. Return true if operation succesfull }
    function SaveActive:boolean;{ Call this function to save active object }
    function CanSaveActive:boolean;{ Returns true if active object can be saved }
    function SaveActiveAs:boolean;    { Call this function to "save as" active object Return true if success }
    function ExportActiveTo:boolean;    { Call this function to "export to" active object Return true if success }
    function CanSaveAll:boolean;    { Return true if any of IDE objects need to be saved }
    function SaveAll:boolean;    { Call this function to save all objects. Return true if operation was  succesfull }
    function SaveObjList(List:TList):boolean;

// ------------ close methods -----------------

    function CanCloseObject(IDEObject:TIDEObject):boolean;    { Return true if object can be closed. Object can be closed when it's not nil and allow to close itself }
    function CloseObject(IDEObject:TIDEObject):boolean;    { Call this function to close object. You can pass nil to this function  Return true if object was closed }
    function CanCloseObjects(ObjList:TList):boolean;
    function CloseActive:boolean;{ Closes active object. Return true if object was succesfully closed }
    function CanCloseAll:boolean;{ Return true if "close all" button can be enabled }
    function CloseAll:boolean;{ Call this function to close all opened objects. Return true if all objects were closed (user will be prompted to save changes)}
    procedure CloseAllWithoutQuestion;

    function CanCloseActive:boolean;

// ------------ clipboard methods -----------------

    procedure CutToClipboard;override;
    procedure PasteFromClipboard;override;
    procedure CopyToClipboard;override;

// ------------ other methods -----------------

    procedure DeleteSelection;override;
    procedure SelectAll;override;

    procedure PreviousObject;
    procedure NextObject;

    destructor Destroy;override;

    procedure Undo;override;
    procedure Redo;override;
    procedure BrowseProperties;override;
    property FixUpList:TIDEProjectItems Read FFixupList;
    property Objects[Index:Integer]:TIDEObject Read GetObject;default;
    property ObjectCount:Integer Read GetObjectCount;
    property ActiveObject:TIDEObject Read GetActiveObject;
    property DefaultFileSystem:string Read FDefaultFileSystem Write FDefaultFileSystem;
    property RecentFilesMenu:TMenuItem Read FRecentFiles Write SetRecentFiles;
    property RecentWorkSpacesMenu:TMenuItem Read FRecentSpaces Write SetRecentSpaces;
    property MaxRecentItems:TRecentCount Read FMaxRecent Write SetMaxRecentItems default 20;
    property RecentInfos:TRecentInfos Read FRecentInfos Write SetRecentInfos;
    property ActiveProject:TCustomIDEProject Read GetActiveProject Write SetActiveProject;
    property OnNewObjectAdd : TOnNewObjectEvent read FOnNewObjectAdd write FOnNewObjectAdd;
    property OnObjectCreated : TOnNewObjectEvent read FOnObjectCreated write FOnObjectCreated;
  end;

  TMasteredIDEObject = class(TCompoundIDEObject)
  private
    FMasterObject:TIDEObject;
  protected
    function GetMasterObjectClass:TIDEObjectClass;virtual;abstract;
  public
    procedure UseObjects(ObjectList:TList);override;
    function CanUseObject(IDEObject:TIDEObject):boolean;override;
    procedure GetUsedObjects(UsedObjects:TStrings);override;
    function ValidObjectName(const ObjName:String):boolean;override;
    constructor CreateFrom(const FileName:TFileName; const FilerID:TFilerID);override;
    constructor CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);override;
    property MasterObject:TIDEObject Read FMasterObject;
  end;

  TCustomIDEFormMemoObject = class(TMasteredIDEObject);

  TCustomIDEProject = class(TIDEObject)
  private
    FModified:boolean;
    FProjectItems:TIDEProjectItems;
    FStrictWithNames:boolean;
    procedure SetProjectItems(Value:TIDEProjectItems);
  protected
    procedure FillProjectItems(IDEObject:TCompoundIDEObject);
    procedure FillProjectIterator(Item:TObject;ItemIndex:Integer;Var Continue:boolean);
    procedure InternalCreate(const FileName:TFileName; const FilerID:TFilerID);override;
    function GetModified:boolean;override;
    procedure SetModifiedFalse;override;
    function GetDefaultSaveClass:TSaveObjectClass;override;
  public
    procedure CreateFromStream(Stream:TStream);override;
    function SaveProjectFiles:boolean;
    procedure SetModifiedTrue;
    procedure ObjectsToList(ObjList:TList;Compound:TCompoundIDEObject);
    function  ProjectItemByShortName(const ShortName:String):TIDEProjectItem;
    function OpenProjectItems(IDEObject:TCompoundIDEObject;
                AllObjects:boolean):boolean;
    function  ExportTo(const FileName:TFileName; const FilerID:TFilerID;SaveClass:TSaveObjectClass):boolean;override;
    destructor Destroy;override;
    procedure ClearProject;
    procedure AddToProject(IDEObject:TIDEObject);virtual;
    procedure RemoveFromProject(IDEObject:TIDEObject);
    property  ProjectItems:TIDEProjectItems Read FProjectItems Write SetProjectItems;
    property  StrictWithNames:boolean Read FStrictWithNames;
  published
  end;

  TIDEProject = class(TCustomIDEProject)
  protected
    procedure InternalCreate(const FileName:TFileName; const FilerID:TFilerID);override;
  public
    RunHandle : Integer;
    procedure AddTo(IDEObject:TCompoundIDEObject);override;
    destructor Destroy;override;
    {$IFNDEF CLX}
    procedure CMIDESAVETO(Var Message:TMessage);message CM_IDESAVETO;
    procedure CMIDEOBJPROPSCHANGED(Var Message:TMessage);message CM_IDEOBJPROPSCHANGED;
    procedure CMIDEADDTO(Var Message:TMessage);message CM_IDEADDTO;
    procedure CMOBJDESTROYED(Var Message:TMessage);message CM_OBJDESTROYED;
    {$ENDIF}
  published
    property ProjectItems;
  end;

  TIDEApplication= class(TIDEProject)
  public
  end;

  TIDEWorkSpace = class(TCustomIDEProject)
  private
    FOwnerObject:TCompoundIDEObject;
  protected
    function GetObjectParams:TIDEObjectParams;override;
  public
    procedure AddTo(IDEObject:TCompoundIDEObject);override;
    function ExportTo(const FileName:TFileName; const FilerID:TFilerID;SaveClass:TSaveObjectClass):boolean;override;
    destructor destroy;override;
  published
    property ProjectItems;
  end;

  TInstantReport = class(TCompoundIDEObject)
  private
    FWorkSpace:TIDEWorkSpace;
    FMainFormCaption:String;
    FProjectInCaption:boolean;
    FVersion : TDCVersion; 
    procedure _UpdateMainFormCaption;
    procedure SetMainFormCaption(const Value:String);
    procedure SetProjectInCaption(Value:boolean);
    procedure UpdateMainFormCaption;
  protected
{$IFNDEF CLX}
    procedure CMBEFOREPACKAGEUNLOAD(Var M:TMessage);message CM_BEFOREPACKAGEUNLOAD;
    procedure CMIDEAPROJCHANGED(Var M:TMessage);message CM_IDEAPROJCHANGED;
    procedure CMIDESAVETO(Var Message:TMessage);message CM_IDESAVETO;
{$ENDIF}
  public
    procedure OpenWorkSpace;
    procedure SaveWorkSpace;override;
    procedure SaveWorkSpaceAs;
    procedure OpenDefaultWorkSpace;

{    procedure SaveTo(const FileName:TFileName; const FilerID:TFilerID;
            SaveClass:TSaveObjectClass);override;}
    procedure InternalCreate(const FileName:TFileName; const FilerID:TFilerID);override;
    destructor Destroy;override;
    property WorkSpace:TIDEWorkSpace Read FWorkSpace;
  published
    property OnSaveAsQuery;
    property OnOpenQuery;
    property RecentFilesMenu;
    property RecentWorkSpacesMenu;
    property MaxRecentItems;
    property MainFormCaption:String Read FMainFormCaption Write SetMainFormCaption;
    property ProjectInCaption:boolean Read FProjectInCaption Write SetProjectInCaption;
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

  TOpenWorkSpaceObject = class(TCustomOpenIDEObject)
  protected
    function GetIDEObjectClass:TIDEObjectClass;override;
  end;

  TOpenProjectObject = class(TOpenIDEObject)
  protected
    function GetIDEObjectClass:TIDEObjectClass;override;
  end;

  TSaveProjectObject = class(TSaveWithBackup)
  public
    procedure SaveToStream(S:TStream);override;
  end;
(*
  TSystemMessageItem=class(TCollectionItem)
  private
    FCaption:String;
  public
    FileName:TFileName;
    FileSystem:TFileSystem;
    CharPos,LinePos:Integer;
  {$IFDEF D3}
    function GetDisplayName: string;override;
  {$ENDIF}
  published
    property Caption:String Read FCaption Write FCaption;
  end;

  TSystemMessageList=class(TCollection)
  end;
*)

{-------------------------------------------------------------------------}

//procedure SendDebugEx(const V:Array of Variant);
//procedure SendDebug(V:Variant);
//function SystemMessageList:TSystemMessageList;

function NormalizeExtension(Const Extension:String):String;

procedure CommandLineToStrings(S:TStrings);

procedure RegisterSaveClass(SaveClass:TSaveObjectClass;
            IDEObjectClass:TIDEObjectClass;
            const Extension,Description:String);

function RegisterOpenClass(OpenClass:TOpenObjectClass;const Extension,Description:String):TObjectParamListItem;

procedure RegisterNewItem(IDEClass:TIDEObjectClass;
  const FileName,ResName,PageCaption,Caption:String);

function GetPropFileSystemFilerID(Instance:TComponent;const APropName:String):TFilerID;

function FilerFileExists(const FilerID:TFilerID;const Filename:TFileName):boolean;
procedure FilerChangeDir(const FilerID:TFilerID;const NewDir:String);
function FilerGetDir(const FilerID:TFilerID):String;

function FindOpenClass(const FileName:String):TOpenObjectClass;

{Converts number 0..36 to hot char 0..9 A..Z
 Return 0 if not in 0..36}
function IntToHotChar(I:Integer):Char;

function MainIDEObject:TCompoundIDEObject;

function IsInMainObject(const O):boolean;

procedure UseObjectsInCodeDesigner(ObjectList:TList;CodeDesigner:TCodeDesigner);
procedure ShortNamesToStrings(IDEObjects:TList;Strings:TStrings);

procedure OpenParamFiles;

procedure FilterProjects(FromList,ToList:TList;InclProjects:boolean);
procedure HasObjects(Var VerbStates:TVerbStates);
function ProjectItemIsCompound(Item:TIDEProjectItem):boolean;
procedure HasActiveObject(Var VerbStates:TVerbStates);
procedure HasActiveProject(Var VerbStates:TVerbStates);

procedure ActionAddToProject(Instance:TPersistent);
procedure ActionSaveObject(Instance:TPersistent);
procedure ActionSaveObjectAs(Instance:TPersistent);
procedure ActionCloseObject(Instance:TPersistent);
procedure ActionActivateProject(Instance:TPersistent);

{-------------------------------------------------------------------------}
var
  NewUniqueNumberStr:String='';
  RunScriptParameters:String='';

{-------------------------------------------------------------------------}
const
  DefaultMainIdeObjectClass  : TCompoundIDEObjectClass = TInstantReport;

implementation

const
  SNewItemID='NewDialogItem'; //don't resource

Var
  FMainObject:TCompoundIDEObject=nil;
  FFakeMainObject:TCompoundIDEObject=nil;

{-------------------------------------------------------------}
(*
{$IFDEF D3}
function TSystemMessageItem.GetDisplayName: string;
begin
  Result:=Caption;
  If Result='' then
    Result:=inherited GetDisplayName;
end;
{$ENDIF}
*)
{-------------------------------------------------------------}

{$IFNDEF CLX}

procedure TInstantReport.CMIDESAVETO(Var Message:TMessage);
begin
  If Message.wparam=Integer(ActiveProject) then
    _UpdateMainFormCaption
end;

{$ENDIF}
{-------------------------------------------------------------}

procedure TInstantReport._UpdateMainFormCaption;
begin
  If FProjectInCaption then
    UpdateMainFormCaption;
end;

{-------------------------------------------------------------}

{$IFNDEF CLX}
procedure TInstantReport.CMIDEAPROJCHANGED(Var M:TMessage);
begin
  _UpdateMainFormCaption
end;
{$ENDIF}

{-------------------------------------------------------------}

procedure TInstantReport.SetMainFormCaption(const Value:String);
begin
  If FMainFormCaption<>Value then
  begin
    FMainFormCaption:=Value;
    UpdateMainFormCaption;
  end;
end;

{-------------------------------------------------------------}

procedure TInstantReport.SetProjectInCaption(Value:boolean);
begin
  If FProjectInCaption<>Value then
  begin
    FProjectInCaption:=Value;
    UpdateMainFormCaption;
  end;
end;

{-------------------------------------------------------------}

procedure TInstantReport.UpdateMainFormCaption;
Var
  TempCapt:String;
begin
  If (csDesigning in ComponentState) or (MainIDEObject<>Self) then
    exit;
  TempCapt:=FMainFormCaption;
  If FProjectInCaption and (ActiveProject<>nil) then
    AddStr(TempCapt,' - '+ActiveProject.ObjectName);
  Application.MainForm.Caption:=TempCapt;
end;

{-------------------------------------------------------------}

destructor TInstantReport.Destroy;
begin
{$IFNDEF CLX}
  If MainIDEObject = Self then
    WriteObjToRegistry(SVarWSpaceRecent, FRecentInfos);
{$ENDIF}

  FWorkSpace.Free;
  inherited;
  If MainIDEObject=Self then
    FMainObject:=FFakeMainObject;
end;

{-------------------------------------------------------------}

procedure TInstantReport.OpenWorkSpace;
begin
  OpenLimitedType(TOpenWorkSpaceObject);
end;

{-------------------------------------------------------------}

procedure TInstantReport.SaveWorkSpace;
begin
  With FWorkSpace do
    SaveTo(FileName,FilerID,nil);
end;

{-------------------------------------------------------------}

procedure TInstantReport.SaveWorkSpaceAs;
begin
  SaveObjectAs(FWorkSpace);
end;

{-------------------------------------------------------------}

function TIDEWorkSpace.GetObjectParams:TIDEObjectParams;
begin
  Result:=[opNoSmartOpen];
end;

{-------------------------------------------------------------}

procedure TCompoundIDEObject.GetReferencedObjects(RefObjects:TList);
Var
  i:Integer;
  TempList:TList;
begin
  inherited;
  TempList:=CreateList;
  try
    for i:=ObjectCount-1 downto 0 do
    begin
      Objects[i].GetReferencedObjects(TempList);
      AddList(TempList,RefObjects);
    end;
  finally
    TempList.Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCompoundIDEObject.ReleaseIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  TIDEObject(Item).RemoveFrom(Self);
end;

{-------------------------------------------------------------}

function TCompoundIDEObject.GetModifiedDuringOpen:boolean;
begin
  Result:=not ForEachListItem(FObjectList,GetModifiedDuringOpenIterator);
end;

{-------------------------------------------------------------}

function TIDEObject.GetModifiedDuringOpen:boolean;
begin
  Result:=FModifiedDuringOpen;
end;

{-------------------------------------------------------------}

procedure TIDEObject.FixupReferences;
begin
end;

{-------------------------------------------------------------}

procedure TIDEObject.PropsChanged;
begin
  BroadCastToNotifiers(Self,CM_IDEOBJPROPSCHANGED,Integer(Self),0);
end;

{-------------------------------------------------------------}

function TIDEObject.GetObjectProps:String;
begin
  Result:='';
end;

{-------------------------------------------------------------}

procedure TIDEObject.RemoveFrom(IDEObject:TCompoundIDEObject);
Var
  i:Integer;
begin
  If IDEObject=nil then
    exit;
  With IDEObject,FObjectList do
  begin
    i:=IndexOf(Self);
    If i<0 then
      exit;
    AddRecentInfo(Self);
    Delete(i);
//    BroadcastToNotifiers(Self,CM_IDEREMOVEFROM,Integer(Self),Integer(IDEObject));
  end;
  dec(FRefCount);
  If FRefCount<=0 then
    Free;
end;

{-------------------------------------------------------------}

procedure TCompoundIDEObject.ReleaseObjects;
begin
  If Self=MainIDEObject then
    SimpleBroadCast(cm_IDECLOSEAll);
  ForEachListItem(FObjectList,ReleaseIterator);
end;

{-------------------------------------------------------------}

procedure TIDEWorkSpace.AddTo(IDEObject:TCompoundIDEObject);

  procedure UpdateWorkSpace;
  begin
    With TInstantReport(IDEObject) do
    begin
      FWorkSpace.Free;
      FWorkSpace:=Self;
      RemoveRecentInfo(Self);
    end;
  end;

begin
  If not (IDEObject is TInstantReport) then
    raise Exception.Create(SErrNotInstantReport);

  inherited;

  IDEObject.FObjectList.Remove(Self);

  FOwnerObject:=IDEObject;
  With TInstantReport(IDEObject) do
  begin
    If not SaveAllWithQuestion then
    begin
      If (Self.FileName<>FWorkSpace.FileName) or
         (Self.FilerID<>FWorkSpace.FilerID) then
        SaveWorkSpace;
      Self.FFileName:=FWorkSpace.FileName;
      Self.FFilerID:=FWorkSpace.FilerID;
      Self.FWasSaved:=FWorkSpace.FWasSaved;
      UpdateWorkSpace;
      exit;
    end;
    ReleaseObjects;
    UpdateWorkSpace;
    OpenProjectItems(IDEObject,True);
  end;
end;

{-------------------------------------------------------------}

function TIDEObject.HasEqualFileName(IDEObject:TIDEObject):boolean;
begin
  Result:=(IDEObject<>nil) and (FileName=IDEObject.FileName) and (FilerID=IDEObject.FilerID);
end;

{-------------------------------------------------------------}

destructor TIDEWorkSpace.destroy;
begin
  If Assigned(FOwnerObject) then
    FOwnerObject.AddRecentInfo(Self);
  inherited;
end;

{-------------------------------------------------------------}

function TIDEWorkSpace.ExportTo(const FileName:TFileName; const FilerID:TFilerID;SaveClass:TSaveObjectClass):boolean;
begin
  FillProjectItems(FOwnerObject);
  Result:=inherited ExportTo(FileName,FilerID,SaveClass);
{$IFNDEF CLX}
  If FOwnerObject=MainIDEObject then
  begin
    WriteToRegistry(SVarWSpaceFileName, FileName);
    WriteToRegistry(SVarWSpaceFilerID, FilerID);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------}

function DefaultWorkSpaceName:TFileName;
begin
  Result:=ChangeFileExt(ParamStr(0),SExtWorkSpace)
end;

{-------------------------------------------------------------}

procedure TInstantReport.OpenDefaultWorkSpace;
Var
  WorkFileName:TFileName;
  WorkFilerId:TFilerId;
begin
{$IFNDEF CLX}
  WorkFileName:=ReadFromRegistry(SVarWSpaceFileName,DefaultWorkSpaceName);
  WorkFilerID:=ReadFromRegistry(SVarWSpaceFilerID,'');
  try
    If MainIDEObject=Self then
    begin
      ReadObjFromRegistry(SVarWSpaceRecent,FRecentInfos);
      RecentInfosChanged;
    end;
    OpenFile(WorkFileName,WorkFilerID,False);
  except
  end;
{$ENDIF}
end;

{-------------------------------------------------------------}

procedure TCustomIDEProject.SetProjectItems(Value:TIDEProjectItems);
begin
  FProjectItems.Assign(Value);
end;

{-------------------------------------------------------------}

function TCustomIDEProject.GetDefaultSaveClass:TSaveObjectClass;
begin
  Result:=TSaveProjectObject;
end;

{-------------------------------------------------------------}

procedure TCustomIDEProject.SetModifiedTrue;
begin
  FModified:=True;
  IDEChanged;
end;

{-------------------------------------------------------------}

procedure TCustomIDEProject.SetModifiedFalse;
begin
  FModified:=False;
  IDEChanged;
end;

{-------------------------------------------------------------}

function TCustomIDEProject.ExportTo(const FileName:TFileName; const FilerID:TFilerID;SaveClass:TSaveObjectClass):boolean;
begin
  With ProjectItems do
  begin
    UpdateObjectProps; // before makepathsrelative
    MakePathsRelative(FileName,FilerID);
    try
      Result:=inherited ExportTo(FileName,FilerID,SaveClass);
    finally
      MakePathsAbsolute(FileName,FilerID);
    end;
  end;
  SetModifiedFalse;
end;

{-------------------------------------------------------------}

function TCustomIDEProject.GetModified:boolean;
begin
  Result:=FModified;
end;

{-------------------------------------------------------------}

function TOpenProjectObject.GetIDEObjectClass:TIDEObjectClass;
begin
  Result:=TIDEProject;
end;

{-------------------------------------------------------------}

function TOpenWorkSpaceObject.GetIDEObjectClass:TIDEObjectClass;
begin
  Result:=TIDEWorkSpace;
end;

{-------------------------------------------------------------}

procedure TCustomIDEProject.CreateFromStream(Stream:TStream);
begin
  Stream.ReadComponent(Self);
  FProjectItems.MakePathsAbsolute(FileName,FilerID);
end;

{-------------------------------------------------------------}

procedure UseObjectsInCodeDesigner(ObjectList:TList;CodeDesigner:TCodeDesigner);
Var
  Strings:TStringList;
begin
  If Assigned(CodeDesigner) then
  begin
    Strings:=TStringList.Create;
    try
      ShortNamesToStrings(ObjectList,Strings);
      CodeDesigner.UseUnits(Strings,False);
    finally
      Strings.Free;
    end;
  end;
end;

{---------------------------------------------------}

destructor TIDEProjectItem.Destroy;
begin
  Changed(False);
  NotifyDestroy(Self);
  inherited;
end;
{
  if Item<>nil then
  begin
    BroadCastToNotifiers(Self,CM_IDEREMOVEFROMPROJ,Integer(Item),0);
    SetModifiedTrue;
  end;
}
{---------------------------------------------------}

function TIDEProjectItem.GetPropValue(const PropName:String):String;
Var
  Strings:TStrings;
begin
  Strings:=TStringList.Create;
  try
    Strings.CommaText:=FObjectProps;
    Result:=Strings.Values[PropName];
  finally
    Strings.Free;
  end;
end;

{---------------------------------------------------}

function TIDEObjectListItem.RelatedObject:TIDEObject;
begin
  Result:=MainIDEObject.ObjectByFileName(FileName,FilerID);
end;

{---------------------------------------------------}

procedure TIDEProjectItems.Update(Item: TCollectionItem);
begin
  IF Owner is TCustomIDEProject then
    TCustomIDEProject(Owner).SetModifiedTrue;
end;

{---------------------------------------------------}

function TIDEProjectItems.AllObjectsOpened:boolean;
var
  i:integer;
begin
  for I:=0 to Count-1 do
    if not TIDEprojectItem(Items[i]).ObjectOpened then
    begin
      Result:=False;
      exit;
    end;
  Result:=True;
end;

{---------------------------------------------------}

procedure TIDEProjectItems.UpdateObjectProps;
var
  i:Integer;
  IDEObject:TIDEObject;
begin
  for i:=0 to Count-1 do
  With TIDEProjectItem(Items[i]) do
  begin
    IDEObject:=RelatedObject;
    ObjectOpened:=(IDEObject<>nil) and (not IDEobject.Closed);
    If IDEobject<>nil then
      ObjectProps:=IDEObject.GetObjectProps;
  end;
end;

{---------------------------------------------------}

function TIDEProjectItems.AddObject(IDEObject:TIDEObject):TIDEObjectListItem;
begin
  Result:=inherited AddObject(IDEObject);
{  With TIDEProjectItem(Result) do
    ObjectOpened:=True;}
end;

{---------------------------------------------------}

function TRecentInfos.AddObject(IDEObject:TIDEObject):TIDEObjectListItem;
begin
  If IDEObject.WasSaved=False then
  begin
    Result:=nil;
    exit;
  end;
  Result:=inherited AddObject(IDEObject);
  With TRecentInfo(Result) do
    if IDEObject is TIDEWorkSpace then
      InfoKind:=rkWorkSpace
    else
    If IDEObject is TIDEProject then
      InfoKind:=rkProject
    else
      InfoKind:=rkFile;
end;

{---------------------------------------------------}

function TIDEObjectList.AddObject(IDEObject:TIDEObject):TIDEObjectListItem;
begin
  Result:=nil;
  If IDEObject=nil then
    exit;
  RemoveObject(IDEObject);
  Result:=TIDEObjectListItem(Add);
  With Result do
  begin
    FileName:=IDEObject.FileName;
    FilerID:=IDEObject.FilerID;
    ObjectClassName:=IDEObject.ClassName;
  end;
end;

{---------------------------------------------------}

function TIDEObjectList.RemoveObject(IDEObject:TIDEObject):TIDEObjectListItem;
Var
  i:Integer;
begin
  Result:=nil;
  If IDEObject=nil then
    exit;
  for i:=Count-1 downto 0 do
    With Items[i] do
      if (CompareText(FileName,IDEObject.FileName)=0) and
         (FilerID=IDEObject.FilerID) then
      begin
        Result:=Items[i];
        Result.Free;
        exit;
      end;
end;

{---------------------------------------------------}

function TIDEObjectList.GetItem(Index:Integer):TIDEObjectListItem;
begin
  Result:=TIDEObjectListItem(inherited Items[Index]);
end;

{------------------------------------------------------------------}

function GetPropFileSystemFilerID(Instance:TComponent;const APropName:String):TFilerID;
Var
  PropSystem:TPropFileSystem;
begin
  PropSystem:=TPropFileSystem.Create(nil);

  With PropSystem do
  begin
    Component := Instance;
    PropName:=APropName;
  end;
  Result:=GetFilerID(PropSystem);
  PropSystem.Free;
end;

{------------------------------------------------------------------}

procedure TSaveProjectObject.SaveToStream(S:TStream);
begin
  S.WriteComponent(IDEObject);
end;

{------------------------------------------------------------------}

function MainIDEObject:TCompoundIDEObject;
begin
  Result:=FMainObject;
  If Result=nil then
  begin
    If FFakeMainObject=nil then
    begin
      FFakeMainObject:=DefaultMainIdeObjectClass.Create(nil);
      FMainObject:=nil;
    end;
    Result:=FFakeMainObject;
  end;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.SaveWorkSpace;
begin
end;

{------------------------------------------------------------------}

procedure TMasteredIDEObject.UseObjects(ObjectList:TList);
begin
  MasterObject.UseObjects(ObjectList)
end;

{------------------------------------------------------------------}

function TMasteredIDEObject.CanUseObject(IDEObject:TIDEObject):boolean;
begin
  Result:=MasterObject.CanUseObject(IDEObject)
end;

{------------------------------------------------------------------}

procedure TMasteredIDEObject.GetUsedObjects(UsedObjects:TStrings);
begin
  MasterObject.GetUsedObjects(UsedObjects);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.UseObjects(ObjectList:TList);
begin
  If ActiveObject<>nil then
    ActiveObject.UseObjects(ObjectList)
  else
    inherited;
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.CanUseObject(IDEObject:TIDEObject):boolean;
begin
  If ActiveObject<>nil then
    Result:=ActiveObject.CanUseObject(IDEObject)
  else
    Result:=inherited CanUseObject(IDEObject);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.GetUsedObjects(UsedObjects:TStrings);
begin
  If ActiveObject<>nil then
    ActiveObject.GetUsedObjects(UsedObjects)
  else
    inherited;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.SetObjectOrder(IDEObject:TIDEObject;NewOrder:Integer);
Var
  Index:Integer;
begin
  Index:=FObjectList.IndexOf(IDEObject);
  If (Index<0) or (NewOrder=Index) then
    exit;
  FObjectList.Move(Index,NewOrder);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.SetRecentInfos(Value:TRecentInfos);
begin
  FRecentInfos.Assign(Value);
  RecentInfosChanged;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.SetFocusedIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  TIDEObject(Item).SetFocused;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.SetFocused;
begin
  inherited;
  ForEachListItem(FObjectList,SetFocusedIterator);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.UpdateRecentSpacesMenu;
begin
  If (FRecentSpaces=nil) then
    exit;
  ClearMenuSubItems(FRecentSpaces,False);
  FRecentInfos.AddToRecentMenu(FRecentSpaces,rkWorkSpace,RecentMenuOnClick,0);
  FRecentSpaces.Enabled:=FRecentSpaces.Count>0;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.RecentMenuOnClick(Sender:TObject);
begin
  With TRecentInfo(RecentInfos.Items[TComponent(Sender).Tag]) do
    OpenFile(FileName,FilerID,True);
end;

{------------------------------------------------------------------}

function IntToHotChar(I:Integer):Char;
begin
  case I of
    0..9:
      Result:=Char(i+48);
    10..35:
      Result:=Char(i-10+65);
  else
    Result:=#0;
  end;
end;

{------------------------------------------------------------------}

function TRecentInfos.AddToRecentMenu(
            MenuItem:TMenuItem;AInfoKind:TRecentInfoKind;OnClick:TNotifyEvent;StartHotKey:Integer):Integer;
Var
  i:Integer;
  Item:TMenuItem;
  ShortCut:String;

begin
  Result:=StartHotKey;
  If MenuItem=nil then
    exit;
  for i:=Count-1 downto 0 do
    With TRecentInfo(Items[i]) do
      if InfoKind=AInfoKind then
      begin
        ShortCut:=IntToHotChar(Result);

        If ShortCut<>#0 then
          ShortCut:='&'+ShortCut+' ';

        Item:=NewItem(ShortCut+FileName,0,
          False,True, OnClick,0,'');
        Item.Tag:=i;
        MenuItem.Add(Item);
        inc(Result);
      end;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.UpdateRecentFilesMenu;
Var
  StartHotKey:Integer;
begin
  If FRecentFiles=nil then
    exit;
  ClearMenuSubItems(FRecentFiles,False);
  StartHotKey:=FRecentInfos.AddToRecentMenu(FRecentFiles,rkProject,RecentMenuOnClick,0);
  FRecentFiles.Add(NewLine);
  FRecentInfos.AddToRecentMenu(FRecentFiles,rkFile,RecentMenuOnClick,StartHotKey);
  RemoveExtraMenuSeparators(FRecentFiles);
  FRecentFiles.Enabled:=FRecentFiles.Count>0;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.RecentInfosChanged;
begin
  UpdateRecentFilesMenu;
  UpdateRecentSpacesMenu;
end;

{------------------------------------------------------------------}

procedure TCustomIDEProject.InternalCreate(const FileName:TFileName; const FilerID:TFilerID);
begin
  inherited;
  FProjectItems:=TIDEProjectItems.Create(Self,TIDEProjectItem);
  SetModifiedTrue;
end;

{------------------------------------------------------------------}

destructor TCustomIDEProject.Destroy;
begin
  FProjectItems.Free;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomIDEProject.RemoveFromProject(IDEObject:TIDEObject);
begin
  FProjectItems.RemoveObject(IDEObject);
end;

{------------------------------------------------------------------}

procedure TCustomIDEProject.FillProjectIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  If (TIDEObject(Item).WasSaved) and (not TIDEObject(Item).Closed) then
    AddToProject(TIDEObject(Item));
end;

{------------------------------------------------------------------}

procedure TCustomIDEProject.AddToProject(IDEObject:TIDEObject);
begin
  If (IDEObject=self) or (IDEObject=nil) or (FProjectItems.IndexOfObject(IDEObject,False)>=0)
     or (IDEObject is TIDEWorkSpace)

// this is tmprorary, just "projects in projects" not implemented
     or ((IDEObject is TCustomIDEProject) and (not (Self is TIDEWorkSpace)))
  then
    exit;

  if (StrictWithNames) and (ProjectItemByShortName(IDEObject.ObjectName)<>nil) then
    ErrorFmt(SErrAlreadyInProject,[IDEObject.ObjectName]);

  FProjectItems.AddObject(IDEObject);
  SetModifiedTrue;
end;

{------------------------------------------------------------------}

procedure TCustomIDEProject.ClearProject;
begin
  FProjectItems.Clear;
  SetModifiedTrue;
end;

{------------------------------------------------------------------}

procedure TCustomIDEProject.FillProjectItems(IDEObject:TCompoundIDEObject);
begin
  ClearProject;
  If IDEObject<>nil then
    ForEachListItem(IDEObject.FObjectList,FillProjectIterator);
end;

{------------------------------------------------------------------}

procedure TIDEObjectList.MakePathsRelative(const AFileName:String; const AFilerID:string);
Var
  i:Integer;
  BaseName:String;
begin
  BaseName:=ExtractFilePath(AFileName);
  for i:=0 to Count-1 do
    With TIDEProjectItem(Items[i]) do
      If FilerID=AFilerID then
        FileName:=ExtractRelativePath(BaseName,FileName);
end;

{------------------------------------------------------------------}

{procedure TIDEObject.BeforeClose;
begin
end;}

{------------------------------------------------------------------}

function TIDEObject.GetVisible:boolean;
begin
  Result:=False;
end;

{------------------------------------------------------------------}

procedure TIDEObject.SetVisible(Value:boolean);
begin
  If Visible<>Value then
  begin
    If Value then
      SetFocused
    else
      Hide;
  end;
end;

{------------------------------------------------------------------}

procedure TIDEObject.SetFocusedValue(Value:boolean);
begin
  If Value then
    SetFocused;
end;

{------------------------------------------------------------------}

procedure TIDEObject.Hide;
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.Show;
begin
  SetFocused;
end;

{------------------------------------------------------------------}

function TIDEObject.GetObjectParams:TIDEObjectParams;
begin
  Result:=[];
end;

{------------------------------------------------------------------}

procedure TIDEObject.SetModifiedFalse;
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.CreateFromStream(Stream:TStream);
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.SetFocused;
begin
end;

{------------------------------------------------------------------}

function TIDEObject.GetModified:boolean;
begin
  Result:=False;
end;

{------------------------------------------------------------------}

function TIDEObject.GetFocused:boolean;
begin
  Result:=False;
end;

{------------------------------------------------------------------}

procedure TIDEObject.UseObjects(ObjectList:TList);
begin
end;

{------------------------------------------------------------------}

function TIDEObject.CanUseObject(IDEObject:TIDEObject):boolean;
begin
  Result:=False;
end;

{------------------------------------------------------------------}

procedure TIDEObject.GetUsedObjects(UsedObjects:TStrings);
begin
  UsedObjects.Clear;
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.SetRecentFiles(Value:TMenuItem);
begin
  If FRecentFiles<>Value then
  begin
    ClearMenuSubItems(FRecentFiles,False);
    FRecentFiles:=Value;
    If Value<>nil then
      Value.FreeNotification(self);
    UpdateRecentFilesMenu;
  end;
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.SetRecentSpaces(Value:TMenuItem);
begin
  If FRecentSpaces<>Value then
  begin
    ClearMenuSubItems(FRecentSpaces,False);
    FRecentSpaces:=Value;
    If Value<>nil then
      Value.FreeNotification(self);
    UpdateRecentSpacesMenu;
  end;
end;

{------------------------------------------------------------------}

procedure TInstantReport.InternalCreate(const FileName:TFileName; const FilerID:TFilerID);
begin
  inherited;
  If (FMainObject=nil) then
    FMainObject:=Self;
  FWorkSpace:=TIDEWorkSpace.CreateNew(DefaultWorkSpaceName,'',0);
  FWorkSpace.FOwnerObject:=Self;
end;

{------------------------------------------------------------------}

procedure TIDEObjectList.MakePathsAbsolute(const AFileName:String; const AFilerID:string);
Var
  i:Integer;
begin
  for i:=0 to Count-1 do
    with TIDEProjectItem(Items[i]) do
      if FilerID = AFilerID then
        FileName := ExpandRelativeFileName(AFileName, FileName, AFilerID)
end;

{------------------------------------------------------------------}

function TCustomIDEProject.OpenProjectItems(IDEObject:TCompoundIDEObject;
            AllObjects:boolean):boolean;
Var
  i:Integer;
  OModified:boolean;
begin
  IDEBeginUpdate;
  OModified:=FModified;
  try
    Result:=False;
    With FProjectItems do
      for i:=0 to Count-1 do
        With TIDEProjectItem(Items[i]) do
           If ObjectOpened or AllObjects then
           begin
             IDEObject.OpenFile(FileName,FilerID,True);
             Result:=true;
           end;
  finally
    FModified:=OModified;
    IDEEndUpdate;
  end;
end;

{------------------------------------------------------------------}

function FilerFileExists(const FilerID:TFilerID;const Filename:TFileName):boolean;
Var
  FileSystem:TFileSystem;
begin
  result:=False;
  FileSystem:=GetFileSystem(FilerID);
  If FileSystem=nil then
    exit;
  try
    Result:=FileSystem.FileExists(FileName);
  finally
    ReleaseFileSystem(FileSystem);
  end;
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}
procedure TInstantReport.CMBEFOREPACKAGEUNLOAD(Var M:TMessage);
begin
  DesignerInsertClass:='';
  If not CloseAll then
    M.Result:=1;
end;
{$ENDIF}
{------------------------------------------------------------------}

function TCustomOpenIDEObject.OpenFrom(const FileName:TFileName;
                  const FilerID:TFilerID):TIDEObject;
begin
  Result:=GetIDEObjectClass.CreateFrom(FileName,FilerID);
end;

{------------------------------------------------------------------}

procedure CommandLineToStrings(S:TStrings);
Var
  i:Integer;
begin
  With S do
  begin
    BeginUpdate;
    Clear;
    for i:=1 to ParamCount do
      S.Add(ParamStr(i));
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.GetVisibleIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  Continue:=not TIDEObject(Item).Visible;
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.GetVisible:boolean;
begin
  Result:=not ForEachListItem(FObjectList,GetVisibleIterator);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.HideIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  TIDEObject(Item).Hide;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.Hide;
begin
  ForEachListItem(FObjectList,HideIterator);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.SetModifiedFalseIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  TIDEObject(Item).SetModifiedFalse;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.SetModifiedFalse;
begin
  ForEachListItem(FObjectList,SetModifiedFalseIterator);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.GetModifiedDuringOpenIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  Continue:=not TIDEObject(Item).ModifiedDuringOpen;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.GetModifiedIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  Continue:=not TIDEObject(Item).Modified;
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.GetModified:boolean;
begin
  Result:=not ForEachListItem(FObjectList,GetModifiedIterator);
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.GetFocused:boolean;
begin
  Result:=ActiveObject<>nil;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.AddObject(IDEObject:TIDEObject);
begin
  If Assigned(IDEObject) then
    IDEObject.AddTo(Self);
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.ActiveObjectIndex:Integer;
begin
  Result:=FObjectList.IndexOf(ActiveObject);
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.IsActiveCompound:boolean;
begin
  Result:=(ActiveObject is TCompoundIDEObject) and
    (TCompoundIDEObject(ActiveObject).ObjectCount>1);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.CompoundNextObject;
begin
  If ActiveObject is TCompoundIDEObject then
    TCompoundIDEObject(ActiveObject).NextObject;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.CompoundPreviousObject;
begin
  If ActiveObject is TCompoundIDEObject then
    TCompoundIDEObject(ActiveObject).PreviousObject;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.ChangeActiveObject(ANext:Boolean);
Var
  i:Integer;
begin
  I:=ActiveObjectIndex;

  If i=-1 then
    exit;

  If ANext then
    inc(i)
  else
    dec(i);

  If i<0 then
    i:=ObjectCount-1
  else
  If i>=ObjectCount then
    i:=0;

  Objects[I].SetFocused;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.PreviousObject;
begin
  ChangeActiveObject(False);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.NextObject;
begin
  ChangeActiveObject(True);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.OpenFiles(FileNames:TStrings;const FilerID:TFilerID);
var
  i:Integer;
begin
  for i:=0 to FileNames.Count-1 do
    OpenFile(FileNames[i],FilerID,True);
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.OpenWin32File(const FileName:String):TIDEObject;
begin
  Result:=OpenFile(FileName,'',True);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.OpenWin32Files(FileNames:TStrings);
begin
  OpenFiles(FileNames,'');
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.OpenCommandLineFiles;
Var
  S:TStringList;
begin
  S:=TStringList.Create;
  try
    CommandLineToStrings(S);
    OpenWin32Files(S);
  finally
    S.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.RemoveRecentInfo(IDEObject:TIDEObject);
begin
  FRecentInfos.RemoveObject(IDEObject);
  RecentInfosChanged;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.AddRecentInfo(IDEObject:TIDEObject);
begin
  If (IDEObject=nil) or (opNoRecentFile in IDEObject.GetObjectParams) then
    exit;
  If FRecentInfos.AddObject(IDEObject)<>nil then
    DeleteExtraRecentItems(FRecentInfos,FMaxRecent-1);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  If Operation=opRemove then
  begin
    If FRecentSpaces=AComponent then
      RecentWorkSpacesMenu:=nil else
    If FRecentFiles=AComponent then
      RecentFilesMenu:=nil else
    If (AComponent is TIDEObject) and (FObjectList<>nil) then
    begin
      If FActiveProject=AComponent then
        ActiveProject:=nil;
      FObjectList.Remove(AComponent);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.CutToClipboard;
begin
  If ActiveObject<>nil then
    ActiveObject.CutToClipboard;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.PasteFromClipboard;
begin
  If ActiveObject<>nil then
    ActiveObject.PasteFromClipboard;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.CopyToClipboard;
begin
  If ActiveObject<>nil then
    ActiveObject.CopyToClipboard;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.DeleteSelection;
begin
  If ActiveObject<>nil then
    ActiveObject.DeleteSelection;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.SelectAll;
begin
  If ActiveObject<>nil then
    ActiveObject.SelectAll;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.Undo;
begin
  If ActiveObject<>nil then
    ActiveObject.Undo;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.Redo;
begin
  If ActiveObject<>nil then
    ActiveObject.Redo;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.BrowseProperties;
begin
  If ActiveObject<>nil then
    ActiveObject.BrowseProperties;
end;

{------------------------------------------------------------------}

procedure TIDEObject.BrowseProperties;
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.CutToClipboard;
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.PasteFromClipboard;
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.CopyToClipboard;
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.DeleteSelection;
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.SelectAll;
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.Undo;
begin
end;

{------------------------------------------------------------------}

procedure TIDEObject.Redo;
begin
end;

{------------------------------------------------------------------}

procedure TSaveWithBackup.SaveProc(const FileName:TFileName;
                  const FilerID:TFilerID);
Var
  FileSystem:TFileSystem;

  procedure SaveToFile(const FileName:String);
  var
    Stream:TStream;
  begin
    With FileSystem do
    begin
      Stream:=GetFileStream(FileName,fmCreate);
      try
        SaveToStream(Stream);
      finally
        Stream.Free;
      end;
    end;
  end;

  procedure FullSave;
  Var
    TempFileName:String;
    BackFileName:String;
  begin
    With FileSystem do
    begin
      TempFileName:=GetTempFileName(FileName);
      SaveToFile(TempFileName);
      BackFileName:=GetBackupFileName(FileName);

      DeleteFileExcept(BackFileName);

      If FileExists(FileName) then
        RenameFileExcept(FileName,BackFileName);

      RenameFileExcept(TempFileName,FileName);
    end;
  end;

begin
  FileSystem:=GetFileSystem(FilerID);
  try
    If FileSystem.IsReadonly(FileName) then
      raise Exception.CreateFmt(SErrReadOnlyFile,[FileName]);

    Case FileSystem.GetFileSystemLevel of
      flFullSupport:
         FullSave;
      flOnlyGetStream:
         SaveToFile(FileName);
    end;
  finally
    ReleaseFileSystem(FileSystem);
  end;
end;

{-------------------------------------------------------------------------}

function SaveTypesToFilter(SaveTypes:TStrings):String;
Var
  i:Integer;
begin
  Result:='';
  for i:=0 to SaveTypes.Count-1 do
  begin
    If i>0 then
      Result:=Result+'|';
    Result:=Result+SaveTypes[i]
  end;
end;

{-------------------------------------------------------------------------}

function DefaultOpenQuery(FileNames:TStrings;var FilerID:TFilerID;
           OpenTypes:TStrings;var OpenClass:TOpenObjectClass):boolean;
begin
  Result:=False;
  with TOpenDialog.Create(nil) do
    try
      Options := [{$IFNDEF CLX}ofHideReadOnly,{$ENDIF} ofPathMustExist, ofFileMustExist, ofAllowMultiSelect];
      FilerID:='';
      {$IFNDEF CLX}
      Filter:=SaveTypesToFilter(OpenTypes);
      FilterIndex:=OpenTypes.Count;
      InitialDir:=Win32FileSystem.CurrentDir;
      {$ENDIF}
      if Execute then
      begin
        If (FilterIndex<OpenTypes.Count) and (Files.Count=1) then
          OpenClass:=TOpenObjectClass(OpenTypes.Objects[FilterIndex-1]);
        FileNames.Assign(Files);
        Result:=True;
      end;
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

function GetDefaultSaveType(const FileName:String; SaveTypes:TStrings):Integer;
Var
  i:Integer;
  Ext:String;

begin
  Ext:=AnsiUpperCase('*'+ExtractFileExt(FileName));
  for i:=0 to SaveTypes.Count-1 do
    if Pos(Ext,AnsiUpperCase(SaveTypes[i]))<>0 then
    begin
      Result:=i;
      exit;
    end;
  Result:=0;
end;

{-------------------------------------------------------------------------}

function CopyBetween(const S,BegStr,EndStr:String):String;
Var
  EndPos,BegPos:Integer;
begin
  Result:='';
  BegPos:=Pos(BegStr,S);
  EndPos:=Pos(EndStr,S);
  If (BegPos=0) or (EndPos=0) or (EndPos<BegPos) then
    exit;
  Result:=Copy(S,BegPos,EndPos-BegPos);
end;

{-------------------------------------------------------------------------}

function DefaultSaveAsQueryEx(var AFileName:String;var FilerID:TFilerID;
           SaveTypes:TStrings; const DialogTitle: string):TSaveObjectClass;
var
  i:Integer;
begin
  Result:=nil;
  with TSaveDialog.Create(nil) do
    try
      if DialogTitle <> '' then
        Title := DialogTitle;
      FileName:=AFileName;
      Options:=[ofOverwritePrompt,{$IFNDEF CLX}ofHideReadOnly,{$ENDIF}ofPathMustExist];
      FilerID:='';

      {$IFNDEF CLX}
      Filter:=SaveTypesToFilter(SaveTypes);
      FilterIndex:=GetDefaultSaveType(AFileName,SaveTypes)+1;
      {$ENDIF}

      if Execute then
      begin
        i:=FilterIndex-1;
        Result:=TSaveObjectClass(SaveTypes.Objects[i]);
        AFileName:=FileName;
        if ExtractFileExt(AFileName)='' then
          AddStr(AFileName,CopyBetween(SaveTypes[i],'.',')'));
      end;
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CloseActive:boolean;
begin
  Result:=CloseObject(ActiveObject);                 
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.CloseAllWithoutQuestion;
begin
  IDEBeginUpdate;
  try
    try
      SaveWorkSpace;
    except
    end;
    ReleaseObjects;
  finally
    IDEEndUpdate;
  end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CloseAll:boolean;
begin
  IDEBeginUpdate;
  try
    Result:=SaveAllWithQuestion;
    If not Result then
      exit;
    try
      SaveWorkSpace;
    except
    end;
    ReleaseObjects;
  finally
    IDEEndUpdate;
  end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveWithQuestion(IDEObject:TIDEObject):boolean;
Var
  DlgResult : Integer;
  AButtons  : TMsgDlgButtons;
begin
  If (IDEObject=nil) or (IDEObject.Closed) then
  begin
    Result:=True;
    exit;
  end;

  With IDEObject do
  begin
    Result:=not Modified;
    If Result=False then
    begin
      AButtons := [mbYes,mbNo,mbCancel];

      {$IFNDEF CLX}
      if FNeedSaveAll then
        include(AButtons, mbAll);
      {$ENDIF}

      if FNeedSaveAll and FSaveAll then
        DlgResult := mrYes
      else
        DlgResult:=MessageDlg(Format(SSaveChanges,[IDEObject.DisplayName]),{$IFDEF CLX}mtWarning{$ELSE}mtConfirmation{$ENDIF}, AButtons, 0);

      case DlgResult of
        mrYes:
          Result:=SaveObject(IDEObject);
        mrNo:
          Result:=True;
        mrCancel:
          Result:=False;
        mrAll :
        begin
          FSaveAll := true;
          Result:=SaveObject(IDEObject);
        end;
      end;
      FSaveAll := FSaveAll and Result;
    end;
  end;
end;

{-------------------------------------------------------------------------}

procedure TIDEObject.SetClosed(Value:boolean);
begin
  If FClosed<>Value then
  begin
    FClosed:=Value;
    If FClosed then
      Hide;
  end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.IsObjectUsed(IDEObject:TIDEObject):boolean;
var
  i:integer;
  RefObjects:TList;
begin
  RefObjects:=TList.Create;
  try
    for i:=ObjectCount-1 downto 0 do
      if (Objects[i]<>IDEObject) and (not Objects[i].Closed) then
      begin
        Objects[i].GetReferencedObjects(RefObjects);
        If RefObjects.IndexOf(IDEObject)>=0 then
        begin
          Result:=True;
          exit;
        end;
      end;
    Result:=False;
  finally
    RefObjects.Free;
  end;
end;

{-------------------------------------------------------------------------}

procedure TIDEObject.GetReferencedObjects(RefObjects:TList);
begin
  RefObjects.Clear;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CloseObject(IDEObject:TIDEObject):boolean;
begin
  Result:=False;
  If IDEObject=nil then
   exit;

  IDEBeginUpdate;
  try

    If IDEObject.Closed then
    begin
      Result:=True;
      exit;
    end;

    If IDEObject is TCustomIDEProject then
    begin
      Result:=CloseProject(TCustomIDEProject(IDEObject));
      exit;
    end;

    Result:=False;
    If not CanCloseObject(IDEObject) then
      exit;
    Result:=SaveWithQuestion(IDEObject);
    If Result then
      IDEObject.Closed:=True;
  finally
    FixupClosedObjects;
    IDEEndUpdate;
  end;
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.FixupClosedObjects;

  function FixupObject:boolean;
  Var
    i:Integer;
  begin
    Result:=False;
    for I:=ObjectCount-1 downto 0 do
      if Objects[i].Closed and ((not Objects[i].WasSaved) or
        (not IsObjectUsed(Objects[i]))) then
      begin
        Result:=True;
        Objects[i].RemoveFrom(Self);
      end;
  end;

begin
  While FixupObject do;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CanCloseObject(IDEObject:TIDEObject):boolean;
begin
  Result:=(IDEObject<>nil) and (IDEObject.CanClose);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CanCloseAll:boolean;
begin
  Result:=FObjectList.Count>0;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveAsQuery(var FileName:String;var FilerID:TFilerID;
           SaveTypes:TStrings):TSaveObjectClass;
begin
  Result := SaveAsQueryEx(FileName,FilerID,SaveTypes,'');
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveAsQueryEx(var FileName:String;var FilerID:TFilerID;
           SaveTypes:TStrings; const DialogTitle: string):TSaveObjectClass;
begin
  If Assigned(OnSaveAsQuery) then
    OnSaveAsQuery(FileName,FilerID,SaveTypes,Result)
  else
    Result:=DefaultSaveAsQueryEx(FileName,FilerID,SaveTypes, DialogTitle)
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.OpenQuery(FileNames:TStringS;var FilerID:TFilerID;
           OpenTypes:TStrings;var OpenClass:TOpenObjectClass):boolean;
begin
  If Assigned(OnOpenQuery) then
    OnOpenQuery(FileNames,FilerID,OpenTypes,OpenClass,Result)
  else
    Result:=DefaultOpenQuery(FileNames,FilerID,OpenTypes,OpenClass);
end;

{--------------------------------------------}

function NormalizeExtension(Const Extension:String):String;
Var
  S:TStringList;
  i:Integer;
begin
  S:=TStringList.Create;
  Result:='';
  With S do
    try
      Sorted:=True;
      Duplicates:=DupIgnore;
      CommaText:=Extension;
      For i:=0 to Count-1 do
        If S[i]<>'' then
        begin
          If result<>'' then
            Result:=Result+';';
          Result:=Result+'*.'+S[i];
        end;
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

function TIDEObject.CanClose:boolean;
begin
  Result:=True;
end;

{-------------------------------------------------------------------------}

function TIDEObject.ValidObjectName(const ObjName:String):boolean;
begin
  Result:=True;
end;

{-------------------------------------------------------------------------}

function TIDEObject.GetDefaultSaveClass:TSaveObjectClass;
begin
  Result:=nil;
end;

{-------------------------------------------------------------------------}

function TIDEObject.ExportTo(const FileName:TFileName; const FilerID:TFilerID;
            SaveClass:TSaveObjectClass):boolean;
Var
  SaveObject:TSaveObject;
begin
  Result:=false;
  If FileName='' then
    exit;
  If SaveClass=nil then
    SaveClass:=FSaveClass;
  If SaveClass=nil then
    SaveClass:=GetDefaultSaveClass;
  If SaveClass=nil then
    raise Exception.Create(SErrCantSaveObject);

  SaveObject:=SaveClass.Create(Self);
  try
    SaveObject.SaveProc(FileName,FilerID);
  finally
    SaveObject.Free;
  end;
  Result:=true;
end;

{-------------------------------------------------------------------------}

function TIDEObject.SaveTo(const FileName:TFileName; const FilerID:TFilerID;SaveClass:TSaveObjectClass):boolean;
begin
  ExportTo(FileName, FilerID, SaveClass);

  SetModifiedFalse;
  FOldFilename:=FFileName;
  FOldFilerID:=FFilerID;
  FFilerID:=FilerID;
  FFileName:=FileName;
  FSaveClass:=SaveClass;
  FWasSaved:=True;
  BroadCastToNotifiers(Self,CM_IDESAVETO,Integer(Self),0);
  Result := true;
end;

{------------------------------------------------------------------}

function FindOpenClass(const FileName:String):TOpenObjectClass;
begin
  Result:=TOpenObjectClass(GetClassEx(TOpenObject,[SOpenExtension],[
    ','+RemoveCharSet(['.'],ExtractFileExt(FileName))+','],[cpPartialCompare,cpIgnoreCase]));
  if Result = nil then
    Result := TOpenObjectClass(GetClassEx(TOpenObject,[SOpenExtension],[',*,'],[cpPartialCompare,cpIgnoreCase]));

end;

{------------------------------------------------------------------}

function TCompoundIDEObject.OpenFile(const FileName:String;
           const FilerID:TFilerID;ASetVisible:boolean):TIDEObject;
begin
  Result:=OpenFileAs(FileName,FilerID,FindOpenClass(FileName),ASetVisible);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.CloseWithClassIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  if TObject(Item) is FIDEClass then
    Continue:=CloseObject(TIDEObject(Item));
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.FindObjectWithClass(IDEClass:TIDEObjectClass):TIDEObject;
var
  i:Integer;
begin
  for I:=0 to ObjectCount-1 do
    if Objects[i] is IDEClass then
    begin
      Result:=Objects[i];
      exit;
    end;
  Result:=nil;
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.CloseObjectsWithClass(IDEClass:TIDEObjectClass):boolean;
begin
  FIDEClass:=IDEClass;
  Result:=ForEachListItem(FObjectList,CloseWithClassIterator);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.FixupIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  TIDEObject(Item).FixupReferences;
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.FixupReferences;
begin
  ForEachListItem(FObjectList,FixupIterator);
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.OpenFileAs(const FileName:String;
            const FilerID:TFilerID;OpenClass:TOpenObjectClass;ASetVisible:boolean):TIDEObject;
Var
  OpenObject:TOpenObject;
  OModified:boolean;
  i:Integer;

  procedure ShowResult;
  begin
    If (Result<>nil) and (ASetVisible) then
      Result.Show;
  end;

  procedure FixupObjects;
  var
    IDEObject:TIDEObject;
  begin
    With FFixupList do
    begin
      i:=0;
      try
        while i<Count do
        begin
          With TIDEProjectItem(Items[i]) do
            If (Self.ObjectByFileName(FileName,FilerID)=nil) and (not ObjectOpened) then
            begin
              ObjectOpened:=True;
              IDEObject:=OpenFile(FileName,FilerID,False);
              If IDEObject<>nil then
                IDEObject.Closed:=True;
            end;
          Result.FixupReferences;
          inc(i);
        end;
        If FFixUplist.AllObjectsOpened then
          FFixupList.Clear;
      except
        FFixupList.Clear;
        raise;
      end;
    end;
  end;
begin
  IDEBeginUpdate;
  try
  try
    Result:=ObjectByFileName(FileName,FilerID);
    If Result=Self then
    begin
      ShowResult;
      exit;
    end;
    If (Result=nil) or (opNoSmartOpen in Result.GetObjectparams) then
    begin
      Result:=nil;
      If (OpenClass<>nil) and (Trim(FileName)<>'') and
          (FilerFileExists(FilerID,FileName)) then
      begin
        OpenObject:=OpenClass.Create(Self);
        try
          Result:=OpenObject.OpenFrom(FileName,FilerID);
        finally
          OpenObject.Free;
        end;

        If (Result<>nil) and (not Result.ModifiedDuringOpen) then
          Result.SetModifiedFalse;
      end;
    end;
    If Result<>nil then
    begin
      AddObject(Result);
      OModified:=Result.Modified;
      try
        FixupObjects;
      finally
        ShowResult;
        Result.Closed:=False;
        If (not OModified) and (not Result.ModifiedDuringOpen) then
          Result.SetModifiedFalse;
      end;
    end;
  finally
    IDEEndUpdate;
  end;
  except
    if ExceptObject.ClassType<>TSkipException then
      raise;
  end;
end;

{
  This code checks if IDEObject can be only single!
If OpenObject is TOpenIDEObject then
begin
  IDEClass:=TOpenIDEObject(OpenObject).GetIDEObjectClass;
  if opCanBeOnlyOne in IDEClass.GetObjectParams then
    if not CloseObjectsWithClass(IDEClass) then
      exit;
end;}

{------------------------------------------------------------------}

function TCompoundIDEObject.Open:TIDEObject;
begin
  Result:=OpenLimitedType(nil);
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.OpenLimitedType(OpenClass:TOpenObjectClass):TIDEObject;
Var
  OpenTypes:TStringList;
begin
  OpenTypes:=TStringList.Create;
  try
    GetOpenTypes(OpenClass,OpenTypes);
    Result:=OpenLimited(OpenTypes);
  finally
    OpenTypes.Free;
  end;
end;

{------------------------------------------------------------------}

function TCompoundIDEObject.OpenLimited(OpenTypes:TStrings):TIDEObject;
Var
  AFileSystem:TFilerID;
  OpenClass:TOpenObjectClass;
  FileNames:TStringList;
begin
  Result:=nil;
  FileNames:=TStringList.Create;
  try
    AFileSystem:=DefaultFileSystem;
    OpenClass:=nil;
    If OpenQuery(FileNames,AFileSystem,OpenTypes,OpenClass) then
    begin
      If (OpenClass<>nil) and (FileNames.Count=1) then
        Result:=OpenFileAs(FileNames[0],AFileSystem,OpenClass,True)
      else
        If FileNames.Count=1 then
          Result:=OpenFile(FileNames[0],AFileSystem,True)
        else
          OpenFiles(FileNames,AFileSystem);
    end;
  finally
    FileNames.Free;
  end;
end;

{-------------------------------------------------------------------------}

procedure FilerChangeDir(const FilerID:TFilerID;const NewDir:String);
Var
  F:TFileSystem;
begin
  F:=GetFileSystem(FilerID);
  try
    F.CurrentDir:=NewDir;
  finally
    ReleaseFileSystem(F);
  end;
end;

{-------------------------------------------------------------------------}

function FilerGetDir(const FilerID:TFilerID):String;
Var
  F:TFileSystem;
begin
  F:=GetFileSystem(FilerID);
  try
    Result:=F.CurrentDir;
  finally
    ReleaseFileSystem(F);
  end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.UnivSaveObject(IDEObject:TIDEObject;
      Method: TSaveMethod; const DialogTitle: string):boolean;
var
  AFileName:String;
  AFileSystem:TFilerID;
  SaveTypes:TStringList;
  SaveClass:TSaveObjectClass;
  TempStr:String;
begin
  Result:=False;
  If (IDEObject=nil) {or (not IDEObject.CanBeSaved)} then
    exit;
  With IDEObject do
  begin
    AFileName:=FileName;
    AFileSystem:=FilerID;

    SaveTypes:=TStringList.Create;
    try
      GetSaveTypes(TIDEObjectClass(IDEObject.ClassType),SaveTypes);

      If SaveTypes.Count=0 then
        raise Exception.Create(SErrCantSaveObject);

      If not WasSaved then
        AFileName:=AddSlash(FilerGetDir(FilerID))+ExtractFileName(AFileName);
      if DialogTitle = '' then
        SaveClass:=SaveAsQuery(AFileName,AFileSystem,SaveTypes)
      else
        SaveClass:=SaveAsQueryEx(AFileName,AFileSystem,SaveTypes, DialogTitle);
      If Assigned(SaveClass) then
      begin
        TempStr:=ExtractOnlyName(AFileName);
        If Not IDEObject.ValidObjectName(TempStr) then
          raise Exception.CreateFmt(SNotValidIdent,[TempStr]);
        FilerChangeDir(AFileSystem,ExtractFilePath(AFileName));

        Result:= Method(AFileName,AFileSystem,SaveClass);
      end;
    finally
      SaveTypes.Free;
    end;
  end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveObjectAs(IDEObject:TIDEObject):boolean;
begin
  Result := UnivSaveObject(IDEObject, IDEObject.SaveTo, '');
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.ExportObjectTo(IDEObject:TIDEObject):boolean;
begin
  Result := UnivSaveObject(IDEObject, IDEObject.ExportTo, SExportToTitle);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveObject(IDEObject:TIDEObject):boolean;
begin
  Result:=True;
  If not CanSaveObject(IDEObject) then
    exit;

  With IDEObject do
  begin
    If not WasSaved then
      Result:=SaveObjectAs(IDEObject)
    else
      Result:=SaveTo(FileName,FilerID,nil);
  end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveActiveAs:boolean;
begin
  Result:=SaveObjectAs(ActiveObject);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.ExportActiveTo:boolean;
begin
  Result:=ExportObjectTo(ActiveObject);
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.SaveAllQuestionIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  Continue:=SaveWithQuestion(TIDEObject(Item));
end;

{-------------------------------------------------------------------------}

procedure FilterProjects(FromList,ToList:TList;InclProjects:boolean);
Var
  i:Integer;
begin
  ToList.Clear;
  for i:=0 to FromList.Count-1 do
    if (TObject(FromList[i]) is TCustomIDEProject)=InclProjects then
      ToList.Add(FromList[i]);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.DoWithObjects(List:TList;Iterator:TListIteratorProc):boolean;
Var
  FList:TList;
begin
  FList:=TList.Create;
  IDEBeginUpdate;
  try
    FilterProjects(List,FList,False);
    Result:=ForEachListItem(FList,Iterator);
    IF not Result then
      exit;
    FilterProjects(List,FList,True);
    Result:=ForEachListItem(FList,Iterator);
  finally
    FList.Free;
    IDEEndUpdate;
  end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveAllWithQuestion:boolean;
begin
  FNeedSaveAll := true;
  FSaveAll := false;
  try
    Result:=DoWithObjects(FobjectList,SaveAllQuestionIterator);
  finally
    FNeedSaveAll := false; 
  end;
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.SaveAllIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  Continue:=SaveObject(TIDEObject(Item));
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveObjList(List:TList):boolean;
begin
  IDEBeginUpdate;
  try
    Result:=(not CanSaveObjList(List)) or DoWithObjects(List,SaveAllIterator);
    If Result and (List=FObjectList) then
      SaveWorkSpace;
  finally
    IDEEndUpdate;
  end;
end;          


{-------------------------------------------------------------------------}

function TCustomIDEProject.SaveProjectFiles:boolean;
var
  i:Integer;
  List:TList;
  RObject:TIDEObject;
begin
  List:=TList.Create;
  try
    With FProjectItems do
      for i:=0 to Count-1 do
      begin
        RObject:=Items[i].RelatedObject;
        If RObject<>nil then
          List.Add(RObject);
      end;
      List.Add(Self);
      Result:=MainIDEObject.SaveObjList(List);
  finally
    List.Free;
  end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveAll:boolean;
begin
  Result:=SaveObjList(FObjectList);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveActive:boolean;
begin
  Result:=SaveObject(ActiveObject);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CanSaveObject(IDEObject:TIDEObject):boolean;
begin
  Result:=(IDEObject<>nil) and (IDEObject.Modified) and (not IDEobject.Closed)

  {and (IDEObject.CanBeSaved)};
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CanSaveActive:boolean;
begin
  Result:=CanSaveObject(ActiveObject);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CanCloseActive:boolean;
begin
  Result:=CanCloseObject(ActiveObject);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CanSaveObjList(List:TList):boolean;
Var
  i:Integer;
begin
  With List do
    for i:=0 to Count-1 do
      if CanSaveObject(Items[i]) then
      begin
        Result:=True;
        exit;
      end;
  Result:=False;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CanSaveAll:boolean;
begin
  Result:=CanSaveObjList(FObjectList);
end;

{-------------------------------------------------------------------------}

function TCustomIDEProject.ProjectItemByShortName(const ShortName:String):TIDEProjectItem;
Var
  i:Integer;
begin
  With FProjectItems do
    for i:=0 to Count-1 do
      if CompareText(TIDEProjectItem(Items[i]).ShortName,ShortName)=0 then
      begin
        Result:=TIDEProjectItem(Items[i]);
        exit;
      end;
  Result:=nil;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.ProjectItemByShortName(const ShortName:String):TIDEProjectItem;
Var
  i:Integer;
begin
  for i:=0 to ObjectCount-1 do
    if Objects[i] is TCustomIDEProject then
    begin
      Result:=TCustomIDEProject(Objects[i]).ProjectItemByShortName(ShortName);
      If Result<>nil then
        exit;
    end;
  Result:=nil;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.UniqueObjectNumber(const BaseName:String):Integer;
var
  i : integer;
  CheckName:String;
begin
  i := 0;
  repeat
    inc(i);
    result := i;
    CheckName:=BaseName+IntToStr(Result);
  until (ObjectByName(CheckName) = nil) and
        (ProjectItemByShortName(CheckName)=nil);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.UniqueObjectName(const BaseName:String):String;
begin
  Result:=BaseName+IntToStr(UniqueObjectNumber(BaseName));
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.ObjectByFileName(const FileName:TFileName;const FilerID:TFilerID):TIDEObject;
Var
  i:Integer;
begin
  With FObjectList do
    for i:=0 to Count-1 do
      If (CompareText(Objects[i].FileName,FileName)=0) and
         (FilerID=Objects[i].FilerID) then
        begin
          Result:=Objects[i];
          exit;
        end;
  Result:=nil;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.ObjectByName(const ObjectName:String):TIDEObject;
Var
  i:Integer;
begin
  With FObjectList do
    for i:=0 to Count-1 do
      If CompareText(Objects[i].ObjectName,ObjectName)=0 then
        begin
          Result:=Objects[i];
          exit;
        end;
  Result:=nil;
end;

{-------------------------------------------------------------------------}

function TIDEObject.GetDisplayName:String;
begin
  Result:=FileName;
end;

{-------------------------------------------------------------------------}

function TIDEObject.GetFileExt:String;
begin
  Result:=RemoveStrSet('.',ExtractFileExt(FileName),False);
end;

{-------------------------------------------------------------------------}

function TIDEObject.GetObjectName:String;
begin
  Result:=ExtractOnlyName(FileName);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.GetActiveObject:TIDEObject;
Var
  i:Integer;
begin
  With FObjectList do
  begin
    i:=Count-1;
    While i>=0 do
    begin
      if TIDEObject(Items[i]).Focused then
      begin
        Result:=TIDEObject(Items[i]);
        exit;
      end;
      i:=Min(Count,i);
      dec(i);
    end;
  end;
  Result:=nil;
end;

{-------------------------------------------------------------------------}

destructor TCompoundIDEObject.Destroy;
begin
  ReleaseObjects;
  RecentFilesMenu:=nil;
  RecentWorkSpacesMenu:=nil;
  inherited;
  FRecentInfos.Free;
  FFixupList.Free;
  FObjectList.Free;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.GetObjectCount:Integer;
begin
  Result:=FObjectList.Count;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.GetObject(Index:Integer):TIDEObject;
begin
  Result:=FObjectList[Index];
end;

{-------------------------------------------------------------------------}

destructor TIDEObject.Destroy;
begin
  UnRegisterNotifier(Self);
  NotifyDestroy(Self);
  inherited;
end;

{-------------------------------------------------------------------------}

constructor TIDEObject.Create(AOwner:TComponent);
begin
  inherited;
  If (FFilename='') and (FFilerID='') then
    CreateNew('','',0)
  else
    InternalCreate(FFileName,FFilerID);

//  CreateNew('','',0);
end;

{-------------------------------------------------------------------------}

procedure TIDEObject.InternalCreate(const FileName:TFileName;
            const FilerID:TFilerID);
begin
  SafeRegisterClass(TPersistentClass(ClassType));
  FFilerID:=FilerID;
  FFileName:=FileName;
  RegisterNotifier(Self);
end;

{-------------------------------------------------------------------------}

constructor TIDEObject.CreateFrom(const FileName:TFileName;
              const FilerID:TFilerID);
Var
  Stream:TStream;
  FileSystem:TFileSystem;
begin
  inherited Create(nil);
  InternalCreate(FileName,FilerID);
  FWasSaved:=True;
  FileSystem:=GetFileSystem(FilerID);
  If FileSystem<>nil then
  begin
    try
      Stream:=FileSystem.GetFileStream(FileName, DefaultOpenMode);
      try
        CreateFromStream(Stream);
      finally
        Stream.Free;
      end;
    finally
      ReleaseFileSystem(FileSystem);
    end;
  end;
  If not ModifiedDuringOpen then
    SetModifiedFalse;
  ObjectCreated;
end;

{-------------------------------------------------------------------------}

procedure TIDEObject.ObjectCreated;
begin
  if MainIdeObject <> nil then
    MainIdeObject.IDEObjectCreated(Self);
end;

{-------------------------------------------------------------------------}

constructor TIDEObject.CreateNew(const FileName:TFileName;const FilerID:TFilerID;Dummy:Integer);
begin
  inherited Create(nil);
  InternalCreate(FileName,FilerID);
  ObjectCreated;
end;

{-------------------------------------------------------------------------}

procedure TIDEObject.AddTo(IDEObject:TCOmpoundIDEObject);
Var
  Index:Integer;
begin
  If (IDEObject=nil) or (IDEObject=self) then
    exit;
  Index:=IDEObject.FObjectList.IndexOf(Self);
  If Index<0 then
  begin
    IDEObject.FObjectList.Add(Self);
    Self.FreeNotification(IDEObject);
    IDEObject.RemoveRecentInfo(Self);
    inc(FRefCount);
    If not (Self is TIDEWorkspace) then
      BroadcastToNotifiers(Self,CM_IDEADDTO,Integer(Self),Integer(IDEObject));
  end;
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.InternalCreate;
begin
  inherited;
  FRecentInfos:=TRecentInfos.Create(Self,TRecentInfo);
  FFixUpList:=TIDEProjectItems.Create(Self,TIDEProjectItem);
  FObjectList:=TList.Create;
  FDefaultFileSystem:='';
  FMaxRecent:=20;
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.DeleteExtraRecentItems(Infos:TRecentInfos;NewCount:Integer);
begin
  NewCount:=Max(0,NewCount);
  With Infos do
    While (Count>NewCount) do
      Items[0].Free;
  RecentInfosChanged;
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.SetMaxRecentItems(Value:TRecentCount);
begin
  If FMaxrecent<>Value then
  begin
    FMaxRecent:=Value;
    DeleteExtraRecentItems(FRecentInfos,Value);
  end;
end;

{-------------------------------------------------------------------------}

{function TCompoundIDEObject.New:TIDEObject;
begin
  Result:=NewIDEObject(GetNewIDEObjectData,True);
end;}

{-------------------------------------------------------------------------}

function TCompoundIDEObject.NewRegisteredIDEObject(IDEClass:TIDEObjectClass;
           ASetVisible:boolean):TIDEObject;
var
  Item:TObjectParamListItem;
begin
  Item:=GetItemEqual(IDEClass,[SNewItemID],[SNewItemID],[]);
  If Item=nil then
    Result:=nil
  else
    Result:=NewIDEObject(Item,ASetVisible);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.NewIDEObject(Item:TObjectParamListItem;
           ASetVisible:boolean):TIDEObject;
begin
  Result:=nil;
  If Item<>nil then
    with Item do
      Result:=NewObjectOfClass(TIDEObjectClass(ClassPtr),
        params[SNewFileName],ASetVisible);
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.NewObjectAdded(AObject : TIDEObject);
begin
  if Assigned(FOnNewObjectAdd) then
    FOnNewObjectAdd(Self, AObject);
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.IDEObjectCreated(AObject : TIDEObject);
begin
  if Assigned(FOnObjectCreated) then
    FOnObjectCreated(Self, AObject);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.NewObjectOfClass(IDEClass:TIDEObjectClass;
           const BaseName:string; ASetVisible:boolean):TIDEObject;
Var
  ObjName:String;
  Extension:String;
  F:TFileSystem;
  AFileName:String;
begin
  IDEbeginUpdate;
  try
    AFileName:=BaseName; 
    ObjName:=ExtractOnlyName(AFileName);
    Extension:=ExtractFileExt(AFileName);

    NewUniqueNumberStr:=
      IntToStr(UniqueObjectNumber(ObjName));

    F:=GetFileSystem(DefaultFileSystem);
    try
      AFileName:=AddSlash(F.GetCurrentDir)+
        ObjName + NewUniqueNumberStr + Extension;
    finally
      ReleaseFileSystem(F);
    end;

    result:=IDEClass.CreateNew(AFileName,DefaultFileSystem,0);
    NewObjectAdded(Result);

    If Assigned(ActiveProject) and (not (Result is TCustomIDEProject)) then
      ActiveProject.AddToProject(Result);

    AddObject(Result);

    If ASetVisible and (Result<>nil) then
      Result.Show;
   finally
     IDEEndUpdate;
   end;
   NewObjectAdded(nil);
end;
{    if opCanBeOnlyOne in IDEClass.GetObjectParams then
      if not CloseObjectsWithClass(IDEClass) then
        exit;}

{-------------------------------------------------------------------------}

procedure AddExtension(S:TStrings;const Desc,Ext:String;ObjectPtr:TObject);
Var
  TempStr:String;
begin
  TempStr:=NormalizeExtension(Ext);
  S.AddObject(Desc + ' ('+TempStr+')|'+
    TempStr,ObjectPtr);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveTypesIterator(Item:TObjectParamListItem;const AParams:Array of variant;
           Var Finish:boolean):Variant;
Var
  C:TClass;
  IDEClass:TClass;
  Strings:TStrings;
begin
  Strings:=TStrings(Integer(AParams[0]));
  C:=TClass(Integer(AParams[1]));
  IDEClass:=TClass(Integer(Item.Params[SSaveIDEObjectClass]));
  If C.InheritsFrom(IDEClass) then
    With Item do
      AddExtension(Strings,Params[SSaveDescription],
        Params[SSaveExtension],ObjectPtr);
end;

{-------------------------------------------------------------------------}

procedure TCOmpoundIDEObject.GetOpenTypes(OpenClass:TOpenObjectClass;OpenTypes:TStrings);
begin
  FAllFilesExt:='';
  ObjectParamList.ForEveryClass(TOpenObject,[Integer(OpenTypes),Integer(OpenClass)],
    OpenTypesIterator);
  If (OpenTypes.Count>1) and (FAllFilesExt<>'') then
    AddExtension(Opentypes,SAllFiles,FAllFilesExt,nil);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.OpenTypesIterator(Item:TObjectParamListItem;const AParams:Array of variant;
           Var Finish:boolean):Variant;
Var
  Strings:TStrings;
  OpenClass:TOpenObjectClass;
begin
  Strings:=TStrings(Integer(AParams[0]));
  OpenClass:=TOpenObjectClass(Integer(AParams[1]));
  With Item do
    If (OpenClass=nil) or (ClassPtr.InheritsFrom(OpenClass)) then
    begin
      If FAllFilesExt<>'' then
        FAllFilesExt:=FAllFilesExt+',';
      FAllFilesExt:=FAllFilesExt+Params[SOpenExtension];

      AddExtension(Strings,Params[SOpenDescription],
        Params[SOpenExtension],ObjectPtr);
    end;
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.GetSaveTypes(IDEClass:TIDEObjectClass;SaveTypes:TStrings);
begin
  ObjectParamList.ForEveryClass(TSaveObject,[Integer(SaveTypes),Integer(IDEClass)],
    SaveTypesIterator);
end;

{-------------------------------------------------------------------------}

function RegisterOpenClass(OpenClass:TOpenObjectClass;const Extension,Description:String):TObjectParamListItem;
begin
  Result:=RegisterClassExt(OpenClass,[SOpenExtension,SOpenDescription],
    [','+Extension+',',Description]);
end;

{-------------------------------------------------------------------------}

procedure RegisterSaveClass(SaveClass:TSaveObjectClass;
            IDEObjectClass:TIDEObjectClass;
            const Extension,Description:String);
begin
  RegisterClassExt(SaveClass,[SSaveIDEObjectClass,SSaveExtension,
    SSaveDescription],[Integer(IDEObjectClass),Extension,Description]);
end;

{-------------------------------------------------------------------------}

procedure RegisterNewItem(IDEClass:TIDEObjectClass;
  const FileName,ResName,PageCaption,Caption:String);
begin
  If GetItemEqual(IDEClass,[SNewItemID],[SNewItemID],[])<>nil then
    raise Exception.CreateFmt(SErrAlreadyInNewDialog,[IDEClass.ClassName]);
  RegisterClassExt(IDEClass,
   [SNewItemID,SNewFileName,SNewResName,SNewPageCaption,SNewCaption],
   [SNewItemID,FileName,ResName,PageCaption,Caption]);
end;

{--------------------------------------------}

function TMasteredIDEObject.ValidObjectName(const ObjName:String):boolean;
begin
  Result:=FMasterObject.ValidObjectName(ObjName);
end;

{--------------------------------------------}

constructor TMasteredIDEObject.CreateFrom(const FileName:TFileName; const FilerID:TFilerID);
begin
  inherited;
  FMasterObject:=GetMasterObjectClass.CreateFrom(FileName,FilerID);
  AddObject(FMasterObject);
  ObjectCreated;
end;

{--------------------------------------------}

constructor TMasteredIDEObject.CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);
begin
  inherited;
  FMasterObject:=GetMasterObjectClass.CreateNew(FileName,FilerID,0);
  AddObject(FMasterObject);
end;

{-------------------------------------------------------------------------}

procedure ShortNamesToStrings(IDEObjects:TList;Strings:TStrings);
Var
  i:Integer;
begin
  With Strings do
  begin
    BeginUpdate;
    Clear;
    for i:=0 to IDEObjects.Count-1 do
      AddObject(TIDEObject(IDEObjects[i]).ObjectName,IDEObjects[i]);
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure OpenParamFiles;
begin
  If MainIDEObject is TInstantReport then
  begin
    {load default workspace into IDE }
    TInstantReport(MainIDEObject).OpenDefaultWorkSpace;

    {Open files in command line into IDE }
    TInstantReport(MainIDEObject).OpenCommandLineFiles;
  end;
end;

{-------------------------------------------------------------------------}

procedure HasActiveProject(Var VerbStates:TVerbStates);
begin
  If MainIDEObject.ActiveProject=nil then
    Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------------------}

procedure FileOpen;
begin
  MainIDEObject.Open;
end;

{-------------------------------------------------------------------------}

procedure FileOpenWorkSpace;
begin
  TInstantReport(MainIDEObject).OpenWorkSpace;
end;

{-------------------------------------------------------------------------}

procedure FileSaveWorkSpace;
begin
  TInstantReport(MainIDEObject).SaveWorkSpace;
end;

{-------------------------------------------------------------------------}

procedure FileSaveWorkSpaceAs;
begin
  TInstantReport(MainIDEObject).SaveWorkSpaceAs;
end;

{-------------------------------------------------------------------------}

procedure CanPrint(Var VerbStates:TVerbStates);
begin
  If not MainIDEObject.CanPrint then
   Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------------------}

procedure FilePrint;
begin
  MainIDEObject.Print;
end;

{-------------------------------------------------------------------------}

procedure FileSave;
begin
  MainIDEObject.SaveActive;
end;

{-------------------------------------------------------------------------}

procedure FileSaveAs;
begin
  MainIDEObject.SaveActiveAs;
end;

{-------------------------------------------------------------------------}

procedure FileExportTo;
begin
  MainIDEObject.ExportActiveTo;
end;

{-------------------------------------------------------------------------}

procedure FileSaveAll;
begin
  MainIDEObject.SaveAll;
end;

{-------------------------------------------------------------------------}

procedure FileClose;
begin
  MainIDEObject.CloseActive;
end;

{-------------------------------------------------------------------------}

procedure FileCloseAll;
begin
  MainIDEObject.CloseAll;
end;

{-------------------------------------------------------------------------}

procedure FileExit;
begin
  Application.MainForm.Close;
end;

{-------------------------------------------------------------------------}

procedure EditUndo;
begin
  MainIDEObject.Undo;
end;

{-------------------------------------------------------------------------}

procedure EditRedo;
begin
  MainIDEObject.Redo;
end;

{-------------------------------------------------------------------------}

procedure EditCut;
begin
  MainIDEObject.CutToClipboard;
end;

{-------------------------------------------------------------------------}

procedure EditCopy;
begin
  MainIDEObject.CopyToClipboard;
end;

{-------------------------------------------------------------------------}

procedure EditPaste;
begin
  MainIDEObject.PasteFromClipboard;
end;

{-------------------------------------------------------------------------}

procedure EditDelete;
begin
  MainIDEObject.DeleteSelection;
end;

{-------------------------------------------------------------------------}

procedure EditSelectAll;
begin
  MainIDEObject.SelectAll;
end;

{-------------------------------------------------------------------------}

procedure WindowCompoundNext;
begin
  MainIDEObject.CompoundNextObject;
end;

{-------------------------------------------------------------------------}

procedure WindowCompoundPrev;
begin
  MainIDEObject.CompoundPreviousObject;
end;

{-------------------------------------------------------------------------}

procedure HasActiveObject(Var VerbStates:TVerbStates);
begin
  If (MainIDEObject.ActiveObject=nil) then
     Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------------------}

procedure HasObjects(Var VerbStates:TVerbStates);
begin
  If (MainIDEObject.ObjectCount=0) then
     Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------------------}

procedure HasActiveCompound(Var VerbStates:TVerbStates);
begin
  If (not MainIDEObject.IsActiveCompound) then
     Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------------------}

procedure CanSaveActive(Var VerbStates:TVerbStates);
begin
  If (not MainIDEObject.CanSaveActive) then
     Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------------------}

procedure CanSaveAll(Var VerbStates:TVerbStates);
begin
  If (not MainIDEObject.CanSaveAll) then
     Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------------------}

procedure CanCloseActive(Var VerbStates:TVerbStates);
begin
  If (not MainIDEObject.CanCloseActive) then
     Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------------------}

procedure CanCloseAll(Var VerbStates:TVerbStates);
begin
  If (not MainIDEObject.CanCloseAll) then
     Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------------------}

{procedure RunRunParameters;
begin
  ReadString(SCapRunParameters,'&'+SCapRunParameters,0,RunScriptParameters);
end;}

{-------------------------------------------------------------------------}

function TCompoundIDEObject.AddToActiveProject:TIDEObject;
begin
  Result:=AddToProject(ActiveProject);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.AddToProject(Project:TCustomIDEProject):TIDEObject;
begin
  Result:=nil;
  If Project=nil then
    exit;
  Result:=OpenLimitedType(TOpenIDEObject);
  Project.AddToProject(Result);
end;

{-------------------------------------------------------------------------}

procedure FileAddToProject;
begin
  MainIDEObject.AddToActiveProject;
end;

{-------------------------------------------------------------------------}

//BeginSkipConst
const
  VerbArray:Array[0..{$IFDEF CLX}22{$ELSE}25{$ENDIF}] of TVerbData=(
    (Name:'File.Open';              GetState:nil;Execute:FileOpen),
    (Name:'File.OpenWorkSpace';     GetState:nil;Execute:FileOpenWorkSpace),
    (Name:'File.SaveWorkSpace';     GetState:nil;Execute:FileSaveWorkSpace),
    (Name:'File.SaveWorkSpaceAs';   GetState:nil;Execute:FileSaveWorkSpaceAs),
    (Name:'File.Save';              GetState:CanSaveActive;Execute:FileSave),
    (Name:'File.SaveAs';            GetState:HasActiveObject;Execute:FileSaveAs),
    (Name:'File.SaveAll';           GetState:CanSaveAll;Execute:FileSaveAll),
    (Name:'File.ExportTo';          GetState:HasActiveObject;Execute:FileExportTo),
    (Name:'File.Close';             GetState:CanCloseActive;Execute:FileClose),
    (Name:'File.CloseAll';          GetState:CanCloseAll;Execute:FileCloseAll),
    (Name:'File.AddToProject';      GetState:HasActiveProject;Execute:FileAddToProject),
    (Name:'File.Exit';              GetState:nil;Execute:FileExit),

    (Name:'File.Print';             GetState:CanPrint;Execute:FilePrint),

    (Name:'Edit.Undo';              GetState:HasActiveObject;Execute:EditUndo),
    (Name:'Edit.Redo';              GetState:HasActiveObject;Execute:EditRedo),
    (Name:'Edit.Cut';               GetState:HasActiveObject;Execute:EditCut),
    (Name:'Edit.Copy';              GetState:HasActiveObject;Execute:EditCopy),
    (Name:'Edit.Paste';             GetState:HasActiveObject;Execute:EditPaste),
    (Name:'Edit.Delete';            GetState:HasActiveObject;Execute:EditDelete),
    (Name:'Edit.SelectAll';         GetState:HasActiveObject;Execute:EditSelectAll),

    (Name:'View.ToggleInspector';     GetState:nil;Execute:ToggleInspector),

    (Name:'Window.CompoundNext';    GetState:HasActiveCompound;Execute:WindowCompoundNext),
    (Name:'Window.CompoundPrev';    GetState:HasActiveCompound;Execute:WindowCompoundPrev)
    {$IFNDEF CLX}
    ,
    (Name:'Help.HomePage';          GetState:nil;Execute:HomePage),
    (Name:'Help.WriteToUs';         GetState:nil;Execute:WriteToUs),
    (Name:'Help.OnlineRegistration';GetState:nil;Execute:OnlineRegistration)
    {$ENDIF}
  );


//    (Name:'Tools.Options';          GetState:nil;Execute:ToolsOptions),
//    (Name:'Help.Contents';          GetState:nil;Execute:HelpContents),
//    (Name:'Help.About';             GetState:nil;Execute:nil));

//EndSkipConst

{-------------------------------------------------------------------------}

{procedure SendDebugEx(const V:Array of Variant);
begin
end;}

{-------------------------------------------------------------------------}

{procedure SendDebug(V:Variant);
begin
  SendDebugEx([V]);
end;}

{-------------------------------------------------------------------------}
(*
Var
  FSystemMessageList:TSystemMessageList=nil;

function SystemMessageList:TSystemMessageList;
begin
  If FSystemMessageList=nil then
    FSystemmessageList:=TSystemMessageList.Create(TSystemMessageItem);
  Result:=FSystemmessageList;
end;
*)

{-------------------------------------------------------------------------}

function IsInMainObject(const O):boolean;
begin
  Result:=(Integer(O)>0) and (TObject(O) is TIDEObject) and
       (MainIDEObject.FObjectList.IndexOf(TIDEObject(O))>=0);
end;

{------------------------------------------------------------------}

procedure TCompoundIDEObject.CanCloseIterator(Item:TObject;ItemIndex:Integer;var Continue:boolean);
begin
  Continue:=CanCloseObject(TIDEObject(Item));
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CanCloseObjects(ObjList:TList):boolean;
begin
  Result:=ForEachListItem(ObjList,CanCloseIterator);
end;

{-------------------------------------------------------------------------}

procedure TCustomIDEProject.ObjectsToList(ObjList:TList;Compound:TCOmpoundIDEObject);
var
  i:Integer;
  IDEObject:TIDEObject;
begin
  ObjList.Clear;
  With FProjectItems do
  for i:=0 to Count-1 do
    With TIDEProjectItem(Items[i]) do
    begin
      IDEObject:=MainIDEObject.ObjectByFileName(FileName,FilerID);
      IF (IDEObject<>nil) then
        ObjList.Add(IDEObject);
    end;
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.SaveObjectsWithQuestion(ObjList:TList):boolean;
begin
  Result:=ForEachListItem(ObjList,SaveAllQuestionIterator);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.CloseProject(IDEProject:TCustomIDEProject):boolean;
Var
  ObjList:TList;
begin
  Result:=False;
  ObjList:=TList.Create;
  try
    IDEProject.ObjectsToList(ObjList,Self);
    ObjList.Insert(0,IDEProject);
    If not CanCloseObjects(ObjList) then
      exit;
    Result:=SaveObjectsWithQuestion(ObjList);
    If Result then
      IDEProject.RemoveFrom(Self);
  finally
    ObjList.Free;
  end;
end;

{-------------------------------------------------------------------------}

function ProjectItemIsCompound(Item:TIDEProjectItem):boolean;
var
  TempClass:TClass;
begin
  TempClass:=GetClass(Item.ObjectClassName);
  Result:= (TempClass<>nil) and TempClass.InheritsFrom(TCompoundIDEObject);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.IsMemberOfProject(IDEObject:TIDEObject;
           ExceptProject:TCustomIDEProject; CheckOld:boolean):boolean;
Var
  i:Integer;
begin
  Result:=False;
  If (IDEObject is TCustomIDEProject) or (IDEObject=nil) then
    exit;
  With FObjectList do
    for i:=0 to Count-1 do
      if (TObject(Items[i]) is TCustomIDEProject) and (Items[i]<>ExceptProject) then
        if TCustomIDEProject(Items[i]).ProjectItems.IndexOfObject(IDEObject,CheckOld)<>-1 then
        begin
          Result:=True;
          exit;
        end;
end;

{-------------------------------------------------------------------------}

function TIDEObjectList.IndexOfFileName(const AFileName:TFileName;
           const AFilerID:TFilerID):Integer;
Var
  i:Integer;
begin
  for I:=0 to Count-1 do
    With Items[i] do
      if (CompareText(FileName,AFileName)=0) and
         (FilerID=AFilerID) then
         begin
           Result:=i;
           exit;
         end;
  Result:=-1;
end;

{-------------------------------------------------------------------------}

function TIDEObjectList.IndexOfObject(IDEObject:TIDEObject;CheckOld:boolean):Integer;
begin
  With IDEObject do
    Result:=IndexOfFileName(FileName,FilerID);
  If (Result<0) and CheckOld then
    Result:=IndexOfoldObject(IDEObject);
end;

{-------------------------------------------------------------------------}

function TIDEObjectList.IndexOfOldObject(IDEObject:TIDEObject):Integer;
begin
  With IDEObject do
    Result:=IndexOfFileName(FOldFileName,FOldFilerID);
end;

{-------------------------------------------------------------------------}

function TCompoundIDEObject.GetActiveProject:TCustomIDEProject;
Var
  i:Integer;
begin
  If FActiveProject=nil then
    With FObjectList do
      for i:=Count-1 downto 0 do
        if TObject(Items[i]) is TCustomIDEProject then
          begin
            FActiveProject:=TCustomIDEProject(Items[i]);
            break;
          end;
  Result:=FActiveProject;
end;

{-------------------------------------------------------------------------}

procedure TCompoundIDEObject.SetActiveProject(IDEProject:TCustomIDEProject);
begin
  If FActiveProject<>IDEProject then
  begin
    FActiveProject:=IDEProject;
    IDEChanged;
    BroadcastToNotifiers(nil,CM_IDEAPROJCHANGED,Integer(IDEProject),0);
  end;
end;

{-------------------------------------------------------------------------}
{$IFNDEF CLX}
procedure TIDEProject.CMIDEOBJPROPSCHANGED(Var Message:TMessage);
begin
  If ProjectItems.IndexOfObject(TIDEObject(Message.wParam),False)>=0 then
    SetModifiedTrue;
end;
{$ENDIF}
{-------------------------------------------------------------------------}

destructor TIDEProject.Destroy;
Var
  i:Integer;
  IDEObject:TIDEObject;
begin
  If MainIDEObject<>nil then
  With FProjectItems do
  for i:=0 to Count-1 do
    With TIDEProjectItem(Items[i]) do
    begin
      IDEObject:=MainIDEObject.ObjectByFileName(FileName,FilerID);
      IF (IDEObject<>nil) and (not MainIDEObject.IsMemberOfProject(IDEObject,self,False)) then
        IDEObject.RemoveFrom(MainIDEObject);
    end;
  inherited;
end;

{-------------------------------------------------------------------------}

procedure TIDEProject.InternalCreate(const FileName:TFileName; const FilerID:TFilerID);
begin
  inherited;
  FStrictWithNames:=True;
end;

{-------------------------------------------------------------------------}

procedure TIDEProject.AddTo(IDEObject:TCompoundIDEObject);
begin
  inherited;
  IDEBeginUpdate;
  try
    If IDEObject<>nil then
      IDEObject.ActiveProject:=Self;

    If (WasSaved) and (not OpenProjectItems(IDEObject,False)) then
      CallVerbByName(SViewProjectMan);

  finally
    IDEEndUpdate;
  end;
end;

{-------------------------------------------------------------------------}

function TIDEObject.OldNameIsSame:boolean;
begin
  Result:=(FFileName=FOldFileName) and (FFilerID=FOldFilerID);
end;

{-------------------------------------------------------------------------}

{$IFNDEF CLX}
procedure TIDEProject.CMIDESAVETO(Var Message:TMessage);
Var
  IDEObject:TIDEObject;
  i:Integer;
begin
  IDEObject:=TIDEObject(Message.wParam);
  If IDEObject.OldNameIsSame or (MainIDEObject.FObjectList.IndexOf(IDEObject)<0) then
    exit;
  with FProjectItems do
  begin
    I:=IndexOfOldObject(IDEObject);
    If i>=0 then
      With Items[i] do
      begin
        FileName:=IDEObject.FileName;
        FilerID:=IDEObject.FilerID;
        SetModifiedTrue;
      end;
  end;
end;

{-------------------------------------------------------------------------}

procedure TIDEProject.CMIDEADDTO(Var Message:TMessage);
Var
  Index:Integer;
  IDEObject:TIDEObject;
begin
  IDEObject:=TIDEObject(Message.wParam);
  Index:=ProjectItems.IndexOfObject(IDEObject,False);
  If Index<0 then
    exit;
  if (not TIDEProjectItem(ProjectItems[Index]).ObjectOpened) and (not IDEObject.Closed) then
    SetModifiedTrue;
end;

{-------------------------------------------------------------------------}

procedure TIDEProject.CMOBJDESTROYED(Var Message:TMessage);
Var
  Index:Integer;
  IDEObject:TIDEObject;
begin
  If not (TObject(Message.wParam) is TIDEObject) then
    exit;
  IDEObject:=TIDEObject(Message.wParam);

  Index:=ProjectItems.IndexOfObject(IDEObject,False);
  If Index<0 then
    exit;
  if IDEObject.WasSaved then
    With TIDEProjectItem(ProjectItems.Items[Index]) do
    begin
      ObjectProps:=IDEObject.GetObjectProps;
      SetModifiedTrue;
    end
  else
    RemoveFromProject(IDEObject);
end;

{-------------------------------------------------------------------------}
{$ENDIF CLX}


function TIDEObjectListItem.GetShortName:String;
begin
  Result:=ExtractOnlyName(FFileName);
end;

{-------------------------------------------------------------}

procedure TCompoundIDEObject.ShortNamesToObjList(ShortNames:TStrings;ObjectList:TList);
Var
  i:Integer;
  Item:TIDEProjectItem;
begin
  ObjectList.Clear;
  If ActiveProject=nil then
    exit;
  for i:=0 to ShortNames.Count-1 do
  begin
    Item:=ActiveProject.ProjectItemByShortName(ShortNames[i]);
    If (Item<>nil) and (Item.RelatedObject<>nil) then
        ObjectList.Add(Item.RelatedObject);
  end;
end;

{-------------------------------------------------------------------------}

constructor TSaveObject.Create(IDEObject:TIDEObject);
begin
  inherited Create;
  FIDEObject:=IDEObject;
end;

{-------------------------------------------------------------------------}

constructor TOpenObject.Create(Compound:TCompoundIDEObject);
begin
  inherited Create;
  FCompound:=Compound;
end;

{-------------------------------------------------------------------------}

procedure TIDEObject.SetFileName(const Value:TFileName);
begin
  If FFileName<>Value then
  begin
    FFileName:=Value;
  end;
end;

{-------------------------------------------------------------------------}

procedure TIDEObject.SetFilerID(const Value:TFilerID);
begin
  If FFilerID<>Value then
  begin
    FFilerID:=Value;
  end;
end;

{-------------------------------------------------------------------------}

procedure ActionActivateProject(Instance:TPersistent);
begin
  if Instance is TCustomIDEProject then
    MainIDEObject.ActiveProject:=TCustomIDEProject(Instance);
end;

{-------------------------------------------------------------------------}

procedure ActionAddToProject(Instance:TPersistent);
begin
  if Instance is TCustomIDEProject then
    MainIDEObject.AddToProject(TCustomIDEProject(Instance));
end;

{-------------------------------------------------------------------------}

function CorrectInstance(var Instance:TPersistent):boolean;
begin
  If Instance is TIDEProjectItem then
    Instance:=TIDEProjectItem(Instance).RelatedObject;
  Result:=Instance<>nil;
end;

{-------------------------------------------------------------------------}

function InMainObject(var Instance : TPersistent) : boolean;
begin
  result := CorrectInstance(Instance) and IsInMainObject(Instance);
end;

{-------------------------------------------------------------------------}

procedure ActionSaveObject(Instance:TPersistent);
begin
  If InMainObject(Instance) then
    MainIDEObject.SaveObject(TIDEObject(Instance));
end;

{-------------------------------------------------------------------------}

procedure ActionSaveObjectAs(Instance:TPersistent);
begin
  If InMainObject(Instance) then
    MainIDEObject.SaveObjectAs(TIDEObject(Instance));
end;

{-------------------------------------------------------------------------}

procedure ActionCloseObject(Instance:TPersistent);
begin
  If InMainObject(Instance) then
    MainIDEObject.CloseObject(TIDEObject(Instance));
end;

{-------------------------------------------------------------------------}

function TIDEObject.GetInstance:TComponent;
begin
  Result:=nil;
end;

{-------------------------------------------------------------------------}

procedure _Register;
begin
// ---------------- save classes registration --------------------

  RegisterSaveClass(TSaveProjectObject,TIDEProject,'ipr',SProjectFile);  //don't resource
  RegisterSaveClass(TSaveProjectObject,TIDEWorkSpace,'iws',SWorkSpaceFile);//don't resource

// ----------------- open classes registration --------------------

  RegisterOpenClass(TOpenWorkSpaceObject,'iws',SWorkSpaceFile);//don't resource
  RegisterOpenClass(TOpenProjectObject,'ipr',SProjectFile);//don't resource

// ---------------- new items registration -------------------

  RegisterNewItem(TIDEWorkSpace,SFileWorkSpace,'NEWWORKSPACE',SProject,SWorkSpace);//don't resource
  RegisterNewItem(TIDEProject,SFileProject,'NEWPROJECT',SProject,SProject);//don't resource

  RegisterVerbArray(VerbArray);


  SafeRegisterClasses([TIDEObject,TIDEProject]);

end;

{-------------------------------------------------------------------------}

procedure RunRegister;
begin
  _Register;
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}
type
  TResMessageAnswer = class(TMessageAnswer)
  private
    FFixList:TStringList;
    function  GlobalFindResComp(const Name : string) : TComponent;
  protected
    procedure CMDESIGNRESFORM (var Msg : TMessage); message CM_DESIGNRESFORM;
  public
    constructor Create;
    destructor Destroy;override;
  end;

{------------------------------------------------------------------}

constructor TResmessageAnswer.Create;
begin
  inherited;
  FFixList:=CreateSortedStringList;
end;

{------------------------------------------------------------------}

destructor TResmessageAnswer.Destroy;
begin
  FFixList.Free;
  inherited
end;

{------------------------------------------------------------------}

function  TResmessageAnswer.GlobalFindResComp(const Name : string) : TComponent;
begin
  result := GlobalFindObject(Name);
  if result = nil then
    fFixList.Add(ClassPrefix + Name);
end;

{------------------------------------------------------------------}
{$ENDIF}

procedure TIDEObject.Print;
begin
end;

{------------------------------------------------------------------}

function TIDEObject.CanPrint:boolean;
begin
  Result:=False;
end;

{-------------------------------------------------------------}

function TCompoundIDEObject.CanPrint:boolean;
begin
  Result:=(ActiveObject<>nil) and ActiveObject.CanPrint;
end;

{-------------------------------------------------------------}

procedure TCompoundIDEObject.Print;
begin
  If ActiveObject<>nil then
    ActiveObject.Print;
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}

procedure TResMessageAnswer.CMDESIGNRESFORM (var Msg : TMessage);
var
  FilerID:TFilerID;
  Hooked:boolean;

  function GetPath(const ResName:String):String;
  begin
    Result:=StringFromRType(PDesignResFormData(Msg.lParam)^.ResType) + '\' + ResName + '.dfm';//don't resource
  end;

begin
  if MainIDEObject <> nil then
    with Msg, PDesignResFormData(lParam)^ do
    begin
      If not IsFormInResource(string(wParam),ResName,ResType) then
      begin
        ShowMessage(SErrOnlyForms);
        exit;
      end;
      FilerID:=GetResFileSystemFilerID(string(wParam));
      fFixList.Clear;
      Hooked:=SetFindGlobalCompProc(GlobalFindResComp);
      fFixList.Add(ResName);
      try
        while fFixList.Count > 0 do
        begin
          MainIDEObject.OpenFile(GetPath(FFixList[0]),FilerID,
            CompareText(FFixList[0],Resname)=0);
          fFixList.Delete(0);
          GlobalFixupReferences;
        end;
      finally
        If Hooked then
          RemoveFindGlobalCompProc;
      end;
    end;
end;

{------------------------------------------------------------------}

var
  rmanswer : TResMessageAnswer;
{$ENDIF}
{-------------------------------------------------------------------------}

initialization
  RunRegister;
{$IFNDEF CLX}
  rmanswer := TResMessageAnswer.Create;
{$ENDIF}
finalization
{$IFNDEF CLX}
  FreeObject(rmanswer,rmanswer);
{$ENDIF}
  FreeObject(FFakeMainObject,FFakeMainObject);
end.
