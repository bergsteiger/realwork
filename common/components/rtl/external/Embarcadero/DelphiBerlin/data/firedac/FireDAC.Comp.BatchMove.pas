{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                 FireDAC TFDBatchMove                  }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Comp.BatchMove;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Util, FireDAC.Stan.Factory,
  FireDAC.Comp.Client;

type
  IFDBatchMoveDriver = interface;
  IFDBatchMoveReader = interface;
  IFDBatchMoveWriter = interface;
  TFDBatchMoveDriver = class;
  TFDBatchMoveMappingItem = class;
  TFDBatchMoveMappings = class;
  TFDBatchMove = class;

  IFDBatchMoveDriver = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2050}']
    // private
    function GetCatalog: String;
    function GetIsUnicode: Boolean;
    function GetIsOpen: Boolean;
    function GetIsBatch: Boolean;
    function GetFieldCount: Integer;
    function GetFieldName(AIndex: Integer): String;
    // public
    procedure SetBatchMove(AValue: TFDBatchMove);
    function CheckDefined(ARaise: Boolean): Boolean;
    procedure Open(AStartTx: Boolean);
    procedure Close(AStopTxError: Boolean);
    procedure Refresh;
    procedure AbortJob;
    function AddAutoFields: Boolean;
    procedure DeleteAutoFields;
    function GetFieldIndex(const AName: String; ACheck: Boolean): Integer;
    function GetFieldInfo(AIndex: Integer; var AType: TFDDataType;
      var ASize: LongWord; var APrec, AScale: Integer; var AInKey, AIsIdentity: Boolean): TObject;
    // R/O props
    property Catalog: String read GetCatalog;
    property IsUnicode: Boolean read GetIsUnicode;
    property IsOpen: Boolean read GetIsOpen;
    property IsBatch: Boolean read GetIsBatch;
    property FieldCount: Integer read GetFieldCount;
    property FieldNames[AIndex: Integer]: String read GetFieldName;
  end;

  TFDBatchMoveAnalyze = set of (taDelimSep, taFormatSet, taHeader, taFields);
  IFDBatchMoveReader = interface(IFDBatchMoveDriver)
    ['{3E9B315B-F456-4175-A864-B2573C4A2051}']
    // private
    function GetSourceTableName: String;
    // public
    procedure ReadHeader;
    function Eof: Boolean;
    procedure ReadRecord;
    procedure NextRecord;
    procedure GuessFormat(AAnalyze: TFDBatchMoveAnalyze = [taDelimSep, taHeader, taFields]);
    procedure GetTableDefs(AFieldDefs: TFieldDefs; AIndexDefs: TIndexDefs);
    property SourceTableName: String read GetSourceTableName;
  end;

  IFDBatchMoveWriter = interface(IFDBatchMoveDriver)
    ['{3E9B315B-F456-4175-A864-B2573C4A2052}']
    // public
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

  TFDBatchMoveMode = (dmAlwaysInsert, dmAppend, dmUpdate, dmAppendUpdate, dmDelete);
  TFDBatchMoveAction = (paGuess, paSkip, paInsert, paUpdate, paDelete);
  TFDLogFileAction = (laNone, laCreate, laAppend);
  TFDBatchMovePhase = (psPreparing, psStarting, psProgress, psFinishing, psUnpreparing);
  TFDBatchMoveProgressEvent = procedure (ASender: TObject; APhase: TFDBatchMovePhase) of object;
  TFDBatchMoveFindDestRecordEvent = procedure (ASender: TObject; var AFound: Boolean) of object;
  TFDBatchMoveWriteValueEvent = procedure (ASender: TObject;
    AItem: TFDBatchMoveMappingItem; var AValue: Variant) of object;
  TFDBatchMoveWriteRecordEvent = procedure (ASender: TObject;
    var AAction: TFDBatchMoveAction) of object;
  TFDBatchMoveOption = (poClearDest, poClearDestNoUndo, poIdentityInsert, poCreateDest);
  TFDBatchMoveOptions = set of TFDBatchMoveOption;

  // eaFail: write error to log, go to next record, if ErrorCount >= MaxErrors, then eaExitFailure
  // eaSkip: write error to log, go to next record
  // eaRetry: retry record
  // eaApplied: go to next record
  // eaDefault: ->> eaFail
  // eaExitSuccess: stop moving and exit
  // eaExitFailure: stop moving and reraise
  TFDBatchMoveErrorEvent = procedure (ASender: TObject; AException: Exception;
    var AAction: TFDErrorAction) of object;

  /// <summary> TFDBatchMoveDriver is base abstract class for all batch move
  ///  reader and writer classes. </summary>
  TFDBatchMoveDriver = class(TFDComponent)
  private
    [Weak] FBatchMove: TFDBatchMove;
  protected
    /// <summary> GetIsBatch method is overriden by descendants and returns True
    ///  if batch move writer supports batch-like data writing. </summary>
    function GetIsBatch: Boolean; virtual;
    procedure SetBatchMove(AValue: TFDBatchMove);
  public
    /// <summary> BatchMove property returns reference to associated batch move
    ///  object. </summary>
    property BatchMove: TFDBatchMove read FBatchMove;
  end;

  /// <summary> TFDBatchMoveMappingItem class represents mapping of source
  ///  data item to destination data item, including:
  ///  * it allows to map source dataset field name (SourceFieldName) to
  ///    destination dataset field name (DestinationFieldName);
  ///  * it allows to specify expression (SourceExpression), which will be
  ///    applied to data source and result will be assigned to destination
  //     data item.
  ///   </summary>
  TFDBatchMoveMappingItem = class(TCollectionItem)
  private
    FSourceExpression: String;
    FSourceFieldName: String;
    FSourceField: TField;
    FSourceFieldObj: TObject;
    FSourceEvaluator: IFDStanExpressionEvaluator;
    FSourceValue: Variant;
    FDestinationFieldName: String;
    FDestField: TField;
    FDestFieldObj: TObject;
    FDestValue: Variant;
    FInKey: Boolean;
    FIsIdentity: Boolean;
    function GetAsText: String;
    procedure SetAsText(const AValue: String);
    function GetItemBaseValue: Variant;
    function GetItemValue: Variant;
  protected
    function GetDisplayName: String; override;
    procedure Prepare;
    procedure Unprepare;
  public
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    /// <summary> Move method moves data from source data item to destination data item. </summary>
    procedure Move;
    /// <summary> DestField property keeps reference to destination field object.
    ///  This property is used only for TField based destination data items. </summary>
    property DestField: TField read FDestField;
    /// <summary> DestFieldObj property keeps reference to destination data item object.
    ///  This property is used only for non-TField based destination data items. </summary>
    property DestFieldObj: TObject read FDestFieldObj;
    /// <summary> DestValue property keeps current destination data item value.
    ///  This property is used only for non-TField based destination data items. </summary>
    property DestValue: Variant read FDestValue write FDestValue;
    /// <summary> SourceField property keeps reference to source field object.
    ///  This property is used only for TField based source data items. </summary>
    property SourceField: TField read FSourceField;
    /// <summary> SourceFieldObj property keeps reference to source data item object.
    ///  This property is used only for non-TField based source data items. </summary>
    property SourceFieldObj: TObject read FSourceFieldObj;
    /// <summary> SourceEvaluator property returns reference to expresion evaluator
    ///  interface. This property is not nil only when SourceExpression is assigned. </summary>
    property SourceEvaluator: IFDStanExpressionEvaluator read FSourceEvaluator;
    /// <summary> SourceValue property keeps current source data item value.
    ///  This property is used only for non-TField based source data items. </summary>
    property SourceValue: Variant read FSourceValue write FSourceValue;
    /// <summary> ItemValue property returns value of current source data item.
    ///  If TFDBatchMove.OnWriteValue event handler is assigned, then it will be
    ///  called before returning item value. </summary>
    property ItemValue: Variant read GetItemValue;
    /// <summary> InKey property returns True if destination data item is
    ///  part of the primary key. </summary>
    property InKey: Boolean read FInKey;
    /// <summary> IsIdentity property returns True if destination data item is
    ///  identity field or column. </summary>
    property IsIdentity: Boolean read FIsIdentity;
    /// <summary> AsText property gets/sets mapping item as text in the
    ///  '<SourceFieldName>=<DestinationFieldName>' format. </summary>
    property AsText: String read GetAsText write SetAsText;
  published
    /// <summary> SourceFieldName property represents optional source data item name.
    ///  Depending on the data source kind, that may be dataset field name,
    ///  table column name, text file column name, etc. SourceFieldName may be
    ///  combined with SourceExpression. </summary>
    property SourceFieldName: String read FSourceFieldName write FSourceFieldName;
    /// <summary> SourceExpression property represents optional expression which
    ///  will be applied to the source data. The result of the expression then will be
    ///  assigned to destination data item. SourceExpression may be combined with
    ///  SourceFieldName. </summary>
    property SourceExpression: String read FSourceExpression write FSourceExpression;
    /// <summary> DestinationFieldName property represents mandatory destination data
    ///  item name. Depending on the data destination kind, that may be dataset
    ///  field name, table column name, text file column name, etc. </summary>
    property DestinationFieldName: String read FDestinationFieldName write FDestinationFieldName;
  end;

  /// <summary> TFDBatchMoveMappings class represents a collection of mappings
  ///  of source data items to destination data items.  </summary>
  TFDBatchMoveMappings = class(TCollection)
  private
    [Weak] FBatchMove: TFDBatchMove;
    FMappingsAuto: Boolean;
    FReaderAutoFields: Boolean;
    FWriterAutoFields: Boolean;
    FKeyFields: String;
    FKeyValues: Variant;
    function GetItem(AIndex: Integer): TFDBatchMoveMappingItem;
    procedure SetItem(AIndex: Integer; const AValue: TFDBatchMoveMappingItem);
    function GetKeyValues: Variant;
  protected
    function GetOwner: TPersistent; override;
    procedure Prepare;
    procedure Unprepare;
  public
    constructor Create(ABatchMove: TFDBatchMove);
    procedure Assign(ASource: TPersistent); override;
    /// <summary> Add method appends new mapping item. </summary>
    function Add: TFDBatchMoveMappingItem; overload;
    /// <summary> Add method appends new mapping item and assigns AMapItem
    ///  to its TFDBatchMoveMappingItem.AsText property. </summary>
    procedure Add(const AMapItem: String); overload;
    /// <summary> AddAll method populates collection by creating a mapping item
    ///  for each destination data item. </summary>
    procedure AddAll;
    /// <summary> Move method moves source data item values to corresponding
    ///  destination data items. When AKeysOnly is True, then only destination
    ///  data items constituting primary key are assigned. </summary>
    procedure Move(AKeysOnly: Boolean);
    /// <summary> IndexOfName method returns index of mapping item, where
    ///  destination item name is equal to AName. If item is not found,
    ///  then -1 is returned. </summary>
    function IndexOfName(const AName: String): Integer;
    /// <summary> BatchMove property returns reference to associated batch move
    ///  object. </summary>
    property BatchMove: TFDBatchMove read FBatchMove;
    /// <summary> KeyFields property returns string containing destination data
    ///  item names, constituting destination record primary key. </summary>
    property KeyFields: String read FKeyFields;
    /// <summary> KeyValues property returns variant array of destination data
    ///  item values, constituting destination record primary key value. </summary>
    property KeyValues: Variant read GetKeyValues;
    /// <summary> Items property gets/sets a mapping item by its index. </summary>
    property Items[Index: Integer]: TFDBatchMoveMappingItem read GetItem write SetItem; default;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDBatchMove = class(TFDComponent)
  private
    FReader: IFDBatchMoveReader;
    FWriter: IFDBatchMoveWriter;

    FMode: TFDBatchMoveMode;
    FOptions: TFDBatchMoveOptions;
    FMappings: TFDBatchMoveMappings;
    FLogFileAction: TFDLogFileAction;
    FLogFileName: String;
    FLogFileEncoding: TFDEncoding;
    FCommitCount: Integer;
    FStatisticsInterval: Integer;
    FAnalyze: TFDBatchMoveAnalyze;
    FAnalyzeSample: Integer;
    FMaxErrors: Integer;
    FOnProgress: TFDBatchMoveProgressEvent;
    FOnFindDestRecord: TFDBatchMoveFindDestRecordEvent;
    FOnWriteValue: TFDBatchMoveWriteValueEvent;
    FOnWriteRecord: TFDBatchMoveWriteRecordEvent;
    FOnError: TFDBatchMoveErrorEvent;

    FDeleteCount: Integer;
    FInsertCount: Integer;
    FUpdateCount: Integer;
    FReadCount: Integer;
    FErrorCount: Integer;
    FAborting: Boolean;
    FLogStream: TStream;
    function FindDestRecord: Boolean;
    procedure SetMappings(const AValue: TFDBatchMoveMappings);
    function GetWriteCount: Integer;
    procedure DoStatistic(APhase: TFDBatchMovePhase);
    function InitLogFile: TFDTextFile;
    procedure ProcessException(E: Exception; ALog: TFDTextFile;
      out AAction: TFDErrorAction);
    procedure DeleteExceptionFile(ALog: TFDTextFile);
    procedure SetReader(const AValue: IFDBatchMoveReader);
    procedure SetWriter(const AValue: IFDBatchMoveWriter);
    procedure CheckReader;
    procedure CheckWriter;
    procedure SetDriver(var ADriver: IFDBatchMoveDriver;
      const AValue: IFDBatchMoveDriver);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Integer;
    procedure AbortJob;
    procedure GuessFormat(AAnalyze: TFDBatchMoveAnalyze = [taDelimSep, taHeader, taFields]);
    property ReadCount: Integer read FReadCount;
    property InsertCount: Integer read FInsertCount;
    property UpdateCount: Integer read FUpdateCount;
    property DeleteCount: Integer read FDeleteCount;
    property WriteCount: Integer read GetWriteCount;
    property ErrorCount: Integer read FErrorCount;
    property LogStream: TStream read FLogStream write FLogStream;
  published
    property Reader: IFDBatchMoveReader read FReader write SetReader;
    property Writer: IFDBatchMoveWriter read FWriter write SetWriter;

    property Mode: TFDBatchMoveMode read FMode write FMode default dmAlwaysInsert;
    property Options: TFDBatchMoveOptions read FOptions write FOptions default [poIdentityInsert, poCreateDest];
    property Mappings: TFDBatchMoveMappings read FMappings write SetMappings;
    property LogFileAction: TFDLogFileAction read FLogFileAction write FLogFileAction default laNone;
    property LogFileName: String read FLogFileName write FLogFileName;
    property LogFileEncoding: TFDEncoding read FLogFileEncoding write FLogFileEncoding default ecDefault;
    property CommitCount: Integer read FCommitCount write FCommitCount default 100;
    property StatisticsInterval: Integer read FStatisticsInterval write FStatisticsInterval default 100;
    property Analyze: TFDBatchMoveAnalyze read FAnalyze write FAnalyze default [];
    property AnalyzeSample: Integer read FAnalyzeSample write FAnalyzeSample default 10;
    property MaxErrors: Integer read FMaxErrors write FMaxErrors default 0;

    property OnProgress: TFDBatchMoveProgressEvent read FOnProgress write FOnProgress;
    property OnFindDestRecord: TFDBatchMoveFindDestRecordEvent read FOnFindDestRecord write FOnFindDestRecord;
    /// <summary> The OnWriteValue event is triggered before a source value will be
    ///  moved to target data source. The AItem argument identifies data item (eg,
    ///  dataset field). The AValue argument represent the item value. An application
    ///  may use this event to reformat or convert the source value. </summary>
    property OnWriteValue: TFDBatchMoveWriteValueEvent read FOnWriteValue write FOnWriteValue;
    /// <summary> The OnWriteRecord event is triggered before a target record will
    ///  be updated. The AAction argument identifies an action which will be performed
    ///  with the target record. An application may use this event and Mapping
    ///  collection (contains current source record values) to change default
    ///  update action. </summary>
    property OnWriteRecord: TFDBatchMoveWriteRecordEvent read FOnWriteRecord write FOnWriteRecord;
    property OnError: TFDBatchMoveErrorEvent read FOnError write FOnError;
  end;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.Variants,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Consts, FireDAC.Stan.ResStrs,
  FireDAC.UI.Intf,
  FireDAC.Comp.DataSet;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveDriver                                                            }
{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDriver.SetBatchMove(AValue: TFDBatchMove);
begin
  FBatchMove := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDriver.GetIsBatch: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
{ TFDMappingItemExpressionDS                                                    }
{-------------------------------------------------------------------------------}
type
  TFDMappingItemExpressionDS = class(TInterfacedObject, IFDStanExpressionDataSource)
  private
    FMappings: TFDBatchMoveMappings;
    FBatchMove: TFDBatchMove;
    FThisIndex: Integer;
  protected
    // IFDStanExpressionDataSource
    function GetVarIndex(const AName: String): Integer;
    function GetVarType(AIndex: Integer): TFDDataType;
    function GetVarScope(AIndex: Integer): TFDExpressionScopeKind;
    function GetVarData(AIndex: Integer): Variant;
    procedure SetVarData(AIndex: Integer; const AValue: Variant);
    function GetSubAggregateValue(AIndex: Integer): Variant; virtual;
    function GetPosition: Pointer;
    procedure SetPosition(AValue: Pointer);
    function GetRowNum: Integer;
    function GetDatabase: String;
    function GetUser: String;
  public
    constructor Create(AMappings: TFDBatchMoveMappings; AThisIndex: Integer);
  end;

{-------------------------------------------------------------------------------}
constructor TFDMappingItemExpressionDS.Create(AMappings: TFDBatchMoveMappings;
  AThisIndex: Integer);
begin
  inherited Create;
  FMappings := AMappings;
  FBatchMove := AMappings.BatchMove;
  FThisIndex := AThisIndex;
end;

{-------------------------------------------------------------------------------}
function TFDMappingItemExpressionDS.GetPosition: Pointer;
begin
  Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDMappingItemExpressionDS.SetPosition(AValue: Pointer);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDMappingItemExpressionDS.GetRowNum: Integer;
begin
  Result := FBatchMove.ReadCount;
end;

{-------------------------------------------------------------------------------}
function TFDMappingItemExpressionDS.GetDatabase: String;
begin
  Result := FBatchMove.Reader.Catalog;
end;

{-------------------------------------------------------------------------------}
function TFDMappingItemExpressionDS.GetUser: String;
begin
  Result := '';
end;

{-------------------------------------------------------------------------------}
function TFDMappingItemExpressionDS.GetSubAggregateValue(AIndex: Integer): Variant;
begin
  Result := Unassigned;
  FDCapabilityNotSupported(Self, [S_FD_LComp, S_FD_LComp_PDM]);
end;

{-------------------------------------------------------------------------------}
function TFDMappingItemExpressionDS.GetVarIndex(const AName: String): Integer;
begin
  Result := FMappings.IndexOfName(AName);
end;

{-------------------------------------------------------------------------------}
function TFDMappingItemExpressionDS.GetVarType(AIndex: Integer): TFDDataType;
var
  oItem: TFDBatchMoveMappingItem;
  iIndex, iScale, iPrec: Integer;
  iSize: LongWord;
  lInKey, lIsIdentity: Boolean;
begin
  oItem := FMappings.Items[AIndex];
  Result := dtUnknown;
  iSize := 0;
  iPrec := 0;
  iScale := 0;
  if oItem.SourceExpression <> '' then begin
    iIndex := FBatchMove.Writer.GetFieldIndex(oItem.DestinationFieldName, True);
    FBatchMove.Writer.GetFieldInfo(iIndex, Result, iSize, iPrec, iScale, lInKey, lIsIdentity);
  end
  else if oItem.SourceFieldName <> '' then begin
    iIndex := FBatchMove.Reader.GetFieldIndex(oItem.SourceFieldName, True);
    FBatchMove.Reader.GetFieldInfo(iIndex, Result, iSize, iPrec, iScale, lInKey, lIsIdentity);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMappingItemExpressionDS.GetVarScope(AIndex: Integer): TFDExpressionScopeKind;
begin
  Result := ckField;
end;

{-------------------------------------------------------------------------------}
function TFDMappingItemExpressionDS.GetVarData(AIndex: Integer): Variant;
var
  oItem: TFDBatchMoveMappingItem;
begin
  oItem := FMappings.Items[AIndex];
  if AIndex = FThisIndex then
    Result := oItem.GetItemBaseValue
  else
    Result := oItem.ItemValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDMappingItemExpressionDS.SetVarData(AIndex: Integer; const AValue: Variant);
begin
  FMappings.Items[AIndex].SourceValue := AValue;
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveMappingItem                                                       }
{-------------------------------------------------------------------------------}
destructor TFDBatchMoveMappingItem.Destroy;
begin
  Unprepare;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappingItem.Assign(ASource: TPersistent);
begin
  if ASource is TFDBatchMoveMappingItem then begin
    SourceFieldName := TFDBatchMoveMappingItem(ASource).SourceFieldName;
    SourceExpression := TFDBatchMoveMappingItem(ASource).SourceExpression;
    DestinationFieldName := TFDBatchMoveMappingItem(ASource).DestinationFieldName;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveMappingItem.GetDisplayName: string;
begin
  Result := SourceFieldName;
  if Result = '' then
    Result := SourceExpression;
  if (Result <> '') or (DestinationFieldName <> '') then
    Result := Result + '->';
  Result := Result + DestinationFieldName;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappingItem.Prepare;
var
  oBM: TFDBatchMove;
  iDestInd, iSrcIndex: Integer;
  iTmp: Integer;
  eTmp: TFDDataType;
  ilTmp: LongWord;
  lTmp: Boolean;
  oParser: IFDStanExpressionParser;
begin
  oBM := TFDBatchMoveMappings(Collection).FBatchMove;
  if DestinationFieldName <> '' then
    iDestInd := oBM.Writer.GetFieldIndex(DestinationFieldName, True)
  else
    iDestInd := Index;
  FDestField := nil;
  FDestFieldObj := oBM.Writer.GetFieldInfo(iDestInd, eTmp, ilTmp, iTmp, iTmp,
    FInKey, FIsIdentity);
  if FDestFieldObj is TField then begin
    FDestField := TField(FDestFieldObj);
    FDestFieldObj := nil;
  end;

  if SourceExpression <> '' then begin
    FDCreateInterface(IFDStanExpressionParser, oParser);
    FSourceEvaluator := oParser.Prepare(
      TFDMappingItemExpressionDS.Create(TFDBatchMoveMappings(Collection), iDestInd),
      SourceExpression, [], [poDefaultExpr], '');
  end;
  if (SourceFieldName = '') and (SourceExpression <> '') then begin
    FSourceFieldObj := nil;
    FSourceField := nil;
  end
  else begin
    if SourceFieldName <> '' then
      iSrcIndex := oBM.Reader.GetFieldIndex(SourceFieldName, True)
    else
      iSrcIndex := iDestInd;
    try
      FSourceField := nil;
      FSourceFieldObj := oBM.Reader.GetFieldInfo(iSrcIndex, eTmp, ilTmp, iTmp, iTmp,
        lTmp, lTmp);
      if FSourceFieldObj is TField then begin
        FSourceField := TField(FSourceFieldObj);
        FSourceFieldObj := nil;
      end;
    except
      FDException(oBM, [S_FD_LComp, S_FD_LComp_PDM],
        er_FD_DPSrcUndefined, [DestinationFieldName]);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappingItem.Unprepare;
begin
  FDestField := nil;
  FDestFieldObj := nil;
  FDestValue := Unassigned;
  FSourceField := nil;
  FSourceFieldObj := nil;
  FSourceEvaluator := nil;
  FSourceValue := Unassigned;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveMappingItem.GetItemBaseValue: Variant;
begin
  if FSourceFieldObj <> nil then
    Result := FSourceValue
  else if FSourceField <> nil then
    Result := FSourceField.Value
  else
    Result := Null;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveMappingItem.GetItemValue: Variant;
begin
  if FSourceEvaluator <> nil then
    Result := FSourceEvaluator.Evaluate
  else
    Result := GetItemBaseValue;
  if Assigned(TFDBatchMoveMappings(Collection).FBatchMove.OnWriteValue) then
    TFDBatchMoveMappings(Collection).FBatchMove.OnWriteValue(
      TFDBatchMoveMappings(Collection).FBatchMove, Self, Result);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappingItem.Move;

  procedure SetupIdentityInsertion;
  begin
    if FDestField is TFDAutoIncField then
      TFDAutoIncField(FDestField).IdentityInsert := True
    else begin
      FDestField.ReadOnly := False;
      FDestField.ProviderFlags := FDestField.ProviderFlags + [pfInUpdate];
    end;
  end;

var
  V: Variant;
begin
  if FDestFieldObj <> nil then
    FDestValue := ItemValue
  else if (FSourceField <> nil) and (FSourceEvaluator = nil) and
          not Assigned(TFDBatchMoveMappings(Collection).FBatchMove.OnWriteValue) then begin
    if FIsIdentity and (poIdentityInsert in TFDBatchMoveMappings(Collection).FBatchMove.Options) and
       not FSourceField.IsNull then
      SetupIdentityInsertion;
    FDestField.Assign(FSourceField);
  end
  else begin
    V := ItemValue;
    if VarIsNull(V) then begin
      if not FDestField.IsNull then
        FDestField.Clear;
    end
    else begin
      if FIsIdentity and (poIdentityInsert in TFDBatchMoveMappings(Collection).FBatchMove.Options) then
        SetupIdentityInsertion;
      if FDestField is TBinaryField then
        if TFDBatchMoveMappings(Collection).FBatchMove.Reader.IsUnicode then
          FDestField.AsWideString := V
        else
{$IFDEF NEXTGEN}
          FDestField.AsString := String(V)
{$ELSE}
          FDestField.AsAnsiString := AnsiString(V)
{$ENDIF}
      else
        FDestField.Value := V;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveMappingItem.GetAsText: String;
begin
  if DestinationFieldName = SourceFieldName then
    Result := DestinationFieldName
  else
    Result := DestinationFieldName + '=' + SourceFieldName;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappingItem.SetAsText(const AValue: String);
var
  i: Integer;
begin
  i := Pos('=', AValue);
  if i <> 0 then begin
    DestinationFieldName := Copy(AValue, 1, i - 1);
    SourceFieldName := Copy(AValue, i + 1, Length(AValue));
  end
  else begin
    DestinationFieldName := AValue;
    SourceFieldName := AValue;
  end;
  for i := 1 to Length(SourceFieldName) do
    if not FDInSet(SourceFieldName[i], ['A'..'Z', 'a'..'z', '0'..'9', '_', '$', '#']) then begin
      SourceExpression := SourceFieldName;
      SourceFieldName := '';
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveMappings                                                          }
{-------------------------------------------------------------------------------}
constructor TFDBatchMoveMappings.Create(ABatchMove: TFDBatchMove);
begin
  inherited Create(TFDBatchMoveMappingItem);
  FBatchMove := ABatchMove;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappings.Assign(ASource: TPersistent);
var
  i: Integer;
begin
  if ASource is TStrings then begin
    Clear;
    for i := 0 to TStrings(ASource).Count - 1 do
      Add(TStrings(ASource).Strings[i]);
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveMappings.GetItem(AIndex: Integer): TFDBatchMoveMappingItem;
begin
  Result := TFDBatchMoveMappingItem(inherited GetItem(AIndex));
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveMappings.GetOwner: TPersistent;
begin
  Result := FBatchMove;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappings.SetItem(AIndex: Integer; const AValue: TFDBatchMoveMappingItem);
begin
  inherited SetItem(AIndex, AValue);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveMappings.Add: TFDBatchMoveMappingItem;
begin
  Result := TFDBatchMoveMappingItem(inherited Add);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappings.Add(const AMapItem: String);
begin
  Add.AsText := AMapItem;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappings.AddAll;
var
  lReaderOpen, lWriterOpen: Boolean;
  i: Integer;
  sDestName: String;
  oItem: TFDBatchMoveMappingItem;
begin
  Clear;
  BatchMove.CheckReader;
  BatchMove.CheckWriter;

  lReaderOpen := BatchMove.Reader.IsOpen;
  lWriterOpen := BatchMove.Writer.IsOpen;
  if not lReaderOpen then
    BatchMove.Reader.Open(False);
  if not lWriterOpen then
    BatchMove.Writer.Open(False);
  try
    for i := 0 to BatchMove.Writer.FieldCount - 1 do begin
      sDestName := BatchMove.Writer.FieldNames[i];
      oItem := Add;
      oItem.DestinationFieldName := sDestName;
      if BatchMove.Reader.GetFieldIndex(sDestName, False) <> -1 then
        oItem.SourceFieldName := sDestName;
    end;
  finally
    if not lReaderOpen then
      BatchMove.Reader.Close(False);
    if not lWriterOpen then
      BatchMove.Writer.Close(False);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappings.Prepare;
var
  i: Integer;
  iKeys: Integer;
begin
  try
    FReaderAutoFields := BatchMove.Reader.AddAutoFields;
    FWriterAutoFields := BatchMove.Writer.AddAutoFields;
    if Count = 0 then begin
      FMappingsAuto := True;
      AddAll;
    end;
    FKeyFields := '';
    FKeyValues := Null;
    iKeys := 0;
    for i := 0 to Count - 1 do begin
      Items[i].Prepare;
      if Items[i].InKey then begin
        Inc(iKeys);
        FKeyFields := FKeyFields + Items[i].DestinationFieldName + ';';
      end;
    end;
    if FKeyFields <> '' then begin
      SetLength(FKeyFields, Length(FKeyFields) - 1);
      FKeyValues := VarArrayCreate([0, iKeys - 1], varVariant);
    end;
    if (BatchMove.Mode in [dmAppend, dmUpdate, dmAppendUpdate, dmDelete]) and
       ([poClearDest, poClearDestNoUndo] * BatchMove.Options = []) and
       (FKeyFields = '') then
      FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPSrcUndefined, []);
  except
    Unprepare;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappings.Unprepare;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].Unprepare;
  if FMappingsAuto then begin
    FMappingsAuto := False;
    Clear;
  end;
  if FReaderAutoFields then begin
    FReaderAutoFields := False;
    FBatchMove.Reader.DeleteAutoFields;
  end;
  if FWriterAutoFields then begin
    FWriterAutoFields := False;
    FBatchMove.Writer.DeleteAutoFields;
  end;
  FKeyFields := '';
  FKeyValues := Null;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveMappings.Move(AKeysOnly: Boolean);
var
  i: Integer;
  oItem: TFDBatchMoveMappingItem;
begin
  for i := 0 to Count - 1 do begin
    oItem := Items[i];
    if not AKeysOnly or oItem.InKey then
      oItem.Move;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveMappings.IndexOfName(const AName: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].DestinationFieldName, AName) = 0 then begin
      Result := i;
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveMappings.GetKeyValues: Variant;
var
  i: Integer;
  iKey: Integer;
begin
  iKey := 0;
  for i := 0 to Count - 1 do
    if Items[i].InKey then begin
      FKeyValues[iKey] := Items[i].ItemValue;
      Inc(iKey);
    end;
  Result := FKeyValues;
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMove                                                                  }
{-------------------------------------------------------------------------------}
constructor TFDBatchMove.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMappings := TFDBatchMoveMappings.Create(Self);
  FOptions := [poIdentityInsert, poCreateDest];
  FCommitCount := 100;
  FMode := dmAlwaysInsert;
  FLogFileAction := laNone;
  FLogFileName := 'Data.log';
  FLogFileEncoding := ecDefault;
  FStatisticsInterval := 100;
  FAnalyzeSample := 10;
  FMaxErrors := 0;
end;

{-------------------------------------------------------------------------------}
destructor TFDBatchMove.Destroy;
begin
  Reader := nil;
  Writer := nil;
  FDFreeAndNil(FMappings);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  oRdr: IFDBatchMoveReader;
  oWrt: IFDBatchMoveWriter;
begin
  if Operation = opRemove then begin
    if AComponent = TObject(Reader) then
      Reader := nil
    else if AComponent = TObject(Writer) then
      Writer := nil;
  end
  else if Operation = opInsert then begin
    if ((AComponent.Owner = Self) or (Reader = nil)) and
       Supports(AComponent, IFDBatchMoveReader, oRdr) then
      Reader := oRdr
    else if ((AComponent.Owner = Self) or (Writer = nil)) and
       Supports(AComponent, IFDBatchMoveWriter, oWrt) then
      Writer := oWrt;
  end;
  inherited Notification(AComponent, Operation);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.SetDriver(var ADriver: IFDBatchMoveDriver;
  const AValue: IFDBatchMoveDriver);
var
  oComp: TComponent;
begin
  if ADriver <> AValue then begin
    if ADriver <> nil then begin
      ADriver.SetBatchMove(nil);
      if TObject(ADriver) is TComponent then begin
        oComp := TComponent(ADriver);
        oComp.RemoveFreeNotification(Self);
        if (oComp.Owner = Self) and not (csDestroying in oComp.ComponentState) then begin
          FDFree(oComp);
          Pointer(ADriver) := nil;
        end;
      end;
    end;
    ADriver := AValue;
    if ADriver <> nil then begin
      ADriver.SetBatchMove(Self);
      if TObject(ADriver) is TComponent then
        TComponent(ADriver).FreeNotification(Self);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.SetReader(const AValue: IFDBatchMoveReader);
begin
  SetDriver(IFDBatchMoveDriver(FReader), IFDBatchMoveDriver(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.SetWriter(const AValue: IFDBatchMoveWriter);
begin
  SetDriver(IFDBatchMoveDriver(FWriter), IFDBatchMoveDriver(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.SetMappings(const AValue: TFDBatchMoveMappings);
begin
  FMappings.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMove.GetWriteCount: Integer;
begin
  Result := FInsertCount + FUpdateCount + FDeleteCount;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.DoStatistic(APhase: TFDBatchMovePhase);
begin
  if Assigned(FOnProgress) then
    FOnProgress(Self, APhase);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMove.InitLogFile: TFDTextFile;
var
  S: String;
begin
  if ((LogFileName > #32) or (LogStream <> nil)) and (LogFileAction <> laNone) then begin
    if LogStream <> nil then
      Result := TFDTextFile.Create(LogStream, False, False, LogFileAction = laCreate,
        LogFileEncoding, elDefault)
    else
      Result := TFDTextFile.Create(LogFileName, False, LogFileAction = laCreate,
        LogFileEncoding, elDefault);
    S := C_FD_EOL + C_FD_EOL + '*************** ' + S_FD_StartLog + ' ' +
      DateTimeToStr(Now) + ' ***************';
    Result.WriteLine(S);
  end
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.ProcessException(E: Exception; ALog: TFDTextFile;
  out AAction: TFDErrorAction);
var
  sSQL, S: String;
begin
  AAction := eaFail;
  if E is EDatabaseError then begin
    if Assigned(FOnError) then begin
      FOnError(Self, E, AAction);
      if AAction = eaDefault then
        AAction := eaFail;
    end;
    if AAction in [eaFail, eaSkip] then begin
      Inc(FErrorCount);
      if ALog <> nil then begin
        if E is EFDDBEngineException then
          sSQL := EFDDBEngineException(E).SQL
        else
          sSQL := '';
        S := C_FD_EOL + E.Message + C_FD_EOL + C_FD_EOL + sSQL;
        ALog.WriteLine(S);
      end;
    end;
    if (AAction = eaFail) and
       (MaxErrors <> -1) and (ErrorCount >= MaxErrors) then
      AAction := eaExitFailure;
  end
  else
    AAction := eaExitFailure;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.DeleteExceptionFile(ALog: TFDTextFile);
var
  S: String;
begin
  if ALog <> nil then
    try
      if FErrorCount = 0 then begin
        S := C_FD_EOL + '          **********  ' + S_FD_NoErrorsLogged + ' ' +
          '**********';
        ALog.WriteLine(S);
      end;
      S := C_FD_EOL + '*************** ' + S_FD_EndLog + ' ' +
        DateTimeToStr(Now) + ' ***************';
      ALog.WriteLine(S);
    finally
      FDFree(ALog);
    end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMove.FindDestRecord: Boolean;
begin
  if Assigned(FOnFindDestRecord) then begin
    Result := False;
    FOnFindDestRecord(Self, Result);
  end
  else
    Result := Writer.FindRecord;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.CheckReader;
begin
  if Reader = nil then
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPNoSrcDS, []);
  Reader.CheckDefined(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.CheckWriter;
begin
  if Writer = nil then
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPNoDestDS, []);
  Writer.CheckDefined(True);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMove.Execute: Integer;
var
  oLog: TFDTextFile;
  eInitAction, eRecAction: TFDBatchMoveAction;
  lExcLogged: Boolean;
  oWait: IFDGUIxWaitCursor;
  lRetry: Boolean;
  eErrorAction: TFDErrorAction;
begin
  CheckReader;
  CheckWriter;
  FReadCount := 0;
  FInsertCount := 0;
  FUpdateCount := 0;
  FDeleteCount := 0;
  FErrorCount := 0;
  FAborting := False;
  lExcLogged := False;
  oLog := nil;
  oWait := nil;

  DoStatistic(psPreparing);
  if not FAborting then
  try
    if not FDGUIxSilent then begin
      FDCreateInterface(IFDGUIxWaitCursor, oWait);
      oWait.StartWait;
    end;
    oLog := InitLogFile;

    try
      Reader.Open(False);
      Writer.Open(True);
      Mappings.Prepare;

      eInitAction := paSkip;
      eRecAction := paSkip;
      case Mode of
      dmAlwaysInsert:
        eInitAction := paInsert;
      dmAppend,
      dmAppendUpdate:
        if Writer.IsBatch or
           ([poClearDest, poClearDestNoUndo] * Options <> []) then
          eInitAction := paInsert
        else
          eInitAction := paGuess;
      dmUpdate,
      dmDelete:
        if Writer.IsBatch then
          if Mode = dmUpdate then
            eInitAction := paUpdate
          else
            eInitAction := paDelete
        else if [poClearDest, poClearDestNoUndo] * Options <> [] then
          eInitAction := paSkip
        else
          eInitAction := paGuess;
      end;

      DoStatistic(psStarting);
      if [poClearDest, poClearDestNoUndo] * Options <> [] then
        Writer.Erase(poClearDestNoUndo in Options);

      if eInitAction <> paSkip then begin
        Reader.ReadHeader;
        Writer.WriteHeader;

        while not Reader.Eof and not FAborting do begin
          if oWait <> nil then
            oWait.StartWait;
          try
            Reader.ReadRecord;
            Inc(FReadCount);

            eRecAction := eInitAction;
            if eRecAction = paGuess then begin
              eRecAction := paSkip;
              if FindDestRecord then begin
                if (Mode = dmUpdate) or (Mode = dmAppendUpdate) then
                  eRecAction := paUpdate
                else if Mode = dmDelete then
                  eRecAction := paDelete;
              end
              else begin
                if (Mode = dmAppend) or (Mode = dmAppendUpdate) then
                  eRecAction := paInsert;
              end;
            end;

            if CommitCount > 0 then
              Writer.StartTransaction;

            repeat
              lRetry := False;
              try
                if Assigned(OnWriteRecord) then
                  OnWriteRecord(Self, eRecAction);
                case eRecAction of
                paInsert: Inc(FInsertCount, Writer.InsertRecord);
                paUpdate: Inc(FUpdateCount, Writer.UpdateRecord);
                paDelete: Inc(FDeleteCount, Writer.DeleteRecord);
                end;
              except
                on E: Exception do begin
                  if CommitCount > 0 then
                    Writer.RollbackTransaction;
                  lExcLogged := True;
                  ProcessException(E, oLog, eErrorAction);
                  case eErrorAction of
                  eaFail:        lRetry := False;
                  eaSkip:        lRetry := False;
                  eaRetry:       lRetry := True;
                  eaApplied:     lRetry := False;
                  eaExitSuccess: FAborting := True;
                  eaExitFailure: raise;
                  end;
                  lExcLogged := False;
                end;
              end;
            until not lRetry;

            Reader.NextRecord;
            if (CommitCount > 0) and (WriteCount mod CommitCount = 0) then
              Writer.CommitTransaction;

            if StatisticsInterval > 0 then
              if FReadCount mod StatisticsInterval = 0 then
                DoStatistic(psProgress);
          finally
            if oWait <> nil then
              oWait.StopWait;
          end;
        end;
      end;

      DoStatistic(psFinishing);
      case eRecAction of
      paInsert: Inc(FInsertCount, Writer.FlushRecords);
      paUpdate: Inc(FUpdateCount, Writer.FlushRecords);
      paDelete: Inc(FDeleteCount, Writer.FlushRecords);
      end;
      if CommitCount > 0 then
        Writer.CommitTransaction;
      Reader.Refresh;
      Writer.Refresh;
      Reader.Close(False);
      Writer.Close(False);
    except
      on E: Exception do begin
        if CommitCount > 0 then
          Writer.RollbackTransaction;
        Reader.Close(True);
        Writer.Close(True);
        if not lExcLogged then
          ProcessException(E, oLog, eErrorAction);
        if eErrorAction = eaExitFailure then
          raise;
      end;
    end;

  finally
    DoStatistic(psUnpreparing);
    Mappings.Unprepare;
    DeleteExceptionFile(oLog);
    if oWait <> nil then
      oWait.StopWait;
  end;
  Result := WriteCount;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.AbortJob;
begin
  if not FAborting then begin
    FAborting := True;
    if Writer <> nil then
      Writer.AbortJob;
    if Reader <> nil then
      Reader.AbortJob;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMove.GuessFormat(AAnalyze: TFDBatchMoveAnalyze);
begin
  if Reader = nil then
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPNoSrcDS, []);
  Reader.GuessFormat(AAnalyze);
end;

end.
