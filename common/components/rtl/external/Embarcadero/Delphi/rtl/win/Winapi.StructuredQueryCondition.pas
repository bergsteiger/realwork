{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: structuredquerycondition.h             }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.StructuredQueryCondition;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses Winapi.Windows, Winapi.ActiveX;

{$HPPEMIT '#include <structuredquerycondition.h>'}

const
  SID_IRichChunk  = '{4FDEF69C-DBC9-454e-9910-B34F3C64B510}';
  SID_ICondition  = '{0FC988D4-C935-4b97-A973-46282EA175C8}';
  SID_ICondition2 = '{0DB8851D-2E5B-47eb-9208-D28C325A01D7}';

  IID_IRichChunk: TGUID  = SID_IRichChunk;
  {$EXTERNALSYM IID_IRichChunk}
  IID_ICondition: TGUID  = SID_ICondition;
  {$EXTERNALSYM IID_ICondition}
  IID_ICondition2: TGUID = SID_ICondition2;
  {$EXTERNALSYM IID_ICondition2}

type
  CONDITION_TYPE = type Integer; 
  {$EXTERNALSYM CONDITION_TYPE}
  TConditionType = CONDITION_TYPE;
const
  CT_AND_CONDITION  = 0; 
  {$EXTERNALSYM CT_AND_CONDITION}
  CT_OR_CONDITION   = CT_AND_CONDITION + 1; 
  {$EXTERNALSYM CT_OR_CONDITION}
  CT_NOT_CONDITION  = CT_OR_CONDITION + 1; 
  {$EXTERNALSYM CT_NOT_CONDITION}
  CT_LEAF_CONDITION = CT_NOT_CONDITION + 1; 
  {$EXTERNALSYM CT_LEAF_CONDITION}

type
  CONDITION_OPERATION = type Integer; 
  {$EXTERNALSYM CONDITION_OPERATION}
  TConditionOperation = CONDITION_OPERATION;
const
  COP_IMPLICIT             = 0; 
  {$EXTERNALSYM COP_IMPLICIT}
  COP_EQUAL                = COP_IMPLICIT + 1; 
  {$EXTERNALSYM COP_EQUAL}
  COP_NOTEQUAL             = COP_EQUAL + 1; 
  {$EXTERNALSYM COP_NOTEQUAL}
  COP_LESSTHAN             = COP_NOTEQUAL + 1; 
  {$EXTERNALSYM COP_LESSTHAN}
  COP_GREATERTHAN          = COP_LESSTHAN + 1; 
  {$EXTERNALSYM COP_GREATERTHAN}
  COP_LESSTHANOREQUAL      = COP_GREATERTHAN + 1; 
  {$EXTERNALSYM COP_LESSTHANOREQUAL}
  COP_GREATERTHANOREQUAL   = COP_LESSTHANOREQUAL + 1; 
  {$EXTERNALSYM COP_GREATERTHANOREQUAL}
  COP_VALUE_STARTSWITH     = COP_GREATERTHANOREQUAL + 1; 
  {$EXTERNALSYM COP_VALUE_STARTSWITH}
  COP_VALUE_ENDSWITH       = COP_VALUE_STARTSWITH + 1; 
  {$EXTERNALSYM COP_VALUE_ENDSWITH}
  COP_VALUE_CONTAINS       = COP_VALUE_ENDSWITH + 1; 
  {$EXTERNALSYM COP_VALUE_CONTAINS}
  COP_VALUE_NOTCONTAINS    = COP_VALUE_CONTAINS + 1; 
  {$EXTERNALSYM COP_VALUE_NOTCONTAINS}
  COP_DOSWILDCARDS         = COP_VALUE_NOTCONTAINS + 1; 
  {$EXTERNALSYM COP_DOSWILDCARDS}
  COP_WORD_EQUAL           = COP_DOSWILDCARDS + 1; 
  {$EXTERNALSYM COP_WORD_EQUAL}
  COP_WORD_STARTSWITH      = COP_WORD_EQUAL + 1; 
  {$EXTERNALSYM COP_WORD_STARTSWITH}
  COP_APPLICATION_SPECIFIC = COP_WORD_STARTSWITH + 1; 
  {$EXTERNALSYM COP_APPLICATION_SPECIFIC}

{ interface IRichChunk }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRichChunk);'}
  IRichChunk = interface(IUnknown) 
    [SID_IRichChunk]
    function GetData(var pFirstPos: Cardinal; var pLength: Cardinal; 
      var ppsz: LPWSTR; var pValue: TPropVariant): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRichChunk}

{ interface ICondition }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ICondition);'}
  ICondition = interface(IPersistStream) 
    [SID_ICondition]
    function GetConditionType(var pNodeType: TConditionType): HRESULT; stdcall;
  
    function GetSubConditions(const riid: TIID; 
      var ppv: Pointer): HRESULT; stdcall;
  
    function GetComparisonInfo(var ppszPropertyName: LPWSTR; 
      var pcop: TConditionOperation; var ppropvar: TPropVariant): HRESULT; stdcall;
  
    function GetValueType(var ppszValueTypeName: LPWSTR): HRESULT; stdcall;
  
    function GetValueNormalization(
      var ppszNormalization: LPWSTR): HRESULT; stdcall;
  
    function GetInputTerms(out ppPropertyTerm: IRichChunk; 
      out ppOperationTerm: IRichChunk; 
      out ppValueTerm: IRichChunk): HRESULT; stdcall;
  
    function Clone(out ppc: ICondition): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ICondition}

{ interface ICondition2 }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ICondition2);'}
  ICondition2 = interface(ICondition) 
    [SID_ICondition2]
    function GetLocale(var ppszLocaleName: LPWSTR): HRESULT; stdcall;
  
    function GetLeafConditionInfo(var ppropkey: TPropertyKey; 
      var pcop: TConditionOperation; var ppropvar: TPropVariant): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ICondition2}

implementation

end.
