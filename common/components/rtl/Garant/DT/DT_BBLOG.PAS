Unit Dt_BBLog;

{ $Id: DT_BBLOG.PAS,v 1.76 2016/08/11 08:37:29 lukyanets Exp $ }

// $Log: DT_BBLOG.PAS,v $
// Revision 1.76  2016/08/11 08:37:29  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.75  2016/06/16 05:40:06  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.74  2016/04/22 11:39:39  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.73  2016/04/18 11:48:05  lukyanets
// Готовимся переводить UserManager
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.72  2016/03/25 12:41:40  lukyanets
// cleanup
//
// Revision 1.71  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.70  2015/08/13 11:13:54  lukyanets
// Читаем из полей
//
// Revision 1.69  2015/07/03 13:00:51  lukyanets
// Сортируем по правильному
//
// Revision 1.68  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.67  2015/05/25 14:52:45  lukyanets
// Готовимся дальше изолировать журнал
//
// Revision 1.66  2015/05/14 13:59:51  lukyanets
// Cleanup
//
// Revision 1.65  2015/05/06 14:38:03  lukyanets
// Готовимся изолировать Большого Брата
//
// Revision 1.64  2015/04/29 14:57:20  lukyanets
// Заготовки Большого Брата
//
// Revision 1.63  2015/04/29 08:13:30  lukyanets
// Cleanup
//
// Revision 1.62  2015/04/28 14:38:50  lukyanets
// Заготовки Большого Брата
//
// Revision 1.61  2015/04/28 14:02:54  lukyanets
// Не до конца окучили новый тип операции
//
// Revision 1.60  2015/04/27 09:19:52  lukyanets
// Cleanup
//
// Revision 1.59  2014/07/08 07:02:13  lukyanets
// {Requestlink:552022662}. Полный цикл
//
// Revision 1.58  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.57  2014/03/12 10:35:36  voba
// - адаптация под новый HyTech
//
// Revision 1.56  2010/10/26 12:14:16  fireton
// - утечки в Большом Брате (не надо распределять строку)
//
// Revision 1.55  2010/09/28 13:06:08  fireton
// - Распределяем память для PChar своими средствами
//
// Revision 1.54  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.53  2009/09/15 12:32:04  voba
// - add function MakeDocEditRec
//
// Revision 1.52  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.51  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.50  2009/03/10 09:23:15  voba
// - сс
//
// Revision 1.49  2009/03/02 07:55:42  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.48  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.47.4.1  2008/12/26 15:22:05  fireton
// - полностью избавляемся от ссылок на DT_Srch
//
// Revision 1.47  2008/09/17 14:47:46  fireton
// - новая версия базы (130)
// - срочность документа
//
// Revision 1.46  2008/08/11 08:49:48  voba
// - поиск по stCorSources
//
// Revision 1.45  2008/06/10 14:13:01  narry
// - запись в ББ информации о проведенной АК
//
// Revision 1.44  2008/03/27 09:52:40  voba
// - поиск по Published
//
// Revision 1.43  2007/12/06 11:40:59  lulin
// - cleanup.
//
// Revision 1.42  2007/08/14 14:30:07  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.41  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.40  2007/06/28 10:43:51  narry
// - не компилировалось
//
// Revision 1.39  2007/06/20 11:55:19  voba
// - add dict dlServiceInfo
//
// Revision 1.38  2007/05/24 14:40:10  fireton
// - переписано получение статистики (с помщью ISab)
// - теперь стало возможным получать сводную статистику по юзерам и документам
//
// Revision 1.37  2007/05/18 12:23:40  fireton
// - реорганизация Большого Брата:
//   * логика перенесена из вызывающего кода в ББ
//   * изничтожен OperationHandle
//
// Revision 1.36  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.35  2007/03/26 09:33:19  fireton
// - format
// - убран ненужный теперь кусок кода
//
// Revision 1.34  2007/01/09 10:16:52  voba
// - rename function l3StringToPCharAlloc to l3PCharAlloc
//
// Revision 1.33  2006/11/22 16:21:41  fireton
// - исправлено: подготовка к большому UserID
//
// Revision 1.32  2006/06/08 15:54:45  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.31.42.1  2006/06/08 08:50:00  fireton
// - перевод User ID на Longword
//
// Revision 1.31  2005/03/23 16:07:03  step
// расширен SrchStr
//
// Revision 1.30  2004/09/21 12:04:19  lulin
// - Release заменил на Cleanup.
//
// Revision 1.29  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.28  2004/08/03 08:52:49  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.27  2004/07/14 13:28:27  step
// продолжительность транзакции задается в StartTA
//
// Revision 1.26  2004/07/01 14:14:26  voba
// - merge newCashe
//
// Revision 1.25.12.1  2004/06/17 18:03:48  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.25  2004/03/29 09:32:44  voba
// no message
//
// Revision 1.24  2004/03/03 18:22:21  law
// - rename unit: l3Tree2 -> l3Tree.
//
// Revision 1.23  2003/11/25 14:34:00  voba
// -Code clean
//
// Revision 1.22  2003/02/11 10:04:38  voba
// - rename proc: l3NodeActionL2FA -> l3L2IA.
//
// Revision 1.21  2001/11/23 13:29:02  demon
// -new behavior: add AccGroups attribute to Search process
//
// Revision 1.20  2001/04/24 15:59:52  voba
// Демон на моей машине отлаживался
//
// Revision 1.19  2001/04/23 10:45:05  demon
// - new behavior: add new function GetDocStatistic;
// - new behavior: function GetStatistic rename to GetDocStatistic;
//
// Revision 1.18  2001/02/07 13:51:11  demon
// - add search on Warnings
//
// Revision 1.17  2000/12/15 15:36:15  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
Uses
 l3Date,
 l3Tree,
 l3Tree_TLB,

 daTypes,

 HT_Const,
 Dt_Types, Dt_Const, dt_AttrSchema,

 dtIntf, Dt_ATbl, DT_Sab;

Const
 BlankSession  = -1;

 MaxBBOpTime   = 900; (* 15 минуты *)

 bbID_Session    = 1;
 bbID_Operation  = 2;
 bbID_Family     = 3;
 bbID_Ext        = 4;  {UserID, DocID or other key information}
 bbDate          = 5;
 bbTime          = 6;
 bbAdditional    = 7;

Type
(* Edit Type Record *)
 PDocEditRec = ^TDocEditRec;
 TDocEditRec = Record
                EditType  : TdaDocEditType;
                Case Byte of
                    1 : (Operation : TdaEditOperation);
                    2 : (DictType  : TdaDictionaryType);
               end;

(* Dict Type Record *)
 PDictEditRec = ^TDictEditRec;
 TDictEditRec = Record
                 DictType  : TdaDictionaryType;
                 Operation : TdaEditOperation;
                end;

(* Table Record *)
 PBBLogRec = ^TBBLogRec;
 TBBLogRec = Record
              Session   : LongInt;
              Operation : Word;
              Family    : TdaFamilyID;
              ExtID     : LongInt;
              Date      : TStDate;
              Time      : TStTime;
              AdditInfo : LongInt;
             end;

 TBigBrotherTbl = Class(TPrometTbl)
  private
    function Get_CurStatisticTreeRoot: Il3RootNode;
  protected
   fCurSessionID    : LongInt;
   fCurUser         : TdaUserID;

   fCurStatTree     : Tl3Tree;

//   Function  GetNewSessionID : LongInt;

   Procedure ClearStatTree;
   Procedure AnalyseLog(LogSab : Sab);
   Procedure Cleanup; override;
   function  GetDocStatistic(FromDate,ToDate : TStDate; ID : TDocID): ISab;
   function  GetUserStatistic(FromDate,ToDate : TStDate; ID : TdaUserID; UserGr : Boolean): ISab;
   Procedure PutBBRec(aOperation : TdaJournalOperation;
                      aFamilyID  : TdaFamilyID;
                      aExtID     : LongInt;
                      aData      : LongInt);
  public
   Constructor Create; Reintroduce;
   procedure CalcStatistics(FromDate,ToDate : TStDate;
                            aDocID          : TDocID;
                            UserOrGroupID   : TdaUserID;
                            UserGr          : Boolean);

   //procedure LogSearch(aFamilyID: TdaFamilyID; aSrchSet: TSearchSet);
   procedure LogExport(aFamilyID: TdaFamilyID; aCount: Longint);
   procedure LogImport(aFamilyID: TdaFamilyID);
   procedure LogPause(aLength: Longint);
   procedure LogPrintDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);
   procedure LogSaveDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);
   procedure LogEditDoc(aFamilyID: TdaFamilyID; aDocID: TDocID; aEditInfo: TDocEditRec); overload;
   procedure LogEditDoc(aFamilyID: TdaFamilyID; aDocID: TDocID; aEditType: TdaDocEditType); overload;
   procedure LogDeleteDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);
   procedure LogEditDict(aFamilyID: TdaFamilyID; aEditInfo: TDictEditRec);
   procedure LogCreateDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);
   procedure LogAutoClass(aFamilyID: TdaFamilyID; aCount: Longint);
   procedure LogOpenDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);

   procedure SessionDone;

   property  UserID : TdaUserID read fCurUser;
   property  CurStatisticTreeRoot : Il3RootNode read Get_CurStatisticTreeRoot;
   property  CurStatTree : Tl3Tree read fCurStatTree;
 end;

//function MakeDocEditRec(aEditType : TdaDocEditType; aOperation : TdaEditOperation) : TDocEditRec;
// overload;
function MakeDocEditRec(aEditType : TdaDocEditType; aDictType  : TdaDictionaryType) : TDocEditRec;
 overload;

Implementation

uses
  SysUtils,
  TypInfo,

  l3Base,
  l3Nodes,
  l3String,
  l3TreeInterfaces,

  daSchemeConsts,
  daDataProvider, 

  HT_Dll,
  Dt_Err,
  Dt_List,
  Dt_User
  ;

(******************************** TBigBrotherTbl *********************************)

Constructor TBigBrotherTbl.Create;
begin
 {$IfDef FlushTbl}
 CreateWithFlush(MainTblsFamily, Ord(mtBBLog));
 {$else FlushTbl}
 inherited Create(MainTblsFamily, Ord(mtBBLog));
 {$endIf FlushTbl}
 fCurSessionID:=BlankSession;
 fCurUser:=0;
 fCurStatTree:=Tl3Tree.Create;
 Randomize;
end;

Procedure TBigBrotherTbl.Cleanup;
begin
 L3Free(fCurStatTree);
 Inherited;
end;
(*
Function TBigBrotherTbl.GetNewSessionID : LongInt;
Var
 TmpSab  : Sab;
 Uniq    : Boolean;
 TmpDate : TStDate;
begin
 Result:=BlankSession;
 TmpDate:=(CurrentDate - DMYtoStDate(1,1,1998)) mod 24855;
 Result:=TmpDate * 24 * 60 * 60 + CurrentTime;
 Repeat
  htSearch(nil,TmpSab,Handle,bbID_Session,EQUAL,@Result,nil);
  try
   Uniq:=TmpSab.GFoundCnt=0;
   if Not Uniq
    then
     Inc(Result);
  finally
   htClearResults(TmpSab);
  end;
 until Uniq;
end;
*)
Procedure TBigBrotherTbl.PutBBRec(aOperation : TdaJournalOperation;
                                  aFamilyID  : TdaFamilyID;
                                  aExtID     : LongInt;
                                  aData      : LongInt);
Var
 TmpLI   : LongInt;
 l_Operation: Word;
begin
 if fCurSessionID=BlankSession then
  raise EHtErrors.CreateInt(ecNotEnable);

 ClearFullRec;
 PutToFullRec(bbID_Session, fCurSessionID);
 l_Operation := Word(aOperation);
 PutToFullRec(bbID_Operation, l_Operation);
 PutToFullRec(bbID_Family, aFamilyID);
 if aExtID <> 0 then
  PutToFullRec(bbID_Ext, aExtID);
 TmpLI:=CurrentDate;
 PutToFullRec(bbDate, TmpLI);
 TmpLI:=CurrentTime;
 PutToFullRec(bbTime, TmpLI);
 if aData <> 0 then
  PutToFullRec(bbAdditional, aData);

 AddFRec;
end;

Procedure TBigBrotherTbl.SessionDone;
begin
 PutBBRec(da_oobSessionEnd, 0, 0, 0);
end;

Procedure TBigBrotherTbl.ClearStatTree;
begin
 fCurStatTree.Clear;
end;

Procedure TBigBrotherTbl.AnalyseLog(LogSab : Sab);
Var
 LogList    : TAbstractList;
 TmpMode    : TOpenMode;
 I          : LongInt;
 LogRec     : PBBLogRec;

 CurS_ID    : LongInt;
 TmpNode,
 CurS_Node  : Il3Node;

 DT1,DT2    : TStDateTimeRec;
 Days,Secnds: LongInt;
 Hours,Mins,
 Secs       : Word;
 Day,
 Month,
 Year       : Integer;
 PauseTime  : TStTime;
 TmpStr     : ShortString;

 //Iter       : TSearchParameters;

 FullTime,
 FullPause,
 FullOpenDocs,
 FullModifDocs,
 FullModifications : LongInt;

 function FindLastNodeByParam(Parent: Il3Node; Param : Integer) : Il3Node;
 Var
  ResNode : Il3Node;

  function IterHandler(CurNode : Il3Node) : Boolean;far;
   begin
    if Param = (CurNode as Il3HandleNode).Handle then
     ResNode:=CurNode;
    Result:=False;
   end;

 begin
  ResNode:=nil;
  fCurStatTree.IterateF(l3L2NA(@IterHandler),imOneLevel,Parent);
  Result:=ResNode;
 end;

 Procedure GetTimeFromLongInt(aSecnds : LongInt;Var Hours,Minutes,Seconds : Word);
 Const
  cSIH = 60*60;
  cSIM = 60;
 begin
  Hours:=aSecnds div cSIH;
  aSecnds:=aSecnds mod cSIH;
  Minutes:=aSecnds div cSIM;
  Seconds:=aSecnds mod cSIM;
 end;

 procedure SetSessionTime;
 begin
  DateTimeDiff(DT1,DT2,Days,Secnds);
  FullTime:=FullTime+Days*(24*60*60)+Secnds;
  GetTimeFromLongInt(Secnds,Hours,Mins,Secs);
  Hours:=Hours+Days*24;
  fCurStatTree.InsertNode(CurS_Node,
      MakeNode(Format('Продолжительность сессии: %0.2d:%0.2d:%0.2d', [Hours,Mins,Secs])));

  if PauseTime<>0
   then
    begin
     GetTimeFromLongInt(PauseTime,Hours,Mins,Secs);
     fCurStatTree.InsertNode(CurS_Node,
         MakeNode(Format('Нерабочее время (пауза): %0.2d:%0.2d:%0.2d', [Hours,Mins,Secs])));
     FullPause:=FullPause+PauseTime;
    end;
 end;

 procedure SetFooterParams;
 begin
  GetTimeFromLongInt(FullTime,Hours,Mins,Secs);
  fCurStatTree.InsertNode(fCurStatTree.RootNode,
      MakeNode(Format('Общее время работы: %0.2d:%0.2d:%0.2d', [Hours,Mins,Secs])));

  GetTimeFromLongInt(FullPause,Hours,Mins,Secs);
  fCurStatTree.InsertNode(fCurStatTree.RootNode,
      MakeNode(Format('Общее время простоя (паузы): %0.2d:%0.2d:%0.2d', [Hours,Mins,Secs])));

  fCurStatTree.InsertNode(fCurStatTree.RootNode,
        MakeNode(Format('Количество открытых документов: %d',[FullOpenDocs])));
  fCurStatTree.InsertNode(fCurStatTree.RootNode,
        MakeNode(Format('Количество отредактированных документов: %d',[FullModifDocs])));
  fCurStatTree.InsertNode(fCurStatTree.RootNode,
        MakeNode(Format('Общее количество изменений в документах: %d',[FullModifications])));
 end;

begin
 ClearStatTree;
 FullTime:=0;
 FullPause:=0;
 FullOpenDocs:=0;
 FullModifDocs:=0;
 FullModifications:=0;
 PauseTime:=0;
 DT1.D:=0;
 DT1.T:=0;
 DT2.D:=0;
 DT2.T:=0;

 TmpMode.openMode:=ROPEN_BODY;
 TmpMode.Count:=0;
 TmpMode.FldArr:=nil;
 LogList:=TAbstractList.Create(@LogSab,TmpMode);
 LogList.ReadForvard:=True;
 try
  CurS_ID:=0;
  CurS_Node:=nil;
  For I:=0 to LogList.Count-1 do
   begin
    LogRec:=LogList.GetItem(I);
    if LogRec^.Session<>CurS_ID
     then
      begin
       if CurS_Node<>nil
        then
         SetSessionTime;

       DT1.D:=LogRec^.Date;
       DT1.T:=LogRec^.Time;
       CurS_ID:=LogRec^.Session;
       PauseTime:=0;
      end;

    Case TdaJournalOperation(LogRec^.Operation) of
     da_oobPause : PauseTime:=PauseTime+LogRec^.AdditInfo;
     da_oobSessionBegin:
      begin
       TmpNode:=fCurStatTree.FindNodeByParam(fCurStatTree.RootNode,LogRec^.ExtID,imOneLevel);
       if TmpNode=nil
        then
         begin
          TmpNode:=fCurStatTree.InsertNode(fCurStatTree.RootNode,
                                  MakeNode(PChar(GlobalDataProvider.UserManager.GetUserName(LogRec^.ExtID))));
          (TmpNode as Il3HandleNode).Handle:=LogRec^.ExtID;
         end;
       StDateToDMY(LogRec^.Date,Day,Month,Year);
       CurS_Node:=fCurStatTree.InsertNode(TmpNode,
                                          MakeNode(Format('Рабочая сессия (%d/%d/%d)',
                                                                        [Day,Month,Year])));
      end;
     da_oobSessionEnd : fCurStatTree.InsertNode(CurS_Node,
                                             MakeNode('Cессия закончилась корректно'));
     da_oobOpenDoc    :
      begin
       Inc(FullOpenDocs);
       TmpNode:=fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Открыт документ N %d',[LogRec^.ExtID])));
       (TmpNode as Il3HandleNode).Handle:=LogRec^.ExtID;
      end;
     da_oobCreateDoc :
      begin
       Inc(FullOpenDocs);
       TmpNode:=fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Создан документ N %d',[LogRec^.ExtID])));
       (TmpNode as Il3HandleNode).Handle:=LogRec^.ExtID;
      end;
     da_oobDeleteDoc : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Удален документ N %d',[LogRec^.ExtID])));
     da_oobEditDoc:
      begin
       Inc(FullModifications);
       TmpNode:=FindLastNodeByParam(CurS_Node,LogRec^.ExtID);
       if TmpNode=nil
        then
         begin
          TmpNode:=fCurStatTree.InsertNode(CurS_Node,
                                           MakeNode(Format('Отредактирован документ N %d',[LogRec^.ExtID])));
          Inc(FullModifDocs);
         end
        else
         if Not TmpNode.HasChild
          then
           Inc(FullModifDocs);
       Case PDocEditRec(@LogRec^.AdditInfo)^.EditType of
        da_detText      : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменен Текст'));
        da_detAttribute : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены Аттрибуты'));
        da_detHyperLink : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены Гиперлинки'));
        da_detSub       : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены Subы'));
        da_detDiction:
         Case PDocEditRec(@LogRec^.AdditInfo)^.DictType of
          da_dlSources    : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены Органы'));
          da_dlTypes      : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены Типы'));
          da_dlClasses    : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены Классы'));
          da_dlKeyWords   : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены KW'));
          da_dlBases      : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены Группы'));
          da_dlDateNums   : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены Дата или Номер'));
          da_dlWarnings   : fCurStatTree.InsertNode(TmpNode,MakeNode('Изменены Предупреждения'));
          da_dlCorrects   : fCurStatTree.InsertNode(TmpNode,MakeNode('Внесена вычитка'));
         end;
       end;
      end;
     da_oobPrintDoc : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Документ N %d напечатан',[LogRec^.ExtID])));
     da_oobSaveDoc  : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Документ N %d сохранен на диск',[LogRec^.ExtID])));
     da_oobEditDictionary :
      begin
       Case PDictEditRec(@LogRec^.AdditInfo)^.Operation of
        da_eoNone   : TmpStr:='';
        da_eoAdd    : TmpStr:='(Добавлен элемент)';
        da_eoEdit   : TmpStr:='(Исправлен элемент)';
        da_eoDelete : TmpStr:='(Удален элемент)';
       end;
       Case PDictEditRec(@LogRec^.AdditInfo)^.DictType of
        da_dlSources    : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Изменен словарь Органы %s',[TmpStr])));
        da_dlTypes      : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Изменен словарь Типы %s',[TmpStr])));
        da_dlClasses    : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Изменен словарь Классы %s',[TmpStr])));
        da_dlKeyWords   : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Изменен словарь KW %s',[TmpStr])));
        da_dlBases      : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Изменен словарь Группы %s',[TmpStr])));
        da_dlWarnings   : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Изменен словарь Предупреждения %s',[TmpStr])));
        da_dlCorSources : fCurStatTree.InsertNode(CurS_Node,
                                               MakeNode(Format('Изменен словарь Источники публикации %s',[TmpStr])));
       end;
      end;
     da_oobExport : fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Проведен Экспорт %d документов',
                                                                                 [LogRec^.AdditInfo])));
     da_oobImport : fCurStatTree.InsertNode(CurS_Node,MakeNode('Проведен Импорт'));
     da_oobSearch_Deprecated : ;
      {
      begin
       TmpNode:=fCurStatTree.InsertNode(CurS_Node,MakeNode('Проведен Поиск'));
       TmpStr:='';
       if PSearchSet(@LogRec^.AdditInfo)^<>[]
        then
         begin
          For Iter:=Low(TSearchParameters) to High(TSearchParameters) do
           if Iter in PSearchSet(@LogRec^.AdditInfo)^
            then
             if TmpStr=''
              then
               TmpStr:=TmpStr+SrchStr[Iter]
              else
               TmpStr:=TmpStr+'\'+SrchStr[Iter];
         end
        else
         TmpStr:='Все документы';
       fCurStatTree.InsertNode(TmpNode,MakeNode(TmpStr));
      end;
      }
     da_oobAutoClass: fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Проведена автоклассификация %d документов',
                                                                                 [LogRec^.AdditInfo])));
    else
     fCurStatTree.InsertNode(CurS_Node,MakeNode(Format('Нераспознанная операция (%s)', [GetEnumName(TypeInfo(TdaJournalOperation), LogRec^.Operation)])));
    end;

    DT2.D:=LogRec^.Date;
    DT2.T:=LogRec^.Time;
   end;
   SetSessionTime;
   SetFooterParams;
 finally
  l3Free(LogList);
 end;
end;

procedure TBigBrotherTbl.CalcStatistics(FromDate,ToDate : TStDate;
                                        aDocID          : TDocID;
                                        UserOrGroupID   : TdaUserID;
                                        UserGr          : Boolean);
var
 l_ResultSab, l_DocSab: ISab;
begin
 try
  if UserOrGroupID <> 0 then
  begin
   l_ResultSab := GetUserStatistic(FromDate, ToDate, UserOrGroupID, UserGr);
   if aDocID <> 0 then
   begin
    l_DocSab := GetDocStatistic(FromDate, ToDate, aDocID);
    try
     l_ResultSab.AndSab(l_DocSab);
    finally
     l_DocSab := nil;
    end;
   end;
  end
  else
   l_ResultSab := GetDocStatistic(FromDate, ToDate, aDocID);
  // анализируем полученные данные
  l_ResultSab.Sort([bbID_Session, bbDate, bbTime]);
  AnalyseLog(l_ResultSab.HTSab);
 finally
  l_ResultSab := nil;
 end;
end;

function TBigBrotherTbl.GetUserStatistic(FromDate,ToDate : TStDate; ID : TdaUserID; UserGr : Boolean): ISab;
var
 l_ResultSab: ISab;

 TmpOper  : Word;

begin
 Result := nil;
 if FromDate = 0 then
  FromDate := {CurrentDate}1;
 if ToDate = 0 then
  ToDate := CurrentDate+5;

 l_ResultSab := MakeSab(Self);

 try
  if ID <> 0 then
  begin
   // Если ID - это группа, то получаем список записей для пользователей из группы
   // Если нет, то получаем этого пользователя
   if UserGr then
   begin
    l_ResultSab := xxxUserManager.xxxGetUserGroupsList(ID);
    l_ResultSab.TransferToPhoto(bbID_Ext, MakePhoto(Self));
    l_ResultSab.RecordsByKey;
   end
   else
    l_ResultSab.Select(bbID_Ext, ID);

   // получаем список сессий
   TmpOper := Word(da_oobSessionBegin);
   l_ResultSab.SubSelect(bbID_Operation, TmpOper);
   // получаем сессии в диапазоне дат...
   l_ResultSab.SubSelect(bbDate, FromDate, ToDate);

   // получаем все операции выбранных сессий
   l_ResultSab.ValuesOfKey(bbID_Session);
   l_ResultSab.RecordsByKey;
  end
  else
   l_ResultSab.Select(bbDate, FromDate, ToDate);

  Result := l_ResultSab;
 finally
  l_ResultSab := nil;
 end;
end;

function TBigBrotherTbl.GetDocStatistic(FromDate,ToDate : TStDate; ID : TDocID): ISab;
var
 l_DocSab  : ISab;
 l_SessSab : ISab;
 l_SessEndSab: ISab;
 TmpOper  : Word;
begin
 Result := nil;
 if FromDate = 0 then
  FromDate:={CurrentDate}1;
 if ToDate = 0 then
  ToDate:=CurrentDate+5;

 l_DocSab := MakeSab(Self);
 try
  // Если ID определен
  if ID <> 0 then
  begin
   // сначала найдем все вхождения ID
   l_DocSab.Select(bbID_Ext, ID);
   // выкинем входжения, относящиеся к User ID
   TmpOper:=Word(da_oobSessionBegin);
   l_DocSab.SubSelect(bbID_Operation, TmpOper, NOT_EQUAL);
   // теперь отфильтруем по дате
   l_DocSab.SubSelect(bbDate, FromDate, ToDate);
 
   // мы получили все записи, в которых что-то делается с искомым документом
   // теперь получим список сессий, в которых это происходит
   l_SessSab := MakeSabCopy(l_DocSab);
   try
    l_SessSab.ValuesOfKey(bbID_Session);
    // и все записи, которые принадлежат этим сессиям
    l_SessSab.RecordsByKey;
 
    // теперь найдем начала и концы сессий и приклеим их к вхождениям докдокументов
    l_SessEndSab := MakeSabCopy(l_SessSab);
    try
     TmpOper:=Word(da_oobSessionBegin);
     l_SessSab.SubSelect(bbID_Operation, TmpOper);
     TmpOper:=Word(da_oobSessionEnd);
     l_SessEndSab.SubSelect(bbID_Operation, TmpOper);
 
     l_DocSab.OrSab(l_SessSab);
     l_DocSab.OrSab(l_SessEndSab);
    finally
     l_SessEndSab := nil;
    end;
   finally
    l_SessSab := nil;
   end;
  end
  else // если ID документа не задано, то получаем все записи из диапазона дат
   l_DocSab.Select(bbDate, FromDate, ToDate);

  Result := l_DocSab;
 finally
  l_DocSab := nil;
 end;
end;

procedure TBigBrotherTbl.LogDeleteDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);
begin
 PutBBRec(da_oobDeleteDoc, aFamilyID, aDocID, 0);
end;

procedure TBigBrotherTbl.LogCreateDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);
begin
 PutBBRec(da_oobCreateDoc, aFamilyID, aDocID, 0);
end;

procedure TBigBrotherTbl.LogOpenDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);
begin
 PutBBRec(da_oobOpenDoc, aFamilyID, aDocID, 0);
end;

procedure TBigBrotherTbl.LogEditDoc(aFamilyID: TdaFamilyID; aDocID: TDocID; aEditInfo: TDocEditRec);
var
 Tmp: Longint;
begin
 Tmp := 0;
 l3Move(aEditInfo, Tmp, SizeOf(TDocEditRec));
 PutBBRec(da_oobEditDoc, aFamilyID, aDocID, Tmp);
end;

procedure TBigBrotherTbl.LogEditDoc(aFamilyID: TdaFamilyID; aDocID: TDocID; aEditType: TdaDocEditType);
var
 Tmp: Longint;
begin
 Tmp := 0;
 l3Move(aEditType, Tmp, SizeOf(TdaDocEditType));
 PutBBRec(da_oobEditDoc, aFamilyID, aDocID, Tmp);
end;

procedure TBigBrotherTbl.LogEditDict(aFamilyID: TdaFamilyID; aEditInfo: TDictEditRec);
var
 Tmp: Longint;
begin
 Tmp := 0;
 l3Move(aEditInfo, Tmp, SizeOf(TDictEditRec));
 PutBBRec(da_oobEditDictionary, aFamilyID, 0, Tmp);
end;

{
procedure TBigBrotherTbl.LogSearch(aFamilyID: TdaFamilyID; aSrchSet: TSearchSet);
var
 Tmp: Longint;
begin
 Tmp := 0;
 l3Move(aSrchSet, Tmp, SizeOf(TSearchSet));
 PutBBRec(da_oobSearch_Deprecated, aFamilyID, 0, Tmp);
end;
}

procedure TBigBrotherTbl.LogExport(aFamilyID: TdaFamilyID; aCount: Longint);
begin
 PutBBRec(da_oobExport, aFamilyID, 0, aCount);
end;

procedure TBigBrotherTbl.LogAutoClass(aFamilyID: TdaFamilyID; aCount: Longint);
begin
 PutBBRec(da_oobAutoClass, aFamilyID, 0, aCount);
end;

procedure TBigBrotherTbl.LogImport(aFamilyID: TdaFamilyID);
begin
 PutBBRec(da_oobImport, aFamilyID, 0, 0);
end;

procedure TBigBrotherTbl.LogPause(aLength: Longint);
begin
 PutBBRec(da_oobPause, 0, 0, aLength);
end;

procedure TBigBrotherTbl.LogPrintDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);
begin
 PutBBRec(da_oobPrintDoc, aFamilyID, aDocID, 0);
end;

procedure TBigBrotherTbl.LogSaveDoc(aFamilyID: TdaFamilyID; aDocID: TDocID);
begin
 PutBBRec(da_oobSaveDoc, aFamilyID, aDocID, 0);
end;
(*
function MakeDocEditRec(aEditType : TdaDocEditType; aOperation : TdaEditOperation) : TDocEditRec;
begin
 with Result do
 begin
  EditType  := aEditType;
  Operation := aOperation;
 end;
end;
*)
function MakeDocEditRec(aEditType : TdaDocEditType; aDictType  : TdaDictionaryType) : TDocEditRec;
begin
 with Result do
 begin
  EditType  := aEditType;
  DictType  := DictType;
 end;
end;

function TBigBrotherTbl.Get_CurStatisticTreeRoot: Il3RootNode;
begin
 Result := fCurStatTree.RootNode;
end;

end.
