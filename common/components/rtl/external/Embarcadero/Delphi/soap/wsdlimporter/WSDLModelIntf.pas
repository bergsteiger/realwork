{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit WSDLModelIntf;

interface

uses
  XmlSchema, Classes, TypInfo, WSDLBind, InvokeRegistry, UDDIHlprDesign, WSDLItems, xmldom;

type
  { Describe a basic WSDLItem - Note some of the types, wiTypes and wiPortTypes, for example,
    are really for UI display - i.e. they serve no real purpose in the Model
    other than grouping }
  WSDLItemType = (wiUndefined,  // 0
                  wiPortType,   // 1
                  wiOperation,  // 2
                  wiPart,       // 3
                  wiType,       // 4
                  wiTypes,      // 5
                  wiPortTypes); // 6

  ArrayOfString = array of string;

  ///<summary>
  ///  Base interface of every element found in a WSDL File.
  ///</summary>
  IWSDLItem = interface
  ['{D4D73214-8431-43D0-BEA4-15B59F4ECA30}']
    function  GetName: DOMString;
    function  GetLangName: DOMString;
    procedure SetLangName(const lName: DOMString);
    function  GetDocumentation: DOMString;
    function  GetWSDLItemType: WSDLItemType;

    function  GetSelected: Boolean;
    procedure SetSelected(const Sel: Boolean);
    function  GetNotes: ArrayOfString;
    procedure AddNote(const Note: string);
    procedure SetDocumentation(const doc: DOMString);
    procedure Rename(const NewName: DOMString);

    property  Name: DOMString read GetName;
    property  LangName: DOMString read GetLangName write SetLangName;
    property  Documentation: DOMString read GetDocumentation write SetDocumentation;
    property  ItemType: WSDLItemType read GetWSDLItemType;
    property  Selected: Boolean read GetSelected write SetSelected;
    property  Notes: ArrayOfString read GetNotes;
  end;

  { IWSDLItemArray }
  IWSDLItemArray = array of IWSDLItem;

  { IWSDLItemNS }
  IWSDLItemNS = interface(IWSDLItem)
  ['{86EFFCA7-F7A9-4292-AFC9-6582DD2EB81C}']
    function  GetNamespace: DOMString;
    procedure SetNamespace(const nspace: DOMString);
    property  Namespace: DOMString read GetNamespace write SetNamespace;
  end;

  { Forward ref. all interfaces }
  IWSDLPart      = interface;
  IWSDLOperation = interface;
  IWSDLPortType  = interface;
  IWSDLType      = interface;
  IWSDLImporter  = interface;
  IWSDLTypes     = interface;
  IWSDLPortTypes = interface;

  /// <summary>
  ///  Flag the describes a part or parameter
  /// </summary>
  PartType     = (pUnknown, pIn, pOut, pInOut, pReturn, pAttribute, pDefaultArray);
  TPartType    = set of PartType;

  /// <summary>
  ///  Flag that describes a WSDL part (or an XML element)
  /// </summary>
  ///
  PartFlag     = (pfOptional,        { minOccurs=0 or use="optional" }
                  pfUnbounded,       { maxOccurs="unbounded" or maxOccurs=n where n > 1 }
                  pfNillable,        { nillable ="true" }
                  pfFormUnqualified, { form="unqualified" or elementFormDefault="unqualified" }
                  pfText,            { Maps to the text of the node - i.e. Simple content }
                  pfAny,             { Maps to xsd:any }
                  pfRef,             { Has 'ref' attribute }
                  pfFormQualified    { For Qualified attributes }
                  );
  TPartFlag    =  set of PartFlag;

  ArgumentType = (argIn, argOut, argInOut, argReturn);

  { IWSDLPart }
  IWSDLPart = interface(IWSDLItemNS)
  ['{55B4FF2E-F401-45E5-BBB6-51435634464D}']
    function  GetPartKind: PartType;
    procedure SetPartKind(const pt: PartType);
    function  GetDataType: IWSDLType;
    procedure SetDataType(const DataType: IWSDLType);
    function  GetPartFlags: TPartFlag;
    procedure SetPartFlags(const PartFlag: TPartFlag);
    function  GetRequired: Boolean;
    procedure SetRequired(Flag: Boolean);
    function  GetDefaultValue: DOMString;
    function  GetRegInfo: DOMString;
    procedure SetRegInfo(const ARegInfo: DOMString);

    function  Clone: IWSDLPart;

    property DataType: IWSDLType read GetDataType write SetDataType;
    property PartKind: PartType read GetPartKind write SetPartKind;
    property PartFlags: TPartFlag read GetPartFlags write SetPartFlags;
    property Required: Boolean read GetRequired write SetRequired;
    property DefaultValue: DOMString read GetDefaultValue;
    property RegInfo: DOMString read GetRegInfo write SetRegInfo;
  end;

  { IPartArray }
  IWSDLPartArray = array of IWSDLPart;

  IMIMEPart = interface
  ['{F2402663-322B-11D6-BFB2-00C04F79AB6E}']
    function  GetName: DOMString;
    procedure SetName(const AName: DOMString);
    function  GetOperationName: DOMString;
    procedure SetOperationName(const OName: DOMString);
    function  GetMessageName: DOMString;
    procedure SetMessageName(const Name: DOMString);
    function  GetMIMEType: DOMString;
    procedure SetMIMEType(const MType: DOMString);
    function  GetArgType: ArgumentType;
    procedure SetArgType(const AArgType: ArgumentType);

    property  MIMEType: DOMString read GetMIMEType write SetMIMEType;
    property  MessageName: DOMString read GetMessageName write SetMessageName;
    property  Name: DOMString read GetName write SetName;
    property  ArgType: ArgumentType read GetArgType write SetArgType;
    property  OperationName: DOMString read GetOperationName write SetOperationName;
  end;

  IMIMEPartArray = array of IMIMEPart;

  { Indicates whether Unwinding is necessary/doable }
  UnwrapStatus = (usNotReq,  {We don't need to unwrap - RPC|Encoded services, for example }
                  usCan,     { We can unwrap }
                  usCannot); { Parts cannot be unwrapped}
  UnwrapStatusArray = array of UnwrapStatus;

  TweakPartOpt = (tpNone, tpUnwrapped);
  TTweakPartOpts = set of TweakPartOpt;

  CannotUnwrap = (cuInputMessageHasMoreThanOnePart,
                  cuOutputMessageHasMoreThanOnePart,
                  cuInputPartRefersToTypeNotElement,
                  cuOutputPartRefersToTypeNotElement,
                  cuInputWrapperElementNotSameAsOperationName,
                  cuInputPartNotAComplexType,
                  cuOutputPartNotAComplexType,
                  cuMoreThanOneStrictlyOutMembersWereFound,
                  cuTypeNeedsSpecialSerialization,
                  cuOutputElementIsAPureCollection
                  );
  TCannotUnwrap = set of CannotUnwrap;


  { IWSDLOperation }
  IWSDLOperation = interface(IWSDLItem)
  ['{7D017A89-8319-4212-B9E0-A509FF223D35}']
    function  GetParts: IWSDLPartArray;
    function  GetHeaders: IWSDLPartArray;
    function  GetFaults: IWSDLPartArray;
    function  IsOverloaded: Boolean;
    function  GetSOAPAction: DOMString;
    function  GetStyle: DOMString;
    function  GetInputUse: DOMString;
    function  GetInputNamespace: DOMString;
    function  GetOuputUse: DOMString;
    function  GetOuputNamespace: DOMString;
    function  GetReturnIndex: integer;
    procedure SetOverloaded(const Value: Boolean);
    function  GetCannotUnwrap: TCannotUnwrap;
    function  GetInputWrapper: IWSDLPart;
    function  GetOutputWrapper: IWSDLPart;

    { Used by PortType to unwrap literal }
    procedure TweakReturnParam(const Importer: IWSDLImporter; Opts: TTweakPartOpts);
    procedure HandleLiteralParams(UnwindStat: UnwrapStatus; UseLiteralParams: Boolean = False);
    function  CanUnwrap(Input: Boolean): UnwrapStatus;

    property Parts: IWSDLPartArray read GetParts;
    property Headers: IWSDLPartArray read GetHeaders;
    property Faults: IWSDLPartArray read GetFaults;
    property Overloaded: Boolean read IsOverloaded write SetOverloaded;
    property Style: DOMString read GetStyle;
    property SOAPAction: DOMString read GetSOAPAction;
    property InputUse: DOMString read GetInputUse;
    property InputNamespace: DOMString read GetInputNamespace;
    property OutputUse: DOMString read GetOuputUse;
    property OutputNamespace: DOMString read GetOuputNamespace;
    property ReturnIndex: integer read GetReturnIndex;
    property CannotUnwrap: TCannotUnwrap read GetCannotUnwrap;
    property InputWrapper: IWSDLPart read GetInputWrapper;
    property OutputWrapper: IWSDLPart read GetOutputWrapper;
  end;

  { IOperationArray }
  IWSDLOperationArray = array of IWSDLOperation;

  PortTypeFlags = (ptfWasUnwrapped);

  TPortTypeFlags = set of PortTypeFlags;

  { TPortType }
  IWSDLPortType = interface(IWSDLItemNS)
  ['{57F2F8C6-55EF-49FA-B370-C0C8E2A7EE60}']
    function  GetOperationCount: integer;
    function  GetOperations: IWSDLOperationArray;
    function  GetGUID: TGUID;
    function  GetBinding: DOMString;
    function  GetService: DOMString;
    function  GetPort: DOMString;
    function  GetURL: DOMString;
    function  GetStyle: DOMString;
    function  GetUse: DOMString;
    function  GetTransport: DOMString;
    function  GetSOAPAction: DOMString;
    procedure SetSOAPAction(const soapAction: DOMString; All: Boolean);
    function  GetHasDefaultSOAPAction: Boolean;
    function  GetHasAllSOAPActions: Boolean;
    function  GetInvokeOptions: TIntfInvokeOptions;
    function  GetBaseInterfaceName: DOMString;
    procedure SetInvokeOptions(const InvOptions: TIntfInvokeOptions);
    function  GetPortTypeFlags: TPortTypeFlags;

    property Operations: IWSDLOperationArray read GetOperations;
    property OperationCount: integer read GetOperationCount;
    property GUID: TGUID read GetGUID;
    property Binding: DOMString read GetBinding;
    property Service: DOMString read GetService;
    property Port: DOMString read GetPort;
    property URL: DOMString read GetURL;
    property Style: DOMString read GetStyle;
    property Use: DOMString read GetUse;
    property Transport: DOMString read GetTransport;
    property HasDefaultSOAPAction: Boolean read GetHasDefaultSOAPAction;
    property HasAllSOAPActions: Boolean read GetHasAllSOAPActions;
    property SOAPAction: DOMString read GetSOAPAction;
    property InvokeOptions: TIntfInvokeOptions read GetInvokeOptions write SetInvokeOptions;
    property BaseInterfaceName: DOMString read GetBaseInterfaceName;
    property Flags: TPortTypeFlags read GetPortTypeFlags;
  end;

  { TPortTypeArray }
  IWSDLPortTypeArray = array of IWSDLPortType;

  { ArrayOfIPortType }
  ArrayOfIPortType = array of IPortType;

  { Languge Type Binding of a type }
  WSDLTypeKind = (wtNotDefined,       { Was not explicitly defined but referred to    }
                  wtDuplicate,        { Type redefined - usually in another namespace }
                  wtEnumeration,      { Enumeration           }
                  wtAlias,            { Type alias            }
                  wtArray,            { Array                 }
                  wtClass,            { Structure/class       }
                  wtAttrGroup,        { AttributeGroup        }
                  wtElemGroup);       { ElementGroup          }

  { Flag that describes what a type is used for }
  WSDLTypeFlag = (wfNone,
                  wfLiteralParam,
                  wfFault,
                  wfHeader,
                  wfArrayAsClass);

  XMLItemInfo = (
    xtiGlobal,    { XML Type is not anonymous - it's Global }
    xtiKnownType, { Refers to known type }
    xtiElement,   { XML Type is an <element... > }
    xtiComplex,   { XML Type is a <complexType... > }
    xtiSimple,    { XML Type is a <simpleType... > }
    xtiAttribute, { XML Type is an <attribute... > }
    xtiAttrGroup, { XML Type is an <attributeGroup ... > }
    xtiElemGroup, { XML Type is a  <group...> }
    xtiFakeUnboundedType,   { Array Type created by importer }
    xtiFakeAliasType,       { Alias Type created by importer }
    xtiForNillable,         { Alias Type for nillable instances }
    xtiMixed                { mixed="true" }
  );
  TXMLItemInfo = set of XMLItemInfo;

  { Array of IWSDLType }
  IWSDLTypeArray = array of IWSDLType;

  { IWSDLTypes }
  IWSDLTypes = interface(IWSDLItem)
  ['{A4A3FFE7-A204-4001-99B1-E8229D1D5F59}']
    function  FindType(const Name, Namespace: DOMString;
                       const HasThese: TXMLItemInfo;
                       const DoesNotHaveThes: TXMLItemInfo;
                       Create: Boolean = True): IWSDLType;
    function  GenArrayType(const WSDLType: IWSDLType; const Tag: Boolean): IWSDLType;
    function  GenAliasType(const WSDLType: IWSDLType; const Name: DOMString; const Namespace: DOMString): IWSDLType;
    function  AddType(const Name,  Namespace: DOMString; XMLItemInfo: TXMLItemInfo): IWSDLType; 
    function  GetTypes: IWSDLTypeArray;
    procedure Clear;
    function  IndexOf(const WSDLType: IWSDLType): Integer;
    procedure Move(CurIndex: Integer; NewIndex: Integer);
    procedure Swap(Index1, Index2: Integer);
    function  GetType(Index: Integer): IWSDLType;
    property  Types: IWSDLTypeArray read GetTypes;
    property  Items[Index: Integer]: IWSDLType read GetType; default;
  end;

  IProcessedTracker = interface
  ['{31502D87-7B77-4BA9-AB11-85F5F891502D}']
    function  ProcessedAlready(const Name: DOMString): Boolean;
    procedure AddProcessed(const Name: DOMString);
    procedure Clear;
    function  GetCount: Integer;
    function  GetItem(Index: Integer): DOMString;
    property  Count: Integer read GetCount;
    property  Items[Index: Integer]: DOMString read GetItem; default;
  end;

  { ISchemaTypeImporter }
  ISchemaTypeImporter = interface
  ['{49EADE0D-1BCB-40EE-BFEC-A3365BF3B705}']
    { Import from WSDL }
    procedure GetTypes(const WSDLItems: TWSDLItems;
                       const WSDLTypes: IWSDLTypes;
                       const Name: DOMString;
                       const Tracker: IProcessedTracker;
                       const Reset: Boolean); overload;
    { Import from Schema }
    procedure GetTypes(const SchemaDef: IXMLSchemaDef;
                       const WSDLTypes: IWSDLTypes;
                       const Name: DOMString;
                       const Tracker: IProcessedTracker); overload;
  end;

  { IWSDLPortTypes }
  IWSDLPortTypes = interface(IWSDLItem)
  ['{B7A3A3AD-59ED-4F13-9F2A-E060370A5304}']
    procedure AddPortType(const WSDLPortType: IWSDLPortType);
    function  GetPortTypes: IWSDLPortTypeArray;
    procedure Clear;
    property  PortTypes: IWSDLPortTypeArray read GetPortTypes;
  end;

  { ICleanupIntf }
  ICleanupIntf = interface(IWSDLItemNS)
    ['{292F3737-9C98-4B04-B23D-5388507192BF}']
    procedure Cleanup;
  end;

  { Holds information about a particular WSDL type }
  IWSDLType = interface(ICleanupIntf)
  ['{EFFA6C0C-6245-4605-8623-F1CE58E7D04C}']
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
    procedure SetBaseType(const WSDLType: IWSDLType);
    procedure SetMembers(const membrs: IWSDLPartArray);
    procedure SetDimensions(dim: Integer);
    procedure SetIsUsed(Used: Boolean);
    procedure SetXMLItemInfo(const Flag: TXMLItemInfo);
    procedure SetRegInfo(const RegInfo: string);

    function  GetSerializerOpt: TSerializationOptions;
    procedure SetSerializerOpt(const SOpt: TSerializationOptions);

    function  GetAlternateType: IWSDLType;

    property  DataKind: WSDLTypeKind read GetDataKind write SetDataKind;
    property  TypeFlag: WSDLTypeFlag read GetTypeFlag write SetTypeFlag;
    property  TypeInfo: PTypeInfo read GetTypeInfo write SetTypeInfo;
    property  Dimensions: integer read GetDimensions write SetDimensions;
    property  IsUsed: Boolean read GetIsUsed write SetIsUsed;
    property  XMLItemInfo: TXMLItemInfo read GetXMLItemInfo write SetXMLItemInfo;

    { EnumValues - when DataKind = wtEnumeration }
    property  EnumValues: IWSDLItemArray read GetEnumValues write SetEnumValues;

    { BaseTypeName - when DataKind = wtAlias, wtArray, wtComplexArray, wtClass }
    property  BaseType: IWSDLType read GetBaseType write SetBaseType;

    { ClassMembers - when DataKind = wtClass, has attributes?? }
    property  Members: IWSDLPartArray read GetMembers write SetMembers;
    property  SerializationOpt: TSerializationOptions read GetSerializerOpt write SetSerializerOpt;

    { Alternalte type mapping }
    property AlternateType: IWSDLType read GetAlternateType;

    { Registration Information }
    property RegInfo: string read GetRegInfo write SetRegInfo;
  end;

  { Flags that describe general features encountered by importer. These flags
    control code generation }
  WSDLImporterOpts = (
    woHasSOAPDM,          // SOAP Data module in the WSDL
    woHasDocStyle,        // Document style services
    woHasLiteralUse,      // Literal use
    woHasOptionalElem,    // Types with optional elements
    woHasUnboundedElem,   // Types with unbounded elements
    woHasNillableElem,    // Types with nillable elements
    woHasUnqualifiedElem, // Types with unqualified elements
    woHasAttribute,       // Complex types with attributes
    woHasText,            // Properties that map to 'text' nodes - not ntElement
    woHasAny,
    woHasRef,
    woHasQualifiedAttr,
    woHasOut
  );
  TWSDLImporterOpts = set of WSDLImporterOpts;

  PTWSDLImporterOpts = ^TWSDLImporterOpts;

  TWriteProc = procedure (const Msg: string; const Args: array of const);

  IWSDLImporterOptions = interface
    ['{5373C97E-F282-4F99-B2C6-D3EC2BF68FB5}']
    function  GetOptions: TWSDLImporterOpts;
    procedure SetOptions(const Opts: TWSDLImporterOpts);

    property  Options: TWSDLImporterOpts read GetOptions write SetOptions;
  end;

  PWSDLImportInfo = ^TWSDLImportInfo;
  TWSDLImportInfo = record
    SkipURLs: ArrayOfString;
  end;

  { IWSDLImporter }
  IWSDLImporter = interface(IWSDLImporterOptions)
  ['{C9AB297B-177D-47DE-9139-C49420AB5367}']
    procedure Import(const FileName: DOMString; const Stream: TStream);
    function  GetFileName: DOMString;
    function  GetOutFile:  DOMString;
    procedure SetOutFile(const OFile: DOMString);
    function  GetEncoding: DOMString;
    function  GetVersion:  DOMString;

    function  GetWSDLItems: TWSDLItems;

    function  GetTypes: IWSDLTypeArray;
    function  GetPortTypes: IWSDLPortTypeArray;

    function  GetWSDLTypes: IWSDLTypes;
    function  GetWSDLPortTypes: IWSDLPortTypes;

    procedure SelectItem(const WSDLItem: IWSDLItem);

    function  FindType(const Name: DOMString;
                       const Namespace: DOMString;
                       const HasThese: TXMLItemInfo = [];
                       const DoesNotHaveThes: TXMLItemInfo = [];
                       Create: Boolean = True): IWSDLType;
    function  SkipType(const WSDLType: IWSDLType; SkipAll: Boolean = False): Boolean;
    function  CreateSerializer(const BaseType: IWSDLType;
                               const NewTypeName: DOMString;
                               const NewTypeNamespace: DOMString;
                               const MemberName: DOMString;
                               const SerialOpts: TSerializationOptions;
                               UpdateReferences: Boolean): IWSDLType;

    procedure AddWarning(const Fmt: string; const Args: array of const); overload;

    function  GetOnWrite: TWriteProc;
    procedure SetOnWrite(const WriteProc: TWriteProc);

    function  GetDefName: DOMString;
    procedure SetDefName(const Name: DOMString);
    function  GetImportList: IProcessedTracker;
    function  GetWarningList: TStringList;

    function  GetWSDLImportInfo: PWSDLImportInfo;
    procedure SetWSDLImportInfo(const ImportInfo: PWSDLImportInfo);

    property  DefName:  DOMString read GetDefName write SetDefName;
    property  FileName: DOMString read GetFileName;
    property  OutFile:  DOMString read GetOutFile write SetOutFile;
    property  Encoding: DOMString read GetEncoding;
    property  Version:  DOMString read GetVersion;
    property  OnWrite:  TWriteProc read GetOnWrite write SetOnWrite;
    property  ImportList: IProcessedTracker read GetImportList;
    property  WarningList: TStringList read GetWarningList;
    property  WSDLTypes: IWSDLTypes read GetWSDLTypes;
    property  WSDLPortTypes: IWSDLPortTypes read GetWSDLPortTypes;

    function  FindMIMEPart(const PartName, AOperation, AMessage: DOMString;
                           ArgType: ArgumentType): IMIMEPart;
    procedure GetMIMEParts(const BindingName: DOMString);
    procedure ClearMIMEParts;

    property  WSDLImportInfo: PWSDLImportInfo read GetWSDLImportInfo write SetWSDLImportInfo;
  end;

const
  WSDLTypeKindStr: array[WSDLTypeKind] of String = ('undefined', { Do not localize }
                                                    'duplicate', { Do not localize }
                                                    'enum',      { Do not localize }
                                                    'alias',     { Do not localize }
                                                    'array',     { Do not localize }
                                                    'class',     { Do not localize }
                                                    'attrGrp',   { Do not localize }
                                                    'elemGrp');  { Do not localize }

  XMLItemInfoStr: array[XMLItemInfo] of String = ('global',    { XML Type is not anonymous - it's Global }
                                                  'predefined',{ Refers to known type }
                                                  'element',   { XML Type is an <element... > }
                                                  'complex',   { XML Type is a <complexType... > }
                                                  'simple',    { XML Type is a <simpleType... > }
                                                  'attribute', { XML Type is an <attribute... > }
                                                  'attrGroup', { XML Type is an <attributeGroup.. > }
                                                  'elemGroup', { XML Type is a <group ... > }
                                                  'fakeArray', { Fake created by importer }
                                                  'fakeAlias', { Fake alias created by importer }
                                                  'nillable',  { Alias for nillable cases }
                                                  'mixed'      { mixed="true" }
                                                );

  PartFlagStr: array[PartFlag] of String = ('optional',   { With attribute minOccurs="0"   }
                                            'unbounded',  { With attribute maxOccurs="unbounded" }
                                            'nillable',   { With attribute nillable="true" }
                                            'unqualified',{ With form="unqualified" }
                                            'text',       { Maps to node's text }
                                            'any',
                                            'ref',
                                            'qual'
                                            );

  WSDLTypeFlagStr: array[WSDLTypeFlag] of String = ('',
                                                    'Wrapper',
                                                    'Fault',
                                                    'Header',
                                                    'ArrayAsClass');

  PartTypeStr: array[PartType] of String = ('pUnknown',
                                            'pIn',
                                            'pOut',
                                            'pInOut',
                                            'pReturn',
                                            'pAttribute',
                                            'pDefaultArray');

  WSDLImpMajVer = 2;
  WSDLImpMinVer = 41;

implementation

end.
