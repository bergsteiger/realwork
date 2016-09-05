unit rtGrinder;

{ $Id: rtGrinder.pas,v 1.29 2016/08/11 11:40:24 lukyanets Exp $}

// $Log: rtGrinder.pas,v $
// Revision 1.29  2016/08/11 11:40:24  lukyanets
// Полчищаем dt_user
//
// Revision 1.28  2016/08/11 10:42:03  lukyanets
// Полчищаем dt_user
//
// Revision 1.27  2016/06/16 05:38:52  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.26  2016/04/25 11:23:21  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.25  2015/12/22 12:22:04  lukyanets
// Убираем служебных пользователей
//
// Revision 1.24  2015/11/26 09:31:19  lukyanets
// КОнстанты переехали
//
// Revision 1.23  2015/09/01 13:39:06  lukyanets
// Не собиралось
//
// Revision 1.22  2015/09/01 12:31:13  lukyanets
// Заготовки к Postgress
//
// Revision 1.21  2015/04/30 11:37:28  lukyanets
// Заготовки Большого Брата
//
// Revision 1.20  2015/04/30 11:14:39  lukyanets
// Заготовки Большого Брата
//
// Revision 1.19  2015/04/29 04:44:35  fireton
// - не собиралось
//
// Revision 1.18  2015/04/07 09:08:09  lukyanets
// Изолируем домашний каталог
//
// Revision 1.17  2015/04/07 07:35:58  lukyanets
// Изолируем HT
//
// Revision 1.16  2015/04/02 12:46:24  lukyanets
// Изолируем регион
//
// Revision 1.15  2015/03/31 14:08:45  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.14  2014/04/18 05:48:06  fireton
// - ISab переехал в dtIntf
//
// Revision 1.13  2014/02/20 08:05:34  fireton
// - исправляем сборку
//
// Revision 1.12  2013/04/15 09:52:15  fireton
// - невозможно было изменить регион, только назначить с нуля
//
// Revision 1.11  2010/02/24 11:42:37  fireton
// - забыл покомитеть
//
// Revision 1.10  2010/01/22 10:37:35  narry
// - Обновление
//
// Revision 1.9  2008/03/04 08:27:30  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.8  2007/12/03 09:06:45  fireton
// - не компилировалось
//
// Revision 1.7  2007/06/19 09:48:50  fireton
// - переработан механизм обновления директорий пользователей
//
// Revision 1.6  2007/05/07 08:09:41  fireton
// - cBadRegion вынесен в отдельный модуль
//
// Revision 1.5  2007/04/24 06:59:22  fireton
// - fix: Батыгина Татьяна исключена из "тверских"
//
// Revision 1.4  2007/04/23 09:35:37  fireton
// - add: корректируем пути к таблицам стилей
//
// Revision 1.3  2007/04/17 11:42:13  fireton
// - переименовываем и пользовательские директории тоже
//
// Revision 1.2  2007/04/09 11:39:01  fireton
// - забыл исправить после отладки
//
// Revision 1.1  2007/04/09 11:31:43  fireton
// - первый коммит
//

interface
uses
 l3Base,
 l3ProtoObject,
 l3FileUtils,

 daInterfaces,
 daTypes,

 DT_Types,
 DT_Const
 ;

type
 TIntervalRec = record
  FromID, ToID: Longword;
 end;

 TGrinder = class(Tl3ProtoObject)
 private
  f_Region: Byte;
  procedure ChangeRegion(aFrom, aTo: TdaUserID; aRegion: TdaRegionID);
  procedure CorrectAllIntervalIDs;
  procedure CorrectFREEForIntervalRegion(aIntervals: array of TIntervalRec);
  procedure CorrectMaxUserID;
  procedure CorrectRegionInterval(aRegion: TdaRegionID; aIntervals: array of TIntervalRec);
  procedure CorrectUserIDInTable(IsMainTable: Boolean; aTable: Byte; aFieldNo: Smallint; aFrom, aTo: TdaUserID; aRegion:
      TdaRegionID);
  procedure ProcessHomeDirectories(aFrom, aTo: TdaUserID; aRegion: TdaRegionID);
 public
  constructor Create;
  procedure Grind;
 end;

const
 rcNPP     =   0; // это мы
 rcTver    =   1; // НПП Тверь
 rcSaratov =  46;
 rcPenza   =  38;

 iaTver: array[1..4] of TIntervalRec =
    ((FromID:130; ToID:148),(FromID:180; ToID:227),(FromID:289; ToID:289),(FromID:443; ToID:492));
 iaSaratov: array[1..2] of TIntervalRec =
    ((FromID:293; ToID:342),(FromID:376; ToID:425));
 iaPenza: array[1..1] of TIntervalRec =
    ((FromID:493; ToID:542));
 // для "самостийных" регионов - корректируется все кроме сервера и супервизора
 iaSelfSufficient: array[1..2] of TIntervalRec =
    ((FromID:usSupervisor+1; ToID:usServerService-1),(FromID:usServerService+1; ToID: $FFFFFFFF));

implementation

uses
 SysUtils,

 l3IniFile,

 HT_Const,

 daDataProvider,
 daSchemeConsts,

 dtIntf,
 DT_Serv,
 dt_BBLog,
 DT_ATbl,
 DT_DictConst,
 DT_Sab,
 DT_Misc,
 DT_Stage,
 DT_Log,
 DT_Free,
 dt_UserConst;

const
 MAX_DWRD = $FFFFFFFF;

function ReplaceRegion(aUserID: TdaUserID; aRegionID: TdaRegionID): TdaUserID;
begin
 Result := (aUserID and $00FFFFFF) or (aRegionID shl 24);
end;

constructor TGrinder.Create;
begin
 inherited Create;
 f_Region := GlobalDataProvider.RegionID;
end;

procedure TGrinder.ChangeRegion(aFrom, aTo: TdaUserID; aRegion: TdaRegionID);
var
 l_Sab: ISab;
begin
 // Модифицируем таблицу USERS
 CorrectUserIDInTable(True, Ord(mtUsers), dtIDFld, aFrom, aTo, aRegion);
 // Модифицируем таблицу PASS
 CorrectUserIDInTable(True, Ord(mtPass), pssUserID_fld, aFrom, aTo, aRegion);
 // Модифицируем таблицу GULNK
 CorrectUserIDInTable(True, Ord(mtGULnk), dtIDFld, aFrom, aTo, aRegion);
 // Модифицируем таблицу BBLOG
 CorrectUserIDInTable(True, Ord(mtBBLog), bbID_Ext, aFrom, aTo, aRegion);

 // Модифицируем таблицу STAGE
 CorrectUserIDInTable(False, Ord(ftStage), stAuthor_Key, aFrom, aTo, aRegion);
 // Модифицируем таблицу LOG
 CorrectUserIDInTable(False, Ord(ftLog), lgAuthor_Key, aFrom, aTo, aRegion);
 // Модифицируем таблицу DT#9
 CorrectUserIDInTable(False, Ord(ftDt9), crAuthorFld, aFrom, aTo, aRegion);

 // переименовываем юзерские home-директории и корректируем пути к таблицам стилей
 ProcessHomeDirectories(aFrom, aTo, aRegion);
end;

procedure TGrinder.CorrectAllIntervalIDs;
begin
 CorrectRegionInterval(rcTver,    iaTver);
 CorrectRegionInterval(rcSaratov, iaSaratov);
 CorrectRegionInterval(rcPenza,   iaPenza);
end;

procedure TGrinder.CorrectFREEForIntervalRegion(aIntervals: array of TIntervalRec);
var
 l_FreeTbl: TFreeTbl;
 I: Integer;
 l_Interval: TIntervalRec;
begin
 l_FreeTbl := GlobalHtServer.FreeTbl[MainTblsFamily];
 l_FreeTbl.ResetFreeTblNum(MainTblNames[mtUsers], 1, cMaxUserID);
 for I := Low(aIntervals) to High(aIntervals) do
 begin
  l_Interval := aIntervals[I];
  // выкидываем "использованные" интервалы
  l_FreeTbl.ExcludeFreeNumsFromTable(MainTblNames[mtUsers], l_Interval.FromID, l_Interval.ToID);
 end;
 // исключаем также супервизора и сервер
 l_FreeTbl.ExcludeFreeFromTable(MainTblNames[mtUsers], usSupervisor);
 l_FreeTbl.ExcludeFreeFromTable(MainTblNames[mtUsers], usServerService);
end;

procedure TGrinder.CorrectMaxUserID;
var
 l_Sab: ISab;
 l_Temp: Longword;
 l_TblName: string[8];
begin
 l_Sab := MakeSab(GlobalHtServer.FreeTbl[MainTblsFamily]);
 try
  l_Temp := MAX_DWRD;
  l_Sab.Select(ftLimit, l_Temp);
  System.FillChar(l_TblName, SizeOf(l_TblName), 0);
  l_TblName := MainTblNames[mtUsers];
  l_Sab.SubSelect(ftTblName, l_TblName[1]);
  l_Temp := cMaxUserID;
  GlobalHtServer.FreeTbl[MainTblsFamily].ModifyRecs(l_Sab.HTSab, ftLimit, @l_Temp);
 finally
  l_Sab := nil;
 end;
end;

procedure TGrinder.CorrectRegionInterval(aRegion: TdaRegionID; aIntervals: array of TIntervalRec);
var
 I: Integer;
 l_Interval: TIntervalRec;
begin
 for I := Low(aIntervals) to High(aIntervals) do
 begin
  l_Interval := aIntervals[I];
  ChangeRegion(l_Interval.FromID, l_Interval.ToID, aRegion);
 end;
end;

procedure TGrinder.CorrectUserIDInTable(IsMainTable: Boolean; aTable: Byte; aFieldNo: Smallint; aFrom, aTo: TdaUserID;
    aRegion: TdaRegionID);
var
 l_Table  : TPrometTbl;
 l_Sab    : ISab;
 l_HStub  : Pointer;
 l_Main   : TMainTbls;
 l_Fam    : TFamTbls;
 l_Passw  : TPassStr;
 l_Name   : TTblNameStr;
 l_Family : TdaFamilyID;
 l_BBOper : Word;
 l_TmpID  : TdaUserID;
 l_ZeroUserID  : TdaUserID;

 function ModifyUserIDInTable(gRecNo : LongInt; fpRecord : Pointer) : MFUNC_RET;
 var
  l_UserID: TdaUserID;
 begin
  l_Table.GetFieldFromRecord(fpRecord, aFieldNo, l_UserID);
  l_UserID := ReplaceRegion(l_UserID, aRegion);
  l_Table.PutFieldToRecord(fpRecord, aFieldNo, l_UserID);
  Result := MFUNC_SUCCESS;
 end;

begin
 if IsMainTable then
  l_Family := MainTblsFamily
 else
  l_Family := CurrentFamily;
 l_Table := TPrometTbl.Create(l_Family, aTable);
 try
  l_Sab := MakeSab(l_Table);
  try
   if aFrom >= usAdminReserved then
    l_Sab.SelectAll
   else
    l_Sab.Select(aFieldNo, aFrom, aTo);
   if IsMainTable and (l_Main = mtBBLog) then // для BBLOG нужно сделать дополнительную выборку
   begin
    l_BBOper := Word(da_oobSessionBegin);
    l_Sab.SubSelect(bbID_Operation, l_BBOper);
   end;
   // исключаем супервизора и сервер из выборки
   l_TmpID := usSupervisor;
   l_Sab.SubSelect(aFieldNo, l_TmpID, NOT_EQUAL);
   l_TmpID := usServerService;
   l_Sab.SubSelect(aFieldNo, l_TmpID, NOT_EQUAL);
   l_ZeroUserID := 0;
   l_TmpID := usAdminReserved - 1;
   l_Sab.SubSelect(aFieldNo, l_ZeroUserID, l_TmpID);
   // модифицируем ID...
   l_HStub := HTStub3(@ModifyUserIDInTable);
   try
    l_Table.ModifyRecs(l_Sab.HTSab, l_HStub);
   finally
    HTStubFree(l_HStub);
   end;
  finally
   l_Sab := nil;
  end;
 finally
  l3Free(l_Table);
 end;
end;

procedure TGrinder.Grind;
begin
 if GlobalDataProvider.IsRegionExists(f_Region) then
 begin
  case f_Region of
   rcNPP  : CorrectAllIntervalIDs;
   rcTver :
    begin
     CorrectAllIntervalIDs;
     CorrectFREEForIntervalRegion(iaTver);
    end;
   rcSaratov :
    begin
     CorrectAllIntervalIDs;
     CorrectFREEForIntervalRegion(iaSaratov);
    end;
   rcPenza :
    begin
     CorrectAllIntervalIDs;
     CorrectFREEForIntervalRegion(iaPenza);
    end;
  else
   CorrectRegionInterval(f_Region, iaSelfSufficient);
  end;
 end
 else
  Exception.Create('Неверный код региона!');
end;

procedure TGrinder.ProcessHomeDirectories(aFrom, aTo: TdaUserID; aRegion: TdaRegionID);
var
 l_ID         : TdaUserID;
 l_HomePath   : TPathStr;
 l_NewHomePath: TPathStr;
 l_UserIni    : TCfgList;
 l_IniFilename: string;
 l_StylePath  : string;
 l_SR         : TSearchRec;
 l_Res        : Integer;
 l_NumS       : string;
begin
 l_Res := FindFirst(GlobalDataProvider.GlobalHomePath + 'USR#*', faAnyFile, l_SR);
 while l_Res = 0 do
 begin
  l_NumS := '$'+Copy(l_SR.Name, 5, MaxInt);
  l_ID   := StrToIntDef(l_NumS, 0);
  if (l_ID >= aFrom) and (l_ID <= aTo) then
  begin
   l_HomePath := GlobalDataProvider.GetHomePathName(l_ID);
   l_NewHomePath := GlobalDataProvider.GetHomePathName(ReplaceRegion(l_ID, aRegion));
   RenDir(l_HomePath, l_NewHomePath);
   l_IniFilename := ConcatDirName(l_NewHomePath, 'User.ini');
   if FileExists(l_IniFileName) then
   begin
    l_UserIni := TCfgList.Create(l_IniFilename);
    try
     l_UserIni.Section := 'PREFERENCES';
     l_StylePath := l_UserIni.ReadParamStrDef('StyleTable', '');
     if Pos(UpperCase(l_HomePath), UpperCase(l_StylePath)) > 0 then
      l_UserIni.WriteParamStr('StyleTable', ConcatDirName(l_NewHomePath, ExtractFileName(l_StylePath)));
    finally
     l3Free(l_UserIni);
    end;
   end;
  end;
  l_Res := FindNext(l_SR);
 end;
end;

end.
