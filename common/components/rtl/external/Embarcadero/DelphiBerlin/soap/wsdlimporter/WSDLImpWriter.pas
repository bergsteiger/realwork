{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{           WSDL Importer and Writer classes            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit WSDLImpWriter;

{$IFNDEF VER150}
{$INCLUDE 'CompVer.inc'}
{$ENDIF}

{ Generates an .XML file with information about XML Schema }
{$DEFINE SHOW_XML_INFO}

{$DEFINE PRECONDITION_ON}
{ Console logs }
//{$DEFINE LOG_TYPES_READING}
//{$DEFINE LOG_TYPES_WRITING}
//{$DEFINE LOG_TYPES_UNWIND}
//{$DEFINE LOG_TYPES_SORTING}
//{$DEFINE LOG_TYPES_LOOKUP}
//{$DEFINE LOG_TYPES_DUMP}

{$DEFINE CACHE_TYPES}

{$DEFINE COLLAPSE_ANONYMOUS_COMPLEXTYPES}


{ Sanity Checks }
{$DEFINE CHECK_CIRCULAR_BASETYPE}
{$DEFINE VALIDATE_BASETYPE}
{$DEFINE VALIDATE_MODEL}

{ Map unbounded elements to array types }
{$DEFINE MAP_UNBOUNDED_TO_ARRAY}

{ Define this to ensure that memory tracking is working:) }
//{$DEFINE SIMULATE_LEAK}

interface

uses
  Classes, TypInfo, xmldom, XmlSchema, WSDLIntf, WSDLBind, InvokeRegistry, WSDLItems,
  UDDIHlprDesign, Contnrs, WSDLModelIntf;

const
  SMultiPart = 'multipartRelated';
  SSoapAttachment = 'TSOAPAttachment';

  SBase64Binary = 'base64Binary';
  Commas: array[Boolean] of string = ('', ', ');
  SemiStr: array[Boolean] of string = ('', '; ');
{$IFDEF LINUX}
{ Linux linebreaks don't show up correcly in code previewer }
  SLineBreak = #13#10;
{$ENDIF}

type

  TWSDLTypeKind = set of WSDLTypeKind;

  { Flags to the writer what to write out }
  PassWriterType = (ptForwardDecl,
                    ptTypeDecl,
                    ptTypeImpl,
                    ptTypeFactoryDecl,
                    ptTypeFactoryImpl,
                    ptMethImpl);
  TPassWriterType = set of PassWriterType;

  { Implements Items Processed }
  TProcessedTracker = class(TInterfacedObject, IProcessedTracker)
    FProcessedList: TDOMStrings;
  public
    constructor Create;
    destructor  Destroy; override;
    function    ProcessedAlready(const Name: DOMString): Boolean;
    procedure   AddProcessed(const Name: DOMSTring);
    procedure   Clear;
    function    GetCount: Integer;
    function    GetItem(Index: Integer): DOMString;
  end;

  ImporterFlags = (ifWriterHasWeakAliases,  // C++
                   ifWriterHasOutParams,    // Delphi
                   ifImportXMLSchema);
  TImporterFlags = set of ImporterFlags;

  { Generic Importer of information from WSDL documents }
  TWSDLImporter = class(TWSDLItems, IWSDLImporter, IWSDLImporterOptions)
  protected
    FMIMEParts: IMIMEPartArray;
    FDefName:   DOMString;
    FFileName:  DOMString;
    FOutFile:   DOMString;
    FOnWrite:   TWriteProc;
    FWSDLTypes: IWSDLTypes;
    FWSDLPortTypes: IWSDLPortTypes;
    FImportList: IProcessedTracker;
    FSchemaImportList: IProcessedTracker;
    FWarningList: TStringList;
    FWSDLImporterOpts: TWSDLImporterOpts;
    FWSDLImportInfo: PWSDLImportInfo;
    FImporterFlags: TImporterFlags;

    { Mime Part Access }
    function    FindMimePart(const PartName, AOperation, AMessage: DOMString;
                             ArgType: ArgumentType): IMIMEPart;
    procedure   GetMIMEParts(const BindingName: DOMString);
    procedure   ClearMIMEParts;

    { Method to load porttypes from WSDL document }
    procedure   ImportInterfaces(const WSDLItems: TWSDLItems;
                                 const WSDLPortTypes: IWSDLPortTypes);
    procedure   ImportTypes(const WSDLItems: TWSDLItems;
                            const Name: DOMString;
                            const WSDLTypes: IWSDLTypes;
                            const Reset: Boolean); overload;
    procedure   ImportTypes(const Schema: IXMLSchemaDef;
                            const Name: DOMString;
                            const WSDLTypes: IWSDLTypes); overload;
    procedure   AddWarning(const warning: string); overload;
    procedure   AddWarning(const Fmt: string; const Args: array of const); overload;

  public
    constructor Create(AOwner: TComponent; Flag: TImporterFlags);

    destructor  Destroy; override;

    procedure   Import(const FileName: DOMString; const Stream: TStream);
    procedure   ImportsCallback(const Options: IterateImportOptions;
                                const WSDLItems: IWSDLItems;
                                const XMLSchemaDoc: IXMLSchemaDoc;
                                const Name: DOMString);
    procedure   WriteFeedback(const Fmt: string; const Args: array of const);
    procedure   MarkTypes;
    procedure   SortTypes;
    procedure   MungeTypes;
    procedure   DumpTypes;
    procedure   ValidateModel;
    function  CreateSerializer(const BaseType: IWSDLType;
                               const NewTypeName: DOMString;
                               const NewTypeNamespace: DOMString;
                               const MemberName: DOMString;
                               const SerialOpts: TSerializationOptions;
                               UpdateReferences: Boolean): IWSDLType;

    { IWSDLImporter }
    function    GetWSDLItems: TWSDLItems;
    function    GetTypes: IWSDLTypeArray;
    function    GetPortTypes: IWSDLPortTypeArray;

    function    GetWSDLTypes: IWSDLTypes;
    function    GetWSDLPortTypes: IWSDLPortTypes;

    procedure   SelectItem(const WSDLItem: IWSDLItem);
    function    FindType(const Name: DOMString;
                         const Namespace: DOMString;
                         const HasThese: TXMLItemInfo = [];
                         const DoesNotHaveThese: TXMLItemInfo = [];
                         Create: Boolean = True): IWSDLType;
    function    SkipType(const WSDLType: IWSDLType; SkipAll: Boolean = False): Boolean;
    function    GetOnWrite: TWriteProc;
    procedure   SetOnWrite(const WriteProc: TWriteProc);
    function    GetOutFile: DOMString;
    procedure   SetOutFile(const OFile: DOMString);

    function    GetDefName: DOMString;
    procedure   SetDefName(const Name: DOMString);
    function    GetImportList: IProcessedTracker;
    function    GetWarningList: TStringList;

    function    GetOptions: TWSDLImporterOpts;
    procedure   SetOptions(const Opts: TWSDLImporterOpts);

    procedure   Cleanup;

    function  GetWSDLImportInfo: PWSDLImportInfo;
    procedure SetWSDLImportInfo(const WSDLImportInfo: PWSDLImportInfo);

  end;

  { Flags to configure writer }
  WSDLGenFlags = (wfDebug,
                  wfVerbose,
                  wfSkipHttpBindings,             { Skip http bound bindings }
                  wfOneOutIsReturn,               { Convert single out to retval }
                  wfServer,                       { Generate server implementation code }
                  wfUseXMLBindingManager,         { SEPRECATED: From pre-schema parsing days }
                  wfAmbiguousComplexTypesAsArray, { DEPRECATED: From pre-schema parsing days }
                  wfUnwindLiteralParameters,      { This option is only safe if all operations use literal messages }
                  wfOutputLiteralTypes,           { Output the structure that represent literal types }
                  wfMapStringsToWideStrings,      { Map "xsd:string" to a WideString }
                  wfIgnoreSchemaErrors,           { Be lenient on some (??) errors }
                  wfAutoInitMembers,                                                      
                  wfAutoDestroyMembers,           { Cleanup Objects and Array of Objects }
                  wfQuietMode,
                  wfSelectiveCodeGen,             { UI-internal only }
                  wfGenerateWarnings,             { Generate Warnings }
                  wfMapArraysToClasses,           { Map pure collections to class types instead of arrays }
                  wfTypesInNamespace,             { Declare types in namespace }
                  wfSkipUnusedTypes,              { Don't emit unused types }
                  wfUseSerializerClassForAttrs,
                  wfValidateEnumMembers,          { Validate Enum members }
                  wfProcessFaults,                { Process faults }
                  wfProcessHeaders,               { Process Headers }
                  wfGenTrueGUIDs,                 { Unique GUIDs for each import }
                  wfProcessRefSchemas,            { Process Ref. schemas }
                  wfStrongClassAliases,           { Make class aliases derived classes }
                  wfAllowOutParameters,           { Allow multiple Out parameters }
                  wfUseSettersAndGetters,         { Use setters and getters for properties }
                  wfProcessOptionalNillable,      { Generate code that processess nillable/optional elements }
                  wfUseXSTypeForSimpleNillable,   { Use TXSxxx for simple nillable types }
                  wfUseScopedEnumeration,         { Use scope enumeration }
                  wfForceSOAP11,                  { Force SOAP 1.1 }
                  wfForceSOAP12,                  { Force SOAP 1.2 }
                  wfCreateArrayElemTypeAlias,     { Create Array element type alias }
                  wfLastOption                    { Marker }
                  );
  TWSDLGenFlags = set of WSDLGenFlags;

  { TWSDLWriter }
  TWSDLWriter = class(TMemoryStream)
  protected
    FOnWrite: TWriteProc;
    FTempFile: THandleStream; { File stream as virtual memory }
    FTempFileName: string;
    FFileName: string;
    FOutFile: string;
    FWSDLImporter: IWSDLImporter;
    FDirectory: string;
    FRelHeaderDir: string;
    FWritingEnums: Boolean;

    procedure WriteStr(const Str: string);
    procedure WriteLn(const Str: string); overload;
    procedure WriteLn(const Fmt: string; const Args: array of const); overload;
    procedure WriteFmt(const Fmt: string; const Args: array of const);
    procedure WriteFeedback(const Fmt: string; const Args: array of const);
    function  DataToString: String;
    function  DataToUTF8String: UTF8String;

    procedure WriteWSDLInfo;
    procedure WriteComplexClassInfo(const WSDLType: IWSDLType);
    procedure WriteInterfaceInfo(const WSDLPortType: IWSDLPortType);
    procedure WritePredefinedInfo;
    function  TypeCount(const TypeKinds: TWSDLTypeKind): Integer;
    function  GetTypeInfo(const WSDLType: IWSDLType): DOMString; virtual;

    function  GetBaseClassName(const WSDLType: IWSDLType): string; virtual;

    function  IsComplex(const WSDLType: IWSDLType): boolean;
    function  IsComplexArray(const WSDLType: IWSDLType): boolean;
    function  SkipType(const WSDLType: IWSDLType; SkipAll: Boolean = False): Boolean;

    function WriteOutSerialOpts(const WSDLType: IWSDLType): Boolean;
    function HasIndexDecl(const Member: IWSDLPart; FlagOut: Boolean = False): Boolean; overload;
    function HasIndexDecl(const Member: IWSDLPart;
                          out Flags: TPartFlag;
                          out IsAttr: Boolean;
                          FlagOut: Boolean = False): Boolean; overload;
    function EmitIndexMacros(out Opts: TWSDLImporterOpts;
                             FlagOut: Boolean = False): Boolean;
    function GenSpecifiedSupport(const Member: IWSDLPart): Boolean;
    function GenIndexedSpecifiedSupport(const Member: IWSDLPart): Boolean;
    function HasInfoAboutMethod(const WSDLOperation: IWSDLOperation): Boolean;
    function GetMethodInfo(const WSDLOperation: IWSDLOperation): string;

    procedure Init(const WSDLImporter: IWSDLImporter; OutFileName : string); virtual;

    { Routines that *MUST* be provided by individual writers }
    procedure MapTypes(const WSDLTypeArray: IWSDLTypeArray); virtual;
    procedure ValidateTypes(const WSDLTypeArray: IWSDLTypeArray); virtual;
    function  IsReservedWord(const Name: DOMString; var NewName: DOMString): boolean; virtual; abstract;
    procedure ValidatePortTypes(const WSDLPortTypeArray: IWSDLPortTypeArray); virtual;
    procedure ValidateName(const WSDLItem: IWSDLItem;
                           Symbols: TDOMStrings = nil;
                           Index: Integer = -1;
                           Types: TDOMStrings = nil);
    procedure ValidatePart(const WSDLPart: IWSDLPart); virtual;
    procedure WriteInterfaceBegin(const WSDLPortType: IWSDLPortType; PassType: TPassWriterType); virtual; abstract;
    procedure WriteInterfaceEnd(const WSDLPortType: IWSDLPortType; PassType: TPassWriterType); virtual; abstract;
    procedure WriteMethod(const WSDLOperation: IWSDLOperation;
                          const Parent: IWSDLPortType;
                          PassType: TPassWriterType); virtual; abstract;
    procedure WriteEnum(const WSDLType: IWSDLType); virtual; abstract;
    procedure WriteAliasDef(const WSDLType: IWSDLType); virtual; abstract;
    procedure WriteArray(const WSDLType: IWSDLType); virtual; abstract;
    procedure WriteComplexTypeClass(const WSDLType: IWSDLType; PassType: TPassWriterType); virtual; abstract;
    procedure WriteRegCalls; virtual; abstract;
    function  Escape(const S: DOMString): DOMString; virtual; abstract;


    { Routines likely to be overridden by individual writers }
    procedure WriteIntfHeader; virtual;
    procedure WriteIntfFooter; virtual;
    function  ReplaceSpecialChar(const Name: DOMString): DOMString; virtual;
    function  GetDataType(const WSDLType: IWSDLType): DOMString; virtual;
    function  TypeNameFromTypeInfo(TypeInfo: pTypeInfo): DOMString; virtual;
    function  GetTypeInfoPad: DOMString; virtual;
    function  GetDebugMode: boolean;
    function  GetVerboseMode: boolean;
    function  IsCaseSensitive: Boolean; virtual;
    function  RemapMembersOfTypeName: boolean; virtual;

    { Routines that *COULD* be overridden by individual writers }
    procedure WriteEnumPrologue; virtual;
    procedure WriteEnumEpilogue; virtual;
  public
    constructor Create(const WSDLImporter: IWSDLImporter); virtual;
    constructor CreateFilename(const WSDLImporter: IWSDLImporter; OutFileName : string); virtual;


    destructor Destroy; override;

    procedure WriteToFile(FileName: String);
    procedure SetSize(NewSize: Longint); override;
    function  Write(const Buffer; Count: Integer): Longint; override;

    function  IntfExt: DOMString; virtual;
    function  HasSource: Boolean; virtual;
    function  SourceExt: DOMString; virtual; abstract;
    procedure WriteIntf; virtual;
    procedure WriteSource; virtual;
    function  WriteSettingsFile: Boolean; virtual; abstract;

    procedure SetDirectory(const Directory: string);
    procedure SetRelHeaderDir(const RelDir: string);

    { Routines that *COULD* be overridden by individual writers }
    procedure WriteForwards; virtual;
    procedure WriteInterfaces; virtual;
    procedure WriteImplHeader; virtual;
    procedure WriteImplementations; virtual;
    function  WriteTypes: integer; overload; virtual;
    procedure WriteInterface(const WSDLPortType: IWSDLPortType; PassType: TPassWriterType); virtual;
    function  WriteTypes(PassType: TPassWriterType; const TypeKinds: TWSDLTypeKind; const ExcludeKinds: TWSDLTypeKind = []): Integer; overload; virtual;
    procedure WriteTypeDecl(const WSDLType: IWSDLType; PassType: TPassWriterType); virtual;
    procedure WriteDebug; virtual;
    procedure SetOutFile(const outFile: string; CheckProject: Boolean); virtual;

    property FileName: string read FFileName write FFileName;
    property OutFile: string read FOutFile;
    property DataString: string read DataToString;
    property AsUTF8String: UTF8String read DataToUTF8String;
    property OnWrite: TWriteProc read FOnWrite write FOnWrite;
    property TypeInfoPad: DOMString read GetTypeInfoPad;
    property DebugMode: boolean read GetDebugMode;
    property Verbose: boolean read GetVerboseMode;
    property WritingEnums: boolean read FWritingEnums write FWritingEnums;
  end;

  TWSDLWriterClass = class of TWSDLWriter;

{ following three classes are used to
  keep track of Headers registered for specific methods }

  TMethodItem = class(TObject)
    private
      FMethodName: DOMString;
      FMethType: eHeaderMethodType;
      FRequired: Boolean;
    public
      constructor Create(const MethName: DOMString; MethType: eHeaderMethodType;
                  Required: Boolean); reintroduce;
  end;

  TMethodList = class(TObjectList)
    public
      procedure AddItem(const MethName: DOMString; MethType: eHeaderMethodType;
                Required: Boolean);
      function Find(const MethName: DOMString): Integer;
  end;

  THeaderItem = class(TObject)
    private
      FNameSpace: DOMString;
      FTypeName: DOMString;
      FMethodList: TMethodList;
    public
      constructor Create(const TypeName, MethName, Namespace: DOMString;
                  MethType: eHeaderMethodType; Required: Boolean); reintroduce;
  end;

  TRegTrackType = (rtHeader, rtFault);

  TRegTracker = class(TObjectList)
    private
      FIntfName: DOMString;
      FRegHeader: string;
      FRegHeaderMethod: string;
      FRegType: TRegTrackType;
    public
      constructor Create(const IntfName: DOMString; const ARegHeader,
                         ARegHeaderMethod: string; RegType: TRegTrackType); reintroduce;
      function  Find(const TypeName: DOMString): Integer;
      procedure AddItem(const TypeName, MethName, Namespace: DOMString;
                        MethType: eHeaderMethodType; Required: Boolean);
      procedure WriteRegistration(const IntfName: DOMString; Operations: IWSDLOperationArray; Writer: TWSDLWriter);
      property  RegHeader: string read FRegHeader;
      property  RegHeaderMethod: string read FRegHeaderMethod;
  end;

  { What type of factory routine we can write ?? }
  FactProcType = (ftNone,       { don't write factory       }
                  ftWSDLURL,    { write a full blown factory }
                  ftURL,        { write a factory with a known URL }
                  ftNoURL);     { Write a factory with no known URL }

  { Options use by SetToStr routine }
  SetToStrOpt = (stsBrackets,
                 stsComma,
                 stsInsertion,
                 stsUnused);
  SetToStrOpts = set of SetToStrOpt;

  InfoAttribute = (iaExternalName,
                   iaMethReturnName,
                   iaMethRequestNamespace,
                   iaMethResponseNamespace,
                   iaMethSOAPAction,
                   iaNamespace,
                   iaArrayItemName,
                   iaArrayItemNamespace,
                   iaIgnoreItem);

  TRegInfoAttribute = record
    Attrs: TArray<InfoAttribute>;
    Values: TArray<string>;
    procedure Reset;
    procedure SetAttr(Attr: InfoAttribute; const Value: string);
    function  HasAttr: Boolean;
    function  Load(const AttrStr: string): Integer;
    function  AsString(UseSingleQuote: Boolean): string;
  end;

const
  InfoAttributeStr: array[InfoAttribute] of string =
                      ('ExtName',
                       'ReturnName',
                       'RequestNS',
                       'ResponseNS',
                       'SOAPAction',
                       'Namespace',
                       'ArrayItemName',
                       'ArrayItemNS',
                       'Ignore'
                      );
  INFOATTR_BEG_CHAR: Char = '[';
  INFOATTR_END_CHAR: Char = ']';


function  GetOutFileName(const FileName: string): string;
function  GetValidIdent(const Ident: string): string;
function  SubstituteStrings(const InputString: DOMString; const SubString: DOMString;
                            const Replacement: DOMString): DOMString;
function  UnwindType(const WSDLType: IWSDLType; ClsOnly: Boolean = False): IWSDLType;
function  ImportWSDL(const WSDLFileName: DOMString;
                     const Stream: TStream;
                     WriteProc: TWriteProc;
                     Flag: TImporterFlags;
                     const OutFileName: DOMString = '';
                     const Proxy: DOMString = '';
                     const UserName: DOMString = '';
                     const Password: DOMString = '';
                     ATimeOut: Integer = 0;
                     const WSDLImportInfo: PWSDLImportInfo = nil): IWSDLImporter;

function  SetToStr(TypeInfo: PTypeInfo; Value: Integer; Brackets: Boolean): string; overload;
function  SetToStr(TypeInfo: PTypeInfo; Value: Integer; Opts: SetToStrOpts): string; overload;

function  IsPortTypeDerivedFromIAppServerSOAP(const PType: IPortType): Boolean;
function  WriteFactory(const WSDLPortType: IWSDLPortType): FactProcType;
procedure AddHeadersForOperation(Operation: IWSDLOperation; HeaderTracker: TRegTracker);
procedure AddFaultsForOperation(Operation: IWSDLOperation; FaultTracker: TRegTracker);
function  IsReservedNameInSymFile(const AName: DOMString; IsCplusplusNotDelphi: Boolean; var NewName: DOMString): Boolean;
function  GetSortedWSDLGenFlags: TArray<WSDLGenFlags>;


const
  RevString = '- $Rev: 86412 $';  { Do not localize }
  { Default Settings }
  Default_WSDLGenFlags : TWSDLGenFlags = [
                           wfSkipHttpBindings,
                           wfVerbose,
                           wfOneOutIsReturn,
                           wfAutoDestroyMembers,
                           wfUnwindLiteralParameters,
                           wfTypesInNamespace,
                           wfSkipUnusedTypes,
                           wfGenerateWarnings,
{$IFNDEF UNICODE}
                           wfMapStringsToWideStrings,
{$ENDIF}
                           wfUseSerializerClassForAttrs,
                           wfValidateEnumMembers,
                           wfProcessHeaders,
                           wfProcessFaults,
                           wfProcessRefSchemas,
                           wfStrongClassAliases,
                           wfProcessOptionalNillable,
                           wfUseScopedEnumeration
                           ];
var
  Global_WSDLGenFlags: TWSDLGenFlags;
  Global_WSDLGenFlags_Specified: array[WSDLGenFlags] of boolean;
  DefaultReturnParamNames: string;    // Default name of parameters we treat at return
  ExcludedFromRenameList: TStrings;   // Symbols that should not be renamed
  NoDateStamp: Boolean;               // Don't emit dates so it's easier to compare changes
  DumpSettings: Boolean;              // Write import settings to file
  XMLSchemaFile: Boolean;             // Importing an XML Schema file

implementation

uses
  Windows, ActiveX, WSDLImpConst, SOAPConst, MessageDigest_5, SysUtils, Variants,
  Generics.Defaults, Generics.Collections,
  IntfInfo, XMLIntf, XMLSchemaTags, Types, HTTPUtil, IniFiles, XMLSchemaHelper,
  Xml.Win.msxmldom;

const
  DateString= '$Date: 2016-03-02 03:08:50 -0800 (Wed, 02 Mar 2016) $'; { Do not localize }
  NoYes: array[Boolean] of string = ('No', 'Yes');    { do not localize }
  sMethodNotImplemented = 'Method not implemented';   { do not localize }

{ Moved to SOAPConst.pas for Highlander }
{$IFNDEF HIGHLANDER_UP}
  SOptional = 'optional';                                  { do not localize }
  SSoapNillable = 'nillable';                              { do not localize }
  SElemForm = 'form';                                      { do not localize }
  SUnqualified = 'unqualified';                            { do not localize }
{$ENDIF}
  SUnknownValue = '????';

type

  { TBaseImporter }
  TWSDLBaseImporter = class(TInterfacedObject)
  protected
    FOnWrite: TWriteProc;
    FWarningList: TStringList;

    procedure WriteFeedback(const Fmt: string; const Args: array of const);
    procedure AddWarning(const Fmt: string; const Args: array of const);

    property  OnWrite: TWriteProc read FOnWrite write FOnWrite;
    property  WarningList: TStringList read FWarningList write FWarningList;
  end;

  { TWSDLTypesImporter }
  { Imports Types described in WSDL documents }
  TWSDLTypeImporter = class(TWSDLBaseImporter, ISchemaTypeImporter, IXMLSchemaVisitor)
  private
    FWSDLTypes: IWSDLTypes;
    FWSDLOptions: IWSDLImporterOptions;
    function  FindType(const Name: DOMString; const Namespace: DOMString;
                       HasThese: TXMLItemInfo = [];
                       DoesNotHaveThese: TXMLItemInfo = [];
                       Create: Boolean = True): IWSDLType;
    function  AddType(const Name: DOMString; const Namespace: DOMString; XMLItemInfo: TXMLItemInfo): IWSDLType;
    function  AddSimpleType(const TypeDef: IXMLSimpleTypeDef; const Context: IWSDLType): IWSDLType;
    function  AddComplexType(const TypeDef: IXMLComplexTypeDef; const Context: IWSDLType): IWSDLType;
    function  AddAttributeGroup(const TypeDef: IXMLAttributeGroup; const Context: IWSDLType): IWSDLType;
    function  AddElementGroup(const TypeDef: IXMLElementGroup; const Context: IWSDLType): IWSDLType;
    function  AddElement(const TypeDef: IXMLElementDef;
                         const ElementTypes: TElementTypes;
                         const CompositorId: Integer;
                         const Context: IWSDLType): IWSDLType;
    function  AddAttribute(const TypeDef: IXMLAttributeDef; const Context: IWSDLType): IWSDLType;
    procedure UpdateWoHasOptions(Opt: WSDLImporterOpts);

{$IFDEF LOG_TYPES_READING}
    procedure LogTypeReading(Item: IXMLSchemaItem);
{$ENDIF}

  public
    constructor Create; virtual;
    destructor  Destroy; override;
    { Methods to load types from WSDL documents }
    procedure GetTypes(const WSDLItems: TWSDLItems;
                       const WSDLTypes: IWSDLTypes;
                       const Name: DOMString;
                       const Tracker: IProcessedTracker;
                       const Reset: Boolean); overload;
    procedure GetTypes(const Schema: IXMLSchemaDef;
                       const WSDLTypes: IWSDLTypes;
                       const Name: DOMString;
                       const Tracker: IProcessedTracker); overload;

    { IXMLSchemaVisitor }
    function Start(const SchemaDef: IXMLSchemaDef; const SchemaLoc: String): XMLVisitorContext;
    function Visit(const Item: IXMLAttributeDef; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLElementDef; const ElementTypes: TElementTypes;
                   const CompositorId: Integer; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLSimpleTypeDef; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLComplexTypeDef; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLAttributeGroup; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLElementGroup; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function VisitAny(const Item: IXMLNode; const Context: XMLVisitorContext): XMLVisitorContext;
    procedure Skipping(const SchemaLoc: String);
    procedure Done(const SchemaLoc: String);
    procedure Error(const SchemaLoc: String; const Msg: string);

    function  GetOptions: TWSDLImporterOpts;
    procedure SetOptions(Opts: TWSDLImporterOpts);

    property  Options: TWSDLImporterOpts read GetOptions write SetOptions;
  end;

  { TWSDLInterfaceImporter }
  { Imports Interfaces described in WSDL documents }
  TWSDLInterfaceImporter = class(TWSDLBaseImporter)
    procedure GetInterfaces(const WSDLImporter: IWSDLImporter;
                            const WSDLItems: TWSDLItems;
                            const WSDLPortTypes: IWSDLPortTypes);
    procedure UpdatePortTypeInfo(WSDLPortType: IWSDLPortType; InvOpts: TIntfInvokeOptions; const SOAPVersion: TSOAPVersion);
  end;

  { Implements IWSDLItemNS }
  TWSDLItem = class(TInterfacedObject, IWSDLItem, IWSDLItemNS)
  private
    FName:          DOMString;
    FLangName:      DOMString;
    FNamespace:     DOMString;
    FDocumentation: DOMString;
    FGenerate:      Boolean;
    FNotes:         ArrayOfString;
  public
    function  GetName: DOMString;
    function  GetLangName: DOMString;
    function  GetNamespace: DOMString;
    function  GetDocumentation: DOMString;

    procedure SetNamespace(const nspace: DOMString);
    procedure SetName(const name: DOMString);
    procedure SetLangName(const lname: DOMString);
    function  GetWSDLItemType: WSDLItemType; virtual;
    procedure Rename(const NewName: DOMString);

    function  GetSelected: Boolean;
    procedure SetSelected(const Sel: Boolean); virtual;
    procedure SetDocumentation(const doc: DOMString);
    procedure AddNote(const Note: string);
    function  GetNotes: ArrayOfString;
  end;

  { Implements IWSDLPart }
  TWSDLPart = class(TWSDLItem, IWSDLPart)
  private
    FPartKind: PartType;
    FDataType: IWSDLType;
    FPartFlags: TPartFlag;
    FDefaultValue: DOMString;
    FRegInfo: DOMString;
  public
    constructor Create; virtual;
    destructor  Destroy; override;
    function    GetPartKind: PartType;
    procedure   SetPartKind(const pt: PartType);
    function    GetDataType: IWSDLType;
    procedure   SetDataType(const DataType: IWSDLType);
    function    GetWSDLItemType: WSDLItemType; override;
    procedure   SetPartFlags(const Value: TPartFlag);
    function    GetPartFlags: TPartFlag;
    procedure   SetRequired(Flag: Boolean);
    function    GetRequired: Boolean;
    function    Clone: IWSDLPart;
    function    GetDefaultValue: DOMString;
    function    GetRegInfo: DOMString;
    procedure   SetRegInfo(const ARegInfo: DOMString);
  end;

  { Implements IMIMEPart }
  TMIMEPart = class(TInterfacedObject, IMIMEPart)
  private
    FMIMEType: DOMString;
    FMessageName: DOMString;
    FName: DOMString;
    FArgumentType: ArgumentType;
    FOperationName: DOMString;
  public
    function  GetName: DOMString;
    procedure SetName(const AName: DOMString);
    function  GetMessageName: DOMString;
    procedure SetMessageName(const Name: DOMString);
    function  GetMIMEType: DOMString;
    procedure SetMIMEType(const Name: DOMString);
    function  GetArgType: ArgumentType;
    procedure SetArgType(const AArgType: ArgumentType);
    function  GetOperationName: DOMString;
    procedure SetOperationName(const Name: DOMString);
  end;

  { Implements IWSDLOperation }
  TWSDLOperation = class(TWSDLItem, IWSDLOperation)
  private
    FIsOverLoaded: Boolean;
    FPartArray: IWSDLPartArray;
    FHeaderArray: IWSDLPartArray;
    FFaultArray: IWSDLPartArray;
    FStyle: DOMString;
    FInputUse: DOMString;
    FInputNamespace: DOMString;
    FOutputUse: DOMString;
    FOutputNamespace: DOMString;
    FSOAPAction: DOMString;
    FCannotUnwrap: TCannotUnwrap;
    FInputWrapper: IWSDLPart;
    FOutputWrapper: IWSDLPart;

    procedure AddPartInfo(const WSDLImporter: IWSDLImporter;
                          const WSDLItems: TWSDLItems;
                          const Part: IPart; ArgType: ArgumentType;
                          IsFault: Boolean = False;
                          const AMessage: DOMString = '');
    function  AddParts(const WSDLImporter: IWSDLImporter;
                       const WSDLItems: TWSDLItems;
                       const Operation: IOperation;
                       const BindingName: IQualifiedName): IQualifiedNameArray;
    procedure AddHeaders(const WSDLImporter: IWSDLImporter;
                         const WSDLItems: TWSDLItems;
                         const Operation: IOperation;
                         const BindingName: IQualifiedName;
                         OverloadIndex: Integer;
                         const MessageNames: IQualifiedNameArray;
                         var SOAPVersion: TSOAPVersion);
    procedure AddFaults(const WSDLImporter: IWSDLImporter;
                        const WSDLItems: TWSDLItems;
                        const Operation: IOperation);
    function  GetPartCountOfType(PartTypeKind: PartType): integer;
    function  GetPartOfType(PartTypeKind: PartType): IWSDLPart;
    function  GetPartsOfType(PartTypeKind: PartType): IWSDLPartArray;
    procedure UnwrapParams(const PartsIn: IWSDLPartArray;
                           PartIn: PartType;
                           const PartsOut: IWSDLPartArray;
                           PartOut: PartType);
    procedure ChangePartsKind(NewKind: PartType; OldKind: PartType);
    procedure TweakReturnParam(const Importer: IWSDLImporter; Opts: TTweakPartOpts);
    procedure HandleLiteralParams(UnwrapStat: UnwrapStatus; UseLiteralParams: Boolean);
    function  CanUnwrap(Input: Boolean): UnwrapStatus;
  public
    constructor Create; virtual;
    destructor  Destroy; override;
    function    GetParts: IWSDLPartArray;
    function    GetHeaders: IWSDLPartArray;
    function    GetFaults: IWSDLPartArray;
    function    IsOverloaded: Boolean;
    function    GetSOAPAction: DOMString;
    function    GetStyle: DOMString;
    function    GetInputUse: DOMString;
    function    GetInputNamespace: DOMString;
    function    GetOuputUse: DOMString;
    function    GetOuputNamespace: DOMString;
    function    GetReturnIndex: integer;
    function    GetWSDLItemType: WSDLItemType; override;
    procedure   SetSelected(const Sel: Boolean); override;
    procedure   SetOverloaded(const Value: Boolean);
    function    GetCannotUnwrap: TCannotUnwrap;
    procedure   SetCannotUnwrap(const Value: TCannotUnwrap);
    function    GetInputWrapper: IWSDLPart;
    function    GetOutputWrapper: IWSDLPart;
  end;

  { Implements IWSDLPortType }
  TWSDLPortType = class(TWSDLItem, IWSDLPortType)
  private
    FOperationArray: IWSDLOperationArray;
    FIID:            TGUID;
    FBinding:        DOMString;
    FService:        DOMString;
    FPort:           DOMString;
    FURL:            DOMString;
    FStyle:          DOMString;
    FUse:            DOMString;
    FTransport:      DOMString;
    FSOAPAction:     DOMString;
    FInvokeOptions:  TIntfInvokeOptions;
    FBaseInterfaceName: DOMString;
    FFlags:          TPortTypeFlags;

    function  AddOperations(const PortType: IPortType; const WSDLImporter: IWSDLImporter;
                            const WSDLItems: TWSDLItems; const Operations: IOperations;
                            const BindingName: IQualifiedName; var SOAPVersion: TSOAPVersion): Integer;
    function  FixupOperationParams(const WSDLImporter: IWSDLImporter): TIntfInvokeOptions;

  public
    constructor Create; virtual;
    destructor  Destroy; override;
    function    GetOperationCount: integer;
    function    GetOperations: IWSDLOperationArray;
    function    GetGUID: TGUID;
    function    GetBinding: DOMString;
    function    GetService: DOMString;
    function    GetPort: DOMString;
    function    GetURL: DOMString;
    function    GetStyle: DOMString;
    function    GetUse: DOMString;
    function    GetTransport: DOMString;
    function    GetHasDefaultSOAPAction: Boolean;
    function    GetHasAllSOAPActions: Boolean;
    function    GetSOAPAction: DOMString;
    procedure   SetSOAPAction(const soapAction: DOMString; All: Boolean);
    function    GetWSDLItemType: WSDLItemType; override;
    procedure   SetSelected(const Sel: Boolean); override;
    function    GetInvokeOptions: TIntfInvokeOptions;
    function    GetBaseInterfaceName: DOMString;
    procedure   SetInvokeOptions(const InvOptions: TIntfInvokeOptions);
    function    GetPortTypeFlags: TPortTypeFlags;
  end;

  { Implements IWSDLType }
  TWSDLType = class(TWSDLItem, IWSDLType)
  private
    FDataKind:  WSDLTypeKind;
    FTypeFlag:  WSDLTypeFlag;
    FTypeInfo:  PTypeInfo;
    FEnumValues: IWSDLItemArray;
    FBaseType: IWSDLType;
    FSerializeOpt: TSerializationOptions;
    FMembers:   IWSDLPartArray;
    FDimensions: Integer;
    FIsUsed: Boolean;
    FXMLItemInfo: TXMLItemInfo;
    FAlternateType: IWSDLType;
    FRegInfo: string;
  public
    constructor Create; virtual;
    destructor  Destroy; override;
    function    GetDataKind: WSDLTypeKind;
    function    GetTypeFlag: WSDLTypeFlag;
    function    GetTypeInfo: PTypeInfo;
    function    GetEnumValues: IWSDLItemArray;
    function    GetBaseType: IWSDLType;
    function    GetMembers: IWSDLPartArray;
    function    GetDimensions: integer;
    function    GetIsUsed: Boolean;
    function    GetXMLItemInfo: TXMLItemInfo;
    function    GetRegInfo: string;

    procedure   SetDataKind(const DataKind: WSDLTypeKind);
    procedure   SetTypeFlag(const TypeFlag: WSDLTypeFlag);
    procedure   SetTypeInfo(const TypeInfo: PTypeInfo);
    procedure   SetEnumValues(const enumValues: IWSDLItemArray);
    procedure   SetBaseType(const baseType: IWSDLType);
    procedure   SetMembers(const membrs: IWSDLPartArray);
    procedure   SetDimensions(dim: Integer);
    procedure   SetIsUsed(Used: Boolean);
    procedure   SetXMLItemInfo(const Flag: TXMLItemInfo);
    procedure   SetRegInfo(const RegInfo: string);

    function    GetWSDLItemType: WSDLItemType; override;

    procedure   AddMember(const Member: IWSDLPart);
    procedure   RemoveMember(const Member: IWSDLPart);

    function    GetSerializerOpt: TSerializationOptions;
    procedure   SetSerializerOpt(const SOpt: TSerializationOptions);

    function    GetAlternateType: IWSDLType;
    procedure   Cleanup;
  end;

{$IFDEF CACHE_TYPES}
  PointerArray = array of Pointer;
  TTypesCache = class(TDictionary<string, PointerArray>)
  end;
{$ENDIF}

  { Implements IWSDLTypes }
  TWSDLTypes = class(TWSDLItem, IWSDLTypes)
  private
    FWSDLTypeArray: IWSDLTypeArray;
{$IFDEF CACHE_TYPES}
    FTypesCache: TTypesCache;
{$ENDIF}
    procedure AddType(const WSDLType: IWSDLType); overload;
  public
    constructor Create;
    destructor Destroy; override;

    function  FindType(const Name, Namespace: DOMString;
                       const HasThese: TXMLItemInfo;
                       const DoesNotHaveThese: TXMLItemInfo;
                       Create: Boolean): IWSDLType;
    function  GenArrayType(const WSDLType: IWSDLType; const Tag: Boolean): IWSDLType;
    function  GenAliasType(const WSDLType: IWSDLType;
                           const Name: DOMString;
                           const Namespace: DOMString): IWSDLType;
    function  AddType(const Name,  Namespace: DOMString; XMLItemInfo: TXMLItemInfo): IWSDLType; overload;
    function  AddType(const Name,  Namespace: DOMString;
                      XMLItemInfo: TXMLItemInfo;
                      IsScalar: Boolean; IsA: TClass): IWSDLType; overload;
    function  GetTypes: IWSDLTypeArray;
    procedure Clear;
    function  GetWSDLItemType: WSDLItemType; override;
    function  IndexOf(const WSDLType: IWSDLType): Integer;
    procedure Move(CurIndex: Integer; NewIndex: Integer);
    procedure Swap(Index1, Index2: Integer);
    function  GetType(Index: Integer): IWSDLType; inline;
    procedure SetSelected(const Sel: Boolean); override;
  end;

  { Implements IWSDLPortTypes }
  TWSDLPortTypes = class(TWSDLItem, IWSDLPortTypes)
  private
    FWSDLPortTypeArray: IWSDLPortTypeArray;
  public
    destructor Destroy; override;
    procedure AddPortType(const WSDLPortType: IWSDLPortType);
    function  GetPortTypes: IWSDLPortTypeArray;
    procedure Clear;
    function  GetWSDLItemType: WSDLItemType; override;
    procedure SetSelected(const Sel: Boolean); override;
  end;

  TWSDLPartFixer = class(TWSDLItem, IWSDLType)
    FWSDLPart: IWSDLPart;
  public
    constructor Create(PartToFix: IWSDLPart);
    destructor  Destroy; override;
    function  GetDataKind: WSDLTypeKind;
    function  GetTypeFlag: WSDLTypeFlag;
    function  GetTypeInfo: PTypeInfo;
    function  GetEnumValues: IWSDLItemArray;
    function  GetBaseType: IWSDLType;
    function  GetMembers: IWSDLPartArray;
    function  GetDimensions: integer;
    function  GetIsUsed: Boolean;
    function  GetXMLItemInfo: TXMLItemInfo;
    function  GetRegInfo: string;

    procedure AddMember(const Member: IWSDLPart);
    procedure RemoveMember(const Member: IWSDLPart);

    procedure SetDataKind(const DataKind: WSDLTypeKind);
    procedure SetTypeFlag(const TypeFlag: WSDLTypeFlag);
    procedure SetTypeInfo(const TypeInfo: PTypeInfo);
    procedure SetEnumValues(const enumValues: IWSDLItemArray);

    { Key method used to patch part back to its data type }
    procedure SetBaseType(const WSDLType: IWSDLType);

    procedure SetMembers(const membrs: IWSDLPartArray);
    procedure SetDimensions(dim: Integer);
    procedure SetIsUsed(Used: Boolean);
    procedure SetXMLItemInfo(const Flag: TXMLItemInfo);
    procedure SetRegInfo(const RegInfo: string);

    function  GetSerializerOpt: TSerializationOptions;
    procedure SetSerializerOpt(const SOpt: TSerializationOptions);
    function  GetAlternateType: IWSDLType;
    procedure Cleanup;
  end;

var
  WSDLImpDotSym: TMemIniFile;         // Maps to WSDLImp.sym file

{ Main entry-point of import }
function  ImportWSDL(const WSDLFileName: DOMString;
                     const Stream: TStream;
                     WriteProc: TWriteProc;
                     Flag: TImporterFlags;
                     const OutFileName: DOMString = '';
                     const Proxy: DOMString = '';
                     const UserName: DOMString = '';
                     const Password: DOMString = '';
                     ATimeOut: Integer = 0;
                     const WSDLImportInfo: PWSDLImportInfo = nil): IWSDLImporter;
var
  Importer: IWSDLImporter;
begin
  Importer := TWSDLImporter.Create(nil, Flag);
  Importer.OnWrite := WriteProc;
  Importer.OutFile := OutFileName;
  Importer.GetWSDLItems.StreamLoader.Proxy := Proxy;
  Importer.GetWSDLItems.StreamLoader.Password := Password;
  Importer.GetWSDLItems.StreamLoader.UserName := UserName;
  Importer.GetWSDLItems.StreamLoader.Timeout := ATimeOut;
  Importer.WSDLImportInfo := WSDLImportInfo;
  Importer.Import(WSDLFileName, Stream);
  Result := Importer;
end;

{ Similar to ExtractFileName except that it also handles forward slashes }
{ and other characters found in URIs - and it removes anything found at
  end of urls like querystrings or bookmarks }
function ExtractFileNameEx(const FileName: string): string;
const
  Delim1 = '\/:';
  Delim2 = '.?#/';
var
  I: Integer;
  Len: Integer;
begin
  Len := Length(FileName);
  I := LastDelimiter(Delim1, FileName);
  if (I = Len) and (Len > 1) then
    I := LastDelimiter(Delim1, Copy(FileName, 1, Len-1));
  Result := Copy(FileName, I + 1, MaxInt);
  I := FirstDelimiter(Delim2, Result);
  if I > 0 then
    Result := Copy(Result, 1, I-1);
end;

function GetOutFileName(const FileName: string): string;
begin
  { BB: Improve filename generation }
  Result := GetValidIdent(ExtractFileNameEx(FileName));
end;

function GetValidIdent(const Ident: string): string;
const
  Alpha = ['A'..'Z', 'a'..'z', '_'];
  AlphaNumeric = Alpha + ['0'..'9'];
  Numeric = ['0'..'9'];
var
  I: Integer;
begin
  Result := Ident;
  if (Length(Ident) = 0) then
    Result := '_'
  else
  begin
    if CharInSet(Result[1], Numeric) then
      Result := '_' + Result;
    if not CharInSet(Result[1], Alpha) then
      Result[1] := '_';
  end;
  for I := 2 to Length(Result) do
  begin
    if not CharInSet(Result[I], AlphaNumeric) then
      Result[I] := '_';
  end;
end;

procedure ValidateIdentifier(var Ident: string);
var
  I: Integer;
begin
  I := 1;
  while I <= Length(Ident) do
  begin
    if CharInSet(Ident[I], ['A'..'Z','a'..'z','_','0'..'9']) then
      Inc(I)
    else if CharInSet(Ident[I], LeadBytes) then
      Delete(Ident, I, 2)
    else
      Ident[I] := '_';
  end;
end;

procedure AddHeadersForOperation(Operation: IWSDLOperation; HeaderTracker: TRegTracker);
var
  Headers: IWSDLPartArray;
  I: integer;
begin
  Headers := Operation.Headers;
  for I := 0 to Length(Headers) -1 do
  begin
    case Headers[I].PartKind of
      pIn:
        HeaderTracker.AddItem(Headers[I].DataType.LangName, Operation.Name,
                              Headers[I].DataType.Namespace, hmtRequest, Headers[I].Required);
      pOut:
        HeaderTracker.AddItem(Headers[I].DataType.LangName, Operation.Name,
                              Headers[I].DataType.Namespace, hmtResponse, Headers[I].Required);
      pInOut:
        HeaderTracker.AddItem(Headers[I].DataType.LangName, Operation.Name,
                              Headers[I].DataType.Namespace, hmtAll, Headers[I].Required);
    end;
  end;
end;

procedure AddFaultsForOperation(Operation: IWSDLOperation; FaultTracker: TRegTracker);
var
  Faults: IWSDLPartArray;
  I: integer;
begin
  Faults := Operation.Faults;
  for I := 0 to Length(Faults) -1 do
    FaultTracker.AddItem(Faults[I].LangName, Operation.Name,
                  Faults[I].Namespace, hmtAll, False);
end;


  constructor TMethodItem.Create(const MethName: DOMString;
              MethType: eHeaderMethodType; Required: Boolean);
  begin
    inherited Create;
    FMethodName := MethName;
    FMethType := MethType;
    FRequired := Required;
  end;

{ TMethodList }

  procedure TMethodList.AddItem(const MethName: DOMString; MethType: eHeaderMethodType;
                                Required: Boolean);
  var
    Index: Integer;
  begin
    Index := Find(MethName);
    if Index >= 0 then
    begin
      TMethodItem(Items[Index]).FMethType := hmtAll;                         
      TMethodItem(Items[Index]).FRequired := Required;
    end else
      Add(TMethodItem.Create(MethName, MethType, Required));
  end;

  function TMethodList.Find(const MethName: DOMString): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := 0 to Count -1 do
    begin
      if SameText(TMethodItem(Items[I]).FMethodName, MethName) then
      begin
        Result := I;
        break;
      end;
    end;
  end;

{ THeaderItem }

  constructor THeaderItem.Create(const TypeName, MethName, Namespace: DOMString;
                                 MethType: eHeaderMethodType; Required: Boolean);
  begin
    inherited Create;
    FTypeName := TypeName;
    FNamespace := Namespace;
    FMethodList := TMethodList.Create;
    FMethodList.AddItem(MethName, MethType, Required);
  end;

{ TRegTracker }

  constructor TRegTracker.Create(const IntfName: DOMString; 
              const ARegHeader, ARegHeaderMethod: string; RegType: TRegTrackType);
  begin
    inherited Create;
    FIntfName := IntfName;
    FRegHeader := ARegHeader;
    FRegHeaderMethod := ARegHeaderMethod;
    FRegType := RegType;
  end;

  function TRegTracker.Find(const TypeName: DOMString): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := 0 to Count -1 do
    begin
      if SameText(THeaderItem(Items[I]).FTypeName, TypeName) then
      begin
        Result := I;
        break;
      end;
    end;
  end;

  procedure TRegTracker.WriteRegistration(const IntfName: DOMString;
            Operations: IWSDLOperationArray; Writer: TWSDLWriter);

    { if true, also return whether Request/Response/Both and if Required }
    function UseAll(TypeName: DOMString; var MethType: EHeaderMethodType;
             var DefaultRequired: Boolean): Boolean;
    var
      MethCount, Index, I: Integer;
    begin
      DefaultRequired := False;
      MethType := hmtAll;
      Index := Find(TypeName);
      MethCount := THeaderItem(Items[Index]).FMethodList.Count;
      Result := MethCount = Length(Operations);
      if Result then
      begin
        for I := 0 to MethCount -1 do
        begin
          { first time through, get MethodType and Required: all the rest must
            match, or else we need to register all HeaderMethods individually }
          if I = 0 then
          begin
            MethType := TMethodItem(THeaderItem(Items[Index]).FMethodList[I]).FMethType;
            DefaultRequired := TMethodItem(THeaderItem(Items[Index]).FMethodList[I]).FRequired;
          end else
          begin
            if (TMethodItem(THeaderItem(Items[Index]).FMethodList[I]).FMethType <> MethType) or
               (TMethodItem(THeaderItem(Items[Index]).FMethodList[I]).FRequired <> DefaultRequired) then
            begin
              Result := False;
              break;
            end;
          end;
        end;
      end;
    end;

  var
    I, J: Integer;
    TypeName: DOMString;
    SRequired, SType: string;
    MethType: EHeaderMethodType;
    Required: Boolean;
  begin
    for I := 0 to Count -1 do
    begin
      TypeName := THeaderItem(Items[I]).FTypeName;
      if UseAll(TypeName, MethType, Required) then
      begin
        if Required then
          SRequired := 'True'
        else
          SRequired := 'False';
        case MethType of
          hmtAll: SType := 'hmtAll';
          hmtRequest: SType := 'hmtRequest';
          hmtResponse: SType := 'hmtResponse';
        end;
        Writer.WriteFmt(RegHeader, [IntfName, TypeName, SType, SRequired]);
      end else
      begin
        Writer.WriteFmt(RegHeader, [IntfName, TypeName, 'hmtAll', 'False']);
        for J := 0 to THeaderItem(Items[I]).FMethodList.Count -1 do
        begin
          if TMethodItem(THeaderItem(Items[I]).FMethodList[J]).FRequired then
            SRequired := 'True'
          else
            SRequired := 'False';
          case TMethodItem(THeaderItem(Items[I]).FMethodList[J]).FMethType of
            hmtRequest: SType := 'hmtRequest';
            hmtResponse: SType := 'hmtResponse';
            else SType := 'hmtAll';
          end;
          case FRegType of
            rtHeader:
              Writer.WriteFmt(RegHeaderMethod, [IntfName, TypeName,
                TMethodItem(THeaderItem(Items[I]).FMethodList[J]).FMethodName,
                SType, SRequired]);
            rtFault:
              Writer.WriteFmt(RegHeaderMethod, [IntfName, TypeName,
                TMethodItem(THeaderItem(Items[I]).FMethodList[J]).FMethodName]);
          end;
        end;
      end;
    end
  end;

  procedure TRegTracker.AddItem(const TypeName, MethName, Namespace: DOMString;
            MethType: eHeaderMethodType; Required: Boolean);
  var
    Index: Integer;
  begin
    Index := Find(TypeName);
    if Index < 0 then
      Add(THeaderItem.Create(TypeName, MethName, Namespace, MethType, Required))
    else
      THeaderItem(Items[Index]).FMethodList.AddItem(MethName, MethType, Required);
  end;


{ TWSDLBaseImporter }

procedure TWSDLBaseImporter.WriteFeedback(const Fmt: string; const Args: array of const);
begin
  if Assigned(FOnWrite) then
    FOnWrite(Fmt, Args);
end;

procedure TWSDLBaseImporter.AddWarning(const Fmt: string; const Args: array of const);
begin
  if Assigned(FWarningList) then
    FWarningList.Add(Format(Fmt, Args));
end;

{ TWSDLImporter }

constructor TWSDLImporter.Create(AOwner: TComponent; Flag: TImporterFlags);
begin
  inherited Create(AOwner);
  FImporterFlags := Flag;
  FWSDLTypes := TWSDLTypes.Create;
  FWSDLPortTypes := TWSDLPortTypes.Create;
  FImportList := TProcessedTracker.Create;
  FSchemaImportList := TProcessedTracker.Create;
  FWarningList:= TStringList.Create;
end;

destructor TWSDLImporter.Destroy;
begin
  Cleanup();
  FWarningList.Free;
  FWSDLPortTypes := nil;
  FWSDLTypes := nil;
  inherited Destroy;
end;

procedure TWSDLImporter.Cleanup;
var
  WSDLType: IWSDLType;
begin
  { Remove all type references to allow proper cleanup }
  { NOTE: Without this, the model could contain circular reference
          that would prevent proper cleanup }
  for WSDLType in FWSDLTypes.GetTypes do
  begin
    WSDLType.Cleanup;
  end;
end;

procedure TWSDLImporter.Import(const FileName: DOMString;
                               const Stream: TStream);

  function isHTTP(const Name: String): boolean;
  const
    sHTTPPrefix = 'http://';
    sHTTPsPrefix= 'https://';
  begin
    Result := SameText(Copy(Name, 1, Length(sHTTPPrefix)), sHTTPPrefix) or
              SameText(Copy(Name, 1, Length(sHTTPsPrefix)),sHTTPsPrefix);
  end;

  function GetFullPath(const Path: string): string;
  begin
    Result := Path;
    if IsHTTP(Path) then
      Exit;
    if FileExists(Path) then
    begin
      Result := ExpandFileName(Path);
      if Result = '' then
        Result := Path;
    end;
  end;

var
  WSDLItems: TWSDLItems;
  Definition: IDefinition;
  Name: DOMString;
  SchemaStream: TMemoryStream;
  SchemaDoc: IXMLSchemaDoc;
begin
  FFileName := GetFullPath(FileName);
  WSDLItems := GetWSDLItems;

  if Assigned(Stream) then
    WSDLItems.LoadFromStream(Stream)
  else
    WSDLItems.Load(FileName);
  WSDLItems.Active := True;

  if (HasDefinition(WSDLItems as IWSDLItems) = False) and
     (ifImportXMLSchema in FImporterFlags) then
  begin
    FWSDLImporterOpts := FWSDLImporterOpts + [woHasLiteralUse];
    SchemaStream := TMemoryStream.Create;
    try
      StreamLoader.Load(FFileName, SchemaStream);
      SchemaDoc := TXMLSchemaDoc.Create(nil);
      SchemaDoc.LoadFromStream(SchemaStream);
      SchemaDoc.Active := True;
      SchemaDoc.FileName := FFileName;
      ImportsCallback(ioLoaded, nil, SchemaDoc, FFileName);
    finally
      SchemaStream.Free;
    end;
  end
  else
  begin
    { Confirm Definition Node is present }
    try
      Definition := WSDLItems.Definition;
    except
      on E: EIntfCastError do
      begin
        raise Exception.Create(Format(sMissingDefinition, [WSDLItems.FileName, Wsdlns]));
      end;
      on E2: Exception do
        raise E2;
    end;

    { Store Definition's Name }
    Name := Definition.Name;
    if (Name = '') then
      Name := ExtractFileNameEx(FileName);
    SetDefName(Name);

    { Initialize list }
    FImportList.Clear;
    FImportList.AddProcessed(FileName);

    { Load the types/porttypes of this WSDL }
    ImportTypes(Self, FileName, FWSDLTypes, True);
    { Iterate through imports }
    IterateImports(ImportsCallback);
    { Import interfaces }
    ImportInterfaces(Self, FWSDLPortTypes);
  end;
{$IFDEF VALIDATE_MODEL}
  ValidateModel;
{$ENDIF}
  { Tweak types as needed }
  MungeTypes;
  { Mark which types are used and which ones are not}
  MarkTypes;
  { Sort Types }
  SortTypes;
{$IFDEF LOG_TYPES_DUMP}
  { Dump Types }
  DumpTypes;
{$ENDIF}
end;

procedure TWSDLImporter.ImportsCallback(const Options: IterateImportOptions;
                                        const WSDLItems: IWSDLItems;
                                        const XMLSchemaDoc: IXMLSchemaDoc;
                                        const Name: DOMString);
var
  ForSchema: Boolean;
  ProcessedAlready: Boolean;
begin
  { Processing a Schema or WSDL ? }
  ForSchema := XMLSchemaDoc <> nil;

  { And have we seen it already }
  if (ForSchema) then
    ProcessedAlready := FSchemaImportList.ProcessedAlready(Name)
  else
    ProcessedAlready := FImportList.ProcessedAlready(Name);

  if (Options = ioBeforeLoad) then
  begin
    if not (wfQuietMode in Global_WSDLGenFlags) then
    begin
      if ProcessedAlready then
        WriteFeedback(sFeedbackSkip+sLineBreak, [Name])
      else
        WriteFeedback(sFeedbackImp+sLineBreak, [Name]);
    end;
  end
  else if (Options = ioLoaded) then
  begin
    if not ProcessedAlready then
    begin
      if XMLSchemaDoc <> nil then
      begin
        ImportTypes(XMLSchemaDoc.SchemaDef, Name, FWSDLTypes);
        FSchemaImportList.AddProcessed(Name);
      end
      else
      begin
        ImportTypes(WSDLItems.GetWSDLItems, Name, FWSDLTypes, False);
        ImportInterfaces(WSDLItems.GetWSDLItems, FWSDLPortTypes);
        FImportList.AddProcessed(Name);
      end;
    end;
  end;
end;

procedure TWSDLImporter.WriteFeedback(const Fmt: string; const Args: array of const);
begin
  if Assigned(FOnWrite) then
    FOnWrite(Fmt, Args);
end;

function TWSDLImporter.GetWSDLItems: TWSDLItems;
begin
  Result := Self;
end;

function TWSDLImporter.GetTypes: IWSDLTypeArray;
begin
  Result := FWSDLTypes.Types;
end;

function TWSDLImporter.GetPortTypes: IWSDLPortTypeArray;
begin
  Result := FWSDLPortTypes.PortTypes;
end;

function TWSDLImporter.GetWSDLTypes: IWSDLTypes;
begin
  Result := FWSDLTypes;
end;

function TWSDLImporter.GetWSDLPortTypes: IWSDLPortTypes;
begin
  Result := FWSDLPortTypes;
end;

procedure TWSDLImporter.SelectItem(const WSDLItem: IWSDLItem);
begin
  { Clear selection }
  FWSDLTypes.Selected := False;
  FWSDLPortTypes.Selected := False;

  { Now select }
  if (WSDLItem <> nil) then
    WSDLItem.Selected := True;
end;

procedure TWSDLImporter.AddWarning(const warning: string);
begin
  FWarningList.Add(warning);
end;

procedure TWSDLImporter.AddWarning(const Fmt: string; const Args: array of const);
begin
  AddWarning(Format(Fmt, Args));
end;

procedure TWSDLImporter.ImportTypes(const WSDLItems: TWSDLItems;
                                    const Name: DOMString;
                                    const WSDLTypes: IWSDLTypes;
                                    const Reset: Boolean);
var
  TypeImporter: TWSDLTypeImporter;
  Importer: ISchemaTypeImporter;
begin
  TypeImporter := TWSDLTypeImporter.Create;
  Importer := TypeImporter;

  TypeImporter.OnWrite := FOnWrite;
  TypeImporter.WarningList := FWarningList;
  TypeImporter.FWSDLOptions := Self;

  Importer.GetTypes(WSDLItems, WSDLTypes, Name, FSchemaImportList, Reset);
end;

procedure TWSDLImporter.ImportTypes(const Schema: IXMLSchemaDef;
                                    const Name: DOMString;
                                    const WSDLTypes: IWSDLTypes);
var
  TypeImporter: TWSDLTypeImporter;
  Importer: ISchemaTypeImporter;
begin
  TypeImporter := TWSDLTypeImporter.Create;
  Importer := TypeImporter;

  TypeImporter.OnWrite := FOnWrite;
  TypeImporter.WarningList := FWarningList;
  TypeImporter.FWSDLOptions := Self;

  Importer.GetTypes(Schema, WSDLTypes, Name, FSchemaImportList);
end;

procedure TWSDLImporter.ImportInterfaces(const WSDLItems: TWSDLItems;
                                         const WSDLPortTypes: IWSDLPortTypes);
var
  IntfImporter: TWSDLInterfaceImporter;
begin
  IntfImporter := TWSDLInterfaceImporter.Create;
  try
    IntfImporter.OnWrite := FOnWrite;
    IntfImporter.WarningList := FWarningList;

    IntfImporter.GetInterfaces(Self, WSDLItems, WSDLPortTypes);
  finally
    IntfImporter.Free;
  end;
end;

function  TWSDLImporter.GetOnWrite: TWriteProc;
begin
  Result := FOnWrite;
end;

procedure TWSDLImporter.SetOnWrite(const WriteProc: TWriteProc);
begin
  FOnWrite := WriteProc;
end;

function TWSDLImporter.GetWarningList: TStringList;
begin
  Result := FWarningList;
end;

function TWSDLImporter.GetOutFile: DOMString;
begin
  Result := FOutFile;
end;

procedure TWSDLImporter.SetOutFile(const OFile: DOMString);
begin
  FOutFile := OFile;
end;

{ --------------------------------------------------------
Helper routine to intercept when a string matches a value.
----------------------------------------------------------}
function _DebugHack(Str: DOMString): Boolean;
begin
  Result := False;
  if Str = 'QueryResult' then
  begin
    asm
      int 3;
    end;
    Result := True;
  end;
end;

function TWSDLImporter.FindType(const Name: DOMString;
                                const Namespace: DOMString;
                                const HasThese: TXMLItemInfo = [];
                                const DoesNotHaveThese: TXMLItemInfo = [];
                                Create: Boolean = True): IWSDLType;
begin
  Result := FWSDLTypes.FindType(Name, Namespace, HasThese, DoesNotHaveThese, Create);
end;

function TWSDLImporter.SkipType(const WSDLType: IWSDLType; SkipAll: Boolean = False): Boolean;
begin
  // If we don't have any porttypes, then we don't skip any types
  // as this probably means that the WSDL is really just an XML
  // schema that declares types
  if Length(FWSDLPortTypes.PortTypes) < 1 then
  begin
    if (not SkipAll) or ((WSDLType.DataKind <> wtNotDefined) and (WSDLType.DataKind <> wtDuplicate)) then
    begin
      Result := False;
      Exit;
    end;
  end;

  Result := True;
  { Ununsed ?? }
  if (wfSkipUnusedTypes in Global_WSDLGenFlags) and
     (WSDLType.IsUsed = False) then
    Exit;

  { Literal types ?? }
  if (WSDLType.TypeFlag = wfLiteralParam) and
      not WSDLType.IsUsed and
      not (wfOutputLiteralTypes in Global_WSDLGenFlags) then
    Exit;

  { Should we be real strict - i.e. avoid predefined/duplicate too }
  if SkipAll then
  begin
    case WSDLType.DataKind of
      wtNotDefined, wtDuplicate:
        Exit;
    end;
  end;

  { If we get this far, it's good! }
  Result := False;
end;

function TWSDLImporter.GetOptions: TWSDLImporterOpts;
begin
  Result := FWSDLImporterOpts;
end;

procedure TWSDLImporter.SetOptions(const Opts: TWSDLImporterOpts);
begin
  FWSDLImporterOpts := Opts;
end;

function TWSDLImporter.GetWSDLImportInfo: PWSDLImportInfo;
begin
  Result := FWSDLImportInfo;
end;

procedure TWSDLImporter.SetWSDLImportInfo(const WSDLImportInfo: PWSDLImportInfo);
var
  Len, I: Integer;
  URL: string;
begin
  FWSDLImportInfo := WSDLImportInfo;
  if WSDLImportInfo <> nil then
  begin
    Len := Length(WSDLImportInfo^.SkipURLs);
    for I := 0 to Len-1 do
    begin
      URL := WSDLImportInfo^.SkipURLs[I];
      if not FSchemaImportList.ProcessedAlready(URL) then
        FSchemaImportList.AddProcessed(URL);
    end;
  end;
end;


{ TWSDLTypeImporter }
constructor TWSDLTypeImporter.Create;
begin
  inherited Create;
end;

destructor TWSDLTypeImporter.Destroy;
begin
  inherited Destroy;
end;

function TWSDLTypeImporter.Start(const SchemaDef: IXMLSchemaDef; const SchemaLoc: String): XMLVisitorContext;
begin
  WriteFeedback(sFeedbackImp+sLineBreak, [SchemaLoc]);
end;

{$IFDEF LOG_TYPES_READING}
procedure TWSDLTypeImporter.LogTypeReading(Item: IXMLSchemaItem);
begin
  WriteFeedback(sReadingType+sLineBreak, [Item.Name]);
end;
{$ENDIF}

function TWSDLTypeImporter.Visit(const Item: IXMLElementDef;
                                 const ElementTypes: TElementTypes;
                                 const CompositorId: Integer;
                                 const Context: XMLVisitorContext): XMLVisitorContext;
begin
{$IFDEF LOG_TYPES_READING}
  LogTypeReading(Item);
{$ENDIF}

  // Skip Global Groups as it's a top-level that names the group
  if (ElementTypes = [etGlobal, etElementGroup]) then
  begin
    Result := Context;
    Exit;
  end;

  Result := AddElement(Item, ElementTypes, CompositorId, Context);
end;

function TWSDLTypeImporter.Visit(const Item: IXMLAttributeDef; const Context: XMLVisitorContext): XMLVisitorContext;
begin
{$IFDEF LOG_TYPES_READING}
  LogTypeReading(Item);
{$ENDIF}
  Result := AddAttribute(Item, Context);
end;

function TWSDLTypeImporter.Visit(const Item: IXMLComplexTypeDef; const Context: XMLVisitorContext): XMLVisitorContext;
begin
{$IFDEF LOG_TYPES_READING}
  LogTypeReading(Item);
{$ENDIF}
  Result := AddComplexType(Item, Context);
end;

function TWSDLTypeImporter.Visit(const Item: IXMLAttributeGroup; const Context: XMLVisitorContext): XMLVisitorContext;
begin
{$IFDEF LOG_TYPES_READING}
  LogTypeReading(Item);
{$ENDIF}
  Result := AddAttributeGroup(Item, Context);
end;

function TWSDLTypeImporter.Visit(const Item: IXMLElementGroup; const Context: XMLVisitorContext): XMLVisitorContext;
begin
{$IFDEF LOG_TYPES_READING}
  LogTypeReading(Item);
{$ENDIF}
  Result := AddElementGroup(Item, Context);
end;

procedure TWSDLTypeImporter.UpdateWoHasOptions(Opt: WSDLImporterOpts);
begin
  if not (Opt in Options) then
    Options := Options + [Opt];
end;

function TWSDLTypeImporter.VisitAny(const Item: IXMLNode;
  const Context: XMLVisitorContext): XMLVisitorContext;
//var
//  Part: TWSDLPart;
begin
//Note: this function does nothing (not sure why it is here but commented out to clear up warning
//  if (False {Need Runtime Support}) and (not (xtiMixed in Context.XMLItemInfo)) then
//  begin
//    Part := TWSDLPart.Create;
//    { NOTE: For a true name it's not necessary to extract but for whatever
//            reason when an element has a ref attribute,  the 'Ref' member
//            is not always set and one  has to rely on Name. In that case,
//            it might be a qualified Name }
//    Part.FName := ExtractLocalName(Item.NodeName);
//    Part.FNamespace := XMLSchemaNamespace;
//    Part.FDataType := FindType('schema', XMLSchemaNamespace, [xtiGlobal]);
//    Part.FPartFlags := [pfAny, pfOptional];
//    Context.AddMember(Part);
//
//    UpdateWoHasOptions(woHasAny);
//    UpdateWoHasOptions(woHasOptionalElem);
////    if not (woHasAny in Options) then
////      Options := Options + [woHasAny];
////    if not (woHasOptionalElem in Options) then
////      Options := Options + [woHasOptionalElem];
//  end;
end;

function TWSDLTypeImporter.Visit(const Item: IXMLSimpleTypeDef;const Context: XMLVisitorContext): XMLVisitorContext;
begin
{$IFDEF LOG_TYPES_READING}
  LogTypeReading(Item);
{$ENDIF}
  Result := AddSimpleType(Item, Context);
end;

procedure TWSDLTypeImporter.Skipping(const SchemaLoc: String);
begin
  WriteFeedback(sFeedbackSkip+sLineBreak, [SchemaLoc]);
end;

procedure TWSDLTypeImporter.Done(const SchemaLoc: String);
begin
  WriteFeedback(sFeedbackDone+sLineBreak, [SchemaLoc]);
end;

procedure TWSDLTypeImporter.Error(const SchemaLoc: String; const Msg: string);
begin
  WriteFeedback(sFeedbackError+sLineBreak, [SchemaLoc]);
  WriteFeedback(sFeedbackError2+sLineBreak, [Msg]);
end;

function TWSDLTypeImporter.GetOptions: TWSDLImporterOpts;
begin
  Result := FWSDLOptions.Options;
end;

procedure TWSDLTypeImporter.SetOptions(Opts: TWSDLImporterOpts);
begin
  FWSDLOptions.Options := Opts;
end;

procedure TWSDLTypeImporter.GetTypes(const WSDLItems: TWSDLItems;
                                     const WSDLTypes: IWSDLTypes;
                                     const Name: DOMString;
                                     const Tracker: IProcessedTracker;
                                     const Reset: Boolean);
var
  Types: ITypes;
  I: Integer;
  SchemaDef: IXMLSchemaDef;
  SchemaName: DOMString;
begin
  { Reset Type array }
  if Reset then
    WSDLTypes.Clear;

  { Store away }
  FWSDLTypes := WSDLTypes;
  try

    { Retrieve 'Types' under 'Definition' }
    Types := WSDLItems.Definition.Types;

    if (Types <> nil) and (Types.SchemaDefs.Count > 0) then
    begin
      for I := 0 to Types.SchemaDefs.Count - 1 do
      begin
        SchemaDef := Types.SchemaDefs[I];
        { The logic below tags a ># to the name in order for us
          to use this string to keep track of schemas already
          processed. When the schema is embedded in a WSDL, this
          is really not an issue except that this path may be
          used to resolve a relative schema included/imported.
          Fortunately, the '>' does not conflict with relative
          path resolution }
        SchemaName := Name + '>' + IntToStr(I);
        GetTypes(SchemaDef, WSDLTypes, SchemaName, Tracker);
      end;
    end;
  finally
    FWSDLTypes := nil;
  end;
end;

{ Returns an array of DOMString representing the members of an enumeration }
function GetEnumValues(const XMLEnumColl: IXMLEnumerationCollection): IWSDLItemArray;
var
  Count: Integer;
  Item: TWSDLItem;
begin
  SetLength(Result, 0);
  for Count := 0 to XMLEnumColl.Count-1 do
  begin
    SetLength(Result, Count+1);
    { NOTE: TWSDLItem.GetWSDLItemType is not used in enumeration members }
    Item := TWSDLItem.Create;
    Item.FName := XMLEnumColl[Count].Value;
    Result[Count] := Item;
  end;
end;

function GetEnumInfo(const XMLEnumColl: IXMLEnumerationCollection): String;
const
  Commas: array[Boolean] of string = ('', ', ');
var
  Enums: IWSDLItemArray;
  I: Integer;
begin
  Enums := GetEnumValues(XMLEnumColl);
  for I := 0 to Length(Enums)-1 do
    Result := Format('%s%s%s', [Result, Commas[Length(Result)>0], Enums[I].Name]);
end;

function TWSDLTypeImporter.AddType(const Name,  Namespace: DOMString; XMLItemInfo: TXMLItemInfo): IWSDLType;
begin
  Result := FWSDLTypes.AddType(Name, Namespace, XMLItemInfo);
end;

function TWSDLTypeImporter.FindType(const Name, Namespace: DOMString;
                                    HasThese: TXMLItemInfo;
                                    DoesNotHaveThese: TXMLItemInfo;
                                    Create: Boolean): IWSDLType;
begin
  Result := FWSDLTypes.FindType(Name, Namespace, HasThese, DoesNotHaveThese, Create);
end;

function TWSDLTypeImporter.AddComplexType(const TypeDef: IXMLComplexTypeDef; const Context: IWSDLType): IWSDLType;


  function HuntExtension(const WSDLType: IWSDLType): Boolean;
  const
    ContentNode: array[TDerivationMethod] of string = ('', sComplexContent, sComplexContent,
     sSimpleContent, sSimpleContent);
  var
    Node: IXMLNode;
    TypeName, TypeNamespace: DOMString;
  begin
    Result := False;
    Node := TypeDef.ChildNodes.FindNode(ContentNode[Typedef.DerivationMethod]);
    if (Node <> nil) then
    begin
      Node := Node.ChildNodes.FindNode(sExtension);
      if (Node <> nil) then
      begin
        if Node.HasAttribute(sBase) then
        begin
          TypeName := Node.Attributes[sBase];
          if IsPrefixed(TypeName) then
          begin
            TypeNamespace := ExtractPrefix(TypeName);
            TypeName := ExtractLocalName(TypeName);
            TypeNamespace := Node.FindNamespaceURI(TypeNamespace);
          end
          else
            TypeNamespace := WSDLType.Namespace;
          WSDLType.BaseType := FindType(TypeName, TypeNamespace, [xtiGlobal]);
          Result := True;
        end;
      end;
    end;
  end;


var
  TypeName, TypeNamespace: DOMString;
  Dimension: Integer;
  Part: TWSDLPart;
  AName, ANamespace: DOMString;
begin
  if (TypeDef.IsAnonymous) then
  begin
{$IFDEF COLLAPSE_ANONYMOUS_COMPLEXTYPES}
    if (Context.DataKind = wtNotDefined) then
      Result := Context
    else
{$ENDIF}
    begin
      { Get a default Name/Namespace }
      AName := Context.Name;
      ANamespace := Context.Namespace;
      AName := GetNameOf(TypeDef, AName);
      ANamespace := GetNamespaceOf(Typedef);
      Result := AddType(AName, ANamespace, [xtiComplex]);
      { Point context back to us }
      if (Context.DataKind = wtNotDefined) then
        Context.DataKind := wtAlias;
      Context.BaseType := Result;
    end;
  end
  else
  begin
    Result := FindType(TypeDef.Name, GetNamespaceOf(Typedef), [xtiGlobal], [xtiSimple, xtiElement, xtiAttribute]);
    Result.XMLItemInfo := Result.XMLItemInfo + [xtiComplex];
  end;

  (* NOTE: Don't be tempted to handle pure collections here because they then become
           ineligible for unwrapping if they are literal params.
           Instead we'll handle them in MungeTypes -- *)

  { Handle Arrays }
  Dimension := 1; {Safe start}
  if SOAPArray(Typedef, TypeName, TypeNamespace, Dimension) then
  begin
    Result.DataKind := wtArray;
    Result.Dimensions := Dimension;
    Result.BaseType := FindType(TypeName, TypeNamespace, [xtiGlobal]);
    Exit;
  end;

  { Handle Mixed Content }
  if TypeDef.HasAttribute(SMixed) and (TypeDef.ElementDefs.Count = 0) then
  begin
    {
      NOTE:
       .NET will sometimes emit something like this in a WSDL's schema:

        <s1:schema elementFormDefault="qualified"
                   targetNamespace="http://www.w3.org/2001/XMLSchema">
          <s1:complexType name="dateTime" mixed="true">
            <s1:anyAttribute/>
          </s1:complexType>
        </s1:schema>

      It's common to see this for Services that want to expose a header of a
      simpleType. Of course, this would throw us off because it's in essense
      remapping a built-in XML type.

      Mapping to xsd:string is not a good idea in that case. To work around
      this for now, we'll stop for anything that's in the XMLNamespace
    }
    if GetNamespaceOf(TypeDef) = XMLSchemaNamespace then
    begin
      Result.TypeInfo := RemClassRegistry.XSDToTypeInfo(XMLSchemaNamespace, TypeDef.Name);
      if (Result.TypeInfo <> nil) then
        Exit;
    end;

    Result.DataKind := wtAlias;
    Result.BaseType := FindType('schema', XMLSchemaNamespace, [xtiGlobal]);
    Result.XMLItemInfo := Result.XMLItemInfo + [xtiMixed];
    Exit;
  end;

  { Here we have a class }
  Result.DataKind := wtClass;

  { More work required here for Simple Extensions }
  if (TypeDef.DerivationMethod = dmSimpleExtension) or
     (TypeDef.DerivationMethod = dmSimpleRestriction) then
  begin
    if (TypeDef.BaseType <> nil) then
    begin
      Part := TWSDLPart.Create;
      Part.FName := 'Text'; { Do not localize }
      Part.FNamespace := Result.Namespace;

      TypeName := TypeDef.BaseType.Name;
      TypeNamespace := TypeDef.BaseType.NamespaceURI;
      TypeName := GetNameOf(TypeDef.BaseType, '');
      TypeNamespace := GetNamespaceOf(TypeDef.BaseType);
      Part.FDataType := FindType(TypeName, TypeNamespace, [xtiGlobal]);
      Part.FPartFlags := [pfText];

      UpdateWoHasOptions(woHasText);
//      if not (woHasText in Options) then
//        Options := Options + [woHasText];

      Result.AddMember(Part);
    end
    else
    begin
      { Here sometimes XMLSchema fails to set the BaseType - so we workaround }
      { This happens, for example, with AWSAlexa's DataUrl type }
      { Log failure if our workaround failed too }
      if not HuntExtension(Result) then
        Result.AddNote(Format('TODO: Simple Content Failure: %s', [DerivationMethodStr[TypeDef.DerivationMethod]]));
    end;
  end;

  if (TypeDef.BaseType <> nil) then
  begin
    Result.BaseType := FindType(TypeDef.BaseType.Name, GetNamespaceOf(TypeDef.BaseType), [xtiGlobal]);
  end
  else
  begin
    { Here we workaround cases where the XMLSchema handler fails to set BaseType properly }
    { This happens with many types declared in PayPayl/EBay's schema for example }
    if (TypeDef.DerivationMethod = dmComplexExtension) or
       (TypeDef.DerivationMethod = dmComplexRestriction) then
    begin
      { Log failure if our workaround failed too }
      if not HuntExtension(Result) then
        Result.AddNote(Format('TODO: XMLParser missed derivation: %s', [DerivationMethodStr[TypeDef.DerivationMethod]]));
    end;
  end;
end;

function TWSDLTypeImporter.AddAttributeGroup(const TypeDef: IXMLAttributeGroup; const Context: IWSDLType): IWSDLType;
var
  AName, ANamespace: DOMString;
  isGlobal, hasName, hasRef: Boolean;
  Part: TWSDLPart;
begin
  isGlobal :=Typedef.IsGlobal;
  hasName := Typedef.HasAttribute(SName);
  hasRef := Typedef.HasAttribute(SRef);
  if hasName then
  begin
    AName := TypeDef.Attributes[SName];
    ANamespace := GetNamespaceOf(TypeDef);
  end
  else if hasRef then
  begin
    AName := TypeDef.Attributes[SRef];
    if IsPrefixed(AName) then
    begin
      ANamespace := ExtractPrefix(AName);
      AName := ExtractLocalName(AName);
      ANamespace := Typedef.FindNamespaceURI(ANamespace);
    end;
  end;

  if isGlobal then
  begin
    if hasName or hasRef then
    begin
      Result := FindType(AName, ANamespace, [xtiGlobal],
                                            [xtiElement, xtiComplex,
                                             xtiSimple, xtiElemGroup], True);
      Result.XMLItemInfo := Result.XMLItemInfo + [xtiAttrGroup];
      Result.DataKind := wtAttrGroup;
    end;
  end
  else
  begin
    Part := TWSDLPart.Create;
    Context.AddMember(Part);
    if hasRef then
    begin
      Result := FindType(AName, ANamespace, [xtiGlobal],
                                            [xtiElement, xtiComplex,
                                             xtiSimple, xtiElemGroup], True);
      Result.XMLItemInfo := Result.XMLItemInfo + [xtiAttrGroup];
      Part.SetName(Format('attributeGroup_%s', [AName]));
      Part.SetNamespace(ANamespace);
      Part.FDataType := Result;
    end
    else if AttributeGroupDefinedInline(Typedef) then
      Result := TWSDLPartFixer.Create(Part)
    else
      Result := Context;
  end;
end;

function TWSDLTypeImporter.AddElementGroup(const TypeDef: IXMLElementGroup; const Context: IWSDLType): IWSDLType;
begin
  Result := Context;
end;


function TWSDLTypeImporter.AddElement(const TypeDef: IXMLElementDef;
                                      const ElementTypes: TElementTypes;
                                      const CompositorId: Integer;
                                      const Context: IWSDLType): IWSDLType;

  function StrToIntSafe(const S: DOMString): Integer;
  begin
    try
      Result := StrToInt(S);
    except
      Result := 0;
    end;
  end;

  function PartFlagsToImporterOpts(PartFlags: TPartFlag): TWSDLImporterOpts;
  const             {opt/unb/nil/unq/txt}
    WIOpts: array[PartFlag] of WSDLImporterOpts = (
            woHasOptionalElem,
            woHasUnboundedElem,
            woHasNillableElem,
            woHasUnqualifiedElem,
            woHasText,
            woHasAny,
            woHasRef,
            woHasQualifiedAttr);
  var
    F: PartFlag;
  begin
    Result := [];
    for F := Low(PartFlag) to High(PartFlag) do
    begin
      if F in PartFlags then
        Result := Result + [WIOpts[F]];
    end;
  end;

var
  IsGlobal: Boolean;
  IsElementOfArray, IsRefed: Boolean;
  Part: TWSDLPart;
  PartFlags: TPartFlag;
  SearchFor: TXMLItemInfo;
  SearchNotFor: TXMLItemInfo;
//  Attr: DOMString;
  FoundOpts: TWSDLImporterOpts;
  TypeName, TypeNamespace: DOMString;
  ElemName, ElemNamespace: DOMString;
begin
  IsElementOfArray := (Context <> nil) and (Context.DataKind = wtArray);
  if (IsElementOfArray) then
  begin
    { When type of array if defined, let it fix up back to the array }
    if ElementDefinedInline(TypeDef) then
      Result := Context;
    Exit;
  end;

  IsGlobal := TypeDef.IsGlobal;
  if (IsGlobal) then
  begin
    { A Global <element... > is an alias to some other element (via ref="...") or
      another type (via type="xxx") }
    ElemName := TypeDef.Name;
    ElemNamespace := GetNamespaceOf(Typedef);
    Result := FindType(ElemName, ElemNamespace, [xtiGlobal], [xtiSimple, xtiComplex, xtiAttribute]);
    Result.XMLItemInfo := Result.XMLItemInfo + [xtiElement];
    if not ElementDefinedInline(TypeDef) then
    begin
      Result.DataKind := wtAlias;
      IsRefed := HasRefAttr(TypeDef);
      if IsRefed then
      begin
        SearchFor := [xtiGlobal, xtiElement];
        SearchNotFor := [xtiSimple, xtiComplex, xtiAttribute];
      end
      else
      begin
        SearchFor := [xtiGlobal];
        SearchNotFor := [xtiElement];
      end;
      TypeName := GetDataTypeName(TypeDef);
      TypeNamespace := GetDataTypeNamespace(TypeDef);
      Result.BaseType := FindType(TypeName, TypeNamespace, SearchFor, SearchNotFor);
    end else
    begin
      // Global Element with inline declaration of type
      Part := TWSDLPart.Create;
      try
        { NOTE: For a true name it's not necessary to extract but for whatever
                reason when an element has a ref attribute,  the 'Ref' member
                is not always set and one  has to rely on Name. In that case,
                it might be a qualified Name }
        Part.FName := ExtractLocalName(GetNameOf(TypeDef));
        Part.FNamespace := GetNamespaceOf(TypeDef);
        IsRefed := HasRefAttr(TypeDef);
        if IsRefed then
          Part.FPartFlags := [pfRef];
        UpdateWoHasOptions(woHasRef);
        Result := FindType(Part.FName, Part.FNamespace, [xtiElement, xtiGlobal], [xtiSimple, xtiComplex, xtiAttribute]);
      finally
        Part.Free;
      end;
    end;
  end
  else
  begin
    Part := TWSDLPart.Create;
    { NOTE: For a true name it's not necessary to extract but for whatever
            reason when an element has a ref attribute,  the 'Ref' member
            is not always set and one  has to rely on Name. In that case,
            it might be a qualified Name }
    ElemName := ExtractLocalName(GetNameOf(TypeDef));
    ElemNamespace := GetNamespaceOf(Typedef);
    Part.FName := ElemName;
    Part.FNamespace := ElemNamespace;
    Context.AddMember(Part);

    { Collect part flags }
    PartFlags := [];

    { maxOccurs > 1 }
{$IFDEF _DEBUG}
    if TypeDef.HasAttribute(SMaxOccurs) then
    begin
      Attr := TypeDef.Attributes[SMaxOccurs];
      if (Attr = SUnbounded) then
        PartFlags := PartFlags + [pfUnbounded]
      else if StrToIntSafe(Attr) > 1 then
        PartFlags := PartFlags + [pfUnbounded]
    end;
{$ELSE}
    if TypeDef.IsRepeating then
    begin
      PartFlags := PartFlags + [pfUnbounded]
    end;
{$ENDIF}

    { Nillable ? }
    if Typedef.HasAttribute(SSoapNillable) and (TypeDef.Attributes[SSoapNillable] = STrue) then
      PartFlags := PartFlags + [pfNillable];

    { Optional: minOccurs='0' or a 'choice '}
    if Typedef.HasAttribute(SMinOccurs) and (TypeDef.Attributes[SMinOccurs] = DOMString('0')) then
      PartFlags := PartFlags + [pfOptional]
    else if etChoice in ElementTypes then
      PartFlags := PartFlags + [pfOptional];

    { Element form }
    if TypeDef.HasAttribute(sElemForm) then
    begin
     if (Typedef.Attributes[sElemForm] = SUnqualified) then
      PartFlags := PartFlags + [pfFormUnqualified];
    end
    else
    begin
      if TypeDef.SchemaDef.ElementFormDefault = fcUnqualified then
      begin
        if not (pfRef in PartFlags) then
          PartFlags := PartFlags + [pfFormUnqualified];
      end;
    end;

    Part.FPartFlags := PartFlags;

    { Let importer know of flags we've encountered }
    FoundOpts := PartFlagsToImporterOpts(PartFlags);
    if (FoundOpts - Options) <> [] then
      Options := Options + FoundOpts;

    { Default value }
    if Typedef.HasAttribute(SDefault) then
      Part.FDefaultValue := TypeDef.Attributes[SDefault];

    { If it's an element with an anonymous type, the type will fixup back to
      its element's (i.e. IWSDLPart) when it's handled }
    if ElementDefinedInline(TypeDef) then
      Result := TWSDLPartFixer.Create(Part)
    else
    begin
      { Here the element refers to a global type }
      IsRefed := HasRefAttr(TypeDef);
      if IsRefed then
      begin
        SearchFor := [xtiGlobal, xtiElement];
        SearchNotFor := [xtiSimple, xtiComplex];
        Part.FPartFlags := Part.FPartFlags + [pfRef];
        if (pfFormUnqualified in Part.FPartFlags) then
          Part.FPartFlags := Part.FPartFlags - [pfFormUnqualified];
        UpdateWoHasOptions(woHasRef);
      end
      else
      begin
        SearchFor := [xtiGlobal];
        SearchNotFor := [xtiElement];
      end;
      TypeName := GetDataTypeName(TypeDef);
      TypeNamespace := GetDataTypeNamespace(TypeDef);
      Result := FindType(TypeName, TypeNamespace, SearchFor, SearchNotFor);
      Part.FDataType := Result;
    end;
  end;
end;

function TWSDLTypeImporter.AddAttribute(const TypeDef: IXMLAttributeDef; const Context: IWSDLType): IWSDLType;
var
  IsGlobal, IsRefed: Boolean;
  Part: TWSDLPart;
  PartFlags: TPartFlag;
  AttrName, AttrNS: DOMString;
  TypeName, TypeNS: DOMString;
  HasThese, NotThese: TXMLItemInfo;
begin
  Result := nil;
  IsGlobal := TypeDef.IsGlobal;
  if (IsGlobal) then
  begin
    { A Global <attribute... > is an alias to some other attribute (via ref="...") or
      another type (via type="xxx") }
    AttrName := GetNameOf(TypeDef);
    AttrNS := GetNamespaceOf(TypeDef);
    Result := FindType(AttrName, AttrNS, [xtiGlobal], [xtiSimple, xtiComplex, xtiElement]);
    Result.XMLItemInfo := Result.XMLItemInfo + [xtiAttribute];
    if not AttributeDefinedInline(TypeDef) then
    begin
      Result.DataKind := wtAlias;
      TypeName := GetDataTypeName(TypeDef);
      TypeNS := GetDataTypeNamespace(TypeDef);

      IsRefed := HasRefAttr(TypeDef);
      if IsRefed then
      begin
        HasThese := [xtiGlobal, xtiAttribute];
        NotThese := [xtiSimple, xtiComplex, xtiElement];
      end
      else
      begin
        HasThese := [xtiGlobal];
        NotThese := [xtiAttribute];
      end;

      Result.BaseType := FindType(TypeName, TypeNS, HasThese, NotThese);
    end else
    begin
                                                                                     
    end;
  end
  else
  begin
    { Bail out if it's an array - as this means that it's a SOAP Array
      with a non XML standard attribute }
    if Context.DataKind = wtArray then
      Exit;

    Part := TWSDLPart.Create;
    Part.FName := GetNameOf(TypeDef);
    Part.FNamespace := GetNamespaceOf(TypeDef);
    Context.AddMember(Part);

    { Collect part flags - Attribute 'use' defaults to 'optional' and form to 'unqualified'}
    PartFlags := [pfOptional];

    { Is it Required ? }
    if TypeDef.HasAttribute(SUse) and (TypeDef.Attributes[SUse] <> SOptional) then
      PartFlags := PartFlags - [pfOptional];

    { Qualified ? }
    if TypeDef.HasAttribute(sElemForm) then
    begin
     if (Typedef.Attributes[sElemForm] = Squalified) then
      PartFlags := PartFlags + [pfFormQualified];
    end
    else
    begin
      if TypeDef.SchemaDef.AttributeFormDefault = fcqualified then
        PartFlags := PartFlags + [pfFormQualified];
    end;

    Part.FPartFlags := PartFlags;

    { Mark as 'attribute' }
    Part.FPartKind := pAttribute;

    { Flag that we have attributes }
    UpdateWoHasOptions(woHasAttribute);
    { It's optional ? }
    if (pfOptional in PartFlags) then
      UpdateWoHasOptions(woHasOptionalElem);
    { It's qualified ? }
    if (pfFormQualified in PartFlags) then
      UpdateWoHasOptions(woHasQualifiedAttr);

    { If it's an element with an anonymous type, the type will fixup back to the
      it's element's (i.e. IWSDLPart) when it's handled }
    if AttributeDefinedInline(TypeDef) then
    begin
      { Attribute type defaults to string }
                                                                                                          
      Part.FDataType := FindType('string', XMLSchemaNamespace, [xtiGlobal], []);
      Result := TWSDLPartFixer.Create(Part)
    end
    else
    begin
      { Here the element refers to a global type }
      { NOTE: We could check whether it's via ref="xxx" or type="xxx" to allow us to
              narrow down the datatype correctly }
      try
        TypeName := GetDataTypeName(TypeDef);
        TypeNS := GetDataTypeNamespace(TypeDef);

        IsRefed := HasRefAttr(TypeDef);
        if IsRefed then
        begin
          HasThese := [xtiGlobal, xtiAttribute];
          NotThese := [xtiSimple, xtiComplex, xtiElement];
        end
        else
        begin
          HasThese := [xtiGlobal];
          NotThese := [xtiAttribute];
        end;

        Result := FindType(TypeName, TypeNS, HasThese, NotThese);
      except
        { In case of exception, fallback on xsd:string - it's fairly
          safe for an attribute }
        if Result = nil then
          Result := FindType('string', XMLSchemaNamespace, [xtiGlobal], []);
      end;
      Part.FDataType := Result;
    end;
  end;
end;

function TWSDLTypeImporter.AddSimpleType(const TypeDef: IXMLSimpleTypeDef; const Context: IWSDLType): IWSDLType;
var
  ItemInfo: TXMLItemInfo;
begin
  ItemInfo := [xtiSimple];
  if IsKnownType(TypeDef) then
    ItemInfo := [xtiKnownType];

  if (TypeDef.IsAnonymous) then
  begin
    Result := AddType(TypeDef.Name, GetNamespaceOf(Typedef), [xtiSimple]);
    if (Context.DataKind = wtNotDefined) then
      Context.DataKind := wtAlias;
    Context.BaseType := Result;
  end
  else
    Result := FindType(TypeDef.Name, GetNamespaceOf(Typedef), [xtiGlobal], [xtiComplex, xtiElement, xtiAttribute]);

  Result.XMLItemInfo := Result.XMLItemInfo + ItemInfo;

  { Enumerations }
  if (TypeDef.DerivationMethod = sdmRestriction) and
     (TypeDef.Enumerations <> nil) and
     (TypeDef.Enumerations.Count > 0) then
  begin
    Result.DataKind := wtEnumeration;
    Result.EnumValues := GetEnumValues(TypeDef.Enumerations);
  end
  else
  begin
    Result.DataKind := wtAlias;
    if TypeDef.BaseType <> nil then
      Result.BaseType := FindType(TypeDef.BaseType.Name,
                                  GetNamespaceOf(TypeDef.BaseType), [xtiGlobal])
    else
    begin
      { If we're out of ideas, point the type to a string - unless it's xsd:string }
      if (Result.Name <> 'string') and (Result.Namespace <> XMLSchemaNamespace) then
        Result.BaseType := FindType('string', XMLSchemaNamespace, [xtiGlobal])
      else
        Result.DataKind := wtNotDefined;
    end;
  end;
end;

function HasAttributeMembers(const ComplexType: IXMLComplexTypeDef): Boolean;
var
  I: Integer;
  AttributeDef: IXMLAttributeDef;
begin
  Result := False;
  for I := 0 to ComplexType.AttributeDefs.Count-1 do
  begin
    AttributeDef := ComplexType.AttributeDefs[I];
    if AttributeDef.HasAttribute(SUse) and
       AttributeDef.HasAttribute(SName) and
       AttributeDef.HasAttribute(SType) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TWSDLTypeImporter.GetTypes(const Schema: IXMLSchemaDef;
                                     const WSDLTypes: IWSDLTypes;
                                     const Name: DOMString;
                                     const Tracker: IProcessedTracker);
begin
  FWSDLTypes := WSDLTypes;
  try
    VisitSchema(Schema, Name, Self, Tracker);
  finally
    FWSDLTypes := nil;
  end;
end;

function SkipPort(PortType: IPortType; const WSDLItems: TWSDLItems): Boolean;
begin
  Result := False;
  { Skip PortType that are http:bound ??}
  if wfSkipHttpBindings in Global_WSDLGenFlags then
  begin
//    if WSDLItems.IsPortTypeHTTPBound(PortType.Name) then
//      Result := True;
  end;
end;

function GetValidPortTypes(PortTypes: IPortTypes; const WSDLItems: TWSDLItems): ArrayOfIPortType;
var
  I, Count: Integer;
begin
  SetLength(Result, PortTypes.Count);
  Count := 0;
  for I := 0 to (PortTypes.Count-1) do
  begin
    if not SkipPort(PortTypes[I], WSDLItems) then
    begin
      Result[Count] := PortTypes[I];
      Inc(Count);
    end;
  end;
  SetLength(Result, Count);
end;

function TWSDLImporter.GetDefName: DOMString;
begin
  Result := FDefName;
end;

function TWSDLImporter.GetImportList: IProcessedTracker;
var
  I: Integer;
begin
  Result := TProcessedTracker.Create;
  for I := 0 to FImportList.Count-1 do
    Result.AddProcessed(FImportList[I]);
  for I := 0 to FSchemaImportList.Count-1 do
    Result.AddProcessed(FSchemaImportList[I]);
end;

procedure TWSDLImporter.SetDefName(const Name: DOMString);
begin
  FDefName := Name;
end;

function TWSDLImporter.FindMimePart(const PartName, AOperation, AMessage: DOMString;
                                    ArgType: ArgumentType): IMIMEPart;
var
  I: Integer;
begin
  Result := Nil;
  for I := 0 to Length(FMIMEParts) -1 do
  begin
    if not CompareName(FMIMEParts[I].OperationName, AOperation) then
      continue;

    if CompareName(FMIMEParts[I].Name, PartName) and
                  (FMIMEParts[I].ArgType = ArgType) then
    begin
      if (FMimeParts[I].MessageName = '') or
         (CompareName(AMessage, FMimeParts[I].MessageName)) then
      begin
        Result := FMIMEParts[I];
        break;
      end;
    end;
  end;
end;

function TWSDLImporter.CreateSerializer(const BaseType: IWSDLType;
                                        const NewTypeName: DOMString;
                                        const NewTypeNamespace: DOMString;
                                        const MemberName: DOMString;
                                        const SerialOpts: TSerializationOptions;
                                        UpdateReferences: Boolean): IWSDLType;


  procedure UpdateRef(const AType: IWSDLType;
                      const OldType: IWSDLType;
                      const NewType: IWSDLType); overload;
  var
    I: Integer;
    WSDLPart: IWSDLPart;
  begin
    if AType.BaseType = OldType then
      AType.BaseType := NewType;
    for I := 0 to Length(AType.Members)-1 do
    begin
      WSDLPart := AType.Members[I];
      if WSDLPart.DataType = OldType then
        WSDLPart.DataType := NewType;
    end;
  end;

  procedure UpdateRef(const PortType: IWSDLPortType;
                      const OldType: IWSDLType;
                      const NewType: IWSDLType); overload;
  var
    I, J: Integer;
    WSDLPart: IWSDLPart;
    Operation: IWSDLOperation;
  begin
    for I := 0 to Length(PortType.Operations)-1 do
    begin
      Operation := PortType.Operations[I];
      for J := 0 to Length(Operation.Parts)-1 do
      begin
        WSDLPart := Operation.Parts[J];
        if WSDLPart.DataType = OldType then
          WSDLPart.DataType := NewType;
      end;
    end;
  end;

  function CreateSerializer: IWSDLType;
  var
    NewType: TWSDLType;
    NewMember: TWSDLPart;
  begin
    NewType := TWSDLType.Create;
    Result := NewType;
    NewType.FName := NewTypeName;
    NewType.FNamespace := NewTypeNamespace;
    NewType.FDataKind := wtClass;
    NewType.FSerializeOpt := SerialOpts;

    { Copy other attributes }
    NewType.FTypeFlag := BaseType.TypeFlag;

    { Make previous type a member of new type }
    SetLength(NewType.FMembers, 1);
    NewMember := TWSDLPart.Create;
    NewType.FMembers[0] := NewMember;
    NewMember.FName := MemberName;
    NewMember.FDataType := BaseType;

    Result.XMLItemInfo := [xtiFakeAliasType];
  end;

var
  I, Len: integer;
  WSDLType: IWSDLType;
  PortType: IWSDLPortType;
begin
  Result := FindType(NewTypeName, NewTypeNamespace, [xtiFakeAliasType],
                     [xtiGlobal, xtiElement, xtiComplex, xtiSimple, xtiAttribute], False);
  if (Result = nil) then
  begin
    { Create a serializer type }
    Result := CreateSerializer;
    (FWSDLTypes as TWSDLTypes).AddType(Result);
  end;

  { Now find everyone that points to the type and make them point
    to the serializer instead }
  if UpdateReferences then
  begin
    Len := Length(FWSDLTypes.Types);
    for I := 0 to Len-1 do
    begin
      WSDLType := FWSDLTypes.Types[I];
      if WSDLType <> Result then
        UpdateRef(WSDLType, BaseType, Result);
    end;
    for I := 0 to Length(FWSDLPortTypes.PortTypes)-1 do
    begin
      PortType := FWSDLPortTypes.PortTypes[I];
      UpdateRef(PortType, BaseType, Result);
    end;
  end;
end;

                                           

procedure TWSDLImporter.GetMIMEParts(const BindingName: DOMString);

  procedure AddMimePart(MimeNode: IXMLNode;
                        const AOperationName: DOMString;
                        const AMessageName: DOMString;
                        AArgType: ArgumentType);
  var
    PartName: DOMString;
    MPart: IMIMEPart;
  begin
    try
      PartName := MimeNode.Attributes[SPart];
      MPart := TMIMEPart.Create as IMIMEPart;
      MPart.OperationName := AOperationName;
      MPart.MessageName := AMessageName;
      MPart.Name := PartName;
      MPart.MIMEType := MimeNode.Attributes[SType];
      MPart.ArgType := AArgType;
      SetLength(FMIMEParts, Length(FMIMEParts) + 1);
      FMIMEParts[Length(FMIMEParts) -1] := MPart;
    except
     { for now, ignore, as wsdl spec for Attachments is not finalized! }
    end;
  end;

  procedure FindMimeNode(Node: IParam;
                         const AOperation: DOMString;
                         const AMessage: DOMString;
                         AArgType: ArgumentType);
  var
    MimeNode, MimeContentNode: IXMLNode;
    MimeNodes: IXMLNodeList;
    J, K, L: Integer;
  begin
    MimeNodes := Node.ChildNodes;
    for J := 0 to MimeNodes.Count -1 do
    begin
      MimeNode := MimeNodes[J];
      if CompareName(MimeNode.LocalName, SMultiPart) then
      begin
        for K := 0 to MimeNode.ChildNodes.Count -1 do
        begin
          if MimeNode.ChildNodes[K].ChildNodes.Count = 0 then
            continue;
                                                                         
          for L := 0 to MimeNode.ChildNodes[K].ChildNodes.Count -1 do
          begin
            MimeContentNode := MimeNode.ChildNodes[K].ChildNodes[L];
            if MimeContentNode.Attributes[SPart] <> NULL then
            begin
              AddMimePart(MimeContentNode, AOperation, AMessage, AArgType);
              break;
            end;
          end;
        end;
      end;
    end;
  end;

var
  I,Count: Integer;
  AMessage, AOperation: DOMString;
  Bindings: IBindings;
  BindOperations: IBindingOperations;
  BindOperation: IBindingOperation;
  InputNode: IBindingInput;
  OutputNode: IBindingOutput;
begin
  Bindings := Definition.Bindings;
  for Count := 0 to Bindings.Count -1 do
  begin
    if CompareName(Bindings[Count].Name, BindingName) then
    begin
      BindOperations := Bindings[Count].BindingOperations;
      for I := 0 to BindOperations.Count -1 do
      begin
        BindOperation := BindOperations[I];
        AOperation := BindOperation.Name;
        InputNode := BindOperation.Input;
        if (not VarIsNull(InputNode)) and (InputNode.ChildNodes.Count > 0) then
        begin
          if not VarIsNull(InputNode.Attributes[SMessage]) then
            AMessage := InputNode.Attributes[SMessage]
          else
            AMessage := '';
          FindMimeNode(InputNode, AOperation, AMessage, argIn);
        end;
        OutputNode := BindOperation.Output;
        if (not VarIsNull(OutputNode)) and (OutputNode.ChildNodes.Count > 0) then
        begin
          if not VarIsNull(OutputNode.Attributes[SMessage]) then
            AMessage := OutputNode.Attributes[SMessage]
          else
            AMessage := '';
          FindMimeNode(OutputNode, AOperation, AMessage, argOut);
        end;
      end;
    end;
  end;
end;

procedure TWSDLImporter.ClearMIMEParts;
begin
  SetLength(FMIMEParts, 0);
end;

procedure TWSDLInterfaceImporter.GetInterfaces(const WSDLImporter: IWSDLImporter;
                                               const WSDLItems: TWSDLItems;
                                               const WSDLPortTypes: IWSDLPortTypes);
var
  Port: Integer;
  PortTypes: ArrayOfIPortType;
  PortType: IPortType;
  Operations: IOperations;
  ID: TGUID;
  BindingNames: IQualifiedNameArray;
  BindingName: IQualifiedName;
  I: Integer;
  ServiceName, PortName, URLLocation: DOMString;
  NewPortType: TWSDLPortType;
  InvOpts: TIntfInvokeOptions;
  SOAPVersion, CurrSOAPVersion: TSOAPVersion;
  MDigest: IMD5;
  PortTypeSig: String;
  Sig: TByteDynArray;
begin
  BindingName := nil;
  SetLength(BindingNames, 0);

  PortTypes := GetValidPortTypes(WSDLItems.Definition.PortTypes, WSDLItems);
  for Port := 0 to Length(PortTypes)-1 do
  begin
    { Load information about Porttype }
    NewPortType := TWSDLPortType.Create;
    WSDLPortTypes.AddPortType(NewPortType);

    PortType := PortTypes[Port];
    NewPortType.SetName(PortType.Name);
    NewPortType.SetNamespace(WSDLItems.Definition.TargetNamespace);

    { Retrieve the binding name }
    BindingNames := WSDLImporter.GetWSDLItems.GetBindingOfType(PortType.Name, WSDLItems.TargetNamespace);

    { Figure out if the user forced a specific SOAP version, otherwise figure it out for ourselves }
    if wfForceSOAP12 in Global_WSDLGenFlags then
      SOAPVersion := svSOAP12
    else if wfForceSOAP11 in Global_WSDLGenFlags then
      SOAPVersion := svSOAP11
    else
      SOAPVersion := svUnspecified;

    { Find the perfect binding!! }
    if SOAPVersion = svUnspecified then
    begin
{$IFDEF SOAP12_PRECEDENCE_OVER_SOAP11}
      for CurrSOAPVersion := High(TSOAPVersion) downto Low(TSOAPVersion) do
{$ELSE}
      for CurrSOAPVersion := Low(TSOAPVersion) to High(TSOAPVersion) do
{$ENDIF}
      begin
        if CurrSOAPVersion = svUnspecified then
          Continue;

        for I := 0 to Length(BindingNames)-1 do
        begin
          { Service and Port }
          if WSDLImporter.GetWSDLItems.GetServiceAndPortOfBinding(BindingNames[I], ServiceName, PortName) then
          begin
            { Store binding info/index }
            BindingName := BindingNames[I];
            NewPortType.FService := ServiceName;
            NewPortType.FPort := PortName;
            NewPortType.FBinding := BindingNames[I].Name;

             { URL endpoint }
            SOAPVersion := CurrSOAPVersion;
            URLLocation := WSDLImporter.GetWSDLItems.GetSoapAddressForServicePort(ServiceName, PortName, SOAPVersion);
            NewPortType.FURL := URLLocation;

                                                                                                                         
            { Stop as soon as we find a binding with a valid URL }
            if URLLocation <> '' then
              break;
          end;
        end;

        if URLLocation <> '' then
          break;
      end;

      { If we didn't find a URLLocation, don't save any left over SOAP version }
      if URLLocation = '' then
        SOAPVersion := svUnspecified;
    end
    else
    begin
      for I := 0 to Length(BindingNames)-1 do
      begin
        { Service and Port }
        if WSDLImporter.GetWSDLItems.GetServiceAndPortOfBinding(BindingNames[I], ServiceName, PortName) then
        begin
          { Store binding info/index }
          BindingName := BindingNames[I];
          NewPortType.FService := ServiceName;
          NewPortType.FPort := PortName;
          NewPortType.FBinding := BindingNames[I].Name;

           { URL endpoint }
          URLLocation := WSDLImporter.GetWSDLItems.GetSoapAddressForServicePort(ServiceName, PortName, SOAPVersion);
          NewPortType.FURL := URLLocation;

                                                                                                                       
          { Stop as soon as we find a binding with a valid URL }
          if URLLocation <> '' then
            break;
        end;
      end;
    end;

    { If we did not find an appropriate binding, pick one.. }
    if (Length(BindingNames) > 0) and (BindingName = nil) then
    begin
      BindingName := BindingNames[0];
      NewPortType.FBinding := BindingName.Name;
    end;

    if BindingName <> nil then
    begin
      { NOTE: Here we assume that for a given PortType, the style of all operations
              will match that of the style of the <soap:binding> node.
              Each operation has its own style attribute and so it's conceivable
              that each operation could have different styles. However, I have
              not seen implementations of these currently. So for the sake of
              simplicity, we'll keep the above assumption }
      NewPortType.FStyle := WSDLImporter.GetWSDLItems.GetSoapBindingAttribute(BindingName.Name, SStyle, SOAPVersion);

      { If the <soap:binding ...> element does not have a 'style' attribute, then
        we'll use that of an operation when asked (See TWSDLPortType.GetStyle) }
      if NewPortType.FStyle = '' then
      begin
        // Here we'll rely on the operations to retrieve their respective style
        // and we'll default to that
      end;
      
      NewPortType.FUse := WSDLImporter.GetWSDLItems.GetSoapBindingAttribute(BindingName.Name, SUse, SOAPVersion);
      { If the <soap:binding ...> element does not have a 'style' attribute, then
        we'll use that of an operation when asked (See TWSDLPortType.GetUse) }
      if NewPortType.FUse = '' then
      begin
        // Here we'll rely on the operations to retrieve their respective "use" attribute
        // and we'll default to that
      end;   

      { Grab the transport }
      NewPortType.FTransport := WSDLImporter.GetWSDLItems.GetSoapBindingAttribute(BindingName.Name, STransport, SOAPVersion);

      { Load Mime Parts of the binding associated with this porttype }
      WSDLImporter.GetMIMEParts(BindingName.Name);
    end;

{$IFDEF REGISTER_UDDI_INFO}
    { If we did not get an endpoint from WSDL, try UDDI }
    if WSDLImporter.UDDIImportInfo <> nil then
    begin
      NewPortType.FInvokeOptions := NewPortType.FInvokeOptions + [ioHasUDDIInfo];
      if NewPortType.FURL = '' then
        NewPortType.FURL := WSDLImporter.UDDIImportInfo.SOAPEndpoint;
    end;
{$ENDIF}

    try
      if (wfGenTrueGUIDs in Global_WSDLGenFlags) then
      begin
        CoCreateGuid(ID);
        NewPortType.FIID := ID;
      end
      else
      begin
        { Here we use a MessageDigest to generate the GUID. This approach ensures
          that the GUID of a given Service is consistent across multiple imports.
          Technically speaking, it's not necessary that a Service's GUID be consistent;
          however, in practice differing GUIDs lead to trouble unless one is careful
          to rebuild every dependent code after reimporting. This approach minimizes
          this issue }
        MDigest := GetMD5;
        PortTypeSig := Format(sPortTypeSignature, [NewPortType.FName,
                                                   NewPortType.FNamespace,
                                                   NewPortType.FBinding,
                                                   NewPortType.FService,
                                                   NewPortType.FPort]);
        MDigest.Update(PortTypeSig);
        SetLength(Sig, 0);
        Sig := MDigest.Final;
        Move(Pointer(Sig)^, Pointer(@ID)^, SizeOf(TGUID));
        NewPortType.FIID := ID;
      end;

      { Add operations }
      Operations := PortType.Operations;
      NewPortType.AddOperations(PortType, WSDLImporter, WSDLItems, Operations, BindingName, SOAPVersion);
      InvOpts := NewPortType.FixupOperationParams(WSDLImporter);

      { Update PortType Info }
      UpdatePortTypeInfo(NewPortType, InvOpts, SOAPVersion);

      { Update importer if we have a document service }
      if (NewPortType.GetStyle() = 'document') then
        WSDLImporter.Options := WSDLImporter.Options + [woHasDocStyle];
        
      { Update importer if we have 'literal' use }
      if NewPortType.GetUse() = 'literal' then
        WSDLImporter.Options := WSDLImporter.Options + [woHasLiteralUse];        
    finally
      { Make sure we clear the MIME Parts in case different bindings have
        operations with similar part names that could mislead us in thinking
        a part is multipart }
      WSDLImporter.ClearMimeParts;
    end;
  end;
end;

function SubstituteStrings(const InputString: DOMString; const SubString: DOMString;
                           const Replacement: DOMString): DOMString;
var
  I: Integer;
begin
  Result := InputString;
  I := Pos(SubString, InputString);
  if I = 0 then
    Exit
  else
  begin
    Delete(Result, I, Length(SubString));
    Insert(Replacement, Result, I);
  end;
end;

procedure TWSDLInterfaceImporter.UpdatePortTypeInfo(WSDLPortType: IWSDLPortType;
  InvOpts: TIntfInvokeOptions; const SOAPVersion: TSOAPVersion);
const
  SOAPActionDelim = '|,;-&';
var
  I, J: Integer;
  Namespace: DOMString;
  SOAPAction1, SOAPAction2: DOMString;
  WSDLOperation: IWSDLOperation;
  DOMStrings1, DOMStrings2: TDOMStrings;
  Delim: char;
begin
  { The namespace is set to the <soap:body namespace="???"> value since that's
    when we'll use the info - i.e. when sending out a payload }
  for I := 0 to Length(WSDLPortType.Operations)-1 do
  begin
    WSDLOperation := WSDLPortType.Operations[I];
    Namespace := WSDLOperation.InputNamespace;
    if (Namespace = '') then
      Namespace := WSDLOperation.OutputNamespace;
    if (Namespace <> '') then
    begin
      WSDLPortType.Namespace := Namespace;
      break;
    end;
  end;

  { Next we'll see if we can deduce the 'default' SOAPAction }
  DOMStrings1 := TDOMStrings.Create;
  try
    DOMStrings2 := TDOMStrings.Create;
    try
      for I := 0 to Length(WSDLPortType.Operations)-1 do
      begin
        WSDLOperation := WSDLPortType.Operations[I];
        SOAPAction1 := WSDLOperation.SOAPAction;
        SOAPAction2 := SubstituteStrings(SOAPAction1, WSDLOperation.Name, SOperationNameSpecifier);

        if DOMStrings1.IndexOf(SOAPAction1) = -1 then
          DOMStrings1.Add(SOAPAction1);

        if DOMStrings2.IndexOf(SOAPAction2) = -1 then
          DOMStrings2.Add(SOAPAction2);
      end;
      { Easy case - we have just one SOAPAction for all operations }
      if DOMStrings1.Count = 1 then
      begin
        WSDLPortType.SetSOAPAction(DOMStrings1[0], False);
      end
      { Maybe each SOAPAction is just a fix constant with the OperationName }
      else if DOMStrings2.Count = 1 then
      begin
        WSDLPortType.SetSOAPAction(DOMStrings2[0], False);
      end
      else
      begin
        { Here each operation has a "unique" SOAPAction }
        { Find delimiter that's unique }
        for I := 1 to Length(SOAPActionDelim) do
        begin
          Delim := SOAPActionDelim[I];
          for J := 0 to DOMStrings1.Count-1 do
          begin
            if Pos(Delim, DOMStrings1[J]) >= 0 then
              break;
          end;
          if J < DOMStrings1.Count then
            break;
        end;

        { We have a delimiter }
        if I <= Length(SOAPActionDelim) then
        begin
          SOAPAction1 := '';
          for J := 0 to DOMStrings1.Count-1 do
            SOAPAction1 := SOAPAction1 + Delim + DOMStrings1[J];
        end;

        { Here we have the SOAPActions }
        WSDLPortType.SetSOAPAction(SOAPAction1, True);
      end;
    finally
      DOMStrings2.Free;
    end;
  finally
    DOMStrings1.Free;
  end;

  { Then we update the invoke options }
  WSDLPortType.InvokeOptions := WSDLPortType.InvokeOptions + InvOpts;
    
  { Flag that we have a service using literal encoding. 
    NOTE: We use 'ioDocument' for backwards compatibility because back in the early
        days of Delphi 6/7, when everything was rpc|encoded, 'ioDocument' was incorrectly
        used by the runtime to mean "non-section5 encoded" :( }
  if SameText(WSDLPortType.Style, 'document') and SameText(WSDLPortType.Use, 'literal') then  { do not localize }
  begin
    WSDLPortType.InvokeOptions := WSDLPortType.InvokeOptions + [ioDocument];
  end
  else if SameText(WSDLPortType.Style, 'rpc') and SameText(WSDLPortType.Use, 'literal') then  { do not localize }
  begin
    { Again, to work with the backward meaning of InvokeOptions we will use plain 'ioLiteral' to mean rpc|literal }
    WSDLPortType.InvokeOptions := WSDLPortType.InvokeOptions + [ioLiteral];
  end;
  
  //Flag SOAP 1.2
  if SOAPVersion = svSOAP12 then
    WSDLPortType.InvokeOptions := WSDLPortType.InvokeOptions + [ioSOAP12];
end;

{ TWSDLWriter }

constructor TWSDLWriter.Create(const WSDLImporter: IWSDLImporter);
begin
  inherited Create;
  Init(WSDLImporter, WSDLImporter.OutFile);
end;

constructor TWSDLWriter.CreateFilename(const WSDLImporter: IWSDLImporter; OutFileName : string);
begin
  inherited Create;
  Init(WSDLImporter, OutFileName);
end;

destructor TWSDLWriter.Destroy;
begin
  FWSDLImporter := nil;
  inherited Destroy;
end;

procedure TWSDLWriter.Init(const WSDLImporter: IWSDLImporter; OutFileName : string);
begin
  FWSDLImporter := WSDLImporter;
  FOnWrite := WSDLImporter.OnWrite;
  FFileName := WSDLImporter.FileName;
  MapTypes(WSDLImporter.GetTypes);
  ValidateTypes(WSDLImporter.GetTypes);
  ValidatePortTypes(WSDLImporter.GetPortTypes);
  if (OutFileName = '') or (OutFIleName = '_') then
    OutFileName := WSDLImporter.DefName;
  SetOutFile(GetValidIdent(OutFileName), False);
end;

procedure TWSDLWriter.WriteStr(const Str: string);
{$IFDEF UNICODE}
var
  utf8Str: UTF8String;
{$ENDIF}
begin
  if Length(Str) = 0 then
    Exit;
  { Write out the data }
{$IFDEF UNICODE}
  utf8Str := UTF8Encode(Str);
  Write(Pointer(utf8Str)^, Length(utf8Str));
{$ELSE}
  Write(Pointer(Str)^, Length(Str));
{$ENDIF}
end;

procedure TWSDLWriter.WriteLn(const Str: string);
begin
  WriteStr(Str + sLineBreak);
end;

procedure TWSDLWriter.WriteLn(const Fmt: string; const Args: array of const);
begin
  WriteLn(Format(Fmt, Args));
end;

function TWSDLWriter.WriteOutSerialOpts(const WSDLType: IWSDLType): Boolean;
begin
  Result := (WSDLType.SerializationOpt <> []) and
            (WSDLType.TypeFlag <> wfFault) and
            (WSDLType.TypeFlag <> wfHeader);
end;

procedure TWSDLWriter.WriteFmt(const Fmt: string; const Args: array of const);
begin
  WriteStr(Format(Fmt, Args));
end;

procedure TWSDLWriter.WriteFeedback(const Fmt: string; const Args: array of const);
begin
  if Assigned(FOnWrite) then
    FOnWrite(Fmt, Args);
end;

function TWSDLWriter.DataToString: String;
begin
{$IFDEF UNICODE}
  with TStringStream.Create('', TEncoding.UTF8) do
{$ELSE}
  with TStringStream.Create('') do
{$ENDIF}
  try
    CopyFrom(Self, 0);
    Result := DataString;
  finally
    Free;
  end;
end;

function TWSDLWriter.DataToUTF8String: UTF8String;
begin
  Position := 0;
  SetLength(Result, Size);
  Self.Read(Result[1], Length(Result));
end;

procedure TWSDLWriter.WriteToFile(FileName: String);
{$IFDEF UNICODE}
var
  Bom: TBytes;

  { Function returns true if any high bit is set in our stream. The idea here
    is to find out if any utf8 encoding took place or if all characters were
    in the first 128 US Ascii range - which means no BOM is necessary }
  function HasHighBit: Boolean;
  var
    P: PByte;
    I: Integer;
  begin
    Result := False;
    P := Self.Memory;
    for I := 0 to Self.Size-1 do
    begin
      if ((P^ and $80) <> 0) then
      begin
        Result := True;
        Exit;
      end;
      Inc(P);
    end;
  end;

{$ENDIF}
begin
  with TFileStream.Create(FileName, fmCreate) do
  try
{$IFDEF UNICODE}
    if HasHighBit then
    begin
      Bom := TEncoding.UTF8.GetPreamble;
      Self.Position := 0;
      Write(Bom[0], Length(Bom));
    end;
{$ENDIF}
    CopyFrom(Self, 0);
    if not (wfQuietMode in Global_WSDLGenFlags) then
      WriteFeedback(sFeedbackWrite+sLineBreak, [FileName]);
  finally
    Free;
  end;
end;

procedure TWSDLWriter.SetSize(NewSize: Longint);
begin
  if FTempFile = nil then
    inherited SetSize(NewSize)
  else if NewSize = 0 then
  begin
    FTempFile.Free;
    DeleteFile(PChar(FTempFileName));
    FTempFile := nil;
    FTempFileName := '';
  end;
end;

function TWSDLWriter.Write(const Buffer; Count: Integer): Longint;
var
  H: THandleStream;
  TempDir: string;
  C: Integer;
begin
  if FTempFile = nil then
    try
      Result := inherited Write(Buffer, Count);
      Exit;
    except
      { The following logic accomodates cases where we might run out of memory!
        I don't suspect this code to be activated with the typical WSDL of
        today but if/when more complex ones (with zillion of types) show up,
        our goal is to switch to the FileStream at this point }
      on E: EStreamError do
      begin
        SetLength(TempDir, 255);
        SetLength(TempDir, GetTempPath(255, PChar(TempDir)));
        SetLength(FTempFileName, 255);
        GetTempFileName(PChar(TempDir), 'w$d1', 0, PChar(FTempFileName));
        SetLength(FTempFileName, StrLen(PChar(FTempFileName)));
        H := THandleStream.Create(CreateFile(PChar(FTempFileName),
          GENERIC_READ or GENERIC_WRITE, 0, nil, CREATE_ALWAYS,
          FILE_ATTRIBUTE_TEMPORARY, 0));
        Self.Position := 0;
        C := Self.Size;
        H.WriteBuffer(Self.Memory^, C);
        Self.SetSize(0);
        FTempFile := H;
      end;
    end;
  if (FTempFile <> nil) then
    Result := FTempFile.Write(Buffer, Count)
  else
    Result := 0;
end;

procedure TWSDLImporter.MarkTypes;
var
  I, J, K: Integer;
  PortTypes: IWSDLPortTypeArray;
  Operation: IWSDLOperation;
  PortType: IWSDLPortType;
begin
  PortTypes := GetPortTypes;
  for I := 0 to Length(PortTypes)-1 do
  begin
    PortType := PortTypes[I];
    for J := 0 to Length(PortType.Operations)-1 do
    begin
      Operation := PortType.Operations[J];
      for K := 0 to Length(Operation.Parts)-1 do
      begin
        Operation.Parts[K].DataType.IsUsed := True;
      end;
      for K := 0 to Length(Operation.Headers)-1 do
      begin
        Operation.Headers[K].DataType.IsUsed := True;
      end;
      for K := 0 to Length(Operation.Faults)-1 do
      begin
        Operation.Faults[K].DataType.IsUsed := True;
      end;
    end;
  end;
end;

type
  MoveReason = (mrUnusedType, mrAliasBaseType, mrArrayBaseType, mrClassBaseType, mrClassMember, mrClassMemberAlias);

  IWSDLTypeComparer = interface(IComparer<IWSDLType>)
  ['{DE49EAE5-7A91-44D7-A388-BC4F17E8749B}']
  end;
  
  TWSDLTypeComparer = class(TInterfacedObject, IWSDLTypeComparer)
  public
    function Compare(const Left, Right: IWSDLType): Integer; 
  end;
  
function TWSDLTypeComparer.Compare(const Left, Right: IWSDLType): Integer; 
const
  BoolVal: array[Boolean] of Integer = (-1, 1);
var
  LIsUsed, RIsUsed: Boolean;
begin
  Result := 0;
  LIsUsed := Left.IsUsed;
  RIsUsed := Right.IsUsed;
  if (LIsUsed <> RIsUsed) then
  begin
    Result := BoolVal[LIsUsed];
  end;
end;

const
  MoveReasonStr: array[MoveReason] of string = ('mrUnusedType',
                                                'mrAliasBaseType',
                                                'mrArrayBaseType',
                                                'mrClassBaseType',
                                                'mrClassMember',
                                                'mrClassMemberAlias');

{ Sort types in a way that eases the code generation - i.e. So that we can
  write out types in the order they are in the array without having to worry
  about forward references }
procedure TWSDLImporter.SortTypes;

  function CompareHelper(const A: IWSDLType; const B: IWSDLType): Integer;
  var
    Member: IWSDLPart;
  begin
    Result := 0;

    { All unused items are at the end }
    if not A.IsUsed then
    begin
      if not B.IsUsed then
        Result := 0
      else
        Result := 1;
      Exit;
    end;

    { Alias: A type follows its alias }
    if (A.DataKind = wtAlias) and (A.BaseType = B) then
      Result := 1

    { Array }
    else if (A.DataKind = wtArray) and (A.BaseType = B) then
    begin
      { An array of a class precedes the class; array of other types follow }
      if (B.DataKind in [wtClass, wtAttrGroup]) then
        Result := -1
      else
        Result := 1;
    end

    { Class }
    else if (A.DataKind in [wtClass, wtAttrGroup]) then
    begin
      { A class follows its base type }
      if (A.BaseType = B) then
        Result := 1
      else
        for Member in A.Members do
        begin
          if (Member.DataType = B) and (Member.DataType.DataKind <> wtArray) then
          begin
            Result := 1;
            break;
          end;
        end;
    end;
  end;

  function Compare(const A: IWSDLType; const B: IWSDLType): Integer;
  begin
    Result := CompareHelper(A, B);
{$IFDEF LOG_TYPES_SORTING}
    if (Result <> 0) and (Result = CompareHelper(B, A)) then
      WriteFeedback(sUnableToSortTypes+sLineBreak, [A.Name, B.Name]);
{$ENDIF}
  end;

  procedure GetDependentTypes(const WSDLType: IWSDLType; var Types: IWSDLTypeArray); overload;
  begin
  end;

  function GetDependentTypes(const WSDLType: IWSDLType): IWSDLTypeArray; overload;
  begin
    SetLength(Result, 0);
    GetDependentTypes(WSDLType, Result);
  end;


  { Returns index of a particular type }
  function IndexOfType(const WSDLType: IWSDLType): integer;
  begin
    Result := FWSDLTypes.IndexOf(WSDLType);
  end;

  { Moves one type from its current index to a new index - it's inserted at the new index }
  procedure MoveType(curIndex: integer; newIndex: integer; AMoveReason: MoveReason);
  begin
{$IFDEF LOG_TYPES_SORTING}
    WriteFeedback(sMovingType+sLineBreak,
                  [FWSDLTypes.Types[curIndex].LangName, curIndex,
                   FWSDLTypes.Types[newIndex].LangName, newIndex,
                   WSDLTypeKindStr[FWSDLTypes.Types[curIndex].DataKind],
                   MoveReasonStr[AMoveReason]]);
{$ENDIF}
    FWSDLTypes.Move(curIndex, newIndex);
{$IFDEF LOG_TYPES_SORTING}
    if (AMoveReason <> mrUnusedType) then
      WriteFeedback(sSortingType+sLineBreak, [FWSDLTypes.Types[curIndex].LangName, curIndex,
                                              WSDLTypeKindStr[FWSDLTypes.Types[curIndex].DataKind]]);
{$ENDIF}
  end;

var
  I, Idx, Idx2, Loop: Integer;
  WSDLType, SortingType, TempType: IWSDLType;
  Len, LastIndex: Integer;
  Member: IWSDLPart;
  AMoveReason: MoveReason;
  AComparer: IWSDLTypeComparer;
begin
  { Any types to sort? }
  Len := Length(FWSDLTypes.Types);
  if Len < 2 then
    Exit;

  { First move all unused types to the end }
  AComparer := TWSDLTypeComparer.Create as IWSDLTypeComparer;
  TArray.Sort<IWSDLType>((FWSDLTypes as TWSDLTypes).FWSDLTypeArray, AComparer);

  { NOTE: The following fuzzy sorting logic should be reworked! }
  I := 0;
  LastIndex := -1;
  Loop := 0;

  while (I < Len) do
  begin
    { Did we loop too much }
    if (Loop > Len) then
    begin
      { Give a warning and move to next one }
      AddWarning(sUnableToSort, [SortingType.LangName]);
{$IFDEF LOG_TYPES_SORTING}
      WriteFeedback(sUnableToSort+sLineBreak, [SortingType.LangName]);
{$ENDIF}
      Inc(I);
    end;

    { Are we moving to next one? Grab the type we're sorting
      in order to be able to emit warnings when we're unable
      to sort }
    if I > LastIndex then
    begin
      Loop := 0;
      LastIndex := I;
      SortingType := FWSDLTypes.Types[I];
{$IFDEF LOG_TYPES_SORTING}
      WriteFeedback(sDottedLine+sLineBreak, []);
      WriteFeedback(sSortingType+sLineBreak, [SortingType.Name, I,
                                              WSDLTypeKindStr[SortingType.DataKind]]);
{$ENDIF}
    end;

    WSDLType := FWSDLTypes.Types[I];

    { Don't bother with unused types }
    if SkipType(WSDLType) then
    begin
{$IFDEF LOG_TYPES_SORTING}
      WriteFeedback(sFeedbackSkip+sLineBreak, [WSDLType.Name]);
{$ENDIF}
      Inc(I);
      continue;
    end;

    { NOTE: The following logic does not handle circular references
            very well. Should be reworked when type sorting is reworked. }
    case WSDLType.DataKind of
      { Alias should follow their base type }
      wtAlias:
        begin
          Idx := IndexOfType(WSDLType.BaseType);
          if Idx > I then
            MoveType(I, Idx, mrAliasBaseType)
          else
            Inc(I);
        end;

      wtArray:
      { Arrays should follow their base type }
      { However, there's a catch. If an array's underlying
        type is a class, then the class should follow
        the array to allow for the case where one of the
        class' members might be arrays of the class itself
        NOTE: The Amazon Webservice illustrates this well }
        begin
          if WSDLType.BaseType.DataKind <> wtClass then
          begin
            Idx := IndexOfType(WSDLType.BaseType);
            if Idx > I then
              MoveType(I, Idx, mrArrayBaseType)
            else
              Inc(I);
          end else
            Inc(I);
        end;

      { Classes must make sure they follow their members types }
      { unless the member is of class type }
      { And base types }
      wtClass, wtAttrGroup:
        begin
          // To shut off warning
          AMoveReason := mrClassMember;
          Idx := I;
          { Find index of furthest member }
          for Member in WSDLType.Members do
          begin
            { Skip class types as they are forward declared }
            if (Member.DataType.DataKind = wtClass) then
              continue;

            Idx2 := IndexOfType(Member.DataType);
            if Idx2 > Idx then
            begin
              Idx := Idx2;
              AMoveReason := mrClassMember;
            end;
            { And follow aliases }
            TempType := Member.DataType;
            while (TempType.DataKind = wtAlias) do
            begin
              TempType := TempType.BaseType;
              Idx2 := IndexOfType(TempType);
              if Idx2 > Idx then
              begin
                Idx := Idx2;
                AMoveReason := mrClassMemberAlias;
              end;
            end;
          end;

          { And index of base type }
          if (WSDLType.BaseType <> nil) then
          begin
            Idx2 := IndexOfType(WSDLType.BaseType);
            if Idx2 > Idx then
            begin
              Idx := Idx2;
              AMoveReason := mrClassBaseType;
            end;
          end;

          if Idx > I then
            MoveType(I, Idx, AMoveReason)
          else
            Inc(I);
        end;
      else
        Inc(I);
    end;
    Inc(Loop);
  end;
end;


procedure TWSDLImporter.DumpTypes;
const
  BooleanStr: array[Boolean] of string = ('N', 'Y');
var
  WSDLType: IWSDLType;
  I: Integer;
begin
  I := 0;
  for WSDLType in FWSDLTypes.Types do
  begin
    WriteFeedback('%d - "%s:%s" [%s] Used:%s, Kind:%s, Flag:%s'+sLineBreak, [I,
                             WSDLType.Name, WSDLType.Namespace,
                             SetToStr(TypeInfo(XMLItemInfo), Word(WSDLType.XMLItemInfo), False),
                             BooleanStr[WSDLType.IsUsed],
                             WSDLTypeKindStr[WSDLType.DataKind],
                             WSDLTypeFlagStr[WSDLType.TypeFlag]]);
    Inc(I);
  end;
end;

procedure TWSDLImporter.MungeTypes;

  procedure UpdateRef(AType: IWSDLType;
                      const OldType: IWSDLType;
                      const NewType: IWSDLType); overload;
  var
    I: Integer;
    WSDLPart: IWSDLPart;
  begin
    if AType.BaseType = OldType then
      AType.BaseType := NewType;
    for I := 0 to Length(AType.Members)-1 do
    begin
      WSDLPart := AType.Members[I];
      if WSDLPart.DataType = OldType then
        WSDLPart.DataType := NewType;
    end;
  end;

  procedure UpdateRef(PortType: IWSDLPortType;
                      const OldType: IWSDLType;
                      const NewType: IWSDLType); overload;
  var
    I, J: Integer;
    WSDLPart: IWSDLPart;
    Operation: IWSDLOperation;
  begin
    for I := 0 to Length(PortType.Operations)-1 do
    begin
      Operation := PortType.Operations[I];
      for J := 0 to Length(Operation.Parts)-1 do
      begin
        WSDLPart := Operation.Parts[J];
        if WSDLPart.DataType = OldType then
          WSDLPart.DataType := NewType;
      end;
    end;
  end;

  procedure PatchUnboundedPart(const WSDLPart: IWSDLPart; const InOperation: Boolean);
  var
    NewType: IWSDLType;
  begin
    if pfUnbounded in WSDLPart.PartFlags then
    begin
{$IFDEF MAP_UNBOUNDED_TO_ARRAY}
      if not (xtiFakeUnboundedType in WSDLPart.DataType.XMLItemInfo) then
      begin
        NewType := FWSDLTypes.GenArrayType(WSDLPart.DataType, False{InOperation});
        NewType.IsUsed := WSDLPart.DataType.IsUsed;
        WSDLPart.DataType := NewType;
      end;
{$ENDIF}
    end;
  end;

  function AliasOfClass(const WSDLType: IWSDLType; Unwind: Boolean = False): Boolean;
  begin
    if Unwind then
      Result := (WSDLType.DataKind = wtAlias) and (UnWindType(WSDLType).DataKind = wtClass)
    else
      Result := (WSDLType.DataKind = wtAlias) and (WSDLType.BaseType.DataKind = wtClass);
  end;

  function NeedsStrongAlias(const WSDLType: IWSDLType): Boolean;
  begin
    Assert(IsPureCollection(WSDLType));
    Result := WSDLType.Members[0].Name <> WSDLType.Members[0].DataType.Name;
  end;

  function IsCpp: Boolean;
  begin
    Result := (ifWriterHasWeakAliases in FImporterFlags);
  end;

  procedure ExpandAttributeGroups;
  var
    WSDLType: IWSDLType;
    WSDLPart, Part2: IWSDLPart;
    I: Integer;
  begin
    { Expand attributeGroups }
    for WSDLType in FWSDLTypes.Types do
    begin
      if WSDLType.DataKind = wtClass then
      begin
        for I := 0 to Length(WSDLType.Members)-1 do
        begin
          WSDLPart := WSDLType.Members[I];
          if WSDLPart.DataType.DataKind = wtAttrGroup then
          begin
            for Part2 in WSDLPart.DataType.Members do
            begin
              WSDLType.AddMember(Part2.Clone);
            end;
            WSDLType.RemoveMember(WSDLPart);
          end;
        end;
      end;
    end;
  end;

var
  MapArraysToClass: Boolean;
  EmptyParts: IWSDLPartArray;

{$DEFINE REGISTER_PURE_COLL_ELEM_INFO}
  procedure FixPureCollection(WSDLType: IWSDLType);
  var
    BaseType: IWSDLType;
    WSDLPart: IWSDLPart;
    ARegInfo: TRegInfoAttribute;
    NSInfo: InvString;
  begin
    { NOTE: Weak aliases can't use arrays for pure collections
            if the element name does not match that of the type }
    if (MapArraysToClass) or (WSDLType.BaseType <> nil)
{$IFNDEF REGISTER_PURE_COLL_ELEM_INFO}
       or
       ((ifWriterHasWeakAliases in FImporterFlags) and NeedsStrongAlias(WSDLType))
{$ENDIF}
       then
    begin
      WSDLType.Members[0].PartKind := pDefaultArray;
    end
    else
    begin
      WSDLPart := WSDLType.Members[0];
      { Type of array element }
      BaseType := WSDLPart.DataType;
      { NOTE: Here we don't want to lose element name/namespace before we collapse
              the Pure Collection to an array type
      }
      ARegInfo.Reset;
      if pfRef in WSDLPart.PartFlags then
        NSInfo := BaseType.Namespace
      else
        NSInfo := WSDLType.Namespace;
{$IFDEF REGISTER_PURE_COLL_ELEM_INFO}
      if WSDLPart.Name <> '' then
        ARegInfo.SetAttr(InfoAttribute.iaArrayItemName, WSDLPart.Name);
      if (NSInfo <> XMLSchemaNamespace) and
         (NSInfo <> WSDLType.Namespace) then
        ARegInfo.SetAttr(InfoAttribute.iaNamespace, NSInfo);
{$DEFINE XE_PATCH2}        
{$IFNDEF XE_PATCH2}
      if (BaseType.Namespace <> NSInfo) and
         (BaseType.Namespace <> XMLSchemaNamespace) then
        ARegInfo.SetAttr(InfoAttribute.iaArrayItemNamespace, BaseType.Namespace);
{$ELSE}
//      if (BaseType.Namespace <> XMLSchemaNamespace) then
//        ARegInfo.SetAttr(InfoAttribute.iaArrayItemNamespace, BaseType.Namespace);
{$ENDIF}
{$ENDIF}
      // Backward compatible approach where we created a brand new type
      // to encode the name/namespace (NOTE: Requires strong alias)
      if (wfCreateArrayElemTypeAlias in Global_WSDLGenFlags) and (WSDLPart.Name <> BaseType.Name) then
        BaseType := FWSDLTypes.GenAliasType(BaseType, WSDLPart.Name, WSDLType.Namespace);

      WSDLType.DataKind := wtArray;
      WSDLType.BaseType := BaseType;
      WSDLType.Dimensions := 1;
      WSDLType.Members := EmptyParts;
      if ARegInfo.HasAttr then
        WSDLType.RegInfo := ARegInfo.AsString(IsCpp);
    end;
  end;

  procedure MakeClassAliasAClass;
  var
    Found: Boolean;
    WSDLType, BaseType, BaseMostType: IWSDLType;
    BaseTypes: IWSDLTypeArray;
    Len: Integer;
    BaseTypesMsg: string;
    TempPart: IWSDLPart;
  begin
    { Make all class aliases classes - this works around the 'weak alias' issue
      with Delphi and C++, mostly C++ }
    repeat
      Found := False;
      for WSDLType in FWSDLTypes.Types do
      begin
        if (WSDLType.DataKind = wtAlias) and
           (WSDLType.BaseType.DataKind = wtClass) then
        begin
          Found := True;
          WSDLType.DataKind := wtClass;

          { Copy over typeflag that affects the base type of the underlying type }
          case WSDLType.TypeFlag of
            wfFault, wfHeader:
            begin
              SetLength(BaseTypes, 0);

              { Compute the base-most type and keep track of bases }
              BaseMostType := WSDLType.BaseType;
              while (BaseMostType.DataKind = wtClass) do
              begin
                Len := Length(BaseTypes);
                SetLength(BaseTypes, Len+1);
                BaseTypes[Len] := BaseMostType;
                if BaseMostType.BaseType = nil then
                  break;
                BaseMostType := BaseMostType.BaseType;
              end;

              { We pass the header flag to the base-most type if it's not tagged
                as something else }
              if WSDLType.TypeFlag = wfHeader then
              begin
                if BaseMostType.TypeFlag = wfNone then
                  BaseMostType.TypeFlag := WSDLType.TypeFlag;
              end;

              //FIXME - This is bad for exception hierarchies :(
              //FIXME 
              { For fault types we collapse the fault as we don't want to take
                the chance of switching a base type to ERemotableException if it's
                the base for non-exception types }
              if WSDLType.TypeFlag = wfFault then
              begin
                BaseTypesMsg := '';
                for Len:=Length(BaseTypes)-1 downto 0 do
                begin
                  { Log type and Copy over members }
                  BaseType := BaseTypes[Len];
                  BaseTypesMsg := Format('%s%s%s', [BaseTypesMsg,
                                                    Commas[Length(BaseTypesMsg)>0],
                                                    BaseType.Name]);
                  for TempPart in BaseType.Members do
                  begin
                    WSDLType.AddMember(TempPart.Clone());
                  end;
                end;

                { Disconnect derivation }
                WSDLType.BaseType := nil;
                WSDLType.AddNote(Format('Base Types: %s', [BaseTypesMsg]));
              end;
            end;
          end;
        end;
      end;
    until not Found;
  end;

  procedure RecordMemberRegInfo(WSDLType: IWSDLType);
  var
    WSDLPart: IWSDLPart;
    ARegInfo: TRegInfoAttribute;
    ComplexNS, PartNS: InvString;
  begin
    if WSDLType.DataKind in [wtClass, wtAttrGroup] then
    begin
      ComplexNS := WSDLType.Namespace;
      for WSDLPart in WSDLType.Members do
      begin
        ARegInfo.Reset;
        PartNS := WSDLPart.DataType.Namespace;
        if ((pfRef in WSDLPart.PartFlags) or
            ((WSDLPart.PartKind = pAttribute) and (PartNS <> ComplexNS))) and
           (PartNS <> XMLSchemaNamespace) and
           (not (WSDLPart.DataType.DataKind in [wtClass])) then
        begin
          ARegInfo.SetAttr(InfoAttribute.iaNamespace, PartNS);
          WSDLPart.RegInfo := ARegInfo.AsString(IsCpp);
        end;
      end;
    end;
  end;

var
  WSDLType: IWSDLType;
  WSDLPart: IWSDLPart;
  WSDLPortType : IWSDLPortType;
  WSDLOperation: IWSDLOperation;
  StrongClassAliases: Boolean;
begin
  SetLength(EmptyParts, 0);

  { Map alias of classes to derived class }
  StrongClassAliases := wfStrongClassAliases in Global_WSDLGenFlags;
  { Map Pure collections to class }
  MapArraysToClass := wfMapArraysToClasses in Global_WSDLGenFlags;

  { Inline <attributeGroup> references }
  ExpandAttributeGroups;

  { Handle pure collections}
  for WSDLType in FWSDLTypes.Types do
  begin
    { Map Pure collections to arrays }
    if IsPureCollection(WSDLType) then
      FixPureCollection(WSDLType)
    else
      RecordMemberRegInfo(WSDLType)
  end;

  { Make class aliases classes }
  if StrongClassAliases then
    MakeClassAliasAClass;

  { Check for unbounded elements }
  for WSDLType in FWSDLTypes.Types do
  begin
    if (WSDLType.DataKind = wtClass) then
    begin
      for WSDLPart in WSDLType.Members do
      begin
        PatchUnboundedPart(WSDLPart, False);
      end;
    end;
  end;

  { Check for unbounded parameters }
  for WSDLPortType in FWSDLPortTypes.PortTypes do
  begin
    for WSDLOperation in WSDLPortType.Operations do
    begin
      for WSDLPart in WSDLOperation.Parts do
      begin
        PatchUnboundedPart(WSDLPart, True);
      end;
    end;
  end;

  { Since we might have created new classes }
  ExpandAttributeGroups;
end;

procedure TWSDLImporter.ValidateModel;

  procedure ValidateMembers(const WSDLType: IWSDLType);
  var
    Member: IWSDLPart;
  begin
    for Member in WSDLType.Members do
    begin
      Assert(Member.DataType <> nil,
             Format('Invalid member %s::%s - with nil datatype', [WSDLType.Name, Member.Name]));
      Assert(not IsPrefixed(Member.Name),
             Format('Suspicious prefixed member name: "%s:%s"', [WSDLType.Name, Member.Name]));
    end;
  end;

  procedure ValidateType(const WSDLType: IWSDLType);
  begin
    if (WSDLType.DataKind = wtAlias) or (WSDLType.DataKind = wtArray) then
    begin
      Assert(WSDLType.BaseType <>  nil,
             Format('Invalid Type (%s:%s) of type (%s) with nil basetype',
                    [WSDLType.Name, WSDLType.Namespace, WSDLTypeKindStr[WSDLType.DataKind]]));
    end;
    ValidateMembers(WSDLType);
  end;

var
  WSDLType: IWSDLType;
  WSDLPort: IWSDLPortType;
  WSDLOperation: IWSDLOperation;
  WSDLPart: IWSDLPart;
begin
  { Validate Types }
  for WSDLType in FWSDLTypes.Types do
  begin
    ValidateType(WSDLType);
  end;

  { Validate Port Types }
  for WSDLPort in FWSDLPortTypes.PortTypes do
  begin
    for WSDLOperation in WSDLPort.Operations do
    begin
      for WSDLPart in WSDLOperation.Parts do
      begin
        Assert(WSDLPart.DataType <> nil,
               Format('Invalid part %s::%s(%s) with invalid nil datatype',
                      [WSDLPort.Name, WSDLOperation.Name, WSDLPart.Name]));
      end;
    end;
  end;
end;


procedure TWSDLWriter.MapTypes(const WSDLTypeArray: IWSDLTypeArray);
var
  I: integer;
  NewName: DOMString;
  WSDLType: IWSDLType;
begin
  for I := 0 to Length(WSDLTypeArray)-1 do
  begin
    { Here we map the XMLType to a native type }
    WSDLType := WSDLTypeArray[I];

    { But only if we don't already have a langName }
    if WSDLType.Name = WSDLType.LangName then
    begin
      NewName := GetDataType(WSDLType);
      if NewName <> WSDLType.Name then
        WSDLType.LangName := NewName;
    end;

    { Here we handle predefined native types }
    { The following logic may not be safe: For backwards compatibility
      we handle 'urn:Types' but that's not a very unique ns?? }
    if ((WSDLType.Namespace = sBorlandTypeNamespace) or
        (WSDLType.Namespace = 'urn:Types')) and   { Do not localize }
       (WSDLType.Name = WSDLType.LangName) then
    begin
      WSDLType.DataKind := wtNotDefined;
    end;
  end;
end;

procedure TWSDLWriter.ValidateTypes(const WSDLTypeArray: IWSDLTypeArray);
var
  TypeNames : TStringHash;

  { Returns whether this identifier has been used already }
  function IdentifierOK(const Name: DOMString): boolean;
  begin
    if IsCaseSensitive then
      Result := TypeNames.ValueOf(Name) = -1
    else
      Result := TypeNames.ValueOf(UpperCase(Name)) = -1;
  end;

  { Tweak until we have a valid name  - then insert it }
  procedure InsertName(Item: IWSDLItem; const Suffix: DOMString = '');
  var
    X: Integer;
    NewName: DOMString;
    HasSuffix: Boolean;
  begin
    if not IdentifierOK(Item.LangName) then
    begin
      HasSuffix := Suffix <> '';
      { Look for non-conflicting name - start with suffix }
      if HasSuffix then
        Item.LangName := Item.LangName + Suffix;
      if (HasSuffix = False) or (IdentifierOK(Item.LangName) = False) then
      begin
        X := 1;
        repeat
          Inc(X);
          NewName := Item.LangName + IntToStr(X);
        until IdentifierOK(NewName);
        Item.LangName := NewName;
      end;
    end;
    if IsCaseSensitive then
      TypeNames.Add(Item.LangName, 1)
    else
      TypeNames.Add(UpperCase(Item.LangName), 1);
  end;

  procedure ClearNameList;
  begin
    TypeNames.Clear;
  end;

var
  Pass: Integer;
  I, J, Len: integer;
  WSDLType: IWSDLType;
  Enum: IWSDLItem;
  Siblings, MemberTypes: TDOMStrings;
  Member: IWSDLPart;
begin
  { Validate names first }
  TypeNames := TStringHash.Create(1024);
  try
    { First add all enum members into the global namespace }
    for I := 0 to Length(WSDLTypeArray)-1 do
    begin
      WSDLType := WSDLTypeArray[I];

      { Skip unused types }
      if SkipType(WSDLType) then
        continue;

      { NOTE: With scoped enumeration, there's no need to validate
              members of all enumeration - just the members of each
              enumeration }
      if (wfValidateEnumMembers in Global_WSDLGenFlags) then
      begin
        if WSDLType.DataKind = wtEnumeration then
        begin
          if (wfUseScopedEnumeration in Global_WSDLGenFlags) then
            ClearNameList;
          Len := Length(WSDLType.EnumValues);
          for J := 0 to (Len-1) do
          begin
            Enum := WSDLType.EnumValues[J];

            { Validate enum member }
            ValidateName(Enum);

            { Insert name in namespace?? }
            InsertName(Enum);
          end;
        end;
      end;
    end;

    { Validate Types }
    for Pass := 0 to 1 do
    begin
      for I := 0 to Length(WSDLTypeArray)-1 do
      begin
        WSDLType := WSDLTypeArray[I];

        { We don't care for these two types since we don't generate code for them }
        if (WSDLType.DataKind = wtNotDefined) or
           (WSDLType.DataKind = wtDuplicate) then
          continue;

        { Skip unused types }
        if SkipType(WSDLType) then
          continue;

        { Handle global elements on first pass, then rest in second }
        if ((Pass = 0) and
           ((WSDLType.XMLItemInfo * [xtiGlobal, xtiElement]) <> [xtiGlobal, xtiElement]))
           or
           ((Pass = 1) and
           ((WSDLType.XMLItemInfo * [xtiGlobal, xtiElement]) = [xtiGlobal, xtiElement])) then
          continue;

        { Validate the type name itself}
        ValidateName(WSDLType);

        { Validate name of members }
        if WSDLType.DataKind = wtClass then
        begin
          Siblings := TDOMStrings.Create;
          MemberTypes := nil;
          try
            if RemapMembersOfTypeName then
            begin
              MemberTypes := TDOMStrings.Create;
              for J :=0 to Length(WSDLType.Members)-1 do
                MemberTypes.Add(WSDLType.Members[J].DataType.LangName);
            end;

            for J:= 0 to Length(WSDLType.Members)-1 do
            begin
              Member := WSDLType.Members[J];
              ValidatePart(Member);
              ValidateName(Member, Siblings, J, MemberTypes);
              Siblings.Add(Member.LangName);
              Siblings.Add('F'+Member.LangName);
            end;
          finally
            MemberTypes.Free;
            Siblings.Free;
          end;
        end;

        { Now validate in context of other types }
        InsertName(WSDLType);
      end;
    end;
  finally
    TypeNames.Free;
  end;

  { Next, if a type is based on a duplicate type, unwind to its basetype }
  for I := 0 to Length(WSDLTypeArray)-1 do
  begin
    WSDLType := WSDLTypeArray[I];
    if (WSDLType.DataKind = wtAlias) or
       (WSDLType.DataKind = wtArray) then
    begin
                                                                       
      while (WSDLType.BaseType.DataKind = wtDuplicate) do
        WSDLType.BaseType := WSDLType.BaseType.BaseType;
    end;
  end;
end;


function SetToStr(TypeInfo: PTypeInfo; Value: Integer; Opts: SetToStrOpts): string;
var
  S: TIntegerSet;
  I: Integer;
  useCommas, useBrackets, useInsertionOp: Boolean;
begin
  useCommas := stsComma in Opts;
  useBrackets:= stsBrackets in Opts;
  useInsertionOp := stsInsertion in Opts;

  Result := '';
  Integer(S) := Value;
  for I := 0 to SizeOf(Integer) * 8 - 1 do
    if I in S then
    begin
      if UseInsertionOp then
        Result := '<< ' + Result;
      if UseCommas and (Result <> '') then
        Result := Result + ',';
      Result := Result + GetEnumName(TypeInfo, I);
    end;
  if useBrackets then
    Result := '[' + Result + ']';
end;

function SetToStr(TypeInfo: PTypeInfo; Value: Integer; Brackets: Boolean): string;
const
  stsOpt: array[boolean] of SetToStrOpt = (stsUnused, stsBrackets);
begin
  Result := SetToStr(TypeInfo, Value, [stsComma, stsOpt[Brackets]]);
end;

procedure TWSDLWriter.WriteWSDLInfo;

  function GetNonDefaultOptionsString: string;
  const
    MinusPlus : array[boolean] of string = ('+', '-');
  var
    Flag: WSDLGenFlags;
  begin
    Result := '';
    for Flag := Low(WSDLGenFlags) to High(WSDLGenFlags) do
    begin
      if ((Flag in Default_WSDLGenFlags) and (not (Flag in Global_WSDLGenFlags))) or
         ((Flag in Global_WSDLGenFlags) and (not (Flag in Default_WSDLGenFlags))) then
      begin
        if Result <> '' then
          Result := Result + ', ';
        Result := Format('%s%s%s', [Result,
                                    GetEnumName(TypeInfo(WSDLGenFlags), Integer(Flag)),
                                    MinusPlus[Flag in Default_WSDLGenFlags]]);;
      end;
    end;
    Result := '['+Result+']';
  end;

  function GetImporterOptions: string;
  const
    WSDLImporterOptsStr: array[WSDLImporterOpts] of string =(
                                    'DataModule',
                                    'Doc-style',
                                    'Lit-use',
                                    'Opt',
                                    'Unbnd',
                                    'Nilbl',
                                    'Unql',
                                    'Attr',
                                    'Text',
                                    'Any',
                                    'Ref',
                                    'Qual',
                                    'Out'
                                );
    Commas: array[boolean] of string = ('', ', ');
  var
    Opt: WSDLImporterOpts;
  begin
    Result := '';
    for Opt := Low(WSDLImporterOpts) to High(WSDLImporterOpts) do
      if Opt in FWSDLImporter.Options then
        Result := Format('%s%s%s', [Result,
                                    Commas[Length(Result)>0],
                                    WSDLImporterOptsStr[Opt]]);
  end;

var
  I: Integer;
begin
  WriteFmt(sWSDLInfoBeg, [FWSDLImporter.FileName]);
  if FWSDLImporter.ImportList.Count > 1 then
  begin
    for I := 1 to (FWSDLImporter.ImportList.Count-1) do
      WriteFmt(sImportInfo, [FWSDLImporter.ImportList[I]]);
  end;
  if (FWSDLImporter.Encoding <> '') then
    WriteFmt(sEncodingInfo, [FWSDLImporter.Encoding]);
  if (Default_WSDLGenFlags <> Global_WSDLGenFlags) then
    WriteFmt(sGenOptions, [GetNonDefaultOptionsString]);
  if (FWSDLImporter.Version <> '') then
    WriteFmt(sVersionInfo, [FWSDLImporter.Version]);

  { Not emitting the date and version makes it easier to compare
    changes in the importer when running it on tens of WSDLs
    between changes made to the importer }
  if NoDateStamp then
    WriteFmt(sWSDLInfoEnd, ['', GetImporterOptions()])
  else
    WriteFmt(sWSDLInfoEnd, [DateTimeToStr(Now), RevString]);
end;

procedure TWSDLWriter.WriteComplexClassInfo(const WSDLType: IWSDLType);

  { Returns string that provides info about XML Item Info }
  function GetXMLTypeInfo(const WSDLType: IWSDLType): string;
  var
    Item: XMLItemInfo;
    Info: TXMLItemInfo;
  begin
    Result := WSDLType.Name;
    Info := WSDLType.XMLItemInfo;
    for Item := Low(XMLItemInfo) to High(XMLItemInfo) do
    begin
      if Item in Info then
      begin
        Result := Result + ', ';
        Result := Result + XMLItemInfoComment[Item];
      end;
    end;
  end;

{$IFNDEF SPACELY_UP}
{ This string cannot be introduced in the resource string for the hotfix.
  Remedy after the hotfix }
const
  sXMLInfo =   '// XML       : %s';  { Do not localize }
{$ENDIF}

var
  InfoStr: String;
  SerialOpts: TSerializationOptions;
begin
  InfoStr := '';
  WriteStr(sLineBreak+sLineBreak);
  WriteLn(TypeInfoPad + sInfoBeg);
  { XML Info }
  InfoStr := GetXMLTypeInfo(WSDLType);
  WriteLn(TypeInfoPad + sXMLInfo, [InfoStr]);
  { Namespace }
  WriteLn(TypeInfoPad + sNamespaceInfo, [WSDLType.Namespace]);
  { Serialization Options }
  SerialOpts := WSDLType.SerializationOpt;
  InfoStr := SetToStr(TypeInfo(SerializationOptions),
                         Integer(SerialOpts), False);
  if InfoStr <> '' then
    WriteLn(TypeInfoPad + sSerialization, [InfoStr]);

  { TypeFlag }
  if (WSDLType.TypeFlag <> wfNone) then
    WriteLn(TypeInfoPad + sBindInfoGeneric, [WSDLTypeFlagStr[WSDLType.TypeFlag]]);

  for InfoStr in WSDLType.Notes do
  begin
    WriteLn(TypeInfoPad + Format(sLineComment, [InfoStr]));
  end;

  WriteStr(TypeInfoPad+ sInfoEnd);
end;

procedure TWSDLWriter.WritePredefinedInfo;
begin
  WriteLn(TypeInfoPad + sInfoBeg);
  WriteFmt(sPredefinedInfo, [TypeInfoPad]);
  WriteStr(TypeInfoPad+ sInfoEnd);
end;

procedure TWSDLWriter.WriteInterfaceInfo(const WSDLPortType: IWSDLPortType);
  procedure WriteData(const key, value: DOMString);
  begin
    if value <> '' then
      WriteLn(TypeInfoPad + key, [value]);
  end;
begin
  WriteLn(sLineBreak + TypeInfoPad + sInfoBeg);
  if WSDLPortType.Name <> WSDLPortType.LangName then
    WriteData(sExternalName, WSDLPortType.Name);
  WriteData(sNamespaceInfo, WSDLPortType.Namespace);

  { SoapAction }
  if WSDLPortType.HasDefaultSOAPAction or
     (WSDLPortType.HasAllSOAPActions and (Length(WSDLPortType.SOAPAction) < 1023)) then
    WriteData(sSOAPActionInfo, WSDLPortType.SOAPAction);

  WriteData(sTransportInfo, WSDLPortType.Transport);
  WriteData(sStyleInfo, WSDLPortType.Style);
  WriteData(sUseInfo, WSDLPortType.Use);
  WriteData(sBindingInfo, WSDLPortType.Binding);
  WriteData(sServiceInf, WSDLPortType.Service);
  WriteData(sPortInfo, WSDLPortType.Port);
  WriteData(sURLInfo, WSDLPortType.URL);
  WriteStr(TypeInfoPad+ sInfoEnd);
end;

procedure TWSDLWriter.WriteIntf;
begin
  if DebugMode then
    WriteDebug;

  if not (wfSelectiveCodeGen in Global_WSDLGenFlags) then
  begin
    WriteIntfHeader;
    WriteForwards;
  end;

  WriteTypes;
  WriteInterfaces;

  if not HasSource then
  begin
    if not (wfSelectiveCodeGen in Global_WSDLGenFlags) then
    begin
      WriteImplHeader;
      WriteImplementations;
      WriteRegCalls;
    end;
  end;

  if not (wfSelectiveCodeGen in Global_WSDLGenFlags) then
  begin
    WriteIntfFooter;
  end;
end;

function TWSDLWriter.EmitIndexMacros(out Opts: TWSDLImporterOpts;
                                     FlagOut: Boolean): Boolean;

  procedure CheckForOuts;
  var
    WSDLPortType: IWSDLPortType;
    WSDLOperation: IWSDLOperation;
    WSDLPart: IWSDLPart;
  begin
    Result := False;
    for WSDLPortType in FWSDLImporter.GetPortTypes do
    begin
      for WSDLOperation in WSDLPortType.Operations do
      begin
        for WSDLPart in WSDLOperation.Parts do
        begin
          if WSDLPart.PartKind = pOut then
          begin
            Opts := Opts + [woHasOut];
            Exit;
          end;
        end;
      end;
    end;
  end;

var
  EncodedMode: Boolean;
begin
  Opts := [];
  { NOTE: In Encoded mode we should ignore attributes. However, for
          backwards compatibility, we'll look at attributes as we
          did before. }
  Result := (woHasAttribute in FWSDLImporter.Options);
  if Result then
    Opts := [woHasAttribute];
  if FlagOut then
    CheckForOuts;
  EncodedMode := not (woHasLiteralUse in FWSDLImporter.Options);
  if EncodedMode then
    Opts := Opts + (FWSDLImporter.Options * [woHasOptionalElem, woHasUnboundedElem])
  else
    Opts := Opts + (FWSDLImporter.Options - [woHasSOAPDM, woHasDocStyle, woHasLiteralUse]);
  Result := Opts <> [];
end;

function TWSDLWriter.HasIndexDecl(const Member: IWSDLPart; FlagOut: Boolean): Boolean;
var
  EncodedMode: Boolean;
begin
  { NOTE: In Encoded mode we should ignore attributes. However, for backwards compatibility,
          we'll look at attributes as we did before. }
  Result := (Member.PartKind = pAttribute);
  if (not Result) and FlagOut then
    Result := (Member.PartKind = pOut);
  if not Result then
  begin
    EncodedMode := not (woHasLiteralUse in FWSDLImporter.Options);
    if EncodedMode then
      Result := ((pfOptional in Member.PartFlags) or (pfUnbounded in Member.PartFlags))
    else
      Result := Member.PartFlags <> [];
  end;
end;

function TWSDLWriter.HasIndexDecl(const Member: IWSDLPart;
                                  out Flags: TPartFlag;
                                  out IsAttr: Boolean;
                                  FlagOut: Boolean): Boolean;
var
  ReportOut: Boolean;
begin
  Flags := [];
  ReportOut := False;
  { NOTE: In EncodedMode mode we should ignore attributes. However, for backwards compatibility,
          we'll look at attributes as we did before. }
  IsAttr := Member.PartKind = pAttribute;
  if FlagOut and (Member.PartKind = pOut) then
    ReportOut := True;
  if (woHasLiteralUse in FWSDLImporter.Options) then
    Flags := Member.PartFlags
  else
  begin
    if pfOptional in Member.PartFlags then
      Flags := Flags + [pfOptional];
    if pfUnbounded in Member.PartFlags then
      Flags := Flags + [pfUnbounded];
  end;
  Result := ReportOut or IsAttr or (Flags <> []);
end;

function TWSDLWriter.HasInfoAboutMethod(const WSDLOperation: IWSDLOperation): Boolean;
begin
  Result := (Length(WSDLOperation.Headers) > 0) or
            (Length(WSDLOperation.Faults) > 0) or
            ((WSDLOperation.CannotUnwrap <> []) and (wfUnwindLiteralParameters in Global_WSDLGenFlags));
end;

function TWSDLWriter.GetMethodInfo(const WSDLOperation: IWSDLOperation): string;
const
  sComma: array[Boolean] of string = ('', ', ');
  sRequired: array[Boolean] of string=('', '!');
  sMethodComment         = '    // %s: ';
  sMethodCommentIndent   = '    //     - %s';
  sMethodCommentLF       = sMethodComment + sLineBreak;
  sMethodCOmmentIndentLF = sMethodCommentIndent + sLineBreak;
  sHeaderFmt = '%s%s:%s%s';
var
  CU: CannotUnwrap;
  Part: IWSDLPart;
  FirstPass: Boolean;
begin
  Result :='';
  // Cannot Unwrap operation!
  if (WSDLOperation.CannotUnwrap <> []) and (wfUnwindLiteralParameters in Global_WSDLGenFlags) then
  begin
    Result := Result + Format(sMethodCommentLF, [sCouldNotUnwrapDocLitElementWrapper]);
    for CU := Low(CannotUnwrap) to High(CannotUnwrap) do
    begin
      if CU in WSDLOperation.CannotUnwrap then
      begin
        Result := Result + Format(sMethodCommentIndentLF, [CannotUnwrapStr[CU]]);
      end;
    end;
  end;

  // Headers
  FirstPass := True;
  if (Length(WSDLOperation.Headers) > 0) then
  begin
    Result := Result + Format(sMethodComment, [sMethodHeaders]);
    for Part in WSDLOperation.Headers do
    begin
      Result := Result + Format(sHeaderFmt, [sComma[not FirstPass], Part.Name,
                                             PartTypeStr[Part.PartKind],
                                             sRequired[Part.Required]]);

      FirstPass := False;
    end;
    Result := Result + sLineBreak;
  end;

  { Insert an empty line }
  if Result <> '' then
    Result := sLineBreak + Result;
end;

function TWSDLWriter.HasSource: Boolean;
begin
  Result := False;
end;

function TWSDLWriter.IsCaseSensitive: Boolean;
begin
  Result := True;
end;

{ Writers that have special requirements for filenames can override this method }
procedure TWSDLWriter.SetDirectory(const Directory: String);
begin
  FDirectory := Directory;
end;

procedure  TWSDLWriter.SetRelHeaderDir(const RelDir: string);
begin
  FRelHeaderDir := RelDir;
end;

procedure TWSDLWriter.SetOutFile(const outFile: string; CheckProject: Boolean);
begin
  FOutFile := outFile;
end;

function TWSDLWriter.RemapMembersOfTypeName: boolean;
begin
  Result := False;
end;

function TWSDLWriter.IntfExt: DOMString;
begin
  Result := '.xxx';
end;


{ NOTE: This routine must be overriden by a TWSDLWriter-derived class that
        support source }
procedure TWSDLWriter.WriteSource;
begin
end;

{ NOTE: This routine must be overriden by a TWSDLWriter-derived class -
        The default implementation is strictly for testing purposes }
procedure TWSDLWriter.WriteIntfHeader;
begin
end;

type
  ICheapXMLWriter = interface
    procedure Write(const Fmt: string;  const Args: array of const);
  end;

  ITextFile = interface
    procedure Write(const Fmt: string; const Args: array of const);
  end;

  TCheapTextFile = class(TInterfacedObject, ITextFile)
  private
    TheFile: TextFile;
  public
    constructor Create(FileName: String);
    destructor Destroy; override;
    procedure Write(const Fmt: string; const Args: array of const);
  end;

  TCheapXMLWriter = class(TInterfacedObject, ICheapXMLWriter)
  private
    FTextFile: ITextFile;
    FElem: String;
  public
    constructor Create(TextFile: ITextFile; Elem: String; const Attr: array of String); overload;
    constructor Create(TextFile: ITextFile; Elem: String); overload;
    destructor Destroy; override;
    procedure Write(const Fmt: string; const Args: array of const);
  end;

{ TCheapXMLWriter }

constructor TCheapXMLWriter.Create(TextFile: ITextFile; Elem: String; const Attr: array of String);
var
  Len, I: Integer;
  Key, Val: String;
begin
  FTextFile := TextFile;
  FElem := Elem;
  Len := Length(Attr);
  if Len = 0 then
    Write('<%s>', [FElem])
  else
  begin
    Write('<%s', [FElem]);
    I := 0;
    while (Len >= I+2) do
    begin
      Key := Attr[I];
      Inc(I);
      Val := Attr[I];
      Inc(I);
      if (Key <> '') then
        Write(' %s="%s"', [Key, Val]);
    end;
    Write('>', []);
  end;
  Write(sLineBreak, []);
end;

constructor TCheapXMLWriter.Create(TextFile: ITextFile; Elem: String);
begin
  Create(TextFile, Elem, []);
end;

destructor TCheapXMLWriter.Destroy;
begin
  Write('</%s>' + sLineBreak, [FElem]);
  FTextFile := nil;
end;

procedure TCheapXMLWriter.Write(const Fmt: string;  const Args: array of const);
begin
  FTextFile.Write(Fmt, Args);
end;

{ TCheapTextFile }

constructor TCheapTextFile.Create(FileName: String);
begin
  System.Assign(TheFile, FileName);
  System.Rewrite(TheFile);
end;

destructor TCheapTextFile.Destroy;
begin
  System.Close(TheFile);
end;

procedure TCheapTextFile.Write(const Fmt: string; const Args: array of const);
begin
  System.Write(TheFile, Format(Fmt, Args));
end;

function GetXMLItemInfoString(ItemInfo: TXMLItemInfo): String;
var
  Item: XMLItemInfo;
begin
  Result := '';
  for Item:= Low(XMLItemInfo) to High(XMLItemInfo) do
  begin
    if Item in ItemInfo then
    begin
      if Length(Result) > 0 then
        Result := Result + ', ';
      Result := Result + XMLItemInfoStr[Item];
    end;
  end;
end;

procedure WriteXMLLog(OuputFile: String; SchemaFilename: String; Types: IWSDLTypeArray);
var
  Namespaces: TDOMStrings;

  function GetShortenedNamespace(const NS: DOMString): DOMString;
  var
    Index: Integer;
  begin
    Index := Namespaces.IndexOf(NS);
    if (Index = -1) then
      Index := Namespaces.Add(NS);
    Result := 'NS' + IntToStr(Index);
  end;

  function GetQualifiedName(const WSDLType: IWSDLType): DOMString;
  begin
    Result := GetShortenedNamespace(WSDLType.Namespace) + ':' + WSDLType.Name;
  end;

const
  sWSDLImpTag = 'WSDLImpLog';
  sTypesTag   = 'types';
  sTypeTag    = 'type';
  sFileAttr   = 'file';
  sCountAttr  = 'count';
  sNameAttr   = 'name';
  sNamespace  = 'namespace';
  sKindAttr   = 'kind';
  sXMLAttr    = 'xml';
  sBaseAttr   = 'base';
  sUsedAttr   = 'used';
  sFlagAttr   = 'flag';
var
  DebugFile: ITextFile;
  Count, I: Integer;
  Writer, TypesWriter, InfoWriter: ICheapXMLWriter;
  WSDLType: IWSDLType;
  BaseKey, BaseName: String;
  W: DOMString;
begin
  Count := Length(Types);
  DebugFile := TCheapTextFile.Create(OuputFile);
  Writer := TCheapXMLWriter.Create(DebugFile, sWSDLImpTag, [sFileAttr, SchemaFilename]);
  TypesWriter := TCheapXMLWriter.Create(DebugFile, sTypesTag, [sCountAttr, IntToStr(Count)]);
  Namespaces := TDOMStrings.Create;
  try
    for I := 0 to Count-1 do
    begin
      WSDLType := Types[I];
      if (WSDLType.BaseType <> nil) then
      begin
        BaseKey := sBaseAttr;
        BaseName := GetQualifiedName(WSDLType.BaseType);
      end
      else
      begin
        BaseKey := '';
        BaseName:= '';
      end;
      InfoWriter := TCheapXMLWriter.Create(DebugFile, sTypeTag, [
                                           sNameAttr, GetQualifiedName(WSDLType),
                                           sKindAttr, WSDLTypeKindStr[WSDLType.DataKind],
                                           BaseKey, BaseName,
                                           sUsedAttr, NoYes[WSDLType.IsUsed]
{$IFDEF SHOW_XML_INFO}
                                           ,
                                           sXMLAttr, GetXMLItemInfoString(WSDLType.XMLItemInfo)
{$ENDIF}
                                           ]);
      if (InfoWriter <> nil) then
      begin
        { Nested Log Elements Here }
      end;
      InfoWriter := nil;
    end;
    for I := 0 to Namespaces.Count-1 do
    begin
      W := Namespaces[I];
      InfoWriter := TCheapXMLWriter.Create(DebugFile, sNamespace, [GetShortenedNamespace(W), W]);
      InfoWriter := nil;
    end;
  finally
    Namespaces.Free;
  end;
end;

procedure TWSDLWriter.WriteDebug;

  { Sort Types by name }
  procedure SlowSort(var Types: IWSDLTypeArray);
  var
    I, J, Len: Integer;
    Item: IWSDLType;
  begin
    Len := Length(Types);
    for I := 0 to Len-1 do
    begin
      for J := I to Len-1 do
      begin
        if (Types[I].Name > Types[J].Name) then
        begin
          Item := Types[I];
          Types[I] := Types[J];
          Types[J] := Item;
        end;
      end;
    end;
  end;

{$IFNDEF SPACELY_UP}
 { These constants cannot be introduced to the resource string for the HOTFIX
   since we won't be relocalizing for the HOTFIX.
   Remedy after HOTFIX }
const
  sFeedbackDebug     = '(Debug): %s';
{$ENDIF}

var
  Count: Integer;
  FileName: String;
  Types: IWSDLTypeArray;
begin
  FileName := FDirectory + ChangeFileExt(FWSDLImporter.GetOutFile, '.xml');
  WriteFeedback(sFeedbackDebug+sLineBreak, [FileName]);

  Types := Copy(FWSDLImporter.GetTypes);
  Count := Length(Types);
  if (Count > 0) then
  begin
    SlowSort(Types);
    WriteXMLLog(FileName, FWSDLImporter.FileName, Types);
  end;
end;

procedure TWSDLWriter.WriteEnumPrologue;
begin
  {Nothing to do}
end;

procedure TWSDLWriter.WriteEnumEpilogue;
begin
  {Nothing to do}
end;

procedure TWSDLWriter.WriteForwards;
var
  I: Integer;
begin
  if (Verbose) then
  begin
    if TypeCount([wtNotDefined, wtDuplicate]) > 0 then
    begin
      WritePredefinedInfo;
      WriteTypes([ptForwardDecl], [wtNotDefined, wtDuplicate]);
      WriteLn('');
    end;
  end;

  if (wfGenerateWarnings in Global_WSDLGenFlags) then
  begin
    if Assigned(FWSDLImporter.WarningList) then
    begin
      if FWSDLImporter.WarningList.Count > 0 then
      begin
        WriteLn(sWarningInfoBegin, [TypeInfoPad]);
        for I := 0 to FWSDLImporter.WarningList.Count-1 do
          WriteLn(sWarningInfo, [TypeInfoPad, FWSDLImporter.WarningList[I]]);
        WriteLn(sWarningInfoEnd+sLineBreak, [TypeInfoPad]);
      end;
    end;
  end;

  if (WriteTypes([ptForwardDecl], [wtClass, wtAttrGroup]) > 0) then
    WriteLn('');
end;

function TWSDLWriter.TypeCount(const TypeKinds: TWSDLTypeKind): Integer;
var
  TypeArray: IWSDLTypeArray;
  I: integer;
begin
  Result := 0;
  TypeArray := FWSDLImporter.GetTypes;
  for I := 0 to Length(TypeArray)-1 do
  begin
    if (TypeArray[I].DataKind in TypeKinds) then
      Inc(Result);
  end;
end;


function GetWSDLTypeInfo(const WSDLType: IWSDLType): DOMString;
const
  UsedString: array[Boolean] of string = ('[!U]', ''); { Do not localize }
  TypeString: array[WSDLTypeFlag] of string = ('', '[Lit]','[Flt]', '[Hdr]', '[A]'); {Do not localize }
  XTIString: array[XMLItemInfo] of string = ('Gbl', 'Pred', 'Elm', 'Cplx', 'Smpl', 'Attr', 'AtGp', 'Grp', 'Ubnd', 'Alias', 'Nlbl', 'Mxd'); { Do not localize }

  function GetXMLItemInfoCode(Info: TXMLItemInfo): string;
  var
    I: XMLItemInfo;
  begin
    Result := '';
    for I := Low(XMLItemInfo) to High(XMLItemInfo) do
    begin
      if I In Info then
        Result := Result + XTIString[I];
    end;
  end;

begin
  Result := Format('"%s"%s%s[%s]', [WSDLType.Namespace, { Do not localize }
                                    UsedString[WSDLType.IsUsed],
                                    TypeString[WSDLType.TypeFlag],
                                    GetXMLItemInfoCode(WSDLType.XMLItemInfo)])
end;


function TWSDLWriter.GetTypeInfo(const WSDLType: IWSDLType): DOMString;
begin
  if Verbose then
    Result := GetWSDLTypeInfo(WSDLType)
  else
    Result := '';
end;

function TWSDLWriter.GenIndexedSpecifiedSupport(
  const Member: IWSDLPart): Boolean;
begin
  Result := HasIndexDecl(Member) and GenSpecifiedSupport(Member);
end;

function TWSDLWriter.GenSpecifiedSupport(const Member: IWSDLPart): Boolean;
begin
  Result := HasIndexDecl(Member) and
            (wfProcessOptionalNillable in Global_WSDLGenFlags) and
            (pfOptional in Member.PartFlags);
end;

function TWSDLWriter.GetBaseClassName(const WSDLType: IWSDLType): string;
begin
  case WSDLType.TypeFlag of
    wfLiteralParam:
      Result := 'TRemotable';
    wfHeader:
      Result := 'TSOAPHeader';
    wfFault:
      Result := 'ERemotableException';
    else
      Result := 'TRemotable';
  end;
end;

function TWSDLWriter.IsComplex(const WSDLType: IWSDLType): boolean;
var
  WType: IWSDLType;
begin
  WType := UnwindType(WSDLType);

  Result := (WType.DataKind = wtClass) or
             ((WType.TypeInfo <> nil) and
              (WType.TypeInfo.Kind = tkClass));
end;

function TWSDLWriter.IsComplexArray(const WSDLType: IWSDLType): boolean;
var
  MemType: IWSDLType;
begin
  Result := False;
  MemType := UnwindType(WSDLType);
  if (MemType.DataKind = wtArray) then
  begin
    MemType := UnwindType(MemType.BaseType);
    Result := IsComplex(MemType);
  end;
end;

function  TWSDLWriter.SkipType(const WSDLType: IWSDLType; SkipAll: Boolean = False): Boolean;
begin
  Result := FWSDLImporter.SkipType(WSDLType, SkipAll);
end;

function TWSDLWriter.WriteTypes: integer;
var
  I: integer;
begin
  { Only write enumeration first }
  Result := WriteTypes([ptTypeDecl], [wtEnumeration]);
  { Now write everything else - except for things we've already written }
  I := WriteTypes([ptTypeDecl], [], [wtEnumeration, wtNotDefined, wtDuplicate]);
  Result := Result + I;
end;

function TWSDLWriter.WriteTypes(PassType: TPassWriterType;
                                const TypeKinds: TWSDLTypeKind;
                                const ExcludeKinds: TWSDLTypeKind): Integer;
var
  TypeArray: IWSDLTypeArray;
  WSDLType: IWSDLType;
  I: integer;
begin
  Result := 0;
  TypeArray := FWSDLImporter.GetTypes;
  for I := 0 to Length(TypeArray)-1 do
  begin
    WSDLType := TypeArray[I];

    { Check if we're in selective codegen mode }
    if (wfSelectiveCodeGen in Global_WSDLGenFlags) and
        not WSDLType.Selected then
      continue;

    if ((TypeKinds = []) or (WSDLType.DataKind in TypeKinds)) and
       ((ExcludeKinds=[])or not (WSDLType.DataKind in ExcludeKinds)) then
    begin
{$IFDEF LOG_TYPES_WRITING}
      WriteFeedback(sWritingType+sLineBreak, [WSDLType.Name]);
{$ENDIF}

      { ================================================================
        The following logic relies on the fact that all enumerations
        are emitted at once. IOW, enumerations don't have dependencies
        on other types - so they are emitted shortly after forward
        declarations
        ----------------------------------------------------------------- }
      { Enum prologue }
      if (not WritingEnums) and (WSDLType.DataKind = wtEnumeration) then
      begin
        WritingEnums := True;
        WriteEnumPrologue();
      end;

      { Enum Epilogue }
      if WritingEnums and (WSDLType.DataKind <> wtEnumeration) then
      begin
        WritingEnums := False;
        WriteEnumEpilogue();
      end;

      { Write type }
      WriteTypeDecl(WSDLType, PassType);
      Inc(Result);
    end;
  end;
end;

procedure TWSDLWriter.WriteTypeDecl(const WSDLType: IWSDLType; PassType: TPassWriterType);
begin
  if SkipType(WSDLType) then
    Exit;

  case WSDLType.DataKind of
    wtNotDefined:
      WriteLn(TypeInfoPad + sPredefinedTypes, [WSDLType.Name, GetWSDLTypeInfo(WSDLType)]);

    wtDuplicate:
      WriteLn(TypeInfoPad + sDuplicateTypes,  [WSDLType.Name, GetWSDLTypeInfo(WSDLType)]);

    wtEnumeration:
      WriteEnum(WSDLType);

    wtAlias:
      WriteAliasDef(WSDLType);

    wtArray:
      WriteArray(WSDLType);

    wtClass:
      WriteComplexTypeClass(WSDLType, PassType);

    wtAttrGroup:
      WriteComplexTypeClass(WSDLType, PassType);
  end;
end;

function TWSDLWriter.GetTypeInfoPad: DOMString;
begin
  Result := '';
end;

function TWSDLWriter.GetDebugMode: boolean;
begin
  Result := wfDebug in Global_WSDLGenFlags;
end;

function TWSDLWriter.GetVerboseMode: boolean;
begin
  Result := wfVerbose in Global_WSDLGenFlags;
end;

procedure TWSDLWriter.WriteInterfaces;
var
  WSDLPortTypeArray: IWSDLPortTypeArray;
  I: integer;
  WSDLPortType: IWSDLPortTYpe;
begin
  WSDLPortTypeArray := FWSDLImporter.GetPortTypes;
  for I := 0 to Length(WSDLPortTypeArray)-1 do
  begin
    WSDLPortType := WSDLPortTypeArray[I];
    WriteInterface(WSDLPortType, [ptTypeDecl]);
  end;
  { Give clients a factory method to access an interface }
  if not (wfServer in Global_WSDLGenFlags) then
    for I := 0 to Length(WSDLPortTypeArray)-1 do
    begin
      WSDLPortType := WSDLPortTypeArray[I];
      WriteInterface(WSDLPortType, [ptTypeFactoryDecl]);
    end;
end;

procedure TWSDLWriter.WriteImplHeader;
begin
end;

procedure TWSDLWriter.WriteImplementations;
var
  WSDLPortTypeArray: IWSDLPortTypeArray;
  I: integer;
  WSDLPortType: IWSDLPortTYpe;
begin
  { Are we in server mode - write implementation }
  if wfServer in Global_WSDLGenFlags then
  begin
    WSDLPortTypeArray := FWSDLImporter.GetPortTypes;
    for I := 0 to Length(WSDLPortTypeArray)-1 do
    begin
      WSDLPortType := WSDLPortTypeArray[I];
      WriteInterface(WSDLPortType, [ptTypeImpl]);
    end;
    for I := 0 to Length(WSDLPortTypeArray)-1 do
    begin
      WSDLPortType := WSDLPortTypeArray[I];
      WriteInterface(WSDLPortType, [ptMethImpl]);
    end;
  end else
  begin
    WSDLPortTypeArray := FWSDLImporter.GetPortTypes;
    for I := 0 to Length(WSDLPortTypeArray)-1 do
    begin
      WSDLPortType := WSDLPortTypeArray[I];
      WriteInterface(WSDLPortType, [ptTypeFactoryImpl]);
    end;
  end;

  { See if there are types to be implemented
    Currently limted to complex types classes }
  WriteTypes([ptTypeImpl], [wtClass, wtAttrGroup]);
end;

procedure TWSDLWriter.WriteInterface(const WSDLPortType: IWSDLPortType;
                                     PassType: TPassWriterType);
var
  I: integer;
  WSDLOperation: IWSDLOperation;
begin
  { Write a little blurb about the interface }
  if not (wfSelectiveCodeGen in Global_WSDLGenFlags) then
    if (ptTypeDecl in PassType) then
    begin
      if Verbose then
        WriteInterfaceInfo(WSDLPortType)
      else
        WriteLn('');
    end;

  { Interface declaration }
  if not (wfSelectiveCodeGen in Global_WSDLGenFlags) or WSDLPortType.Selected then
    WriteInterfaceBegin(WSDLPortType, PassType);

  { Methods }
  for I := 0 to Length(WSDLPortType.Operations)-1 do
  begin
    WSDLOperation := WSDLPortType.Operations[I];
    if not (wfSelectiveCodeGen in Global_WSDLGenFlags) or WSDLOperation.Selected then
      WriteMethod(WSDLOperation, WSDLPortType, PassType);
  end;

  { Close interface }
  if not (wfSelectiveCodeGen in Global_WSDLGenFlags) or WSDLPortType.Selected then
    WriteInterfaceEnd(WSDLPortType, PassType);
end;


{ NOTE: This routine must be overriden by a TWSDLWriter-derived class -
        The default implementation is strictly for testing purposes }
procedure TWSDLWriter.WriteIntfFooter;
begin
end;

procedure TWSDLWriter.ValidateName(const WSDLItem: IWSDLItem;
                                   Symbols: TDOMStrings;
                                   Index: Integer;
                                   Types: TDOMStrings);

  (* =========================================================================
     NOTE: C++ does not handle the case where a property has the same
     name as a type very well. For example, Amazon shows this:

      class CartItem : public TRemotable {
         { ... }
        __property Price*          Price = { read=FPrice, write=FPrice };
        __property Price*      ItemTotal = { read=FItemTotal, write=FItemTotal };
      };

      The property 'ItemTotal' generates an error because it's type name
      is the name of a property.
   =========================================================================  *)
  function IsMemberNamedAsType(WSDLItem: IWSDLItem; Index: Integer; Types: TDOMStrings): boolean;
  var
    WSDLPart: IWSDLPart;
    I: Integer;
  begin
    Result := WSDLItem.ItemType = wiPart;
    if (Result) then
    begin
      WSDLPart := WSDLItem as IWSDLPart;
      Result := WSDLPart.LangName = WSDLPart.DataType.LangName;
      if Result then
      begin
        { Here we check if there are more members of that type }
        Result := False;
        { There are no more members of that type, don't rename }
        I := Index+1;
        while (I < Types.Count) do
        begin
          if Types[I] = WSDLPart.LangName then
          begin
            Result := True;
            Exit;
          end;
          Inc(I);
        end;
      end;
    end;
  end;

  { Returns if a particular symbols was explicitly tagged as 'Don't Rename' by
    the user }
  function ExcludeFromRename(const Name: string): boolean;
  begin
    Result := ExcludedFromRenameList.IndexOf(Name) > -1;
  end;

  function IsInSymbols(const Name: DOMString): Boolean;
  begin
    Result := False;
    if Symbols <> nil then
    begin
      if IsCaseSensitive then
        Result := Symbols.IndexOf(Name) <> -1
      else
        Result := Symbols.IndexOfIgnoreCase(Name) <> -1;
    end;
  end;

var
  NewName: DOMString;
  RenameMembersOfTypeName: boolean;
begin
  { Validate identifiers }
  if not IsValidIdent(WSDLItem.Name) then
    WSDLItem.LangName := GetValidIdent(WSDLItem.Name);

  { Check against other reserved words }
  NewName := '';
  RenameMembersOfTypeName := RemapMembersOfTypeName;
  while (IsReservedWord(WSDLItem.LangName, NewName) and
         not ExcludeFromRename(WSDLItem.LangName))
         or
        (RenameMembersOfTypeName and
         (Index <> -1) and
         IsMemberNamedAsType(WSDLItem, Index, Types))
         or
         IsInSymbols(WSDLItem.LangName) do
  begin
    // NOTE: Returning a 'NewName' is optional
    if (NewName <> '') and (NewName <> WSDLItem.LangName) then
      WSDLItem.LangName := NewName
    else
      WSDLItem.LangName := WSDLItem.LangName + '_';
  end;
end;

procedure TWSDLWriter.ValidatePart(const WSDLPart: IWSDLPart);
begin
  if (wfUseXSTypeForSimpleNillable in Global_WSDLGenFlags) then
  begin
    if (pfNillable in WSDLPart.PartFlags) then
    begin
      if WSDLPart.DataType.AlternateType <> nil then
      begin
        WSDLPart.DataType := WSDLPart.DataType.AlternateType;
      end;
    end;
  end;
end;

procedure TWSDLWriter.ValidatePortTypes(const WSDLPortTypeArray: IWSDLPortTypeArray);

   procedure MarkOperationAsOverloaded(WSDLPortType: IWSDLPortType; OpName: DOMString);
   var
     I: Integer;
   begin
     for I := 0 to Length(WSDLPortType.Operations)-1 do
     begin
       if SameText(WSDLPortType.Operations[I].Name, OpName) then
       begin
         WSDLPortType.Operations[I].Overloaded := True;
       end;
     end;
   end;

   procedure AssignUniqueLangName(WSDLItem: IWSDLItem; Names: TDOMStrings);
   var
    X: Integer;
    Name: DOMString;
   begin
      X := 0;
      repeat
        Inc(X);
        Name := WSDLItem.LangName + IntToStr(X);
      until Names.IndexOf(Name) = -1;
      WSDLItem.LangName := Name;
      Names.Add(WSDLItem.LangName);
   end;

var
  I, J, K: integer;
  WSDLPortType: IWSDLPortType;
  WSDLOperation: IWSDLOperation;
  WSDLPart: IWSDLPart;
  Names, LangNames, ParamNames: TDOMStrings;
  NameChanged: Boolean;
begin
  for I := 0 to Length(WSDLPortTypeArray)-1 do
  begin
    WSDLPortType := WSDLPortTypeArray[I];
    ValidateName(WSDLPortType);
    if Length(WSDLPortType.Operations) > 0 then
    begin
      Names := TDOMStrings.Create;
      try
        LangNames := TDOMStrings.Create;
        try
          for J := 0 to Length(WSDLPortType.Operations)-1 do
          begin
            WSDLOperation := WSDLPortType.Operations[J];
            if Names.IndexOf(WSDLOperation.Name) = -1 then
            begin
              Names.Add(WSDLOperation.Name);
              ValidateName(WSDLOperation);
              { If ValidateName has changed WSDLOperation.LangName make sure it
                is unique }
              NameChanged := WSDLOperation.Name <> WSDLOperation.LangName;
              if (not WSDLOperation.OverLoaded) and
                  NameChanged and
                  (LangNames.IndexOf(WSDLOperation.LangName) <> -1) then
              begin
                AssignUniqueLangName(WSDLOperation, LangNames);
              end;
              LangNames.Add(WSDLOperation.LangName);
            end else
            begin
              ValidateName(WSDLOperation);
              MarkOperationAsOverLoaded(WSDLPortType, WSDLOperation.Name);
            end;

            { -------------------------------------------------- }
            { Handle parameters - Validate and ensure uniqueness }
            { NOTE: It's possible to have and 'in' and an 'out'
                    parameter of the same name but different types.
                    Being of different types, they won't be merged
                    into a single 'var' - hence the need to check
                    for uniqueness }
            ParamNames := TDOMStrings.Create;
            try
              for K := 0 to Length(WSDLOperation.Parts)-1 do
              begin
                WSDLPart := WSDLOperation.Parts[K];
                { The above will map to TXSxxxx type if necessary }
                ValidatePart(WSDLPart);
                
                { Now validate names }
                ValidateName(WSDLPart);
                
                { Make sure part names are unique but skip the return part }
                if WSDLPart.PartKind = pReturn then
                  continue;

                if ParamNames.IndexOf(WSDLPart.LangName) <> -1 then
                  AssignUniqueLangName(WSDLPart, ParamNames);
                ParamNames.Add(WSDLPart.LangName);
              end;
            finally
              ParamNames.Free;
            end;
            { -------------------------------------------------- }

            (*
            { -------------------------------------------------- }
            { Headers of operation                               }
            { -------------------------------------------------- }
            for WSDLPart in WSDLOperation.Headers do
            begin
              ValidateName(WSDLPart);
            end;

            { -------------------------------------------------- }
            { Faults of operation                                }
            { -------------------------------------------------- }
            for WSDLPart in WSDLOperation.Faults do
            begin
              ValidateName(WSDLPart);
            end;
            *)
          end;
        finally
          LangNames.Free;
        end;
      finally
        Names.Free;
      end;
    end;
  end;
end;

function TWSDLWriter.ReplaceSpecialChar(const Name: DOMString): DOMString;
var
  Index: Integer;
  NewName: DOMString;
begin
  NewName := Name;
  Index := Length(Name);
  while Index > 0 do
  begin
    if CharInSet(Char(Name[Index]), ['a'..'z']) or 
       CharInSet(Char(Name[Index]), ['A'..'Z']) or
       CharInSet(Char(Name[Index]), ['0'..'9']) then
      NewName[Index] := Name[Index]
    else
      NewName[Index] := '_';

    Index := Index -1;
  end;
  Result := NewName;
end;

{ The following logic will be language dependent - i.e. the language that
  emitted the TypeInfo - Writers can overwrite this to provide mappings
  between languages }
function TWSDLWriter.TypeNameFromTypeInfo(TypeInfo: pTypeInfo): DOMString;
begin
  // UTF8 Decoding??
  Result := DOMString(TypeInfo.Name);
end;

function TWSDLWriter.GetDataType(const WSDLType: IWSDLType): DOMString;

  { Returns true if the specified namespace is an XMLSchema one }
  function IsXMLSchemanamespace(const Namespace: DOMString): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := Low(XMLSchemaNamespaces) to High( XMLSchemaNamespaces) do
    begin
      if (Namespace =  XMLSchemaNamespaces[I]) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

var
  ATypeInfo: pTypeInfo;
  XMLType: DOMString;
begin
  Result := '';
  XMLType := WSDLType.Name;
  if XMLType <> '' then
  begin
    ATypeInfo := WSDLType.TypeInfo;
    if ATypeInfo = nil then
    begin
      { Look for the type under its namespace first }
      ATypeInfo :=  RemTypeRegistry.XSDToTypeInfo(WSDLType.Namespace, XMLType);
      if ATypeInfo = nil then
      begin
        { Allow for older schemas }
        if IsXMLSchemaNamespace(WSDLType.Namespace) then
          ATypeInfo :=  RemTypeRegistry.XSDToTypeInfo(XMLSchemaNameSpace, XMLType);
      end;
    end;

    { Here we'll make up for some WSDL that use XMLSchema types in their complex types
      and yet don't use XMLNamespace prefixes ?? - These members end up with the
      TargetNamespace and the above fails to retrieve their typeinfos }
    if ATypeInfo = nil then
    begin
      if WSDLType.DataKind = wtNotDefined then
      begin
        ATypeInfo := RemTypeRegistry.XSDToTypeInfo(XMLSchemaNameSpace, XMLType);
      end;
    end;

    { Here map string type according to user's choice }
    if (ATypeInfo <> nil) and SameTypeInfo(TypeInfo(System.AnsiString), ATypeInfo) then
    begin
{$IFNDEF TIBURON_UP}
      if (wfMapStringsToWideStrings in Global_WSDLGenFlags) then
      begin
        ATypeInfo := TypeInfo(System.WideString);
      end;
{$ELSE}
      if (wfMapStringsToWideStrings in Global_WSDLGenFlags) then
      begin
        ATypeInfo := TypeInfo(System.WideString);
      end
      else
      begin
        ATypeInfo := TypeInfo(System.String);
      end;  
{$ENDIF}        
    end;

    if ATypeInfo <> nil then
    begin
      Result := TypeNameFromTypeInfo(ATypeInfo);
      WSDLType.TypeInfo := ATypeInfo;
    end;

    { Guess it remains as is }
    { Here we could provide for a way to map types via a configuration file.
      This would a workaround for cases where the user will provide a mapping
      but does not want to go through the SOAP Registry }
    if Result = '' then
      Result := XMLType;
  end;

  { Last resort }
  if Result = '' then
    Result := 'Variant';
end;

{ TWSDLItem }

function TWSDLItem.GetName: DOMString;
begin
  Result := FName;
end;

procedure TWSDLItem.SetName(const name: DOMString);
begin
  FName := name;
end;

function TWSDLItem.GetLangName: DOMString;
begin
  if FLangName <> '' then
    Result := FLangName
  else
    Result := GetName;
end;

procedure TWSDLItem.SetLangName(const lname: DOMString);
begin
  FLangName := lname;
end;

function TWSDLItem.GetWSDLItemType: WSDLItemType;
begin
  Result := wiUndefined;
end;

function TWSDLItem.GetNamespace: DOMString;
begin
  Result := FNamespace;
end;

procedure TWSDLItem.SetNamespace(const nspace: DOMString);
begin
  FNamespace := nspace;
end;

function TWSDLItem.GetDocumentation: DOMString;
begin
  Result := FDocumentation;
end;

function TWSDLItem.GetSelected: Boolean;
begin
  Result := FGenerate;
end;

procedure TWSDLItem.SetSelected(const Sel: Boolean);
begin
  FGenerate := Sel;
end;

procedure TWSDLItem.SetDocumentation(const doc: DOMString);
begin
  FDocumentation := doc;
end;

procedure TWSDLItem.Rename(const NewName: DOMString);
begin
  FName := NewName;
end;

procedure TWSDLItem.AddNote(const Note: string);
var
  Len: Integer;
begin
  Len := Length(FNotes);
  SetLength(FNotes, Len+1);
  FNotes[Len] := Note;
end;

function TWSDLItem.GetNotes: ArrayOfString;
begin
  Result := FNotes;
end;

{ TWSDLPart }

constructor TWSDLPart.Create;
begin
  inherited Create;
end;

destructor TWSDLPart.Destroy;
begin
  FDataType := nil;
  inherited Destroy;
end;

function  TWSDLPart.GetPartKind: PartType;
begin
  Result := FPartKind;
end;

procedure TWSDLPart.SetPartKind(const pt: PartType);
begin
  FPartKind := pt;
end;

function  TWSDLPart.GetDataType: IWSDLType;
begin
  Result := FDataType;
end;

procedure TWSDLPart.SetDataType(const DataType: IWSDLType);
begin
  FDataType := DataType;
end;

function TWSDLPart.GetWSDLItemType: WSDLItemType;
begin
  Result := wiPart;
end;

function TWSDLPart.GetPartFlags: TPartFlag;
begin
  Result := FPartFlags;
end;

procedure TWSDLPart.SetPartFlags(const Value: TPartFlag);
begin
  FPartFlags := Value;
end;

procedure TWSDLPart.SetRegInfo(const ARegInfo: DOMString);
begin
  FRegInfo := ARegInfo;
end;

procedure TWSDLPart.SetRequired(Flag: Boolean);
begin
  if (Flag) then
    FPartFlags := FPartFlags - [pfOptional]
  else
    FPartFlags := FPartFlags + [pfOptional];
end;

function TWSDLPart.GetRegInfo: DOMString;
begin
  Result := FRegInfo;
end;

function TWSDLPart.GetRequired: Boolean;
begin
  Result := not (pfOptional in FPartFlags);
end;

function TWSDLPart.Clone: IWSDLPart;
var
  C: TWSDLPart;
begin
  C := TWSDLPart.Create;
  Result := C;

  { TWSDLPart }
  C.FPartKind := FPartKind;
  C.FDataType := FDataType;
  C.FPartFlags:= FPartFlags;
  C.FDefaultValue := FDefaultValue;

  { Base }
  C.FName     := FName;
  C.FLangName := FLangName;
  C.FNamespace:= FNamespace;
  C.FDocumentation := FDocumentation;
  C.FGenerate := FGenerate;
  C.FNotes    := FNotes;
end;

function TWSDLPart.GetDefaultValue: DOMString;
begin
  Result := FDefaultValue;
end;


{ TWSDLOperation }

constructor TWSDLOperation.Create;
begin
  inherited Create;
end;

destructor TWSDLOperation.Destroy;
begin
  SetLength(FPartArray, 0);
  inherited Destroy;
end;

function TWSDLOperation.GetParts: IWSDLPartArray;
begin
  Result := FPartArray;
end;

function TWSDLOperation.GetHeaders: IWSDLPartArray;
begin
  Result := FHeaderArray;
end;

function TWSDLOperation.GetCannotUnwrap: TCannotUnwrap;
begin
  Result := FCannotUnwrap;
end;

function TWSDLOperation.GetFaults: IWSDLPartArray;
begin
  Result := FFaultArray;
end;

function TWSDLOperation.IsOverloaded: Boolean;
begin
  Result := FIsOverLoaded;
end;

function TWSDLOperation.GetReturnIndex: integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to Length(FPartArray)-1 do
  begin
    if FPartArray[I].PartKind = pReturn then
    begin
      { Assumes only one parameter as pReturn }
      Result := I;
      Exit;
    end;
  end;
end;

function TWSDLOperation.GetStyle: DOMString;
begin
  Result := FStyle;
end;

function TWSDLOperation.GetSOAPAction: DOMString;
begin
  Result := FSOAPAction;
end;

function TWSDLOperation.GetInputUse: DOMString;
begin
  Result := FInputUse;
end;

function TWSDLOperation.GetInputNamespace: DOMString;
begin
  Result := FInputNamespace;
end;

function TWSDLOperation.GetOuputUse: DOMString;
begin
  Result := FOutputUse;
end;

function TWSDLOperation.GetOuputNamespace: DOMString;
begin
  Result := FOutputNamespace;
end;

function TWSDLOperation.GetPartCountOfType(PartTypeKind: PartType): integer;
var
  Part: IWSDLPart;
begin
  Result := 0;
  for Part in FPartArray do
  begin
    if Part.PartKind = PartTypeKind then
      Inc(Result);
  end;
end;

function TWSDLOperation.GetPartOfType(PartTypeKind: PartType): IWSDLPart;
var
  I: integer;
begin
  Result := nil;
  for I := 0 to Length(FPartArray)-1 do
  begin
    if FPartArray[I].PartKind = PartTypeKind then
    begin
      Result := FPartArray[I];
      Exit;
    end;
  end;
end;

function TWSDLOperation.GetPartsOfType(PartTypeKind: PartType): IWSDLPartArray;
var
  Len, I: integer;
begin
  SetLength(Result, 0);
  for I := 0 to Length(FPartArray)-1 do
  begin
    if FPartArray[I].PartKind = PartTypeKind then
    begin
      Len := Length(Result);
      SetLength(Result, Len+1);
      Result[len] := FPartArray[I];
    end;
  end;
end;

procedure TWSDLOperation.UnwrapParams(const PartsIn: IWSDLPartArray;
                                      PartIn: PartType;
                                      const PartsOut: IWSDLPartArray;
                                      PartOut: PartType);
var
  Len: Integer;
  NewParts: IWSDLPartArray;
  Tmp: IWSDLPart;
begin
  if PartsIn <> nil then
  begin
    for Tmp in PartsIn do
    begin
      if Tmp.PartKind = pAttribute then
        Continue;
      Tmp.PartKind := PartIn;
      Len := Length(NewParts);
      SetLength(NewParts, Len+1);
      NewParts[Len] := Tmp;
    end;
  end;

  if PartsOut <> nil then
  begin
    for Tmp in PartsOut do
    begin
      if Tmp.PartKind = pAttribute then
        Continue;
      Tmp.PartKind := PartOut;
      Len := Length(NewParts);
      SetLength(NewParts, Len+1);
      NewParts[Len] := Tmp;
    end;
  end;

  SetLength(FPartArray, 0);
  FPartArray := NewParts;
end;

function LoadPartInfo(const WSDLImporter: IWSDLImporter;
                      const WSDLItems: TWSDLItems;
                      const Part: IPart;
                      ArgType: ArgumentType;
                      var FPartArray: IWSDLPartArray;
                      IsFault: Boolean = False;
                      MapAttachment: Boolean = False;
                      const AMessage: DOMString = '';
                      const AOperation: DOMString = ''): IWSDLPart;


  { Routine that returns the type of an IPart }
  function GetPartDataType(const DataType: DOMString;
                           const DataTypeNS: DOMString): IWSDLType;
  begin
    Result := WSDLImporter.FindType(DataType, DataTypeNS, [xtiElement, xtiGlobal], [], False);
    if (Result = nil) then
      Result := WSDLImporter.FindType(DataType, DataTypeNS, [xtiGlobal], [], False);
    if (Result = nil) then
      Result := WSDLImporter.FindType(DataType, DataTypeNS, [], [], True);
  end;

var
  DataType: DOMString;
  DataTypeNs: DOMString;
  MimePart: IMIMEPart;
  Index: Integer;
  NewPart: TWSDLPart;
begin
  { Get the data type of the part }
  MimePart := Nil;
  if (Part.Type_ <> '') then
    DataType := Part.Type_
  else
    DataType := Part.Element;

  { Is type TSoapAttachment? }
  { For now we assume that only 'base64Binary' types can be multi-part }
  if MapAttachment then
  begin
    MimePart := WSDLImporter.FindMimePart(Part.Name, AOperation, AMessage, ArgType);
    if Assigned(MimePart) then
    begin
      DataType := SSoapAttachment;
      DataTypeNS := SBorlandTypeNamespace;
     end;
  end;

  { Extract Namespace }
  if IsPrefixed(DataType) then
  begin
    DataTypeNS := ExtractPrefix(DataType);
    DataTypeNS := Part.FindNamespaceURI(DataTypeNS);
    DataType   := ExtractLocalName(DataType);
  end
  else if not Assigned(MimePart) then
  begin
    DataTypeNs := WSDLItems.TargetNamespace;
  end;

  { Check if the Part is already there and if it appears in both in and out message }
  { mark it as pInOut }
  for Index:= 0 to Length(FPartArray) -1 do
  begin
    { Check that both the name and type correspond }
    if (FPartArray[Index].Name = Part.Name) and
       (FPartArray[Index].DataType = GetPartDataType(DataType, DataTypeNS)) then
    begin
      if ((FPartArray[Index].PartKind = pIn)  and  (ArgType in [argOut])) then
        FPartArray[Index].PartKind := pInOut;

      if ((FPartArray[Index].PartKind = pOut)  and  (ArgType in [argIn])) then
        FPartArray[Index].PartKind := pInOut;

      Result := FPartArray[Index];
      Exit;
    end;
  end;

  { Add a new Part }
  Index := Length(FPartArray);
  SetLength(FPartArray, Index +1);

  { Create new Part }
  NewPart := TWSDLPart.Create;
  FPartArray[Index] := NewPart;

  { Update parameter flags, name, etc }
  if not IsFault then
    NewPart.SetName(Part.Name)
  else
    NewPart.SetName(DataType);

  { Mark parameter }
  if ArgType in [argIn] then
    NewPart.FPartKind := pIn
  else
    NewPart.FPartKind := pOut;

  { Store parameter type }
  NewPart.FDataType := GetPartDataType(DataType, DataTypeNS);
  NewPart.FNamespace := DataTypeNs;

  Result := NewPart;
end;

procedure TWSDLOperation.AddPartInfo(const WSDLImporter: IWSDLImporter;
                                     const WSDLItems: TWSDLItems;
                                     const Part: IPart;
                                     ArgType: ArgumentType;
                                     IsFault: Boolean = False;
                                     const AMessage: DOMString = '');
begin
  LoadPartInfo(WSDLImporter, WSDLItems, Part,
               ArgType, FPartArray, IsFault, True, AMessage, GetName());
end;

function TWSDLOperation.AddParts(const WSDLImporter: IWSDLImporter;
                                  const WSDLItems: TWSDLItems;
                                  const Operation: IOperation;
                                  const BindingName: IQualifiedName): IQualifiedNameArray;
var
  I, Count: Integer;
  Messages: IMessages;
  Message: IMessage;
  Parts: IParts;
  MessageName: DOMString;
begin
  SetLength(Result, 2);
  Result[0] := nil;
  Result[1] := nil;

  { Collect all part for the Operation from the Input and Output Message }
  if Operation.Input.Message <> '' then
  begin
    MessageName := Operation.Input.Message;
    Result[0] := NewQualifiedName(MessageName, WSDLItems.TargetNamespace);
    Messages := WSDLItems.Definition.Messages;
    for Count := 0 to Messages.Count -1 do
    begin
      Message := Messages[Count];
      if WSDLItems.CompareName(Message.Name, MessageName) then
      begin
        Parts := Messages[Count].Parts;
        for I := 0 to Parts.Count -1 do
        begin
          AddPartInfo(WSDLImporter, WSDLItems, Parts[I], argIn, False, Message.Name);
        end;
      end;
    end;
  end;

  if Operation.Output.Message <> '' then
  begin
    MessageName := Operation.Output.Message;
    Result[1] := NewQualifiedName(MessageName, WSDLItems.TargetNamespace);
    Messages := WSDLItems.Definition.Messages;
    for Count := 0 to Messages.Count -1 do
    begin
      Message := Messages[Count];
      if WSDLItems.CompareName(Message.Name, MessageName) then
      begin
        Parts := Messages[Count].Parts;
        for I := 0 to Parts.Count -1 do
        begin
          AddPartInfo(WSDLImporter, WSDLItems, Parts[I], argOut, False, Message.Name);
        end;
      end;
    end;
  end;
end;

procedure SerializeSimpleTypes(const WSDLImporter: IWSDLImporter;
                               PartArray: IWSDLPartArray);
var
  I: Integer;
  Part: IWSDLPart;
  DataType: IWSDLType;
begin
  for I := 0 to Length(PartArray)-1 do
  begin
    Part := PartArray[I];
    DataType := Part.DataType;
    DataType := UnwindType(DataType);
    if DataType.Namespace = XMLSchemaNamespace then
    begin
      Part.DataType := WSDLImporter.CreateSerializer(DataType,
                                                     Part.Name,
                                                     Part.DataType.Namespace,
                                                     'Value',
                                                     [xoSimpleTypeWrapper], False);
    end;
  end;
end;

procedure TWSDLOperation.AddHeaders(const WSDLImporter: IWSDLImporter; const WSDLItems: TWSDLItems;
                                    const Operation: IOperation; const BindingName: IQualifiedName;
                                    OverloadIndex: Integer; const MessageNames: IQualifiedNameArray;
                                    var SOAPVersion: TSOAPVersion);

  procedure MarkTypeAsHeader(const WSDLType: IWSDLType);
  var
    BaseType: IWSDLType;
  begin
    WSDLType.TypeFlag := wfHeader;
    WSDLType.IsUsed := True;

    if (WSDLType.DataKind = wtAlias) then
    begin
      BaseType := WSDLType.BaseType;
      if (BaseType <> nil) and (BaseType.TypeFlag <> wfHeader) then
        MarkTypeAsHeader(BaseType);
    end;
  end;

var
  HeaderInfoArray: IHeaderInfoArray;
  HeaderInfoArrayWSDLItems: IWSDLItems;
  I, IOIndex: Integer;
  MessageName: DOMString;
  Header: IWSDLPart;
  ArgType: ArgumentType;
begin
  SetLength(HeaderInfoArray, 0);

  { Get IParts representing headers }
  for IOIndex := 0 to 1 do  { Input=0, Output=1 }
  begin
    If IOIndex = 0 then
      ArgType := argIn
    else
      ArgType := argOut;

    if MessageNames[IOIndex] <> nil then
      MessageName := MessageNames[IOIndex].Name
    else
      MessageName := '';

//  -- This crashes in XML Code currently ???
// {$DEFINE MULTIBINDINGS}
{$IFDEF MULTIBINDINGS}
    HeaderInfoArray := WSDLImporter.GetWSDLItems.GetSoapInputHeaders(BindingName, Operation.Name,
                                                                     OverloadIndex, MessageName, SOAPVersion);
{$ELSE}
    HeaderInfoArray := WSDLItems.GetSoapHeaders(BindingName, Operation.Name,
                                                (IOIndex = 0), OverloadIndex,
                                                MessageName, SOAPVersion, HeaderInfoArrayWSDLItems);
{$ENDIF}
    try
      if Length(HeaderInfoArray) > 0 then
      begin
        for I := 0 to Length(HeaderInfoArray)-1 do
        begin
          if HeaderInfoArray[I].Part <> nil then
          begin
            Header := LoadPartInfo(WSDLImporter, WSDLItems, HeaderInfoArray[I].Part, argType,
                                   FHeaderArray);
            Header.Required := HeaderInfoArray[I].Required;
            Header.Namespace:= HeaderInfoArray[I].Namespace;
          end;
        end;
      end;
    finally
      HeaderInfoArrayWSDLItems := nil;
    end;
  end;

  { If header is a simple type, create a serializer }
  SerializeSimpleTypes(WSDLImporter, FHeaderArray);

  { Mark type as a header }
  for I := 0 to Length(FHeaderArray)-1 do
  begin
    MarkTypeAsHeader(FHeaderArray[I].DataType);
  end;
end;

procedure TWSDLOperation.AddFaults(const WSDLImporter: IWSDLImporter;
                                   const WSDLItems: TWSDLItems;
                                   const Operation: IOperation);
var
  J, I, Count: Integer;
  Messages: IMessages;
  Message: IMessage;
  Parts: IParts;
  Fault: IFault;
  MessageName, FaultName: DOMString;
begin
  for J := 0 to Operation.Faults.Count-1 do
  begin
    Fault := Operation.Faults[J];
    if Fault.Message <> '' then
    begin
      MessageName := Fault.Message;
      FaultName := Fault.Name;

      Messages := WSDLItems.Definition.Messages;
      for Count := 0 to Messages.Count -1 do
      begin
        Message := Messages[Count];
        if WSDLItems.CompareName(Message.Name, MessageName) then
        begin
          Parts := Messages[Count].Parts;
          for I := 0 to Parts.Count -1 do
          begin
            LoadPartInfo(WSDLImporter, WSDLItems, Parts[I], argOut, FFaultArray, True);
          end;
        end;
      end;
    end;
  end;

  { If fault is a simple type, create a serializer }
  SerializeSimpleTypes(WSDLImporter, FFaultArray);

  { Mark types as Faults }
  for I := 0 to Length(FFaultArray)-1 do
  begin
                                                         
    FFaultArray[I].DataType.TypeFlag := wfFault;
    FFaultArray[I].DataType.IsUsed := True;
  end;
end;

procedure TWSDLOperation.ChangePartsKind(NewKind: PartType; OldKind: PartType);
var
  I: integer;
begin
  for I := 0 to Length(FPartArray)-1 do
  begin
    if FPartArray[I].PartKind = OldKind then
      FPartArray[I].PartKind := NewKind;
  end;
end;

function TWSDLOperation.CanUnwrap(Input: Boolean): UnwrapStatus;

  function GetPartSignature(const Part: IWSDLPart): DOMString;
  begin
    Result := '';
    if (Part.DataType <> nil) then
      Result := WideFormat('%s:%s:%s', [Part.Name,
                                        Part.DataType.Name,
                                        Part.DataType.Namespace]);
  end;

  { NOTE: This function is used to determine if there are more than one
          strictly out parameters. Therefore if we detect only one
          member, we don't even both checking if it's strictly out.
          So this function is not named appropriately :( }
  function StrictlyOutMembers(const OutType: IWSDLType; var LastStrictlyOutPartName: DOMString): Integer;
  var
    InType: IWSDLType;
    InPart: IWSDLPart;
    MemberCache: TDOMStrings;
    I: Integer;
    Sig: DOMString;
  begin
    Result := Length(OutType.Members);
    if Result > 1 then
    begin
      { If there are more than one members on the Response type, allow
        for the fact that some of these members might be part of the
        request also - hence, are not strictly Out }
      InPart := GetPartOfType(pIn);
      if InPart <> nil then
      begin
        InType := InPart.DataType;
        if InType <> nil then
        begin
          MemberCache := TDOMStrings.Create;
          try
            { First load In parts }
            for I := 0 to Length(InType.Members) - 1 do
            begin
              InPart := InType.Members[I];
              Sig := GetPartSignature(InPart);
              if (Sig <> '') then
                MemberCache.Add(GetPartSignature(InPart));
            end;

            { Now check if any of out parts match in parts }
            for I := 0 to Length(OutType.Members) - 1 do
            begin
              InPart := OutType.Members[I];
              Sig := GetPartSignature(InPart);
              if MemberCache.IndexOf(Sig) <> -1 then
                Dec(Result)
              else
                LastStrictlyOutPartName := InPart.Name;
            end;
          finally
            MemberCache.Free;
          end;
        end;
      end;
    end;
  end;

  function CanUnwrap(const UseDesc: DOMString; pType: PartType): UnwrapStatus;
  var
    Part: IWSDLPart;
    WSDLType: IWSDLType;
    ResultPartName: DOMString;
  begin
    { Make sure we're invoked properly }
    Assert((pType = pIn)  or (pType = pOut));

    { Not applicable for non-literal services }
    Result := usNotReq;
    if not SameText(UseDesc, 'literal') then { do not localize }
      Exit;

    { Not applicable if we're in RPC style too }
    if SameText(FStyle, 'rpc') then
      Exit;

    { Wrapped style services must have at most one input or output part }
    { Zero's OK too }
    if GetPartCountOfType(pType) = 0 then
      Exit(usCan)
    else if (GetPartCountOfType(pType) > 1) then
    begin
      if (pType = pOut) then
        SetCannotUnwrap(GetCannotUnwrap() + [cuOutputMessageHasMoreThanOnePart])
      else
        SetCannotUnwrap(GetCannotUnwrap() + [cuInputMessageHasMoreThanOnePart]);
      Result := usCannot;
      Exit;
    end;

    { Check the part itself }
    Part := GetPartOfType(pType);
    WSDLType := Part.DataType;

    { The type must be a global element }
    if not (xtiElement in WSDLType.XMLItemInfo) then
    begin
      if (pType = pOut) then
        SetCannotUnwrap(GetCannotUnwrap() + [cuOutputPartRefersToTypeNotElement])
      else
        SetCannotUnwrap(GetCannotUnwrap() + [cuInputPartRefersToTypeNotElement]);
      Result := usCannot;
      Exit;
    end;

    { The Input element name must match that of the operation }
    if (pType = pIn) then
    begin
      if (GetName() <> WSDLType.Name) then
      begin
        SetCannotUnwrap(GetCannotUnwrap() + [cuInputWrapperElementNotSameAsOperationName]);
        Result := usCannot;
        Exit;
      end;
    end;

    { Unwind levels of alias indirection }
    WSDLType := UnwindType(WSDLType);
    { The element must be a complex type }
    if (WSDLType.DataKind = wtClass) then
    begin
      { OK - This one is ours - not doc|lit convention }
      if WSDLType.SerializationOpt <> [] then
      begin
        SetCannotUnwrap(GetCannotUnwrap() + [cuTypeNeedsSpecialSerialization]);
        Result := usCannot;
        Exit;
      end;

      { Here avoid multiple 'out' parameters unless the user overrides }
      ResultPartName := '';
      if (pType = pOut) and
         (StrictlyOutMembers(WSDLType, ResultPartName) > 1) and
         (not (wfAllowOutParameters in Global_WSDLGenFlags)) then
      begin
        SetCannotUnwrap(GetCannotUnwrap() + [cuMoreThanOneStrictlyOutMembersWereFound]);
        Result := usCannot;
        Exit;
      end;

      { This one is also ours - Our runtime cannot handle unwrapping
        a pure collection currently }
      if (IsPureCollection(WSDLType)) then
      begin
        Result := usCannot;
        if Result <> usCannot then
          Exit;
      end;

                                                                              
                                                  

      { OK Here we think that we can unwrap }
      Result := usCan;
    end
    else
    begin
    { The single part of must be an element that contains a complex type - IOW,
      a wtClass. Here we had something other than wtClass }
      if (pType = pOut) then
        SetCannotUnwrap(GetCannotUnwrap() + [cuOutputPartNotAComplexType])
      else
        SetCannotUnwrap(GetCannotUnwrap() + [cuInputPartNotAComplexType]);
      Result := usCannot;
      Exit;
    end;
  end;

begin
  if Input then
    Result := CanUnwrap(FInputUse, pIn)
  else
    Result := CanUnwrap(FOutputUse, pOut);
end;

procedure TWSDLOperation.HandleLiteralParams(UnwrapStat: UnwrapStatus;
                                             UseLiteralParams: Boolean);

  function CloneMembers(const Parts: IWSDLPartArray): IWSDLPartArray;
  var
    Part: IWSDLPart;
    I, Len: Integer;
  begin
    Len := Length(Parts);
    SetLength(Result, Len);
    for I := 0 to Len-1 do
    begin
      Part := Parts[I];
      Result[I] := Part.Clone;
    end;
  end;

  procedure MarkLiteralType(var WSDLType: IWSDLType);
  begin
    while (WSDLType.DataKind = wtAlias) do
    begin
      WSDLType.TypeFlag := wfLiteralParam;
      WSDLType := WSDLType.BaseType;
    end;
    WSDLType.TypeFlag := wfLiteralParam;
  end;

var
  PartIn, PartOut: IWSDLPart;
  WSDLTypeIn, WSDLTypeOut: IWSDLType;
begin
  { If not required, nothing to do }
  if UnwrapStat = usNotReq then
    Exit;

  WSDLTypeIn := nil;
  WSDLTypeOut := nil;

  if (UnwrapStat = usCan) then
  begin
    { Input }
    PartIn := GetPartOfType(pIn);
    if PartIn <> nil then
    begin
      WSDLTypeIn := PartIn.DataType;
      MarkLiteralType(WSDLTypeIn);
    end;
    { Output }
    PartOut := GetPartOfType(pOut);
    if PartOut <> nil then
    begin
      WSDLTypeOut := PartOut.DataType;
      MarkLiteralType(WSDLTypeOut);
    end;

    { Nothing to do }
    if (PartIn = nil) and (PartOut = nil) then
      Exit;

    { Store Wrapper Parts }
    FInputWrapper := PartIn;
    FOutputWrapper := PartOut;

    { NOTE: We clone here just in case the 'in' and 'out' types point to the same
            type. Tweaking the members for one will affect the other }
    if PartIn = nil then
      UnwrapParams(nil, pUnknown,
                   CloneMembers(WSDLTypeOut.Members), PartOut.PartKind)
    else if PartOut = nil then
      UnwrapParams(CloneMembers(WSDLTypeIn.Members), PartIn.PartKind,
                   nil, pUnknown)
    else
      UnwrapParams(CloneMembers(WSDLTypeIn.Members), PartIn.PartKind,
                   CloneMembers(WSDLTypeOut.Members), PartOut.PartKind);
  end
  else
  begin
    { Input }
    PartIn := GetPartOfType(pIn);
    if (PartIn <> nil) then
      WSDLTypeIn := PartIn.DataType;

    { Output }
    PartOut := GetPartOfType(pOut);
    if (PartOut <> nil) then
      WSDLTypeOut := PartOut.DataType;

    if WSDLTypeIn <> nil then
      MarkLiteralType(WSDLTypeIn);
    if WSDLTypeOut <> nil then
      MarkLiteralType(WSDLTypeOut);

    { Here we're not unwrapping literal params }
    if not UseLiteralParams then
    begin
      if WSDLTypeIn <> nil then
        WSDLTypeIn.SerializationOpt := WSDLTypeIn.SerializationOpt + [xoHolderClass, xoLiteralParam];
      if WSDLTypeOut <> nil then
        WSDLTypeOut.SerializationOpt := WSDLTypeOut.SerializationOpt + [xoHolderClass, xoLiteralParam];
    end else
    begin
      if WSDLTypeIn <> nil then
        WSDLTypeIn.SerializationOpt := WSDLTypeIn.SerializationOpt + [xoLiteralParam];
      if WSDLTypeOut <> nil then
        WSDLTypeOut.SerializationOpt := WSDLTypeOut.SerializationOpt + [xoLiteralParam];
    end;
  end;
end;

procedure TWSDLOperation.TweakReturnParam(const Importer: IWSDLImporter; Opts: TTweakPartOpts);

  function IndexOf(const Name: string; const Strings: TStringDynArray): integer;
  var
    I: integer;
  begin
    Result := -1;
    for I := 0 to Length(Strings)-1 do
    begin
      if SameText(Name, Strings[I]) then
      begin
        Result := I;
        Exit;
      end;
    end;
  end;

  function DuplicateIndex(const Part: IWSDLPart; const Parts: IWSDLPartArray): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := 0 to Length(Parts)-1 do
    begin
      if (Parts[I] <> Part) and (Parts[I].Name = Part.Name) and
         (Parts[I].DataType = Part.DataType) then
      begin
        Result := I;
        Exit;
      end;
    end;
  end;

var
  I, Index: integer;
  Parts: IWSDLPartArray;
  ReturnParams: TStringDynArray;
  HaveReturn: Boolean;
begin
  HaveReturn := False;
  SetLength(ReturnParams, 0);
  SetLength(Parts, 0);

  { Then try to determine the return type from the param name }
  if GetPartCountOfType(pReturn) = 0 then
  begin
                                                                     
    
    { See if any of the out params match the Return param names }
    ReturnParams := StringToStringArray(DefaultReturnParamNames, sReturnParamDelimiters);

    { NOTE: MS .NET Default to operationname with 'Result' suffix }

    if (ReturnParams <> nil) and (Length(ReturnParams) > 0) then
    begin
      Parts := GetPartsOfType(pOut);
      if Length(Parts) > 0 then
      begin
        for I := 0 to Length(Parts)-1 do
        begin
          if IndexOf(Parts[I].Name, ReturnParams) <> -1 then
          begin
            { If we find match, update the part kind }
            Parts[I].PartKind := pReturn;
            HaveReturn := True;
            break;
          end;
        end;
      end;
    end;
  end;

  { In case we did not find the return via name, try a single out }
  if not HaveReturn and (wfOneOutIsReturn in Global_WSDLGenFlags) then
  begin
    if (GetPartCountOfType(pOut) = 1) then
    begin
      ChangePartsKind(pReturn, pOut);
      HaveReturn := True;
    end;
  end;

  { Here we try to match 'in' and 'out' to 'InOut' }
  if tpUnwrapped in Opts then
  begin
    SetLength(Parts, 0);
    for I := 0 to Length(FPartArray)-1 do
    begin
      Index := DuplicateIndex(FPartArray[I], Parts);
      if (Index = -1) then
      begin
        SetLength(Parts, Length(Parts)+1);
        Parts[Length(Parts)-1] := FPartArray[I];
      end
      else
      begin
        if ((Parts[Index].PartKind = pIn) and (FPartArray[I].PartKind = pOut)) or
           ((Parts[Index].PartKind = pOut) and (FPartArray[I].PartKind = pIn)) then
          Parts[Index].PartKind := pInOut
        else
          { Here we have a little problem unless one is the return }
          if (Parts[Index].PartKind <> pReturn) and (FPartArray[I].PartKind <> pReturn) then
          begin
            Assert(False, Format('Error: Parts[Index]=%s:%s & FPartArray[I]=%s:%s',  { Do not localize }
                           [Parts[Index].Name, PartTypeStr[Parts[Index].PartKind],
                            FPartArray[I].Name, PartTypeStr[FPartArray[I].PartKind]]));
          end;
      end;
    end;
    if Length(Parts) < Length(FPartArray) then
      FPartArray := Parts;
  end;

  { We return the above logic for cases where there were many outs and some of them
    went to in|out }
  if not HaveReturn and (wfOneOutIsReturn in Global_WSDLGenFlags) then
  begin
    if (GetPartCountOfType(pOut) = 1) then
      ChangePartsKind(pReturn, pOut);
  end;
end;

function TWSDLOperation.GetWSDLItemType: WSDLItemType;
begin
  Result := wiOperation;
end;

procedure TWSDLOperation.SetSelected(const Sel: Boolean);
begin
  inherited SetSelected(Sel);
end;

procedure TWSDLOperation.SetCannotUnwrap(const Value: TCannotUnwrap);
begin
  FCannotUnwrap := Value;
end;

procedure TWSDLOperation.SetOverloaded(const Value: Boolean);
begin
  FIsOverLoaded := Value;
end;

function TWSDLOperation.GetInputWrapper: IWSDLPart;
begin
  Result := FInputWrapper;
end;

function TWSDLOperation.GetOutputWrapper: IWSDLPart;
begin
  Result := FOutputWrapper;
end;


{ TWSDLPortType }

constructor TWSDLPortType.Create;
begin
  inherited Create;
  { Default to IInvokable }
  FBaseInterfaceName := 'IInvokable';  { do not localize }
end;

destructor TWSDLPortType.Destroy;
begin
  SetLength(FOperationArray, 0);
  inherited Destroy;
end;

function  TWSDLPortType.GetOperations: IWSDLOperationArray;
begin
  Result := FOperationArray;
end;

function  TWSDLPortType.GetGUID: TGUID;
begin
  Result := FIID;
end;

function  TWSDLPortType.GetBinding: DOMString;
begin
  Result := FBinding;
end;

function TWSDLPortType.GetService: DOMString;
begin
  Result := FService;
end;

function TWSDLPortType.GetPort: DOMString;
begin
  Result := FPort;
end;

function TWSDLPortType.GetPortTypeFlags: TPortTypeFlags;
begin
  Result := FFlags;
end;

function TWSDLPortType.GetURL: DOMString;
begin
  Result := FURL;
end;

function TWSDLPortType.GetStyle: DOMString;
begin
  Result := '';
  { First try an operation's style }
  if (GetOperationCount > 0) then
  begin
    Result := GetOperations[0].Style;
  end;

  { Then try the attribute on the binding }
  if Result = '' then
    Result := FStyle;

  { Default }
  if Result = '' then
    Result := SUnknownValue;
end;

function TWSDLPortType.GetUse: DOMString;
begin
  Result := FUse;
  { If the Binding did not have the 'use' attribute, then pick one
    operation's 'use' }
  if  Result = '' then
  begin
    if (GetOperationCount > 0) then
    begin
      Result := GetOperations[0].InputUse;
      if Result = '' then
        Result := GetOperations[0].OutputUse;
    end;
  end;
  if Result = '' then
    Result := SUnknownValue;
end;

function  TWSDLPortType.GetTransport: DOMString;
begin
  Result := FTransport;
end;

function TWSDLPortType.GetHasDefaultSOAPAction: Boolean;
begin
  Result := ioHasDefaultSOAPAction in FInvokeOptions;
end;

function TWSDLPortType.GetHasAllSOAPActions: Boolean;
begin
  Result := ioHasAllSOAPActions in FInvokeOptions;
end;

function  TWSDLPortType.GetSOAPAction: DOMString;
begin
  Result := FSOAPAction;
end;

procedure TWSDLPortType.SetSOAPAction(const soapAction: DOMString; All: Boolean);
begin
  FSOAPAction := soapAction;
  if All then
    FInvokeOptions := FInvokeOptions + [ioHasAllSOAPActions]
  else
    FInvokeOptions := FInvokeOptions + [ioHasDefaultSOAPAction];
end;

function IsPortTypeDerivedFromIAppServerSOAP(const PType: IPortType): Boolean;
const
  OpNames: array[0..6] of string = ( 'SAS_ApplyUpdates',         { do not localize }
                                     'SAS_GetRecords',           { do not localize }
                                     'SAS_DataRequest',          { do not localize }
                                     'SAS_GetProviderNames',     { do not localize }
                                     'SAS_GetParams',            { do not localize }
                                     'SAS_RowRequest',           { do not localize }
                                     'SAS_Execute');             { do not localize }
var
  I: Integer;
begin
  Result := (PType.Operations.Count >= 7) and
            not SameText(PType.Name, 'IAppServerSOAP');             { do not localize }
  if Result then
  begin
    for I := Low(OpNames) to High(OpNames) do
    begin
      if not SameText(PType.Operations[I].Name, OpNames[I]) then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TWSDLPortType.AddOperations(const PortType: IPortType;
                                     const WSDLImporter: IWSDLImporter;
                                     const WSDLItems: TWSDLItems;
                                     const Operations: IOperations;
                                     const BindingName: IQualifiedName;
                                     var SOAPVersion: TSOAPVersion) : Integer;
var
  I, J, Start, Len, OpIndex: Integer;
  Operation: IOperation;
  NewOperation: TWSDLOperation;
  MessageNames: IQualifiedNameArray;
begin
  SetLength(MessageNames, 0);

  Len := Operations.Count;
  Start := 0;

  { Skip first 7 methods of IAppServerSOAP }
  if IsPortTypeDerivedFromIAppServerSOAP(PortType) then
  begin
    Start := 7;
    FBaseInterfaceName := 'IAppServerSOAP';
    FInvokeOptions := FInvokeOptions + [ioIsAppServerSOAP];
    WSDLImporter.Options := WSDLImporter.Options + [woHasSOAPDM];
  end;

  { Load all operation information }
  SetLength(FOperationArray, Len-Start);
  for I := Start to (Len-1) do
  begin
    Operation := Operations[I];
    NewOperation := TWSDLOperation.Create;
    FOperationArray[I-Start] := NewOperation;

    NewOperation.SetName(Operation.Name);

    { Is this an overloaded method }
    OpIndex := 0;
    for J := Start to I-1 do
      if FOperationArray[J-Start].Name = Operation.Name then
        Inc(OpIndex);

    { SOAPAction, Style}
    NewOperation.FSOAPAction := WSDLImporter.GetWSDLItems.GetSOAPAction(FBinding, Operation.Name, OpIndex, SOAPVersion);
    NewOperation.FStyle := WSDLImporter.GetWSDLItems.GetSoapOperationStyle(FBinding, Operation.Name, OpIndex, SOAPVersion);

    { <soap:body ... attributes > }
    NewOperation.FInputUse := WSDLImporter.GetWSDLItems.GetSoapBodyInputAttribute(FBinding, Operation.Name, SUse, OpIndex, SOAPVersion);
    NewOperation.FInputNamespace := WSDLImporter.GetWSDLItems.GetSoapBodyInputAttribute(FBinding, Operation.Name, SNamespace, OpIndex, SOAPVersion);
    NewOperation.FOutputUse := WSDLImporter.GetWSDLItems.GetSoapBodyOutputAttribute(FBinding, Operation.Name, SUse, OpIndex, SOAPVersion);
    NewOperation.FOutputNamespace := WSDLImporter.GetWSDLItems.GetSoapBodyOutputAttribute(FBinding, Operation.Name, SNamespace, OpIndex, SOAPVersion);

    { Save arguments }
    MessageNames := NewOperation.AddParts(WSDLImporter, WSDLItems, Operation, BindingName);

    { Collect Headers }
    if (wfProcessHeaders in Global_WSDLGenFlags) and (BindingName <> nil) then
      NewOperation.AddHeaders(WSDLImporter, WSDLItems, Operation, BindingName, Opindex, MessageNames, SOAPVersion);

    { Collect Faults }
    if (wfProcessFaults in Global_WSDLGenFlags) then
      NewOperation.AddFaults(WSDLImporter, WSDLItems, Operation);
  end;

  Result := Length(FOperationArray);
end;

function TWSDLPortType.FixupOperationParams(const WSDLImporter: IWSDLImporter): TIntfInvokeOptions;

  function AllUnwrapStatus(const List1, List2: UnwrapStatusArray; Stat: UnwrapStatus): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := 0 to Length(List1)-1 do
    begin
      if List1[I] <> Stat then
      begin
        Result := False;
        Exit;
      end;
    end;
    for I := 0 to Length(List2)-1 do
    begin
      if List2[I] <> Stat then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;


var
  I: Integer;
  UnwrapListIn, UnwrapListOut: UnwrapStatusArray;
  UnwindRequested, Unwinding: Boolean;
  WSDLOperation: IWSDLOperation;
  TweakOpts: TTweakPartOpts;
begin
  Result := [];
  Unwinding := False;

  {
    If in 'literal' (i.e. not encoded), see if we have wrapped or bare.
    In the case of wrapped we want to unwrap.
  }
  if GetUse() = 'literal' then { Do not localize }
  begin
    { Now determine what needs to be done to the parts, the literal }
    SetLength(UnwrapListIn, Length(FOperationArray));
    SetLength(UnwrapListOut, Length(FOperationArray));
    for I := 0 to Length(FOperationArray)-1 do
    begin
      UnwrapListIn[I] := FOperationArray[I].CanUnwrap(True);
      UnwrapListOut[I]:= FOperationArray[I].CanUnwrap(False);
    end;

    { Any operations require unwinding }
    if not AllUnwrapStatus(UnwrapListIn, UnwrapListOut, usNotReq) then
    begin
      { Was unwinding requested? }
      UnwindRequested := wfUnwindLiteralParameters in Global_WSDLGenFlags;
      { Here all operations are unwindable }
      if AllUnwrapStatus(UnwrapListIn, UnwrapListOut, usCan) then
      begin
        Unwinding := UnwindRequested;
        for WSDLOperation in FOperationArray do
        begin
          if UnwindRequested then
          begin
            WSDLOperation.HandleLiteralParams(usCan);
            if Length(WSDLOperation.Parts) = 0 then
              continue;
          end
          else
          begin
            WSDLOperation.HandleLiteralParams(usNotReq, True);
          end;
        end;
        { Flag that we have a bare service. 
          NOTE: We use 'ioLiteral' for backwards compatibility because back in the early
                days of Delphi 6/7, when everything was rpc|encoded, 'ioLiteralParams' was incorrectly
                used by the runtime to mean 'bare' literal service }
        if not UnwindRequested then
          Result := Result + [ioLiteral];
      end else
      begin
        { Here we had some that did require but could not... }
        for I := 0 to Length(FOperationArray)-1 do
        begin
          WSDLOperation := FOperationArray[I];
          if (UnwrapListIn[I] <> usNotReq) or
             (UnwrapListOut[I] <> usNotReq)  then
            WSDLOperation.HandleLiteralParams(usCannot, UnwindRequested);
        end;

        { Flag that we have a bare service. 
          NOTE: We use 'ioLiteral' for backwards compatibility because back in the early
                days of Delphi 6/7, when everything was rpc|encoded, 'ioLiteral' was incorrectly
                used by the runtime to mean 'bare' literal service }
        if UnwindRequested then
          Result := Result + [ioLiteral];
      end;
    end;
  end;

  { Now tweak the return param of the operation as necessary }
  if Unwinding then
  begin
    TweakOpts := [tpUnwrapped];
    { And tag the port type as having been unwrapped }
    FFlags := FFlags + [ptfWasUnwrapped];
  end
  else
    TWeakOpts := [];

  for WSDLOperation in FOperationArray do
  begin
    WSDLOperation.TweakReturnParam(WSDLImporter, TweakOpts);
  end;
end;

function TWSDLPortType.GetOperationCount: integer;
begin
  Result := Length(FOperationArray);
end;

function TWSDLPortType.GetWSDLItemType: WSDLItemType;
begin
  Result := wiPortType;
end;

procedure TWSDLPortType.SetSelected(const Sel: Boolean);
var
  I: integer;
begin
  inherited SetSelected(Sel);
  for I := 0 to Length(FOperationArray)-1 do
  begin
    FOperationArray[I].Selected := Sel;
  end;
end;

function TWSDLPortType.GetInvokeOptions: TIntfInvokeOptions;
begin
  Result := FInvokeOptions;
end;

procedure TWSDLPortType.SetInvokeOptions(const InvOptions: TIntfInvokeOptions);
begin
  FInvokeOptions := InvOptions;
end;

function TWSDLPortType.GetBaseInterfaceName: DOMString;
begin
  Result := FBaseInterfaceName;
end;


{ TWSDLType }

function UnwindType(const WSDLType: IWSDLType; ClsOnly: Boolean): IWSDLType;
begin
  Result := WSDLType;
{$IFDEF LOG_TYPES_UNWIND}
  WriteLn(sDottedLine);
{$ENDIF}
  while (Result.DataKind = wtAlias) do
  begin
{$IFDEF LOG_TYPES_UNWIND}
    WriteLn(Result.Name+':'+Result.Namespace);
{$ENDIF}
    { Only unwind class aliases }
    if ClsOnly and (WSDLType.BaseType.DataKind <> wtClass) then
      Exit;
    Result := Result.BaseType;
  end;
end;


constructor TWSDLType.Create;
begin
  inherited Create;
  FXMLItemInfo := [];
end;

destructor  TWSDLType.Destroy;
begin
  SetLength(FEnumValues, 0);
  SetLength(FMembers, 0);
  FBaseType := nil;
  inherited Destroy;
end;

procedure TWSDLType.Cleanup;
var
  WSDLPart: IWSDLPart;
begin
  for WSDLPart in FMembers do
  begin
    WSDLPart.DataType := nil;
  end;

  FDataKind := wtNotDefined;
  FBaseType := nil;
  FAlternateType := nil;
end;

function TWSDLType.GetDataKind: WSDLTypeKind;
begin
  Result := FDataKind;
end;

function TWSDLType.GetTypeInfo: PTypeInfo;
begin
  Result := FTypeInfo;
end;

function TWSDLType.GetEnumValues: IWSDLItemArray;
begin
  Result := FEnumValues;
end;

function TWSDLType.GetAlternateType: IWSDLType;
begin
  Result := FAlternateType;
end;

function TWSDLType.GetBaseType: IWSDLType;
begin
  Result := FBaseType;
end;

function  TWSDLType.GetSerializerOpt: TSerializationOptions;
begin
  Result := FSerializeOpt;
end;

function TWSDLType.GetMembers: IWSDLPartArray;
begin
  Result := FMembers;
end;

function TWSDLType.GetRegInfo: string;
begin
  Result := FRegInfo;
end;

procedure TWSDLType.AddMember(const Member: IWSDLPart);
var
  Len: Integer;
begin
  Len := Length(FMembers);
  SetLength(FMembers, Len+1);
  FMembers[Len] := Member;
end;

procedure TWSDLType.RemoveMember(const Member: IWSDLPart);
var
  I, Len: Integer;
  Found: Boolean;
begin
  Found := False;
  Len := Length(FMembers);
  for I := 0 to Len-1 do
  begin
    Found := Found or (Member = FMembers[I]);
    if (Found) then
    begin
      if (I < (Len-1)) then
        FMembers[I] := FMembers[I+1]
      else
        FMembers[I] := nil;
    end;
  end;
  if Found then
    SetLength(FMembers, Len-1);
end;

function TWSDLType.GetDimensions: integer;
begin
  Result := FDimensions;
end;

function TWSDLType.GetXMLItemInfo: TXMLItemInfo;
begin
  Result := FXMLItemInfo;
end;

function TWSDLType.GetIsUsed: Boolean;
begin
  Result := FIsUsed;

  { NOTE: Headers and Fault types are always used }
  if (not Result) and ((FTypeFlag = wfHeader) or (FTypeFlag = wfFault)) then
  begin
    SetIsUsed(True);
    Result := True;
  end;

  { To support polymorphism, classes are used if their base type is used }
  if (not Result) and ((FDataKind = wtClass) and
                       (FBaseType <> nil) and
                       (FBaseType.IsUsed)) then
  begin
    SetIsUsed(True);
    Result := True;
  end;
end;

procedure TWSDLType.SetXMLItemInfo(const Flag: TXMLItemInfo);
begin
  FXMLItemInfo := Flag;
end;

procedure TWSDLType.SetIsUsed(Used: Boolean);
var
  I: Integer;
begin
  if FIsUsed = Used then
    Exit;

  FIsUsed := Used;
  if Used then
  begin
    if FBaseType <> nil then
      FBaseType.IsUsed := Used;
    if (FMembers <> nil) and (Length(FMembers) > 0) then
    begin
      for I := 0 to Length(FMembers)-1 do
        FMembers[I].DataType.IsUsed := Used;
    end;
  end;
end;

procedure TWSDLType.SetDataKind(const DataKind: WSDLTypeKind);
begin
  FDataKind := DataKind;
end;

procedure TWSDLType.SetTypeInfo(const TypeInfo: PTypeInfo);
begin
  FTypeInfo := TypeInfo;
end;

procedure TWSDLType.SetEnumValues(const enumValues: IWSDLItemArray);
begin
  FEnumValues := enumValues;
end;

procedure TWSDLType.SetBaseType(const baseType: IWSDLType);
{$IFDEF CHECK_CIRCULAR_BASETYPE}
var
  Quick, Slow: IWSDLType;
{$ENDIF}
begin
  FBaseType := baseType;
{$IFDEF VALIDATE_BASETYPE}
  if (FBaseType = nil) and (FDataKind <> wtNotDefined) and (FDataKind <> wtClass) then
    Assert(False, 'Nil basetype specified incorrectly');
  if (FBaseType <> nil) and (FDataKind <> wtAlias) and
     (FDataKind <> wtClass) and (FDataKind <> wtArray) then
    Assert(False, 'Basetype specified for non valid datakind');
{$ENDIF}
{$IFDEF CHECK_CIRCULAR_BASETYPE}
  Quick := Self;
  Slow := Self;
  while (Quick <> nil) do
  begin
    if Quick <> nil then
      Quick := Quick.BaseType;
    if Quick <> nil then
      Quick := Quick.BaseType;
    if Slow <> nil then
      Slow := Slow.BaseType;
    if (Quick = Slow) and (Quick <> nil) then
      Assert(False, Format('BUG - Circular BaseType Reference: (%s:%s) -> (%s:%s) !!',
                           [FName, FNamespace, baseType.Name, baseType.Namespace]));
  end;
{$ENDIF}
end;

{$IFNDEF SPACELY_UP}
var
  _dummystr : string = sCircularTypeLink;
{$ENDIF}

procedure TWSDLType.SetSerializerOpt(const SOpt: TSerializationOptions);
begin
  FSerializeOpt := SOpt;
end;

procedure TWSDLType.SetMembers(const membrs: IWSDLPartArray);
begin
  FMembers := membrs;
end;

procedure TWSDLType.SetRegInfo(const RegInfo: string);
begin
  FRegInfo := RegInfo;
end;

procedure TWSDLType.SetDimensions(dim: Integer);
begin
  FDimensions := dim;
end;

function TWSDLType.GetWSDLItemType: WSDLItemType;
begin
  Result := wiType;
end;

function TWSDLType.GetTypeFlag: WSDLTypeFlag;
begin
  Result := FTypeFlag;
end;

procedure TWSDLType.SetTypeFlag(const TypeFlag: WSDLTypeFlag);
begin
  FTypeFlag := TypeFlag;
end;

{ TWSDLPortTypes }
destructor TWSDLPortTypes.Destroy;
begin
  SetLength(FWSDLPortTypeArray, 0);
  inherited Destroy;
end;

function TWSDLPortTypes.GetPortTypes: IWSDLPortTypeArray;
begin
  Result := FWSDLPortTypeArray;
end;

procedure TWSDLPortTypes.AddPortType(const WSDLPortType: IWSDLPortType);
var
  Len: Integer;
begin
  Len := Length(FWSDLPortTypeArray);
  SetLength(FWSDLPortTypeArray, Len+1);
  FWSDLPortTypeArray[Len] := WSDLPortType;
end;

function TWSDLPortTypes.GetWSDLItemType: WSDLItemType;
begin
  Result := wiPortTypes;
end;

procedure TWSDLPortTypes.SetSelected(const Sel: Boolean);
var
  I: Integer;
begin
  inherited SetSelected(Sel);
  for I := 0 to Length(FWSDLPortTypeArray)-1 do
    FWSDLPortTypeArray[I].Selected := Sel;
end;

procedure TWSDLPortTypes.Clear;
begin
  SetLength(FWSDLPortTypeArray, 0);
end;

{ TWSDLTypes }

constructor TWSDLTypes.Create;
begin
  inherited;
{$IFDEF CACHE_TYPES}
  FTypesCache := TTypesCache.Create;
{$ENDIF}
end;

destructor TWSDLTypes.Destroy;
begin
  SetLength(FWSDLTypeArray, 0);
{$IFDEF CACHE_TYPES}
  FTypesCache.Free;
{$ENDIF}
  inherited Destroy;
end;

function TWSDLTypes.GetTypes: IWSDLTypeArray;
begin
  Result := FWSDLTypeArray;
end;

function TWSDLTypes.IndexOf(const WSDLType: IWSDLType): Integer;
var
  Index: integer;
begin
  Result := -1;
  for Index := 0 to Length(FWSDLTypeArray)-1 do
  begin
    if FWSDLTypeArray[Index] = WSDLType then
    begin
      Result := Index;
      Exit;
    end;
  end;
end;

function GetTypeKey(const AName: DOMString;
                    const ANamespace: DOMString): string; overload;
begin
  Result := Format('%s:%s', [AName, ANamespace]);
end;

function GetTypeKey(const WSDLType: IWSDLType): string; overload;
begin
  Result := GetTypeKey(WSDLType.Name, WSDLType.Namespace);
end;

function TWSDLTypes.FindType(const Name, Namespace: DOMString;
                             const HasThese: TXMLItemInfo;
                             const DoesNotHaveThese: TXMLItemInfo;
                             Create: Boolean): IWSDLType;

var
  WSDLType: IWSDLType;
  I: Integer;
{$IFDEF CACHE_TYPES}
  TypeKey: string;
  TypeVals: PointerArray;
{$ENDIF}
begin
{$IFDEF LOG_TYPES_LOOKUP}
  Write('LOOKUP: ' + Name + ':' + Namespace + ', +['+
        SetToStr(TypeInfo(XMLItemInfo), Word(HasThese), False) + '], -['+
        SetToStr(TypeInfo(XMLItemInfo), Word(DoesNotHaveThese), False) + '] ');
{$ENDIF}
  Assert(HasThese * DoesNotHaveThese = [],
         Format('TWSDLTypes.FindType: "%s:%s " +[%s] -[%s]: Invalid XMLItemInfo',
                [Name, Namespace, SetToStr(TypeInfo(XMLItemInfo), Word(HasThese), False),
                                  SetToStr(TypeInfo(XMLItemInfo), Word(DoesNotHaveThese), False)]));
{$IFDEF CACHE_TYPES}
  TypeKey := GetTypeKey(Name, Namespace);
  if FTypesCache.ContainsKey(TypeKey) then
  begin
    TypeVals := FTypesCache[TypeKey];
    for I :=0 to Length(TypeVals)-1 do
    begin
      WSDLType := IWSDLType(TypeVals[I]);
      if (HasThese <= WSDLType.XMLItemInfo) and
         (DoesNotHaveThese * WSDLType.XMLItemInfo = []) then
      begin
        Result := WSDLType;
  {$IFDEF LOG_TYPES_LOOKUP}
        WriteLn('FOUND');
  {$ENDIF}
        Exit;
      end;
    end;
  end;
{$ELSE}
  for I :=0 to Length(FWSDLTypeArray)-1 do
  begin
    WSDLType := FWSDLTypeArray[I];
    if (WSDLType.Name = Name) and
       (WSDLType.Namespace = Namespace) and
       (HasThese <= WSDLType.XMLItemInfo) and
       (DoesNotHaveThese * WSDLType.XMLItemInfo = []) then
    begin
      Result := WSDLType;
{$IFDEF LOG_TYPES_LOOKUP}
      WriteLn('FOUND');
{$ENDIF}
      Exit;
    end;
  end;
{$ENDIF}

  if Create then
  begin
    Result := AddType(Name, Namespace, HasThese);
{$IFDEF LOG_TYPES_LOOKUP}
    WriteLn('CREATED');
{$ENDIF}
  end
  else
  begin
{$IFDEF LOG_TYPES_LOOKUP}
    WriteLn('NOT FOUND');
{$ENDIF}
    Result := nil;
  end;
end;

function TWSDLTypes.GenArrayType(const WSDLType: IWSDLType; const Tag: Boolean): IWSDLType;
const
  SArrayPrefix = 'Array_Of_';
var
  Tmp: IWSDLType;
begin
{$IFDEF PRECONDITION_ON}
  Assert(not (xtiFakeUnboundedType in WSDLType.XMLItemInfo));
{$ENDIF}
  { First find an existing type that matches }
  for Tmp in FWSDLTypeArray do
  begin
    if (Tmp.DataKind = wtArray) and (Tmp.BaseType = WSDLType) then
    begin
      if (not Tag) or (xoInlineArrays in Tmp.SerializationOpt) then
      begin
        Result := Tmp;
        Exit;
      end;
    end;
  end;

  if xtiGlobal in WSDLType.XMLItemInfo then
  begin
    { Next find a fake one we've created already, maybe - or create one }
    Result := FindType(SArrayPrefix+WSDLType.Name,
                       WSDLType.Namespace, [xtiFakeUnboundedType, xtiGlobal],
                       [xtiComplex, xtiElement, xtiSimple], False);
    if (Result <> nil) then
    begin
      { Make sure it's tagged if requested }
      if Tag and not (xoInlineArrays in Result.SerializationOpt) then
        Result.SerializationOpt := Result.SerializationOpt + [xoInlineArrays];
      Exit;
    end;

    { Here we create it}
    Result := FindType(SArrayPrefix+WSDLType.Name,
                       WSDLType.Namespace, [xtiFakeUnboundedType, xtiGlobal],
                       [xtiComplex, xtiElement, xtiSimple], True);
  end
  else
    { For anonymous types, we just create a new array }
    Result := AddType(SArrayPrefix+WSDLType.Name,
                      WSDLType.Namespace, [xtiFakeUnboundedType]);

  Result.DataKind := wtArray;
  Result.BaseType := WSDLType;
  Result.Dimensions := 1;
  if Tag then
  begin
    Result.SerializationOpt := [xoInlineArrays];
  end;
end;

function  TWSDLTypes.GenAliasType(const WSDLType: IWSDLType;
                                  const Name: DOMString;
                                  const Namespace: DOMString): IWSDLType;
var
  Tmp: IWSDLType;
begin
  { First find an existing type that matches }
  for Tmp in FWSDLTypeArray do
  begin
    if (Tmp.DataKind = wtAlias) and (Tmp.BaseType = WSDLType) and (Tmp.Name = Name) then
    begin
      Result := Tmp;
      Exit;
    end;
  end;

  { Here we create it}
  Result := AddType(Name, Namespace, [xtiFakeAliasType]);
  Result.DataKind := wtAlias;
  Result.BaseType := WSDLType;
end;

{ Overloaded version that adds a class-based type }
function TWSDLTypes.AddType(const Name,  Namespace: DOMString;
                            XMLItemInfo: TXMLItemInfo;
                            IsScalar: Boolean;
                            IsA: TClass): IWSDLType;
var
  I: Integer;
  RegEntry: TRemRegEntry;
  AltType: TWSDLType;
begin
  for I:= 0 to RemClassRegistry.GetURICount-1 do
  begin
    RegEntry := RemClassRegistry.GetURIMap(I);
    if (RegEntry.URI = Namespace) and
       (RegEntry.Name= Name) and
       (RegEntry.Info <> nil) and
       (RegEntry.Info.Kind = tkClass) and
       (RegEntry.IsScalar = IsScalar) and
       (GetTypeData(RegEntry.Info).ClassType.InheritsFrom(IsA)) then
    begin
      AltType := TWSDLType.Create;
      Result  := AltType;
      AltType.FName := Name;
      AltType.FNamespace := Namespace;
      AltType.FTypeInfo := RegEntry.Info;
      AltType.FXMLItemInfo := XMLItemInfo + [xtiForNillable];
      AddType(AltType);

      break;
    end;
  end;

end;


function TWSDLTypes.AddType(const Name,  Namespace: DOMString; XMLItemInfo: TXMLItemInfo): IWSDLType;
var
  NewType: TWSDLType;
begin
  NewType := TWSDLType.Create;
  NewType.FName := Name;
  NewType.FNamespace := Namespace;
  NewType.FTypeInfo := RemClassRegistry.URIToInfo(Namespace, Name);
  NewType.FXMLItemInfo := XMLItemInfo;

  Result := NewType;
  AddType(Result);

  { Here we check if we need to duplicate the type for Nillable support }
  { If there's any TXSType registered for an XML type we're processing, we'll
    tag it to the XML type }
  if (wfUseXSTypeForSimpleNillable in Global_WSDLGenFlags) then
  begin
    if (NewType.FTypeInfo <> nil) and
       (NewType.FTypeInfo.Kind <> tkClass) and
       (Namespace = XMLSchemaNamespace) and
       (xtiGlobal in XMLItemInfo) then
    begin
      NewType.FAlternateType := AddType(Name, Namespace, XMLItemInfo, True, TRemotableXS);
    end;
  end;


{$IFDEF SIMULATE_LEAK}
  NewType := TWSDLType.Create;
{$ENDIF}
end;

procedure TWSDLTypes.AddType(const WSDLType: IWSDLType);
var
  Len: Integer;
{$IFDEF CACHE_TYPES}
  TypeKey: string;
  TypeVals: PointerArray;
{$ENDIF}
begin
  Assert(WSDLType <> nil, 'Error - Adding nil type');
{$IFDEF CACHE_TYPES}
  TypeKey := GetTypeKey(WSDLType);
  if FTypesCache.ContainsKey(TypeKey) then
  begin
    TypeVals := FTypesCache[TypeKey];
    Len := Length(TypeVals);
    SetLength(TypeVals, Len+1);
    TypeVals[Len] := Pointer(WSDLType);
  end
  else
  begin
    SetLength(TypeVals, 1);
    TypeVals[0] := Pointer(WSDLType);
  end;
  FTypesCache.AddOrSetValue(TypeKey, TypeVals);
{$ENDIF}
  Len := Length(FWSDLTypeArray);
  SetLength(FWSDLTypeArray, Len+1);
  FWSDLTypeArray[Len] := WSDLType;
end;

procedure TWSDLTypes.Clear;
begin
  SetLength(FWSDLTypeArray, 0);
end;

function TWSDLTypes.GetWSDLItemType: WSDLItemType;
begin
  Result := wiTypes;
end;

procedure TWSDLTypes.Move(CurIndex: Integer; NewIndex: Integer);
var
  Index: Integer;
  Movee: IWSDLType;
begin
  if curIndex = newIndex then
    Exit;
  { Save moving item }
  Movee := FWSDLTypeArray[curIndex];
  { Move items down/up }
  { Favor moving from low to high index since that's the only kind of movin' we do }
  if newIndex > curIndex then
  begin
    for Index := curIndex to newIndex-1 do
      FWSDLTypeArray[Index] := FWSDLTypeArray[Index+1];
  end
  else
  begin
    for Index := curIndex downto newIndex+1 do
      FWSDLTypeArray[Index] := FWSDLTypeArray[Index-1];
  end;
  { Move 'em }
  FWSDLTypeArray[newIndex] := Movee;
end;

procedure TWSDLTypes.SetSelected(const Sel: Boolean);
var
  I: Integer;
begin
  inherited SetSelected(Sel);
  for I := 0 to Length(FWSDLTypeArray)-1 do
    FWSDLTypeArray[I].Selected := Sel;
end;

procedure TWSDLTypes.Swap(Index1, Index2: Integer);
var
  Temp: IWSDLType;
begin
  Temp := FWSDLTypeArray[Index1];
  FWSDLTypeArray[Index1] := FWSDLTypeArray[Index2];
  FWSDLTypeArray[Index2] := Temp;
end;

function TWSDLTypes.GetType(Index: Integer): IWSDLType;
begin
  Result := FWSDLTypeArray[Index];
end;


{ TMIMEPart }

function TMIMEPart.GetMIMEType: DOMString;
begin
  Result := FMIMEType;
end;

function TMIMEPart.GetMessageName: DOMString;
begin
  Result := FMessageName;
end;

function TMIMEPart.GetOperationName: DOMString;
begin
  Result := FOperationName;
end;

procedure TMIMEPart.SetOperationName(const Name: DOMString);
begin
  FOperationName := Name;
end;

function TMIMEPart.GetName: DOMString;
begin
  Result := FName;
end;

function TMIMEPart.GetArgType: ArgumentType;
begin
  Result := FArgumentType;
end;

procedure TMIMEPart.SetMIMEType(const Name: DOMString);
begin
  FMIMEType := Name;
end;

procedure TMIMEPart.SetMessageName(const Name: DOMString);
begin
  FMessageName := Name;
end;

procedure TMIMEPart.SetName(const AName: DOMString);
begin
  FName := AName;
end;

procedure TMIMEPart.SetArgType(const AArgType: ArgumentType);
begin
  FArgumentType := AArgType;
end;

function WriteFactory(const WSDLPortType: IWSDLPortType): FactProcType;
begin
  Result := ftNone;
  if (wfServer in Global_WSDLGenFlags) or
     (ioIsAppServerSOAP in WSDLPortType.InvokeOptions) then
    Exit;

  if (WSDLPortType.Service <> '') and
     (WSDLPortType.Port    <> '') then
    Result := ftWSDLURL
  else
  begin
    if WSDLPortType.URL <> '' then
      Result := ftURL
    else
      Result := ftNoURL;
  end;
end;

// Returns full path to WSDLImp.sym file
function GetSymFilename: string;
begin
  // Start in the startup directory of the IDE/WSDLIMP
  Result := ExtractFilePath(ParamStr(0)) + 'WSDLImp.sym';     // Do not localize.
  if not FileExists(Result) then
  begin
    // Next, look in the current directory
    Result := GetCurrentDir + '\WSDLImp.sym';                 // Do not localize.
    if not FileExists(Result) then
    begin
      Result := ExtractFilePath(ParamStr(0)) + '..\bin\WSDLImp.sym'; // Do not localize.
    end;
  end;
end;

// Function to lookup a symbol in WSDLImp.sym and return an alternate name, if one was provided
//
function IsRenamedInSymFile(const AName: string; const Section: DOMString; IsCplusplusNotDelphi: Boolean; var NewName: DOMString): Boolean;
const
  LanguageString : array [Boolean] of string = ( 'Pascal', 'C++' );
var
  sectionName: string;
begin
  // Look for [Language:Section]
  sectionName := LanguageString[IsCplusplusNotDelphi] + ':' + Section;
  if WSDLImpDotSym.SectionExists(sectionName) then
  begin
    NewName := WSDLImpDotSym.ReadString(sectionName, AName, AName);
    if NewName <> AName then
    begin
      Result := True;
      Exit;
    end;
  end;
  // Didnt find anything ??
  Result := False;
  NewName:= AName;
end;

// Function to lookup a symbol in WSDLImp.sym and return an alternate name, if one was provided
//
function IsReservedNameInSymFile(const AName: DOMString; IsCplusplusNotDelphi: Boolean; var NewName: DOMString): Boolean;
begin
  Result := IsRenamedInSymFile(AName, 'Reserved', IsCplusplusNotDelphi, NewName);
end;


{ TWSDLPartFixer }

procedure TWSDLPartFixer.Cleanup;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

constructor TWSDLPartFixer.Create(PartToFix: IWSDLPart);
begin
  FWSDLPart := PartToFix;
end;

destructor TWSDLPartFixer.Destroy;
begin
  inherited;
end;

procedure TWSDLPartFixer.AddMember(const Member: IWSDLPart);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.RemoveMember(const Member: IWSDLPart);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetAlternateType: IWSDLType;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetBaseType: IWSDLType;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetDataKind: WSDLTypeKind;
begin
  Result := wtAlias;
end;

function TWSDLPartFixer.GetDimensions: integer;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetEnumValues: IWSDLItemArray;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetIsUsed: Boolean;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetMembers: IWSDLPartArray;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetRegInfo: string;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetSerializerOpt: TSerializationOptions;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetTypeFlag: WSDLTypeFlag;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetTypeInfo: PTypeInfo;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

function TWSDLPartFixer.GetXMLItemInfo: TXMLItemInfo;
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetBaseType(const WSDLType: IWSDLType);
begin
  FWSDLPart.DataType := WSDLType;
end;

procedure TWSDLPartFixer.SetDataKind(const DataKind: WSDLTypeKind);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetDimensions(dim: Integer);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetEnumValues(const enumValues: IWSDLItemArray);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetIsUsed(Used: Boolean);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetMembers(const membrs: IWSDLPartArray);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetRegInfo(const RegInfo: string);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetSerializerOpt(const SOpt: TSerializationOptions);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetTypeFlag(const TypeFlag: WSDLTypeFlag);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetTypeInfo(const TypeInfo: PTypeInfo);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

procedure TWSDLPartFixer.SetXMLItemInfo(const Flag: TXMLItemInfo);
begin
  raise Exception.Create(sMethodNotImplemented);
end;

{ TProcessedTracker }

procedure TProcessedTracker.AddProcessed(const Name: DOMString);
begin
  FProcessedList.Add(Name);
end;

procedure TProcessedTracker.Clear;
begin
  FProcessedList.Clear;
end;

constructor TProcessedTracker.Create;
begin
  FProcessedList := TDOMStrings.Create;
end;

destructor TProcessedTracker.Destroy;
begin
  FProcessedList.Free;
end;

function TProcessedTracker.GetCount: Integer;
begin
  Result := FProcessedList.Count;
end;

function TProcessedTracker.GetItem(Index: Integer): DOMString;
begin
  Result := FProcessedList[Index];
end;

function TProcessedTracker.ProcessedAlready(const Name: DOMString): Boolean;
begin
  Result := FProcessedList.IndexOfIgnoreCase(Name) <> -1;
end;

procedure LoadExcludeFromRenameNamesFromDotSym;
const
  NoRenameSection = 'NoRename';
begin
  WSDLImpDotSym.ReadSectionValues(NoRenameSection, ExcludedFromRenameList);
end;

type
   TWSDLGenFlagsComparer = TComparer<WSDLGenFlags>;

function  GetSortedWSDLGenFlags: TArray<WSDLGenFlags>;
var
  CurrFlag: WSDLGenFlags;
  FlagsOrder: TList<WSDLGenFlags>;
begin
  FlagsOrder := TList<WSDLGenFlags>.Create;
  try
    for CurrFlag := Low(WSDLGenFlags) to High(WSDLGenFlags) do
      FlagsOrder.Add(CurrFlag);
    FlagsOrder.Sort(TWSDLGenFlagsComparer.Construct(
      function (const L, R: WSDLGenFlags): Integer
      begin
        Result := CompareText(OptCommandLineFlags[L],
                              OptCommandLineFlags[R]);
      end));
    Result := FlagsOrder.ToArray;
  finally
    FlagsOrder.Free;
  end;
end;

{ TRegInfoAttribute }
function GetRegInfo(const InfoStr: string;
                    const Key: string;
                    out Value: string): Boolean;

  function Match(P1: PChar; P2: PChar): Boolean; inline;
  begin
    while (P1^ = P2^) and (P2^ <> #0) do
    begin
      Inc(P1);
      Inc(P2);
    end;
    Result := (P2^ = #0) and ((P1^ <= ' ') or (P1^ = '='));
  end;

const
  Alpha = ['A'..'Z', 'a'..'z'];
var
  Len: Integer;
  P1, P2, P3, PEnd: PChar;
  Quote: Char;
  HaveMatch: Boolean;
begin
  Result := False;
  Len := Length(InfoStr);
  if (Len < 3) or
     (InfoStr[1] <> INFOATTR_BEG_CHAR) or
     (InfoStr[Len] <> INFOATTR_END_CHAR) then
    Exit;
  P1 := @InfoStr[2];
  P2 := @Key[1];
  P3 := nil;
  PEnd := @InfoStr[Len];
  repeat
    while P1^ <= ' ' do
      Inc(P1);
    HaveMatch := Match(P1, P2);
    if HaveMatch then
      Inc(P1, Length(P2))
    else
    begin
      while (CharInSet(P1^, Alpha)) do
        Inc(P1);
    end;
    while (P1^ <= ' ') do
      Inc(P1);
    if (P1^ <> '=') then
      Exit;
    Inc(P1);
    while (P1^ <= ' ') do
      Inc(P1);
    Quote := P1^;
    if (Quote <> '''') and (Quote <> '"') and (Quote <> '`') then
      Exit;
    Inc(P1);
    if HaveMatch then
      P3 := P1;
    while (P1 < PEnd) and (P1^ <> Quote) do
      Inc(P1);
    if P1^ <> Quote then
      Exit;
    if HaveMatch then
    begin
      Value := WideCharLenToString(P3, P1-P3);
      Result := True;
      Exit;
    end;
    Inc(P1);
    while (P1^ <= ' ') or (P1^ = ',') do
      Inc(P1);
  until (P1 = PEnd);
end;

procedure TRegInfoAttribute.Reset;
begin
  SetLength(Attrs, 0);
  SetLength(Values, 0);
end;

procedure TRegInfoAttribute.SetAttr(Attr: InfoAttribute;
                                    const Value: string);
var
  I, Len: Integer;
begin
  Len := Length(Attrs);
  for I := 0 to Len-1 do
  begin
    if Attrs[I] = Attr then
    begin
      // NOTE: Don't need ability to clear
      //       but could do so on empty 'Value'
      Values[I] := Value;
      Exit;
    end;
  end;

  SetLength(Attrs, Len+1);
  SetLength(Values, Len+1);
  Attrs[Len] := Attr;
  Values[Len] := Value;
end;

function TRegInfoAttribute.HasAttr: Boolean;
begin
  Result := Length(Attrs) > 0;
end;


function TRegInfoAttribute.Load(const AttrStr: string): Integer;
var
  R: InfoAttribute;
  Value: string;
begin
  Result := 0;
  for R := low(InfoAttribute) to high(InfoAttribute) do
  begin
    if GetRegInfo(AttrStr, InfoAttributeStr[R], Value) then
    begin
      SetAttr(R, Value);
      Inc(Result);
    end;
  end;
end;

function TRegInfoAttribute.AsString(UseSingleQuote: Boolean): string;
const
  Delim: array[Boolean] of string = ('', ', ');
  Quotes: array[Boolean] of string = ('"', '''');
var
  I: Integer;
  Key, Value, Quote: string;
begin
  Result := INFOATTR_BEG_CHAR;
  for I := Low(Attrs) to High(Attrs) do
  begin
    Key := InfoAttributeStr[Attrs[I]];
    Value:= Values[I];
    Quote := Quotes[UseSingleQuote];
    if Pos(Quote, Value) > 0 then
      Quote := '`';
    Result := Format('%s%s%s=%s%s%s', [Result, Delim[I>0], Key,
                                       Quote, Value, Quote]);
  end;
  Result := Result + INFOATTR_END_CHAR;
end;




initialization
  { By having two flags, we can keep track of settings the user overrides }
  Global_WSDLGenFlags := Default_WSDLGenFlags;
  DefaultReturnParamNames := SDefaultReturnParamNames;
  WSDLImpDotSym := TMemIniFile.Create(GetSymFileName);
  ExcludedFromRenameList := TStringList.Create;
  LoadExcludeFromRenameNamesFromDotSym;
  Xml.Win.msxmldom.MSXMLDOMDocumentFactory.AddDOMProperty('ProhibitDTD', false);
finalization
  ExcludedFromRenameList.Free;
  WSDLImpDotSym.Free;


end.
