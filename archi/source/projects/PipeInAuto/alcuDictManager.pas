unit alcuDictManager;
{ Менеджер изменений словарей. Работает в двух режимах - главный или ведомый }

{ $Id: alcuDictManager.pas,v 1.29 2015/11/26 08:45:26 lukyanets Exp $ }

// $Log: alcuDictManager.pas,v $
// Revision 1.29  2015/11/26 08:45:26  lukyanets
// КОнстанты переехали
//
// Revision 1.28  2015/07/02 07:34:38  lukyanets
// Описываем словари
//
// Revision 1.27  2015/04/17 11:20:59  lukyanets
// Подчищаем протухшие словари
//
// Revision 1.26  2015/04/07 07:35:54  lukyanets
// Изолируем HT
//
// Revision 1.25  2014/10/15 10:58:30  lukyanets
// Отучаем ddAppCOnfig от dd
//
// Revision 1.24  2014/08/11 09:26:27  lukyanets
// Чистим
//
// Revision 1.23  2014/07/02 17:13:07  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.22  2014/07/01 11:12:02  lulin
// - удаляем "мусор".
//
// Revision 1.21  2014/06/03 15:34:10  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.20  2014/02/14 15:33:23  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.19  2014/02/12 12:39:12  lulin
// - рефакторим списки заданий.
//
// Revision 1.18  2012/03/22 05:17:13  narry
// Не собирается куча проектов (349119808)
//
// Revision 1.17  2010/10/22 13:13:49  narry
// K237503145 Чтение !ZOOM из NSRC приводит к ошибке
//
// Revision 1.16  2010/09/24 12:41:07  voba
// - k : 235046326
//
// Revision 1.15  2010/09/21 11:20:17  fireton
// - переводим деревья с PChar на Tl3WString
//
// Revision 1.14  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.13  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.12  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.11  2009/02/20 13:30:19  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.10  2009/02/20 13:28:44  narry
// - обновление
//
// Revision 1.9  2008/11/24 15:06:34  narry
// - обработка запроса о списке нередактируемых словарей
//
// Revision 1.8  2008/10/13 12:38:41  narry
// - промежуточное обновление
//
// Revision 1.7  2008/07/22 08:37:18  narry
// - последствия рефакторинга
//
// Revision 1.6  2008/07/14 08:05:51  narry
// - промежуточное обновление Единого КВ
//
// Revision 1.5  2008/07/12 12:36:02  fireton
// - рефакторинг DT_Dict
//
// Revision 1.4  2008/05/14 11:23:36  narry
// - уменьшение объема выоводимой в лог инфы для регионов
// - рефакторинг конфигурации
// - переделки Прайма
//
// Revision 1.3  2007/11/16 09:39:21  narry
// - запись дополнительной информации об изменении словарей
//
// Revision 1.2  2007/11/12 09:11:10  narry
// - накопилось: чистка кода, окошко "О программе",  поддержка внешних словарей, исправление "метки 20005", "Английская база"
//
// Revision 1.1  2007/09/06 06:21:12  narry
// - исправление ошибки доставки больших заданий пользователю (заплатка)
// - Расстановка меток 30005 и 20005
// - Удаленое изменение словарей
//

interface
Uses
 Classes,
 l3Base,
 csServerTaskTypes,
 daTypes,
 dt_Types, dt_AttrSchema,
 CsDataPipe;

type
  TalcuDictionaryManagerMode = (alcu_dmNone, alcu_dmMaster, alcu_dmSlave);
  TalcuDictionaryManager = class(Tl3Base)
  private
   f_DictID: Integer;
   f_DictsToSave: TDLTypeSet;
   f_WorkMode: TalcuDictionaryManagerMode;
   function AdjustName(aName: String): string;
   function DictListFileName(aDictID: Word): String;
   function GetDictName(aDictID: Integer): String;
   function IsComplexDicttionary(aDictType: TdaDictionaryType): Boolean;
   procedure SetDicts(aDicts: Integer);
   procedure WorkUpDictInfo(aFamily, aDictType, aOperation: Integer; aID, aParentID, aNextID : LongInt; aNameR, aNameE,
       aNameS: String; aIsPrivate: TIsPrivate; aNonperiodic: TIsNonperiodic);
  protected
   procedure Cleanup; override;
   function LoadOneFile(const aFileName: String): Boolean;
   {$IFDEF RemoteDict}
   procedure WriteAddOperation(aDictInfo: TRemoteDictEditQuery; aStream: TStream);
   procedure WriteDeleteOperation(aDictInfo: TRemoteDictEditQuery; aStream: TStream);
   procedure WriteEditOperation(aDictInfo: TRemoteDictEditQuery; aStream: TStream);
   {$EndIF RemoteDict}
   procedure WriteLnString(aStream: TStream; aStr: String);
   {$IFDEF RemoteDict}
   procedure WriteMoveOperation(aDictInfo: TRemoteDictEditQuery; aStream: TStream);
   {$EndIF RemoteDict}
  public
   constructor Make(aDicts: Integer; aWorkMode: TalcuDictionaryManagerMode);
   procedure cs_GetNonEditableDicts(aPipe: TCSDataPipe);
   procedure Execute;
   {$IFDEF RemoteDict}
   function GetFullPath(aDictInfo: TRemoteDictEditQuery): string;
   {$EndIF RemoteDict}
   procedure GetFromFTP;
   procedure LoadDictInfo;
   {$IFDEF RemoteDict}
   function GetNextPath(aDictInfo: TRemoteDictEditQuery): String;
   function GetPrevPath(aDictInfo: TRemoteDictEditQuery): string;
   {$EndIF RemoteDict}
   procedure PutToFTP;
   {$IFDEF RemoteDict}
   procedure SaveDictInfo(aDictInfo: TRemoteDictEditQuery); overload;
   {$EndIF RemoteDict}
   property DictsToSave: TDLTypeSet read f_DictsToSave write f_DictsToSave;
  end;

(*  TalcuDictSaveInfo = record
   DictInfo: TDictRec;
   NameR: String;
   NameE: String;
   ShortName: String;
   IsPrivate: TIsPrivate;
   IsNonperiodic: TIsNonperiodic;
  end;*)

implementation

Uses
 SysUtils, Forms,
 Base_CFG,
 l3Stream, l3Types, l3Bits, l3Tree_TLB, l3Nodes, l3FileUtils, l3String,
 ddAppConfig, ddFileIterator, ddUtils,
 daInterfaces, daSchemeConsts,
 dt_Dict, dt_Const,
 idFTP, StrUtils, dtSupport, dt_UserConst, dt_DictConst, Math, dt_DictTypes, TypInfo;

const
 cDictFileMask = '????????.dct';

constructor TalcuDictionaryManager.Make(aDicts: Integer; aWorkMode: TalcuDictionaryManagerMode);
begin
 inherited Create;
 f_WorkMode:= aWorkMode;
 SetDicts(aDicts);
end;

function TalcuDictionaryManager.AdjustName(aName: String): string;
begin
 Result := Trim(StringReplace(aName, '  ', '', [rfReplaceAll]));
 Result := StringReplace(Result, #13, '\', [rfReplaceAll]);
end;

procedure TalcuDictionaryManager.Cleanup;
begin

  inherited;
end;

procedure TalcuDictionaryManager.cs_GetNonEditableDicts(aPipe: TCSDataPipe);
var
 l_Dicts: Longint;
 i: TdaDictionaryType;
begin
 l_Dicts:= 0;
 if f_WorkMode = alcu_dmSlave then
  for i:= Low(TdaDictionaryType) to High(TdaDictionaryType) do
   if i in DictsToSave then
   begin
    case i of
     da_dlClasses: l3SetBit(l_Dicts, agDictClass);
     da_dlNewClasses_Deprecated:
     Assert(False, 'Deprecated dlNewClasses');
//     l3SetBit(l_Dicts, agDictNewClass_Deprecated);
     da_dlKeyWords: l3SetBit(l_Dicts, agDictKW);
     da_dlPublisheds: l3SetBit(l_Dicts, agPublished);
    else
     l3SetBit(l_Dicts, agDictOrdinary);
    end;
   end;
 aPipe.WriteInteger(l_Dicts);
end;

function TalcuDictionaryManager.DictListFileName(aDictID: Word): String;
var
 l_Folder: String;
begin
 l_Folder := SafeValidFolder(ddAppConfiguration.AsString['Dict_Folder']);
 Result := ConcatDirName(l_Folder, AnsiReplaceStr(Format('%2d%s.dct', [aDictID, FormatDateTime('YYMMDD', Date)]), ' ', '0'));
end;

procedure TalcuDictionaryManager.Execute;
begin
 case f_WorkMode of
  alcu_dmMaster: PutToFTP;
  alcu_dmSlave :
   begin
    //!!!!! GetFromFTP;
    LoadDictInfo;
   end
  else
   l3System.Msg2Log('Не задан режим работы менеджера словарей');
 end
end;

function TalcuDictionaryManager.GetDictName(aDictID: Integer): String;
begin
 Result := 'unknown';
 if TdaDictionaryType(aDictID) in [da_dlSources..High(TdaDictionaryType)] then
  Result:= GetEnumName(TypeInfo(TdaDictionaryType), aDictID);
end;


procedure TalcuDictionaryManager.GetFromFTP;
var
 l_List: TStrings;
 l_FTP: TidFTP;
 i: Integer;
 l_Dict: TdaDictionaryType;
begin
 l_FTP:= TidFTP.Create;
 try
  with l_FTP, ddAppConfiguration do
  begin
   Host:= AsString['Dict_FTPHost'];
   //Port:= AsInteger['Dict_FTPPort'];
   Username:= AsString['Dict_FTPUser'];
   Password := AsString['Dict_FTPPassword'];
   Connect;
   if Connected then
   begin
    ChangeDir(AsString['Dict_FTPFolder']);
    l_List:= TStringList.Create;
    try
     l_FTP.List(cDictFileMask, False);
     l_List.Assign(l_FTP.ListResult);
     for i:= 0 to Pred(l_List.Count) do
     begin
     end;
    finally
     l3Free(l_List);
    end;

    //забрать с FTP Только те файлы, которые свежее локальных
    for l_Dict:= Low(TdaDictionaryType) to High(TdaDictionaryType) do
     if l_Dict in DictsToSave then
      Get(ExtractFileName(DictListFileName(Ord(l_Dict))), DictListFileName(Ord(l_Dict)));
    Disconnect;
   end; // Connected
  end;
 finally
  l3Free(l_FTP);
 end;
end;

function TalcuDictionaryManager.IsComplexDicttionary(aDictType: TdaDictionaryType): Boolean;
begin
 Result := False;
end;

procedure TalcuDictionaryManager.LoadDictInfo;
var
 l_Stream: TStream;
 i: TdaDictionaryType;
 l_Version,
 l_Family   ,
 l_DictType ,
 l_Operation: Integer;
 l_ID       ,
 l_ParentID ,
 l_NextID   : LongInt;
 l_NameR, l_NameE, l_NameS: String;
 l_IsPrivate: TIsPrivate;
 l_IsNonperiodic: TIsNonperiodic;
 l_FileIterator: TddFileIterator;
begin
 // TODO -cMM: TddServerTaskManager.LoadDictInfo default body inserted
 { Считываем из файла информацию об изменениях словарей:
    1. Проверяем на соответствие словаря списку изменяемых на сервере
    2. Проверяем версию изменения - все более старые изменения пропускаются
    3. Обрабатываем изменения - добавляем в цепочку заданий
 }
 l_FileIterator:= TddFileIterator.Create;
 try
  l_FileIterator.Directory:= ddAppConfiguration.AsString['Dict_Folder'];
  for i:= Low(TdaDictionaryType) to High(TdaDictionaryType) do
   if i in DictsToSave then
   begin
    f_DictID:= Ord(i);
    // перебрать все файлы в папке, подходящие под маску, начиная с самых старых
    l_FileIterator.FileMask:= Format('%.2d*.dct', [Ord(i)]);
    l_FileIterator.LoadFiles;
    l_FileIterator.IterateFiles(LoadOneFile);
   end; // i in DictsToSave
  finally
   l3Free(l_FileIterator);
  end;
end;

function TalcuDictionaryManager.LoadOneFile(const aFileName: String): Boolean;
var
 l_Stream: Tl3TextStream;
 l_S, l_Parent: String;
 {$IFDEF RemoteDict}
 l_Task: TRemoteDictEditQuery;
 {$EndIF RemoteDict}
begin
 Result := True;
 l_Stream := Tl3TextStream.Create(aFileName, l3_fmRead);
 try
  while l_Stream.Position < l_Stream.Size do
  begin
   l_S:= l_Stream.GetLine;
   if l_S <> '' then
   begin
    if AnsiStartsText('[ADD]', l_S) then
    begin
     l_S:= l_Stream.GetLine;
     if l_S <> '' then
     begin
      {$IFDEF RemoteDict}
      l_Task:= TRemoteDictEditQuery.Create({nil, }usServerService);
      try
       l_Task.DictType:= f_DictID;
       l_Task.Operation:= Ord(atAdd);
       // Вполне вероятно, что добавляемый элемент является подэлементом - нужно вычленить Parent
       if Pos('\', l_S) > 0 then
       begin
        l_Parent:= Copy(l_S, 1, Pos('\', l_S)-1);
        l_Task.ParentID:= DictServer(CurrentFamily).Dict[TdaDictionaryType(f_DictID)].FindIDByFullPath(l3PCharLen(l_Parent));
        Delete(l_S, 1, Pos('\', l_S));
       end; // Pos('\', l_S) > 0
       l_Task.NameCyr:= l_S;
       DictServer(CurrentFamily).ProcessRemoteDictEdit(l_Task);
      finally
       l3Free(l_Task);
      end;
      {$Else  RemoteDict}
      Assert(false);
      {$EndIF RemoteDict}
     end;
    end
    else
    if AnsiStartsText('[DEL]', l_S) then
    begin
     l_S:= l_Stream.GetLine;
     if l_S <> '' then
     begin
      {$IFDEF RemoteDict}
      l_Task:= TRemoteDictEditQuery.Create({nil, }usServerService);
      try
       l_Task.DictType:= f_DictID;
       l_Task.Operation:= Ord(atDelete);
       l_Task.ID:= DictServer(CurrentFamily).Dict[TdaDictionaryType(f_DictID)].FindIDByFullPath(l3PCharLen(l_S));
       l_S:= l_Stream.GetLine;
       if AnsiStartsText('[ADD]', l_S) then
       begin
        l_S:= l_Stream.GetLine;
        l_Task.NextID:= DictServer(CurrentFamily).Dict[TdaDictionaryType(f_DictID)].FindIDByFullPath(l3PCharLen(l_S));
        if l_Task.NextID = cUndefDictID then // Редактирование
        begin
         l_Task.Operation:= Ord(atEdit);
         Delete(l_S, 1, Pos('\', l_S));
         l_Task.NameCyr:= l_S;
        end
       end; // AnsiStartsText('[ADD]', l_S) then
       DictServer(CurrentFamily).ProcessRemoteDictEdit(l_Task);
      finally
       l3Free(l_Task);
      end;
      {$Else  RemoteDict}
      Assert(false);
      {$EndIF RemoteDict}
     end;
    end
   end; // l_S <> ''
  end; // while not l_Stream.Position <> l_Stream.Size
 finally
  l3Free(l_Stream);
 end;
 //DeleteFile(aFileName);
end;

{$IFDEF RemoteDict}
function TalcuDictionaryManager.GetFullPath(aDictInfo: TRemoteDictEditQuery): string;
var
 l_Name: String;
begin
 with aDictInfo do
 begin
  if TOperActionType(Operation) = atAdd then
  begin
   Result:= NameCyr;
   if ParentID <> cUndefDictID then
    Result:= DictServer(CurrentFamily).Dict[TdaDictionaryType(DictType)].DictTbl.GetNameR(ParentID)+ '\' + Result;
  end
  else
  begin
   Result := AdjustName(DictServer(CurrentFamily).Dict[TdaDictionaryType(DictType)].GetFullDictItemName(ID));
   if TOperActionType(Operation) = atEdit then
   begin
    // Нужно заменить окончание на новое имя
    l_Name:= DictServer(CurrentFamily).Dict[TdaDictionaryType(DictType)].DictTbl.getNameR(ID);
    Delete(Result, Length(Result)-Length(l_Name)+1, Length(l_Name));
    Result:= Result + NameCyr;
   end;
  end;
 end;
end;

function TalcuDictionaryManager.GetNextPath(aDictInfo: TRemoteDictEditQuery): String;
begin
 with aDictInfo do
 begin
  if InRange(NextID, 1, Pred(cUndefDictID)) then
   Result:= AdjustName(DictServer(CurrentFamily).Dict[TdaDictionaryType(DictType)].GetFullDictItemName(NextID))
  else
   Result:= ''
 end;
end;

function TalcuDictionaryManager.GetPrevPath(aDictInfo: TRemoteDictEditQuery): string;
begin
 with aDictInfo do
 begin
  if InRange(ID, 1, Pred(cUndefDictID)) then
   Result:= AdjustName(DictServer(CurrentFamily).Dict[TdaDictionaryType(DictType)].GetFullDictItemName(ID))
  else
   Result:= ''
 end;
end;
{$EndIF RemoteDict}

procedure TalcuDictionaryManager.PutToFTP;
var
 l_LastFile, l_NewFile: String;
 l_Folder: TddFileIterator;
 i: Integer;
begin
 l_LastFile:= BaseConfig.MagicString['ExternalDicts', 'LastDictFile'];
 with TidFTP.Create, ddAppConfiguration do
 try
  Host:= AsString['Dict_FTPHost'];
  //Port:= AsInteger['Dict_FTPPort'];
  Username:= AsString['Dict_FTPUser'];
  Password := AsString['Dict_FTPPassword'];
  Connect;
  if Connected then
  begin
   ChangeDir(AsString['Dict_FTPFolder']);
   l_Folder:= TddFileIterator.Create;
   try
    l_Folder.FileMask:= cDictFileMask;
    l_Folder.Directory:= AsString['Dict_Folder'];
    l_Folder.LoadFiles;
    for i:= 0 to Pred(l_Folder.FileList.Count) do
    begin
     l_NewFile:= ExtractFileName(l_Folder.FileList.Strings[i]);
     if l_LastFile < l_NewFile then
     begin
      Put(l_Folder.FileList.Strings[i]);
      l_LastFile:= l_NewFile;
      BaseConfig.MagicString['ExternalDicts', 'LastDictFile'] := l_LastFile;
     end; // l_LastName < l_NewName
    end; // for i
   finally
    l3Free(l_Folder);
   end;
   Disconnect;
  end; // Connected
 finally
  Free;
 end;
end;

{$IFDEF RemoteDict}
procedure TalcuDictionaryManager.SaveDictInfo(aDictInfo: TRemoteDictEditQuery);
var
 l_Stream: TStream;
 l_IsPrivate: TIsPrivate;
 l_IsNonperiodic: TIsNonperiodic;
 l_NameR, l_NameE, l_NameS: String;
 l_Version: Integer;
begin
 if (f_WorkMode = alcu_dmMaster) and (TdaDictionaryType(aDictInfo.DictType) in DictsToSave) then
 begin
  DictServer(CurrentFamily).Family:= aDictInfo.Family;
  DictServer(CurrentFamily).Dict[TdaDictionaryType(aDictInfo.DictType)].RootNode;
  l_Stream := Tl3FileStream.Create(DictListFileName(aDictInfo.DictType), l3_fmAppend);
  try
   case TOperActionType(aDictInfo.Operation) of
    atAdd    : WriteAddOperation(aDictInfo, l_Stream);
    atDelete : WriteDeleteOperation(aDictInfo, l_Stream);
    atEdit   : WriteEditOperation(aDictInfo, l_Stream);
    atMove   : WriteMoveOperation(aDictInfo, l_Stream);
   end;
  finally
   l3Free(l_Stream);
  end; 
 end; // aDictInfo.DictInfo.DictType in DictsToSave
end;
{$EndIF RemoteDict}

procedure TalcuDictionaryManager.SetDicts(aDicts: Integer);
var
 i: Integer;
begin
 for i:= 0 to 31 do
  if l3TestBit(aDicts, i) then
   Include(f_DictsToSave, TdaDictionaryType(Succ(i)));
end;

procedure TalcuDictionaryManager.WorkUpDictInfo(aFamily, aDictType, aOperation: Integer; aID, aParentID, aNextID :
    LongInt; aNameR, aNameE, aNameS: String; aIsPrivate: TIsPrivate; aNonperiodic: TIsNonperiodic);
var
 l_Rec: TDictMessageRec;
 l_ParentNode: Il3Node;
 l_Dict: TdaDictionaryType;
begin
  l_Dict:= TdaDictionaryType(aDictType);
  l_ParentNode:= l3FindNodeByHandle(DictServer(CurrentFamily).DictRootNode[l_Dict], aParentID);
  case TOperActionType(aOperation) of
   atAdd : DictServer(CurrentFamily).Dict[l_Dict].AddDictNode(aID, l3PCharLen(aNameR), l3PCharLen(aNameE), l3PCharLen(aNameS), l_ParentNode, aIsPrivate, aNonperiodic);
   atDelete: DictServer(CurrentFamily).Dict[l_Dict].DelDictItem(aID);
   atEdit: DictServer(CurrentFamily).Dict[l_Dict].EditDictItem(aID, l3PCharLen(aNameR), l3PCharLen(aNameE), l3PCharLen(aNameS), aIsPrivate, aNonperiodic);
   atMove: ;
  end; // TOperActionType(Operation)
 l_Rec.Family := aFamily;
 l_Rec.DictType:= l_Dict;
 l_Rec.Operation:= TOperActionType(aOperation);
 l_Rec.ID:= aID;
 l_Rec.ParentID:= aParentID;
 l_Rec.NextID:= aNextID;
 DictServer(CurrentFamily).SendNotify(l_Rec, 65000);
end;

{$IFDEF RemoteDict}
procedure TalcuDictionaryManager.WriteAddOperation(aDictInfo: TRemoteDictEditQuery; aStream: TStream);
begin
 WriteLnString(aStream, '');
 WriteLnString(aStream, '[ADD]');
 WriteLnString(aStream, GetFullPath(aDictInfo));
end;

procedure TalcuDictionaryManager.WriteDeleteOperation(aDictInfo: TRemoteDictEditQuery; aStream: TStream);
var
 l_NextPath: String;
begin
 WriteLnString(aStream, '');
 WriteLnString(aStream, '[DEL]');
 WriteLnString(aStream, GetFullPath(aDictInfo));
 l_NextPath:= GetNextPath(aDictInfo);
 if l_NextPath <> '' then
 begin
  WriteLnString(aStream, '[ADD]');
  WriteLnString(aStream, l_NextPath);
 end;
end;

procedure TalcuDictionaryManager.WriteEditOperation(aDictInfo: TRemoteDictEditQuery; aStream: TStream);
begin
 WriteLnString(aStream, '');
 WriteLnString(aStream, '[DEL]');
 WriteLnString(aStream, GetPrevPath(aDictInfo));
 WriteLnString(aStream, '[ADD]');
 WriteLnString(aStream, GetFullPath(aDictInfo));
end;
{$EndIF RemoteDict}

procedure TalcuDictionaryManager.WriteLnString(aStream: TStream; aStr: String);
var
 l_Str: String;
begin
 l_Str:= aStr + #13#10;
 aStream.Write(l_Str[1], Length(l_Str));
end;

{$IFDEF RemoteDict}
procedure TalcuDictionaryManager.WriteMoveOperation(aDictInfo: TRemoteDictEditQuery; aStream: TStream);
begin
 // TODO -cMM: TalcuDictionaryManager.WriteAddOperation default body inserted
end;
{$EndIF RemoteDict}

end.
