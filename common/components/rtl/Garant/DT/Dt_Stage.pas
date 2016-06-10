Unit Dt_Stage;

{ $Id: Dt_Stage.pas,v 1.86 2016/04/18 11:48:06 lukyanets Exp $ }
// $Log: Dt_Stage.pas,v $
// Revision 1.86  2016/04/18 11:48:06  lukyanets
// Готовимся переводить UserManager
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.85  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.84  2015/04/03 11:30:43  lukyanets
// Изолируем HT
//
// Revision 1.83  2015/03/31 14:09:11  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.82  2014/09/09 05:29:05  lukyanets
// Не собиралось. Переименовали CurUserID в UserID
//
// Revision 1.81  2014/09/05 11:51:48  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.80  2013/12/03 09:55:07  voba
// - збавляемся от степановских итераторов
//
// Revision 1.79  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.78  2013/04/19 15:27:38  lulin
// - портируем.
//
// Revision 1.77  2013/01/17 07:56:29  fireton
// - погорячились с удалением "мусорных" стадий
//
// Revision 1.76  2013/01/16 11:24:41  fireton
// - избавляемся от "мусорных" стадий
//
// Revision 1.75  2013/01/16 09:36:57  voba
// - K:320745193
//
// Revision 1.74  2012/10/25 12:35:17  voba
// -k:406127456
//
// Revision 1.73  2011/11/22 07:55:30  voba
// - k : 301695085
//
// Revision 1.72  2010/11/30 11:47:08  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.71  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.70  2010/03/30 11:13:05  voba
// - add comment
//
// Revision 1.69  2010/03/23 07:37:11  voba
// no message
//
// Revision 1.68  2010/03/23 07:34:26  voba
// - ошибка с upcase строк в кодировке CP_WesternWin
//
// Revision 1.67  2010/03/22 17:52:48  voba
// no message
//
// Revision 1.66  2009/10/14 11:09:14  voba
// - избавляемся от библиотеки mg
//
// Revision 1.65  2009/07/20 12:38:48  voba
// - Засунул renum в атрибуты
//
// Revision 1.64  2009/07/14 12:39:52  voba
// - cc
//
// Revision 1.63  2009/06/23 09:01:38  narry
// - не собиралось
//
// Revision 1.62  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.61  2009/06/08 13:23:25  voba
// - enh. унификация атрибутов. Избавился от псевдоатрибутов atDateNumsChDate, atRelHLink,
//
// Revision 1.60  2009/05/19 12:14:38  voba
// - унификация атрибутов
//
// Revision 1.59  2009/05/08 11:10:08  voba
// - заменил TblH на Handle
//
// Revision 1.58  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.57  2009/03/02 08:16:33  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.56  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.55.8.1  2008/12/22 11:08:12  fireton
// - перевод поисков на TdtQuery
//
// Revision 1.55  2007/12/06 11:40:59  lulin
// - cleanup.
//
// Revision 1.54  2007/11/15 14:18:25  voba
// - chng. procedure TStageTbl.DelDocStage Убрал проверку на DocID = 0
//
// Revision 1.53  2007/10/25 11:10:56  voba
// - cc
//
// Revision 1.52  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.51  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.50  2007/08/14 14:30:09  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.49  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.48  2007/05/25 15:20:07  voba
// - DeleteRecsByKeys теперь возвращает количество удаленных и подывмает exception в случае ошибок
//
// Revision 1.47  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.46  2007/02/22 09:25:26  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.45  2006/08/23 10:15:49  voba
// - merge with b_archi_ifltr_opt
//
// Revision 1.44  2006/06/08 15:54:46  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.43.8.1  2006/06/08 09:08:02  fireton
// - перевод User ID на Longword
//
// Revision 1.43.6.2  2006/06/15 11:30:07  voba
// - merge
//
// Revision 1.43.6.1  2006/05/30 11:50:37  voba
// no message
//
// Revision 1.43  2006/02/17 11:53:25  voba
// - add procedure StagesOnDocs
//
// Revision 1.42  2005/12/15 09:54:41  step
// TStageTbl.StagesInEDateInterval игнорирует убитых юзеров
//
// Revision 1.41  2005/12/14 09:43:48  step
// исправлена TStageTbl.GetDocStagesRecList
//
// Revision 1.40  2005/11/18 10:41:30  step
// TStageTbl.StagesInEDateInterval взвращает ВНЕШНИЕ DocId
//
// Revision 1.39.2.1  2006/02/16 16:13:44  voba
// - add procedure StagesOnDocs
//
// Revision 1.39  2005/11/11 15:19:22  voba
// - del procedure BaseStatistic
// - избавляемся от stDone
//
// Revision 1.38  2005/11/08 16:02:07  step
// из  TStageTbl.StagesInEDateInterval убран пересчет DocId во внешние
//
// Revision 1.37  2005/11/08 15:58:41  step
// new: TStageTbl.StagesInEDateInterval
//
// Revision 1.36  2005/11/08 13:44:24  voba
// - add procedure SetDocStagesRecList
//
// Revision 1.35  2005/11/03 11:28:13  voba
// - заменил  в параметрах функций _Tl3DataList на Tl3CustomDataList
//
// Revision 1.34  2005/03/03 12:14:18  voba
// no message
//
// Revision 1.33  2004/09/30 18:03:07  step
// выделен отдельно метод TStageTbl.FilteredBy
//
// Revision 1.32  2004/09/14 15:58:15  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.31  2004/08/03 08:52:49  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.30  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.29.2.1  2004/06/17 18:03:50  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.29  2004/06/04 12:55:26  voba
// no message
//
// Revision 1.28  2004/03/05 16:56:45  step
// чистка кода
//
// Revision 1.27  2003/04/29 15:46:12  voba
// - добавил новый этап
//
// Revision 1.26  2003/04/07 12:30:55  voba
// no message
//
// Revision 1.25  2003/03/12 12:46:53  demon
// - синтаксис fix
//
// Revision 1.24  2003/03/12 10:35:09  demon
// - del: Внесены изменения в связи с удалением полей
// NoActive и PreActive из таблицы File
//
// Revision 1.23  2003/01/23 16:43:49  demon
// - new: расширил возможности операции HasDocThisStage у объекта TStageTbl
//
// Revision 1.22  2002/09/11 14:46:45  voba
// -new behavior : добавлен этам "разбивка на блоки"
// -new behavior : отключен запрет закрытия этапа открытого другим пользователем (не админом)
//
// Revision 1.21  2001/11/21 12:44:45  demon
// - new behavior: add function HasDocThisStage
//
// Revision 1.20  2001/07/06 14:38:15  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.19  2001/05/29 06:38:10  demon
// - cleanup (after Voba)
//
// Revision 1.18  2001/05/29 06:34:43  voba
// -new : добавил тип PStageFullRec
//
// Revision 1.17  2001/05/28 12:22:37  demon
// - new behavior: function GetDocStagesRecList(aList : _Tl3DataList)
// (list contains structures TStageFullRec)
//
// Revision 1.16  2001/02/12 14:15:44  demon
// - exclude function of setting VInclude when document set Done
//
// Revision 1.15  2001/02/05 09:39:28  demon
// - add procedure DelDocStage, for one stage removing
//
// Revision 1.14  2000/12/15 15:36:17  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
Uses
   SysUtils,
   l3Date, l3DatLst,
   HT_Const,
   Dt_Types, Dt_Const,
   dt_Sab,
   Dt_ATbl,
   dt_Link,
   Dt_Renum;
Const
 stDocID_Key       = 1;
 stType_Key        = 2;
 stBDate_Key       = 3;
 stEDate_Key       = 4;
 stAuthor_Key      = 5;
 stDocType_Key     = 6; {уникальный ключ}

 StageReportFileName = 'Statist.txt';

Type
 PStageFullRec = ^TStageFullRec;
 TStageFullRec = record
                  DocID  : TDocID;
                  StType : Byte;
                  BDate  : TStDate;
                  EDate  : TStDate;
                  Author : TUserID;
                 end;

type
 TStagesStrOrdRec = record
  rName : ShortString;
  rStageID : TStageType;
 end;

const
 cStagesStringUserOrder : Array[1..14] of TStagesStrOrdRec = (
                                                       (rName : 'Ввод'; rStageID : stInput),
                                                       (rName : 'Форматирование'; rStageID : stDocFormat),
                                                       (rName : 'Вычитка'; rStageID : stRead),
                                                       (rName : 'Вычитка по офиц. публикации'; rStageID : stORead),
                                                       (rName : 'Исправление'; rStageID : stEdit),
                                                       (rName : 'Исправление по офиц. публикации'; rStageID : stOEdit),
                                                       (rName : 'Классификация'; rStageID : stClass),
                                                       (rName : 'Ключевые слова'; rStageID : stKW),
                                                       (rName : 'Начальная Юр. обработка'; rStageID : stUrObr),
                                                       (rName : 'Окончательная Юр. обработка'; rStageID : stFinUrObr),
                                                       (rName : 'Полнотекстовая редакция'; rStageID : stFullEdition),
                                                       (rName : 'Подключение внешних объектов';  rStageID : stExternalObj),
                                                       (rName : 'Аннотация';  rStageID : stAnno),
                                                       (rName : 'Классификация аннотации'; rStageID : stAnnoClass)
                                                       );
Type
 TStageTbl = Class(TDocAttrTbl)
  protected
   //fReportFile : TFileName;
   Function    GetIntervalSab(BeginDate,EndDate : TStDate;
                              StageFlag : TStageFlag) : Sab;
   {* - используется в GetDocOnStages которая используется в парне}
   //Procedure   BeginStage(aDocID : TDocID; aStage : TStageType);
   //Procedure   EndStage(aDocID : TDocID; aStage : TStageType);
   //Procedure   DocumentDone;
  public
   Constructor Create(aFamID : TFamilyID); Reintroduce;

   //Procedure   GetDocStages(Var BeginSet,EndSet : TStageSet);
   Procedure   GetDocStagesRecList(aDocID : TDocID; aList : Tl3CustomDataList);
   procedure   SetDocStagesRecList(aDocID : TDocID; aList : Tl3CustomDataList);
   Function    PutStageRec(aDocID : TDocID; aStage : TStageType; aBeginDate, aEndDate : TStDate; aUserID : TUserID) : Boolean;

   //Procedure   SetDocStages(aDocID : TDocID; BeginSet,EndSet : TStageSet);
   //Procedure   DelDocStage(aStage : TStageType);
   //function    FilteredBy(aBeginDate,
   //                       aEndDate: TStDate;
   //                       aStageFlag: TStageFlag;
   //                       aUserID: TUserID;
   //                       aStage: TStageType): SAB;
   //Function    GetStatisticDocSab(BeginDate,EndDate : TStDate; StageFlag : TStageFlag;
   //                               UserID : TUserID; Stage : TStageType) : SAB;

   Function    GetDocOnStages(BeginDate,EndDate : TStDate;
                              BeginSet,EndSet,NotEndSet : TStageSet) : Sab;
   {* - используется в парне}
   Function    GetStagesOnDoc(aDocID : TDocID) : Sab;
   //Function    GetStagesOnDocs(aDocSab : Sab) : Sab;

   //function    HasDocThisStage(aDocID : TDocID; aStage : TStageType) : Boolean; overload;
   //function    HasDocThisStage(aDocID : TDocID; aStage : TStageType;
   //                            var AbsNum : LongInt) : Boolean; overload;

   //Property    ReportFile : TFileName read fReportFile write fReportFile;
 end;

 function StageNameByID(aStageID : TStageType) : String;

 function StageTypeToBitIndex(const aStageID: TStageType): Integer;

implementation
uses
 WinTypes, Classes,

 l3Base, m0Const,

 daDataProvider,
 daSchemeConsts,

 HT_Dll,

 dt_AttrSchema,
 dt_UserConst, dt_DictConst,
 Dt_List, Dt_Serv, Dt_Err, Dt_Doc, Dt_Dict,
 Dt_User, Dt_Log,
 Dt_LinkServ;

function StageNameByID(aStageID : TStageType) : String;
var
 I : integer;
begin
 Result := '';
 for I := low(cStagesStringUserOrder) to high(cStagesStringUserOrder) do
  with cStagesStringUserOrder[I] do
   if rStageID = aStageID then
   begin
    Result := rName;
    Break;
   end;
end;

(******************************** TStageTbl *********************************)
Type
 PStageRec = ^TStageRec;
 TStageRec = Record
              StType : Byte;
              BDate,
              EDate  : TStDate;
             end;

 TStageKeyRec = Record
                 DocID : TDocID;
                 Stage : TStageType;
                end;

Const
 StFldCount = 3;
 StFldArr : Array [1..StFldCount] of SmallInt = (stType_Key,stBDate_Key,stEDate_Key);

Constructor TStageTbl.Create(aFamID : TFamilyID);
Begin
 if aFamID = MainTblsFamily then
  Abort;
 inherited Create(aFamID, atStages);
end;

function TStageTbl.PutStageRec(aDocID : TDocID; aStage : TStageType; aBeginDate, aEndDate : TStDate; aUserID : TUserID) : Boolean;
{- возвращает True если изменение состоялось}
Var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
 TmpDate : TStDate;
 //lWasChanged : Boolean;
begin
 Result := False;
 if aBeginDate = 1 then aBeginDate := CurrentDate;
 if aEndDate = 1 then aEndDate := CurrentDate;
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);
 if (aBeginDate = 0) and (aEndDate = 0) then
  exit; // наверное надо стирать запись, но в нынешнем интерфейсе такого не бывает
 with fTable do
 begin
 ClearFullRec;
 PutToFullRec(stDocID_Key, aDocID);
 PutToFullRec(stType_Key,aStage);
 AbsNum:=Ht(htRecordByUniq(Nil,Handle,stDocType_Key,FullRecord,@RecH));

 if (aUserID <= 0) then
  aUserID := GlobalDataProvider.UserID;

 if AbsNum = 0 then
 begin
  PutToFullRec(stBDate_Key, aBeginDate);
  PutToFullRec(stEDate_Key, aEndDate);
  PutToFullRec(stAuthor_Key, aUserID);
  AddFRec;
  Result := True;
 end
 else
 begin
  GetFullRec(AbsNum,True);
  try
   //GetFromFullRec(stAuthor_Key, TmpUser);
     { запрет закрытия этапа открытого другим пользователем (не админом)
      If Not GlobalDataProvider.AdminRights
      then
       If (TmpUser<>GlobalDataProvider.UserID)
        then
         raise EHtErrors.CreateInt(ecAccessDenied);
      }
     if aBeginDate <> 0 then
     begin
      GetFromFullRec(stBDate_Key,TmpDate);
      if TmpDate = 0 then
      begin
       PutToFullRec(stBDate_Key, aBeginDate);
       Result := True;
      end;
     end;
     if aEndDate <> 0 then
     begin
      GetFromFullRec(stEDate_Key, TmpDate);
      if TmpDate = 0 then
      begin
       PutToFullRec(stEDate_Key, aEndDate);
       Result := True;
      end;
     end;

     if Result then
     begin
      PutToFullRec(stAuthor_Key, aUserID);
      UpdFRec(AbsNum);
     end;
  finally
   FreeRec(AbsNum);
  end;
 end;
 end; //with fTable do
end;

procedure TStageTbl.SetDocStagesRecList(aDocID : TDocID; aList : Tl3CustomDataList);
var
 I : Integer;

 function lpRestoreDate(aDate : TStDate) : TStDate;
 begin
  if aDate = 1 then
   Result := CurrentDate
  else
   Result := aDate;
 end;

begin
 if aDocID = 0 then
  raise EHtErrors.CreateInt(ecNotAssigned);

 for I := 0 to Pred(aList.Count) do
  with PStageFullRec(aList.Data[I])^ do
   PutStageRec(aDocID, TStageType(StType), BDate, EDate, Author);
end;

Procedure TStageTbl.GetDocStagesRecList(aDocID : TDocID; aList : Tl3CustomDataList);
var
 DocStages  : Sab;
 TmpMode    : TOpenMode;
 StagesList : TAbstractList;
 I          : Integer;
begin
 if (aDocID = 0) then raise EHtErrors.CreateInt(ecNotAssigned);

 htSearch(nil,DocStages,fTable.Handle,stDocID_Key,Equal,@aDocID,nil);

 try
  if DocStages.gFoundCnt<>0 then
   begin
    aList.Clear;
    aList.DataSize:=SizeOf(TStageFullRec);
    with TmpMode do
     begin
      openMode:=ROPEN_BODY;
      FldArr:=nil;
      Count:=0;
     end;
    StagesList:=TAbstractList.Create(@DocStages,TmpMode);
    try
     StagesList.ReadForvard:=True;
     for I:=0 to StagesList.Count-1 do
      aList.Add(StagesList.GetItem(I));
    finally
     l3Free(StagesList);
    end;
   end;
 finally
  htClearResults(DocStages);
 end;
end;

Function TStageTbl.GetStagesOnDoc(aDocID : TDocID) : Sab;
Begin
 l3FillChar(Result,SizeOf(Sab));
 htSearch(nil,Result,fTable.Handle,stDocID_Key,Equal,@aDocID,Nil);
end;

Function TStageTbl.GetIntervalSab(BeginDate,EndDate : TStDate;
                                  StageFlag : TStageFlag) : Sab;
Var
 TmpSab1,
 TmpSab2,
 TmpSab3,
 TmpSab4 : SAB;
Begin
 with table do
 begin
  If EndDate = BlankDate then EndDate:=CurrentDate;
  If BeginDate = BlankDate then BeginDate:=MinSrchDate;
  Case StageFlag of
   stfNone :
     Begin
      htSearch(nil,TmpSab1,Handle,stBDate_Key,Less_Equal,@EndDate,Nil); // начавшиеся до конца периода
      Try
       htSearch(@TmpSab1,TmpSab2,Handle,stEDate_Key,Great_Equal,@BeginDate,Nil); // закончившиеся после начала периода
       Try
        htSearch(@TmpSab1,TmpSab3,Handle,stEDate_Key,EQUAL,@BlankDate,Nil);  // незаконченные
        Try
         htOrResults(TmpSab4,TmpSab3,TmpSab2);
         Try
          htAndResults(Result,TmpSab1,TmpSab4);
         finally
          htClearResults(TmpSab4);
         end;
        finally
         htClearResults(TmpSab3);
        end;
       finally
        htClearResults(TmpSab2);
       end;
      finally
       htClearResults(TmpSab1);
      end;
     end;
   stfBegined :
     Begin
 //     htSearch(@fSrchList,Result,Handle,stBDate_Key,Less_Equal,@EndDate,Nil);
      htSearch(nil,Result,Handle,stBDate_Key,IN_RANGE,@BeginDate,@EndDate);
     end;
   stfFinished :
     Begin
 //     htSearch(@fSrchList,Result,Handle,stEDate_Key,Less_Equal,@EndDate,Nil);
      htSearch(nil,Result,Handle,stEDate_Key,IN_RANGE,@BeginDate,@EndDate);
     end;
   stfUnfinished :
     Begin
      htSearch(nil,TmpSab1,Handle,stEDate_Key,Great,@EndDate,Nil);
      Try
       htSearch(@TmpSab1,TmpSab2,Handle,stEDate_Key,Equal,@BlankDate,Nil);
       Try
        htOrResults(Result,TmpSab1,TmpSab2);
       finally
        htClearResults(TmpSab2);
       end;
      finally
       htClearResults(TmpSab1);
      end;
     end;
  end;
 end; // with table
end;

(*
Procedure TStageTbl.BeginStage(aDocID : TDocID; aStage : TStageType);
Begin
 PutStageRec(aDocID, aStage,CurrentDate,0);
end;

Procedure TStageTbl.EndStage(aDocID : TDocID; aStage : TStageType);
Var
 CurDate : TStDate;
Begin
 CurDate:=CurrentDate;
 PutStageRec(aDocID, aStage,CurDate,CurDate);
end;
*)
(*
Procedure TStageTbl.DocumentDone;
Var
 CurDate : TStDate;
Begin
 CurDate:=CurrentDate;
 PutStageRec(stDone,CurDate,CurDate);

// now this function supported by high level interface

{
 While Not (DayOfWeek(CurDate)=Saturday) do
  CurDate:=CurDate+1;
 GlobalHTServer.LogBook[TblFamily].PutDateLogRec(fDocID,acIncluded,CurDate,0);
}
end;
*)

{Procedure TStageTbl.GetDocStages(Var BeginSet,EndSet : TStageSet);
Var
 DocStages  : Sab;
 TmpMode    : TOpenMode;
 StagesList : TAbstractList;
 TmpRec     : PStageRec;
 I          : Word;
Begin
 If (fDocID = 0) then raise EHtErrors.CreateInt(ecNotAssigned);
 BeginSet:=[];
 EndSet:=[];

 RefreshSrchList;
 htSearch(@fSrchList,DocStages,Handle,stDocID_Key,Equal,@fDocID,Nil);
 Try
  If DocStages.gFoundCnt<>0
   then
    Begin
     With TmpMode do
      Begin
       openMode:=ROPEN_READ;
       FldArr:=@StFldArr;
       Count:=StFldCount;
      end;
     StagesList:=TAbstractList.Create(@DocStages,TmpMode);
     Try
      StagesList.ReadForvard:=True;
      For I:=0 to StagesList.Count-1 do
       Begin
        TmpRec:=StagesList.GetItem(I);
        If TmpRec^.BDate<>0
         then
          BeginSet:=BeginSet+[TStageType(TmpRec^.StType)];
        If TmpRec^.EDate<>0
         then
          EndSet:=EndSet+[TStageType(TmpRec^.StType)];
       end;
     finally
      l3Free(StagesList);
     end;
    end;
 finally
  htClearResults(DocStages);
 end;
end;}

(*
Procedure TStageTbl.SetDocStages(aDocID : TDocID; BeginSet,EndSet : TStageSet);
Var
 I : TStageType;
Begin
 If (aDocID = 0) then raise EHtErrors.CreateInt(ecNotAssigned);
 BeginSet:=BeginSet-EndSet;
 If (BeginSet<>[]) or (EndSet<>[])
  then
   Begin
    //If stDone in BeginSet then
    // DocumentDone;
    For I:=stInput to High(TStageType) do
     Begin
      If I in BeginSet
       then
        BeginStage(aDocID, I);
      If I in EndSet
       then
        EndStage(aDocID, I);
     end;
   end;
end;
*)
{Procedure TStageTbl.DelDocStage(aStage : TStageType);
Var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
begin
 //If (fDocID = 0) then raise EHtErrors.CreateInt(ecNotAssigned);
 ClearFullRec;
 PutToFullRec(stDocID_Key,fDocID);
 PutToFullRec(stType_Key,aStage);
 AbsNum:=Ht(htRecordByUniq(Nil,Handle,stDocType_Key,fFullRecord,@RecH));
 If AbsNum <> 0 then
  DelRec(AbsNum);
end;

Function TStageTbl.GetStatisticDocSab(BeginDate,EndDate : TStDate;StageFlag : TStageFlag;
                                      UserID : TUserID; Stage : TStageType) : SAB;
Var
 l_Stages: SAB;
Begin
 l_Stages := FilteredBy(BeginDate, EndDate, StageFlag, UserID, Stage);
 Try
  htValuesOfKey(Result, stDocID_Key, l_Stages);
 finally
  htClearResults(l_Stages);
 end;
end;
}

Function TStageTbl.GetDocOnStages(BeginDate,EndDate : TStDate;
                                  BeginSet,EndSet,NotEndSet : TStageSet) : Sab;
Var
 BeginSab,
 EndSab,
 NotEndSab,
 TmpSab1,
 TmpSab2  : Sab;
 I        : TStageType;
Begin
 with table do
 begin
 l3FillChar(Result,SizeOf(Sab));
 BeginSab:=GetIntervalSab(BeginDate,EndDate,stfBegined);
 Try
  EndSab:=GetIntervalSab(BeginDate,EndDate,stfFinished);
  Try
   NotEndSab:=GetIntervalSab(BeginDate,EndDate,stfUnfinished);
   Try
    l3FillChar(TmpSab1,SizeOf(Sab));
    For I:=stInput to High(TStageType) do
     Begin
      If I in BeginSet
       then
        Begin
         htSearch(@BeginSab,TmpSab2,Handle,stType_Key,Equal,@I,Nil);
         Try
          htAndResults(TmpSab1,TmpSab2,BeginSab);
         finally
          htClearResults(TmpSab2);
         end;
        end;
      If I in EndSet
       then
        Begin
         htSearch(@EndSab,TmpSab2,Handle,stType_Key,Equal,@I,Nil);
         Try
          htAndResults(TmpSab1,TmpSab2,EndSab);
         finally
          htClearResults(TmpSab2);
         end;
        end;
      If I in NotEndSet
       then
        Begin
         htSearch(@NotEndSab,TmpSab2,Handle,stType_Key,Equal,@I,Nil);
         Try
          htAndResults(TmpSab1,TmpSab2,NotEndSab);
         finally
          htClearResults(TmpSab2);
         end;
        end;
      If htResultsType(TmpSab1) <> Res_NProc
       then
        Begin
         htValuesOfKey(TmpSab2,stDocID_Key,TmpSab1);
         htClearResults(TmpSab1);
         If htResultsType(Result) <> Res_NProc then
          Begin
           TmpSab1:=Result;
           htAndResults(Result,TmpSab2,TmpSab1);
           htClearResults(TmpSab1);
           htClearResults(TmpSab2);
          end
         else
          Result:=TmpSab2;
        end;
     end;
   finally
    htClearResults(NotEndSab);
   end;
  finally
   htClearResults(EndSab);
  end;
 finally
  htClearResults(BeginSab);
 end;
  end; //with table
end;  

(*Function TStageTbl.GetStagesOnDocs(aDocSab : Sab) : Sab;
Begin
 l3FillChar(Result,SizeOf(Sab));
 htRecordsByKey(Result,aDocSab);
end;

function TStageTbl.HasDocThisStage(aDocID : TDocID; aStage : TStageType) : Boolean;
var
 AbsNum : LongInt;
begin
 Result:=HasDocThisStage(aDocID,aStage,AbsNum);
end;

function TStageTbl.HasDocThisStage(aDocID : TDocID; aStage : TStageType;
                                   var AbsNum : LongInt) : Boolean;
var
 CurKeyValue : TStageKeyRec;
 RecH        : RHANDLE;
begin
 CurKeyValue.DocID:=aDocID;
 CurKeyValue.Stage:=aStage;
 AbsNum:=Ht(htRecordByUniq(nil,Handle,stDocType_Key,@CurKeyValue,@RecH));
 Result:=(AbsNum>0);
end;

function TStageTbl.FilteredBy(aBeginDate,
                              aEndDate: TStDate;
                              aStageFlag: TStageFlag;
                              aUserID: TUserID;
                              aStage: TStageType): SAB;
Var
 l_Sab1,
 l_Sab2: Sab;
Begin
 RefreshSrchList;
 Result:=GetIntervalSab(aBeginDate,aEndDate,aStageFlag);

 if aUserID <> 0 then
 begin
  l_Sab1 := Result;
  try
   htSearch(@fSrchList, l_Sab2, Handle, stAuthor_Key, Equal, @aUserID, nil);
   try
    htAndResults(Result, l_Sab1, l_Sab2);
   finally
    htClearResults(l_Sab2);
   end;
  finally
   htClearResults(l_Sab1);
  end;
 end;

 if aStage <> stNone then
 begin
  l_Sab1 := Result;
  try
   htSearch(@fSrchList, l_Sab2, Handle, stType_Key, Equal, @aStage, nil);
   try
    htAndResults(Result, l_Sab1, l_Sab2);
   finally
    htClearResults(l_Sab2);
   end;
  finally
   htClearResults(l_Sab1);
  end;
 end;
end;
*)

function StageTypeToBitIndex(const aStageID: TStageType): Integer;
begin
 Result := Ord(aStageID) - 2;
 Assert(Result >= 0, 'Тип этапа не входит в битовую маску!');
end;

end.

