{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: propsys.h                              }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.PropSys;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses
  Winapi.Windows, Winapi.ActiveX,  Winapi.StructuredQueryCondition;

{$HPPEMIT '#include <propsys.h>'}

const
  SID_IInitializeWithFile                     = '{b7d14566-0509-4cce-a71f-0a554233bd9b}';
  SID_IInitializeWithStream                   = '{b824b49d-22ac-4161-ac8a-9916e8fa3f7f}';
  SID_IPropertyStore                          = '{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}';
  SID_INamedPropertyStore                     = '{71604b0f-97b0-4764-8577-2f13e98a1422}';
  SID_IObjectWithPropertyKey                  = '{fc0ca0a7-c316-4fd2-9031-3e628e6d4f23}';
  SID_IPropertyChange                         = '{f917bc8a-1bba-4478-a245-1bde03eb9431}';
  SID_IPropertyChangeArray                    = '{380f5cad-1b5e-42f2-805d-637fd392d31e}';
  SID_IPropertyStoreCapabilities              = '{c8e2d566-186e-4d49-bf41-6909ead56acc}';
  SID_IPropertyStoreCache                     = '{3017056d-9a91-4e90-937d-746c72abbf4f}';
  SID_IPropertyEnumType                       = '{11e1fbf9-2d56-4a6b-8db3-7cd193a471f2}';
  SID_IPropertyEnumType2                      = '{9b6e051c-5ddd-4321-9070-fe2acb55e794}';
  SID_IPropertyEnumTypeList                   = '{a99400f4-3d84-4557-94ba-1242fb2cc9a6}';
  SID_IPropertyDescription                    = '{6f79d558-3e96-4549-a1d1-7d75d2288814}';
  SID_IPropertyDescription2                   = '{57d2eded-5062-400e-b107-5dae79fe57a6}';
  SID_IPropertyDescriptionAliasInfo           = '{f67104fc-2af9-46fd-b32d-243c1404f3d1}';
  SID_IPropertyDescriptionSearchInfo          = '{078f91bd-29a2-440f-924e-46a291524520}';
  SID_IPropertyDescriptionRelatedPropertyInfo = '{507393f4-2a3d-4a60-b59e-d9c75716c2dd}';
  SID_IPropertySystem                         = '{ca724e8a-c3e6-442b-88a4-6fb0db8035a3}';
  SID_IPropertyDescriptionList                = '{1f9fc1d0-c39b-4b26-817f-011967d3440e}';
  SID_IPropertyStoreFactory                   = '{bc110b6d-57e8-4148-a9c6-91015ab2f3a5}';
  SID_IDelayedPropertyStoreFactory            = '{40d4577f-e237-4bdb-bd69-58f089431b6a}';
  SID_IPersistSerializedPropStorage           = '{e318ad57-0aa0-450f-aca5-6fab7103d917}';
  SID_IPersistSerializedPropStorage2          = '{77effa68-4f98-4366-ba72-573b3d880571}';
  SID_IPropertySystemChangeNotify             = '{fa955fd9-38be-4879-a6ce-824cf52d609f}';
  SID_ICreateObject                           = '{75121952-e0d0-43e5-9380-1d80483acf72}';

  IID_IInitializeWithFile: TGUID                     = SID_IInitializeWithFile;
  {$EXTERNALSYM IID_IInitializeWithFile}
  IID_IInitializeWithStream: TGUID                   = SID_IInitializeWithStream;
  {$EXTERNALSYM IID_IInitializeWithStream}
  IID_IPropertyStore: TGUID                          = SID_IPropertyStore;
  {$EXTERNALSYM IID_IPropertyStore}
  IID_INamedPropertyStore: TGUID                     = SID_INamedPropertyStore;
  {$EXTERNALSYM IID_INamedPropertyStore}
  IID_IObjectWithPropertyKey: TGUID                  = SID_IObjectWithPropertyKey;
  {$EXTERNALSYM IID_IObjectWithPropertyKey}
  IID_IPropertyChange: TGUID                         = SID_IPropertyChange;
  {$EXTERNALSYM IID_IPropertyChange}
  IID_IPropertyChangeArray: TGUID                    = SID_IPropertyChangeArray;
  {$EXTERNALSYM IID_IPropertyChangeArray}
  IID_IPropertyStoreCapabilities: TGUID              = SID_IPropertyStoreCapabilities;
  {$EXTERNALSYM IID_IPropertyStoreCapabilities}
  IID_IPropertyStoreCache: TGUID                     = SID_IPropertyStoreCache;
  {$EXTERNALSYM IID_IPropertyStoreCache}
  IID_IPropertyEnumType: TGUID                       = SID_IPropertyEnumType;
  {$EXTERNALSYM IID_IPropertyEnumType}
  IID_IPropertyEnumType2: TGUID                      = SID_IPropertyEnumType2;
  {$EXTERNALSYM IID_IPropertyEnumType2}
  IID_IPropertyEnumTypeList: TGUID                   = SID_IPropertyEnumTypeList;
  {$EXTERNALSYM IID_IPropertyEnumTypeList}
  IID_IPropertyDescription: TGUID                    = SID_IPropertyDescription;
  {$EXTERNALSYM IID_IPropertyDescription}
  IID_IPropertyDescription2: TGUID                   = SID_IPropertyDescription2;
  {$EXTERNALSYM IID_IPropertyDescription2}
  IID_IPropertyDescriptionAliasInfo: TGUID           = SID_IPropertyDescriptionAliasInfo;
  {$EXTERNALSYM IID_IPropertyDescriptionAliasInfo}
  IID_IPropertyDescriptionSearchInfo: TGUID          = SID_IPropertyDescriptionSearchInfo;
  {$EXTERNALSYM IID_IPropertyDescriptionSearchInfo}
  IID_IPropertyDescriptionRelatedPropertyInfo: TGUID = SID_IPropertyDescriptionRelatedPropertyInfo;
  {$EXTERNALSYM IID_IPropertyDescriptionRelatedPropertyInfo}
  IID_IPropertySystem: TGUID                         = SID_IPropertySystem;
  {$EXTERNALSYM IID_IPropertySystem}
  IID_IPropertyDescriptionList: TGUID                = SID_IPropertyDescriptionList;
  {$EXTERNALSYM IID_IPropertyDescriptionList}
  IID_IPropertyStoreFactory: TGUID                   = SID_IPropertyStoreFactory;
  {$EXTERNALSYM IID_IPropertyStoreFactory}
  IID_IDelayedPropertyStoreFactory: TGUID            = SID_IDelayedPropertyStoreFactory;
  {$EXTERNALSYM IID_IDelayedPropertyStoreFactory}
  IID_IPersistSerializedPropStorage: TGUID           = SID_IPersistSerializedPropStorage;
  {$EXTERNALSYM IID_IPersistSerializedPropStorage}
  IID_IPersistSerializedPropStorage2: TGUID          = SID_IPersistSerializedPropStorage2;
  {$EXTERNALSYM IID_IPersistSerializedPropStorage2}
  IID_IPropertySystemChangeNotify: TGUID             = SID_IPropertySystemChangeNotify;
  {$EXTERNALSYM IID_IPropertySystemChangeNotify}
  IID_ICreateObject: TGUID                           = SID_ICreateObject;
  {$EXTERNALSYM IID_ICreateObject}

{ library PropSysObjects }
  CLSID_IInMemoryPropertyStore: TGUID = (
    D1:$9A02E012; D2:$6303; D3:$4E1E; D4:($B9,$A1,$63,$0F,$80,$25,$92,$C5));
  {$EXTERNALSYM CLSID_IInMemoryPropertyStore}
  CLSID_IPropertySystem: TGUID = (
    D1:$B8967F85; D2:$58AE; D3:$4F46; D4:($9F,$B2,$5D,$79,$04,$79,$8F,$4B));
  {$EXTERNALSYM CLSID_IPropertySystem}

{ interface IInitializeWithFile }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInitializeWithFile);'}
  IInitializeWithFile = interface(IUnknown)
    [SID_IInitializeWithFile]
    function Initialize(pszFilePath: LPCWSTR; grfMode: DWORD): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IInitializeWithFile}

{ interface IInitializeWithStream }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInitializeWithStream);'}
  IInitializeWithStream = interface(IUnknown)
    [SID_IInitializeWithStream]
    function Initialize(const pstream: IStream; grfMode: DWORD): HRESULT; stdcall;               
  end;
  {$EXTERNALSYM IInitializeWithStream}

{ interface IPropertyStore }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyStore);'}
  IPropertyStore = interface(IUnknown) 
    [SID_IPropertyStore]
    function GetCount(out cProps: DWORD): HRESULT; stdcall;

    function GetAt(iProp: DWORD; out pkey: TPropertyKey): HRESULT; stdcall;
  
    function GetValue(const key: TPropertyKey; out pv: TPropVariant): HRESULT; stdcall;

    function SetValue(const key: TPropertyKey; const propvar: TPropVariant): HRESULT; stdcall;
  
    function Commit: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyStore}

{ interface INamedPropertyStore }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(INamedPropertyStore);'}
  INamedPropertyStore = interface(IUnknown) 
    [SID_INamedPropertyStore]
    function GetNamedValue(pszName: LPCWSTR; out ppropvar: TPropVariant): HRESULT; stdcall;
    function SetNamedValue(pszName: LPCWSTR; const propvar: TPropVariant): HRESULT; stdcall;
    function GetNameCount(var pdwCount: DWORD): HRESULT; stdcall;
    function GetNameAt(iProp: DWORD; var pbstrName: WideString): HRESULT; stdcall;
  end;
  {$EXTERNALSYM INamedPropertyStore}

{ interface IObjectWithPropertyKey }
type
  GETPROPERTYSTOREFLAGS = type Integer; 
  {$EXTERNALSYM GETPROPERTYSTOREFLAGS}
  TGetPropertyStoreFlags = GETPROPERTYSTOREFLAGS;
const
  GPS_DEFAULT               = 0; 
  {$EXTERNALSYM GPS_DEFAULT}
  GPS_HANDLERPROPERTIESONLY = $1; 
  {$EXTERNALSYM GPS_HANDLERPROPERTIESONLY}
  GPS_READWRITE             = $2; 
  {$EXTERNALSYM GPS_READWRITE}
  GPS_TEMPORARY             = $4; 
  {$EXTERNALSYM GPS_TEMPORARY}
  GPS_FASTPROPERTIESONLY    = $8; 
  {$EXTERNALSYM GPS_FASTPROPERTIESONLY}
  GPS_OPENSLOWITEM          = $10; 
  {$EXTERNALSYM GPS_OPENSLOWITEM}
  GPS_DELAYCREATION         = $20; 
  {$EXTERNALSYM GPS_DELAYCREATION}
  GPS_BESTEFFORT            = $40; 
  {$EXTERNALSYM GPS_BESTEFFORT}
  GPS_NO_OPLOCK             = $80; 
  {$EXTERNALSYM GPS_NO_OPLOCK}
  GPS_MASK_VALID            = $FF; 
  {$EXTERNALSYM GPS_MASK_VALID}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IObjectWithPropertyKey);'}
  IObjectWithPropertyKey = interface(IUnknown) 
    [SID_IObjectWithPropertyKey]
    function SetPropertyKey(const key: TPropertyKey): HRESULT; stdcall;
  
    function GetPropertyKey(out pkey: TPropertyKey): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IObjectWithPropertyKey}

type
  PKA_FLAGS = type Integer; 
  {$EXTERNALSYM PKA_FLAGS}
  TPKAFlags = PKA_FLAGS;
const
  PKA_SET    = 0; 
  {$EXTERNALSYM PKA_SET}
  PKA_APPEND = PKA_SET + 1; 
  {$EXTERNALSYM PKA_APPEND}
  PKA_DELETE = PKA_APPEND + 1; 
  {$EXTERNALSYM PKA_DELETE}

{ interface IPropertyChange }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyChange);'}
  IPropertyChange = interface(IObjectWithPropertyKey)
    [SID_IPropertyChange]
    function ApplyToPropVariant(const propvarIn: TPropVariant; 
      out ppropvarOut: TPropVariant): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyChange}

{ interface IPropertyChangeArray }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyChangeArray);'}
  IPropertyChangeArray = interface(IUnknown) 
    [SID_IPropertyChangeArray]
    function GetCount(out pcOperations: UINT): HRESULT; stdcall;
  
    function GetAt(iIndex: UINT; const riid: TIID; out ppv): HRESULT; stdcall;

    function InsertAt(iIndex: UINT;
      const ppropChange: IPropertyChange): HRESULT; stdcall;

    function Append(const ppropChange: IPropertyChange): HRESULT; stdcall;

    function AppendOrReplace(const ppropChange: IPropertyChange): HRESULT; stdcall;

    function RemoveAt(iIndex: UINT): HRESULT; stdcall;

    function IsKeyInArray(const key: TPropertyKey): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyChangeArray}

{ interface IPropertyStoreCapabilities }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyStoreCapabilities);'}
  IPropertyStoreCapabilities = interface(IUnknown)
    [SID_IPropertyStoreCapabilities]
    function IsPropertyWritable(const key: TPropertyKey): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyStoreCapabilities}

{ interface IPropertyStoreCache }
type
  PSC_STATE = type Integer;
  {$EXTERNALSYM PSC_STATE}
  TPSCState = PSC_STATE;
const
  PSC_NORMAL      = 0;
  {$EXTERNALSYM PSC_NORMAL}
  PSC_NOTINSOURCE = 1;
  {$EXTERNALSYM PSC_NOTINSOURCE}
  PSC_DIRTY       = 2;
  {$EXTERNALSYM PSC_DIRTY}
  PSC_READONLY    = 3; 
  {$EXTERNALSYM PSC_READONLY}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyStoreCache);'}
  IPropertyStoreCache = interface(IPropertyStore) 
    [SID_IPropertyStoreCache]
    function GetState(const key: TPropertyKey;
      out pstate: TPSCState): HRESULT; stdcall;
  
    function GetValueAndState(const key: TPropertyKey; out ppropvar: TPropVariant;
      out pstate: TPSCState): HRESULT; stdcall;
  
    function SetState(const key: TPropertyKey; state: TPSCState): HRESULT; stdcall;

    function SetValueAndState(const key: TPropertyKey; const ppropvar: TPropVariant;
      state: TPSCState): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyStoreCache}

{ interface IPropertyEnumType }
type
  PROPENUMTYPE = type Integer;
  {$EXTERNALSYM PROPENUMTYPE}
  TPropEnumType = PROPENUMTYPE;
const
  PET_DISCRETEVALUE = 0; 
  {$EXTERNALSYM PET_DISCRETEVALUE}
  PET_RANGEDVALUE   = 1; 
  {$EXTERNALSYM PET_RANGEDVALUE}
  PET_DEFAULTVALUE  = 2; 
  {$EXTERNALSYM PET_DEFAULTVALUE}
  PET_ENDRANGE      = 3; 
  {$EXTERNALSYM PET_ENDRANGE}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyEnumType);'}
  IPropertyEnumType = interface(IUnknown) 
    [SID_IPropertyEnumType]
    function GetEnumType(var penumtype: TPropEnumType): HRESULT; stdcall;
  
    function GetValue(out ppropvar: TPropVariant): HRESULT; stdcall;
  
    function GetRangeMinValue(out ppropvarMin: TPropVariant): HRESULT; stdcall;
  
    function GetRangeSetValue(out ppropvarSet: TPropVariant): HRESULT; stdcall;
  
    function GetDisplayText(out ppszDisplay: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyEnumType}

{ interface IPropertyEnumType2 }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyEnumType2);'}
  IPropertyEnumType2 = interface(IPropertyEnumType) 
    [SID_IPropertyEnumType2]
    function GetImageReference(out ppszImageRes: LPWSTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyEnumType2}

{ interface IPropertyEnumTypeList }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyEnumTypeList);'}
  IPropertyEnumTypeList = interface(IUnknown) 
    [SID_IPropertyEnumTypeList]
    function GetCount(out pctypes: UINT): HRESULT; stdcall;
  
    function GetAt(itype: UINT; const riid: TIID; out ppv): HRESULT; stdcall;
  
    function GetConditionAt(nIndex: UINT; const riid: TIID; out ppv): HRESULT; stdcall;
  
    function FindMatchingIndex(const propvarCmp: TPropVariant;
      out pnIndex: UINT): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyEnumTypeList}

{ interface IPropertyDescription }
type
  PROPDESC_TYPE_FLAGS = type Integer; 
  {$EXTERNALSYM PROPDESC_TYPE_FLAGS}
  TPropDescTypeFlags = PROPDESC_TYPE_FLAGS;
const
  PDTF_DEFAULT                = 0; 
  {$EXTERNALSYM PDTF_DEFAULT}
  PDTF_MULTIPLEVALUES         = $1; 
  {$EXTERNALSYM PDTF_MULTIPLEVALUES}
  PDTF_ISINNATE               = $2;
  {$EXTERNALSYM PDTF_ISINNATE}
  PDTF_ISGROUP                = $4; 
  {$EXTERNALSYM PDTF_ISGROUP}
  PDTF_CANGROUPBY             = $8; 
  {$EXTERNALSYM PDTF_CANGROUPBY}
  PDTF_CANSTACKBY             = $10; 
  {$EXTERNALSYM PDTF_CANSTACKBY}
  PDTF_ISTREEPROPERTY         = $20; 
  {$EXTERNALSYM PDTF_ISTREEPROPERTY}
  PDTF_INCLUDEINFULLTEXTQUERY = $40; 
  {$EXTERNALSYM PDTF_INCLUDEINFULLTEXTQUERY}
  PDTF_ISVIEWABLE             = $80;
  {$EXTERNALSYM PDTF_ISVIEWABLE}
  PDTF_ISQUERYABLE            = $100;
  {$EXTERNALSYM PDTF_ISQUERYABLE}
  PDTF_CANBEPURGED            = $200; 
  {$EXTERNALSYM PDTF_CANBEPURGED}
  PDTF_SEARCHRAWVALUE         = $400; 
  {$EXTERNALSYM PDTF_SEARCHRAWVALUE}
  PDTF_ISSYSTEMPROPERTY       = $80000000; 
  {$EXTERNALSYM PDTF_ISSYSTEMPROPERTY}
  PDTF_MASK_ALL               = $800007FF; 
  {$EXTERNALSYM PDTF_MASK_ALL}

type
  PROPDESC_VIEW_FLAGS = type Integer;
  {$EXTERNALSYM PROPDESC_VIEW_FLAGS}
  TPropDescViewFlags = PROPDESC_VIEW_FLAGS;
const
  PDVF_DEFAULT                = 0; 
  {$EXTERNALSYM PDVF_DEFAULT}
  PDVF_CENTERALIGN            = $1; 
  {$EXTERNALSYM PDVF_CENTERALIGN}
  PDVF_RIGHTALIGN             = $2; 
  {$EXTERNALSYM PDVF_RIGHTALIGN}
  PDVF_BEGINNEWGROUP          = $4; 
  {$EXTERNALSYM PDVF_BEGINNEWGROUP}
  PDVF_FILLAREA               = $8; 
  {$EXTERNALSYM PDVF_FILLAREA}
  PDVF_SORTDESCENDING         = $10; 
  {$EXTERNALSYM PDVF_SORTDESCENDING}
  PDVF_SHOWONLYIFPRESENT      = $20; 
  {$EXTERNALSYM PDVF_SHOWONLYIFPRESENT}
  PDVF_SHOWBYDEFAULT          = $40; 
  {$EXTERNALSYM PDVF_SHOWBYDEFAULT}
  PDVF_SHOWINPRIMARYLIST      = $80; 
  {$EXTERNALSYM PDVF_SHOWINPRIMARYLIST}
  PDVF_SHOWINSECONDARYLIST    = $100; 
  {$EXTERNALSYM PDVF_SHOWINSECONDARYLIST}
  PDVF_HIDELABEL              = $200;
  {$EXTERNALSYM PDVF_HIDELABEL}
  PDVF_HIDDEN                 = $800; 
  {$EXTERNALSYM PDVF_HIDDEN}
  PDVF_CANWRAP                = $1000; 
  {$EXTERNALSYM PDVF_CANWRAP}
  PDVF_MASK_ALL               = $1BFF; 
  {$EXTERNALSYM PDVF_MASK_ALL}

type
  PROPDESC_DISPLAYTYPE = type Integer;
  {$EXTERNALSYM PROPDESC_DISPLAYTYPE}
  TPropDescDisplayType = PROPDESC_DISPLAYTYPE;
const
  PDDT_STRING     = 0; 
  {$EXTERNALSYM PDDT_STRING}
  PDDT_NUMBER     = 1; 
  {$EXTERNALSYM PDDT_NUMBER}
  PDDT_BOOLEAN    = 2; 
  {$EXTERNALSYM PDDT_BOOLEAN}
  PDDT_DATETIME   = 3; 
  {$EXTERNALSYM PDDT_DATETIME}
  PDDT_ENUMERATED = 4; 
  {$EXTERNALSYM PDDT_ENUMERATED}

type
  PROPDESC_GROUPING_RANGE = type Integer;
  {$EXTERNALSYM PROPDESC_GROUPING_RANGE}
  TPropDescGroupingRange = PROPDESC_GROUPING_RANGE;
const
  PDGR_DISCRETE     = 0; 
  {$EXTERNALSYM PDGR_DISCRETE}
  PDGR_ALPHANUMERIC = 1; 
  {$EXTERNALSYM PDGR_ALPHANUMERIC}
  PDGR_SIZE         = 2; 
  {$EXTERNALSYM PDGR_SIZE}
  PDGR_DYNAMIC      = 3; 
  {$EXTERNALSYM PDGR_DYNAMIC}
  PDGR_DATE         = 4; 
  {$EXTERNALSYM PDGR_DATE}
  PDGR_PERCENT      = 5; 
  {$EXTERNALSYM PDGR_PERCENT}
  PDGR_ENUMERATED   = 6; 
  {$EXTERNALSYM PDGR_ENUMERATED}

type
  PROPDESC_FORMAT_FLAGS = type Integer;
  {$EXTERNALSYM PROPDESC_FORMAT_FLAGS}
  TPropDescFormatFlags = PROPDESC_FORMAT_FLAGS;
const
  PDFF_DEFAULT              = 0;
  {$EXTERNALSYM PDFF_DEFAULT}
  PDFF_PREFIXNAME           = $1; 
  {$EXTERNALSYM PDFF_PREFIXNAME}
  PDFF_FILENAME             = $2; 
  {$EXTERNALSYM PDFF_FILENAME}
  PDFF_ALWAYSKB             = $4; 
  {$EXTERNALSYM PDFF_ALWAYSKB}
  PDFF_RESERVED_RIGHTTOLEFT = $8; 
  {$EXTERNALSYM PDFF_RESERVED_RIGHTTOLEFT}
  PDFF_SHORTTIME            = $10; 
  {$EXTERNALSYM PDFF_SHORTTIME}
  PDFF_LONGTIME             = $20;
  {$EXTERNALSYM PDFF_LONGTIME}
  PDFF_HIDETIME             = $40;
  {$EXTERNALSYM PDFF_HIDETIME}
  PDFF_SHORTDATE            = $80; 
  {$EXTERNALSYM PDFF_SHORTDATE}
  PDFF_LONGDATE             = $100; 
  {$EXTERNALSYM PDFF_LONGDATE}
  PDFF_HIDEDATE             = $200; 
  {$EXTERNALSYM PDFF_HIDEDATE}
  PDFF_RELATIVEDATE         = $400; 
  {$EXTERNALSYM PDFF_RELATIVEDATE}
  PDFF_USEEDITINVITATION    = $800; 
  {$EXTERNALSYM PDFF_USEEDITINVITATION}
  PDFF_READONLY             = $1000; 
  {$EXTERNALSYM PDFF_READONLY}
  PDFF_NOAUTOREADINGORDER   = $2000; 
  {$EXTERNALSYM PDFF_NOAUTOREADINGORDER}

type
  PROPDESC_SORTDESCRIPTION = type Integer;
  {$EXTERNALSYM PROPDESC_SORTDESCRIPTION}
  TPropDescSortDescription = PROPDESC_SORTDESCRIPTION;
const
  PDSD_GENERAL          = 0; 
  {$EXTERNALSYM PDSD_GENERAL}
  PDSD_A_Z              = 1; 
  {$EXTERNALSYM PDSD_A_Z}
  PDSD_LOWEST_HIGHEST   = 2; 
  {$EXTERNALSYM PDSD_LOWEST_HIGHEST}
  PDSD_SMALLEST_BIGGEST = 3; 
  {$EXTERNALSYM PDSD_SMALLEST_BIGGEST}
  PDSD_OLDEST_NEWEST    = 4; 
  {$EXTERNALSYM PDSD_OLDEST_NEWEST}

type
  PROPDESC_RELATIVEDESCRIPTION_TYPE = type Integer;
  {$EXTERNALSYM PROPDESC_RELATIVEDESCRIPTION_TYPE}
  TPropDescRelativeDescriptionType = PROPDESC_RELATIVEDESCRIPTION_TYPE;
const
  PDRDT_GENERAL  = 0; 
  {$EXTERNALSYM PDRDT_GENERAL}
  PDRDT_DATE     = 1; 
  {$EXTERNALSYM PDRDT_DATE}
  PDRDT_SIZE     = 2; 
  {$EXTERNALSYM PDRDT_SIZE}
  PDRDT_COUNT    = 3; 
  {$EXTERNALSYM PDRDT_COUNT}
  PDRDT_REVISION = 4; 
  {$EXTERNALSYM PDRDT_REVISION}
  PDRDT_LENGTH   = 5; 
  {$EXTERNALSYM PDRDT_LENGTH}
  PDRDT_DURATION = 6; 
  {$EXTERNALSYM PDRDT_DURATION}
  PDRDT_SPEED    = 7; 
  {$EXTERNALSYM PDRDT_SPEED}
  PDRDT_RATE     = 8; 
  {$EXTERNALSYM PDRDT_RATE}
  PDRDT_RATING   = 9; 
  {$EXTERNALSYM PDRDT_RATING}
  PDRDT_PRIORITY = 10; 
  {$EXTERNALSYM PDRDT_PRIORITY}

type
  PROPDESC_AGGREGATION_TYPE = type Integer;
  {$EXTERNALSYM PROPDESC_AGGREGATION_TYPE}
  TPropDescAggregationType = PROPDESC_AGGREGATION_TYPE;
const
  PDAT_DEFAULT   = 0; 
  {$EXTERNALSYM PDAT_DEFAULT}
  PDAT_FIRST     = 1; 
  {$EXTERNALSYM PDAT_FIRST}
  PDAT_SUM       = 2; 
  {$EXTERNALSYM PDAT_SUM}
  PDAT_AVERAGE   = 3; 
  {$EXTERNALSYM PDAT_AVERAGE}
  PDAT_DATERANGE = 4; 
  {$EXTERNALSYM PDAT_DATERANGE}
  PDAT_UNION     = 5; 
  {$EXTERNALSYM PDAT_UNION}
  PDAT_MAX       = 6; 
  {$EXTERNALSYM PDAT_MAX}
  PDAT_MIN       = 7; 
  {$EXTERNALSYM PDAT_MIN}

type
  PROPDESC_CONDITION_TYPE = type Integer;
  {$EXTERNALSYM PROPDESC_CONDITION_TYPE}
  TPropDescConditionType = PROPDESC_CONDITION_TYPE;
const
  PDCOT_NONE     = 0; 
  {$EXTERNALSYM PDCOT_NONE}
  PDCOT_STRING   = 1; 
  {$EXTERNALSYM PDCOT_STRING}
  PDCOT_SIZE     = 2; 
  {$EXTERNALSYM PDCOT_SIZE}
  PDCOT_DATETIME = 3; 
  {$EXTERNALSYM PDCOT_DATETIME}
  PDCOT_BOOLEAN  = 4; 
  {$EXTERNALSYM PDCOT_BOOLEAN}
  PDCOT_NUMBER   = 5;
  {$EXTERNALSYM PDCOT_NUMBER}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyDescription);'}
  IPropertyDescription = interface(IUnknown) 
    [SID_IPropertyDescription]
    function GetPropertyKey(var pkey: TPropertyKey): HRESULT; stdcall;
  
    function GetCanonicalName(var ppszName: LPWSTR): HRESULT; stdcall;
  
    function GetPropertyType(var pvartype: TVarType): HRESULT; stdcall;
  
    function GetDisplayName(var ppszName: LPWSTR): HRESULT; stdcall;
  
    function GetEditInvitation(var ppszInvite: LPWSTR): HRESULT; stdcall;
  
    function GetTypeFlags(mask: TPropDescTypeFlags; 
      var ppdtFlags: TPropDescTypeFlags): HRESULT; stdcall;
  
    function GetViewFlags(var ppdvFlags: TPropDescViewFlags): HRESULT; stdcall;
  
    function GetDefaultColumnWidth(var pcxChars: UINT): HRESULT; stdcall;
  
    function GetDisplayType(
      var pdisplaytype: TPropDescDisplayType): HRESULT; stdcall;
  
    function GetColumnState(var pcsFlags: DWORD): HRESULT; stdcall;
  
    function GetGroupingRange(var pgr: TPropDescGroupingRange): HRESULT; stdcall;
  
    function GetRelativeDescriptionType(
      var prdt: TPropDescRelativeDescriptionType): HRESULT; stdcall;
  
    function GetRelativeDescription(const propvar1: TPropVariant; 
      propvar2: TPropVariant; var ppszDesc1: LPWSTR; 
      var ppszDesc2: LPWSTR): HRESULT; stdcall;
  
    function GetSortDescription(
      var psd: TPropDescSortDescription): HRESULT; stdcall;
  
    function GetSortDescriptionLabel(fDescending: BOOL; 
      var ppszDescription: LPWSTR): HRESULT; stdcall;
  
    function GetAggregationType(
      var paggtype: TPropDescAggregationType): HRESULT; stdcall;

    function GetConditionType(var pcontype: TPropDescConditionType;
      var popDefault: TConditionOperation): HRESULT; stdcall;

    function GetEnumTypeList(const riid: TIID; var ppv: Pointer): HRESULT; stdcall;
  
    function CoerceToCanonicalValue(var ppropvar: TPropVariant): HRESULT; stdcall;
  
    function FormatForDisplay(const propvar: TPropVariant; 
      pdfFlags: TPropDescFormatFlags; var ppszDisplay: LPWSTR): HRESULT; stdcall;
  
    function IsValueCanonical(const propvar: TPropVariant): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyDescription}

{ interface IPropertyDescription2 }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyDescription2);'}
  IPropertyDescription2 = interface(IPropertyDescription) 
    [SID_IPropertyDescription2]
    function GetImageReferenceForValue(const propvar: TPropVariant; 
      var ppszImageRes: LPWSTR): HRESULT; stdcall;
  
  end;
  {$EXTERNALSYM IPropertyDescription2}

{ interface IPropertyDescriptionAliasInfo }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyDescriptionAliasInfo);'}
  IPropertyDescriptionAliasInfo = interface(IPropertyDescription) 
    [SID_IPropertyDescriptionAliasInfo]
    function GetSortByAlias(const riid: TIID; var ppv: Pointer): HRESULT; stdcall;
  
    function GetAdditionalSortByAliases(const riid: TIID; 
      var ppv: Pointer): HRESULT; stdcall;
  
  end;
  {$EXTERNALSYM IPropertyDescriptionAliasInfo}

{ interface IPropertyDescriptionSearchInfo }
type
  PROPDESC_SEARCHINFO_FLAGS = type Integer; 
  {$EXTERNALSYM PROPDESC_SEARCHINFO_FLAGS}
  TPropDescSearchInfoFlags = PROPDESC_SEARCHINFO_FLAGS;
const
  PDSIF_DEFAULT         = 0; 
  {$EXTERNALSYM PDSIF_DEFAULT}
  PDSIF_ININVERTEDINDEX = $1; 
  {$EXTERNALSYM PDSIF_ININVERTEDINDEX}
  PDSIF_ISCOLUMN        = $2; 
  {$EXTERNALSYM PDSIF_ISCOLUMN}
  PDSIF_ISCOLUMNSPARSE  = $4; 
  {$EXTERNALSYM PDSIF_ISCOLUMNSPARSE}
  PDSIF_ALWAYSINCLUDE   = $8; 
  {$EXTERNALSYM PDSIF_ALWAYSINCLUDE}

type
  PROPDESC_COLUMNINDEX_TYPE = type Integer; 
  {$EXTERNALSYM PROPDESC_COLUMNINDEX_TYPE}
  TPropDescColumnIndexType = PROPDESC_COLUMNINDEX_TYPE;
const
  PDCIT_NONE         = 0; 
  {$EXTERNALSYM PDCIT_NONE}
  PDCIT_ONDISK       = 1; 
  {$EXTERNALSYM PDCIT_ONDISK}
  PDCIT_INMEMORY     = 2; 
  {$EXTERNALSYM PDCIT_INMEMORY}
  PDCIT_ONDEMAND     = 3; 
  {$EXTERNALSYM PDCIT_ONDEMAND}
  PDCIT_ONDISKALL    = 4; 
  {$EXTERNALSYM PDCIT_ONDISKALL}
  PDCIT_ONDISKVECTOR = 5; 
  {$EXTERNALSYM PDCIT_ONDISKVECTOR}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyDescriptionSearchInfo);'}
  IPropertyDescriptionSearchInfo = interface(IPropertyDescription) 
    [SID_IPropertyDescriptionSearchInfo]
    function GetSearchInfoFlags(
      var ppdsiFlags: TPropDescSearchInfoFlags): HRESULT; stdcall;
  
    function GetColumnIndexType(
      var ppdciType: TPropDescColumnIndexType): HRESULT; stdcall;
  
    function GetProjectionString(var ppszProjection: LPWSTR): HRESULT; stdcall;
  
    function GetMaxSize(var pcbMaxSize: UINT): HRESULT; stdcall;
  
  end;
  {$EXTERNALSYM IPropertyDescriptionSearchInfo}

{ interface IPropertyDescriptionRelatedPropertyInfo }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyDescriptionRelatedPropertyInfo);'}
  IPropertyDescriptionRelatedPropertyInfo = interface(IPropertyDescription) 
    [SID_IPropertyDescriptionRelatedPropertyInfo]
    function GetRelatedProperty(pszRelationshipName: LPCWSTR; const riid: TIID;
      var ppv: Pointer): HRESULT; stdcall;
  
  end;
  {$EXTERNALSYM IPropertyDescriptionRelatedPropertyInfo}

type
  PROPDESC_ENUMFILTER = type Integer;
  {$EXTERNALSYM PROPDESC_ENUMFILTER}
  TPropDescEnumFilter = PROPDESC_ENUMFILTER;
const
  PDEF_ALL             = 0; 
  {$EXTERNALSYM PDEF_ALL}
  PDEF_SYSTEM          = 1;
  {$EXTERNALSYM PDEF_SYSTEM}
  PDEF_NONSYSTEM       = 2;
  {$EXTERNALSYM PDEF_NONSYSTEM}
  PDEF_VIEWABLE        = 3; 
  {$EXTERNALSYM PDEF_VIEWABLE}
  PDEF_QUERYABLE       = 4; 
  {$EXTERNALSYM PDEF_QUERYABLE}
  PDEF_INFULLTEXTQUERY = 5; 
  {$EXTERNALSYM PDEF_INFULLTEXTQUERY}
  PDEF_COLUMN          = 6; 
  {$EXTERNALSYM PDEF_COLUMN}

{ interface IPropertySystem }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertySystem);'}
  IPropertySystem = interface(IUnknown) 
    [SID_IPropertySystem]
    function GetPropertyDescription(const propkey: TPropertyKey; const riid: TIID;
      out ppv): HRESULT; stdcall;

    function GetPropertyDescriptionByName(pszCanonicalName: LPCWSTR;
      const riid: TIID; out ppv): HRESULT; stdcall;
  
    function GetPropertyDescriptionListFromString(pszPropList: LPCWSTR; 
      const riid: TIID; out ppv): HRESULT; stdcall;

    function EnumeratePropertyDescriptions(filterOn: TPropDescEnumFilter;
      const riid: TIID; out ppv): HRESULT; stdcall;
  
    function FormatForDisplay(const key: TPropertyKey; const propvar: TPropVariant;
      pdff: TPropDescFormatFlags; pszText: LPWSTR;
      cchText: DWORD): HRESULT; stdcall;

    function FormatForDisplayAlloc(const key: TPropertyKey; const propvar: TPropVariant;
      pdff: TPropDescFormatFlags; var ppszDisplay: LPWSTR): HRESULT; stdcall;

    function RegisterPropertySchema(pszPath: LPCWSTR): HRESULT; stdcall;

    function UnregisterPropertySchema(pszPath: LPCWSTR): HRESULT; stdcall;
  
    function RefreshPropertySchema: HRESULT; stdcall;
  
  end;
  {$EXTERNALSYM IPropertySystem}

{ interface IPropertyDescriptionList }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyDescriptionList);'}
  IPropertyDescriptionList = interface(IUnknown) 
    [SID_IPropertyDescriptionList]
    function GetCount(var pcElem: UINT): HRESULT; stdcall;
  
    function GetAt(iElem: UINT; const riid: TIID; out ppv): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyDescriptionList}

{ interface IPropertyStoreFactory }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyStoreFactory);'}
  IPropertyStoreFactory = interface(IUnknown) 
    [SID_IPropertyStoreFactory]
    function GetPropertyStore(flags: Integer; const pUnkFactory: IUnknown;
      const riid: TIID; out ppv): HRESULT; stdcall;
  
    function GetPropertyStoreForKeys(const rgKeys: PROPERTYKEY; cKeys: UINT;
      flags: Integer; const riid: TIID; out ppv): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyStoreFactory}

{ interface IDelayedPropertyStoreFactory }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDelayedPropertyStoreFactory);'}
  IDelayedPropertyStoreFactory = interface(IPropertyStoreFactory) 
    [SID_IDelayedPropertyStoreFactory]
    function GetDelayedPropertyStore(flags: Integer; dwStoreId: DWORD;
      const riid: TIID; out ppv): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDelayedPropertyStoreFactory}

{ interface IPersistSerializedPropStorage }
type
  tagPERSIST_SPROPSTORE_FLAGS = type Integer;
  {$EXTERNALSYM tagPERSIST_SPROPSTORE_FLAGS}
const
  FPSPS_DEFAULT  = 0;
  {$EXTERNALSYM FPSPS_DEFAULT}
  FPSPS_READONLY = $1;
  {$EXTERNALSYM FPSPS_READONLY}
type
  PERSIST_SPROPSTORE_FLAGS = Integer;
  {$EXTERNALSYM PERSIST_SPROPSTORE_FLAGS}
  TPersistSPropStoreFlags = PERSIST_SPROPSTORE_FLAGS;
  SERIALIZEDPROPSTORAGE = array[0..0] of BYTE;
  {$EXTERNALSYM SERIALIZEDPROPSTORAGE}
  PUSERIALIZEDPROPSTORAGE = ^SERIALIZEDPROPSTORAGE;
  {$EXTERNALSYM PUSERIALIZEDPROPSTORAGE}
  PCUSERIALIZEDPROPSTORAGE = ^SERIALIZEDPROPSTORAGE;
  {$EXTERNALSYM PCUSERIALIZEDPROPSTORAGE}
  TSerializedPropStorage = SerializedPropStorage;
  PSerializedPropStorage = ^TSerializedPropStorage;

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPersistSerializedPropStorage);'}
  IPersistSerializedPropStorage = interface(IUnknown)
    [SID_IPersistSerializedPropStorage]
    function SetFlags(flags: TPersistSPropStoreFlags): HRESULT; stdcall;

    function SetPropertyStorage(var psps: TSerializedPropStorage;
      cb: DWORD): HRESULT; stdcall;

    function GetPropertyStorage(var ppsps: TSerializedPropStorage; var pcb: DWORD): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPersistSerializedPropStorage}

{ interface IPersistSerializedPropStorage2 }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPersistSerializedPropStorage2);'}
  IPersistSerializedPropStorage2 = interface(IPersistSerializedPropStorage)
    [SID_IPersistSerializedPropStorage2]
    function GetPropertyStorageSize(var pcb: DWORD): HRESULT; stdcall;

    function GetPropertyStorageBuffer(var psps: TSerializedPropStorage; cb: DWORD;
      var pcbWritten: DWORD): HRESULT; stdcall;

  end;
  {$EXTERNALSYM IPersistSerializedPropStorage2}

{ interface IPropertySystemChangeNotify }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertySystemChangeNotify);'}
  IPropertySystemChangeNotify = interface(IUnknown)
    [SID_IPropertySystemChangeNotify]
    function SchemaRefreshed: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertySystemChangeNotify}

{ interface ICreateObject }
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ICreateObject);'}
  ICreateObject = interface(IUnknown) 
    [SID_ICreateObject]
    function CreateObject(const clsid: TGUID; const pUnkOuter: IUnknown;
      const riid: TIID; out ppv): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ICreateObject}

// Format a property value for display purposes
function PSFormatForDisplay(const propkey: TPropertyKey; const propvar: TPropVariant;
  pdfFlags: TPropDescFormatFlags; pwszText: LPWSTR;
  cchText: DWORD): HResult; stdcall;
{$EXTERNALSYM PSFormatForDisplay}

function PSFormatForDisplayAlloc(const key: TPropertyKey; const propvar: TPropVariant;
  pdff: TPropDescFormatFlags; var ppszDisplay: LPWSTR): HResult; stdcall;
{$EXTERNALSYM PSFormatForDisplayAlloc}

function PSFormatPropertyValue(var pps: IPropertyStore;
  var ppd: IPropertyDescription; pdff: TPropDescFormatFlags;
  var ppszDisplay: LPWSTR): HResult; stdcall;
{$EXTERNALSYM PSFormatPropertyValue}

// Retrieve the image reference associated with a property value (if specified)
function PSGetImageReferenceForValue(const propkey: TPropertyKey;
  const propvar: TPropVariant; var ppszImageRes: LPWSTR): HResult; stdcall;
{$EXTERNALSYM PSGetImageReferenceForValue}

const
  PKEY_PIDSTR_MAX = 10;      // will take care of any long integer value
  {$EXTERNALSYM PKEY_PIDSTR_MAX}
  GUIDSTRING_MAX = 1 + 8 + 1 + 4 + 1 + 4 + 1 + 4 + 1 + 12 + 1 + 1;        // "{12345678-1234-1234-1234-123456789012}"
  {$EXTERNALSYM GUIDSTRING_MAX}
  PKEYSTR_MAX = GUIDSTRING_MAX + 1 + PKEY_PIDSTR_MAX; 
  {$EXTERNALSYM PKEYSTR_MAX}

// Convert a PROPERTYKEY to and from a PWSTR
function PSStringFromPropertyKey(const pkey: TPropertyKey; psz: LPWSTR;
  cch: UINT): HResult; stdcall;
{$EXTERNALSYM PSStringFromPropertyKey}

function PSPropertyKeyFromString(pszString: LPCWSTR;
  var pkey: PROPERTYKEY): HResult; stdcall;
{$EXTERNALSYM PSPropertyKeyFromString}


// Creates an in-memory property store
// Returns an IPropertyStore, IPersistSerializedPropStorage, and related interfaces interface
function PSCreateMemoryPropertyStore(const riid: TIID; 
  var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSCreateMemoryPropertyStore}


// Create a read-only, delay-bind multiplexing property store
// Returns an IPropertyStore interface or related interfaces
function PSCreateDelayedMultiplexPropertyStore(flags: Integer;
  var pdpsf: IDelayedPropertyStoreFactory; rgStoreIds: array of DWORD;
  cStores: DWORD; const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSCreateDelayedMultiplexPropertyStore}


// Create a read-only property store from one or more sources (which each must support either IPropertyStore or IPropertySetStorage)
// Returns an IPropertyStore interface or related interfaces
function PSCreateMultiplexPropertyStore(prgpunkStores: array of IUnknown;
  cStores: DWORD; const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSCreateMultiplexPropertyStore}


// Create a container for IPropertyChanges
// Returns an IPropertyChangeArray interface
function PSCreatePropertyChangeArray(var rgpropkey: PROPERTYKEY;
  var rgflags: TPKAFlags; var rgpropvar: TPropVariant; cChanges: UINT;
  const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSCreatePropertyChangeArray}


// Create a simple property change
// Returns an IPropertyChange interface
function PSCreateSimplePropertyChange(flags: TPKAFlags; const key: TPropertyKey;
  const propvar: TPropVariant; const riid: TIID;
  var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSCreateSimplePropertyChange}


// Get a property description
// Returns an IPropertyDescription interface
function PSGetPropertyDescription(const propkey: TPropertyKey; const riid: TIID;
  var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSGetPropertyDescription}

function PSGetPropertyDescriptionByName(pszCanonicalName: LPCWSTR; 
  const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSGetPropertyDescriptionByName}


// Lookup a per-machine registered file property handler
function PSLookupPropertyHandlerCLSID(pszFilePath: LPCWSTR; 
  var pclsid: TGUID): HResult; stdcall;
{$EXTERNALSYM PSLookupPropertyHandlerCLSID}
// Get a property handler, on Vista or downlevel to XP
// punkItem is a shell item created with an SHCreateItemXXX API
// Returns an IPropertyStore
function PSGetItemPropertyHandler(var punkItem: IUnknown; fReadWrite: BOOL; 
  const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSGetItemPropertyHandler}


// Get a property handler, on Vista or downlevel to XP
// punkItem is a shell item created with an SHCreateItemXXX API
// punkCreateObject supports ICreateObject
// Returns an IPropertyStore
function PSGetItemPropertyHandlerWithCreateObject(var punkItem: IUnknown;
  fReadWrite: BOOL; var punkCreateObject: IUnknown; const riid: TIID; 
  var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSGetItemPropertyHandlerWithCreateObject}


// Get or set a property value from a store
function PSGetPropertyValue(var pps: IPropertyStore; 
  var ppd: IPropertyDescription; var ppropvar: TPropVariant): HResult; stdcall;
{$EXTERNALSYM PSGetPropertyValue}

function PSSetPropertyValue(const pps: IPropertyStore;
  const ppd: IPropertyDescription; const propvar: TPropVariant): HResult; stdcall;
{$EXTERNALSYM PSSetPropertyValue}


// Interact with the set of property descriptions
function PSRegisterPropertySchema(pszPath: LPCWSTR): HResult; stdcall;
{$EXTERNALSYM PSRegisterPropertySchema}

function PSUnregisterPropertySchema(pszPath: LPCWSTR): HResult; stdcall;
{$EXTERNALSYM PSUnregisterPropertySchema}

function PSRefreshPropertySchema: HResult; stdcall;
{$EXTERNALSYM PSRefreshPropertySchema}

// Returns either: IPropertyDescriptionList or IEnumUnknown interfaces
function PSEnumeratePropertyDescriptions(filterOn: TPropDescEnumFilter;
  const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSEnumeratePropertyDescriptions}


// Convert between a PROPERTYKEY and its canonical name
function PSGetPropertyKeyFromName(pszName: LPCWSTR;
  var ppropkey: PROPERTYKEY): HResult; stdcall;
{$EXTERNALSYM PSGetPropertyKeyFromName}

function PSGetNameFromPropertyKey(const propkey: TPropertyKey;
  var ppszCanonicalName: LPWSTR): HResult; stdcall;
{$EXTERNALSYM PSGetNameFromPropertyKey}


// Coerce and canonicalize a property value
function PSCoerceToCanonicalValue(const key: TPropertyKey;
  var ppropvar: TPropVariant): HResult; stdcall;
{$EXTERNALSYM PSCoerceToCanonicalValue}


// Convert a 'prop:' string into a list of property descriptions
// Returns an IPropertyDescriptionList interface
function PSGetPropertyDescriptionListFromString(pszPropList: LPCWSTR;
  const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSGetPropertyDescriptionListFromString}


// Wrap an IPropertySetStorage interface in an IPropertyStore interface
// Returns an IPropertyStore or related interface
function PSCreatePropertyStoreFromPropertySetStorage(
  var ppss: IPropertySetStorage; grfMode: DWORD; const riid: TIID;
  var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSCreatePropertyStoreFromPropertySetStorage}


// punkSource must support IPropertyStore or IPropertySetStorage
// On success, the returned ppv is guaranteed to support IPropertyStore.
// If punkSource already supports IPropertyStore, no wrapper is created.
function PSCreatePropertyStoreFromObject(var punk: IUnknown; grfMode: DWORD;
  const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSCreatePropertyStoreFromObject}


// punkSource must support IPropertyStore
// riid may be IPropertyStore, IPropertySetStorage, IPropertyStoreCapabilities, or IObjectProvider
function PSCreateAdapterFromPropertyStore(var pps: IPropertyStore;
  const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSCreateAdapterFromPropertyStore}


// Talk to the property system using an interface
// Returns an IPropertySystem interface
function PSGetPropertySystem(const riid: TIID;
  var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSGetPropertySystem}

// Obtain a value from serialized property storage
function PSGetPropertyFromPropertyStorage(psps: PSerializedPropStorage;
  cb: DWORD; rpkey: TPropertyKey;
  var ppropvar: TPropVariant): HResult; stdcall;
{$EXTERNALSYM PSGetPropertyFromPropertyStorage}


// Obtain a named value from serialized property storage
function PSGetNamedPropertyFromPropertyStorage(psps: PSerializedPropStorage;
  cb: DWORD; pszName: LPCWSTR; var ppropvar: TPropVariant): HResult; stdcall;
{$EXTERNALSYM PSGetNamedPropertyFromPropertyStorage}

// Helper functions for reading and writing values from IPropertyBag's.
function PSPropertyBag_ReadType(var propBag: IPropertyBag; propName: LPCWSTR;
  var _var: Variant; _type: TVarType): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadType}
function PSPropertyBag_ReadStr(var propBag: IPropertyBag; propName: LPCWSTR;
  value: LPWSTR; characterCount: Integer): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadStr}
function PSPropertyBag_ReadStrAlloc(var propBag: IPropertyBag; 
  propName: LPCWSTR; var value: LPWSTR): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadStrAlloc}
function PSPropertyBag_ReadBSTR(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: WideString): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadBSTR}
function PSPropertyBag_WriteStr(var propBag: IPropertyBag; propName: LPCWSTR; 
  value: LPCWSTR): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteStr}
function PSPropertyBag_WriteBSTR(var propBag: IPropertyBag; propName: LPCWSTR; 
  value: WideString): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteBSTR}
function PSPropertyBag_ReadInt(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: Integer): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadInt}
function PSPropertyBag_WriteInt(var propBag: IPropertyBag; propName: LPCWSTR; 
  value: Integer): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteInt}
function PSPropertyBag_ReadSHORT(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: Shortint): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadSHORT}
function PSPropertyBag_WriteSHORT(var propBag: IPropertyBag; propName: LPCWSTR; 
  value: Shortint): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteSHORT}
function PSPropertyBag_ReadLONG(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: Integer): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadLONG}
function PSPropertyBag_WriteLONG(var propBag: IPropertyBag; propName: LPCWSTR; 
  value: Integer): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteLONG}
function PSPropertyBag_ReadDWORD(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: DWORD): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadDWORD}
function PSPropertyBag_WriteDWORD(var propBag: IPropertyBag; propName: LPCWSTR; 
  value: DWORD): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteDWORD}
function PSPropertyBag_ReadBOOL(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: BOOL): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadBOOL}
function PSPropertyBag_WriteBOOL(var propBag: IPropertyBag; propName: LPCWSTR; 
  value: BOOL): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteBOOL}
function PSPropertyBag_ReadPOINTL(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: TPointL): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadPOINTL}
function PSPropertyBag_WritePOINTL(var propBag: IPropertyBag; propName: LPCWSTR;
  var value: TPointL): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WritePOINTL}
function PSPropertyBag_ReadPOINTS(var propBag: IPropertyBag; propName: LPCWSTR;
  var value: TSmallPoint): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadPOINTS}
function PSPropertyBag_WritePOINTS(var propBag: IPropertyBag; propName: LPCWSTR;
  var value: TSmallPoint): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WritePOINTS}
function PSPropertyBag_ReadRECTL(var propBag: IPropertyBag; propName: LPCWSTR;
  var value: TRect): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadRECTL}
function PSPropertyBag_WriteRECTL(var propBag: IPropertyBag; propName: LPCWSTR;
  var value: TRect): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteRECTL}
function PSPropertyBag_ReadStream(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: IStream): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadStream}
function PSPropertyBag_WriteStream(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: IStream): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteStream}
function PSPropertyBag_Delete(var propBag: IPropertyBag; 
  propName: LPCWSTR): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_Delete}
function PSPropertyBag_ReadULONGLONG(var propBag: IPropertyBag; 
  propName: LPCWSTR; var value: ULONGLONG): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadULONGLONG}
function PSPropertyBag_WriteULONGLONG(var propBag: IPropertyBag; 
  propName: LPCWSTR; value: ULONGLONG): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteULONGLONG}
function PSPropertyBag_ReadUnknown(var propBag: IPropertyBag; propName: LPCWSTR; 
  const riid: TIID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadUnknown}
function PSPropertyBag_WriteUnknown(var propBag: IPropertyBag; 
  propName: LPCWSTR; var punk: IUnknown): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteUnknown}
function PSPropertyBag_ReadGUID(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: TGUID): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadGUID}
function PSPropertyBag_WriteGUID(var propBag: IPropertyBag; propName: LPCWSTR; 
  var value: TGUID): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WriteGUID}
function PSPropertyBag_ReadPropertyKey(var propBag: IPropertyBag; 
  propName: LPCWSTR; var value: PROPERTYKEY): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_ReadPropertyKey}
function PSPropertyBag_WritePropertyKey(var propBag: IPropertyBag; 
  propName: LPCWSTR; value: TPropertyKey): HResult; stdcall;
{$EXTERNALSYM PSPropertyBag_WritePropertyKey}

implementation

const
  propsyslib = 'propsys.dll';

function PSFormatForDisplay; external propsyslib name 'PSFormatForDisplay' delayed;
function PSFormatForDisplayAlloc; external propsyslib name 'PSFormatForDisplayAlloc' delayed;
function PSFormatPropertyValue; external propsyslib name 'PSFormatPropertyValue' delayed;
function PSGetImageReferenceForValue; external propsyslib name 'PSGetImageReferenceForValue' delayed;
function PSStringFromPropertyKey; external propsyslib name 'PSStringFromPropertyKey' delayed;
function PSPropertyKeyFromString; external propsyslib name 'PSPropertyKeyFromString' delayed;
function PSCreateMemoryPropertyStore; external propsyslib name 'PSCreateMemoryPropertyStore' delayed;
function PSCreateDelayedMultiplexPropertyStore; external propsyslib name 'PSCreateDelayedMultiplexPropertyStore' delayed;
function PSCreateMultiplexPropertyStore; external propsyslib name 'PSCreateMultiplexPropertyStore' delayed;
function PSCreatePropertyChangeArray; external propsyslib name 'PSCreatePropertyChangeArray' delayed;
function PSCreateSimplePropertyChange; external propsyslib name 'PSCreateSimplePropertyChange' delayed;
function PSGetPropertyDescription; external propsyslib name 'PSGetPropertyDescription' delayed;
function PSGetPropertyDescriptionByName; external propsyslib name 'PSGetPropertyDescriptionByName' delayed;
function PSLookupPropertyHandlerCLSID; external propsyslib name 'PSLookupPropertyHandlerCLSID' delayed;
function PSGetItemPropertyHandler; external propsyslib name 'PSGetItemPropertyHandler' delayed;
function PSGetItemPropertyHandlerWithCreateObject; external propsyslib name 'PSGetItemPropertyHandlerWithCreateObject' delayed;
function PSGetPropertyValue; external propsyslib name 'PSGetPropertyValue' delayed;
function PSSetPropertyValue; external propsyslib name 'PSSetPropertyValue' delayed;
function PSRegisterPropertySchema; external propsyslib name 'PSRegisterPropertySchema' delayed;
function PSUnregisterPropertySchema; external propsyslib name 'PSUnregisterPropertySchema' delayed;
function PSRefreshPropertySchema; external propsyslib name 'PSRefreshPropertySchema' delayed;
function PSEnumeratePropertyDescriptions; external propsyslib name 'PSEnumeratePropertyDescriptions' delayed;
function PSGetPropertyKeyFromName; external propsyslib name 'PSGetPropertyKeyFromName' delayed;
function PSGetNameFromPropertyKey; external propsyslib name 'PSGetNameFromPropertyKey' delayed;
function PSCoerceToCanonicalValue; external propsyslib name 'PSCoerceToCanonicalValue' delayed;
function PSGetPropertyDescriptionListFromString; external propsyslib name 'PSGetPropertyDescriptionListFromString' delayed;
function PSCreatePropertyStoreFromPropertySetStorage; external propsyslib name 'PSCreatePropertyStoreFromPropertySetStorage' delayed;
function PSCreatePropertyStoreFromObject; external propsyslib name 'PSCreatePropertyStoreFromObject' delayed;
function PSCreateAdapterFromPropertyStore; external propsyslib name 'PSCreateAdapterFromPropertyStore' delayed;
function PSGetPropertySystem; external propsyslib name 'PSGetPropertySystem' delayed;
function PSGetPropertyFromPropertyStorage; external propsyslib name 'PSGetPropertyFromPropertyStorage' delayed;
function PSGetNamedPropertyFromPropertyStorage; external propsyslib name 'PSGetNamedPropertyFromPropertyStorage' delayed;
function PSPropertyBag_ReadType; external propsyslib name 'PSPropertyBag_ReadType' delayed;
function PSPropertyBag_ReadStr; external propsyslib name 'PSPropertyBag_ReadStr' delayed;
function PSPropertyBag_ReadStrAlloc; external propsyslib name 'PSPropertyBag_ReadStrAlloc' delayed;
function PSPropertyBag_ReadBSTR; external propsyslib name 'PSPropertyBag_ReadBSTR' delayed;
function PSPropertyBag_WriteStr; external propsyslib name 'PSPropertyBag_WriteStr' delayed;
function PSPropertyBag_WriteBSTR; external propsyslib name 'PSPropertyBag_WriteBSTR' delayed;
function PSPropertyBag_ReadInt; external propsyslib name 'PSPropertyBag_ReadInt' delayed;
function PSPropertyBag_WriteInt; external propsyslib name 'PSPropertyBag_WriteInt' delayed;
function PSPropertyBag_ReadSHORT; external propsyslib name 'PSPropertyBag_ReadSHORT' delayed;
function PSPropertyBag_WriteSHORT; external propsyslib name 'PSPropertyBag_WriteSHORT' delayed;
function PSPropertyBag_ReadLONG; external propsyslib name 'PSPropertyBag_ReadLONG' delayed;
function PSPropertyBag_WriteLONG; external propsyslib name 'PSPropertyBag_WriteLONG' delayed;
function PSPropertyBag_ReadDWORD; external propsyslib name 'PSPropertyBag_ReadDWORD' delayed;
function PSPropertyBag_WriteDWORD; external propsyslib name 'PSPropertyBag_WriteDWORD' delayed;
function PSPropertyBag_ReadBOOL; external propsyslib name 'PSPropertyBag_ReadBOOL' delayed;
function PSPropertyBag_WriteBOOL; external propsyslib name 'PSPropertyBag_WriteBOOL' delayed;
function PSPropertyBag_ReadPOINTL; external propsyslib name 'PSPropertyBag_ReadPOINTL' delayed;
function PSPropertyBag_WritePOINTL; external propsyslib name 'PSPropertyBag_WritePOINTL' delayed;
function PSPropertyBag_ReadPOINTS; external propsyslib name 'PSPropertyBag_ReadPOINTS' delayed;
function PSPropertyBag_WritePOINTS; external propsyslib name 'PSPropertyBag_WritePOINTS' delayed;
function PSPropertyBag_ReadRECTL; external propsyslib name 'PSPropertyBag_ReadRECTL' delayed;
function PSPropertyBag_WriteRECTL; external propsyslib name 'PSPropertyBag_WriteRECTL' delayed;
function PSPropertyBag_ReadStream; external propsyslib name 'PSPropertyBag_ReadStream' delayed;
function PSPropertyBag_WriteStream; external propsyslib name 'PSPropertyBag_WriteStream' delayed;
function PSPropertyBag_Delete; external propsyslib name 'PSPropertyBag_Delete' delayed;
function PSPropertyBag_ReadULONGLONG; external propsyslib name 'PSPropertyBag_ReadULONGLONG' delayed;
function PSPropertyBag_WriteULONGLONG; external propsyslib name 'PSPropertyBag_WriteULONGLONG' delayed;
function PSPropertyBag_ReadUnknown; external propsyslib name 'PSPropertyBag_ReadUnknown' delayed;
function PSPropertyBag_WriteUnknown; external propsyslib name 'PSPropertyBag_WriteUnknown' delayed;
function PSPropertyBag_ReadGUID; external propsyslib name 'PSPropertyBag_ReadGUID' delayed;
function PSPropertyBag_WriteGUID; external propsyslib name 'PSPropertyBag_WriteGUID' delayed;
function PSPropertyBag_ReadPropertyKey; external propsyslib name 'PSPropertyBag_ReadPropertyKey' delayed;
function PSPropertyBag_WritePropertyKey; external propsyslib name 'PSPropertyBag_WritePropertyKey' delayed;

end.
