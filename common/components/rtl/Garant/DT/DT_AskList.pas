unit DT_AskList;

{ $Id: DT_AskList.pas,v 1.10 2015/04/07 09:08:35 lukyanets Exp $ }

// $Log: DT_AskList.pas,v $
// Revision 1.10  2015/04/07 09:08:35  lukyanets
// Изолируем домашний каталог
//
// Revision 1.9  2014/02/13 12:14:51  lulin
// - рефакторим безликие списки.
//
// Revision 1.8  2010/08/04 08:29:27  voba
// - k: 229672814
//
// Revision 1.7  2010/04/02 12:08:47  narry
// - новое свойство: папка сохранения запросов
// - создание глобального объекта при первом обращении
//
// Revision 1.6  2009/12/11 15:56:09  lulin
// {RequestLink:172984520}.
//
// Revision 1.5  2009/12/11 14:14:49  lulin
// {RequestLink:172984520}.
//
// Revision 1.4  2009/10/19 11:45:09  voba
// - избавляемся от старой библиотеки регулярных выражений
//
// Revision 1.3  2009/02/09 11:52:40  voba
// - bug fix загрузка пустой строки
//
// Revision 1.2  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.1.2.4.2.4  2008/12/03 07:59:07  fireton
// - перевод поисков на TdtQuery
//
// Revision 1.1.2.4.2.3  2008/11/21 11:52:18  fireton
// - конвертация старых сохраненных выборок  в новый формат
//
// Revision 1.1.2.4.2.2  2008/11/01 14:15:38  voba
// no message
//
// Revision 1.1.2.4.2.1  2008/10/31 09:57:13  voba
// no message
//
// Revision 1.1.2.4  2008/10/16 07:53:48  voba
// no message
//
// Revision 1.1.2.3  2008/10/10 06:43:31  voba
// no message
//
// Revision 1.1.2.2  2008/10/06 07:20:24  voba
// no message
//
// Revision 1.1.2.1  2008/10/01 13:36:21  voba
// no message
//
// Revision 1.1  2008/09/18 07:12:29  voba
// - move AskList to DT_AskList, FormulaProcessor to DT_FormulaProcessor
//


interface
uses
 SysUtils,
 l3Types, l3_Base, l3Base,
 l3LongintList, l3String,
 l3Stream,
 l3Interfaces, l3InternalInterfaces,
 l3ObjectRefArray,
 l3ChangeNotifier,
 l3NotifyPtrList,
 l3ProtoObject,
 Dt_Types,
 DT_Query,
 SavedQuery,
 QueryListPrim
 ;

type
 TQueryList = class(TQueryListPrim, Il3HandledStringList)
 private
  f_QueriesPath: String;
  procedure pm_SetQueriesPath(const Value: String);
 protected
  function  pm_GetHandle(anIndex: Integer): Integer;
  procedure pm_SetHandle(anIndex: Integer; aValue: Integer);

  function  GetStrItems(anIndex: Integer): Tl3PCharLen;
  procedure SetStrItems(anIndex: Integer; const aValue: Tl3PCharLen);

  function  pm_GetCount : Integer;
  function  Il3HandledStringList.pm_GetItems = GetStrItems;
  procedure Il3HandledStringList.pm_setItems = setStrItems;

  procedure DoDelete(Index: Integer); override;
  procedure DirectInsert(anIndex: Integer; const aData : TSavedQuery); override;
 public
  constructor Create;

  procedure LoadAsksList;

  //procedure DeleteEqualNameAsks;

  function  SaveQuery(const aName : String; aQuery : TdtQuery) : TSavedQuery;

  procedure DelSQuery(aSavedQuery : TSavedQuery); overload;
  procedure DelSQuery(aHandle : Longint);         overload;
  function  GetSQueryByHandle(aHandle : Integer) : TSavedQuery;

  function  FindByName(const aName : String; var aSavedQuery : TSavedQuery) : boolean;
  property QueriesPath: String read f_QueriesPath write pm_SetQueriesPath;
 end;

function g_dtQueryList : TQueryList;

implementation

uses
 Classes,
 l3FileUtils,
 daDataProvider,
 dt_Err
 ;

type
 PSavedQuery = ^TSavedQuery;

const
 p_dtQueryList : TQueryList = nil;

function g_dtQueryList : TQueryList;
begin
 if p_dtQueryList = nil then
 begin
  p_dtQueryList := TQueryList.Create;
  p_dtQueryList.QueriesPath:= ConcatDirName(GlobalDataProvider.CurHomePath, 'queries');
 end;
 Result:= p_dtQueryList;
end;

{ TQueryList }

constructor TQueryList.Create;
begin
 inherited Create;
 Sorted := True;
end;

procedure TQueryList.LoadAsksList;
var
 lFPStub : Pointer;

 function lFileProcessingFunc(const aFileName: string): Boolean;
 var
  lSQ : TSavedQuery;
 begin
  Result := True;
  lSQ := TSavedQuery.CreateFromFile(aFileName);
  try
   Add(lSQ);
  finally
   l3Free(lSQ);
  end;
 end;

begin
 Clear;
 //ConvertOldSavedQueries;
 lFPStub := l3LocalStub(@lFileProcessingFunc);
 try
  ProcessFilesWithMask(QueriesPath, 'q*.sqr', TFileProcessingFunc(lFPStub));
 finally
  l3FreeLocalStub(lFPStub);
 end;
end;

function TQueryList.SaveQuery(const aName : String; aQuery : TdtQuery) : TSavedQuery;
var
 lSQ : TSavedQuery;
begin
 lSQ := TSavedQuery.Create(aName);
 try
  lSQ.FileName:= GetUniqFileName(QueriesPath,'q','.sqr');
  lSQ.Save(aQuery);
  Add(lSQ);
  Result := lSQ;
 finally
  l3Free(lSQ);
 end;

end;

procedure TQueryList.DelSQuery(aSavedQuery : TSavedQuery);
begin
 aSavedQuery.DeletePersist;
 Delete(IndexOf(aSavedQuery));
end;

procedure TQueryList.DelSQuery(aHandle : Longint);
begin
 DelSQuery(GetSQueryByHandle(aHandle));
end;

function TQueryList.GetSQueryByHandle(aHandle : Integer) : TSavedQuery;
begin
 // никому не рассказываем что aHandle это и есть указатель на TSavedQuery
 Result := TSavedQuery(aHandle);
end;

function  TQueryList.FindByName(const aName : String; var aSavedQuery : TSavedQuery) : boolean;
var
 I : Integer;
 lCompRes : integer;
begin
 Result := False;
 for I := 0 to Pred(Count) do
 begin
  lCompRes := l3Compare(aName, TSavedQuery(Items[I]).Name);
  if lCompRes = 0 then
  begin
   Result := True;
   aSavedQuery := TSavedQuery(Items[I]);
   Break;
  end
  else
  if lCompRes < 0 then
   Break;
 end;
end;

function TQueryList.pm_GetHandle(anIndex: Integer): Integer;
begin
 Result := Integer(Items[anIndex]);
end;

procedure TQueryList.pm_SetHandle(anIndex: Integer; aValue: Integer);
begin
 Assert(False,'TQueryList.pm_SetHandle not defined');
end;

function  TQueryList.GetStrItems(anIndex: Integer): Tl3PCharLen;
begin
 Result := l3PCharLen(TSavedQuery(Items[anIndex]).Name);
end;

procedure TQueryList.SetStrItems(anIndex: Integer; const aValue: Tl3PCharLen);
begin
 Assert(False,'TQueryList.SetStrItems not defined');
end;

function TQueryList.pm_GetCount : Integer;
begin
 Result := Count;
end;

procedure TQueryList.DoDelete(Index: Integer);
begin
 Changing;
 try
  CallNotify(ntDelete, Index);
  inherited;
 finally
  Changed;
 end;//try..finally
end;

procedure TQueryList.DirectInsert(anIndex: Integer; const aData: TSavedQuery);
begin
 Changing;
 try
  inherited;
  CallNotify(ntInsert, anIndex);
 finally
  Changed;
 end;//try..finally
end;

procedure TQueryList.pm_SetQueriesPath(const Value: String);
begin
 Assert(Value <> '');
 f_QueriesPath := Value;
 ForceDirectories(f_QueriesPath);
end;

initialization

finalization
 l3Free(p_dtQueryList);
end.


(*
procedure TQueryList.DeleteEqualNameAsks;
var
 AskFile  : TCfgList;
 FlName   : TPathStr;
 StrDate  : ShortString;
 I,
 LastItem : LongInt;
 CurDate,
 LastDate : LongInt;
begin
 if Count <= 1 then
  exit;

 AskFile:=TCfgList.Create(GlobalDataProvider.CurHomePath+AskFileName);
 try
  LastItem:=Count-1;
  AskFile.Section:='ASK'+IntToStr(DataInt[LastItem]);
  AskFile.ReadParamStr('File',FlName);
  LastDate:=FileAge(GlobalDataProvider.CurHomePath+FlName);
  if not AskFile.ReadParamStr('Date',StrDate) then
   AskFile.WriteParamStr('Date',DateTimeToStr(FileDateToDateTime(LastDate)));
  for I:=Count-2 Downto 0 do
   begin
    AskFile.Section:='ASK'+IntToStr(DataInt[I]);
    if StrComp(Strings[LastItem],Strings[I]) = 0 then
     begin
      AskFile.Section:='ASK'+IntToStr(DataInt[I]);
      AskFile.ReadParamStr('File',FlName);
      CurDate:=FileAge(GlobalDataProvider.CurHomePath+FlName);
      if CurDate > LastDate then
       begin
        DelAskOnIndex(LastItem);
        LastItem:=I;
        LastDate:=CurDate;

        AskFile.Section:='ASK'+IntToStr(DataInt[I]);
        if not AskFile.ReadParamStr('Date',StrDate) then
         AskFile.WriteParamStr('Date',DateTimeToStr(FileDateToDateTime(LastDate)));
       end
      else
       begin
        DelAskOnIndex(I);
        Dec(LastItem);
       end;
     end
    else
     begin
      LastItem:=I;
      AskFile.Section:='ASK'+IntToStr(DataInt[LastItem]);
      AskFile.ReadParamStr('File',FlName);
      LastDate:=FileAge(GlobalDataProvider.CurHomePath+FlName);
      if not AskFile.ReadParamStr('Date',StrDate) then
       AskFile.WriteParamStr('Date',DateTimeToStr(FileDateToDateTime(LastDate)));
     end;
   end;
 finally
  l3Free(AskFile);
 end;
end;
*)
