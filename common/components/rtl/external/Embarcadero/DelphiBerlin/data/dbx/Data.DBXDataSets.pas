{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Data.DBXDataSets;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Data.DBCommon,
  Data.DBCommonTypes,
  Data.DBXCommon,
  System.Generics.Collections
;

type
  TDBXReaderDataSet = class(TDataSet)
  public const
    SOrderBy        =   ' order by ';           { Do not localize }
    SParam          =   '?';                    { Do not localize }
    DefaultMaxBlobSize = -1;   // values are in K; -1 means retrieve actual size
    // maps the TDBXDataTypes into FldTypeMap
    DataTypeMap: array[0..TDBXDataTypes.MaxBaseTypes - 1] of TFieldType = (
      ftUnknown, ftString, ftDate, ftBlob, ftBoolean, ftSmallint,
      ftInteger, ftFloat, ftFMTBCD, ftBytes, ftTime, ftDateTime,
      ftWord, ftInteger, ftUnknown, ftVarBytes, ftUnknown, ftCursor,
      ftLargeInt, ftLargeInt, ftADT, ftArray, ftReference, ftDataSet,
      ftTimeStamp, ftBCD, ftWideString, ftSingle, ftShortint, ftByte, ftUnknown,
      ftUnknown, ftUnknown, ftUnknown, ftUnknown, ftVariant, ftTimeStampOffset, ftObject,
      ftObject);
    SUB_TYPE_MEMO = TDBXDataTypes.MemoSubType;

    BlobTypeMap: array[SUB_TYPE_MEMO..TDBXDataTypes.BFileSubType] of TFieldType = (
      ftMemo, ftBlob, ftFmtMemo, ftParadoxOle, ftGraphic, ftDBaseOle,
      ftTypedBinary, ftBlob, ftBlob, ftBlob, ftWideMemo, ftOraClob, ftOraBlob,
      ftBlob, ftBlob);
  public type
    TBlobStream = class(TMemoryStream)
    private
      [Weak]FDataSet: TDBXReaderDataSet;
      [Weak]FField: TBlobField;
      FFieldNo: Integer;
      FHasData: Boolean;
    protected
      procedure ReadBlobSize;
    public
      constructor Create(Field: TBlobField; Mode: TBlobStreamMode = bmRead);
      destructor Destroy; override;
      procedure ReadBlobData;
      function Read(Buffer: TBytes; Offset, Count: Longint): Longint; overload; override;
  {$IFNDEF NEXTGEN}
      function Read(var Buffer; Count: Longint): Longint; overload; override; deprecated 'Use overloaded method instead';
  {$ENDIF !NEXTGEN}
    end;
    TFLDDesc = class
    private
      FFldNum:          Word;             { Field number (1..n) }
      FName:            string;           { Field name }
      FFldType:         Word;             { Field type }
      FSubType:         Word;             { Field subtype (if applicable) }
      FUnits1:          SmallInt;         { Number of Chars, digits etc }
      FUnits2:          SmallInt;         { Decimal places etc. }
      FOffset:          Word;             { Offset in the record (computed) }
      FLen:             LongWord;         { Length in bytes (computed) }
      FNullOffset:      Word;             { For Null bits (computed) }
      FFLDVchk:         FLDVchk;          { Field Has vcheck (computed) }
      FFLDRights:       FLDRights;        { Field Rights (computed) }
      FCalcField:       WordBool;         { Is Calculated field (computed) }
    public
      property iFldNum: Word read FFldNum write FFldNum;
      property szName: string read FName write FName;
      property iFldType: Word read FFldType write FFldType;
      property iSubType: Word read FSubType write FSubType;
      property iUnits1: SmallInt read FUnits1 write FUnits1;
      property iUnits2: SmallInt read FUnits2 write FUnits2;
      property iOffset: Word read FOffset write FOffset;
      property iLen: LongWord read FLen write FLen;
      property iNullOffset: Word read FNullOffset write FNullOffset;
      property efldvVchk: FLDVchk read FFLDVchk write FFLDVchk;
      property efldrRights: FLDRights read FFLDRights write FFLDRights;
      property bCalcField: WordBool read FCalcField write FCalcField;
    end;

  TFieldDescList = array of TFLDDesc;
  strict private
    FFieldBuffer:  TArray<Byte>;
    FRefreshing: Boolean;
  private
    FBlobBuffer: TBlobByteData;
    FCalcFieldsBuffer: TArray<Byte>;
    FCheckRowsAffected: Boolean;
    FCurrentBlobSize: Int64;
    FDesignerData: string;
    FProvidedDBXReader: Boolean;
    FOwnsProvidedDBXReader: Boolean;
    FIndexDefs: TIndexDefs;
    FMaxBlobSize: Integer;
    FMaxColSize: LongWord;
    FGetMetadata: Boolean;
    FNumericMapping: Boolean;
    FPrepared: Boolean;
    FRecords: Integer;
    FRowsAffected: Integer;
    FSortFieldNames: string;
    FDBXReader: TDBXReader;

    function GetCalculatedField(Field: TField; var Buffer: TValueBuffer): Boolean;
    function GetQueryFromType: string; virtual;
    function GetRowsAffected: Integer;
    procedure InitBuffers;
    procedure LoadFieldDef(FieldID: Word; var FldDesc: TFLDDesc); overload;
    procedure SetCurrentBlobSize(Value: Int64);
    procedure SetPrepared(Value: Boolean);
  protected
    { IProviderSupport }
    procedure PSEndTransaction(Commit: Boolean); override;
    procedure PSExecute; override;
    function PSExecuteStatement(const ASQL: string; AParams: TParams): Integer; overload; override;
    function PSExecuteStatement(const ASQL: string; AParams: TParams;
      var ResultSet: TDataSet): Integer; overload; override;
{$IFNDEF NEXTGEN}
    function PSExecuteStatement(const ASQL: string; AParams: TParams;
      ResultSet: Pointer = nil): Integer; overload; override; deprecated 'Use overloaded method instead';
{$ENDIF !NEXTGEN}
    procedure PSGetAttributes(List: TPacketAttributeList); override;
    function PSGetDefaultOrder: TIndexDef; override;
    function PSGetKeyFields: string; override;
    function PSGetQuoteChar: string; override;
    function PSGetTableName: string; override;
    function PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs; override;
    function PSGetParams: TParams; override;
    function PSGetUpdateException(E: Exception; Prev: EUpdateError): EUpdateError; override;
    function PSInTransaction: Boolean; override;
    function PSIsSQLBased: Boolean; override;
    function PSIsSQLSupported: Boolean; override;
    procedure PSReset; override;
    procedure PSSetCommandText(const ACommandText: string); override;
    procedure PSSetParams(AParams: TParams); override;
    procedure PSStartTransaction; override;
    function PSUpdateRecord(UpdateKind: TUpdateKind; Delta: TDataSet): Boolean; override;
    function PSGetCommandText: string; override;
    function PSGetCommandType: TPSCommandType; override;
  protected
    { implementation of abstract TDataSet methods }
    procedure InternalClose; override;
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalOpen; override;
    function IsCursorOpen: Boolean; override;
  protected
    procedure AddFieldDesc(FieldDescs: TFieldDescList; DescNo: Integer;
        var FieldID: Integer; RequiredFields: TBits; FieldDefs: TFieldDefs);
    procedure ClearIndexDefs;
    procedure CloseCursor; override;
    procedure CloseStatement;
    procedure FreeReader;
    procedure FreeBuffers;
    procedure FreeCommand;
    function GetCanModify: Boolean; override;
    procedure GetObjectTypeNames(Fields: TFields);
    function GetRecord(Buffer: TRecBuf; GetMode: TGetMode; DoCheck: Boolean): TGetResult; overload; override;
{$IFNDEF NEXTGEN}
    function GetRecord(Buffer: TRecordBuffer; GetMode: TGetMode; DoCheck: Boolean): TGetResult; overload; override; deprecated 'Use overloaded method instead';
{$ENDIF !NEXTGEN}
    function GetSortFieldNames: string;
    procedure InitRecord(Buffer: TRecBuf); overload; override;
{$IFNDEF NEXTGEN}
    procedure InitRecord(Buffer: TRecordBuffer); overload; override; deprecated 'Use overloaded method instead';
{$ENDIF !NEXTGEN}
    procedure InternalRefresh; override;
    procedure Loaded; override;
    function LocateRecord(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions; SyncCursor: Boolean): Boolean;
    procedure OpenCursor(InfoQuery: Boolean); override;
    procedure PropertyChanged;
    procedure SetBufListSize(Value: Integer); override;

    procedure SetFieldData(Field: TField; Buffer: TValueBuffer); overload; override;
{$IFNDEF NEXTGEN}
    procedure SetFieldData(Field: TField; Buffer: Pointer); overload; override; deprecated 'Use overloaded method instead';
{$ENDIF !NEXTGEN}
    procedure SetSortFieldNames(Value: string);
    procedure UpdateIndexDefs; override;
    { protected properties }
    property BlobBuffer: TBlobByteData read FBlobBuffer write FBlobBuffer;
    property CurrentBlobSize: Int64 read FCurrentBlobSize write SetCurrentBlobSize;
    property RowsAffected: Integer read GetRowsAffected;
    procedure SetMaxBlobSize(MaxSize: Integer);
  protected  { publish in TSQLDataSet }
    [Default(0)]
    property MaxBlobSize: Integer read FMaxBlobSize write SetMaxBlobSize default 0;
    function GetRecordCount: Integer; override;
    property SortFieldNames: string read GetSortFieldNames write SetSortFieldNames;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; DBXReader: TDBXReader; AOwnsInstance: Boolean); reintroduce; overload;
    destructor Destroy; override;
    function CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream; override;
    function GetBlobFieldData(FieldNo: Integer; var Buffer: TBlobByteData): Integer; override;
    function GetFieldData(FieldNo: Integer; var Buffer: TValueBuffer): Boolean; overload; override;
    function GetFieldData(Field: TField; var Buffer: TValueBuffer): Boolean; overload; override;
{$IFNDEF NEXTGEN}
    function GetFieldData(FieldNo: Integer; Buffer: Pointer): Boolean; overload; override; deprecated 'Use overloaded method instead';
    function GetFieldData(Field: TField; Buffer: Pointer): Boolean; overload; override; deprecated 'Use overloaded method instead';
{$ENDIF !NEXTGEN}
    property IndexDefs: TIndexDefs read FIndexDefs write FIndexDefs;
    function IsSequenced: Boolean; override;
    function Locate(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions): Boolean; override;
    function Lookup(const KeyFields: string; const KeyValues: Variant;
      const ResultFields: string): Variant; override;
    [Default(False)]
    property Prepared: Boolean read FPrepared write SetPrepared default False;
    property DesignerData: string read FDesignerData write FDesignerData;
    property RecordCount: Integer read GetRecordCount;
  public
    [Default(True)]
    property GetMetadata: Boolean read FGetMetadata write FGetMetadata default True;
    [Default(False)]
    property NumericMapping: Boolean read FNumericMapping write FNumericMapping default False;
    [Default(False)]
    property ObjectView default False;
    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeScroll;
    property AfterScroll;
    property BeforeRefresh;
    property AfterRefresh;
    property OnCalcFields;
    [Default(False)]
    property Active default False;
  end;


implementation

uses
  Data.DBConsts,
  Data.FmtBcd,
  System.Variants,
  Data.DBByteBuffer,
  System.StrUtils,
  Data.SqlTimSt,
  Data.DBXPlatform
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;


function GetBlobLength(DataSet: TDBXReaderDataSet; FieldNo: Integer): Int64;
var
  IsNull: LongBool;
begin
  Result := 0;
  if not DataSet.EOF then
  begin
    if DataSet.MaxBlobSize = 0 then
      exit;
    DataSet.FDBXReader.ByteReader.GetByteLength(FieldNo-1, Result, isNull);
    if isNull then
      Result := 0;
  end;
  DataSet.CurrentBlobSize := Result;
end;

{ TSQLBlobStream }

constructor TDBXReaderDataSet.TBlobStream.Create(Field: TBlobField; Mode: TBlobStreamMode = bmRead);
begin
  inherited Create;
  if not Field.DataSet.Active then
    DataBaseError(SDatasetClosed);
  FField := Field;
  FDataSet := FField.DataSet as TDBXReaderDataSet;
  FFieldNo := FField.FieldNo;
  FHasData := false;
  ReadBlobSize;
end;

destructor TDBXReaderDataSet.TBlobStream.Destroy;
begin
  inherited Destroy;
end;

procedure TDBXReaderDataSet.TBlobStream.ReadBlobSize;
var
  LOffset, LRead: Integer;
  LIsNull: LongBool;
  LBytes: TArray<Byte>;
  BlobLength: Int64;
const
  sMaxTmpBuffer = 32768;                                                                                            
begin
  Clear;
  BlobLength := GetBlobLength(FDataSet, FFieldNo);

  // For DataSnap connections, blob size can be -1 for large streams
  //  We need to determine the correct size now to be able to retrieve
  //  the data properly
  if BlobLength = -1 then
  begin
    //if MaxBlobSize is -1, then we are not limiting the buffer size
    //  so let's find out what the real blob size is
    if FDataSet <> nil then
    begin
      if FDataSet.MaxBlobSize = -1 then
      begin
        LOffset := 0;
        repeat
          SetLength(LBytes, LOffset + sMaxTmpBuffer);
          LRead :=  FDataSet.FDBXReader.ByteReader.GetBytes(FFieldNo-1, LOffset, LBytes, LOffset, sMaxTmpBuffer, LIsNull);
          if LRead < sMaxTmpBuffer then
          begin
            LOffset := LOffset + LRead;
            SetLength(LBytes, LOffset)
          end
          else
            LOffset := LOffset + sMaxTmpBuffer;
        until LRead < sMaxTmpBuffer;
        BlobLength := LOffset;
        Write(LBytes[0], BlobLength);
        FHasData := True;
        Position := 0;
      end
      else
        BlobLength := FDataSet.MaxBlobSize * 1024;
      FDataSet.CurrentBlobSize := BlobLength;
    end;
  end;

  if BlobLength > 0 then
    SetSize(BlobLength);
end;

procedure TDBXReaderDataSet.TBlobStream.ReadBlobData;
begin
  if FDataSet.GetFieldData(FField, FDataSet.FBlobBuffer, True) then
    Write(FDataSet.FBlobBuffer[0], FDataSet.FCurrentBlobSize);

  Position := 0;
  FHasData := true;
end;

function TDBXReaderDataSet.TBlobStream.Read(Buffer: TBytes; Offset, Count: LongInt): LongInt;
begin
  if not FHasData then
    ReadBlobData;
  Result := inherited Read(Buffer, Offset, Count);
end;

{$IFNDEF NEXTGEN}
function TDBXReaderDataSet.TBlobStream.Read(var Buffer; Count: Longint): Longint;
begin
  if not FHasData then
    ReadBlobData;
  Result := inherited Read(Buffer, Count);
end;
{$ENDIF !NEXTGEN}

constructor TDBXReaderDataSet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIndexDefs := TIndexDefs.Create(Self);
  FRecords := -1;
  SetUniDirectional(True);
  ObjectView := False;
end;

destructor TDBXReaderDataSet.Destroy;
begin
  Close;
  if Assigned(FDBXReader) then FreeReader;
  FreeAndNil(FIndexDefs);
  inherited Destroy;
  FreeBuffers;
end;

{ open/close Cursors and Statements }

procedure TDBXReaderDataSet.GetObjectTypeNames(Fields: TFields);
var
  I: Integer;
  ObjectField: TObjectField;
begin
  for I := 0 to Fields.Count - 1 do
  begin
    if Fields[I] is TObjectField then
    begin
      ObjectField := TObjectField(Fields[I]);
      ObjectField.ObjectType := FDBXReader.GetObjectTypeName(ObjectField.FieldNo-1);
      if ObjectField.DataType in [ftADT, ftArray] then
      begin
        if (ObjectField.DataType = ftArray) and SparseArrays and
           (ObjectField.Fields[0].DataType = ftADT) then
          GetObjectTypeNames(TObjectField(ObjectField.Fields[0]).Fields) else
          GetObjectTypeNames(ObjectField.Fields);
      end;
    end;
  end;
end;

procedure TDBXReaderDataSet.InternalOpen;
begin
  Assert(Assigned(FDBXReader));
  FieldDefs.Update;
  CreateFields;
  BindFields(True);
  if ObjectView then GetObjectTypeNames(Fields);
  InitBuffers;
end;

function TDBXReaderDataSet.IsCursorOpen: Boolean;
begin
  Result := (FDBXReader <> nil);
end;

procedure TDBXReaderDataSet.OpenCursor(InfoQuery: Boolean);
begin
  SetPrepared(True);
  inherited OpenCursor;
end;

procedure TDBXReaderDataSet.CloseCursor;
begin
  inherited CloseCursor;
end;

procedure TDBXReaderDataSet.FreeReader;
begin
  if Assigned(FDBXReader) then
  begin
    if FProvidedDBXReader and not FOwnsProvidedDBXReader then
      FDBXReader := nil
    else
      FreeAndNil(FDBXReader);
  end;
end;

procedure TDBXReaderDataSet.FreeCommand;
begin
  if Assigned(FieldDefs) then
    FieldDefs.Updated := False;
  ClearIndexDefs;
end;

procedure TDBXReaderDataSet.CloseStatement;
begin
  FPrepared := False;
end;

procedure TDBXReaderDataSet.InternalClose;
var
  DetailList: TList<TDataSet>;
  I: Integer;
begin
  BindFields(False);
  DestroyFields;
  FreeBuffers;
  if not FRefreshing then
  begin
    DetailList := TList<TDataSet>.Create;
    try
      GetDetailDataSets(DetailList);
      for I := 0 to DetailList.Count -1 do
        if DetailList[I] is TDBXReaderDataSet then
        begin
          TDBXReaderDataSet(DetailList[I]).Close;
          TDBXReaderDataSet(DetailList[I]).SetPrepared(False);
        end;
    finally
      DetailList.Free;
    end;
  end;
  SetPrepared(False);
end;

procedure TDBXReaderDataSet.Loaded;
begin
  inherited Loaded;
end;

procedure TDBXReaderDataSet.InternalRefresh;
begin
  FRefreshing := True;
  try
    SetState(dsInactive);
    CloseCursor;
    OpenCursor(False);
    SetState(dsBrowse);
  finally
    FRefreshing := False;
  end;
end;

procedure TDBXReaderDataSet.InitBuffers;
begin
  if (MaxBlobSize > 0) then
    SetLength(FBlobBuffer, MaxBlobSize * 1024);
  if (CalcFieldsSize > 0) then
    SetLength(FCalcFieldsBuffer, CalcFieldsSize);
end;

procedure TDBXReaderDataSet.ClearIndexDefs;
begin
  FIndexDefs.Clear;
//  FIndexDefsLoaded := False;
end;

procedure TDBXReaderDataSet.FreeBuffers;
begin
  if FBlobBuffer <> nil then
    SetLength(FBlobBuffer, 0);
  FBlobBuffer := nil;
  if FFieldBuffer <> nil then
    SetLength(FFieldBuffer, 0);
  FFieldBuffer := nil;
  FCurrentBlobSize := 0;
  if FCalcFieldsBuffer <> nil then
  begin
    SetLength(FCalcFieldsBuffer, 0);
    FCalcFieldsBuffer := nil;
  end;
end;

procedure TDBXReaderDataSet.InitRecord(Buffer: TRecBuf);
begin
  { NOP }
end;

{$IFNDEF NEXTGEN}
procedure TDBXReaderDataSet.InitRecord(Buffer: TRecordBuffer);
begin
  { NOP }
end;
{$ENDIF !NEXTGEN}

procedure TDBXReaderDataSet.SetBufListSize(Value: Integer);
begin
end;

{ Reader Level Metadata }

procedure TDBXReaderDataSet.AddFieldDesc(FieldDescs: TFieldDescList; DescNo: Integer;
  var FieldID: Integer; RequiredFields: TBits; FieldDefs: TFieldDefs);
const
  ArrayIndex = '[0]';
var
  LType: TFieldType;
  LSize: LongWord;
  LRequired: Boolean;
  LPrecision, I: Integer;
  FieldName: string;
  FieldDesc: TFLDDesc;
  FldDef: TFieldDef;
begin
  FieldDesc := FieldDescs[DescNo];
  FieldName := FieldDesc.szName;                                            
  FieldDesc.FName := FieldName;
  I := 0;
  while FieldDefs.IndexOf(FieldDesc.FName) >= 0 do
  begin
    Inc(I);
    FieldDesc.FName := Format('%s_%d', [FieldName, I]);
  end;
  if FieldDesc.iFldType < TDBXDataTypes.MaxBaseTypes then
    LType := DataTypeMap[FieldDesc.iFldType]
  else
    LType := ftUnknown;
  if FieldDesc.iFldType in [TDBXDataTypes.CurrencyType, TDBXDataTypes.BcdType] then
  begin
    FieldDesc.iUnits2 := Abs(FieldDesc.iUnits2);
    if FieldDesc.iUnits1 < FieldDesc.iUnits2 then   // iUnits1 indicates Oracle 'usable decimals'
      FieldDesc.iUnits1 := FieldDesc.iUnits2;
    // ftBCD supports only up to 18-4.  If Prec > 14 or Scale > 4, make FMTBcd
    if (FieldDesc.iUnits1 > (MaxBcdPrecision-4)) or (FieldDesc.iUnits2 > MaxBcdScale) or FNumericMapping then
    begin
      LType := ftFMTBcd;
      FieldDesc.iFldType := TDBXDataTypes.BcdType;
      if FieldDesc.iUnits1 > MaxFMTBcdDigits then
        FieldDesc.iUnits1 := MaxFMTBcdDigits;
    end;
  end;
  LSize := 0;
  LPrecision := 0;
  if RequiredFields.Size > FieldID then
    LRequired := RequiredFields[FieldID] else
    LRequired := False;
  case FieldDesc.iFldType of
    TDBXDataTypes.AnsiStringType:
      begin
        if FieldDesc.iUnits1 = 0 then { Ignore MLSLABEL field type on Oracle }
          LType := ftUnknown else
          LSize := FieldDesc.iUnits1;
      end;
    TDBXDataTypes.WideStringType:
      begin
        if FieldDesc.iUnits1 = 0 then { Ignore MLSLABEL field type on Oracle }
          LType := ftUnknown else
          LSize := FieldDesc.iUnits1;
      end;
    TDBXDataTypes.BytesType, TDBXDataTypes.VarBytesType, TDBXDataTypes.RefType:
      begin
        if FieldDesc.iUnits1 = 0 then { Ignore MLSLABEL field type on Oracle }
          LType := ftUnknown else
          LSize := FieldDesc.iUnits1;
      end;
    TDBXDataTypes.Int16Type, TDBXDataTypes.UInt16Type:
      if FieldDesc.iLen <> 2 then LType := ftUnknown;
    TDBXDataTypes.Int32Type:
      if FieldDesc.iSubType = TDBXDataTypes.AutoIncSubType then
      begin
        LType := ftAutoInc;
        LRequired := False;
      end;
    TDBXDataTypes.DoubleType:
      if FieldDesc.iSubType = TDBXDataTypes.MoneySubType then LType := ftCurrency;
    TDBXDataTypes.CurrencyType, TDBXDataTypes.BcdType:
      begin
        LSize := Abs(FieldDesc.iUnits2);
        LPrecision := FieldDesc.iUnits1;
      end;
    TDBXDataTypes.AdtType, TDBXDataTypes.ArrayType:
      begin
        LSize := FieldDesc.iUnits2;
        LPrecision := FieldDesc.iUnits1;
      end;
    TDBXDataTypes.BlobType:
      begin
        LSize := FieldDesc.iUnits1;
        if (FieldDesc.iSubType >= TDBXDataTypes.MemoSubType) and (FieldDesc.iSubType <= TDBXDataTypes.BFileSubType) then
          LType := BlobTypeMap[FieldDesc.iSubType];
      end;
  end;
  FldDef := FieldDefs.AddFieldDef;
  FldDef.FieldNo := FieldID;
  Inc(FieldID);
  FldDef.Name := FieldDesc.FName;
  FldDef.DataType := LType;
  FldDef.Size := LSize;
  FldDef.Precision := LPrecision;
  if LRequired then
    FldDef.Attributes := [faRequired];
  if FieldDesc.efldrRights = fldrREADONLY then
    FldDef.Attributes := FldDef.Attributes + [faReadonly];
  if FieldDesc.iSubType = TDBXDataTypes.FixedSubType then
    FldDef.Attributes := FldDef.Attributes + [faFixed];
  FldDef.InternalCalcField := FieldDesc.bCalcField;
  case LType of
    ftBlob, ftMemo, ftWideMemo, ftOraBlob, ftOraClob, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle:
      if FldDef.Size > MaxBlobSize then
        MaxBlobSize := FldDef.Size;
    ftADT:
      begin
        if FieldDesc.iSubType = TDBXDataTypes.AdtNestedTableSubType then
          FldDef.Attributes := FldDef.Attributes + [faUnNamed];
        for I := 1 to FieldDesc.iUnits1 do
        begin
          LoadFieldDef(Word(FldDef.FieldNo + I), FieldDescs[1]);
          AddFieldDesc(FieldDescs, 1, FieldID, RequiredFields, FldDef.ChildDefs);
        end;
      end;
    ftArray:
      begin
        for I := 1 to FieldDesc.iUnits1 do
        begin
          LoadFieldDef(Word(FldDef.FieldNo + I), FieldDescs[1]);
          FieldDescs[1].szName := FieldDesc.szName + ArrayIndex;
          AddFieldDesc(FieldDescs, 1, FieldID, RequiredFields, FldDef.ChildDefs);
        end;
      end;
  end;
end;

procedure TDBXReaderDataSet.LoadFieldDef(FieldID: Word; var FldDesc: TFLDDesc);
var
  ValueType: TDBXValueType;
begin
  FldDesc.iFldNum   := FieldID;
  ValueType         := FDBXReader.ValueType[FieldID-1];
  FldDesc.szName    := ValueType.Name;
  FldDesc.iFldType  := ValueType.DataType;
  FldDesc.iSubtype  := ValueType.SubType;
  FldDesc.iLen      := ValueType.Size;
  if ValueType.Precision > High(FldDesc.iUnits1) then
    FldDesc.iUnits1 := High(FldDesc.iUnits1)
  else
    FldDesc.iUnits1   := ValueType.Precision;
  if ValueType.Scale > High(FldDesc.iUnits2) then
    FldDesc.iUnits2 := High(FldDesc.iUnits2)
  else
    FldDesc.iUnits2   := ValueType.Scale;
  if ValueType.ReadOnly then
    FldDesc.efldrRights := fldrREADONLY;
  if FldDesc.iUnits1 = 0 then
  begin
    case ValueType.DataType of
      TDBXDataTypes.WideStringType:
        // Must provide a length in order to create a dataset column.  Raid 272101.
        // This code is consistent with TDBXDBMetaData.AddClientDataSetFields and
        // TDBXDataSetTable.CopyValueTypeProperties when handling TDBXDataTypes.WideStringType
        // Don't provide a length when have a DBXCommand so that ORACLE special cases special
        // cases will continue to work.  Search this file for "{ Ignore MLSLABEL field type on Oracle }".
        if (FldDesc.iLen <= 0) then // and (FDBXCommand = nil) then
          FldDesc.iUnits1 := 128  // default size (make constant)
        else
          FldDesc.iUnits1 := FldDesc.iLen;
      TDBXDataTypes.AnsiStringType:
        FldDesc.iUnits1 := FldDesc.iLen;
      TDBXDataTypes.VarBytesType,
      TDBXDataTypes.BytesType:
      begin
        // data size is in scale
        FldDesc.iUnits1 := FldDesc.iUnits2;
        FldDesc.iLen := FldDesc.iUnits2;
      end;
    end;
  end;
end;

procedure TDBXReaderDataSet.InternalInitFieldDefs;
var
  FID: Integer;
  FieldDescs: TFieldDescList;
  RequiredFields: TBits;
  FldDescCount: Word;
begin
  if (FDBXReader <> nil) then
  begin
    RequiredFields := TBits.Create;
    try
      FldDescCount := FDBXReader.ColumnCount;
      SetLength(FieldDescs, FldDescCount);
      for FID := 1 to FldDescCount do
        FieldDescs[FID-1] := TFldDesc.Create;
      try
        RequiredFields.Size := FldDescCount + 1;
        FieldDefs.Clear;
        FID := 1;
        FMaxColSize := FldDescCount;
        while FID <= FldDescCount do
        begin
          RequiredFields[FID] := FDBXReader.ValueType[FID-1].Nullable = False;
          LoadFieldDef(Word(FID), FieldDescs[0]);
          if (FieldDescs[0].iLen > FMaxColSize) and
             (FieldDescs[0].iFldType <> TDBXDataTypes.BlobType) then
            FMaxColSize := (FMaxColSize + FieldDescs[0].iLen);
          AddFieldDesc(FieldDescs, Integer(0), FID, RequiredFields, FieldDefs);
        end;
      finally
        for FID := 1 to FldDescCount do
          FreeAndNil(FieldDescs[FID-1]);
        FieldDescs := nil;
      end;
    finally
      RequiredFields.Free;
    end;
  end
  else
     DatabaseError(SDataSetClosed, self);
end;

{ Field and Record Access }

procedure NormalizeBcdData(FieldBuffer: TArray<Byte>; BcdData: TValueBuffer; Precision, Scale: Word);
var
  InBcd: TBcd;
  LBcd: TBcd;
begin
  if Assigned(BcdData) then
  begin
    if Precision > MaxFMTBcdDigits then Precision := MaxFMTBcdDigits;
    InBcd := BcdFromBytes(FieldBuffer);
    if (LBcd.SignSpecialPlaces = 38) and ((Scale and 63)in [38,0]) then
    begin
      if (Scale and (1 shl 7)) <> 0 then
        NormalizeBcd(InBcd, LBcd, MaxFMTBcdDigits, Word((DefaultFMTBcdScale and 63) or (1 shl 7)))
      else
        NormalizeBcd(InBcd, LBcd, MaxFMTBcdDigits, DefaultFMTBcdScale);
    end else
      NormalizeBcd(InBcd, LBcd, Precision, Scale);
    TPlatformValueBuffer.Copy(BcdToBytes(LBcd), 0, BcdData, SizeOfTBcd);
  end;
end;

function TDBXReaderDataSet.GetFieldData(FieldNo: Integer; var Buffer: TValueBuffer): Boolean;
var
  FldType, Precision, Scale: Word;
  LBlank: LongBool;
  Field: TField;
  ByteReader: TDBXByteReader;
  ByteBufferLength, DataLength, FieldDataSize, Ordinal: Integer;
  ByteBuffer: TArray<Byte>;
  BytesRead:  Int64;
  ValueType: TDBXValueType;
  ValueStr: string;
  M: TMarshaller;
begin
  if (FDBXReader = nil) then
    DatabaseError(SDataSetClosed, self);

  // When EOF is True or we are dealing with a calculated field (FieldNo < 1)
  // we should not be calling into the driver to get Data
  //
  if (FieldNo < 1) then
  begin
    Result := False;
    Exit;
  end;
  if EOF and (not BOF) then
  begin
    Result := False;
    Exit;
  end;
  if (EOF and BOF and FDBXReader.Closed) then
  begin
    Result := False;
    Exit;
  end;

  LBlank := True;
  Ordinal := FieldNo - 1;
  ValueType := FDBXReader.ValueType[Ordinal];
  DataLength := ValueType.Size;
  FldType := ValueType.DataType;
  if (Length(FFieldBuffer) < DataLength) and (FldType <> TDBXDataTypes.BlobType) then
    SetLength(FFieldBuffer, DataLength);
  ByteReader := FDBXReader.ByteReader;
  begin
    case FldType of
      TDBXDataTypes.AnsiStringType:
        begin
          FillChar(FFieldBuffer[0], Length(FFieldBuffer), 0);
{$IFNDEF NEXTGEN}
          if ByteReader <> nil then
            ByteReader.GetAnsiString(Ordinal, FFieldBuffer, 0, LBlank)
          else
{$ENDIF !NEXTGEN}
          begin
            ValueStr := FDBXReader.Value[Ordinal].AsString;
            LBlank := FDBXReader.Value[Ordinal].IsNull;
            if ValueStr.Length > 0 then
              TMarshal.Copy(M.AsAnsi(ValueStr), FFieldBuffer, 0, ValueStr.Length);
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.WideStringType:
        begin
          FieldDataSize := FieldByNumber(FieldNo).DataSize;
          if Length(FFieldBuffer) < FieldDataSize then
            SetLength(FFieldBuffer, FieldDataSize);
          FillChar(FFieldBuffer[0], Length(FFieldBuffer), 0);
          if Assigned(ByteReader) then
            ByteReader.GetWideString(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            ValueStr := FDBXReader.Value[Ordinal].AsString;
            LBlank := FDBXReader.Value[Ordinal].IsNull;
            if ValueStr.Length > 0 then
            begin
               ByteBuffer := TDBXPlatform.WideStrToBytes(ValueStr);
               ByteBufferLength := Length(ByteBuffer);
               TDBXPlatform.CopyByteArray(ByteBuffer, 0, FFieldBuffer, 0, ByteBufferLength);
            end;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, FieldDataSize);
        end;
      TDBXDataTypes.UInt8Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetUInt8(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyUInt8(FDBXReader.Value[Ordinal].AsUInt8, FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.Int8Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt8(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt8(FDBXReader.Value[Ordinal].AsInt8, FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.Int16Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt16(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt16(FDBXReader.Value[Ordinal].AsInt16, FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.UInt16Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt16(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyUInt16(FDBXReader.Value[Ordinal].AsUInt16, FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.Int32Type, TDBXDataTypes.UInt32Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt32(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt32(FDBXReader.Value[Ordinal].AsInt32, FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.Int64Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt64(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt64(FDBXReader.Value[Ordinal].AsInt64, FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.SingleType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetSingle(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt32(TDBXPlatform.SingleToInt32Bits(FDBXReader.Value[Ordinal].AsSingle), FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.DoubleType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetDouble(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt64(TDBXPlatform.DoubleToInt64Bits(FDBXReader.Value[Ordinal].AsDouble), FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.CurrencyType, TDBXDataTypes.BcdType:
        begin
          Field := FieldByNumber(FieldNo);
          if Length(FFieldBuffer) < Field.DataSize then
            SetLength(FFieldBuffer, Field.DataSize);
          if Assigned(ByteReader) then
            ByteReader.GetBcd(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyBcd(FDBXReader.Value[Ordinal].AsBcd, FFieldBuffer, 0);
            LBlank := False;
          end;
          if (not LBlank) and (Field <> nil) then
          begin
            if Field.DataType = ftBcd then
            begin
              Precision := TBcdField(Field).Precision;
              Scale := TBcdField(Field).Size;
            end else
            begin
              Precision := TFMTBcdField(Field).Precision;
              Scale := TFMTBcdField(Field).Size;
            end;
            NormalizeBcdData(FFieldBuffer, Buffer, Precision, Scale);
          end;
        end;
      TDBXDataTypes.DateType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetDate(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt32(FDBXReader.Value[Ordinal].AsDate, FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.TimeType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetTime(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt32(FDBXReader.Value[Ordinal].AsTime, FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.TimeStampType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetTimeStamp(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt64(TDBXPlatform.DoubleToInt64Bits(FDBXReader.Value[Ordinal].AsDateTime), FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.TimeStampOffsetType:
        begin
          ByteReader.GetTimeStampOffset(Ordinal, FFieldBuffer, 0, LBlank);
          if not LBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.DateTimeType:
        begin
          if not FDBXReader.Value[Ordinal].IsNull then
          begin
            Field := FieldByNumber(FieldNo);
            TDBXPlatform.CopyInt64(TDBXPlatform.DoubleToInt64Bits(FDBXReader.Value[Ordinal].AsDateTime), FFieldBuffer, 0);
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
            DataConvert(Field, Buffer, Buffer, True);
            LBlank := False;
          end
        end;
      TDBXDataTypes.BooleanType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt16(Ordinal, FFieldBuffer, 0, LBlank)
          else
          begin
            TDBXPlatform.CopyInt16(FDBXReader.Value[Ordinal].AsInt16, FFieldBuffer, 0);
            LBlank := False;
          end;
          if not LBlank then
            // DbxClient returns DataSize of 1, but we are reading 2 bytes.
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, 2);//DataLength);
        end;
      TDBXDataTypes.VarBytesType:
        begin
          DataLength := FDBXReader.ValueType[Ordinal].Size;
          SetLength(ByteBuffer, DataLength+2);
          if Assigned(ByteReader) then
            BytesRead := ByteReader.GetBytes(Ordinal, 0, ByteBuffer, 2, DataLength, LBlank)
          else
          begin
            BytesRead := FDBXReader.Value[Ordinal].GetBytes(0, ByteBuffer, 2, DataLength);
            LBlank := False;
          end;
          ByteBuffer[0] := BytesRead;
          ByteBuffer[1] := BytesRead shr 8;
          if not LBlank then
            TPlatformValueBuffer.Copy(ByteBuffer, 0, Buffer, DataLength+2);
        end;
      TDBXDataTypes.BytesType:
        begin
          DataLength := FDBXReader.ValueType[Ordinal].Size;
          SetLength(ByteBuffer, DataLength);
          if Assigned(ByteReader) then
            ByteReader.GetBytes(Ordinal, 0, ByteBuffer, 0, DataLength, LBlank)
          else
          begin
            FDBXReader.Value[Ordinal].GetBytes(0, ByteBuffer, 0, DataLength);
            LBlank := False;
          end;
          if not LBlank then
            TPlatformValueBuffer.Copy(ByteBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.BlobType:
        begin
//          DataLength := GetBlobLength(Self, FieldNo);
          if CurrentBlobSize = 0 then
            LBlank := True
          else
            begin
              if Assigned(ByteReader) then
              begin
                // Temporary for bug 249185.  Needs to be fixed properly for both managed
                // and native in a better way than this.  This change will keep things
                // working the same way they did in bds2006.
                // Need to modify all drivers to return 0 bytes read if they cannot read
                // a blob twice.  The temporary change below is also an optimization for
                // blobs since it avoids a copy of the blob.  This is not the right way
                // to fix this.  Solution should solve the problem for both native and
                // managed. One option is to duplicate blob read code from the TSQLBlobStream
                // class.  Virtually all apps will go through a blob stream to access blob
                // data.  However there is a path to this method though TField.GetData.
                // Sure would be nice if TDataSet could manage record buffers as TArray<Byte>.
                // sshaughnessy 2007.04.19.
                //
                if Buffer = FBlobBuffer then
                begin
                  ByteBuffer := TArray<Byte>(Buffer);
                  ByteReader.GetBytes(Ordinal, 0, ByteBuffer, 0, CurrentBlobSize, LBlank);
                end else
                begin
                  SetLength(ByteBuffer, CurrentBlobSize);
                  ByteReader.GetBytes(Ordinal, 0, ByteBuffer, 0, CurrentBlobSize, LBlank);
                  if not LBlank then
                    TPlatformValueBuffer.Copy(ByteBuffer, 0, Buffer, CurrentBlobSize);
                end;
              end
              else
              begin
                SetLength(ByteBuffer, CurrentBlobSize);
                FDBXReader.Value[Ordinal].GetBytes(0, ByteBuffer, 0, CurrentBlobSize);
                TPlatformValueBuffer.Copy(ByteBuffer, 0, Buffer, CurrentBlobSize);
              end;
            end;
        end;
    end;
  end;
//    SetLength(FFieldBuffer, 1);
  Result := not LBlank;
end;

function TDBXReaderDataSet.GetFieldData(Field: TField; var Buffer: TValueBuffer): Boolean;
var
   FieldNo: Word;
   TempBuffer: TValueBuffer;
   ThisBuffer: TValueBuffer;
   BlobSize: Int64;
   BlobNull: LongBool;
begin
  if not Self.Active then
    DataBaseError(SDatasetClosed);
  FieldNo := Field.FieldNo;
  if not Assigned(Buffer) then
  begin
    if Field.IsBlob then
    begin
      if EOF then
        BlobNull := True
      else
        FDBXReader.ByteReader.GetByteLength(Word(FieldNo)-1, BlobSize, BlobNull);
      Result := not Boolean(BlobNull);
      Exit;
    end
    else if Field.Size > Field.DataSize then
      TempBuffer := TPlatformValueBuffer.CreateValueBuffer(Field.Size)
    else
      TempBuffer := TPlatformValueBuffer.CreateValueBuffer(Field.DataSize);
    ThisBuffer := TempBuffer;
  end else
  begin
    ThisBuffer := Buffer;
    TempBuffer := nil;
  end;
  try
    if Field.FieldNo < 1 then
      Result := GetCalculatedField(Field, ThisBuffer)
    else
      Result := GetFieldData(FieldNo, ThisBuffer);
  finally
    if Assigned(TempBuffer) then
      TPlatformValueBuffer.Free(TempBuffer);
  end;
end;

{$IFNDEF NEXTGEN}
function TDBXReaderDataSet.GetFieldData(FieldNo: Integer; Buffer: Pointer): Boolean;
var
  FldType: Word;
  FBlank: LongBool;
  Field: TField;
  Precision, Scale: Word;
  ByteReader: TDBXByteReader;
  Ordinal:  Integer;
  ByteBuffer: TArray<Byte>;
  DataLength, ByteBufferLength: Integer;
  BytesRead:  Int64;
  ValueType: TDBXValueType;
  FieldDataSize: Integer;
  ValueStr: string;
begin
  if (FDBXReader = nil) then
    DatabaseError(SDataSetClosed, self);

  // When EOF is True or we are dealing with a calculated field (FieldNo < 1)
  // we should not be calling into the driver to get Data
  //
  if (FieldNo < 1) then
  begin
    Result := False;
    Exit;
  end;
  if EOF and (not BOF) then
  begin
    Result := False;
    Exit;
  end;
  if (EOF and BOF and FDBXReader.Closed) then
  begin
    Result := False;
    Exit;
  end;

  FBlank := True;
  Ordinal := FieldNo - 1;
  ValueType := FDBXReader.ValueType[Ordinal];
  DataLength := ValueType.Size;
  FldType := ValueType.DataType;
  if (Length(FFieldBuffer) < DataLength) and (FldType <> TDBXDataTypes.BlobType) then
    SetLength(FFieldBuffer, DataLength);
  ByteReader := FDBXReader.ByteReader;
  begin
    case FldType of
      TDBXDataTypes.AnsiStringType:
        begin
          FillChar(FFieldBuffer[0], Length(FFieldBuffer), 0);
          if ByteReader <> nil then
            ByteReader.GetAnsiString(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            ValueStr := FDBXReader.Value[Ordinal].AsString;
            if ValueStr.Length > 0 then
            begin
              ByteBuffer := TDBXPlatform.AnsiStrToBytes(AnsiString(ValueStr));
              ByteBufferLength := Length(ByteBuffer);
              TDBXPlatform.CopyByteArray(ByteBuffer, 0, FFieldBuffer, 0, ByteBufferLength);
              FBlank := ByteBufferLength = 0;
            end;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.WideStringType:
        begin
          FieldDataSize := FieldByNumber(FieldNo).DataSize;
          if Length(FFieldBuffer) < FieldDataSize then
            SetLength(FFieldBuffer, FieldDataSize);
          FillChar(FFieldBuffer[0], Length(FFieldBuffer), 0);
          if Assigned(ByteReader) then
            ByteReader.GetWideString(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            ValueStr := FDBXReader.Value[Ordinal].AsString;
            if ValueStr.Length > 0 then
            begin
               ByteBuffer := TDBXPlatform.WideStrToBytes(ValueStr);
               ByteBufferLength := Length(ByteBuffer);
               TDBXPlatform.CopyByteArray(ByteBuffer, 0, FFieldBuffer, 0, ByteBufferLength);
               FBlank := ByteBufferLength = 0;
            end;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, FieldDataSize);
        end;
      TDBXDataTypes.UInt8Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetUInt8(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyUInt8(FDBXReader.Value[Ordinal].AsUInt8, FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.Int8Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt8(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt8(FDBXReader.Value[Ordinal].AsInt8, FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.Int16Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt16(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt16(FDBXReader.Value[Ordinal].AsInt16, FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.UInt16Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt16(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyUInt16(FDBXReader.Value[Ordinal].AsUInt16, FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.Int32Type, TDBXDataTypes.UInt32Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt32(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt32(FDBXReader.Value[Ordinal].AsInt32, FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.Int64Type:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt64(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt64(FDBXReader.Value[Ordinal].AsInt64, FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.SingleType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetSingle(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt32(TDBXPlatform.SingleToInt32Bits(FDBXReader.Value[Ordinal].AsSingle), FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.DoubleType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetDouble(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt64(TDBXPlatform.DoubleToInt64Bits(FDBXReader.Value[Ordinal].AsDouble), FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.CurrencyType, TDBXDataTypes.BcdType:
        begin
          Field := FieldByNumber(FieldNo);
          if Length(FFieldBuffer) < Field.DataSize then
            SetLength(FFieldBuffer, Field.DataSize);
          if Assigned(ByteReader) then
            ByteReader.GetBcd(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyBcd(FDBXReader.Value[Ordinal].AsBcd, FFieldBuffer, 0);
            FBlank := False;
          end;
          if (not FBlank) and (Field <> nil) then
          begin
            if Field.DataType = ftBcd then
            begin
              Precision := TBcdField(Field).Precision;
              Scale := TBcdField(Field).Size;
            end else
            begin
              Precision := TFMTBcdField(Field).Precision;
              Scale := TFMTBcdField(Field).Size;
            end;
            NormalizeBcdData(FFieldBuffer, Buffer, Precision, Scale);
          end;
        end;
      TDBXDataTypes.DateType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetDate(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt32(FDBXReader.Value[Ordinal].AsDate, FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.TimeType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetTime(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt32(FDBXReader.Value[Ordinal].AsTime, FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.TimeStampType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetTimeStamp(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt64(TDBXPlatform.DoubleToInt64Bits(FDBXReader.Value[Ordinal].AsDateTime), FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.TimeStampOffsetType:
        begin
          ByteReader.GetTimeStampOffset(Ordinal, FFieldBuffer, 0, FBlank);
          if not FBlank then
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.DateTimeType:
        begin
          if not FDBXReader.Value[Ordinal].IsNull then
          begin
            Field := FieldByNumber(FieldNo);
            TDBXPlatform.CopyInt64(TDBXPlatform.DoubleToInt64Bits(FDBXReader.Value[Ordinal].AsDateTime), FFieldBuffer, 0);
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, DataLength);
            DataConvert(Field, Buffer, Buffer, True);
            FBlank := False;
          end
        end;
      TDBXDataTypes.BooleanType:
        begin
          if Assigned(ByteReader) then
            ByteReader.GetInt16(Ordinal, FFieldBuffer, 0, FBlank)
          else
          begin
            TDBXPlatform.CopyInt16(FDBXReader.Value[Ordinal].AsInt16, FFieldBuffer, 0);
            FBlank := False;
          end;
          if not FBlank then
            // DbxClient returns DataSize of 1, but we are reading 2 bytes.
            TPlatformValueBuffer.Copy(FFieldBuffer, 0, Buffer, 2);//DataLength);
        end;
      TDBXDataTypes.VarBytesType:
        begin
          DataLength := FDBXReader.ValueType[Ordinal].Size;
          SetLength(ByteBuffer, DataLength+2);
          if Assigned(ByteReader) then
            BytesRead := ByteReader.GetBytes(Ordinal, 0, ByteBuffer, 2, DataLength, FBlank)
          else
          begin
            BytesRead := FDBXReader.Value[Ordinal].GetBytes(0, ByteBuffer, 2, DataLength);
            FBlank := False;
          end;
          ByteBuffer[0] := BytesRead;
          ByteBuffer[1] := BytesRead shr 8;
          if not FBlank then
            TPlatformValueBuffer.Copy(ByteBuffer, 0, Buffer, DataLength+2);
        end;
      TDBXDataTypes.BytesType:
        begin
          DataLength := FDBXReader.ValueType[Ordinal].Size;
          SetLength(ByteBuffer, DataLength);
          if Assigned(ByteReader) then
            ByteReader.GetBytes(Ordinal, 0, ByteBuffer, 0, DataLength, FBlank)
          else
          begin
            FDBXReader.Value[Ordinal].GetBytes(0, ByteBuffer, 0, DataLength);
            FBlank := False;
          end;
          if not FBlank then
            TPlatformValueBuffer.Copy(ByteBuffer, 0, Buffer, DataLength);
        end;
      TDBXDataTypes.BlobType:
        begin
//          DataLength := GetBlobLength(Self, FieldNo);
          if CurrentBlobSize = 0 then
            FBlank := True
          else
            begin
              if Assigned(ByteReader) then
              begin
                // Temporary for bug 249185.  Needs to be fixed properly for both managed
                // and native in a better way than this.  This change will keep things
                // working the same way they did in bds2006.
                // Need to modify all drivers to return 0 bytes read if they cannot read
                // a blob twice.  The temporary change below is also an optimization for
                // blobs since it avoids a copy of the blob.  This is not the right way
                // to fix this.  Solution should solve the problem for both native and
                // managed. One option is to duplicate blob read code from the TSQLBlobStream
                // class.  Virtually all apps will go through a blob stream to access blob
                // data.  However there is a path to this method though TField.GetData.
                // Sure would be nice if TDataSet could manage record buffers as TArray<Byte>.
                // sshaughnessy 2007.04.19.
                //
                if Buffer = FBlobBuffer then
                begin
                  ByteBuffer := TArray<Byte>(Buffer);
                  ByteReader.GetBytes(Ordinal, 0, ByteBuffer, 0, CurrentBlobSize, FBlank);
                end else
                begin
                  SetLength(ByteBuffer, CurrentBlobSize);
                  ByteReader.GetBytes(Ordinal, 0, ByteBuffer, 0, CurrentBlobSize, FBlank);
                  if not FBlank then
                    TPlatformValueBuffer.Copy(ByteBuffer, 0, Buffer, CurrentBlobSize);
                end;
              end
              else
              begin
                SetLength(ByteBuffer, CurrentBlobSize);
                FDBXReader.Value[Ordinal].GetBytes(0, ByteBuffer, 0, CurrentBlobSize);
                TPlatformValueBuffer.Copy(ByteBuffer, 0, Buffer, CurrentBlobSize);
              end;
            end;
        end;
    end;
  end;
//    SetLength(FFieldBuffer, 1);
  Result := not FBlank;
end;

function TDBXReaderDataSet.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
var
   FieldNo: Word;
   TempBuffer: TValueBuffer;
   ThisBuffer: TValueBuffer;
   BlobSize: Int64;
   BlobNull: LongBool;
begin
  if not Self.Active then
    DataBaseError(SDatasetClosed);
  FieldNo := Field.FieldNo;
  if not Assigned(Buffer) then
  begin
    if Field.IsBlob then
    begin
      if EOF then
        BlobNull := True
      else
        FDBXReader.ByteReader.GetByteLength(Word(FieldNo)-1, BlobSize, BlobNull);
      Result := not Boolean(BlobNull);
      Exit;
    end
    else if Field.Size > Field.DataSize then
      TempBuffer := TPlatformValueBuffer.CreateValueBuffer(Field.Size)
    else
      TempBuffer := TPlatformValueBuffer.CreateValueBuffer(Field.DataSize);
    ThisBuffer := TempBuffer;
  end else
  begin
    ThisBuffer := Buffer;
    TempBuffer := nil;
  end;
  try
    if Field.FieldNo < 1 then
      Result := GetCalculatedField(Field, ThisBuffer)
    else
      Result := GetFieldData(FieldNo, ThisBuffer);
  finally
    if Assigned(TempBuffer) then
      TPlatformValueBuffer.Free(TempBuffer);
  end;
end;
{$ENDIF !NEXTGEN}

procedure TDBXReaderDataSet.SetCurrentBlobSize(Value: Int64);
begin
  if Value > FCurrentBlobSize then
    SetLength(FBlobBuffer, Value);
  FCurrentBlobSize := Value;
end;

function TDBXReaderDataSet.GetBlobFieldData(FieldNo: Integer; var Buffer: TBlobByteData): Integer;
var
  IsNull: LongBool;
  Ordinal: Integer;
begin
  Result := 0;
  Ordinal := FieldNo - 1;
  GetBlobLength(Self, FieldNo);
  if (FDBXReader = nil) then
    DatabaseError(SDataSetClosed, self);
  if FCurrentBlobSize > 0 then
  begin
    if LongWord(Length(Buffer)) < CurrentBlobSize then
      SetLength(Buffer, CurrentBlobSize);
    FDBXReader.ByteReader.GetBytes(Ordinal, 0, TArray<Byte>(Buffer), 0, FCurrentBlobSize, IsNull);
    if not IsNull then
      Result := CurrentBlobSize;
  end;
end;


constructor TDBXReaderDataSet.Create(AOwner: TComponent; DBXReader: TDBXReader; AOwnsInstance: Boolean);
begin
  Create(AOwner);
  FProvidedDBXReader := true;
  FOwnsProvidedDBXReader := AOwnsInstance;
  FDBXReader := DBXReader;

                                                                      
  //  DBXReader's connection properties as well (if possible), but for now, we can set this to
  //  the default value otherwise assuming it is unspecified there
  if FMaxBlobSize = 0 then   // means it hasn't been changed
    FMaxBlobSize := DefaultMaxBlobSize;
end;

function TDBXReaderDataSet.CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream;
begin
  Result := TDBXReaderDataSet.TBlobStream.Create(Field as TBlobField, Mode);
end;

procedure TDBXReaderDataSet.SetFieldData(Field: TField; Buffer: TValueBuffer);
var
  RecBuf: TArray<Byte>;
begin
  RecBuf := FCalcFieldsBuffer;
  if Field.FieldNo < 1 then   //{fkCalculated}
  begin
    if Assigned(Buffer) then
    begin
      RecBuf[Field.Offset] := 1;
      TPlatformValueBuffer.Copy(Buffer, RecBuf, Field.Offset+1, Field.DataSize);
    end
    else
      RecBuf[Field.Offset] := 0;
  end;
end;

{$IFNDEF NEXTGEN}
procedure TDBXReaderDataSet.SetFieldData(Field: TField; Buffer: Pointer);
var
  RecBuf: TArray<Byte>;
begin
  RecBuf := FCalcFieldsBuffer;
  if Field.FieldNo < 1 then   //{fkCalculated}
  begin
    if Assigned(Buffer) then
    begin
      RecBuf[Field.Offset] := 1;
      Move(Buffer^, RecBuf[Field.Offset+1], Field.DataSize);
    end
    else
      RecBuf[Field.Offset] := 0;
  end;
end;
{$ENDIF !NEXTGEN}

function TDBXReaderDataSet.GetCalculatedField(Field: TField; var Buffer: TValueBuffer): Boolean;
var
  RecBuf: TArray<Byte>;
begin
  Result := False;
  RecBuf := FCalcFieldsBuffer;
  if Field.FieldNo < 1 then   //{fkCalculated}
  begin
    if Boolean(RecBuf[Field.Offset]) then
    begin
      TPlatformValueBuffer.Copy(RecBuf, Field.Offset+1, Buffer, Field.DataSize);
      Result := True;
    end;
  end;
end;

function TDBXReaderDataSet.GetCanModify: Boolean;
begin
  Result := False;
end;

function TDBXReaderDataSet.GetRecord(Buffer: TRecBuf; GetMode: TGetMode; DoCheck: Boolean): TGetResult;
begin
  if FDBXReader.Next then
  begin
    GetCalcFields(Buffer);
    if Buffer <> 0 then
      Move(PByte(Buffer)[0], FCalcFieldsBuffer[0], Length(FCalcFieldsBuffer));
    Result := grOK
  end
  else
    Result := grEOF;
end;

{$IFNDEF NEXTGEN}
function TDBXReaderDataSet.GetRecord(Buffer: TRecordBuffer; GetMode: TGetMode; DoCheck: Boolean): TGetResult;
begin
  if FDBXReader.Next then
  begin
    GetCalcFields(Buffer);
    if Buffer <> nil then
      Move(Buffer^, FCalcFieldsBuffer[0], Length(FCalcFieldsBuffer));
    Result := grOK
  end
  else
    Result := grEOF;
end;
{$ENDIF !NEXTGEN}


{ Query Management }

procedure TDBXReaderDataSet.SetPrepared(Value: Boolean);
var
  Complete: Boolean;
begin
  if FProvidedDBXReader then
    FPrepared := Value
  else
    FreeReader;

  if Value <> Prepared then
  begin
    try
      if Value then
        begin
          FRowsAffected := -1;
          FCheckRowsAffected := True;
        end
      else
        begin
          if FCheckRowsAffected then
            FRowsAffected := RowsAffected;
          FreeCommand;
        end;
      FPrepared := Value;
    except
      FPrepared := False;
    end;

    Complete := false;
    if Value then
      try
        FRowsAffected := -1;
        FCheckRowsAffected := True;
        Complete := true;
      finally
        if not Complete then
          FPrepared := False;
      end
    else
      try
        if FCheckRowsAffected then
          FRowsAffected := RowsAffected;
        FreeCommand;
      except
        FPrepared := False;
      end;

    FPrepared := Value;
  end;
end;

function TDBXReaderDataSet.GetQueryFromType: string;
begin
  if (FSortFieldNames > '') then
    Result := SOrderBy + FSortFieldNames
  else
    Result := '';
end;

function TDBXReaderDataSet.GetRecordCount: Integer;
begin
  Result := FRecords;
end;

function TDBXReaderDataSet.GetRowsAffected: Integer;
var
  UpdateCount: LongWord;
begin
  if FRowsAffected > 0 then
    Result := Integer(FRowsAffected)
  else
  begin
    UpdateCount := 0;
    FRowsAffected := Integer(UpdateCount);
    Result := Integer(UpdateCount);
  end;
end;

function TDBXReaderDataSet.GetSortFieldNames: string;
begin
  Result := FSortFieldNames;
end;

procedure TDBXReaderDataSet.SetSortFieldNames(Value: string);
begin
  if Value <> FSortFieldNames then
  begin
    CheckInactive;
    FSortFieldNames := Value;
    SetPrepared(False);
  end;
end;

procedure TDBXReaderDataSet.SetMaxBlobSize(MaxSize: Integer);
begin
  FMaxBlobSize := MaxSize;
end;

procedure TDBXReaderDataSet.PropertyChanged;
begin
  if not (csLoading in ComponentState) then
  begin
    SetPrepared(False);
    FRecords := -1;
    FreeCommand;
    if SortFieldNames <> '' then
      FSortFieldNames := '';
  end;
end;

{ Miscellaneous }

function TDBXReaderDataSet.IsSequenced: Boolean;
begin
  Result := False;
end;

procedure TDBXReaderDataSet.InternalHandleException;
begin
end;

{ Index Support }

procedure TDBXReaderDataSet.UpdateIndexDefs;
begin
end;

{ ProviderSupport }

procedure TDBXReaderDataSet.PSEndTransaction(Commit: Boolean);
begin
end;

procedure TDBXReaderDataSet.PSExecute;
begin
  inherited;
end;

function TDBXReaderDataSet.PSExecuteStatement(const ASQL: string; AParams: TParams): Integer;
begin
  Result := inherited;
end;

function TDBXReaderDataSet.PSExecuteStatement(const ASQL: string; AParams: TParams;
  var ResultSet: TDataSet): Integer;
begin
  Result := inherited;
end;

{$IFNDEF NEXTGEN}
function TDBXReaderDataSet.PSExecuteStatement(const ASQL: string; AParams: TParams;
      ResultSet: Pointer = nil): Integer;
begin
  Result := inherited;
end;
{$ENDIF !NEXTGEN}

procedure TDBXReaderDataSet.PSGetAttributes(List: TPacketAttributeList);
begin
  inherited PSGetAttributes(List);
end;

function TDBXReaderDataSet.PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs;
begin
  Result := GetIndexDefs(IndexDefs, IndexTypes);
end;

function TDBXReaderDataSet.PSGetDefaultOrder: TIndexDef;

  function FieldsInQuery(IdxFields: string): Boolean;
  var
    I:  Integer;
    IdxFlds, Flds: TStrings;
    FldNames: string;
  begin
    Result := True;
    IdxFlds := TStringList.Create;
    try
      IdxFlds.CommaText := IdxFields;
      Flds := TStringList.Create;
      try
        Fields.GetFieldNames(Flds);
        FldNames := Flds.CommaText;
        for I := 0 to IdxFlds.Count -1 do
        begin
          if FldNames.IndexOf(IdxFlds[I]) = -1 then
          begin
            Result := False;
            Exit;
          end;
        end;
      finally
        Flds.Free;
      end;
    finally
      IdxFlds.Free;
    end;
  end;

var
  I: Integer;
begin
  Result := inherited PSGetDefaultOrder;
  if not Assigned(Result) then
    Result := GetIndexForOrderBy(GetQueryFromType, Self);
  if not Assigned(Result) then
  begin
    for I := 0 to IndexDefs.Count - 1 do
    begin
      if (ixPrimary in TIndexDef(IndexDefs[I]).Options) and
         FieldsInQuery(TIndexDef(IndexDefs[I]).Fields) then
      begin
        Result := TIndexDef.Create(nil);
        Result.Assign(IndexDefs[I]);
        Break;
      end;
    end;
  end;
end;

function TDBXReaderDataSet.PSGetKeyFields: string;
var
  HoldPos, I: Integer;
  IndexFound: Boolean;
begin
  Result := inherited PSGetKeyFields;
  IndexFound := False;
  if Result = '' then
  begin
    for I := 0 to IndexDefs.Count - 1 do
      if (ixUnique in IndexDefs[I].Options) or
         (ixPrimary in IndexDefs[I].Options) then
      begin
        Result := IndexDefs[I].Fields;
        IndexFound := (FieldCount = 0);
        if not IndexFound then
        begin
          HoldPos := 1;
          while HoldPos <= Result.Length do
          begin
            IndexFound := FindField(ExtractFieldName(Result, HoldPos)) <> nil;
            if not IndexFound then Break;
          end;
        end;
        if IndexFound then Break;
      end;
    if not IndexFound then
      Result := '';
  end;
end;

function TDBXReaderDataSet.PSGetParams: TParams;
begin
  Result := inherited;
end;

function TDBXReaderDataSet.PSGetQuoteChar: string;
begin
  Result := '';
end;

procedure TDBXReaderDataSet.PSReset;
begin
  inherited PSReset;
  if Active and (not BOF) then
    First;
end;

function TDBXReaderDataSet.PSGetTableName: string;
begin
  Result := inherited;
end;

function TDBXReaderDataSet.PSGetUpdateException(E: Exception; Prev: EUpdateError): EUpdateError;
begin
  Result := inherited;
end;

function TDBXReaderDataSet.PSInTransaction: Boolean;
begin
  Result := inherited;
end;

function TDBXReaderDataSet.PSIsSQLBased: Boolean;
begin
  Result := True;
end;

function TDBXReaderDataSet.PSIsSQLSupported: Boolean;
begin
  Result := True;
end;

procedure TDBXReaderDataSet.PSSetParams(AParams: TParams);
begin
  Close;
end;

procedure TDBXReaderDataSet.PSSetCommandText(const ACommandText: string);
begin
end;

procedure TDBXReaderDataSet.PSStartTransaction;
begin
  inherited;
end;

function TDBXReaderDataSet.PSUpdateRecord(UpdateKind: TUpdateKind; Delta: TDataSet): Boolean;
begin
  { OnUpdateRecord is not supported }
  Result := False;
end;

function TDBXReaderDataSet.PSGetCommandText: string;
begin
  Result := inherited;
end;

function TDBXReaderDataSet.PSGetCommandType: TPSCommandType;
begin
  Result := inherited;
end;

function TDBXReaderDataSet.LocateRecord(const KeyFields: string; const KeyValues: Variant;
  Options: TLocateOptions; SyncCursor: Boolean): Boolean;

  function SameValue(V1, V2: Variant; IsString, CaseInsensitive,
           PartialLength: Boolean): Boolean;
  var
    V: Variant;
  begin
    if not IsString then
      Result := VarCompareValue(V1, V2) = vrEqual
    else
    begin
      if PartialLength then
        V := string(V1).Substring(0, string(V2).Length)
      else
        V := V1;
      if CaseInsensitive then
        Result := string(V).ToLower = string(V2).ToLower
      else
        Result := V = V2;
    end;
  end;

  function CheckValues(AFields: TStrings; Values: Variant;
           CaseInsensitive, PartialLength: Boolean): Boolean;
  var
    J: Integer;
    Field: TField;
  begin
    Result := True;
    for J := 0 to AFields.Count -1 do
    begin
      Field := FieldByName(AFields[J]);
      if not SameValue(Field.Value, Values[J],
        Field.DataType in [ftString, ftFixedChar, ftWideString, ftFixedWideChar], CaseInsensitive, PartialLength) then
      begin
        Result := False;
        break;
      end;
    end;
  end;

var
  I: Integer;
  SaveFields, AFields: TStrings;
  PartialLength, CaseInsensitive: Boolean;
  Values, StartValues: Variant;
  bFound: Boolean;
begin
  CheckBrowseMode;
  CursorPosChanged;
  AFields := TStringList.Create;
  SaveFields := TStringList.Create;
  try
    AFields.CommaText := StringReplace(KeyFields, ';', ',', [rfReplaceAll]);
    PartialLength := loPartialKey in Options;
    CaseInsensitive := loCaseInsensitive in Options;
    if VarIsArray(KeyValues) then
      Values := KeyValues
    else
      Values := VarArrayOf([KeyValues]);
    { save current record in case we cannot locate KeyValues }
    StartValues := VarArrayCreate([0, FieldCount], varVariant);
    for I := 0 to FieldCount -1 do
    begin
      StartValues[I] := Fields[I].Value;
      SaveFields.Add(Fields[I].FieldName);
    end;
    First;
    while not EOF do
    begin
      if CheckValues(AFields, Values, CaseInsensitive, PartialLength) then
        break;
      Next;
    end;
    { if not found, reset cursor to starting position }
    bFound := not EOF;
    if not bFound then
    begin
      First;
      while not EOF do
      begin
        if CheckValues(SaveFields, StartValues, False, False) then
          break;
        Next;
      end;
    end;
    Result := bFound;
  finally
    AFields.Free;
    SaveFields.Free;
  end;
end;

function TDBXReaderDataSet.Locate(const KeyFields: string; const KeyValues: Variant;
  Options: TLocateOptions): Boolean;
begin
  DoBeforeScroll;
  Result := LocateRecord(KeyFields, KeyValues, Options, True);
  if Result then
  begin
    Resync([rmExact, rmCenter]);
    DoAfterScroll;
  end;
end;

function TDBXReaderDataSet.Lookup(const KeyFields: string; const KeyValues: Variant;
  const ResultFields: string): Variant;
begin
  Result := Null;
  if LocateRecord(KeyFields, KeyValues, [], False) then
  begin
    SetTempState(dsCalcFields);
    try
      CalculateFields(0);
      Result := FieldValues[ResultFields];
    finally
      RestoreState(dsBrowse);
    end;
  end;
end;

end.
