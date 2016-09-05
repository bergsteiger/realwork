unit Migrator;

interface

uses
 daTypes,

 htInterfaces,
 htDataProviderParams,

 pgConnection,
 pgDataProviderParams,
 pgCommandExecutor
 ;

type
 TReportCallback = procedure (const aStr: String; WriteToLog: Boolean) of object;

 TMigrator = class(TObject)
 private
  f_CallBack: TReportCallback;
  f_Connection: TpgConnection;
  f_Executor: TpgCommandExecutor;
  f_PostgresParams: TpgDataProviderParams;
  f_Helper: IhtDataSchemeHelper;
  f_StoredProcPath: String;
  function Report(const aStr: String; WriteToLog: Boolean = False): String;
  procedure InitHT;
  procedure CloseHT;
  procedure RecreateDataBase;
  procedure RecreateSchema;
  procedure LoadParams;
  procedure SaveParams;
  procedure MigrateTables;
  procedure MigrateTable(aKind: TdaTables); overload;
  function HTKey2SQL(aHTKey: Byte): string;
  procedure MigrateForeignKeys;
  procedure MigrateProcedures;
  procedure CreateProcedure(const aProcName: String);
 public
  constructor Create; reintroduce;
  destructor Destroy; override;
  procedure Migrate;
  property ReportCallBack: TReportCallback read f_CallBack write f_CallBack;
  property PostrgesParams: TpgDataProviderParams read f_PostgresParams;
  property StoredProcPath: String read f_StoredProcPath write f_StoredProcPath;
 end;

implementation

uses
 Windows,
 SysUtils,
 Classes,

 l3Types,
 l3Base,
 l3StopWatch,
 l3FileUtils,
 l3Stream,
 l3Tree_TLB,
 l3TreeInterfaces,
 l3Nodes,
 l3IniFile,

 Ht_Const,
 Ht_DLL,

 dt_Table,
 dt_dictTree,

 daInterfaces,
 daScheme,
 daDataProviderSuperFactory,

 htDataSchemeHelper;

const
 cPostgresSection = 'Postgres.Data';
 cStoredProcPath = 'StoredProcPath';

{ TMigrator }

constructor TMigrator.Create;
begin
 inherited Create;
 f_Connection := TpgConnection.Create(nil);
 f_Executor := TpgCommandExecutor.Create(f_Connection);
 LoadParams;
end;

destructor TMigrator.Destroy;
begin
 FreeAndNil(f_Executor);
 FreeAndNil(f_Connection);
 FreeAndNil(f_PostgresParams);
 inherited;
end;

procedure TMigrator.RecreateDataBase;
begin
 Report('Recreate database');
 f_Connection.ConnectAs(PostrgesParams.Login, PostrgesParams.Password, 'postgres', PostrgesParams);
 try
  f_Executor.Execute(Format('DROP DATABASE IF EXISTS %s;', [cDefaultSchemeName]));
  f_Executor.Execute(Format('CREATE DATABASE %s WITH TEMPLATE=template0 ENCODING=''WIN1251'' LC_COLLATE=''Russian_Russia.1251'' LC_CTYPE=''Russian_Russia.1251'';', [cDefaultSchemeName]));
 finally
  f_Connection.Disconnect;
 end;
end;

procedure TMigrator.Migrate;
var
 l_Watch: Tl3StopWatch;
 l_WasError: Boolean;
begin
 Report(Format('Start convertation at %s ', [FormatDateTime('dd.mm.yyyy hh:nn:ss', Now)]), True);
 l_Watch.Reset;
 l_Watch.Start;
 try
  l_WasError := False;
  try
   InitHT;
   try
    RecreateDataBase;
    f_Connection.ConnectAs(PostrgesParams.Login, PostrgesParams.Password, cDefaultSchemeName, PostrgesParams);
    try
     Report('Connect to postgres');
     RecreateSchema;
     MigrateTables;
     MigrateForeignKeys;
     MigrateProcedures;
    finally
     f_Connection.Disconnect;
     Report('Disconnect from postgres');
    end;
   finally
    try
     CloseHT;
    except
    end;
   end;
   SaveParams;
  except
   on E: Exception do
   begin
    Report(Format('ERROR!! %s', [E.Message]));
    l3System.Exception2Log(E);
    l_WasError := True;
   end;
  end;
 finally
  l_Watch.Stop;
  if l_WasError then
   Report(Format('FAILED. Elapsed %s ms', [FormatFloat('#,###', l_Watch.Time * 1000)]), True)
  else
   Report(Format('All done in %s ms', [FormatFloat('#,###', l_Watch.Time * 1000)]), True);
 end;
end;

function TMigrator.Report(const aStr: String; WriteToLog: Boolean = False): String;
begin
 Result := aStr;
 if Assigned(f_CallBack) then
  f_CallBack(aStr, WriteToLog);
end;

procedure TMigrator.SaveParams;
begin
 TdaDataProviderSuperFactory.Instance.FindFactoryByParamType(TpgDataProviderParams.ParamsKey).SaveToConfig(f_PostgresParams);
 StationConfig.Section := cPostgresSection;
 StationConfig.WriteParamStr(cStoredProcPath, f_StoredProcPath);
end;

procedure TMigrator.RecreateSchema;
begin
 f_Executor.Execute(Format('DROP SCHEMA IF EXISTS "%s" CASCADE;', [cDefaultSchemeName]));
 f_Executor.Execute('VACUUM FULL');
 f_Executor.Execute(Format('CREATE SCHEMA IF NOT EXISTS "%s" AUTHORIZATION postgres;', [cDefaultSchemeName]));
end;

procedure TMigrator.CloseHT;
begin
 htShut;
 htGlobalShut;
end;

procedure fn_OnIOError(fpFileName: PChar;
                       nIoCode:    SmallInt;
                       nDosError:  SmallInt); stdcall;
var
 l_Buff220: array[0..220] of Char;
begin
 htIOMessage(@l_Buff220);
 raise Exception.Create(StrPas(l_Buff220) + StrPas(fpFileName));
end;

procedure fn_OnHtError(nMessID: SmallInt); stdcall;
var
 l_Buff220: array[0..220] of Char;
begin
 // игнорируемые ошибки
 if nMessID in [
  72, // "Таблица задействована в транзакциях" (это вовсе не ошибка)
  25  // "Unique key doublet value found" - возникает при изменении записи,
      //   при этом дубликаты удаляются автоматически, так что можно не беспокоиться
 ] then
  Exit;

 htMessage(nMessID, @l_Buff220);
 raise Exception.Create(StrPas(l_Buff220) + ' Код ошибки: ' + IntToStr(nMessID));
end;

procedure TMigrator.InitHT;
var
 l_Init :Init;
begin
 if not DirectoryExists(PostrgesParams.DocStoragePath) then
  raise Exception.Create('Database not found');
 if not DirectoryExists(ConcatDirName(PostrgesParams.DocStoragePath, 'MAIN')) then
  raise Exception.Create('Database not found');
 if not DirectoryExists(ConcatDirName(PostrgesParams.DocStoragePath, 'GARANT')) then
  raise Exception.Create('Database not found');

 l3FillChar(l_Init, SizeOf(l_Init));
 with l_Init do
 begin
  nTableCnt      := 50;
  nTaskCnt       := 20;
  nHtCnt         := 4 + 20 * 6 + 1;
  nLockTimeOut   := 40;
  nPollDelay     := 40;
  nTransTimeOut  := 40;
  nTrsMode       := TRS_HARD;
  fpTmpPath      := PChar(PostrgesParams.DocStoragePath);
  fpNetPath      := PChar(PostrgesParams.DocStoragePath);
  fpTrtPath      := PChar(PostrgesParams.DocStoragePath);
  fpNetName      := 'pgMigrate';
  fpfInfo        := Pointer(-1);
  fpfIoMess      := @fn_OnIOError;
  fpfErrMess     := @fn_OnHtError;

  fpfPiStart     := Pointer(-1);
  fpfPiDraw      := Pointer(-1);
  fpfPiStop      := Pointer(-1);

  fpfYield       := Pointer(-1);
  gHeapCtrl      := 10000000;
  gHeapTask      := 120000;
 end;
 htGlobalInit(HInstance);
 htInit(@l_Init, SizeOf(l_Init));
end;

procedure TMigrator.MigrateTables;
var
 l_IDX: TdaTables;
 l_HitechParams: ThtDataProviderParams;
begin

 l_HitechParams := TdaDataProviderSuperFactory.Instance.FindFactoryByParamType(ThtDataProviderParams.ParamsKey).MakeFromConfig as ThtDataProviderParams;
 try
  l_HitechParams.ChangeBasePath(f_PostgresParams.DocStoragePath);
  f_Helper := ThtDataSchemeHelper.Make(l_HitechParams);
  try
   for l_IDX := Low(TdaTables) to High(TdaTables) do
    MigrateTable(l_IDX);
  finally
   f_Helper := nil;
  end;
 finally
  FreeAndNil(l_HitechParams);
 end;
end;

function TMigrator.HTKey2SQL(aHTKey : Byte) : string;
begin
 case aHTKey of
  EK_NOTKEY: (* Элемент не ключ  *)
   Result := '';
  EK_COMMON:  (* Обычный ключ     *)
   Result := '';
  EK_UNIQUE : (* Уникальный ключ  *)
   Result := 'UNIQUE';
 end;
end;

procedure TMigrator.MigrateTable(aKind: TdaTables);
var
 l_HTTable: String;
 l_HTTableOut: String;
 l_Table: TdtTable;
 l_TableDesc: IdaTableDescription;
 l_SQLString: String;
 l_FullTableName: String;
 l_IsFirst: Boolean;
 l_CommandStr: String;
 l_Watch: Tl3StopWatch;
 l_TreeWatch: Tl3StopWatch;
 l_IDX: Integer;
 l_FldName: String;

 procedure lp_AddToCommand(const aStr: String);
 begin
  if l_CommandStr <> '' then
   l_CommandStr := l_CommandStr + #13#10;
  l_CommandStr := l_CommandStr + aStr;
 end;

 function lp_HTType2SQL(const aField: IdaFieldDescription): String;
 const
  cMap: array [TdaDataType] of String = (
   'varchar', //da_dtChar
   'smallint', //da_dtByte
   'int4', //da_dtDate
   'int4', //da_dtTime
   'int4', //da_dtDWord
   'int2', //da_dtWord
   'int4', //da_dtInteger
   'bool', //da_dtBoolean
   'int8' //da_dtQWord
  );
 begin
  Result := cMap[aField.DataType];
  if aField.DataType = da_dtChar then
   Result := Format('%s(%d)', [Result, aField.Size]);
 end;

 function lp_BuildFields(aField: IdaFieldDescription): Boolean;
 var
  l_FldName: String;
 const
  cNullMap: array [Boolean] of String = ('NULL', 'NOT NULL');
 begin
  Result := True;
  if l_SQLString <> '' then
   l_SQLString := l_SQLString + ','#13#10;
  l_FldName := aField.SQLName;
  l_SQLString := l_SQLString + ' ' + l_FldName + ' ' + lp_HTType2SQL(aField) + ' ' + cNullMap[aField.Required];
 end;

 function lp_GetFieldsOfGroup(aElemIdx : word) : string;
 var
  I : Integer;
  l_S: String;
 begin
  Result := '';
  with l_Table, Element[aElemIdx] do
   for I := 0 to Pred(wLength) do
   begin
    Result := Result + l_TableDesc.FieldByIndex(wOffset + I).SQLName;
    if I < Pred(wLength) then
     Result := Result + ','
   end;
 end;

 procedure lp_ExportTreeToFile(const aHTTable : String);
  var
   lStream : Tl3TextStream;
   lTreeStruct : TTreeStrorage;
   lRootNode : Il3Node;

  function IterHandler_MakeTreeInfo(const CurNode : Il3Node) : Boolean; far;
  var
   l_S: AnsiString;
  begin
   Result := False;
   with CurNode, (CurNode as Il3HandleNode) do
   begin
    l_S := Format('%d'#9'%d'#9'%d'#13#10,[Handle, (Parent as Il3HandleNode).Handle, GetNumInParent(True)]);
    lStream.Write(l_S[1], Length(l_S));
   end;
  end;

 begin
  lTreeStruct := TTreeStrorage.Create(ChangeFileExt(aHTTable, ''));
  try
   //lTreeStruct.ChildNodeClass:=fChildNodeClass;
   lRootNode := Tl3UsualNode.Make;
   try
    lTreeStruct.Load(lRootNode);

    lStream := Tl3TextStream.Create(ChangeFileExt(aHTTable, '.tree'), l3_fmCreateReadWrite);
    try
     lRootNode.IterateF(l3L2NA(@IterHandler_MakeTreeInfo), 0);
    finally
     lStream.Free;
    end;
   finally
    lRootNode := nil;
   end;
  finally
   l3Free(lTreeStruct);
  end;
 end;

const
 cMap: array [Boolean] of Integer = (0, 2);

begin
 if aKind in [da_mtControl, da_ftNone, da_ftControl, da_ftDocumentsDub1, da_ftDocumentsDub2] then
   Exit;

 l_HTTable := f_Helper.TableFullPath(aKind);

 Report('Table : ' + l_HTTable, True);

 l_HTTableOut := ChangeFileExt(l_HTTable, '.txt');

 l_Table := TdtTable.CreateWithOpen(ExtractFilePath(l_HTTable), f_Helper.TablePassword(aKind), ExtractOnlyFileName(l_HTTable), TAB_SHARE);
 l_TableDesc := TdaScheme.Instance.Table(aKind);
 try

  l_FullTableName := Format('%s.%s', [cDefaultSchemeName, l_TableDesc.SQLName]);

  l_CommandStr := '';
  lp_AddToCommand(Report('CREATE TABLE ' + l_FullTableName + ' ('));


  Assert(l_TableDesc.FieldsCountWithoutTree = l_Table.fldCount, 'Не совпадает структура таблиц');

  l_SQLString := '';
  l_TableDesc.IterateFieldsF(L2DaTableDescriptionIteratorIterateFieldsFAction(@lp_BuildFields));
  l_SQLString := l_SQLString + #13#10');';
  lp_AddToCommand(Report(l_SQLString));

  l_Watch.Reset;
  l_Watch.Start;
  try
   f_Executor.Execute(l_CommandStr);
  finally
   l_Watch.Stop;
   Report(Format('ExecSQL time : %s ms', [FormatFloat('#,###', l_Watch.Time * 1000)]), True)
  end;

  Report('ExportToFile');
  l_Watch.Reset;
  l_Watch.Start;
  try
   l_Table.ExportToFile(l_HTTableOut, #0, #9, cMap[l_TableDesc.IsTree]);
  finally
   l_Watch.Stop;
   Report(Format('ExportToFile time : %s ms', [FormatFloat('#,###', l_Watch.Time * 1000)]), True)
  end;

  l_Watch.Reset;
  l_Watch.Start;
  try
   f_Executor.Execute(Report('COPY '+ l_FullTableName + ' FROM ''' +  l_HTTableOut + ''' WITH (ENCODING ''Win1251'', NULL ''~~~NULL~~~'')'));
  finally
   l_Watch.Stop;
   Report(Format('ExecSQL time : %s ms', [FormatFloat('#,###', l_Watch.Time * 1000)]), True)
  end;

  // CREATE INDEX
  l_Watch.Reset;
  l_Watch.Start;
  try
   l_IsFirst := True;
   l_CommandStr := '';
   for l_IDX := 1 to l_Table.fldCount do
   begin
    l_FldName := l_TableDesc.FieldByIndex(l_IDX).SQLName;
    if l_Table.ElementKeyKind[l_IDX] = EK_UNIQUE then
    begin
     if l_IsFirst then
     begin
      lp_AddToCommand(Report(Format('ALTER TABLE %s ADD PRIMARY KEY (%s);',[l_FullTableName, l_FldName])));
      l_IsFirst := False;
     end
     else
      lp_AddToCommand(Report(Format('ALTER TABLE %s ADD UNIQUE (%s);',[l_FullTableName, l_FldName])));
    end
    else
     if l_Table.ElementKeyKind[l_IDX] = EK_COMMON then
      lp_AddToCommand(Report(Format('CREATE INDEX %s_%s ON %s (%s);',[l_TableDesc.SQLName, l_FldName, l_FullTableName, l_FldName])));
   end;

   for l_IDX := (l_Table.fldCount + 1) to l_Table.ElementsCount do
   begin
    l_FldName := l_Table.ElementName[l_IDX];
    if (l_Table.ElementKeyKind[l_IDX] = EK_UNIQUE) and (aKind <> da_ftPiblishedIn) then
     lp_AddToCommand(Report(Format('CREATE UNIQUE INDEX %s_%s ON %s (%s);',[l_TableDesc.SQLName, l_FldName, l_FullTableName, lp_GetFieldsOfGroup(l_IDX)])))
    else
     lp_AddToCommand(Report(Format('CREATE INDEX %s_%s ON %s (%s);',[l_TableDesc.SQLName, l_FldName, l_FullTableName, lp_GetFieldsOfGroup(l_IDX)])));
   end;
   if l_CommandStr <> '' then
    f_Executor.Execute(l_CommandStr);
  finally
   l_Watch.Stop;
   Report(Format('Create index time : %s ms', [FormatFloat('#,###', l_Watch.Time * 1000)]), True)
  end; // CREATE INDEX

  //Укладываем дерево в таблицу
  if l_TableDesc.IsTree then
   begin
    l_TreeWatch.Reset;
    l_TreeWatch.Start;
    try
     lp_ExportTreeToFile(l_HTTable);
     l_CommandStr := '';
     lp_AddToCommand(Report('DROP TABLE IF EXISTS TREE;'));
     lp_AddToCommand(Report('CREATE TEMP TABLE TREE (ID int8, ParentID int8, OrderNum int8);'));
     lp_AddToCommand(Report('COPY TREE FROM ''' +  ChangeFileExt(l_HTTable, '.tree') + ''';'));
     lp_AddToCommand(Report(Format('UPDATE %s d SET ParentID = t.ParentID, OrderNum = t.OrderNum FROM TREE t WHERE t.ID = d.ID;',[l_FullTableName])));
     lp_AddToCommand(Report(Format('CREATE INDEX %s_order ON %s (ParentID, OrderNum);',[l_TableDesc.SQLName, l_FullTableName])));
     l_Watch.Reset;
     l_Watch.Start;
     try
      f_Executor.Execute(l_CommandStr);
     finally
      l_Watch.Stop;
      Report(Format('ExecSQL time : %s ms', [FormatFloat('#,###', l_Watch.Time * 1000)]), True)
     end;

    finally
     l_TreeWatch.Stop;
     Report(Format('Make tree data time : %s ms', [FormatFloat('#,###', l_TreeWatch.Time * 1000)]), True)
    end;
   end; //Укладываем дерево в таблицу
 finally
  l_TableDesc := nil;
  l_Table.CloseTbl;
  FreeAndNil(l_Table);
 end;

end;

procedure TMigrator.MigrateForeignKeys;
begin
// Do nothing yet
end;

procedure TMigrator.MigrateProcedures;
var
 l_IDX: Integer;
begin
 for l_IDX := 0 to TdaScheme.Instance.StoredProcsCount - 1 do
  CreateProcedure(TdaScheme.Instance.StoredProcName(l_IDX));
end;

procedure TMigrator.LoadParams;
begin
 f_PostgresParams := TdaDataProviderSuperFactory.Instance.FindFactoryByParamType(TpgDataProviderParams.ParamsKey).MakeFromConfig as TpgDataProviderParams;
 StationConfig.Section := cPostgresSection;
 f_StoredProcPath := StationConfig.ReadParamStrDef(cStoredProcPath, '');
end;

procedure TMigrator.CreateProcedure(const aProcName: String);
var
 l_Watch: Tl3StopWatch;
 l_Name: String;
 l_Text: TStringList;
begin
 l_Watch.Reset;
 l_Watch.Start;
 try
  Report('Create proc ' + aProcName, True);
  l_Name := ConcatDirName(f_StoredProcPath, aProcName + '.sql');
  if not FileExists(l_Name) then
   raise Exception.CreateFmt('Source for stored proc %s not found (file %s)',[aProcName, l_Name]);
  l_Text := TStringList.Create;
  try
   l_Text.LoadFromFile(l_Name);
   f_Executor.Execute(Report(l_Text.Text, True));
  finally
   FreeAndNil(l_Text);
  end;
 finally
  l_Watch.Stop;
  Report(Format('ExecSQL %s ms', [FormatFloat('#,###', l_Watch.Time * 1000)]), True)
 end;
end;

end.
