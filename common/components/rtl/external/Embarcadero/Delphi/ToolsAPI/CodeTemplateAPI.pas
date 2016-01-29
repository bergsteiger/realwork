{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit CodeTemplateAPI;

interface

uses
  System.SysUtils, ToolsAPI, System.Classes;

(*$HPPEMIT 'DEFINE_GUID(IID_IOTACodeTemplateScript,0xA9385BEA,0x6CE9,0x457D,0xB3,0x6E,0x59,0x14,0xE3,0x4E,0x91,0x8F);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTACodeTemplatePoint100,0xF94D1BBD,0x7ABD,0x4EA5,0x8B,0x4C,0xEB,0x30,0x2B,0x59,0x4D,0x98);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTACodeTemplatePoint,0xB05C9A29,0x3A82,0x437F,0x9F,0x3B,0x2C,0x1E,0xE7,0x7F,0x4B,0x12);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTATemplateCodeReference,0x4949AB6F,0x2659,0x44A4,0x89,0xD7,0x66,0x92,0x06,0x9E,0x2F,0xC2);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTACodeTemplateObject,0xFB3B4C8C,0x5757,0x4E5A,0x90,0x91,0x54,0xFF,0x98,0x6D,0x6D,0x8D);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTACodeTemplate,0xED1EBB0B,0xDDD8,0x4157,0xBB,0xFE,0xDD,0xAC,0x10,0x7B,0xD6,0x19);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTATemplateReader,0x31F52EEB,0x290E,0x46D5,0x94,0x96,0x49,0xF2,0x16,0x38,0x0B,0xB0);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTATemplateWriter,0x3EBA335E,0x61AB,0x4A75,0xBF,0x60,0xB8,0xFE,0x55,0x2B,0xD4,0xEB);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTATemplateFactory,0xA1F52E3E,0xFD9F,0x4BC4,0xBE,0x80,0x28,0x48,0x89,0xF9,0x42,0x75);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTATemplateReaderFactory,0x6EF4BEBB,0x32DB,0x4074,0x9B,0xA9,0x05,0x0E,0x4C,0xA0,0x93,0x9A);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTATemplateWriterFactory,0x6EF4BEBB,0x32DB,0x4074,0x9B,0xA9,0x05,0x0E,0x4C,0xA0,0x93,0x9A);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTACodeTemplateScriptEngine,0x49A9DED0,0x9B1B,0x425B,0x97,0x52,0x06,0xE8,0x5E,0xD9,0xAE,0x78);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTATemplateArgs,0x94A1859F,0x79E7,0x4FBF,0xA2,0x86,0x13,0x15,0x20,0x9F,0x89,0x0C);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTATemplateChangeNotifier,0x7F316770,0x186E,0x41E5,0x9C,0x91,0x87,0xD7,0x80,0x1B,0x2D,0x40);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTACodeTemplateServices100,0xAF5A5EDA,0xDF66,0x4E07,0x8C,0xAF,0x19,0xBB,0xDC,0xF9,0x2D,0x82);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTACodeTemplateServices,0x92E1F6C0,0x1273,0x4412,0x97,0x28,0xC8,0x3C,0xA9,0x4A,0xC9,0xD0);'*)

const
  sDefaultDelimiter = '$';

  sTemplateLanguageCSharp = 'CSharp';
  sTemplateLanguageVB = 'VB';
  sTemplateLanguageJsharp = 'Jsharp';
  sTemplateLanguageHTML = 'HTML';
  sTemplateLanguageXML = 'XML';
  sTemplateLanguageDelphi = 'Delphi';
  sTemplateLanguageC = 'C';
  sTemplateLanguageIDE = 'IDE';
  sTemplateLanguageSQL = 'SQL';
  sTemplateLanguageIDL = 'IDL';
  sTemplateLanguageJavaScript = 'JavaScript';
  sTemplateLanguageCSS = 'CSS';
  sTemplateLanguageINI = 'INI';
  sTemplateLanguagePHP = 'PHP';

type
  TOTATemplateInvokeKind = (ikNone, ikManual, ikAuto);
  TOTATemplateKind = (skNone, skMethodBody, skMethodDecl, skMemberDecl,
                     skDecl, skTypeDecl, skComment, skStringLiteral,
                     skPage, skFile, skAny, skAnyNoMemberRef, skMemberRef);
  TOTATemplateTypes = (stRefactoring, stSurroundsWith, stExpansion);
  TOTATemplateType = set of TOTATemplateTypes;
  TOTATemplateScriptExecutions = (sseOnValidate, sseOnEnter, sseOnLeave, sseOnExit);
  TOTATemplateScriptExecution = set of TOTATemplateScriptExecutions;

  IOTACodeTemplateScript = interface
  ['{A9385BEA-6CE9-457D-B36E-5914E34E918F}']
    procedure SetScriptLanguage(const Value: WideString);
    function GetScriptLanguage: WideString;
    function GetExecution: TOTATemplateScriptExecution;
    procedure SetExecution(Value: TOTATemplateScriptExecution);
    function GetScript: WideString;
    procedure SetScript(const Value: WideString);

    property Execution: TOTATemplateScriptExecution read GetExecution write SetExecution;
    property Script: WideString read GetScript write SetScript;
    property ScriptLanguage: WideString read GetScriptLanguage write SetScriptLanguage;
  end;

  IOTACodeTemplatePoint100 = interface
  ['{F94D1BBD-7ABD-4EA5-8B4C-EB302B594D98}']
    function GetEditable: Boolean;
    procedure SetEditable(Value: Boolean);
    function GetValue: WideString;
    procedure SetValue(const Value: WideString);
    function GetID: WideString;
    procedure SetID(const Value: WideString);
    function GetToolTip: WideString;
    procedure SetToolTip(const Value: WideString);
    procedure SetIsDefault(Value: Boolean);
    function GetIsDefault: Boolean;
    function GetScripts(Index: Integer): IOTACodeTemplateScript;
    procedure AddScript(const Script: IOTACodeTemplateScript);
    function GetScriptCount: Integer;
    property ScriptCount: Integer read GetScriptCount;
    property Scripts[Index: Integer]: IOTACodeTemplateScript read GetScripts;
    property Editable: Boolean read GetEditable write SetEditable;
    property Value: WideString read GetValue write SetValue;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
    property ID: WideString read GetID write SetID;
    property ToolTip: WideString read GetToolTip write SetToolTip;
  end;

  IOTACodeTemplatePoint = interface(IOTACodeTemplatePoint100)
  ['{B05C9A29-3A82-437F-9F3B-2C1EE77F4B12}']
    function GetMultiLine: Boolean;
    procedure SetMultiLine(Value: Boolean);
    property MultiLine: Boolean read GetMultiLine write SetMultiLine;
  end;


  IOTATemplateCodeReference = interface
  ['{4949AB6F-2659-44A4-89D7-6692069E2FC2}']
    function GetReference: WideString;
    procedure SetReference(const Value: WideString);
    function GetUrl: WideString;
    procedure SetUrl(const Value: WideString);

    property Reference: WideString read GetReference write SetReference;
    property Url: WideString read GetUrl write SetUrl;
  end;

  IOTACodeTemplateObject = interface(IOTACodeTemplatePoint)
  ['{FB3B4C8C-5757-4E5A-9091-54FF986D6D8D}']
    function GetType: WideString;
    procedure SetType(const Value: WideString);

    property _Type: WideString read GetType write SetType;
  end;

  IOTACodeTemplate = interface
  ['{ED1EBB0B-DDD8-4157-BBFE-DDAC107BD619}']
    procedure Clear;
    function GetDelimiter: WideString;
    procedure SetDelimiter(const Value: WideString);
    function GetKind: TOTATemplateKind;
    procedure SetKind(Value: TOTATemplateKind);
    function GetLanguage: WideString;
    procedure SetLanguage(const Value: WideString);
    function GetEditorOpts: WideString;
    procedure SetEditorOpts(const Value: WideString);
    function GetCode: WideString;
    procedure SetCode(const Value: WideString);
    function GetDescription: WideString;
    procedure SetDescription(const Value: WideString);
    function GetReferencesCount: Integer;
    function GetImportedNamespaces(I: Integer): WideString;
    procedure SetImportedNamespaces(I: Integer; const Value: WideString);
    function GetReferences(I: Integer): IOTATemplateCodeReference;
    procedure SetReferences(I: Integer; const Value: IOTATemplateCodeReference);
    function GetAuthor: WideString;
    procedure SetAuthor(const Value: WideString);
    function FindPoint(const AName: WideString): IOTACodeTemplatePoint;
    function GetPoints(I: Integer): IOTACodeTemplatePoint;
    function GetKeywords(I: Integer): WideString;
    procedure SetKeywords(I: Integer; const Value: WideString);
    function GetShortcut: WideString;
    procedure SetShortcut(const Value: WideString);
    function GetTemplateType: TOTATemplateType;
    procedure SetTemplateType(Value: TOTATemplateType);
    function GetIsDirty: Boolean;
    procedure SetIsDirty(Value: Boolean);
    procedure SetFileName(const Value: WideString);
    function GetFileName: WideString;
    function GetHelpUrl: WideString;
    function GetTitle: WideString;
    function GetNamespaceCount: Integer;
    function GetPointsCount: Integer;
    function GetKeywordsCount: Integer;
    function GetTemplateFormat: WideString;
    procedure SetTemplateFormat(const Value: WideString);
    procedure SetTitle(const Value: WideString);
    procedure SetUrl(const Value: WideString);
    procedure AddNamespace(const Value: WideString);
    procedure AddReference(const Value: IOTATemplateCodeReference);
    procedure AddPoint(const Value: IOTACodeTemplatePoint);
    procedure AddKeyword(const Value: WideString);
    procedure AddScript(const Value: IOTACodeTemplateScript);
    function GetScriptCount: Integer;
    function GetScript(I: Integer): IOTACodeTemplateScript;
    procedure SetInvokeKind(Value: TOTATemplateInvokeKind);
    function GetInvokeKind: TOTATemplateInvokeKind;

    property ScriptCount: Integer read GetScriptCount;
    property Script[I: Integer]: IOTACodeTemplateScript read GetScript;
    property Format: WideString read GetTemplateFormat write SetTemplateFormat;
    property Title: WideString read GetTitle write SetTitle;
    property HelpUrl: WideString read GetHelpUrl write SetUrl;
    property Delimiter: WideString read GetDelimiter write SetDelimiter;
    property Kind: TOTATemplateKind read GetKind write SetKind;
    property Language: WideString read GetLanguage write SetLanguage;
    property EditorOpts: WideString read GetEditorOpts write SetEditorOpts;
    property Code: WideString read GetCode write SetCode;
    property Description: WideString read GetDescription write SetDescription;
    property ReferencesCount: Integer read GetReferencesCount;
    property NamespaceCount: Integer read GetNamespaceCount;
    property ImportedNamespaces[I: Integer]: WideString read GetImportedNamespaces write SetImportedNamespaces;
    property References[I: Integer]: IOTATemplateCodeReference read GetReferences write SetReferences;
    property Author: WideString read GetAuthor write SetAuthor;
    property PointsCount: Integer read GetPointsCount;
    property Points[I: Integer]: IOTACodeTemplatePoint read GetPoints;
    property KeywordsCount: Integer read GetKeywordsCount;
    property Keywords[I: Integer]: WideString read GetKeywords write SetKeywords;
    property Shortcut: WideString read GetShortcut write SetShortcut;
    property TemplateType: TOTATemplateType read GetTemplateType write SetTemplateType;
    property IsDirty: Boolean read GetIsDirty write SetIsDirty;
    property InvokeKind: TOTATemplateInvokeKind read GetInvokeKind write SetInvokeKind;
    property FileName: WideString read GetFileName write SetFileName;
  end;

  IOTATemplateReader = interface
  ['{31F52EEB-290E-46D5-9496-49F216380BB0}']
    function GetTemplate: IOTACodeTemplate;
    procedure SetTemplate(const Value: IOTACodeTemplate);
    procedure Load(const AFileName: WideString;
      const ATemplate: IOTACodeTemplate);

    property Template: IOTACodeTemplate read GetTemplate write SetTemplate;
  end;

  IOTATemplateWriter = interface
  ['{3EBA335E-61AB-4A75-BF60-B8FE552BD4EB}']
    function GetTemplate: IOTACodeTemplate;
    procedure SetTemplate(const Value: IOTACodeTemplate);
    procedure Save(const ATemplate: IOTACodeTemplate);

    property Template: IOTACodeTemplate read GetTemplate write SetTemplate;
  end;

  IOTATemplateFactory = interface
  ['{A1F52E3E-FD9F-4BC4-BE80-284889F94275}']
  end;

  IOTATemplateReaderFactory = interface(IOTATemplateFactory)
  ['{6EF4BEBB-32DB-4074-9BA9-050E4CA0939A}']
    function CreateReader: IOTATemplateReader;
    function HandlesFile(const AFileName: WideString): Boolean;
  end;

  IOTATemplateWriterFactory = interface(IOTATemplateFactory)
  ['{6EF4BEBB-32DB-4074-9BA9-050E4CA0939A}']
    function CreateWriter: IOTATemplateWriter;
  end;

  IOTACodeTemplateScriptEngine = interface
  ['{49A9DED0-9B1B-425B-9752-06E85ED9AE78}']
    function GetIDString: WideString;
    function GetLanguage: WideString;
    procedure Execute(const ATemplate: IOTACodeTemplate;
      const APoint: IOTACodeTemplatePoint;
      const ASyncPoints: IOTASyncEditPoints;
      const AScript: IOTACodeTemplateScript;
      var Cancel: Boolean);
    property Language: WideString read GetLanguage;
  end;

  IOTATemplateArgs = interface
  ['{94A1859F-79E7-4FBF-A286-1315209F890C}']
    procedure SetValue(Name: WideString; AValue: WideString);
    function GetValue(Name: WideString): WideString;
    property Value[Name: WideString]: WideString read GetValue write SetValue; default;
  end;

  TTemplateIndexArray = array of Integer;
  TOTATemplateNotificationType = (ntAdded, ntRemoved, ntModified);

  IOTATemplateChangeNotifier = interface
  ['{7F316770-186E-41E5-9C91-87D7801B2D40}']
    procedure ChangeNotification(AType: TOTATemplateNotificationType;
      const ATemplate: IOTACodeTemplate);
  end;

  IOTACodeTemplateServices100 = interface
  ['{AF5A5EDA-DF66-4E07-8CAF-19BBDCF92D82}']
    function GetCodeObjectCount: Integer;
    function GetCodeObjects(I: Integer): IOTACodeTemplate;
    function GetTemplateCharSet(EdOpts: string): TSysCharSet;
    procedure RegisterExtension(AExt: WideString; AFormat: WideString);
    procedure RegisterReader(AReader: IOTATemplateReaderFactory;
      AFormat: WideString);
    procedure RegisterWriter(AWriter: IOTATemplateWriterFactory;
      AFormat: WideString);
    function AddNotifier(const ANotifier: IOTATemplateChangeNotifier): Integer;
    procedure RemoveNotifier(AIndex: Integer);
    procedure RegisterScriptEngine(const AEngine: IOTACodeTemplateScriptEngine);
    function FindEngine(const ALanguage: WideString): IOTACodeTemplateScriptEngine;
    function ValidTemplates(EdOpts: string): Boolean;
    procedure ValidateTemplates;
    function InsertCodeByShortcut(const AShortcut: WideString;
      const AEditorOpts: WideString; const AEditor: IOTAEditView;
      Remove: Boolean; const Args: IOTATemplateArgs = nil): Boolean;
    function InsertCode(Index: Integer; const AEditor: IOTAEditView;
      Remove: Boolean; Args: IOTATemplateArgs = nil): Boolean;
    function AutoComplete(const View: IOTAEditView; Key: WideChar): Boolean;
    procedure LoadTemplates(const Dir: WideString);
    procedure RemoveTemplate(const Template: IOTACodeTemplate);
    function FindByID(const AShortcut: WideString; const AEditorOpts: WideString): Integer;
    procedure ReloadTemplate(const Template: IOTACodeTemplate);
    procedure SaveTemplate(const Template: IOTACodeTemplate);
    procedure MatchTemplates(const Token: WideString;
      EdOpts: string; out Indecies: TTemplateIndexArray);
    procedure ReloadTemplates;
    procedure SaveTemplates;
    procedure RegisterLanguage(const ALang: WideString; AOptionID: WideString);
    procedure UnregisterLanguage(const ALang: WideString);
    function LanguageToOptionID(const ALang: WideString): WideString;
    function GetAutoCompleteKey: WideChar;
    procedure SetAutoCompleteKey(Value: WideChar);
    function GetManualCompleteKey: WideChar;
    procedure SetManualCompleteKey(Value: WideChar);

    property AutoCompleteKey: WideChar read GetAutoCompleteKey
      write SetAutoCompleteKey;
    property ManualCompleteKey: WideChar read GetManualCompleteKey
      write SetManualCompleteKey;
    property CodeObjectCount: Integer read GetCodeObjectCount;
    property CodeObjects[I: Integer]: IOTACodeTemplate read GetCodeObjects; default;
  end;

  IOTACodeTemplateServices = interface(IOTACodeTemplateServices100)
  ['{92E1F6C0-1273-4412-9728-C83CA94AC9D0}']
    function CreateClass(GUID: TGUID): IInterface;
  end;

implementation

end.
