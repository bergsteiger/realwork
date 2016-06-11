{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC db parameters and macros            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Stan.Param;

interface

uses
  System.Classes, Data.DB, System.Variants, Data.FmtBcd, Data.SqlTimSt,
  FireDAC.Stan.Intf, FireDAC.Stan.SQLTimeInt, FireDAC.Stan.Util;

type
  TFDMacro = class;
  TFDMacros = class;
  TFDParam = class;
  TFDParams = class;

  TFDGetOwner = function: TPersistent of object;

  TFDMacroDataType = (mdUnknown, mdString, mdIdentifier, mdInteger,
    mdBoolean, mdFloat, mdDate, mdTime, mdDateTime, mdRaw);

  TFDMacro = class(TCollectionItem)
  private
    FName: String;
    FValue: Variant;
    FDataType: TFDMacroDataType;
    procedure SetValue(const AValue: Variant);
    function GetAsDateTime: TDateTime;
    function GetAsInteger: Integer;
    function GetAsString: String;
    function GetSQL: String;
    procedure SetAsDateTime(const AValue: TDateTime);
    procedure SetAsInteger(const AValue: Integer);
    procedure SetAsString(const AValue: String);
    function GetIsNull: Boolean;
    function GetAsFloat: Double;
    procedure SetAsFloat(const AValue: Double);
    function GetAsDate: TDateTime;
    procedure SetAsDate(const AValue: TDateTime);
    procedure SetDataType(const AValue: TFDMacroDataType);
    procedure SetData(const AValue: Variant; AType: TFDMacroDataType);
    procedure Changed;
    procedure SetAsIdentifier(const AValue: String);
    function GetAsTime: TDateTime;
    procedure SetAsTime(const AValue: TDateTime);
    function GetAsRaw: String;
    procedure SetAsRaw(const AValue: String);
  protected
    function GetDisplayName: String; override;
    function GetCollectionOwner: TPersistent;
  public
    constructor Create(Collection: TCollection); override;
    procedure Clear;
    procedure Assign(AValue: TPersistent); override;
    function IsEqual(AValue: TFDMacro): Boolean;
    property CollectionOwner: TPersistent read GetCollectionOwner;
    property AsString: String read GetAsString write SetAsString;
    property AsIdentifier: String read GetAsString write SetAsIdentifier;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsDate: TDateTime read GetAsDate write SetAsDate;
    property AsTime: TDateTime read GetAsTime write SetAsTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsRaw: String read GetAsRaw write SetAsRaw;
    property IsNull: Boolean read GetIsNull;
    property SQL: String read GetSQL;
  published
    property Value: Variant read FValue write SetValue;
    property Name: String read FName write FName;
    property DataType: TFDMacroDataType read FDataType write SetDataType default mdRaw;
  end;

  TFDMacros = class(TCollection)
  private
    FGetOwner: TFDGetOwner;
    FOnChanged: TNotifyEvent;
    FRefs: TFDRefCounter;
    FTempLockUpdate: Boolean;
    function GetDataSet: TDataSet;
    function GetItem(AIndex: Integer): TFDMacro; inline;
    procedure SetItem(AIndex: Integer; AValue: TFDMacro);
    procedure DoChanged;
    function GetIsRefCounted: Boolean;
  protected
    function GetOwner: TPersistent; override;
    procedure AssignTo(ADest: TPersistent); override;
  public
    constructor Create; overload;
    constructor CreateRefCounted(AGetOwner: TFDGetOwner);
    destructor Destroy; override;
    procedure AddRef;
    procedure RemRef;
    procedure Assign(AValue: TPersistent); override;
    procedure EndUpdate; override;
    procedure TempLockUpdate;
    procedure AssignValues(AValue: TFDMacros);
    function Add: TFDMacro;
    function IsEqual(AValue: TFDMacros): Boolean;
    function MacroByName(const AValue: String): TFDMacro;
    function FindMacro(const AValue: String): TFDMacro;
    property IsRefCounted: Boolean read GetIsRefCounted;
    property Command: TDataSet read GetDataSet;
    property Items[AIndex: Integer]: TFDMacro read GetItem write SetItem; default;
    property UpdateCount;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnGetOwner: TFDGetOwner read FGetOwner write FGetOwner;
  end;

  TFDParamArrayType = (atScalar, atArray, atTable);
  TFDParamBindMode = (pbByName, pbByNumber);

  TFDParam = class(TCollectionItem)
  private
    FName: String;
    FDataType: TFieldType;
    FFDDataType: TFDDataType;
    FParamType: TParamType;
    FSize: Integer;
    FPrecision: Integer;
    FNumericScale: Integer;
    FBound: Boolean;
    FPosition: Integer;
    FIsCaseSensitive: Boolean;
    FArrayType: TFDParamArrayType;
    FValue: TFDVariantArray;
    FDataTypeName: String;
    FStreamMode: TFDStreamMode;
    procedure InternalSetScalarValue(AIndex: Integer; const AValue: Variant);
    procedure InternalSetTableValue(const AValue: Variant);
    function GetDataSet: TDataSet;
    function IsParamStored: Boolean;
    function GetAsBCDs(AIndex: Integer): Currency;
    function GetAsBooleans(AIndex: Integer): Boolean;
    function GetAsByteStrs(AIndex: Integer): TFDByteString;
    function GetAsCurrencys(AIndex: Integer): Currency;
    function GetAsDateTimes(AIndex: Integer): TDateTime;
    function GetAsFloats(AIndex: Integer): Double;
    function GetAsFMTBCDs(AIndex: Integer): TBcd;
    function GetAsIntegers(AIndex: Integer): Integer;
    function GetAsSQLTimeStamps(AIndex: Integer): TSQLTimeStamp;
    function GetAsStrings(AIndex: Integer): String;
    function GetAsVariants(AIndex: Integer): Variant;
    function GetIsNulls(AIndex: Integer): Boolean;
    function GetAsWideStrings(AIndex: Integer): UnicodeString;
    procedure SetAsBCDs(AIndex: Integer; const AValue: Currency);
    procedure SetAsBlobs(AIndex: Integer; const AValue: TFDByteString);
    procedure SetAsBooleans(AIndex: Integer; const AValue: Boolean);
    procedure SetAsByteStrs(AIndex: Integer; const AValue: TFDByteString);
    procedure SetAsVarByteStrs(AIndex: Integer; const AValue: TFDByteString);
    procedure SetAsCurrencys(AIndex: Integer; const AValue: Currency);
    procedure SetAsDates(AIndex: Integer; const AValue: TDateTime);
    procedure SetAsDateTimes(AIndex: Integer; const AValue: TDateTime);
    procedure SetAsFloats(AIndex: Integer; const AValue: Double);
    procedure SetAsFMTBCDs(AIndex: Integer; const AValue: TBcd);
    procedure SetAsIntegers(AIndex: Integer; const AValue: Integer);
    procedure SetAsMemos(AIndex: Integer; const AValue: TFDAnsiString);
    procedure SetAsSmallInts(AIndex: Integer; const AValue: SmallInt);
    procedure SetAsSQLTimeStamps(AIndex: Integer; const AValue: TSQLTimeStamp);
    procedure SetAsStrings(AIndex: Integer; const AValue: String);
    procedure SetAsTimes(AIndex: Integer; const AValue: TDateTime);
    procedure SetAsVariants(AIndex: Integer; const AValue: Variant);
    procedure SetAsWords(AIndex: Integer; AValue: Word);
    procedure SetBytesValue(AIndex: Integer; ABuff: PByte; ASize: LongWord);
    procedure GetBytesValue(AIndex: Integer; ABuff: PByte);
    procedure SetTexts(AIndex: Integer; const AValue: String); inline;
    procedure SetAsWideStrings(AIndex: Integer; const AValue: UnicodeString);
    procedure ErrIndex(AIndex: Integer);
    procedure CheckIndex(var AIndex: Integer);
    function GetArraySize: Integer;
    procedure SetArraySize(AValue: Integer);
    procedure SetArrayType(AValue: TFDParamArrayType);
    function GetIsUnicode: Boolean;
    procedure UpdateData(ADim: Integer);
    function GetAsLargeInt: LargeInt; inline;
    function GetAsLargeInts(AIndex: Integer): LargeInt;
    procedure SetAsLargeInt(const AValue: LargeInt); inline;
    procedure SetAsLargeInts(AIndex: Integer; const AValue: LargeInt);
    procedure GetVarData(out AVar: PVariant; AIndex: Integer = -1);
    procedure ErrBadFieldType;
    procedure ErrUnknownFieldType;
    procedure ErrFieldOutOfRange;
    function GetAsGUID: TGUID; inline;
    function GetAsGUIDs(AIndex: Integer): TGUID;
    procedure SetAsGUID(const AValue: TGUID); inline;
    procedure SetAsGUIDs(AIndex: Integer; const AValue: TGUID);
    procedure SetAsWideMemo(const AValue: UnicodeString); inline;
    procedure SetAsWideMemos(AIndex: Integer; const AValue: UnicodeString);
    procedure SetAsFixedChar(const AValue: String); inline;
    procedure SetAsFixedChars(AIndex: Integer; const AValue: String);
    function GetAsAnsiString: TFDAnsiString; inline;
    function GetAsAnsiStrings(AIndex: Integer): TFDAnsiString;
    function GetAsExtended: Extended; inline;
    function GetAsExtendeds(AIndex: Integer): Extended;
    function GetAsLongWord: LongWord; inline;
    function GetAsLongWords(AIndex: Integer): LongWord;
    procedure SetAsAnsiString(const AValue: TFDAnsiString); inline;
    procedure SetAsAnsiStrings(AIndex: Integer; const AValue: TFDAnsiString);
    procedure SetAsByte(const AValue: Byte); inline;
    procedure SetAsBytes(AIndex: Integer; const AValue: Byte);
    procedure SetAsExtended(const AValue: Extended); inline;
    procedure SetAsExtendeds(AIndex: Integer; const AValue: Extended);
    procedure SetAsLongWord(const AValue: LongWord); inline;
    procedure SetAsLongWords(AIndex: Integer; const AValue: LongWord);
    procedure SetAsShortInt(const AValue: ShortInt); inline;
    procedure SetAsShortInts(AIndex: Integer; const AValue: ShortInt);
    function GetAsFMTBCD: TBcd; inline;
    function GetAsBCD: Currency; inline;
    function GetAsBoolean: Boolean; inline;
    function GetAsByteStr: TFDByteString; inline;
    function GetAsDateTime: TDateTime; inline;
    function GetAsSQLTimeStamp: TSQLTimeStamp; inline;
    function GetAsCurrency: Currency; inline;
    function GetAsFloat: Double; inline;
    function GetAsInteger: Integer; inline;
    function GetAsString: String; inline;
    function GetAsWideString: UnicodeString; inline;
    function GetAsVariant: Variant; inline;
    function GetIsNull: Boolean; inline;
    procedure SetAsBCD(const AValue: Currency); inline;
    procedure SetAsFMTBCD(const AValue: TBcd); inline;
    procedure SetAsBlob(const AValue: TFDByteString); inline;
    procedure SetAsByteStr(const AValue: TFDByteString); inline;
    procedure SetAsVarByteStr(const AValue: TFDByteString); inline;
    procedure SetAsBoolean(const AValue: Boolean); inline;
    procedure SetAsCurrency(const AValue: Currency); inline;
    procedure SetAsDate(const AValue: TDateTime); inline;
    procedure SetAsDateTime(const AValue: TDateTime); inline;
    procedure SetAsSQLTimeStamp(const AValue: TSQLTimeStamp); inline;
    procedure SetAsFloat(const AValue: Double); inline;
    procedure SetAsInteger(const AValue: Integer); inline;
    procedure SetAsMemo(const AValue: TFDAnsiString); inline;
    procedure SetAsString(const AValue: String); inline;
    procedure SetAsWideString(const AValue: UnicodeString); inline;
    procedure SetAsSmallInt(const AValue: SmallInt); inline;
    procedure SetAsTime(const AValue: TDateTime); inline;
    procedure SetAsVariant(const AValue: Variant); inline;
    procedure SetAsWord(const AValue: Word); inline;
    procedure SetDataType(AValue: TFieldType);
    procedure SetText(const AValue: String); inline;
    function GetAsSQLTimeInterval: TFDSQLTimeInterval; inline;
    function GetAsSQLTimeIntervals(AIndex: Integer): TFDSQLTimeInterval;
    procedure SetAsSQLTimeInterval(const AValue: TFDSQLTimeInterval); inline;
    procedure SetAsSQLTimeIntervals(AIndex: Integer; const AValue: TFDSQLTimeInterval);
    procedure SetAsXML(const AValue: UnicodeString); inline;
    procedure SetAsXMLs(AIndex: Integer; const AValue: UnicodeString);
    function GetAsSingle: Single; inline;
    function GetAsSingles(AIndex: Integer): Single;
    procedure SetAsSingle(const AValue: Single); inline;
    procedure SetAsSingles(AIndex: Integer; const AValue: Single);
    function GetSQLName: String;
    procedure BeginSetBlobRawData(var AIndex: Integer);
    function EndSetBlobRawData(ALen: LongWord; APtr: PByte; AIndex: Integer): PByte;
    procedure ReadADDataType(Reader: TReader);
    function GetParamObjectBase(const AData: TVarData): IParamObject;
    function GetParamObject(AIndex: Integer): IParamObject;
    function HasParamObjectBase(const AData: TVarData; const AObjectType: TClass): Boolean;
    function HasParamObject(const AObjectType: TClass; AIndex: Integer): Boolean;
    function GetAsDataSet: TDataSet;
    function GetAsDataSets(AIndex: Integer): TDataSet;
    procedure SetAsDataSet(const AValue: TDataSet);
    procedure SetAsDataSets(AIndex: Integer; const AValue: TDataSet);
    function GetAsStream: TStream;
    function GetAsStreams(AIndex: Integer): TStream;
    procedure SetAsStream(const AValue: TStream);
    procedure SetAsStreams(AIndex: Integer; const AValue: TStream);
    function GetIsDataSet: Boolean; inline;
    function GetIsDatasets(AIndex: Integer): Boolean;
    function GetIsStream: Boolean; inline;
    function GetIsStreams(AIndex: Integer): Boolean;
    function GetIsObject: Boolean; inline;
    function GetIsObjects(AIndex: Integer): Boolean;
    function GetAsByte: Byte; inline;
    function GetAsBytes(AIndex: Integer): Byte;
    function GetAsShortInt: ShortInt; inline;
    function GetAsShortInts(AIndex: Integer): ShortInt;
    function GetAsSmallInt: SmallInt; inline;
    function GetAsSmallInts(AIndex: Integer): SmallInt;
    function GetAsWord: Word; inline;
    function GetAsWords(AIndex: Integer): Word;
  protected
    procedure AssignParam(AParam: TFDParam);
    procedure AssignDlpParam(AParam: TParam);
    procedure AssignToDlpParam(AParam: TParam);
    procedure AssignTo(ADest: TPersistent); override;
    procedure DefineProperties(AFiler: TFiler); override;
    function IsEqual(AValue: TFDParam): Boolean;
    function GetDisplayName: String; override;
    property DataSet: TDataSet read GetDataSet;
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(AParams: TFDParams; AParamType: TParamType); reintroduce; overload;

    // value manipulations
    procedure Assign(ASource: TPersistent); override;
    procedure AssignField(AField: TField);
    procedure AssignFieldValue(AField: TField; const AValue: Variant); overload;
    procedure AssignFieldValue(AField: TField); overload;
    procedure Clear(AIndex: Integer = -1);
    procedure AssignVarRec(const AVarRec: TVarRec; AIndex: Integer = -1);

    // raw data methods
    function GetBlobRawData(var ALen: LongWord; var APtr: PByte; AIndex: Integer = -1): Boolean;
    function SetBlobRawData(ALen: LongWord; APtr: PByte; AIndex: Integer = -1): PByte;
    procedure GetData(ABuffer: PByte; AIndex: Integer = -1);
    procedure SetData(ABuffer: PByte; ALen: LongWord = $FFFFFFFF; AIndex: Integer = -1);
    function GetDataLength(AIndex: Integer = -1): Integer;
    function GetDataSize(AIndex: Integer = -1): Integer;
    procedure LoadFromFile(const AFileName: String; ABlobType: TFieldType; AIndex: Integer = -1);
    procedure LoadFromStream(AStream: TStream; ABlobType: TFieldType; AIndex: Integer = -1);
    procedure GetDataReader(ABuffer: PByte; AIndex: Integer = -1);

    // object data methods
    function SetObjectValue(const AInstance: TObject; const ADataType: TFieldType;
      AOwner: Boolean = True; AIndex: Integer = -1): IParamObject;
    procedure SetDataSet(ADataset: TDataSet; AOwner: Boolean = True;
      AIndex: Integer = -1);
    procedure SetStream(AStream: TStream; ABlobType: TFieldType;
      AOwner: Boolean = True; AIndex: Integer = -1);

    // value properties
    property AsSingle: Single read GetAsSingle write SetAsSingle;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsExtended: Extended read GetAsExtended write SetAsExtended;
    property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
    property AsBCD: Currency read GetAsBCD write SetAsBCD;
    property AsFMTBCD: TBcd read GetAsFMTBCD write SetAsFMTBCD;

    property AsShortInt: ShortInt read GetAsShortInt write SetAsShortInt;
    property AsByte: Byte read GetAsByte write SetAsByte;
    property AsSmallInt: SmallInt read GetAsSmallInt write SetAsSmallInt;
    property AsWord: Word read GetAsWord write SetAsWord;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsLongword: LongWord read GetAsLongWord write SetAsLongWord;
    property AsLargeInt: LargeInt read GetAsLargeInt write SetAsLargeInt;

    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;

    property AsByteStr: TFDByteString read GetAsByteStr write SetAsByteStr;
    property AsVarByteStr: TFDByteString read GetAsByteStr write SetAsVarByteStr;
    property AsString: String read GetAsString write SetAsString;
    property AsFixedChar: String read GetAsString write SetAsFixedChar;
    property AsWideString: UnicodeString read GetAsWideString write SetAsWideString;
    property AsAnsiString: TFDAnsiString read GetAsAnsiString write SetAsAnsiString;

    property AsBlob: TFDByteString read GetAsByteStr write SetAsBlob;
    property AsMemo: TFDAnsiString read GetAsAnsiString write SetAsMemo;
    property AsWideMemo: UnicodeString read GetAsWideString write SetAsWideMemo;
    property AsXML: UnicodeString read GetAsWideString write SetAsXML;

    property AsDate: TDateTime read GetAsDateTime write SetAsDate;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsSQLTimeStamp: TSQLTimeStamp read GetAsSQLTimeStamp write SetAsSQLTimeStamp;
    property AsTime: TDateTime read GetAsDateTime write SetAsTime;
    property AsSQLTimeInterval: TFDSQLTimeInterval read GetAsSQLTimeInterval write SetAsSQLTimeInterval;

    property AsGUID: TGUID read GetAsGUID write SetAsGUID;

    property AsDataSet: TDataSet read GetAsDataSet write SetAsDataSet;
    property AsStream: TStream read GetAsStream write SetAsStream;

    // array value properties
    property AsSingles[AIndex: Integer]: Single read GetAsSingles write SetAsSingles;
    property AsFloats[AIndex: Integer]: Double read GetAsFloats write SetAsFloats;
    property AsExtendeds[AIndex: Integer]: Extended read GetAsExtendeds write SetAsExtendeds;
    property AsCurrencys[AIndex: Integer]: Currency read GetAsCurrencys write SetAsCurrencys;
    property AsBCDs[AIndex: Integer]: Currency read GetAsBCDs write SetAsBCDs;
    property AsFMTBCDs[AIndex: Integer]: TBcd read GetAsFMTBCDs write SetAsFMTBCDs;

    property AsShortInts[AIndex: Integer]: ShortInt read GetAsShortInts write SetAsShortInts;
    property AsBytes[AIndex: Integer]: Byte read GetAsBytes write SetAsBytes;
    property AsSmallInts[AIndex: Integer]: SmallInt read GetAsSmallInts write SetAsSmallInts;
    property AsWords[AIndex: Integer]: Word read GetAsWords write SetAsWords;
    property AsIntegers[AIndex: Integer]: Integer read GetAsIntegers write SetAsIntegers;
    property AsLongwords[AIndex: Integer]: LongWord read GetAsLongWords write SetAsLongWords;
    property AsLargeInts[AIndex: Integer]: LargeInt read GetAsLargeInts write SetAsLargeInts;

    property AsBooleans[AIndex: Integer]: Boolean read GetAsBooleans write SetAsBooleans;

    property AsByteStrs[AIndex: Integer]: TFDByteString read GetAsByteStrs write SetAsByteStrs;
    property AsVarByteStrs[AIndex: Integer]: TFDByteString read GetAsByteStrs write SetAsVarByteStrs;
    property AsStrings[AIndex: Integer]: String read GetAsStrings write SetAsStrings;
    property AsFixedChars[AIndex: Integer]: String read GetAsStrings write SetAsFixedChars;
    property AsWideStrings[AIndex: Integer]: UnicodeString read GetAsWideStrings write SetAsWideStrings;
    property AsAnsiStrings[AIndex: Integer]: TFDAnsiString read GetAsAnsiStrings write SetAsAnsiStrings;

    property AsBlobs[AIndex: Integer]: TFDByteString read GetAsByteStrs write SetAsBlobs;
    property AsMemos[AIndex: Integer]: TFDAnsiString read GetAsAnsiStrings write SetAsMemos;
    property AsWideMemos[AIndex: Integer]: UnicodeString read GetAsWideStrings write SetAsWideMemos;
    property AsXMLs[AIndex: Integer]: UnicodeString read GetAsWideStrings write SetAsXMLs;

    property AsDates[AIndex: Integer]: TDateTime read GetAsDateTimes write SetAsDates;
    property AsDateTimes[AIndex: Integer]: TDateTime read GetAsDateTimes write SetAsDateTimes;
    property AsSQLTimeStamps[AIndex: Integer]: TSQLTimeStamp read GetAsSQLTimeStamps write SetAsSQLTimeStamps;
    property AsTimes[AIndex: Integer]: TDateTime read GetAsDateTimes write SetAsTimes;
    property AsSQLTimeIntervals[AIndex: Integer]: TFDSQLTimeInterval read GetAsSQLTimeIntervals write SetAsSQLTimeIntervals;

    property AsGUIDs[AIndex: Integer]: TGUID read GetAsGUIDs write SetAsGUIDs;

    property AsDataSets[AIndex: Integer]: TDataSet read GetAsDataSets write SetAsDataSets;
    property AsStreams[AIndex: Integer]: TStream read GetAsStreams write SetAsStreams;

    property Values[AIndex: Integer]: Variant read GetAsVariants write SetAsVariants;
    property IsNulls[AIndex: Integer]: Boolean read GetIsNulls;
    property IsObjects[AIndex: Integer]: Boolean read GetIsObjects;
    property IsStreams[AIndex: Integer]: Boolean read GetIsStreams;
    property IsDatasets[AIndex: Integer]: Boolean read GetIsDatasets;

    // attributes
    property SQLName: String read GetSQLName;
    property Bound: Boolean read FBound write FBound;
    property IsNull: Boolean read GetIsNull;
    property IsObject: Boolean read GetIsObject;
    property IsStream: Boolean read GetIsStream;
    property IsDataSet: Boolean read GetIsDataSet;
    property IsUnicode: Boolean read GetIsUnicode;
    property Text: String read GetAsString write SetText;
    property Texts[AIndex: Integer]: String read GetAsStrings write SetTexts;

  published
    property Position: Integer read FPosition write FPosition default 0;
    property Name: String read FName write FName;
    property IsCaseSensitive: Boolean read FIsCaseSensitive write FIsCaseSensitive default False;
    property ArrayType: TFDParamArrayType read FArrayType write SetArrayType default atScalar;
    property ArraySize: Integer read GetArraySize write SetArraySize default 1;
    property DataType: TFieldType read FDataType write SetDataType default ftUnknown;
    property FDDataType: TFDDataType read FFDDataType write FFDDataType default dtUnknown;
    property Precision: Integer read FPrecision write FPrecision default 0;
    property NumericScale: Integer read FNumericScale write FNumericScale default 0;
    property ParamType: TParamType read FParamType write FParamType default ptUnknown;
    property DataTypeName: String read FDataTypeName write FDataTypeName;
    property Size: Integer read FSize write FSize default 0;
    property StreamMode: TFDStreamMode read FStreamMode write FStreamMode default smOpenRead;
    property Value: Variant read GetAsVariant write SetAsVariant stored IsParamStored;
  end;

  TFDParams = class(TCollection)
  private
    FGetOwner: TFDGetOwner;
    FBindMode: TFDParamBindMode;
    FRefs: TFDRefCounter;
    FMarkers: TStrings;
    FHasObjects: Boolean;
    function GetItem(Index: Integer): TFDParam; inline;
    procedure SetItem(Index: Integer; const AValue: TFDParam);
    function GetArraySize: Integer;
    procedure SetArraySize(const AValue: Integer);
    function GetParamValues(const AParamNames: String): Variant;
    procedure SetParamValues(const AParamNames: UnicodeString; const AValue: Variant);
    function GetIsRefCounted: Boolean;
    procedure ReadBinaryData(Stream: TStream);
    procedure SetMarkers(const AValue: TStrings);
  protected
    function GetDataSet: TDataSet;
    function GetOwner: TPersistent; override;
    procedure DefineProperties(AFiler: TFiler); override;
    property DataSet: TDataSet read GetDataSet;
  public
    // used only by FireDAC.Phys
    procedure Prepare(ADefaultDataType: TFieldType;
      ADefaultParamType: TParamType);
    procedure Close;
    procedure Unprepare;
  public
    constructor Create; overload;
    constructor CreateRefCounted(AGetOwner: TFDGetOwner); overload;
    destructor Destroy; override;
    procedure AddRef;
    procedure RemRef;
    procedure AssignValues(AValue: TFDParams;
      AParamTypes: TParamTypes = [ptUnknown .. ptResult]);
    procedure Assign(AValue: TPersistent); override;
    function Add: TFDParam; overload;
    function Add(const AName: String; const AValue: Variant;
      AParamType: TParamType = ptUnknown): TFDParam; overload;
    function Add(const AName: String; AType: TFieldType; ASize: Integer = -1;
      AParamType: TParamType = ptUnknown): TFDParam; overload;
    function CreateParam(AFldType: TFieldType; const AParamName: String;
      AParamType: TParamType): TFDParam;
    procedure GetParamList(AList: TFDObjList; const AParamNames: String);
    function IsEqual(AValue: TFDParams): Boolean;
    function ParamByName(const AValue: String): TFDParam;
    function FindParam(const AValue: String): TFDParam; overload;
    function ParamByPosition(const AValue: Integer): TFDParam;
    function FindParam(const AValue: Integer): TFDParam; overload;
    procedure ClearValues(AIndex: Integer = -1);
    property IsRefCounted: Boolean read GetIsRefCounted;
    property Items[Index: Integer]: TFDParam read GetItem write SetItem; default;
    property ParamValues[const AParamNames: String]: Variant read GetParamValues write SetParamValues;
    property ArraySize: Integer read GetArraySize write SetArraySize;
    property BindMode: TFDParamBindMode read FBindMode write FBindMode;
    property Markers: TStrings read FMarkers write SetMarkers;
    property OnGetOwner: TFDGetOwner read FGetOwner write FGetOwner;
  end;

function FDVarType2FieldType(const AValue: Variant): TFDMacroDataType;
function FDVar2SQLTyped(const AValue: Variant; AFieldType: TFDMacroDataType): String;
function FDVar2SQL(const AValue: Variant): String;
procedure FDRegisterParamObjectClass(ADataType: TFieldType; AObjClass: TParamObjectClass);

var
  C_FieldType2VarType: array[TFieldType] of Integer = (
    varError, varString, varSmallint, varInteger, varSmallint,
    varBoolean, varDouble, varCurrency, varCurrency, varDate, varDate, varDate,
    varString, varString, varInteger, varString, varString, varString, varOleStr,
    varError, varError, varString, varError, varString, varOleStr,
    varInt64, varError, varError, varError, varError, varString, varString,
    varVariant, varUnknown, varDispatch, varString, varDate, varCurrency,
    varOleStr, varOleStr, varDate, varString,
    varLongWord, varShortInt, varByte, varDouble, varError, varError, varError,
    varString, varError, varSingle);

const
  C_MacroDataType2VarType: array[TFDMacroDataType] of Integer = (
    varError, varUString, varUString, varInteger, varBoolean, varDouble, varDate,
    varDate, varDate, varUString);

  C_ParamTypeNames: array [TParamType] of string =
    ('ptUnknown', 'ptInput', 'ptOutput', 'ptInputOutput', 'ptResult');

  C_FDDataAttributeNames: array[TFDDataAttribute] of string =
    ('Searchable', 'AllowNull', 'FixedLen', 'BlobData', 'ReadOnly', 'AutoInc',
     'ROWID', 'Default', 'RowVersion', 'Internal', 'Calculated', 'Volatile',
     'Unnamed', 'Virtual', 'Base', 'Expression');

  C_FDDataOptionNames: array[TFDDataOption] of string =
    ('AllowNull', 'Unique', 'ReadOnly', 'InUpdate',
     'InWhere', 'InKey', 'AfterInsChanged', 'AfterUpdChanged');

  C_FDParamArrayTypeNames: array[TFDParamArrayType] of string =
    ('atScalar', 'atArray', 'atTable');

  C_MacroTypeNames: array [TFDMacroDataType] of string =
    ('mdUnknown', 'mdString', 'mdIdentifier', 'mdInteger',
     'mdBoolean', 'mdFloat', 'mdDate', 'mdTime', 'mdDateTime', 'mdRaw');

implementation

uses
  System.VarUtils, System.SysUtils, System.Math, Data.DBConsts,
  FireDAC.Stan.Error, FireDAC.Stan.Consts,
  FireDAC.Phys.Intf;

{ ---------------------------------------------------------------------------- }
const
  C_StreamedTypes = [
    ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftDBaseOle,
      ftTypedBinary, ftOraBlob, ftOraClob, ftWideMemo, ftStream,
    ftString, ftFixedChar,
    ftWideString, ftFixedWideChar,
    ftBytes, ftVarBytes];
type
  TFDParamObjectRec = record
    FDataTypes: TFieldTypes;
    FObjClass: TParamObjectClass;
  end;
var
  GParamObjectClasses: array[0 .. 1] of TFDParamObjectRec = (
    (FDataTypes: [ftDataSet]; FObjClass: TParamObject),
    (FDataTypes: C_StreamedTypes; FObjClass: TParamStreamObject)
  );

procedure FDRegisterParamObjectClass(ADataType: TFieldType; AObjClass: TParamObjectClass);
var
  i: Integer;
begin
  for i := 0 to High(GParamObjectClasses) do
    if ADataType in GParamObjectClasses[i].FDataTypes then
      GParamObjectClasses[i].FObjClass := AObjClass;
end;

{ ---------------------------------------------------------------------------- }
function FDVarType2FieldType(const AValue: Variant): TFDMacroDataType;
begin
  case VarType(AValue) of
  varEmpty,
  varNull     : Result := mdUnknown;
  varByte,
  varShortInt,
  varWord,
  varSmallint,
  varLongWord,
  varInteger,
  varUInt64,
  varInt64    : Result := mdInteger;
  varSingle,
  varDouble,
  varCurrency : Result := mdFloat;
  varDate     : Result := mdDateTime;
  varUString,
  varByte or varArray,
  varString,
  varOleStr   : Result := mdString;
  varBoolean  : Result := mdBoolean;
  else
    if VarIsSQLTimeStamp(AValue) then
      Result := mdDateTime
    else
    if VarIsFMTBcd(AValue) then
      Result := mdFloat
    else
      Result := mdUnknown;
  end;
end;

{ ---------------------------------------------------------------------------- }
function FDVar2SQLTyped(const AValue: Variant; AFieldType: TFDMacroDataType): String;
var
  l: Boolean;
  dt: TDateTime;
  rFS: TFormatSettings;
begin
  Result := '';
  if (VarType(AValue) and varTypeMask) in [varEmpty, varNull] then begin
    if not (AFieldType in [mdRaw, mdIdentifier]) then
      Result := 'NULL';
  end
  else begin
    case AFieldType of
    mdRaw:
      Result := AValue;
    mdInteger:
      Result := VarAsType(AValue, varInteger);
    mdFloat:
      Result := '{e ' + FDFloat2Str(VarAsType(AValue, varDouble), '.', 15) + '}';
    mdDate:
      begin
        dt := VarAsType(AValue, varDate);
        rFS.DateSeparator := '-';
        Result := FormatDateTime('yyyy/mm/dd', dt, rFS);
        Result := '{d ''' + Result + '''}';
      end;
    mdTime:
      begin
        dt := VarAsType(AValue, varDate);
        rFS.TimeSeparator := ':';
        Result := FormatDateTime('hh:nn:ss', dt);
        Result := '{t ''' + Result + '''}';
      end;
    mdDateTime:
      begin
        dt := VarAsType(AValue, varDate);
        rFS.DateSeparator := '-';
        rFS.TimeSeparator := ':';
        Result := FormatDateTime('yyyy/mm/dd hh:nn:ss', dt, rFS);
        Result := '{dt ''' + Result + '''}';
      end;
    mdUnknown,
    mdString:
      Result := '{s ''' + VarAsType(AValue, varUString) + '''}';
    mdIdentifier:
      Result := '{id ''' + VarAsType(AValue, varUString) + '''}';
    mdBoolean:
      begin
        l := VarAsType(AValue, varBoolean);
        if l then
          Result := '{l True}'
        else
          Result := '{l False}';
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function FDVar2SQL(const AValue: Variant): String;
begin
  Result := FDVar2SQLTyped(AValue, FDVarType2FieldType(AValue));
end;

{ ---------------------------------------------------------------------------- }
{ TFDMacro                                                                     }
{ ---------------------------------------------------------------------------- }
constructor TFDMacro.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FValue := Null;
  FDataType := mdRaw;
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetSQL: String;
begin
  Result := FDVar2SQLTyped(FValue, DataType);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetDisplayName: String;
begin
  if Name <> '' then
    Result := Name
  else
    Result := inherited GetDisplayName;
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetCollectionOwner: TPersistent;
begin
  if not Assigned(Collection) then
    Result := nil
  else
    Result := TFDMacros(Collection).GetOwner;
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.IsEqual(AValue: TFDMacro): Boolean;
begin
  Result := (Name = AValue.Name) and (DataType = AValue.DataType);
  if Result then
    try
      Result := Value = AValue.Value;
    except
      Result := False;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.Assign(AValue: TPersistent);
begin
  if AValue is TFDMacro then
    try
      if Collection <> nil then
        Collection.BeginUpdate;
      FDataType := TFDMacro(AValue).DataType;
      FName := TFDMacro(AValue).Name;
      FValue := TFDMacro(AValue).Value;
    finally
      if Collection <> nil then
        Collection.EndUpdate;
    end
  else
    inherited Assign(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.Changed;
begin
  TFDMacros(Collection).DoChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetDataType(const AValue: TFDMacroDataType);
begin
  if FDataType <> AValue then begin
    FDataType := AValue;
    Changed;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetData(const AValue: Variant; AType: TFDMacroDataType);
var
  lEQ: Boolean;
begin
  try
    lEQ := Value = AValue;
  except
    lEQ := False;
  end;
  if not lEQ then begin
    FValue := AValue;
    if AType <> mdUnknown then
      FDataType := AType
    else
      if FDataType = mdUnknown then
        FDataType := FDVarType2FieldType(AValue);
    Changed;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetIsNull: Boolean;
var
  pData: PVarData;
begin
  pData := FindVarData(FValue);
  Result := (pData^.VType = varNull) or (pData^.VType = varEmpty);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.Clear;
begin
  SetData(Null, mdUnknown);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetValue(const AValue: Variant);
begin
  SetData(AValue, mdUnknown);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetAsString: String;
begin
  if IsNull then
    Result := ''
  else
    Result := FValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetAsString(const AValue: String);
begin
  SetData(AValue, mdString);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetAsIdentifier(const AValue: String);
begin
  SetData(AValue, mdIdentifier);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetAsInteger: Integer;
begin
  if IsNull then
    Result := 0
  else
    Result := FValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetAsInteger(const AValue: Integer);
begin
  SetData(AValue, mdInteger);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetAsDateTime: TDateTime;
begin
  if IsNull then
    Result := 0.0
  else
    Result := FValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetAsDateTime(const AValue: TDateTime);
begin
  SetData(AValue, mdDateTime);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetAsFloat: Double;
begin
  if IsNull then
    Result := 0.0
  else
    Result := FValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetAsFloat(const AValue: Double);
begin
  SetData(AValue, mdFloat);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetAsDate: TDateTime;
begin
  if IsNull then
    Result := 0.0
  else
    Result := FValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetAsDate(const AValue: TDateTime);
var
  dt: TDateTime;
begin
  dt := Trunc(AValue);
  SetData(dt, mdDate);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetAsTime: TDateTime;
begin
  if IsNull then
    Result := 0.0
  else
    Result := FValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetAsTime(const AValue: TDateTime);
var
  dt: TDateTime;
begin
  dt := AValue - Trunc(AValue);
  SetData(dt, mdTime);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacro.GetAsRaw: String;
begin
  if IsNull then
    Result := ''
  else
    Result := FValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacro.SetAsRaw(const AValue: String);
begin
  SetData(AValue, mdRaw);
end;

{ ---------------------------------------------------------------------------- }
{ TFDMacros                                                                    }
{ ---------------------------------------------------------------------------- }
constructor TFDMacros.Create;
begin
  inherited Create(TFDMacro);
end;

{ ---------------------------------------------------------------------------- }
constructor TFDMacros.CreateRefCounted(AGetOwner: TFDGetOwner);
begin
  FGetOwner := AGetOwner;
  inherited Create(TFDMacro);
  FRefs := TFDRefCounter.Create(Self);
  FRefs.CountRef(1);
end;

{-------------------------------------------------------------------------------}
destructor TFDMacros.Destroy;
begin
  FDFreeAndNil(FRefs);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDMacros.AddRef;
begin
  if FRefs <> nil then
    FRefs.AddRef;
end;

{-------------------------------------------------------------------------------}
procedure TFDMacros.RemRef;
begin
  if FRefs <> nil then
    FRefs.RemRef;
end;

{-------------------------------------------------------------------------------}
function TFDMacros.GetIsRefCounted: Boolean;
begin
  Result := (FRefs <> nil) and (FRefs.Refs >= 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacros.Assign(AValue: TPersistent);
var
  i, j: Integer;
  s: String;
  oMac: TFDMacro;
begin
  if AValue is TStrings then begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to TStrings(AValue).Count - 1 do begin
        oMac := TFDMacro(Add);
        s := TStrings(AValue)[i];
        j := Pos('=', s);
        oMac.Name := Copy(s, 1, j - 1);
        oMac.AsRaw := Copy(s, j + 1, Length(s));
      end;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacros.AssignTo(ADest: TPersistent);
var
  i: Integer;
begin
  if ADest is TStrings then begin
    TStrings(ADest).Clear;
    for i := 0 to Count - 1 do
      TStrings(ADest).Add(Items[i].Name + '=' + Items[i].Value);
  end
  else
    inherited AssignTo(ADest);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacros.AssignValues(AValue: TFDMacros);
var
  i: Integer;
  oMacro: TFDMacro;
begin
  BeginUpdate;
  try
    for i := 0 to AValue.Count - 1 do begin
      oMacro := FindMacro(AValue[i].Name);
      if oMacro <> nil then
        oMacro.Assign(AValue[i]);
    end;
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDMacros.Add: TFDMacro;
begin
  Result := TFDMacro(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacros.IsEqual(AValue: TFDMacros): Boolean;
var
  i: Integer;
begin
  Result := Count = AValue.Count;
  if Result then                                                               
    for i := 0 to Count - 1 do begin
      Result := Items[i].IsEqual(AValue.Items[i]);
      if not Result then
        Break;
    end
end;

{ ---------------------------------------------------------------------------- }
function TFDMacros.FindMacro(const AValue: String): TFDMacro;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do begin
    Result := Items[i];
    if {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
       (Result.Name, AValue) = 0 then
      Exit;
  end;
  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TFDMacros.MacroByName(const AValue: String): TFDMacro;
begin
  Result := FindMacro(AValue);
  if Result = nil then
    FDException(Self, [S_FD_LStan], er_FD_StanMacroNotFound, [AValue]);
end;

{ ---------------------------------------------------------------------------- }
function TFDMacros.GetDataSet: TDataSet;
begin
  if Assigned(FGetOwner) and (FGetOwner() <> nil) and (FGetOwner() is TDataSet) then
    Result := TDataSet(FGetOwner())
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TFDMacros.GetItem(AIndex: Integer): TFDMacro;
begin
  Result := TFDMacro(inherited Items[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacros.SetItem(AIndex: Integer; AValue: TFDMacro);
begin
  inherited Items[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDMacros.GetOwner: TPersistent;
begin
  if Assigned(FGetOwner) then
    Result := FGetOwner()
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacros.DoChanged;
begin
  if UpdateCount = 0 then
    try
      if Assigned(FOnChanged) and not FTempLockUpdate then
        FOnChanged(Self);
    finally
      FTempLockUpdate := False;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacros.EndUpdate;
begin
  inherited EndUpdate;
  DoChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDMacros.TempLockUpdate;
begin
  FTempLockUpdate := True;
end;

{ ---------------------------------------------------------------------------- }
{ TFDParams                                                                    }
{ ---------------------------------------------------------------------------- }
constructor TFDParams.Create;
begin
  inherited Create(TFDParam);
  FMarkers := TFDStringList.Create;
end;

{ ---------------------------------------------------------------------------- }
constructor TFDParams.CreateRefCounted(AGetOwner: TFDGetOwner);
begin
  FGetOwner := AGetOwner;
  inherited Create(TFDParam);
  FRefs := TFDRefCounter.Create(Self);
  FRefs.CountRef(1);
  FMarkers := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDParams.Destroy;
begin
  FDFreeAndNil(FRefs);
  FDFreeAndNil(FMarkers);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDParams.AddRef;
begin
  if FRefs <> nil then
    FRefs.AddRef;
end;

{-------------------------------------------------------------------------------}
procedure TFDParams.RemRef;
begin
  if FRefs <> nil then
    FRefs.RemRef;
end;

{-------------------------------------------------------------------------------}
function TFDParams.GetIsRefCounted: Boolean;
begin
  Result := (FRefs <> nil) and (FRefs.Refs >= 0);
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.GetDataSet: TDataSet;
begin
  if Assigned(FGetOwner) and (FGetOwner() <> nil) and (FGetOwner() is TDataSet) then
    Result := TDataSet(FGetOwner())
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.GetOwner: TPersistent;
begin
  if Assigned(FGetOwner) then
    Result := FGetOwner()
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.SetMarkers(const AValue: TStrings);
begin
  FMarkers.SetStrings(AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.Add: TFDParam;
begin
  Result := TFDParam(inherited Add);
  if (Count > 1) and (Items[0].ArrayType = atArray) then
    Result.ArraySize := Items[0].ArraySize;
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.Add(const AName: String;
  const AValue: Variant; AParamType: TParamType = ptUnknown): TFDParam;
begin
  Result := Add;
  Result.Name := AName;
  Result.Value := AValue;
  if AParamType <> ptUnknown then
    Result.ParamType := AParamType;
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.Add(const AName: String; AType: TFieldType;
  ASize: Integer = -1; AParamType: TParamType = ptUnknown): TFDParam;
begin
  Result := Add;
  Result.Name := AName;
  Result.DataType := AType;
  if ASize <> -1 then
    Result.Size := ASize;
  if AParamType <> ptUnknown then
    Result.ParamType := AParamType;
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.CreateParam(AFldType: TFieldType;
  const AParamName: String; AParamType: TParamType): TFDParam;
begin
  Result := Add(AParamName, AFldType, -1, AParamType);
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.FindParam(const AValue: String): TFDParam;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do begin
    Result := Items[i];
    if {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
       (Result.Name, AValue) = 0 then
      Exit;
  end;
  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.ParamByName(const AValue: String): TFDParam;
begin
  Result := FindParam(AValue);
  if Result = nil then
    DatabaseErrorFmt(SParameterNotFound, [AValue], GetDataSet);
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.FindParam(const AValue: Integer): TFDParam;
var
  i: Integer;
begin
  if (AValue >= 1) and (AValue <= Count) then begin
    Result := Items[AValue - 1];
    if Result.Position = AValue then
      Exit;
  end;
  for i := 0 to Count - 1 do begin
    Result := Items[i];
    if Result.Position = AValue then
      Exit;
  end;
  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.ParamByPosition(const AValue: Integer): TFDParam;
begin
  Result := FindParam(AValue);
  if Result = nil then
    DatabaseErrorFmt(SParameterNotFound, ['#' + IntToStr(AValue)], GetDataSet);
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.GetItem(Index: Integer): TFDParam;
begin
  Result := TFDParam(inherited Items[Index]);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.SetItem(Index: Integer; const AValue: TFDParam);
begin
  inherited Items[Index] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.Assign(AValue: TPersistent);
begin
  if AValue = Self then
    Exit;
  if AValue is TFDParams then begin
    FBindMode := TFDParams(AValue).BindMode;
    FMarkers.SetStrings(TFDParams(AValue).Markers);
    FHasObjects := TFDParams(AValue).FHasObjects;
  end;
  inherited Assign(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.AssignValues(AValue: TFDParams;
  AParamTypes: TParamTypes = [ptUnknown .. ptResult]);
var
  i, j, n: Integer;
  oPar1, oPar2: TFDParam;
begin
  if AValue = Self then
    Exit;
  if BindMode = pbByName then
    for i := AValue.Count - 1 downto 0 do begin
      oPar1 := AValue[i];
      for j := 0 to Count - 1 do begin
        oPar2 := Items[j];
        if ({$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
            (oPar1.Name, oPar2.Name) = 0) and
           (not (Assigned(DataSet) and (csDesigning in DataSet.ComponentState)) or
            (oPar2.DataType = ftUnknown) or (oPar2.DataType = oPar1.DataType)) and
           (oPar2.ParamType in AParamTypes) then
          oPar2.AssignParam(oPar1);
      end;
    end
  else begin
    n := AValue.Count;
    if n > Count then
      n := Count;
    for i := 0 to n - 1 do begin
      oPar2 := Items[i];
      if oPar2.ParamType in AParamTypes then
        oPar2.AssignParam(AValue[i]);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.Prepare(ADefaultDataType: TFieldType;
  ADefaultParamType: TParamType);
var
  i: Integer;
  oPar: TFDParam;
  lNoName, lNoPos: Boolean;
begin
  if Count = 0 then
    Exit;
  lNoName := True;
  lNoPos := True;
  for i := 0 to Count - 1 do begin
    oPar := Items[i];
    if oPar.DataType = ftUnknown then
      oPar.DataType := ADefaultDataType;
    if oPar.ParamType = ptUnknown then
      oPar.ParamType := ADefaultParamType;
    if oPar.Size < 0 then
      oPar.Size := 0;
    lNoName := lNoName and (oPar.Name = '');
    lNoPos := lNoPos and (oPar.Position <= 0);
  end;
  if lNoPos and ((BindMode = pbByNumber) or lNoName) then begin
    BindMode := pbByNumber;
    for i := 0 to Count - 1 do
      Items[i].Position := i + 1;
  end
  else if lNoName and not lNoPos then
    BindMode := pbByNumber;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.Close;
var
  i: Integer;
begin
  if FHasObjects then
    for i := 0 to Count - 1 do
      if Items[i].IsStream then
        Items[i].Clear();
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.Unprepare;
begin
  Markers.Clear;
  Close;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.GetParamList(AList: TFDObjList; const AParamNames: String);
var
  iPos: Integer;
begin
  iPos := 1;
  while iPos <= Length(AParamNames) do
    AList.Add(ParamByName(FDExtractFieldName(AParamNames, iPos)));
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.IsEqual(AValue: TFDParams): Boolean;
var
  i: Integer;
begin
  Result := (Count = AValue.Count);
  if Result then
    for i := 0 to Count - 1 do begin
      Result := Items[i].IsEqual(AValue.Items[i]);
      if not Result then
        Break;
    end
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.GetArraySize: Integer;
begin
  if (Count = 0) or (Items[0].ArrayType <> atArray) then
    Result := 1
  else
    Result := Items[0].ArraySize;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.SetArraySize(const AValue: Integer);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].ArraySize := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParams.GetParamValues(const AParamNames: String): Variant;
var
  i: Integer;
  oParams: TFDObjList;
begin
  if Pos(';', AParamNames) <> 0 then begin
    oParams := TFDObjList.Create;
    try
      GetParamList(oParams, AParamNames);
      Result := VarArrayCreate([0, oParams.Count - 1], varVariant);
      for I := 0 to oParams.Count - 1 do
        Result[I] := TFDParam(oParams[I]).Value;
    finally
      FDFree(oParams);
    end;
  end
  else
    Result := ParamByName(AParamNames).Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.SetParamValues(const AParamNames: String; const AValue: Variant);
var
  i: Integer;
  oParams: TFDObjList;
begin
  if Pos(';', AParamNames) <> 0 then begin
    oParams := TFDObjList.Create;
    try
      GetParamList(oParams, AParamNames);
      for i := 0 to oParams.Count - 1 do
        TFDParam(oParams[I]).Value := AValue[I];
    finally
      FDFree(oParams);
    end;
  end
  else
    ParamByName(AParamNames).Value := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.ClearValues(AIndex: Integer);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].Clear(AIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.DefineProperties(AFiler: TFiler);
begin
  inherited DefineProperties(AFiler);
  AFiler.DefineBinaryProperty('Data', ReadBinaryData, nil, False);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParams.ReadBinaryData(Stream: TStream);
var
  I, Temp, NumItems: Integer;
  Buffer: array[0..2047] of Byte;
  Version: Word;
  Bool: Boolean;
  oParam: TFDParam;
begin
  Clear;
  Stream.ReadBuffer(Version, SizeOf(Version));
  if Version > 2 then
    DatabaseError(SInvalidVersion);
  NumItems := 0;
  if Version = 2 then
    Stream.ReadBuffer(NumItems, SizeOf(NumItems))
  else
    Stream.ReadBuffer(NumItems, 2);
  for I := 0 to NumItems - 1 do begin
    oParam := TFDParam(Add);
    Temp := 0;
    if Version = 2 then
      Stream.ReadBuffer(Temp, SizeOf(Temp))
    else
      Stream.ReadBuffer(Temp, 1);
    Stream.ReadBuffer(Buffer, Temp);
    oParam.Name := TFDEncoder.Deco(@Buffer, Temp, ecANSI);
    Stream.ReadBuffer(oParam.FParamType, SizeOf(oParam.FParamType));
    Stream.ReadBuffer(oParam.FDataType, SizeOf(oParam.FDataType));
    if oParam.DataType <> ftUnknown then
    begin
      Temp := 0;
      if Version = 2 then
        Stream.ReadBuffer(Temp, SizeOf(Temp))
      else
        Stream.ReadBuffer(Temp, 2);
      Stream.ReadBuffer(Buffer, Temp);
      if oParam.DataType in [ftBlob, ftGraphic..ftTypedBinary, ftOraBlob, ftOraClob] then
        oParam.SetBlobRawData(Temp, @Buffer)
      else
        oParam.SetData(@Buffer);
    end;
    Stream.ReadBuffer(Bool, SizeOf(Bool));
    if Bool then
      oParam.FValue[0] := Null;
    Stream.ReadBuffer(oParam.FBound, SizeOf(oParam.FBound));
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TFDParam                                                                     }
{ ---------------------------------------------------------------------------- }
constructor TFDParam.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  UpdateData(TFDParams(Collection).ArraySize);
end;

{ ---------------------------------------------------------------------------- }
constructor TFDParam.Create(AParams: TFDParams; AParamType: TParamType);
begin
  Create(AParams);
  ParamType := AParamType;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.DefineProperties(AFiler: TFiler);
begin
  inherited DefineProperties(AFiler);
  AFiler.DefineProperty('ADDataType', ReadADDataType, nil, False);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.ReadADDataType(Reader: TReader);
var
  sVal: string;
  eType: TFDDataType;
begin
  FFDDataType := dtUnknown;
  sVal := Reader.ReadIdent;
  for eType := Low(TFDDataType) to High(TFDDataType) do
    if CompareText(sVal, 'dt' + C_FD_DataTypeNames[eType]) = 0 then begin
      FFDDataType := eType;
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.IsEqual(AValue: TFDParam): Boolean;

  function CompareValues(const V1, V2: TFDVariantArray): Boolean;
  var
    i: Integer;
  begin
    Result := Length(V1) = Length(V2);
    if Result then
      for i := 0 to Length(V1) - 1 do
        if not FDSameVariants(V1[i], V2[i]) then begin
          Result := False;
          Break;
        end;
  end;

begin
  Result :=
    (Position = AValue.Position) and (IsCaseSensitive = AValue.IsCaseSensitive) and
    (ArrayType = AValue.ArrayType) and (ArraySize = AValue.ArraySize) and
    (DataType = AValue.DataType) and (FDDataType = AValue.FDDataType) and
    (Precision = AValue.Precision) and (NumericScale = AValue.NumericScale) and
    (Name = AValue.Name) and (ParamType = AValue.ParamType) and
    (Size = AValue.Size) and (IsNull = AValue.IsNull) and (Bound = AValue.Bound) and
    (DataTypeName = AValue.DataTypeName) and CompareValues(FValue, AValue.FValue) and
    (StreamMode = AValue.StreamMode);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.IsParamStored: Boolean;
begin
  Result := Bound and (ArrayType = atScalar) and (GetParamObject(0) = nil) and
    not VarIsArray(FValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetSQLName: String;
begin
  Result := Name;
  if (Result = '') and (Collection <> nil) and
     (TFDParams(Collection).BindMode = pbByNumber) then
    if ParamType <> ptResult then
      Result := 'P' + IntToStr(Position)
    else
      Result := 'RESULT';
  if IsCaseSensitive then
    Result := '"' + Result + '"';
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.ErrIndex(AIndex: Integer);
begin
  if AIndex <= 0 then
    AIndex := 0;
  FDException(Self, [S_FD_LStan], er_FD_StanBadParRowIndex,
    [Name, AIndex, Length(FValue) - 1]);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.CheckIndex(var AIndex: Integer);
begin
  if FValue = nil then
    ErrIndex(AIndex)
  else if AIndex <= 0 then
    AIndex := 0
  else if Length(FValue) <= AIndex then
    ErrIndex(AIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.UpdateData(ADim: Integer);
var
  i, iLen: Integer;
begin
  iLen := Length(FValue);
  if iLen <> ADim then begin
    SetLength(FValue, ADim);
    for i := iLen to ADim - 1 do
      FValue[i] := Null;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetArraySize: Integer;
begin
  Result := Length(FValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetArraySize(AValue: Integer);
begin
  if ArraySize <> AValue then begin
    if AValue = 1 then begin
      if FArrayType = atArray then
        FArrayType := atScalar;
    end
    else if AValue >= 0 then begin
      if FArrayType = atScalar then
        FArrayType := atArray;
    end;
    UpdateData(AValue);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetArrayType(AValue: TFDParamArrayType);
begin
  if ArrayType <> AValue then begin
    FArrayType := AValue;
    if (ArrayType = atScalar) and (ArraySize <> 1) then
      ArraySize := 1;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetIsUnicode: Boolean;
begin
  Result := (DataType in [ftWideString, ftFixedWideChar, ftWideMemo, ftFmtMemo, ftDBaseOle]) or
    (DataType = ftOraClob) and (FFDDataType in [dtWideHMemo, dtWideMemo, dtXML]);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetIsNull: Boolean;
begin
  Result := GetIsNulls(0);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetIsNulls(AIndex: Integer): Boolean;
var
  pData: PVarData;
begin
  CheckIndex(AIndex);
  pData := FindVarData(FValue[AIndex]);
  Result := (pData^.VType = varNull) or (pData^.VType = varEmpty);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetIsObject: Boolean;
begin
  Result := GetIsObjects(0)
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetIsObjects(AIndex: Integer): Boolean;
begin
  Result := (DataType in [ftDataSet, ftStream]) or HasParamObject(TObject, AIndex);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetIsDataSet: Boolean;
begin
  Result := GetIsDatasets(0);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetIsDatasets(AIndex: Integer): Boolean;
begin
  Result := (DataType = ftDataSet) and HasParamObject(TDataSet, AIndex);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetIsStream: Boolean;
begin
  Result := GetIsStreams(0);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetIsStreams(AIndex: Integer): Boolean;
begin
  Result := (DataType = ftStream) or HasParamObject(TStream, AIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetDataType(AValue: TFieldType);
var
  vType, i: Integer;
begin
  if FDataType <> AValue then begin
    FDataType := AValue;
    if Assigned(DataSet) and (csDesigning in DataSet.ComponentState) and
       not GetIsNulls(-1) then begin
      vType := C_FieldType2VarType[AValue];
      if vType <> varError then
        try
          for i := 0 to Length(FValue) - 1 do
            VarCast(FValue[i], FValue[i], vType);
        except
          Clear;
        end
      else
        Clear;
    end
    else
      Clear;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.ErrUnknownFieldType;
begin
  DatabaseErrorFmt(SUnknownFieldType, [Name], DataSet);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.ErrBadFieldType;
begin
  DatabaseErrorFmt(SBadFieldType, [Name], DataSet);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.ErrFieldOutOfRange;
begin
  raise EOverFlow.CreateFmt(SFieldOutOfRange, [Name]);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetDataLength(AIndex: Integer): Integer;
var
  pVar: PVariant;

  function GetStrVarLen(out AResult: Integer): Boolean;
  begin
    case VarType(pVar^) of
{$IFNDEF NEXTGEN}
    varString:
      begin
        AResult := Length(AnsiString(TVarData(pVar^).VString));
        Result := True;
      end;
{$ENDIF}
    varOleStr:
      begin
        AResult := StrLen(TVarData(pVar^).VOleStr);
        Result := True;
      end;
    varUString:
      begin
        AResult := Length(UnicodeString(TVarData(pVar^).VUString));
        Result := True;
      end;
    varByte or varArray:
      begin
        AResult := TVarData(pVar^).VArray^.Bounds[0].ElementCount;
        Result := True;
      end;
    else
      Result := False;
    end;
  end;

  procedure GetVarLen(out AResult: Integer);
  var
    s: String;
  begin
    if not VarIsNull(pVar^) then begin
      s := pVar^;
      AResult := Length(s);
    end;
  end;

  procedure GetVar2Len(out AResult: Integer);
  var
    s: String;
  begin
    if not VarIsNull(pVar^) then begin
      s := VarToStr(pVar^);
      AResult := Length(s);
    end;
  end;

  procedure GetVarWideLen(out AResult: Integer);
  var
    ws: UnicodeString;
  begin
    if not VarIsNull(pVar^) then begin
      ws := pVar^;
      Result := Length(ws);
    end;
  end;

begin
  case DataType of
    ftUnknown:
      begin
        Result := 0;
        ErrUnknownFieldType;
      end;
    ftString, ftFixedChar, ftADT:
      begin
        Result := 0;
        GetVarData(pVar, AIndex);
        if not GetStrVarLen(Result) then
          GetVarLen(Result);
      end;
    ftWideString, ftFixedWideChar:
      begin
        Result := 0;
        GetVarData(pVar, AIndex);
        if not GetStrVarLen(Result) then
          GetVarWideLen(Result);
      end;
    ftBoolean:
      Result := SizeOf(WordBool);
    ftFMTBcd,
    ftBCD:
      Result := SizeOf(TBcd);
    ftCurrency:
      Result := SizeOf(Currency);
    ftSingle:
      Result := SizeOf(Single);
    ftFloat:
      Result := SizeOf(Double);
    ftExtended:
      Result := SizeOf(Extended);
    ftTimeStamp, ftOraTimeStamp:
      Result := SizeOf(TSQLTimeStamp);
    ftParadoxOle, ftOraInterval:
      Result := SizeOf(TFDSQLTimeInterval);
    ftDateTime:
      Result := SizeOf(TDateTime);
    ftTime, ftDate:
      Result := SizeOf(Integer);
    ftAutoInc, ftInteger:
      Result := SizeOf(Integer);
    ftLongWord:
      Result := SizeOf(LongWord);
    ftShortint:
      Result := SizeOf(ShortInt);
    ftByte:
      Result := SizeOf(Byte);
    ftSmallint:
      Result := SizeOf(SmallInt);
    ftWord:
      Result := SizeOf(Word);
    ftLargeint:
      Result := SizeOf(Largeint);
    ftBytes, ftVarBytes:
      begin
        Result := 0;
        GetVarData(pVar, AIndex);
        if VarIsArray(pVar^) then
          Result := VarArrayHighBound(pVar^, 1) + 1
        else if not GetStrVarLen(Result) then
          Result := 0;
      end;
    ftBlob, ftGraphic, ftTypedBinary, ftOraBlob:
      begin
        Result := 0;
        GetVarData(pVar, AIndex);
        if VarIsArray(pVar^) then
          Result := VarArrayHighBound(pVar^, 1) + 1
        else if not GetStrVarLen(Result) then
          GetVar2Len(Result);
      end;
    ftMemo, ftFmtMemo, ftDBaseOle, ftOraClob, ftWideMemo:
      begin
        Result := 0;
        GetVarData(pVar, AIndex);
        if not GetStrVarLen(Result) then
          GetVar2Len(Result);
      end;
    ftGUID:
      Result := SizeOf(TGUID);
    ftStream, ftDataSet:
      Result := SizeOf(IUnknown);
    ftArray, ftReference, ftCursor:
      Result := 0; // nothing
  else
    Result := 0;
    ErrBadFieldType;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetDataSize(AIndex: Integer): Integer;
begin
  Result := GetDataLength(AIndex);
  case DataType of
    ftFixedWideChar,
    ftWideString:
      Result := (Result + 1) * SizeOf(WideChar);
    ftWideMemo,
    ftFmtMemo,
    ftDBaseOle:
      Result := Result * SizeOf(WideChar);
    ftFixedChar,
    ftString,
    ftAdt:
      Result := (Result + 1) * SizeOf(TFDAnsiChar);
    ftMemo:
      Result := Result * SizeOf(TFDAnsiChar);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.GetData(ABuffer: PByte; AIndex: Integer);
var
  pVar: PVariant;
  cr: Currency;
  buff: array[0 .. 63] of Char;
  iSize: Integer;

  procedure GetAnsiString(AAddOn: Integer);
  var
    SA: TFDAnsiString;
{$IFDEF NEXTGEN}
    SB: TFDByteString;
{$ENDIF}
  begin
    SA := AsAnsiStrings[AIndex];
{$IFDEF NEXTGEN}
    SB := TFDEncoder.Enco(SA, ecANSI);
    Move(PByte(SB)^, ABuffer^, (Length(SA) + AAddOn) * SizeOf(TFDAnsiChar));
{$ELSE}
    Move(PAnsiChar(SA)^, ABuffer^, (Length(SA) + AAddOn) * SizeOf(AnsiChar));
{$ENDIF}
  end;

  procedure GetWideString(AAddOn: Integer);
  var
    SW: UnicodeString;
  begin
    SW := AsWideStrings[AIndex];
    Move(PWideChar(SW)^, ABuffer^, (Length(SW) + AAddOn) * SizeOf(WideChar));
  end;

  procedure GetByteString;
  var
    SB: TFDByteString;
  begin
    SB := AsByteStrs[AIndex];
    Move(PByte(SB)^, ABuffer^, Length(SB) * SizeOf(Byte));
  end;

begin
  CheckIndex(AIndex);
  case DataType of
    ftUnknown:
      ErrUnknownFieldType;
    ftString, ftFixedChar, ftAdt:
      GetAnsiString(1);
    ftMemo:
      GetAnsiString(0);
    ftWideString, ftFixedWideChar:
      GetWideString(1);
    ftFmtMemo, ftWideMemo, ftDBaseOle:
      GetWideString(0);
    ftShortint:
      PShortInt(ABuffer)^ := AsShortInts[AIndex];
    ftByte:
      PByte(ABuffer)^ := AsBytes[AIndex];
    ftSmallint:
      PSmallInt(ABuffer)^ := AsSmallInts[AIndex];
    ftWord:
      PWord(ABuffer)^ := AsWords[AIndex];
    ftAutoInc, ftInteger:
      PInteger(ABuffer)^ := AsIntegers[AIndex];
    ftLongWord:
      PLongWord(ABuffer)^ := AsLongWords[AIndex];
    ftLargeint:
      PInt64(ABuffer)^ := AsLargeInts[AIndex];
    ftTime:
      PDateTimeRec(ABuffer)^.Time := DateTimeToTimeStamp(AsDateTimes[AIndex]).Time;
    ftDate:
      PDateTimeRec(ABuffer)^.Date := DateTimeToTimeStamp(AsDateTimes[AIndex]).Date;
    ftDateTime:
      if FDDataType = dtDateTimeStamp then
        PSQLTimeStamp(ABuffer)^ := AsSQLTimeStamps[AIndex]
      else
        PDateTimeRec(ABuffer)^.DateTime := FDDateTime2MSecs(AsDateTimes[AIndex]);
    ftTimeStamp, ftOraTimeStamp:
      PSQLTimeStamp(ABuffer)^ := AsSQLTimeStamps[AIndex];
    ftParadoxOle, ftOraInterval:
      PFDSQLTimeInterval(ABuffer)^ := AsSQLTimeIntervals[AIndex];
    ftBCD:
      begin
        GetVarData(pVar, AIndex);
        if VarIsFmtBCD(pVar^) then
          PBcd(ABuffer)^ := VarToBCD(pVar^)
        else
        begin
          cr := pVar^;
          FDCurr2Str(buff, iSize, cr, Char(FormatSettings.DecimalSeparator));
          FDStr2BCD(buff, iSize, PBcd(ABuffer)^, Char(FormatSettings.DecimalSeparator));
        end;
      end;
    ftFMTBCD:
      PBcd(ABuffer)^ := AsFMTBCDs[AIndex];
    ftSingle:
      PSingle(ABuffer)^ := AsSingles[AIndex];
    ftFloat:
      PDouble(ABuffer)^ := AsFloats[AIndex];
    ftExtended:
      PExtended(ABuffer)^ := AsExtendeds[AIndex];
    ftCurrency:
      PCurrency(ABuffer)^ := AsCurrencys[AIndex];
    ftBoolean:
      PWord(ABuffer)^ := Ord(AsBooleans[AIndex]);
    ftBytes, ftVarBytes:
      GetBytesValue(AIndex, ABuffer);
    ftBlob, ftGraphic, ftTypedBinary, ftOraBlob, ftOraClob:
      GetByteString;
    ftGUID:
      PGUID(ABuffer)^ := AsGUIDs[AIndex];
    ftDataSet, ftStream, ftArray, ftReference, ftCursor:
      ; // nothing
  else
    ErrBadFieldType;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetData(ABuffer: PByte; ALen: LongWord; AIndex: Integer);
var
  crValue: Currency;
  TimeStamp: TTimeStamp;
{$IFNDEF NEXTGEN}
  SA: AnsiString;
{$ENDIF}
  SW: UnicodeString;
begin
  if DataType = ftUnknown then
    ErrUnknownFieldType
  else if ABuffer = nil then
    Clear(AIndex)
  else
    case DataType of
{$IFDEF NEXTGEN}
      ftMemo, ftOraClob,
{$ENDIF}
      ftString, ftFixedChar, ftADT:
        begin
          if ALen = $FFFFFFFF then
            if (DataType = ftFixedChar) and (Size > 0) then
              ALen := Size
            else
              ALen := FDAnsiStrLen(PFDAnsiString(ABuffer));
{$IFDEF NEXTGEN}
          Values[AIndex] := TFDEncoder.Deco(ABuffer, ALen, ecANSI);
{$ELSE}
          SetString(SA, PAnsiChar(ABuffer), ALen);
          Values[AIndex] := SA;
{$ENDIF}
        end;
      ftWideString, ftFmtMemo, ftWideMemo, ftFixedWideChar, ftDBaseOle:
        begin
          if ALen = $FFFFFFFF then
            if (DataType = ftFixedWideChar) and (Size > 0) then
              ALen := Size
            else
              ALen := StrLen(PWideChar(ABuffer));
          SetString(SW, PWideChar(ABuffer), ALen);
          Values[AIndex] := SW;
        end;
      ftShortint:
        AsShortInts[AIndex] := PShortInt(ABuffer)^;
      ftByte:
        AsBytes[AIndex] := PByte(ABuffer)^;
      ftSmallint:
        if FDDataType = dtSByte then
          AsSmallInts[AIndex] := PShortint(ABuffer)^
        else if FDDataType = dtByte then
          AsSmallInts[AIndex] := PByte(ABuffer)^
        else
          AsSmallInts[AIndex] := PSmallint(ABuffer)^;
      ftWord:
        if FDDataType = dtByte then
          AsWords[AIndex] := PByte(ABuffer)^
        else
          AsWords[AIndex] := PWord(ABuffer)^;
      ftInteger, ftAutoInc:
        AsIntegers[AIndex] := PInteger(ABuffer)^;
      ftLongWord:
        AsLongWords[AIndex] := PLongWord(ABuffer)^;
      ftLargeint:
        AsLargeInts[AIndex] := PInt64(ABuffer)^;
      ftTime:
        begin
          TimeStamp.Time := PInteger(ABuffer)^;
          TimeStamp.Date := DateDelta;
          AsTimes[AIndex] := TimeStampToDateTime(TimeStamp);
        end;
      ftDate:
        begin
          TimeStamp.Time := 0;
          TimeStamp.Date := PInteger(ABuffer)^;
          AsDates[AIndex] := TimeStampToDateTime(TimeStamp);
        end;
      ftDateTime:
        if FDDataType = dtDateTimeStamp then
          AsSQLTimeStamps[AIndex] := PSQLTimeStamp(ABuffer)^
        else
          AsDateTimes[AIndex] := FDMSecs2DateTime(PDouble(ABuffer)^);
      ftTimeStamp, ftOraTimeStamp:
        AsSQLTimeStamps[AIndex] := PSQLTimeStamp(ABuffer)^;
      ftParadoxOle, ftOraInterval:
        AsSQLTimeIntervals[AIndex] := PFDSQLTimeInterval(ABuffer)^;
      ftBCD:
        begin
          crValue := 0.0;
          if BCDToCurr(PBcd(ABuffer)^, crValue) then
            AsBCDs[AIndex] := crValue
          else
            ErrFieldOutOfRange;
        end;
      ftFMTBcd:
        AsFMTBCDs[AIndex] := PBcd(ABuffer)^;
      ftCurrency:
        AsCurrencys[AIndex] := PCurrency(ABuffer)^;
      ftSingle:
        AsSingles[AIndex] := PSingle(ABuffer)^;
      ftFloat:
        case FDDataType of
        dtFmtBCD:   AsFMTBCDs[AIndex] := PBcd(ABuffer)^;
        dtSingle:   AsSingles[AIndex] := PSingle(ABuffer)^;
        else        AsFloats[AIndex] := PDouble(ABuffer)^;
        end;
      ftExtended:
        AsExtendeds[AIndex] := PExtended(ABuffer)^;
      ftBoolean:
        AsBooleans[AIndex] := PWordBool(ABuffer)^;
      ftBytes, ftVarBytes:
        begin
          if ALen = $FFFFFFFF then
            if (DataType = ftBytes) and (Size > 0) then
              ALen := Size
            else
              ALen := FDAnsiStrLen(PFDAnsiString(ABuffer));
          SetBytesValue(AIndex, ABuffer, ALen);
        end;
{$IFNDEF NEXTGEN}
      ftMemo, ftOraClob,
{$ENDIF}
      ftBlob, ftGraphic, ftTypedBinary, ftOraBlob:
        begin
          if ALen = $FFFFFFFF then
            ALen := FDAnsiStrLen(PFDAnsiString(ABuffer));
          SetBlobRawData(ALen, ABuffer, AIndex);
        end;
      ftGUID:
        AsGUIDs[AIndex] := PGUID(ABuffer)^;
      ftCursor:
        begin
          if AIndex < 0 then
            AIndex := 0;
          FValue[AIndex] := 0;
        end;
      ftArray, ftReference, ftDataSet, ftStream:
        ; // nothing
    else
      ErrBadFieldType;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.BeginSetBlobRawData(var AIndex: Integer);
begin
  CheckIndex(AIndex);
  if not (DataType in [ftString, ftWideString, ftFixedChar,
                       ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftDBaseOle, ftTypedBinary, ftOraBlob, ftOraClob,
                       ftWideMemo, ftFixedWideChar]) then
    FDataType := ftBlob;
  FBound := True;
  FValue[AIndex] := Null;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.EndSetBlobRawData(ALen: LongWord; APtr: PByte; AIndex: Integer): PByte;
var
  pData: PVarData;
begin
  if (APtr <> nil) or (ALen > 0) then begin
    pData := @TVarData(FValue[AIndex]);
    if IsUnicode then begin
      pData^.VType := varUString;
      if APtr <> nil then
        SetString(UnicodeString(pData^.VUString), PWideChar(APtr), ALen)
      else
        SetLength(UnicodeString(pData^.VUString), ALen);
      Result := PByte(PWideChar(UnicodeString(pData^.VUString)));
    end
    else begin
{$IFDEF NEXTGEN}
      FValue[AIndex] := VarArrayCreate([0, ALen - 1], varByte);
      Result := PByte(pData^.VArray^.Data);
      if APtr <> nil then
        Move(APtr^, Result^, ALen);
{$ELSE}
      pData^.VType := varString;
      if APtr <> nil then
        SetString(AnsiString(pData^.VString), PAnsiChar(APtr), ALen)
      else
        SetLength(AnsiString(pData^.VString), ALen);
      Result := PByte(PAnsiChar(AnsiString(pData^.VString)));
{$ENDIF}
    end;
  end
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.SetBlobRawData(ALen: LongWord; APtr: PByte; AIndex: Integer): PByte;
begin
  BeginSetBlobRawData(AIndex);
  Result := EndSetBlobRawData(ALen, APtr, AIndex);
end;

{ ---------------------------------------------------------------------------- }
                                                                          
                                                                        
function TFDParam.GetBlobRawData(var ALen: LongWord; var APtr: PByte; AIndex: Integer): Boolean;
  procedure ErrorCantGet;
  begin
    FDException(Self, [S_FD_LStan], er_FD_StanCantGetBlob, []);
  end;
begin
  if not (DataType in [ftString, ftWideString, ftFixedChar,
                       ftBytes, ftVarBytes,
                       ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftDBaseOle, ftTypedBinary, ftOraBlob, ftOraClob,
                       ftWideMemo, ftFixedWideChar]) then
    ErrorCantGet;
  Result := not IsNulls[AIndex];
  if not Result then begin
    ALen := 0;
    APtr := nil;
  end
  else begin
    if AIndex < 0 then
      AIndex := 0;
    case VarType(FValue[AIndex]) of
{$IFNDEF NEXTGEN}
    varString:
      begin
        APtr := PByte(AnsiString(TVarData(FValue[AIndex]).VString));
        ALen := Length(AnsiString(TVarData(FValue[AIndex]).VString));
      end;
{$ENDIF}
    varOleStr:
      begin
        APtr := PByte(TVarData(FValue[AIndex]).VOleStr);
        ALen := StrLen(TVarData(FValue[AIndex]).VOleStr);
      end;
    varUString:
      begin
        APtr := PByte(PWideChar(UnicodeString(TVarData(FValue[AIndex]).VUString)));
        ALen := Length(UnicodeString(TVarData(FValue[AIndex]).VUString));
      end;
    varArray or varByte:
      begin
        APtr := PByte(TVarData(FValue[AIndex]).VArray^.Data);
        ALen := TVarData(FValue[AIndex]).VArray^.Bounds[0].ElementCount;
      end;
    else
      if IsUnicode then
        VarCast(FValue[AIndex], FValue[AIndex], varUString)
      else
        VarCast(FValue[AIndex], FValue[AIndex], varString);
      Result := GetBlobRawData(ALen, APtr, AIndex);
    end;
    if (ALen = 0) and (APtr = nil) then
      APtr := PByte(Self);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetBytesValue(AIndex: Integer; ABuff: PByte; ASize: LongWord);
var
  V: Variant;
  pDest: Pointer;
begin
  if not (DataType in [ftVarBytes, ftBytes]) then
    DataType := ftBytes;
  if ASize = 0 then
    Values[AIndex] := Null
  else begin
    V := VarArrayCreate([0, ASize - 1], varByte);
    pDest := VarArrayLock(V);
    try
      Move(ABuff^, pDest^, ASize);
    finally
      VarArrayUnlock(V);
    end;
    Values[AIndex] := V;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.GetBytesValue(AIndex: Integer; ABuff: PByte);
var
  V: Variant;
  P: Pointer;
  sb: TFDByteString;
  pData: PVarData;
begin
  V := Values[AIndex];
  if VarIsArray(V) then begin
    P := VarArrayLock(V);
    try
      Move(P^, ABuff^, VarArrayHighBound(V, 1) + 1);
    finally
      VarArrayUnlock(V);
    end;
  end
  else begin
    pData := FindVarData(V);
    if (pData^.VType <> varNull) and (pData^.VType <> varEmpty) then begin
{$IFNDEF NEXTGEN}
      if pData^.VType = varString then
        sb := TFDByteString(V)
      else
{$ENDIF}
        sb := TFDEncoder.Enco(V, ecANSI);
      Move(PByte(sb)^, ABuff^, Length(sb) * SizeOf(Byte));
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.Assign(ASource: TPersistent);

  procedure LoadFromStreamPersist(const StreamPersist: IStreamPersist);
  var
    MS: TMemoryStream;
  begin
    MS := TMemoryStream.Create;
    try
      StreamPersist.SaveToStream(MS);
      LoadFromStream(MS, ftGraphic);
    finally
      FDFree(MS);
    end;
  end;

  procedure LoadFromStrings(ASource: TStrings);
  begin
    AsWideMemo := ASource.Text;
  end;

var
  StreamPersist: IStreamPersist;
begin
  if ASource is TFDParam then
    AssignParam(TFDParam(ASource))
  else if ASource is TParam then
    AssignDlpParam(TParam(ASource))
  else if ASource is TField then
    AssignField(TField(ASource))
  else if ASource is TStrings then
    LoadFromStrings(TStrings(ASource))
  else if Supports(ASource, IStreamPersist, StreamPersist) then
    LoadFromStreamPersist(StreamPersist)
  else
    inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.AssignTo(ADest: TPersistent);
begin
  if ADest is TField then
    TField(ADest).Value := FValue[0]
  else if ADest is TParam then
    AssignToDlpParam(TParam(ADest))
  else
    inherited AssignTo(ADest);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.AssignParam(AParam: TFDParam);
begin
  if AParam <> nil then begin
    FDataType := AParam.DataType;
    FFDDataType := AParam.FDDataType;
    FDataTypeName := AParam.FDataTypeName;
    FBound := AParam.Bound;
    FName := AParam.Name;
    if FParamType = ptUnknown then
      FParamType := AParam.ParamType;
    FSize := AParam.Size;
    FPrecision := AParam.Precision;
    FNumericScale := AParam.NumericScale;
    FPosition := AParam.Position;
    FIsCaseSensitive := AParam.IsCaseSensitive;
    ArraySize := AParam.ArraySize;
    ArrayType := AParam.ArrayType;
    FStreamMode := AParam.StreamMode;
    FValue := Copy(AParam.FValue);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.AssignDlpParam(AParam: TParam);
begin
  if AParam <> nil then begin
    FDataType := AParam.DataType;
    FFDDataType := dtUnknown;
    FDataTypeName := '';
    FBound := AParam.Bound;
    FName := AParam.Name;
    if FParamType = ptUnknown then
      FParamType := AParam.ParamType;
    FSize := AParam.Size;
    FPrecision := AParam.Precision;
    FNumericScale := AParam.NumericScale;
    FPosition := AParam.Index + 1;
    FIsCaseSensitive := False;
    ArraySize := 1;
    ArrayType := atScalar;
    FStreamMode := smOpenRead;
    case FDataType of
    ftString, ftFixedChar, ftMemo:
      if AParam.IsNull then
        FValue[0] := Null
      else
        FValue[0] := VarAsType(AParam.Value, varFDAString);
    ftBytes, ftVarBytes, ftBlob, ftGraphic, ftTypedBinary, ftOraBlob:
      if AParam.IsNull then
        FValue[0] := Null
      else if VarType(AParam.Value) = varOleStr then
        FValue[0] := VarAsType(AParam.Value, varUString)
      else
        FValue[0] := AParam.Value;
    else
      FValue[0] := AParam.Value;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.AssignToDlpParam(AParam: TParam);
begin
  if AParam <> nil then begin
    AParam.DataType := FDataType;
    AParam.Bound := FBound;
    AParam.Name := FName;
    if AParam.ParamType = ptUnknown then
      AParam.ParamType := FParamType;
    AParam.Size := FSize;
    AParam.Precision := FPrecision;
    AParam.NumericScale := FNumericScale;
    if Length(FValue) > 0 then
      AParam.Value := FValue[0]
    else
      AParam.Value := Null;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.AssignFieldValue(AField: TField; const AValue: Variant);
var
  oRefField: TField;
begin
  if AField = nil then
    Exit;
  if AField.DataType = ftArray then
    oRefField := TObjectField(AField).Fields[0]
  else
    oRefField := AField;
  if (oRefField.DataType = ftString) and TStringField(oRefField).FixedChar then
    DataType := ftFixedChar
  else if (oRefField.DataType = ftMemo) and (oRefField.Size > 255) then
    DataType := ftString
  else if (oRefField.DataType = ftFmtMemo) and (oRefField.Size > 255) then
    DataType := ftWideString
  else if (oRefField.DataType = ftWideString) and TWideStringField(oRefField).FixedChar then
    DataType := ftFixedWideChar
  else if (oRefField.DataType = ftWideMemo) and (oRefField.Size > 255) then
    DataType := ftWideString
  else
    DataType := oRefField.DataType;
  FFDDataType := dtUnknown;
  if AField is TObjectField then
    FDataTypeName := TObjectField(AField).ObjectType;
  if oRefField.DataType in [ftBcd, ftFMTBcd] then
    NumericScale := oRefField.Size
  else
    Size := oRefField.Size;
  if AField.DataType = ftArray then begin
    ArraySize := AField.Size;
    ArrayType := atTable;
  end
  else begin
    ArraySize := 1;
    ArrayType := atScalar;
  end;
  if VarIsNull(AValue) then
    Clear
  else
    Value := AValue;
  FBound := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.AssignFieldValue(AField: TField);
begin
  if AField <> nil then
    AssignFieldValue(AField, AField.Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.AssignField(AField: TField);
begin
  if AField <> nil then begin
    AssignFieldValue(AField, AField.Value);
    Name := AField.FieldName;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.Clear(AIndex: Integer);
var
  i: Integer;
begin
  if ArrayType = atScalar then
    FValue[0] := Null
  else if AIndex = -1 then
    for i := 0 to Length(FValue) - 1 do
      FValue[i] := Null
  else begin
    CheckIndex(AIndex);
    FValue[AIndex] := Null;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.AssignVarRec(const AVarRec: TVarRec; AIndex: Integer = -1);
begin
  case AVarRec.VType of
  vtInteger:       AsIntegers[AIndex] := AVarRec.VInteger;
  vtBoolean:       AsBooleans[AIndex] := AVarRec.VBoolean;
  vtExtended:      AsFloats[AIndex] := AVarRec.VExtended^;
  vtPointer:       {$IFDEF FireDAC_32} AsIntegers {$ELSE} AsLargeInts {$ENDIF}
                     [AIndex] := NativeInt(AVarRec.VPointer);
{$IFNDEF NEXTGEN}
  vtChar:          AsAnsiStrings[AIndex] := AVarRec.VChar;
  vtString:        AsAnsiStrings[AIndex] := AVarRec.VString^;
  vtAnsiString:    AsAnsiStrings[AIndex] := TFDAnsiString(AVarRec.VAnsiString);
  vtPChar:         AsAnsiStrings[AIndex] := AVarRec.VPChar;
{$ENDIF}
  vtWideChar:      AsWideStrings[AIndex] := AVarRec.VWideChar;
  vtWideString:    AsWideStrings[AIndex] := WideString(AVarRec.VWideString);
  vtUnicodeString: AsStrings[AIndex] := UnicodeString(AVarRec.VUnicodeString);
  vtPWideChar:     AsWideStrings[AIndex] := AVarRec.VPWideChar;
  vtCurrency:      AsCurrencys[AIndex] := AVarRec.VCurrency^;
  vtVariant:       Values[AIndex] := AVarRec.VVariant^;
  vtInt64:         AsLargeInts[AIndex] := AVarRec.VInt64^;
  else             ASSERT(False);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetDataSet: TDataSet;
begin
  if not Assigned(Collection) then
    Result := nil
  else
    Result := TFDParams(Collection).GetDataSet;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetDisplayName: String;
begin
  if FName = '' then
    Result := inherited GetDisplayName
  else
    Result := FName;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.HasParamObjectBase(const AData: TVarData; const AObjectType: TClass): Boolean;

  function IsIParamObject: Boolean;
  var
    oObj: IParamObject;
  begin
    Result := Supports(IUnknown(AData.VUnknown), IParamObject, oObj) and
      oObj.InstanceIsType(AObjectType);
  end;

begin
  Result := (AData.VType = varUnknown) and IsIParamObject;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.HasParamObject(const AObjectType: TClass; AIndex: Integer): Boolean;
var
  pData: PVarData;
begin
  CheckIndex(AIndex);
  pData := FindVarData(FValue[AIndex]);
  Result := HasParamObjectBase(pData^, AObjectType);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetParamObjectBase(const AData: TVarData): IParamObject;
begin
  if AData.VType = varUnknown then
    Result := IUnknown(AData.VUnknown) as IParamObject
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetParamObject(AIndex: Integer): IParamObject;
var
  pData: PVarData;
begin
  CheckIndex(AIndex);
  pData := FindVarData(FValue[AIndex]);
  Result := GetParamObjectBase(pData^);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.SetObjectValue(const AInstance: TObject; const ADataType: TFieldType;
  AOwner: Boolean; AIndex: Integer): IParamObject;
var
  oObj: IParamObject;
  i: Integer;
  oObjClass: TParamObjectClass;
begin
  // If setting the same object and changing only the ownership flags, first
  // make sure the existing TParamObject doesn't own the instance so it won't free it.
  if HasParamObject(TObject, AIndex) then begin
    oObj := GetParamObject(AIndex);
    if oObj.GetInstance(False) = AInstance then
      // Release ownership
      oObj.GetInstance(True);
  end;
  FDataType := ADataType;
  if AInstance = nil then
    Clear(AIndex)
  else begin
    oObjClass := nil;
    for i := 0 to High(GParamObjectClasses) do
      if ADataType in GParamObjectClasses[i].FDataTypes then begin
        oObjClass := GParamObjectClasses[i].FObjClass;
        Break;
      end;
    if oObjClass = nil then
      ErrBadFieldType;
    Result := oObjClass.Create(AInstance, FDataType, AOwner);
    Values[AIndex] := Result;
    if Collection <> nil then
      TFDParams(Collection).FHasObjects := True;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsBoolean(const AValue: Boolean);
begin
  SetAsBooleans(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsBoolean: Boolean;
begin
  Result := GetAsBooleans(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsBooleans(AIndex: Integer; const AValue: Boolean);
begin
  FDataType := ftBoolean;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsBooleans(AIndex: Integer): Boolean;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := False
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsByteStr: TFDByteString;
begin
  Result := GetAsByteStrs(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsByteStr(const AValue: TFDByteString);
begin
  SetAsByteStrs(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsVarByteStr(const AValue: TFDByteString);
begin
  SetAsVarByteStrs(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsByteStrs(AIndex: Integer): TFDByteString;
begin
  if IsNulls[AIndex] then
    SetLength(Result, 0)
  else begin
    SetLength(Result, GetDataSize(AIndex));
    GetBytesValue(AIndex, PByte(Result));
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsByteStrs(AIndex: Integer; const AValue: TFDByteString);
begin
  FDataType := ftBytes;
  SetBytesValue(AIndex, PByte(AValue), Length(AValue) * SizeOf(Byte));
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsVarByteStrs(AIndex: Integer; const AValue: TFDByteString);
begin
  FDataType := ftVarBytes;
  SetBytesValue(AIndex, PByte(AValue), Length(AValue) * SizeOf(Byte));
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsSingle(const AValue: Single);
begin
  SetAsSingles(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsSingle: Single;
begin
  Result := GetAsSingles(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsSingles(AIndex: Integer; const AValue: Single);
begin
  FDataType := ftSingle;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsSingles(AIndex: Integer): Single;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0.0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsFloat(const AValue: Double);
begin
  SetAsFloats(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsFloat: Double;
begin
  Result := GetAsFloats(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsFloats(AIndex: Integer; const AValue: Double);
begin
  FDataType := ftFloat;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsFloats(AIndex: Integer): Double;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0.0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsExtended(const AValue: Extended);
begin
  SetAsExtendeds(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsExtended: Extended;
begin
  Result := GetAsExtendeds(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsExtendeds(AIndex: Integer; const AValue: Extended);
begin
  FDataType := ftExtended;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsExtendeds(AIndex: Integer): Extended;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0.0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsCurrency(const AValue: Currency);
begin
  SetAsCurrencys(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsCurrency: Currency;
begin
  Result := GetAsCurrencys(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsCurrencys(AIndex: Integer; const AValue: Currency);
begin
  FDataType := ftCurrency;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsCurrencys(AIndex: Integer): Currency;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0.0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsBCD(const AValue: Currency);
begin
  SetAsBCDs(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsBCD: Currency;
begin
  Result := GetAsBCDs(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsBCDs(AIndex: Integer; const AValue: Currency);
begin
  FDataType := ftBCD;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsBCDs(AIndex: Integer): Currency;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0.0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsFMTBCD(const AValue: TBcd);
begin
  SetAsFMTBCDs(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsFMTBCD: TBcd;
begin
  Result := GetAsFMTBCDs(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsFMTBCDs(AIndex: Integer; const AValue: TBcd);
begin
  FDataType := ftFMTBCD;
  Values[AIndex] := VarFMTBcdCreate(AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsFMTBCDs(AIndex: Integer): TBcd;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := NullBcd
  else begin
    GetVarData(pVar, AIndex);
    Result := VarToBcd(pVar^);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsSQLTimeStamp(const AValue: TSQLTimeStamp);
begin
  SetAsSQLTimeStamps(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsSQLTimeStamp: TSQLTimeStamp;
begin
  Result := GetAsSQLTimeStamps(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsSQLTimeStamps(AIndex: Integer; const AValue: TSQLTimeStamp);
begin
  if FDataType <> ftOraTimeStamp then
    FDataType := ftTimeStamp;
  Values[AIndex] := VarSQLTimeStampCreate(AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsSQLTimeStamps(AIndex: Integer): TSQLTimeStamp;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := NullSQLTimeStamp
  else begin
    GetVarData(pVar, AIndex);
    Result := VarToSQLTimeStamp(pVar^);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsSQLTimeInterval(const AValue: TFDSQLTimeInterval);
begin
  SetAsSQLTimeIntervals(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsSQLTimeInterval: TFDSQLTimeInterval;
begin
  Result := GetAsSQLTimeIntervals(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsSQLTimeIntervals(AIndex: Integer; const AValue: TFDSQLTimeInterval);
begin
  FDataType := ftOraInterval;
  Values[AIndex] := FDVarSQLTimeIntervalCreate(AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsSQLTimeIntervals(AIndex: Integer): TFDSQLTimeInterval;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := C_NullSQLTimeInterval
  else begin
    GetVarData(pVar, AIndex);
    Result := FDVar2SQLTimeInterval(pVar^);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsShortInt(const AValue: ShortInt);
begin
  SetAsShortInts(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsShortInt: ShortInt;
begin
  Result := GetAsShortInts(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsShortInts(AIndex: Integer; const AValue: ShortInt);
begin
  FDataType := ftShortint;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsShortInts(AIndex: Integer): ShortInt;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsByte(const AValue: Byte);
begin
  SetAsBytes(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsByte: Byte;
begin
  Result := GetAsBytes(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsBytes(AIndex: Integer; const AValue: Byte);
begin
  FDataType := ftByte;
  Values[AIndex] := Byte(AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsBytes(AIndex: Integer): Byte;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsSmallInt(const AValue: SmallInt);
begin
  SetAsSmallInts(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsSmallInt: SmallInt;
begin
  Result := GetAsSmallInts(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsSmallInts(AIndex: Integer; const AValue: SmallInt);
begin
  FDataType := ftSmallint;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsSmallInts(AIndex: Integer): SmallInt;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsWord(const AValue: Word);
begin
  SetAsWords(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsWord: Word;
begin
  Result := GetAsWords(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsWords(AIndex: Integer; AValue: Word);
begin
  FDataType := ftWord;
  Values[AIndex] := Word(AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsWords(AIndex: Integer): Word;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsInteger(const AValue: Integer);
begin
  SetAsIntegers(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsInteger: Integer;
begin
  Result := GetAsIntegers(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsIntegers(AIndex: Integer; const AValue: Integer);
begin
  FDataType := ftInteger;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsIntegers(AIndex: Integer): Integer;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsLongWord: LongWord;
begin
  Result := GetAsLongWords(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsLongWord(const AValue: LongWord);
begin
  SetAsLongWords(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsLongWords(AIndex: Integer): LongWord;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsLongWords(AIndex: Integer; const AValue: LongWord);
begin
  FDataType := ftLongWord;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsLargeInt(const AValue: LargeInt);
begin
  SetAsLargeInts(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsLargeInt: LargeInt;
begin
  Result := GetAsLargeInts(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsLargeInts(AIndex: Integer; const AValue: LargeInt);
begin
  FDataType := ftLargeint;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsLargeInts(AIndex: Integer): LargeInt;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsString(const AValue: String);
begin
  SetAsStrings(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsString: String;
begin
  Result := GetAsStrings(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsStrings(AIndex: Integer; const AValue: String);
begin
  if not (FDataType in [ftString, ftFixedChar, ftWideString, ftFixedWideChar]) then
    FDataType := ftWideString;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsStrings(AIndex: Integer): String;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := ''
  else if DataType = ftBoolean then begin
    if Values[AIndex] then
      Result := S_FD_True
    else
      Result := S_FD_False;
  end
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsFixedChar(const AValue: String);
begin
  SetAsFixedChars(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsFixedChars(AIndex: Integer; const AValue: String);
begin
  if not (FDataType in [ftString, ftFixedChar, ftWideString, ftFixedWideChar]) then
    FDataType := ftFixedChar;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsAnsiString: TFDAnsiString;
begin
  Result := GetAsAnsiStrings(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsAnsiString(const AValue: TFDAnsiString);
begin
  SetAsAnsiStrings(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsAnsiStrings(AIndex: Integer): TFDAnsiString;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := ''
  else if DataType = ftBoolean then begin
    if Values[AIndex] then
      Result := S_FD_True
    else
      Result := S_FD_False;
  end
  else begin
    GetVarData(pVar, AIndex);
    Result := TFDAnsiString(pVar^);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsAnsiStrings(AIndex: Integer; const AValue: TFDAnsiString);
begin
  if not (FDataType in [ftString, ftFixedChar]) then
    FDataType := ftString;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsWideString: UnicodeString;
begin
  Result := GetAsWideStrings(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsWideString(const AValue: UnicodeString);
begin
  SetAsWideStrings(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsWideStrings(AIndex: Integer): UnicodeString;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := ''
  else begin
    GetVarData(pVar, AIndex);
    Result := pVar^;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsWideStrings(AIndex: Integer; const AValue: UnicodeString);
begin
  if not (DataType in [ftWideString, ftFixedWideChar]) then
    DataType := ftWideString;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsXML(const AValue: UnicodeString);
begin
  SetAsXMLs(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsXMLs(AIndex: Integer; const AValue: UnicodeString);
begin
  DataType := ftDBaseOle;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsDate(const AValue: TDateTime);
begin
  SetAsDates(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsDates(AIndex: Integer; const AValue: TDateTime);
begin
  FDataType := ftDate;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsTime(const AValue: TDateTime);
begin
  SetAsTimes(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsTimes(AIndex: Integer; const AValue: TDateTime);
begin
  FDataType := ftTime;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsDateTime(const AValue: TDateTime);
begin
  SetAsDateTimes(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsDateTime: TDateTime;
begin
  Result := GetAsDateTimes(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsDateTimes(AIndex: Integer; const AValue: TDateTime);
begin
  FDataType := ftDateTime;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsDateTimes(AIndex: Integer): TDateTime;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    Result := 0.0
  else begin
    GetVarData(pVar, AIndex);
    Result := VarToDateTime(pVar^);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsGUID: TGUID;
begin
  Result := GetAsGUIDs(-1);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsGUIDs(AIndex: Integer): TGUID;
var
  pVar: PVariant;
begin
  if IsNulls[AIndex] then
    FillChar(Result, SizeOf(TGUID), 0)
  else begin
    GetVarData(pVar, AIndex);
    Result := StringToGUID(VarToStr(pVar^));
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsGUID(const AValue: TGUID);
begin
  SetAsGUIDs(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsGUIDs(AIndex: Integer; const AValue: TGUID);
begin
  DataType := ftGuid;
  Values[AIndex] := GUIDToString(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsVariant(const AValue: Variant);
begin
  SetAsVariants(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.InternalSetScalarValue(AIndex: Integer; const AValue: Variant);
var
  iLen: Integer;
  pData: PVarData;

  procedure ErrorValueToLong;
  begin
    FDException(Self, [S_FD_LStan], er_FD_StanParamOverflow, [DisplayName, iLen, Size]);
  end;

begin
  if (Size > 0) and
     (DataType in [ftWideString, ftFmtMemo, ftString, ftFixedChar, ftMemo,
                   ftOraClob, ftADT, ftBytes, ftVarBytes, ftBlob, ftOraBlob,
                   ftWideMemo, ftFixedWideChar, ftDBaseOle]) then begin
    pData := FindVarData(AValue);
    case pData^.VType of
{$IFNDEF NEXTGEN}
    varString:
      begin
        iLen := Length(AnsiString(pData^.VString));
        if iLen > Size then
          ErrorValueToLong;
      end;
{$ENDIF}
    varOleStr:
      begin
        iLen := StrLen(pData^.VOleStr);
        if iLen > Size then
          ErrorValueToLong;
      end;
    varUString:
      begin
        iLen := Length(UnicodeString(pData^.VUString));
        if iLen > Size then
          ErrorValueToLong;
      end;
    varArray or varByte:
      begin
        iLen := VarArrayHighBound(AValue, 1) + 1;
        if iLen > Size then
          ErrorValueToLong;
      end;
    end;
  end;
  FValue[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.InternalSetTableValue(const AValue: Variant);
var
  i: Integer;
begin
  for i := 0 to Min(ArraySize - 1, VarArrayHighBound(AValue, 1)) do
    SetAsVariants(i, AValue[i]);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsVariants(AIndex: Integer; const AValue: Variant);
var
  tp: TVarType;
begin
  CheckIndex(AIndex);
  if ArrayType = atScalar then
    FBound := not VarIsEmpty(AValue)
  else
    FBound := True;
  tp := FindVarData(AValue)^.VType;
  if FDataType = ftUnknown then
    case tp of
      varShortInt:
        FDataType := ftShortint;
      varByte:
        FDataType := ftByte;
      varSmallint:
        FDataType := ftSmallInt;
      varWord:
        FDataType := ftWord;
      varLongWord:
        FDataType := ftLongWord;
      varInteger:
        FDataType := ftInteger;
      varCurrency:
        FDataType := ftCurrency;
      varSingle:
        FDataType := ftSingle;
      varDouble:
        FDataType := ftFloat;
      varDate:
        FDataType := ftDateTime;
      varBoolean:
        FDataType := ftBoolean;
      varUString,
      varString,
      varOleStr:
        if not (FDataType in [ftString, ftFixedChar, ftWideString, ftFixedWideChar]) then
          FDataType := ftWideString;
      varArray or varByte:
        FDataType := ftBlob;
      varUInt64,
      varInt64:
        FDataType := ftLargeInt;
      varUnknown:
        if HasParamObjectBase(TVarData(AValue), TDataSet) then
          FDataType := ftDataSet
        else if HasParamObjectBase(TVarData(AValue), TStream) then
          FDataType := ftStream
        else
          FDataType := ftUnknown;
    else
      if tp = VarFMTBcd then
        FDataType := ftFMTBcd
      else if tp = VarSQLTimeStamp then
        FDataType := ftTimeStamp
      else if tp = FDVarSQLTimeInterval then
        FDataType := ftOraInterval
      else
        FDataType := ftUnknown;
    end;
  if not IsUnicode and ((tp = varOleStr) or (tp = varUString)) then
    InternalSetScalarValue(AIndex, VarAsType(AValue, varFDAString))
  else if IsUnicode and (tp = varString) then
    InternalSetScalarValue(AIndex, VarAsType(AValue, varUString))
  else if (ArrayType = atTable) and (tp and varArray = varArray) and (AIndex = 0) then
    InternalSetTableValue(AValue)
  else
    InternalSetScalarValue(AIndex, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsVariant: Variant;
begin
  Result := GetAsVariants(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.GetVarData(out AVar: PVariant; AIndex: Integer = -1);
begin
  CheckIndex(AIndex);
  AVar := @(FValue[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsVariants(AIndex: Integer): Variant;
var
  pVar: PVariant;
  iLen: Integer;
  pRes, pSrc: Pointer;
begin
  GetVarData(pVar, AIndex);
  if VarType(pVar^) = (varArray or varByte) then begin
    iLen := VarArrayHighBound(pVar^, 1);
    Result := VarArrayCreate([0, iLen], varByte);
    pRes := VarArrayLock(Result);
    pSrc := VarArrayLock(pVar^);
    try
      Move(pSrc^, pRes^, iLen + 1);
    finally
      VarArrayUnlock(Result);
      VarArrayUnlock(pVar^);
    end;
  end
  else
    Result := pVar^;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsMemo(const AValue: TFDAnsiString);
begin
  SetAsMemos(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsMemos(AIndex: Integer; const AValue: TFDAnsiString);
begin
  if not (FDataType in [ftMemo, ftBlob, ftOraBlob, ftOraClob, ftWideMemo]) then
    FDataType := ftMemo;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsBlob(const AValue: TFDByteString);
begin
  SetAsBlobs(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsBlobs(AIndex: Integer; const AValue: TFDByteString);
begin
  if not (FDataType in [ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftDBaseOle,
                        ftTypedBinary, ftOraBlob, ftOraClob, ftWideMemo]) then
    FDataType := ftBlob;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsWideMemo(const AValue: UnicodeString);
begin
  SetAsWideMemos(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsWideMemos(AIndex: Integer; const AValue: UnicodeString);
begin
  FDataType := ftWideMemo;
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetText(const AValue: String);
begin
  SetTexts(0, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetTexts(AIndex: Integer; const AValue: String);
begin
  Values[AIndex] := AValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.LoadFromFile(const AFileName: String; ABlobType: TFieldType;
  AIndex: Integer);
var
  oStream: TStream;
begin
  oStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    LoadFromStream(oStream, ABlobType, AIndex);
  finally
    FDFree(oStream);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.LoadFromStream(AStream: TStream; ABlobType: TFieldType;
  AIndex: Integer);

  function ReallocRawData(ALen: LongWord): PByte;
  begin
    if IsUnicode then
      ALen := ALen div SizeOf(WideChar);
    Result := EndSetBlobRawData(ALen, nil, AIndex);
  end;

const
  CBufSize = $7FFE;
var
  iLen: LongInt;
  iRead: Integer;
begin
  BeginSetBlobRawData(AIndex);
  FDataType := ABlobType;
  AStream.Position := 0;
  iLen := AStream.Size;
  if iLen < 0 then begin
    iLen := 0;
    repeat
      iRead := AStream.Read((ReallocRawData(iLen + CBufSize) + iLen)^, CBufSize);
      Inc(iLen, iRead);
    until iRead < CBufSize;
    ReallocRawData(iLen);
  end
  else
    AStream.ReadBuffer(ReallocRawData(iLen)^, iLen);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.GetDataReader(ABuffer: PByte; AIndex: Integer);
begin
  PPointer(ABuffer)^ := nil;
  PUnknown(ABuffer)^ := GetParamObject(AIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetDataSet(ADataset: TDataSet; AOwner: Boolean; AIndex: Integer);
begin
  SetObjectValue(ADataset, ftDataSet, AOwner, AIndex);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsDataSet: TDataSet;
begin
  Result := GetAsDataSets(-1);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsDataSets(AIndex: Integer): TDataSet;
begin
  if not IsNulls[AIndex] and HasParamObject(TDataSet, AIndex) then
    Result := GetParamObject(AIndex).GetInstance(False) as TDataSet
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsDataSet(const AValue: TDataSet);
begin
  SetAsDataSets(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsDataSets(AIndex: Integer; const AValue: TDataSet);
begin
  SetDataSet(AValue, (AValue <> nil) and (AValue.Owner = nil), AIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetStream(AStream: TStream; ABlobType: TFieldType;
  AOwner: Boolean; AIndex: Integer);
begin
  SetObjectValue(AStream, ABlobType, AOwner, AIndex);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsStream: TStream;
begin
  Result := GetAsStreams(-1);
end;

{ ---------------------------------------------------------------------------- }
function TFDParam.GetAsStreams(AIndex: Integer): TStream;
begin
  if not IsNulls[AIndex] and HasParamObject(TStream, AIndex) then
    Result := GetParamObject(AIndex).GetInstance(False) as TStream
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsStream(const AValue: TStream);
begin
  SetAsStreams(-1, AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDParam.SetAsStreams(AIndex: Integer; const AValue: TStream);
var
  eType: TFieldType;
begin
  if DataType in C_StreamedTypes then
    eType := DataType
  else
    eType := ftStream;
  SetStream(AValue, eType, AValue <> nil, AIndex);
end;

{ ---------------------------------------------------------------------------- }
initialization

  C_FieldType2VarType[ftFMTBcd] := VarFMTBcd;
  C_FieldType2VarType[ftTimeStamp] := VarSQLTimeStamp;
  C_FieldType2VarType[ftOraInterval] := FDVarSQLTimeInterval;

end.
