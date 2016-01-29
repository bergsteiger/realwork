{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcsystem;

interface
{$I dc.inc}

uses
  {$IFDEF D6}
  RTLConsts,
  {$ENDIF}
  Consts,

  {$IFDEF DEBUG_} dcdebug,{$ENDIF}
  {$IFDEF WIN}
  {$IFNDEF CLX}
    windows, messages,
    {$IFDEF D3} activex, {$ELSE} ole2, oleauto, olectl, {$ENDIF}
  {$ELSE}
    dcactivex, Types, QGraphics,
  {$ENDIF}
  {$ENDIF}
  dcClasses, Classes, Sysutils, Typinfo, dcapi, dchook,
  {$IFDEF WIN}
  {$IFNDEF CLX}
  registry, graphics, //never remove graphics from the uses
  {$ENDIF}
  {$ENDIF}

  dcconsts, dcdreamlib
  {$IFDEF WIN}
  {$IFNDEF CLX}
  ,Stdctrls
  {$ELSE}
  ,QStdCtrls
  {$ENDIF}
  {$ENDIF}
  {$IFDEF D6}
  ,Variants
  {$ENDIF}
  ;

const
  SvarSourceClass      = 'Source.ObjClass';  //don't resource
  SvarSourceEditMethod = 'Source.EditMethod'; //don't resource
  SvarSourceIdent      = 'Source.Ident'; //don't resource

  SVarInitProc='Var.InitProc'; //don't resource
  SVarForInstant='Var.ForInstant'; //don't resource
  SVarRegistered='Var.Registered'; //don't resource

{$IFDEF WIN}
{$IFNDEF CLX}
const
{$IFNDEF D3}
  _IMAGE_NUMBEROF_DIRECTORY_ENTRIES = 16;
  _IMAGE_SIZEOF_SHORT_NAME          = 8;
{$ELSE}
  _IMAGE_NUMBEROF_DIRECTORY_ENTRIES = IMAGE_NUMBEROF_DIRECTORY_ENTRIES;
  _IMAGE_SIZEOF_SHORT_NAME          = IMAGE_SIZEOF_SHORT_NAME;
{$ENDIF}
{$ENDIF}
{$ENDIF}

//  IMAGE_OFFSET_STRIP_HIGH          = $7FFFFFFF;

//=========================================================================
// typedec
// ------------------------ types declaration ------------------

type
  TDCStringArray=Array[0..1] of String;
  PDCStringArray=^TDCStringArray;

  THorzAlignment=(haNone,haLeft,haCenter,haRight);
  TVertAlignment=(vaNone,vaLeft,vaCenter,vaRight);

  TWriteLogEvent=procedure(const Value:Variant);
  TStringsOperateProc=procedure (S:TStrings);

  TSearchParam=(spCaseSens,spWholeWords,spBackSearch);
  TSearchParams=set of TSearchParam;

  TDCSimpleScripter = class(TComponent)
  public
    procedure BeginDesign; virtual; abstract;
    procedure EndDesign; virtual; abstract;
    procedure CreateEvent(Instance : TComponent; const Event, ScriptMethod : string; ACallExisting : boolean); virtual; abstract;
    procedure RenameEvent(const OldName, NewName : string); virtual; abstract;
    procedure EventDeleted; virtual; abstract;
  end;

  _TIDEObject=class(TComponent)
  end;

  TKeyboardInitProc = procedure(Instance:TObject);

  TKeyboardMethod = procedure of object;
  TEventHandler = function (EventName : pchar; cArgs : integer; pArgs : PVariantArgList) : variant of object;

  TKeyData=class(TCollectionItem)
  public
    ActiveState,LeaveState:ShortInt;
    KeyCode:Word;
    ShiftState:TShiftState;
    ActionCode:TKeyboardMethod;
    procedure Assign(Source : TPersistent); override;
  end;

  TKeyList=class(TCollection)
  private
    FCachedData:TKeyData;
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create;
    function  AddKey(AKey:Word;AShift:TShiftState;ACode:TKeyboardMethod;
                AActiveState,ALeaveState:ShortInt):TKeyData;

    function  AddAllKey(AKey:Word;AShift:TShiftState;ACode:TKeyboardMethod):TKeyData;
    function  AddSimpleKey(AKey:Word;AShift:TShiftState;ACode:TKeyboardMethod):TKeyData;

    function FindKeyData(AKey:Word;AShift:TShiftState;AState:ShortInt):TKeyData;
  end;

  TOptionExt = class(TPersistent)
  private
    fUpdateCount:Integer;
    fGlobalOptions : TOptionExt;
    fGlobal : boolean;
    Procedure InitializeOptions;
  protected
    procedure LoadConfig; virtual;
    procedure SaveConfig; virtual;
    function  GetKey : string; virtual;
    procedure InitValues; virtual;
    procedure Update; virtual;
    function UpdateDisabled:boolean;
  public
    procedure BeginUpdate;
    procedure EndUpdate;
    constructor Create; virtual;
    destructor  Destroy; override;
    procedure   Assign(Source : TPersistent); override;
    procedure   ApplyOptions; virtual;
    function    GetOptionControl:TPersistent; virtual;

    property  Global : boolean read fGlobal;
    property UpdateCount:Integer Read FUpdateCount;
  end;

  TOptionExtClass = class of TOptionExt;

  TOptionExtList = class(TList)
  public
    constructor Create;
    destructor Destroy;override;
    function GetOptionWithClass(const OptionClass:string):TOptionExt;
    procedure ApplyOptions;
  end;

  TOptionsInitializator=Procedure(Options:TOptionExt);
{$IFDEF WIN}
{$IFNDEF CLX}

  PIMAGE_DOS_HEADER = ^IMAGE_DOS_HEADER;
  IMAGE_DOS_HEADER = packed record      { DOS .EXE header }
    e_magic         : WORD;             { Magic number }
    e_cblp          : WORD;             { Bytes on last page of file }
    e_cp            : WORD;             { Pages in file }
    e_crlc          : WORD;             { Relocations }
    e_cparhdr       : WORD;             { Size of header in paragraphs }
    e_minalloc      : WORD;             { Minimum extra paragraphs needed }
    e_maxalloc      : WORD;             { Maximum extra paragraphs needed }
    e_ss            : WORD;             { Initial (relative) SS value }
    e_sp            : WORD;             { Initial SP value }
    e_csum          : WORD;             { Checksum }
    e_ip            : WORD;             { Initial IP value }
    e_cs            : WORD;             { Initial (relative) CS value }
    e_lfarlc        : WORD;             { File address of relocation table }
    e_ovno          : WORD;             { Overlay number }
    e_res           : packed array [0..3] of WORD; { Reserved words }
    e_oemid         : WORD;             { OEM identifier (for e_oeminfo) }
    e_oeminfo       : WORD;             { OEM information; e_oemid specific }
    e_res2          : packed array [0..9] of WORD; { Reserved words }
    e_lfanew        : Longint;          { File address of new exe header }
  end;

  PIMAGE_FILE_HEADER = ^IMAGE_FILE_HEADER;
  IMAGE_FILE_HEADER = packed record
    Machine              : WORD;
    NumberOfSections     : WORD;
    TimeDateStamp        : DWORD;
    PointerToSymbolTable : DWORD;
    NumberOfSymbols      : DWORD;
    SizeOfOptionalHeader : WORD;
    Characteristics      : WORD;
  end;

  PIMAGE_DATA_DIRECTORY = ^IMAGE_DATA_DIRECTORY;
  IMAGE_DATA_DIRECTORY = packed record
    VirtualAddress  : DWORD;
    Size            : DWORD;
  end;

  PIMAGE_OPTIONAL_HEADER = ^IMAGE_OPTIONAL_HEADER;
  IMAGE_OPTIONAL_HEADER = packed record
   { Standard fields. }
    Magic           : WORD;
    MajorLinkerVersion : Byte;
    MinorLinkerVersion : Byte;
    SizeOfCode      : DWORD;
    SizeOfInitializedData : DWORD;
    SizeOfUninitializedData : DWORD;
    AddressOfEntryPoint : DWORD;
    BaseOfCode      : DWORD;
    BaseOfData      : DWORD;
   { NT additional fields. }
    ImageBase       : DWORD;
    SectionAlignment : DWORD;
    FileAlignment   : DWORD;
    MajorOperatingSystemVersion : WORD;
    MinorOperatingSystemVersion : WORD;
    MajorImageVersion : WORD;
    MinorImageVersion : WORD;
    MajorSubsystemVersion : WORD;

    MinorSubsystemVersion : WORD;
    Reserved1       : DWORD;
    SizeOfImage     : DWORD;
    SizeOfHeaders   : DWORD;
    CheckSum        : DWORD;
    Subsystem       : WORD;
    DllCharacteristics : WORD;
    SizeOfStackReserve : DWORD;
    SizeOfStackCommit : DWORD;
    SizeOfHeapReserve : DWORD;
    SizeOfHeapCommit : DWORD;
    LoaderFlags     : DWORD;
    NumberOfRvaAndSizes : DWORD;
    DataDirectory   : packed array [0.._IMAGE_NUMBEROF_DIRECTORY_ENTRIES-1] of IMAGE_DATA_DIRECTORY;
  end;

  PIMAGE_SECTION_HEADER = ^IMAGE_SECTION_HEADER;
  IMAGE_SECTION_HEADER = packed record
    Name            : packed array [0.._IMAGE_SIZEOF_SHORT_NAME-1] of Char;
    PhysicalAddress : DWORD; // or VirtualSize (union);
    VirtualAddress  : DWORD;
    SizeOfRawData   : DWORD;
    PointerToRawData : DWORD;
    PointerToRelocations : DWORD;
    PointerToLinenumbers : DWORD;
    NumberOfRelocations : WORD;
    NumberOfLinenumbers : WORD;
    Characteristics : DWORD;
  end;

  PIMAGE_NT_HEADERS = ^IMAGE_NT_HEADERS;
  IMAGE_NT_HEADERS = packed record
    Signature       : DWORD;
    FileHeader      : IMAGE_FILE_HEADER;
    OptionalHeader  : IMAGE_OPTIONAL_HEADER;
  end;

{ Resources }

  PIMAGE_RESOURCE_DIRECTORY = ^IMAGE_RESOURCE_DIRECTORY;
  IMAGE_RESOURCE_DIRECTORY = packed record
    Characteristics : DWORD;
    TimeDateStamp   : DWORD;
    MajorVersion    : WORD;
    MinorVersion    : WORD;
    NumberOfNamedEntries : WORD;
    NumberOfIdEntries : WORD;
  end;

  PIMAGE_RESOURCE_DIRECTORY_ENTRY = ^IMAGE_RESOURCE_DIRECTORY_ENTRY;
  IMAGE_RESOURCE_DIRECTORY_ENTRY = packed record
    Name: DWORD;        // Or ID: Word (Union)
    OffsetToData: DWORD;
  end;

  PIMAGE_RESOURCE_DATA_ENTRY = ^IMAGE_RESOURCE_DATA_ENTRY;
  IMAGE_RESOURCE_DATA_ENTRY = packed record
    OffsetToData    : DWORD;
    Size            : DWORD;
    CodePage        : DWORD;
    Reserved        : DWORD;
  end;

  PIMAGE_RESOURCE_DIR_STRING_U = ^IMAGE_RESOURCE_DIR_STRING_U;
  IMAGE_RESOURCE_DIR_STRING_U = packed record
    Length          : WORD;
    NameString      : array [0..0] of WCHAR;
  end;

  PIconHeader = ^TIconHeader;
  TIconHeader = packed record
    wReserved: Word;         { Currently zero }
    wType: Word;             { 1 for icons }
    wCount: Word;            { Number of components }
  end;

  PIconResInfo = ^TIconResInfo;
  TIconResInfo = packed record
    bWidth: Byte;
    bHeight: Byte;
    bColorCount: Byte;
    bReserved: Byte;
    wPlanes: Word;
    wBitCount: Word;
    lBytesInRes: DWORD;
    wNameOrdinal: Word;      { Points to component }
  end;

  PCursorResInfo = ^TCursorResInfo;
  TCursorResInfo = packed record
    wWidth: Word;
    wHeight: Word;
    wPlanes: Word;
    wBitCount: Word;
    lBytesInRes: DWORD;
    wNameOrdinal: Word;      { Points to component }
  end;
{$ENDIF} 
{$ENDIF} // WIN

  TInitProcClass=class
  end;

  TVerbObject = class(TPersistent)
  end;

  TPropReader = class(TReader)
  public
    SkipObject : TObject;

    constructor Create(Stream: TStream; BufSize: Integer; ASkipObject : TObject);

    procedure DefineProperty(const Name: string;
      ReadData: TReaderProc; WriteData: TWriterProc;
      HasData: Boolean); override;
    procedure DefineBinaryProperty(const Name: string;
      ReadData, WriteData: TStreamProc;
      HasData: Boolean); override;
  end;

  TMWriter = class(TWriter)
  public
    SkipObject : TObject;

    constructor Create(Stream: TStream; BufSize: Integer; ASkipObject : TObject);

    procedure DefineProperty(const Name: string;
      ReadData: TReaderProc; WriteData: TWriterProc;
      HasData: Boolean); override;
    procedure DefineBinaryProperty(const Name: string;
      ReadData, WriteData: TStreamProc;
      HasData: Boolean); override;
  end;


  TVerbClass=class of TVerbObject;

  TVerbState=(vsVisible,vsEnabled,vsChecked);
  TVerbStates=set of TVerbState;
  TGetVerbStateProc=procedure(Var VerbStates:TVerbStates);
  TExecuteVerbProc=procedure;

  TVerbData=record
    Name:String;
    GetState:TGetVerbStateProc;
    Execute:TExecuteVerbProc;
  end;


  TCompareParam=(cpIgnoreCase,cpPartialCompare);
  TCompareParams=set of TCompareParam;
  TObjectParamListItem = class;

  TFilerID = string;

  PScriptErrorInfo = ^TScriptErrorInfo;
  TScriptErrorInfo = record
    FilerID   : TFilerID;
    FileName  : TFileName;
    CharPos   : integer;
    LinePos   : integer;
    ExcepInfo : TExcepInfo;
  end;

  TWMScriptError = record
    Msg       : Cardinal;
    ErrorInfo : PScriptErrorInfo;
    LParam    : Longint;
    Result    : Longint;
  end;

  TInitProc=procedure;

  TListWrapper = class
  private
    FList:TSortedList;
    function GetCount:Integer;
    function GetClass(Index:Integer):TClass;
    function GetObject(Index:Integer):TObject;
  public
    constructor Create;
    destructor Destroy;override;
    procedure Add(P:Pointer);
    procedure Remove(P:Pointer);
    property Classes[Index:Integer]:TClass Read GetClass;
    property Objects[Index:Integer]:TObject Read GetObject;
    property Count:Integer Read GetCount;
  end;
  
  TFileSystemLevel=(flFullSupport,flOnlyGetStream);

  { maybe ExtractFilePath,ChangeFileExt,ExtractFileName must be in filesystem also }
  TFileSystem=class(TComponent)
  public
    procedure RenameFileExcept(const FileName,ToFileName:String);virtual;
    procedure DeleteFileExcept(const FileName:String);virtual;

    function GetCurrentDir:String;virtual;
    procedure SetCurrentDir(const Dir:String);virtual;
    function GetFileStream(const FileName: TFileName; Mode: Integer): TStream;virtual; abstract;
    function FileAge(const FileName: TFileName): Integer;virtual;
    function RenameFile(const OldName, NewName: TFileName): Boolean;virtual;
    function IsReadonly(const FileName: TFileName): Boolean;virtual;
    function DeleteFile(const FileName: TFileName): Boolean;virtual;
    function FileExists(const FileName: TFileName): Boolean;virtual; abstract;
    function GetTempFileName(const FileName: TFileName): TFileName; virtual;
    function GetBackupFileName(const FileName: TFileName): TFileName; virtual;
    function GetFileSystemLevel:TFileSystemLevel;virtual;
    function ChangeFileExt(const FileName, Extension : string) : string; virtual;
    property CurrentDir:String Read GetCurrentDir Write SetCurrentDir;
  published
  end;

  TFileSystemClass=class of TFileSystem;

{$IFDEF WIN}
{$IFNDEF CLX}

  TResFileSystem = class(TFileSystem)
  private
    fFileName : string;
    fModuleHandle : THandle;

    procedure SetFileName(const val : string);
  protected
    procedure SplitFileName(var FileName : string; var ResType : PChar; var ResName : string);
    procedure OpenModule;
    procedure CloseModule;
  public
    destructor Destroy; override;
    function FileExists(const FileName: TFileName): Boolean; override;
    function GetFileStream(const FileName : TFileName; Mode : Integer) : TStream; override;
    function GetFileSystemLevel : TFileSystemLevel; override;
  published
    property FileName : string read fFileName write SetFileName;
  end;

  TResWriteStream = class(TMemoryStream)
  private
    fModified : boolean;
    fInitSize : integer;
    fResName  : string;
    fResType  : PChar;
    fFileName : string;
  public
    constructor Create(const FileName : string;
                       const ResName : string; ResType : PChar; Mode : integer);
    destructor  Destroy; override;
    function    Write(const Buffer; Count: Longint): Longint; override;
  end;
{$ENDIF}
{$ENDIF}

  TWin32FileSystem=class(TFileSystem)
  public
    function GetCurrentDir:String;override;
    procedure SetCurrentDir(const Dir:String);override;
    function GetFileStream(const FileName: TFileName; Mode: Integer): TStream;override;
    function FileAge(const FileName: TFileName): Integer;override;
    function RenameFile(const OldName, NewName: TFileName): Boolean;override;
    function IsReadonly(const FileName: TFileName): Boolean;override;
    function DeleteFile(const FileName: TFileName): Boolean;override;
    function FileExists(const FileName: TFileName): Boolean;override;
    function GetTempFileName(const FileName: TFileName): TFileName; override;
  end;

  PDesignResFormData=^TDesignResFormData;
  TDesignResFormData=packed record
    ResName:String;
    ResType:PChar;
  end;

  TCallType = (cRegister, cPascal, cCdecl, cStdCall, cSafeCall);

  TMethodType = (mtProc, mtMethod, mtClassMethod, mtConstructor, mtDestructor, mtScriptProc, mtScriptMethod);

  TAlignControls  = (acNoChange, acLefts, acTops, acCenters, acRights, acBottoms,
                     acSpaceEqually, acCenterInWindow);

  TActionProc=procedure(Instance:TPersistent);

  TIntegerSet = set of 0..SizeOf(Integer) * 8 - 1;

  TFindComponentProc = function(const Name : string) : TComponent of object;

  TMessageAnswer=class
  public
    constructor Create;
    destructor Destroy;override;
  end;

  TListIteratorProc=procedure (Item:TObject;ItemIndex:Integer;
    Var AContinue:boolean) of object;

  TCharSet = set of char;

  TFileFoundCallBack=procedure (const Path:String;const SearchRec: TSearchRec;
    Var AContinue:boolean) of object;

  PMethodTable=^TMethodTable;
  TMethodTable=packed record
    Size:Word;
    MethodDefs:Array[0..1000] of byte;
  end;

  PMethodDef=^TMethodDef;
  TMethodDef=packed record
    Size : Word;
    Addr : Pointer;
    Name : ShortString;
  end;

  TNotifierProc=procedure(Sender:TObject;wParam,lParam:Integer) of object;


  TNotifierListItem=class(TCollectionItem)
  public
    Method:TNotifierProc;
  end;

  TNotifierList=class//{$IFDEF D3}(TInterfacedObject,IDCNotifierList){$ENDIF}
  private
    FCollection:TCollection;
(*
    {$IFDEF D3}
    procedure IDCNotifierList.Notify=NotifyEvents;
    procedure IDCNotifierList.RegisterNotifier=AddMethod;
    procedure IDCNotifierList.UnRegisterNotifier=DeleteMethod;
    {$ENDIF}

*)
  protected
    property Notifiers:TCollection Read FCollection;
  public
    procedure   NotifyEvents(Sender:TObject;wParam,lParam:Integer);
    constructor Create;
    destructor Destroy;override;
    procedure   AddMethod(T:TNotifierProc);
    procedure   DeleteMethod(T:TNotifierProc);
    procedure   DeleteWithData(Data:Pointer);
  end;

{$IFDEF WIN}
{$IFNDEF CLX}

  TActiveNotifier = class(TCustomActiveNotifier)
  private
    FVersion : TDCVersion;
  published
    property Version : TDCVersion read FVersion write FVersion;
    property OnActiveChanged;
  end;

  TRegistryStream = class(TMemoryStream)
  private
    fModified : boolean;
    fkey      : string;
    fInitSize : integer;
  public
    constructor Create(const Key : string; Mode : integer);
    destructor  Destroy; override;
    function    Write(const Buffer; Count: Longint): Longint; override;
  end;
{$ENDIF}
{$ENDIF}

  TSimpleParser = class(TComponent)
  private
    FNotifiers        : TNotifierList;
  protected
    FLinePos          : Integer;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure UpdateLinePos(Value : integer); virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure RegisterNotifier(W : TNotifierProc);
    procedure UnRegisterNotifier(W : TNotifierProc);
    {$IFDEF WIN}
    function GetFont(AState: integer): TFont; virtual;
    function GetBackColor(AState: integer; var Color :  TColor) : boolean; virtual;
    {$ENDIF}
    function ColorString(const StrData: String; InitState: Integer;
      var AColorData: String): Integer; virtual; abstract;

    function  StoreColorData : boolean; virtual;
    procedure PrepareColorData(LinePos : integer; const s : string ; var ColorData : string); virtual;

    property  Notifiers : TNotifierList read FNotifiers;
  end;

  TSimpleParserClass=class of TSimpleParser;

  TShowSourceEvent = procedure (Sender : TObject; x, y : integer) of object;
  TMethodState = (msEmpty, msNotPresent, msOk);

  TCodeDesigner = class(TComponent)
  private
    fModuleOwner : TComponent;
    fOnShowSource : TShowSourceEvent;
  protected
    procedure SetStrings(val : TStrings); virtual;abstract;
    function  GetStrings : TStrings; virtual;abstract;
    procedure ShowSource(x, y : integer);virtual;
  public
    function  GetSyntaxParserClass:TSimpleParserClass;virtual;
    procedure CreateMethod(const MethodName : string; TypeData : PTypeData); virtual; abstract;
    procedure ShowMethod(const MethodName : string); virtual; abstract;
    procedure RenameMethod(const OldName, NewName : string); virtual; abstract;
    procedure DeleteMethod(const MethodName : string); virtual; abstract;
    procedure DeleteEmptyMethods; virtual; abstract;
    procedure GetMethods(TypeData : PTypeData; S : TStrings); virtual; abstract;
    function  MethodExists(const MethodName: string): boolean; virtual; abstract;

    procedure InsertComponent(Comp : TComponent; const CompName : string); virtual;abstract;
    procedure DeleteComponent(Comp : TComponent); virtual; abstract;
    procedure RenameComponent(Comp : TComponent; const NewName : string); virtual; abstract;
    function  ValidIdentifier(const Ident : String) : boolean; virtual; abstract;

    function  GetMethodState(const MethodName : string) : TMethodState;virtual;abstract;
    procedure GetUsedUnits(S : TStrings; InInterface : boolean); virtual; abstract;
    procedure UseUnits(S : TStrings; InInterface : boolean); virtual; abstract;
    function  AutoFillUses : boolean; virtual; 

    procedure RenameModule(const OldName,NewName : string); virtual;
    procedure FillWithTemplate(const ModuleName:String;NewTemplate:boolean); virtual; abstract;

    function TypeToString(TypeCode : integer) : string; virtual; abstract;

    function GetDelimiters : string; virtual;
    property ModuleOwner : TComponent read fModuleOwner write FModuleOwner;
    property Strings : TStrings read GetStrings write SetStrings;
  published
    property OnShowSource:TShowSourceEvent Read fOnShowSource Write fOnShowSource;
  end;

  TCodeDesignerClass=class of TCodeDesigner;

  TDCNamedItems=class(TCustomDCNamedItems)
  public
    procedure LoadFromFile(const FileName:String);
    procedure LoadFromStream(S:TStream);
    procedure SaveToStream(S:TStream);
    procedure SaveToFile(const FileName:String);
  end;


  TObjectParamListItem = class(TCollectionItem)
  private
    FParamList:TStringList;
    function GetObjectPtr:TObject;
    function GetClassPtr:TClass;
    function GetParamByName(const Name:String):Variant;
    procedure SetParamByName(const AName:String; const Value:Variant);
  protected
  public
    DataPtr:Pointer;
    IsClass:boolean;
    EditorGroup:Integer;
    property ObjectPtr:TObject Read GetObjectPtr;
    property ClassPtr:TClass Read GetClassPtr;
    constructor Create(ACollection:TCollection);override;
    destructor Destroy;override;
    property Params[const Name:String]:Variant Read GetParamByName Write SetParamByName;
  end;

  TObjectParamListIterator=
    function(Item:TObjectParamListItem;const AParams:Array of variant;
      Var Finish:boolean):Variant of object;

  TObjectParamList = class(TCollection)
  private
    function GetItem(Index:Integer):TObjectParamListItem;
  public
    function ItemByDataPtr(p:Pointer):TObjectParamListItem;
    constructor Create;
    function ForEveryClass(C:TClass;const AParams:Array of variant;
               Iterator:TObjectParamListIterator):Variant;

    property Items[Index:Integer]:TObjectParamListItem Read GetItem;default;
  end;

{$IFNDEF D3}
type
  IEnumGUID = class(IUnknown)
    function Next(celt: UINT; var rgelt: TGUID; var pceltFetched: UINT): HResult; virtual; stdcall; abstract;
    function Skip(celt: UINT): HResult; virtual; stdcall; abstract;
    function Reset: HResult; virtual; stdcall; abstract;
    function Clone(var ppenum: IEnumGUID): HResult; virtual; stdcall; abstract;
  end;

  PCATEGORYINFO = ^TCATEGORYINFO;
  TCATEGORYINFO = record
    catid: TGUID;
    lcid: UINT;
    szDescription: array[0..127] of WideChar;
  end;

  IEnumCATEGORYINFO = class(IUnknown)
    function Next(celt: UINT; var rgelt: TCATEGORYINFO; var pceltFetched: UINT): HResult; virtual; stdcall; abstract;
    function Skip(celt: UINT): HResult; virtual; stdcall; abstract;
    function Reset: HResult; virtual; stdcall; abstract;
    function Clone(var ppenum: IEnumCATEGORYINFO): HResult; virtual; stdcall; abstract;
  end;

  ICatInformation = class(IUnknown)
    function EnumCategories(lcid: UINT; var ppenumCategoryInfo: IEnumCATEGORYINFO): HResult; virtual; stdcall; abstract;
    function GetCategoryDesc(const rcatid: TGUID; lcid: UINT; var pszDesc: PWideChar): HResult; virtual; stdcall; abstract;
    function EnumClassesOfCategories(cImplemented: UINT; rgcatidImpl: Pointer; cRequired: UINT; rgcatidReq: Pointer; var ppenumClsid: IEnumGUID): HResult; virtual; stdcall; abstract;
    function IsClassOfCategories(const rclsid: TGUID; cImplemented: UINT; rgcatidImpl: Pointer; cRequired: UINT; rgcatidReq: Pointer): HResult; virtual; stdcall; abstract;
    function EnumImplCategoriesOfClass(var rclsid: TGUID; var ppenumCatid: IEnumGUID): HResult; virtual; stdcall; abstract;
    function EnumReqCategoriesOfClass(var rclsid: TGUID; var ppenumCatid: IEnumGUID): HResult; virtual; stdcall; abstract;
  end;
{$ENDIF}

type

  TStringListClass=class of TStringList;

  TBuildCompNameFunc = function (Comp : TPersistent; const AName : string) : string;
  TFindExpression = function(const S : string; var AStart, ALen : integer; Direction : boolean): boolean of object;

  TGetColorDataEvent = procedure(Sender: TObject; Token: Integer;
    const TokenStr: string; var ColorData: string) of object;

  {-------------------------------------------------------------}

//=========================================================================
// globproc
// ------------------------ global procedures and functions ------------------

function GetOriginalComponentName(const Name : string) : string;

{$IFDEF WIN}
{$IFNDEF CLX}
procedure AddResFromFile(const SrcFile,DstFile, ResName : string);
{$ENDIF}
{$ENDIF}

function  UnderWindowsNT : boolean;

{$IFDEF DEBUG_}
procedure DebugRect(Const S:String;R:TRect);
{$ENDIF}

function RectToStr(const R:TRect):String;
function PointToStr(const P:TPoint):String;

function RectWidth(const R:TRect):Integer;
function RectHeight(const R:TRect):Integer;

function CurrentYear:Word;
function IsLeapHour(Hour:Integer):boolean;
function IsLeapMinute(Minute:Integer):boolean;


// -------------------- Log file procedures --------------------

{$IFDEF WIN}
{$IFNDEF CLX}
function GetLogDataFileName:String;
{$ENDIF}
{$ENDIF}

var
  DCLogFileShowGUID:boolean;
  DCLogFileShowTime:boolean;
  DCLogFileWriteln:boolean;
  DCLogSuspend:Integer;

procedure WriteToLog(const Value:Variant);
procedure DoWriteToLog(const Value:Variant);
procedure MapLogFileToWriteln;

// -------------------- EnvOptions extensions --------------------

{$IFDEF WIN}
procedure RegisterOptionExt(OptionExtClass:TOptionExtClass);
function  GetOptionsByClass(OptionClass : TOptionExtClass) : TOptionExt;
procedure SaveGlobalOptions;
{$ENDIF}

// -------------------- Verb support --------------------

function GetVerbProcAddr(const VerbName:String;
           Var VerbGetState:TGetVerbStateProc;var VerbExecute:TExecuteVerbProc):TObjectParamListItem;
procedure CallVerbByName(const VerbName:String);

procedure RegisterVerb(const VerbName:String;
            GetVerbState:TGetVerbStateProc;
            ExecuteVerb:TExecuteVerbProc);

procedure RegisterVerbArray(const VerbArray:Array of TVerbData);

// -------------------- Delphi related --------------------

{$IFDEF WIN}
{$IFNDEF CLX}
function CompiledWithPackages:boolean;
function StrToDelphiVers(const Vers:String):TDelphiVers;

// -------------------- File system routines --------------------
function GetResFileSystemFilerID(const AFileName : string) : TFilerID;
{$ENDIF}
{$ENDIF}
function GetFilerID(FileSystem:TFileSystem):TFilerID;
function GetFileSystem(const FilerID:TFilerID):TFileSystem;
procedure ReleaseFileSystem(AFileSystem:TFileSystem);
function Win32FileSystem:TWin32FIleSystem;

// -------------------- OLE support --------------------
{$IFDEF WIN}
{$IFNDEF CLX}
function CreateNewGUID:TGUID;
function  ExtractControlName(const aname : string) : string;
function  GetTypeLibName(const guid : TGUID) : string;
function  ExtractActiveXHint(Const AHint:String):String;
procedure RegisterOCX(const FileName : string);
{$ENDIF}
{$ENDIF}

procedure SetPropByDispatch(const disp : IDispatch; ID : TDispID; const Value : OleVariant);

// -------------------- change params --------------------

function ChangeParamsEx(const S:String;Params:TStrings;ParamSep:Char):String;


procedure ChangeParamsInStringsEx(S,Params:TStrings;ParamSep:Char);
procedure ChangeParamsInStrings(S,Params:TStrings);
procedure ChangeParamsInFile(const FileName:String; Params:TStrings);

procedure ChangeParamsInFiles(const Dir,FileMasks:String; Attr: Integer;
            Params:TStrings; SubFolders:boolean);

// -------------------- keyboard handling --------------------

{$IFDEF WIN}
{$IFNDEF CLX}
Function  ShiftIsPressed:Boolean;
function  IsAltKeyDown:Boolean;
function  KeysToShift:TShiftState;
{$ENDIF}
{$ENDIF}
// -------------------- string handling --------------------

function ExtractQuotedStr(const s : string; QuoteChar : char) : string;

procedure SaveStringToFile(const FileName,DataStr:String);

function StrToBoolean(const S:String):boolean;
function RemoveExtraSlash(const FileName:String):String;

function ShortMonthNameToIndex(const ShortMonthName:String):Integer;
procedure ReplaceAllOccurEx(var S:String;const FromStr,ToStr:String;
            IgnoreCase:boolean);
procedure ReplaceAllOccur(var S:String;const FromStr,ToStr:String);
function GetWord(const S:String;NumberOfWord:Integer):String;
function GetWordPos(const S:String;NumberOfWord:Integer;const Separators : TCharSet):Integer;
function GetWordEx(const S:String;NumberOfWord:Integer; const Separators : TCharSet):String;

function ExtractOnlyName(const FileName:String):string;
function TrimSeparatorsLeft(const S: string;Separators:TCharSet): string;
function TrimSeparatorsRight(const S: string;Separators:TCharSet): string;
function TrimSeparators(const S: string;Separators:TCharSet): string;

procedure Replace(var s : string; index : integer; const OldStr, NewStr : string);
function CommaText(const StringArray:Array of String):String;
function  StringOfSpace(Num:Integer):String;
procedure AddBackSpaces(Var S:String;Len:Integer);
function  PReadShortStr(var p : pchar) : string;
function  RemoveNonIdentChars(Const N:String):String;
procedure AddStr(var BaseString:String;const AddString:String);
Function  GetFirstNotSpace(Const S:String):Integer;
function  AddCharOccurence(Const S:String;C:Char;Count:Integer):String;
Function  RemoveCharSet(Const CharSet:TCharSet;Const S:String):String;
function  DCRemovePoints(Const S:String):String;
function  RemoveStrSet(const StrSet,S:String;CaseSens:Boolean):String;
function  StringToCharSet(InitValue:TCharSet;const S:String;CaseSens:Boolean):TCharSet;
function  StringFromRType(RType:Pchar):string;
function  StringFromRName(ResName : pchar) : string;
function  StrArrayToDelimStr(const StrArray : array of string; Delim:Char):String;

// -------------------- TStrings handling -------------------

function FindNextInStrings(const TextToFind:String;S:TStrings;
           CaseSens:boolean;Var P:TPoint; var Len : integer; FindRoutine : TFindExpression):boolean;
function FindFirstInStrings(const TextToFind:String;S:TStrings;
           CaseSens:boolean;Var P:TPoint; var Len : integer;FindRoutine : TFindExpression):boolean;

function FindInStringsEx(const TextToFind:String;S:TStrings;SearchParams:TSearchParams;
         Const DelimSet:TCharSet;Var P:TPoint; var Len : integer; FindRoutine : TFindExpression):boolean;

procedure ExtractFilePaths(Source,Dest:TStrings);
procedure SortAndRemoveDups(S:TStrings);
procedure OperateStrings(S:TStrings;StringsProc:TStringsOperateProc);
procedure RemoveEmptyStrings(S:TStrings);
function  StringsToString(S : TStrings; Separator : Char) : string;
procedure StringsObjectsToList(Strings:TStrings;List:TList);
function  CreateSortedStringList:TStringList;
function CreateSortedStringListEx(C:TStringListClass):TStringList;
procedure FreeStringsObjects(Strings:TStrings);
procedure FreeStrings(var Strings);
procedure ClearStrings(S : TStrings);
procedure EditStringsProperty(Instance : TComponent; const PropName : string);
procedure ValuePartToStrings(Source,Dest:TStrings);
procedure NamePartToStrings(Source,Dest:TStrings);
Procedure StringsToProc(S:TStrings; Proc: TGetStrProc);
procedure AnsiUpperCaseStrings(S : TStrings);
procedure SubtractStrings(S1,S2:TStrings);
procedure AnsiLowerCaseStrings(S : TStrings);
procedure RemoveStrings(FromStrings,StringsToRemove:TStrings);
procedure StrArrayToStrings(Strings:TStrings;const A:Array of string);
procedure IntersectStrings(Source, Dest : TStrings);

Function DCGetUnitSource( Var AUnitName : String; Const AIncludePath : string;
                          AUnitsSource : TStrings ) : Boolean;

// ------------------- TStream handling --------------------

function  GetClassFromStream(S : TStream) : TComponentClass;
function SmartSkipResHeader(S:TStream;OnlyCheck:boolean):boolean;
procedure _WritePropsToStream(Writer : TWriter; Inst : TComponent; PropNames : TStrings);
procedure WritePropsToStream(Stream : TStream; Instance : TComponent; const PropNames : array of string);
procedure ReadPropsFromStream(Stream : TStream; Instance : TComponent);
procedure WriteWord(S:TStream;Value:Word);
procedure WriteInt(S:TStream;Value:Integer);
procedure WriteShortStr(S:TStream;Const St:String);

Procedure DCWriteStrWithLenToStream( AStream : TStream; Const AStr : String );
Function  DCReadStrWithLenFromStream( AStream : TStream ) : String;

// ------------------- TList handling ----------------------

function  CreateListIfEmpty(var L:TList):TList;
procedure DisposeList(Var AList:TList);
function  EqualList(l1, l2 : TList) : boolean;
function  ListsInterSect(l1, l2 : TList) : boolean;
function  ForEachListItem(L:TList;ListIterator:TListIteratorProc):boolean;
procedure AddList(FromList,ToList : TList);
function  RemoveItem(List:TList;Item: Pointer): Integer;
function  CreateList:TList;
function  RemoveSortedItem(List:TSortedList;Item: Pointer): Integer;

// -------------------- TCollection handling ------------------------

procedure SetColItemDisplayName(T:TCollectionItem;const S:String);
function  GetColItemDisplayName(T:TCollectionItem):String;

// -------------------- different registration procedures -------------

function ObjectParamList:TObjectParamList;

procedure RegisterForDelphi(InitProc:TInitProc);
procedure RegisterForInstant(InitProc:TInitProc);

procedure RegisterUnitCodeDesigner(CodeDesigner:TCodeDesignerClass;const Extension:String);
procedure RegisterFormCodeDesigner(CodeDesigner:TCodeDesignerClass;const Extension:String);

function GetUnitCodeDesignerClass(const Extension:String):TCodeDesignerClass;
function GetFormCodeDesignerClass(const Extension:String):TCodeDesignerClass;

function RegisterClassExt(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant):TObjectParamListItem;

procedure UnRegisterClassExt(C : TClass);

procedure RegisterObjectEx(O:TObject;const ParamNames:Array of String;
            const ParamValues:Array of variant);

function GetClassEx(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;CompareParams:TCompareParams):TClass;

procedure GetRegisteredClasses(C:TClass;List:TList);

procedure GetItemsEx(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams;
            ResultList:TList);

function GetItemEqual(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TObjectParamListItem;

function GetItemInherited(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TObjectParamListItem;

function GetItemEx(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TObjectParamListItem;

function GetItemExParent(C,TopClass:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TObjectParamListItem;

function GetCodeDesignerClass(const Extension:String;ForUnit:boolean):TCodeDesignerClass;

function GetClassInherited(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TClass;
procedure SafeRegisterClasses(AClasses:Array of TPersistentClass);
procedure SafeRegisterClass(AClass: TPersistentClass);
function SetFindGlobalCompProc(Proc : TFindComponentProc):boolean;
procedure RemoveFindGlobalCompProc;

// -------------------- integer handling -------------------

function  MaxIntValue(const Data: array of Integer): Integer;

// -------------------- TObject and TClass handling -------------------


function  NameIsUnique(AOwner : TComponent; const AName : string) : boolean;
function  UniqueName(AOwner : TComponent; const BaseName: string): string;
function  FindUniqueName(const Name: string): string;
{$IFDEF WIN}
{$IFNDEF CLX}
function  GetClassModule(C:TClass):THandle;
{$ENDIF}
{$ENDIF}

procedure CompNamesToProc(container,OwnerComp : TComponent; TypeData: PTypeData;
            Proc: TGetStrProc);
procedure CompListNamesToProc(List:TList;OwnerComp : TComponent; TypeData: PTypeData;
            Proc: TGetStrProc);
Function  ClassNamePtr(A:TClass):Pointer;assembler;
procedure SetClassNamePtr(A:TClass;Value:Pointer);
procedure SetMethodTable(A:TClass;Value:Pointer);
Function  MethodTable(A:TClass):PMethodTable;assembler;
function  CallMethod(Data,Code:Pointer):integer;
Function  GetClassUnit(O:TObject):String;
function  GetCompName(Comp:TPersistent):String;
function  GetCommonParent(AClass,BClass:TClass):TClass;
function  GetCommonClassesParent(list : TList) : TClass;

// ---------------------- property handling ---------------------------

procedure PropNamesToStrings(Instance:TPersistent;PropNames:TStrings);
procedure AssignPropsFromStrings(Instance:TPersistent;Params:TStrings);
procedure SetEnabledControls(Const Ctrls:Array of TPersistent; Enabled:boolean);
procedure SetPropValues(const Ctrls:Array of TPersistent; const PropName:String; const Val:Variant);
procedure SetPropValue(Instance : TPersistent; const PropName : string; const Value : Variant);
function  GetPropValue(Instance : TPersistent; const PropName: string) : Variant;
function PropertyExists(C:TPersistent;const PropName:String):boolean;
procedure AssignProps(Source, Dest : TPersistent; PropNames : array of string);
procedure AssignPropsEx(Source,Dest:TPersistent; Const Propnames:String);

// -------------------- Coordinates (TPoint) handling -------------------

Procedure DCClearPointStruct( Var APoint : TPoint );
Function  DCIsPointStructClear( Const APoint : TPoint ) : Boolean;

// --------------------- Registry handling --------------------
{$IFNDEF CLX}
{$IFDEF WIN}
procedure AssociateFileExt(const DefaultExt, Description, CommandLine, IconHolder: string; DefaultIcon: integer);
procedure UnAssociateFileExt(const DefaultExt, Description : string);
procedure WriteObjToRegistry(const Key:String;Instance:TPersistent);
procedure ReadObjFromRegistry(const Key:String;Instance:TPersistent);
procedure WriteObjTextToRegistry(const Key:String;Instance:TPersistent);
procedure ReadObjTextFromRegistry(const Key:String;Instance:TPersistent);

procedure WriteBufToRegistry(const VarName:String; var Buf; size : integer);
function  ReadBufFromRegistry(const VarName:String; var Buf; size : integer) : integer;
function  GetRegBufSize(const VarName : string) : integer;
procedure WriteLongBufToRegistry(const VarName:String; var Buf; size : integer);
function  ReadLongBufFromRegistry(const VarName:String; var Buf; size : integer) : integer;
function  GetLongRegBufSize(const VarName : string) : integer;

procedure WriteToRegistry(Const VarName:String;const VarValue:Variant);
function  ReadFromRegistry(Const VarName:String;const DefaultValue:Variant):Variant;
procedure ReadStringsFromRegistry(Const VarName:String;S:TStrings);
procedure WriteStringsToRegistry(Const VarName:String;S:TStrings);
procedure ReadPropsFromRegistry(Instance : TPersistent; const Key : string);
procedure WritePropsToRegistry(Instance : TPersistent; const Key : string);
function  RegValueExists(Const VarName : String) : boolean;

Function  DCDeleteRegKey( ABaseKey : HKey; Const AKeyPath, ADeletingKey : String ) : Boolean;
{$ENDIF}
{$ENDIF}
// --------------------- files and resource handling --------------------

procedure ModifyFileAttr(const FileName:String;RemoveAttr,AddAttr:Integer);
procedure ModifyFilesAttr(Files:TStrings;RemoveAttr,AddAttr:Integer);
procedure ModifyFilesAttrInFolder(const FileMask:String;
            RemoveAttr,AddAttr:Integer;SubFolders:boolean);

function ChangeFileName(const FileName,NewName:String):String;

Function DCRelativeFileSearch( Const ARelativeFileName, APaths : String ) : String;
Function DCExpandRelativeFileEx( Const ABasePath, ARelativeFileName : String ) : String;
Function DCExpandRelativePathEx( Const ABasePath, ARelativePath : String ) : String;

{$IFDEF WIN}
{$IFNDEF CLX}
function IsFormInResource(const FileName,ResName: string; ResType: PChar):boolean;
function ResourceUpdate (Const Filename : string; ResType : PChar; const ResName : String; IDLanguage : word;
                         Data : pointer; DataLength : integer) : boolean;
{$ENDIF}
{$ENDIF}

function ExpandRelativePath(const BaseName,RelativeName:String; const AFilerID : TFilerID):string;
function ExpandRelativeFileName(const BaseFileName, RelativeFileName : String;
                                AFilerID : TFilerID) : String;

procedure FindFilesEx(const Path,FileMasks:String;
            Attr: Integer;SubFolders:boolean;Files:TStrings);

procedure FindFiles(const Path: string; Attr: Integer;SubFolders:boolean;
            Files:TStrings);

{$IFNDEF CLX}
function TempFileName(const FileName: TFileName): TFileName;
{$ENDIF}
function AppFolder:String;

function  ForEachFile(const Path: string; Attr: Integer;SubFolders:boolean;
            CallBack:TFileFoundCallBack):Integer;
procedure RenameToBak(Const Path:String);
Function  FileBakName(Const Path:String):String;

// ---------------------- notification procedure ---------------

procedure NotifyDestroy(Instance:TObject);
procedure NotifyDestroying(Sender : TComponent; Notifiers : TNotifierList);
procedure NotifyDestroyObjects(List : TList);
procedure ShowInspector;
procedure ToggleInspector;
procedure ShowInspectorEx(MakeTop:boolean);
procedure HideInspector;
procedure SimpleBroadCast(M:Integer);
procedure RegisterNotifier(C:TObject);
procedure UnregisterNotifier(C:TObject);
procedure IDEChanged;
procedure IDEBeginUpdate;
procedure IDEEndUpdate;
function  BroadcastToNotifiersEx(Self:TObject;Msg: Cardinal; WParam, LParam: Longint;
            ExitOnDisagree:boolean):boolean;
function  BroadcastToNotifierList(Self:TObject;Notifiers:TList;Msg: Cardinal; WParam, LParam: Longint;
            ExitOnDisagree:boolean):boolean;
procedure BroadCastToNotifiers(Self:TObject;Msg: Cardinal; WParam, LParam: Longint);
function  NotifiersAgree(Self:TObject;Msg: Cardinal; WParam, LParam: Longint):boolean;

// ----------------------------  different graphic procedures ----------
{$IFDEF WIN}
{$IFNDEF CLX}
function  GetTransparentColor(dc : THandle; const arect : TRect) : longint;
Procedure TransparentBitBltEx(sourcedc, destdc: THandle; SrcRect,DstRect: TRect;
    atranscolor: longint);
procedure TransparentBitBlt(sourcedc, destdc : THandle; arect : TRect;
            atranscolor : longint;aoriginX,aoriginY:Integer);

Procedure CorrectRectByRect(Var InRect:TRect;const OutRect:TRect);
procedure DrawTextWithFill(Canvas : TCanvas; const Str : String; Mode : Integer; AllRect : TRect);
procedure FillRectEx(Canvas : TCanvas; const ARect, ExcludeRect : TRect);
Function AlignRectByRect(const ARectIn,ARectOut:TRect;
                          HorzAlignment:THorzAlignment;
                          VertAlignment:TVertAlignment;
                          AMinHSpace,AMinVSpace:Integer):TRect;

function GetComponentTopLeft(Instance : TComponent) : TPoint;
procedure SetComponentTopLeft(Instance : TComponent; Position : TPoint);

// ---------------------------- D2 support ----------------------

function  StringToGUID(const S: string): TGUID;
function  GUIDToString(const ClassID: TGUID): string;
{$ENDIF}
{$ENDIF}

{$IFNDEF D3}

{------------------------------------------------------------------}

function  CompareMem(P1, P2: Pointer; Length: Integer): Boolean; assembler;

var
  LeadBytes: set of Char = [];

function  AnsiStrIComp(S1, S2: PChar): Integer;
function  ExtractRelativePath(const BaseName, DestName: string): string;

{$ENDIF}


function BuildCompName(Comp:TPersistent; Const AName : string) : string;
function  ConvertDelphiTypeToString(TypeCode : integer) : string;


//=========================================================================
// globvar
// ------------------------ global variables declaration ------------------

Var
  BuildCompNameFunc : TBuildCompNameFunc = nil;
  WriteLogEvent:TWriteLogEvent=nil;
  RegistryKey : String = SDefaultRegKey;
  IDEUpdateCount:Integer=0;
  UnderDelphiIDE:boolean;
  ClassPrefix: string = 'T';

//=========================================================================
// _consts
// ------------------------ constant declaration ------------------

const
  dispparamsNoArgs : TDispParams = (rgvarg:nil; rgdispidNamedArgs:nil; cArgs:0; cNamedArgs:0);
const
  boolShowHelpButton : boolean = False;

  PCharTypeInfo     = 1;
  PWideCharTypeInfo = 2;
  RealTypeInfo      = 3;
  UntypedTypeInfo   = 4;
  ArrayOfConstInfo  = 5;
  PointerInfo       = 6;

  TypeInfoReal = pointer(RealTypeInfo);
  TypeInfoUntyped = pointer(UntypedTypeInfo);
  TypeInfoArrayOfConst = pointer(ArrayOfConstInfo);
  TypeInfoPointer = pointer(PointerInfo);

  tNoTypeInfoTypes = [PCharTypeInfo, PWideCharTypeInfo, RealTypeInfo, UntypedTypeInfo, ArrayOfConstInfo, PointerInfo];

  NoParams : array [0..0] of PTypeInfo = (pointer(1));

  DefaultRegBlockSize : integer = 8192; // used when storing large data in registry under Win95/98

  NullInt : integer = 0;

{ Resource Type Constants }
  StringsPerBlock = 16;
//BeginSkipConst
  PredefinedResourcesTypesNames : array[1 .. 22] of string =
  ('CURSOR',         //  1
   'BITMAP',         //  2
   'ICON',           //  3
   'MENU',           //  4
   'DIALOG',         //  5
   'STRING',         //  6
   'FONTDIR',        //  7
   'FONT',           //  8
   'ACCELERATOR',    //  9
   'RCDATA',         //  10
   'MESSAGETABLE',   //  11
   'GROUP_CURSOR',   //  12
   '',               //  13
   'GROUP_ICON',     //  14
   '',               //  15
   'VERSION',        //  16
   'DLGINCLUDE',     //  17
   '',               //  18
   'PLUGPLAY',       //  19
   'VXD',            //  20
   'ANICURSOR',      //  21
   'ANIICON');       //  22
//EndSkipConst

  _Package : THandle=0;
  DesignerInsertClass : string='';

{$IFNDEF D3}
  IID_ICatInformation : TGUID = (D1:$0002E013; D2:0000; D3:0000; D4:($C0,00,00,00,00,00,00,$46));
  CLSID_StdComponentCategoryMgr: TGUID = (D1:$0002E005; D2:0000; D3:0000; D4:($C0, 00, 00, 00, 00, 00, 00, $46));
  GUID_OLE_COLOR: TGUID = (D1 : $66504301; D2 : $BE0F; D3 : $101A; D4 : ($8B,$BB,$00,$AA,$00,$30,$0C,$AB));

  {$IFDEF VER93}
  vmtMethodTable       = -48;
  vmtClassName         = -40;
  {$ELSE}
  vmtClassName         = -28;
  vmtMethodTable       = -36;
  {$ENDIF}
{$ENDIF}

  FilerSignature: array[1..4] of Char = 'TPF0'; // don't resource

  cDelphiDelimiters = '/{}+-*():=,;><$.#[]^@&~|%'''; // don't resource

  ssAShift  : TShiftState = [ssShift,ssAlt];
  ssCAShift : TShiftState = [ssShift,ssAlt,ssctrl];
  ssCShift  : TShiftState = [ssShift,ssctrl];

  StringTypes:TTypeKinds=[tkString,tkWChar, tkLString{$IFDEF D3} ,tkWString {$ENDIF}];

  RegistrationURL = 'http://www.dream-com.com/ordering.html'; // don't resource
  WriteToUsURL='mailto: contact@dream-com.com'; // don't resource
  HomePageURL='http://www.dream-com.com'; // don't resource

  scNoChange = -1;
  scShrinkToSmallest = -2;
  scGrowToLargest = - 3;

  MinVMTOffset = - 200;
  
procedure RegisterKeyboardInitProc(C:TClass;const ProcName:String;Proc:TKeyboardInitProc);
function  GetKeyboardInitProc(C:TClass;const ProcName:string):TKeyboardInitProc;

{$IFDEF WIN}
{$IFNDEF CLX}
procedure InitIDENotifier;
function  GetDreamRegKey(const key: string):string;
procedure SetRootRegKey(const key : HKEY);
Procedure SaveComponentToIniFile(Instance:TPersistent;const Key:String);
Procedure LoadComponentFromIniFile(Instance:TPersistent;const Key:String);
{$ENDIF}
{$ENDIF}

type
  TEditSource = class (TComponent)
  protected
    function  GetValue : string; virtual; abstract;
    procedure SetValue (const val : string); virtual; abstract;
  public
    procedure StartEdit; dynamic;
    property  Value : string read GetValue write SetValue;
  end;

  TEditSourceClass = class of TEditSource;

  {$IFDEF WIN}
  TPackagedCollectionItem=class(TCollectionItem)
  public
    PackageHandle:THandle;
    DesignGroup:Integer;
  end;

  TPackagedCollection=class(TCollection)
  protected
    procedure CMFREEEDITGROUP(Var M:TMessage); message CM_FREEEDITGROUP;
  public
    function Add : TPackagedCollectionItem;
    constructor Create(ItemClass: TCollectionItemClass);
    destructor Destroy;override;
    procedure DeleteItems(DesignGroup:Integer);
    function  Last : TPackagedCollectionItem;
    property Items[Index: Integer]: TCollectionItem read GetItem write SetItem; default;
  end;

  TClassItemCat=(icNonActiveX,icField,icNoIcon,icShowinPalette);
  TClassItemCats=set of TClassItemCat;

  TClassItem=class(TPackagedCollectionItem)
  public
   ClassPtr:TClass; // class
   Categories:TClassItemCats;
   PalettePage:String;
  end;


  TClassItems = class(TPackagedCollection)
  public
   { Call this function to determine is class iconic or not. (Iconic class is class
     that will be seen on the form during design and will be included in combo of object
     inspector form. For example field classes aren't iconic)}
   function  IsIconClass (c : TComponentClass) : boolean;

   procedure ListFieldClasses(L:TList);

   function RegisterClass(AClassPtr:TClass;ACategories:TClassItemCats):TClassItem;
   constructor Create;
  end;
  {$ENDIF}

Var
  OptionsFileName:TFileName;
  StoreOptionsInFile:Boolean;

// ------------------------ DCEdit_registration --------------

{$IFDEF WIN}
function PopupClasses      : TPackagedCollection;
function EditSourceClasses : TPackagedCollection;
function EditClasses       : TPackagedCollection;

procedure RegisterPopupClass(PropertyType: PTypeInfo; ComponentClass: TClass;
  const PropertyName: string; EditorClass: TComponentClass);

procedure RegisterEditSource(AClass : TEditSourceClass);

procedure RegisterEditClass(PropertyType: PTypeInfo; ComponentClass: TClass;
  const PropertyName: string; EditorClass: TComponentClass);

procedure RegisterTextEditClass(PropertyType: PTypeInfo; ComponentClass: TClass;
  const PropertyName: string; EditorClass: TComponentClass);

function IsTextEditClass (EditorClass : TComponentClass) : boolean;

procedure UnRegisterPopupClass(PropertyType: PTypeInfo; ComponentClass: TClass;
                   const PropertyName: string; EditorClass: TComponentClass);

procedure UnRegisterEditClass(PropertyType: PTypeInfo; ComponentClass: TClass;
                   const PropertyName: string; EditorClass: TComponentClass);

type
  TPopupClassInfo = class(TPackagedCollectionItem)
  public
    c      : TComponentClass;
    ti     : PTypeInfo;
    name   : string;
    CClass : TClass;
  end;

type
  TEditClassInfo = class(TPackagedCollectionItem)
  public
    c        : TComponentClass;
    ti       : PTypeInfo;
    name     : string;
    CClass   : TClass;
    isText   : boolean;
    Internal : boolean
  end;

  TEditSourceClassInfo = class(TPackagedCollectionItem)
  public
    c : TClass;
  end;

function  DefaultCheckWidth : integer;
function  DefaultCheckHeight : integer;
{$ENDIF}
procedure CallPropertyEdit(C:TPersistent;Const APropname:String);

var
  CallPropEditProc : procedure (C : TPersistent; const APropname : String);

{$IFDEF WIN}
function ClassItems : TClassItems;
function  IsIconClass (c : TComponentClass) : boolean;
procedure RegisterNonInstant(ComponentClasses: array of TComponentClass);
procedure UpdateStandardButtons(btnOK, btnCancel, btnHelp: TButton);
{$ENDIF}
Procedure RegisterOptionsInitializator(OptionsInitializator:TOptionsInitializator);
Procedure UnRegisterOptionsInitializator(OptionsInitializator:TOptionsInitializator);

procedure EnumTextStylesSets(Proc: TGetStrProc);
procedure FreeTextStylesSets;

function BufferToText(Buffer: PChar; Size: Integer): string;
procedure TextToStream(const Str: string; Stream: TStream);

function DCIsStrInStrArray(const S:String;const SArray:Array of String):boolean;

function DCGetDelphiVerFromDefinesStr(const DefinesStr:String;var DelphiVer:TDelphiVer):boolean;

type
  TDCInstanceClassIs=function(Instance:TObject):boolean;

var
  DCObjectIsControl:TDCInstanceClassIs;
  DCObjectIsWinControl:TDCInstanceClassIs;

type
  IDCPropInfoList=interface
  ['{BB5623B0-5023-4846-A7FC-84BC5A179A94}']
    function GetCount:Integer;
    function GetItem(Index:Integer):PPropInfo;
    procedure Delete(Index:Integer);
    procedure Intersect(List:IDCPropInfoList);
    procedure SetInstance(Instance:TPersistent;Filter:TTypeKinds);
    function ContainsItem(P:PPropInfo):Boolean;
    property Count:Integer read GetCount;
    property Items[Index:Integer]:PPropInfo read GetItem;default;
  end;

  IDCDsgnImplementation=interface
  ['{6E23CB5C-C27C-4B50-8AA2-20744837CB0D}']
    function GetInstance: TObject;
  end;

  IDCDsgnImplementationAsPersistent=interface(IDCDsgnImplementation)
  ['{6E23CB5C-C27C-4B50-8AA2-20744837CB0D}']
    function GetInstanceAsPersistent:TPersistent;
  end;

  IDCDsgnDesignerSelections=interface
  ['{657DE4BB-D624-425F-AA73-C8D755ABB9E9}']
    function Add(const Item: TPersistent): Integer;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    function Get(Index: Integer): TPersistent;
    function Equals(const List:IDCDsgnDesignerSelections):Boolean;
    property Items[Index: Integer]: TPersistent read Get; default;
  end;

  TDCPersistentList=class(TInterfacedObject,IDCDsgnDesignerSelections)
  private
    FList:TList;
  public
    function Equals(const List:IDCDsgnDesignerSelections):Boolean;
    constructor Create;
    destructor Destroy;override;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    function Add(const Item: TPersistent): Integer;
    function Get(Index: Integer): TPersistent;
    property Items[Index: Integer]: TPersistent read Get; default;
  end;

{----------------------------------------}

function DCUnParseString(Strings : TStrings;const Separator : String):String;
function DCUnParseStringEx(Strings:TStrings;const Separator:String;
  AddEndSeparator:boolean):String;

function DCCreatePropInfoList(Instance:TPersistent;Filter:TTypeKinds):IDCPropInfoList;

procedure DCGetEnumTypeValueNames(TypeInfo:PTypeInfo;AValueNames: TStrings);

procedure DCGetDelphiSourceDirsAsStrings(DelphiVer:TDelphiVer;Strings:TStrings);
procedure DCRemoveVCLPaths(UnitPaths:TStrings;DelphiVer:TDelphiVer);
procedure DCAddSlashInStrings(Strings:TStrings);

function DCChangeFilePath(const FileName,NewPath:String):String;
procedure DCChangeFilePathInStrings(Strings:TStrings;const NewPath:String);
procedure DCChangeFileExtInStrings(Strings:TStrings;const NewExt:String);

{----------------------------------------}

implementation

{--------------------------------------}

procedure DCAddSlashInStrings(Strings:TStrings);
var
  i:Integer;
begin
  for i:=0 to Strings.Count-1 do
    Strings[i]:=AddSlash(Strings[i]);
end;

{--------------------------------------}

procedure DCRemoveVCLPaths(UnitPaths:TStrings;DelphiVer:TDelphiVer);
var
  VCLPaths:TStringList;
begin
  VCLPaths:=TStringList.Create;
  try
    DCGetDelphiSourceDirsAsStrings(DelphiVer,VCLPaths);
    DCAddSlashInStrings(UnitPaths);
    DCAddSlashInStrings(VCLPaths);
    RemoveStrings(UnitPaths,VCLPaths);
  finally
    VCLPaths.Free;
  end;
end;

{--------------------------------------}

procedure DCGetEnumTypeValueNames(TypeInfo:PTypeInfo;AValueNames: TStrings);
var
  i: Integer;
begin
  if not Assigned(AValueNames) or (TypeInfo = nil) or
    (TypeInfo^.Kind <> tkEnumeration) then
    Exit;
  AValueNames.Clear;
  for i := GetTypeData(TypeInfo)^.MinValue to GetTypeData(TypeInfo)^.MaxValue do
   AValueNames.Add(GetEnumName(TypeInfo, i));
end;

{--------------------}

function TDCPersistentList.Equals(const List:IDCDsgnDesignerSelections):Boolean;
var
  I: Integer;
begin
  Result:=False;
  if List.Count<>Count then
    Exit;
  for I:=0 to Count-1 do
    if Items[I]<>List[I] then
      Exit;
  Result:=True;
end;

{--------------------}

constructor TDCPersistentList.Create;
begin
  inherited;
  FList:=TList.Create;
end;

{--------------------}

destructor TDCPersistentList.Destroy;
begin
  FList.Free;
  inherited;
end;

{--------------------}

function TDCPersistentList.GetCount: Integer;
begin
  Result:=FList.Count;
end;

{--------------------}

function TDCPersistentList.Add(const Item: TPersistent): Integer;
begin
  Result:=FList.Add(Item);
end;

{--------------------}

function TDCPersistentList.Get(Index: Integer): TPersistent;
begin
  Result:=TPersistent(FList.Items[Index]);
end;

{--------------------------------------}

function DCUnParseStringEx(Strings:TStrings;const Separator:String;
  AddEndSeparator:boolean):String;
var
  i: Integer;
begin
  Result := '';
  if not Assigned(Strings)
   then Exit;

  for i:= (Strings.Count-1) downto 0 do
  begin
    If (Result='') and (not AddEndSeparator) then
      Result:=Strings[i]
    else
      Result:=Strings[i]+Separator+Result;
  end;
end;

{--------------------------------------}

function DCUnParseString(Strings : TStrings;const Separator : String):String;
begin
  Result:=DCUnParseStringEx(Strings,Separator,True);
end;

{--------------------------------------}

function GetOriginalComponentName(const Name : string) : string; // converts Form2_123 -> Form2
var
  lname : integer;
begin
  lname := length(Name) - 1;
  if lname >= 2 then
    begin
      while Name[lname + 1] in ['0' .. '9'] do
        dec(lname);
      if Name[lname + 1] = '_' then
        begin
          result := copy(Name, 1, lname);
          exit;
        end;
    end;
  result := Name;
end;

{------------------------------------------------------------------}

{$IFDEF WIN}
var
  _ClassItems : TClassItems;
  OptionsInitializators : TList;

function ClassItems : TClassItems;
begin
  if _ClassItems = nil then
    _ClassItems := TClassItems.Create;

  result := _ClassItems;
end;
{$ENDIF}
{------------------------------------------------------------------}

procedure CallPropertyEdit(C : TPersistent; Const APropname : String);
begin
  if Assigned(CallPropEditProc) then
    CallPropEditProc(C, APropName);
end;

{$IFNDEF D3}
const
  OBM_CHECKBOXES = 32759;
{$ENDIF}

{$IFDEF WIN}

var
  fCheckWidth  : integer = 0;
  fCheckHeight : Integer = 0;


procedure GetCheckSize;
begin
  if fCheckWidth = 0 then
  {$IFNDEF CLX}
    with TBitmap.Create do
      try
        Handle := LoadBitmap(0, PChar(OBM_CHECKBOXES));
        FCheckWidth := Width div 4;
        FCheckHeight := Height div 3;
      finally
        Free;
      end;
  {$ELSE}
  FCheckWidth :=  13;
  FCheckHeight := 13;
  {$ENDIF}
end;

{------------------------------------------------------------------}

function DefaultCheckWidth : integer;
begin
  GetCheckSize;
  result := fCheckWidth;
end;

{------------------------------------------------------------------}

function DefaultCheckHeight : integer;
begin
  GetCheckSize;
  result := fCheckHeight;
end;

{------------------------------------------------------------------}

var
  fPopupClasses      : TPackagedCollection;
  fEditSourceClasses : TPackagedCollection;
  fEditClasses       : TPackagedCollection;

function PopupClasses      : TPackagedCollection;
begin
  if fPopupClasses = nil then
    fPopupClasses := TPackagedCollection.Create(TPopupClassInfo);

  result := fPopupClasses;
end;

{----------------------------------------------------------}

function EditSourceClasses : TPackagedCollection;
begin
  if fEditSourceClasses = nil then
    fEditSourceClasses := TPackagedCollection.Create(TEditSourceClassInfo);

  result := fEditSourceClasses;
end;

{----------------------------------------------------------}

function EditClasses       : TPackagedCollection;
begin
  if fEditClasses = nil then
    fEditClasses := TPackagedCollection.Create(TEditClassInfo);

  result := fEditClasses;
end;

{$ENDIF}

procedure TEditSource.StartEdit;
begin

end;


{$IFNDEF D3}
const
  IMAGE_DOS_SIGNATURE    = $5A4D;       { MZ }
  IMAGE_OS2_SIGNATURE    = $454E;       { NE }
  IMAGE_OS2_SIGNATURE_LE = $454C;       { LE }
  IMAGE_VXD_SIGNATURE    = $454C;       { LE }
  IMAGE_NT_SIGNATURE     = $00004550;   { PE00 }

  IMAGE_SIZEOF_SECTION_HEADER      = 40;
  IMAGE_RESOURCE_NAME_IS_STRING    = $80000000;
  IMAGE_RESOURCE_DATA_IS_DIRECTORY = $80000000;
{$ENDIF}

{$IFDEF WIN}
{$IFNDEF CLX}
var
  FRegistry:TRegistry;

{$ENDIF}
{$ENDIF}

type
  TMPersistent = class(TPersistent)
  end;

{------------------------------------------------------------------}

function GetComponentTopLeft(Instance : TComponent) : TPoint;
begin
  with LongRec(Instance.DesignInfo) do
    begin
      Result.X := Lo;
      Result.Y := Hi;
    end;
end;

{------------------------------------------------------------------}

procedure SetComponentTopLeft(Instance : TComponent; Position : TPoint);
begin
  with LongRec(Instance.DesignInfo) do
    begin
      Lo := Position.X;
      Hi := Position.Y;
    end;
end;

{------------------------------------------------------------------}

function PReadShortStr(var p : pchar) : string;
var
  l  : integer;
begin
  l := byte(p^);
  SetLength(result, l);
  inc(p);
  Move(p^, result[1], l);
  inc(p, l);
end;

{------------------------------------------------------------------}

function RemoveNonIdentChars(const N : string) : string;
begin
  result := RemoveCharSet([#0..#255] - ['a'..'z','A'..'Z','_'], N);
end;

{------------------------------------------------------------------}

procedure AddStr(var BaseString : string; const AddString : string);
begin
  BaseString := BaseString + AddString;
end;

{--------------------------------------------}

function GetFirstNotSpace(const s : string) : integer;
var
  slen : integer;
begin
  result := 0;
  slen := length(s);
  while (result < slen) and (s[result + 1] = ' ') do
    inc(result);

  inc(result);  
end;

{--------------------------------------------}

function AddCharOccurence(Const S:String;C:Char;Count:Integer):String;
Var
  i:Integer;
begin
  If Count=0 then
  begin
    Result:=S;
    exit;
  end;
  inc(count);
  Result:='';
  for I:=1 to Length(S) do
    if S[i]=C then
      Result:=Result+StringOfChar(C,Count)
    else
      Result:=Result+S[i];
end;

{------------------------------------------------------------------}

function RemoveStrSet(const StrSet,S:String;CaseSens:Boolean):String;
Var
  C:TCharSet;
begin
  C:=StringToCharSet([],StrSet,CaseSens);
  Result:=RemoveCharSet(C,S);
end;

{------------------------------------------------------------------}

function DCRemovePoints(Const S:String):String;
begin
  Result:=RemoveCharSet(['.'],S);
end;

{------------------------------------------------------------------}

Function RemoveCharSet(Const CharSet:TCharSet;Const S:String):String;
Var
  i:Integer;
begin
  Result:=S;
  for I := Length(Result) downto 1 do
    if Result[I] in CharSet then
      Delete(Result, I, 1);
end;

{--------------------------------------------}

function StringToCharSet(InitValue:TCharSet;const S:String;CaseSens:Boolean):TCharSet;

  procedure Work(Const TempStr:String);
  var
    i:Integer;
  begin
    For i:=1 to Length(TempStr) do
      Include(Result,TempStr[i]);
  end;

begin
  Result:=InitValue;
  If CaseSens
  then
    Work(S)
  else
    begin
      Work(AnsiUpperCase(S));
      Work(AnsiLowerCase(S));
    end;
end;

{------------------------------------------------------------------}

procedure OperateStrings(S:TStrings;StringsProc:TStringsOperateProc);

  procedure UpperSortedStringList(S:TStringList);
  begin
    S.Sorted:=False;
    StringsProc(S);
    S.Sorted:=True;
  end;

begin
  S.BeginUpdate;
  try
    if (S is TStringList) and (TStringList(s).Sorted) then
      UpperSortedStringList(TStringList(S))
    else
      StringsProc(S);
  finally
    S.EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure _AnsiUpperCaseStrings(S : TStrings);
var
  i : integer;
begin
  for i := 0 to S.Count - 1 do
    S[i] := AnsiUpperCase(S[i]);
end;

procedure AnsiUpperCaseStrings(S : TStrings);
begin
  OperateStrings(S,_AnsiUpperCaseStrings);
end;

{------------------------------------------------------------------}

procedure _AnsiLowerCaseStrings(S : TStrings);
var
  i : integer;
begin
  for i := 0 to S.Count - 1 do
    S[i] := AnsiLowerCase(S[i]);
end;

procedure AnsiLowerCaseStrings(S : TStrings);
begin
  OperateStrings(S,_AnsiLowerCaseStrings);
end;

{------------------------------------------------------------------}

{function StringsToStr(S:TStrings;MaxLength,Ident:Integer):String;
Var
  i,le:Integer;
begin
  Result:='';
  If S.Count=0 then exit;
  Result:=S[0];
  Le:=Length(S[0]);
  For i:=1 to S.Count-1 do
  begin
    Result:=Result+', ';
    If Le+Length(S[i])+2>=MaxLength then
    begin
      Le:=Ident;
      Result:=Result+#13#10+StringOfChar(' ',Ident);
    end;
    Inc(Le,Length(S[i])+2);
    Result:=Result+S[i];
  end;
end;}

{-------------------------------------------------------------}

procedure StrArrayToStrings(Strings:TStrings;const A:Array of string);
Var
  i:Integer;
begin
  with Strings do
  begin
    BeginUpdate;
    Clear;
    for i:=Low(A) to High(A) do
      Add(A[i]);
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

function ForEachListItem(L:TList;ListIterator:TListIteratorProc):boolean;
Var
  i:Integer;
begin
  Result:=True;
  If L=nil then
    exit;
  With L do
  begin
    i:=Count-1;
    While i>=0 do
    begin
      ListIterator(Items[i],i,Result);
      If not Result then
        exit;
      i:=Min(Count,i);
      dec(i);
    end;
  end;
end;

{------------------------------------------------------------------}

function RemoveItem(List:TList;Item: Pointer): Integer;
begin
  result:=List.Remove(Item);
  TObject(Item).Free;
end;

{----------------------------------------------------------}

function  RemoveSortedItem(List:TSortedList;Item: Pointer): Integer;
begin
  result := List.Remove(Item);
  TObject(Item).Free;
end;

{---------------------------------------------------------------}

type
  TFindFilesClass=class
  private
    FStrings:TStrings;
  public
    procedure CallBack(const Path:String;const SearchRec: TSearchRec;
      Var AContinue:boolean);
  end;

{---------------------------------------------------------------}

procedure TFindFilesClass.CallBack(const Path:String;const SearchRec: TSearchRec;
  Var AContinue:boolean);
begin
  FStrings.Add(Path+SearchRec.Name);
end;

{---------------------------------------------------------------}

procedure FindFiles(const Path: string; Attr: Integer;SubFolders:boolean;
  Files:TStrings);
var
  FindFilesObj:TFindFilesClass;
begin
  FindFilesObj:=TFindFilesClass.Create;
  FindFilesObj.FStrings:=Files;
  With Files do
    try
      BeginUpdate;
      Clear;
      ForEachFile(Path,Attr,SubFolders,FindFilesObj.CallBack);
    finally
      EndUpdate;
      FindFilesObj.Free;
    end;
end;

{-------------------------------------------------------------------------}

procedure RemoveEmptyStrings(S:TStrings);
var
  i:Integer;
begin
  With S do
    for i:=Count-1 downto 0 do
      if Trim(Strings[i])='' then
        Delete(i);
end;

{---------------------------------------------------------------}

procedure FindFilesEx(const Path,FileMasks:String;
            Attr: Integer;SubFolders:boolean;Files:TStrings);
var
  TempFiles,ResultFiles:TStringList;
  MaskStrings:TStringList;
  i:Integer;
begin
  TempFiles:=TStringList.Create;
  ResultFiles:=TStringList.Create;
  TempFiles.Sorted:=True;
  TempFiles.Duplicates:=dupIgnore;
  MaskStrings:=TStringList.Create;
  If FileMasks='' then
    MaskStrings.Add('*.*')//don't resource
  else
    ParseString(FileMasks,';',MaskStrings);
  RemoveEmptyStrings(MaskStrings);
  try
    for i:=0 to MaskStrings.Count-1 do
    begin
      FindFiles(AddSlash(Path)+MaskStrings[i],
        Attr,SubFolders,ResultFiles);
      AnsiUpperCaseStrings(ResultFiles);
      TempFiles.AddStrings(ResultFiles);
    end;
    Files.Assign(TempFiles);
  finally
    TempFiles.Free;
    ResultFiles.Free;
    MaskStrings.Free;
  end;
end;

{---------------------------------------------------------------}
{
type
  TCalc]Obj = class
    size : comp;
    procedure DirSize(const Path:String;const SearchRec: TSearchRec; Var AContinue:boolean) ;
  end;

procedure TCalcObj.DirSize(const Path:String;const SearchRec: TSearchRec; Var AContinue:boolean) ;
begin
  size := size + SearchRec.Size;
end;

function GetFolderSize(Const Dirname : string): comp;
begin
  with TCalcObj.Create do
    try
      ForEachFile(AddSlash(Dirname)+'*.*' , faVolumeID or faAnyFile or faDirectory , true, DirSize);
      result := size;
    finally
      free;
    end;
end;
 }
{---------------------------------------------------------------}

function ForEachFile(const Path : string; Attr : integer; SubFolders : boolean;
  CallBack : TFileFoundCallBack) : integer;

  function Iterate(const Path : string) : integer;
  var
    SearchRec : TSearchRec;
    R         : integer;
    MyPath    : string;
    MyFile    : string;
    AContinue : boolean;
    sattr     : integer;
  begin
    Result := 0;
    MyPath := AddSlash(ExtractFilePath(Path));
    MyFile := ExtractFileName(Path);

//----- search and process files -------------

    R := FindFirst(Path, Attr, SearchRec);
    if R = 0 then
      try
        AContinue := True;
        while (R = 0) and AContinue do
          begin
            sattr := SearchRec.Attr;
            if (sattr and Attr <> 0) or
              ((sAttr in [0, $80]) and (Attr and (faAnyFile - faDirectory) <> 0)) then
                begin
                  CallBack(MyPath, SearchRec, AContinue);
                  inc(Result);
                end;
            R := FindNext(SearchRec);
          end;
      finally
        SysUtils.FindClose(SearchRec);
      end;

//----------------- iterate subfolders if needed ----------
    if SubFolders then
      begin
        R := FindFirst(MyPath + '*.*', faDirectory, SearchRec);
        if R = 0 then
          try
            repeat
              if (SearchRec.Name[1] <> '.') and (SearchRec.Attr and faDirectory <> 0) then
                Inc(Result, Iterate(MyPath + SearchRec.Name + SlashString + MyFile));
              R := FindNext(SearchRec);
            until R <> 0;  
          finally
            SysUtils.FindClose(SearchRec);
          end;
      end;
  end;

begin
  if Assigned(CallBack) then
    Result := Iterate(Path)
  else
    Result := 0;
end;

{------------------------------------------------------------}

function MaxIntValue(const Data: array of Integer): Integer;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result < Data[I] then
      Result := Data[I];
end;

{-------------------------------------------------------------}

function CallMethod(Data,Code:Pointer):integer;
asm
  Call Code
end;

{----------------------------------------------------------}

procedure AssignPropsEx(Source,Dest:TPersistent; Const Propnames:String);
Var
  S:TStringList;
  i:Integer;
begin
  If not AreObjNotEqualNotNil(Source,Dest) then
    exit;

  S:=TStringList.Create;
  try
    S.CommaText:=PropNames;
    for i:=0 to S.Count-1 do
      AssignProp(Source,Dest,S[i]);
  finally
    S.Free;
  end;
end;

{----------------------------------------------------------}

procedure AssignProps(Source, Dest : TPersistent; PropNames : array of string);
var
  i : integer;
begin
  If not AreObjNotEqualNotNil(Source,Dest) then
    exit;
  for i := Low(PropNames) to High(PropNames) do
    AssignProp(Source,Dest,PropNames[i]);
end;

{------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}

procedure ReadStringsFromRegistry(Const VarName:String;S:TStrings);
Var
  TempStr:String;
begin
  TempStr:=ReadFromRegistry(VarName,S.Text);
  S.Text:=TempStr;
end;

{------------------------------------------------------------------}

procedure WriteStringsToRegistry(Const VarName:String;S:TStrings);
begin
  WriteToRegistry(VarName,S.Text);
end;

{------------------------------------------------------------------}

procedure GetRegKey(const VarName:String; var FKey, FName:String);
begin
  FKey:=AddSlash(RegistryKey)+VarName;
  FName:=ExtractFileName(FKey);
  FKey:=RemoveSlash(ExtractFilePath(FKey));
end;

{------------------------------------------------------------------}

function InternalRegistry:TRegistry;
begin
  Result:=FRegistry;
  If Result=nil then
  begin
    Result:=TRegistry.Create;
    FRegistry:=Result;
  end;
end;

{------------------------------------------------------------------}

procedure SetRootRegKey(const key : HKEY);
begin
  InternalRegistry.RootKey := key;
end;

{------------------------------------------------------------------}

procedure WriteBufToRegistry(const VarName:String; var Buf; size : integer);
Var
  FKey : String;
  FName: String;
begin
  If VarName='' then
    exit;
  GetRegKey(VarName, fKey, fName);
  If (FName='') or (FKey='') then
    exit;
  With InternalRegistry do
    begin
      OpenKey(FKey, True);
      try
        WriteBinaryData(fName, Buf, Size);
      finally
        CloseKey;
      end;
   end;
end;

{------------------------------------------------------------------}

function GetRegBufSize(const VarName : string) : integer;
Var
  FKey : String;
  FName: String;
begin
  GetRegKey(VarName, fKey, fName);
  with InternalRegistry do
    if OpenKey(FKey, False) then
      try
        result := GetDataSize(fName);
      finally
        CloseKey;
      end
    else
      result := -1;
end;

{------------------------------------------------------------------}

function ReadBufFromRegistry(const VarName : String; var Buf; size : integer) : integer;
Var
  FKey : String;
  FName: String;
begin
  If VarName='' then
  begin
    Result:=0;
    exit;
  end;

  GetRegKey(VarName, fKey, fName);
  with InternalRegistry do
    if OpenKey(FKey, False) then
      try
        result := ReadBinaryData(fName, Buf, Size);
      finally
        CloseKey;
      end
    else
      result := 0;
end;

{------------------------------------------------------------------}

const
  RegLongBufHeader = '__Long RegKey__';  //don't resource
  FullHeaderSize = length(RegLongBufHeader) + 10 * 2 + 1;

procedure WriteRegLongBufHeader(const VarName : string; Size, BlockSize : integer);
var
  s : string;
begin
  s := RegLongBufHeader + Format('%.10d %.10d', [Size, BlockSize]); //don't resource
  WriteBufToRegistry(VarName, s[1], length(s));
end;

{------------------------------------------------------------------}

function GetLongRegBlockName(const VarName : string; BlockNum : integer) : string;
begin
  result := VarName + '__' + IntToStr(BlockNum);
end;

{------------------------------------------------------------------}

procedure WriteLongBufToRegistry(const VarName : String; var Buf; size : integer);
var
  pbuf      : PChar;
  blocknum  : integer;
  bsize     : integer;
begin
  if UnderWindowsNT then
    WriteBufToRegistry(VarName, Buf, Size)
  else
    begin
      WriteRegLongBufHeader(VarName, Size, DefaultRegBlockSize);

      blocknum := 0;
      pbuf := @Buf;

      while size > 0 do
        begin
          bsize := min(size, DefaultRegBlockSize);
          WriteBufToRegistry(GetLongRegBlockName(VarName, blocknum), PBuf^, bsize);
          dec(size, bsize);
          inc(blocknum);
          inc(PBuf, bsize);
        end;

    end;
end;

{------------------------------------------------------------------}

function IsLongRegBuf(const VarName : String; var Size, BlockSize : integer) : boolean;
var
  header : string;
  ASize  : integer;
begin
  ASize := Max(GetRegBufSize(VarName), FullHeaderSize);
  SetString(header, nil, ASize);
  result := not UnderWindowsNT and
               (ReadBufFromRegistry(VarName, header[1], ASize) = ASize) and
               CompareMem(@header[1], @(RegLongBufHeader[1]), length(RegLongBufHeader));

  if result then
    begin
      Size := StrToIntDef(copy(header, length(RegLongBufHeader) + 1, 10), 0);
      BlockSize := StrToIntDef(copy(header, length(RegLongBufHeader) + 1 + 10 + 1, 10), 0);
    end;
end;

{------------------------------------------------------------------}

function  ReadLongBufFromRegistry(const VarName : String; var Buf; size : integer) : integer;
var
  BufSize   : integer;
  BlockSize : integer;
  numread   : integer;
  pbuf      : PChar;
  blocknum  : integer;
begin
  if not IsLongRegBuf(VarName, BufSize, BlockSize) then
    result := ReadBufFromRegistry(VarName, Buf, Size)
  else
    begin
      result := 0;
      blocknum := 0;
      pbuf := @Buf;
      size := min(size, BufSize);

      while size > 0 do
        begin
          numread := ReadBufFromRegistry(GetLongRegBlockName(VarName, blocknum), PBuf^, BlockSize);
          inc(result, numread);
          dec(size, numread);
          if numread < BlockSize then
            break;

          inc(blocknum);
          inc(PBuf, BlockSize);
        end;
    end;
end;

{------------------------------------------------------------------}

function  GetLongRegBufSize(const VarName : string) : integer;
var
  size : integer;
  bsize : integer;
begin
  if UnderWindowsNT or not IsLongRegBuf(VarName, size, bsize) then
    result := GetRegBufSize(VarName)
  else
    result := size;
end;

{------------------------------------------------------------------}

procedure WriteToRegistry(Const VarName:String;const VarValue:Variant);
Var
  FKey:String;
  FName:String;
begin
  If VarName='' then
    exit;
  GetRegKey(VarName, fKey, fName);
  with InternalRegistry do
    begin
      OpenKey(FKey,True);
      try
        With TVarData(VarValue) do
          Case VType of
            varSmallint,varInteger,varByte:
              WriteInteger(FName,VarValue);
            varSingle,varDouble:
              WriteFloat(FName,VarValue);
            varCurrency:
              WriteCurrency(FName,VarValue);
            varDate:
              WriteDate(FName,VarValue);
            varOleStr:
              WriteString(FName,WideCharToString(VOleStr));
            varBoolean:
              WriteBool(FName,VarValue);
            varString:
              WriteString(FName,VarValue);
            else
              Raise Exception.Create(SErrUnknRegType);
          end;
      finally
        CloseKey;
      end;
    end;
end;

{------------------------------------------------------------------}

function RegValueExists(Const VarName : String) : boolean;
var
  fKey  : string;
  fName : string;
begin
  result := false;
  if VarName = '' then
    exit;

  GetRegKey(VarName, fKey, fName);
  with InternalRegistry do
    if OpenKey(FKey, False) then
      try
        result := ValueExists(FName);
      finally
        CloseKey;
      end;
end;

{------------------------------------------------------------------}

function ReadFromRegistry(Const VarName:String;
           const DefaultValue:Variant):Variant;
Var
  FKey:String;
  FName:String;
begin
  Result:=DefaultValue;
  If VarName='' then
    exit;
  GetRegKey(VarName, fKey, fName);
  With InternalRegistry do
    if OpenKey(FKey,False) then
      try
        if ValueExists(FName) then
          With TVarData(DefaultValue) do
            Case VType of
              varSmallint,varInteger,VarByte:
                Result:=ReadInteger(FName);
              varDouble,varSingle:
                Result:=ReadFloat(FName);
              varCurrency:
                Result:=ReadCurrency(FName);
              varDate:
                Result:=ReadDate(FName);
              varBoolean:
                Result:=ReadBool(FName);
              varString,varOleStr:
                Result:=ReadString(FName);
              else
                Raise Exception.Create(SErrUnknRegType+'($'+IntToHex(VType,4)+')');
            end;
      finally
        CloseKey;
      end;
end;

{------------------------------------------------------------------}

function CompiledWithPackages:boolean;

{$IFDEF D3}
const
  {$IFDEF D6}
    PackName = 'VCL60.BPL';
  {$ELSE}
    {$IFDEF BCB5}
      PackName = 'VCL50.BPL'; //don't resource
    {$ELSE}
      {$IFDEF D5}
        PackName = 'VCL50.BPL'; //don't resource
      {$ELSE}
        {$IFDEF CPB4}
          PackName = 'VCL40.BPL'; //don't resource
        {$ELSE}
          {$IFDEF D4}
            PackName='VCL40.BPL'; //don't resource
          {$ELSE}
            {$IFDEF CPB3}
              PackName='VCL35.BPL'; //don't resource
            {$ELSE}
              PackName='VCL30.DPL'; //don't resource
            {$ENDIF}
          {$ENDIF}
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF D3}
   Result:=GetModuleHandle(PackName)<>0;
  {$ELSE}
   Result:=False;
  {$ENDIF}
end;

{------------------------------------------------------------------}

Function DCDeleteRegKey( ABaseKey : HKey; Const AKeyPath, ADeletingKey : String ) : Boolean;
Var
  I                             : Integer;
  Len                           : DWORD;
  SubKeyNumber, MaxSubKeyLength : Integer;
  DeleteKey                     : HKey;
  NewKeyPath, SubKeyName        : String;
begin
  Result := False;
  NewKeyPath := AddSlash( AKeyPath ) + ADeletingKey;
  If NewKeyPath[1] = '\' Then
    Delete( NewKeyPath, 1, 1 );
  If RegOpenKeyEx( ABaseKey, PChar( NewKeyPath ), 0, KEY_ALL_ACCESS, DeleteKey ) = ERROR_SUCCESS Then
  try
    If RegQueryInfoKey( DeleteKey, Nil, Nil, Nil, @SubKeyNumber, @MaxSubKeyLength, Nil, Nil, Nil, Nil, Nil, Nil ) <> ERROR_SUCCESS Then
      Exit;
    Inc( MaxSubKeyLength );

    SetLength( SubKeyName, MaxSubKeyLength );
    For I := 0 To SubKeyNumber - 1 Do
    begin
      Len := MaxSubKeyLength;
      If RegEnumKeyEx( DeleteKey, I, PChar( SubKeyName ), Len, Nil, Nil, Nil, Nil ) = ERROR_SUCCESS Then
        DCDeleteRegKey( ABaseKey, NewKeyPath, PChar( SubKeyName ) );
    end;
  finally
    RegCloseKey( DeleteKey );
  end;
  Result := RegDeleteKey( HKEY_CURRENT_USER, PChar( NewKeyPath ) ) In [ ERROR_SUCCESS, 2 ];
end;

{$ENDIF}
{$ENDIF WIN}

{------------------------------------------------------------------}

procedure RenameToBak(Const Path:String);
Var
  BakName:String;
begin
  BakName:=FileBakName(Path);
  If FileExists(Path) then
  begin
    If FileExists(BakName) then
      DeleteFile(PChar(BakName));
    RenameFile(Path,BakName);
  end;
end;

{------------------------------------------------------------------}

Function FileBakName(Const Path:String):String;
Var
  AName,APath,AExt:String;
begin
  APath:=ExtractFilePath(Path);
  AName:=ExtractFileName(Path);
  AExt:=ExtractFileExt(Path);
  If Length(AExt)>0
  then
    begin
      Insert('~',AExt,2);
      If Length(AExt)>4 then SetLength(AExt,4);
    end
  else
    AExt:='.~';
  Result:=AddSlash(APath)+ChangeFileExt(AName,AExt);
end;

{------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}
Function ShiftIsPressed:Boolean;
begin
  Result:=(GetAsyncKeyState(VK_SHIFT) AND $80000000) <> 0
end;

{------------------------------------------------------------------}

function KeysToShift:TShiftState;
begin
  Result:=[];
  if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
  if IsAltKeyDown then Include(Result,ssAlt);
end;

{------------------------------------------------------------------}

function IsAltKeyDown:Boolean;
begin
  Result:=((GetAsyncKeyState(VK_MENU) and $80000000)<>0);
end;

{$ENDIF}
{$ENDIF}

{------------------------------------------------------------------}

function EqualList(l1, l2 : TList) : boolean;
var
  i : integer;
begin
  result := false;
  if l1.count <> l2.count then
    exit;

  for i := 0 to l1.count - 1 do
    if l2.indexof(l1[i]) < 0 then
      exit;

  result := true;
end;

{------------------------------------------------------------------}

function ListsInterSect(l1, l2 : TList) : boolean;
Var
  i:Integer;
begin
  result := true;

  for i := 0 to l1.Count - 1 do
    if l2.IndexOf(l1[i]) >= 0 then
      exit;

  result := false;
end;

{--------------------------------------------}

function StringOfSpace(Num:Integer):String;
begin
  result:=StringOfChar(' ',Num);
end;

{--------------------------------------------}

procedure AddBackSpaces(Var S:String;Len:Integer);
Var
  OLen:Integer;
begin
  OLen:=Length(S);
  If Olen<Len then
  begin
    SetLength(S,Len);
    FillChar(S[Olen+1],Length(S)-OLen,' ');
  end;
end;

{------------------------------------------------------------------}

{-------------------------------------------------------------------------}

function StrArrayToDelimStr(const StrArray : array of string; Delim:Char):String;
var
  i : integer;
begin
  for i := Low(StrArray) to High(StrArray) do
   if StrArray[i] <> '' then
     if result = '' then
       result := StrArray[i]
     else
       result := result + Delim + StrArray[i];
end;

{-------------------------------------------------------------------------}

procedure StringsObjectsToList(Strings:TStrings;List:TList);
Var
  i:Integer;
begin
  List.Clear;
  With Strings do
    for i:=0 to Count-1 do
      List.Add(Objects[i]);
end;

{-------------------------------------------------------------------------}

procedure ToggleInspector;
begin
  SimpleBroadCast(cm_ToggleInspector);
end;

{-------------------------------------------------------------------------}

procedure ShowInspectorEx(MakeTop:boolean);
begin
  BroadCastToNotifiers(nil,CM_SHOWINSPECTOR,Integer(MakeTop),0);
end;

{-----------------------------------------------------------}

function StrToBoolean(const S:String):boolean;
begin
  Result:=CompareText(S,'True')=0; //don't resource
end;

{-----------------------------------------------------------}

function CreateSortedStringList:TStringList;
begin
  Result:=TStringList.Create;
  Result.Sorted:=True;
end;

{-----------------------------------------------------------}

function CreateSortedStringListEx(C:TStringListClass):TStringList;
begin
  Result:=C.Create;
  Result.Sorted:=True;
end;

{-------------------------------------------------------------------------}

procedure ShowInspector;
begin
  ShowInspectorEx(True);
end;

{-------------------------------------------------------------------------}

procedure HideInspector;
begin
  SimpleBroadCast(CM_HIDEINSPECTOR);
end;

{----------------------------------------------------------}

procedure DisposeList(Var AList:TList);
var
  i:integer;
begin
  if Pointer(Alist) <> nil then
    with AList do
      begin
        for i := 0 to Count - 1 do
          Dispose(Items[i]);

        Clear;
      end;
  AList.Free;
  AList:=nil;
end;

{------------------------------------------------------------------}

procedure ClearStrings(S : TStrings);
{Var
  A:TObject;}
var
  i:Integer;

begin
  if S <> nil then
    With S do
    try
      for i:=0 to Count-1 do
        Objects[i].Free;
    finally
      Clear;
    end;
{
    with S do
      while Count > 0 do
        begin
          A := TObject(Objects[0]);
          Delete(0);
          A.Free;
        end;
 }
end;

{------------------------------------------------------------------}

procedure FreeStringsObjects(Strings:TStrings);
var
  i : Integer;
begin
  With Strings do
    for i := Count - 1 downto 0 do
      TObject(Objects[I]).Free;
end;

{------------------------------------------------------------------}

procedure FreeStrings(var Strings);
begin
  if Pointer(Strings) <> nil then
    begin
      FreeStringsObjects(TObject(Strings) as TStrings);
      TStrings(Strings).Free;
      Pointer(Strings) := nil;
    end;
end;

{------------------------------------------------------------------}

Procedure StringsToProc(S:TStrings; Proc: TGetStrProc);
var
  i : integer;
begin
  for i := 0 to S.Count - 1 do
    Proc(S[i]);
end;

{------------------------------------------------------------------}

procedure AddList(FromList,ToList : TList);
Var
  i : Integer;
begin
  if FromList = ToList then
    exit;

  With ToList do
    begin
      Capacity := Max(FromList.Count + Count,Capacity);
      for i := 0 to Fromlist.Count - 1 do
        Add(Fromlist[i]);
    end;
end;

{------------------------------------------------------------------}

Function MethodTable(A:TClass):PMethodTable;assembler;
asm
  mov EAX,[EAX].vmtMethodTable
end;

{------------------------------------------------------------------}

procedure WriteShortStr(S:TStream;Const St:String);
Var
  TempStr:ShortString;
begin
  TempStr:=St;
  S.WriteBuffer(TempStr,Length(TempStr)+1);
end;

{------------------------------------------------------------------}

procedure WriteInt(S:TStream;Value:Integer);
Var
  K:Integer;
begin
  K:=Value;
  S.WriteBuffer(K,4);
end;

{------------------------------------------------------------------}

procedure WriteWord(S:TStream;Value:Word);
Var
  K:Word;
begin
  K:=Value;
  S.WriteBuffer(K,2);
end;

{---------------------------------------------------}

procedure SetMethodTable(A:TClass;Value:Pointer);
var
  v : DWORD;
begin
  v := integer(Value);
  WriteMemory(Pointer(integer(A) + vmtMethodTable), @V, 4);
end;

{------------------------------------------------------------------}

const
  DisplayPropNameCount = 6;
  DisplayPropNames : array[1..DisplayPropNameCount] of string =
    ('Caption', 'Text', 'Name', 'Title', 'FieldName', 'VerbName'); //don't resource

function GetColItemDisplayName(T : TCollectionItem) : string;
  {$IFDEF D3}
begin
  result := '';
  If T=nil then
    exit;
  Result:=T.DisplayName;
  {$ELSE}

var
  pinfo : PPropInfo;
  i     : integer;
begin
  result := '';
  If T=nil then
    exit;
  for i := 1 to DisplayPropNameCount do
    begin
      pinfo := GetPropInfo(T.ClassInfo, DisplayPropNames[i]);
      if (pinfo = nil) or not (GetPTypeInfo(pinfo).kind in [tkString,tkWChar, tkLString]) then
        continue;
      result := GetStrProp(T, pinfo);

      if result <> '' then
        break;
    end;
  if result = '' then
    Result := T.ClassName;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure SafeRegisterClasses(AClasses:Array of TPersistentClass);
var
  i:Integer;
begin
  for i:=Low(AClasses) to High(AClasses) do
    SafeRegisterClass(AClasses[i]);
end;

{------------------------------------------------------------------}

procedure SafeRegisterClass(AClass: TPersistentClass);
begin
  if AClass <> nil then
    try
      if GetClass(AClass.ClassName) = nil then
        Classes.RegisterClass(AClass);
    except
    end;
end;

{------------------------------------------------------------------}

procedure SetColItemDisplayName(T:TCollectionItem;const S:String);
begin
  {$IFDEF D3}
    T.DisplayName:=S;
  {$ENDIF}
end;

{---------------------------------------------------}

procedure SetClassNamePtr(A:TClass;Value:Pointer);
Var
  V:DWORD;
begin
  V := Integer(Value);
  WriteMemory(Pointer(integer(A) + vmtClassName), @V, 4);
end;

{---------------------------------------------------}

Function ClassNamePtr(A:TClass):Pointer;assembler;
asm
  mov EAX,[EAX].vmtClassName
end;

{------------------------------------------------------------------}

Function GetClassUnit(O:TObject):String;
begin
  Result:=GetTypeData(O.ClassInfo).UnitName;
end;

{------------------------------------------------------------------}

procedure SetEnabledControls(const Ctrls:Array of TPersistent; Enabled:boolean);
begin
  SetPropValues(Ctrls,'Enabled',Enabled); //don't resource
end;

{------------------------------------------------------------------}

procedure SetPropValues(const Ctrls:Array of TPersistent; const PropName:String; const Val:Variant);
var
  i: integer;
begin
 for i:=low(ctrls) to High(ctrls) do
   SetPropValue(ctrls[i],PropName,Val);
end;

{------------------------------------------------------------------}

function PropertyExists(C:TPersistent;const PropName:String):boolean;
begin
  Result:=GetPropInfo(C.ClassInfo, PropName)<>nil;
end;

{------------------------------------------------------------------}

procedure SetPropValue(Instance : TPersistent; const PropName : String; const Value : Variant);
var
  propinfo : PPropInfo;
begin
  If Instance = nil then
    exit;
  propinfo := GetPropInfo(Instance.ClassInfo, PropName);
  if propinfo <> nil then
    SetPropValueByPropInfo(Instance, propinfo, Value);
end;

{------------------------------------------------------------------}

function GetPropValue(Instance : TPersistent; const PropName : string) : Variant;
var
  propinfo : PPropInfo;
begin
  If Instance=nil then
    exit;
  propinfo := GetPropInfo(Instance.ClassInfo, PropName);
  result := GetPropValueByPropInfo(Instance, propinfo);
end;

{------------------------------------------------------------------}

function ExpandRelativeFileName(const BaseFileName, RelativeFileName : String;
                                AFilerID : TFilerID) : String;
var
  BasePath:String;
begin
  if RelativeFileName='' then
  begin
    Result:='';
    exit;
  end;

  BasePath:=ExtractFilePath(BaseFileName);

  Result:=ExpandRelativePath(BasePath, RelativeFileName, AFilerID);
end;

{------------------------------------------------------------------}

function ExpandRelativePath(const BaseName,RelativeName:String; const AFilerID : TFilerID):string;
Var
  CurDir:String;
  FSystem : TFileSystem;
begin
  Result:='';
  FSystem := GetFileSystem(AFilerID);
  try
    CurDir := FSystem.GetCurrentDir;
    FSystem.SetCurrentDir(BaseName);
    try
      Result := ExpandFileName(RelativeName);//AddSlash(FSystem.GetCurrentDir) + ExtractFileName(RelativeName);
    finally
      FSystem.SetCurrentDir(CurDir);
    end;
  finally
    ReleaseFileSystem(FSystem);
  end;
end;

{--------------------------------------------}

procedure SimpleBroadCast(M:Integer);
begin
  BroadcastToNotifiers(nil,M,0,0);
end;

{------------------------------------------------------------------}

Var
  FNotifiers:TList=nil;

function Notifiers:TList;
begin
  Result:=CreateListIfEmpty(FNotifiers);
end;

procedure RegisterNotifier(C:TObject);
begin
  if c = nil then
    exit;

  with Notifiers do
    begin
      Remove(C);
      Add(C);
    end;
end;

{------------------------------------------------------------------}

procedure UnregisterNotifier(C:TObject);
begin
  Notifiers.Remove(c);
end;

{------------------------------------------------------------------}

function BroadcastToNotifiersEx(Self:TObject;Msg: Cardinal; WParam, LParam: Longint;
           ExitOnDisagree:boolean):boolean;
begin
  Result:=BroadcastToNotifierList(Self,Notifiers,Msg,WParam,LParam,ExitOnDisagree);
end;

{------------------------------------------------------------------}

function BroadcastToNotifierList(Self:TObject;Notifiers:TList;Msg: Cardinal; WParam, LParam: Longint;
           ExitOnDisagree:boolean):boolean;
Var
  i:Integer;
//  F:TObject;
  M:TMessage;
begin
  Result:=True;
  With Notifiers do
  begin
    M.wParam:=wParam;
    M.lParam:=lParam;
    M.Msg:=Msg;
    M.Result:=0;

    i:=Count-1;
    While i>=0 do
    begin
      TObject(Items[i]).Dispatch(M);
      If ExitOnDisagree and (M.Result<>0) then
      begin
        Result:=False;
        exit;
      end;
      i:=Min(Count,i);
      dec(i);
    end;
  end;
end;

{------------------------------------------------------------------}

function NotifiersAgree(Self:TObject;Msg: Cardinal; WParam, LParam: Longint):boolean;
begin
  Result:=BroadcastToNotifiersEx(Self,Msg,WParam, LParam,True);
end;

{------------------------------------------------------------------}

procedure BroadCastToNotifiers(Self:TObject;Msg: Cardinal; WParam, LParam: Longint);
begin
  BroadcastToNotifiersEx(Self,Msg,WParam, LParam,False);
end;

{---------------------------------------------------------------------}
{$IFDEF WIN}
{$IFNDEF CLX}
Function GetTransparentColor(dc: THandle; const arect: TRect): longint;
Begin
  result := GetPixel(dc, arect.left, arect.bottom);
End;

{------------------------------------------------------------------}

function StringToGUID(const s: string): TGUID;
var
  p : PWideChar;
begin
  p := DCStringToOleSt(s);
  CLSIDFromString(p, Result);
  SysFreeString(p);
end;

{------------------------------------------------------------------}

function GUIDToString(const ClassID: TGUID): string;
var
  P: PWideChar;
begin
  StringFromCLSID(ClassID, P);
  Result := WideCharToString(P);
  CoTaskMemFree(P);
end;
{$ENDIF}
{$ENDIF}

{------------------------------------------------------------------}
{$IFNDEF D3}
function AnsiStrIComp(S1, S2: PChar): Integer;
begin
  Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, S1, -1,
    S2, -1) - 2;
end;

{------------------------------------------------------------------}

function ExtractRelativePath(const BaseName, DestName: string): string;
var
  BasePath, DestPath: string;
  BaseDirs, DestDirs: array[0..129] of PChar;
  BaseDirCount, DestDirCount: Integer;
  I, J: Integer;

  function ExtractFilePathNoDrive(const FileName: string): string;
  begin
    Result := ExtractFilePath(FileName);
    Result := Copy(Result, Length(ExtractFileDrive(FileName)) + 1, 32767);
  end;

  procedure SplitDirs(var Path: string; var Dirs: array of PChar;
    var DirCount: Integer);
  var
    I, J: Integer;
  begin
    I := 1;
    J := 0;
    while I <= Length(Path) do
    begin
      if Path[I] in LeadBytes then Inc(I)
      else if Path[I] = SlashString then             { Do not localize }
      begin
        Path[I] := #0;
        Dirs[J] := @Path[I + 1];
        Inc(J);
      end;
      Inc(I);
    end;
    DirCount := J - 1;
  end;

begin
  if AnsiCompareText(ExtractFileDrive(BaseName), ExtractFileDrive(DestName)) = 0 then
  begin
    BasePath := ExtractFilePathNoDrive(BaseName);
    DestPath := ExtractFilePathNoDrive(DestName);
    SplitDirs(BasePath, BaseDirs, BaseDirCount);
    SplitDirs(DestPath, DestDirs, DestDirCount);
    I := 0;
    while (I < BaseDirCount) and (I < DestDirCount) do
    begin
      if AnsiStrIComp(BaseDirs[I], DestDirs[I]) = 0 then
        Inc(I)
      else Break;
    end;
    Result := '';
    for J := I to BaseDirCount - 1 do
      Result := Result + '..\';              { Do not localize }
    for J := I to DestDirCount - 1 do
      Result := Result + DestDirs[J] + SlashString;  { Do not localize }
    Result := Result + ExtractFileName(DestName);
  end else Result := DestName;
end;

function CompareMem(P1, P2: Pointer; Length: Integer): Boolean; assembler;
asm
        PUSH    ESI
        PUSH    EDI
        MOV     ESI,P1
        MOV     EDI,P2
        MOV     EDX,ECX
        XOR     EAX,EAX
        AND     EDX,3
        SHR     ECX,1
        SHR     ECX,1
        REPE    CMPSD
        JNE     @@2
        MOV     ECX,EDX
        REPE    CMPSB
        JNE     @@2
@@1:    INC     EAX
@@2:    POP     EDI
        POP     ESI
end;

{$ENDIF}

{-----------------------------------------------------------------------}

function RectWidth(const R:TRect):Integer;
begin
  With R do
    Result := right - left;
end;

{-----------------------------------------------------------------------}

function RectHeight(const R:TRect):Integer;
begin
  With R do
    Result := bottom - top;
end;

{-----------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}
function TransparentStretchBlt(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcDC: HDC; SrcX, SrcY, SrcW, SrcH: Integer; MaskDC: HDC; MaskX,
  MaskY: Integer): Boolean;
const
  ROP_DstCopy = $00AA0029;
var
  MemDC  : THandle;
  MemBmp : THandle;
  Save   : THandle;
  crText : TColorRef;
  crBack : TColorRef;
begin
  Result := True;
  if UnderWindowsNT and (SrcW = DstW) and (SrcH = DstH) then
    begin
      MemBmp := CreateCompatibleBitmap(SrcDC, 1, 1);
      MemBmp := SelectObject(MaskDC, MemBmp);
      MaskBlt(DstDC, DstX, DstY, DstW, DstH, SrcDC, SrcX, SrcY, MemBmp, MaskX,
              MaskY, MakeRop4(ROP_DstCopy, SrcCopy));
      MemBmp := SelectObject(MaskDC, MemBmp);
      DeleteObject(MemBmp);
      exit;
    end;

  MemDC := CreateCompatibleDC(0);
  MemBmp := CreateCompatibleBitmap(SrcDC, SrcW, SrcH);
  Save := SelectObject(MemDC, MemBmp);
  StretchBlt(MemDC, 0, 0, SrcW, SrcH, MaskDC, MaskX, MaskY, SrcW, SrcH, SrcCopy);
  StretchBlt(MemDC, 0, 0, SrcW, SrcH, SrcDC, SrcX, SrcY, SrcW, SrcH, SrcErase);
  crText := SetTextColor(DstDC, $0);
  crBack := SetBkColor(DstDC, $FFFFFF);
  StretchBlt(DstDC, DstX, DstY, DstW, DstH, MaskDC, MaskX, MaskY, SrcW, SrcH, SrcAnd);
  StretchBlt(DstDC, DstX, DstY, DstW, DstH, MemDC, 0, 0, SrcW, SrcH, SrcInvert);
  SetTextColor(DstDC, crText);
  SetBkColor(DstDC, crBack);
  SelectObject(MemDC, Save);
  DeleteObject(MemBmp);
  DeleteDC(MemDC);
end;

Procedure TransparentBitBlt(sourcedc, destdc: THandle; arect: TRect;
    atranscolor: longint; aoriginX,aoriginY: Integer);

begin
  TransparentBitBltEx(sourcedc, destdc,arect,
    Rect(aoriginX,aoriginY,aoriginX+RectWidth(arect),aoriginY+RectHeight(arect)),
    atranscolor);
end;

{Var
  monobitmap: THandle;
  oldbkcolor: longint;
  monodc: THandle;
  width: integer;
  height: integer;
  oldbitmap: THandle;
Begin
  With arect do
  Begin
    width := right - left;
    height := bottom - top;
    monodc := CreateCompatibleDC(sourcedc);
    monobitmap := CreateCompatibleBitmap(monodc, width, height);
    oldbitmap := SelectObject(monodc, monobitmap);
    Try
      oldbkcolor := SetBkColor(sourcedc, atranscolor);
      BitBlt(monodc, 0, 0, width, height, sourcedc, 0, 0, SRCCOPY);
      SetBkColor(sourcedc, oldbkcolor);
      TransparentStretchBlt(destdc, aoriginx, aoriginy, width, height,
        SourceDC, left, top, width, height, monodc, 0, 0);
    Finally
      SelectObject(monodc, oldbitmap);
      DeleteDC(monodc);
      DeleteObject(monobitmap);
    End;
  End;
End;}

{-----------------------------------------------------------------------}

Procedure TransparentBitBltEx(sourcedc, destdc: THandle; SrcRect,DstRect: TRect;
    atranscolor: longint);
Var
  monobitmap: THandle;
  oldbkcolor: longint;
  monodc: THandle;
  width: integer;
  height: integer;
  oldbitmap: THandle;
Begin
  With SrcRect do
  Begin
    width := RectWidth(SrcRect);
    height := RectHeight(SrcRect);
    monodc := CreateCompatibleDC(sourcedc);
    monobitmap := CreateCompatibleBitmap(monodc, width, height);
    oldbitmap := SelectObject(monodc, monobitmap);
    Try
      oldbkcolor := SetBkColor(sourcedc, atranscolor);
      BitBlt(monodc, 0, 0, width, height, sourcedc, Left, Top, SRCCOPY);
      SetBkColor(sourcedc, oldbkcolor);
      TransparentStretchBlt(destdc, DstRect.Left, DstRect.Top, RectWidth(DstRect),
        RectHeight(DstRect),
        SourceDC, left, top, width, height, monodc, 0, 0);
    Finally
      SelectObject(monodc, oldbitmap);
      DeleteDC(monodc);
      DeleteObject(monobitmap);
    End;
  End;
End;


Procedure CorrectLeftByRect(Var InRect:TRect;const OutRect:TRect);
Begin
  If InRect.Left<OutRect.Left Then
    InRect.Left:=OutRect.Left
End;

{---------------------------------------------------------}

Procedure CorrectTopByRect(Var InRect:TRect;const OutRect:TRect);
Begin
  If InRect.Top<OutRect.Top Then
    InRect.Top:=OutRect.Top
End;

{---------------------------------------------------------}

Procedure CorrectRightByRect(Var InRect:TRect;const OutRect:TRect);
Begin
  If InRect.Right>OutRect.Right Then
    InRect.Right:=OutRect.Right
End;

{---------------------------------------------------------}

Procedure CorrectBottomByRect(Var InRect:TRect;const OutRect:TRect);
Begin
  If InRect.Bottom>OutRect.Bottom Then
    InRect.Bottom:=OutRect.Bottom
End;

{---------------------------------------------------------}

Procedure HCenterRect(Var Source:TRect;const Dest:TRect);
Var
  TextHeight:Integer;
Begin
  TextHeight:=Source.Right-Source.Left;
  Source.Left:=(Dest.Right+Dest.Left-TextHeight) Div 2;
  Source.Right:=Source.Left+TextHeight;
End;

{---------------------------------------------------------}

Procedure VBottomRect(Var Source:TRect;const Dest:TRect);
Var
  TextHeight:Integer;
Begin
  TextHeight:=Source.Bottom-Source.Top;
  Source.Bottom:=Dest.Bottom;
  Source.Top:=Dest.Bottom-TextHeight;
End;

{---------------------------------------------------------}

Procedure VCenterRect(Var Source:TRect;const Dest:TRect);
Var
  TextHeight:Integer;
Begin
  TextHeight:=Source.Bottom-Source.Top;
  Source.Top:=(Dest.Bottom+Dest.Top-TextHeight) Div 2;
  Source.Bottom:=Source.Top+TextHeight;
End;

{---------------------------------------------------------}

Procedure CorrectRectByRect(Var InRect:TRect;const OutRect:TRect);
Begin
  CorrectLeftByRect(InRect,OutRect);
  CorrectTopByRect(InRect,OutRect);
  CorrectRightByRect(InRect,OutRect);
  CorrectBottomByRect(InRect,OutRect);
End;

{---------------------------------------------------------}

Function AlignRectByRect(const ARectIn,ARectOut:TRect;
                          HorzAlignment:THorzAlignment;
                          VertAlignment:TVertAlignment;
                          AMinHSpace,AMinVSpace:Integer):TRect;
Var
  Size:Integer;
  MaxPoint:Integer;
Begin
  Result:=ARectOut;
  Size:=ARectIn.Right-ARectIn.Left;
  Case HorzAlignment Of
    haLeft:
      With Result Do
      Begin
        Result.Right:=ARectOut.Left+Size;
        MaxPoint:=ARectOut.Right-AMinVSpace;
        If Right>MaxPoint Then
          Right:=MaxPoint;
      End;
    haCenter:
      With Result Do
      Begin
        Left:=(ARectOut.Right+ARectout.Left-Size) Div 2;
        Right:=Left+Size;
      End;
    haRight:
      With Result Do
      Begin
        Left:=ARectOut.Right-Size;
        MaxPoint:=ARectOut.Left+AMinHSpace;
        If Left<MaxPoint Then
          Left:=MaxPoint;
      End;
  End;
  Size:=ARectIn.Bottom-ARectIn.Top;
  Case VertAlignment Of
    vaLeft:
      With Result Do
      Begin
        Result.Bottom:=ARectOut.Top+Size;
        MaxPoint:=ARectOut.Bottom-AMinVSpace;
        If Bottom>MaxPoint Then
          Bottom:=MaxPoint;
      End;
    vaCenter:
      With Result Do
      Begin
        Top:=(ARectOut.Bottom+ARectout.Top-Size) Div 2;
        Bottom:=Top+Size;
      End;
    vaRight:
      With Result Do
      Begin
        Top:=ARectOut.Bottom-Size;
        MaxPoint:=ARectOut.Top+AMinHSpace;
        If Top<MaxPoint Then
          Top:=MaxPoint;
      End;
  End;
  CorrectRectByRect(Result,ARectOut);
End;

{---------------------------------------------------------}


Procedure FillRectEx(Canvas:TCanvas;const ARect,ExcludeRect:TRect);//LLTTRR
Begin                                                              //LLEERR
  With Canvas Do                                                   //LLEERR
  Begin                                                            //LLBBRR
    FillRect(Rect(ARect.Left,ARect.Top,ExcludeRect.Left,ARect.Bottom));//left rect
    FillRect(Rect(ExcludeRect.Right,ARect.Top,ARect.Right,ARect.Bottom));//right rect
    FillRect(Rect(ExcludeRect.Left,ARect.Top,ExcludeRect.Right,ExcludeRect.Top));//top rect
    FillRect(Rect(ExcludeRect.Left,ExcludeRect.Bottom,ExcludeRect.Right,ARect.Bottom));//bottom rect
  End;
End;

{---------------------------------------------------------}

Procedure DrawTextWithFill(Canvas:TCanvas;const Str:String;Mode:Integer;AllRect:TRect);
Var
  TextRect:TRect;
  OldMode:Integer;
Begin
  OldMode:=Mode;
  TextRect:=AllRect;
  Mode:=Mode And Not DT_BOTTOM And Not DT_CENTER And Not DT_VCENTER;
  If Str<>'' Then
  Begin
    DrawText(Canvas.Handle,PChar(Str),Length(Str),TextRect,Mode Or DT_CALCRECT);
    CorrectRightByRect(TextRect,AllRect);
  End
  Else
    Canvas.FillRect(AllRect);
  If IsRectEmpty(TextRect) Then
  Begin
    TextRect:=AllRect;
    Exit;
  End;
  If (OldMode And DT_CENTER)<>0 Then
    HCenterRect(TextRect,AllRect);
  If (OldMode And DT_BOTTOM)<>0 Then
    VBottomRect(TextRect,AllRect);
  If (OldMode And DT_VCENTER)<>0 Then
    VCenterRect(TextRect,AllRect);
  DrawText(Canvas.Handle,PChar(Str),Length(Str),TextRect,Mode);
  FillRectEx(Canvas,AllRect,TextRect);
End;

{$ENDIF}
{$ENDIF}

{*******************************************************************}

procedure TNotifierList.NotifyEvents(Sender:TObject;wParam,lParam:Integer);
var
  i:integer;
begin
  With FCollection do
  begin
    i:=Count-1;
    While i>=0 do
    begin
      TNotifierListItem(Items[i]).Method(Sender,wParam,lParam);
      i:=Min(Count,i);
      dec(i);
    end;
  end;
end;

{-------------------------------------------------------------------}

destructor TNotifierList.Destroy;
begin
  FCollection.Free;
  inherited;
end;

{-------------------------------------------------------------------}

constructor TNotifierList.Create;
begin
  inherited;
  FCollection:=TCollection.Create(TNotifierListItem);
end;

{-------------------------------------------------------------------}

procedure TNotifierList.AddMethod(T:TNotifierProc);
begin
  DeleteMethod(T);
  (FCollection.Add as TNotifierListItem).Method:=T;
end;

{-------------------------------------------------------------------}

procedure TNotifierList.DeleteWithData(Data:Pointer);
Var
  i:integer;
begin
  With FCollection do
  for i:=Count-1 downto 0 do
    if TMethod(TNotifierListItem(Items[i]).Method).Data=Data then
      Items[i].Free;
end;

{-------------------------------------------------------------------}

procedure TNotifierList.DeleteMethod(T:TNotifierProc);
Var
  i:integer;
begin
  With FCollection do
  for i:=0 to Count-1 do
  if isMethodsEqual(TMethod(TNotifierListItem(Items[i]).Method),TMethod(T)) then
  begin
    Items[i].Free;
    exit;
  end;
end;

{******************************************************************}

{$IFDEF WIN}
{$IFNDEF CLX}
constructor TRegistryStream.Create(const Key : string; Mode : integer);
begin
  fkey := Key;
  if Mode = fmCreate then
    WriteLongBufToRegistry(Key, Mode, 0)
  else
    begin
      fInitSize := GetLongRegBufSize(Key);
      If fInitSize>0 then
      begin
        SetSize(fInitSize);
        ReadLongBufFromRegistry(Key, Memory^, Size);
      end;
    end;
end;

{------------------------------------------------------------------}

destructor  TRegistryStream.Destroy;
begin
  if fModified or (fInitSize <> -1) and (fInitSize <> Size) then
    WriteLongBufToRegistry(fKey, Memory^, Size);

  inherited;
end;

{------------------------------------------------------------------}

function TRegistryStream.Write(const Buffer; Count: Longint): Longint;
begin
  result := inherited Write(Buffer, Count);
  fModified := true;
end;
{$ENDIF}
{$ENDIF}

{******************************************************************}

function CreateListIfEmpty(var L:TList):TList;
begin
  if L = nil then
    L := TList.Create;
  Result := L;
end;

{------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}

procedure UniWriteObjToRegistry(const Key:String;Instance:TPersistent; TextMode : boolean);
Var
  Stream:TRegistryStream;
begin
  Stream:=TRegistryStream.Create(Key,fmCreate);
  try
    if TextMode then
      WriteObjToTextStream(Stream, Instance)
    else
      WriteObjToStream(Stream,Instance)
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------}

procedure WriteObjToRegistry(const Key:String;Instance:TPersistent);
begin
  UniWriteObjToRegistry(Key, Instance, false);
end;

{------------------------------------------------------------------}

procedure WriteObjTextToRegistry(const Key:String;Instance:TPersistent);
begin
  UniWriteObjToRegistry(Key, Instance, true);
end;

{------------------------------------------------------------------}

procedure UniReadObjFromRegistry(const Key:String;Instance:TPersistent; TextMode : boolean);
Var
  Stream:TRegistryStream;
begin
  Stream:=TRegistryStream.Create(Key,fmOpenRead);
  try
    If Stream.Size>0 then
      if TextMode then
        ReadObjFromTextStream(Stream,Instance)
      else
        ReadObjFromStream(Stream,Instance)
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------}

procedure ReadObjTextFromRegistry(const Key:String;Instance:TPersistent);
begin
  UniReadObjFromRegistry(Key, Instance, true);
end;

{------------------------------------------------------------------}

procedure ReadObjFromRegistry(const Key:String;Instance:TPersistent);
begin
  UniReadObjFromRegistry(Key, Instance, false);
end;

{$ENDIF}
{$ENDIF}
{------------------------------------------------------------------}

procedure _WritePropsToStream(Writer : TWriter; Inst : TComponent; PropNames : TStrings);
var
  PropCount : Integer;
  PropList  : PPropList;
  SaveStoreList : TList;
  i   : integer;
  p   : pointer;
  pinfos  : TList;
  savepos : integer;
  endpos  : integer;
  delta   : integer;

begin
  if Inst = nil then
    exit;

  if Writer is TMWriter then
    TMWriter(Writer).SkipObject := inst;
      
  PropCount := GetTypeData(Inst.ClassInfo)^.PropCount;
  GetMem(PropList, PropCount * SizeOf(Pointer));
  SaveStoreList := TList.Create;
  pinfos := TList.Create;
  try
    for i := 0 to PropNames.Count - 1 do
      pinfos.Add(GetPropInfo(Inst.ClassInfo, PropNames[i]));

    GetPropInfos(Inst.ClassInfo, PropList);
    p := nil;

    for i := 0 to PropCount - 1 do
      if pinfos.IndexOf(PropList^[I]) < 0 then
        with PropList^[I]^ do
          begin
            SaveStoreList.Add(StoredProc);
            WriteMemory(@StoredProc, @p, 4);
          end
        else
          SaveStoreList.Add(nil);

    with Writer do
      try
        Write(savepos, sizeof(integer));
        savepos := Position;
        WriteDescendent(Inst, nil);
        endpos := Position;
        delta := endpos - savepos;
        FlushBuffer;
        Position := savepos - sizeof(integer);
        Write(delta, sizeof(integer));
        Position := endpos;
      finally
        for i := 0 to PropCount - 1 do
          if pinfos.IndexOf(PropList^[I]) < 0 then
            with PropList^[I]^ do
              begin
                p := SaveStoreList[i];
                WriteMemory(@StoredProc, @p, 4);
              end;
    end;
  finally
    FreeMem(PropList, PropCount * SizeOf(Pointer));
    SaveStoreList.Free;
    pinfos.Free;
  end;
end;

{------------------------------------------------------------------}

procedure ReadPropsFromStream(Stream : TStream; Instance : TComponent);
var
  size : integer;
begin
  if Instance = nil then
    exit;

  with TPropReader.Create(Stream, 4096, Instance) do
    try
      Read(size, sizeof(integer)); //
      ReadRootComponent(Instance);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure WritePropsToStream(Stream : TStream; Instance : TComponent; const PropNames : array of string);
var
  w : TWriter;
  pnames : TStrings;
  i      : integer;
begin
  if Instance = nil then
    exit;

  w := TMWriter.Create(Stream, 4096, Instance);
  pnames := TStringList.Create;
  with w do
    try
      IgnoreChildren := true;
      for i := Low(PropNames) to High(PropNames) do
        pnames.Add(PropNames[i]);
      _WritePropsToStream(w, Instance, pnames);
    finally
      Free;
      pnames.Free;
    end;
end;

{------------------------------------------------------------------}

constructor TPropReader.Create(Stream: TStream; BufSize: Integer; ASkipObject : TObject);
begin
  inherited Create(Stream, BufSize);
  SkipObject := SkipObject;
end;

{------------------------------------------------------------------}

procedure TPropReader.DefineProperty(const Name: string;
      ReadData: TReaderProc; WriteData: TWriterProc; HasData: Boolean);
begin
  exit;
  if TMethod(ReadData).Data <> SkipObject then
    inherited;
end;

{------------------------------------------------------------------}

procedure TPropReader.DefineBinaryProperty;
begin
  exit;
  if TMethod(ReadData).Data <> SkipObject then
    inherited;
end;

{******************************************************************}

constructor TMWriter.Create(Stream: TStream; BufSize: Integer; ASkipObject : TObject);
begin
  inherited Create(Stream, BufSize);
  SkipObject := ASkipObject;
end;

{------------------------------------------------------------------}

procedure TMWriter.DefineProperty;
begin
  if TMethod(WriteData).Data <> SkipObject then
    inherited;
end;

{------------------------------------------------------------------}

procedure TMWriter.DefineBinaryProperty;
begin
  if TMethod(WriteData).Data <> SkipObject then
    inherited;
end;

{******************************************************************}

constructor TMessageAnswer.Create;
begin
  inherited;
  RegisterNotifier(Self);
end;

{------------------------------------------------------------------}

destructor TMessageAnswer.Destroy;
begin
  UnregisterNotifier(Self);
  inherited;
end;

{******************************************************************}

{$IFDEF D3}
function GetCompName(Comp:TPersistent):String;
begin
  if Comp = nil then
    result := ''
  else
    Result:=Comp.GetNamePath;
end;
{$ELSE}
function GetCompName(Comp:TPersistent):String;
begin
  If Comp is TComponent
  then
    Result:=TComponent(Comp).Name
  else
    Result:='';
end;
{$ENDIF}

type
  THack=class(TPersistent)
  end;

{------------------------------------------------------------------}

function SmartSkipResHeader(S:TStream;OnlyCheck:boolean):boolean;
var
  ReadCount: DWORD;
  Header: array[0..79] of Char;
  OldPos:Integer;
begin
  With S do
  begin
    FillChar(Header, SizeOf(Header), 0);
    OldPos:=Position;
    ReadCount := Read(Header, SizeOf(Header) - 1);
    Result:=(Byte((@Header[0])^) = $FF) and (Word((@Header[1])^) = 10);
    If Result and (not OnlyCheck) then
      Seek(StrLen(Header + 3) + 10 - ReadCount, 1)
    else
      Seek(OldPos,soFromBeginning);
  end;
end;

{------------------------------------------------------------------}

procedure CompListNamesToProc(List:TList;OwnerComp : TComponent; TypeData: PTypeData;
            Proc: TGetStrProc);
var
  i : integer;
begin
  for i := 0 to List.Count - 1 do
    CompNamesToProc(TComponent(List.List[i]), OwnerComp, TypeData, Proc);
end;

{------------------------------------------------------------------}

procedure CompNamesToProc(container,OwnerComp : TComponent; TypeData: PTypeData;
            Proc: TGetStrProc);
var
  i : integer;
  s : string;
begin
  if Assigned(container) then
    with container do
      for i := 0 to ComponentCount - 1 do
        if (Components[i].Name <> '') and
           (Components[i] is Typedata^.ClassType) then
             begin
               s := Components[i].Name;
               if container <> OwnerComp then
                 s := name + '.' + s;
               Proc(s);
             end;
end;

{----------------------------------------------------------}

function GetClassFromStream(S : TStream) : TComponentClass;
var
  savepos : integer;
  i       : Integer;
  flags   : TFilerFlags;
begin
  savepos := S.Position;
  try
    SmartSkipresHeader(S,False);

    with TReader.Create(S, 64) do
      try
        ReadSignature;
        ReadPrefix(flags, i);
        Result := TComponentClass(GetClass(ReadStr));
      finally
        Free;
      end;
  finally
    S.Position := savepos;
  end;
end;

{--------------------------------------------}

var
  fOldFindComp : TFindGlobalComponent = nil;
  fFindProc : TFindComponentProc = nil;

function FindComponentGlobal(const Name: string): TComponent;
begin
  if @fFindProc <> nil then
    result := fFindProc(Name)
  else if @fOldFindComp <> nil then
    result := fOldFindComp(Name)
  else
    result := nil;
end;

{-------------------------------------------------------------------------}

function SetFindGlobalCompProc(Proc : TFindComponentProc):boolean;
begin
  if Assigned(FFindProc) then
  begin
    Result:=False;
    exit;
  end;
  {$IFDEF D6}
  RegisterFindGlobalComponentProc(FindComponentGlobal);
  {$ELSE}
  if @fOldFindComp = nil then
    fOldFindComp := FindGlobalComponent;
  FindGlobalComponent := FindComponentGlobal;
  {$ENDIF}
  fFindProc := Proc;
  Result:=True;
end;

{-------------------------------------------------------------------------}

procedure RemoveFindGlobalCompProc;
begin
  {$IFDEF D6}
  UnRegisterFindGlobalComponentProc(FindComponentGlobal);
  {$ENDIF}
  fFindProc := nil;
end;

{------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}
function GetClassModule(C : TClass) : THandle;
var
  M : TMemoryBasicInformation;
begin
  VirtualQuery(C, M, SizeOf(M));
  result := 0;
  if M.Type_9 = MEM_IMAGE then
    result := integer(M.AllocationBase);
end;

{------------------------------------------------------------------}

procedure RegisterOCX(const FileName : string);
type
  TRegProc = function : HResult; stdcall;
var
  lib : THandle;
  RegProc: TRegProc;
const
  RegName = 'DllRegisterServer'; //don't resource
begin
  Lib := LoadLibrary(PChar(FileName));
  if Lib = 0 then
    raise Exception.CreateFmt(SErrOCXLoadFail, [FileName]);
  try
    @RegProc := GetProcAddress(Lib, RegName);
    if @RegProc = nil then
      raise Exception.CreateFmt(SErrOCXCantFindProc, [RegName, FileName]);
    if RegProc <> 0 then
      raise Exception.CreateFmt(SErrOCXRegFail, [RegName, FileName]);
  finally
    FreeLibrary(Lib);
  end;
end;

{------------------------------------------------------------------}

function ExtractActiveXHint(Const AHint:String):String;
begin
  Result:=AnsiUpperCase(AHint);
  If Pos('CONTROL',Result)=Length(Result)-6 //don't resource
  then
    Result:=Trim(Copy(AHint,1,Length(Result)-7))
  else
    Result:=Trim(AHint);
end;

{------------------------------------------------------------------}

function  GetTypeLibName(const guid : TGUID) : string;
var
  knames : TStringList;
begin
  knames := TStringList.Create;
  with TRegistry.Create do
    try
      RootKey := HKEY_CLASSES_ROOT;
      if OpenKey('TypeLib\'+GUIDToString(guid), false) then //don't resource
        begin
          GetKeyNames(knames);
          OpenKey(knames[0], false);
          result := ReadString('');
        end;
    finally
      Free;
      knames.Free;
    end;
end;

{------------------------------------------------------------------}
{$ENDIF}
{$ENDIF} //WIN

function FindUniqueName(const Name: string): string;
var
  I: Integer;
begin
  I := 0;
  Result := '';
{$IFNDEF D6}
  if Assigned(FindGlobalComponent) then
  begin
{$ENDIF}
    Result := Name;
    while FindGlobalComponent(Result) <> nil do
    begin
      Inc(I);
      Result := Format('%s_%d', [Name, I]); //don't resource
    end;
{$IFNDEF D6}
  end;
{$ENDIF}
end;

{------------------------------------------------------------------}

function NameIsUnique(AOwner : TComponent; const AName : string) : boolean;
begin
  result := true;

  while AOwner <> nil do
    begin
      result := AOwner.FindComponent(AName) = nil;
      if not result then
        exit;

      AOwner := AOwner.Owner;
    end;
end;

{------------------------------------------------------------------}

function UniqueName(AOwner : TComponent; const BaseName: string): string;
var
  i     : integer;
begin
  i := 0;
  repeat
    inc(i);
    result := basename + IntToStr(i);
  until (AOwner = nil) or NameIsUnique(AOwner, result);
end;

{------------------------------------------------------------------}

function ExtractControlName(const aname : string) : string;
var
  p : integer;
begin
  result := aname;
  p := pos('.', result);
  if p <> 0 then
    delete(result, 1, p);

  p := pos('.', result);
  if p <> 0 then
    delete(result, p, length(result) - p + 1);
end;

{------------------------------------------------------------------}

function StringFromRType(RType:Pchar):string;
begin
 if integer(rtype) < 23 then
    result := PredefinedResourcesTypesNames[integer(rtype)]
  else
    result := StrPas(rtype);
end;

{------------------------------------------------------------------}

function StringFromRName(ResName : pchar) : string;
begin
  if integer(ResName) < $FFFF then
    result := IntToStr(integer(ResName))
  else
    result := StrPas(ResName);
end;

{------------------------------------------------------------------}

function CreateList : TList;
begin
  result := TList.Create;
end;

{-------------------------------------------------------------------------}
(*
procedure RegisterInitProc(InitProc:TInitProc;ForInstant:boolean);
begin
  If GetClassEx(TInitProcClass,[SVarInitProc],[Integer(@InitProc)],[])=nil then
    RegisterClassExt(TInitProcClass,[SVarRegistered,SVarInitProc,SVarForInstant],
      [False,Integer(@InitProc),ForInstant])
{  else
    SendDebug(IntToHex(Integer(@InitProc),4));}
end;
*)
{-------------------------------------------------------------------------}

procedure RegisterForDelphi(InitProc:TInitProc);
begin
  InitProc;
end;

{-------------------------------------------------------------------------}

procedure RegisterForInstant(InitProc:TInitProc);
begin
  if not UnderDelphiIDE then
    InitProc;
//  RegisterInitProc(InitProc,True);
end;

{------------------------------------------------------------------}

function  StringsToString(S : TStrings; Separator : Char) : string;
var
  i : integer;
begin
  result := '';
  for i := 0 to S.Count - 1 do
    begin
      AddStr(result, S[i]);
      if i < S.Count - 1 then
        AddStr(result, Separator);
    end;
end;

{-------------------------------------------------------------------------}

function TListWrapper.GetCount:Integer;
begin
  Result:=FList.Count;
end;

{-------------------------------------------------------------------------}

function TListWrapper.GetClass(Index:Integer):TClass;
begin
  Result:=FList[Index];
end;

{-------------------------------------------------------------------------}

function TListWrapper.GetObject(Index:Integer):TObject;
begin
  Result:=FList[Index];
end;

{-------------------------------------------------------------------------}

constructor TListWrapper.Create;
begin
  inherited;
  FList:=TSortedList.Create;
end;

{-------------------------------------------------------------------------}

destructor TListWrapper.Destroy;
begin
  FList.Free;
  inherited;
end;

{-------------------------------------------------------------------------}

procedure TListWrapper.Add(P:Pointer);
begin
  FList.Add(P);
end;

{-------------------------------------------------------------------------}

procedure TListWrapper.Remove(P:Pointer);
begin
  FList.Remove(P);
end;

{------------------------------------------------------------------}

function TFileSystem.GetTempFileName(const FileName: TFileName): TFileName;
begin
  Result:=FileName;
end;

{------------------------------------------------------------------}

function TFileSystem.GetCurrentDir:String;
begin
  Result:='';
end;

{------------------------------------------------------------------}

procedure TFileSystem.SetCurrentDir(const Dir:String);
begin
end;

{------------------------------------------------------------------}

function TFileSystem.FileAge(const FileName: TFileName): Integer;
begin
  Result:=0;
end;

{------------------------------------------------------------------}

function TFileSystem.RenameFile(const OldName, NewName: TFileName): Boolean;
begin
  Result:=True;
end;

{------------------------------------------------------------------}

function TFileSystem.IsReadonly(const FileName: TFileName): Boolean;
begin
  Result:=False;
end;

{------------------------------------------------------------------}

function TFileSystem.DeleteFile(const FileName: TFileName): Boolean;
begin
  Result:=True;
end;

{------------------------------------------------------------------}

function TFileSystem.GetFileSystemLevel:TFileSystemLevel;
begin
  Result:=flFullSupport;
end;

{------------------------------------------------------------------}

function TFileSystem.ChangeFileExt(const FileName, Extension : string) : string;
begin
  result := sysutils.ChangeFileExt(FileName, Extension);
end;

{------------------------------------------------------------------}

procedure TFileSystem.RenameFileExcept(const FileName,ToFileName:String);
begin
  If not RenameFile(FileName,ToFileName) then
    raise Exception.CreateFmt(SErrRenameFile,[FileName,ToFileName]);
end;

{------------------------------------------------------------------}

procedure TFileSystem.DeleteFileExcept(const FileName:String);
begin
  If FileExists(FileName) then
    If not DeleteFile(FileName) then
      raise Exception.CreateFmt(SErrDeleteFile,[FileName]);
end;

{-------------------------------------------------------------------------}

procedure TWin32FileSystem.SetCurrentDir(const Dir:String);
begin
  SysUtils.SetCurrentDir(Dir);
end;

{-------------------------------------------------------------------------}

function TWin32FileSystem.GetFileStream(const FileName: TFileName; Mode: Integer): TStream;
begin
  Result:=TFileStream.Create(FileName,Mode);
end;

{-------------------------------------------------------------------------}

function TWin32FileSystem.FileAge(const FileName: TFileName): Integer;
begin
  Result:=SysUtils.FileAge(FileName);
end;

{-------------------------------------------------------------------------}

function TWin32FileSystem.RenameFile(const OldName, NewName: TFileName): Boolean;
begin
  Result:=SysUtils.RenameFile(OldName,NewName);
end;

{-------------------------------------------------------------------------}

function TWin32FileSystem.IsReadonly(const FileName: TFileName): Boolean;
Var
  FileAttrs:Integer;
begin
  FileAttrs:=SysUtils.FileGetAttr(FileName);
  Result:=(FileAttrs<>-1) and ((FileAttrs and SysUtils.faReadOnly)<>0);
end;

{-------------------------------------------------------------------------}

function TWin32FileSystem.DeleteFile(const FileName: TFileName): Boolean;
begin
  Result:=SysUtils.DeleteFile(FileName);
end;

{-------------------------------------------------------------------------}

function TWin32FileSystem.FileExists(const FileName: TFileName): Boolean;
begin
  Result:=SySutils.FileExists(FileName);
end;

{-------------------------------------------------------------------------}
{$IFNDEF CLX}
{$IFDEF WIN}
procedure AddResFromFile(const SrcFile,DstFile, ResName : string);
var
  Stream : TFileStream;
  p      : pointer;
begin
  p := nil;
  Stream := TFileStream.Create(SrcFile, DefaultOpenMode);
  try
    GetMem(p, Stream.Size);
    Stream.Read(p^, Stream.Size);
    AddRCDataResource(DstFile, ResName, p, Stream.Size);
  finally
    FreeMem(p);
    Stream.Free;
  end;
end;
{$ENDIF}
{$ENDIF}
{-------------------------------------------------------------------------}

{$IFNDEF CLX}
function TempFileName(const FileName: TFileName): TFileName;
Var
  FPath:String;
  FName:String;
begin
  FPath:=ExtractFilePath(FileName);
  FName:=ExtractFileName(FileName);
  SetLength(Result,MAX_PATH);
  If Windows.GetTempFileName(PChar(FPath),PChar(FName),0,PChar(Result))=0 then
  begin
    Result:='';
    raise Exception.Create(SErrCantCreateTemp);
  end;
  Result:=String(PChar(Result));
end;
{$ENDIF}
{-------------------------------------------------------------------------}

function TWin32FileSystem.GetTempFileName(const FileName: TFileName): TFileName;
begin
{$IFNDEF CLX}
  Result:=TempFileName(FileName);
{$ELSE}
  result := FileName + RemoveCharSet([',', '.'], FloatToStr(Now));
{$ENDIF}
end;

{-------------------------------------------------------------------------}

var
  FWin32FileSystem:TWin32FileSystem;

function Win32FileSystem:TWin32FIleSystem;
begin
  If FWin32FileSystem=nil then
    FWin32FileSystem:=TWin32FileSystem.Create(nil);

  Result:=FWin32FileSystem;
end;

{-------------------------------------------------------------------------}

function TFileSystem.GetBackupFileName(const FileName: TFileName): TFileName;
begin
  Result:=FileBakName(FileName);
end;

{-------------------------------------------------------------------------}

function TWin32FileSystem.GetCurrentDir:String;
begin
  Result:=SysUtils.GetCurrentDir;
end;

{------------------------------------------------------------------}

type
  TFileSystemListItem=class
  public
    FileSystem:TFileSystem;
    RefCount:Integer;
    destructor Destroy;override;
  end;

destructor TFileSystemListItem.Destroy;
begin
  FileSystem.Free;
  inherited;
end;

{------------------------------------------------------------------}

Var
  FFileSystemList:TStringList=nil;

function GetFileSystem(const FilerID:TFilerID):TFileSystem;
Var
  Index:Integer;
  ListItem:TFileSystemListItem;
  Stream:TMemoryStream;
begin
  If FilerID='' then
  begin
    result:=Win32FileSystem;
    exit;
  end;
  If FFileSystemList=nil then
  begin
    FFileSystemList:=TStringList.Create;
    With FFileSystemList do
    begin
      Sorted:=True;
      Duplicates:=DupIgnore;
    end;
  end;
  With FFileSystemList do
  begin
    If Find(FilerID,Index) then
      With TFileSystemListItem(Objects[Index]) do
      begin
        Result:=FileSystem;
        inc(RefCount);
        exit;
      end;
    Stream:=TMemoryStream.Create;
    try
      Stream.WriteBuffer(FilerID[1],Length(FilerID));
      Stream.Seek(0,soFromBeginning);
      Result:=TFileSystem(Stream.ReadComponent(nil));
      ListItem:=TFileSystemListItem.Create;
      ListItem.RefCount:=1;
      ListItem.FileSystem:=Result;
      AddObject(FilerID,ListItem);
    finally
      Stream.Free;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure ReleaseFileSystem(AFileSystem:TFileSystem);
Var
  i:Integer;
begin
  If AFileSystem=Win32FileSystem then
    exit;
  With FFileSystemList do
    for i:=Count-1 downto 0 do
      with TFileSystemListItem(Objects[i]) do
        if FileSystem=AFileSystem then
        begin
          dec(RefCount);
          if RefCount=0 then
          begin
            Objects[i].Free;
            Delete(i);
          end;
          break;
        end;
end;

{-------TSimpleParser----------------------------------------}

constructor TSimpleParser.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FNotifiers := TNotifierList.Create;
end;

{-----------------------------------------------------------}

type
  TMComponent = class(TComponent);

procedure NotifyDestroying(Sender : TComponent; Notifiers : TNotifierList);
var
  i   : integer;
  Obj : TObject;
begin
  with Notifiers.FCollection do
  begin
    i := Count - 1;
    while i >= 0 do
    begin
      Obj := TObject(TMethod(TNotifierListItem(Items[i]).Method).Data);
        if Obj is TComponent then
          TMComponent(Obj).Notification(Sender, opRemove);
      i := Min(i, Count);
      dec(i);
    end;
  end;
end;

{-----------------------------------------------------------}

destructor TSimpleParser.Destroy;
begin
  NotifyDestroying(Self, FNotifiers);
  FNotifiers.Free;
  FNotifiers := nil;
  inherited Destroy;
end;

{-----------------------------------------------------------}

procedure TSimpleParser.RegisterNotifier(W : TNotifierProc);
var
  Obj : TObject;
begin
  FNotifiers.AddMethod(W);
  Obj := TObject(TMethod(W).Data);
  if Obj is TComponent then
    TComponent(Obj).FreeNotification(Self);
end;

{-----------------------------------------------------------}

procedure TSimpleParser.UnRegisterNotifier(W : TNotifierProc);
begin
  if FNotifiers <> nil then
    FNotifiers.DeleteMethod(W);
end;

{-----------------------------------------------------------}
{$IFDEF WIN}
function TSimpleParser.GetFont(AState: integer): TFont;
begin
  Result := nil;
end;

{-----------------------------------------------------------}

function TSimpleParser.GetBackColor(AState: integer; var Color :  TColor) : boolean;
begin
  Result := false;
end;
{$ENDIF}
{-----------------------------------------------------------}


procedure TSimpleParser.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if FNotifiers <> nil then
      FNotifiers.DeleteWithData(AComponent);
  end;
end;

{-----------------------------------------------------------}

procedure TSimpleParser.UpdateLinePos(Value : integer);
begin
  FLinePos := Value;
end;

{-----------------------------------------------------------}

procedure TSimpleParser.PrepareColorData(LinePos : integer; const s : string ; var ColorData : string);
var
  Leng : integer;
begin
  Leng := Length(s);
  Setlength(ColorData, Leng);
  if Leng > 0 then
    FillChar(ColorData[1], Leng, 0);
end;

{-----------------------------------------------------------}


function  TSimpleParser.StoreColorData : boolean;
begin
  result := false;
end;

{***********************************************************}

function TCodeDesigner.GetSyntaxParserClass:TSimpleParserClass;
begin
  result := nil;
end;

{-----------------------------------------------------------}

procedure TCodeDesigner.ShowSource(x, y : integer);
begin
  if Assigned(fOnShowSource) then
    fOnShowSource(self, x, y);
end;

{-------------------------------------------------------------------------}

procedure TCodeDesigner.RenameModule(const OldName,NewName : string);
begin
end;

{-------------------------------------------------------------------------}

function TCodeDesigner.AutoFillUses : boolean;
begin
  result := false;
end;

{-------------------------------------------------------------------------}

function TCodeDesigner.GetDelimiters:String;
begin
  Result:=cDelphiDelimiters;
end;

{*************************************************************************}

function StringsEqual(const S1,S2:String;Params:TCompareParams):boolean;

  function InternalCompare(const S1,S2:String):boolean;
  begin
    if cpPartialCompare in Params then
      Result:=(Pos(S2,S1)<>0) or (Pos(S1,S2)<>0)
    else
      Result:=S1=S2;
  end;

begin
  if cpIgnoreCase in Params then
    Result:=InternalCompare(AnsiUpperCase(S1),AnsiUpperCase(S2))
  else
    Result:=InternalCompare(S1,S2);
end;

{---------------------------------------------------}

function VariantEqual(A, B: Variant;Params:TCompareParams):boolean;
Begin
  Result := (vartype(a) = vartype(b));
  If not Result then
    exit;

  If VarType(a)=VarString then
    Result:=StringsEqual(A,B,Params)
  else
    Result:=a=b;
End;

{------------------------------------------------------------------}

function GetClassEx(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;CompareParams:TCompareParams):TClass;
Var
  Item:TObjectParamListItem;
begin
  Item:=GetItemEx(C,ParamNames,ParamValues,CompareParams);
  If Item<>nil then
    Result:=Item.ClassPtr
  else
    Result:=nil;
end;

{------------------------------------------------------------------}

function GetItemExParent(C,TopClass:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TObjectParamListItem;
begin
  repeat
    Result:=GetItemEx(C,ParamNames,ParamValues,Params);
    if C=TopClass then
      break;
    C:=C.ClassParent;
  until (Result<>nil);
end;

{-------------------------------------------------------------------------}

type
  TClassCompareType=(cctC2C1,cctC1C2,cctEqual);

function _GetItems(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams;
            ClassCompareType:TClassCompareType;ResultList:TList):TObjectParamListItem;
Var
  i:Integer;

  function EqualParams(Item:TObjectParamListItem):boolean;
  var
    i:Integer;
  begin
    for i:=0 to High(ParamNames) do
      if not VariantEqual(ParamValues[i],Item.Params[ParamNames[i]],Params) then
      begin
        Result:=False;
        exit;
      end;
    Result:=True;
  end;

  function CompareClasses(C1,C2:TClass):boolean;
  begin
    case ClassCompareType of
      cctC2C1:
        Result:=C2.InheritsFrom(C1);
      cctC1C2:
        Result:=C1.InheritsFrom(C2);
      else //cctEqual:
        Result:=C1=C2;
    end;
{    If SwapClasses then
      Result:=C2.InheritsFrom(C1)
    else
      Result:=C1.InheritsFrom(C2);}
  end;

begin
  With ObjectParamList do
    for i:=0 to Count-1 do
      With Items[i] do
        if IsClass and CompareClasses(ClassPtr,C) and EqualParams(Items[i]) then
        begin
          Result:=Items[i];
          If ResultList=nil then
            exit
          else
            ResultList.Add(Result);
        end;
  Result:=nil;
end;

{------------------------------------------------------------------}

function GetItemInherited(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TObjectParamListItem;
begin
  Result:=_GetItems(C,ParamNames,ParamValues,Params,cctC2C1,nil);
end;

{------------------------------------------------------------------}

function GetItemEqual(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TObjectParamListItem;
begin
  Result:=_GetItems(C,ParamNames,ParamValues,Params,cctEqual,nil);
end;

{-------------------------------------------------------------------------}

function GetItemEx(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TObjectParamListItem;
begin
  Result:=_GetItems(C,ParamNames,ParamValues,Params,cctC1C2,nil);
end;

{-------------------------------------------------------------------------}

constructor TObjectParamList.Create;
begin
  inherited Create(TObjectParamListItem);
end;

{-------------------------------------------------------------------------}

constructor TObjectParamListItem.Create(ACollection:TCollection);
begin
  inherited;
  FParamList:=TStringList.Create;
  With FParamList do
  begin
    Sorted:=True;
    Duplicates:=dupIgnore;
  end;
end;

{-------------------------------------------------------------------------}

destructor TObjectParamListItem.Destroy;
begin
  FreeStrings(TStrings(FParamList));
  inherited;
end;

type
  TParamListData=class
  public
    Data:Variant;
  end;

{-------------------------------------------------------------------------}

function TObjectParamListItem.GetParamByName(const Name:String):Variant;
Var
  Index:Integer;
begin
  With FParamList do
    If Find(Name,Index) then
      Result:=TParamListData(Objects[Index]).Data
    else
      Result:=NULL;
end;

{-------------------------------------------------------------------------}

procedure TObjectParamListItem.SetParamByName(const AName:String;const Value:Variant);
Var
  index:Integer;
  FData:TParamListData;
begin
  With FParamList do
    If Find(AName,Index) then
      TParamListData(Objects[Index]).Data:=Value
    else
      begin
        FData:=TParamListData.Create;
        FData.Data:=Value;
        Index:=AddObject(AName,FData);
      end;
end;

{-------------------------------------------------------------------------}

function TObjectParamListItem.GetObjectPtr:TObject;
begin
  Result:=DataPtr;
end;

{-------------------------------------------------------------------------}

function TObjectParamListItem.GetClassPtr:TClass;
begin
  Result:=DataPtr;
end;

{-------------------------------------------------------------------------}

function TObjectParamList.ItemByDataPtr(p:Pointer):TObjectParamListItem;
Var
  i:Integer;
begin
  for i:=0 to Count-1 do
    if Items[i].DataPtr=P then
    begin
      result:=Items[i];
      exit;
    end;
  Result:=nil;
end;

{-------------------------------------------------------------------------}

function RegisterItemEx(P:Pointer;const ParamNames:Array of String;
            const ParamValues:Array of variant;AIsClass:boolean):TObjectParamListItem;
var
  i:Integer;
begin
  Result:=TObjectParamListItem(ObjectParamList.Add);
  With Result do
  begin
    DataPtr:=P;
    IsClass:=AIsClass;
    {$IFDEF D3}
    EditorGroup:=classes.CurrentGroup;
    {$ENDIF}
  end;

  for i:=0 to High(ParamValues) do
    Result.Params[ParamNames[i]]:=ParamValues[i];
end;

{-------------------------------------------------------------------------}

procedure UnRegisterClassExt(C : TClass);
var
  item : TObjectParamListItem;
begin
  repeat
    item := ObjectParamList.ItemByDataPtr(C);
    item.Free;
  until item = nil;
end;

{-------------------------------------------------------------------------}

function RegisterClassExt(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant):TObjectParamListItem;
begin
  Result:=RegisterItemEx(C,ParamNames,ParamValues,True);
end;

{-------------------------------------------------------------------------}

procedure RegisterObjectEx(O:TObject;const ParamNames:Array of String;
            const ParamValues:Array of variant);
begin
  RegisterItemEx(O,ParamNames,ParamValues,False);
end;

{-------------------------------------------------------------------------}

Var
  FObjectParamList:TObjectParamList=nil;

function ObjectParamList:TObjectParamList;
begin
  Result:=FObjectParamList;
  If Result=nil then
  begin
    FObjectParamList:=TObjectParamList.Create;
    Result:=FObjectParamList;
  end;
end;

{-------------------------------------------------------------------------}

function TObjectParamList.GetItem(Index:Integer):TObjectParamListItem;
begin
  Result:=TObjectParamListItem(inherited Items[Index]);
end;

{-------------------------------------------------------------------------}

function GetCodeDesignerClass(const Extension:String;ForUnit:boolean):TCodeDesignerClass;
begin
  Result:=TCodeDesignerClass(GetClassEx(TCodeDesigner,[SCodeDesForUnit,SCodeDesExtension],
    [ForUnit,RemoveCharSet(['.'],Extension)],[cpIgnoreCase]));
end;

{-------------------------------------------------------------------------}

function TObjectParamList.ForEveryClass(C:TClass;const AParams:Array of variant;
            Iterator:TObjectParamListIterator):Variant;
Var
  i:Integer;
  Finish:boolean;
begin
  i:=Count-1;
  Finish:=False;
  While i>=0 do
  begin
    If (Items[i].IsClass) and (Items[i].ClassPtr.InheritsFrom(C)) then
      Result:=Iterator(Items[i],AParams,Finish);
    If Finish then
      break;
    i:=Min(Count,i);
    dec(i);
  end;
end;

{------------------------------------------------------------------}

procedure GetRegisteredClasses(C:TClass;List:TList);
Var
  i:Integer;
begin
  List.Clear;
  With ObjectParamList do
    for i:=0 to Count-1 do
      With Items[i] do
        if IsClass and ClassPtr.InheritsFrom(C) then
          List.Add(Items[i]);
end;

{-------------------------------------------------------------------------}

procedure GetItemsEx(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams;
            ResultList:TList);
begin
  _GetItems(C,ParamNames,ParamValues,Params,cctC1C2,ResultList);
end;

{-------------------------------------------------------------------------}

procedure RegisterCodeDesigner(CodeDesigner:TCodeDesignerClass;const Extension:String;
            ForUnit:boolean);
begin
  RegisterClassExt(CodeDesigner,[SCodeDesForUnit,SCodeDesExtension],[ForUnit,Extension]);
end;

{-------------------------------------------------------------------------}

function GetUnitCodeDesignerClass(const Extension:String):TCodeDesignerClass;
begin
  Result:=GetCodeDesignerClass(Extension,True);
end;

{-------------------------------------------------------------------------}

function GetFormCodeDesignerClass(const Extension:String):TCodeDesignerClass;
begin
  Result:=GetCodeDesignerClass(Extension,False);
end;

{-------------------------------------------------------------------------}

procedure RegisterUnitCodeDesigner(CodeDesigner:TCodeDesignerClass;const Extension:String);
begin
  RegisterCodeDesigner(CodeDesigner,Extension,True);
end;

{-------------------------------------------------------------------------}

procedure RegisterVerb(const VerbName:String;
            GetVerbState:TGetVerbStateProc;
            ExecuteVerb:TExecuteVerbProc);
begin
  RegisterClassExt(TVerbObject,[SVerbName,SVerbGetState,SVarVerbExecute],
    [VerbName,Integer(@GetVerbState),Integer(@ExecuteVerb)]);
  IDEChanged;  
end;

{-------------------------------------------------------------------------}

procedure RegisterVerbArray(const VerbArray:Array of TVerbData);
Var
  i:Integer;
begin
  IDEBeginUpdate;
  try
    for i:=Low(VerbArray) to High(VerbArray) do
      With VerbArray[i] do
        RegisterVerb(Name,GetState,Execute);
  finally
    IDEEndUpdate;
  end;
end;

{-------------------------------------------------------------------------}

function GetVerbProcAddr(const VerbName:String;
           Var VerbGetState:TGetVerbStateProc;var VerbExecute:TExecuteVerbProc):TObjectParamListItem;
begin
  Result:=GetItemEx(TVerbObject,[SVerbName],[VerbName],[cpIgnoreCase]);
  if Result<>nil then
    WIth Result do
    begin
      VerbGetState:=TGetVerbStateProc(Integer(Params[SVerbGetState]));
      VerbExecute:=TExecuteVerbProc(Integer(Params[SVarVerbExecute]));
    end;
end;

{-------------------------------------------------------------------------}

procedure CallVerbByName(const VerbName:String);
Var
  Proc:TExecuteVerbProc;
  VerbGetState:TGetVerbStateProc;
begin
  if GetVerbProcAddr(VerbName,VerbGetState,Proc) <> nil then
    if Assigned(Proc) then
      Proc;
end;

{-------------------------------------------------------------}

procedure IDEChanged;
begin
  If IDEUpdateCount=0 then
    SimpleBroadCast(cm_IDEChanged);
end;
{-------------------------------------------------------------------------}

procedure IDEBeginUpdate;
begin
  if IDEUpdateCount=0 then
    SimpleBroadcast(cm_IDEBeginUpdate);
  inc(IDEUpdateCount);
end;

{-------------------------------------------------------------------------}

procedure IDEEndUpdate;
begin
  if IDEUpdateCount>0 then
  begin
    dec(IDEUpdateCount);
    If IDEUpdateCount=0 then
    begin
      SimpleBroadcast(cm_IDEEndUpdate);
      IDEChanged;
    end;
  end;
end;

{-------------------------------------------------------------------------}

procedure NotifyDestroyObjects(List : TList);
begin
  if List <> nil then
    BroadCastToNotifiers(nil,CM_OBJDESTROYED,0, Integer(List));
end;

{-------------------------------------------------------------------------}

procedure NotifyDestroy(Instance:TObject);
begin
  If Instance<>nil then
    BroadCastToNotifiers(Instance,CM_OBJDESTROYED,Integer(Instance),0);
end;

{-------------------------------------------------------------------------}

procedure RegisterFormCodeDesigner(CodeDesigner:TCodeDesignerClass;const Extension:String);
begin
  RegisterCodeDesigner(CodeDesigner,Extension,False);
end;

{*************************************************************************}

{$IFDEF WIN}
{$IFNDEF CLX}
constructor TResWriteStream.Create(const FileName : string;
               const ResName : string; ResType: PChar; Mode : integer);
var
  fRes : THandle;
  HGlobal : THandle;
  Instance : THandle;
begin
  fResName := ResName;
  fResType := ResType;
  fFileName := FileName;
  Instance := LoadLibraryEx(PChar(FileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  try
    if Mode = fmCreate then
      exit;

    fRes := FindResource(Instance, PChar(ResName), ResType);
    fInitSize := SizeOfResource(Instance, fRes);
    if fInitSize > 0 then
      begin
        HGlobal := LoadResource(Instance, fRes);
        SetSize(fInitSize);
        Move(LockResource(HGlobal)^, Memory^, fInitSize);
        UnlockResource(HGlobal);
        FreeResource(fRes);
      end;
  finally
    FreeLibrary(Instance);
  end;
end;

{------------------------------------------------------------------}

destructor  TResWriteStream.Destroy;
begin
  if fModified or (fInitSize <> Size) then
    if not ResourceUpdate(fFilename, fResType, fResName, 0, Memory, Size) then
      Error(SErrUpdateRes);

  inherited;
end;

{------------------------------------------------------------------}

function TResWriteStream.Write(const Buffer; Count: Longint): Longint;
begin
  result := inherited Write(Buffer, Count);
  fModified := true;
end;

{------------------------------------------------------------------}

const
  SysResCount = 22;
//BeginSkipConst
  ResTypes : array[1 .. SysResCount] of string =
  ('RT_CURSOR',         //  1
   'RT_BITMAP',         //  2
   'RT_ICON',           //  3
   'RT_MENU',           //  4
   'RT_DIALOG',         //  5
   'RT_STRING',         //  6
   'RT_FONTDIR',        //  7
   'RT_FONT',           //  8
   'RT_ACCELERATOR',    //  9
   'RT_RCDATA',         //  10
   'RT_MESSAGETABLE',   //  11
   'RT_GROUP_CURSOR',   //  12
   '',                  //  13
   'RT_GROUP_ICON',     //  14
   '',                  //  15
   'RT_VERSION',        //  16
   'RT_DLGINCLUDE',     //  17
   '',                  //  18
   'RT_PLUGPLAY',       //  19
   'RT_VXD',            //  20
   'RT_ANICURSOR',      //  21
   'RT_ANIICON');       //  22
//EndSkipConst
{------------------------------------------------------------------}

destructor TResFileSystem.Destroy;
begin
  CloseModule;
  inherited;
end;

{------------------------------------------------------------------}

procedure TResFileSystem.CloseModule;
begin
  if fModuleHandle <> 0 then
    begin
      FreeLibrary(fModuleHandle);
      fModuleHandle := 0;
    end;
end;

{------------------------------------------------------------------}

procedure TResFileSystem.OpenModule;
begin
  if fModuleHandle = 0 then
    fModuleHandle := LoadLibraryEx(PChar(FFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
end;

{------------------------------------------------------------------}

procedure TResFileSystem.SetFileName(const val : string);
begin
  if val <> fFileName then
    begin
      CloseModule;
      fFileName := val;
    end;
end;

{------------------------------------------------------------------}

function TResFileSystem.GetFileSystemLevel : TFileSystemLevel;
begin
  result := flOnlyGetStream;
end;

{------------------------------------------------------------------}

procedure TResFileSystem.SplitFileName(var FileName : string; var ResType : PChar; var ResName : string);
var
  i : integer;
  p : integer;
  rt : string;
begin
  FileName := ChangeFileExt(FileName, '');
  p := pos(SlashString, FileName);
  if p <> 0 then
    begin
      rt := 'RT_' + copy(FileName, 1, p - 1);  //don't resource
      ResName := copy(FileName, p + 1, length(FileName) - p);
      for i := 1 to SysResCount do
        if CompareText(rt, ResTypes[i]) = 0 then
          begin
            ResType := PChar(i);
            exit;
          end;
      FileName[p] := #0;
      ResType := @(FileName[1]);
    end
  else
    begin
      ResType := nil;
      ResName := '';
    end;
end;

{------------------------------------------------------------------}

function TResFileSystem.FileExists(const FileName: TFileName): boolean;
var
  rtype : PChar;
  rname : string;
  fname : string;
begin
  OpenModule;
  try
    fname := FileName;
    SplitFileName(fName, rtype, rname);
    result := FindResource(fModuleHandle, PChar(rname), rtype) <> 0;
  finally
    CloseModule;
  end;
end;

{------------------------------------------------------------------}

function TResFileSystem.GetFileStream(const FileName : TFileName; Mode : Integer) : TStream;
var
  rtype : PChar;
  rname : string;
  fname : string;
begin
  fname := FileName;
  SplitFileName(fName, rtype, rname);
  result := TResWriteStream.Create(fFileName, rname, rtype, Mode);
end;

{------------------------------------------------------------------}

type
  PDirEntry = PIMAGE_RESOURCE_DIRECTORY_ENTRY;

{------------------------------------------------------------------}

function Win95UpdateResource(FileName : string; ResType : PChar;
           const ResName : string; Data : Pointer; DataLength : integer) : boolean; forward;

{------------------------------------------------------------------}

function ResourceUpdate (const Filename : string; ResType : PChar; const ResName : String; IDLanguage : word;
                         Data : pointer; DataLength : integer) : boolean;
var
  updatehandle : THandle;
begin
  result := false;
  if UnderWindowsNT then
    begin
      updatehandle := BeginUpdateResource(PChar(FileName), false);
      if updatehandle = 0 then
        exit;
      result :=
         UpdateResource(updatehandle, PChar(ResType), PChar(ResName), IDLanguage, Data, DataLength) and
         EndUpdateResource(updatehandle, false);
      exit;
    end
  else
    result := Win95UpdateResource(FileName, PChar(ResType), ResName, Data, DataLength);
end;

{------------------------------------------------------------------}

type
  TProcessFunction = function (direntry : PDirEntry) : boolean of object;

type
  TResourceWriter = class
  private
    FFileHandle  : THandle;
    FFileMapping : THandle;
    FFileBase    : pointer;
    fOldFileSize : integer;
    FDosHeader   : PIMAGE_DOS_HEADER;
    FNTHeader    : PIMAGE_NT_HEADERS;
    FResSectHdr  : PIMAGE_SECTION_HEADER;
    FResourceBase: DWORD;
    FResourceRVA : DWORD;
    fResName     : string;
    fData        : pointer;
    fDataLength  : integer;
    fDelta       : integer;
    fOldSize     : integer;
    fFilesize    : integer;
    FFileName    : string;
//    fOffset      : integer;

    function DataEntry(DirEntry : PDirEntry): PIMAGE_RESOURCE_DATA_ENTRY;
    function FirstChildDirEntry(DirEntry : PDirEntry): PDirEntry;
    function IsList(DirEntry : PDirEntry): Boolean;
    function RawData(DirEntry : PDirEntry): Pointer;
    function GetSectionHdr(const SectionName: string;
        var Header: PIMAGE_SECTION_HEADER): Boolean;
    function GetResourceSize(direntry : PDirEntry) : boolean;
    function WriteResource(direntry : PDirEntry) : boolean;
    procedure CreateMapping(MapSize : integer);
    procedure CloseMapping;
//    procedure UpdateReferences(DirEntry : PDirEntry);
  public
    function ProcessAllResources(DirEntry : PDirEntry; ProcessFunc : TProcessFunction) : boolean;
    procedure UpdateResource(ResType : PChar; ResName : string; Data : Pointer; DataLength : integer);
    constructor Create(const FileName : string);
    destructor  Destroy; override;
  end;

procedure ErrorRes(const ErrMessage : string);
begin
  raise Exception.CreateFmt(ErrMessage + SError, [GetLastError]);
end;

{------------------------------------------------------------------}

function StripHighBit(val : DWORD) : DWORD;
begin
  result := val and $7FFFFFFF;
end;

{------------------------------------------------------------------}

function HighBitSet(l : DWORD): Boolean;
begin
  result := l <> StripHighBit(l);
end;

{------------------------------------------------------------------}

constructor TResourceWriter.Create(const FileName : string);
begin
  inherited Create;
  fFileName := FileName;
  CreateMapping(0);
end;

{------------------------------------------------------------------}

destructor TResourceWriter.Destroy;
begin
  CloseMapping;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TResourceWriter.CreateMapping(MapSize : integer); // 0 = all file
begin
  FFileHandle := CreateFile(PChar(fFileName), GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ,
    nil, OPEN_EXISTING, 0, 0);

  if FFileHandle = INVALID_HANDLE_VALUE then
    ErrorRes(SErrFileOpen);

  fFileSize := GetFileSize(FFileHandle, nil);

  FFileMapping := CreateFileMapping(FFileHandle, nil, PAGE_READWRITE, 0, MapSize, nil);

  if FFileMapping = 0 then
    ErrorRes(SErrMap);

  FFileBase := MapViewOfFile(FFileMapping, FILE_MAP_WRITE, 0, 0, 0);
  if FFileBase = nil then
    ErrorRes(sErrMapView);

  FDosHeader := PIMAGE_DOS_HEADER(FFileBase);
  if not FDosHeader.e_magic = IMAGE_DOS_SIGNATURE then
    ErrorRes(SErrEXE);

  FNTHeader := PIMAGE_NT_HEADERS(Longint(FDosHeader) + FDosHeader.e_lfanew);
  if IsBadReadPtr(FNTHeader, sizeof(IMAGE_NT_HEADERS)) or
     (FNTHeader.Signature <> IMAGE_NT_SIGNATURE) then
      ErrorRes(SErrEXE);

  if not GetSectionHdr('.rsrc', FResSectHdr) then  //don't resource
    ErrorRes(SErrNoResources);

  FResourceBase := FResSectHdr.PointerToRawData + DWORD(FDosHeader);
  FResourceRVA := FResSectHdr.VirtualAddress;
end;

{------------------------------------------------------------------}

procedure TResourceWriter.CloseMapping;
begin
  if FFileHandle <> INVALID_HANDLE_VALUE then
    begin
      UnmapViewOfFile(FFileBase);
      CloseHandle(FFileMapping);
      CloseHandle(FFileHandle);
    end;
end;

{------------------------------------------------------------------}

function TResourceWriter.GetSectionHdr(const SectionName: string;
        var Header: PIMAGE_SECTION_HEADER): Boolean;
var
  I: Integer;
begin
  Header := PIMAGE_SECTION_HEADER(FNTHeader);
  Inc(PIMAGE_NT_HEADERS(Header));
  Result := True;
  for i := 0 to FNTHeader.FileHeader.NumberOfSections - 1 do
    begin
      if Strlicomp(Header.Name, PChar(SectionName), _IMAGE_SIZEOF_SHORT_NAME) = 0 then
        exit;

      inc(Header);
    end;

  Result := False;
end;

{------------------------------------------------------------------}

function TResourceWriter.DataEntry(DirEntry : PDirEntry): PIMAGE_RESOURCE_DATA_ENTRY;
begin
  Result := PIMAGE_RESOURCE_DATA_ENTRY(FirstChildDirEntry(DirEntry).OffsetToData
    + FResourceBase);
end;

{------------------------------------------------------------------}

function TResourceWriter.FirstChildDirEntry(DirEntry : PDirEntry): PDirEntry;
begin
  Result := PDirEntry(StripHighBit(DirEntry.OffsetToData) +
    FResourceBase + SizeOf(IMAGE_RESOURCE_DIRECTORY));
end;

{------------------------------------------------------------------}

function TResourceWriter.IsList(DirEntry : PDirEntry): Boolean;
begin
  Result := HighBitSet(FirstChildDirEntry(DirEntry).OffsetToData);
end;

{------------------------------------------------------------------}

function TResourceWriter.RawData(DirEntry : PDirEntry): Pointer;
begin
  Result := pointer(FResourceBase - FResourceRVA + DataEntry(DirEntry).OffsetToData);
end;

{------------------------------------------------------------------}

function TResourceWriter.ProcessAllResources(DirEntry : PDirEntry; ProcessFunc : TProcessFunction) : boolean;
var
  DirCnt   : integer;
  i        : integer;
  FResDir  : PIMAGE_RESOURCE_DIRECTORY;
begin
    result := false;
    FResDir := PIMAGE_RESOURCE_DIRECTORY(DirEntry);
    DirCnt := FResDir.NumberOfNamedEntries + FResDir.NumberOfIdEntries;
    inc(PIMAGE_RESOURCE_DIRECTORY(DirEntry));
    for i := 0 to DirCnt - 1 do
      begin
        if IsList(DirEntry) then
          begin
            if ProcessAllResources(PDirEntry(StripHighBit(DirEntry.OffsetToData) + FResourceBase), ProcessFunc) then
              begin
                result := true;
                break;
              end;
          end
        else
          if ProcessFunc(DirEntry) then
            begin
              result := true;
              break;
            end;
        inc(DirEntry);
      end;
end;

{------------------------------------------------------------------}
(*
procedure TResourceWriter.UpdateReferences(DirEntry : PDirEntry);
var
  DirCnt   : integer;
  i        : integer;
  FResDir  : PIMAGE_RESOURCE_DIRECTORY;
  diroffs  : integer;
  DirNameOffs : integer;
begin
    FResDir := PIMAGE_RESOURCE_DIRECTORY(DirEntry);
    DirCnt := FResDir.NumberOfNamedEntries + FResDir.NumberOfIdEntries;
    inc(PIMAGE_RESOURCE_DIRECTORY(DirEntry));
    for i := 0 to DirCnt - 1 do
      begin
        if IsList(DirEntry) then
          begin
            DirOffs := integer(StripHighBit(DirEntry.OffsetToData));

            if DirOffs > fOffset then
              DirEntry.OffsetToData := $80000000 OR DWORD(DirOffs + fdelta);

            DirNameOffs := integer(StripHighBit(DirEntry.Name));

            if DirNameOffs > fOffset then
              if HighBitSet(DirEntry.Name) then
                DirEntry.Name := $80000000 OR DWORD(DirNameOffs + fdelta);

            UpdateReferences(PDirEntry(DWORD(DirOffs) + FResourceBase));
          end
        else
          if integer(DataEntry(DirEntry).OffsetToData) > fOffset then
            inc(DataEntry(DirEntry).OffsetToData, fdelta);

        inc(DirEntry);
      end;
end;
*) 
{------------------------------------------------------------------}

function GetResFileSystemFilerID(const AFileName : string) : TFilerID;
var
  RSystem : TResFileSystem;
begin
  RSystem := TResFileSystem.Create(nil);
  with RSystem do
    try
      FileName := AFileName;
      Result := GetFilerID(RSystem);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

function WideCharToStr(WStr: PWChar; Len: Integer): string;
begin
  if Len = 0 then Len := -1;
  Len := WideCharToMultiByte(CP_ACP, 0, WStr, Len, nil, 0, nil, nil);
  SetLength(Result, Len);
  WideCharToMultiByte(CP_ACP, 0, WStr, Len, PChar(Result), Len, nil, nil);
end;

{------------------------------------------------------------------}

function TResourceWriter.WriteResource(direntry : PDirEntry) : boolean;
var
  PDirStr : PIMAGE_RESOURCE_DIR_STRING_U;
  p       : pchar;
begin
  PDirStr := PIMAGE_RESOURCE_DIR_STRING_U(StripHighBit(DirEntry.Name) +
      FResourceBase);

  if HighBitSet(DirEntry.Name) then
    if WideCharToStr(@PDirStr.NameString, PDirStr.Length) = fResName then
      begin
        p := PChar(integer(fFileBase) + fOldFileSize);
        move(fdata^, p^, fDataLength);
        DataEntry(direntry).size := fDataLength;

//        Result := pointer(FResourceBase - FResourceRVA + DataEntry(DirEntry).OffsetToData);

        inc(DataEntry(direntry).OffsetToData, integer(p) - integer(RawData(direntry)));

//        inc(FResSectHdr.SizeOfRawData, 64000);
//        DataEntry(direntry).OffsetToData := integer(p - fResourceBase + FResourceRVA);

        result := true;
        RawData(direntry);
        exit;
(*
        p := RawData(direntry);
        move((p + fOldSize)^, (p + fDelta {fDataLength})^, integer(fFileBase) + fFileSize - integer(p + fOldSize));
        move(fdata^, p^, fDataLength);
        DataEntry(direntry).size := fDataLength;
        fOffset := integer(p - fResourceBase + FResourceRVA );
        result := true;
        exit;
*)        
      end;
   result := false;
end;

{------------------------------------------------------------------}

function TResourceWriter.GetResourceSize(direntry : PDirEntry) : boolean;
var
  PDirStr : PIMAGE_RESOURCE_DIR_STRING_U;
begin
  PDirStr := PIMAGE_RESOURCE_DIR_STRING_U(StripHighBit(DirEntry.Name) +
      FResourceBase);

  if HighBitSet(DirEntry.Name) then
    if WideCharToStr(@PDirStr.NameString, PDirStr.Length) = fResName then
      begin
        fOldSize := DataEntry(direntry).size;
        result := true;
        exit;
      end;
   result := false;
end;

{------------------------------------------------------------------}

procedure TResourceWriter.UpdateResource(ResType : PChar; ResName : string; Data : Pointer; DataLength : integer);
begin
  fResName := ResName;
  fData := Data;
  fDataLength := DataLength;

  fOldSize := -1;
  ProcessAllResources(PDirEntry(FResourceBase), GetResourceSize);
  if fOldSize = -1 then
    Error(sErrResNotFound);

//  fDelta := DataLength - fOldSize;

  fDelta := DataLength;


//  fFileSize := (fFileSize div 4 + 1) * 4;
  fOldFileSize := fFileSize;{(fFileSize div 4096 + 1) * 4096;}

  fDelta := (fDelta div 4096 + 1) * 4096;

  if fDelta > 0 then
    begin
      CloseMapping;
      CreateMapping(fOldFileSize + fDelta)
    end;

{
  Move(pchar(FResourceBase)^, PChar((fResourceBase) + fDelta)^, FResSectHdr.SizeOfRawData);
  inc(fResSectHdr.PointerToRAWData, fDelta);
}
//  fResSectHdr.PointerToRAWData := integer(fFileBase) + fOldFileSize - integer(FDosHeader);
  ProcessAllResources(PDirEntry(FResourceBase), WriteResource);

  inc(fNTHeader^.OptionalHeader.SizeOfInitializedData, fdelta);
  inc(fNTHeader^.OptionalHeader.SizeOfImage, fdelta);
  inc(fResSectHdr.PhysicalAddress, fDelta);
  inc(fResSectHdr.SizeOfRawData, fDelta);
  inc(fNTHeader^.OptionalHeader.DataDirectory[2].Size, fDelta);

//  UpdateReferences(PDirEntry(FResourceBase));

  if fDelta < 0  then
    begin
      CloseMapping;
      CreateMapping(fFileSize + fDelta);
      SetFilePointer(fFileHandle, fDelta, nil, FILE_END);
      SetEndOfFile(fFileHandle);
    end;
end;

{------------------------------------------------------------------}

function Win95UpdateResource(FileName : string; ResType : PChar;
                             const ResName : string; Data : Pointer; DataLength : integer) : boolean;
begin
  with TResourceWriter.Create(FileName) do
    try
      UpdateResource(ResType, ResName, Data, DataLength);
    finally
      Free;
    end;
  result := true;
end;

{------------------------------------------------------------------}

function IsFormInResource(const FileName,ResName: string; ResType: PChar):boolean;
var
  RStream:TResourceStream;
  Module:THandle;
  Signature:Integer;

  procedure LoadModule;
  begin
    module := LoadLibraryEx(PChar(FileName), 0, LOAD_LIBRARY_AS_DATAFILE);
    if module = 0 then
      raise Exception.CreateFmt(sErrCantOpen, [FileName, GetLastError]);
  end;

  procedure UnloadModule;
  begin
    if module <> 0 then
      FreeLibrary(module);
  end;

begin
  LoadModule;
  try
    rstream := TResourceStream.Create(Module,ResName, ResType);
    try
      rstream.Read(signature, 4);
      rstream.Seek(0, 0);
      Result:=signature = Integer(FilerSignature);
    finally
      RStream.Free;
    end;
  finally
    UnloadModule;
  end;
end;
{$ENDIF}
{$ENDIF} // WIN

{------------------------------------------------------------------}

function GetClassInherited(C:TClass;const ParamNames:Array of String;
            const ParamValues:Array of variant;Params:TCompareParams):TClass;
var
  Item : TObjectParamListItem;
begin
  Item := GetItemInherited(C,ParamNames,ParamValues,Params);
  if Item = nil then
    result := nil
  else
    result := Item.ClassPtr;
end;

{------------------------------------------------------------------}

function GetFilerID(FileSystem:TFileSystem):TFilerID;
begin
  With TMemoryStream.Create do
  try
    WriteComponent(FileSystem);
    Seek(0,soFromBeginning);
    SetLength(Result,Size);
    ReadBuffer(Result[1],Size);
  finally
    Free;
  end;
end;

//BeginSkipConst
{$IFDEF WIN}
{$IFNDEF CLX}
procedure AssociateFileExt(const DefaultExt, Description, CommandLine, IconHolder: string; DefaultIcon: integer);
var
  R:TRegistry;
procedure WriteKeyToReg(const Key ,Value :string);
begin
  with R do
    if OpenKey(key,true) then
    try
      WriteString('',Value);
    finally
      CloseKey;
    end;
end;
begin
  R:=TRegistry.Create;
  with R do
    try
      RootKey:=HKEY_CLASSES_ROOT;
      WriteKeyToReg(DefaultExt,Description);
      WriteKeyToReg(Description+'\DefaultIcon',IconHolder +','+ IntToStr(DefaultIcon));
      WriteKeyToReg(Description+'\Shell\Open\Command',CommandLine + ' "%1"');
    finally
      R.Free;
    end;
end;

{------------------------------------------------------------------}

procedure UnAssociateFileExt(const DefaultExt, Description:string);
begin
  with TRegistry.Create do
  try
    RootKey:=HKEY_CLASSES_ROOT;
    DeleteKey(DefaultExt);
    DeleteKey(Description+'\DefaultIcon');
    DeleteKey(Description+'\Shell\Open\Command');
    DeleteKey(Description+'\Shell\Open');
    DeleteKey(Description+'\Shell');
    DeleteKey(Description);
  finally
    Free;
  end;
end;

{$ENDIF}
{$ENDIF}

//EndSkipConst

{------------------------------------------------------------------}

function CommaText(const StringArray:Array of String):String;
var
  l,i:Integer;
begin
  L:=Low(StringArray);
  Result:=StringArray[L];
  for i:=L+1 to High(StringArray) do
    Result:=Result+','+StringArray[i];
end;

{------------------------------------------------------------------}

procedure RemoveStrings(FromStrings,StringsToRemove:TStrings);
var
  i:Integer;
begin
  With FromStrings do
    for i:=Count-1 downto 0 do
      if StringsToRemove.IndexOf(Strings[i])>=0 then
        Delete(i);
end;

{------------------------------------------------------------------}

{$IFDEF WIN}

var
  fGlobalOptionsList : TStringList;

function _getOptionsByClass(OptionClass : TOptionExtClass) : TOptionExt;
var
  i : integer;
begin
  with fGlobalOptionsList do
    begin
      i := IndexOf(OptionClass.ClassName);
      if i >= 0 then
        begin
          result := TOptionExt(Objects[i]);
          exit;
        end
      else
        result := nil;
    end;
end;

{------------------------------------------------------------------}

function GetOptionsByClass(OptionClass : TOptionExtClass) : TOptionExt;
begin
  result := _getOptionsByClass(OptionClass);
  if result = nil then
    result := OptionClass.Create;
end;

{------------------------------------------------------------------}

procedure SaveGlobalOptions;
var
  i : integer;
begin
  with fGlobalOptionsList do
    for i := 0 to Count - 1 do
      TOptionExt(Objects[i]).SaveConfig;
end;

{------------------------------------------------------------------}

procedure DoneGlobalOptions;
begin
  SaveGlobalOptions;
  FreeStrings(fGlobalOptionsList);
end;

{------------------------------------------------------------------}

function TOptionExt.UpdateDisabled:boolean;
begin
  Result := not Global or (UpdateCount>0);
end;

{------------------------------------------------------------------}

procedure TOptionExt.BeginUpdate;
begin
  inc(FUpdateCount);
end;

{------------------------------------------------------------------}

procedure TOptionExt.EndUpdate;
begin
  if FUpdateCount>0 then
  begin
    dec(FUpdateCount);
    If FUpdateCount=0 then
      Update;
  end;
end;

{------------------------------------------------------------------}

function TOptionExt.GetOptionControl:TPersistent;
begin
  Result:=Self;
end;

{------------------------------------------------------------------}

constructor TOptionExt.Create;
begin
  inherited;
  fGlobalOptions := _getOptionsByClass(TOptionExtClass(ClassType));
  fGlobal := fGlobalOptions = nil;
  if fGlobal then
    begin
      fGlobalOptionsList.AddObject(ClassName, self);
      InitValues;
      InitializeOptions;
      LoadConfig;
    end
  else
    Assign(fGlobalOptions)
end;

{------------------------------------------------------------------}

destructor TOptionExt.Destroy;
var
  i : integer;
begin
  if fGlobal then
    begin
      i := fGlobalOptionsList.IndexOf(ClassName);

      if i >= 0 then
        fGlobalOptionsList.Delete(i);
    end;

  inherited;
end;

{------------------------------------------------------------------}

Procedure TOptionExt.InitializeOptions;
Var
  I:Integer;
Begin
  If OptionsInitializators<>Nil Then
    For I:=OptionsInitializators.Count-1 DownTo 0 Do
      TOptionsInitializator(OptionsInitializators[I])(Self);
End;

{------------------------------------------------------------------}

procedure TOptionExt.Update;
begin

end;

{------------------------------------------------------------------}

procedure TOptionExt.InitValues;
begin

end;

{------------------------------------------------------------------}

procedure TOptionExt.Assign(Source : TPersistent);
begin
  BeginUpdate;
  try
    AssignAllProps(Source, self);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TOptionExt.ApplyOptions;
begin
  if not fGlobal then
  begin
    BeginUpdate;
    try
      fGlobalOptions.Assign(self)
    finally
      EndUpdate;
    end
  end
  else
    Update;
end;

{------------------------------------------------------------------}

procedure TOptionExt.LoadConfig;
begin
  {$IFNDEF CLX}
  BeginUpdate;
  try
    If StoreOptionsInFile Then
      LoadComponentFromIniFile(GetOptionControl,GetKey)
    Else
      ReadPropsFromRegistry(GetOptionControl, GetKey);
  finally
    EndUpdate;
  end;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TOptionExt.SaveConfig;
begin
  {$IFNDEF CLX}
  If StoreOptionsInFile Then
    SaveComponentToIniFile(GetOptionControl, GetKey)
  Else
    WritePropsToRegistry(GetOptionControl, GetKey);
  {$ENDIF}
end;

{------------------------------------------------------------------}

function TOptionExt.GetKey : string;
begin
  result := ClassName;
  delete(result, 1, 1);
end;

{------------------------------------------------------------------}

constructor TOptionExtList.Create;
var
  i : integer;
  c : TOptionExtClass;
begin
  inherited;
  GetRegisteredClasses(TOptionExt, Self);
  for i:=0 to Count-1 do
    begin
      c := TOptionExtClass(TObjectParamListItem(Items[i]).ClassPtr);
      repeat
        Items[i] := c.Create;
      until not TOptionExt(Items[i]).Global;
    end;
end;

{------------------------------------------------------------------}

destructor TOptionExtList.Destroy;
begin
  ClearList(Self);
  inherited;
end;

{------------------------------------------------------------------}

function TOptionExtList.GetOptionWithClass(const OptionClass:string):TOptionExt;
var
  i:Integer;
begin
  for I:=0 to Count-1 do
    if CompareText(TObject(Items[i]).ClassName,OptionClass)=0 then
    begin
      Result:=Items[i];
      exit;
    end;
  Result:=nil;
end;

{------------------------------------------------------------------}

procedure TOptionExtList.ApplyOptions;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    TOptionExt(Items[i]).ApplyOptions;
end;

{------------------------------------------------------------------}

const
  SEnvironmentId = 'Environment.Options';//don't resource


procedure RegisterOptionExt(OptionExtClass:TOptionExtClass);
begin
  RegisterClassExt(OptionExtClass,[SEnvironmentId],[123])
end;

{$ENDIF} // WIN


{------------------------------------------------------------------}

function GetCommonParent(AClass,BClass:TClass):TClass;
begin
  If AClass.InheritsFrom(BClass) then
    Result:=BClass
  else
  if BClass.InheritsFrom(AClass) then
    Result:=AClass
  else
    Result:=GetCommonParent(AClass.ClassParent,BClass.ClassParent);
end;

{-------------------------------------------------------------------------}

function GetCommonClassesParent(list : TList) : TClass;
var
  i : integer;
begin
  if list.Count = 0 then
    begin
      result := nil;
      exit;
    end;

  result := TObject(list[0]).ClassType;
  for i := 1 to list.Count - 1 do
    result := GetCommonParent(result, TObject(list[i]).ClassType);
end;

{-------------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}

type
  TPropsReaderWriter = class
    fKey      : string;

    procedure ReadProp(Instance: TPersistent; PropInfo: PPropInfo; UserData: Integer);
    procedure WriteProp(Instance: TPersistent; PropInfo: PPropInfo; UserData: Integer);
  end;

{-------------------------------------------------------------------------}

procedure TPropsReaderWriter.ReadProp(Instance: TPersistent; PropInfo: PPropInfo; UserData: Integer);
var
  o : TPersistent;
  RegKey:String;
begin
  with PropInfo^ do
  begin
    RegKey:=fKey + Name;
    if GetPTypeInfo(PropInfo).Kind = tkClass then
      begin
        o := TPersistent(GetOrdProp(Instance, propinfo));
        if o is TStrings then
          ReadStringsFromRegistry(RegKey, TStrings(o))
//{$IFNDEF BCB}
        else if o is TCollection then
          ReadObjTextFromRegistry(RegKey, o)
//{$ENDIF}
        else
          ReadPropsFromRegistry(o,RegKey);
      end
    else
      SetPropValueByPropInfo(Instance, PropInfo,
           ReadFromRegistry(RegKey, GetPropValueByPropInfo(Instance, PropInfo)));
  end;
end;

{-------------------------------------------------------------------------}

procedure TPropsReaderWriter.WriteProp(Instance: TPersistent; PropInfo: PPropInfo; UserData: Integer);
var
  o : TPersistent;
  RegKey:String;
begin
  with PropInfo^ do
  begin
    RegKey:=fKey + Name;

    if GetPTypeInfo(PropInfo).Kind = tkClass then
      begin
        o := TPersistent(GetOrdProp(Instance, propinfo));
        if o is TStrings then
          WriteStringsToRegistry(RegKey, TStrings(o))
//{$IFNDEF BCB}
        else if o is TCollection then
          WriteObjTextToRegistry(RegKey, o)
//{$ENDIF}
        else
          WritePropsToRegistry(o,RegKey);
      end
    else
      WriteToRegistry(RegKey, GetPropValueByPropInfo(Instance, PropInfo));
  end;
end;

{-------------------------------------------------------------------------}

procedure ReadPropsFromRegistry(Instance : TPersistent; const Key : string);
begin
  with TPropsReaderWriter.Create do
    try
      fKey := AddSlash(Key);
      ForEachProp(Instance, ReadProp, true, 0);
    finally
       Free;
    end;
end;

{-------------------------------------------------------------------------}

procedure WritePropsToRegistry(Instance : TPersistent; const Key : string);
begin
  with TPropsReaderWriter.Create do
    try
      fKey := AddSlash(Key);
      ForEachProp(Instance, WriteProp, true, 0);
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}
{$ENDIF}
{$ENDIF} // WIN

procedure IntersectStrings(Source, Dest : TStrings);
var
  i : integer;
begin
  for i := Dest.Count - 1 downto 0 do
    if Source.IndexOf(Dest[i]) < 0 then
      Dest.Delete(i);
end;

{-------------------------------------------------------------------------}

procedure TKeyData.Assign(Source : TPersistent);
begin
  if Source is TKeyData then
    with TKeyData(Source) do
    begin
      Self.ActiveState := ActiveState;
      Self.LeaveState := LeaveState;
      Self.KeyCode := KeyCode;
      Self.ShiftState := ShiftState;
      Self.ActionCode := ActionCode;
    end
  else
    inherited Assign(Source);
end;

{-------------------------------------------------------------------------}

procedure TKeyList.Update(Item: TCollectionItem);
begin
  inherited;
  FCachedData:=nil;
end;

{-------------------------------------------------------------}

function TKeyList.FindKeyData(AKey:Word;AShift:TShiftState;AState:ShortInt):TKeyData;
var
  i:Integer;

  function IsNeededKeyData(KeyData:TKeyData):boolean;
  begin
    With KeyData do
      Result:=(KeyCode=AKey) and (AShift=ShiftState)
        and ((AState=ActiveState) or (ActiveState=-1));
  end;

begin
  If (FCachedData<>nil) and IsNeededKeyData(FCachedData) then
  begin
    Result:=FCachedData;
    exit;
  end;

  for i:=Count-1 downto 0 do
    If IsNeededKeydata(TKeyData(Items[i])) then
      begin
        Result:=TKeyData(Items[i]);
        FCachedData:=Result;
        exit;
      end;
  Result:=nil;
end;

{-------------------------------------------------------------}

function  TKeyList.AddKey(AKey:Word;AShift:TShiftState;ACode:TKeyboardMethod;
            AActiveState,ALeaveState:ShortInt):TKeyData;
begin
  Result:=TKeyData(Add);
  With Result do
  begin
    KeyCode:=AKey;
    ShiftState:=AShift;
    ActionCode:=ACode;
    ActiveState:=AActiveState;
    LeaveState:=ALeaveState;
  end;
end;

{-------------------------------------------------------------}

function  TKeyList.AddSimpleKey(AKey:Word;AShift:TShiftState;ACode:TKeyboardMethod):TKeyData;
begin
  Result:=AddKey(AKey,AShift,ACode,0,0);
end;

{-------------------------------------------------------------}

function  TKeyList.AddAllKey(AKey:Word;AShift:TShiftState;ACode:TKeyboardMethod):TKeyData;
begin
  Result:=AddKey(AKey,AShift,ACode,-1,0);
end;

{-------------------------------------------------------------}

constructor TKeyList.Create;
begin
  inherited Create(TKeyData);
end;

{-------------------------------------------------------------}

function GetKeyboardInitProc(C:TClass;const ProcName:string):TKeyboardInitProc;
var
  Item:TObjectParamListItem;
begin
  Item:=GetItemInherited(C,[SParKeyboardID,SParKeyboardInitName],
    [SParKeyboardID,ProcName],[cpIgnoreCase]);
  If Item=nil then
    Result:=nil
  else
    Result:=Pointer(Integer(Item.Params[SParKeyboardInitProc]));
end;

{-------------------------------------------------------------}

procedure RegisterKeyboardInitProc(C:TClass;const ProcName:String;Proc:TKeyboardInitProc);
begin
  RegisterClassExt(C,[SParKeyboardID,SParKeyboardInitName,
    SParKeyboardInitProc],[SParKeyboardID,ProcName,Integer(@Proc)]);
end;

{-------------------------------------------------------------------------}

function ExtractOnlyName(const FileName:String):string;
begin
  Result:=ChangeFileExt(ExtractFileName(FileName),'');
end;

{-------------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}
type
  TIDEActiveNotifier = class(TActiveNotifier)
  protected
    procedure HookProc(const Msg : TCWPRetStruct);override;
  end;

var
  IDEActiveNotifier:TIDEActiveNotifier;

{-------------------------------------------------------------------------}

procedure TIDEActiveNotifier.HookProc(const Msg : TCWPRetStruct);
begin
  IDEChanged;
end;
{$ENDIF}
{$ENDIF}
{-------------------------------------------------------------------------}

function GetDreamRegKey(const key: string):string;
begin
  result  := SDreamRegKey + key;
end;

{-------------------------------------------------------------------------}

function IsLeapHour(Hour:Integer):boolean;
begin
  Result:=(Hour>=0) and (Hour<24);
end;

function IsLeapMinute(Minute:Integer):boolean;
begin
  Result:=(Minute>=0) and (Minute<60);
end;

{-------------------------------------------------------------------------}

procedure RunRegister;
begin
  SafeRegisterClass(TWin32FileSystem);
{$IFDEF WIN}
{$IFNDEF CLX}
  SafeRegisterClass(TResFileSystem);
{$ENDIF}
{$ENDIF}
end;

{------------------------------------------------------------------}
{$IFDEF WIN}
{$IFNDEF CLX}
procedure InitIDENotifier;
begin
  If IDEActiveNotifier=nil then
    IDEActiveNotifier:=TIDEActiveNotifier.Create(nil);
end;
{$ENDIF}
{$ENDIF}
{------------------------------------------------------------}

function TrimSeparatorsLeft(const S: string;Separators:TCharSet): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] in Separators) do Inc(I);
  Result := Copy(S, I, Maxint);
end;

{------------------------------------------------------------}

function TrimSeparatorsRight(const S: string;Separators:TCharSet): string;
var
  I: Integer;
begin
  I := Length(S);
  while (I > 0) and (S[I] in Separators) do Dec(I);
  Result := Copy(S, 1, I);
end;

{------------------------------------------------------------}

function TrimSeparators(const S: string;Separators:TCharSet): string;
begin
  Result:=TrimSeparatorsRight(TrimSeparatorsLeft(S,Separators),Separators);
end;

{------------------------------------------------------------}

function ShortMonthNameToIndex(const ShortMonthName:String):Integer;
var
  i:Integer;
begin
  for i:=1 to 12 do
    if CompareText(ShortMonthNames[i],ShortMonthName)=0 then
    begin
      Result:=i;
      exit;
    end;
  Result:=-1;
end;

{------------------------------------------------------------}

function CurrentYear:Word;
Var
  Month,Day:Word;
begin
  DecodeDate(Date,Result,Month,Day);
end;

{------------------------------------------------------------}

function GetWordPos(const S:String;NumberOfWord:Integer;const Separators:TCharSet):Integer;
var
  i:Integer;
  TempStr:String;
  CurrentWord:Integer;
begin
  Result:=-1;
  TempStr:=TrimSeparators(S,Separators);
  I:=1;
  CurrentWord:=1;

  While i<=Length(TempStr) do
  begin
    if CurrentWord=NumberOfWord then
    begin
      Result:=i;
      break;
    end;
    if TempStr[i] in Separators then
    begin
      inc(CurrentWord);
      While (TempStr[i] in Separators) and (i<=Length(TempStr)) do
        inc(i);
    end else
      inc(i);
  end;
end;

{------------------------------------------------------------}

function GetWord(const S:String;NumberOfWord:Integer):String;
begin
  Result:=GetWordEx(S,NumberOfWord,[#0..#32]);
end;

{------------------------------------------------------------}

procedure ReplaceAllOccurEx(var S:String;const FromStr,ToStr:String;
            IgnoreCase:boolean);
var
  PosChar,BegChar:Integer;
  WorkStr,WorkFromStr:String;
begin
  If IgnoreCase=False then
  begin
    ReplaceAllOccur(S,FromStr,ToStr);
    exit;
  end;

  BegChar:=1;

  if IgnoreCase then
  begin
    WorkStr:=AnsiUpperCase(S);
    WorkFromStr:=AnsiUpperCase(FromStr);
  end else
    begin
      WorkStr:=S;
      WorkFromStr:=FromStr;
    end;

  repeat
    PosChar:=PosEx(WorkFromStr,WorkStr,BegChar);
    if PosChar=0 then
      break;
    Replace(WorkFromStr,PosChar,FromStr,ToStr);
    Replace(S,PosChar,FromStr,ToStr);
    BegChar := PosChar + Length(ToStr);
  until BegChar > length(WorkFromStr);
end;

{------------------------------------------------------------}

procedure ReplaceAllOccur(var s : string; const FromStr, ToStr : string);
var
  PosChar, BegChar : integer;
  tostrlen : integer;
begin
  tostrlen := length(ToStr);
  BegChar := 1;
  repeat
    PosChar := PosEx(FromStr, s, BegChar);
    if PosChar = 0 then
      break;
    Replace(S, PosChar, FromStr, ToStr);
    BegChar := PosChar + tostrlen;
  until BegChar > length(s);
end;

{------------------------------------------------------------}

function GetWordEx(const S:String;NumberOfWord:Integer;const Separators:TCharSet):String;
var
  WordPos,WordEndPos:Integer;
begin
  Result:='';
  WordPos:=GetWordPos(S,NumberOfWord,Separators);
  If WordPos<>-1 then
  begin
    WordEndPos:=WordPos+1;
    While (WordEndPos<=Length(S)) and (not (S[WordEndPos] in Separators)) do
      inc(WordEndPos);
    Result:=Copy(S,WordPos,WordEndPos-WordPos);
  end;
end;

{------------------------------------------------------------}

procedure Replace(var s : string; index : integer; const OldStr, NewStr : string);
begin
  Delete(s, index, length(OldStr));
  Insert(NewStr, s, index);
end;

{------------------------------------------------------------------}

procedure EditStringsProperty(Instance : TComponent; const PropName : string);
begin
  BroadcastToNotifiers(nil, CM_EDITTEXTPROP, Integer(Instance), Integer(PropName));
end;

{------------------------------------------------------------------}
{$IFDEF WIN}
{$IFNDEF CLX}
function CreateNewGUID : TGUID;
begin
  CoCreateGuid(Result);
end;
{$ENDIF} 
{$ENDIF} //WIN
{------------------------------------------------------------------}

function AppFolder:String;
begin
  Result:=AddSlash(ExtractFilePath(ParamStr(0)));
end;

{------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}
function GetLogDataFileName:String;
var
  Folder:String;
begin
  Folder:=AddSlash(ExtractFilePath(ParamStr(0)))+'LOGS\';  //don't resource
  CreateDir(Folder);
  Result:=Folder+GUIDToString(CreateNewGuid)+'.log';       //don't resource
end;
{$ENDIF}
{$ENDIF}
{------------------------------------------------------------------}

procedure _WritelnLogFile(const Value:Variant);
begin
  Writeln(Value);
end;

procedure MapLogFileToWriteln;
begin
  WriteLogEvent:=_WritelnLogFile;
end;

{------------------------------------------------------------------}

var
  AppGUID:String;

procedure DoWriteToLog(const Value:Variant);
var
  F:Text;
  LogFileName:String;
  S:String;
begin
  If DCLogSuspend>0 then
    exit;

  try
    LogFileName:=ChangeFileExt(ParamStr(0),'.LOG');   //don't resource
    Assign(f,LogFileName);
    if not FileExists(LogFileName) then
      Rewrite(f)
    else
      Append(F);

    S:='';
    If DCLogFileShowGUID then
      S:=S+AppGUID+' ';
    If DCLogFileShowTime then
      S:=S+DateTimeToStr(Now)+'  ';
    S:=S+VarToStr(Value);
    Writeln(F,S);
    If DCLogFileWriteln then
      Writeln(S);
    Close(F);
  except
  end;
end;

{$IFDEF LOGFILE}
procedure WriteToLog(const Value:Variant);
begin
  DoWriteToLog(Value);
end;
{$ELSE}
procedure WriteToLog(const Value:Variant);
begin
  If Assigned(WriteLogEvent) then
    WriteLogEvent(Value);
end;
{$ENDIF}

{--------------------------------------------}

procedure TDCNamedItems.LoadFromFile(const FileName:String);
begin
  ReadObjFromFile(Self,FileName);
end;

{--------------------------------------------}

procedure TDCNamedItems.LoadFromStream(S:TStream);
begin
  ReadObjFromStream(S,Self);
end;

{--------------------------------------------}

procedure TDCNamedItems.SaveToStream(S:TStream);
begin
  WriteObjToStream(S,Self);
end;

{--------------------------------------------}

function PointToStr(const P:TPoint):String;
begin
  Result:=IntToStr(P.X)+' '+IntToStr(P.Y);
end;

{--------------------------------------------}

function RectToStr(const R:TRect):String;
begin
  Result:=IntToStr(R.Left)+' '+IntToStr(R.Top)+' '+
    IntToStr(R.Right)+' '+IntToStr(R.Bottom);
end;

{--------------------------------------------}

{$IFDEF DEBUG_}
procedure DebugRect(Const S:String;R:TRect);
begin
  WriteToLog(S+' '+RectToStr(R));
end;
{$ENDIF}

{--------------------------------------------}

procedure TDCNamedItems.SaveToFile(const FileName:String);
begin
  WriteObjToFile(Self,FileName);
end;

{-------------------------------------------------------------------------}

procedure ModifyFilesAttr(Files:TStrings;RemoveAttr,AddAttr:Integer);
var
  i:Integer;
begin
  for i:=0 to Files.Count-1 do
    ModifyFileAttr(Files[i],RemoveAttr,AddAttr);
end;

{------------------------------------------------------------------}

function ChangeFileName(const FileName,NewName:String):String;
begin
  Result:=AddSlash(ExtractFilePath(FileName))+NewName;
end;

{-------------------------------------------------------------------------}

procedure ModifyFileAttr(const FileName:String;RemoveAttr,AddAttr:Integer);
var
  FileAttr:Integer;
begin
  FileAttr:=SysUtils.FileGetAttr(FileName);
  FileAttr:=(FileAttr and (not RemoveAttr)) or AddAttr;
  SysUtils.FileSetAttr(FileName,FileAttr);
  WriteToLog('Setting file attr to '+FileName);  //don't resource
end;

{-------------------------------------------------------------------------}

procedure ModifyFilesAttrInFolder(const FileMask:String;
            RemoveAttr,AddAttr:Integer;SubFolders:boolean);
Var
  Files:TStringList;
begin
  Files:=TStringList.Create;
  try
    FindFiles(FileMask,faAnyFile-faDirectory,SubFolders,Files);
    ModifyFilesAttr(Files,RemoveAttr,AddAttr);
  finally
    Files.Free;
  end;
end;

{-------------------------------------------------------------------------}

procedure SubtractStrings(S1,S2:TStrings);
var
  i:Integer;
begin
  for i:=S1.Count-1 downto 0 do
    if S2.IndexOf(S1[i])>=0 then
      S1.Delete(i);
end;

{-------------------------------------------------------------------------}

function UnderWindowsNT : boolean;
begin
//  Result := false;
{$IFDEF CLX}
  result := false;
{$ELSE}
  result := Win32Platform = VER_PLATFORM_WIN32_NT;
{$ENDIF}
end;

{-------------------------------------------------------------------------}

procedure SaveStringToFile(const FileName,DataStr:String);
begin
  with TStringList.Create do
    try
      Text := DataStr;
      CreateAllDirectories(ExtractFilePath(FileName),nil); //Added in V4.1
      SavetoFile(FileName);
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

function ExtractQuotedStr(const s : string; QuoteChar : char) : string;
var
  slen : integer;
  i    : integer;
begin
  slen := length(s);
  case slen of
    0 : result := '';
    1 : result := s[1];
    else
      begin
        if (s[1] = QuoteChar) and (s[slen] = QuoteChar) then
          result := copy(s, 2, slen - 2)
        else
          result := s;

        i := length(result);

        while i >= 2 do
          begin
            if (result[i] = QuoteChar) and (result[i - 1] = QuoteChar) then
              begin
                delete(result, i, 1);
                dec(i);
              end;

            dec(i);
          end;
      end;
  end;
end;

{-------------------------------------------------------------------------}

procedure ChangeParamsInFile(const FileName:String; Params:TStrings);
var
  S:TStringList;
begin
  S:=TStringList.Create;
  try
    S.LoadFromFile(FileName);
    ChangeParamsInStrings(S,Params);
    S.SaveToFile(FileName);
  finally
    S.Free;
  end;
end;

{-------------------------------------------------------------------------}

function ChangeParamsEx(const S:String;Params:TStrings;ParamSep:Char):String;
var
  i:Integer;
  FromStr,ToStr:String;
begin
  Result:=S;
  If S='' then
    exit;
  With Params do
    for i:=0 to Count-1 do
    begin
      FromStr:=ParamSep+Trim(ExtractNamePart(Strings[i]))+ParamSep;
      ToStr:=Trim(ExtractValuePart(Strings[i]));
      ReplaceAllOccurEx(Result,FromStr,ToStr,True);
    end;
end;

{-------------------------------------------------------------------------}

procedure ChangeParamsInStringsEx(S,Params:TStrings;ParamSep:Char);
var
  i:Integer;
begin
  With S do
  begin
    BeginUpdate;
    try
      for i:=0 to Count-1 do
        Strings[i]:=ChangeParamsEx(Strings[i],Params,ParamSep);
    finally
      EndUpdate;
    end;
  end;
end;

{-------------------------------------------------------------------------}

procedure ChangeParamsInStrings(S,Params:TStrings);
begin
  ChangeParamsInStringsEx(S,Params,'%');
end;

{-------------------------------------------------------------------------}

procedure ChangeParamsInFiles(const Dir,FileMasks:String; Attr: Integer;
            Params:TStrings; SubFolders:boolean);
var
  Files:TStringList;
  i:Integer;
begin
  Files:=TStringList.Create;
  try
    FindFilesEx(Dir,FileMasks,Attr,SubFolders,Files);
    for i:=0 to Files.Count-1 do
      ChangeParamsInFile(Files[i],Params);
  finally
    Files.Free;
  end;
end;

{-------------------------------------------------------------------------}

function RemoveExtraSlash(const FileName:String):String;
begin
  Result:=FileName;
  ReplaceAllOccur(Result,SlashString+SlashString,SlashString);
end;

{-------------------------------------------------------------------------}

procedure SortAndRemoveDups(S:TStrings);
var
  Temp:TStringList;
begin
  Temp:=CreateSortedStringList;
  try
    Temp.Assign(S);
    S.Assign(Temp);
  finally
    Temp.Free;
  end;
end;

{-------------------------------------------------------------------------}

procedure NamePartToStrings(Source,Dest:TStrings);
var
  i:Integer;
begin
  With Dest do
  begin
    BeginUpdate;
    Clear;
    for i:=0 to Source.Count-1 do
      Dest.Add(ExtractNamePart(Source[i]));
    EndUpdate;
  end;
end;

{-------------------------------------------------------------------------}

procedure ValuePartToStrings(Source,Dest:TStrings);
var
  i:Integer;
begin
  With Dest do
  begin
    BeginUpdate;
    Clear;
    for i:=0 to Source.Count-1 do
      Dest.Add(ExtractValuePart(Source[i]));
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

function StrToDelphiVers(const Vers:String):TDelphiVers;
Var
  TempStrings:TStringList;
  i:TDelphiVer;
begin
  Result:=[];
  TempStrings:=TStringList.Create;
  With TempStrings do
    try
      CommaText:=RemoveCharSet([#32],Vers);
      for i:=Low(TDelphiVer) to High(TDelphiVer) do
        if IndexOf(cDelphiVers[i])>=0 then
          Include(Result,i);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure PropNamesToStrings(Instance:TPersistent;PropNames:TStrings);
var
  I, Count: Integer;
  PropList: PPropList;
begin
  PropNames.Clear;
  If Instance=nil then
    exit;
  Count := GetTypeData(Instance.ClassInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      GetPropInfos(Instance.ClassInfo,PropList);
      for I := 0 to Count - 1 do
        PropNames.Add(PropList^[I].Name);
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;

{------------------------------------------------------------------}

procedure AssignPropsFromStrings(Instance:TPersistent;Params:TStrings);
Var
  PropNames:TStringList;
  i:Integer;
  PValue:String;
begin
  PropNames:=TStringList.Create;
  try
    PropNamesToStrings(Instance,PropNames);
    With PropNames do
      for i:=0 to Count-1 do
      begin
        PValue:=Trim(Params.Values[Trim(Strings[i])]);
        If PValue<>'' then
          SetPropValue(Instance,Strings[i],PValue);
      end;
  finally
    PropNames.Free;
  end;
end;

{-------------------------------------------------------------------------}

procedure _ExtractFilePaths(S:TStrings);
var
  i:Integer;
begin
  With S do
    for i:=0 to Count-1 do
      Strings[i]:=ExtractFilePath(Strings[i]);
end;

procedure ExtractFilePaths(Source,Dest:TStrings);
begin
  If Dest<>Source then
    Dest.Assign(Source);
  OperateStrings(Dest,_ExtractFilePaths);
  SortAndRemoveDups(Dest);
end;

{-------------------------------------------------------------------------}


function FindInStringsEx(const TextToFind:String;S:TStrings;SearchParams:TSearchParams;
         Const DelimSet:TCharSet;Var P:TPoint; var Len : integer; FindRoutine : TFindExpression):boolean;
var
  TempStr,SearStr:String;
  CaseInsens:boolean;
  iBeg,iEnd:Integer;

  function CheckWholeWord(const S:String; X, Len : integer) : boolean;
  begin
    result := true;
    If (not (spWholeWords in SearchParams)) or (X=0)  then
      exit;
    iBeg:=X;
    While (IBeg>1) and (not (S[IBeg-1] in DelimSet)) do
      dec(IBeg);
    iEnd:=X;
    While (IEnd<Length(S)) and (not (S[IEnd+1] in DelimSet)) do
      inc(IEnd);
    result := (iBeg = X) and (Len = (IEnd-IBeg+1));
  end;

  procedure SearchBack;
  begin
    result := false;
    With P do
      While Y>=0 do
      begin
        SearStr:=TrimRight(S[Y]);
        If (X>0) or ((SearStr = '') and (X = 0) and Assigned(FindRoutine)) then
        begin
          X:=Min(X,Length(SearStr));
          If CaseInSens and not Assigned(FindRoutine) then
            SearStr:=AnsiUpperCase(SearStr);
          if Assigned(FindRoutine) then
            result := FindRoutine(SearStr, integer(X), Len, false)
          else
            X:=BackPosEx(TempStr,SearStr,X);
          if (SearStr <> '') and not CheckWholeWord(SearStr, X, Len) then
          begin
            result := false;
            if X = iBeg then
              dec(X)
            else
              X := iBeg - 1;
            continue;
          end;
          Result:= result or (X<>0);
          If Result then
            break;
        end;
        dec(y);
        If Y>=0 then
          x:=Length(S[Y]);
      end;
  end;

  procedure SearchForward;
  begin
    result := false;
    With P do
      While Y<S.Count do
      begin
        SearStr:=S[Y];
        If (X<=Length(SearStr)) or ((SearStr = '') and (X = 1) and Assigned(FindRoutine)) then
        begin
          If CaseInSens and not Assigned(FindRoutine) then
            SearStr:=AnsiUpperCase(SearStr);
          if Assigned(FindRoutine) then
            result := FindRoutine(SearStr, integer(X), Len, true)
          else
            X:=PosEx(TempStr,SearStr,X);
          if (SearStr <> '') and not CheckWholeWord(SearStr, X, Len) then
          begin
            result := false;
            if X = iEnd then
              inc(X)
            else
              X := iEnd;
            continue;
          end;
          Result:= result or (X<>0);
          If Result then
            break;
        end;
        inc(y);
        X:=1;
      end;
  end;

begin
  Result:=False;
  Len := Length(TextToFind);
  If (S.Count=0) then
    exit;
  If TextToFind='' then
    exit;
  TempStr:=TextToFind;

  CaseInSens:=not (spCaseSens in SearchParams);

  If CaseInSens and not Assigned(FindRoutine) then
    TempStr:=AnsiUpperCase(TempStr);

  If spBackSearch in SearchParams
  then
    SearchBack
  else
    SearchForward;
end;

{--------------------------------------------}

function FindFirstInStrings(const TextToFind:String;S:TStrings;
           CaseSens:boolean;Var P:TPoint; var Len : integer; FindRoutine : TFindExpression):boolean;
begin
  P.X := 1;
  P.Y := 0;
  Result:=FindNextInStrings(TextToFind,S,CaseSens,P, Len, FindRoutine);
end;

{--------------------------------------------}

function FindNextInStrings(const TextToFind:String;S:TStrings;
           CaseSens:boolean;Var P:TPoint; var Len : integer; FindRoutine : TFindExpression):boolean;
Var
  SearchParams:TSearchParams;
begin
  If CaseSens then
    SearchParams:=[spCaseSens]
  else
    SearchParams:=[];
  Result:=FindInStringsEx(TextToFind,S,SearchParams,[],P, Len, FindRoutine);
end;

{-----------------------------------------------------------}

Type
  TPublicComponent=Class(TComponent);

Function BufferToText(Buffer:PChar;Size:Integer):String;
Var
  I:Integer;
  Len:Integer;
Begin
  Result:='';
  Len:=0;
  For I:=0 To Size-1 Do
  Begin
    Result:=Result+IntToHex(Byte(Buffer[I]),2);
    Inc(Len);
    If Len=32 Then
    Begin
      Result:=Result+#0;
      Len:=0;
    End;
  End;
  Result:=Result+#0;
End;

{-----------------------------------------------------------}

Procedure TextToStream(const Str:String;Stream:TStream);
Var
  I:Integer;
  Data:Byte;
Begin
  I:=1;
  While I<=Length(Str) Do
  Begin
    If Str[I]<>#0 Then
    Begin
      Data:=Byte(StrToInt('$'+Str[I]+Str[I+1]));
      Stream.WriteBuffer(Data,1);
      Inc(I);
    End;
    Inc(I);
  End;
End;

{-----------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}
Procedure WriteStreamToKey(Stream:TMemoryStream;const Key:String);
Var
  Data:String;
Begin
  Data:=BufferToText(Stream.Memory,Stream.Size);
  If WritePrivateProfileSection(PChar(Key),Nil,PChar(OptionsFileName)) Then
    WritePrivateProfileSection(PChar(Key),PChar(Data),PChar(OptionsFileName));
End;

{-----------------------------------------------------------}

Procedure ReadStreamFromKey(Stream:TMemoryStream;const Key:String);
Const
  MaxSectionSize=32767;
Var
  Data:String;
Begin
  SetLength(Data,MaxSectionSize);
  SetLength(Data,GetPrivateProfileSection(PChar(Key),PChar(Data),MaxSectionSize,PChar(OptionsFileName)));
  If Length(Data)=0 Then
    exit;

  TextToStream(Data,Stream);
  Stream.Seek(soFromBeginning,0);
End;

{-----------------------------------------------------------}

Procedure SaveComponentToIniFile(Instance:TPersistent;const Key:String);
Var
  Stream     : TMemoryStream;
  Writer     : TWriter;
  Component  : TComponent;
  PersHolder : TPersHolder;
begin
  If Instance Is TComponent Then
  Begin
    Component:=TComponent(Instance);
    PersHolder:=Nil;
  End
  Else
  Begin
    PersHolder:=TPersHolder.Create(Nil);
    PersHolder.Name:='PersHolder';//don't resource
    PersHolder.P:=Instance;
    Component:=PersHolder;
  End;
  Try
    Stream:=TMemoryStream.Create;
    Try
      Writer:=TWriter.Create(Stream,4096);
      Try
        Writer.Ancestor:=Nil;
        Writer.RootAncestor:=Nil;
        Writer.Root:=Component;
        TPublicComponent(Component).WriteState(Writer);
        Writer.FlushBuffer;
        WriteStreamToKey(Stream,Key);
      Finally
        Writer.Free;
      End;
    Finally
      Stream.Free;
    End;
  Finally
    PersHolder.Free;
  End;
End;

{-----------------------------------------------------------}

Procedure LoadComponentFromIniFile(Instance:TPersistent;const Key:String);
Var
  Stream:TMemoryStream;
  Reader:TReader;
  ChildPos:Integer;
  Flags:TFilerFlags;
  Component:TComponent;
  PersHolder:TPersHolder;
Begin
  Stream:=TMemoryStream.Create;
  PersHolder:=Nil;
  Try
    ReadStreamFromKey(Stream,Key);
    If Stream.Size=0 Then
      Exit;
    If Instance Is TComponent Then
      Component:=TComponent(Instance)
    Else
    Begin
      PersHolder:=TPersHolder.Create(Nil);
      PersHolder.Name:='PersHolder';//don't resource
      PersHolder.P:=Instance;
      Component:=PersHolder;
    End;
    Reader:=TReader.Create(Stream,4096);
    Try
      Reader.Ancestor:=Nil;
      Reader.Root:=Component;
      Reader.ReadPrefix(Flags, ChildPos);
      Reader.ReadStr;//ignore classname
      Reader.ReadStr;//ignore componentname;
      TPublicComponent(Component).ReadState(Reader);
    Finally
      Reader.Free;
    End;
  Finally
    Stream.Free;
    PersHolder.Free;
  End;
End;

{-----------------------------------------------------------}
{$ENDIF}
{$ENDIF}

//BeginSkipConst
const
VT_DelphiNames : array[-1 .. VT_LPWSTR] of string =
(
'TColor',
'',//VT_EMPTY
'',//VT_NULL
'Smallint',//VT_I2
'Longint',//VT_I4
'Single',//VT_R4
'Double',//VT_R8
'Currency',//VT_CY
'TDateTime',//VT_DATE
'PWideChar',//VT_BSTR
'Pointer',//VT_DISPATCH
'Integer',//VT_ERROR
'WordBool',//VT_BOOL
'Variant',//VT_VARIANT
'Pointer',//VT_UNKNOWN
'PWideChar',//VT_DECIMAL??
'',
'ShortInt',//VT_I1
'Byte',//VT_UI1
'Word',//VT_UI2
'Cardinal',//VT_UI4
'Variant',//VT_I8
'Variant',//VT_UI8
'Integer',//VT_INT
'Cardinal',//VT_UINT
'Variant',//VT_VOID
'HResult',//VT_HRESULT
'Pointer',//VT_PTR
'Variant',//VT_SAFEARRAY
'Variant',//VT_CARRAY
'Variant',//VT_USERDEFINED
'PChar', //VT_LPSTR
'PWideChar'//VT_LPWSTR
);
//EndSkipConst
function ConvertDelphiTypeToString(TypeCode : integer) : string;
begin
  result := VT_DelphiNames[TypeCode];
end;

{-----------------------------------------------------------}

function BuildCompName(Comp : TPersistent; Const AName : string) : string;
var
  TempName : string;
begin
  if Assigned(BuildCompNameFunc) then
    result := BuildCompNameFunc(Comp, AName)
  else
    begin
      result := '';
      if Comp = nil then
       exit;

      if AName <> '' then
        TempName := AName
      else
        begin
          TempName := GetCompName(Comp);
          if TempName = '' then
            exit;
        end;

      result := TempName + ': '+ Comp.ClassName;
    end;
end;

{-----------------------------------------------------------}

procedure SetPropByDispatch(const disp : IDispatch; ID : TDispID; const Value : OleVariant);
var
  dparams : TDispParams;
  did     : TDispID;
  invkind : integer;
begin
 with dparams do
  begin
    rgvarg := @Value;
    did := DISPID_PROPERTYPUT;
    rgdispidNamedArgs := @did;
    cArgs := 1;
    cNamedArgs := 1;
  end;

 if TVariantArg(Value).vt = VT_DISPATCH then
   InvKind := DISPATCH_PROPERTYPUTREF
 else
   InvKind := DISPATCH_PROPERTYPUT;

  disp.Invoke(id, GUID_NULL, 0, invkind, dparams, nil, nil, nil);
end;

{------------------------------------------------------------------}

{---------TPackagedCollection------------------------------------------}
{$IFDEF WIN}
function  TPackagedCollection.Last : TPackagedCollectionItem;
begin
  result := TPackagedCollectionItem(Items[Count - 1]);
end;

{-------------------------------------------------------------------------}

function TPackagedCollection.Add:TPackagedCollectionItem;
begin
  Result:=TPackagedCollectionItem(inherited Add);
  With Result do
  begin
    PackageHandle:=_package;
    {$IFDEF D3}
    DesignGroup:=CurrentGroup;
    {$ENDIF}
  end;
end;

{-------------------------------------------------------------------------}

constructor TPackagedCollection.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  RegisterNotifier(Self);
end;

{-------------------------------------------------------------------------}

destructor TPackagedCollection.Destroy;
begin
  UnRegisterNotifier(Self);
  inherited;
end;

{-------------------------------------------------------------------------}

procedure TPackagedCollection.CMFREEEDITGROUP(Var M:TMessage);
begin
  DeleteItems(M.wParam);
end;

{-------------------------------------------------------------------------}

procedure TPackagedCollection.DeleteItems(DesignGroup:Integer);
Var
  i:Integer;
begin
  for I:=Count-1 downto 0 do
    if DesignGroup=TPackagedCollectionItem(Items[i]).DesignGroup then
      Items[i].Free;
end;

{-------------------------------------------------------------------------}

procedure RegisterPopupClass(PropertyType: PTypeInfo; ComponentClass: TClass;
                   const PropertyName: string; EditorClass: TComponentClass);
begin
  with TPopupClassInfo(PopupClasses.Add) do
    begin
      c      := EditorClass;
      ti     := PropertyType;
      name   := PropertyName;
      CClass := ComponentClass;
    end;

  SafeRegisterClass(EditorClass);
end;

{------------------------------------------------------------------}

procedure UnRegisterPopupClass(PropertyType: PTypeInfo; ComponentClass: TClass;
                   const PropertyName: string; EditorClass: TComponentClass);
var
  i : integer;
begin
  for i := 0 to PopupClasses.Count - 1 do
    with TPopupClassInfo(PopupClasses[i]) do
      if (c = EditorClass) and (ti = PropertyType) and
         (name = PropertyName) and (CClass = ComponentClass) then
        begin
          PopupClasses[i].Free;
          break;
        end;
end;

{------------------------------------------------------------------}

procedure UnRegisterEditClass(PropertyType: PTypeInfo; ComponentClass: TClass;
                   const PropertyName: string; EditorClass: TComponentClass);
var
  i : integer;
begin
  for i := 0 to EditClasses.Count - 1 do
    with TEditClassInfo(EditClasses[i]) do
      if (c = EditorClass) and (ti = PropertyType) and
         (name = PropertyName) and (CClass = ComponentClass) then
        begin
          EditClasses[i].Free;
          break;
        end;
end;

{------------------------------------------------------------------}

procedure RegisterEditSource(AClass : TEditSourceClass);
begin
  with TEditSourceClassInfo(EditSourceClasses.Add) do
    c := AClass;

  SafeRegisterClass(AClass);
end;

{------------------------------------------------------------------}

procedure RegisterEditClass(PropertyType: PTypeInfo; ComponentClass: TClass;
                   const PropertyName: string; EditorClass: TComponentClass);
begin
  with TEditClassInfo(EditClasses.Add) do
    begin
      c := EditorClass;
      ti := PropertyType;
      name := PropertyName;
      CClass := ComponentClass;
    end;

  SafeRegisterClass(EditorClass);
end;

{------------------------------------------------------------------}

procedure RegisterTextEditClass(PropertyType: PTypeInfo; ComponentClass: TClass;
                   const PropertyName: string; EditorClass: TComponentClass);
begin
  RegisterEditClass(PropertyType, ComponentClass, PropertyName, EditorClass);
  TEditClassInfo(EditClasses.Last).isText := true;
end;

{------------------------------------------------------------------}

function IsTextEditClass (EditorClass : TComponentClass) : boolean;
var
  i : integer;
begin
  result := false;
  for i := EditClasses.Count - 1 downto 0 do
    with TEditClassInfo(EditClasses[i]) do
      if (EditorClass = c) and IsText then
        begin
          result := true;
          exit;
        end;
end;

{*************************************************************************}

procedure InternalRegister(Const Page:String; const CompClasses:Array of TComponentClass;
           ACategories:TClassItemCats);
var
  i : integer;
begin
  for i := Low(CompClasses) to High(CompClasses) do
    begin
      classes.RegisterClass(CompClasses[i]);
      with ClassItems.RegisterClass(CompClasses[i], ACategories) do
        if PalettePage = '' then
          PalettePage := Page;
    end;
  BroadcastToNotifiers(nil, CM_REGISTERCOMPS, 0, 0);
end;

{------------------------------------------------------------------}

procedure mregisterproc(const Page: string; {$IFDEF D7} const {$ENDIF} ComponentClasses: array of TComponentClass);
begin
  InternalRegister(Page,ComponentClasses,[icShowinPalette]);
end;

{------------------------------------------------------------------}

procedure mregisternoicon({$IFDEF D7} const {$ENDIF} ComponentClasses: array of TComponentClass);
begin
  InternalRegister('',ComponentClasses,[icNoIcon]);
end;

{*************************************************************************}

procedure TClassItems.ListFieldClasses(L:TList);
Var
  i:Integer;
begin
  L.Clear;
  For i:=0 to Count-1 do
    With TClassItem(Items[i]) do
      if icField in Categories then
        L.Add(ClassPtr);
end;

{-------------------------------------------------------------------------}

function  TClassItems.IsIconClass (c : TComponentClass) : boolean;
Var
  i:Integer;
begin
  For i:=0 to Count-1 do
    With TClassItem(Items[i]) do
      If C.InheritsFrom(ClassPtr) then
      begin
        Result:=not (icNoIcon in Categories);
        exit;
      end;
  Result:=True;
end;

{-------------------------------------------------------------------------}

function TClassItems.RegisterClass(AClassPtr:TClass;ACategories:TClassItemCats):TClassItem;

function FindItem(C:TClass):TClassItem;
Var
  i:Integer;
begin
  for i:=0 to Count-1 do
    if TClassItem(Items[i]).ClassPtr=C then
    begin
      Result:=TClassItem(Items[i]);
      exit;
    end;
  Result:=nil;
end;

begin
  Result:=FindItem(AClassPtr);
  If Result=nil then
    Result:=TClassItem(Add);
  With Result do
  begin
    Categories:=Categories+ACategories;
    ClassPtr:=AClassPtr;
  end;
end;

{-------------------------------------------------------------------------}

constructor TClassItems.Create;
begin
  inherited Create(TClassItem);
end;

{*************************************************************************}

procedure RegisterNonInstant(ComponentClasses: array of TComponentClass);
begin
  InternalRegister('',ComponentClasses,[icNoIcon]);
end;

{------------------------------------------------------------}

{$IFDEF D3}

{$IFNDEF CLX}
procedure mregisternonactivex({$IFDEF D7} const {$ENDIF} ComponentClasses: array of TComponentClass;
  AxRegType: TActiveXRegType);
begin
  InternalRegister('',ComponentClasses,[icNonActiveX]);
end;

{$ENDIF}
{$ENDIF}

{-------------------------------------------------------------------------}

procedure PatchVCLPackage;
begin
  If not Assigned(RegisterComponentsProc) then
    RegisterComponentsProc := mregisterproc;

  If not Assigned(RegisterNoIconProc) then
   RegisterNoIconProc := mregisternoicon;
  {$IFDEF D3}
  {$IFNDEF CLX}
  
  If not Assigned(RegisterNonActiveXProc) then
    RegisterNonActiveXProc := mregisternonactivex;
  {$ENDIF}
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure UnPatchVCLPackage;
begin
  If @RegisterComponentsProc=@mregisterproc then
    RegisterComponentsProc := nil;

  If @RegisterNoIconProc=@mregisternoicon then
   RegisterNoIconProc := nil;
 {$IFDEF D3}
 {$IFNDEF CLX}
  If @RegisterNonActiveXProc=@mregisternonactivex then
    RegisterNonActiveXProc := nil;
 {$ENDIF}
 {$ENDIF}
end;

{------------------------------------------------------------------}

function IsIconClass (c : TComponentClass) : boolean;
begin
  Result := ClassItems.IsIconClass(c)
end;

{------------------------------------------------------------------}

procedure UpdateStandardButtons(btnOK, btnCancel, btnHelp: TButton);
begin
  btnHelp.Visible := boolShowHelpButton;
  if not boolShowHelpButton then
  begin
    btnOK.Left := btnCancel.Left;
    btnCancel.Left := btnHelp.Left;
  end;
  btnOK.Caption := ResStr(SOKButton);
  btnCancel.Caption := ResStr(SCancelButton);
  btnHelp.Caption := ResStr(SHelpButton);
end;

{------------------------------------------------------------------}

{$ENDIF WIN}

Procedure RegisterOptionsInitializator(OptionsInitializator:TOptionsInitializator);
Begin
  If OptionsInitializators=Nil Then
    OptionsInitializators:=TList.Create;
  OptionsInitializators.Add(@OptionsInitializator);
End;

{------------------------------------------------------------------}

Procedure UnRegisterOptionsInitializator(OptionsInitializator:TOptionsInitializator);
Begin
  If OptionsInitializators<>Nil Then
  Begin
    OptionsInitializators.Remove(@OptionsInitializator);
    If OptionsInitializators.Count=0 Then
      FreeObject(OptionsInitializators,OptionsInitializators);
  End;
End;

{------------------------------------------------------------------}

Procedure DCWriteStrWithLenToStream( AStream : TStream; Const AStr : String );
Var
  Len : Integer;
begin
  Len := Length( AStr );
  AStream.WriteBuffer( Len, SizeOf( Len ) );
  AStream.WriteBuffer( AStr[1], Len );
end;

{------------------------------------------------------------------}

Function  DCReadStrWithLenFromStream( AStream : TStream ) : String;
Var
  Len : Integer;
begin
  AStream.ReadBuffer( Len, SizeOf( Len ) );
  SetLength( Result, Len );
  AStream.ReadBuffer( Result[1], Len );
end;

{------------------------------------------------------------------}

Procedure DCClearPointStruct( Var APoint : TPoint );
begin
  FillChar( APoint, SizeOf( APoint ), 255 );
end;

{------------------------------------------------------------------}

Function DCIsPointStructClear( Const APoint : TPoint ) : Boolean;
begin
  Result := APoint.X = -1;
end;

{------------------------------------------------------------------}

Function DCGetUnitSource( Var AUnitName : String; Const AIncludePath : string;
  AUnitsSource : TStrings ) : Boolean;
Var
  UnitFullPath : String;
begin
  Result := False;
  if AUnitsSource = nil then
    Exit;
  AUnitsSource.Clear;
  UnitFullPath := DCRelativeFileSearch( AUnitName, AIncludePath );
  If UnitFullPath = '' Then
    Exit;
  AUnitsSource.LoadFromFile( UnitFullPath );
  AUnitName := UnitFullPath;
  Result := True;
end;

{------------------------------------------------------------------}

Function DCRelativeFileSearch( Const ARelativeFileName, APaths : String ) : String;
var
  I: Integer;
  TempStrings: TStringList;
begin
  TempStrings := TStringList.Create;
  try
    If FileExists( ARelativeFileName ) Then
    begin
      Result := ARelativeFileName;
      Exit;
    end;
    ParseString(APaths, ';', TempStrings);
    for I := 0 to TempStrings.Count - 1 do
    begin
      Result := DCExpandRelativeFileEx(TempStrings[I], ARelativeFileName);
      if FileExists(Result) then
        Exit;
    end;
    Result := '';
  finally
    TempStrings.Free;
  end;
end;

{------------------------------------------------------------------}

Function DCExpandRelativeFileEx( Const ABasePath, ARelativeFileName : String ) : String;
Var
  FileName : string;
begin
  FileName := ExtractFileName( ARelativeFileName );
  Result := DCExpandRelativePathEx( ABasePath, ExtractFilePath( ARelativeFileName ) ) + FileName;
end;

{------------------------------------------------------------------}

Function DCExpandRelativePathEx( Const ABasePath, ARelativePath : String ) : String;
Var
  SaveDir : String;
begin
  if ARelativePath = '' then
  begin
    Result := AddSlash(ABasePath);
    Exit;
  end;

  Result := '';
  SaveDir := GetCurrentDir;
  try
    SetCurrentDir(ABasePath);
    Result := ExpandFileName(ARelativePath);
  finally
    SetCurrentDir(SaveDir);
  end;
end;

{------------------------------------------------------------------}

procedure EnumTextStylesSets(Proc: TGetStrProc);
var
  List: TList;
  i: integer;
begin
  List := TList.Create;
  try
    GetRegisteredClasses(TObject, List);
    with List do
      for i := 0 to Count - 1 do
        if TObjectParamListItem(Items[i]).Params[SParTextStylesID] = SParTextStylesID then
          Proc(TObjectParamListItem(Items[i]).Params[SParTextStylesInitName]);
  finally
    List.Free;
  end;
end;

procedure FreeTextStylesSets;
var
  List: TList;
  i: integer;
begin
  List := TList.Create;
  try
    GetRegisteredClasses(TObject, List);
    with List do
      for i := Count - 1 downto 0 do
        with TObjectParamListItem(Items[i]) do
          if Params[SParTextStylesID] = SParTextStylesID then
          begin
            Free;
            Delete(i);
          end;
  finally
    List.Free;
  end;
end;

{------------------------------------------------------------------}

function DCIsStrInStrArray(const S:String;const SArray:Array of String):boolean;
var
  i:Integer;
begin
  for i:=Low(SArray) to High(SArray) do
    if AnsiCompareText(S,SArray[i])=0 then
    begin
      Result:=True;
      exit;
    end;
  Result:=False;
end;

{--------------------------------------}

function DCGetDelphiVerFromDefinesStr(const DefinesStr:String;var DelphiVer:TDelphiVer):boolean;
var
  TempStrings:TStringList;
begin
  TempStrings:=TStringList.Create;
  try
    ParseString(DefinesStr,';',TempStrings);
    Result:=DCGetDelphiVerFromDefines(TempStrings,DelphiVer);
  finally
    TempStrings.Free;
  end;
end;

{---------------------}

type
  TDCPropInfoList=class(TInterfacedObject,IDCPropInfoList)
  private
    FSize:Integer;
    FCount:Integer;
    FList:PPropList;
    function GetCount:Integer;
    procedure Cleanup;
    function GetItem(Index:Integer):PPropInfo;
  public
    procedure Delete(Index:Integer);
    procedure Intersect(List:IDCPropInfoList);
    procedure SetInstance(Instance:TPersistent;Filter:TTypeKinds);
    function ContainsItem(P:PPropInfo):Boolean;
    constructor Create(Instance:TPersistent;Filter:TTypeKinds);
    destructor Destroy;override;
    property Count:Integer read GetCount;
    property Items[Index:Integer]:PPropInfo read GetItem;default;
  end;

{---------------------}

function TDCPropInfoList.GetCount:Integer;
begin
  Result:=FCount;
end;

{---------------------}

procedure TDCPropInfoList.Cleanup;
begin
  if FList<>nil then
  begin
    FreeMem(FList,FSize);
    FList:=nil;
    FSize:=0;
  end;
end;

{---------------------}

procedure TDCPropInfoList.SetInstance(Instance:TPersistent;Filter:TTypeKinds);
begin
  Cleanup;
  FCount:=GetPropList(Instance.ClassInfo,Filter,nil);
  FSize:=FCount * SizeOf(Pointer);
  GetMem(FList, FSize);
  GetPropList(Instance.ClassInfo, Filter, FList);
end;

{---------------------}

constructor TDCPropInfoList.Create(Instance: TPersistent; Filter: TTypeKinds);
begin
  inherited Create;
  SetInstance(Instance,Filter);
end;

{---------------------}

destructor TDCPropInfoList.Destroy;
begin
  Cleanup;
  inherited;
end;

{---------------------}

function TDCPropInfoList.ContainsItem(P:PPropInfo):Boolean;
var
  I:Integer;
begin
  for I:=0 to FCount-1 do
    with FList^[I]^ do
      if (PropType^=P^.PropType^) and (CompareText(Name,P^.Name)=0) then
      begin
        Result:=True;
        Exit;
      end;
  Result:=False;
end;

{---------------------}

procedure TDCPropInfoList.Delete(Index:Integer);
begin
  Dec(FCount);
  if Index<FCount then
    Move(FList^[Index+1],FList^[Index],(FCount-Index)*SizeOf(Pointer));
end;

{---------------------}

function TDCPropInfoList.GetItem(Index:Integer):PPropInfo;
begin
  Result:=FList^[Index];
end;

{---------------------}

procedure TDCPropInfoList.Intersect(List:IDCPropInfoList);
var
  I:Integer;
begin
  for I:=FCount-1 downto 0 do
    if not List.ContainsItem(FList^[I]) then
      Delete(I);
end;

{---------------------}

function DCCreatePropInfoList(Instance:TPersistent;Filter:TTypeKinds):IDCPropInfoList;
begin
  Result:=TDCPropInfoList.Create(Instance,Filter);
end;

{------------------------------------------------------------------}

procedure DCGetDelphiSourceDirsAsStrings(DelphiVer:TDelphiVer;Strings:TStrings);
var
  S:String;
begin
  Strings.Clear;
  S:=GetDelphiSourceDirsEx(DelphiVer);
  ParseString(S,';',Strings);
end;

{------------------------------------------------------------------}

function DCChangeFilePath(const FileName,NewPath:String):String;
begin
  Result:=AddSlash(NewPath)+ExtractFileName(FileName);
end;

{-------------------------------}

procedure DCChangeFilePathInStrings(Strings:TStrings;const NewPath:String);
var
  i:Integer;
  NeedResort:boolean;
begin
  NeedResort:=(Strings is TStringList) and TStringList(Strings).Sorted;

  If NeedResort then
    TStringList(Strings).Sorted:=False;

  for i:=0 to Strings.Count-1 do
    Strings[i]:=DCChangeFilePath(Strings[i],NewPath);

  If NeedResort then
    TStringList(Strings).Sorted:=True;
end;

{-------------------------------}

procedure DCChangeFileExtInStrings(Strings:TStrings;const NewExt:String);
var
  i:Integer;
  NeedResort:boolean;
begin
  NeedResort:=(Strings is TStringList) and TStringList(Strings).Sorted;

  If NeedResort then
    TStringList(Strings).Sorted:=False;

  for i:=0 to Strings.Count-1 do
    Strings[i]:=ChangeFileExt(Strings[i],NewExt);

  If NeedResort then
    TStringList(Strings).Sorted:=True;
end;

{------------------------------------------------------------------}

initialization
{$IFDEF WIN}
  PatchVCLPackage;
  fGlobalOptionsList := TStringList.Create;
{$ENDIF}

  RunRegister;

  AppGUID:=GUIDToString(CreateNewGUID);
  {$IFDEF LOGFILE}
  WriteToLog('-- Started ['+ParamStr(0)+'] -------------');//don't resource
  {$ENDIF}
finalization
{$IFDEF WIN}
{$IFNDEF CLX}
  FreeObject(IDEActiveNotifier,IDEActiveNotifier);
  DoneGlobalOptions;
  FreeObject(FRegistry,FRegistry);

  UnPatchVCLPackage;
  _ClassItems.Free;

  fPopupClasses.Free;
  fEditSourceClasses.Free;
  fEditClasses.Free;
{$ENDIF}
{$ENDIF}

  FreeObject(FNotifiers,FNotifiers);
  FreeObject(FWin32FileSystem,FWin32FileSystem);
  FreeObject(FFileSystemList,FFileSystemList);
  FreeObject(FObjectParamList,FObjectParamList);
  {$IFDEF LOGFILE}
  WriteToLog('-- Closed ['+ParamStr(0)+'] -------------');//don't resource
  {$ENDIF}

end.
