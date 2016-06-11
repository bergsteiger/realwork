{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC TFDBatchMove text driver            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Comp.BatchMove.Text;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Util,
  FireDAC.Comp.BatchMove;

type
  TFDTextField = class;
  TFDTextFields = class;
  TFDTextFormatSettings = class;
  TFDTextDataDef = class;
  TFDBatchMoveTextDriver = class;
  TFDBatchMoveTextReader = class;
  TFDBatchMoveTextWriter = class;

  TFDTextDataType = (atOther, atString, atFloat, atNumber, atBool, atLongInt,
    atDate, atTime, atDateTime, atBlob, atMemo);
  TFDTextRecordFormat = (rfFixedLength, rfFieldPerLine, rfCommaDoubleQuote,
    rfSemicolonDoubleQuote, rfTabDoubleQuote, rfCustom);

  TFDTextField = class(TCollectionItem)
  private
    FDataType: TFDTextDataType;
    FFieldName: String;
    FFieldSize: Integer;
    FPrecision: Integer;
    procedure SetFieldName(const AValue: String);
  protected
    function GetDisplayName: String; override;
    procedure AssignTo(ADest: TPersistent); override;
  public
    procedure Assign(ASource: TPersistent); override;
    procedure Define(const AName: String; ADataType: TFDDataType;
      ASize, APrecision, AScale: Integer);
  published
    property FieldName: String read FFieldName write SetFieldName;
    property DataType: TFDTextDataType read FDataType write FDataType default atOther;
    property FieldSize: Integer read FFieldSize write FFieldSize default 0;
    property Precision: Integer read FPrecision write FPrecision default 0;
  end;

  TFDTextFields = class(TCollection)
  private
    [Weak] FDef: TFDTextDataDef;
    function GetItem(AIndex: Integer): TFDTextField; inline;
    procedure SetItem(AIndex: Integer; const AValue: TFDTextField); inline;
    procedure CheckFieldName(AField: TFDTextField; const ANewName: String);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ADef: TFDTextDataDef);
    function Add: TFDTextField;
    procedure AddAll;
    function FindField(const AName: String): TFDTextField;
    function FieldByName(const AName: String): TFDTextField;
    property Items[Index: Integer]: TFDTextField read GetItem write SetItem; default;
  end;

  TFDTextFormatSettingsValue = (
    fsCurrencyFormat, fsNegCurrFormat, fsThousandSeparator, fsDecimalSeparator,
    fsCurrencyDecimals, fsDateSeparator, fsTimeSeparator, fsCurrencyString,
    fsShortDateFormat, fsTimeAMString, fsTimePMString, fsShortTimeFormat,
    fsTwoDigitYearCenturyWindow);
  TFDTextFormatSettingsValueSet = set of TFDTextFormatSettingsValue;

  TFDTextFormatSettings = class(TPersistent)
  private
    FFS: TFormatSettings;
    [Weak] FDataDef: TFDTextDataDef;
    FValues: TFDTextFormatSettingsValueSet;
    FBoolFalseVals: TStrings;
    FBoolTrueVals: TStrings;
    FNullVals: TStrings;
    procedure SetCurrencyDecimals(const AValue: Byte);
    procedure SetCurrencyFormat(const AValue: Byte);
    procedure SetCurrencyString(const AValue: string);
    procedure SetDateSeparator(const AValue: Char);
    procedure SetDecimalSeparator(const AValue: Char);
    procedure SetNegCurrFormat(const AValue: Byte);
    procedure SetShortDateFormat(const AValue: string);
    procedure SetShortTimeFormat(const AValue: string);
    procedure SetThousandSeparator(const AValue: Char);
    procedure SetTimeAMString(const AValue: string);
    procedure SetTimePMString(const AValue: string);
    procedure SetTimeSeparator(const AValue: Char);
    procedure SetTwoDigitYearCenturyWindow(const AValue: Word);
    function IsCDS: Boolean; inline;
    function IsCFS: Boolean; inline;
    function IsCSS: Boolean; inline;
    function IsDSS: Boolean; inline;
    function IsDTSS: Boolean; inline;
    function IsNCFS: Boolean; inline;
    function IsSDFS: Boolean; inline;
    function IsSTFS: Boolean; inline;
    function IsTAMSS: Boolean; inline;
    function IsTDYCWS: Boolean; inline;
    function IsTMSS: Boolean; inline;
    function IsTPMSS: Boolean; inline;
    function IsTSS: Boolean; inline;
    function GetCurrencyDecimals: Byte; inline;
    function GetCurrencyFormat: Byte; inline;
    function GetCurrencyString: string; inline;
    function GetDateSeparator: Char; inline;
    function GetDecimalSeparator: Char; inline;
    function GetNegCurrFormat: Byte; inline;
    function GetShortDateFormat: string; inline;
    function GetShortTimeFormat: string; inline;
    function GetThousandSeparator: Char; inline;
    function GetTimeAMString: string; inline;
    function GetTimePMString: string; inline;
    function GetTimeSeparator: Char; inline;
    function GetTwoDigitYearCenturyWindow: Word; inline;
    procedure SetBoolFalseVals(const AValue: TStrings);
    procedure SetBoolTrueVals(const AValue: TStrings);
    procedure SetNullVals(const AValue: TStrings);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ADef: TFDTextDataDef);
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    property DataDef: TFDTextDataDef read FDataDef;
    property FS: TFormatSettings read FFS;
  published
    property CurrencyFormat: Byte read GetCurrencyFormat write SetCurrencyFormat stored IsCFS;
    property NegCurrFormat: Byte read GetNegCurrFormat write SetNegCurrFormat stored IsNCFS;
    property ThousandSeparator: Char read GetThousandSeparator write SetThousandSeparator stored IsTSS;
    property DecimalSeparator: Char read GetDecimalSeparator write SetDecimalSeparator stored IsDSS;
    property CurrencyDecimals: Byte read GetCurrencyDecimals write SetCurrencyDecimals stored IsCDS;
    property DateSeparator: Char read GetDateSeparator write SetDateSeparator stored IsDTSS;
    property TimeSeparator: Char read GetTimeSeparator write SetTimeSeparator stored IsTMSS;
    property CurrencyString: string read GetCurrencyString write SetCurrencyString stored IsCSS;
    property ShortDateFormat: string read GetShortDateFormat write SetShortDateFormat stored IsSDFS;
    property TimeAMString: string read GetTimeAMString write SetTimeAMString stored IsTAMSS;
    property TimePMString: string read GetTimePMString write SetTimePMString stored IsTPMSS;
    property ShortTimeFormat: string read GetShortTimeFormat write SetShortTimeFormat stored IsSTFS;
    property TwoDigitYearCenturyWindow: Word read GetTwoDigitYearCenturyWindow
      write SetTwoDigitYearCenturyWindow stored IsTDYCWS;
    property BoolTrueVals: TStrings read FBoolTrueVals write SetBoolTrueVals;
    property BoolFalseVals: TStrings read FBoolFalseVals write SetBoolFalseVals;
    property NullVals: TStrings read FNullVals write SetNullVals;
  end;

  TFDTextDataDef = class(TPersistent)
  private
    [Weak] FDriver: TFDBatchMoveTextDriver;
    FFields: TFDTextFields;
    FDelimiter: Char;
    FRecordDelimiter: TFDTextEndOfLine;
    FRecordFormat: TFDTextRecordFormat;
    FSeparator: Char;
    FWithFieldNames: Boolean;
    FFormatSettings: TFDTextFormatSettings;
    FStrsEmpty2Null: Boolean;
    FTrimLeft: Boolean;
    FTrimRight: Boolean;
    procedure SetFields(const AValue: TFDTextFields);
    procedure SetDelimiter(AValue: Char);
    procedure SetRecordFormat(AValue: TFDTextRecordFormat);
    procedure SetSeparator(AValue: Char);
    function IsADDS: Boolean;
    procedure SetWithFieldNames(const AValue: Boolean);
    procedure SetFormatSettings(const AValue: TFDTextFormatSettings);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ADriver: TFDBatchMoveTextDriver);
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    property Driver: TFDBatchMoveTextDriver read FDriver;
  published
    property Fields: TFDTextFields read FFields write SetFields;
    property Delimiter: Char read FDelimiter write SetDelimiter stored IsADDS;
    property Separator: Char read FSeparator write SetSeparator stored IsADDS;
    property EndOfLine: TFDTextEndOfLine read FRecordDelimiter write FRecordDelimiter default elDefault;
    property RecordFormat: TFDTextRecordFormat read FRecordFormat write SetRecordFormat default rfCommaDoubleQuote;
    property WithFieldNames: Boolean read FWithFieldNames write SetWithFieldNames default False;
    property TrimLeft: Boolean read FTrimLeft write FTrimLeft default True;
    property TrimRight: Boolean read FTrimRight write FTrimRight default True;
    property StrsEmpty2Null: Boolean read FStrsEmpty2Null write FStrsEmpty2Null default True;
    property FormatSettings: TFDTextFormatSettings read FFormatSettings write SetFormatSettings;
  end;

  TFDBatchMoveTextDriver = class(TFDBatchMoveDriver)
  private
    FStream: TStream;
    FFileName: String;
    FDataDef: TFDTextDataDef;
    FEncoding: TFDEncoding;
    FText: TFDTextFile;
    procedure SetDataDef(const AValue: TFDTextDataDef);
    function GetActualFileName: String;
  protected
    // IFDBatchMoveDriver
    function CheckDefined(ARaise: Boolean): Boolean; virtual;
    procedure Close(AStopTxError: Boolean);
    procedure Refresh;
    procedure AbortJob;
    function AddAutoFields: Boolean;
    procedure DeleteAutoFields;
    function GetCatalog: String;
    function GetIsUnicode: Boolean;
    function GetIsOpen: Boolean;
    function GetFieldCount: Integer;
    function GetFieldName(AIndex: Integer): String;
    function GetFieldIndex(const AName: String; ACheck: Boolean): Integer;
    function GetFieldInfo(AIndex: Integer; var AType: TFDDataType;
      var ASize: LongWord; var APrec, AScale: Integer; var AInKey, AIsIdentity: Boolean): TObject;
    procedure GetTableDefs(AFieldDefs: TFieldDefs; AIndexDefs: TIndexDefs);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Stream: TStream read FStream write FStream;
    property ActualFileName: String read GetActualFileName;
  published
    property FileName: String read FFileName write FFileName;
    property DataDef: TFDTextDataDef read FDataDef write SetDataDef;
    property Encoding: TFDEncoding read FEncoding write FEncoding default ecDefault;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDBatchMoveTextReader = class(TFDBatchMoveTextDriver, IFDBatchMoveReader)
  private
    FEof: Boolean;
    FBuff: array of Char;
    function TrimText(const AStr: String; AHeader: Boolean): String;
    procedure GuessFormat(AText: TFDTextFile; AAnalyze: TFDBatchMoveAnalyze); overload;
  protected
    // IFDBatchMoveReader
    function CheckDefined(ARaise: Boolean): Boolean; override;
    function GetSourceTableName: String;
    procedure Open(AStartTx: Boolean);
    procedure ReadHeader;
    function Eof: Boolean;
    procedure ReadRecord;
    procedure NextRecord;
    procedure GuessFormat(AAnalyze: TFDBatchMoveAnalyze = [taDelimSep, taHeader, taFields]); overload;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDBatchMoveTextWriter = class(TFDBatchMoveTextDriver, IFDBatchMoveWriter)
  protected
    // IFDBatchMoveWriter
    procedure Open(AStartTx: Boolean);
    procedure CreateTable;
    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
    procedure Erase(ANoUndo: Boolean);
    procedure WriteHeader;
    function FindRecord: Boolean;
    function InsertRecord: Integer;
    function UpdateRecord: Integer;
    function DeleteRecord: Integer;
    function FlushRecords: Integer;
  end;

implementation

uses
  System.Variants,
  FireDAC.Stan.Consts, FireDAC.Stan.Error, FireDAC.Stan.Option;

{-------------------------------------------------------------------------------}
{ TFDTextField                                                                  }
{-------------------------------------------------------------------------------}
procedure TFDTextField.SetFieldName(const AValue: String);
begin
  if FFieldName <> AValue then begin
    TFDTextFields(Collection).CheckFieldName(Self, AValue);
    FFieldName := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTextField.GetDisplayName: string;
begin
  Result := FieldName;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextField.Assign(ASource: TPersistent);
begin
  if ASource is TFDTextField then begin
    DataType := TFDTextField(ASource).DataType;
    FieldName := TFDTextField(ASource).FieldName;
    FieldSize := TFDTextField(ASource).FieldSize;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextField.AssignTo(ADest: TPersistent);
var
  oFld: TFieldDef;
begin
  if ADest is TFieldDef then begin
    oFld := ADest as TFieldDef;
    oFld.Name := FieldName;
    if oFld.Name = '' then
      oFld.Attributes := oFld.Attributes + [faUnNamed];
    case DataType of
    atOther,
    atString:
      begin
        if TFDTextFields(Collection).FDef.Driver.Encoding in [ecUTF8, ecUTF16] then
          oFld.DataType := ftWideString
        else
          oFld.DataType := ftString;
        oFld.Size := FieldSize;
        if oFld.Size = 0 then
          oFld.Size := C_FD_DefStrSize;
      end;
    atFloat:
      begin
        oFld.DataType := ftFloat;
        oFld.Precision := Precision;
      end;
    atNumber:
      oFld.DataType := ftWord;
    atBool:
      oFld.DataType := ftBoolean;
    atLongInt:
      oFld.DataType := ftLargeint;
    atDate:
      oFld.DataType := ftDate;
    atTime:
      oFld.DataType := ftTime;
    atDateTime:
      oFld.DataType := ftDateTime;
    atBlob:
      oFld.DataType := ftBlob;
    atMemo:
      if TFDTextFields(Collection).FDef.Driver.Encoding in [ecUTF8, ecUTF16] then
        oFld.DataType := ftWideMemo
      else
        oFld.DataType := ftMemo;
    end;
  end
  else
    inherited AssignTo(ADest);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextField.Define(const AName: String; ADataType: TFDDataType;
  ASize, APrecision, AScale: Integer);
begin
  case ADataType of
  dtBoolean:
    begin
      DataType := atBool;
      FieldSize := 1;
    end;
  dtSByte:
    begin
      DataType := atNumber;
      FieldSize := 4;
    end;
  dtByte:
    begin
      DataType := atNumber;
      FieldSize := 3;
    end;
  dtInt16:
    begin
      DataType := atNumber;
      FieldSize := 6;
    end;
  dtUInt16:
    begin
      DataType := atNumber;
      FieldSize := 5;
    end;
  dtInt32:
    begin
      DataType := atLongInt;
      FieldSize := 11;
    end;
  dtUInt32:
    begin
      DataType := atLongInt;
      FieldSize := 10;
    end;
  dtInt64:
    begin
      DataType := atLongInt;
      FieldSize := 21;
    end;
  dtUInt64:
    begin
      DataType := atLongInt;
      FieldSize := 20;
    end;
  dtSingle:
    begin
      DataType := atFloat;
      Precision := APrecision;
      if Precision > 0 then
        FieldSize := Precision + 2
      else
        FieldSize := 9;
    end;
  dtDouble:
    begin
      DataType := atFloat;
      Precision := APrecision;
      if Precision > 0 then
        FieldSize := Precision + 2
      else
        FieldSize := 18;
    end;
  dtExtended:
    begin
      DataType := atFloat;
      Precision := APrecision;
      if Precision > 0 then
        FieldSize := Precision + 2
      else
        FieldSize := 21;
    end;
  dtCurrency:
    begin
      DataType := atFloat;
      Precision := APrecision;
      if Precision > 0 then
        FieldSize := Precision + 2
      else
        FieldSize := 22;
    end;
  dtBCD:
    begin
      DataType := atFloat;
      Precision := APrecision;
      if Precision > 0 then
        FieldSize := Precision + 2
      else
        FieldSize := 18;
    end;
  dtFMTBcd:
    begin
      DataType := atFloat;
      Precision := APrecision;
      if Precision > 0 then
        FieldSize := Precision + 2
      else
        FieldSize := 38;
    end;
  dtDate:
    begin
      DataType := atDate;
      FieldSize := 16;
    end;
  dtTime:
    begin
      DataType := atTime;
      FieldSize := 11;
    end;
  dtDateTimeStamp,
  dtDateTime:
    begin
      DataType := atDateTime;
      FieldSize := 27;
    end;
  dtTimeIntervalFull,
  dtTimeIntervalYM,
  dtTimeIntervalDS:
    begin
      DataType := atString;
      FieldSize := 35;
    end;
  dtAnsiString,
  dtWideString:
    begin
      DataType := atString;
      FieldSize := ASize;
    end;
  dtByteString:
    begin
      DataType := atBlob;
      FieldSize := ASize;
    end;
  dtBlob,
  dtHBlob,
  dtHBFile:
    begin
      DataType := atBlob;
      FieldSize := -1;
    end;
  dtMemo,
  dtWideMemo,
  dtHMemo,
  dtWideHMemo,
  dtXML:
    begin
      DataType := atMemo;
      FieldSize := -1;
    end;
  dtGUID:
    begin
      DataType := atString;
      FieldSize := 38;
    end;
  else
    DataType := atOther;
    FieldSize := 100;
  end;
  FieldName := AName;
end;

{-------------------------------------------------------------------------------}
{ TFDTextFields                                                                 }
{-------------------------------------------------------------------------------}
constructor TFDTextFields.Create(ADef: TFDTextDataDef);
begin
  inherited Create(TFDTextField);
  FDef := ADef;
end;

{-------------------------------------------------------------------------------}
function TFDTextFields.GetItem(AIndex: Integer): TFDTextField;
begin
  Result := TFDTextField(inherited GetItem(AIndex));
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFields.SetItem(AIndex: Integer; const AValue: TFDTextField);
begin
  inherited SetItem(AIndex, AValue);
end;

{-------------------------------------------------------------------------------}
function TFDTextFields.GetOwner: TPersistent;
begin
  Result := FDef;
end;

{-------------------------------------------------------------------------------}
function TFDTextFields.Add: TFDTextField;
begin
  Result := TFDTextField(inherited Add);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFields.AddAll;
var
  i: Integer;
  oDrv: IFDBatchMoveDriver;
  eType: TFDDataType;
  iSize: LongWord;
  iPrec, iScale: Integer;
  lInKey, lIsIdentity: Boolean;
begin
  if FDef.Driver.BatchMove.Reader.FieldCount > 0 then
    oDrv := FDef.Driver.BatchMove.Reader
  else if FDef.Driver.BatchMove.Writer.FieldCount > 0 then
    oDrv := FDef.Driver.BatchMove.Writer
  else
    Exit;
  Clear;
  for i := 0 to oDrv.FieldCount - 1 do begin
    oDrv.GetFieldInfo(i, eType, iSize, iPrec, iScale, lInKey, lIsIdentity);
    Add.Define(oDrv.FieldNames[i], eType, iSize, iPrec, iScale);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTextFields.FindField(const AName: String): TFDTextField;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if AnsiCompareText(AName, Items[i].FieldName) = 0 then begin
      Result := Items[i];
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDTextFields.FieldByName(const AName: String): TFDTextField;
begin
  Result := FindField(AName);
  if Result = nil then
    FDException(FDef.Driver.BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPNoTxtFld, [AName]);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFields.CheckFieldName(AField: TFDTextField; const ANewName: String);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if (Items[i] <> AField) and (AnsiCompareText(Items[i].FieldName, ANewName) = 0) then
      FDException(FDef.Driver.BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPTxtFldDup, [ANewName]);
end;

{-------------------------------------------------------------------------------}
{ TFDTextFormatSettings                                                         }
{-------------------------------------------------------------------------------}
constructor TFDTextFormatSettings.Create(ADef: TFDTextDataDef);
begin
  inherited Create;
  FDataDef := ADef;
  FFS := TFormatSettings.Create;
  FValues := [];
  FBoolFalseVals := TFDStringList.Create;
  FBoolTrueVals := TFDStringList.Create;
  FNullVals := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDTextFormatSettings.Destroy;
begin
  FDFreeAndNil(FBoolFalseVals);
  FDFreeAndNil(FBoolTrueVals);
  FDFreeAndNil(FNullVals);
  FDataDef := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetOwner: TPersistent;
begin
  Result := FDataDef;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetCurrencyDecimals: Byte;
begin
  Result := FFS.CurrencyDecimals;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetCurrencyFormat: Byte;
begin
  Result := FFS.CurrencyFormat;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetCurrencyString: string;
begin
  Result := FFS.CurrencyString;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetDateSeparator: Char;
begin
  Result := FFS.DateSeparator;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetDecimalSeparator: Char;
begin
  Result := FFS.DecimalSeparator;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetNegCurrFormat: Byte;
begin
  Result := FFS.NegCurrFormat;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetShortDateFormat: string;
begin
  Result := FFS.ShortDateFormat;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetShortTimeFormat: string;
begin
  Result := FFS.ShortTimeFormat;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetThousandSeparator: Char;
begin
  Result := FFS.ThousandSeparator;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetTimeAMString: string;
begin
  Result := FFS.TimeAMString;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetTimePMString: string;
begin
  Result := FFS.TimePMString;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetTimeSeparator: Char;
begin
  Result := FFS.TimeSeparator;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.GetTwoDigitYearCenturyWindow: Word;
begin
  Result := FFS.TwoDigitYearCenturyWindow;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.Assign(ASource: TPersistent);
begin
  if ASource is TFDTextFormatSettings then begin
    FFS := TFDTextFormatSettings(ASource).FFS;
    FValues := TFDTextFormatSettings(ASource).FValues;
    FBoolFalseVals.SetStrings(TFDTextFormatSettings(ASource).FBoolFalseVals);
    FBoolTrueVals.SetStrings(TFDTextFormatSettings(ASource).FBoolTrueVals);
    FNullVals.SetStrings(TFDTextFormatSettings(ASource).FNullVals);
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetCurrencyDecimals(const AValue: Byte);
begin
  if FFS.CurrencyDecimals <> AValue then begin
    FFS.CurrencyDecimals := AValue;
    Include(FValues, fsCurrencyDecimals);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetCurrencyFormat(const AValue: Byte);
begin
  if FFS.CurrencyFormat <> AValue then begin
    FFS.CurrencyFormat := AValue;
    Include(FValues, fsCurrencyFormat);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetCurrencyString(const AValue: string);
begin
  if FFS.CurrencyString <> AValue then begin
    FFS.CurrencyString := AValue;
    Include(FValues, fsCurrencyString);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetDateSeparator(const AValue: Char);
begin
  if FFS.DateSeparator <> AValue then begin
    FFS.DateSeparator := AValue;
    Include(FValues, fsDateSeparator);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetDecimalSeparator(const AValue: Char);
begin
  if FFS.DecimalSeparator <> AValue then begin
    FFS.DecimalSeparator := AValue;
    Include(FValues, fsDecimalSeparator);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetNegCurrFormat(const AValue: Byte);
begin
  if FFS.NegCurrFormat <> AValue then begin
    FFS.NegCurrFormat := AValue;
    Include(FValues, fsNegCurrFormat);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetShortDateFormat(const AValue: string);
begin
  if FFS.ShortDateFormat <> AValue then begin
    FFS.ShortDateFormat := AValue;
    FFS.LongDateFormat := AValue;
    Include(FValues, fsShortDateFormat);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetShortTimeFormat(const AValue: string);
begin
  if FFS.ShortTimeFormat <> AValue then begin
    FFS.ShortTimeFormat := AValue;
    FFS.LongTimeFormat := AValue;
    Include(FValues, fsShortTimeFormat);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetThousandSeparator(const AValue: Char);
begin
  if FFS.ThousandSeparator <> AValue then begin
    FFS.ThousandSeparator := AValue;
    Include(FValues, fsThousandSeparator);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetTimeAMString(const AValue: string);
begin
  if FFS.TimeAMString <> AValue then begin
    FFS.TimeAMString := AValue;
    Include(FValues, fsTimeAMString);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetTimePMString(const AValue: string);
begin
  if FFS.TimePMString <> AValue then begin
    FFS.TimePMString := AValue;
    Include(FValues, fsTimePMString);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetTimeSeparator(const AValue: Char);
begin
  if FFS.TimeSeparator <> AValue then begin
    FFS.TimeSeparator := AValue;
    Include(FValues, fsTimeSeparator);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetTwoDigitYearCenturyWindow(
  const AValue: Word);
begin
  if FFS.TwoDigitYearCenturyWindow <> AValue then begin
    FFS.TwoDigitYearCenturyWindow := AValue;
    Include(FValues, fsTwoDigitYearCenturyWindow);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsCDS: Boolean;
begin
  Result := fsCurrencyDecimals in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsCFS: Boolean;
begin
  Result := fsCurrencyFormat in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsCSS: Boolean;
begin
  Result := fsCurrencyString in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsDSS: Boolean;
begin
  Result := fsDecimalSeparator in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsDTSS: Boolean;
begin
  Result := fsDateSeparator in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsNCFS: Boolean;
begin
  Result := fsNegCurrFormat in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsSDFS: Boolean;
begin
  Result := fsShortDateFormat in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsSTFS: Boolean;
begin
  Result := fsShortTimeFormat in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsTAMSS: Boolean;
begin
  Result := fsTimeAMString in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsTDYCWS: Boolean;
begin
  Result := fsTwoDigitYearCenturyWindow in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsTMSS: Boolean;
begin
  Result := fsTimeSeparator in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsTPMSS: Boolean;
begin
  Result := fsTimePMString in FValues;
end;

{-------------------------------------------------------------------------------}
function TFDTextFormatSettings.IsTSS: Boolean;
begin
  Result := fsThousandSeparator in FValues;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetBoolFalseVals(const AValue: TStrings);
begin
  FBoolFalseVals.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetBoolTrueVals(const AValue: TStrings);
begin
  FBoolTrueVals.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFormatSettings.SetNullVals(const AValue: TStrings);
begin
  FNullVals.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
{ TFDTextDataDef                                                                }
{-------------------------------------------------------------------------------}
constructor TFDTextDataDef.Create(ADriver: TFDBatchMoveTextDriver);
begin
  inherited Create;
  FDriver := ADriver;
  FFields := TFDTextFields.Create(Self);
  FDelimiter := #34;
  FSeparator := #44;
  FRecordFormat := rfCommaDoubleQuote;
  FRecordDelimiter := elDefault;
  FWithFieldNames := False;
  FStrsEmpty2Null := True;
  FTrimLeft := True;
  FTrimRight := True;
  FFormatSettings := TFDTextFormatSettings.Create(Self);
end;

{-------------------------------------------------------------------------------}
destructor TFDTextDataDef.Destroy;
begin
  FDFreeAndNil(FFields);
  FDFreeAndNil(FFormatSettings);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDTextDataDef.GetOwner: TPersistent;
begin
  Result := Driver;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextDataDef.Assign(ASource: TPersistent);
begin
  if ASource is TFDTextDataDef then begin
    EndOfLine := TFDTextDataDef(ASource).EndOfLine;
    Delimiter := TFDTextDataDef(ASource).Delimiter;
    Separator := TFDTextDataDef(ASource).Separator;
    RecordFormat := TFDTextDataDef(ASource).RecordFormat;
    Fields := TFDTextDataDef(ASource).Fields;
    WithFieldNames := TFDTextDataDef(ASource).WithFieldNames;
    StrsEmpty2Null := TFDTextDataDef(ASource).StrsEmpty2Null;
    TrimLeft := TFDTextDataDef(ASource).TrimLeft;
    TrimRight := TFDTextDataDef(ASource).TrimRight;
    FormatSettings.Assign(TFDTextDataDef(ASource).FormatSettings);
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextDataDef.SetFields(const AValue: TFDTextFields);
begin
  FFields.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextDataDef.SetDelimiter(AValue: Char);
begin
  if FDelimiter <> AValue then begin
    RecordFormat := rfCustom;
    FDelimiter := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextDataDef.SetSeparator(AValue: Char);
begin
  if FSeparator <> AValue then begin
    RecordFormat := rfCustom;
    FSeparator := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextDataDef.SetRecordFormat(AValue: TFDTextRecordFormat);
begin
  if FRecordFormat <> AValue then begin
    FRecordFormat := AValue;
    case AValue of
    rfCommaDoubleQuote:
      begin
        FDelimiter := #34;
        FSeparator := #44;
      end;
    rfSemicolonDoubleQuote:
      begin
        FDelimiter := #34;
        FSeparator := #59;
      end;
    rfTabDoubleQuote:
      begin
        FDelimiter := #34;
        FSeparator := #9;
      end;
    rfFixedLength:
      begin
        FDelimiter := #34;
        FSeparator := #0;
        FWithFieldNames := False;
      end;
    rfFieldPerLine:
      begin
        FDelimiter := #0;
        FSeparator := #0;
        FWithFieldNames := False;
      end;
    else
      FDelimiter := #34;
      FSeparator := #59;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTextDataDef.IsADDS: Boolean;
begin
  Result := (FRecordFormat = rfCustom);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextDataDef.SetWithFieldNames(const AValue: Boolean);
begin
  if FWithFieldNames <> AValue then begin
    FWithFieldNames := AValue;
    if FWithFieldNames and (RecordFormat in [rfFixedLength, rfFieldPerLine]) then
      RecordFormat := rfCommaDoubleQuote;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextDataDef.SetFormatSettings(const AValue: TFDTextFormatSettings);
begin
  FFormatSettings.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveTextDriver                                                        }
{-------------------------------------------------------------------------------}
constructor TFDBatchMoveTextDriver.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFileName := '';
  FEncoding := ecDefault;
  FDataDef := TFDTextDataDef.Create(Self);
end;

{-------------------------------------------------------------------------------}
destructor TFDBatchMoveTextDriver.Destroy;
begin
  FDFreeAndNil(FDataDef);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextDriver.SetDataDef(const AValue: TFDTextDataDef);
begin
  FDataDef.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.GetActualFileName: String;
begin
  Result := FDExpandStr(Trim(FileName));
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.CheckDefined(ARaise: Boolean): Boolean;
var
  iErr: Integer;
begin
  Result := (ActualFileName <> '') or (Stream <> nil);
  if not Result and ARaise then begin
    if Self is TFDBatchMoveTextReader then
      iErr := er_FD_DPNoTxtSrc
    else
      iErr := er_FD_DPNoTxtDest;
    FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], iErr, []);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextDriver.Close(AStopTxError: Boolean);
begin
  FDFree(FText);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextDriver.Refresh;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextDriver.AbortJob;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.AddAutoFields: Boolean;
begin
  Result := DataDef.Fields.Count = 0;
  if Result then
    DataDef.Fields.AddAll;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextDriver.DeleteAutoFields;
begin
  DataDef.Fields.Clear;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.GetCatalog: String;
begin
  Result := ActualFileName;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.GetIsUnicode: Boolean;
begin
  Result := Encoding in [ecUTF8, ecUTF16 {$IFDEF POSIX}, ecDefault {$ENDIF}];
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.GetIsOpen: Boolean;
begin
  Result := FText <> nil;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.GetFieldCount: Integer;
begin
  Result := DataDef.Fields.Count;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.GetFieldName(AIndex: Integer): String;
begin
  Result := DataDef.Fields[AIndex].FieldName;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.GetFieldIndex(const AName: String; ACheck: Boolean): Integer;
var
  oField: TFDTextField;
begin
  if ACheck then
    Result := DataDef.Fields.FieldByName(AName).Index
  else begin
    oField := DataDef.Fields.FindField(AName);
    if oField <> nil then
      Result := oField.Index
    else
      Result := -1;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextDriver.GetFieldInfo(AIndex: Integer; var AType: TFDDataType;
  var ASize: LongWord; var APrec, AScale: Integer; var AInKey, AIsIdentity: Boolean): TObject;
const
  TDT2DT: array[TFDTextDataType] of TFDDataType = (dtAnsiString, dtAnsiString,
    dtDouble, dtFmtBCD, dtBoolean, dtInt32, dtDate, dtTime, dtDateTime, dtBlob, dtMemo);
var
  oField: TFDTextField;
begin
  oField := DataDef.Fields[AIndex];
  AType := TDT2DT[oField.DataType];
  if oField.FieldSize < 0 then
    ASize := 0
  else
    ASize := oField.FieldSize;
  APrec := oField.Precision;
  AScale := 0;
  AInKey := False;
  AIsIdentity := False;
  Result := oField;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextDriver.GetTableDefs(AFieldDefs: TFieldDefs; AIndexDefs: TIndexDefs);
var
  i: Integer;
begin
  AFieldDefs.Clear;
  for i := 0 to DataDef.Fields.Count - 1 do
    AFieldDefs.AddFieldDef.Assign(DataDef.Fields[i]);
  AIndexDefs.Clear;
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveTextReader                                                        }
{-------------------------------------------------------------------------------}
function TFDBatchMoveTextReader.CheckDefined(ARaise: Boolean): Boolean;
begin
  Result := inherited CheckDefined(ARaise);
  if Result then begin
    Result := (DataDef.Fields.Count <> 0) or (taFields in BatchMove.Analyze) or
      (BatchMove.Writer <> nil) and (
        not (BatchMove.Writer is TFDBatchMoveTextWriter) and BatchMove.Writer.CheckDefined(False) or
        (BatchMove.Writer is TFDBatchMoveTextWriter) and (BatchMove.Writer.FieldCount > 0));
    if not Result and ARaise then
      FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPNoTxtFlds, []);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextReader.GetSourceTableName: String;
begin
  Result := FDExtractFileNameNoPath(FileName);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextReader.TrimText(const AStr: String; AHeader: Boolean): String;
begin
  if not ((Length(AStr) <> 0) and ((AStr[Length(AStr)] <= ' ') or (AStr[1] <= ' '))) then
    Result := AStr
  else if AHeader or DataDef.TrimLeft and DataDef.TrimRight then
    Result := Trim(AStr)
  else begin
    Result := AStr;
    if DataDef.TrimLeft then
      Result := TrimLeft(Result);
    if DataDef.TrimRight then
      Result := TrimRight(Result);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextReader.GuessFormat(AText: TFDTextFile; AAnalyze: TFDBatchMoveAnalyze);
var
  sLine1, sLine2, sItem: String;
  i, j, n, iLen: Integer;
  iBmk: Int64;
  rFmt: TFDParseFmtSettings;
  lFieldNames, lAllStrings, lFieldNamesUC: Boolean;
  oField: TFDTextField;
  eType: TFDTextDataType;

  function Unquote(const AStr: String; AHeader: Boolean): String;
  begin
    Result := TrimText(AStr, AHeader);
    if (Result <> '') and (Result[1] = rFmt.FQuote) and (Result[Length(Result)] = rFmt.FQuote) then
      Result := Copy(Result, 2, Length(Result) - 2);
  end;

  function CheckSet(const AStr: String; ASet1, ASet2: TFDCharSet): Boolean;
  var
    i: Integer;
  begin
    Result := FDInSet(AStr[1], ASet1);
    if Result then
      for i := 2 to Length(AStr) do begin
        if not FDInSet(AStr[i], ASet2) then begin
          Result := False;
          Exit;
        end;
      end;
  end;

  function GetType(AItem: String; AHeader: Boolean): TFDTextDataType;
  var
    iVal: Int64;
    eVal: Extended;
    dtVal: TDateTime;
  begin
    AItem := UpperCase(Unquote(AItem, AHeader));
    if (AItem = '') or (DataDef.FormatSettings.NullVals.IndexOf(AItem) >= 0) then
      Result := atOther
    else if CheckSet(AItem, ['0'..'9', '+', '-'], ['0'..'9']) and
            TryStrToInt64(AItem, iVal) then
      Result := atLongInt
    else if CheckSet(AItem, ['0'..'9', '+', '-', DataDef.FormatSettings.DecimalSeparator],
                            ['0'..'9', DataDef.FormatSettings.DecimalSeparator]) and
            TryStrToFloat(AItem, eVal, DataDef.FormatSettings.FS) then
      Result := atFloat
    else if CheckSet(AItem, ['0'..'9'], ['0'..'9', DataDef.FormatSettings.DateSeparator]) or
            TryStrToDate(AItem, dtVal, DataDef.FormatSettings.FS) then
      Result := atDate
    else if CheckSet(AItem, ['0'..'9'], ['0'..'9', DataDef.FormatSettings.TimeSeparator]) or
            TryStrToTime(AItem, dtVal, DataDef.FormatSettings.FS) then
      Result := atTime
    else if CheckSet(AItem, ['0'..'9'], ['0'..'9', DataDef.FormatSettings.DateSeparator,
                                         DataDef.FormatSettings.TimeSeparator, ' ']) or
            TryStrToDateTime(AItem, dtVal, DataDef.FormatSettings.FS) then
      Result := atDateTime
    else if AHeader and CheckSet(AItem, ['A'..'Z', '_'], ['A'..'Z', '0'..'9', '_', '#', '$']) then
      Result := atString
    else if (Length(AItem) >= 32) and CheckSet(AItem, ['0'..'9', 'A'..'F'], ['0'..'9', 'A'..'F']) then
      Result := atBlob
    else if (DataDef.FormatSettings.BoolTrueVals.IndexOf(AItem) >= 0) or
            (DataDef.FormatSettings.BoolFalseVals.IndexOf(AItem) >= 0) or
            (AItem = 'T') or (AItem = 'F') or (AItem = 'TRUE') or (AItem = 'FALSE') or
            (AItem = 'Y') or (AItem = 'N') or (AItem = 'YES') or (AItem = 'NO') then
      Result := atBool
    else
      Result := atString;
  end;

begin
  sLine1 := AText.ReadLine;
  // Simple guessing
  if taDelimSep in AAnalyze then begin
    DataDef.RecordFormat := rfCustom;
    if Pos(#9, sLine1) <> 0 then
      DataDef.Separator := #9
    else if Pos(';', sLine1) <> 0 then
      DataDef.Separator := ';'
    else if Pos(',', sLine1) <> 0 then
      DataDef.Separator := ',';
    DataDef.Delimiter := '"';
  end;
  // No guessing
  if taFormatSet in AAnalyze then begin
    DataDef.FormatSettings.DecimalSeparator := '.';
    DataDef.FormatSettings.DateSeparator := '-';
    DataDef.FormatSettings.ShortDateFormat := 'yyyy/MM/dd';
    DataDef.FormatSettings.TimeSeparator := ':';
    DataDef.FormatSettings.ShortTimeFormat := 'HH:mm:ss';
  end;
  rFmt.FDelimiter := DataDef.Separator;
  rFmt.FQuote := DataDef.Delimiter;
  rFmt.FQuote1 := #0;
  rFmt.FQuote2 := #0;

  // taFields without taHeader rather will fail when a text file contains
  // top line with field names. So, force scanning for top line with field
  // names when only taFields specified.
  if [taHeader, taFields] * AAnalyze <> [] then begin
    lFieldNames := True;
    lAllStrings := True;
    lFieldNamesUC := True;
    i := 1;
    while i <= Length(sLine1) do begin
      sItem := Trim(FDExtractFieldName(sLine1, i, rFmt));
      // Check that first line contains only atString values
      if (sItem = '') or (GetType(sItem, True) <> atString) then begin
        lFieldNames := False;
        Break;
      end;
      // When a value is upper-cased, this is a "good" sign, that
      // the value is field name
      if not CheckSet(sItem, ['A'..'Z', '_'], ['A'..'Z', '0'..'9', '_', '#', '$']) then
        lFieldNamesUC := False;
    end;
    // When next AnalyzeSample lines contain only atString values, then
    // probably first line contains also string values and not field names
    if lFieldNames then begin
      iBmk := AText.Stream.Position;
      for j := 1 to BatchMove.AnalyzeSample do begin
        sLine2 := AText.ReadLine;
        if sLine2 = '' then
          Break;
        i := 1;
        while i <= Length(sLine2) do begin
          sItem := Trim(FDExtractFieldName(sLine2, i, rFmt));
          if not (GetType(sItem, False) in [atOther, atString]) then begin
            lAllStrings := False;
            Break;
          end;
        end;
        if not lAllStrings then
          Break;
      end;
      AText.Stream.Position := iBmk;
    end;
    // Final guess about first line
    DataDef.WithFieldNames := lFieldNames and (not lAllStrings or lFieldNamesUC);
  end;

  if taFields in AAnalyze then begin
    DataDef.Fields.Clear;
    if DataDef.WithFieldNames then begin
      i := 1;
      while i <= Length(sLine1) do
        DataDef.Fields.Add.FieldName := Unquote(FDExtractFieldName(sLine1, i, rFmt), True);
      sLine2 := AText.ReadLine;
    end
    else
      sLine2 := sLine1;
    n := 0;
    repeat
      i := 1;
      j := 0;
      while i <= Length(sLine2) do begin
        sItem := FDExtractFieldName(sLine2, i, rFmt);
        if (n = 0) and not DataDef.WithFieldNames then
          oField := DataDef.Fields.Add
        else
          oField := DataDef.Fields[j];
        Inc(j);
        eType := GetType(sItem, False);
        if eType <> atOther then begin
          case oField.DataType of
          atLongInt:
            if eType = atFloat then
              oField.DataType := atFloat
            else if eType <> atLongInt then
              oField.DataType := atMemo;
          atFloat:
            if not (eType in [atLongInt, atFloat]) then
              oField.DataType := atMemo;
          atDate,
          atTime:
            if eType = atDateTime then
              oField.DataType := eType
            else if not (eType in [atDate, atTime]) then
              oField.DataType := atMemo;
          atDateTime:
            if not (eType in [atDate, atTime, atDateTime]) then
              oField.DataType := atMemo;
          atBool:
            if eType <> atBool then
              oField.DataType := atMemo;
          atString:
            ;
          atOther:
            oField.DataType := eType;
          end;
          iLen := Length(Unquote(sItem, False));
          if iLen > oField.FieldSize then
            oField.FieldSize := iLen;
        end;
      end;
      if n < BatchMove.AnalyzeSample then
        sLine2 := AText.ReadLine;
      Inc(n);
    until (sLine2 = '') or (n = BatchMove.AnalyzeSample);
    for i := 0 to DataDef.Fields.Count - 1 do begin
      oField := DataDef.Fields[i];
      if oField.DataType = atMemo then
        oField.DataType := atString;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextReader.GuessFormat(
  AAnalyze: TFDBatchMoveAnalyze = [taDelimSep, taHeader, taFields]);
var
  oText: TFDTextFile;
  iBmk: Int64;
begin
  if Stream <> nil then begin
    iBmk := Stream.Position;
    oText := TFDTextFile.Create(Stream, False, True, False, Encoding, DataDef.EndOfLine);
  end
  else begin
    iBmk := -1;
    oText := TFDTextFile.Create(ActualFileName, True, False, Encoding, DataDef.EndOfLine);
  end;
  try
    GuessFormat(oText, AAnalyze);
  finally
    if Stream <> nil then
      Stream.Position := iBmk;
    FDFree(oText);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextReader.Open(AStartTx: Boolean);
var
  i: Integer;
begin
  FEof := False;
  SetLength(FBuff, 1024);
  if Stream <> nil then
    FText := TFDTextFile.Create(Stream, False, True, False, Encoding, DataDef.EndOfLine)
  else
    FText := TFDTextFile.Create(ActualFileName, True, False, Encoding, DataDef.EndOfLine);
  if BatchMove.Analyze <> [] then begin
    GuessFormat(FText, BatchMove.Analyze);
    FText.Stream.Position := 0;
    if DataDef.Fields.Count = 0 then
      FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPNoTxtFlds, []);
  end;
  if DataDef.RecordFormat = rfFixedLength then
    for i := 0 to DataDef.Fields.Count - 1 do
      if DataDef.Fields[i].FieldSize < 0 then
        FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPBadFixedSize,
          [DataDef.Fields[i].FieldName]);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextReader.ReadHeader;
begin
  if DataDef.WithFieldNames then begin
    repeat
      FEof := not FText.ReadChar(FBuff[0]);
    until FEof or (FBuff[0] = #13) or (FBuff[0] = #10);
    repeat
      FEof := not FText.ReadChar(FBuff[0]);
    until FEof or not ((FBuff[0] = #13) or (FBuff[0] = #10));
    if not FEof then
      FText.Stream.Position := FText.Stream.Position - 1;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextReader.Eof: Boolean;
begin
  Result := FEof;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextReader.ReadRecord;
var
  lEOL: Boolean;
  i: Integer;
  oFld: TFDTextField;
  iLen: Integer;
  lInDelim: Boolean;
  iFrom: Integer;
  iTo: Integer;
  sVal: String;

  procedure NextChar;
  begin
    Inc(iLen);
    if iLen >= Length(FBuff) then
      SetLength(FBuff, iLen + iLen div 2);
    FEof := not FText.ReadChar(FBuff[iLen]);
  end;

  function StrAndBoolToInt(const AStr: String): Variant;
  begin
    if FDInSet(AStr[1], ['T', 't', 'Y', 'y']) then
      Result := 1
    else if FDInSet(AStr[1], ['F', 'f', 'N', 'n']) then
      Result := 0
    else if Length(AStr) >= 10 then
      Result := StrToInt64(AStr)
    else
      Result := StrToInt(AStr);
  end;

  function StrAndBoolToFloat(const AStr: String; const AFS: TFormatSettings): Extended;
  begin
    if FDInSet(AStr[1], ['T', 't', 'Y', 'y']) then
      Result := 1.0
    else if FDInSet(AStr[1], ['F', 'f', 'N', 'n']) then
      Result := 0.0
    else
      Result := FDStr2Float(AStr, AFS.DecimalSeparator);
  end;

  function CheckDateNotEmpty(const AStr: String): Boolean;
  var
    pCh: PChar;
    oFS: TFDTextFormatSettings;
  begin
    pCh := PChar(AStr);
    oFS := DataDef.FormatSettings;
    while pCh^ <> #0 do
      if not ((pCh^ = ' ') or (pCh^ = '0') or (pCh^ = oFS.DateSeparator) or (pCh^ = oFS.TimeSeparator)) then
        Break
      else
        Inc(pCh);
    Result := pCh^ <> #0;
  end;

  procedure SetStr(ATxtFld: TFDTextField; const AStr: String);
  var
    i: Integer;
    oItem: TFDBatchMoveMappingItem;
    S: String;
  begin
    for i := 0 to BatchMove.Mappings.Count - 1 do begin
      oItem := BatchMove.Mappings[i];
      if oItem.SourceFieldObj = ATxtFld then begin
                                                                  
        S := TrimText(AStr, False);
        if (S = '') and ((oFld.DataType <> atString) or DataDef.StrsEmpty2Null) or
           (DataDef.FormatSettings.NullVals.IndexOf(S) >= 0) then
          oItem.SourceValue := Null
        else
          try
            case oFld.DataType of
            atOther,
            atString:
              oItem.SourceValue := S;
            atFloat:
              oItem.SourceValue := StrAndBoolToFloat(S, DataDef.FormatSettings.FS);
            atNumber:
              oItem.SourceValue := StrAndBoolToInt(S);
            atBool:
              if DataDef.FormatSettings.BoolTrueVals.IndexOf(S) >= 0 then
                oItem.SourceValue := True
              else if DataDef.FormatSettings.BoolFalseVals.IndexOf(S) >= 0 then
                oItem.SourceValue := False
              else
                oItem.SourceValue := StrAndBoolToInt(S) <> 0;
            atLongInt:
              oItem.SourceValue := StrAndBoolToInt(S);
            atDate:
              if CheckDateNotEmpty(S) then
                oItem.SourceValue := StrToDate(S, DataDef.FormatSettings.FS)
              else
                oItem.SourceValue := Null;
            atTime:
              if CheckDateNotEmpty(S) then
                oItem.SourceValue := StrToTime(S, DataDef.FormatSettings.FS)
              else
                oItem.SourceValue := Null;
            atDateTime:
              if CheckDateNotEmpty(S) then
                oItem.SourceValue := StrToDateTime(S, DataDef.FormatSettings.FS)
              else
                oItem.SourceValue := Null;
            atBlob:
              oItem.SourceValue := FDHex2Bin(S);
            atMemo:
              oItem.SourceValue := S;
            end;
          except
            on E: EConvertError do
              FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPBadTextFmt,
                [AStr, oItem.DisplayName, E.Message]);
          end;
        Break;
      end;
    end;
  end;

  procedure UnDoubleChar(ACh: Char; var AStr: String);
  var
    j: Integer;
  begin
    j := 1;
    repeat
      j := Pos(ACh, AStr, j);
      if j > 0 then begin
        if (j < Length(AStr)) and (AStr[j + 1] = ACh) then
          Delete(AStr, j, 1);
        Inc(j, 1);
      end;
    until j = 0;
  end;

begin
  lEOL := False;
  for i := 0 to DataDef.Fields.Count - 1 do begin
    oFld := DataDef.Fields[i];
    iLen := -1;

    if not FEof and not lEOL then
      case DataDef.RecordFormat of
      rfFixedLength:
        begin
          iLen := oFld.FieldSize;
          if Length(FBuff) < iLen then
            SetLength(FBuff, iLen);
          FEof := FText.ReadChars(FBuff[0], iLen) = 0;
          if not FEof then
            Dec(iLen);
        end;
      rfFieldPerLine:
        begin
          repeat
            NextChar;
          until FEof or ((FBuff[iLen] = #13) or (FBuff[iLen] = #10));
          if not FEof then begin
            if (DataDef.EndOfLine in [elWindows {$IFDEF MSWINDOWS}, elDefault {$ENDIF}]) and
               (FBuff[iLen] = #13) then
              FEof := not FText.ReadChar(FBuff[iLen]);
            Dec(iLen);
          end;
        end;
      else
        iLen := -1;
        lInDelim := False;
        repeat
          NextChar;
          if not FEof and (FBuff[iLen] = DataDef.Delimiter) then
            if iLen = 0 then
              lInDelim := not lInDelim
            else begin
              NextChar;
              if not FEof and (FBuff[iLen] <> DataDef.Delimiter) then
                lInDelim := not lInDelim;
            end;
          lEOL := not FEof and not lInDelim and ((FBuff[iLen] = #13) or (FBuff[iLen] = #10));
        until FEof or lEOL or not lInDelim and (FBuff[iLen] = DataDef.Separator);
        if not FEof then
          Dec(iLen);
      end;

    if iLen >= 0 then begin
      iFrom := 0;
      iTo := iLen;
      if (iFrom >= 0) and (iFrom < Length(FBuff)) and (FBuff[iFrom] = DataDef.Delimiter) then
        Inc(iFrom);
      if (iTo >= 0) and (iTo < Length(FBuff)) and (
           (FBuff[iTo] = DataDef.Separator) or (FBuff[iTo] = DataDef.Delimiter)) then
        Dec(iTo);
      SetString(sVal, PChar(FBuff) + iFrom, iTo - iFrom + 1);
      if DataDef.Delimiter <> #0 then
        UnDoubleChar(DataDef.Delimiter, sVal);
      SetStr(oFld, sVal);
    end
    else
      SetStr(oFld, '');
  end;

  if DataDef.RecordFormat <> rfFieldPerLine then begin
    repeat
      FEof := not FText.ReadChar(FBuff[0]);
    until FEof or not ((FBuff[0] = #13) or (FBuff[0] = #10));
    if not FEof then
      FText.Stream.Position := FText.Stream.Position - 1;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextReader.NextRecord;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveTextWriter                                                        }
{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextWriter.Open(AStartTx: Boolean);
begin
  if Stream <> nil then
    FText := TFDTextFile.Create(Stream, False, False,
      [poClearDest, poClearDestNoUndo] * BatchMove.Options = [],
      Encoding, DataDef.EndOfLine)
  else
    FText := TFDTextFile.Create(ActualFileName, False,
      [poClearDest, poClearDestNoUndo] * BatchMove.Options = [],
      Encoding, DataDef.EndOfLine);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextWriter.CreateTable;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextWriter.StartTransaction;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextWriter.CommitTransaction;
begin
  if FText.Stream is TBufferedFileStream then
    TBufferedFileStream(FText.Stream).FlushBuffer;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextWriter.RollbackTransaction;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextWriter.Erase(ANoUndo: Boolean);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveTextWriter.WriteHeader;
var
  i: Integer;
begin
  if DataDef.WithFieldNames then begin
    for i := 0 to DataDef.Fields.Count - 1 do begin
      if i > 0 then
        FText.WriteChar(DataDef.Separator);
      if DataDef.Delimiter <> #0 then
        FText.WriteChar(DataDef.Delimiter);
      FText.WriteText(DataDef.Fields[i].FieldName);
      if DataDef.Delimiter <> #0 then
        FText.WriteChar(DataDef.Delimiter);
    end;
    FText.WriteLine('');
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextWriter.FindRecord: Boolean;
begin
  FDCapabilityNotSupported(BatchMove, [S_FD_LComp, S_FD_LComp_PDM]);
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextWriter.InsertRecord: Integer;
var
  i: Integer;
  oField: TFDTextField;
  sVal: String;
  lNeedDelim: Boolean;

  function GetStr(ATxtFld: TFDTextField): String;
  var
    i: Integer;
    v: Variant;
    oItem: TFDBatchMoveMappingItem;
    sb: TFDByteString;
    iLen: Integer;
    pData: Pointer;
  begin
    Result := '';
    for i := 0 to BatchMove.Mappings.Count - 1 do begin
      oItem := BatchMove.Mappings[i];
      if oItem.DestFieldObj = ATxtFld then begin
        v := oItem.DestValue;
        if VarIsEmpty(v) or VarIsNull(v) then
          if DataDef.FormatSettings.NullVals.Count > 0 then
            Result := DataDef.FormatSettings.NullVals[0]
          else
            Result := ''
        else
                                                        
          case ATxtFld.DataType of
          atOther,
          atString:
            Result := v;
          atFloat:
            Result := FDFloat2Str(v, DataDef.FormatSettings.DecimalSeparator,
              ATxtFld.Precision);
          atNumber:
            Result := v;
          atBool:
            if (v) then
              if DataDef.FormatSettings.BoolTrueVals.Count > 0 then
                Result := DataDef.FormatSettings.BoolTrueVals[0]
              else
                Result := 'T'
            else
              if DataDef.FormatSettings.BoolFalseVals.Count > 0 then
                Result := DataDef.FormatSettings.BoolFalseVals[0]
              else
                Result := 'F';
          atLongInt:
            Result := v;
          atDate:
            Result := DateToStr(v, DataDef.FormatSettings.FS);
          atTime:
            Result := TimeToStr(v, DataDef.FormatSettings.FS);
          atDateTime:
            Result := DateTimeToStr(v, DataDef.FormatSettings.FS);
          atBlob:
            if VarIsArray(v) then begin
              iLen := VarArrayHighBound(v, 1) + 1;
              pData := VarArrayLock(v);
              try
                Result := FDBin2Hex(pData, iLen);
              finally
                VarArrayUnlock(v);
              end;
            end
            else begin
              sb := TFDEncoder.Enco(v, ecANSI);
              Result := FDBin2Hex(PByte(sb), TFDEncoder.EncoLength(sb, ecANSI));
            end;
          atMemo:
            Result := v;
          end;
        Break;
      end;
    end;
  end;

  procedure DoubleChar(ACh: Char; var AStr: String);
  var
    j: Integer;
  begin
    j := 1;
    repeat
      j := Pos(ACh, AStr, j);
      if j > 0 then begin
        Insert(ACh, AStr, j);
        Inc(j, 2);
      end;
    until j = 0;
  end;

  function HasChars(const AStr: String; ASet: TFDCharSet): Boolean;
  var
    pStr: PChar;
  begin
    pStr := PChar(AStr);
    while (pStr^ <> #0) and not FDInSet(pStr^, ASet) do
      Inc(pStr);
    Result := pStr^ <> #0;
  end;

begin
  BatchMove.Mappings.Move(False);
  for i := 0 to DataDef.Fields.Count - 1 do begin
    oField := DataDef.Fields[i];
    sVal := GetStr(oField);
    if DataDef.Delimiter <> #0 then
      DoubleChar(DataDef.Delimiter, sVal);
    lNeedDelim := (oField.DataType in [atMemo, atString, atOther]) or
      (oField.DataType in [atFloat, atNumber, atDate, atTime, atDateTime]) and
      HasChars(sVal, [DataDef.Delimiter, DataDef.Separator, #13, #10, #9]);
    if (DataDef.RecordFormat in [rfCommaDoubleQuote, rfSemicolonDoubleQuote, rfTabDoubleQuote, rfCustom]) and
       lNeedDelim and (DataDef.Delimiter <> #0) then
      FText.WriteChar(DataDef.Delimiter);
    if DataDef.RecordFormat = rfFixedLength then
      if oField.DataType in [atMemo, atString, atOther] then
        sVal := FDPadR(sVal, oField.FieldSize)
      else
        sVal := FDPadL(sVal, oField.FieldSize);
    if Length(sVal) > 0 then
      FText.WriteText(sVal);
    if (DataDef.RecordFormat in [rfCommaDoubleQuote, rfSemicolonDoubleQuote, rfTabDoubleQuote, rfCustom]) then begin
      if lNeedDelim and (DataDef.Delimiter <> #0) then
        FText.WriteChar(DataDef.Delimiter);
      if i < DataDef.Fields.Count - 1 then
        if DataDef.Separator <> #0 then
          FText.WriteChar(DataDef.Separator);
    end;
    if DataDef.RecordFormat = rfFieldPerLine then
      FText.WriteLine('');
  end;
  if DataDef.RecordFormat <> rfFieldPerLine then
    FText.WriteLine('');
  Result := 1;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextWriter.UpdateRecord: Integer;
begin
  FDCapabilityNotSupported(BatchMove, [S_FD_LComp, S_FD_LComp_PDM]);
  Result := 0;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextWriter.DeleteRecord: Integer;
begin
  FDCapabilityNotSupported(BatchMove, [S_FD_LComp, S_FD_LComp_PDM]);
  Result := 0;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveTextWriter.FlushRecords: Integer;
begin
  // nothing
  Result := 0;
end;

end.
