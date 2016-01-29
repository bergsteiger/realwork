{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit unitpars;

interface
{$I dc.inc}

uses
  consts, classes, dcsystem, typinfo, dcparser,
  sysutils, dcdreamlib,
  {$IFDEF WIN32}
   messages,
  {$ENDIF}
   dcconsts, dcapi;

const
  CompiledExt = '.dpu'; //don't resource

type
  TDCParserInfoKind=(ikParserDestroyed,ikLoadedUnit,ikConsideredEmpty,
    ikCompiledUnit,ikSavedTo,ikNotSavedTo,ikError,ikCompilingUnit,ikImplementIgnored);
  TDCParserInfoKinds=set of TDCParserInfoKind;

const
  ParserInfoKinds:TDCParserInfoKinds=[Low(TDCParserInfoKind)..High(TDCParserInfoKind)]-[ikNotSavedTo,ikCompilingUnit,ikImplementIgnored];

  SDCParserDestroyed ='Parser Destroyed : ';
  SDCLoadedUnit      ='Loaded Unit      : ';
  SDCConsideredEmpty ='Considered empty : ';
  SDCCompiledUnit    ='Compiled Unit    : ';
  SDCCompilingUnit   ='Compiling Unit   : ';
  SDCSavedTo         ='Saved To         : ';
  SDCNotSavedTo      ='Not Saved To     : ';
  SDCError           ='Error            : ';
  SDCImplementIgnored='Implement ignored: ';
type
  TScope = (sPrivate, sProtected, sPublic, sPublished, sAutomated);
  TModuleType = (moUnit, moProgram, moLibrary);

  TBaseType = (
    btInteger, btShortint, btSmallInt, btLongint, btByte, btWord, btCardinal,
    btChar, btAnsiChar, btBoolean, btByteBool, btWordBool, btLongBool, btValuedEnum, btEnum, // ordinal
    btReal, btSingle, btDouble, btExtended, btComp, btCurrency,    // real
    btShortString, btAnsiString, btWideString,                     // string
    btPointer, btProc,
    btPChar, btPWideChar, btPAnsiChar, btFile, btText, btInt64 , btRecord
  );

  TBaseTypes = set of TBaseType;

  TBaseStringType = btShortString .. btWideString;

  TTypeReference = (trEqual, trSubrange, trArray, trFile, trClassOf, trSetOf,
                    trPointer, trDynArray);

  TTypeDeclKind = (tdBase, tdRef, tdClass, tdRecord, tdUnknown, tdInterface,
                   tdDispInterface, tdObject);

  TTypeDeclKinds = set of TTypeDeclKind;

  TPropMode = (pmRead, pmWrite, pmDefault, pmDeclaredHere);

  TPropModes = set of TPropMode;

  TMethodFlag = (mfOverride, mfVirtual, mfDynamic, mfAbstract, mfMapped,
                 mfOverload, mfReintroduce, mfMessage, mfDeprecated, mfLibrary, mfPlatform);

  TMethodFlags = set of TMethodFlag;

  GlobalString = integer;

  TDCMsgHandler = procedure( Const AMsgText : String ) of object;

  PParamInfo = ^TParamInfo;
  TParamInfo = packed record
    ParamName  : GlobalString;
    ParamType  : GlobalString;
    ParamFlags : TParamFlags;
  end;

  PMethodInfo = ^TMethodInfo;
  TMethodInfo = packed record
    MName      : GlobalString;
    RetType    : GlobalString;
    ParamIndex : integer;

    ParamCount : word;
    DefaultParam : word;
    MethodType : TMethodType;
    OfObject   : boolean;
    IsFunction : boolean;
    Scope      : TScope;
    CallType   : TCallType;
    MethodFlags: TMethodFlags;
    VMTOffset  : integer;
  end;

  PPropertyInfo = ^TPropertyInfo;
  TPropertyInfo = packed record
    PropName   : GlobalString;
    VarType    : GlobalString;
//    PRead      : GlobalString;
//    PWrite     : GlobalString;
    PStored    : GlobalString;
    ParamIndex : integer;
    ParamCount : word;
    Scope      : TScope;
    Mode       : TPropModes;
//    IsDefault  : boolean;
  end;

  PVarInfo = ^TVarInfo;
  TVarInfo = packed record
    VarName    : GlobalString;
    VarType    : GlobalString;
    Scope      : TScope;
    IsThread   : boolean;
  end;

  TModuleInfo = class;

  PConstInfo = ^TConstInfo;
  TConstInfo = packed record
    MInfo      : TModuleInfo;
    ConstName  : GlobalString;
    ConstType  : GlobalString;
    IsSet      : boolean;
    //!!!! value
  end;

  PTypeDeclInfo = ^TTypeDeclInfo;
  TTypeDeclInfo = packed record
    MInfo       : TModuleInfo;
    BaseName    : GlobalString;
    TypeName    : GlobalString;
    MethodIndex : integer;
    PropIndex   : integer;
    ProcInfo    : integer;
    VarIndex    : integer;
    ConstIndex  : integer;

    MethodCount : word;
    PropCount   : word;
    VarCount    : word;
    ConstCount  : word;

    TypeKind    : TTypeDeclKind;
    BaseType    : TBaseType;
    Reference   : TTypeReference;
    BaseTypeDecl: integer;

    VMCount     : word;
    VMStart     : integer;
    DynaCount   : word;
    DynaStart   : word;
    VMCalculated: boolean;
//    RefType    : ;
//    IsPacked   : boolean;
//    Indices    : TList;  // type1, min1, max1, type2, min2, max2
//    MinValue   : integer;
//    MaxValue   : integer;
  end;

  TStringHolder = class
  private
    fStream   : TMemoryStream;
    function    GetBaseAddr : PChar;
  public
    function    Add(const s : string) : integer;
    property    BaseAddr : PChar read GetBaseAddr;

    constructor Create;
    destructor  Destroy; override;

    procedure   SaveToStream(S : TStream);
    procedure   LoadFromStream(S : TStream);
  end;

  TDeclProc = procedure of object;

  TModuleInfo = class
  private
    fGStrings : TStringList;
    GlobalStrings : TStringHolder;


    procedure WriteSelf(w : TWriter);
    procedure ReadSelf(r : TReader);
    function  _getTypeDecl(const ATypeName : string; scanunits, scanall : boolean) : PTypeDeclInfo;
    function  _GetConstDecl(const ConstName : string; ScanUnits : boolean) : PConstInfo;

  public
    UsedUnits : TStringList;
    TypeList  : TStringList;
    ConstNames: TStringList;

    TypList   : TRecordList;
    ProcList  : TRecordList;
    ConstList : TRecordList;
    VarList   : TRecordList;
    PropList  : TRecordList;

    GlobalProcList : TRecordList;

    ProcCount : word;
    ProcIndex : integer;

    VarCount    : integer;

    ModuleName : string;
    ModuleFile : string;
    ModuleType : TModuleType;

    InterfaceUses : TStringList;
    ImplementUses : TStringList;
    GlobalParams  : TRecordList;

    function    GetGlobalString(GS : GlobalString) : string;
    function    SetGlobalString(const s : string) : GlobalString;
    constructor Create;
    destructor  Destroy; override;
    function    GetTypeDecl(const TypeName : string) : PTypeDeclInfo;
    function    GetTypeDeclInAllUnits(const TypeName : string) : PTypeDeclInfo;
    function    GetConstDecl(const ConstName : string) : PConstInfo;
    function    GetUnitWherePropertyWasDeclared(const CName, APropName : string) : TModuleInfo;
    procedure   SaveToStream(S : TStream);
    procedure   LoadFromStream(S : TStream);
  end;

type
  TUnitParser = class(TDCIncludeParser)
  private
    fRefCount   : integer;
    fModuleInfo : TModuleInfo;
    fParams     : TStringList;
    fCallType   : TCallType;
    fDefaultStringType : TBaseStringType;
    fModuleDate : integer;
    fDefines    : string;
    {fIgnoreDefines: String;}
    fUnits      : string;
    fAliases    : string;

    fAliasesList : TStringList;

    fCompiledPath : string;
    fThreadVar    : boolean;

    FMsgHandler       : TDCMsgHandler; // Dm.
    FIgnoreExistDPU   : Boolean; // Dm.
    FNoDefaultDefines : Boolean;

    procedure FindCloseBracket;
    procedure InitTypes;
    procedure UseUnit(const UnitName : string);
    function  ProcessParamList(CloseBracket : char; var ParamIndex : integer; var DefaultParam : word) : integer;
    function  NextGS : GlobalString;

    procedure WriteHeader(S : TStream);
    function  ReadHeader(S : TStream) : boolean;
    function  LoadFromCompiled(const UnitName : string) : boolean;
    procedure LoadFromSourceStream(S : TStream);
    procedure WriteUsedUnits(S : TStream);
    procedure WriteIncludes(S : TStream);
    procedure LoadUsedUnits(S : TStream);
    procedure LoadIncludes(S : TStream);
    procedure GetInheritedPropInfo(PInfo : PPropertyInfo; const BaseName : GlobalString);
    function  AddNewConst(const AConstName : string) : integer;
    procedure SetCompiledPath(const Path : string);
    procedure ParseText; virtual;
    procedure ProcessTypedConst(PConst : PConstInfo);
    procedure ProcessSimpleConst(PConst : PConstInfo);
    function  ProcessTypeDeclaration(const ATypeName : string) : integer;
{    procedure CalcVMT(pti : PTypeDeclInfo);}
    procedure CalcVMTs;
    procedure ReadField;
  protected
    procedure OutMessage(const S:String);
    function  GetParsedFileName:String;override;
    procedure ProcessDeclaration(Proc : TDeclProc);
    procedure ProcessDeclarationFromNextToken(Proc : TDeclProc);
    procedure ProcessConst;
    procedure ProcessVar;
    procedure ProcessType;
    procedure ProcessUses(UsesList : TStrings;DoUseUnit:boolean);
    procedure ProcessModuleType(AModuleType : TModuleType);
    procedure SkipHintDirectives;

    function  ProcessFunction(AScope : TScope; AMethodType : TMethodType;
                             MethodList : TRecordList; var MethodIndex : integer; var MethodCount : word;
                             TypeDecl : boolean) : integer;
    procedure GenerateParsedFile;
    function  GetErrorDesc : string; override;

    Procedure DoFileConfirm( Var AFileName : String; Var AConsiderEmpty : Boolean ); Override; // Dm.
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    procedure   AddRef;
    procedure   Release;

    procedure   LoadFromFile(const AFName, ADefines,AIgnoreDefines,
                  Units, Aliases : string);
    function    LoadFromStream(S : TStream) : boolean;
    procedure   SaveToStream(S : TStream);

    property    CompiledPath : string read fCompiledPath write SetCompiledPath;
    property    ModuleInfo : TModuleInfo read fModuleInfo;
    property    DefaultCallType : TCallType read fCallType write fCallType default cRegister;
    property    DefaultStringType : TBaseStringType read fDefaultStringType write fDefaultStringType default btAnsiString;

    Property IgnoreExistDPU   : Boolean       Read FIgnoreExistDPU  Write FIgnoreExistDPU; //Dm.
    Property MsgHandler       : TDCMsgHandler Read FMsgHandler      Write FMsgHandler; // Dm.
    Property NoDefaultDefines : Boolean       Read FNoDefaultDefines Write FNoDefaultDefines; // Dm.
  end;

  TUnitParserClass=class of TUnitParser;

  TDCImplParser = class(TUnitParser)
  protected
    procedure ParseText; override;
  end;

function LoadModuleEx(const FileName, ADefines, AIgnoreDefines, Units,
           Aliases,DPUFolder : string;
           ParserClass:TUnitParserClass;ANoDefaultDefines:Boolean;
           AMsgHandler:TDCMsgHandler) : TUnitParser;
           
Function DCLoadModule( Const FileName, ADefines, AIgnoreDefines, Units, Aliases,
                       DPUFolder : String; ParserClass : TUnitParserClass;
                       AIgnoreExistDPU, ANoDefaultDefines : Boolean;
                       AMsgHandler : TDCMsgHandler ) : TUnitParser; // Dm.
{
procedure GetUsedFiles(const PasFile,ADefines,AIgnoreDefines,
InclFolders,DPUPath:String;UsedFiles:TStrings);
}
Procedure DCGetUsedFilesEx( Const PasFile, ADefines, AIgnoreDefines, InclFolders, DPUPath : String;
  UsedFiles:TStrings; AIgnoreExistDPU, ANoDefaultDefines : Boolean;
  AMsgHandler:TDCMsgHandler;ADestroyParser:boolean); // Dm.
{
procedure GetUsedFilesList(PasFiles,UsedFiles:TStrings;
const Defines,IgnoreDefines,InclFolders,DPUPath:String);
}
Procedure DCGetUsedFilesListEx( PasFiles, UsedFiles : TStrings;
  Const Defines, IgnoreDefines, InclFolders, DPUPath : String;
  AIgnoreExistDPU, ANoDefaultDefines : Boolean; AMsgHandler : TDCMsgHandler;
  ADestroyParser:boolean;UsedFilesPerUnit:TStrings);

{$IFDEF WIN32}
Procedure DCGenVCLDPUsForVer( Const DestPath : String; DelphiVer : TDelphiVer;
                               AIgnoreExistDPU, ANoDefaultDefines : Boolean;
                               AMsgHandler : TDCMsgHandler );

Procedure DCGenVCLDPUs( Const DestPath : String );

Procedure DCGenVCLDPUsEx( Const DestPath : String; AIgnoreExistDPU, ANoDefaultDefines : Boolean;
                           AMsgHandler : TDCMsgHandler );

{$ENDIF}
Procedure DCRemoveCreatedParsers;

const
  GSEMPTY = 0;

  cArrayOfConst = 'Array of Const'; //don't resource

  CompiledHeader = 'DC IMP V1.036 ' + SDreamControlsVersion; //don't resource

//  CompiledHeader = 'Dream Company'; //don't resource

function GetBaseTypeName(bType : TBaseType) : string;

const
  DCSkipAbsentVCLUnits:boolean=True;

procedure DCRemoveBadVCLUnits(UnitList:TStrings;DelphiVer:TDelphiVer);
function DCUnitIsInBadUnits(const FileName:String;DelphiVer:TDelphiVer):boolean;

{-----------------------------------}

type
  TDCOnIgnoreExistDPUProc=function(UnitParser:TUnitParser;const FileName:String):boolean;
var
  DCOnIgnoreExistDPU:TDCOnIgnoreExistDPUProc;
  DCOnIgnoreSaveToDPU:TDCOnIgnoreExistDPUProc;
  DConIgnoreImplementation:TDCOnIgnoreExistDPUProc;

function DCIgnoreDPUsButNotVCL(UnitParser:TUnitParser;const FileName:String):boolean;

function DCPathIsInAnyDelphiDirs(const Path:String):boolean;
function DCPathIsInDelphiDirs(const Path:String;DelphiVer:TDelphiVer):boolean;
function DCPathIsInPaths(const Path,Paths:String):boolean;

{-----------------------------------}

var
  Parsers : TList;

{-----------------------------------}

type
  TDCCheckParserProc=function(UnitParser:TUnitParser;UserData:Pointer):boolean;

procedure DCEnumParsersToDestroy(List:TList;ParserIsOk:TDCCheckParserProc;UserData:Pointer);

{-----------------------------------}

implementation

{-----------------------------------}

function DCPathIsInPaths(const Path,Paths:String):boolean;
var
  APath,APaths:String;
begin
  APath:=';'+AnsiUpperCase(RemoveSlash(Path))+';';
  APaths:=';'+AnsiUpperCase(Paths)+';';
  Result:=Pos(APath,APaths)<>0;
end;

{-----------------------------------}

function DCPathIsInDelphiDirs(const Path:String;DelphiVer:TDelphiVer):boolean;
begin
  Result:=DCPathIsInPaths(Path,GetDelphiSourceDirsEx(DelphiVer));
end;

{-----------------------------------}

function DCPathIsInAnyDelphiDirs(const Path:String):boolean;
var
  i:TDelphiVer;
begin
  for i:=Low(TDelphiVer) to High(TDelphiVer) do
    If DCPathIsInDelphiDirs(Path,i) then
    begin
      Result:=True;
      exit;
    end;
  Result:=False;  
end;

{-----------------------------------}

function DCIgnoreDPUsButNotVCL(UnitParser:TUnitParser;const FileName:String):boolean;
begin
{
  Writeln('Checked '+FileName);
}
  Result:=not DCPathIsInAnyDelphiDirs(ExtractFilePath(FileName));
{
  If not Result then
    Writeln('is VCL unit');
}
end;

{-----------------------------------}

const
  SDCD2BadUnits:Array[0..0] of String=('');
  SDCC1BadUnits:Array[0..0] of String=('');

  SDCD4BadUnits:Array[0..5] of String=(
    'dcdsgnintf.pas',
    'dcdsgnutil.pas',
    'OLE2.pas',
    'OLECTL.pas',
    'OLEAUTO.pas',
    'DELPHIMM.pas'
  );

  SDCD5BadUnits:Array[0..5] of String=(
    'dcdsgnintf.pas',
    'dcdsgnutil.pas',
    'OLE2.pas',
    'OLECTL.pas',
    'OLEAUTO.pas',
    'DELPHIMM.pas'
  );

  SDCC3BadUnits:Array[0..16] of String=(
    'dcdsgnintf.pas',
    'dcdsgnutil.pas',
    'dcactlst.pas',
    'dcActLstReg.pas',
    'dcdsgnstuff.pas',
    'DSGNWNDS.pas',
    'PICEDIT.pas',
    'VCSINTF.pas',
    'BORLNDMM.pas',
    'DDEREG.pas',
    'DELPHIMM.pas',
    'DSGNWNDS.pas',
    'OLE2.pas',
    'OLEAUTO.pas',
    'OLECTL.pas',
    'OLEREG.pas',
    'STDREG.pas'
  );

  SDCC4BadUnits:Array[0..10] of String=(
    'dcdsgnintf.pas',
    'dcdsgnutil.pas',
    'DSGNWNDS.pas',
    'BORLNDMM.pas',
    'DELPHIMM.pas',
    'DSGNWNDS.pas',
    'OLE2.pas',
    'OLEAUTO.pas',
    'OLECTL.pas',
    'OLEREG.pas',
    'STDREG.pas'
  );

  SDCC5BadUnits:Array[0..7] of String=(
    'dcdsgnintf.pas',
    'dcdsgnutil.pas',
    'DSGNWNDS.pas',
    'WCOMPREG.pas',
    'DELPHIMM.pas',
    'OLE2.pas',
    'OLEAUTO.pas',
    'OLECTL.pas'
  );

  SDCD3BadUnits:Array[0..9] of String=(
    'dcdsgnintf.pas',
    'dcdsgnutil.pas',
    'dcactlst.pas',
    'dcActLstReg.pas',
    'dcdsgnstuff.pas',
    'OLE2.pas',
    'OLECTL.pas',
    'PICEDIT.pas',
    'OLEAUTO.pas',
    'DELPHIMM.pas'
  );

  SDCD6BadUnits:Array[0..19] of String=(
    'CLXICONEDIT.pas',
    'CLXIMGEDIT.pas',
    'CLXITEMEDIT.pas',
    'CLXNODEEDIT.pas',
    'CLXPICEDIT.pas',
    'CLXSTREDIT.pas',
    'MIDREG.pas',
    'CORBAOBJ.pas',
    'CORBAVCL.pas',
    'OLE2.pas',
    'OLECTL.pas',
    'CLXDESIGNWINDOWS.pas',
    'CLXEDITORS.pas',
    'CLXSPRIGS.pas',
    'CORBACON.pas',
    'CORBASTD.pas',
    'OLEAUTO.pas',
    'SCKTMAIN.pas',
    'DELPHIMM.pas',
    'HTTPINTR.pas'
  );

  SDCD2AbsentUnits:Array[0..0] of String=('');
  SDCC1AbsentUnits:Array[0..0] of String=('');

  SDCD3AbsentUnits:Array[0..14] of String=(
    'LibIntf.pas',
    'mxarrays.pas',
    'mxpbar.pas',
    'mxtables.pas',
    'mxqparse.pas',
    'mxbutton.pas',
    'syncobjs.pas',
    'mxqedcom.pas',
    'chart.pas',
    'masks.pas',
    'series.pas',
    'teengine.pas',
    'TeeProcs.pas',
    'QuickRpt.pas',
    'QRExport.pas'
  );

  SDCD4AbsentUnits:Array[0..14] of String=(
    'Masks.pas',
    'LibIntf.pas',
    'mxarrays.pas',
    'mxpbar.pas',
    'mxtables.pas',
    'mxqparse.pas',
    'mxqedcom.pas',
    'mxbutton.pas',
    'mxArrays.pas',
    'QuickRpt.pas',
    'QRExport.pas',
    'chart.pas',
    'series.pas',
    'teengine.pas',
    'TeeProcs.pas'
  );

  SDCD5AbsentUnits:Array[0..13+18] of String=(
    'DsnDB.pas',
    'DrpCtrls.pas',
    'DsnDBCst.pas',
    'DMForm.pas',
    'DataModelViews.pas',
    'DataModelSupport.pas',
    'DbXPlor.pas',
    'ModelViews.pas',
    'ModelPrimitives.pas ',
    'teengine.pas',
    'TeeProcs.pas',
    'ToolWnds.pas',
    'TblDsgn.pas',
    'ParentageSupport.pas',
    'series.pas',
    'RSConsts.pas',
    'GQEDelph.pas',
    'CnColEdt.pas',
    'LibIntf.pas',
    'QuickRpt.pas',
    'QRExport.pas',
    'chart.pas',
    'ChartReg.pas',
    'CustomModuleEditors.pas',
    'Report.pas',
    'LibIntf.pas',
    'LibHelp.pas',
    'DmDesigner.pas',
    'IBInstallHeader.pas',
    'IBServices.pas',
    'MidProd.pas',
    'HTTPApp.pas'
  );

  SDCC3AbsentUnits:Array[0..16] of String=(
    'SysConst.pas',
    'QuickRpt.pas',
    'QRExport.pas',
    'ActiveX.pas',
    'Masks.pas',
    'LibIntf.pas',
    'mxarrays.pas',
    'mxpbar.pas',
    'mxtables.pas',
    'mxqparse.pas',
    'mxqedcom.pas',
    'mxbutton.pas',
    'chart.pas',
    'series.pas',
    'teengine.pas',
    'TeeProcs.pas',
    'ScktComp.pas'
  );

  SDCC4AbsentUnits:Array[0..14] of String=(
    'ActiveX.pas',
    'QuickRpt.pas',
    'QRExport.pas',
    'Masks.pas',
    'LibIntf.pas',
    'mxarrays.pas',
    'mxpbar.pas',
    'mxTables.pas',
    'mxqparse.pas',
    'mxqedcom.pas',
    'mxbutton.pas',
    'chart.pas',
    'series.pas',
    'teengine.pas',
    'TeeProcs.pas'
  );

  SDCC5AbsentUnits:Array[0..11] of String=(
    'series.pas',
    'teengine.pas',
    'TeeProcs.pas',
    'LibIntf.pas',
    'chart.pas',
    'QuickRpt.pas',
    'QRExport.pas',
    'ChartReg.pas',
    'IBInstallHeader.pas',
    'IBServices.pas',
    'MidProd.pas',
    'HTTPApp.pas'
  );

  SDCD6AbsentUnits:Array[0..28] of String=(
    'IBInstallHeader.pas',
    'QuickRpt.pas',
    'QRExport.pas',
    'IBServices.pas',
    'ComponentDesigner.pas',
    'CHART.pas',
    'CHARTREG.pas',
    'DsnDb.pas',
    'Report.pas',
    'LibHelp.pas',
    'LibHelp.pas',
    'DsnConst.pas',
    'ComponentDesigner.pas',
    'LibHelp.pas',
    'DsnDBCst.pas',
    'RSCONSTS.pas',
    'ToolWnds.pas',
    'DrpCtrls.pas',
    'SERIES.pas',
    'WItemEdt.pas',
    'TEENGINE.pas',
    'TEEPROCS.pas',
    'DiagramSupport.pas',
    'Dbxplor.pas',
    'GqeDelph.pas',
    'TblDsgn.pas',
    'CNCOLEDT.pas',
    'DMForm.pas',
    'LMidReg.pas'
  );

{------------------------------------------------------------------}
(*
function LoadModule(const FileName, ADefines, Units, Aliases : string) : TUnitParser;
begin
//  Result:=LoadModuleEx(FileName, ADefines, '', Units, Aliases,'',TUnitParser); // Dm.
  Result := DCLoadModule( FileName, ADefines, '', Units, Aliases, '', TUnitParser, False, False, Nil ); // Dm
end;
*)
{------------------------------------------------------------------}

function LoadModuleEx(const FileName, ADefines, AIgnoreDefines, Units,
           Aliases,DPUFolder : string;
           ParserClass:TUnitParserClass;ANoDefaultDefines:Boolean;
           AMsgHandler:TDCMsgHandler) : TUnitParser;
begin
  Result := DCLoadModule( FileName, ADefines, AIgnoreDefines, Units,
                          Aliases, DPUFolder, ParserClass, False,
                          ANoDefaultDefines,AMsgHandler);
end;

{------------------------------------------------------------------}

Function DCLoadModule( Const FileName, ADefines, AIgnoreDefines, Units, Aliases,
                        DPUFolder : String; ParserClass : TUnitParserClass;
                        AIgnoreExistDPU, ANoDefaultDefines : Boolean;
                        AMsgHandler : TDCMsgHandler ) : TUnitParser; // Dm.
begin
  {WriteToLog(FileName);}
  result := ParserClass.Create(nil);
  with result do
    try
      CompiledPath:=DPUFolder;
      If CompiledPath='' then
        CompiledPath := AppFolder;
      IgnoreExistDPU := AIgnoreExistDPU;
      MsgHandler := AMsgHandler;
      If ANoDefaultDefines Then
        Defines.Clear;
      NoDefaultDefines := ANoDefaultDefines;
      LoadFromFile(FileName, ADefines, AIgnoreDefines,Units, Aliases);
    except
      Free;
      raise;
    end;
end;

{------------------------------------------------------------------}

function CreateRecordList(size : integer) : TRecordList;
begin
  result := TRecordList.Create(size);
end;

{-----------------------------------------------------------}

procedure WriteStrings(w : TWriter; Strings : TStrings);
var
  i : integer;
begin
  with Strings do
    begin
      w.WriteString(Text);
      for i := 0 to Count - 1 do
        w.WriteInteger(integer(Objects[i]));
    end;
end;

{-----------------------------------------------------------}

procedure ReadStrings(r : TReader; Strings : TStrings);
var
  i : integer;
  s : string;
begin
  with Strings do
    begin
      s := r.ReadString;
      Text := s;
      for i := 0 to Count - 1 do
        Objects[i] := TObject(r.ReadInteger);
    end;
end;

{-----------------------------------------------------------}

procedure WriteStringsToStream(S : TStream; Strings : TStrings);
var
  w : TWriter;
begin
  w := TWriter.Create(S, 4096);
  try
    WriteStrings(w, Strings);
  finally
    w.Free;
  end;
end;

{-----------------------------------------------------------}

procedure ReadStringsFromStream(S : TStream; Strings : TStrings);
var
  r : TReader;
begin
  r := TReader.Create(S, 4096);
  try
    ReadStrings(r, Strings);
  finally
    r.Free;
  end;
end;

{-----------------------------------------------------------}

function TModuleInfo.GetGlobalString(GS : GlobalString) : string;
begin
  if GS = GSEMPTY then
    result := ''
  else
    result := PShortString(GS + GlobalStrings.BaseAddr)^;
end;

{-----------------------------------------------------------}

function TModuleInfo.SetGlobalString(const s : string) : GlobalString;
var
  index : integer;
begin
  if s = '' then
    result := GSEMPTY
  else
    with fGStrings do
      begin
        index := Add(s);
        result := integer(Objects[index]);
        if result = 0 then
          begin
            result := GlobalStrings.Add(s);
            Objects[index] := TObject(result);
          end;
      end;
end;

{-----------------------------------------------------------}

constructor TStringHolder.Create;
begin
  inherited;
  fStream := TMemoryStream.Create;
  fStream.Write(fStream, 1);
end;

{-----------------------------------------------------------}

destructor  TStringHolder.Destroy;
begin
  fStream.Free;
  inherited;
end;

{-----------------------------------------------------------}

procedure   TStringHolder.SaveToStream(S : TStream);
var
  ssize : integer;
begin
  with fStream do
    begin
      ssize := Size;
      S.Write(ssize, sizeof(integer));
      S.Write(Memory^, Size);
    end;
end;

{-----------------------------------------------------------}

procedure   TStringHolder.LoadFromStream(S : TStream);
var
  ssize : integer;
begin
  with fStream do
    begin
      S.Read(ssize, sizeof(integer));
      SetSize(ssize);
      S.Read(Memory^, ssize);
    end;
end;

{-----------------------------------------------------------}

function TStringHolder.GetBaseAddr : PChar;
begin
  result := fStream.Memory;
end;

{-----------------------------------------------------------}

function TStringHolder.Add(const s : string) : integer;
var
  ss : ShortString;
begin
  result := fStream.Position;
  ss := s;
  fStream.Write(ss, length(ss) + 1);
end;

{***********************************************************}

const
  SCallType : array[TCallType] of string =
  ('Register', 'Pascal', 'Cdecl', 'StdCall', 'SafeCall'); //don't resource

constructor TUnitParser.Create(AOwner : TComponent);
begin
  inherited;
  fModuleInfo := TModuleInfo.Create;
  fParams     := TStringList.Create;
  fAliasesList := TStringList.Create;
  fDefaultStringType := btAnsiString;
  InitDelphiSyntax;
  InitTypes;
  Parsers.Add(self);
end;

{-----------------------------------------------------------}

destructor  TUnitParser.Destroy;
begin
  fModuleInfo.Free;
  fParams.Free;
  Parsers.Remove(self);
  fAliasesList.Free;
  inherited;
end;

{-----------------------------------------------------------}

procedure TUnitParser.Release;
begin
  dec(fRefCount);
  if fRefCount = 0 then
    Free;
end;

{-----------------------------------------------------------}

procedure TUnitParser.AddRef;
begin
  inc(fRefCount);
end;

{-----------------------------------------------------------}

procedure TUnitParser.SetCompiledPath(const Path : string);
begin
  fCompiledPath := AddSlash(Path);
end;

{-----------------------------------------------------------}

type
  TBaseTypeDesc = record
    bType : TBaseType;
    Name  : string;
  end;

const
//BeginSkipConst
  BaseTypes : array[TBaseType] of TBaseTypeDesc =
(
//  (bType : btNone       ; Name : ''           ),
  (bType : btInteger    ; Name : 'Integer'    ),
  (bType : btShortint   ; Name : 'Shortint'   ),
  (bType : btSmallInt   ; Name : 'SmallInt'   ),
  (bType : btLongint    ; Name : 'Longint'    ),
  (bType : btByte       ; Name : 'Byte'       ),
  (bType : btWord       ; Name : 'Word'       ),
  (bType : btCardinal   ; Name : 'Cardinal'   ),
  (bType : btChar       ; Name : 'Char'       ),
  (bType : btAnsiChar   ; Name : 'AnsiChar'   ),
  (bType : btBoolean    ; Name : 'Boolean'    ),
  (bType : btByteBool   ; Name : 'ByteBool'   ),
  (bType : btWordBool   ; Name : 'WordBool'   ),
  (bType : btLongBool   ; Name : 'LongBool'   ),
  (bType : btValuedEnum ; Name : ''           ),
  (bType : btEnum       ; Name : ''           ),
  (bType : btReal       ; Name : 'Real'       ),
  (bType : btSingle     ; Name : 'Single'     ),
  (bType : btDouble     ; Name : 'Double'     ),
  (bType : btExtended   ; Name : 'Extended'   ),
  (bType : btComp       ; Name : 'Comp'       ),
  (bType : btCurrency   ; Name : 'Currency'   ),
  (bType : btShortString; Name : 'ShortString'),
  (bType : btAnsiString ; Name : 'AnsiString' ),
  (bType : btWideString ; Name : 'WideString' ),
  (bType : btPointer    ; Name : 'Pointer'    ),
  (bType : btProc       ; Name : ''           ),
  (bType : btPChar      ; Name : 'PChar'      ),
  (bType : btPWideChar  ; Name : 'PWideChar'  ),
  (bType : btPAnsiChar  ; Name : 'PAnsiChar'  ),
  (bType : btFile       ; Name : 'File'       ),
  (bType : btText       ; Name : 'Text'       ),
  (bType : btInt64      ; Name : 'Int64'      ),
  (bType : btRecord     ; Name : ''      )
);
//EndSkipConst

function GetBaseTypeName(bType : TBaseType) : string;
begin
  result := BaseTypes[bType].Name;
end;

procedure TUnitParser.InitTypes;
var
  i    : TBaseType;
begin
  for i := Low(TBaseType) to High(TBaseType) do
    with ModuleInfo, PTypeDeclInfo(TypList[TypList.Add(nil)])^, BaseTypes[i] do
      if Name <> '' then
        begin
          BaseType := bType;
          TypeName := ModuleInfo.SetGlobalString(Name);
          MInfo := ModuleInfo;
          TypeList.AddObject(Name, TObject(TypList.Count - 1))
        end;

  with ModuleInfo, PTypeDeclInfo(TypList[TypList.Add(nil)])^ do
    begin
      Reference := trClassOf;
      MInfo := ModuleInfo;
      TypeName := ModuleInfo.SetGlobalString('TClass'); //don't resource
      BaseName := ModuleInfo.SetGlobalString('Object'); //don't resource
      TypeList.AddObject('TClass', TObject(TypList.Count - 1)); //don't resource
    end;

  with PConstInfo(ModuleInfo.ConstList[AddNewConst('nil')])^ do //don't resource
    ConstType := ModuleInfo.SetGlobalString('Pointer'); //don't resource
end;

{-----------------------------------------------------------}

procedure TUnitParser.ProcessDeclaration(Proc : TDeclProc);
begin
  repeat
    Proc;
    while IsTokenChar(';') do
      NextValidToken;
  until ParserEOF or ((Token = tokResWord) and not (ResWordID in [ID_ABSOLUTE, ID_INDEX, ID_MESSAGE]));
end;

{-----------------------------------------------------------}

procedure TUnitParser.ProcessDeclarationFromNextToken(Proc : TDeclProc);
begin
  NextValidToken;
  ProcessDeclaration(Proc);
end;

{-----------------------------------------------------------}

function  TUnitParser.GetErrorDesc : string;
begin
  result := 'Unit : ' + ModuleInfo.ModuleFile; //don't resource
end;

{-----------------------------------------------------------}

procedure TUnitParser.GenerateParsedFile;
var
  FS : TFileStream;
  pfname : string;
begin
  pfname := CompiledPath + ChangeFileExt(ExtractFileName(ModuleInfo.ModuleFile), CompiledExt);

  If Assigned(DCOnIgnoreSaveToDPU) then
    If DCOnIgnoreSaveToDPU(Self,ModuleInfo.ModuleFile) then
    begin
      If ikNotSavedTo in ParserInfoKinds then
        OutMessage(SDCNotSavedTo+pfName);
      exit;
    end;

  FS := TFileStream.Create(pfname, fmCreate);
  try
    SaveToStream(FS);
    if ikSavedTo in ParserInfoKinds then
      OutMessage(SDCSavedTo+pfName);
  finally
    FS.Free;
  end;
end;

{-----------------------------------------------------------}

procedure CalcVMT(pti : PTypeDeclInfo);
var
  i      : integer;
  tdecl  : PTypeDeclInfo;
  mindex : integer;
  mcount : integer;

  function IsVirtual(MFlags : TMethodFlags) : boolean;
  begin
    result := [mfVirtual{$IFDEF VER93}, mfDynamic{$ENDIF}] * MFlags <> [];
  end;

  function IsDynamic(MFlags : TMethodFlags) : boolean;
  begin
    result := {$IFDEF VER93}false{$ELSE}mfDynamic in MFlags{$ENDIF};
  end;
{
var
  S1,S:String;
}
begin
  with pti^ do
    begin
{
      S:=MInfo.GetGlobalString(BaseName);
      S1:=MInfo.GetGlobalString(TypeName);
      If S='TCustomListAction' then
        asm nop end;
}
      if (TypeKind <> tdClass) or VMCalculated then
        exit;
{
      WriteToLog('Calc VMT '+S1+'=class('+S+')');
}
      mindex := MethodIndex;
      mcount := MethodCount - 1;
{
      If S1='TCustomGroupBox' then
        asm nop end;
}
      with MInfo do
        tdecl := GetTypeDecl(GetGlobalString(BaseName));

      if tdecl <> nil then
        begin
          {WriteToLog('before CalcVmt');}
          CalcVMT(tdecl);
          {WriteToLog('after CalcVmt');}
          VMStart := tdecl.vmstart + tdecl.vmcount;
          {WriteToLog('after SetVMStart');}
          DynaStart := tdecl.DynaStart + tdecl.DynaCount;
        end;

      if BaseName <> GSEMPTY then
        for i := mindex to mIndex + mcount do
          begin
            with PMethodInfo(MInfo.ProcList[i])^ do
              begin
                if IsVirtual(MethodFlags) then
                  begin
                    VMTOffset := (vmstart + vmcount) * sizeof(pointer);
                    inc(VMCount);
                  end;
              end;
          end
      else
        begin
          for i := mIndex + mcount downto mindex do
            begin
              with PMethodInfo(MInfo.ProcList[i])^ do
                begin
                  if IsVirtual(MethodFlags) then
                    begin
                      VMTOffset := - (vmcount * sizeof(pointer));
                      inc(VMCount);
                    end;
                end;
            end;
          VMStart := - VMCount;
        end;

      for i := mindex to mIndex + mcount do
        begin
          with PMethodInfo(MInfo.ProcList[i])^ do
            begin
              if IsDynamic(MethodFlags) then
                begin
                  VMTOffset := DynaStart + DynaCount;
                  inc(DynaCount);
                end;
            end;
        end;

      VMCalculated := true;
    end;
end;

{-----------------------------------------------------------}

procedure TUnitParser.CalcVMTs;
var
  i : integer;
{  S,S1:String;}
begin
  with ModuleInfo, TypList do
    for i := 0 to Count - 1 do
    begin
      {
      With PTypeDeclInfo(TypList[i])^ do
      begin
        S:=ModuleInfo.GetGlobalString(BaseName);
        S1:=ModuleInfo.GetGlobalString(TypeName);

        if (TypeKind = tdClass) then
          WriteToLog(IntToHex(Integer(TypList[i]),8)+'   '+IntToStr(i)+' '+S1+'=class('+S+')');
      end;
      }
      CalcVMT(PTypeDeclInfo(TypList[i]));
    end;
end;

{-----------------------------------------------------------}

function DCUnitIsInAbsentUnits(const FileName:String;DelphiVer:TDelphiVer):boolean;
begin
  case DelphiVer of
    dvD2:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD2AbsentUnits);
    dvC1:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCC1AbsentUnits);
    dvD3:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD3AbsentUnits);
    dvC3:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCC3AbsentUnits);
    dvD4:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD4AbsentUnits);
    dvC4:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCC4AbsentUnits);
    dvD5:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD5AbsentUnits);
    dvC5:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCC5AbsentUnits);
    dvd6:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD6AbsentUnits);
    else
      Result:=False;
  end;
end;

{-----------------------------------------------------------}

function DCUnitIsInBadUnits(const FileName:String;DelphiVer:TDelphiVer):boolean;
begin
  case DelphiVer of
    dvD2:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD2BadUnits);
    dvC1:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCC1BadUnits);
    dvD3:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD3BadUnits);
    dvC3:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCC3BadUnits);
    dvD4:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD4BadUnits);
    dvC4:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCC4BadUnits);
    dvD5:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD5BadUnits);
    dvC5:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCC5BadUnits);
    dvd6:
      Result:=DCIsStrInStrArray(ExtractFileName(FileName),SDCD6BadUnits);
    else
      Result:=False;
  end;
end;

{-----------------------------------------------------------}

procedure DCRemoveBadVCLUnits(UnitList:TStrings;DelphiVer:TDelphiVer);
var
  i:Integer;
begin
  for i:=UnitList.Count-1 downto 0 do
    if DCUnitIsInBadUnits(UnitList[i],DelphiVer) then
      UnitList.Delete(i);
end;

{-----------------------------------------------------------}

Procedure TUnitParser.DoFileConfirm( Var AFileName : String; Var AConsiderEmpty : Boolean );
begin
  AConsiderEmpty := True;

  If DCUnitIsInAbsentUnits(AFileName,DelphiVer) and DCSkipAbsentVCLUnits then
    exit;

  DoWriteToLog(AFileName+' not found');

  If Assigned( FMsgHandler ) Then
    MsgHandler( SDCError + Format( SErrFileNotFound, [AFileName] ) )
  else
    ErrorFmt(SErrFileNotFound,[AFileName]);
end;

{-----------------------------------------------------------}

procedure TUnitParser.OutMessage(const S:String);
begin
  If Assigned(FMsgHandler) Then
    MsgHandler(S);
end;

{-----------------------------------------------------------}

procedure TUnitParser.ParseText;
var
  S:String;
begin
//  writeln('Parsing ' + ModuleInfo.ModuleFile);
  while not (ParserEOF or IsTokenResWord(ID_Implementation)) do
    begin
      if IsTokenChar(';') then
        begin
          NextValidToken;
          continue;
        end;

      S:=TokenString;

      if Token = tokResWord then
        begin
//          SendDebug(IntToStr(LinePos));
        case ResWordID of
          ID_CONST, ID_RESOURCESTRING : begin
                                          NextValidToken;
                                          repeat
                                            ProcessDeclaration(ProcessConst);
                                          until not IsTokenResWord(ID_ABSOLUTE);
                                        end;

          ID_FUNCTION, ID_PROCEDURE : with ModuleInfo do
                                         ProcessFunction(sPublic, mtProc, GlobalProcList, ProcIndex, ProcCount, false);
          ID_INTERFACE : begin
                           if CompareText(ModuleInfo.ModuleName, 'system') <> 0 then //don't resource
                             UseUnit('System'); //don't resource
                           NextToken;
                         end;
          ID_LIBRARY : ProcessModuleType(moLibrary);
          ID_TYPE :
            ProcessDeclarationFromNextToken(ProcessType);
          ID_UNIT : ProcessModuleType(moUnit);
          ID_PROGRAM : ProcessModuleType(moProgram);
          ID_THREADVAR : begin
                           fThreadVar := true;
                           ProcessDeclarationFromNextToken(ProcessVar); //!!!!!
                         end;
          ID_USES : ProcessUses(ModuleInfo.InterfaceUses,True);
          ID_VAR  : begin
                      fThreadVar := false;
                      ProcessDeclarationFromNextToken(ProcessVar);
                    end;
        else
          NextToken;
        end
       end
      else
        NextToken;
    end;
  CalcVMTs;
end;

{-----------------------------------------------------------}

function  TUnitParser.ProcessParamList(CloseBracket : char; var ParamIndex : integer; var DefaultParam : word) : integer;
var
  Flags : TParamFlags;
  VarType : string;

  {---------------------------------}

  procedure OutVars;
  var
    PInfo  : PParamInfo;
    index  : integer;
  begin
    with fParams, ModuleInfo do
      while Count > 0 do
        begin
          index := integer(Objects[0]);
          pinfo := PParamInfo(GlobalParams[index]);
          with pinfo^ do
            begin
              ParamName := SetGlobalString(Strings[0]);
              ParamType := ModuleInfo.SetGlobalString(VarType);
              ParamFlags := Flags;
              if result = 0 then
                ParamIndex := index;
              Delete(0);
              inc(result);
            end;
        end;
  end;

  {---------------------------------}
var
  peekstr : string;

begin
  fParams.Clear;
  result := 0;
  NextValidToken; // (
  Flags := [];

  while not (ParserEOF or IsTokenChar(CloseBracket)) do
    begin
      if IsTokenResWord(ID_VAR) then
        Flags := [pfVar]
{$IFDEF D3}
      else if IsTokenResWord(ID_OUT) then
        Flags := [pfOut]
{$ENDIF}
      else if IsTokenResWord(ID_CONST) then
        Flags := [pfConst]
      else if IsTokenChar(';') then
        begin
          OutVars;
          Flags := [];
        end
      else if IsTokenChar(':') then
        begin
          NextValidToken;
          if IsTokenResWord(ID_ARRAY) then
            begin
              Include(Flags, pfArray);
              NextValidToken; // OF
              NextValidToken;
            end;

          if IsTokenResWord(ID_CONST) and (pfArray in Flags) then
            VarType := cArrayOfConst
          else
            VarType := TokenString;


          If PeekValidTokenStr = '.' then               // Added in V4.1
          begin                                         //
            NextValidToken;                             //
            NextValidToken;                             //
            VarType := VarType + '.' + TokenString;     //
          end;                                          //

          if PeekValidTokenStr = '=' then
            repeat
              if DefaultParam = 0 then
                DefaultParam := result + 1;

              NextValidToken; // =
              peekstr := PeekValidTokenStr;
              if (peekstr = ';') or (peekstr = CloseBracket) then
                break;
            until ParserEOF;

          OutVars;
        end
      else if not IsTokenChar(',') then
        with ModuleInfo do
          fParams.AddObject(TokenString, TObject(GlobalParams.Add(nil)));

      NextValidToken;
    end;
  VarType := '';
  OutVars;
end;

{---------------------------------}

procedure TUnitParser.SkipHintDirectives;
begin
  while (Token = tokResWord) and (ResWordID in [ID_Deprecated, ID_Library, ID_Platform]) do
    NextValidToken;
end;

{---------------------------------}

function TUnitParser.ProcessFunction(AScope : TScope; AMethodType : TMethodType;
                         MethodList : TRecordList; var MethodIndex : integer;
                         var MethodCount : word; TypeDecl : boolean) : integer;

var
  MInfo  : PMethodInfo;

  {---------------------------------}

  procedure ProcessRetType;
  var
    S:String;
  begin
    NextValidToken; // :

    NextValidToken; // get return type or unit name
    S:=TokenString;
    If PeekValidTokenStr = '.' then   // Added in V4.1
    begin                             //
      NextValidToken;                 // Read .
      NextValidToken;                 // Read return type
      S := S + '.' + TokenString;     //
    end;                              //

    MInfo.RetType := ModuleInfo.SetGlobalString(S);
  end;

  {---------------------------------}

  procedure ProcessCallType;
  begin
    with MInfo^ do
      begin
        CallType := DefaultCallType;
        if IsTokenChar(';') then
          NextValidToken;
        if (Token = tokResWord) and
           (ResWordID in [ID_Register, ID_Pascal, ID_Cdecl, ID_StdCall, ID_SafeCall])
        then
          begin
            case ResWordID of
              ID_CDECL    : CallType := cCdecl;
              ID_PASCAL   : CallType := cPascal;
              ID_REGISTER : CallType := cRegister;
              ID_SAFECALL : CallType := cSafeCall;
              ID_STDCALL  : CallType := cStdCall;
            end;

            while (Token = tokResWord) and (ResWordID in [ID_Register, ID_Pascal, ID_Cdecl, ID_StdCall, ID_SafeCall]) do
              begin
                NextValidToken;
                while IsTokenChar(';') do
                  NextValidToken;
              end;
          end;
      end;
  end;

  {---------------------------------}

  procedure ProcessOfObject;
  begin
    if IsTokenResWord(ID_OF) then
      begin
        CheckNextResWord(ID_OBJECT);
        NextValidToken; // ;
        MInfo.OfObject := true;
      end;
  end;

  {---------------------------------}

  procedure ProcessMethodType;
  begin
    with MInfo^ do
      begin
        while IsTokenChar(';') do
          NextValidToken;

        while (Token = tokResWord) and
              (ResWordID in [ID_Abstract, ID_Dynamic, ID_Library, ID_Message, ID_Overload, ID_Override,
                             ID_Reintroduce, ID_Virtual]) do
          begin
            case ResWordID of
              ID_ABSTRACT    : Include(MethodFlags, mfAbstract);
              ID_DYNAMIC     : Include(MethodFlags, mfDynamic);
              ID_Message     : begin
                                 Include(MethodFlags, mfMessage);
                                 NextValidToken;
                               end;
              ID_OVERLOAD    : Include(MethodFlags, mfOverload);
              ID_OVERRIDE    : Include(MethodFlags, mfOverride);
              ID_REINTRODUCE : Include(MethodFlags, mfReintroduce);
              ID_VIRTUAL     : Include(MethodFlags, mfVirtual);
            end;

            repeat
              NextValidToken;
            until not IsTokenChar(';');
          end;
      end;
  end;

  {---------------------------------}

var
  mnam : string;

begin
  result := MethodList.Add(nil);
  if MethodCount = 0 then
    MethodIndex := result;

  inc(MethodCount);

  MInfo := PMethodInfo(MethodList[result]);
  with MInfo^ do
    begin
      Scope := AScope;
      MethodType := AMethodType;
      IsFunction := IsTokenResWord(ID_FUNCTION);

      if not TypeDecl then
        begin
          mnam := NextValidTokenStr;
          if PeekValidTokenStr = '.' then
            begin
              NextValidTokenStr; // '.'
              mnam := mnam + NextValidTokenStr;
            end;
          MName := ModuleInfo.SetGlobalString(MNam);
        end;

      if PeekValidTokenStr = '=' then
        begin
          Include(MethodFlags, mfMapped);
          NextValidTokenStr;
          NextValidTokenStr;
          NextValidTokenStr;
          exit;
        end;

      if PeekValidTokenStr = '(' then
        begin
          NextValidToken;
          ParamCount := ProcessParamList(')', ParamIndex, DefaultParam);
        end;

      if PeekValidTokenStr = ':' then
        ProcessRetType;

      NextValidToken; // RetType

      ProcessOfObject;
      ProcessMethodType;
      ProcessCallType;
      ProcessOfObject;
      SkipHintDirectives;
    end;
end;

{-----------------------------------------------------------}

function TUnitParser.NextGS : GlobalString;
begin
  result := ModuleInfo.SetGlobalString(NextValidTokenStr);
end;

{-----------------------------------------------------------}

procedure TUnitParser.GetInheritedPropInfo(PInfo : PPropertyInfo; const BaseName : GlobalString);
var
  tdecl : PTypeDeclInfo;
  pname : string;
  i     : integer;
begin
  with ModuleInfo do
    begin
      tdecl := GetTypeDecl(GetGlobalString(BaseName));
      pname := GetGlobalString(PInfo.PropName);
    end;

  while tdecl <> nil do
    with tdecl^ do
      begin
        for i := 0 to PropCount - 1 do
          with minfo, PPropertyInfo(PropList[i + PropIndex])^ do
            if CompareText(GetGlobalString(PropName), pname) = 0 then
              begin
                pinfo.Mode := Mode;
                pinfo.VarType := ModuleInfo.SetGlobalString(GetGlobalString(VarType));
                pinfo.ParamIndex := ParamIndex;
                pinfo.ParamCount := ParamCount;
                pinfo.PStored    := PStored;
                exit;
              end;
        tdecl := MInfo.GetTypeDecl(MInfo.GetGlobalString(BaseName));
      end;
end;


{-----------------------------------------------------------}

procedure SetKindRef(PTypInfo : PTypeDeclInfo; kind : TTypeDeclKind; ref : TTypeReference);
begin
  with PTypInfo^ do
    begin
      TypeKind := kind;
      Reference := ref;
    end;
end;

{-----------------------------------------------------------}

procedure TUnitParser.ReadField;
begin
  repeat
    NextValidToken;
    NextValidToken;
  until not IsTokenChar('.');
end;

{-----------------------------------------------------------}

function TUnitParser.ProcessTypeDeclaration(const ATypeName : string) : integer;
var
  fBaseName : string;
  PTypInfo : PTypeDeclInfo;

  {---------------------------------}


  procedure ProcessClassDeclaration(const TKind : TTypeDeclKind);

    {---------------------------------}

    procedure ProcessClassContent;
    var
      DeclScope : TScope;
      ClassMethod : boolean;
      mtype       : TMethodType;

      {---------------------------------}

      procedure ProcessProperty;
      var
        pinfo  : PPropertyInfo;
        pindex : integer;
        pst    : string;
        dummy  : word;

        {---------------------------------}

      begin
        with ModuleInfo do
          begin
            pindex := PropList.Add(nil);
            pinfo := PPropertyInfo(PropList[pindex]);
            with PTypInfo^ do
              begin
                if PropCount = 0 then
                  PropIndex := pindex;
                inc(PropCount);
              end;
          end;

        with pinfo^ do
          begin
            PropName := NextGS;
            NextValidToken;

            Scope := DeclScope;

            if IsTokenChar('[') then
              begin
                ParamCount := ProcessParamList(']', ParamIndex, dummy);
                NextValidToken; // ]
              end;

            if IsTokenChar(':') then
              begin
                VarType := NextGS;
                NextValidToken;
                Include(Mode, pmDeclaredHere);
              end
            else
              begin
                GetInheritedPropInfo(pinfo, PTypInfo.BaseName);
                Exclude(Mode, pmDeclaredHere);
              end;

            if IsTokenResWord(ID_INDEX) then
              begin
                NextValidToken;
                NextValidToken;
              end;

            if IsTokenResWord(ID_READ) then
              begin
                Include(Mode, pmRead);
                ReadField;
              end;

            if IsTokenResWord(ID_WRITE) then
              begin
                Include(Mode, pmWrite);
                ReadField;
              end;

            if IsTokenResWord(ID_STORED) then
              begin
                PStored := NextGS;
                NextValidToken;
              end;

            pst := PeekValidTokenStr;

            if (CompareText(pst, 'DEFAULT') = 0) or
               (CompareText(pst, 'NODEFAULT') = 0) then
                 NextValidToken;

            if IsTokenResWord(ID_DEFAULT) then
              begin
                SkipToChar(';');
                Include(Mode, pmDefault);
              end
            else if IsTokenResWord(ID_NODEFAULT) then
              begin
                NextValidToken;
                Exclude(Mode, pmDefault);
              end;
          end;
      end;

      {---------------------------------}

    const
      NoSkipResWords = [ID_AUTOMATED, ID_CONSTRUCTOR, ID_CLASS, ID_DESTRUCTOR,
                       ID_END, ID_FUNCTION, ID_PRIVATE, ID_PROTECTED, ID_PUBLIC,
                       ID_PUBLISHED, ID_PROCEDURE, ID_PROPERTY, ID_PRIVATE];
    begin
      DeclScope := sPublic;
      ClassMethod := false;
      NextValidToken;
      while not (ParserEOF or IsTokenResWord(ID_END)) do
        begin
          if Token = tokResWord then
            case ResWordID of
              ID_AUTOMATED : begin
                               DeclScope := sAUTOMATED;
                               NextValidToken;
                             end;

              ID_CLASS     : begin
                               ClassMethod := true;
                               NextValidToken;
                             end;

              ID_CONSTRUCTOR : ProcessFunction(DeclScope, mtConstructor, ModuleInfo.ProcList, PTypInfo.MethodIndex, PTypInfo.MethodCount, false);

              ID_DESTRUCTOR :  ProcessFunction(DeclScope, mtDestructor,  ModuleInfo.ProcList, PTypInfo.MethodIndex, PTypInfo.MethodCount, false);

              ID_PRIVATE   : begin
                               DeclScope := sPRIVATE;
                               NextValidToken;
                             end;

              ID_PROTECTED : begin
                               DeclScope := sPROTECTED;
                               NextValidToken;
                             end;

              ID_PUBLIC    : begin
                               DeclScope := sPUBLIC;
                               NextValidToken;
                             end;

              ID_PUBLISHED : begin
                               DeclScope := sPUBLISHED;
                               NextValidToken;
                             end;

              ID_PROCEDURE,
              ID_FUNCTION  : begin
                               if ClassMethod then
                                 mtype := mtClassMethod
                               else
                                 mtype := mtMethod;
                               ProcessFunction(DeclScope, mtype, ModuleInfo.ProcList, PTypInfo.MethodIndex, PTypInfo.MethodCount, false);
                               ClassMethod := false;
                             end;

              ID_PROPERTY : ProcessProperty;
            end;
         if not ((Token = tokResWord) and
            (ResWordID in NoSkipResWords)) then
           NextValidToken;
        end;
      NextValidToken; // ;
    end;

    {---------------------------------}

  begin
    PTypInfo.TypeKind := TKind;

    if TKind = tdClass then
      PTypInfo.BaseType:=btInteger;

    if PeekValidTokenStr = ';' then
      begin
        NextValidToken; // ;
        exit; // forward declaration
      end;
    with PTypInfo^ do
      begin
        if PeekValidTokenStr = '(' then
          begin
            NextValidToken; // (
            BaseName := NextGS;
            SkipToChar(')');
//            NextValidToken; // )
          end
        else if TKind = tdClass then
          if ATypeName <> 'TObject' then //don't resource
            BaseName := ModuleInfo.SetGlobalString('TObject'); //don't resource

        if PeekValidTokenStr <> ';' then
          ProcessClassContent
        else
          NextToken;
      end;
  end;

  {---------------------------------}

  procedure ProcessClassOf;
  begin
    NextValidToken; // OF
    fBaseName := NextValidTokenStr; // classname
    NextValidToken; // ;
    SetKindRef(PTypInfo, tdRef, trClassOf);
  end;

  {---------------------------------}

  procedure ProcessClass(const TKind : TTypeDeclKind);
  begin
    if CompareText(PeekTokenStr, 'OF') <> 0 then  // class of //don't resource
      ProcessClassDeclaration(TKind)
    else
      ProcessClassOf;
  end;

  {---------------------------------}

  procedure ProcessEnum;
  var
    cindex : integer;
  begin
    PTypInfo.BaseType := btEnum;
    NextValidToken;

    while not IsTokenChar(')') do
      begin
        with PTypInfo^ do
          begin
            cindex := AddNewConst(TokenString);
            if ConstCount = 0 then
              ConstIndex := cindex;

            inc(ConstCount);
          end;

        NextValidToken;

        if IsTokenChar('=') then                  //  Added in V4.1
        begin                                     //
          NextValidToken; {read constant value}   //
          NextValidToken;                         //
          PTypInfo.BaseType := btValuedEnum;      //
        end;                                      //

        if IsTokenChar(',') then
          NextValidToken;
      end;
    NextValidToken;
  end;

  {---------------------------------}

  procedure ProcessSet;
  begin
    CheckNextResWord(ID_OF);
    fBaseName := NextValidTokenStr;

    If FBaseName='(' then  // Added in V4.1
      FBaseName:='Byte';    //

    if IsTokenChar('(') then
      ProcessEnum//SkipToChar(')');
    else
      NextToken; // ;
      
    SetKindRef(PTypInfo, tdRef, trSetOf);
  end;

  {---------------------------------}

  procedure ProcessArray;
  const
    ArrayKinds : array [boolean] of TTypeReference = (trArray, trDynArray);
  var
    btd : integer;
    isdynamic : boolean;
  begin
    NextValidToken;
    isdynamic := true;
    if IsTokenChar('[') then
      begin
        SkipToChar(']');
        NextValidToken;
        isdynamic := false;
      end;
    CheckResWord(ID_OF);
    fBaseName := PeekValidTokenStr;
    btd := ProcessTypeDeclaration('');
    PTypInfo := PTypeDeclInfo(ModuleInfo.TypList[result]);
    PTypInfo.BaseTypeDecl := btd;
//    NextValidToken; // ;
    SetKindRef(PTypInfo, tdRef, ArrayKinds[isdynamic]);
  end;

  {---------------------------------}

  procedure ProcessType;
  begin
    fBaseName := NextValidTokenStr;
    if PeekTokenStr = '.' then
      begin
        NextToken;
        fBaseName := fBaseName + '.' + NextTokenStr;
      end;
    SkipToChar(';');
    PTypInfo.TypeKind := tdRef;
  end;

  {---------------------------------}

  procedure ProcessRecord;
  var
    startindex : integer;
    vcount     : integer;
    vtype      : GlobalString;
    vname      : string;

    procedure _getvarlist;
    var
      i          : integer;
    begin
      while not ParserEOF do
        begin
          if IsTokenChar(')') then
            exit;

          if IsTokenResWord(ID_END) then
            begin
              NextValidToken;
              exit;
            end;

          if IsTokenResWord(ID_CASE) then
            begin
              NextValidToken;
              NextValidToken;
              if IsTokenChar(':') then
                begin
                  NextValidToken;
                  NextValidToken;
                end;
              CheckResWord(ID_OF);
              repeat
                SkipToChar(':');
                NextValidToken;
                CheckChar('(');
                NextValidToken;
                _getvarlist;
                CheckChar(')');
                NextValidToken;
                while IsTokenChar(';') do
                  NextValidToken;

                if IsTokenResWord(ID_END) then
                  begin
                    NextValidToken;
                    exit;
                  end;

                if IsTokenChar(')') then
                  exit;
              until ParserEOF;
            end
          else
            with ModuleInfo, VarList do
              begin
                startindex := Count;

                if PTypInfo^.VarCount = 0 then
                  PTypInfo^.VarIndex := startindex;

                vcount   := 0;
                while not (ParserEOF or IsTokenChar(':')) do
                  begin
                    with PVarInfo(Items[Add(nil)])^ do
                      begin
                        VarName := SetGlobalString(TokenString);
                        IsThread := fThreadVar;
                      end;

                    vname := 'R ' + ATypeName + ' ' + TokenString; //don't resource
                    inc(vcount);
                    NextValidToken;
                    if TokenString = ',' then
                      NextValidToken;
                  end;

                VType := SetGlobalString(vname);
                ProcessTypeDeclaration(vname);
                PTypInfo := PTypeDeclInfo(ModuleInfo.TypList[result]);
                for i := 0 to vcount - 1 do
                  PVarInfo(Items[startindex + i])^.VarType := VType;

                inc(PTypInfo^.VarCount, vcount);
                inc(VarCount, vcount);
                while IsTokenChar(';') do
                  NextValidToken;
              end;

        end;
    end;

  begin
    startindex := 0;
    vcount := 0;
    PTypInfo.VarCount := 0;
    NextValidToken;
    _getvarlist;

    PTypInfo^.TypeKind := tdRecord;
    PTypInfo^.BaseType := btRecord; //Added in V4.1
  end;

  {---------------------------------}

  procedure ProcessString;
  begin
    NextValidToken;
    if IsTokenChar('[') then
      begin
        PTypInfo.BaseType := btShortString;
        SkipToChar(']');
        NextValidToken;
      end
    else
      PTypInfo.BaseType := DefaultStringType;
  end;

  {---------------------------------}

  procedure ProcessSubRange;
  begin
    while not (ParserEOF or IsTokenChar('=') or IsTokenChar(';')) do
      NextToken;
  end;

  {---------------------------------}

var
  basetdecl : PTypeDeclInfo;
  typeindex : integer;
  S:String;
begin
  if ATypeName = 'TControl' then
    asm nop  end;

  if ModuleInfo.TypeList.Find(ATypeName, typeindex) then
    result := Integer(ModuleInfo.TypeList.Objects[typeindex])
  else
    begin
//      WriteToLog('TyplistAdd '+ATypeName);
      result := ModuleInfo.TypList.Add(nil);
      typeindex := -1;
    end;

  PTypInfo := PTypeDeclInfo(ModuleInfo.TypList[result]);
  PTypInfo.MInfo := ModuleInfo;
  PTypInfo.TypeName := ModuleInfo.SetGlobalString(ATypeName);

  fBaseName := '';
  NextValidToken;
  if IsTokenResWord(ID_PACKED) then
    NextValidToken;

  while (Token = tokWhiteChar) and (TokenString[1] in ['-', '+']) do
    NextValidToken;

  if (Token in [tokInteger, tokString]) or (ModuleInfo.GetConstDecl(TokenString) <> nil) then
    ProcessSubRange
  else if IsTokenChar('^') then
    begin
      SetKindRef(PTypInfo, tdRef, trPointer);
      fBaseName := NextValidTokenStr;
      NextValidToken;
//!!!!      SkipToChar(';');
    end
  else if IsTokenChar('(') then
    ProcessEnum
  else
    if Token = tokResWord then
      case ResWordID of
        ID_CLASS : ProcessClass(tdClass);
        ID_INTERFACE : ProcessClass(tdInterface);
        ID_DISPINTERFACE : ProcessClass(tdDispInterface);
        ID_OBJECT        : ProcessClass(tdObject);
        ID_ARRAY : ProcessArray;
        ID_FUNCTION,
        ID_PROCEDURE : with PTypInfo^ do
                         begin
                           BaseType := btProc;
                           ProcInfo := ProcessFunction(sPublic, mtProc, ModuleInfo.GlobalProcList, MethodIndex, MethodCount, true);
                         end;
        ID_RECORD : ProcessRecord;
        ID_SET : ProcessSet;
        ID_STRING : ProcessString;
        ID_TYPE : ProcessType;
        else
          begin
            fBaseName := TokenString;
            NextValidTokenStr;
          end;
      end
    else
      begin
        fBaseName := TokenString;
        NextValidToken;

        if IsTokenChar('.') and not IsPeekTokenChar('.') then
          begin
            NextToken;
            fBaseName := fBaseName + '.' + TokenString;
            SkipToChar(';');
          end;

        basetdecl := ModuleInfo.GetTypeDecl(fBaseName);

        if (basetdecl <> nil) and (basetdecl.TypeKind = tdClass) then
        begin
          PTypInfo.TypeKind := tdClass;
          {PTypInfo.BaseType := btInteger;}
        end;

        if IsTokenChar('.') then
          SkipToChar(';');
      end;

  SkipHintDirectives;

  with PTypInfo^ do
    if BaseName = GSEMPTY then
       BaseName := ModuleInfo.SetGlobalString(fBaseName);

  S:=ModuleInfo.GetGlobalString(PTypInfo^.BaseName);

  if (ATypeName <> '') and (typeindex < 0) then
    ModuleInfo.TypeList.AddObject(ATypeName, TObject(result));
end;

{-----------------------------------------------------------}

procedure TUnitParser.ProcessVar;
var
  startindex : integer;
  vcount     : integer;
  vtype      : GlobalString;
  i          : integer;
  vname      : string;
begin
  with ModuleInfo, VarList do
    begin
      startindex := Count;
      vcount   := 0;
      while not (ParserEOF or IsTokenChar(':')) do
        begin
          with PVarInfo(Items[Add(nil)])^ do
            begin
              VarName := SetGlobalString(TokenString);
              IsThread := fThreadVar;
            end;

          vname := 'V ' + TokenString; //don't resource
          inc(vcount);
          NextValidToken;
          if TokenString = ',' then
            NextValidToken;
        end;

      VType := SetGlobalString(vname);
      ProcessTypeDeclaration(vname);
      for i := 0 to vcount - 1 do
        PVarInfo(Items[startindex + i])^.VarType := VType;

      inc(VarCount, vcount)
    end;


  if IsTokenChar('=') then
    begin
      NextValidToken;
      if IsTokenChar('(') then
        FindCloseBracket;
      SkipToChar(';')
    end
  else if IsTokenResWord(ID_ABSOLUTE) then
    SkipToChar(';');

  SkipHintDirectives;
end;

{-----------------------------------------------------------}

procedure TUnitParser.ProcessType;
var
  tname : string;
begin
  tname := TokenString; //
//  WriteToLog('Process type '+ tname);
  if tname = 'TListControlItems' then
    asm nop end;
  NextValidToken;       // =
  ProcessTypeDeclaration(tname);
end;

{-----------------------------------------------------------}

procedure TUnitParser.UseUnit(const UnitName : string);
var
  parser: TUnitParser;
  i     : integer;
begin
{
  If AnsiUpperCase(ExtractFileExt(UnitName))<>'.PAS' then
    asm nop end;
}
  parser := nil;
  with Parsers do
    for i := 0 to Count - 1 do
      if CompareText(TUnitParser(Items[i]).ModuleInfo.ModuleName, UnitName) = 0 then
        begin
          parser := TUnitParser(Items[i]);
          break;
        end;

  if parser = nil then
    parser := DCLoadModule(ExtractFilePath(ModuleInfo.ModuleFile) +
      ChangeFileExt(UnitName, '.'+SExtPas), fDefines, IgnoreDefinesAsLine,
      fUnits, fAliases,
      CompiledPath,TUnitParserClass(ClassType), IgnoreExistDPU, NoDefaultDefines, MsgHandler ); //don't resource // Dm.

  parser.AddRef;
  ModuleInfo.UsedUnits.AddObject(UnitName, parser);
end;

{-----------------------------------------------------------}

procedure TUnitParser.ProcessUses(UsesList : TStrings;DouseUnit:boolean);
var
  uname : string;
  vname : string;
begin
  NextValidToken;
  while not ParserEOF do
    begin
      uname := TokenString;
      vname := fAliasesList.Values[uname];
      if vname <> '' then
      begin
        If (DelphiVer in [dvd2..dvc5]) and
           (AnsiCompareText(vname,'orbpas40')=0)
        then
          begin
          end
        else
          uname := vname;
      end;

      if UsesList.IndexOf(uname) < 0 then
        begin
          UsesList.Add(uname);
          If DouseUnit then
            UseUnit(uname);
        end;

      NextValidToken;

      if IsTokenResWord(ID_IN) then
        begin
          NextValidToken;
          NextValidToken;
        end;

      if IsTokenChar(';') then
        break;

      NextValidToken;
    end;
end;

{-----------------------------------------------------------}

procedure TUnitParser.ProcessModuleType(AModuleType : TModuleType);
begin
  with ModuleInfo do
    begin
      ModuleType := AModuleType;
      ModuleName := NextValidTokenStr;
      NextValidToken;
      SkipHintDirectives;
      CheckChar(';');
    end;
end;

{-----------------------------------------------------------}

procedure TUnitParser.FindCloseBracket;
var
  level : integer;
begin
  level := 1;
  while not ParserEOF and (level > 0) do
    begin
      NextValidToken;
      if IsTokenChar('(') then
        inc(level)
      else if IsTokenChar(')') then
        dec(level);
    end;
end;

{-----------------------------------------------------------}

procedure TUnitParser.ProcessTypedConst(PConst : PConstInfo);
begin
  ProcessTypeDeclaration(ModuleInfo.GetGlobalString(PConst.ConstType));
  CheckChar('=');
  NextValidToken;
  if IsTokenChar('(') then
    FindCloseBracket;
  SkipToChar(';');
end;

{-----------------------------------------------------------}

procedure TUnitParser.ProcessSimpleConst(PConst : PConstInfo);
var
  decl : PTypeDeclInfo;
  PTypInfo : PTypeDeclInfo;
  index    : integer;
  constdecl: PConstInfo;
begin
  CheckChar('=');
  NextValidToken;

  if IsTokenChar('[') then
    PConst.IsSet := true
  else
    begin
      decl := ModuleInfo.GetTypeDecl(TokenString);
      if decl <> nil then
        with ModuleInfo do
          begin
            index := TypList.Add(nil);
            PTypInfo := PTypeDeclInfo(TypList[index]);
            TypeList.AddObject(GetGlobalString(PConst.ConstType), TObject(index));
            PTypInfo^.MInfo := ModuleInfo;
            PTypInfo^.BaseName := ModuleInfo.SetGlobalString(TokenString);
          end
      else
        with ModuleInfo do
          begin
            constdecl := GetConstDecl(TokenString);
            if constdecl <> nil then
              begin
                PConst^.ConstType := SetGlobalString(constdecl.MInfo.GetGlobalString(constdecl.ConstType));
                PConst^.IsSet := constdecl.IsSet;
              end;
          end;
    end;

  SkipToChar(';');
end;

{-----------------------------------------------------------}

function TUnitParser.AddNewConst(const AConstName : string) : integer;
begin
  with ModuleInfo.ConstList do
    result := Add(nil);

  with PConstInfo(ModuleInfo.ConstList[result])^ do
    begin
      ConstName := ModuleInfo.SetGlobalString(AConstName);
      MInfo := ModuleInfo;
    end;
  ModuleInfo.ConstNames.AddObject(AConstName, TObject(result));
end;

{-----------------------------------------------------------}

procedure TUnitParser.ProcessConst;
var
  PConst : PConstInfo;
begin
  PConst := PConstInfo(ModuleInfo.ConstList[AddNewConst(TokenString)]);

  with PConst^, ModuleInfo do
    ConstType := SetGlobalString('C ' + TokenString); //don't resource

  NextValidToken;

  if IsTokenChar(':') then
    ProcessTypedConst(PConst)
  else if IsTokenChar('=') then
    ProcessSimpleConst(PConst);
end;

{-----------------------------------------------------------}

procedure TUnitParser.LoadFromFile(const Afname, ADefines, AIgnoreDefines,
            Units, Aliases : string);
var
  uname, _FName : string; // Dm.
  intname       : string;
  FS            : TFileStream;
  mname         : string;
  filname       : string;
  shortname     : string;
  i             : integer;
  ConsiderEmpty : Boolean;

  function __IgnoreExistDPU(const FileName:String):boolean;
  begin
    If Assigned(DCOnIgnoreExistDPU) then
      Result:=DCOnIgnoreExistDPU(Self,FileName)
    else
      Result:=IgnoreExistDPU;
  end;

begin
  _FName := AFName; // Dm.

  fDefines := ADefines;
  {fIgnoreDefines:=AIgnoreDefines;}
  fUnits := Units;
  fAliases := Aliases;

  ParseString(fAliases, ';', fAliasesList);

  LoadUnitPaths(fUnits);

//?????????  Defines.Clear; // Dm.

  ParseString(TrimSeparators(fDefines,[';']), ';', Defines);
  IgnoreDefines.Clear;
  ParseString(AIgnoreDefines, ';', IgnoreDefines);
  ParseString(fAliases, ';', fAliasesList);
  ModuleInfo.ModuleFile := _FName;


//  writeln;
//  writeln('LoadFromFile');
//  writeln('Afname = ', Afname);
//  writeln('Units = ', units);

  Repeat // Dm.
    ConsiderEmpty := True; // Dm.
    filname := _FName;
    MName := '';
    shortname := ExtractFileName( _FName );
    i := 0;

    Repeat
      IntName := ChangeFileExt( FilName, '.int' ); //don't resource

      If FileExists( FilName ) Then
        MName := FilName
      Else
        If FileExists( IntName ) Then
          MName := IntName;

      If MName = '' Then
        With UnitPaths Do
          If I = Count Then
            break
          Else
            begin
              Filname := UnitPaths[I] + ShortName;
              Inc( I );
            end
      Else
        break;
    Until False;

    If MName = '' Then
      FS := Nil
    Else
      FS := TFileStream.Create( MName, DefaultOpenMode );

    try
      UName := ChangeFileExt( _FName, CompiledExt );
      If FS <> Nil Then
        FModuleDate := FileGetDate( FS.Handle )
      Else
        FModuleDate := -1;

      If ( Not __IgnoreExistDPU(MName) ) And LoadFromCompiled( UName ) Then
      begin
        if ikLoadedUnit in ParserInfoKinds then
          OutMessage(SDCLoadedUnit+MName);
        Exit;
      end;

      If FS = nil Then
      begin
        ConsiderEmpty := False; // Dm.
        DoFileConfirm( _FName, ConsiderEmpty ); // Dm.
        If ConsiderEmpty and (ikConsideredEmpty in ParserInfoKinds) then
          OutMessage(SDCConsideredEmpty+MName);
      end
      Else
        begin
          ModuleInfo.ModuleType := moProgram;
          ModuleInfo.ModuleFile := MName;
          if ikCompilingUnit in ParserInfoKinds then
            OutMessage(SDCCompilingUnit+MName);
          LoadFromSourceStream( FS );
          if ikCompiledUnit in ParserInfoKinds then
            OutMessage(SDCCompiledUnit+MName);
          GenerateParsedFile;
        end;
    finally
      FS.Free;
    end;
  Until ConsiderEmpty; // Dm.
end;

{-----------------------------------------------------------}

procedure TUnitParser.LoadFromSourceStream(S : TStream);
var
  pp : PChar;
begin
  GetMem(pp, S.Size + 1);
  with S do
    try
      Read(pp^, Size);
      (pp + Size)^ := #0;
      LinePos := 0;
      LinePtr := pp;
      ParseText;
    finally
      FreeMem(pp);
    end;
end;

{-----------------------------------------------------------}

function TUnitParser.LoadFromCompiled(const UnitName : string) : boolean;
var
  FS : TFileStream;
  uname : string;
begin
  result := false;
//  exit;
  uname := CompiledPath + ExtractFileName(UnitName);
  if not FileExists(uName) then
    exit;

  FS := TFileStream.Create(UName, DefaultOpenMode);
  try
    result := LoadFromStream(FS);
  finally
    FS.Free;
  end;
end;

{-----------------------------------------------------------}

function TUnitParser.LoadFromStream(S : TStream) : boolean;
begin
  result := ReadHeader(S);
  if result then
    begin
      LoadUsedUnits(S);
      LoadIncludes(S);
      ModuleInfo.LoadFromStream(S);
    end;
end;

{-----------------------------------------------------------}

procedure   TUnitParser.SaveToStream(S : TStream);
begin
  WriteHeader(S);
  WriteUsedUnits(S);
  WriteIncludes(S);
  ModuleInfo.SaveToStream(S);
end;

{-----------------------------------------------------------}

procedure TUnitParser.LoadIncludes(S : TStream);
begin
  ReadStringsFromStream(S, InclFiles);
end;

{-----------------------------------------------------------}

procedure TUnitParser.LoadUsedUnits(S : TStream);
var
  ulist : TStringList;
  i     : integer;
begin
  ulist := TStringList.Create;
  try
    ReadStringsFromStream(S, ulist);

    for i := 0 to ulist.Count - 1 do
      UseUnit(ulist[i]);
  finally
    ulist.Free;
  end;
end;

{-----------------------------------------------------------}

procedure   TUnitParser.WriteUsedUnits(S : TStream);
var
  w : TWriter;
begin
  w := TWriter.Create(S, 4096);
  try
    WriteStrings(w, ModuleInfo.UsedUnits);
  finally
    w.Free;
  end;
end;

{-----------------------------------------------------------}

procedure TUnitParser.WriteIncludes(S : TStream);
begin
  WriteStringsToStream(S, InclFiles);
end;

{-----------------------------------------------------------}

function TUnitParser.ReadHeader(S : TStream) : boolean;
var
  dd  : integer;
  Hdr : array[0 .. length(CompiledHeader) - 1] of char;
begin
  result := (S.Read(Hdr, sizeof(Hdr)) = sizeof(Hdr)) and CompareMem(@Hdr, @CompiledHeader[1], sizeof(Hdr));
  if result then
    begin
      S.Read(dd, sizeof(integer));
      result := (dd = fModuleDate) or (fModuleDate = -1);
    end;
end;

{-----------------------------------------------------------}

procedure TUnitParser.WriteHeader(S : TStream);
begin
  with S do
    begin
      Write(CompiledHeader, length(CompiledHeader));
      Write(fModuleDate, sizeof(integer));
    end;
end;

{----------------------------}

type
  TDebugStringList=class(TStringList)
  public
    function AddObject(const S: string; AObject: TObject): Integer; override;
  end;

{----------------------------}

function TDebugStringList.AddObject(const S: string; AObject: TObject): Integer;
begin
//  If S='TListControlItems' then
//    asm nop end;

  Result:=inherited AddObject(S,AObject);
end;

{----------------------------}

constructor TModuleInfo.Create;
begin
  inherited;
  GlobalStrings := TStringHolder.Create;
  GlobalParams  := TRecordList.Create(sizeof(TParamInfo));
  TypeList := CreateSortedStringListEx(TDebugStringList);
  ConstNames := CreateSortedStringList;

  ProcList  := CreateRecordList(sizeof(TMethodInfo));
  GlobalProcList := CreateRecordList(sizeof(TMethodInfo));
  ConstList := CreateRecordList(sizeof(TConstInfo));
  VarList   := CreateRecordList(sizeof(TVarInfo));
  PropList  := CreateRecordList(sizeof(TPropertyInfo));
  TypList   := CreateRecordList(sizeof(TTypeDeclInfo));

  InterfaceUses := TStringList.Create;
  ImplementUses := TStringList.Create;
  UsedUnits := TStringList.Create;
  fGStrings := CreateSortedStringList;
end;

{-----------------------------------------------------------}

destructor  TModuleInfo.Destroy;
var
  i : integer;
begin
  GlobalStrings.Free;
  GlobalParams.Free;
  TypeList.Free;
  PropList.Free;
  ProcList.Free;
  ConstList.Free;
  VarList.Free;
  TypList.Free;
  ConstNames.Free;

  InterfaceUses.Free;
  ImplementUses.Free;
  fGStrings.Free;
  with UsedUnits do
    begin
      for i := 0 to Count - 1 do
        TUnitParser(Objects[i]).Release;
      Free;
    end;
  inherited;
end;

{-----------------------------------------------------------}

procedure TModuleInfo.WriteSelf(w : TWriter);
begin
  with w do
    begin
      WriteInteger(ProcCount);
      WriteInteger(ProcIndex);
      WriteInteger(integer(ModuleType));
      WriteInteger(VarCount);
      WriteString(ModuleName);
      WriteString(ModuleFile);
    end;
end;

{-----------------------------------------------------------}

procedure TModuleInfo.ReadSelf(r : TReader);
begin
  with r do
    begin
      ProcCount := ReadInteger;
      ProcIndex := ReadInteger;
      ModuleType := TModuleType(ReadInteger);
      VarCount   := ReadInteger;
      ModuleName := ReadString;
      ModuleFile := ReadString;
    end;
end;

{-----------------------------------------------------------}

procedure TModuleInfo.SaveToStream(S : TStream);
var
  w : TWriter;
begin
  w := TWriter.Create(S, 4096);
  try
    WriteSelf(w);
    WriteStrings(w, InterfaceUses);
    WriteStrings(w, ImplementUses);
    WriteStrings(w, TypeList);
  finally
    w.Free;
  end;

  GlobalStrings.SaveToStream(S);
  GlobalParams.SaveToStream(S);
  TypList.SaveToStream(S);
  ProcList.SaveToStream(S);
  ConstList.SaveToStream(S);
  VarList.SaveToStream(S);
  PropList.SaveToStream(S);
  GlobalProcList.SaveToStream(S);
end;

{-----------------------------------------------------------}

procedure TModuleInfo.LoadFromStream(S : TStream);
var
  r : TReader;
  i : integer;
begin
  r := TReader.Create(S, 4096);
  try
    ReadSelf(r);
    ReadStrings(r, InterfaceUses);
    ReadStrings(r, ImplementUses);
    TypeList.Sorted := false;
    ReadStrings(r, TypeList);
    TypeList.Sorted := true;
  finally
    r.Free;
  end;

  GlobalStrings.LoadFromStream(S);
  GlobalParams.LoadFromStream(S);
  TypList.LoadFromStream(S);
  ProcList.LoadFromStream(S);
  ConstList.LoadFromStream(S);
  VarList.LoadFromStream(S);
  PropList.LoadFromStream(S);
  GlobalProcList.LoadFromStream(S);

  with TypList do
    for i := 0 to Count - 1 do
      PTypeDeclInfo(Items[i])^.mInfo := self;

  with ConstList do
    for i := 0 to Count - 1 do
      PConstInfo(Items[i])^.mInfo := self;
end;

{-----------------------------------------------------------}

function    TModuleInfo._GetConstDecl(const ConstName : string; ScanUnits : boolean) : PConstInfo;
var
  index : integer;
  i     : integer;
begin
  with ConstNames do
    if Find(ConstName, index) then
      result := ConstList[integer(Objects[index])]
    else
      result := nil;

  if ScanUnits then
    for i := UsedUnits.Count - 1 downto 0 do
      begin
        if result <> nil then
          break;

        result := TUnitParser(UsedUnits.Objects[i]).ModuleInfo._GetConstDecl(ConstName, false);
      end;
end;

{-----------------------------------------------------------}

function    TModuleInfo.GetConstDecl(const ConstName : string) : PConstInfo;
begin
  result := _GetConstDecl(ConstName, true);
end;

{-----------------------------------------------------------}

function TModuleInfo._getTypeDecl(const ATypeName : string; scanunits, scanall : boolean) : PTypeDeclInfo;

function InternalGetTypeDecl(const ATypeName : string;
  scanunits, scanall : boolean) : PTypeDeclInfo;
var
  index : integer;
  i     : integer;
  ppos  : integer;
begin
  result := nil;

  ppos := pos('.', ATypeName);

  if ppos > 0 then
    begin
      index := UsedUnits.IndexOf(copy(ATypeName, 1, ppos - 1));
      if index >= 0 then
        result := TUnitParser(UsedUnits.Objects[index]).ModuleInfo._getTypeDecl(copy(ATypeName, ppos + 1, length(ATypeName)), false, false);
      exit;
    end;

  with TypeList do
    if Find(ATypeName, index) then
      result := TypList[integer(TypeList.Objects[index])];

  if ScanUnits then
    for i := UsedUnits.Count - 1 downto 0 do
      begin
        if result <> nil then
          break;

        result := TUnitParser(UsedUnits.Objects[i]).ModuleInfo._GetTypeDecl(ATypeName, scanall, scanall);
      end;
end;

begin
  result:=InternalGetTypeDecl(ATypeName,Scanunits,Scanall);

  {here we can substitute types}                                   //  Added in V4.1
                                                                   //
  If (Result=nil) and (Length(ATypeName)>0) then                   //
  begin                                                            //
    If ATypeName[1] in ['I'] then                                  //
      Result:=InternalGetTypeDecl('IUnknown',Scanunits,Scanall)    //
    else                                                           //
    If ATypeName[1] in ['T'] then                                  //
      Result:=InternalGetTypeDecl('TObject',Scanunits,Scanall);    //
  end;
end;

{-----------------------------------------------------------}

function TModuleInfo.GetTypeDecl(const TypeName : string) : PTypeDeclInfo;
begin
  result := _gettypedecl(TypeName, true, false);
end;

{-----------------------------------------------------------}

function TModuleInfo.GetTypeDeclInAllUnits(const TypeName : string) : PTypeDeclInfo;
begin
  result := _gettypedecl(TypeName, true, true);
end;

{-----------------------------------------------------------}

function    TModuleInfo.GetUnitWherePropertyWasDeclared(const CName, APropName : string) : TModuleInfo;
var
  tdecl : PTypeDeclInfo;
  i     : integer;
begin
  tdecl := GetTypeDecl(CName);
  while tdecl <> nil do
    with tdecl^ do
      begin
        for i := 0 to PropCount - 1 do
          with minfo, PPropertyInfo(PropList[i + PropIndex])^ do
            if (pmDeclaredHere in Mode) and (CompareText(GetGlobalString(PropName), APropName) = 0) then
              begin
                result := minfo;
                exit;
              end;
        tdecl := MInfo.GetTypeDecl(MInfo.GetGlobalString(BaseName));
      end;
   result := nil;
end;

{-----------------------------------------------------------}

function TUnitParser.GetParsedFileName:String;
begin
  Result:=ModuleInfo.ModuleFile
end;

{-----------------------------------------------------------}

procedure TDCImplParser.ParseText;
begin
  inherited;

  If Assigned(DCOnIgnoreImplementation) then
    If not DCOnIgnoreImplementation(Self,ModuleInfo.ModuleFile) then
    begin
      if ikImplementIgnored in ParserInfoKinds then
        OutMessage(SDCImplementIgnored+ModuleInfo.ModuleFile);
      exit;
    end;

  while not ParserEOF do
    if IsTokenResWord(ID_USES) then
        ProcessUses(ModuleInfo.ImplementUses,False)
    else
      NextToken;

{
  while not ParserEOF do
    if IsTokenResWord(ID_USES) then
      begin
        ProcessUses(ModuleInfo.ImplementUses,False);
        exit;
      end
    else if Token = tokResWord then
      exit
    else
      NextToken;
}
end;

{------------------------------------------------------------------}
{
procedure GetUsedFilesList(PasFiles,UsedFiles:TStrings;
            const Defines,IgnoreDefines,InclFolders,DPUPath:String);
begin
  DCGetUsedFilesListEx( PasFiles, UsedFiles, Defines, IgnoreDefines, InclFolders, DPUPath,
    False, False, Nil ); // Dm.
end;
}
{------------------------------------------------------------------}

Procedure DCGetUsedFilesListEx( PasFiles, UsedFiles : TStrings;
  Const Defines, IgnoreDefines, InclFolders, DPUPath : String;
  AIgnoreExistDPU, ANoDefaultDefines : Boolean;
  AMsgHandler:TDCMsgHandler;ADestroyParser:boolean;UsedFilesPerUnit:TStrings);
var
  UOnlyFiles,UFiles,TempUsedFiles:TStringList;
  i:Integer;
begin
  TempUsedFiles:=CreateSortedStringList;
  UFiles:=CreateSortedStringList;
  UOnlyFiles:=CreateSortedStringList;
  try
    for i:=0 to PasFiles.Count-1 do
    begin
      UFiles.Clear;
      DCGetUsedFilesEx(PasFiles[i],Defines,IgnoreDefines,InclFolders,DPUPath,
        UFiles, AIgnoreExistDPU, ANoDefaultDefines,AMsgHandler,ADestroyParser);
      If UsedFilesPerUnit<>nil then
      begin
        UOnlyFiles.Assign(UFiles);
        DCChangeFilePathInStrings(UOnlyFiles,'');
        DCChangeFileExtInStrings(UOnlyFiles,'');
        UsedFilesPerUnit.Add(ExtractOnlyName(PasFiles[i])+'='+UOnlyFiles.CommaText);
      end;
      TempUsedFiles.AddStrings(UFiles);
    end;

    UsedFiles.Assign(TempUsedFiles);
  finally
    TempUsedFiles.Free;
    UFiles.Free;
    UOnlyFiles.Free;
  end;
end;

{------------------------------------------------------------------}

const
  ufIntfUses  = 0; //interface section uses
  ufImplUses  = 1; //implementation section uses
  ufIncludes  = 2; //include file
  ufResources = 3; //resource file
{
procedure GetUsedFiles(const PasFile,ADefines,AIgnoreDefines,
            InclFolders,DPUPath:String;
            UsedFiles:TStrings);
begin
  DCGetUsedFilesEx( PasFile, ADefines, AIgnoreDefines, InclFolders, DPUPath,
                    UsedFiles, False, False, Nil ); // Dm.
end;
}
{------------------------------------------------------------------}

Procedure DCGetUsedFilesEx(Const PasFile, ADefines, AIgnoreDefines, InclFolders, DPUPath : String;
  UsedFiles : TStrings; AIgnoreExistDPU, ANoDefaultDefines : Boolean;
  AMsgHandler:TDCMsgHandler;ADestroyParser:boolean);
var
  P : TDCImplParser;
  i : Integer;
  t : Integer;

  function GetFullName(const ShortName:String):String;
  var
    TempStr:String;
  begin
    Result:=ChangeFileExt(ShortName,'.pas'); //don't resource
    TempStr:=FileSearch(Result,ExtractFilePath(PasFile)+';'+InclFolders);
    If TempStr<>'' then
      Result:=TempStr;
  end;

begin
  P := TDCImplParser( DCLoadModule( PasFile, ADefines, AIgnoreDefines, InclFolders,
                                    '', DPUPath, TDCImplParser, AIgnoreExistDPU, ANoDefaultDefines, AMsgHandler ) ); // Dm.
  UsedFiles.Clear;
  With P do
  try
    for i:=0 to InclFiles.Count-1 do
    begin
      if InclFiles.Objects[i]=nil then
        t:=ufResources
      else
        t:=ufIncludes;
      UsedFiles.AddObject(InclFiles[i],Pointer(t));
    end;

    With ModuleInfo.InterfaceUses do
      for i:=0 to Count-1 do
        UsedFiles.AddObject(GetFullName(Strings[i]),Pointer(ufIntfUses));

    With ModuleInfo.ImplementUses do
      for i:=0 to Count-1 do
        UsedFiles.AddObject(GetFullName(Strings[i]),Pointer(ufImplUses));

    AnsiLowerCaseStrings(UsedFiles);
  finally
    If ADestroyParser then
      Free;
  end;
end;

{-----------------------------------------------------------}

Function FindNextToDestroy:TUnitParser;
Var
  I : Integer;
begin
  For I := 0 To Parsers.Count - 1 Do
    If TUnitParser( Parsers[ I ] ).fRefCount = 0 Then
    begin
      Result := Parsers[ I ];
      Exit;
    end;
  Result := Parsers[ 0 ];
end;

{-----------------------------------------------------------}

procedure DCEnumParsersToDestroy(List:TList;ParserIsOk:TDCCheckParserProc;UserData:Pointer);
Var
  I : Integer;
begin
  List.Clear;
  For I:=0 To Parsers.Count-1 Do
    If (TUnitParser(Parsers[I]).fRefCount=0) and (ParserIsOk(TUnitParser(Parsers[i]),UserData)) Then
    begin
      List.Add(Parsers[I]);
      Exit;
    end;
end;

{-----------------------------------------------------------}

Procedure DCRemoveCreatedParsers;
begin
  While Parsers.Count > 0 Do
    FindNextToDestroy.Free;
end;

{-----------------------------------------------------------}
{$IFDEF WIN32}
Procedure DCGenVCLDPUsForVer( Const DestPath : String; DelphiVer : TDelphiVer;
                               AIgnoreExistDPU, ANoDefaultDefines : Boolean;
                               AMsgHandler : TDCMsgHandler );
Var
  I                       : Integer;
  SourceDirs, SourceFiles : TStrings;
  ResultFolder            : String;

{----------------------------------------------}
  Procedure ParseUnits;
  Var
    J : Integer;
  begin
    For J := 0 To SourceFiles.Count - 1 Do
      DCLoadModule( SourceFiles[ J ], '', '', GetDelphiSourceDirsEx( DelphiVer ), '',
                    ResultFolder, TUnitParser, AIgnoreExistDPU, ANoDefaultDefines, AMsgHandler );
  end;
{----------------------------------------------}

begin
  ResultFolder := AddSlash( DestPath ) + 'DPU_' + cDelphiVers[ DelphiVer ];
  CreateAllDirectories( ResultFolder, Nil );

  SourceDirs := CreateSortedStringList;
  try
    SourceFiles := CreateSortedStringList;
    ParseString( GetDelphiSourceDirsEx( DelphiVer ), ';', SourceDirs );
    For I := 0 To SourceDirs.Count - 1 Do
    begin
      FindFilesEx( SourceDirs[I], '*.pas', faAnyFile, False, SourceFiles );
      ParseUnits;
      FindFilesEx( SourceDirs[I], '*.int', faAnyFile, False, SourceFiles );
      ParseUnits;
    end;
  finally
    FreeObject( SourceFiles ,SourceFiles );
    FreeObject( SourceDirs ,SourceDirs );
    DCRemoveCreatedParsers;
  end;
end;

{------------------------------------------------------------------}

Procedure DCGenVCLDPUs( Const DestPath : String );
begin
  DCGenVCLDPUsEx( DestPath, False, False, Nil );
end;

{------------------------------------------------------------------}

Procedure DCGenVCLDPUsEx( Const DestPath : String; AIgnoreExistDPU, ANoDefaultDefines : Boolean;
                           AMsgHandler : TDCMsgHandler );
Var
  I : TDelphiVer;
begin
  For I := Low( TDelphiVer ) To High( TDelphiVer ) Do
    DCGenVCLDPUsForVer( DestPath, I, AIgnoreExistDPU, ANoDefaultDefines, AMsgHandler );
end;

{------------------------------------------------------------------}
{$ENDIF}
initialization
  Parsers := TList.Create;
finalization
  DCRemoveCreatedParsers;
  Parsers.Free;
end.
