{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: structuredquery.h                      }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.StructuredQuery;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses Winapi.StructuredQueryCondition, Winapi.ObjectArray, Winapi.ActiveX, Winapi.Windows;

{$HPPEMIT '#include <structuredquery.h>'}

const
  SID_IQueryParser            = '{2EBDEE67-3505-43f8-9946-EA44ABC8E5B0}';
  SID_IConditionFactory       = '{A5EFE073-B16F-474f-9F3E-9F8B497A3E08}';
  SID_IQuerySolution          = '{D6EBC66B-8921-4193-AFDD-A1789FB7FF57}';
  SID_IConditionFactory2      = '{71D222E1-432F-429e-8C13-B6DAFDE5077A}';
  SID_IConditionGenerator     = '{92D2CC58-4386-45a3-B98C-7E0CE64A4117}';
  SID_IInterval               = '{6BF0A714-3C18-430b-8B5D-83B1C234D3DB}';
  SID_IMetaData               = '{780102B0-C43B-4876-BC7B-5E9BA5C88794}';
  SID_IEntity                 = '{24264891-E80B-4fd3-B7CE-4FF2FAE8931F}';
  SID_IRelationship           = '{2769280B-5108-498c-9C7F-A51239B63147}';
  SID_INamedEntity            = '{ABDBD0B1-7D54-49fb-AB5C-BFF4130004CD}';
  SID_ISchemaProvider         = '{8CF89BCB-394C-49b2-AE28-A59DD4ED7F68}';
  SID_ITokenCollection        = '{22D8B4F2-F577-4adb-A335-C2AE88416FAB}';
  SID_INamedEntityCollector   = '{AF2440F6-8AFC-47d0-9A7F-396A0ACFB43D}';
  SID_ISchemaLocalizerSupport = '{CA3FDCA2-BFBE-4eed-90D7-0CAEF0A1BDA1}';
  SID_IQueryParserManager     = '{A879E3C4-AF77-44fb-8F37-EBD1487CF920}';

  IID_IQueryParser: TGUID            = SID_IQueryParser;
  {$EXTERNALSYM IID_IQueryParser}
  IID_IConditionFactory: TGUID       = SID_IConditionFactory;
  {$EXTERNALSYM IID_IConditionFactory}
  IID_IQuerySolution: TGUID          = SID_IQuerySolution;
  {$EXTERNALSYM IID_IQuerySolution}
  IID_IConditionFactory2: TGUID      = SID_IConditionFactory2;
  {$EXTERNALSYM IID_IConditionFactory2}
  IID_IConditionGenerator: TGUID     = SID_IConditionGenerator;
  {$EXTERNALSYM IID_IConditionGenerator}
  IID_IInterval: TGUID               = SID_IInterval;
  {$EXTERNALSYM IID_IInterval}
  IID_IMetaData: TGUID               = SID_IMetaData;
  {$EXTERNALSYM IID_IMetaData}
  IID_IEntity: TGUID                 = SID_IEntity;
  {$EXTERNALSYM IID_IEntity}
  IID_IRelationship: TGUID           = SID_IRelationship;
  {$EXTERNALSYM IID_IRelationship}
  IID_INamedEntity: TGUID            = SID_INamedEntity;
  {$EXTERNALSYM IID_INamedEntity}
  IID_ISchemaProvider: TGUID         = SID_ISchemaProvider;
  {$EXTERNALSYM IID_ISchemaProvider}
  IID_ITokenCollection: TGUID        = SID_ITokenCollection;
  {$EXTERNALSYM IID_ITokenCollection}
  IID_INamedEntityCollector: TGUID   = SID_INamedEntityCollector;
  {$EXTERNALSYM IID_INamedEntityCollector}
  IID_ISchemaLocalizerSupport: TGUID = SID_ISchemaLocalizerSupport;
  {$EXTERNALSYM IID_ISchemaLocalizerSupport}
  IID_IQueryParserManager: TGUID     = SID_IQueryParserManager;
  {$EXTERNALSYM IID_IQueryParserManager}

  CLSID_IQueryParser: TGUID                = '{B72F8FD8-0FAB-4DD9-BDBF-245A6CE1485B}';
  {$EXTERNALSYM CLSID_IQueryParser}
  CLSID_INegationCondition: TGUID          = '{8DE9C74C-605A-4ACD-BEE3-2B222AA2D23D}';
  {$EXTERNALSYM CLSID_INegationCondition}
  CLSID_ICompoundCondition: TGUID          = '{116F8D13-101E-4FA5-84D4-FF8279381935}';
  {$EXTERNALSYM CLSID_ICompoundCondition}
  CLSID_ILeafCondition: TGUID              = '{52F15C89-5A17-48E1-BBCD-46A3F89C7CC2}';
  {$EXTERNALSYM CLSID_ILeafCondition}
  CLSID_IConditionFactory: TGUID           = '{E03E85B0-7BE3-4000-BA98-6C13DE9FA486}';
  {$EXTERNALSYM CLSID_IConditionFactory}
  CLSID_IInterval: TGUID                   = '{D957171F-4BF9-4DE2-BCD5-C70A7CA55836}';
  {$EXTERNALSYM CLSID_IInterval}
  CLSID_IQueryParserManager: TGUID         = '{5088B39A-29B4-4D9D-8245-4EE289222F66}';
  {$EXTERNALSYM CLSID_IQueryParserManager}

type
  STRUCTURED_QUERY_SYNTAX = type Integer; 
  {$EXTERNALSYM STRUCTURED_QUERY_SYNTAX}
  TStructuredQuerySyntax = STRUCTURED_QUERY_SYNTAX; 
const
  SQS_NO_SYNTAX             = 0; 
  {$EXTERNALSYM SQS_NO_SYNTAX}
  SQS_ADVANCED_QUERY_SYNTAX = SQS_NO_SYNTAX + 1; 
  {$EXTERNALSYM SQS_ADVANCED_QUERY_SYNTAX}
  SQS_NATURAL_QUERY_SYNTAX  = SQS_ADVANCED_QUERY_SYNTAX + 1;
  {$EXTERNALSYM SQS_NATURAL_QUERY_SYNTAX}

type
  STRUCTURED_QUERY_SINGLE_OPTION = type Integer; 
  {$EXTERNALSYM STRUCTURED_QUERY_SINGLE_OPTION}
  TStructuredQuerySingleOption = STRUCTURED_QUERY_SINGLE_OPTION;
const
  SQSO_SCHEMA               = 0; 
  {$EXTERNALSYM SQSO_SCHEMA}
  SQSO_LOCALE_WORD_BREAKING = SQSO_SCHEMA + 1; 
  {$EXTERNALSYM SQSO_LOCALE_WORD_BREAKING}
  SQSO_WORD_BREAKER         = SQSO_LOCALE_WORD_BREAKING + 1; 
  {$EXTERNALSYM SQSO_WORD_BREAKER}
  SQSO_NATURAL_SYNTAX       = SQSO_WORD_BREAKER + 1; 
  {$EXTERNALSYM SQSO_NATURAL_SYNTAX}
  SQSO_AUTOMATIC_WILDCARD   = SQSO_NATURAL_SYNTAX + 1; 
  {$EXTERNALSYM SQSO_AUTOMATIC_WILDCARD}
  SQSO_TRACE_LEVEL          = SQSO_AUTOMATIC_WILDCARD + 1; 
  {$EXTERNALSYM SQSO_TRACE_LEVEL}
  SQSO_LANGUAGE_KEYWORDS    = SQSO_TRACE_LEVEL + 1; 
  {$EXTERNALSYM SQSO_LANGUAGE_KEYWORDS}
  SQSO_SYNTAX               = SQSO_LANGUAGE_KEYWORDS + 1; 
  {$EXTERNALSYM SQSO_SYNTAX}
  SQSO_TIME_ZONE            = SQSO_SYNTAX + 1; 
  {$EXTERNALSYM SQSO_TIME_ZONE}
  SQSO_IMPLICIT_CONNECTOR   = SQSO_TIME_ZONE + 1; 
  {$EXTERNALSYM SQSO_IMPLICIT_CONNECTOR}
  SQSO_CONNECTOR_CASE       = SQSO_IMPLICIT_CONNECTOR + 1; 
  {$EXTERNALSYM SQSO_CONNECTOR_CASE}

type
  STRUCTURED_QUERY_MULTIOPTION = type Integer; 
  {$EXTERNALSYM STRUCTURED_QUERY_MULTIOPTION}
  TStructuredQueryMultiOption = STRUCTURED_QUERY_MULTIOPTION;
const
  SQMO_VIRTUAL_PROPERTY   = 0; 
  {$EXTERNALSYM SQMO_VIRTUAL_PROPERTY}
  SQMO_DEFAULT_PROPERTY   = SQMO_VIRTUAL_PROPERTY + 1; 
  {$EXTERNALSYM SQMO_DEFAULT_PROPERTY}
  SQMO_GENERATOR_FOR_TYPE = SQMO_DEFAULT_PROPERTY + 1; 
  {$EXTERNALSYM SQMO_GENERATOR_FOR_TYPE}
  SQMO_MAP_PROPERTY       = SQMO_GENERATOR_FOR_TYPE + 1; 
  {$EXTERNALSYM SQMO_MAP_PROPERTY}

type
  STRUCTURED_QUERY_PARSE_ERROR = type Integer; 
  {$EXTERNALSYM STRUCTURED_QUERY_PARSE_ERROR}
  TStructuredQueryParseError = STRUCTURED_QUERY_PARSE_ERROR;
const
  SQPE_NONE                      = 0; 
  {$EXTERNALSYM SQPE_NONE}
  SQPE_EXTRA_OPENING_PARENTHESIS = SQPE_NONE + 1;
  {$EXTERNALSYM SQPE_EXTRA_OPENING_PARENTHESIS}
  SQPE_EXTRA_CLOSING_PARENTHESIS = SQPE_EXTRA_OPENING_PARENTHESIS + 1; 
  {$EXTERNALSYM SQPE_EXTRA_CLOSING_PARENTHESIS}
  SQPE_IGNORED_MODIFIER          = SQPE_EXTRA_CLOSING_PARENTHESIS + 1; 
  {$EXTERNALSYM SQPE_IGNORED_MODIFIER}
  SQPE_IGNORED_CONNECTOR         = SQPE_IGNORED_MODIFIER + 1; 
  {$EXTERNALSYM SQPE_IGNORED_CONNECTOR}
  SQPE_IGNORED_KEYWORD           = SQPE_IGNORED_CONNECTOR + 1; 
  {$EXTERNALSYM SQPE_IGNORED_KEYWORD}
  SQPE_UNHANDLED                 = SQPE_IGNORED_KEYWORD + 1; 
  {$EXTERNALSYM SQPE_UNHANDLED}

type
  STRUCTURED_QUERY_RESOLVE_OPTION = type Integer; 
  {$EXTERNALSYM STRUCTURED_QUERY_RESOLVE_OPTION}
  TStructuredQueryResolveOption = STRUCTURED_QUERY_RESOLVE_OPTION; 
const
  SQRO_DEFAULT                           = 0; 
  {$EXTERNALSYM SQRO_DEFAULT}
  SQRO_DONT_RESOLVE_DATETIME             = $1; 
  {$EXTERNALSYM SQRO_DONT_RESOLVE_DATETIME}
  SQRO_ALWAYS_ONE_INTERVAL               = $2; 
  {$EXTERNALSYM SQRO_ALWAYS_ONE_INTERVAL}
  SQRO_DONT_SIMPLIFY_CONDITION_TREES     = $4; 
  {$EXTERNALSYM SQRO_DONT_SIMPLIFY_CONDITION_TREES}
  SQRO_DONT_MAP_RELATIONS                = $8; 
  {$EXTERNALSYM SQRO_DONT_MAP_RELATIONS}
  SQRO_DONT_RESOLVE_RANGES               = $10; 
  {$EXTERNALSYM SQRO_DONT_RESOLVE_RANGES}
  SQRO_DONT_REMOVE_UNRESTRICTED_KEYWORDS = $20; 
  {$EXTERNALSYM SQRO_DONT_REMOVE_UNRESTRICTED_KEYWORDS}
  SQRO_DONT_SPLIT_WORDS                  = $40; 
  {$EXTERNALSYM SQRO_DONT_SPLIT_WORDS}
  SQRO_IGNORE_PHRASE_ORDER               = $80; 
  {$EXTERNALSYM SQRO_IGNORE_PHRASE_ORDER}
  SQRO_ADD_VALUE_TYPE_FOR_PLAIN_VALUES   = $100; 
  {$EXTERNALSYM SQRO_ADD_VALUE_TYPE_FOR_PLAIN_VALUES}
  SQRO_ADD_ROBUST_ITEM_NAME              = $200; 
  {$EXTERNALSYM SQRO_ADD_ROBUST_ITEM_NAME}

type
  CASE_REQUIREMENT = type Integer; 
  {$EXTERNALSYM CASE_REQUIREMENT}
const
  CASE_REQUIREMENT_ANY          = 0; 
  {$EXTERNALSYM CASE_REQUIREMENT_ANY}
  CASE_REQUIREMENT_UPPER_IF_AQS = CASE_REQUIREMENT_ANY + 1; 
  {$EXTERNALSYM CASE_REQUIREMENT_UPPER_IF_AQS}

type
  INTERVAL_LIMIT_KIND = type Integer;
  {$EXTERNALSYM INTERVAL_LIMIT_KIND}
  TIntervalLimitKind = INTERVAL_LIMIT_KIND;
const
  ILK_EXPLICIT_INCLUDED = 0;
  {$EXTERNALSYM ILK_EXPLICIT_INCLUDED}
  ILK_EXPLICIT_EXCLUDED = ILK_EXPLICIT_INCLUDED + 1;
  {$EXTERNALSYM ILK_EXPLICIT_EXCLUDED}
  ILK_NEGATIVE_INFINITY = ILK_EXPLICIT_EXCLUDED + 1;
  {$EXTERNALSYM ILK_NEGATIVE_INFINITY}
  ILK_POSITIVE_INFINITY = ILK_NEGATIVE_INFINITY + 1;
  {$EXTERNALSYM ILK_POSITIVE_INFINITY}

type
  QUERY_PARSER_MANAGER_OPTION = type Integer;
  {$EXTERNALSYM QUERY_PARSER_MANAGER_OPTION}
  TQueryParserManagerOption = QUERY_PARSER_MANAGER_OPTION;
const
  QPMO_SCHEMA_BINARY_NAME              = 0;
  {$EXTERNALSYM QPMO_SCHEMA_BINARY_NAME}
  QPMO_PRELOCALIZED_SCHEMA_BINARY_PATH = QPMO_SCHEMA_BINARY_NAME + 1;
  {$EXTERNALSYM QPMO_PRELOCALIZED_SCHEMA_BINARY_PATH}
  QPMO_UNLOCALIZED_SCHEMA_BINARY_PATH  = QPMO_PRELOCALIZED_SCHEMA_BINARY_PATH + 1;
  {$EXTERNALSYM QPMO_UNLOCALIZED_SCHEMA_BINARY_PATH}
  QPMO_LOCALIZED_SCHEMA_BINARY_PATH    = QPMO_UNLOCALIZED_SCHEMA_BINARY_PATH + 1;
  {$EXTERNALSYM QPMO_LOCALIZED_SCHEMA_BINARY_PATH}
  QPMO_APPEND_LCID_TO_LOCALIZED_PATH   = QPMO_LOCALIZED_SCHEMA_BINARY_PATH + 1;
  {$EXTERNALSYM QPMO_APPEND_LCID_TO_LOCALIZED_PATH}
  QPMO_LOCALIZER_SUPPORT               = QPMO_APPEND_LCID_TO_LOCALIZED_PATH + 1;
  {$EXTERNALSYM QPMO_LOCALIZER_SUPPORT}

type
  CONDITION_CREATION_OPTIONS = type Integer;
  {$EXTERNALSYM CONDITION_CREATION_OPTIONS}
  TConditionCreationOptions = CONDITION_CREATION_OPTIONS;
const
  CONDITION_CREATION_DEFAULT     = 0;
  {$EXTERNALSYM CONDITION_CREATION_DEFAULT}
  CONDITION_CREATION_NONE        = 0;
  {$EXTERNALSYM CONDITION_CREATION_NONE}
  CONDITION_CREATION_SIMPLIFY    = $1;
  {$EXTERNALSYM CONDITION_CREATION_SIMPLIFY}
  CONDITION_CREATION_VECTOR_AND  = $2;
  {$EXTERNALSYM CONDITION_CREATION_VECTOR_AND}
  CONDITION_CREATION_VECTOR_OR   = $4;
  {$EXTERNALSYM CONDITION_CREATION_VECTOR_OR}
  CONDITION_CREATION_VECTOR_LEAF = $8;
  {$EXTERNALSYM CONDITION_CREATION_VECTOR_LEAF}
  CONDITION_CREATION_USE_CONTENT_LOCALE = $10;
  {$EXTERNALSYM CONDITION_CREATION_USE_CONTENT_LOCALE}

type
  NAMED_ENTITY_CERTAINTY = type Integer;
  {$EXTERNALSYM NAMED_ENTITY_CERTAINTY}
  TNamedEntityCertainty = NAMED_ENTITY_CERTAINTY;
const
  NEC_LOW    = 0;
  {$EXTERNALSYM NEC_LOW}
  NEC_MEDIUM = NEC_LOW + 1;
  {$EXTERNALSYM NEC_MEDIUM}
  NEC_HIGH   = NEC_MEDIUM + 1;
  {$EXTERNALSYM NEC_HIGH}

{ interface IQueryParser }
type
  IQueryParser            = interface;
  IConditionFactory       = interface;
  IQuerySolution          = interface;
  IConditionFactory2      = interface;
  IConditionGenerator     = interface;
  IInterval               = interface;
  IMetaData               = interface;
  IEntity                 = interface;
  IRelationship           = interface;
  INamedEntity            = interface;
  ISchemaProvider         = interface;
  ITokenCollection        = interface;
  INamedEntityCollector   = interface;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaLocalizerSupport);'}
  ISchemaLocalizerSupport = interface;
  IQueryParserManager     = interface;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IQueryParser);'}
  IQueryParser = interface(IUnknown)
    [SID_IQueryParser]
    function Parse(pszInputString: LPCWSTR; var pCustomProperties: IEnumUnknown;
      out ppSolution: IQuerySolution): HRESULT; stdcall;

    function SetOption(option: STRUCTURED_QUERY_SINGLE_OPTION;
      var pOptionValue: TPropVariant): HRESULT; stdcall;

    function GetOption(option: STRUCTURED_QUERY_SINGLE_OPTION;
      var pOptionValue: TPropVariant): HRESULT; stdcall;

    function SetMultiOption(option: STRUCTURED_QUERY_MULTIOPTION;
      pszOptionKey: LPCWSTR; var pOptionValue: TPropVariant): HRESULT; stdcall;

    function GetSchemaProvider(
      out ppSchemaProvider: ISchemaProvider): HRESULT; stdcall;

    function RestateToString(var pCondition: ICondition; fUseEnglish: BOOL;
      var ppszQueryString: LPWSTR): HRESULT; stdcall;

    function ParsePropertyValue(pszPropertyName: LPCWSTR; pszInputString: LPCWSTR;
      out ppSolution: IQuerySolution): HRESULT; stdcall;

    function RestatePropertyValueToString(var pCondition: ICondition;
      fUseEnglish: BOOL; var ppszPropertyName: LPWSTR;
      var ppszQueryString: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IQueryParser}

{ interface IConditionFactory }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IConditionFactory);'}
  IConditionFactory = interface(IUnknown)
    [SID_IConditionFactory]
    function MakeNot(var pcSub: ICondition; fSimplify: BOOL;
      out ppcResult: ICondition): HRESULT; stdcall;

    function MakeAndOr(ct: TConditionType; var peuSubs: IEnumUnknown;
      fSimplify: BOOL; out ppcResult: ICondition): HRESULT; stdcall;

    function MakeLeaf(pszPropertyName: LPCWSTR; cop: TConditionOperation;
      pszValueType: LPCWSTR; var ppropvar: TPropVariant;
      var pPropertyNameTerm: IRichChunk; var pOperationTerm: IRichChunk;
      var pValueTerm: IRichChunk; fExpand: BOOL;
      out ppcResult: ICondition): HRESULT; stdcall;

    function Resolve(var pc: ICondition; sqro: TStructuredQueryResolveOption;
      var pstReferenceTime: TSystemTime;
      out ppcResolved: ICondition): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IConditionFactory}

{ interface IQuerySolution }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IQuerySolution);'}
  IQuerySolution = interface(IConditionFactory)
    [SID_IQuerySolution]
    function GetQuery(out ppQueryNode: ICondition;
      out ppMainType: IEntity): HRESULT; stdcall;
  
    function GetErrors(const riid: TIID; 
      var ppParseErrors: Pointer): HRESULT; stdcall;
  
    function GetLexicalData(var ppszInputString: LPWSTR; 
      out ppTokens: ITokenCollection; var plcid: LCID;
      out ppWordBreaker: IUnknown): HRESULT; stdcall;
  
  end;
  {$EXTERNALSYM IQuerySolution}

{ interface IConditionFactory2 }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IConditionFactory2);'}
  IConditionFactory2 = interface(IConditionFactory)
    [SID_IConditionFactory2]
    function CreateTrueFalse(fVal: BOOL; cco: TConditionCreationOptions;
      const riid: TIID; var ppv: Pointer): HRESULT; stdcall;

    function CreateNegation(var pcSub: ICondition; cco: TConditionCreationOptions;
      const riid: TIID; var ppv: Pointer): HRESULT; stdcall;
  
    function CreateCompoundFromObjectArray(ct: TConditionType; 
      var poaSubs: IObjectArray; cco: TConditionCreationOptions; const riid: TIID; 
      var ppv: Pointer): HRESULT; stdcall;
  
    function CreateCompoundFromArray(ct: TConditionType; 
      out ppcondSubs: ICondition; cSubs: Cardinal; cco: TConditionCreationOptions;
      const riid: TIID; var ppv: Pointer): HRESULT; stdcall;

    function CreateStringLeaf(const propkey: TPropertyKey; cop: TConditionOperation;
      pszValue: LPCWSTR; pszLocaleName: LPCWSTR; cco: TConditionCreationOptions; 
      const riid: TIID; var ppv: Pointer): HRESULT; stdcall;
  
    function CreateIntegerLeaf(const propkey: TPropertyKey; cop: TConditionOperation;
      lValue: Integer; cco: TConditionCreationOptions; const riid: TIID;
      var ppv: Pointer): HRESULT; stdcall;

    function CreateBooleanLeaf(const propkey: TPropertyKey; cop: TConditionOperation;
      fValue: BOOL; cco: TConditionCreationOptions; const riid: TIID; 
      var ppv: Pointer): HRESULT; stdcall;

    function CreateLeaf(const propkey: TPropertyKey; cop: TConditionOperation;
      const propvar: TPropVariant; pszSemanticType: LPCWSTR; pszLocaleName: LPCWSTR;
      var pPropertyNameTerm: IRichChunk; var pOperationTerm: IRichChunk; 
      var pValueTerm: IRichChunk; cco: TConditionCreationOptions; const riid: TIID; 
      var ppv: Pointer): HRESULT; stdcall;
  
    function ResolveCondition(var pc: ICondition; 
      sqro: TStructuredQueryResolveOption; var pstReferenceTime: SYSTEMTIME; 
      const riid: TIID; var ppv: Pointer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IConditionFactory2}

{ interface IConditionGenerator }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IConditionGenerator);'}
  IConditionGenerator = interface(IUnknown)
    [SID_IConditionGenerator]
    function Initialize(var pSchemaProvider: ISchemaProvider): HRESULT; stdcall;

    function RecognizeNamedEntities(pszInputString: LPCWSTR; lcidUserLocale: LCID;
      var pTokenCollection: ITokenCollection;
      var pNamedEntities: INamedEntityCollector): HRESULT; stdcall;

    function GenerateForLeaf(var pConditionFactory: IConditionFactory;
      pszPropertyName: LPCWSTR; cop: CONDITION_OPERATION; pszValueType: LPCWSTR;
      pszValue: LPCWSTR; pszValue2: LPCWSTR; var pPropertyNameTerm: IRichChunk;
      var pOperationTerm: IRichChunk; var pValueTerm: IRichChunk;
      automaticWildcard: BOOL; var pNoStringQuery: BOOL;
      out ppQueryExpression: ICondition): HRESULT; stdcall;

    function DefaultPhrase(pszValueType: LPCWSTR; var ppropvar: PROPVARIANT;
      fUseEnglish: BOOL; var ppszPhrase: LPWSTR): HRESULT; stdcall;

  end;
  {$EXTERNALSYM IConditionGenerator}

{ interface IInterval }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInterval);'}
  IInterval = interface(IUnknown)
    [SID_IInterval]
    function GetLimits(var pilkLower: TIntervalLimitKind; 
      var ppropvarLower: TPropVariant; var pilkUpper: TIntervalLimitKind; 
      var ppropvarUpper: TPropVariant): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IInterval}

{ interface IMetaData }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMetaData);'}
  IMetaData = interface(IUnknown)
    [SID_IMetaData]
    function GetData(var ppszKey: LPWSTR; var ppszValue: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IMetaData}

{ interface IEntity }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IEntity);'}
  IEntity = interface(IUnknown)
    [SID_IEntity]
    function Name(var ppszName: LPWSTR): HRESULT; stdcall;
  
    function Base(out pBaseEntity: IEntity): HRESULT; stdcall;
  
    function Relationships(const riid: TIID; 
      var pRelationships: Pointer): HRESULT; stdcall;
  
    function GetRelationship(pszRelationName: LPCWSTR; 
      out pRelationship: IRelationship): HRESULT; stdcall;
  
    function MetaData(const riid: TIID; var pMetaData: Pointer): HRESULT; stdcall;
  
    function NamedEntities(const riid: TIID; 
      var pNamedEntities: Pointer): HRESULT; stdcall;
  
    function GetNamedEntity(pszValue: LPCWSTR; 
      out ppNamedEntity: INamedEntity): HRESULT; stdcall;
  
    function DefaultPhrase(var ppszPhrase: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IEntity}

{ interface IRelationship }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRelationship);'}
  IRelationship = interface(IUnknown)
    [SID_IRelationship]
    function Name(var ppszName: LPWSTR): HRESULT; stdcall;

    function IsReal(var pIsReal: BOOL): HRESULT; stdcall;

    function Destination(out pDestinationEntity: IEntity): HRESULT; stdcall;

    function MetaData(const riid: TIID; var pMetaData: Pointer): HRESULT; stdcall;

    function DefaultPhrase(var ppszPhrase: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRelationship}

{ interface INamedEntity }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(INamedEntity);'}
  INamedEntity = interface(IUnknown)
    [SID_INamedEntity]
    function GetValue(var ppszValue: LPWSTR): HRESULT; stdcall;

    function DefaultPhrase(var ppszPhrase: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM INamedEntity}

{ interface ISchemaProvider }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaProvider);'}
  ISchemaProvider = interface(IUnknown)
    [SID_ISchemaProvider]
    function Entities(const riid: TIID; var pEntities: Pointer): HRESULT; stdcall;
  
    function RootEntity(out pRootEntity: IEntity): HRESULT; stdcall;
  
    function GetEntity(pszEntityName: LPCWSTR; 
      out pEntity: IEntity): HRESULT; stdcall;
  
    function MetaData(const riid: TIID; var pMetaData: Pointer): HRESULT; stdcall;
  
    function Localize(lcid: LCID; 
      var pSchemaLocalizerSupport: ISchemaLocalizerSupport): HRESULT; stdcall;
  
    function SaveBinary(pszSchemaBinaryPath: LPCWSTR): HRESULT; stdcall;
  
    function LookupAuthoredNamedEntity(var pEntity: IEntity; 
      pszInputString: LPCWSTR; var pTokenCollection: ITokenCollection; 
      cTokensBegin: Cardinal; var pcTokensLength: Cardinal; 
      var ppszValue: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISchemaProvider}

{ interface ITokenCollection }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITokenCollection);'}
  ITokenCollection = interface(IUnknown)
    [SID_ITokenCollection]
    function NumberOfTokens(var pCount: Cardinal): HRESULT; stdcall;

    function GetToken(i: Cardinal; var pBegin: Cardinal; var pLength: Cardinal;
      var ppsz: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITokenCollection}

{ interface INamedEntityCollector }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(INamedEntityCollector);'}
  INamedEntityCollector = interface(IUnknown)
    [SID_INamedEntityCollector]
    function Add(beginSpan: Cardinal; endSpan: Cardinal; beginActual: Cardinal;
      endActual: Cardinal; var pType: IEntity; pszValue: LPCWSTR;
      certainty: TNamedEntityCertainty): HRESULT; stdcall;
  end;
  {$EXTERNALSYM INamedEntityCollector}


{ interface ISchemaLocalizerSupport }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISchemaLocalizerSupport);'}
  ISchemaLocalizerSupport = interface(IUnknown)
    [SID_ISchemaLocalizerSupport]
    function Localize(pszGlobalString: LPCWSTR; 
      var ppszLocalString: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISchemaLocalizerSupport}

{ interface IQueryParserManager }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IQueryParserManager);'}
  IQueryParserManager = interface(IUnknown)
    [SID_IQueryParserManager]
    function CreateLoadedParser(pszCatalog: LPCWSTR; langidForKeywords: LANGID;
      const riid: TIID; var ppQueryParser: Pointer): HRESULT; stdcall;

    function InitializeOptions(fUnderstandNQS: BOOL; fAutoWildCard: BOOL;
      var pQueryParser: IQueryParser): HRESULT; stdcall;

    function SetOption(option: TQueryParserManagerOption;
      var pOptionValue: TPropVariant): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IQueryParserManager}

implementation

end.
