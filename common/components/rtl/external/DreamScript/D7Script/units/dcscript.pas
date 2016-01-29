{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcscript;

interface
{$I dc.inc}
{$I dcscripter.inc}

uses
  dialogs,dcconsts, Classes, TypInfo, Sysutils,

  comobj,
  {$IFDEF WIN}
    {$IFDEF CLX}
    QControls, QDialogs,QForms,
    {$ELSE}
    controls, forms,
    {$ENDIF}
  {$ENDIF}

  {$IFDEF ACTIVESCRIPTING}
  ActiveX,
  Windows,
  {$ELSE}
  dcActivex,
  {$ENDIF}

  dchook,

  {$IFDEF ACTIVESCRIPTING}
  dcAxScript,
  {$ENDIF}

  {$IFDEF WIN}
  dcapp,
  {$ENDIF}

  dcapi, Consts, dccdes, dcdreamlib,

  {$IFDEF WIN}
    {$IFDEF CLX}
    QActnList,
    {$ELSE}
    {$IFDEF D4}actnlist,{$ENDIF}
    {$ENDIF}
  {$ENDIF}

  dcsystem

  {$IFDEF WIN}
  ,dccommon
  {$ENDIF}
  {$IFDEF D6}
  ,rtlconsts,Variants                   
  {$ENDIF}
  ;

type
  SScriptEngineRunException = class(Exception);

const
  SRunnerExtension    = 'ScriptRun.Extension'; //don't resource
  SRunnerDescription  = 'ScriptRun.Description'; //don't resource

  ExternalRunner = 'dcrunner.exe'; //don't resource
  SCRIPTERROREVENTNAME = 'EXRUNSCRIPTERROREVENT'; //don't resource
  SCRIPTERRORFILENAME  = 'EXRUNSCRIPTERRORFILE'; //don't resource

type
  PArgList = PVariantArgList;
{$IFDEF CPB4}
{$NODEFINE PArgList}
  (*$HPPEMIT 'namespace Dcscript'}*)
  (*$HPPEMIT '{'}*)
  (*$HPPEMIT 'typedef tagVARIANT *PArgList;'*)
  (*$HPPEMIT '}'*)
{$ENDIF}

const
  PCharTypeInfo     = 1;
  PWideCharTypeInfo = 2;
  RealTypeInfo      = 3;
  UntypedTypeInfo   = 4;
  ArrayOfConstInfo  = 5;
  PointerInfo       = 6;
  PWideCharInfo     = 7;

  TypeInfoPChar = pointer(PCharTypeInfo);
  TypeInfoPWideChar = pointer(PWideCharTypeInfo);
  TypeInfoReal = pointer(RealTypeInfo);
  TypeInfoUntyped = pointer(UntypedTypeInfo);
  TypeInfoArrayOfConst = pointer(ArrayOfConstInfo);
  TypeInfoPointer = pointer(PointerInfo);

  tNoTypeInfoTypes = [PCharTypeInfo, PWideCharTypeInfo, RealTypeInfo, UntypedTypeInfo, ArrayOfConstInfo, PointerInfo];

  NoParams : array [0..0] of PTypeInfo = (pointer(1));

type
  TScriptRunner = class;
  TDCScripter = class;

  TGetUserVarIDProc = procedure(const VarName : string; var VarID : integer) of object;
  TGetUserVarProc = procedure(const VarName : string; VarID : integer; var VarValue : OleVariant) of object;
  TSetUserVarProc = procedure(const VarName : string; VarID : integer; const VarValue : OleVariant) of object;

  TGetUnitFileNameProc = procedure (Sender : TObject; const UnitName : string; var AFilerID : TFilerID;
                                    var AFileName : TFileName; var processed : boolean) of object;

  TGetUnitScripterProc = procedure (Sender : TObject; const UnitName : string; var Scripter : TDCScripter) of object;

  TModuleLoadedProc = procedure(Sender : TObject; AModule : TComponent; OrigClassName : string) of object;

  TScriptInitFinalProc = procedure (Sender : TObject) of object;
  TGetFormClassProc = procedure (Sender : TObject; var FormClass : TCustomFormClass) of object;

  TScriptErrorHandler = procedure (Sender : TObject; const ExcepInfo : TExcepInfo;
                            CharNo, LineNo : integer; var Handled : boolean) of object;

  TAutoCreateFormHandler = procedure (Sender : TObject; const FileName, FormClassName : string; var AutoCreate : boolean) of object;
  TTemplateFun = function (const expr : string) : string;

  TDebugManager = class
    function IsBreakPoint(Scripter : TDCScripter; ALine : integer) : boolean; virtual; abstract;
  end;

  TScriptRunner = class
  private
    fOnError : TScriptErrorHandler;
    FNamedItems  : TStringList;
    FGlobalItems : TStringList;
    fScripter : TDCScripter;
    fGlobalWrapper : TObject;
    fScriptName : string;

    fErrLine : integer;
    fErrChar : integer;
    fErrMsg  : string;
    fRunCount : integer;
    fDefaultObject : TObject;

    fSilent : boolean;
    fStrictCheck : boolean;
    fScripterDestroyed : boolean;

    procedure DoneGlobals;
    procedure AddGlobals;
    procedure ClearNamedItems;

  protected
    property NamedItems : TStringList read fNamedItems;
    property GlobalItems : TStringList read fGlobalItems;

    function  GetScriptDispatch : IDispatch; virtual;
    procedure ScriptError(Sender : TObject; const ExcepInfo : TExcepInfo;
                                  CharNo, LineNo : integer;var Handled : boolean); virtual;
    procedure StopScript; virtual;
    function GetModuleAlias : string; virtual;
    procedure DoRemoveItem(const Name : string); virtual;
    procedure FreeRunner; virtual;
    procedure DoInterrupt; virtual;

    property ScripterDestroyed : boolean read fScripterDestroyed;
  public
    constructor Create(AScripter : TDCScripter; const AScriptName : string); virtual;
    destructor  Destroy; override;

    function    GetIDByName(const Name : string) : TDispID;
    function    DispatchMethod(MethodName : PChar; cArgs : integer; pArgs : PArgList) : Variant; virtual;
    function    ParseScript(const Script : string) : boolean; virtual; abstract;
    procedure   AddItem(const Name : string; Global : boolean; const idisp : IDispatch); virtual;
    procedure   RemoveItem(const Name : string);
    procedure   GetVarList(S : TStrings); virtual; abstract;

    procedure   SetVarValue(const VarName : string; const Value : OleVariant);
    function    GetVarValue(const VarName : string) : OleVariant;

    procedure   SaveToStream(S : TStream); virtual;
    procedure   LoadFromStream(S : TStream); virtual;

    function    EvaluateExpression(const Expr : string) : OleVariant; virtual;

    function    Run : Variant;

    procedure  TraceInto; virtual;
    procedure  StepOver; virtual;
    function   CurrentExecutionLine : integer; virtual;
    procedure  GetWatchesPreffixes(var APref_Hex, APref_Str: string); virtual;

    property DefaultObject : TObject read fDefaultObject;
    property ScriptDispatch : IDispatch read GetScriptDispatch;
    property OnError : TScriptErrorHandler read fOnError write fOnError;

    property Silent : boolean read fSilent write fSilent;
    property ScriptName : string read fScriptName write fScriptName;
    property StrictSyntaxCheck : boolean read fStrictCheck;
    property Scripter : TDCScripter read fScripter;
  end;

  TScriptRunClass = class of TScriptRunner;

  TItemInfo = class
    Name   : string;
    disp   : IDispatch;
    Global : boolean;

    destructor Destroy; override;
  end;

  TEventItem = class;

  TEventItems = class(TDCNamedItems)
  private
    function GetItem(index : integer) : TEventItem;
  public
    property Items[index : integer] : TEventItem read GetItem; default;
  end;

  TFreeNotifier = class(TComponent)
  private
    fComp : TComponent;
    fEventItem : TEventItem;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

  TEventItem = class(TDCNamedItem)
  private
    fComponent    : TComponent;
    fEvent        : string;
    fScriptMethod : string;
    fNotifier     : TFreeNotifier;
    fCallExisting : boolean;
    fHooked       : boolean;

    procedure SetComponent(val : TComponent);
    function  GetScripter : TDCScripter;
    procedure SetEvent(const AEvent : string);
    procedure SetScriptMethod(const AScriptMethod : string);

    procedure  Hook;
    procedure  UnHook;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property  Scripter : TDCScripter read GetScripter;
  published
    property  CallExisting : boolean read fCallExisting write fCallExisting;
    property  Component : TComponent read fComponent write SetComponent;
    property  Event : string read fEvent write SetEvent;

    property  ScriptMethod : string read fScriptMethod write SetScriptMethod;
  end;

  TDCScripter = class(TDCSimpleScripter)
  private
    fItems      : TStringList;
    fEvents     : TEventItems;
    fdlist      : TList;
    fRefCount   : integer;
    fScript     : TStrings;
    fFileName   : TFileName;
    fFilerID    : TFilerID;
    fModule     : TComponent;
    fCreatedModule : TComponent;
    fUsedList   : TList;
    fRunInfo    : pointer;
    {$IFDEF WIN}
    fCompFiler  : TCompFiler;
    {$ENDIF}
    fProject    : THandle;
    fOnError    : TScriptErrorHandler;
    fOnAutoCreateForm : TAutoCreateFormHandler;

    {$IFDEF WIN}
    fObjectList : TIDEObjectList;
    fOldOnClose : TCloseEvent;
    {$ENDIF}

    {$IFDEF THREADSAFE}
    fInitScriptRunLock  : TRTLCriticalSection;
    {$ENDIF}

    fLanguage   : string;
    fRegClassItem   : TObjectParamListItem;
    fOnGetUserVarID : TGetUserVarIDProc;
    fOnGetUserVar   : TGetUserVarProc;
    fOnSetUserVar   : TSetUserVarProc;
    fOnModuleLoaded    : TModuleLoadedProc;
    fOnGetUnitFileName : TGetUnitFileNameProc;
    fOnGetUnitScripter : TGetUnitScripterProc;
    fUserVars          : TStringList;
    fInDesign          : integer;
    FVersion           : TDCVersion;
    fCompiledScript    : TStream;
    fScriptName        : string;
    funitsList         : TStringList;
    fModuleClassName   : string;
    fScriptUnitModuleClass : TComponentClass;
    fUnitFormFileName    : string;
    fUnitFormFilerID     : TFilerID;
    fLoadedUnitModules     : TList;

    fOnBeforeScriptInitialized : TScriptInitFinalProc;
    fOnAfterScriptInitialized  : TScriptInitFinalProc;
    fOnGetFormClass            : TGetFormClassProc;

//    fOnGetScriptForm : TGetScriptFormEvent;
    fDebugProject  : THandle;
    FOnLastUnitLoaded: TNotifyEvent;
    fsccheck         : TScriptRunner;
    fDebugObject     : TObject;

    fModuleCreated : boolean;
    fScriptChanged : boolean;
    fUseModule     : boolean;
    fRunFailed     : boolean;
    fHookAllEvents : boolean;
    fLinkEvents    : boolean;
    fModalRun      : boolean;
    fusesprocessed : boolean;
    fInStopScripts : boolean;
    fInDestroy     : boolean;

    fUseExceptions : boolean;
    {$IFDEF WIN}
    fHandlingError : boolean;
    {$ENDIF}

    function  LoadScript : boolean;
    function  LoadUnit(const UnitName : string) : TDCScripter;
    function  GetScriptRunClass : TScriptRunClass;
    function  GetScriptRun : TScriptRunner;
    procedure RegisterUsedObjects(Runner : TDCScripter);
    procedure UnregisterUsedObjects(Runner : TDCScripter);
    function  GetDispatch(Instance : TObject) : IDispatch;

    {$IFDEF WIN}
    procedure HookClose;
    procedure CloseEvent(Sender: TObject; var Action: TCloseAction);
    {$ENDIF}
    procedure SetScript(val : TStrings);
    procedure ScriptChange(Sender : TObject);
    procedure AddObjectsToScript;
    procedure AddItemToScript(item : TItemInfo);
    procedure HookEvents;
    procedure UnHookEvents;
    procedure SetEvents(val : TEventItems);
    procedure SetLinkEvents(val : boolean);
    procedure CheckRegItem;

    function  GetScriptVar(const VarName : string) : OleVariant;
    procedure SetScriptVar(const VarName : string; const Value : OleVariant);
    function  GetUnitName : string;
    function  GetUsedModule(const ModuleName : string) : TDCScripter;
    procedure SetFileName(const val : TFileName);

    function  GetUserVar(VarID : integer) : OleVariant;
    function  SetUserVar(VarID : integer; const Value : OleVariant) : HRESULT;

    procedure  Finish;
    function   InitScriptRun : boolean;
    procedure  SetModule(val : TComponent);
    procedure  ProcessUses;
    procedure  LoadUnitModule (AModule : TComponent);
    procedure  UnloadUnitModule(AModule : TComponent);
    procedure  KillCreatedModule;
  protected
    {$IFDEF WIN}
    function  GetErrorString(const ExcepInfo : TExcepInfo; CharNo, LineNo : integer) : string;
    {$ENDIF}

    procedure ScriptError(Sender : TObject; const ExcepInfo : TExcepInfo;
                          CharNo, LineNo : integer; var Handled : boolean); virtual;

    function  GetUserVarID(const VarName : string) : integer;

    {$IFDEF WIN}
    function  CheckAutoCreateForm(const FileName : TFileName; S : TStream) : boolean;
    function  LoadModule(const FilerID : TFilerID; const FileName : TFileName) : TComponent; virtual;
    {$ENDIF}

    function  GetUnitFileName(const UnitName : string;
                var AFilerID : TFilerID; var AFileName : TFileName) : boolean; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure   AddRef;
    procedure   Release;

    procedure   Loaded; override;
    function    GlobalFindCompInTheSameModule(const Name : string) : TComponent;

    property    DebugProject : THandle read fDebugProject write fDebugProject ;
    property    OnLastUnitLoaded: TNotifyEvent read FOnLastUnitLoaded write FOnLastUnitLoaded;
  public
    procedure   TraceInto;
    procedure   StepOver;
    procedure   CreateScriptRunner;
    function    CurrentExecutionLine : integer;
    
    procedure   RaiseScriptError(const ErrMsg : string);
    procedure   StopScripts;
    function    _DispatchMethod(MethodName : PChar; cArgs : integer; pArgs : PArgList) : Variant;
    function    GetCodeDesignerClass : TCodeDesignerClass;
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy; override;

    procedure   BeginDesign; override;
    procedure   EndDesign; override;
    procedure   CreateEvent(Instance : TComponent; const AEvent, AScriptMethod : string; ACallExisting : boolean); override;
    procedure   RenameEvent(const OldName, NewName : string); override;
    procedure   EventDeleted; override;

    procedure   Stop;
    procedure   InterruptScript;
    procedure   AddItem(const Name : string; Global : boolean; const idisp : IDispatch);
    procedure   AddObjectToScript(Instance : TObject; const Name : string; Global : boolean);
    procedure   RemoveItem(const Name : string);

    function    Run : Variant;
    function    DispatchMethod(const MethodName : string; const pArgs : array of OleVariant) : Variant;
    function    CallNoParamsMethod(const MethodName : string) : Variant;
    function    GetModule : TComponent; virtual;

    function    CheckSyntax : boolean;
    function    CheckSyntaxEx(var ErrLine, ErrChar : integer; StrictCheck : boolean) : boolean;
    function    CheckSyntaxEx2(var ErrLine, ErrChar : integer; var ErrMessage : string; StrictCheck : boolean) : boolean;

    function    Evaluate(const expr : string) : Variant;

    procedure   LoadCompiledScriptFromStream(S : TStream);
    procedure   SaveCompiledScriptToStream(S : TStream);

    procedure   LoadCompiledScriptFromFile(const FileName : string);
    procedure   SaveCompiledScriptToFile(const FileName : string);

    function    GetDisplayScriptName : string;

    function    IsRunning : boolean;

    procedure   UseUnit(const UnitName : string);
    procedure   UnloadUnit(const UnitName : string);    

    property    FilerID : TFilerID read fFilerID write fFilerID;
    property    ModuleClassName : string read fModuleClassName;

    {$IFDEF WIN}
    property    ObjectList : TIDEObjectList read fObjectList;
    {$ENDIF}

    property    Project: THandle read fProject write fProject;

    property    RunFailed : boolean read fRunFailed;
    property    ScriptRun : TScriptRunner read GetScriptRun;

    property    ScriptVars[const VarName : string] : OleVariant read GetScriptVar write SetScriptVar;
    property    UnitName : string read GetUnitName;
    property    UsedModules[const ModuleName : string] : TDCScripter read GetUsedModule;
    property    HookAllEvents : boolean read fHookAllEvents write fHookAllEvents;

    property    DebugObject : TObject read fDebugObject write fDebugObject;

    property    OnBeforeScriptInitialized: TScriptInitFinalProc read fOnBeforeScriptInitialized write fOnBeforeScriptInitialized;
    property    OnAfterScriptInitialized: TScriptInitFinalProc read fOnAfterScriptInitialized write fOnAfterScriptInitialized;
    property    OnGetFormClass: TGetFormClassProc read fOnGetFormClass write fOnGetFormClass;
  published
    property    Events   : TEventItems read fEvents write SetEvents;
    property    Language : string read fLanguage write fLanguage;
    property    LinkEvents : boolean read fLinkEvents write SetLinkEvents default true;
    property    ModalRun : boolean read fModalRun write fModalRun default false;
    property    Module : TComponent read fModule write SetModule;
    property    Script : TStrings read fScript write SetScript;
    property    ScriptFile : TFileName read fFileName write SetFileName;
    property    ScriptName : string read fScriptName write fScriptName;
    property    UseModule : boolean read fUseModule write fUseModule default true;
    property    UseExceptions : boolean read fUseExceptions write fUseExceptions default false;

    property    Version : TDCVersion read FVersion write FVersion stored false;

    property    OnError : TScriptErrorHandler read fOnError write fOnError;

    property    OnGetUserVarID : TGetUserVarIDProc read fOnGetUserVarID write fOnGetUserVarID;
    property    OnGetUserVar   : TGetUserVarProc   read fOnGetUserVar   write fOnGetUserVar;
    property    OnSetUserVar   : TSetUserVarProc   read fOnSetUserVar   write fOnSetUserVar;
    property    OnGetUnitFileName : TGetUnitFileNameProc read fOnGetUnitFileName write fOnGetUnitFileName;
    property    OnGetUnitScripter : TGetUnitScripterProc read fOnGetUnitScripter write fOnGetUnitScripter;
    property    OnModuleLoaded    : TModuleLoadedProc    read fOnModuleLoaded    write fOnModuleLoaded;
    property    OnAutoCreateForm : TAutoCreateFormHandler read fOnAutoCreateForm write fOnAutoCreateForm;
  end;

procedure AssignEventHandlers(Instance : TPersistent; EventHandler : TEventHandler;
                              CallInherited : boolean);

procedure RestoreEventHandlers(Instance : TPersistent);

function  CreateEventCode(Instance : TPersistent; const EventName : string;
                         EventHandler : TEventHandler; CallInherited : boolean) : pointer;

function  CreateEventHandler(Instance : TPersistent; const EventName : string;
            EventHandler : TEventHandler; CallInherited : boolean; const HandlerName : string) : pointer;

function  CreateEvent(Instance : TPersistent; Event : PPropInfo;
                     EventHandler : TEventHandler; CallInherited : boolean) : pointer;

function CreateHandler(Instance : TPersistent; Event : PPropInfo;
           EventHandler : TEventHandler; CallInherited : boolean; const HandlerName : string) : pointer;

procedure HookAllEvents(AComp : TComponent; Scripter : TDCScripter);
procedure UnhookAllEvents(AComp : TComponent);


procedure FreeEventCode(Event : pointer);
function  GetOldEventCode(Event : pointer) : pointer;
function  IsEventCode(Event : pointer) : boolean;
procedure RestoreOldEvent(Instance : TPersistent; PropInfo : PPropInfo);
procedure RestoreOldEventHandler(Instance : TPersistent; PropInfo : PPropInfo);

procedure RunModule(ScriptClass : TScriptRunClass; Module : TComponent;
                    Modal : boolean; Script : TStrings; ErrorProc : TScriptErrorHandler);

procedure RegisterScriptRunner(RunnerClass : TScriptRunClass; const Extension, Desc : string);
function  GetScriptRunnerClass(const FileExt : string) : TScriptRunClass;

procedure RegisterTemplateFun(const LangName : string; TemplateFun : TTemplateFun);

function Disp2Object(const idisp : IDispatch) : TObject;
function GetObjectDispatch(O : TObject; WrapList : TList) : IDispatch;

type
  TPropGetProc = function(Instance : TObject; Index : PArgList) : OleVariant;
  TPropSetProc = procedure(Instance : TObject; Params : PArgList);

  PPropertyInfo = ^TPropertyInfo;
  TPropertyInfo = class
    IndexCount : integer;
    GetProc    : TPropGetProc;
    SetProc    : TPropSetProc;
  end;

  TRegisteredConstInfo = class
    Value : Variant;
  end;

  TVarInfo = class
    GetProc    : TPropGetProc;
    SetProc    : TPropSetProc;
  end;

  TRegisteredClassInfo = class
  public
    RClass  : TClass;
    Methods : TStringList;
    Props   : TStringList;
    DefaultProp : TPropertyInfo;

    constructor Create;
    destructor  Destroy; override;
  end;

const
  MaxParams = 32;

type
  TParamInfo = record
    skip       : integer;
    size       : integer;
    inregister : integer;
    val        : array[0..0] of byte;
  end;

const
  valoffset = 3 * sizeof(integer);

type
  PParamInfo = ^TParamInfo;
  TVarToParamProc = procedure (const v : OleVariant; p : Pointer; _info : PTypeInfo); //size, val
  TParamToVarProc = procedure (var p; var v : OleVariant);
  TVarToVarProc   = procedure (var p; const v : OleVariant);
  TFreeParamProc  = procedure (p : PParamInfo);

  TParamRec = record
    PSize      : integer;
    UseRegister: integer;
    VarToParam : TVarToParamProc;
    ParamToVar : TParamToVarProc;
    VarToVar   : TVarToVarProc;
    FreeParam  : TFreeParamProc;
    Flags      : TParamFlags;
    _tinfo     : PTypeInfo;
  end;

  TParamRecArray = array[0 .. MaxParams - 1] of TParamRec;
  PParamRecArray = ^TParamRecArray;

  PMethodInfo = ^TMethodInfo;

  TMethodInfo = class
  private
    fParamCount   : integer;
    procedure SetParamCount(val : integer);
  public
    Address       : Pointer;
    RetType       : PTypeInfo;
    ParamsSize    : integer;
    ParamRecs     : PParamRecArray;
    ITypeData     : PTypeData;
    MethodType    : TMethodType;
    CallType      : TCallType;
    OfObject      : boolean;
    IsVirtual     : boolean;
    IsDynamic     : boolean;

    destructor  Destroy; override;

    property ParamCount : integer read fParamCount write SetParamCount;
  end;


function RegisterReservedProcEx(AClass : TScriptRunClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer;
            CallType : TCallType; MethodType : TMethodType) : TMethodInfo;

function RegisterReservedProc(AClass : TScriptRunClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer; CallType : TCallType) : TMethodInfo;

function RegisterProc(AClass : TClass; const ProcName : string; MethodType : TMethodType;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; Addr : pointer; CallType : TCallType) : TMethodInfo;

function RegisterProcedure(const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; Addr : pointer; CallType : TCallType) : TMethodInfo;

function RegisterClassMethod(AClass : TClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; Addr : pointer; CallType : TCallType) : TMethodInfo;

function RegisterMethod(AClass : TClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; Addr : pointer; CallType : TCallType) : TMethodInfo;

function RegRegisterMethod(AClass : TClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; Addr : pointer) : TMethodInfo;

function  RegisterRWProc(const RWName : string; Proc : pointer) : TMethodInfo;

procedure UnregisterProcedure(const ProcName : string; ProcInfo : TMethodInfo); 

procedure UnregisterProc(AClass : TClass; const ProcName : string; ProcInfo : TMethodInfo);

procedure RegisterEvent(ProcInfo : PTypeInfo; const Params : array of PTypeInfo);

procedure RegisterIndexedProperty(AClass : TClass; const PropName : string;
            AIndexCount : integer; IsDefault : boolean;
            AGetProc : TPropGetProc; ASetProc : TPropSetProc);
procedure RegisterProperty(AClass : TClass; const PropName : string;
                           AGetProc : TPropGetProc; ASetProc : TPropSetProc);

function RegisterConst(const ConstName : string; const ConstValue : Variant) : TRegisteredConstInfo;
procedure UnregisterConst(const ConstName : string; ConstInfo : TRegisteredConstInfo);

function RegisterVar(const VarName : string; AGetProc : TPropGetProc; ASetProc : TPropSetProc) : TVarInfo;
procedure UnregisterVar(const VarName : string; VarInfo : TVarInfo);

procedure RegisterClassInScript(AClass : TClass);
procedure UnRegisterClassInScript(AClass : TClass);

procedure RegisterClassesInScript(const AClasses : array of TClass);
procedure UnRegisterClassesInScript(const AClasses : array of TClass);

function GetMethodInfo(AClass : TClass; const AMethodName : string) : TMethodInfo;
procedure CallMethod(Instance : TObject; MethodInfo : TMethodInfo; cArgs : integer;
                    pArgs : PArgList; Result : POleVariant);
{function CallMethod(Instance : TObject; MethodInfo : TMethodInfo; cArgs : integer;
                    pArgs : PArgList) : OleVariant;}
function CreateObject(cArgs: integer; pArgs: PArgList): OleVariant;

function  VarFromObject(Instance : TObject) : OleVariant;
function  VarFromSet(const s; size : integer) : integer;
procedure VarToSet(var s; size : integer; const v : OleVariant);
function  VarToObject(const v : OleVariant) : TObject;
function  VarToChar(const v : OleVariant) : char;
function  VarToPointer(const v : OleVariant) : pointer;
function  PointerToVariant(p : pointer) : OleVariant;

//procedure _run;

function FileCanBeExecuted(const FileName : String) : boolean;
function VarFromInterface(const Disp : IDispatch): Variant;
function VarToInterface(const V: Variant): IDispatch;

function DCVarToInterface(const V: Variant): IDispatch;

{$IFDEF WIN}
{$IFNDEF CLX}
function  ExternalRunProject(const FileName : string) : THandle;
{$ENDIF}
{$ENDIF}

function  IsModuleRunning(Handle : THandle) : boolean;
procedure ResetRunningModule(Handle : THandle);

{$IFDEF WIN}
function  RunObjectList(list : TIDEObjectList) : THandle;
function  RunObjectListModal(list : TIDEObjectList) : THandle;
{$ENDIF}

function  RunUnit(const FileName : string) : THandle;
function  RunUnitModal(const FileName : string) : THandle;

function  UniRunUnit(const FileName, ALanguage : string; const AFilerId : TFilerID; IsModal : boolean): THandle;

function  InSet(elem : integer; aset : integer) : boolean;
function  _Set(cArgs : integer; pArgs : PArgList) : OleVariant;
function  _Chr(x : byte) : string;
function  GetRefVariant(v : POleVariant) : POleVariant;

function  ArrayInfo   (TInfo : PTypeInfo) : PTypeInfo;

{$IFDEF D4}
function  DynArrayInfo(TInfo : PTypeInfo) : PTypeInfo;
{$ENDIF}

type
  TScriptProc = function (cArgs : integer; pArgs : PArgList) : OleVariant;
  TScriptMethod = function (Instance : TObject; cArgs : integer; pArgs : PArgList) : OleVariant;

type
  TSimpleObjectProc = procedure of object;

{$IFDEF ACTIVESCRIPTING}
type
  TActiveScriptSite = class;

  TScriptRun = class
  private
    fScriptName : string;
  public
    asite : TActiveScriptSite;
    CatID : TGuid;
    ScriptRunner : TScriptRunner;

    ActiveScript :      IActiveScript;
    ActiveScriptParse : IActiveScriptParse;
    ActiveScriptSite :  IActiveScriptSite;

//    ActiveScriptParseProcedure : IActiveScriptParseProcedure;

    function  InitEngine : Boolean;
    function  ParseScript(const ScriptText : PWideChar): integer; safecall;
    procedure StopEngine;
    constructor Create(const ScriptName : string);
  end;

  TActiveScriptSite = class(TObject, IUnknown,
                            IActiveScriptSite,
                            IActiveScriptSiteWindow,
                            IActiveScriptSiteDebug
                            {IApplicationDebugger})
  private
    fItems       : TStringList;
    fOnError     : TScriptErrorHandler;
    fRefCount    : integer;
    fHelper      : IDebugDocumentHelper;
    ScriptName   : string;
    ScriptRunner : TScriptRunner;

    fFailed    : boolean;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    { IActiveScriptSite }
    function GetLCID(var wLCID: TLCID): HResult;  virtual; stdcall;
    function GetItemInfo(ItemName: PWideChar; dwReturnMask: DWord;
      out UnkItem: IUnknown; out outTypeInfo: ITypeInfo): HResult; stdcall;
    function GetDocVersionString(var VersionString: TBSTR): HResult;  virtual; stdcall;
    function OnScriptTerminate(var VarResult: OleVariant;
      var ExcepInfo: TExcepInfo): HResult;  virtual; stdcall;
    function OnStateChange(ScriptState: LongInt): HResult;  virtual; stdcall;
    function OnScriptError(pAse: IActiveScriptError): HResult;  virtual; stdcall;
    function OnEnterScript: HResult;  virtual; stdcall;
    function OnLeaveScript: HResult;  virtual; stdcall;

    { IActiveScriptSiteWindow }
    function GetWindow(var Hwnd: THandle): HResult; virtual; stdcall;
    function EnableModeless(FEnable: WordBool): HResult; virtual; stdcall;


    { IActiveScriptSiteDebug }
    function GetDocumentContextFromPosition(const dwSourceContext : DWORD;
          const uCharacterOffset: ULONG; const uNumChars : ULONG;
          out ppsc : IDebugDocumentContext) : HRESULT; stdcall;

    function GetApplication(out ppda : IDebugApplication) : HRESULT; stdcall;
    function GetRootApplicationNode(out ppdanRoot : IDebugApplicationNode) : HRESULT; stdcall;
    function OnScriptErrorDebug(const pErrorDebug : IActiveScriptErrorDebug;
                out pfEnterDebugger : BOOL;out pfCallOnScriptErrorWhenContinuing : BOOL) : HRESULT; stdcall;


    {IApplicationDebugger}
    (*
    function QueryAlive : HRESULT; stdcall;

    function CreateInstanceAtDebugger(const rclsid : TCLSID; const pUnkOuter : IUnknown;
                                      const dwClsContext : DWORD; const riid : TIID;
                                      out   ppvObject : IUnknown) : HRESULT; stdcall;

    function onDebugOutput(const pstr : PWideChar) : HRESULT; stdcall;

    function onHandleBreakPoint(const prpt : IRemoteDebugApplicationThread;
                                const br : TBREAKREASON;  const pError : IActiveScriptErrorDebug) : HRESULT; stdcall;

    function onClose : HRESULT; stdcall;

    function onDebuggerEvent(const riid : TIID; const punk : IUnknown) : HRESULT; stdcall;
    *)

  public
    ActiveScript : IActiveScript;
    constructor Create(const AScriptName : string);
    destructor Destroy; override;
    procedure AddItem(const name : string; const intf : IUnknown; flag : integer);
    property OnError : TScriptErrorHandler read fOnError write fOnError;
  end;

type
  TAxScriptRunner = class(TScriptRunner)
  private
    fscrun : TScriptRun;
//    fItems : TStringList;

    procedure SetCatID(const ACatID : TGUID);
    function  GetCatID : TGUID;
  protected
    procedure Stop;
    function  GetDefaultCatID : TGUID; virtual; abstract;
    function  GetScriptDispatch : IDispatch; override;
    procedure StopScript; override;
    procedure DoRemoveItem(const Name : string); override;
    procedure DoInterrupt; override;
  public
    function  ParseScript(const Script : string) : boolean; override;
    procedure AddItem(const Name : string; Global : boolean; const idisp : IDispatch); override;
    procedure GetVarList(S : TStrings); override;

    constructor Create(AScripter : TDCScripter; const AScriptName : string); override;
    destructor Destroy; override;

    property CatID : TGUID read GetCatID write SetCatID;
    property ScriptRun : TScriptRun read fscrun;
   end;

   TVbScriptRunner = class(TAxScriptRunner)
   protected
     function  GetDefaultCatID : TGUID; override;
   public
     procedure  GetWatchesPreffixes(var APref_Hex, APref_Str: string); override;
   end;

   TVbScriptEncodeRunner = class(TAxScriptRunner)
   protected
     function  GetDefaultCatID : TGUID; override;
   end;

   TJavaScriptRunner = class(TAxScriptRunner)
   protected
     function  GetDefaultCatID : TGUID; override;
   end;

   TJavaScriptEncodeRunner = class(TAxScriptRunner)
   protected
     function  GetDefaultCatID : TGUID; override;
   end;

   TPythonScriptRunner = class(TAxScriptRunner)
   protected
     function  GetDefaultCatID : TGUID; override;
   end;

   TPerlScriptRunner = class(TAxScriptRunner)
   protected
     function  GetDefaultCatID : TGUID; override;
   end;

   TEnableScriptRunner = class(TAxScriptRunner)
   protected
     function  GetDefaultCatID : TGUID; override;
   end;
{$ENDIF ACTIVESCRIPTING}


function GetRegisteredClassesList : TStringList;

function GetClassInfoIndex(AClass : TClass) : integer;

procedure GetRoutineNames(Scripter : TDCScripter;  S : TStrings);

function ExecScript(const ALanguage : string; AScript : TStrings; AOwner : TComponent;
            const AMethodName : string; const pArgs : array of OleVariant) : OleVariant;

{$IFDEF ACTIVESCRIPTING}
  procedure ExecuteJavaClass(const ClassFile : string);
{$ENDIF}

{$IFDEF WIN}
{$IFDEF D4}
type
  TDCScriptAction = class(TCustomAction)
  private
    fScripter : TDCScripter;
    fExecuteMethod : string;
    fUpdateMethod : string;

    function MethodAssigned(const MName : string) : boolean;
  public
    function Execute : boolean; override;
    function Update: boolean; override;
  published
    property Scripter : TDCScripter read fScripter write fScripter;
    property ExecuteMethod : string read fExecuteMethod write fExecuteMethod;
    property UpdateMethod : string read fUpdateMethod write fUpdateMethod;

    property Caption;
    property Checked;
    property Enabled;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property Visible;
  end;
{$ENDIF}
{$ENDIF}

var
  GlobalScriptErrorHandler : TScriptErrorHandler = nil;
  GlobalOnAutoCreateForm : TAutoCreateFormHandler = nil;
  GlobalOnGetFormClass : TGetFormClassProc = nil;

function IsIdentRegistered(const IdentName : string) : boolean;
function IsConstRegistered(const ConstName : string) : boolean;
function IsClassRegistered(const ClassName : string) : boolean;
function IsPropRegistered(const PropName : string) : boolean;

procedure GetRegisteredConst(const ConstName : string; var Value : Variant);

{$IFDEF ACTIVESCRIPTING}
procedure BreakRunningScript;
{$ENDIF}

type
  IDCompWrapper = interface
  ['{BA0887B2-F1D3-11D3-BBEA-0000E8DC209E}']
    procedure SetAutoRelease;
    procedure SetModuleMode;
  end;

type
  TDCompWrapper = class(TObject, IUnknown, IDispatch, IDCompWrapper)
  private
    fRefCount : integer;
    fWrappObject : TObject;
    fLastName    : string;
    fLastID      : TDispID;
    fLastRegCount : integer;
    fAutoRelease : boolean;
    fModuleMode  : boolean;


    procedure FreeNotification(Instance : TObject);
//    fNotifier : TDCLinkedComponent;
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    function GetTypeInfoCount(out Count: Integer): HRESULT; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HRESULT; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      cNames, LocaleID: Integer; DispIDs: Pointer): HRESULT; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; stdcall;

    {IDCompWrapper}
    procedure SetAutoRelease;
    procedure SetModuleMode;

    function _InvokeGet(DispID : TDispID; VarResult : POleVariant; var Params: TDispParams) : HRESULT;
    function _InvokeGet2(DispID : TDispID; VarResult : POleVariant; var Params: TDispParams) : HRESULT;
  protected
    function _Invoke(DispID: TDispID; Flags: Integer;
      var Params: TDispParams; VarResult: POleVariant; ExcepInfo: PExcepInfo;
      ArgErr: PInteger): HResult;

    function GetDelphiProperty(WrapObj : TObject; info : pointer; var Params : TDispParams;
                               VarResult : POleVariant) : HRESULT;
    function PutDelphiProperty(WrapObj : TObject; info : pointer; var Params : TDispParams) : HRESULT;
    function GetRegProperty(WrapObj : TObject; info : pointer; var Params : TDispParams;
                                   VarResult : POleVariant) : HRESULT;
    function PutRegProperty(WrapObj : TObject; info : pointer; var Params : TDispParams) : HRESULT;
    function GetConst(info : pointer; var Params : TDispParams;
                                   VarResult : POleVariant) : HRESULT;
    function PutRegVar(WrapObj : TObject; info : pointer; var Params : TDispParams) : HRESULT;
    function GetRegVar(WrapObj : TObject; info : pointer; var Params : TDispParams;
                                    VarResult : POleVariant) : HRESULT;

    procedure SetWrappObject(val : TObject);
    function  UserVarID(const VarName : string) : integer;
    procedure GetUserVar(VarID : integer; pValue : POleVariant);
    function  SetUserVar(VarID : integer; const Value : OleVariant) : HRESULT;
    function  IsUserVarID(info : pointer) : boolean;
    function  _getWrapObj : TObject;
//    procedure Notification(AComponent : TComponent; Operation : TOperation);
  public
    fIsClass  : boolean;
    ScriptRun : TScriptRunner;

    destructor Destroy; override;
    function   MethodCall(WrapObj : TObject; minfo : TMethodInfo; var Params : TDispParams; VarResult : POleVariant) : HRESULT;
    function   PutProperty(info : pointer; var Params : TDispParams) : HRESULT;
    function   GetProperty(info : pointer; var Params : TDispParams; VarResult : POleVariant) : HRESULT;

    property WrappObject : TObject read fWrappObject write SetWrappObject;
  end;

  IDCRecordWrapper = interface
  ['{7BF6F0A1-FCA0-11D3-AE7F-0000E8DC5099}']
    function GetRecordPtr: Pointer;
  end;

  TDCRecordWrapper = class(TPersistent, IUnknown, IDispatch, IDCRecordWrapper)
  private
    FDCompWrapper: TDCompWrapper;

    function QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function GetTypeInfoCount(out Count: Integer): HRESULT; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HRESULT; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      cNames, LocaleID: Integer; DispIDs: Pointer): HRESULT; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; stdcall;
    {IDCompWrapper}
  public
    constructor Create;
    destructor Destroy; override;
    function GetRecordPtr : pointer; virtual; abstract;
  end;


type
  TWrapperClass = class of TDCompWrapper;

var
  CompWrapperClass : TWrapperClass = TDCompWrapper;

function IsMethodRegistered(const MethodName : string) : boolean;
function IsVarRegistered(const VarName : string) : boolean;
function GetRegisteredConstList: TStringList;
function GetRegisteredVarList: TStringList;
function GetRegisteredPropNames: TStringList;
function GetRegisteredProcList: TStringList;
function GetRegisteredClassInfo(Index : integer):TRegisteredClassInfo;

procedure RunRunner(var Runner : TDCScripter);

function GetDWordSize(i : integer) : integer;

type
  TTypeConvertInfo = record
    _info : PTypeInfo;
    tSize : integer;
    v2p : TVarToParamProc;
    p2v : TParamToVarProc;
    v2v : TVarToVarProc;
  end;

  PTypeConvertInfo = ^TTypeConvertInfo;

function GetConvertInfo(tInfo : PTypeInfo) : PTypeConvertInfo;
function IsArrayInfo(tInfo : PTypeInfo) : boolean;
procedure TypeConvertToParamRec(tcInfo : PTypeConvertInfo; var ParamRec : TParamRec;
                                PFlags : TParamFlags; cParam : PTypeInfo; var ParamsSize : integer);

const
  DCShowWarnIfNoEventType:Boolean=True;

procedure DCUnitFinalization;

implementation

{$IFDEF THREADSAFE}
function Synchronizer:TMultiReadExclusiveWriteSynchronizer;forward;
{$ENDIF}

{$IFDEF THREADSAFE}
threadvar
{$ELSE}
var
{$ENDIF}
  CurrentModuleObject : TComponent;
  RegisterCount : integer;

type
  TEventRestorer = class(TComponent)
  private
    fList : TSortedList;
  protected
    procedure Notification (AComponent: TComponent; Operation : TOperation); override;
  public
    procedure AddHookedComponent(Instance : TComponent);
    procedure RemoveHookedComponent(Instance : TComponent);

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end;

procedure TEventRestorer.Notification (AComponent: TComponent; Operation : TOperation);
var
  i : integer;
begin
  inherited;
  if Operation = opRemove then
    with fList do
      begin
        i := IndexOf(AComponent);
        if i >= 0 then
          begin
            RestoreEventHandlers(AComponent);
            Delete(i);
          end;
      end;
end;

{------------------------------------------------------------------}

procedure TEventRestorer.AddHookedComponent(Instance : TComponent);
begin
  if fList.IndexOf(Instance) <= 0 then
    begin
      fList.Add(Instance);
      Instance.FreeNotification(self);
    end;
end;

{------------------------------------------------------------------}

procedure TEventRestorer.RemoveHookedComponent(Instance : TComponent);
begin
{$IFDEF D5}
  if fList.Remove(Instance) >= 0 then
    Instance.RemoveFreeNotification(self);
{$ELSE}
  fList.Remove(Instance)
{$ENDIF}  
end;

{------------------------------------------------------------------}

constructor TEventRestorer.Create(AOwner : TComponent);
begin
  inherited;
  fList := TSortedList.Create;
end;

{------------------------------------------------------------------}

destructor TEventRestorer.Destroy;
begin
  fList.Free;
  inherited;
end;

{******************************************************************}

var
  _EventRestorer : TEventRestorer;
  
function EventRestorer : TEventRestorer;
begin
  if _EventRestorer = nil then
    _EventRestorer := TEventRestorer.Create(nil);
  result := _EventRestorer;
end;


{******************************************************************}

destructor  TMethodInfo.Destroy;
begin
  FreeMem(ParamRecs);
  inherited;
end;

{------------------------------------------------------------------}

procedure TMethodInfo.SetParamCount(val : integer);
begin
  if val <> fParamCount then
    begin
      ReallocMem(ParamRecs, val * sizeof(TParamRec));
      if val > fParamCount then
        FillChar(ParamRecs[fParamCount], (val - fParamCount) * SizeOf(TParamRec), 0);

      fParamCount := val;
    end;
end;

{------------------------------------------------------------------}

{$IFNDEF WIN32}
function InterlockedIncrement(var I: Integer): Integer;
asm
      MOV   EDX,1
      XCHG  EAX,EDX
      LOCK XADD  [EDX],EAX
      INC   EAX
end;

function InterlockedDecrement(var I: Integer): Integer;
asm
      MOV   EDX,-1
      XCHG  EAX,EDX
 LOCK XADD  [EDX],EAX
      DEC   EAX
end;

{$ENDIF}

{_impl}

function CreateCompWrapper : TDCompWrapper;
begin
  result := CompWrapperClass.Create;
end;

{------------------------------------------------------------------}

destructor TItemInfo.Destroy;
begin
  pointer(disp) := nil;
  inherited;
end;

{******************************************************************}

{$IFDEF WIN}
{$IFDEF D4}
function TDCScriptAction.MethodAssigned(const MName : string) : boolean;
begin
  result := (Scripter <> nil) and (MName <> '');
end;

{------------------------------------------------------------------}

function TDCScriptAction.Execute : boolean;
begin
  result := MethodAssigned(ExecuteMethod);
  if result then
    Scripter.DispatchMethod(ExecuteMethod, [VarFromObject(self)])
  else
    result := inherited Execute;
end;

{------------------------------------------------------------------}

function TDCScriptAction.Update: boolean;
begin
  result := MethodAssigned(UpdateMethod) or MethodAssigned(ExecuteMethod);
  if result then
    Scripter.DispatchMethod(UpdateMethod, [VarFromObject(self)])
  else
    result := inherited Update;
end;
{$ENDIF}

{------------------------------------------------------------------}

{$IFDEF ACTIVESCRIPTING}

function CreateComObject(const ClassID: TGUID): IUnknown;
begin
  OleCheck(CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
    CLSCTX_LOCAL_SERVER, IUnknown, Result));

{  CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER or
    CLSCTX_LOCAL_SERVER, ClassID, Result);}
end;

{------------------------------------------------------------------}

type
  PJavaExecuteInfo = ^TJavaExecuteInfo;
  TJavaExecuteInfo = packed record
    cbSize       : DWORD;
    dwFlags      : DWORD;
    pszClassName : PWideChar;
    rgszArgs     : PWideChar;
    cArgs        : ULONG;
    pszClassPath : PWideChar;
  end;

const
   CLASS_SOURCE_TYPE_MODULERESOURCES = $00000001;
   CLASS_SOURCE_TYPE_ISTORAGE        = $00000002;

type
   PJavaProperty = ^TJavaProperty;
   TJavaProperty = packed record
     pszKey   : PWideChar;
     pszValue : PWideChar;
   end;

  IEnumJavaProperties = interface(IUnknown)
  ['{56E7DF80-F527-11cf-B728-FC8703C10000}']
    function Next(celt : ULONG; rgelt : PJavaProperty; var pceltFetched : ULONG) : ULONG; stdcall;
    function Skip(celt : ULONG) : HRESULT; stdcall;
    function Reset : HRESULT; stdcall;
    function Clone(out ppenum : IEnumJavaProperties) : HRESULT; stdcall;
  end;

  IJavaExecute = interface(IUnknown)
  ['{3EFB1800-C2A1-11cf-960C-0080C7C2BA87}']
    function GetDefaultClassPath(const ClassPath : WideString) : HRESULT; stdcall;
    function Execute(ExecuteInfo : PJavaExecuteInfo; errorinfo : pointer) : HRESULT; stdcall; // errorinfo points to a buffer that receives an IErrorInfo
  end;

  IJavaExecute2 = interface(IJavaExecute)
  ['{D7658820-01DD-11d0-9746-00AA00342BD8}']
    function SetSystemProperties(penum : IEnumJavaProperties) : HRESULT; stdcall;
    function SetClassSource(SourceType : DWORD; Data : pointer; DataSize : DWORD) : HRESULT; stdcall;
  end;

procedure ExecuteJavaClass(const ClassFile : string);
var
  iunk     : IUnknown;
  ijexec   : IJavaExecute2;
  execinfo : TJavaExecuteInfo;
begin
  iunk := CreateComObject(IJavaExecute);
  if iunk = nil then
    exit;

  if iunk.QueryInterface(IJavaExecute2, ijexec) <> S_OK then
    exit;

  FillChar(execinfo, sizeof(execinfo), 0);
  with execinfo do
    begin
      execinfo.cbSize := sizeof(execinfo);
      execinfo.pszClassPath := DCStringToOleSt(ExtractFileDir(ClassFile));
      execinfo.pszClassName := DCStringToOleSt(ExtractOnlyName(ClassFile));
      try
        ijexec.Execute(@execinfo, nil);
      finally
        SysFreeString(execinfo.pszClassPath);
        SysFreeString(execinfo.pszClassName);
      end;
    end;
end;

{$ENDIF ACTIVESCRIPTING}
{$ENDIF WIN}

type
  PInt = ^integer;

var
 fLoadedScripts : TSortedList;

procedure _restoreoldevent(Instance : TPersistent; PropInfo : PPropInfo; Permanent : boolean); forward;
procedure RestoreMyEventHandlers(Instance : TPersistent; EventHandler : TEventHandler); forward;

{------------------------------------------------------------------}

procedure SetEventPermanent(event : pointer);
var
  pi : PInt;
begin
  if event <> nil then
    begin
      pi := PInt(integer(Event) - sizeof(integer) * 3);
      pi^ := 1;
    end;
end;

{------------------------------------------------------------------}

function IsEventPermanent(event : pointer) : boolean;
var
  pi : PInt;
begin
  result := event <> nil;
  if result then
    begin
      pi := PInt(integer(Event) - sizeof(integer) * 3);
      result := pi^ <> 0;
    end;
end;

{------------------------------------------------------------------}

function ExecScript(const ALanguage : string; AScript : TStrings; AOwner : TComponent;
            const AMethodName : string; const pArgs : array of OleVariant) : OleVariant;
begin
  with TDCScripter.Create(AOwner) do
    try
      Language := ALanguage;
      Script := AScript;
//      Module := AOwner;
      DispatchMethod(AMethodName, pArgs);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

var
  CallDynaInstAddr : pointer;
  ClassCreateAddr  : pointer;

const GlobalScriptObject = 'vcl'; //don't resource
      GlobalScriptRunObject = '@@@'; //don't resource

const
  ArrayInfoBase = 1000;
  MaxArrayInfo = ArrayInfoBase + 32000;
  DynArrayInfoBase = MaxArrayInfo + 1;
  MaxDynArrayInfo = DynArrayInfoBase + 32000;

var
  ArrayInfos : TList;
  DynArrayInfos : TList;

{-----------------------------------------------------------}

function IsArrayInfo(tInfo : PTypeInfo) : boolean;
begin
  case integer(tInfo) of
    ArrayInfoBase .. MaxArrayInfo - 1 : result := true;
  else
    result := false;
  end;
//  result := (integer(tInfo) >= ArrayInfoBase) and (integer(tInfo) < MaxArrayInfo);
end;

{-----------------------------------------------------------}

{$IFDEF D4}
function IsDynArrayInfo(tInfo : PTypeInfo) : boolean;
begin
  case integer(tInfo) of
    DynArrayInfoBase .. MaxDynArrayInfo - 1 : result := true;
  else
    result := false;
  end;
//  result := (integer(tInfo) >= DynArrayInfoBase) and (integer(tInfo) < MaxDynArrayInfo);
end;
{$ENDIF}
{-----------------------------------------------------------}

function ArrayInfo(TInfo : PTypeInfo) : PTypeInfo;
begin
  result := PTypeInfo(ArrayInfoBase + ArrayInfos.Add(TInfo));
end;

{-----------------------------------------------------------}

{$IFDEF D4}
function  DynArrayInfo(TInfo : PTypeInfo) : PTypeInfo;
begin
  result := PTypeInfo(DynArrayInfoBase + DynArrayInfos.Add(TInfo));
end;
{$ENDIF}

{-----------------------------------------------------------}

type
  __DC__TInSet = function (elem : integer; aset : integer) : boolean of object;
  __DC__T_Set  = function (cArgs : integer; pArgs : PArgList) : OleVariant of object;
  __DC__T_Chr  = function (x : byte) : string of object;

{-----------------------------------------------------------}

function  _Chr(x : byte) : string;
begin
  result := Chr(x);
end;

{-----------------------------------------------------------}

function InSet(elem : integer; aset : integer) : boolean;
begin
  result := (elem < 32) and (aset and (1 shl elem) <> 0);
end;

{-----------------------------------------------------------}

const
  dispparamsNoArgs : TDispParams = (rgvarg:nil; rgdispidNamedArgs:nil; cArgs:0; cNamedArgs:0);

function GetOpenArray(const v : OleVariant) : OleVariant;
{$IFDEF ACTIVESCRIPTING}
var
  disp    : IDispatch;
  iti     : ITypeInfo;
  attr    : PTypeAttr;
  rr      : OleVariant;
  pvar    : PVarDesc;
  i       : integer;
begin
  if TVarData(v).vType <> varDispatch then
    begin
      VarClear(result);
      exit;
    end;

  disp := IDispatch(VarToInterface(v));
  disp.GetTypeInfo(0, 0, iti);
  iti.GetTypeAttr(attr);
  result := VarArrayCreate([0, attr.cVars - 1], varVariant);
  for i := 0 to attr.cVars - 1 do
    begin
      iti.GetVarDesc(i, pvar);
      disp.Invoke(pvar^.memid, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @rr, nil, nil);
      result[i] := rr;
    end;
{$ELSE}
begin
  VarClear(result);
{$ENDIF}
end;

{-----------------------------------------------------------}

function GetRefVariant(v : POleVariant) : POleVariant;
begin
  with TVarData(v^) do
    if (vType = VarByRef or VarVariant) then
      result := GetRefVariant(POleVariant(VPointer))
    else
      result := v;
end;

{-----------------------------------------------------------}

function _Set(cArgs : integer; pArgs : PArgList) : OleVariant;
var
  i       : integer;
  res     : integer;
begin
  res := 0;
  for i := 0 to cArgs - 1 do
    res := res or (1 shl GetRefVariant(@(OleVariant(pargs^[i])))^);

  result := res;
end;

{-----------------------------------------------------------}

var
{$IFDEF THREADSAFE}
  FSynchronizer : TMultiReadExclusiveWriteSynchronizer;
{$ENDIF}
  AssignedEventsList : TSortedList;
  fLoadedModules : TSortedList;
  GlobalWrapList : TList;
  ModuleWrappersList : TList;

{***********************************************************}

{$IFDEF THREADSAFE}

procedure BeginSyncWrite;
begin
  if Synchronizer <> nil then
    Synchronizer.BeginWrite;
end;

{-----------------------------------------------------------}

procedure EndSyncWrite;
begin
  if Synchronizer <> nil then
    Synchronizer.EndWrite;
end;

{$ENDIF THREADSAFE}

{***********************************************************}

constructor TScriptRunner.Create(AScripter : TDCScripter; const AScriptName : string);
begin
  inherited Create;
  fScripter := AScripter;
  fScriptName := AScriptName;
  FNamedItems := CreateSortedStringList;
  FGlobalItems := TStringList.Create;
end;

{-----------------------------------------------------------}

destructor TScriptRunner.Destroy;
begin
  ClearNamedItems;
  FNamedItems.Free;
  FGlobalItems.Free;
  inherited;
end;

{-----------------------------------------------------------}

procedure  TScriptRunner.GetWatchesPreffixes(var APref_Hex, APref_Str: string);
begin
  APref_Hex := '0x';
  APref_Str := '"';
end;

{-----------------------------------------------------------}

function   TScriptRunner.CurrentExecutionLine : integer;
begin
  result := -1;
end;

{-----------------------------------------------------------}

procedure  TScriptRunner.TraceInto;
begin

end;

{-----------------------------------------------------------}

procedure  TScriptRunner.StepOver;
begin

end;

{-----------------------------------------------------------}

procedure TScriptRunner.DoInterrupt;
begin

end;

{-----------------------------------------------------------}

procedure TScriptRunner.FreeRunner;
begin
  Free;
end;

{-----------------------------------------------------------}

procedure   TScriptRunner.SaveToStream(S : TStream);
begin
  Error(SErrNotImplemented);
end;

{-----------------------------------------------------------}

procedure   TScriptRunner.LoadFromStream(S : TStream);
begin
  Error(SErrNotImplemented);
end;

{-----------------------------------------------------------}

procedure TScriptRunner.ClearNamedItems;
var
  p : pointer;
  i : integer;
begin
  with fNamedItems do
    for i := 0 to Count - 1 do
      begin
        p := Objects[i];
        if p <> nil then
          IDispatch(p)._Release;
      end;
end;

{-----------------------------------------------------------}

procedure TScriptRunner.DoneGlobals;
begin
  ClearNamedItems;
  fNamedItems.Clear;
  fGlobalItems.Clear;
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
    if GlobalWrapList <> nil then
      GlobalWrapList.Remove(fGlobalWrapper);
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

procedure TScriptRunner.DoRemoveItem(const Name : string);
var
  i : integer;
begin
  i := NamedItems.IndexOf(Name);
  if i >= 0 then
    IDispatch(pointer(NamedItems.Objects[i]))._Release;
end;

{-----------------------------------------------------------}

procedure TScriptRunner.RemoveItem(const Name : string);
begin
  DoRemoveItem(Name);
  RemoveFromStrings(fGlobalItems, Name);
  RemoveFromStrings(NamedItems, Name);
end;

{-----------------------------------------------------------}

procedure TScriptRunner.AddItem(const Name : string; Global : boolean; const idisp : IDispatch);
begin
  if iDisp = nil then
    exit;
  if Global then
    fGlobalItems.AddObject(Name, Pointer(IDisp));
  fNamedItems.AddObject(Name, Pointer(IDisp));
  iDisp._AddRef;
end;

{-----------------------------------------------------------}

function  TScriptRunner.GetScriptDispatch : IDispatch;
begin
  result := nil;
end;

{-----------------------------------------------------------}

procedure TScriptRunner.ScriptError(Sender : TObject; const ExcepInfo : TExcepInfo;
                                  CharNo, LineNo : integer;var Handled : boolean);
begin
  fErrLine := LineNo;
  fErrChar := CharNo;
  fErrMsg  := ExcepInfo.bstrDescription; 

  if Assigned(OnError) then
    OnError(self, ExcepInfo, CharNo, LineNo, handled);
end;

{-----------------------------------------------------------}

function TScriptRunner.GetModuleAlias : string;
begin
  result := '';
end;

{-----------------------------------------------------------}

function TScriptRunner.GetIDByName(const Name : string) : TDispID;
var
  sDispatch : IDispatch;
  wname     : PWideChar;
begin
  sDispatch := ScriptDispatch;

  result := -1;

  if sDispatch = nil then
    exit;

  wname := DCStringToOleSt(Name);
  try
    sDispatch.getIDsOfNames(GUID_NULL, @wName, 1, 0, @result);
  finally
    {$IFDEF WIN32}
    SysFreeString(wname);
    {$ENDIF}
  end;
end;

{-----------------------------------------------------------}

procedure TScriptRunner.SetVarValue(const VarName : string; const Value : OleVariant);
var
  id        : TDispID;
  sDispatch : IDispatch;
begin
  id := GetIDByName(VarName);
  if id <> -1 then
    begin
      sDispatch := ScriptDispatch;

      if sDispatch = nil then
        exit;

      SetPropByDispatch(sDispatch, id, Value);
    end;
end;

{-----------------------------------------------------------}

function  TScriptRunner.GetVarValue(const VarName : string) : OleVariant;
var
  id : TDispID;
  sdispatch : IDispatch;
begin
  id := GetIDByName(VarName);
  if id <> -1 then
    begin
      sDispatch := ScriptDispatch;

      if sDispatch = nil then
        exit;

      sdispatch.Invoke(id, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @result, nil, nil);
    end;
end;

{-----------------------------------------------------------}

function TScriptRunner.DispatchMethod(MethodName : pchar; cArgs : integer; pArgs : PArgList) : Variant;
var
  Disp       : Integer;
  DispParams : TDispParams;
  Ei         : TExcepInfo;
  InvKind    : Integer;
  sDispatch  : IDispatch;
begin
  VarClear(result);// := UnAssigned;

  if MethodName = 'OrdersSourceStateChange' then
    asm nop end;
  disp := GetIDByName(StrPas(MethodName));
  if disp <> -1 then
    begin
      {$IFDEF THREADSAFE}
      InterlockedIncrement(fRunCount);
      {$ELSE}
      inc(fRunCount);
      {$ENDIF}
      try
        sDispatch := ScriptDispatch;
        FillChar(DispParams, sizeof(DispParams), 0);
        InvKind := DISPATCH_METHOD;

        DispParams.rgvarg := PVariantArgList(pArgs);
        DispParams.cArgs := cArgs;

        sDispatch.Invoke(Disp, GUID_NULL, 0, InvKind, DispParams, @result, @ei, nil);
      finally
        {$IFDEF THREADSAFE}
        InterlockedDecrement(fRunCount);
        {$ELSE}
        dec(fRunCount);
        {$ENDIF}
      end;
    end;
end;

{-----------------------------------------------------------}

procedure TScriptRunner.StopScript;
begin
end;

{***********************************************************}

function VarFromInterface(const Disp : IDispatch): Variant;
begin
  result := Disp;
end;

{-----------------------------------------------------------}

function VarToInterface(const V: Variant): IDispatch;
var
  vv : POleVariant;
begin
  vv := GetRefVariant(POleVariant(@v)); // avoid OleVarFromVar call

  if TVarData(vv^).VType = varDispatch then
    result := IDispatch(vv^)
  else if TVarData(vv^).VType = (varDispatch or varByRef) then
    pointer(Result) := Pointer(TVarData(vv^).VPointer^);
end;

{-----------------------------------------------------------}

function DCVarToInterface(const V: Variant): IDispatch;
begin
  result := VarToInterface(V);
end;

{-----------------------------------------------------------}

function  VarToPointer(const v : OleVariant) : pointer;
var
  vt : integer;
begin
  result := nil;
  vt := TVarData(v).vType and varTypeMask;
  if vt = varDispatch then
    result := Disp2Object(IDispatch(VarToInterface(v)))
  else if vt <> varNull then
    result := pointer(integer(v));
end;

{-----------------------------------------------------------}

function VarToChar(const v : OleVariant) : char;
var
  s : string;
begin
  s := v;
  result := #0;
  if length(s) > 0 then
    result := s[1];
end;

{-----------------------------------------------------------}

function VarToObject(const v : OleVariant) : TObject;
begin
  result := nil;
  if TVarData(v).vType <> varNull then
    result := Disp2Object(IDispatch(VarToInterface(v)));
end;

{-----------------------------------------------------------}

function VarFromSet(const s; size : integer) : integer;
begin
  case size of
    1 : result := byte(s);
    2 : result := word(s);
    else
      result := integer(s);
  end;
end;

{-----------------------------------------------------------}

procedure VarToSet(var s; size : integer; const v : OleVariant);
var
  i : integer;
begin
  i := v;
  case size of
    1 : byte(s) := i;
    2 : word(s) := i;
  else
    integer(s) := i;
  end;
end;

{-----------------------------------------------------------}

{$IFNDEF CLX}
function IsEventSignaled(Handle : THandle) : boolean;
begin
  result := WaitForSingleObject(integer(Handle), 0) <> WAIT_TIMEOUT;
end;
{$ENDIF}

{-----------------------------------------------------------}

function IsModuleLoaded(Handle : THandle) : boolean;
var
  i : integer;
begin
  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
  {$ENDIF}
    result := fLoadedModules.Find(pointer(Handle), i);
  {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

function IsModuleRunning(Handle : THandle) : boolean;
begin
  result := {$IFNDEF CLX}(WaitForSingleObject(integer(Handle), 0) = WAIT_TIMEOUT) or{$ENDIF}
            ((Handle <> 0) and IsModuleLoaded(Handle));
end;

{-----------------------------------------------------------}

procedure ResetRunningModule(Handle : THandle);
begin
  if IsModuleRunning(Handle) then
    if IsModuleLoaded(Handle) then
      TDCScripter(Handle).Free
    {$IFNDEF CLX}
    else
      TerminateProcess(Handle, 0);
    {$ENDIF}  
end;

{-----------------------------------------------------------}

procedure RunRunner(var Runner : TDCScripter);
begin
  with Runner do
    begin
      fHookAllEvents := true;
      Run;
      if RunFailed then
        begin
          Free;
          Runner := nil;
          exit;
        end;

      {$IFDEF WIN}
      if not Runner.ModalRun and (GetModule is TCustomForm) then
        with TCustomForm(GetModule) do
          Show;

      HookClose;
      {$ENDIF}
{
      if GetModule = nil then
        Free;
}
    end;
end;

{-----------------------------------------------------------}

function _RunUnit(const FileName : string; IsModal : boolean) : THandle;
begin
  result := THandle(TDCScripter.Create(nil));
  with TDCScripter(result) do
    try
      fModalRun := IsModal;
      fProject := result;
      ScriptFile := FileName;
      RunRunner(TDCScripter(result));
    except
      Free;
      raise;
    end;
end;

{-----------------------------------------------------------}

function RunUnit(const FileName : string) : THandle;
begin
  result := _RunUnit(FileName, false);
end;

{-----------------------------------------------------------}

function  RunUnitModal(const FileName : string) : THandle;
begin
  result := _RunUnit(FileName, true);
end;

{-----------------------------------------------------------}

function  UNIRunUnit(const FileName, ALanguage : string; const AFilerId : TFilerID; IsModal : boolean): THandle;
begin
  result := THandle(TDCScripter.Create(nil));
  with TDCScripter(result) do
    try
      fModalRun := IsModal;
      fProject := result;
      ScriptFile := FileName;
      Language := ALanguage;
      FilerID := AFilerID;
      RunRunner(TDCScripter(result));
    except
      Free;
      raise;
    end;
end;

{-----------------------------------------------------------}

{$IFDEF WIN}
function UniRunObjectList(list : TIDEObjectList; IsModal : boolean) : THandle;
var
  runindex : integer;
  i        : integer;
  Hooked   : boolean;
begin
  runindex := -1;

  for i := 0 to list.Count - 1 do
    if FileCanBeExecuted(list[i].FileName) then
      begin
        runindex := i;
        break;
      end;

  if runindex < 0 then
    dcdreamLib.Error(SErrNoRunnableObjects);

  result := THandle(TDCScripter.Create(nil));
  with TDCScripter(result) do
    try
      ScriptFile := list[runindex].FileName;
      FilerID := list[runindex].FilerID;
      fObjectList.Assign(list);
      fProject := result;
      fModalRun := IsModal;

      Hooked := SetFindGlobalCompProc(TDCScripter(result).GlobalFindCompInTheSameModule);
      try
        RunRunner(TDCScripter(result));
      finally
        if Hooked then
          RemoveFindGlobalCompProc;
      end;
    except
      Free;
      raise;
    end;
end;

{-----------------------------------------------------------}

function RunObjectList(list : TIDEObjectList) : THandle;
begin
  result := UniRunObjectList(list, false);
end;

{-----------------------------------------------------------}

function RunObjectListModal(list : TIDEObjectList) : THandle;
begin
  result := UniRunObjectList(list, true);
end;
{$ENDIF}
{-----------------------------------------------------------}

type
  StrRec = record
    allocSiz : Longint;
    refCnt   : Longint;
    length   : Longint;
  end;

const
  RealStringSize = sizeof(AnsiString) + sizeof(StrRec);

type
  TPointerArray = array[0..1] of pointer;
  PPointerArray = ^TPointerArray;


function MakeCode(Instance : TPersistent; const EventName : string;
                  MethodInfo : TMethodInfo; const M : TMethod;
                  EventHandler : TEventHandler; CallInherited : boolean) : pointer; forward;

{-----------------------------------------------------------}

procedure SByteToVar(var p; var v : OleVariant);
begin
  v := ShortInt(p);
end;

{-----------------------------------------------------------}

procedure BoolToVar (var p; var v : OleVariant);
begin
  v := boolean(p);
end;

{-----------------------------------------------------------}

procedure UByteToVar(var p; var v : OleVariant);
begin
  v := Byte(p);
end;

{-----------------------------------------------------------}

procedure SWordToVar(var p; var v : OleVariant);
begin
  v := SmallInt(p)
end;

{-----------------------------------------------------------}

procedure UWordToVar(var p; var v : OleVariant);
begin
  v := Word(p);
end;

{-----------------------------------------------------------}

procedure SLongToVar(var p; var v : OleVariant);
begin
  v := integer(p);
end;

{-----------------------------------------------------------}

procedure RealToVar(var p; var v : OleVariant);
var
  r : real;
begin
  r := double(p);
  v := r;
end;

{-----------------------------------------------------------}

procedure SingleToVar(var p; var v : OleVariant);
begin
  v := single(p);
end;

{-----------------------------------------------------------}

procedure DoubleToVar(var p; var v : OleVariant);
begin
  v := double(p);
end;

{-----------------------------------------------------------}

procedure ExtendedToVar(var p; var v : OleVariant);
begin
  v := extended(p);
end;

{-----------------------------------------------------------}

procedure CompToVar(var p; var v : OleVariant);
begin
  v := comp(p);
end;

{-----------------------------------------------------------}

procedure CurrToVar(var p; var v : OleVariant);
begin
  v := currency(p);
end;

{-----------------------------------------------------------}

procedure ShortStringToVar(var p; var v : OleVariant);
begin
  v := ShortString(p);
end;

{-----------------------------------------------------------}

procedure VariantFromObj(pVar : POleVariant; Obj : TObject);
{$IFDEF THREADSAFE}
var
  idisp : IDispatch;
begin
  Synchronizer.BeginRead;
  try
    idisp := GetObjectDispatch(Obj, nil);
    PVariant(pVar)^ := idisp;
    idisp := nil;
  finally
    Synchronizer.EndRead;
  end;
{$ELSE}
begin
  PVariant(pVar)^ := GetObjectDispatch(Obj, nil);
{$ENDIF}
end;

{-----------------------------------------------------------}

procedure ClassToVar(var p; var v : OleVariant);
begin
  if TObject(p) = nil then
    v := NULL
  else
    VariantFromObj(@v, TObject(p))
//  VarFromInterface(GetObjectDispatch(TObject(p), nil));
end;

{-----------------------------------------------------------}

procedure InterfaceToVar(var p; var v : OleVariant);
begin
  v := VarFromInterface(IDispatch(p));
  if IDispatch(p) <> nil then
    IDispatch(p)._Release;  
end;

{-----------------------------------------------------------}

function GetExistingWrapper(Instance : TObject; IsModule : boolean) : TDCompWrapper;
var
  i : integer;
  wlist : TList;
begin
  result := nil;
  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
  {$ENDIF}
    if IsModule then
      wlist := ModuleWrappersList
    else
      wlist := GlobalWrapList;

    if wlist <> nil then
      for i := 0 to wlist.Count - 1 do
        if TDCompWrapper(wlist[i]).WrappObject = Instance then
          begin
            result := TDCompWrapper(wlist[i]);
            exit;
          end;
  {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

function IsWrappedObject(Instance : TObject; var Wrapper : IDispatch) : boolean;
var
  cwrapper : TDCompWrapper;
begin
  cwrapper := GetExistingWrapper(Instance, false);
  if cwrapper = nil then
    cwrapper := GetExistingWrapper(Instance, true);

  Wrapper := cwrapper;
  result := cwrapper <> nil;
end;

{-----------------------------------------------------------}

procedure PointerToVar(var p; var v : OleVariant);
var
  iDisp : IDispatch;
  ip    : integer;
begin
  ip := integer(p);
  if IsWrappedObject(TObject(ip), iDisp) then
    v := iDisp
  else
    v := ip;
end;

{-----------------------------------------------------------}

function  PointerToVariant(p : pointer) : OleVariant;
begin
  PointerToVar(p, result);
end;

{-----------------------------------------------------------}

procedure PCharToVar(var p; var v : OleVariant);
var
  s : string;
begin
  if PChar(p) = nil then
    s := ''
  else
    s := PChar(p);

  v := s;
end;

{-----------------------------------------------------------}

procedure PWCharToVar(var p; var v : OleVariant);
var
  s : string;
begin
  if PWideChar(p) = nil then
    s := ''
  else
    s := PWideChar(p);

  v := s;
end;

{-----------------------------------------------------------}

procedure MethodToVar(var p; var v : OleVariant);
begin
//  v :=
end;

{-----------------------------------------------------------}
(*
procedure VarFromString(const s : string; var v : OleVariant);
begin
  v := s
end;
*)
{-----------------------------------------------------------}

procedure VarFromString2(var s : string; var v : OleVariant; Flags : TParamFlags);
begin
  v := s;
  if not (pfConst in Flags) then
    s := '';
end;

{-----------------------------------------------------------}

procedure LStringToVar(var p; var v : OleVariant);
begin
  asm
{    test ecx, pfConst + 1
    je   @@l1
    call VarFromString
    jmp  @@quit}
@@l1:
    call VarFromString2
@@quit:
  end;  // v := AnsiString(p);
end;

{-----------------------------------------------------------}

procedure WStringToVar(var p; var v : OleVariant);
begin
  v := WideString(p);
end;

{-----------------------------------------------------------}

procedure VarToVar(var p; var v : OleVariant);
begin
  v := Variant(p);
end;

{-----------------------------------------------------------}

procedure VToInt (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  PInt(p)^ := CorrectBool(v);
end;

{-----------------------------------------------------------}
{$IFDEF D5}
procedure VToLongWord (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  if TVarData(v).vType in [VT_BSTR, VT_LPSTR, VT_LPWSTR] then
    Cardinal(PInt(p)^) := StrToInt64(v)
  else
    VToInt(v, p, _info);
end;
{$ENDIF}
{-----------------------------------------------------------}

procedure VToUntyped (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin

end;

{-----------------------------------------------------------}

type
  PPointer = ^pointer;

procedure VToPointer (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  PPointer(p)^ := VarToPointer(v);
end;

{-----------------------------------------------------------}

procedure VToPChar (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  if (TVarData(v).vType = varInteger) and (TVarData(v).VInteger = 0) then
    PPointer(p)^ := nil
  else
    PPointer(p)^ := StrNew(PChar(string(v)));
end;

{-----------------------------------------------------------}

procedure VToPWChar (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  if (TVarData(v).vType = varInteger) and (TVarData(v).VInteger = 0) then
    PPointer(p)^ := nil
  else
    PPointer(p)^ := DCStringToOleSt(string(v));
end;

{-----------------------------------------------------------}

type
  TVarRecArray = array [0 .. 1] of TVarRec;
  PVarRecArray = ^TVarRecArray;
  TVariantArray = array [0 .. 1] of OleVariant;
  PVariantArray = ^TVariantArray;

{-----------------------------------------------------------}

procedure VariantToVarRec(const v : OleVariant; var VarRec : TVarRec);
var
  s : string;
begin
  with VarRec do
    case TVarData(v).vType of
//    varNull     = $0001;
      varSmallint : begin
                      vType := vtInteger;
                      vInteger := TVarData(v).vSmallInt;
                    end;
      varInteger  : begin
                      vType := vtInteger;
                      vInteger := TVarData(v).vInteger;
                    end;
      varSingle   : begin
                      vType := vtExtended;
                      GetMem(vExtended, sizeof(Extended));
                      VExtended^ := TVarData(v).vSingle;
                    end;
      varDouble   : begin
                      vType := vtExtended;
                      GetMem(vExtended, sizeof(Extended));
                      VExtended^ := TVarData(v).vDouble;
                    end;
      varCurrency : begin
                      vType := vtCurrency;
                      GetMem(vCurrency, sizeof(Currency));
                      VCurrency^ := TVarData(v).vCurrency;
                    end;
//      varDate
      varOleStr   : begin
                      vType := vtAnsiString;
                      s := VarToStr(v);
                      vAnsiString := pointer(s);//StrNew(PChar());
                      pointer(s) := nil;

                      //WideCharToString(TVarData(v).vOleStr))));
                    end;
      varDispatch : begin
                      vType := vtObject;
                      vObject := VarToObject(v);
                    end;
//      varError
//      varBoolean
//      varVariant
//      varUnknown
//      varString
    end;
end;
{
vtInteger    = 0;
vtBoolean    = 1;
vtChar       = 2;
vtExtended   = 3;
vtString     = 4;
vtPointer    = 5;
vtPChar      = 6;
vtObject     = 7;
vtClass      = 8;
vtWideChar   = 9;
vtPWideChar  = 10;
vtAnsiString = 11;
vtCurrency   = 12;
vtVariant    = 13;
}
{-----------------------------------------------------------}

procedure VarToArray(const v : OleVariant; p : Pointer; _info : PTypeInfo);
var
  pVars        : PVarRecArray;
  i            : integer;
  ppp          : PPointer;
  Dim          : integer;
begin
  if TVarData(v).VArray <> nil then
    with TVarData(v).VArray^ do
      begin
        Dim := Bounds[0].ElementCount;
        GetMem(pVars, sizeof(TVarRec) * Dim);
        for i := 0 to Dim - 1 do
          VariantToVarRec(v[i], pvars^[i]);

        ppp := PPointer(p);
        ppp^ := pVars;
        inc(PChar(ppp), 4);
        PInt(ppp)^ := Dim - 1;
      end
  else
    Error(SErrTypeMismatch);
end;

{-----------------------------------------------------------}

function GetArray(const v : OleVariant) : OleVariant;
begin
  if (TVarData(v).vType and varByRef) <> 0 then
    result := POleVariant(TVarData(v).vPointer)^
  else
    result := v;

  if (TVarData(result).vType and varArray) = 0 then
    result := GetOpenArray(result);
end;

{-----------------------------------------------------------}

procedure VToArray (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  VarToArray(GetArray(v), p, nil);
end;

{-----------------------------------------------------------}

procedure VarToTypedArray(const v : OleVariant; p : Pointer; _info : PTypeInfo);
var
  pVars        : PChar;
  i            : integer;
  ppp          : PPointer;
  cinfo        : PTypeConvertInfo;
  dsize        : integer;
begin
  cinfo := GetConvertInfo(_info);
  if TVarData(v).VArray <> nil then
    with TVarData(v).VArray^ do
      begin
        dsize := cinfo.tSize;
        GetMem0(pVars, dsize * Bounds[0].ElementCount);
        for i := 0 to Bounds[0].ElementCount - 1 do
          cinfo.V2P(v[i], pVars + i * dsize, nil);

        ppp := PPointer(p);
        ppp^ := pVars;
        inc(PChar(ppp), 4);
        PInt(ppp)^ := Bounds[0].ElementCount - 1;
      end
  else
    Error(SErrTypeMismatch);
end;

{-----------------------------------------------------------}

procedure VToTypedArray (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  VarToTypedArray(GetArray(v), p, _info);
end;

{-----------------------------------------------------------}

{$IFDEF D4}

procedure VToDynamicArray (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  DynArrayFromVariant(PPointer(p)^, v, _info);
end;

{$ENDIF}
{-----------------------------------------------------------}

type
  PIDispatch = ^IDispatch;

procedure FreeInterface(p : PParamInfo);
var
  pidisp : PIDispatch;
begin
  pidisp := PIDispatch(@(p.val));
  if pidisp^ <> nil then
    pidisp^._Release;
end;

{-----------------------------------------------------------}

procedure FreeString(p : PParamInfo);
begin
  with p^ do
    PString(pchar(@val) + sizeof(StrRec))^ := '';
end;

{-----------------------------------------------------------}

type
  PPChar = ^PChar;

procedure FreePChar(p : PParamInfo);
begin
  if ppchar(@p.val)^ <> nil then
    StrDispose(ppchar(@p.val)^);
end;

{-----------------------------------------------------------}

type
  PPWideChar = ^PWideChar;

procedure FreePWideChar(p : PParamInfo);
begin
  if PPWideChar(@p.val)^ <> nil then
    SysFreeString(PPWideChar(@p.val)^);
end;

{-----------------------------------------------------------}
{$IFDEF D4}
procedure FreeDynArray(p : PParamInfo);
begin
  ;
end;
{$ENDIF}
{-----------------------------------------------------------}

procedure FreeArray(p : PParamInfo);
var
  ppp : PPointer;
begin
  ppp := PPointer(@(p^.val));
  FreeMem(ppp^);
end;

{-----------------------------------------------------------}

procedure FreeArrayOfConst(p : PParamInfo);
var
  pVars : PVarRecArray;
  i     : integer;
  ppp   : PPointer;
  count : integer;
  s     : string;
begin
  ppp := PPointer(@(p^.val));
  pVars := ppp^;
  inc(PChar(ppp), 4);
  count := PInt(ppp)^;
  for i := 0 to count do
    with pVars^[i] do
      case vType of
        vtExtended   : FreeMem(VExtended);
        vtString     : FreeMem(VString);
        vtAnsiString : begin
                         pointer(s) := VAnsiString;
                         s := '';
                       end;
      end;
  FreeMem(pVars);
end;

{-----------------------------------------------------------}

type
  PShortInt = ^shortint;

procedure VToShortInt (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  PShortInt(p)^ := v;
end;

{-----------------------------------------------------------}

type
  PSmallInt = ^smallint;

procedure VToSmallInt (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  PSmallInt(p)^ := CorrectBool(v);
end;

{-----------------------------------------------------------}

type
  PByte = ^byte;

procedure VToByte (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  if TVarData(v).vType = varOleStr then
    PChar(p)^ := char(TVarData(v).vOleStr^)
  else
    PByte(p)^ := CorrectBool(v);
end;

{-----------------------------------------------------------}

type
  PWord = ^word;

procedure VToWord (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  PWord(p)^ := CorrectBool(v);
end;

{-----------------------------------------------------------}

type
  PSingle = ^single;

procedure VToSingle (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  PSingle(p)^ := v;
end;

{-----------------------------------------------------------}

type
  TIntArray = array[0..1] of integer;
  PIntArray = ^TIntArray;

procedure CopyParameter(Source, Dest : pointer; Count : integer; p : pointer); // Count + 1 DWORDS are moved
var
  i : integer;
begin
  if PParamInfo(integer(p) - ValOffset).InRegister = 2 then
    move(Source^, Dest^, (Count + 1) * 4)
  else
    for i := 0 to Count do
      PIntArray(Dest)[i] := PIntArray(Source)[Count - i];
end;

{-----------------------------------------------------------}

procedure VToDouble (const v : OleVariant; p : Pointer; _info : PTypeInfo);
var
  d  : double;
begin
  d := v;
  CopyParameter(@d, p, 1, p);
end;

{-----------------------------------------------------------}

procedure VToExtended (const v : OleVariant; p : Pointer; _info : PTypeInfo);
var
  e  : extended;
begin
  e := v;
  CopyParameter(@e, p, 2, p);
end;

{-----------------------------------------------------------}

procedure VToComp (const v : OleVariant; p : Pointer; _info : PTypeInfo);
var
  c  : comp;
begin
  c := v;
  CopyParameter(@c, p, 1, p);
end;

{-----------------------------------------------------------}

procedure VToCurrency (const v : OleVariant; p : Pointer; _info : PTypeInfo);
var
  c  : currency;
begin
  c := v;
  CopyParameter(@c, p, 1, p);
end;

{-----------------------------------------------------------}

procedure VToReal (const v : OleVariant; p : Pointer; _info : PTypeInfo);
var
  r  : real;
begin
  r := v;
  CopyParameter(@r, p, 1, p);
end;

{-----------------------------------------------------------}

procedure VToShortString (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  PShortString(p)^ := v;
end;

{-----------------------------------------------------------}

type
  PObject = ^TObject;

procedure VToClass (const v : OleVariant; p : Pointer; _info : PTypeInfo); // v contains IDispatch
begin
  PObject(p)^ := VarToObject(v)
end;

{-----------------------------------------------------------}

procedure VToInterface(const v : OleVariant; p : Pointer; _info : PTypeInfo); // v contains IDispatch
begin
  PIDispatch(p)^ := VarToInterface(v);
//!!!!  PObject(p)^ := VarToObject(v)
end;

{-----------------------------------------------------------}

procedure VToString (const v : OleVariant; p : Pointer; _info : PTypeInfo);
var
  s : string;
  pinfo : PParamInfo;
begin
  s := v;
  pinfo := PParamInfo(PChar(p) - valoffset);
  with pinfo^ do
    begin
      skip := sizeof(StrRec);
      size := 4;
      FillChar(val, RealStringSize, 0);
      PString(pchar(@val) + sizeof(StrRec))^ := s;
   end;
end;

{-----------------------------------------------------------}

procedure VToWideString (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  PWideString(p)^ := v;
end;

{-----------------------------------------------------------}

procedure VToV (const v : OleVariant; p : Pointer; _info : PTypeInfo);
begin
  PVariant(p)^ := v;
end;

{-----------------------------------------------------------}

procedure UnTypedToVar(var p; var v : OleVariant);
begin

end;

{-----------------------------------------------------------}

procedure VarToShortString (var p; const v : OleVariant);
begin
  ShortString(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToClass (var p; const v : OleVariant);
begin
  TObject(p) := VarToObject(v);
end;

{-----------------------------------------------------------}

procedure VarToString (var p; const v : OleVariant);
begin
  string(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToWideString (var p; const v : OleVariant);
begin
  WideString(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToVariant    (var p; const v : OleVariant);
begin
  Variant(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToIntf  (var p; const v : OleVariant);
begin
  TObject(p) := VarToObject(v)
end;

{-----------------------------------------------------------}

procedure VarToBoolean    (var p; const v : OleVariant);
begin
  boolean(p) := CorrectBool(v);
end;

{-----------------------------------------------------------}

procedure VarToShortInt   (var p; const v : OleVariant);
begin
  ShortInt(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToByte       (var p; const v : OleVariant);
var
  s : string;
begin
  if TVarData(v).vType = varOleStr then
    begin
      s := v;
      if length(s) > 0 then
        char(p) := s[1];
    end
  else
    Byte(p) := CorrectBool(v);
end;

{-----------------------------------------------------------}

procedure VarToSmallint   (var p; const v : OleVariant);
begin
  SmallInt(p) := CorrectBool(v);
end;

{-----------------------------------------------------------}

procedure VarToWord       (var p; const v : OleVariant);
begin
  if TVarData(v).vType = varOleStr then
    begin
      if TVarData(v).vOleStr <> nil then
        WideChar(p) := TVarData(v).vOleStr^
      else
        word(p) := 0;  
    end
  else
    Word(p) := CorrectBool(v);
end;

{-----------------------------------------------------------}

procedure VarToInteger    (var p; const v : OleVariant);
begin
  integer(p) := CorrectBool(v);
end;

{-----------------------------------------------------------}
{$IFDEF D5}
procedure VarToLongWord   (var p; const v : OleVariant);
begin
  LongWord(p) := CorrectBool(v);
end;
{$ENDIF}
{-----------------------------------------------------------}

procedure VarToSingle     (var p; const v : OleVariant);
begin
  single(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToDouble     (var p; const v : OleVariant);
begin
  double(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToExtended   (var p; const v : OleVariant);
begin
  extended(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToComp       (var p; const v : OleVariant);
begin
  comp(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToCurrency   (var p; const v : OleVariant);
begin
  currency(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToReal       (var p; const v : OleVariant);
begin
  real(p) := v;
end;

{-----------------------------------------------------------}

procedure VarToUntyped    (var p; const v : OleVariant);
begin

end;

{-----------------------------------------------------------}

procedure VarToOpenArray      (var p; const v : OleVariant);
begin
  VarToArray(GetArray(v), @p, nil);
end;

{-----------------------------------------------------------}

procedure VarToPtr    (var p; const v : OleVariant);
begin
  pointer(p) := VarToPointer(v);
end;

{-----------------------------------------------------------}

procedure VarToPChar (var p; const v : OleVariant);
begin
  PChar(p) := StrNew(PChar(string(v)));
end;

{-----------------------------------------------------------}

procedure VarToPWChar (var p; const v : OleVariant);
begin
  PWideChar(p) := DCStringToOleSt(string(v));
end;

{-----------------------------------------------------------}

type
  TConvertTypes = (ctUnknown, ctString, ctClass, ctMethod, ctLString,
                   ctWString, ctVariant, ctInterface);

const
  ConvertTypes : array[TConvertTypes] of TTypeConvertInfo =
  (
   (_info : nil; tSize : 0                 ; v2p : nil            ; p2v : nil              ; v2v : nil),               // ctUnknown
   (_info : nil; tSize : 256               ; v2p : VToShortString ; p2v : ShortStringToVar ; v2v : VarToShortString),  // ctString
   (_info : nil; tSize : sizeof(TClass)    ; v2p : VToClass       ; p2v : ClassToVar       ; v2v : VarToClass),        // ctClass
   (_info : nil; tSize : sizeof(TMethod)   ; v2p : nil            ; p2v : MethodToVar      ; v2v : nil),       // ctMethod
   (_info : nil; tSize : RealStringSize    ; v2p : VToString      ; p2v : LStringToVar     ; v2v : VarToString),      // ctLString
   (_info : nil; tSize : sizeof(WideString); v2p : VToWideString  ; p2v : WStringToVar     ; v2v : VarToWideString),      // ctWString
   (_info : nil; tSize : sizeof(Variant)   ; v2p : VToV           ; p2v : VarToVar         ; v2v : VarToVariant),          // ctVariant
   (_info : nil; tSize : sizeof(pointer)   ; v2p : VToInterface   ; p2v : InterfaceToVar   ; v2v : VarToIntf)     // ctInterface
  );

  BoolConvert : TTypeConvertInfo =
  (_info : nil; tSize : sizeof(boolean)    ; v2p : VToByte     ; p2v : BoolToVar           ; v2v : VarToBoolean);

  OrdTypes : array[TOrdType] of TTypeConvertInfo =
  (
   (_info : nil; tSize : sizeof(shortint) ; v2p : VToShortInt ; p2v : SByteToVar           ; v2v : VarToShortInt), // otSByte
   (_info : nil; tSize : sizeof(byte)     ; v2p : VToByte     ; p2v : UByteToVar           ; v2v : VarToByte    ), // otUByte
   (_info : nil; tSize : sizeof(smallint) ; v2p : VToSmallint ; p2v : SWordToVar           ; v2v : VarToSmallint), // otSWord
   (_info : nil; tSize : sizeof(word)     ; v2p : VToWord     ; p2v : UWordToVar           ; v2v : VarToWord    ), // otUWord
   (_info : nil; tSize : sizeof(integer)  ; v2p : VToInt      ; p2v : SLongToVar           ; v2v : VarToInteger )  // otSLong
{$IFDEF D5}
   ,
   (_info : nil; tSize : sizeof(longword) ; v2p : VToLongWord ; p2v : SLongToVar           ; v2v : VarToLongWord)  // otULong
{$ENDIF}
  );

  FloatTypes : array[TFloatType] of TTypeConvertInfo =
  (
   (_info : nil; tSize : sizeof(single)   ; v2p : VToSingle   ; p2v : SingleToVar          ; v2v : VarToSingle  ),   // ftSingle
   (_info : nil; tSize : sizeof(double)   ; v2p : VToDouble   ; p2v : DoubleToVar          ; v2v : VarToDouble  ),   // ftDouble
   (_info : nil; tSize : sizeof(extended) ; v2p : VToExtended ; p2v : ExtendedToVar        ; v2v : VarToExtended), // ftExtended
   (_info : nil; tSize : sizeof(comp)     ; v2p : VToComp     ; p2v : CompToVar            ; v2v : VarToComp    ),     // ftComp
   (_info : nil; tSize : sizeof(currency) ; v2p : VToCurrency ; p2v : CurrToVar            ; v2v : VarToCurrency)      // ftCurr
  );

  ConvertNoTypeInfoTypes : array[PCharTypeInfo .. PointerInfo] of TTypeConvertInfo =
  (
   (_info : nil; tSize : sizeof(PChar)     ; v2p : VToPChar     ; p2v : PCharToVar         ; v2v : VarToPChar   ), // PChar
   (_info : nil; tSize : sizeof(PWideChar) ; v2p : VToPWChar    ; p2v : PWCharToVar        ; v2v : VarToPWChar  ), // PWideChar
   (_info : nil; tSize : sizeof(real)      ; v2p : VToReal      ; p2v : RealToVar          ; v2v : VarToReal    ), // Real
   (_info : nil; tSize : sizeof(real)      ; v2p : VToUntyped   ; p2v : UntypedToVar       ; v2v : VarToUntyped ), // UnTyped
   (_info : nil; tSize : 8                 ; v2p : VToArray     ; p2v : nil                ; v2v : VarToOpenArray),// Array of const
   (_info : nil; tSize : 4                 ; v2p : VToPointer   ; p2v : PointerToVar       ; v2v : VarToPtr     )  //Pointer
  );

  ConvertOpenArray : TTypeConvertInfo =
   (_info : nil; tSize : 8                 ; v2p : VToTypedArray ; p2v : nil; v2v : nil);  // Open array of some type

{$IFDEF D4}
  ConvertDynamicArray : TTypeConvertInfo =
   (_info : nil; tSize : 4                 ; v2p : VToDynamicArray ; p2v : nil; v2v : nil);  // Dynamic array of some type
{$ENDIF}

function GetConvertInfo(tInfo : PTypeInfo) : PTypeConvertInfo;
begin
  result := nil;

  if IsArrayInfo(tInfo) then
    begin
      result := @ConvertOpenArray;
      result^._info := ArrayInfos[integer(tInfo) - ArrayInfoBase];
      exit;
    end;

  {$IFDEF D4}
  if IsDynArrayInfo(tInfo) then
    begin
      result := @ConvertDynamicArray;
      result^._info := DynArrayInfos[integer(tInfo) - DynArrayInfoBase];
      exit;
    end;
  {$ENDIF}

  if integer(tInfo) in tNoTypeInfoTypes then
    result := @(ConvertNoTypeInfoTypes[integer(tInfo)])
  else
    with GetTypeData(tInfo)^ do
      case tInfo.Kind of
        tkUnknown     : result:= @(ConvertTypes[ctUnknown]);
        tkInteger,
        tkChar,
        tkEnumeration : begin
                          result := @BoolConvert;
                          if tinfo <> TypeInfo(boolean) then
                            result := @(OrdTypes[OrdType]);
                        end;

        tkFloat       : result := @(FloatTypes[FloatType]);
        tkString      : result := @(ConvertTypes[ctString]);
        tkSet         : result := @(OrdTypes[OrdType]);
        tkClass       : result := @(ConvertTypes[ctClass]);
        tkMethod      : result := @(ConvertTypes[ctMethod]);
        tkWChar       : result := @(OrdTypes[OrdType]);
        tkLString     : result := @(ConvertTypes[ctLString]);
        tkWString     : result := @(ConvertTypes[ctWString]);
        tkVariant     : result := @(ConvertTypes[ctVariant]);
        tkArray : ;
        tkRecord: ;
        tkInterface   : result := @(ConvertTypes[ctInterface])
      end;
end;

{-----------------------------------------------------------}

function GetDWordSize(i : integer) : integer;
begin
  result := cardinal(i) div 4 + byte(cardinal(i) mod 4 > 0);
end;

{-----------------------------------------------------------}

procedure TypeConvertToParamRec(tcInfo : PTypeConvertInfo; var ParamRec : TParamRec;
                                PFlags : TParamFlags; cParam : PTypeInfo; var ParamsSize : integer);
begin
  with tcinfo^, ParamRec do
    begin
      VarToParam  := v2p;
      ParamToVar  := p2v;
      VarToVar    := v2v;
      pSize       := tSize;
      flags       := PFlags;
      _tinfo      := _info;
      if (cParam = TypeInfo(Variant)) or   // Variant and ShortString are always passed by reference
         (cParam = TypeInfo(OleVariant)) or
         (cParam = TypeInfo(ShortString)) then
        Include(flags, pfVar)
      else if IsArrayInfo(cParam) then
        Exclude(flags, pfVar);

      UseRegister := ord((cParam = TypeInfo(string)) or
                         (cParam = TypeInfoArrayOfConst) or
                         IsArrayInfo(cParam) or
                        (tSize <= 4) and (cParam <> TypeInfo(single)));

      if cParam = TypeInfoArrayOfConst then
        FreeParam := FreeArrayOfConst
      else if cParam = TypeInfoPChar then
        FreeParam := FreePChar
      else if cParam = TypeInfoPWideChar then
        FreeParam := FreePWideChar
      else if cParam = TypeInfo(string) then
        FreeParam := FreeString
      else if IsArrayInfo(cParam) then
        FreeParam := FreeArray
      {$IFDEF D4}
      else if IsDynArrayInfo(cParam) then
        FreeParam := FreeDynArray
      {$ENDIF}  
      else if not (integer(cParam) in tNoTypeInfoTypes) and (cParam.Kind = tkInterface) then
        FreeParam := FreeInterface;

      inc(ParamsSize, GetDWORDSize(tSize) * 4);
   end;
end;


procedure RegInfoToMethodInfo(TypeData : PTypeData; const Params : array of PTypeInfo;
                              IsObjectProc : boolean; addr : pointer;
                              AMethodType : TMethodType; info : TMethodInfo; ACallType : TCallType);
var
  i        : integer;
  p        : PChar;
  PFlags   : TParamFlags;
  TypeName : string;
  cinfo    : PTypeConvertInfo;
  pbase    : integer;
  cParam   : PTypeInfo;
begin
  p := @TypeData^.ParamList;
  with info do
    begin
      ITypeData := TypeData;
      ParamsSize := 0;
      OfObject := IsObjectProc;
      CallType := ACallType;
      Address := addr;
      if abs(integer(addr)) < $FFFF then
        begin
          if integer(addr) > MinVMTOffset then
            IsVirtual := true
          else
            begin
              IsDynamic := true;
              Address := pointer(MinVMTOffset - integer(Address) + 1);
            end;
        end;

      MethodType := AMethodType;

      ParamCount := TypeData^.ParamCount;
      pbase := Low(Params);
      if TypeData.MethodKind = mkFunction then
        RetType := Params[High(Params)]
      else if MethodType = mtConstructor then
        RetType := TypeInfo(TObject)
      else
        RetType := nil;

      for i := 0 to Min(High(Params), ParamCount - 1) do
        begin
          PFlags := TParamFlags(p^);
          inc(p);
          PReadShortStr(p); // ParamName
          TypeName := PReadShortStr(p);
          cParam   := Params[pbase + i];
          cinfo := GetConvertInfo(cParam);

          TypeConvertToParamRec(cinfo, ParamRecs[i], Pflags, cParam, ParamsSize);
        end;
    end;
end;

{-----------------------------------------------------------}

function VarToInt(const v : OleVariant) : integer;
begin
  result := CorrectBool(v);
end;

{-----------------------------------------------------------}
// Param : [skip : 4; size : 4; inregister : 4; val : size * 4]
// inregister : 0 - no, 1 - yes, 2 - ref
function _call(var params; addr : pointer; useregisters : boolean; DynaIndex : integer) : integer; assembler;
asm
     push esi
     push edi
     push ebp
     push ebx
     mov  ebx, DynaIndex
     push ebx

     mov  ebp, esp
     push ebp
     push edx      // addr

     xor  ebp, ebp
     or   cl, cl
     je   @@noregs
     mov  ebp, 3   // free registers count

@@noregs:
     mov  esi, eax // params

     sub  esp, 12     // [eax + 12] - addr, [eax + 8] - skip, [eax] - param passed in eax
     mov  eax, esp
     xor  edi, edi
     mov  [eax + 4], edi // [eax + 4] - 0 - param, 1 - ref

@@loop:
     mov  edi, [esi]  // skip (used for AnsiString)
     mov  [eax + 8], edi
     add  esi, 4

     mov  edi, [esi] // size of param in dwords
     add  esi, 4

     or   edi, edi
     je   @@mcall

     mov  ebx, [esi]  // can be passed in register
     add  esi, 4

     add  esi, [eax + 8] // skip

     jmp  dword ptr [@@regjmptable + ebx * 4]

@@regjmptable:
     dd   @@_stack
     dd   @@_register
     dd   @@_ref

@@_register:
     mov  ebx, [esi]
     jmp  @@passparam

@@_ref:
     mov  ebx, esi
     mov  dword ptr [eax + 4], 1

@@passparam:
     add  esi, 4
     jmp  dword ptr [@@jmptable + ebp * 4]

@@jmptable :
     dd @@stack
     dd @@ECX
     dd @@EDX
     dd @@EAX

@@ECX:
     mov ecx, ebx
     jmp @@regs

@@EDX:
     mov edx, ebx
     jmp @@regs

@@EAX:
     mov [eax], ebx

@@regs:
     dec  ebp
     cmp  dword ptr [eax + 4], 1
     je   @@skip
     dec  edi
     jne  @@_register
     jmp  @@loop

@@_stack:
     mov  ebx, [esi]
     add  esi, 4

@@stack:
     push ebx
     cmp  dword ptr [eax + 4], 1
     je   @@skip
     dec  edi
     je   @@loop
     mov  ebx, [esi]
     add  esi, 4
     jmp  @@stack

@@skip:
     mov  dword ptr [eax + 4], 0
     dec  edi
     je   @@loop
     add  esi, 4
     jmp  @@skip

@@mcall:
     mov  ebx, [eax + 20]
     mov  edi, [eax + 12]
     mov  esi, [eax + 16]
     mov  eax, [eax]
     call edi

     mov  esp, esi

     pop  ebx
     pop  ebx
     pop  ebp
     pop  edi
     pop  esi
end;

{-----------------------------------------------------------}

function _getref(p : pointer) : pointer; assembler;
asm
  mov eax, [eax]
end;

{-----------------------------------------------------------}

function _getaddr(proc : pointer; instance : TObject; IsVirtual : boolean; IsClassMethod : boolean) : pointer; assembler;
asm
  or  cl, cl
  je  @quit
  cmp IsClassMethod, 1
  je  @l1
  mov edx, [edx]
@l1:
  mov eax, [edx + eax]
@quit:
end;

{-----------------------------------------------------------}

//!!! check cArgs = MethodInfo.ParamCount
procedure CallMethod(Instance : TObject; MethodInfo : TMethodInfo; cArgs : integer;
                    pArgs : PArgList; Result : POleVariant);
var
  params     : pointer;
  i          : integer;
  cparam     : pchar;
  retval     : integer;
  retaddr    : pchar;
  ParamAddr  : array[0 .. MaxParams - 1] of pointer;
  ParamInfos : array[0 .. MaxParams - 1] of pointer;

  {--------------------------------}

  function AllocSafeCallRetVal : integer;
  var
    rtype    : PTypeInfo;
  begin
    result := 4;
    rtype := MethodInfo.RetType;
    if rtype.kind = tkFloat then
      result := GetFloatSize(GetTypeData(rtype).FloatType);
  end;

  {--------------------------------}

  procedure AllocRetVal;
  begin
    with MethodInfo, PParamInfo(cparam)^ do
      begin
        if RetType = nil then
          exit;
        skip := 0;
        inregister := 2;
        retaddr := @val;
        size := 0;

        if DWORD(RetType) < $FFFF then
          exit;

        case RetType.kind of
          tkString  : size := 256;

          tkLString, tkWString :
            begin
              size := 4;
              skip := sizeof(StrRec);
              inc(retaddr, skip);
              FillChar(val, RealStringSize, 0);
            end;

          tkVariant : size := sizeof(Variant);

          tkInterface : begin
                          size := sizeof(IUnknown);
                          FillChar(val, size, 0);
                        end;
          else
            if CallType = cSafeCall then
              size := AllocSafeCallRetVal
            else
              exit;
        end;

        if size <> 0 then
          inc(cparam, size * 4 + (sizeof(TParamInfo) - 4) + skip);
      end;
  end;

  {--------------------------------}

  procedure GetResult;
  var
    Convert    : TParamToVarProc;
    fSingle    : single;
    fDouble    : double;
    fExtended  : extended;
    fComp      : comp;
    fCurr      : currency;
    p          : pointer;
    ReturnType : PTypeInfo;
  begin
    with MethodInfo do
      begin
        Convert := GetConvertInfo(RetType)^.p2v;
        p       := nil;
        ReturnType := RetType;

        if CallType = cSafeCall then
          p := retaddr
        else if (integer(ReturnType) in [PCharTypeInfo, PWideCharTypeInfo, PointerInfo]) then
          p := @retval
        else if ReturnType = TypeInfoReal then
          begin
            asm
              fstp fDouble
              wait
            end;
            p := @fDouble;
          end
        else if ReturnType.kind = tkFloat then
          begin
            case GetTypeData(ReturnType).FloatType of
              ftSingle: begin
                          asm
                            fstp fSingle
                          end;
                          p := @fSingle;
                        end;

              ftDouble: begin
                          asm
                            fstp fDouble
                          end;
                          p := @fDouble;
                        end;

              ftExtended: begin
                            asm
                              fstp fExtended
                            end;
                            p := @fExtended;
                          end;

              ftComp: begin
                        asm
                          fstp fComp
                        end;
                        p := @fComp;
                      end;

              ftCurr: begin
                        asm
                          fistp fCurr
                        end;
                        p := @fCurr;
                      end;
            end;

            asm
              wait
            end;
          end
        else if ReturnType.kind in [tkString, tkWString, tkLString, tkVariant, tkInterface] then
          p := retaddr
        else
          p := @retval;

        asm
          mov ecx, pfConst
        end;

        if Assigned(Convert) then
          Convert(p^, result^);
      end;
  end;

  {--------------------------------}

  function GetParamIndex(index : integer) : integer;
  begin
    if MethodInfo.CallType in [cRegister, cPascal] then
      result := index
    else
      result := cArgs - 1 - index;
  end;

  {--------------------------------}

  procedure PassInstance;
  begin
    with MethodInfo do
      begin
        if not OfObject then
          exit;

        if MethodType = mtClassMethod then
          Instance := _getref(Instance);

        with PParamInfo(cparam)^ do
          begin
            skip := 0;
            size := GetDWordSize(sizeof(pointer));
            PInt(@val)^ := integer(Instance);
            InRegister := 1;
            inc(cparam, size * 4 + (sizeof(TParamInfo) - 4) + skip);
          end;
      end;
  end;

  {--------------------------------}

  procedure PassAllocateMode(Mode : boolean);
  begin
    with PParamInfo(cparam)^ do
      begin
        skip := 0;
        size := 1;
        PInt(@val)^ := ord(Mode);   // 0 - class is already created
        InRegister := 1;
        inc(cparam, size * 4 + (sizeof(TParamInfo) - 4) + skip);
      end;
  end;

  {--------------------------------}

var
  ParamIndex : integer;
  _addr      : pointer;
  allocmode  : boolean;
  ptv        : TParamToVarProc;
  paddr      : pointer;
begin
  params := nil;
  with MethodInfo do
    try
      GetMem0(params, (4096 + 8 + 256) + ParamsSize + ParamCount * (sizeof(TParamInfo) - 4));

      cparam := params;
      allocmode := (MethodType = mtConstructor) and IsVirtual;
      if allocmode then
        begin
          asm
            mov eax, instance
            mov dl, 1
            call ClassCreateAddr
            mov instance, eax
          end;
        end;

      if CallType = cRegister then
        PassInstance;

      if MethodType in [mtConstructor, mtDestructor] then
        PassAllocateMode(not allocmode);

      if CallType = cSafeCall then
        AllocRetVal;

      for i := 0 to cArgs - 1 do
        begin
          ParamIndex := GetParamIndex(i);
          with ParamRecs[ParamIndex], PParamInfo(cparam)^ do
            begin
              skip := 0;
              size := pSize;
              if pfVar in Flags then
                InRegister := 2
              else
                InRegister := ord(UseRegister);

              VarToParam(GetRefVariant(POleVariant(@(pArgs^[cArgs - 1 - ParamIndex])))^, @(PParamInfo(cparam)^.val), _tinfo);
              ParamInfos[ParamIndex] := cParam;
              ParamAddr[ParamIndex] := pchar(@val) + skip;
              size := GetDWordSize(size);
              inc(cparam, size * 4 + (sizeof(TParamInfo) - 4) + skip);
            end;
        end;

      if CallType in [cCdecl, cStdCall, cSafeCall] then
        PassInstance;

      if CallType <> cSafeCall then
        AllocRetVal;

      if CallType = cPascal then
        PassInstance;

      PParamInfo(cparam)^.size := 0;
      _addr := CallDynaInstAddr;
      if not IsDynamic then
        _addr := _getaddr(Address, Instance, IsVirtual, MethodType = mtClassMethod);

      retval := _call(params^, _addr, CallType = cRegister, -integer(Address));

      if RetType <> nil then
        GetResult
      else
        VarClear(result^);

      for i := 0 to cArgs - 1 do
        begin
          ParamIndex := GetParamIndex(i);
          with ParamRecs[ParamIndex], TVarData(pArgs^[cArgs - 1 - ParamIndex]) do
            begin
              if pfVar in Flags then
                if vType = VarByRef or VarVariant then
                  begin
                    ptv := ParamToVar;
                    if Assigned(ptv) then
                      begin
                        paddr := ParamAddr[ParamIndex];
                        ptv(paddr^, POleVariant(VPointer)^);
                        if @ptv = @dcscript.VarToVar then
                          VarClear(POleVariant(paddr)^);
                      end;    
                  end;

              if Assigned(FreeParam) then
                FreeParam(ParamInfos[ParamIndex]);
            end;
        end;

    finally
      FreeMem(params);
    end;
end;

{-----------------------------------------------------------}

constructor TRegisteredClassInfo.Create;
begin
  inherited;
  Methods := CreateSortedStringList;
  Props := CreateSortedStringList;
end;

{-----------------------------------------------------------}

destructor  TRegisteredClassInfo.Destroy;
begin
  FreeStrings(Methods);
  FreeStrings(Props);
  inherited;
end;

{***********************************************************}

type
  TRegisteredClassesList = class(TSortedList)
  private
    function GetInfo(index : integer) : TRegisteredClassInfo;
  protected
    function  Compare(Item1, Item2: Pointer) : integer; override;
    function CompareWithKey(Item, Key : pointer):Integer;override;
  public
    property Infos [index : integer] : TRegisteredClassInfo read GetInfo;
  end;

{-----------------------------------------------------------}

function  TRegisteredClassesList.Compare(Item1, Item2 : Pointer) : integer;
begin
  result := integer(TRegisteredClassInfo(Item1).RClass) - integer(TRegisteredClassInfo(Item2).RClass);
end;

{-----------------------------------------------------------}

function TRegisteredClassesList.CompareWithKey(Item, Key : pointer) : Integer;
begin
  result := integer(TRegisteredClassInfo(Item).RClass) - integer(Key);
end;

{-----------------------------------------------------------}

function TRegisteredClassesList.GetInfo(index : integer) : TRegisteredClassInfo;
begin
  result := TRegisteredClassInfo(Items[index]);
end;

{***********************************************************}

var
  fRegisteredClasses : TRegisteredClassesList;
  fResClasses        : TRegisteredClassesList;
  GlobalMethodsList  : TSortedList;
  GlobalMethodNames  : TStringList;
  GlobalPropsList    : TSortedList;
  RClassList         : TStringList;
  RConstList         : TStringList;
  RVarList           : TStringList;
  fGlobalPropNames   : TStringList;
  RCList             : TSortedList;
  RVList             : TSortedList;


{-----------------------------------------------------------}

function GetRegisteredClassesList : TStringList;
begin
  result := RClassList;
end;

{-----------------------------------------------------------}

var
  LastFoundClass : TClass = TClass(-1);
  LastIndex      : integer;

function _getClassInfoIndex(AClass : TClass; ClassList : TRegisteredClassesList) : integer;
var
  rcinfo : TRegisteredClassInfo;
begin
  with ClassList do
    if not Findbykey(AClass, result) then
      begin
        rcinfo := TRegisteredClassInfo.Create;
        rcinfo.rClass := AClass;
        result := Add(rcinfo);
        if AClass <> nil then
          RClassList.AddObject(AClass.ClassName, rcinfo);
      end;
end;

{-----------------------------------------------------------}

function GetClassInfoIndex(AClass : TClass) : integer;
begin
  if AClass = LastFoundClass then
    begin
      result := LastIndex;
      exit;
    end;

  result := _getClassInfoIndex(AClass, fRegisteredClasses);

  LastFoundClass := AClass;
  LastIndex := result;
end;

{-----------------------------------------------------------}

function GetResClassInfoIndex(AClass : TClass) : integer;
begin
  result := _getClassInfoIndex(AClass, fResClasses);
end;

{-----------------------------------------------------------}

function RegisterReservedProcEx(AClass : TScriptRunClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer;
            CallType : TCallType; MethodType : TMethodType) : TMethodInfo;
var
  info   : TMethodInfo;
  index  : integer;
begin
  info := TMethodInfo.Create;
  RegInfoToMethodInfo(GetTypeData(ProcInfo), Params, false, addr,
                      MethodType, info, CallType);
  index := GetResClassInfoIndex(AClass);

  with fResClasses do
    begin
      Infos[index].Methods.AddObject(ProcName, info);
      GlobalMethodsList.Add(info);
      AddToCountedStrings(GlobalMethodNames, ProcName);
    end;

  result := info;
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

function RegisterReservedProc(AClass : TScriptRunClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer;
            CallType : TCallType)  : TMethodInfo;
begin
  result := RegisterReservedProcEx(AClass, ProcName, ProcInfo, Params, addr, CallType, mtProc);
end;

{-----------------------------------------------------------}

procedure UnregisterProc(AClass : TClass; const ProcName : string; ProcInfo : TMethodInfo);
var
  index : integer;
  pindex : integer;
begin
  index := GetClassInfoIndex(AClass);
  with fRegisteredClasses do
    if Infos[index].Methods.Find(ProcName, pindex) then
      begin
        Infos[index].Methods.Delete(pindex);
        GlobalMethodsList.Remove(Procinfo);
        RemoveFromCountedStrings(GlobalMethodNames, ProcName);
      end;
  ProcInfo.Free;
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

procedure UnregisterProcedure(const ProcName : string; ProcInfo : TMethodInfo);
begin
  UnRegisterProc(nil, ProcName, ProcInfo);
end;

{-----------------------------------------------------------}

type
  __TRW = function : IDispatch of object;

function  RegisterRWProc(const RWName : string; Proc : pointer) : TMethodInfo;
begin
  result := RegisterProc(nil, RWName, mtProc, TypeInfo(__TRW), [TypeInfo(IDispatch)], Proc, cRegister);
end;

{-----------------------------------------------------------}

function RegisterProc(AClass : TClass; const ProcName : string; MethodType : TMethodType;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer; CallType : TCallType) : TMethodInfo;
var
  info  : TMethodInfo;
  index : integer;
  pindex : integer;
begin
  info := TMethodInfo.Create;
  RegInfoToMethodInfo(GetTypeData(ProcInfo), Params, AClass <> nil, addr,
                      MethodType, info, CallType);
  index := GetClassInfoIndex(AClass);

  with fRegisteredClasses do
    begin
      if Infos[index].Methods.Find(ProcName, pindex) then
        begin
          info.Free;
          info := nil;
        end
      else
        begin
          Infos[index].Methods.AddObject(ProcName, info);
          GlobalMethodsList.Add(info);
          AddToCountedStrings(GlobalMethodNames, ProcName);
        end;
    end;
  result := info;
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

function RegisterProcedure(const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer; CallType : TCallType) : TMethodInfo;
begin
  result := RegisterProc(nil, ProcName, mtMethod, ProcInfo, Params, addr, CallType);
end;

{-----------------------------------------------------------}

function RegisterClassMethod(AClass : TClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer; CallType : TCallType) : TMethodInfo;
begin
  result := RegisterProc(AClass, ProcName, mtClassMethod, ProcInfo, Params, addr, CallType);
end;

{-----------------------------------------------------------}

function RegisterMethod(AClass : TClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer; CallType : TCallType) : TMethodInfo;
begin
  result := RegisterProc(AClass, ProcName, mtMethod, ProcInfo, Params, addr, CallType);
end;

{-----------------------------------------------------------}

function RegRegisterMethod(AClass : TClass; const ProcName : string;
            ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer) : TMethodInfo;
begin
  result := RegisterProc(AClass, ProcName, mtMethod, ProcInfo, Params, addr, cRegister);
end;

{-----------------------------------------------------------}

procedure RegisterIndexedProperty(AClass : TClass; const PropName : string;
            AIndexCount : integer; IsDefault : boolean;
            AGetProc : TPropGetProc; ASetProc : TPropSetProc);
var
  info   : TPropertyInfo;
  index  : integer;
begin
  info := TPropertyInfo.Create;
  with fRegisteredClasses do
    begin
      with info do
        begin
          IndexCount := AIndexCount;
          GetProc := AGetProc;
          SetProc := ASetProc;
        end;
      index := GetClassInfoIndex(AClass);
      with Infos[index] do
        begin
          Props.AddObject(PropName, info);
          if IsDefault then
            Infos[index].DefaultProp := info;
        end;
      GlobalPropsList.Add(info);
    end;

  fGlobalPropNames.Add(PropName);
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

procedure RegisterProperty(AClass : TClass; const PropName : string;
                              AGetProc : TPropGetProc; ASetProc : TPropSetProc);
begin
  RegisterIndexedProperty(AClass, PropName, 0, false, AGetProc, ASetProc);
end;

{-----------------------------------------------------------}

function RegisterVar(const VarName : string; AGetProc : TPropGetProc; ASetProc : TPropSetProc) : TVarInfo;
var
  i     : integer;
begin
  result := nil;
  if RVarList.Find(VarName, i) then
    exit;

  result := TVarInfo.Create;
  with result do
    begin
      GetProc := AGetProc;
      SetProc := ASetProc;
    end;

  RVarList.AddObject(VarName, result);
  RVList.Add(result);
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

procedure UnregisterVar(const VarName : string; VarInfo : TVarInfo);
var
  index : integer;
begin
  index := RVList.IndexOf(VarInfo);
  if index >= 0 then
    begin
      RVList.Delete(index);
      RemoveFromStrings(RVarList, VarName);
    end;
  VarInfo.Free;
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

procedure RegisterClassInScript(AClass : TClass);
begin
  GetClassInfoIndex(AClass);
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

procedure UnRegisterClassInScript(AClass : TClass);
var
  index : integer;
begin
  if fRegisteredClasses.FindByKey(AClass, index) then
    begin
      TObject(fRegisteredClasses[index]).Free;
      fRegisteredClasses.Delete(index);
      if AClass <> nil then
        RemoveFromStrings(RClassList, AClass.ClassName);

      if LastFoundClass = AClass then
        LastFoundClass := TClass(-1);
    end;
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

procedure RegisterClassesInScript(const AClasses : array of TClass);
var
  i : integer;
begin
  for i := 0 to High(AClasses) do
    RegisterClassInScript(AClasses[i]);
end;

{-----------------------------------------------------------}

procedure UnRegisterClassesInScript(const AClasses : array of TClass);
var
  i : integer;
begin
  for i := 0 to High(AClasses) do
    UnRegisterClassInScript(AClasses[i]);
end;

{-----------------------------------------------------------}

type
  TEventInfo = class
    EventInfo  : PTypeInfo;
    MethodInfo : TMethodInfo;
    destructor Destroy; override;
    constructor Create;
  end;

{-----------------------------------------------------------}

destructor TEventInfo.Destroy;
begin
  MethodInfo.Free;
  inherited;
end;

{-----------------------------------------------------------}

constructor TEventInfo.Create;
begin
  inherited;
  MethodInfo := TMethodInfo.Create;
end;

{-----------------------------------------------------------}

type
  TEventsList = class(TSortedList)
  protected
    function  Compare(Item1, Item2: Pointer) : integer; override;
    function CompareWithKey(Item, Key : pointer) : integer; override;
  end;

{-----------------------------------------------------------}

function  TEventsList.Compare(Item1, Item2 : Pointer) : integer;
begin
  result := integer(TEventInfo(Item1).EventInfo) - integer(TEventInfo(Item2).EventInfo);
end;

{-----------------------------------------------------------}

function TEventsList.CompareWithKey(Item, Key : pointer) : Integer;
begin
  result := integer(TEventInfo(Item).EventInfo) - integer(Key);
end;

{-----------------------------------------------------------}

var
  EventsList : TEventsList;

procedure RegisterEvent(ProcInfo : PTypeInfo; const Params : array of PTypeInfo);
var
  index : integer;
  info  : TEventInfo;
begin
  with EventsList do
    begin
      if not Find(ProcInfo, index) then
        begin
          info := TEventInfo.Create;
          info.EventInfo := ProcInfo;
          index := Add(info);
        end;
      RegInfoToMethodInfo(GetTypeData(ProcInfo), Params, true, nil,
                          mtMethod, TEventInfo(Items[index]).MethodInfo, cRegister);
    end;
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

procedure UnregisterConst(const ConstName : string; ConstInfo : TRegisteredConstInfo);
var
  index : integer;
begin
  if RCList.Find(ConstInfo, index) then
    begin
      RCList.Delete(index);
      if RConstList.Find(ConstName, index) then
        if RConstList.Objects[index] = ConstInfo then
          RConstList.Delete(index);

      ConstInfo.Free;
    end;
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

function RegisterConst(const ConstName : string; const ConstValue : Variant) : TRegisteredConstInfo;
var
  cindex : integer;
begin
  result := TRegisteredConstInfo.Create;

  if RConstList.Find(ConstName, cindex) then
    begin
      result.Free;
      result := nil;
    end
  else
    begin
      result.Value := ConstValue;
      RConstList.AddObject(ConstName, result);
      RCList.Add(result);
    end;
  inc(RegisterCount);
end;

{-----------------------------------------------------------}

function IsConstInfo(info : pointer) : boolean;
begin
  result := (RCList <> nil) and (RClist.IndexOf(info) >= 0);
end;

{-----------------------------------------------------------}

function IsVarInfo(info : pointer) : boolean;
begin
  result := (RVList <> nil) and (RVList.IndexOf(info) >= 0);
end;

{-----------------------------------------------------------}

function _GetMethodInfo(AClass : TClass; const AMethodName : string; ClassList : TRegisteredClassesList) : TMethodInfo;
var
  index  : integer;
  mindex : integer;
begin
  result := nil;

  if ClassList = nil then
    exit;
    
  repeat
    with ClassList do
      if FindByKey(AClass, index) then
        with Infos[index] do
          if Methods.Find(AMethodName, mindex) then
            begin
              result := TMethodInfo(Methods.Objects[mindex]);
              exit;
            end;

    if AClass = nil then
       exit;

    AClass := AClass.ClassParent;

  until AClass = nil;
end;

{-----------------------------------------------------------}

function CreateObject(cArgs: integer; pArgs: PArgList): OleVariant;
var
  i, index: integer;
  MInfo: TMethodInfo;
  AClass: TClass;
  obj: TObject;
  idisp : IDispatch;
begin
  obj := VarToObject(OleVariant(pargs^[cArgs - 1]));
  AClass := TClass(obj);
  Result := NULL;
  MInfo := nil;
  repeat
    with fRegisteredClasses do
      if FindByKey(AClass, index) then
        with Infos[index].Methods do
          for i := 0 to Count - 1 do
            if (TMethodInfo(Objects[i]).MethodType = mtConstructor) and
               (CompareText(Strings[i], 'Create') = 0) then
            begin
              MInfo := TMethodInfo(Objects[i]);
              break;
            end;

    if MInfo <> nil then
      break;

    if AClass = nil then
      exit;

    AClass := AClass.ClassParent;
  until AClass = nil;

  if MInfo = nil then
    exit;

  CallMethod(obj, MInfo, cArgs - 1, pArgs, @Result);
  idisp := VarToInterface(Result);
  if idisp <> nil then
    (idisp as IDCompWrapper).SetAutoRelease;
end;

{-----------------------------------------------------------}

function GetReservedMethodInfo(AClass : TScriptRunClass; const AMethodName : string) : TMethodInfo;
begin
  result := _GetMethodInfo(AClass, AMethodName, fResClasses);
end;

{-----------------------------------------------------------}

function GetMethodInfo(AClass : TClass; const AMethodName : string) : TMethodInfo;
begin
  result := _GetMethodInfo(AClass, AMethodName, fRegisteredClasses);
end;

{-----------------------------------------------------------}

function IsMethodInfo(info : pointer) : boolean;
begin
  result := (GlobalMethodsList <> nil) and (GlobalMethodsList.IndexOf(info) >= 0);
end;

{-----------------------------------------------------------}

function IsRegisteredClass(info : pointer) : boolean;
var
  i : integer;
begin
  result := (info <> nil) and (fRegisteredClasses <> nil) and fRegisteredClasses.Findbykey(info, i);
end;

{-----------------------------------------------------------}

function GetPropertyInfo(AClass : TClass; const PropName : string) : TPropertyInfo;
var
  index  : integer;
  pindex : integer;
begin
  result := nil;

  if fRegisteredClasses = nil then
    exit;
    
  repeat
    with fRegisteredClasses do
      if FindByKey(AClass, index) then
        with Infos[index] do
          if Props.Find(PropName, pindex) then
            begin
              result := TPropertyInfo(Props.Objects[pindex]);
              exit;
            end;

    if AClass = nil then
      exit;

    AClass := AClass.ClassParent;

  until AClass = nil;
end;

{-----------------------------------------------------------}

function IsPropertyInfo(info : pointer) : boolean;
begin
  result := (GlobalPropsList <> nil) and (GlobalPropsList.IndexOf(info) >= 0);
end;

{-------------------------------------------------------------------------}

var
  _nilwrapper : IDispatch;

function Disp2Object(const idisp : IDispatch) : TObject;
var
  disp : IDispatch;
  wrapper : TDCompWrapper;

  procedure scanlist(list : TList);
  var
    i : integer;
  begin
    for i := 0 to list.Count - 1 do
      begin
        wrapper := TDCompWrapper(list[i]);
        wrapper.QueryInterface(IDispatch, disp);
        if disp = idisp then
          begin
            result := wrapper.WrappObject;
            exit;
          end;
      end;
  end;

begin
  result := nil;

  if integer(idisp) = 0 then
    exit;

  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
  {$ENDIF}
    scanlist(GlobalWrapList);
    if result = nil then
      scanlist(ModuleWrappersList);

  {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
end;

{-------------------------------------------------------------------------}

function GetObjectWrapper(O : TObject; WrapList : TList; IsModule : boolean) : TDCompWrapper;
begin
  if WrapList = nil then
    WrapList := GlobalWrapList;

  result := GetExistingWrapper(O, IsModule);
  if result <> nil then
    exit;

  result := CreateCompWrapper;
  result.fIsClass := IsRegisteredClass(O);
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
  if WrapList <> nil then
    WrapList.Add(result);

  if (WrapList <> GlobalWrapList) and not IsModule then
    GlobalWrapList.Add(result);

  result.WrappObject := O;
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}
end;

{-------------------------------------------------------------------------}

function GetModuleObjectDispatch(O : TObject) : IDispatch;
var
  iCompWrapper : IDCompWrapper;
begin
  GetObjectWrapper(O, ModuleWrappersList, true).QueryInterface(IDispatch, result);
  if result.QueryInterface(IDCompWrapper, iCompWrapper) = S_OK then
    iCompWrapper.SetModuleMode;
end;

{-------------------------------------------------------------------------}

function GetObjectDispatch(O : TObject; WrapList : TList) : IDispatch;
begin
  if O = nil then
    result := _nilwrapper
  else
{$IFDEF WIN}
{$IFNDEF CLX}
  if not IsRegisteredClass(O) and (O is TCustomDCOleControl) then
    TCustomDCOleControl(O).OleObject.QueryInterface(IDispatch, result)
  else
{$ENDIF}
{$ENDIF}
  {$IFDEF THREADSAFE}
  begin
  Synchronizer.BeginRead;
  try
  {$ENDIF}
    GetObjectWrapper(O, WrapList, false).QueryInterface(IDispatch, result);
  {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

type
  TGetProc = function (o : TObject; index : integer) : OleVariant;
  TSetProc = procedure (o : TObject; index : integer; val : OleVariant);

{-----------------------------------------------------------}

procedure RegisterScriptRunner(RunnerClass : TScriptRunClass; const Extension, Desc : string);
var
  v1 : variant;
  v2 : variant;
begin
  v1 := Extension;
  v2 := Desc;
  RegisterClassExt(RunnerClass, [SRunnerExtension, SRunnerDescription], [v1, v2]{[Extension, Desc]}); // avoid bug in CPB1 compiler
end;

{-------------------------------------------------------------------------}

function GetScriptRunnerClass(const FileExt : string) : TScriptRunClass;
begin
  result := TScriptRunClass(GetClassEx(TScriptRunner, [SRunnerExtension], [FileExt], [cpIgnoreCase]));
end;

{-------------------------------------------------------------------------}

procedure AddLoadedModule(Runner : TDCScripter);
begin
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
    fLoadedModules.Add(Runner);
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

procedure RemoveLoadedModule(Runner : TDCScripter);
begin
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
    fLoadedModules.RemoveAll(Runner);
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

function FindLoadedModule(const FilID : TFilerID; const AFileName : TFileName;
                          AProject : THandle; var Runner : TDCScripter) : boolean;
var
  i : integer;
begin
  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
  {$ENDIF}
    for i := 0 to fLoadedModules.Count - 1 do
      begin
        runner := TDCScripter(fLoadedModules[i]);
        with runner do
          if (AnsiCompareText(ScriptFile, AFileName) = 0) and (FilID = FilerID) and
             (Project = AProject) then
            begin
              result := true;
              exit;
            end;
      end;
  {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
  result := false;
end;

{-----------------------------------------------------------}

type
  TRunInfo = class
    sc     : TScriptRunner;
    wlist  : TList;
    Module : TComponent;
    Modal  : boolean;

    destructor Destroy; override;
  end;


destructor TRunInfo.Destroy;
begin
  inherited;
end;

{$IFNDEF WIN}
type
  TCompFiler = class
  end;
{$ENDIF}
    
function InitRun(ScriptClass : TScriptRunClass; AModule : TComponent;
                    AModal : boolean; Script : TStrings; ErrorProc : TScriptErrorHandler;
                    HookAllEvents : boolean; AScripter : TDCScripter;
                    CompiledScript : TStream; CompFiler : TCompFiler; fModule : TComponent) : TRunInfo; forward;

procedure FinishRun(info : TRunInfo); forward;


{***********************************************************}

procedure TFreeNotifier.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = fComp) then
    fEventItem.Component := nil;
end;

{***********************************************************}

function TEventItems.GetItem(index : integer) : TEventItem;
begin
  result := TEventItem(inherited Items[index]);
end;

{***********************************************************}

constructor TEventItem.Create(Collection: TCollection);
begin
  inherited;
  fNotifier := TFreeNotifier.Create(nil);
  fNotifier.fEventItem := self;
  fCallExisting := true;
end;

{-----------------------------------------------------------}

destructor TEventItem.Destroy;
begin
  fNotifier.Free;
  UnHook;
  inherited;
end;

{-----------------------------------------------------------}

function  TEventItem.GetScripter : TDCScripter;
begin
  result := TDCScripter(TEventItems(Collection).Owner);
end;

{-----------------------------------------------------------}

procedure TEventItem.Hook;
var
  p : pointer;
begin
  if fHooked or (Scripter.fInDesign > 0) or
     ([csLoading, csDesigning] * Scripter.ComponentState <> []) or
     (Component = nil) or (Event = '') or (ScriptMethod = '') then
    exit;

  p := CreateEventHandler(Component, Event, Scripter._DispatchMethod, CallExisting, ScriptMethod);
  if p <> nil then
    begin
      SetEventPermanent(p);
      fHooked := true;
    end
  else
    fHooked := false;
end;

{-----------------------------------------------------------}

procedure TEventItem.UnHook;
var
  pinfo : PPropInfo;
begin
  if fHooked then
    begin
      pinfo := GetPropInfo(Component.ClassInfo, Event);
      if pinfo <> nil then
        _RestoreOldEvent(Component, pinfo, true);

      fHooked := false;  
    end;
end;

{-----------------------------------------------------------}

procedure TEventItem.SetScriptMethod(const AScriptMethod : string);
begin
  if fScriptMethod <> AScriptMethod then
    begin
      UnHook;
      fScriptMethod := AScriptMethod;
      Hook;
    end;
end;

{-----------------------------------------------------------}

procedure TEventItem.SetEvent(const AEvent : string);
begin
  if AEvent <> fEvent then
    begin
      UnHook;
      fEvent := AEvent;
      Hook;
    end;
end;

{-----------------------------------------------------------}

procedure TEventItem.SetComponent(val : TComponent);
begin
  if val <> fComponent then
    begin
      UnHook;
      fComponent := val;

      if val <> nil then
        begin
          val.FreeNotification(fNotifier);
          Hook;
        end;

      fNotifier.fComp := val;
    end;
end;

{***********************************************************}

{$IFDEF WIN}


{-----------------------------------------------------------}

const
  GetScripterVMTOffsetForm : integer = 0;
  GetScripterVMTOffsetDataModule : integer = 0;

  ScriptUnitModuleRefCountPtr = vmtSelfPtr - sizeof(integer);
  ScriptUnitModuleScripterPtr = ScriptUnitModuleRefCountPtr - sizeof(integer);

function getscripterVMTOffSet(AClass : TClass) : integer;
begin
  result := GetScripterVMTOffsetDataModule;
  if not AClass.InheritsFrom(TDataModule) then
    result := GetScripterVMTOffsetForm;
end;

{-----------------------------------------------------------}

function CreateGetScripterCode(Scripter : TDCScripter) : pointer;
begin
  GetMem(result, 6);
  pchar(result)^ := #$B8;                             // mov eax, Scripter
  PDWORD(pchar(result) + 1)^ := DWORD(Scripter);

  (pchar(result) + 5)^ := #$C3; // ret
end;

{-----------------------------------------------------------}

function CreateScriptUnitModuleClass(AncestorClass : TClass; const AClassName : string; Scripter : TDCScripter) : TClass;

  function getPPDWORD(addr : pointer) : DWORD;
  begin
    GetMem(PDWORD(result), sizeof(DWORD));
    PDWORD(result)^ := DWORD(addr);
  end;

var
  cresult  : PChar;
  cnamelen : integer;
  vmtsize  : word;
  InstSize    : DWORD;
  pClassName  : PChar;
  rcinfo      : TRegisteredClassInfo;
begin
  vmtsize := 4 * 1024;
  GetMem(cresult, -vmtSelfPtr + vmtsize + sizeof(integer) * 2); // refcount + scripter

  PDWORD(cresult)^ := DWORD(Scripter);
  inc(cresult, sizeof(DWORD));

  PInt(cresult)^ := 0;
  inc(cresult, sizeof(integer));

  move((pchar(AncestorClass) + vmtSelfPtr)^, (cresult {+ vmtSelfPtr})^, -vmtSelfPtr + vmtsize);

  inc(cresult, -vmtSelfPtr);
  PDWORD(integer(cresult) + getscripterVMTOffSet(AncestorClass))^ := DWORD(CreateGetScripterCode(Scripter));

  // classparent
  PDWORD(cresult + vmtParent)^ := GetPPDWORD(AncestorClass);
  result := TClass(cresult);

  InstSize := AncestorClass.InstanceSize;

  // instancesize
  PDWORD(cresult + vmtInstanceSize)^ := InstSize;

  // classname
  cnamelen := length(AClassName);
  GetMem(pClassName, cnamelen + 1);
  pClassName^ := char(cnamelen);

  if cnamelen > 0 then
    move(AClassName[1], (pClassName + 1)^, cnamelen);

  PDWORD(cresult + vmtClassName)^ := DWORD(pClassName);

  rcinfo := TRegisteredClassInfo.Create;
  rcinfo.RClass := result;
  fRegisteredClasses.Add(rcinfo);
end;

{-----------------------------------------------------------}

procedure DestroyScriptUnitModuleClass(AClass : TClass);
var
  cresult  : PChar;
  i        : integer;
begin
  if AClass = nil then
    exit;

  cresult := PChar(AClass);

  FreeMem(pointer(PDWORD(cresult + vmtClassName)^));
  FreeMem(pointer(PDWORD(integer(cresult) + getscripterVMTOffSet(AClass))^));
  FreeMem(pointer(PDWORD(cresult + vmtParent)^)); // classparent

  dec(cresult, -vmtSelfPtr + sizeof(integer) * 2);
  FreeMem(cresult);

  if fRegisteredClasses <> nil then
    with fRegisteredClasses do
      if Findbykey(AClass, i) then
        begin
          TObject(Items[i]).Free;
          Delete(i);
        end;
end;

{-----------------------------------------------------------}

procedure ScriptUnitModuleAddRef(AClass : TClass);
begin
  inc(PInt(pchar(AClass) + ScriptUnitModuleRefCountPtr)^);
end;

{-----------------------------------------------------------}

procedure ScriptUnitModuleRelease(AClass : TClass);
var
  prefcount : PInt;
  refcount  : integer;
begin
  if AClass = nil then
    exit;

  prefcount := PInt(pchar(AClass) + ScriptUnitModuleRefCountPtr);
  refcount := prefcount^ - 1;
  prefcount^ := refcount;
  if refcount = 0 then
    DestroyScriptUnitModuleClass(AClass);
end;

{-----------------------------------------------------------}

function ScriptUnitModuleScripter(AClass : TClass) : TDCScripter;
begin
  result := TDCScripter(PInt(pchar(AClass) + ScriptUnitModuleScripterPtr)^)
end;

{-----------------------------------------------------------}

procedure ScriptUnitModuleScripterDeleted(AClass : TClass);
begin
  PInt(pchar(AClass) + ScriptUnitModuleScripterPtr)^ := 0;
end;

{-----------------------------------------------------------}

procedure SetCompEventsHandlers(Owner : TComponent; sc : TScriptRunner; HookAllEvents : boolean; CompFiler : TCompFiler); forward;
procedure RestoreCompEvents(Owner : TComponent; EventHandler : TEventHandler); forward;

type
  TScriptUnitForm = class(TForm)
    function GetScripter : TDCScripter; virtual;

    constructor Create(AOwner : TComponent); override;
    procedure InheritedDestroy;
    {$IFDEF D4}
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    {$ENDIF}
    destructor  Destroy; override;
    procedure _Destroy;
  end;

{-----------------------------------------------------------}

function TScriptUnitForm.GetScripter : TDCScripter;
begin
  result := nil;
end;

{-----------------------------------------------------------}

{$IFDEF D4}
constructor TScriptUnitForm.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
  ScriptUnitModuleAddRef(ClassType);
  inherited;
end;
{$ENDIF}
{-----------------------------------------------------------}

constructor TScriptUnitForm.Create(AOwner : TComponent);
var
  scripter : TDCScripter;
begin
  CreateNew(AOwner);
  scripter := GetScripter;
  scripter.LoadUnitModule(self);
end;

{-----------------------------------------------------------}

procedure TScriptUnitForm.InheritedDestroy; assembler;
asm
  xor dl, dl
  call TForm.Destroy
end;

{-----------------------------------------------------------}

procedure TScriptUnitForm._Destroy;
var
  scripter : TDCScripter;
  scrun    : TScriptRunner;
begin
  scripter := ScriptUnitModuleScripter(ClassType);
  if scripter <> nil then
    begin
      scrun := scripter.ScriptRun;
      if scrun <> nil then
        RestoreCompEvents(self, scrun.DispatchMethod);
    end;

  {$IFNDEF D4}
  InheritedDestroy;
  {$ELSE}
  inherited Destroy;
  {$ENDIF}
end;

{-----------------------------------------------------------}

destructor TScriptUnitForm.Destroy;
asm
  push ebx
  mov  ebx, eax
  call _Destroy

  mov  eax, ebx
  mov  ebx, [ebx]
  call dword ptr [ebx].vmtFreeInstance

  mov  eax, ebx
  call ScriptUnitModuleRelease

  xor  dl, dl
  pop  ebx
end;

{-----------------------------------------------------------}
type
  TScriptUnitDataModule = class(TDataModule)
    function GetScripter : TDCScripter; virtual;

    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;

    procedure _Destroy;

    procedure InheritedDestroy;
  end;

{-----------------------------------------------------------}

procedure TScriptUnitDataModule.InheritedDestroy; assembler;
asm
  xor dl, dl
  call TDataModule.Destroy
end;

{-----------------------------------------------------------}

function TScriptUnitDataModule.GetScripter : TDCScripter;
begin
  result := nil;
end;

{-----------------------------------------------------------}

constructor TScriptUnitDataModule.Create(AOwner : TComponent);
var
  scripter : TDCScripter;
begin
  ScriptUnitModuleAddRef(ClassType);
  CreateNew(AOwner);
  scripter := GetScripter;
  scripter.LoadUnitModule(self);
end;

{-----------------------------------------------------------}

procedure TScriptUnitDataModule._Destroy;
var
  scripter : TDCScripter;
  scrun    : TScriptRunner;
begin
  scripter := ScriptUnitModuleScripter(ClassType);
  if scripter <> nil then
    begin
      scrun := scripter.ScriptRun;
      if scrun <> nil then
        RestoreCompEvents(self, scrun.DispatchMethod);
    end;

  {$IFNDEF D4}
  InheritedDestroy;
  {$ELSE}
  inherited Destroy;
  {$ENDIF}
end;

{-----------------------------------------------------------}

destructor TScriptUnitDataModule.Destroy;
asm
  push ebx
  mov  ebx, eax
  call _Destroy

  mov  eax, ebx
  mov  ebx, [ebx]
  call dword ptr [ebx].vmtFreeInstance

  mov  eax, ebx
  call ScriptUnitModuleRelease

  xor  dl, dl
  pop  ebx
{
  inherited;
  ScriptUnitModuleRelease(ClassType);}
end;

{-----------------------------------------------------------}

{$ENDIF WIN}

constructor TDCScripter.Create(AOwner : TComponent);
begin
  inherited;
  {$IFDEF THREADSAFE}
  InitializeCriticalSection(fInitScriptRunLock);
  {$ENDIF}
  fLinkEvents := true;
  fUseModule := true;
  fEvents := TEventItems.Create(self, TEventItem);
  fItems := TStringList.Create;
  fScript := TStringList.Create;
  fUserVars := TStringList.Create;
  fdlist := TList.Create;
  TStringList(fScript).OnChange := ScriptChange;
  fUsedList := TList.Create;
  funitsList := TStringList.Create;
  fLoadedUnitModules := TList.Create;
{$IFDEF WIN}
  fCompFiler := TCompFiler.Create;
  fObjectList := TIDEObjectList.Create(self, TIDEObjectListItem);
{$ENDIF}
  AddRef;
end;

{----------------------------------------------------------}

procedure TDCScripter.StopScripts;
var
  i : integer;
  scrun : TScriptRunner;
begin
  if ScriptFile = '.\MastApp_Script\EDOrders.pas' then
    Classname;

  if fInStopScripts then
    exit;

  fInStopScripts := true;

  KillCreatedModule;

  if (fRunInfo <> nil) then
    begin
      scrun := TRunInfo(fRunInfo).sc;
      if scrun <> nil then
        scrun.StopScript;
    end;

  for i := 0 to fUsedList.Count - 1 do
    with TDCScripter(fUsedList[i]) do
      if fRefCount <= 1 then
        StopScripts;
end;

{-----------------------------------------------------------}

procedure  TDCScripter.Finish;
begin
  StopScripts;
  UnHookEvents;
  Stop;
end;

{-----------------------------------------------------------}

procedure TDCScripter.KillCreatedModule;
var
  ModuleComp : TComponent;
begin
  if fModuleCreated then
    begin
      ModuleComp := fModule;
      fModule := nil;
      If ModuleComp<>nil then
        ModuleComp.Free;
      fModuleCreated := false;
      if fRunInfo <> nil then
        TRunInfo(fRunInfo).Module := nil;
    end;
end;

{-----------------------------------------------------------}

destructor  TDCScripter.Destroy;
var
  scrun : TScriptRunner;
begin
  if ScriptFile = '.\MastApp_Script\EDOrders.pas' then
    Classname;
  fInDestroy := true;
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
    if fLoadedModules <> nil then
      fLoadedModules.RemoveAll(self);

    if fLoadedScripts <> nil then
      fLoadedScripts.RemoveAll(self);
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}

  scrun := GetScriptRun;
  if scrun <> nil then
    scrun.fScripterDestroyed := true;

  Finish;
  FreeStrings(fItems);
  fScript.Free;
{$IFDEF WIN}
  fCompFiler.Free;
  fObjectList.Free;
{$ENDIF}
  fUsedList.Free;
  fEvents.Free;
  fUserVars.Free;
  fUnitsList.Free;

//  ScriptUnitModuleRelease(fScriptUnitModuleClass);
  fLoadedUnitModules.Free;
  fdlist.Free;
  IDEChanged;
  {$IFDEF THREADSAFE}
  DeleteCriticalSection(fInitScriptRunLock);
  {$ENDIF}
  inherited;
end;

{-----------------------------------------------------------}

procedure TDCScripter.BeginDesign;
var
  i : integer;
begin
  inc(fInDesign);
  for i := 0 to Events.Count - 1 do
    Events[i].UnHook;
end;

{-----------------------------------------------------------}

procedure TDCScripter.EndDesign;
begin
  dec(fInDesign);
  HookEvents;
end;

{-----------------------------------------------------------}

procedure   TDCScripter.CreateEvent(Instance : TComponent; const AEvent, AScriptMethod : string; ACallExisting : boolean);
var
  i : integer;
begin
  for i := 0 to Events.Count - 1 do
    with Events.Items[i] do
      if (Component = Instance) and
         (CompareText(Event, AEvent) = 0) and
         (CompareText(ScriptMethod, AScriptMethod) = 0) then
           exit;

  with TEventItem(Events.Add) do
    begin
      CallExisting := ACallExisting;
      Component := Instance;
      Event := AEvent;
      ScriptMethod := AScriptMethod;
    end;
end;

{-----------------------------------------------------------}

procedure   TDCScripter.RenameEvent(const OldName, NewName : string);
var
  i : integer;
begin
  for i := Events.Count - 1 downto 0 do
    with Events.Items[i] do
      if CompareText(ScriptMethod, OldName) = 0 then
        if NewName = '' then
          Free
        else
          ScriptMethod := NewName;
end;

{-----------------------------------------------------------}

procedure TDCScripter.EventDeleted;
var
  propinfo : PPropInfo;
  i        : integer;
begin
  for i := Events.Count - 1 downto 0 do
    with Events.Items[i] do
      if Component <> nil then
        begin
          propinfo := GetPropInfo(Component.ClassInfo, Event);
          if (propinfo <> nil) and (GetMethodProp(Component, propinfo).code = nil) then
            Free;
        end;
end;

{-----------------------------------------------------------}

function  TDCScripter.GetScriptVar(const VarName : string) : OleVariant;
begin
  if ScriptRun <> nil then
    result := ScriptRun.GetVarValue(VarName)
  else
    VarClear(result);
end;

{-----------------------------------------------------------}

procedure TDCScripter.SetScriptVar(const VarName : string; const Value : OleVariant);
begin
  if ScriptRun <> nil then
    ScriptRun.SetVarValue(VarName, Value);
end;

{-----------------------------------------------------------}

function  TDCScripter.GetUnitName : string;
begin
  result := ExtractOnlyName(ScriptFile);
end;

{-----------------------------------------------------------}

procedure TDCScripter.SetFileName(const val : TFileName);
begin
  if val <> fFileName then
    begin
      fFileName := val;
      fScriptChanged := true;
    end;
end;

{-----------------------------------------------------------}

function  TDCScripter.GetUsedModule(const ModuleName : string) : TDCScripter;
var
  i : integer;
begin
  for i := 0 to fUsedList.Count - 1 do
    if TDCScripter(fUsedList[i]).UnitName = ModuleName then
      begin
        result := TDCScripter(fUsedList[i]);
        exit;
      end;

  result := nil;
end;

{-----------------------------------------------------------}

{assumes that ScriptRun <> nil}
procedure TDCScripter.AddItemToScript(item : TItemInfo);
begin
  with TItemInfo(item) do
    GetScriptRun.AddItem(Name, Global, disp);
end;

{-----------------------------------------------------------}

procedure TDCScripter.AddObjectsToScript;
var
  sc : TScriptRunner;
  i  : integer;
begin
  sc := GetScriptRun;
  if sc <> nil then
    begin
      sc.fScripter := self;
      for i := 0 to fItems.Count - 1 do
        AddItemToScript(TItemInfo(fItems.Objects[i]));
    end;
end;

{-----------------------------------------------------------}

procedure TScriptRunner.AddGlobals;
var
  disp : IDispatch;
begin
  fGlobalwrapper := CreateCompWrapper;
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
    GlobalWrapList.Add(fGlobalwrapper);
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}

  TDCompWrapper(fGlobalwrapper).ScriptRun := self;
  TDCompWrapper(fGlobalwrapper).QueryInterface(IDispatch, disp);

  AddItem(GlobalScriptRunObject, true, disp);
  pointer(disp) := nil;
end;

{-----------------------------------------------------------}

function  TDCScripter.GetModule : TComponent;
begin
  if UseModule then
    begin
      result := fModule;

      if result = nil then
        result := self;

      {$IFDEF WIN}
      if not ((result is TCustomForm) or (result is TDataModule)) then
        result := GetTopOwner(result);
      {$ENDIF WIN}
    end
  else
    result := nil;
end;

{-----------------------------------------------------------}

procedure  TDCScripter.SetModule(val : TComponent);
begin
  if val <> fModule then
    begin
      fModule := val;
      val := GetModule;
      if val <> nil then
        val.FreeNotification(self);
    end;
end;

{-----------------------------------------------------------}

procedure TDCScripter.ScriptChange(Sender : TObject);
begin
  fScriptChanged := true;
end;

{-----------------------------------------------------------}

procedure TDCScripter.InterruptScript;
var
  sc : TScriptRunner;
begin
  sc := ScriptRun;
  if sc = nil then
    sc := fsccheck;

  if sc <> nil then
    sc.DoInterrupt;
end;

{-----------------------------------------------------------}

procedure TDCScripter.Stop;
var
  i           : integer;
  l           : TList;
begin
  if ScriptFile = '.\MastApp_Script\EDOrders.pas' then
    Classname;

  fCompiledScript := nil;
  fUserVars.Clear;
  if fRunInfo <> nil then
    begin
      l := TList.Create;
      try
        CopyList(fUsedList, l);
        for i := 0 to l.Count - 1 do
          TDCScripter(l[i]).Release;
      finally
        l.Free;
      end;

      for i := fLoadedUnitModules.Count - 1 downto 0 do
        UnloadUnitModule(fLoadedUnitModules[i]);

      FinishRun(fRunInfo);
      fUsedList.Clear;
      fRunInfo := nil;
    end;
end;

{-----------------------------------------------------------}

procedure TDCScripter.AddRef;
begin
  inc(fRefCount);
end;

{-----------------------------------------------------------}

procedure TDCScripter.Release;
begin
  dec(fRefCount);
  if (fRefCount = 0) and not fInDestroy then
    Destroy;
end;

{-----------------------------------------------------------}

procedure TDCScripter.Notification(AComponent: TComponent; Operation: TOperation);
var
  ModuleIsDestroyed : boolean;
  index : integer;
begin
  inherited;
  if Operation = opRemove then
    begin
      ModuleIsDestroyed := (AComponent <> Owner) and (AComponent = GetModule);
      index := fUsedList.IndexOf(AComponent);
      if index >= 0 then
        begin
          fUsedList.Delete(index);
          UnregisterUsedObjects(TDCScripter(AComponent));

          exit;
        end;

      if ModuleIsDestroyed and not ((Owner <> nil) and (csDestroying in Owner.ComponentState)) then
        begin
          fModuleCreated := false;
          if ScriptRun <> nil then
            ScriptRun.fDefaultObject := nil;

          if fProject <> 0 then
            if TDCScripter(fProject) = self then
              Destroy
            else
              Release
          else
            begin
              Finish;
              Module := nil;
            end;
        end
      else
        begin
          if ModuleIsDestroyed then
            Module := nil;

          if fLoadedUnitModules.IndexOf(AComponent) >= 0 then
            UnloadUnitModule(AComponent);
        end;
    end;
end;

{-----------------------------------------------------------}

procedure TDCScripter.Loaded;
begin
  inherited;
  if fLinkEvents then
    HookEvents;
end;

{-----------------------------------------------------------}
{$IFDEF WIN}
function TDCScripter.GetErrorString(const ExcepInfo : TExcepInfo;CharNo, LineNo : integer) : string;
begin
  with ExcepInfo do
    begin
      result := bstrSource;
      if result <> '' then
        result := result + #13#10;

      result := result + bstrDescription;
    end;

  if fFileName <> '' then
    AddStr(result, #13#10+ SFilePrefix + fFileName);

  AddStr(result, #13#10+Format(SErrCharPos,[LineNo + 1, CharNo + 1]));
    //'Line ' + IntToStr(LineNo) + ', Column ' + intToStr(CharNo));
end;
{$ENDIF WIN}
{------------------------------------------------------------------}

procedure TDCScripter.ScriptError(Sender : TObject; const ExcepInfo : TExcepInfo;
                          CharNo, LineNo : integer; var Handled : boolean);
{$IFDEF WIN}
var
  info : TScriptErrorInfo;
  form       : TComponent;
{$ENDIF WIN}

begin
  if Assigned(fOnError) then
    fOnError(Self, ExcepInfo, CharNo + 1, LineNo + 1, Handled)
  else if Assigned(GlobalScriptErrorHandler) then
    GlobalScriptErrorHandler(Self, ExcepInfo, CharNo, LineNo, Handled)
  else
    begin
{$IFDEF WIN}
      info.FileName := fFileName;
      info.FilerID := FilerID;
      info.CharPos := CharNo;
      info.LinePos := LineNo;
      info.ExcepInfo := ExcepInfo;
      BroadCastToNotifiers(self, CM_SCRIPTERROR, integer(@info), 0);

      if fHandlingError then
        handled := true
      else if fRunfailed then
        handled := false
      else
        if UseExceptions then
          Error(GetErrorString(ExcepInfo, CharNo, LineNo))
        else
          try
            fHandlingError := true;
            {$IFNDEF CLX}
            handled := MessageBox(0, PChar(GetErrorString(ExcepInfo, CharNo, LineNo) + #13#10#13#10 + SContinueExecution),
                   PChar(Application.Title), MB_OKCANCEL + MB_ICONSTOP + MB_TASKMODAL) = ID_OK;
            {$ELSE}
            handled := MessageDlg(GetErrorString(ExcepInfo, CharNo, LineNo) + #13#10#13#10 + SContinueExecution,
                                  mtError, mbYesNo, 0) = mrYes;
            {$ENDIF}
          finally
            fHandlingError := false;
          end;

      if handled then
        BroadCastToNotifiers(self, CM_SCRIPTERROR, integer(@info), 1);
{$ENDIF WIN}
    end;

   if not handled then
     begin
       fRunfailed := true;

       {$IFDEF WIN}

       {$IFDEF ACTIVESCRIPTING}
       if ScriptRun is TAxScriptRunner then
         TAxScriptRunner(ScriptRun).ScriptRun.aSite.fFailed:=true;
       {$ENDIF ACTIVESCRIPTING}

       if fModuleCreated then
         begin
           form := fCreatedModule;
           if form is TCustomForm then
             with TForm(form) do
               begin
                 {$IFDEF D4}
                 if fsModal in FormState then
                   ModalResult := mrAbort
                 else
                   Release;
                 {$ELSE}
                   Close;
                 {$ENDIF}
               end;
         end;
       {$ENDIF WIN}
     end;
//     else
//       Stop;
//      fProject.Free;
//  else
//    fProject.Release;
end;

{-----------------------------------------------------------}

{$IFDEF WIN}
function TDCScripter.CheckAutoCreateForm(const FileName : TFileName; S : TStream) : boolean;
var
  ancclass : TClass;
begin
  fModuleClassName := GetClassNameFromStream(S);
  ScriptUnitModuleRelease(fScriptUnitModuleClass);

  ancclass := TScriptUnitDataModule;
  if not StreamContainsDataModule(S) then
    ancclass := TScriptUnitForm;

  fScriptUnitModuleClass := TComponentClass(CreateScriptUnitModuleClass(ancclass, fModuleClassName, self));
  ScriptUnitModuleAddRef(fScriptUnitModuleClass);
      
  result := true;
  if Assigned(OnAutoCreateForm) then
    OnAutoCreateForm(self, FileName, fModuleClassName, result);

  if Assigned(GlobalOnAutoCreateForm) then
    GlobalOnAutoCreateForm(self, FileName, fModuleClassName, result);
end;

{-----------------------------------------------------------}

procedure TDCScripter.LoadUnitModule (AModule : TComponent);
var
  cfiler : TCompFiler;
  s      : TStream;
  fs     : TFileSystem;
begin
  s := nil;
  cfiler := TCompFiler.Create;
  try
    fs := GetFileSystem(fUnitFormFilerID);
    try
      if fs.FileExists(fUnitFormFileName) then
        begin
          s := fs.GetFileStream(fUnitFormFileName, DefaultOpenMode);
          cfiler.IgnoreDesignedForms := true;
          cfiler.LoadFromStream(S, AModule);
        end;
    finally
      s.Free;
      ReleaseFileSystem(fs);
    end;

    if ScriptRun <> nil then
      begin
        ScriptRun.AddItem(AModule.Name, true, GetModuleObjectDispatch(AModule));
        SetCompEventsHandlers(AModule, ScriptRun, fHookAllEvents, cfiler);
        CallCompOnCreate(AModule);
      end;  

    if Assigned(OnModuleLoaded) then
      OnModuleLoaded(self, AModule, cfiler.CompClassName);

    fLoadedUnitModules.Add(AModule);
    AModule.FreeNotification(self);
  finally
    cfiler.Free;
  end;
end;

{-----------------------------------------------------------}

procedure TDCScripter.UnloadUnitModule(AModule : TComponent);
begin
  if ScriptRun <> nil then
    RestoreCompEvents(AModule, ScriptRun.DispatchMethod);
  fLoadedUnitModules.Remove(AModule);
  ScriptUnitModuleScripterDeleted(AModule.ClassType);  
end;

{-----------------------------------------------------------}

function TDCScripter.LoadModule(const FilerID : TFilerID; const FileName : TFileName) : TComponent;
var
  s  : TStream;
  fs : TFileSystem;
  Hooked : boolean;
  fclass: TCustomFormClass;
begin
  s := nil;
  result := nil;
  fs := GetFileSystem(FilerID);
  try
    if fs.FileExists(FileName) then
      begin
        s := fs.GetFileStream(FileName, DefaultOpenMode);

        if CheckAutoCreateForm(FileName, S) then
          with fCompFiler do
            begin
              IgnoreDesignedForms := true;
              Hooked := SetFindGlobalCompProc(GlobalFindCompInTheSameModule);
              try
                fclass := TCustomFormClass(fScriptUnitModuleClass);

                if Assigned(fOnGetFormClass) then
                  fOnGetFormClass(self, fclass);

                if Assigned(GlobalOnGetFormClass) then
                  GlobalOnGetFormClass(self, fclass);

                result := CreateFromStream(S, fClass, false);
                {$IFNDEF D4}
                if fClass = fScriptUnitModuleClass then
                  ScriptUnitModuleAddRef(fClass);
                {$ENDIF}
              finally
                if Hooked then
                  RemoveFindGlobalCompProc;
              end;
            end;

        fUnitFormFilerID := FilerID;
        fUnitFormFileName := FileName;
      end;
  finally
    s.Free;
    ReleaseFileSystem(fs);
  end;

  if (result <> nil) and Assigned(OnModuleLoaded) then
    OnModuleLoaded(self, result, fCompFiler.CompClassName);
end;
{$ENDIF WIN}

{-----------------------------------------------------------}

function  TDCScripter.GetScriptRun : TScriptRunner;
begin
{  if fRunInfo <> nil then
    result := TRunInfo(fRunInfo).sc
  else
    result := nil;}
  result := TScriptRunner(fRunInfo);
  if result <> nil then
    result := TRunInfo(result).sc;
end;

{-----------------------------------------------------------}

procedure TDCScripter.AddItem(const Name : string; Global : boolean; const idisp : IDispatch);
var
  info : TItemInfo;
begin
  info := TItemInfo.Create;
  info.Name := Name;
  info.Global := Global;
  pointer(info.disp) := pointer(idisp);
//  info.disp := idisp;
  fItems.AddObject(Name, info);
  if GetScriptRun <> nil then
    AddItemToScript(info);
end;

{-----------------------------------------------------------}

procedure  TDCScripter.AddObjectToScript(Instance : TObject; const Name : string; Global : boolean);
begin
  AddItem(Name, Global, GetDispatch(Instance));
end;

{-----------------------------------------------------------}

procedure TDCScripter.RemoveItem(const Name : string);
var
  index : integer;
begin
  index := fItems.IndexOf(Name);
  if index >= 0 then
    begin
      TItemInfo(fItems.Objects[index]).Free;
      fItems.Delete(index);
    end;
  if ScriptRun <> nil then
    ScriptRun.RemoveItem(Name);  
end;

{-----------------------------------------------------------}

{$IFDEF WIN}
type
  TMCustomForm = class(TCustomForm)
  end;

procedure TDCScripter.HookClose;
begin
  if GetModule is TCustomForm then
    with TMCustomForm(GetModule) do
      begin
        fOldOnClose := OnClose;
        OnClose := CloseEvent;
      end;
end;

{-----------------------------------------------------------}

procedure TDCScripter.CloseEvent(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(fOldOnClose) then
    fOldOnClose(Sender, Action);
  if (Action <> caNone) and (TDCScripter(fProject) = self) then
    begin
      if fModuleCreated then
        begin
          Action := caFree;
          fModuleCreated := false;
        end;
//      Release;
    end;
end;

{$ENDIF WIN}

{-----------------------------------------------------------}

procedure TDCScripter.SetScript(val : TStrings);
begin
  fScript.Assign(val);
end;

{-----------------------------------------------------------}

function TDCScripter.LoadScript : boolean;
var
  fs : TFileSystem;
  S  : TStream;
  fm : TComponent;
begin
  if ScriptFile <> '' then
    begin
      s := nil;
      fs := GetFileSystem(FilerID);
      try
        s := fs.GetFileStream(ScriptFile, DefaultOpenMode);
        fScript.LoadFromStream(s);
      finally
        s.Free;
        ReleaseFileSystem(fs);
      end;

      {$IFDEF WIN}
      if fModule = nil then
        begin
          fModule := LoadModule(FilerID, ChangeFileExt(ScriptFile, '.dfm')); //don't resource
          fCreatedModule := fModule;
          fModuleCreated := true;
          fHookAllEvents := true;
        end;

      if fModule <> nil then
        fModule.FreeNotification(self);
      {$ENDIF}
    end;

    {$IFDEF WIN}
    with fCompFiler do
    {$ENDIF}
      begin
        {$IFDEF WIN}
        if UseModule then
          fm := GetModule
        else
        {$ENDIF}
          fm := nil;

        AddLoadedModule(self);

        try
          InitRun(GetScriptRunClass, fm, fModalRun, fScript, ScriptError, fHookAllEvents, self, fCompiledScript, {$IFDEF WIN}fCompFiler{$ELSE}nil{$ENDIF}, fModule);
        except
          RemoveLoadedModule(self);
          raise;
        end;

        result := fRunInfo <> nil;
        if not result then
          begin
            RemoveLoadedModule(self);
            exit;
          end;
      end;
    fScriptChanged := false;
    if fModule <> nil then
      begin
        {$IFDEF THREADSAFE}
        BeginSyncWrite;
        try
        {$ENDIF}
          fLoadedScripts.Add(self);
        {$IFDEF THREADSAFE}
        finally
          EndSyncWrite;
        end;
        {$ENDIF}
      end;
end;

{-----------------------------------------------------------}

function TDCScripter.GetUnitFileName(const UnitName : string;
            var AFilerID : TFilerID; var AFileName : TFileName) : boolean;
{$IFDEF WIN}
var
  i : integer;
{$ENDIF}
begin
  result := false;

  if Assigned(OnGetUnitFileName) then
    OnGetUnitFileName(self, UnitName, AFilerID, AFileName, result);

  {$IFDEF WIN}
  if result then
    exit;

  with ObjectList do
    for i := 0 to Count - 1 do
      with Items[i] do
        if CompareText(ShortName, UnitName) = 0 then
          begin
            AFilerID := FilerID;
            AFileName := FileName;
            result := true;
            exit;
          end;

  AFileName := AddSlash(ExtractFileDir(ScriptFile)) + AFileName;
  result := FileExists(AFileName);
  if not result then
    begin
      AFileName := ChangeFileExt(AFileName, ExtractFileExt(ScriptFile));
      result := FileExists(AFileName);
    end;
  {$ENDIF WIN}
end;

{-----------------------------------------------------------}

procedure TDCScripter.UnloadUnit(const UnitName : string);
var
  fname : TFileName;
  fid   : TFilerID;
  sc    : TDCScripter;
begin
  fname := UnitName;
  fid := FilerID;
  if not GetUnitFileName(UnitName, fid, fname) then
    exit;

  if FindLoadedModule(fid, fName, fProject, sc) then
    begin
      UnregisterUsedObjects(sc);
      sc.Release;
    end;
end;

{-----------------------------------------------------------}

procedure TDCScripter.UseUnit(const UnitName : string);
begin
  RegisterUsedObjects(LoadUnit(UnitName));
end;

{-----------------------------------------------------------}

function TDCScripter.LoadUnit(const UnitName : string) : TDCScripter;
var
  fname : TFileName;
  fid   : TFilerID;
begin
  fname := UnitName;
  fid := FilerID;
  result := nil;

  if Assigned(OnGetUnitScripter) then
    begin
      OnGetUnitScripter(self, UnitName, result);
      if result <> nil then
        exit;
    end;

  if not GetUnitFileName(UnitName, fid, fname) then
    begin
      //ErrorFmt(SErrUnitNotFound, [UnitName]);
      result := nil;
      exit;
    end;

  if FindLoadedModule(fid, fName, fProject, result) then
    result.AddRef
  else
    begin
      result := TDCScripter(TComponentClass(ClassType).Create(nil));
      with result do
        try
          fHookAllEvents := self.fHookAllEvents;
          ScriptFile := fname;
          FilerID := fid;

          fOnBeforeScriptInitialized := self.fOnBeforeScriptInitialized;
          fOnAfterScriptInitialized := self.fOnAfterScriptInitialized;

          {$IFDEF WIN}
          fObjectList.Assign(self.fObjectList);
          {$ENDIF}
          fProject := self.fProject;
          Run;
        except
          Free;
          raise;
        end;
    end;
  if result <> nil then
    begin
      result.FreeNotification(self);
      fUsedList.Add(result);
    end;
end;

{-----------------------------------------------------------}

function GetFileExt(const FileName : string) : string;
begin
  result := RemoveCharset(['.'], ExtractFileExt(FileName))
end;

{-----------------------------------------------------------}

procedure TDCScripter.RaiseScriptError(const ErrMsg : string);
var
  ExcepInfo : TExcepInfo;
  Handled   : boolean;
begin
  FillChar(ExcepInfo, sizeof(TExcepInfo), 0);
  ExcepInfo.bstrDescription := ErrMsg;
  if Assigned(fOnError) then
    begin
      Handled := false;
      fOnError(Self, ExcepInfo, -1, -1, Handled);
      if Handled then
        Abort;
    end;

  Error(ErrMsg);
end;

{-----------------------------------------------------------}

function TDCScripter.GetScriptRunClass : TScriptRunClass;
var
  ext     : string;
begin
  result := nil;
  if fLanguage <> '' then
    begin
      CheckRegItem;
      if fRegClassItem <> nil then
        result := TScriptRunClass(fRegClassItem.ClassPtr)
      else
        RaiseScriptError(Format(SErrNoScriptForLang, [fLanguage]));
    end
  else if ScriptFile <> '' then
    begin
      ext := GetFileExt(ScriptFile);
      result := GetScriptRunnerClass(ext);
      if result = nil then
        RaiseScriptError(Format(SErrNoScriptRunner, [ext]));
    end
  else
    Error(SErrScriptLanguageNotSpecified);
end;

{-----------------------------------------------------------}

function FileCanBeExecuted(const FileName:String):boolean;
begin
  result := GetScriptRunnerClass(GetFileExt(FileName)) <> nil;
end;

{-----------------------------------------------------------}

function TDCScripter.GetCodeDesignerClass : TCodeDesignerClass;
var
  ext     : string;
begin
  CheckRegItem;
  if fRegClassItem <> nil then
    ext := fRegClassItem.Params[SRunnerExtension]
  else
    ext := GetFileExt(ScriptFile);

  result := GetFormCodeDesignerClass(ext);
{
  if result = nil then
    raise Exception.CreateFmt(SErrNoCodeDesigner, [ext]);
}
end;

{-----------------------------------------------------------}

function  TDCScripter.GetDispatch(Instance : TObject) : IDispatch;
var
  l : TList;
begin
//  if fRunInfo = nil then
    l := fdlist;
//  else
//    l := TRunInfo(fRunInfo).wlist;

  result := GetObjectDispatch(Instance, l)
end;

{-----------------------------------------------------------}

function getusedscriptername(sc : TDCScripter) : string;
var
  pp : integer;
begin
  result := ExtractFileName(sc.ScriptFile);
  if result = '' then
    result := IntToStr(integer(sc))
  else
    begin
      pp := pos('.', result);
      if pp > 0 then
        delete(result, pp, MaxInt);
    end;
end;

{-----------------------------------------------------------}

procedure TDCScripter.UnregisterUsedObjects(Runner : TDCScripter);
var
  rmodule : TComponent;
  fname   : string;
begin
  rmodule := Runner.GetModule;
  if rmodule <> nil then
    RemoveItem(rmodule.name);

  fname := getusedscriptername(Runner);
  RemoveItem(fname);
  RemoveItem(fname + '_____'); //!!!!!!!
end;

{-----------------------------------------------------------}

procedure TDCScripter.RegisterUsedObjects(Runner : TDCScripter);
var
  fname   : string;
  rmodule : TComponent;
  fdisp   : IDispatch;
begin
  if Runner = nil then
    exit;

  with Runner do
    begin
      if RunFailed then
        begin
          self.fRunFailed := true;
          exit;
        end;

      if ScriptRun = nil then
        begin
          Run;

          if ScriptRun = nil then
            exit;
        end;
    end;

    with self.ScriptRun do
      begin
        rmodule := Runner.GetModule;
        if rmodule <> nil then
          AddItem(rmodule.name, false, GetDispatch(rmodule));

        fname := getusedscriptername(Runner);
        fdisp := Runner.ScriptRun.GetScriptDispatch;
        AddItem(fname, true, fdisp);

        //!!!!!!!
        TDCompWrapper(Runner.ScriptRun.fGlobalWrapper).QueryInterface(IDispatch, fdisp);
        AddItem(fname + '_____', true, fdisp);
//          RegisterClassInScript(Module.ClassType);
      end;
end;

{-----------------------------------------------------------}

function TDCScripter.Run : Variant;
begin
  result := CallNoParamsMethod('');

  {$IFDEF WIN}
  if not fRunFailed and (GetModule is TCustomForm) then
    with TCustomForm(GetModule) do
       if ModalRun then
         begin
           Hide;
           result := ShowModal;
         end;
  {$ENDIF WIN}
//       else
//         Show;
end;

{-----------------------------------------------------------}

procedure  TDCScripter.TraceInto;
var
  sc : TScriptRunner;
begin
  CreateScriptRunner;
  sc := ScriptRun;

  if sc <> nil then
    sc.TraceInto;
end;

{-----------------------------------------------------------}

function   TDCScripter.CurrentExecutionLine : integer;
var
  sc : TScriptRunner;
begin
  sc := ScriptRun;

  result := -1;
  if sc <> nil then
    result := sc.CurrentExecutionLine;
end;

{-----------------------------------------------------------}

procedure  TDCScripter.StepOver;
var
  sc : TScriptRunner;
begin
  CreateScriptRunner;
  sc := ScriptRun;
  if sc <> nil then
    sc.StepOver;
end;

{-----------------------------------------------------------}

procedure TDCScripter.HookEvents;
var
  i : integer;
  {$IFDEF ACTIVESCRIPTING}
  cmodule : TComponent;
  {$ENDIF}
begin
  if (csLoading in ComponentState) then
    exit;

  with Events do
    for i := 0 to Count - 1 do
      Items[i].Hook;

  {$IFDEF ACTIVESCRIPTING}
  cmodule := GetModule;
  if cmodule <> nil then
    with cmodule do
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TCustomDCOleControl then
          TCustomDCOleControl(Components[i]).OnEvent := _DispatchMethod;
  {$ENDIF ACTIVESCRIPTING}
end;

{-----------------------------------------------------------}

procedure TDCScripter.SetLinkEvents(val : boolean);
begin
  if fLinkEvents <> val then
    begin
      fLinkEvents := val;
      if val then
        HookEvents
      else
        UnHookEvents;
    end;
end;

{-----------------------------------------------------------}

procedure TDCScripter.SetEvents(val : TEventItems);
begin
  fEvents.Assign(val);
end;

{-----------------------------------------------------------}

procedure TDCScripter.UnHookEvents;
var
  i      : integer;
  module : TComponent;
begin
  with Events do
    for i := 0 to Count - 1 do
      Items[i].UnHook;

  module := GetModule;

  if module = nil then
    exit;

  {$IFDEF ACTIVESCRIPTING}
  with module do
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TCustomDCOleControl then
        TCustomDCOleControl(Components[i]).OnEvent := nil;
  {$ENDIF ACTIVESCRIPTING}
end;

{-----------------------------------------------------------}

procedure TDCScripter.CheckRegItem;
begin
  if (fLanguage <> '') then
    fRegClassItem := GetItemEx(TScriptRunner, [SRunnerDescription], [fLanguage], [cpIgnoreCase])
  else
    fRegClassItem := nil
end;

{-----------------------------------------------------------}

function TDCScripter.CheckSyntaxEx2(var ErrLine, ErrChar : integer; var ErrMessage : string; StrictCheck : boolean) : boolean;
var
  sc     : TScriptRunner;
  AClass : TScriptRunClass;
  i      : integer;
  modulecomp : TComponent;

begin
  result := false;
  AClass := GetScriptRunClass;
  if AClass = nil then
    exit;
  sc := AClass.Create(self, '');
  sc.Silent := true;
  sc.fStrictCheck := StrictCheck;
  try
    try
      fsccheck := sc;
      for i := 0 to fItems.Count - 1 do
        with TItemInfo(fItems.Objects[i]) do
          sc.AddItem(Name, Global, disp);

      modulecomp := GetModule;
      if modulecomp <> nil then
        with modulecomp do
          begin
            sc.AddItem(Name, true, GetObjectDispatch(modulecomp, nil));
            for i := 0 to ComponentCount - 1 do
              sc.AddItem(Components[i].Name, false, GetObjectDispatch(Components[i], nil));
          end;

      result := sc.ParseScript(Script.Text);
    finally
      fsccheck := nil;
      ErrLine := sc.fErrLine + 1;
      ErrChar := sc.fErrChar + 1;
      ErrMessage := sc.fErrMsg;
      sc.Free;
    end;
  except
    result := false;
  end;
end;

{-----------------------------------------------------------}

function TDCScripter.CheckSyntaxEx(var ErrLine, ErrChar : integer; StrictCheck : boolean) : boolean;
var
  tmp : string;
begin
  result := CheckSyntaxEx2(ErrLine, ErrChar, tmp, StrictCheck);
end;

{-----------------------------------------------------------}

function TDCScripter.CheckSyntax : boolean;
var
  errline : integer;
  errchar : integer;
begin
  result := CheckSyntaxEx(ErrLine, ErrChar, false);
end;

{-----------------------------------------------------------}

var
  ScriptLoadCount : integer = 0;

procedure StartScriptsLoading;
begin
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
    if ScriptLoadCount = 0 then
      fLoadedScripts.Clear;

    inc(ScriptLoadCount);
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

procedure FinishScriptsLoading;
{$IFDEF WIN}
var
  i : integer;
{$ENDIF}
begin
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
    dec(ScriptLoadCount);

    {$IFDEF WIN}
    if ScriptLoadCount = 0 then
      with fLoadedScripts do
        for i := 0 to Count - 1 do
          with TDCScripter(Items[i]) do
            if fModuleCreated then
              CallCompOnCreate(fModule);
    {$ENDIF}
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

function TDCScripter.GlobalFindCompInTheSameModule(const Name: string): TComponent;

  function CompIsOK(comp : TComponent) : boolean;
  var
    i : integer;
    scripter : TDCScripter;
  begin
    result := not (csDesigning in comp.ComponentState) and (CompareText(Name, comp.Name) = 0);
    if result then
      for i := 0 to fLoadedModules.Count - 1 do
        begin
          scripter := TDCScripter(fLoadedModules[i]);
          if (scripter.Module = comp) and (scripter.Project <> Project) then
            begin
              result := false;
              exit;
            end;
        end;
  end;

var
  i : integer;
begin
  for i := 0 to ScreenFormCount - 1 do
    begin
      result := ScreenForms(i);
      if CompIsOK(result) then
        exit;
    end;

  for i := 0 to Screen.DataModuleCount - 1 do
    begin
      result := Screen.DataModules[I];
      if CompIsOK(result) then
        exit;
    end;

  result := nil;
end;

{------------------------------------------------------------------}

procedure TDCScripter.ProcessUses;
var
  cdesignclass : TCodeDesignerClass;
  units2  : TStringList;
  i       : integer;
  Hooked  : boolean;
begin
  if fUsesProcessed then
    exit;

  if fCompiledScript = nil then
    begin
      fUnitsList.Clear;

      cdesignclass := GetCodeDesignerClass;
      if cdesignclass <> nil then
        begin
          units2 := TStringList.Create;
          with cdesignclass.Create(nil) do
            try
              Strings := fScript;
              GetUsedUnits(fUnitsList, true);
              GetUsedUnits(units2, false);
              for i := 0 to units2.Count - 1 do
                if fUnitsList.IndexOf(units2[i]) < 0 then
                  fUnitsList.Add(units2[i]);
            finally
              Free;
              units2.Free;
            end;
        end;
    end;

  try
    for i := 0 to fUnitsList.Count - 1 do
      if fRunFailed then
        break
      else
        UseUnit(fUnitsList[i]);
  finally
    Hooked := SetFindGlobalCompProc(GlobalFindCompInTheSameModule);
    try
      GlobalFixupReferences;
    finally
      if Hooked then
        RemoveFindGlobalCompProc;
    end;

    fusesprocessed := true;
  end;
end;

{-----------------------------------------------------------}

function TDCScripter.InitScriptRun : boolean;
begin
{$IFDEF THREADSAFE}
  EnterCriticalSection(fInitScriptRunLock);
  try
{$ENDIF}
    result := true;
    if ScriptRun = nil then
      begin
        StartScriptsLoading;
        try
          fusesprocessed := false;
          if not LoadScript then
            begin
              result := false;
              exit;
            end;

          ProcessUses;

          if (THandle(self) = fProject) or (fProject = 0) then
            if Assigned(FOnLastUnitLoaded) then
              FOnLastUnitLoaded (self);

        finally
          FinishScriptsLoading;
        end;
      end;
{$IFDEF THREADSAFE}
  finally
    LeaveCriticalSection(fInitScriptRunLock);
  end;
{$ENDIF}  
end;

{-----------------------------------------------------------}

procedure TDCScripter.CreateScriptRunner;
begin
  if fScriptChanged then
    Stop;

  InitScriptRun;
end;

{-----------------------------------------------------------}

function TDCScripter._DispatchMethod(MethodName : PChar; cArgs : integer; pArgs : PArgList) : Variant;
begin
  if fScriptChanged then
    Stop;

  fRunFailed := false;

  if Assigned(fOnBeforeScriptInitialized) then
    fOnBeforeScriptInitialized(Self);

  if not InitScriptRun then
     begin
       VarClear(result);
       fRunFailed := true;
       exit;
     end;

  if fRunFailed or (ScriptRun = nil) then
    VarClear(result)
  else
    begin
      if Assigned(fOnAfterScriptInitialized) then
        fOnAfterScriptInitialized(Self);

      result := ScriptRun.DispatchMethod(MethodName, cArgs, pArgs);
    end;
end;

{-----------------------------------------------------------}

function TDCScripter.CallNoParamsMethod(const MethodName : string) : Variant;
begin
  result := _DispatchMethod(PChar(MethodName), 0, nil);
end;

{-----------------------------------------------------------}

function TDCScripter.DispatchMethod(const MethodName : string; const pArgs : array of OleVariant) : Variant;
begin
  result := _DispatchMethod(PChar(MethodName), High(pArgs) - Low(pArgs) + 1, @pArgs);
end;

{-----------------------------------------------------------}

procedure _callOnGetUserVarIDevent(const VarName : string; Scripter : TDCScripter; var result : integer);
begin
  Scripter.OnGetUserVarID(VarName, result);
end;

{-----------------------------------------------------------}

function    TDCScripter.GetUserVarID(const VarName : string) : integer;
begin
  result := -1;
  if Assigned(OnGetUserVarID) then
    _callOnGetUserVarIDevent(VarName, self, result);

  if result <> -1 then
    result := fUserVars.AddObject(VarName, pointer(result));
end;

{-----------------------------------------------------------}

function    TDCScripter.GetUserVar(VarID : integer) : OleVariant;
begin
  if (VarID >= 0) and Assigned(OnGetUserVar) then
    with fUserVars do
      OnGetUserVar(Strings[VarID], integer(Objects[VarID]), result)
  else
    VarClear(result);
end;

{-----------------------------------------------------------}

function   TDCScripter.SetUserVar(VarID : integer; const Value : OleVariant) : HRESULT;
begin
  result := DISP_E_MEMBERNOTFOUND;
  if (VarID >= 0) and Assigned(OnSetUserVar) then
    with fUserVars do
      begin
        OnSetUserVar(Strings[VarID], integer(Objects[VarID]), Value);
        result := S_OK;
      end;
end;

{***********************************************************}

destructor TDCompWrapper.Destroy;
var
  l : TList;
begin
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
    if (fWrappObject <> nil) and not fIsClass then
      dcRemoveFreeNotification(fWrappObject, FreeNotification);

    if fAutoRelease then
      fWrappObject.Free;

    if fModuleMode then
      l := ModuleWrappersList
    else
      l := GlobalWrapList;

    if l <> nil then
      l.Remove(self);
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}
  inherited;
end;

{-----------------------------------------------------------}
(*
procedure TDCompWrapper.Notification(AComponent : TComponent; Operation : TOperation);
begin
  if (AComponent = WrappObject) and (Operation = opRemove) then
    Free;
end;
*)
{-----------------------------------------------------------}

procedure TDCompWrapper.SetAutoRelease;
begin
  fAutoRelease := true;
  dec(fRefCount);
end;

{-----------------------------------------------------------}

procedure TDCompWrapper.SetModuleMode;
begin
  fModuleMode := true;
end;

{-----------------------------------------------------------}

procedure TDCompWrapper.FreeNotification(Instance : TObject);
begin
  if Instance = CurrentModuleObject then
    CurrentModuleObject := nil;
  fLastName := '';
  fWrappObject := nil;
  _Release;
end;

{-----------------------------------------------------------}

procedure TDCompWrapper.SetWrappObject(val : TObject);
begin
  fWrappObject := val;
  if (val <> nil) and not IsRegisteredClass(val) then
    begin
      dcAddFreeNotification(val, FreeNotification);
      _AddRef;
    end;
end;

{-----------------------------------------------------------}

function TDCompWrapper.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  result := E_NOINTERFACE;
  if GetInterface(IID, Obj) then
    result := 0;
end;

{-----------------------------------------------------------}

function TDCompWrapper._AddRef: Longint;
begin
  Result := InterlockedIncrement(fRefCount);
end;

{-----------------------------------------------------------}

function TDCompWrapper._Release: Longint;
begin
  result := InterlockedDecrement(fRefCount);
  if result = 0 then
    Free;
end;

{-----------------------------------------------------------}

function TDCompWrapper.GetTypeInfoCount(out Count: Integer): HRESULT;
begin
  Count := 0;
  Result := S_OK;
end;

{-----------------------------------------------------------}

function TDCompWrapper.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HRESULT;
begin
  pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

{-----------------------------------------------------------}

function TDCompWrapper.UserVarID(const VarName : string) : integer;
var
  scrun : TScriptRunner;
  scripter : TDCScripter;
begin
  result := 0;
  scrun := ScriptRun;
  if scrun <> nil then
    begin
      scripter := scrun.fScripter;
      if scripter <> nil then
        result := -(1 + scripter.GetUserVarID(VarName));
    end;
  dec(result);
{
  if (ScriptRun <> nil) and (ScriptRun.fScripter <> nil) then
    result := -2 - ScriptRun.fScripter.GetUserVarID(VarName)
  else
    result := -1;
}
end;

{-----------------------------------------------------------}

procedure TDCompWrapper.GetUserVar(VarID : integer; pValue : POleVariant);
begin
  if (ScriptRun <> nil) and (ScriptRun.fScripter <> nil) then
    pValue^ := ScriptRun.fScripter.GetUserVar(-2 - VarID)
  else
    VarClear(pValue^);
end;

{-----------------------------------------------------------}

function TDCompWrapper.SetUserVar(VarID : integer; const Value : OleVariant) : HRESULT;
begin
  result := DISP_E_MEMBERNOTFOUND;
  if (ScriptRun <> nil) and (ScriptRun.fScripter <> nil) then
    result := ScriptRun.fScripter.SetUserVar(-2 - VarID, Value);
end;

{-----------------------------------------------------------}

function getidChildComponent(WrappObject : TObject; const Name : string) : integer;
var
  c : TComponent;
begin
  result := -1;
  if WrappObject is TComponent then
    begin
      c := TComponent(WrappObject).FindComponent(Name);
      if c <> nil then
        result := c.ComponentIndex + 1
    end;
end;

{-----------------------------------------------------------}

function GetPublishedPropertyID(WrappObject : TObject; const Name : string) : integer;
begin
  result := integer(WrappObject.ClassInfo);
  if result <> 0 then
    result := integer(GetPropInfo(pointer(result), Name));
end;

{-----------------------------------------------------------}

function GetRegID(RegList : TStringList; const Name : string) : integer;
var
  index : integer;
begin
  result := 0;
  if RegList <> nil then
    with RegList do
      if Find(Name, index) then
        result := integer(Objects[index]);
end;

{-----------------------------------------------------------}

function TDCompWrapper.GetIDsOfNames(const IID: TGUID; Names: Pointer;
                       cNames, LocaleID: Integer; DispIDs: Pointer): HRESULT;
var
  i          : integer;
  pname      : string;
  id         : integer;
  AClass     : TClass;
  index      : integer;
  WrapObj    : TObject;
  IsRegClass : boolean;
begin
  pname := WideCharToString(PWideChar(pointer(Names)^));

  if (fLastRegCount = RegisterCount) and (pname = fLastName) then
    begin
      PDispIDList(DispIDs)^[0] := fLastID;
      result := S_OK;
      exit;
    end;

  for i := 1 to cNames - 1 do
    PDispIDList(DispIDs)^[i] := -1;

  id := -1;

  if ScriptRun <> nil then
    begin
      id := integer(GetReservedMethodInfo(TScriptRunClass(ScriptRun.ClassType), pname));
      if id = 0 then
        begin
          id := UserVarID(pname);

          if id < 0 then
            with ScriptRun.Scripter do
              if CompareText(pname, fModuleClassName) = 0 then
                id := integer(fScriptUnitModuleClass);
        end;
    end
  else
    begin
      WrapObj := CurrentModuleObject;
      if not fModuleMode or (WrapObj = nil) or ((WrappObject <> nil) and (WrapObj.ClassType <> WrappObject.ClassType)) then
        WrapObj := WrappObject;

      if IsRegisteredClass(WrapObj) then
        IsRegClass := true
      else
        begin
          id := getidChildComponent(WrapObj, pname);
          IsRegClass := false;
        end;

      if id < 0 then
        begin
          AClass := TClass(WrapObj);
          if AClass <> nil then
            if not IsRegClass then
              AClass := WrapObj.ClassType;

          id := integer(GetMethodInfo(AClass, pname));

          if id = 0 then
            begin
              if (AClass <> nil) and not fIsClass then
            	id := GetPublishedPropertyID(WrapObj, pname);

              if id = 0 then
                begin
                  id := integer(GetPropertyInfo(AClass, pname));

                  if id = 0 then
                    begin
                      if RClassList <> nil then
                        with RClassList do
                          if Find(pname, index) then
                            id := integer(TRegisteredClassInfo(Objects[index]).rClass);

                      if id = 0 then
                        begin
                          id := GetRegID(RConstList, pname);

                          if id = 0 then
                            id := GetRegID(RVarList, pname);
                        end;
                    end;
                end;
            end;

          if id = 0 then
            dec(id);
        end;
    end;

  PDispIDList(DispIDs)^[0] := TDispID(id);

  result := DISP_E_UNKNOWNNAME;
  if id <> -1 then
    begin
      result := S_OK;
      fLastName := pname;
      fLastID := id;
      fLastRegCount := RegisterCount;
    end;
end;

{-----------------------------------------------------------}

function VarToFloat(const v : OleVariant) : double;
begin
  result := v;
end;

{-----------------------------------------------------------}

function VarToStr(const v : OleVariant) : string;
begin
  result := v;
end;

{-----------------------------------------------------------}

procedure CallScriptProc(Address : pointer; cArgs : integer; rgvarg : PVariantArgList; pResult : POleVariant);
begin
  pResult^ := TScriptProc(Address)(cArgs, rgvarg);
end;

{-----------------------------------------------------------}

procedure CallScriptMethod(Address : pointer; Instance : TObject; cArgs : integer; rgvarg : PVariantArgList; pResult : POleVariant);
begin
  pResult^ := TScriptMethod(Address)(Instance, cArgs, rgvarg);
end;

{-----------------------------------------------------------}

function TDCompWrapper.MethodCall(WrapObj : TObject; minfo : TMethodInfo; var Params : TDispParams;
                                  VarResult : POleVariant) : HRESULT;
var
  pv : POleVariant;
begin
  with minfo do
    if not (MethodType in [mtScriptProc, mtScriptMethod]) and (paramcount <> Params.cArgs) then
      result := DISP_E_BADPARAMCOUNT
    else
      with Params do
        begin
          result := S_OK;

          if VarResult <> nil then
            pv := VarResult
          else
            GetMem0(pv, sizeof(OleVariant));

          try
            if MethodType = mtScriptProc then
              CallScriptProc(Address, cArgs, rgvarg, VarResult)
            else if MethodType = mtScriptMethod then
              CallScriptMethod(Address, WrapObj, cArgs, rgvarg, VarResult)
            else
              CallMethod(WrapObj, minfo, cArgs, rgvarg, pv);
              
          finally
            if VarResult = nil then
              FreeMem(pv);
          end;
        end;
end;

{-----------------------------------------------------------}

function SetDefaultIndexedProperty(Instance : TObject; cArgs : integer;
                                    rgvarg : PArgList) : HRESULT;
var
  index : integer;
  AClass : TClass;
begin
  result := DISP_E_BADPARAMCOUNT;
  if Instance = nil then
    exit;

  AClass := Instance.ClassType;

  repeat
    with fRegisteredClasses do
      if Findbykey(AClass, index) then
         with Infos[index] do
           if (DefaultProp <> nil) then
             with DefaultProp do
               if cArgs = IndexCount + 1 then
                 begin
                   result := S_OK;
                   SetProc(Instance, rgvarg);
                 end;

    if AClass = nil then
      exit;

    AClass := AClass.ClassParent;

  until AClass = nil;
end;

{-----------------------------------------------------------}

function GetDefaultIndexedProperty(Instance : TObject; cArgs : integer;
           rgvarg : PArgList; VarResult : POleVariant) : HRESULT;
var
  index : integer;
  AClass : TClass;
begin
  result := DISP_E_BADPARAMCOUNT;
  if Instance = nil then
    exit;

  AClass := Instance.ClassType;

  repeat
    with fRegisteredClasses do
      if Findbykey(AClass, index) then
         with Infos[index] do
           if (DefaultProp <> nil) then
             with DefaultProp do
               if cArgs = IndexCount then
                 begin
                   result := S_OK;
                   VarResult^ :=  GetProc(Instance, rgvarg);
                   exit;
                 end;

    if AClass = nil then
      exit;

    AClass := AClass.ClassParent;

  until AClass = nil;
end;

{-----------------------------------------------------------}

function TDCompWrapper.PutDelphiProperty(WrapObj : TObject; info : pointer; var Params : TDispParams) : HRESULT;
var
  o : TObject;
  ordprop : integer;
begin
  result := S_OK;
  with PPropInfo(info)^ do
    if SetProc = nil then
      begin
        result := DISP_E_MEMBERNOTFOUND;
        exit;
      end
    else
      case PropType^.kind of
        tkInteger, tkEnumeration, tkSet, tkChar :
          begin
            ordprop := VarToInt(POleVariant(Params.rgvarg)^);
            if (PropType^ = TypeInfo(boolean)) and (ordprop <> 0) then
              ordprop := 1;

            SetOrdProp(WrapObj, info, ordprop);
          end;
        tkFloat:
          SetFloatProp(WrapObj, info, VarToFloat(POleVariant(Params.rgvarg)^));
        tkString, tkLString, tkWString:
          SetStrProp(WrapObj, info, VarToStr(POleVariant(Params.rgvarg)^));
        tkVariant :
          SetVariantProp(WrapObj, info, POleVariant(Params.rgvarg)^);
        tkClass:
          with Params do
            begin
              o := TObject(GetOrdProp(WrapObj, Info));

              if cArgs > 1 then
                result := SetDefaultIndexedProperty(o, cArgs, rgvarg)
              else
                with TVarData(POleVariant(Params.rgvarg)^) do
                  if vtype in [varNull, varDispatch] then
                    begin
                      if vtype = varNull then
                        o := nil
                      else
                        o := Disp2Object(IDispatch(vDispatch));

                      SetOrdProp(WrapObj, Info, integer(o));
                    end;
            end;
      end;
end;

{-----------------------------------------------------------}

function TDCompWrapper.PutRegProperty(WrapObj : TObject; info : pointer; var Params : TDispParams) : HRESULT;
begin
  with Params, TPropertyInfo(info) do
    begin
      if (Addr(SetProc) = nil) then
        result := DISP_E_MEMBERNOTFOUND
      else if cArgs = IndexCount + 1 then
        begin
          result := S_OK;
          SetProc(WrapObj, rgvarg);
        end
      else
        result := DISP_E_BADPARAMCOUNT
    end
end;

{-----------------------------------------------------------}

function TDCompWrapper.PutRegVar(WrapObj : TObject; info : pointer; var Params : TDispParams) : HRESULT;
var
  sproc : TPropSetProc;
begin
  sProc := TVarInfo(info).SetProc;
  if Assigned(sProc) then
     sProc(WrapObj, Params.rgvarg);

  result := S_OK;
end;

{-----------------------------------------------------------}

function TDCompWrapper.PutProperty(info : pointer; var Params : TDispParams) : HRESULT;
var
  WrapObj : TObject;
begin
  result := DISP_E_MEMBERNOTFOUND;
  WrapObj := _getWrapObj;
  if integer(info) = 0 then
    result := SetDefaultIndexedProperty(WrapObj, Params.cArgs, Params.rgvarg)
  else if LongRec(info).Hi <> 0 then
    if IsUserVarID(info) then
      result := SetUserVar(integer(info), POleVariant(Params.rgvarg)^)
    else if IsMethodInfo(info) then
      result := MethodCall(WrapObj, TMethodInfo(info), Params, nil)
    else if IsPropertyInfo(info) then
      result := PutRegProperty(WrapObj, info, Params)
    else if IsVarInfo(info) then
      result := PutRegVar(WrapObj, info, Params)
    else if IsConstInfo(info) then
      result := DISP_E_MEMBERNOTFOUND  // can't assign const
    else
      result := PutDelphiProperty(WrapObj, info, Params);
end;

{-----------------------------------------------------------}

function TDCompWrapper.GetDelphiProperty(WrapObj : TObject; info : pointer; var Params : TDispParams;
                                   VarResult : POleVariant) : HRESULT;
var
  o : TObject;
  ordprop : integer;
begin
  result := S_OK;

  with PPropInfo(info)^ do
    case PropType^.kind of
      tkInteger, tkEnumeration, tkSet, tkChar :
        begin
          ordprop := GetOrdProp(WrapObj, info);
          if (PropType^ = TypeInfo(boolean)) and (ordprop = 1) then
            ordprop := -1;

          VarResult^ := ordprop;
        end;
      tkFloat:
        VarResult^ := GetFloatProp(WrapObj, Info);
      tkString, tkLString, tkWString:
        VarResult^ := GetStrProp(WrapObj, Info);
      tkVariant :
        VarResult^ := GetVariantProp(WrapObj, Info);
      tkClass :
        with Params do
           begin
             o := TObject(GetOrdProp(WrapObj, Info));
             if o = nil then
               VarResult^ := NULL
             else if cArgs > 0 then
               result := GetDefaultIndexedProperty(o, cArgs, rgvarg, VarResult)
             else
               VarResult^ := VarFromInterface(GetObjectDispatch(TComponent(o), nil));
           end;

      else
        VarClear(VarResult^);
    end;
end;

{-----------------------------------------------------------}

function TDCompWrapper.GetRegProperty(WrapObj : TObject; info : pointer; var Params : TDispParams;
                                   VarResult : POleVariant) : HRESULT;
var
  instance : TObject;
begin
  with Params, TPropertyInfo(info) do
    begin
      if cArgs >= IndexCount then
        begin
          result := S_OK;
          VarResult^ := GetProc(WrapObj, rgvarg);
          if (cArgs > 0) and (IndexCount = 0) then
            begin
              instance := VarToObject(VarResult^);
              if instance <> nil then
                result := GetDefaultIndexedProperty(instance, cArgs, rgvarg, VarResult)
              else
                result := DISP_E_BADPARAMCOUNT
            end;
        end
      else
        result := DISP_E_BADPARAMCOUNT
    end
end;

{-----------------------------------------------------------}

function TDCompWrapper.GetRegVar(WrapObj : TObject; info : pointer; var Params : TDispParams;
                                    VarResult : POleVariant) : HRESULT;
begin
  VarResult^ := TVarInfo(info).GetProc(WrapObj, Params.rgvarg);
  result := S_OK;
end;

{-----------------------------------------------------------}

function TDCompWrapper.GetConst(info : pointer; var Params : TDispParams;
                                   VarResult : POleVariant) : HRESULT;
begin
  if Params.cArgs = 0 then
    begin
      result := S_OK;
      VarResult^ := TRegisteredConstInfo(info).Value;
    end
  else
    result := DISP_E_BADPARAMCOUNT; //!!!! const array
end;

{-----------------------------------------------------------}

function TDCompWrapper.IsUserVarID(info : pointer) : boolean;
begin
  result := false;
  case integer(info) of
    -64999 .. -2 : result := true;
  end;
//  result := (integer(info) < -1) and (integer(info) > -65000);
end;

{-----------------------------------------------------------}

function TDCompWrapper._getWrapObj : TObject;
begin
  result := CurrentModuleObject;
  if not fModuleMode or (result = nil) or ((WrappObject <> nil) and (result.ClassType <> WrappObject.ClassType)) then
    result := WrappObject;
end;

{-----------------------------------------------------------}

function TDCompWrapper.GetProperty(info : pointer; var Params : TDispParams;
                                   VarResult : POleVariant) : HRESULT;
var
  HasParams : boolean;
  obj       : TObject;
  WrapObj   : TObject;
begin
  result := S_OK;
  HasParams := Params.cArgs > 0;
  WrapObj := _getWrapObj;

  if integer(info) = 0 then
    with Params do
      if HasParams then
        result := GetDefaultIndexedProperty(WrapObj, cArgs, rgvarg, VarResult)
      else
        VariantFromObj(VarResult, WrapObj)
  else if IsRegisteredClass(info) then
    if HasParams then
      VariantFromObj(VarResult, TObject(integer(OleVariant(Params.rgvArg^[0]))))
    else
      VariantFromObj(VarResult, info)
  else if IsUserVarID(info) then
    GetUserVar(integer(info), VarResult)
  else if LongRec(info).Hi = 0 then
    begin
      obj := TComponent(WrapObj).Components[LongRec(info).Lo - 1];
      if HasParams then
        result := GetDefaultIndexedProperty(obj, Params.cArgs, Params.rgvArg, VarResult)
      else
        VariantFromObj(VarResult, obj)
    end
  else if IsMethodInfo(info) then
    result := MethodCall(WrapObj, TMethodInfo(info), Params, VarResult)
  else if IsPropertyInfo(info) then
    result := GetRegProperty(WrapObj, info, Params, VarResult)
  else if IsVarInfo(info) then
    result := GetRegVar(WrapObj, info, Params, VarResult)
  else if IsConstInfo(info) then
    result := GetConst(info, Params, VarResult)
  else
    result := GetDelphiProperty(WrapObj, info, Params, VarResult);
end;

{-----------------------------------------------------------}

function TDCompWrapper._InvokeGet2(DispID : TDispID; VarResult : POleVariant; var Params: TDispParams) : HRESULT;
var
  v : OleVariant;
begin
  result := GetProperty(PPropInfo(DispID), Params, @v);
end;

{-----------------------------------------------------------}

function TDCompWrapper._InvokeGet(DispID : TDispID; VarResult : POleVariant; var Params: TDispParams) : HRESULT;
begin
  if VarResult <> nil then
    result := GetProperty(PPropInfo(DispID), Params, VarResult)
  else
    result := _InvokeGet2(DispID, VarResult, params);
end;

{-----------------------------------------------------------}

function TDCompWrapper._Invoke(DispID: TDispID; Flags: Integer;
  var Params: TDispParams; VarResult: POleVariant; ExcepInfo: PExcepInfo;
  ArgErr: PInteger): HResult;
begin
  try
    result := DISP_E_MEMBERNOTFOUND;
    if integer(DispID) <> -1 then
      if Flags = DISPATCH_METHOD then
        result := _InvokeGet(DispID, VarResult, Params)
      else
        case Flags and not DISPATCH_METHOD of
          DISPATCH_PROPERTYGET : result := _InvokeGet(DispID, VarResult, Params);

          DISPATCH_PROPERTYPUT,
          DISPATCH_PROPERTYPUTREF,
          DISPATCH_PROPERTYPUT + DISPATCH_PROPERTYPUTREF :  result := PutProperty(PPropInfo(DispID), Params);
        end;
  except
    on E : Exception do
      begin
        Result := DISP_E_EXCEPTION;
        ExcepInfo.wCode := 9999;
        ExcepInfo.bstrDescription := E.Message;
        ExcepInfo.bstrSource := E.ClassName;
        ExcepInfo.dwHelpContext := E.HelpContext;
      end;
{    Application.HandleException(self);
    result := S_OK;}
  end;
end;

{-----------------------------------------------------------}

function TDCompWrapper.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
          Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
begin
  result := _Invoke(DispID, Flags, TDispParams(Params), POleVariant(VarResult), ExcepInfo, ArgErr);
end;

{------------------------------------------------------------------}

constructor TDCRecordWrapper.Create;
begin
  inherited;
  FDCompWrapper := TDCompWrapper.Create;
  FDCompWrapper.fWrappObject := self;
  FDCompWrapper.fAutoRelease := true;
//  FDCompWrapper.SetAutoRelease;
end;

{------------------------------------------------------------------}

destructor TDCRecordWrapper.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------}

function TDCRecordWrapper.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  result := E_NOINTERFACE;
  if GetInterface(IID, Obj) then
    result := 0;
//  Result := FDCompWrapper.QueryInterface(IID, Obj);
end;

{------------------------------------------------------------------}

function TDCRecordWrapper._AddRef: Integer;
begin
  Result := FDCompWrapper._AddRef;
end;

{------------------------------------------------------------------}

function TDCRecordWrapper._Release: Integer;
begin
  Result := FDCompWrapper._Release
end;

{------------------------------------------------------------------}

function TDCRecordWrapper.GetTypeInfoCount(out Count: Integer): HRESULT;
begin
  Result := IDispatch(FDCompWrapper).GetTypeInfoCount(Count);
end;

{------------------------------------------------------------------}

function TDCRecordWrapper.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HRESULT;
begin
  Result := IDispatch(FDCompWrapper).GetTypeInfo(Index, LocaleID, TypeInfo);
end;

{------------------------------------------------------------------}

function TDCRecordWrapper.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  cNames, LocaleID: Integer; DispIDs: Pointer): HRESULT;
begin
  Result := IDispatch(FDCompWrapper).GetIDsOfNames(IID, Names, cNames, LocaleID, DispIDs);
end;

{------------------------------------------------------------------}

function TDCRecordWrapper.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; stdcall;
begin
  Result := IDispatch(FDCompWrapper).Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr);
end;

{------------------------------------------------------------------}

procedure RestoreCompEvents(Owner : TComponent; EventHandler : TEventHandler);
var
  i : integer;
begin
  if Owner = nil then
    exit;

  {$IFDEF ACTIVESCRIPTING}
  if Owner is TCustomDCOleControl then
    TCustomDCOleControl(Owner).OnEvent := nil
  else
  {$ENDIF}
    begin
      RestoreMyEventHandlers(Owner, EventHandler);
      EventRestorer.RemoveHookedComponent(Owner);
    end;

  with Owner do
    for i := 0 to ComponentCount - 1 do
      RestoreCompEvents(Components[i], EventHandler);
end;

{-----------------------------------------------------------}

procedure FinishRun(info : TRunInfo);
var
  globwrapper : TDCompWrapper;
begin
  if Assigned(info) then
    with info do
      begin
        {
         if Module is TCustomForm then
           with TCustomForm(Module) do
             if Modal then
               Show;
        }

        if sc <> nil then
         begin
           RestoreCompEvents(Module, sc.DispatchMethod);
           sc.DoneGlobals;
           globwrapper := TDCompWrapper(sc.fGlobalWrapper);
           if globwrapper <> nil then
             globwrapper.ScriptRun := nil;
           sc.FreeRunner;
           sc := nil;
           globwrapper._Release;
         end;

        FreeList(wlist,wlist);

//        SysFreeString(wc);
        Free;
      end;
end;

{-----------------------------------------------------------}

procedure _SetCompEvents(Owner : TComponent; sc : TScriptRunner; HookAllEvents : boolean);
var
  i : integer;
begin
  if Owner = nil then
    exit;

  if HookAllEvents then
    {$IFDEF ACTIVESCRIPTING}
    if Owner is TCustomDCOleControl then
      with TCustomDCOleControl(Owner) do
        OnEvent := sc.DispatchMethod
    else
    {$ENDIF ACTIVESCRIPTING}
      begin
        AssignEventHandlers(Owner, sc.DispatchMethod, true);
        EventRestorer.AddHookedComponent(Owner);
      end;

  with Owner do
    for i := 0 to ComponentCount - 1 do
      _SetCompEvents(Components[i], sc, HookAllEvents);
end;

{-----------------------------------------------------------}

procedure SetCompEventsHandlers(Owner : TComponent; sc : TScriptRunner; HookAllEvents : boolean; CompFiler : TCompFiler);
begin
  {$IFDEF WIN}
  if CompFiler <> nil then
    CompFiler.BeginMethodTrick(Owner, false);

  try
  {$ENDIF}

    _SetCompEvents(Owner, sc, HookAllEvents);

  {$IFDEF WIN}
  finally
    if CompFiler <> nil then
      CompFiler.EndMethodTrick(Owner);
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

function InitRun(ScriptClass : TScriptRunClass; AModule : TComponent;
                    AModal : boolean; Script : TStrings; ErrorProc : TScriptErrorHandler;
                    HookAllEvents : boolean; AScripter : TDCScripter;
                    CompiledScript : TStream; CompFiler : TCompFiler; fModule : TComponent) : TRunInfo;

  {---------------------------}
var
  disp : IDispatch;
  mdisp : IDispatch;
  malias : string;
  dname  : string;
begin
  result := TRunInfo.Create;
  with result do
    try
      try
        Module := AModule;
        Modal := AModal;
        wlist := TList.Create;
        if AScripter <> nil then
          dname := AScripter.GetDisplayScriptName
        else
          dname := '';

        sc := ScriptClass.Create(AScripter, dname);
        with sc do
          begin
            fDefaultObject := AModule;

            OnError := ErrorProc;

            disp := GetObjectDispatch(nil, nil);
            AddItem(GlobalScriptObject, true, disp);
            //pointer(disp) := nil;
            AddGlobals;

            if Scripter <> nil then
              begin
                Scripter.fRunInfo := result;
                Scripter.AddObjectsToScript;
              end;

            if Module <> nil then
              begin
                mdisp := GetModuleObjectDispatch(Module);
                sc.AddItem(Module.Name, true, mdisp);

                malias := sc.GetModuleAlias;
                if malias <> '' then
                  begin
                    sc.AddItem(malias, false, mdisp);
                    //mdisp._Release;
                  end;
              end;

            if CompiledScript = nil then
              begin
                if not ParseScript(Script.Text) then
                  begin
                    FinishRun(result);
                    pointer(mdisp) := nil;
                    result := nil;
                    exit;
                  end;
              end
            else
              LoadFromStream(CompiledScript);

            SetCompEventsHandlers(fModule, sc, HookAllEvents, CompFiler);
          end;
      except
        FinishRun(result);
        pointer(mdisp) := nil;
        result := nil;
        raise;
      end;
    finally
      if AScripter <> nil then
        AScripter.fRunInfo := result;
    end;
end;

{-----------------------------------------------------------}

procedure RunModule(ScriptClass : TScriptRunClass; Module : TComponent;
                    Modal : boolean; Script : TStrings; ErrorProc : TScriptErrorHandler);
var
  rinfo : TRunInfo;
begin
  rinfo := InitRun(ScriptClass, Module, Modal, Script, ErrorProc, false, nil, nil, nil, nil);
  if rinfo <> nil then
    try
      {$IFDEF WIN}
      if Modal and (Module is TCustomForm) then
        with TCustomForm(Module) do
          begin
            Hide;
            ShowModal;
          end;
      {$ENDIF}
    finally
      FinishRun(rinfo);
    end;
end;

{***********************************************************}

function  TScriptRunner.Run : Variant;
begin
  result := DispatchMethod('', 0, nil);
end;

function  TScriptRunner.EvaluateExpression(const Expr : string) : OleVariant;
begin
  result := 1;
end;

{***********************************************************}

type
  TVarArray = array [0..1] of Variant;
  PVarArray = ^TVarArray;

type
  TMStream = class(TMemoryStream)
  end;

{-----------------------------------------------------------}

function IsEventCode(event : pointer) : boolean;
var
  i : integer;
begin
  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
  {$ENDIF}
    result := AssignedEventsList.Find(event, i);
  {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

function _getEventParam(Event : pointer; index : integer) : pointer;
var
  pi : PInt;
begin
  if LongRec(Event).Hi <> 0 then
    begin
      pi := PInt(integer(Event) - sizeof(integer) * index);
      result := pointer(pi^);
    end
  else
    result := nil;
end;

{-----------------------------------------------------------}

function GetNewEventCode(Event : pointer) : pointer;
begin
  result := _geteventparam(Event, 4);
end;

{-----------------------------------------------------------}

function GetOldEventCode(Event : pointer) : pointer;
begin
  result := _geteventparam(Event, 1);
end;

{-----------------------------------------------------------}

procedure FreeEventCode(Event : pointer);
var
  pi : PInt;
begin
  if LongRec(Event).Hi <> 0 then
    begin
      pi := PInt(integer(Event) - sizeof(integer) * 2);
      TMemoryStream(pi^).Free;
      {$IFDEF THREADSAFE}
      BeginSyncWrite;
      try
      {$ENDIF}
        AssignedEventsList.Remove(Event);
      {$IFDEF THREADSAFE}
      finally
        EndSyncWrite;
      end;
      {$ENDIF}
    end;
end;

{-----------------------------------------------------------}

procedure _restoreoldevent(Instance : TPersistent; PropInfo : PPropInfo; Permanent : boolean);
var
  M : TMethod;
  event : pointer;
begin
  M := GetMethodProp(Instance, PropInfo);
  event := M.Code;
  if event = nil then
    exit;

  if not IsEventCode(event) or (not Permanent and IsEventPermanent(event)) then
    exit;

  M.Code := GetOldEventCode(event);
  SetMethodProp(Instance, PropInfo, M);
  FreeEventCode(event);
end;

{-----------------------------------------------------------}

procedure RestoreOldEvent(Instance : TPersistent; PropInfo : PPropInfo);
begin
  _restoreOldEvent(Instance, PropInfo, false);
end;

{-----------------------------------------------------------}

procedure RestoreOldEventHandler(Instance : TPersistent; PropInfo : PPropInfo);
begin
  _restoreOldEvent(Instance, PropInfo, true);
end;

{-----------------------------------------------------------}

type
  TPropsClass = class
  private
    fEventHandler : TEventHandler;
    fCallInherited : boolean;
    fForceRestore  : boolean;
  public
    procedure PropIterator(Instance : TPersistent; PropInfo : PPropInfo; UserData : integer);
    procedure PropIterator2(Instance : TPersistent; PropInfo : PPropInfo; UserData : integer);
    constructor Create(Instance : TPersistent; EventHandler : TEventHandler;
                              CallInherited : boolean; CreateMode : boolean; ForceRestore : boolean);
  end;

{-----------------------------------------------------------}

procedure TPropsClass.PropIterator(Instance : TPersistent; PropInfo : PPropInfo;UserData:Integer);
begin
  CreateEvent(Instance, PropInfo, fEventHandler, fCallInherited);
end;

{-----------------------------------------------------------}

procedure TPropsClass.PropIterator2(Instance : TPersistent; PropInfo : PPropInfo; UserData : Integer);
begin
  if Assigned(fEventHandler) and
     (GetNewEventCode(GetMethodProp(Instance, PropInfo).Code) <> addr(fEventHandler)) then
    exit;

  if fForceRestore then
    RestoreOldEventHandler(Instance, PropInfo)
  else
    RestoreOldEvent(Instance, PropInfo);
end;

{-----------------------------------------------------------}

constructor TPropsClass.Create(Instance : TPersistent; EventHandler : TEventHandler;
                              CallInherited : boolean; CreateMode : boolean; ForceRestore : boolean);
begin
  fEventHandler := EventHandler;
  fCallInherited := CallInherited;
  fForceRestore := ForceRestore;

  if CreateMode then
    IterateProps(Instance, tkMethods, PropIterator, false, 0)
  else
    IterateProps(Instance, tkMethods, PropIterator2, false, 0);
end;

{-----------------------------------------------------------}

procedure AssignEventHandlers(Instance : TPersistent; EventHandler : TEventHandler;
                              CallInherited : boolean);
begin
  with TPropsClass.Create(Instance, EventHandler, CallInherited, true, false) do
    Free;
end;

{-----------------------------------------------------------}

procedure RestoreMyEventHandlers(Instance : TPersistent; EventHandler : TEventHandler);
begin
  with TPropsClass.Create(Instance, EventHandler, false, false, false) do
    Free;
end;

{-----------------------------------------------------------}

procedure RestoreEventHandlers(Instance : TPersistent);
begin
  with TPropsClass.Create(Instance, nil, false, false, false) do
    Free;
end;

{-----------------------------------------------------------}

function CreateEventHandler(Instance : TPersistent; const EventName : string;
          EventHandler : TEventHandler; CallInherited : boolean; const HandlerName : string) : pointer;
var
  pinfo : PPropInfo;
  pti   : PTypeInfo;
begin
  result := nil;
  if Instance = nil then
    exit;

  pinfo := GetPropInfo(Instance.ClassInfo, EventName);
  if pinfo = nil then
    exit;

  pti := pinfo.PropType^;
  if pti.kind <> tkMethod then
    exit;

  result := CreateHandler(Instance, pinfo, EventHandler, CallInherited, HandlerName);
end;

{-----------------------------------------------------------}

function CreateEventCode(Instance : TPersistent; const EventName : string;
                         EventHandler : TEventHandler; CallInherited : boolean) : pointer;
begin
  result := CreateEventHandler(Instance, EventName, EventHandler, CallInherited, '');
end;

{-----------------------------------------------------------}

function CreateHandler(Instance : TPersistent; Event : PPropInfo;
           EventHandler : TEventHandler; CallInherited : boolean; const HandlerName : string) : pointer;
var
  M : TMethod;
  mname : string;
  minfo : TMethodInfo;
  index : integer;
begin
  result := nil;
  M := GetMethodProp(Instance, Event);

  mname := HandlerName;

  if mname = '' then
    begin
      if M.Data = nil then
        exit;

      mname :=  TObject(M.Data).MethodName(M.Code);
      if mname = '' then
        exit;
    end;

  if EventsList.FindByKey(Event.PropType^, index) then
    minfo := TEventInfo(EventsList[index]).MethodInfo
  else
    begin
      if DCShowWarnIfNoEventType then
        ShowMessage('Event '+Event.PropType^.Name+' is not registered with RegisterEvent');
      exit;
    end;

  result := MakeCode(Instance, mname, minfo, M, EventHandler, (LongRec(M.Code).Hi <> 0) and CallInherited);
  M.Code := result;
  SetMethodProp(Instance, Event, M);
  {$IFDEF THREADSAFE}
  BeginSyncWrite;
  try
  {$ENDIF}
    AssignedEventsList.Add(result);
  {$IFDEF THREADSAFE}
  finally
    EndSyncWrite;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

function CreateEvent(Instance : TPersistent; Event : PPropInfo;
                     EventHandler : TEventHandler; CallInherited : boolean) : pointer;
begin
  result := CreateHandler(Instance, Event, EventHandler, CallInherited, '');
end;

{-----------------------------------------------------------}

procedure HookAllEvents(AComp : TComponent; Scripter : TDCScripter);
var
  i : integer;
begin
  AssignEventHandlers(AComp, Scripter._DispatchMethod, True);
  with AComp do
    for i := 0 to ComponentCount - 1 do
      HookAllEvents(Components[i], Scripter);
end;

{-----------------------------------------------------------}

procedure UnhookAllEvents(AComp : TComponent);
var
  i : integer;
begin
  //RestoreEventHandlers(AComp);
  with TPropsClass.Create(AComp, nil, false, false, true) do
    Free;

  with AComp do
    for i := 0 to ComponentCount - 1 do
      UnhookAllEvents(Components[i]);
end;

{-----------------------------------------------------------}

procedure FreeVariant(var v : OleVariant);
begin
  VarClear(v);
{   with TVarData(v) do
    if vType = varOleStr then
      SysFreeString(vOleStr);}
end;

{-----------------------------------------------------------}

procedure VarToRefVar(var v : Variant);
var
  vp : pointer;
begin
  GetMem(vp, sizeof(Variant));
  move(v, vp^, sizeof(Variant));
  TVarData(v).vType := varByRef + varVariant;
  TVarData(v).vPointer := vp;
end;

{-----------------------------------------------------------}

procedure RefVarToVar(var v : Variant);
var
  vp : pointer;
begin
  vp := TVarData(v).vPointer;
  Move(vp^, v, sizeof(Variant));
  FreeMem(vp);
end;

{-----------------------------------------------------------}

procedure _SetCurrentModuleObject(AModuleObject : TComponent);
begin
  CurrentModuleObject := AModuleObject;
end;

{-----------------------------------------------------------}

function MakeCode(Instance : TPersistent; const EventName : string;
                  MethodInfo : TMethodInfo; const M : TMethod;
                  EventHandler : TEventHandler; CallInherited : boolean) : pointer;
var
  Code : TWriter;
  S    : TMemoryStream;

  {-------------------------------}

  procedure writebyte(b : byte);
  begin
    Code.Write(b, 1);
  end;

  {-------------------------------}

  function CurPosition : pchar;
  begin
    result := pchar(s.Memory) + Code.Position;
  end;

  {-------------------------------}

  procedure _RET;
  begin
    WriteByte($C3);
  end;

  {-------------------------------}

  procedure PutInt(p : integer);
  var
    i : integer;
  begin
    for i := 1 to 4 do
      begin
        WriteByte(p);
        p := p shr 8;
      end;
  end;

  {-------------------------------}

  procedure _PUSH(i : integer);
  begin
    WriteByte($68);
    PutInt(i);
  end;

  {-------------------------------}

  procedure _RETP(stack : word);
  begin
    WriteByte($C2);
    WriteByte(Lo(stack));
    WriteByte(Hi(stack));
  end;

  {-------------------------------}

  procedure _MOVEAX(i : integer);
  begin
    WriteByte($B8);
    PutInt(i);
  end;

  {-------------------------------}

  procedure _MOVEDX(i : integer);
  begin
    WriteByte($BA);
    PutInt(i);
  end;

  {-------------------------------}

  procedure _MOVECX(i : integer);
  begin
    WriteByte($B9);
    PutInt(i);
  end;

  {-------------------------------}

  procedure _JMP(p : pointer);
  begin
    WriteByte($E9);
    PutInt(integer(p) - integer(CurPosition) - 4);
  end;

  {-------------------------------}

  procedure _CALL(p : pointer);
  begin
    WriteByte($E8);
    PutInt(integer(p) - integer(CurPosition) - 4);
  end;

  {-------------------------------}

  procedure _PushEBX;
  begin
    WriteByte($53);
  end;

  {-------------------------------}

  procedure _PushECX;
  begin
    WriteByte($51);
  end;

  {-------------------------------}

  procedure _PushEDX;
  begin
    WriteByte($52);
  end;

  {-------------------------------}

  procedure _POPEAX;
  begin
    WriteByte($58);
  end;

  {-------------------------------}

  procedure _POPEDX;
  begin
    WriteByte($5A);
  end;

  {-------------------------------}

  procedure _PUSHEAX;
  begin
    WriteByte($50);
  end;

  {-------------------------------}

  procedure _MOVEAXEDX;
  begin
    WriteByte($8B);
    WriteByte($C2);
  end;

  {-------------------------------}

  procedure _MOVEAXPESP(offs : byte); // mov eax, [esp + offs]
  begin
    WriteByte($8B);
    WriteByte($44);
    WriteByte($24);
    WriteByte(offs);
  end;

  {-------------------------------}

  procedure _MOVEAXPEAX; // mov EAX, [EAX]
  begin
    WriteByte($8B);
    WriteByte($00);
  end;

  {-------------------------------}

  procedure _ORPEAX(i : integer); // or [EAX], i
  begin
    WriteByte($81);
    WriteByte($08);
    PutInt(i);
  end;

  {-------------------------------}

  procedure _PUSHA;
  begin
    writebyte($60);
  end;

  {-------------------------------}

  procedure _POPA;
  begin
    writebyte($61);
  end;

  {-------------------------------}

  procedure _MOVEAXESP;
  begin
    writebyte($8B);
    writebyte($C4);
  end;

  {-------------------------------}

  procedure _MOVEDXESP;
  begin
    writebyte($89);
    writebyte($E2);
  end;

  {-------------------------------}

  procedure _XOREAXEAX;
  begin
    writebyte($33);
    writebyte($C0);
  end;

  {-------------------------------}

  procedure _XORECXECX;
  begin
    writebyte($33);
    writebyte($C9);
  end;

  {-------------------------------}

  procedure _MOVPEDX(ofs, i : integer); // mov [edx + ofs], i
  begin
    writebyte($C7);
    if ofs = 0 then
      writebyte($02)
    else
      begin
        writebyte($42);
        writebyte(byte(ofs));
      end;
    putint(i);
  end;

  {-------------------------------}

  procedure _MOVPEDXECX(ofs : integer); // mov [edx + ofs], ecx
  begin
    writebyte($89);
    if ofs = 0 then
      writebyte($0A)
    else
      begin
        writebyte($4A);
        writebyte(byte(ofs));
      end;
  end;

  {-------------------------------}

  procedure _MOVMEAX(addr : integer); // mov [addr], eax
  begin
    writebyte($A3);
    putint(addr);
  end;

  {-------------------------------}

  procedure _MOVMECX(addr : integer); // mov [addr], ecx
  begin
    writebyte($89);
    writebyte($0D);
    putint(addr);
  end;

  {-------------------------------}

  procedure _MOVEAXM(addr : integer); // mov eax, [addr]
  begin
    writebyte($A1);
    putint(addr);
  end;

  {-------------------------------}

  procedure _MOVEDXEAX; // mov edx, eax
  begin
    writebyte($8B);
    writebyte($D0);
  end;

  {-------------------------------}

  procedure _ADDEAX(val : integer);
  begin
    writebyte($05);
    putint(val);
  end;

  {-------------------------------}

  procedure _LEAEAXESP(ofs : integer); // lea eax, [esp + ofs]
  begin
    if ofs < $7E then
      begin
        writebyte($8D);
        if ofs = 0 then
          begin
            writebyte($04);
            writebyte($24); // lea eax, [esp]
          end
        else
          begin
            writebyte($44);
            writebyte($24);
            writebyte(ofs);
          end;
      end
    else
      begin
        _MOVEAXESP;
        if ofs > 0 then
          _ADDEAX(ofs);
      end;
  end;

  {-------------------------------}

var
  i : integer;
  stacksize : integer;
  stackpos  : integer;
  RegisterCount : integer;
  CodeStart : pchar;
  evname    : pchar;
  parg      : pointer;
  pvars     : pointer;
  pcount    : integer;
  carg      : PVariant;
  presult   : pchar;
  EDXParam  : integer;
  ECXParam  : integer;
//  EAXParam  : integer;
  {-----------------------------}

  procedure WriteInfo;
  var
    v : OleVariant;
    vc : integer;
  begin
    with Code do
      begin
        evname := CurPosition;
        Write(EventName[1], length(EventName) + 1);

        pvars := CurPosition;
        
        for vc := 1 to pcount do
          Write(i, 4);

        parg := CurPosition;
        VarClear(v);
        for vc := 1 to pcount do
          Write(v, sizeof(OleVariant));

        presult := CurPosition;
        Write(v, sizeof(OleVariant));
        Write(TMethod(EventHandler).Code, sizeof(pointer));
        i := 0;
        Write(i, 4);
        Write(S, 4);
        Write(M.Code, 4);
        codestart := CurPosition;
      end;
  end;

  {-----------------------------}

  function getrealsize(const Param : TParamRec) : integer;
  begin
    with Param do
      if (PSize = RealStringSize) or (pfVar in Flags) then
        result := 4
      else
        result := GetDWORDSize(PSize) * 4;
  end;

  {-----------------------------}

  procedure GetStackSize;
  var
    i     : integer;
  begin
    stacksize := 0;
    RegisterCount := 2; // Self in EAX

    with MethodInfo do
      for i := 0 to ParamCount - 1 do
        with ParamRecs[i] do
          if (RegisterCount > 0) and ((UseRegister = 1) or (pfVar in Flags)) then
            begin
              case RegisterCount of
                1 : ECXParam := i;
                2 : EDXParam := i;
//              3 : EAXParam := i;
              end;
              dec(RegisterCount);
            end
          else
            inc(stacksize, getrealsize(ParamRecs[i]));
  end;

  {-----------------------------}

  function pushasize : integer; assembler;
  asm
    mov eax, esp
    mov edx, esp
    pushad
    sub eax, esp
    mov esp, edx
  end;

var
  _CallInherited : boolean;
  isRef          : boolean;
  regparam       : boolean;
  j              : integer;
  pdsize         : integer;
  ResultConvert  : TVarToParamProc;
begin
  _CallInherited := CallInherited and (M.Code <> nil);
  codestart := nil;
  s := TMemoryStream.Create;
  TMStream(s).Capacity := 2;
  pcount := MethodInfo.ParamCount;
  try
    Code := TWriter.Create(s, 4096);
    try
      stacksize := 0;
      RegisterCount := 2; // Self in EAX

      WriteInfo;
      EDXParam  := -1;
      ECXParam  := -1;

      GetStackSize;

      if _CallInherited then
        _PUSHA;

      RegisterCount := 2;
      stackpos := stacksize;

      if CallInherited then
        inc(stackpos, pushasize);

      carg := PVariant(PChar(parg) + (pcount - 1) * sizeof(variant));

      if ECXParam >= 0 then
        _PUSHECX;

      if EDXParam >= 0 then
         _PUSHEDX;

      _CALL(@_SetCurrentModuleObject);

      for i := 0 to pCount - 1 do
        with MethodInfo do
          begin
            regparam := (i = EDXParam) or (i = ECXParam);
            isRef := pfVar in ParamRecs[i].Flags;

            if regparam then
              _POPEAX
            else
              begin
                pdsize := getrealsize(ParamRecs[i]);
                if isRef then
                  _MOVEAXPESP(stackpos)
                else
                  _LEAEAXESP(stackpos - pdsize + 4);

                dec(stackpos, pdsize);
              end;

            _MOVEDX(integer(carg));

            _XORECXECX;
            for j := 0 to (sizeof(OleVariant) div 4) - 1 do
              _MOVPEDXECX(j * 4);

            if not isRef then
              _MOVMECX(integer(pvars) + i * 4);

            if byte(ParamRecs[i].Flags) <> 0 then  // ECX contains 0 here
              _MOVECX(byte(ParamRecs[i].Flags));

            if isRef then
              _MOVMEAX(integer(pvars) + i * 4)
            else if regparam then
              begin
                _PUSHEAX;
                _MOVEAXESP;
              end;

            _CALL(Addr(ParamRecs[i].ParamToVar));

            if isRef then
              begin
                _MOVEAX(integer(carg));
                _CALL(Addr(VarToRefVar));
              end
            else if regparam then
              _POPEAX;

          dec(integer(carg), sizeof(Variant));
        end;

      _PUSH(integer(parg));
      _PUSH(integer(presult));    // EventHandler result
      _MOVEAX(integer(TMethod(EventHandler).Data));
      _MOVEDX(integer(evname));
      _MOVECX(pcount);
      _CALL(@EventHandler);

      if MethodInfo.RetType <> nil then
        begin
          ResultConvert := GetConvertInfo(MethodInfo.RetType)^.v2p;
          _MOVEAX(integer(presult));
          _PUSH(0);
          _MOVEDXESP;
          _CALL(@ResultConvert);
        end;

      carg := PVariant(PChar(parg) + (pcount - 1) * sizeof(variant));

      for i := 0 to pCount - 1 do
        begin
          with MethodInfo.ParamRecs[i] do
            if pfVar in Flags then
              begin
                _MOVEAX(integer(carg));
                _CALL(Addr(RefVarToVar));
                _MOVEAXM(integer(pvars) + i * 4);
                _MOVEDX(integer(carg));
                _CALL(Addr(VarToVar));
              end;

          dec(integer(carg), sizeof(Variant));
        end;

      carg := parg;
      for i := 1 to pcount do
        begin
          _MOVEAX(integer(carg));
          _CALL(@FreeVariant);
          inc(integer(carg), sizeof(Variant));
        end;

      if MethodInfo.RetType <> nil then
        _POPEAX; // event result

      if _CallInherited then
        begin
          _POPA;
          _JMP(M.Code);
        end
      else if StackSize = 0 then
        _RET
      else
        _RETP(StackSize);

    finally
      Code.Free;
    end;
  except
    s.Free;
    raise;
  end;
  result := CodeStart;
end;

{-----------------------------------------------------------}

function VarFromObject(Instance : TObject) : OleVariant;
begin
  if Instance = nil then
    result := NULL
  else
    VariantFromObj(@result, Instance)
//    result := VarFromInterface(GetObjectDispatch(Instance, nil));
end;

{-----------------------------------------------------------}

type
  TRunThread = class(TThread)
    fRunProcess : THandle;
    fErrorEvent : THandle;
    fErrorFile  : THandle;

    procedure Execute; override;
  end;

{-----------------------------------------------------------}

const
  RunSleep = 100;

procedure TRunThread.Execute;
{$IFNDEF CLX}
var
  errinfo    : TScriptErrorInfo;
  numread    : {$IFDEF D4}cardinal{$ELSE}integer{$ENDIF};
{$ENDIF}
begin
  FreeOnTerminate := true;
  repeat
    {$IFNDEF CLX}
    Sleep(RunSleep);
    if IsEventSignaled(fErrorEvent) then
      begin
        ReadFile(fErrorFile, errinfo, sizeof(errinfo), numread, nil);
        BroadCastToNotifiers(nil, CM_SCRIPTERROR, integer(@errinfo), 0);
      end;
    {$ENDIF}
  until not IsModuleRunning(fRunProcess);
  IDEChanged;
  {$IFNDEF CLX}
  CloseHandle(fErrorEvent);
  CloseHandle(fErrorFile);
  {$ENDIF}
  Terminate;
end;

{-----------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}
function ExternalRunProject(const FileName : string) : THandle;
var
  sinfo : TStartupInfo;
  pinfo : TProcessInformation;
  RunnerName : string;
  plist : TStringList;
  pnames : string;
  ErrorEvent : THandle;
  ErrorFile  : THandle;
begin
  FillChar(sinfo, sizeof(sinfo), 0);
  with sinfo do
    begin
      cb := sizeof(sinfo);
      dwFlags := STARTF_USESHOWWINDOW;
      wShowWindow := SW_SHOW;
    end;

  RunnerName := AddSlash(ExtractFilePath(ParamStr(0))) + ExternalRunner;
  plist := TStringList.Create;
  ErrorEvent := windows.CreateEvent(nil, false, false, SCRIPTERROREVENTNAME);
  ErrorFile := CreateFileMapping(Cardinal(-1), nil, PAGE_READWRITE, 0, sizeof(TScriptErrorInfo), SCRIPTERRORFILENAME);

  try
    GetLoadedPackagesPaths(plist);
    pnames := '"' + StringsToString(plist, ';') + '"';
    if CreateProcess(PChar(RunnerName), PChar('"' + RunnerName + '" ' + '"' + FileName + '" ' + pnames),
            nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, sinfo, pinfo) then
      begin
        result := THandle(pinfo.hProcess);
        with TRunThread.Create(true) do
          begin
            fRunProcess := pinfo.hProcess;
            fErrorEvent := ErrorEvent;
            fErrorFile  := ErrorFile;
            Resume;
          end;
      end
    else
      begin
        result := 0;
        ErrorFmt(SErrExternalRun, [SysErrorMessage(GetLastError)])
      end;
  finally
    plist.Free;
  end;
end;

{-----------------------------------------------------------}

procedure RunVerb(Internal : boolean);
begin
  with MainIDEObject do
    begin
      if ActiveProject = nil then
        exit;

      with TIDEProject(ActiveProject) do
        begin
          if not SaveProjectFiles then
            exit;

          if IsModuleRunning(THandle(RunHandle)) then
            dcdreamLib.Error(SErrAlreadyLaunched);

          if ProjectItems.Count > 0 then
            if Internal then
              begin
                RunHandle := Integer(RunObjectList(ProjectItems));
                if RunHandle <> 0 then
                  with TDCScripter(RunHandle) do
                    if GetModule = nil then
                      Free;
              end
            else
              RunHandle := Integer(ExternalRunProject(FileName));
        end;
    end;
end;

{-----------------------------------------------------------}

procedure RunScriptVerb;
begin
  RunVerb(false);
end;

{-----------------------------------------------------------}

procedure InternalRunScriptVerb;
begin
  RunVerb(true);
end;

{-----------------------------------------------------------}

procedure RunProgramReset;
begin
  With MainIDEObject do
  begin
    with TIDEApplication(ActiveProject) do
      ResetRunningModule(THandle(RunHandle));
  end;
end;

{-----------------------------------------------------------}

procedure CanProgramReset(Var VerbStates:TVerbStates);
begin
  With MainIDEObject do
   if (ActiveProject=nil) or
      (not IsModuleRunning(THandle(TIDEApplication(ActiveProject).RunHandle))) then
     Exclude(VerbStates,vsEnabled);
end;

{-----------------------------------------------------------}

procedure CanRunProgram(Var VerbStates:TVerbStates);
begin
  With MainIDEObject do
   if (ActiveProject=nil) or (ActiveProject.ProjectItems.Count = 0) or
      (IsModuleRunning(THandle(TIDEApplication(ActiveProject).RunHandle))) then
     Exclude(VerbStates,vsEnabled);
end;

{$ENDIF CLX}
{$ENDIF WIN}

{******************************************************************}

{$IFDEF ACTIVESCRIPTING}

var
  _PDM : IProcessDebugManager;
  _AppHandle  : THandle;
  _DebugApplication : IDebugApplication;
  fPDMLock : TRTLCriticalSection;

function GlobalPDM : IProcessDebugManager;
begin
  EnterCriticalSection(fPDMLock);
  try
    if _PDM = nil then
      begin
        CoCreateInstance(CLSID_ProcessDebugManager, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER,
                         IProcessDebugManager, _PDM);

        if (_PDM <> nil) then
          begin
            _PDM.CreateApplication(_DebugApplication);
            _DebugApplication.SetName(DCStringToOleSt(Application.ExeName));
            _PDM.AddApplication(_DebugApplication, _AppHandle);
          end;
      end;

    result := _PDM;
  finally
    LeaveCriticalSection(fPDMLock);
  end;
end;

procedure BreakRunningScript;
begin
  if _DebugApplication <> nil then
    _DebugApplication.CauseBreak;
end;

{------------------------------------------------------------------}

procedure DonePDM;
begin
  EnterCriticalSection(fPDMLock);
  try
    if _PDM <> nil then
      _PDM.RemoveApplication(_AppHandle);

    _PDM := nil;

    if _DebugApplication <> nil then
      _DebugApplication.Close;

    _DebugApplication := nil;
  finally
    LeaveCriticalSection(fPDMLock);
  end;
end;

{******************************************************************}

constructor TActiveScriptSite.Create(const AScriptName : string);
//var
//  fIDebug : IActiveScriptDebug;
//  ppescc : IEnumDebugCodeContexts;
begin
  inherited Create;
  ScriptName := AScriptName;
  _AddRef;
  fItems := CreateSortedStringList;
end;

{------------------------------------------------------------------}

destructor TActiveScriptSite.Destroy;
begin
  if fHelper <> nil then
    fHelper.Detach;

  fItems.Free;
  inherited;
end;

{------------------------------------------------------------------}

procedure TActiveScriptSite.AddItem(const name : string; const intf : IUnknown; flag : integer);
var
  olestr : PWideChar;
  index : integer;
begin
  olestr := DCStringToOleSt(name);
  try
    index := fItems.AddObject(name, TObject(intf));
    if ActiveScript.AddNamedItem(olestr, SCRIPTITEM_ISVISIBLE or flag) <> S_OK then
      fItems.Delete(index);
  finally
    SysFreeString(olestr);
  end;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  result := E_NOINTERFACE;
  if GetInterface(IID, Obj) then
    result := 0;
end;

{------------------------------------------------------------------}

function TActiveScriptSite._AddRef: integer;
begin
  inc(fRefCount);
  Result := fRefCount;
end;

{------------------------------------------------------------------}

function TActiveScriptSite._Release: integer;
begin
  dec(fRefCount);
  result := fRefCount;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.GetDocumentContextFromPosition(const dwSourceContext : DWORD;
          const uCharacterOffset: ULONG; const uNumChars : ULONG;
          out ppsc : IDebugDocumentContext) : HRESULT;
var
  ulStartPos : ULONG;
  iScript    : IActiveScript;
  xxx        : ULONG;
begin
  if fHelper <> nil then
    begin
      ulStartPos := 0;
      fHelper.GetScriptBlockInfo(dwSourceContext, iScript, ulStartPos, xxx);
      result := fHelper.CreateDebugDocumentContext(Cardinal(ulStartPos) + uCharacterOffset, uNumChars, ppsc);
    end
  else
    result := E_FAIL;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.GetApplication(out ppda : IDebugApplication) : HRESULT; stdcall;
begin
  EnterCriticalSection(fPDMLock);
  try
    if _DebugApplication = nil then
      result := E_FAIL
    else
      begin
        ppda := _DebugApplication;
        result := S_OK;
      end;
  finally
    LeaveCriticalSection(fPDMLock);
  end;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.GetRootApplicationNode(out ppdanRoot : IDebugApplicationNode) : HRESULT;
begin
  result := E_FAIL;
  if fHelper <> nil then
    result := fHelper.GetDebugApplicationNode(ppdanRoot);
end;

{------------------------------------------------------------------}

function TActiveScriptSite.OnScriptErrorDebug(const pErrorDebug : IActiveScriptErrorDebug;
                out pfEnterDebugger : BOOL;out pfCallOnScriptErrorWhenContinuing : BOOL) : HRESULT;
begin
  if fFailed then
    begin
      pfEnterDebugger := false;
      pfCallOnScriptErrorWhenContinuing := false;
      result := S_OK;
    end
  else
    result := E_FAIL;
end;

{------------------------------------------------------------------}
(*
function TActiveScriptSite.QueryAlive : HRESULT;
begin

end;

{------------------------------------------------------------------}

function TActiveScriptSite.CreateInstanceAtDebugger(const rclsid : TCLSID; const pUnkOuter : IUnknown;
                                  const dwClsContext : DWORD; const riid : TIID;
                                  out   ppvObject : IUnknown) : HRESULT;
begin
  result := E_NOTIMPL;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.onDebugOutput(const pstr : PWideChar) : HRESULT;
begin

end;

{------------------------------------------------------------------}

function TActiveScriptSite.onHandleBreakPoint(const prpt : IRemoteDebugApplicationThread;
                            const br : TBREAKREASON;  const pError : IActiveScriptErrorDebug) : HRESULT;
begin

end;

{------------------------------------------------------------------}

function TActiveScriptSite.onClose : HRESULT;
begin

end;

{------------------------------------------------------------------}

function TActiveScriptSite.onDebuggerEvent(const riid : TIID; const punk : IUnknown) : HRESULT;
begin

end;
*)
{------------------------------------------------------------------}

function TActiveScriptSite.GetLCID(var wLCID: TLCID): HResult;
begin
  Result := S_OK;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.GetItemInfo(ItemName: PWideChar; dwReturnMask: DWord;
  out UnkItem: IUnknown; out outTypeInfo: ITypeInfo): HResult; stdcall;
var
  index : integer;
  ObjDispatch : IDispatch;
  iName : string;
begin
  if pointer(ItemName) = nil then
    begin
      result := E_NOTIMPL;
      exit;
    end;

  if (dwReturnMask = SCRIPTINFO_IUNKNOWN) then
    begin
       iName := ItemName;
       if fItems.Find(iName, index) then
         UnkItem := IUnknown(pointer(fItems.Objects[index]))
       else if CompareText(iName, ScriptName) = 0 then
         UnkItem := CreateCompWrapper;
    end
  else if (dwReturnMask = SCRIPTINFO_ITYPEINFO) then
    if fItems.Find(ItemName, index) then
      begin
        ObjDispatch := IDispatch(pointer(fItems.Objects[index]));
        ObjDispatch.GetTypeInfo(0, 0, outTypeInfo);
      end;
  Result := S_OK;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.GetDocVersionString(var VersionString: TBSTR): HResult;
begin
  VersionString := '12345';
  Result := S_OK;
//  Result := E_NOTIMPL;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.OnScriptTerminate(var VarResult: OleVariant;
   var ExcepInfo: TExcepInfo): HResult;
begin
  Result := S_OK;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.OnStateChange(ScriptState: LongInt): HResult;
begin
  Result := S_OK;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.OnScriptError(pAse: IActiveScriptError): HResult;
var
  wCookie   : word;
  ExcepInfo : TExcepInfo;
  CharNo    : integer;
  LineNo    : DWORD;
  handled   : boolean;
begin
  wCookie := 0;
  LineNo  := 0;
  CharNo  := 0;
  result := S_OK;

  if Assigned(pAse) then
    begin
      pAse.GetExceptionInfo(ExcepInfo);
      pAse.GetSourcePosition(wCookie, LineNo, CharNo);
      handled := false;
      if Assigned(fOnError) then
        fOnError(self, ExcepInfo, CharNo, LineNo, handled);
      if not handled then
        result := E_FAIL;
    end;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.OnEnterScript(): HResult;
begin
  ScriptRunner.Scripter.ProcessUses;
  Result := S_OK;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.OnLeaveScript(): HResult;
begin
  Result := S_OK;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.GetWindow(var Hwnd: THandle): HResult;
begin
  Hwnd := Application.Handle;
  Result := S_OK;
end;

{------------------------------------------------------------------}

function TActiveScriptSite.EnableModeless(FEnable: WordBool): HResult;
begin
  Result := S_OK;
end;

{******************************************************************}

constructor TScriptRun.Create(const ScriptName : string);
begin
  inherited Create;
  fScriptName := ScriptName;
end;

{------------------------------------------------------------------}

function TScriptRun.ParseScript(const ScriptText : PWideChar) : integer;
Const
  SCRIPTTEXT_HOSTMANAGESSOURCE = $80;
var
  scontext    : DWORD;
  Len         : integer;
  fPDM        : IProcessDebugManager;
  wscriptname : PWideChar;
  ov          : OleVariant;
begin
  fPDM := GlobalPDM;
  if fPDM <> nil then
    begin
      fPDM.CreateDebugDocumentHelper(nil, asite.fHelper);

      with asite.fHelper do
        begin
          SetDocumentAttr(TEXT_DOC_ATTR_READONLY);
          AddUnicodeText(ScriptText);
          Len := Length(ScriptText);
          DefineScriptBlock(0, Len, ActiveScript, False, scontext);
          wscriptname := DCStringToOleSt(fScriptName);
          try
            Init(_DebugApplication, wscriptname, wscriptname, TEXT_DOC_ATTR_READONLY);
          finally
            SysFreeString(wscriptname);
          end;
          Attach(nil);
        end;
    end;

  Result := activeScriptParse.ParseScriptText(ScriptText, '', nil, nil,
         scontext, 0, SCRIPTTEXT_HOSTMANAGESSOURCE, ov, nil);
end;

{------------------------------------------------------------------}

procedure TScriptRun.StopEngine;
begin
  if ActiveScript = nil then
    exit;

//  ActiveScript.SetScriptState(SCRIPTSTATE_CLOSED);

//  ActiveScript.InterruptScriptThread(SCRIPTTHREADID_BASE, @einfo, 0);
  ActiveScript.Close;

  ActiveScript := nil;
  ActiveScriptParse := nil;
  ActiveScriptSite := nil;
  asite.Free;
  pointer(asite) := nil;
end;

{------------------------------------------------------------------}

const
  IID_IActiveScript:TGUID= (D1 : $BB1A2AE1; D2 : $A4F9; D3 : $11cf; D4 : ($8F, $20, $00, $80, $5F, $2C, $D0, $64));
function TScriptRun.InitEngine : Boolean;
var
  iUnk : IUnknown;
begin
  Result := False;

  { Retrieve activeScript interface via IUnknown }
  iunk := CreateComObject(CatID);
  if iunk <> nil then
    iunk.QueryInterface(IID_IActiveScript, ActiveScript);

  if ActiveScript = nil then
    raise SScriptEngineRunException.Create(SErrScriptEngineRun);

  { Get Interface pointer for IActiveScriptParse Interface }
  if (ActiveScript.QueryInterface(IID_IActiveScriptParse,
      ActiveScriptParse) <> S_OK) then
    Exit;

  { COM Host Object Implementation  }
  asite := TActiveScriptSite.Create(fScriptName);
  asite.ScriptName := fScriptName;
  asite.ScriptRunner := ScriptRunner;
  ActiveScriptSite := IActiveScriptSite(asite);

  GlobalPDM;
  { Register Site Object with the ActiveScript Engine }
  if ActiveScript.SetScriptSite(ActiveScriptSite) <> S_OK then
    Exit;

  { initialize the engine }
  if (ActiveScriptParse.InitNew <> S_OK) then
    exit;

//  OleCheck(ActiveScript.QueryInterface(IActiveScriptParseProcedure, ActiveScriptParseProcedure));
  result := true;

{  if ActiveScript.QueryInterface(IActiveScriptDebug, fIDebug) = S_OK then
    begin
      fDebugSupported := true;
    end;
}
end;

{***********************************************************}

function  TVbScriptRunner.GetDefaultCatID : TGUID;
begin
  result := CatID_VBScript;
end;

{-----------------------------------------------------------}

procedure TVbScriptRunner.GetWatchesPreffixes(var APref_Hex, APref_Str: string);
begin
  APref_Hex := '&H';
  APref_Str := '"';
end;

{***********************************************************}

function  TVbScriptEncodeRunner.GetDefaultCatID : TGUID;
begin
  result := CatID_VBScriptEncode;
end;

{***********************************************************}

function  TJavaScriptRunner.GetDefaultCatID : TGUID;
begin
  result := CatID_JScript;
end;

{***********************************************************}

function  TJavaScriptEncodeRunner.GetDefaultCatID : TGUID;
begin
  result := CatID_JScriptEncode;
end;

{***********************************************************}

function  TPythonScriptRunner.GetDefaultCatID : TGUID;
begin
  result := CatID_PythonScript;
end;

{***********************************************************}

function  TPerlScriptRunner.GetDefaultCatID : TGUID;
begin
  result := CATID_PerlScript;
end;

{***********************************************************}

function  TEnableScriptRunner.GetDefaultCatID : TGUID;
begin
  result := CatID_CypressEnable;
end;

{***********************************************************}

procedure TAxScriptRunner.DoInterrupt;
begin
  ScriptRun.ActiveScript.Close;
end;

{-----------------------------------------------------------}

procedure TAxScriptRunner.StopScript;
begin
  with ScriptRun do
    if ActiveScript <> nil then
      ActiveScript.Close;
end;

{-----------------------------------------------------------}

procedure TAxScriptRunner.Stop;
begin
  with fscrun do
    if not IsEqualGUID(CatID, GUID_NULL) then
      StopEngine;
end;

{-----------------------------------------------------------}

procedure TAxScriptRunner.SetCatID(const ACatID : TGUID);
begin
  with fscrun do
    if not IsEqualGUID(CatID, ACatID) then
      begin
        Stop;
        CatID := ACatID;
        InitEngine;
        asite.ActiveScript := ActiveScript;
        asite.OnError := ScriptError;
      end;
end;

{-----------------------------------------------------------}

function  TAxScriptRunner.GetCatID : TGUID;
begin
  result := fscrun.CatID;
end;

{-----------------------------------------------------------}

function TAxScriptRunner.ParseScript(const Script : string) : boolean;
var
  wScript : PWideChar;
begin
  wScript := DCStringToOleSt(Script);
  try
    result := (script = '') or (fscrun.ParseScript(wscript) = S_OK);
    result := result and
              (fscrun.ActiveScript.SetScriptState(SCRIPTSTATE_CONNECTED) = S_OK);
  finally
    SysFreeString(wScript);
  end;
end;

{-----------------------------------------------------------}

procedure TAxScriptRunner.DoRemoveItem(const Name : string); 
begin

end;

{-----------------------------------------------------------}

procedure TAxScriptRunner.AddItem(const Name : string; Global : boolean; const idisp : IDispatch);
var
  flag : integer;
begin
  flag := 0;
  if Global then
    flag := SCRIPTITEM_GLOBALMEMBERS;

  fscrun.asite.AddItem(Name, idisp, flag);
end;

{-----------------------------------------------------------}

constructor TAxScriptRunner.Create(AScripter : TDCScripter; const AScriptName : string);
begin
  inherited;
//  fItems := TStringList.Create;
//  fItems.Sorted := true;
  fscrun := TScriptRun.Create(AScriptName);
  fscrun.ScriptRunner := self;
  SetCatID(GetDefaultCatID);
end;

{-----------------------------------------------------------}

destructor TAxScriptRunner.Destroy;
begin
  Stop;
  fscrun.Free;
//  fItems.Free;
  inherited;
end;

{-----------------------------------------------------------}

function TAxScriptRunner.GetScriptDispatch : IDispatch;
begin
  if fscrun.ActiveScript <> nil then
    fscrun.ActiveScript.GetScriptDispatch(nil, result);
end;

{-----------------------------------------------------------}

procedure TAxScriptRunner.GetVarList(S : TStrings);
var
  iti    : ITypeInfo;
  attr   : PTypeAttr;
  pvar   : PVarDesc;
  i      : integer;
  vnames : TBSTRList;
  xxx    : integer;
  sDispatch  : IDispatch;
begin
  sDispatch := ScriptDispatch;

  if sDispatch = nil then
    exit;

  sDispatch.GetTypeInfo(0, 0, iti);

  if iti = nil then
    exit;

  iti.GetTypeAttr(attr);

  for i := 0 to attr.cVars - 1 do
    try
      iti.GetVarDesc(i, pvar);
      iti.GetNames(pvar.memid, @vnames, 1, xxx);
      S.AddObject(vnames[0], TObject(pvar.memid));
    finally
      iti.ReleaseVarDesc(pvar);
    end;
end;

{$ENDIF ACTIVESCRIPTING}

{-----------------------------------------------------------}

procedure GetRoutineNames(Scripter : TDCScripter;  S : TStrings);
var
  cdesignclass : TCodeDesignerClass;
  cdesign      : TCodeDesigner;
  emptyscript  : boolean;
  scriptsource : TStrings;
begin
  S.Clear;
  cdesignclass := Scripter.GetCodeDesignerClass;
  if cdesignclass <> nil then
    begin
      emptyscript := (Scripter.ScriptRun = nil) and (Scripter.ScriptFile <> '');
      cdesign := cdesignclass.Create(nil);
      scriptsource := nil;
      if emptyscript then
        scriptsource := TStringList.Create;
      with cdesign do
        try
          if emptyscript then
            begin
              scriptsource.LoadFromFile(Scripter.ScriptFile);
              Strings := scriptsource;
            end
          else
            Strings := scripter.Script;

          ModuleOwner := scripter.GetModule;
          GetMethods(nil, s);
        finally
          scriptsource.Free;
          Free;
        end;
    end;
end;


{***********************************************************}
//BeginSkipConst

type
  _TCreateObject = function (cArgs: integer; pArgs: PArgList): OleVariant of object;

procedure _Register;
begin
  RegisterProc(nil,'InSet',mtProc,TypeInfo(__DC__TInSet),[TypeInfo(integer), TypeInfo(integer), TypeInfo(boolean)],Addr(InSet),cRegister);  //don't resource
  RegisterProc(nil,'MkSet', mtScriptProc, TypeInfo(__DC__T_Set), NoParams, Addr(_Set), cRegister); //don't resource
  RegisterProc(nil,'Chr', mtProc, TypeInfo(__DC__T_Chr), [TypeInfo(byte), TypeInfo(string)], Addr(_Chr), cRegister); //don't resource
  RegisterProc(nil,'CreateObject', mtScriptProc, TypeInfo(_TCreateObject), NoParams, Addr(CreateObject), cRegister); //don't resource

{$IFDEF ACTIVESCRIPTING}
  RegisterScriptRunner(TVbScriptRunner, SExtvbs, SLangVBScript);
  RegisterScriptRunner(TVbScriptEncodeRunner, SExtVbsEncode, SLangVBScriptEncode);
  RegisterScriptRunner(TJavaScriptRunner, SExtjs,SLangJavaScript);
  RegisterScriptRunner(TJavaScriptEncodeRunner, SExtJsEncode, SLangJavaScriptEncode);
  RegisterScriptRunner(TPythonScriptRunner, SExtPY, SLangPythonScript);
  RegisterScriptRunner(TPerlScriptRunner, SExtPL, SLangPerlScript);
  RegisterScriptRunner(TEnableScriptRunner, SExtBas, SLangEnableScript);

  RegisterVerb('Run.InternalRun',CanRunProgram,InternalRunScriptVerb);
  RegisterVerb('Run.Run',CanRunProgram,RunScriptVerb);
  RegisterVerb('Run.ProgramReset',CanProgramReset,RunProgramReset);
{$ENDIF}
end;

{-----------------------------------------------------------}

procedure _InstantRegister;
begin
end;

{-----------------------------------------------------------}
//EndSkipConst

{***********************************************************}

{$O+,A+,W-,R-,Q-,B-,X+,T-,P+,H+,J+,C-}
type
  TTestObject = class
    constructor Create;
    procedure   p1; dynamic;
    procedure   p2;
  end;

constructor TTestObject.Create;
begin
end;

procedure TTestObject.p1; assembler;
asm
end;

procedure TTestObject.p2;
begin
  p1;
end;

procedure GetSysProcs;
var
  p : PChar;
begin
  p := pchar(Addr(TTestObject.p2)) + 5;
  if p^ = #$E8 then  //don't resource
    begin
      inc(p);
      CallDynaInstAddr := pointer(PInt(p)^ + integer(p) + 4);
    end;

  p := pchar(Addr(TTestObject.Create)) + 7;
  if p^ = #$E8 then  //don't resource
    begin
      inc(p);
      ClassCreateAddr := pointer(PInt(p)^ + integer(p) + 4);
    end;

  exit;
//  if false then
    with TTestObject.Create do
      begin
        p1;
        Free;
      end;
end;

{******************************************************************}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
  RegisterForInstant(_InstantRegister);
end;

{-----------------------------------------------------------}

var RegisteredTemplates : TStringList;

function DelphiTemplateFun(const expr : string) : string;
begin
  result := 'function Calculate : integer;'#13#10'begin'#13#10'result := ' + expr + ';'#13#10'end;';
end;

function VBScriptTemplateFun(const expr : string) : string;
begin
  result := 'function Calculate()'#13#10'Calculate = ' + expr + #13#10'End Function'
end;

function JavaScriptTemplateFun(const expr : string) : string;
begin
  result := 'function Calculate()'#13#10'{'#13#10'return ' + expr + ';'#13#10'}';
end;

function PerlScriptTemplateFun(const expr : string) : string;
begin
  result := 'sub Calculate{'#13#10'return ' + expr + ';}';
end;

//EndSkipConst

procedure RegisterTemplateFun(const LangName : string; TemplateFun : TTemplateFun);
begin
  RegisteredTemplates.AddObject(LangName, @TemplateFun);
end;

{------------------------------------------------------------------}

function GetRegisteredTemplateFun(const LangName : string ) : TTemplateFun;
var
  i : integer;
begin
  result := nil;
  i := RegisteredTemplates.IndexOf(LangName);
  if i >= 0 then
    result := TTemplateFun(RegisteredTemplates.Objects[i]);
end;

{------------------------------------------------------------------}

function TDCScripter.Evaluate(const expr : string) : Variant;
var
  s : string;
  TemplateFun : TTemplateFun;
begin
  VarClear(result);
  if expr = '' then
    exit;
  TemplateFun := GetRegisteredTemplateFun(Language);
  if Assigned(TemplateFun) then
    begin
      s := TemplateFun(expr);
      Script.Text := s;
      result := CallNoParamsMethod('Calculate'); //don't resource
    end;
end;

{------------------------------------------------------------------}

const
  CompiledHeader = 'DCsc3.11';
  CompiledHeaderLength = length(CompiledHeader);

procedure   TDCScripter.LoadCompiledScriptFromStream(S : TStream);
var
  Header : string;
begin
  SetLength(Header, CompiledHeaderLength);
  S.Read(Header[1], CompiledHeaderLength);

  if Header <> CompiledHeader then
    Error(ResStr(SInvalidImage));

  with TReader.Create(S, 4096) do
    try
      fUnitsList.Text := ReadString;
    finally
      Free;
    end;

  Stop;
  fScriptChanged := false;
  fCompiledScript := S;
  InitScriptRun;
end;

{------------------------------------------------------------------}

procedure   TDCScripter.SaveCompiledScriptToStream(S : TStream);
begin
  if fScriptChanged then
    Stop;

  if InitScriptRun then
    begin
      S.Write(CompiledHeader, CompiledHeaderLength);
      with TWriter.Create(S, 4096) do
        try
          WriteString(fUnitsList.Text);
        finally
          Free;
        end;
      ScriptRun.SaveToStream(S);
    end;
end;

{------------------------------------------------------------------}

procedure   TDCScripter.LoadCompiledScriptFromFile(const FileName : string);
var
  FileStream : TFileStream;
begin
  FileStream := TFileStream.Create(FileName, DefaultOpenMode);
  try
    LoadCompiledScriptFromStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

{------------------------------------------------------------------}

procedure   TDCScripter.SaveCompiledScriptToFile(const FileName : string);
var
  FileStream : TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    SaveCompiledScriptToStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

{------------------------------------------------------------------}

function    TDCScripter.IsRunning : boolean;
begin
  result := (ScriptRun <> nil) and (ScriptRun.fRunCount > 0);
end;

{------------------------------------------------------------------}

function    TDCScripter.GetDisplayScriptName : string;
begin
  result := ScriptName;
  if result = '' then
    result := ScriptFile;
end;

{------------------------------------------------------------------}

function IsMethodRegistered(const MethodName : string) : boolean;
var
  i : integer;
begin
  result := GlobalMethodNames.Find(MethodName, i);
end;

{------------------------------------------------------------------}

function IsVarRegistered(const VarName : string) : boolean;
var
  i : integer;
begin
  result := RVarList.Find(VarName, i);
end;

{------------------------------------------------------------------}

function IsConstRegistered(const ConstName : string) : boolean;
var
  i : integer;
begin
  result := RConstList.Find(ConstName, i);
end;

{------------------------------------------------------------------}

function IsClassRegistered(const ClassName : string) : boolean;
var
  i : integer;
begin
  result := RClassList.Find(ClassName, i);
end;

{------------------------------------------------------------------}

function IsPropRegistered(const PropName : string) : boolean;
var
  i : integer;
begin
  result := fGlobalPropNames.Find(PropName, i);
end;

{------------------------------------------------------------------}

procedure GetRegisteredConst(const ConstName : string; var Value : Variant);
var
  i : integer;
begin
  if RConstList.Find(ConstName, i) then
    Value := TRegisteredConstInfo(RConstList.Objects[i]).Value
  else
    VarClear(Value);
end;

{------------------------------------------------------------------}

function IsIdentRegistered(const IdentName : string) : boolean;
begin
  result := IsMethodRegistered(IdentName) or IsVarRegistered(IdentName) or
            IsConstRegistered(IdentName) or IsClassRegistered(IdentName) or
            IsPropRegistered(IdentName);
end;

{------------------------------------------------------------------}

function GetRegisteredPropNames: TStringList;
begin
  result := fGlobalPropNames;
end;

{------------------------------------------------------------------}

function GetRegisteredVarList: TStringList;
begin
  result := RVarList;
end;

{------------------------------------------------------------------}

function GetRegisteredProcList: TStringList;
begin
  result := GlobalMethodNames;
end;

{------------------------------------------------------------------}

function GetRegisteredConstList: TStringList;
begin
  result := RConstList;
end;

{------------------------------------------------------------------}

function GetRegisteredClassInfo(Index : integer) : TRegisteredClassInfo;
begin
  result := fRegisteredClasses[index];
end;

{------------------------------------------------------------------}

{$IFDEF ACTIVESCRIPTING}
var
  NeedUninitialize : boolean;
{$ENDIF}

procedure CalculateGetScripterVMTOffset;
var
  pVMethod : PDWORD;
  pvStart  : PDWORD;
  maddr    : DWORD;
begin
  pvStart := PDWORD(TScriptUnitForm);
  pVMethod := pvStart;
  maddr := DWORD(Addr(TScriptUnitForm.GetScripter));

  while PVMethod^ <> maddr do
    inc(PVMethod);

  GetScripterVMTOffsetForm := DWORD(PVMethod) - DWORD(pvStart);

  pvStart := PDWORD(TScriptUnitDataModule);
  pVMethod := pvStart;
  maddr := DWORD(Addr(TScriptUnitDataModule.GetScripter));
  while PVMethod^ <> maddr do
    inc(PVMethod);

  GetScripterVMTOffsetDataModule := DWORD(PVMethod) - DWORD(pvStart);
end;

{------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}
type
  _TLoadLibrary = function(p0 : PAnsiChar) : HMODULE of object;
  _TFreeLibrary = function(p0 : HMODULE) : BOOL of object;
{$ENDIF}
{$ENDIF}

{------------------------------------------------------------------}

{$IFDEF THREADSAFE}
function Synchronizer:TMultiReadExclusiveWriteSynchronizer;
begin
  if FSynchronizer=nil then
    FSynchronizer := TMultiReadExclusiveWriteSynchronizer.Create;
  Result:=FSynchronizer;
end;
{$ENDIF}

{-----------------------------------------------------------}
{
Function DCFindNextToDestroy(List:TList):TDCScripter;
Var
  I : Integer;
begin
  For I := 0 To List.Count - 1 Do
    If TDCScripter(List[I]).fRefCount <= 1 Then
    begin
      Result := List[I];
      Exit;
    end;
  Result:=List[0];
end;
}
{------------------------------------------------------------------}

procedure DCDestroyScriptersList(List:TList);
var
  Scripter:TDCScripter;
begin
  While List.Count > 0 Do
  begin
    Scripter := List[0];
    Scripter.Release;

    if List.Count = 0 then
      break;

    if List[0] = Scripter then
      List.Delete(0);
  end;
end;

{------------------------------------------------------------------}

procedure DCUnitFinalization;
begin
  DCDestroyScriptersList(fLoadedModules.InternalList);

  {$IFDEF ACTIVESCRIPTING}
  DonePDM;
  {$ENDIF}

  FreeObject(fLoadedModules,fLoadedModules);
  FreeObject(fLoadedScripts,fLoadedScripts);
  AssignedEventsList.Free;
  FreeSortedList(fRegisteredClasses,fRegisteredClasses);
  FreeSortedList(fResClasses,fResClasses);
  FreeSortedList(EventsList,EventsList);
//  FreeList(GlobalWrapList);
  FreeObject(GlobalWrapList,GlobalWrapList);
  ModuleWrappersList.Free;
  FreeObject(RClassList,RClassList);
  FreeStrings(RConstList);
  FreeStrings(RVarList);
  FreeStrings(fGlobalPropNames);
  FreeObject(RCList,RCList);
  FreeObject(RVList,RVList);
  ArrayInfos.Free;
  DynArrayInfos.Free;
  FreeObject(GlobalMethodsList,GlobalMethodsList);
  FreeObject(GlobalPropsList,GlobalPropsList);
  _nilwrapper := nil;

  GlobalMethodNames.Free;
  RegisteredTemplates.Free;
  _EventRestorer.Free;

  {$IFDEF ACTIVESCRIPTING}
  DeleteCriticalSection(fPDMLock);
  if NeedUninitialize then
    OleUnInitialize;
  {$ENDIF}

  {$IFDEF THREADSAFE}
  FreeObject(FSynchronizer,FSynchronizer); 
  {$ENDIF}
end;

{------------------------------------------------------------------}

initialization
  CalculateGetScripterVMTOffset;

  {$IFDEF ACTIVESCRIPTING}
  NeedUninitialize := {not IsLibrary and }(OleInitialize(nil) = S_OK);
  InitializeCriticalSection(fPDMLock);
  {$ENDIF}

  _nilwrapper := TDCompWrapper.Create as IDispatch;
  GetSysProcs;
  fLoadedScripts := TSortedList.Create;
  AssignedEventsList := TSortedList.Create;
  EventsList := TEventsList.Create;
  fLoadedModules := TSortedList.Create;
  GlobalWrapList := TList.Create;
  ModuleWrappersList := TList.Create;
  fRegisteredClasses := TRegisteredClassesList.Create;
  fResClasses        := TRegisteredClassesList.Create;
  GlobalMethodsList  := TSortedList.Create;
  GlobalPropsList    := TSortedList.Create;
  GlobalMethodNames  := CreateSortedStringList;

  ArrayInfos         := TList.Create;
  DynArrayInfos      := TList.Create;

  RClist := TSortedList.Create;
  RVlist := TSortedList.Create;
  RClassList := CreateSortedStringList;
  RConstList := CreateSortedStringList;
  RVarList   := CreateSortedStringList;
  fGlobalPropNames := CreateSortedStringList;

  RegisteredTemplates := TStringList.Create;

{$IFDEF WIN}
{$IFNDEF CLX}

  RegisterProc(nil, 'LoadLibrary', mtProc, TypeInfo(_TLoadLibrary), [
    TypeInfoPChar, TypeInfo(HMODULE)], Addr(LoadLibrary), cStdCall);

  RegisterProc(nil, 'FreeLibrary', mtProc, TypeInfo(_TFreeLibrary), [
    TypeInfo(HMODULE), TypeInfo(BOOL)], Addr(FreeLibrary), cStdCall);
{$ENDIF}
{$ENDIF}

  RegisterTemplateFun('DelphiScript' , DelphiTemplateFun); //don't resource

{$IFDEF ACTIVESCRIPTING}
  RegisterTemplateFun('VBScript', VBScriptTemplateFun); //don't resource
  RegisterTemplateFun('JavaScript', JavaScriptTemplateFun); //don't resource
  RegisterTemplateFun('PerlScript', PerlScriptTemplateFun); //don't resource
{$ENDIF}

  RunRegister;

finalization
  DCUnitFinalization;
end.
