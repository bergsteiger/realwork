Unit Dt_Hyper;

{ $Id: DT_HYPER.PAS,v 1.167 2015/10/23 14:15:50 voba Exp $ }

// $Log: DT_HYPER.PAS,v $
// Revision 1.167  2015/10/23 14:15:50  voba
// -bf : замена ссылок в корреспондентах выдавала AV если ссылок не найдено
//
// Revision 1.166  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.165  2015/04/30 11:14:54  lukyanets
// Заготовки Большого Брата
//
// Revision 1.164  2015/04/29 14:57:20  lukyanets
// Заготовки Большого Брата
//
// Revision 1.163  2015/04/06 09:38:46  lukyanets
// Изолируем язык базы
//
// Revision 1.162  2015/03/13 11:55:46  voba
// - локальное автосохранение документов
//
// Revision 1.161  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.160  2014/02/13 15:15:59  lulin
// - рефакторим безликие списки.
//
// Revision 1.159  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.158  2013/08/23 09:17:59  voba
// - K:236721575 (Загрузка и запись атрибутов из тегов EVD)
//
// Revision 1.157  2013/07/08 09:21:07  voba
// - K:468028619
//
// Revision 1.156  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.155  2011/06/10 12:49:03  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.154  2011/01/12 07:46:08  voba
// no message
//
// Revision 1.153  2010/09/28 13:06:08  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.152  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.151  2009/10/14 11:09:14  voba
// - избавляемся от библиотеки mg
//
// Revision 1.150  2009/09/11 08:42:08  voba
// - убрал лишние методы
//
// Revision 1.149  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.148  2009/06/01 11:28:36  fireton
// - [$146377261]
//
// Revision 1.147  2009/05/19 12:17:31  voba
// - переход на ISab
//
// Revision 1.146  2009/05/13 11:20:57  voba
// - убрал Procedure THyperLinkServer.DelSubIDList
//
// Revision 1.145  2009/05/12 08:42:56  voba
// - use overload DeleteRecsByKeys with ISab
//
// Revision 1.144  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.143  2009/05/08 08:40:34  voba
// - del (commen) procedure THyperLinkServer.Verify
//
// Revision 1.142  2009/04/09 06:05:38  voba
// - cc
//
// Revision 1.141  2009/03/02 08:14:17  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.140  2009/02/16 09:19:11  voba
// - cc
//
// Revision 1.139  2009/02/05 10:24:43  narry
// - рефакторинг механизма получения языка базы
//
// Revision 1.138  2009/01/19 14:47:03  voba
// - поддержка татарского
//
// Revision 1.137  2008/08/11 08:48:11  voba
// no message
//
// Revision 1.136  2008/06/18 14:42:58  voba
// - add comment.
//
// Revision 1.135  2008/05/07 16:04:51  voba
// - Refact. function .GetRelImportNum и GetINumber убил, вместо нех использовать GetExtDocID
//
// Revision 1.134  2008/04/30 10:14:09  voba
// - enh. procedure THyperLinkTbl.ChangeDestAddr возвращает в aModifiedDocs номера документов в которых произведена замена
//
// Revision 1.133  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.132  2008/02/07 14:44:40  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.131  2008/02/01 16:41:34  lulin
// - используем кошерные потоки.
//
// Revision 1.130  2008/01/31 20:38:11  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.129  2007/12/26 07:54:53  dinishev
// не компилировалось
//
// Revision 1.128  2007/12/06 11:40:59  lulin
// - cleanup.
//
// Revision 1.127  2007/11/12 12:40:41  fireton
// - bug fix: неверное определение типа саба БД
//
// Revision 1.126  2007/10/09 08:53:53  voba
// - merge with b_archi_export_refact2
//
// Revision 1.125.8.2  2007/09/26 12:14:50  voba
// no message
//
// Revision 1.125.8.1  2007/09/21 13:23:02  voba
// no message
//
// Revision 1.125  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.124  2007/08/14 14:30:07  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.123  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.122  2007/06/28 10:43:51  narry
// - не компилировалось
//
// Revision 1.121  2007/06/22 14:37:22  voba
// - change Sab to ISab
//
// Revision 1.120  2007/05/25 15:25:30  voba
// - DeleteRecsByKeys теперь возвращает количество удаленных и подывмает exception в случае ошибок
// - DelDocsHLink,  DelDocsHLinkToDocs теперь возвращает количество удаленных
//
// Revision 1.119  2007/05/18 12:23:40  fireton
// - реорганизация Большого Брата:
//   * логика перенесена из вызывающего кода в ББ
//   * изничтожен OperationHandle
//
// Revision 1.118  2007/04/27 14:27:09  voba
// - chg procedure THyperLinkTbl.ChangeDestAddr
//
// Revision 1.117  2007/04/27 07:49:33  fireton
// - Рефакторинг DT. Перевод THTServer на идентификаторы таблиц.
//
// Revision 1.116  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.115  2007/04/23 07:31:04  voba
// - add  procedure   DelDocsHLinkToDocs(const aDocsID : ISab);
//
// Revision 1.114  2007/04/17 11:15:43  voba
// no message
//
// Revision 1.113  2007/04/13 06:24:04  voba
// - bug fix
//
// Revision 1.112  2007/04/10 10:38:44  voba
// - change Sab to ISab
//
// Revision 1.111  2007/04/02 10:37:24  voba
// - refact. procedure THyperLinkTbl.ChangeDestAddr
//
// Revision 1.110.4.2  2007/03/30 13:55:36  voba
// - change Sab to ISab
//
// Revision 1.110.4.1  2007/03/29 09:05:33  voba
// no message
//
// Revision 1.110  2007/03/02 10:09:40  voba
// - bug fix htSubSearch Bug
//
// Revision 1.109  2007/02/22 09:23:07  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.108  2007/02/16 16:13:36  voba
// - rename type Condition ->ThtCondition
//
// Revision 1.107  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.106  2007/01/09 10:12:25  voba
// - new beh. убрал распределение памяти рrocedure THyperLinkServer.GetDocSubOnSab
//
// Revision 1.105  2006/12/21 15:13:06  voba
// - opt.
//
// Revision 1.104  2006/12/13 15:43:23  voba
// - code format
//
// Revision 1.103  2006/10/04 08:32:54  voba
// - merge with b_archi_ht64
//
// Revision 1.102.10.2  2006/09/19 14:42:06  voba
// - сс
//
// Revision 1.102.10.1  2006/09/19 08:06:55  voba
// - переход на HTStub
//
// Revision 1.102  2006/03/29 09:00:12  voba
// - merge
//
// Revision 1.101.6.1  2006/03/23 14:01:13  voba
// no message
//
// Revision 1.99.10.2  2006/03/23 11:25:57  voba
// -add GetLinkAddrName
//
// Revision 1.99.10.1  2006/02/10 10:37:53  voba
// - bugfix номера гиперссылок теперь берем из документа
//
// Revision 1.101  2006/02/10 11:20:02  voba
// - bugfix номера гиперссылок теперь берем из документа
//
// Revision 1.100  2005/12/06 11:59:30  voba
// - открутил зануление ссылок при удалении документа
// - del Procedure   SetEmptyDestOnDocs(DestDocs : SAB);
// - del Procedure   SetEmptyDestOnSab(RecSab : Sab;IDSab : Sab);
//
// Revision 1.99.10.1  2006/02/10 10:37:53  voba
// - bugfix номера гиперссылок теперь берем из документа
//
// Revision 1.99  2005/10/06 11:33:20  step
// теперь THyperLinkServer.DelSubIDList чистит еще и линки
//
// Revision 1.98  2005/06/21 10:22:47  step
// в THyperLinkServer.EditSubName добавлено обновление снимка табл. SUB
//
// Revision 1.97  2005/06/02 14:25:35  step
// методу THyperLinkTbl.CheckDestDoc явно передается указатель на проверяемую запись
//
// Revision 1.96  2005/03/16 08:38:02  voba
// - improve заменили PAnsiChar на AnsiString
//
// Revision 1.95  2005/01/31 14:27:43  step
// добавлена возможность изменять записи не только по номеру, но и по значению уник. ключа
//
// Revision 1.94  2005/01/11 09:58:22  voba
// - rename TFileTbl.GetAllRelated to TFileTbl.GetAllVerLinkOrder
//
// Revision 1.93  2004/12/01 14:13:02  step
// добавлена очистка списков
//
// Revision 1.92  2004/11/26 16:56:32  step
// продправлены методы удаления гиперссылок
//
// Revision 1.91  2004/11/10 12:41:52  step
// new: THyperLinkTbl.ExtractNotReferencedDocIds, THyperLinkTbl.HasLinksWithDest
//
// Revision 1.90  2004/11/05 17:01:38  step
// добавлена запись в лог случая DestDoc = 0
//
// Revision 1.89  2004/11/04 13:50:32  step
// К THyperLinkServer.GetChildList добавлен параметр типа TDocumentSabList
// Подправлены имена параметров, лок.переменных в THyperLinkTbl.GetChildList
// и THyperLinkServer.GetChildList (со старыми читать листинг не возможно).
//
// Revision 1.88  2004/10/21 08:45:21  voba
// - bug fix
//
// Revision 1.87  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.86  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.85  2004/09/09 11:10:40  voba
// -  new behavior GetCurLinksNames теперь умеет набивать именами поданный в нее список
//
// Revision 1.84  2004/08/03 08:52:48  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.83  2004/07/14 13:28:27  step
// продолжительность транзакции задается в StartTA
//
// Revision 1.82  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.81.2.1  2004/06/17 18:03:49  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.81  2004/06/03 10:11:49  step
// Изменена THyperLinkTbl.GetParentList (добавлена обработка пустого aSubList, убрана сортировка l_BuiltSab)
//
// Revision 1.80  2004/05/26 19:27:31  law
// - new behavior: TvtCustomOutliner теперь знает только про интерфейсы Il3SimpleTree и Il3Tree, а не про объект Tl3Tree. Сделаны изменения, чтобы собирался Архивариус.
//
// Revision 1.79  2004/05/24 17:23:47  step
// change: TSubTbl.PropagateSubNames
//
// Revision 1.78  2004/05/21 19:02:03  step
// new: TSubTbl.PropagateSubNames
//
// Revision 1.77  2004/05/13 16:32:18  step
// замена: "TFreeTbl.Create ..." --> "GlobalHtServer.FreeTbl[...]"
//
// Revision 1.76  2004/05/06 09:16:07  voba
// merge with adding_diapasons_table_free2
//
// Revision 1.75.10.3  2004/04/13 14:19:09  step
// Изменена TFreeTbl.ResetFreeTblNum
//
// Revision 1.75.10.2  2004/04/12 16:11:40  step
// Изменены методы CheckNumber и CheckFreeNumbers
//
// Revision 1.75.10.1  2004/04/09 16:57:55  step
// Переделан класс TFreeTbl (теперь работает с диапазонами)
//
// Revision 1.75  2004/03/11 09:09:27  step
// удален временный код, записывающий сообщения в лог
//
// Revision 1.74  2004/03/05 16:54:43  step
// чистка кода
//
// Revision 1.73  2004/03/03 18:22:21  law
// - rename unit: l3Tree2 -> l3Tree.
//
// Revision 1.72  2004/02/26 09:08:56  step
// изменена THyperLinkTbl.ChangeDestDoc (добавлен параметр aNewDestSub)
//
// Revision 1.71  2004/02/12 11:45:08  step
// добавлена временная обработка ошибок в THyperLinkTbl.GetHIDList и TSubTbl.GetSIDList
//
// Revision 1.70  2003/12/15 09:37:26  step
// THyperLinkTbl.CheckHLinkOnSub игнорирует линки, у которых SourDoc = DestDoc
//
// Revision 1.69  2003/12/10 16:19:25  voba
// -bug fix in ChangeDestDoc
//
// Revision 1.68  2003/12/08 13:12:46  step
// Третий параметр THyperLinkTbl.ChangeDestDoc сделан необязательным
//
// Revision 1.67  2003/12/08 09:27:37  step
// Исправлена THyperLinkTbl.ChangeDestDoc
//
// Revision 1.66  2003/12/04 18:33:28  step
// исправлен метод ChangeDestDoc (добавлен параметр aDocList)
//
// Revision 1.65  2003/11/17 17:19:42  voba
// -add method GetParentList(aResList : TDocumentSabList; aValList  : SAB);
//
// Revision 1.64  2003/11/11 18:55:25  step
// Исправлена THyperLinkTbl.ChangeDestDoc
//
// Revision 1.63  2003/11/11 14:24:16  step
// Исправлена THyperLinkTbl.GetParentList
//
// Revision 1.62  2003/11/06 16:02:03  step
// Исправлены THyperLinkTbl.GetParentList и THyperLinkTbl.ChangeDestDoc (добавлена сортировка)
//
// Revision 1.61  2003/11/06 12:02:15  step
// Исправлены THyperLinkTbl.GetParentList и THyperLinkTbl.ChangeDestDoc (использование FillValueSABfromListEx)
//
// Revision 1.60  2003/11/06 10:39:15  step
// Добавлен метод THyperLinkTbl.ChangeDestDoc
//
// Revision 1.59  2003/11/05 16:52:01  step
// В функцию THyperLinkTbl.GetParentList добавлен параметр aSubList
//
// Revision 1.58  2003/08/05 08:45:50  voba
// -enhancement: в GetHList добавилпараметер aDocID, для фильтрации ссылок с одинаковым ID в разных документах
//
// Revision 1.57  2003/06/03 15:29:20  voba
// - rename Tl3StringDataList AddData to Add
//
// Revision 1.56  2003/05/19 11:07:15  voba
// - improvement: GetParentList фильтруем на текущий документ
//
// Revision 1.55  2003/05/06 11:32:56  voba
// -new proc: GetParentList
//
// Revision 1.54  2003/04/10 12:59:04  demon
// - bug fix
//
// Revision 1.53  2003/04/09 14:50:19  demon
// - add: функция получения SAB всех ссылок для текущего документа
//
// Revision 1.52  2003/01/22 15:25:19  demon
// - bug fix: операция CheckSub затирала FullRecord. Поправлено.
//
// Revision 1.51  2002/11/21 17:25:12  voba
// - bug fix : delete problem hLink
//
// Revision 1.50  2002/11/10 16:49:24  voba
// - new behavior: подправил DelWholeHLink, так чтобы удалялась ссылка только с текущего документа. Помогает разобраться с ситуацией, когда в разных документах стоят ссылки с одинаковым ID
//
// Revision 1.49  2002/07/02 12:09:31  demon
// - fix bugs in packed modification operation
//
// Revision 1.48  2002/04/29 11:51:36  demon
// - new behavior: in saveDocFilter now Hyperlinks and Subs deleted all at once
//
// Revision 1.47  2002/03/26 13:22:49  demon
// - new behavior: add function CheckDoubleHL
//
// Revision 1.46  2002/03/01 09:11:16  voba
// -bug fix : ошибки реализации поиска "дохлых" ссылок
//
// Revision 1.45  2001/12/03 12:58:05  demon
// - new behavior: now from clipboard may insert "dead" Hyperlinks.
//
// Revision 1.44  2001/09/04 13:59:09  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.43  2001/08/03 13:43:55  voba
// - bug fix
//
// Revision 1.42  2001/08/03 13:27:18  demon
// no message
//
// Revision 1.41  2001/08/03 12:55:13  voba
// - bug fix
//
// Revision 1.40  2001/08/03 12:12:18  demon
// - new behavior: add function CheckDestInDoc for checking dead Hyperlinks in Doc
//
// Revision 1.39  2001/08/01 12:27:43  demon
// - bug fix: savefilter now checked valid of HLList and SUBList
//
// Revision 1.38.2.1  2001/08/01 12:26:08  demon
// - bug fix: savefilter now checked valid of HLList and SUBList
//
// Revision 1.38  2001/07/06 14:38:15  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.37  2001/06/21 08:39:23  demon
// - bug fix: Cur HLink name list now getted correctly, when Sub is absent
//
// Revision 1.36  2001/06/14 12:52:54  demon
// - bug fix: something improved in clearing Hlinks when deleting Sub
//
// Revision 1.35  2001/05/30 13:16:26  demon
// - new behavior: in obj THyperLinkServer new proc AddTOCHiperLinks(aList : _Tl3LongintList)
//
// Revision 1.34  2001/03/21 13:00:12  demon
// - spelling bug fix
//
// Revision 1.33  2001/03/20 15:40:34  demon
// - add checking repaired HLinks in Free Tbl & messages to log
//
// Revision 1.32  2001/03/13 13:28:23  demon
// - add function CheckHyperLinkID
//
// Revision 1.31  2001/03/12 15:21:45  demon
// - add function CheckHyperLink
//
// Revision 1.30  2001/03/12 08:52:57  demon
// - again adding exception in set hyper link functions...
//
// Revision 1.29  2001/03/11 14:37:12  demon
// - lock record when modify bug fix
//
// Revision 1.28  2001/03/05 13:06:23  demon
// - in HLServer add new function EditHyperLink
//
// Revision 1.27  2001/02/23 14:55:20  demon
// - now if HLink not added to base - show message
//
// Revision 1.26  2001/01/11 10:59:56  demon
// fix some Delphi Warnings
//
// Revision 1.25  2000/12/15 15:36:15  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
Uses
     WinTypes, Classes, SysUtils,
     l3Tree_TLB, l3Tree, l3DatLst, l3Base,
     daTypes,
     HT_Const,
     dtIntf, DT_Sab, Dt_ATbl,
     Dt_Types, Dt_Const, dt_AttrSchema,
     Dt_Doc, dt_Link,
     l3LongintList
     ;
Const
  hlID_fld    = 1;
  hlSourD_fld = 2;
  hlDestD_fld = 3;
  hlDestS_fld = 4;
  hlUni_key   = 5; {1 2 3 4}
  hlDest_key  = 6; {3 4}

  hlFldCount  = 2;
  hlFldArr : Array[1..hlFldCount] of SmallInt = (hlDestD_fld,hlDestS_fld);

  subDID_fld  = 1;
  subSID_fld  = 2;
  subRFlag_fld= 3;
  subName_fld = 4;
  subUniKey   = 5;

  subFldCount = 2;
  subFldArr : Array[1..subFldCount] of SmallInt = (2,4);

  subRealNameFlag : Byte = 1;

Type
  PHyperLinkRec = ^THyperLinkRec;
  THyperLinkRec = Record
                    ID    : LongInt;
                    SDoc  : TDocID;
                    DDoc  : TDocID;
                    DSub  : TSubID;
                  end;

  PSubRec = ^TSubRec;
  TSubRec = packed record
             DocId : TDocID;
             SubId : TSubID;
             RealFlag: Byte;
             SubName: array[1..cSubNameSize] of Char;
            end;

  THyperLinkTbl = Class(TDocAttrTbl)
   protected
    procedure   CheckDestDoc(aRec: PHyperLinkRec);

    Function    GetParentList(DocID : TDocID;SubID : TSubID) : Sab; overload;
    procedure   GetParentList(aResList : TDocumentSabList;
                              aValList  : SAB);                overload;
   public
    Function    GetParentList(DocID : TDocID; aSubList: Tl3LongintList) : Sab; overload;
    procedure   GetParentList(aDocID : TDocID; //aSubID : TSubID; {cAnySubId}
                              aResList: TDocumentSabList;
                              aSubList: Tl3LongintList = nil); overload;


    procedure   DelHyperLink(aDocID : TDocID; aHLinkID : Longint; DestDoc : Longint; DestSub : TSubID);
    procedure   CheckDestInDoc(aDocID : TDocID; aList : Tl3LongintList);

   public
    Constructor Create(aFamily : TFamilyID); Reintroduce;

    Function    GetHListOnDoc(DocID : TDocID) : ISab;

    procedure   GetChildList(DocID : TDocID; var aDestDocIds, aRecs: Sab); overload;
    procedure   GetChildList(aDocID : TDocID; const ResList : Il3Tree;
                             const aRespondents: TDocumentSabList = nil);  overload;


    procedure   ExtractNotReferencedDocIds(const aSourDocIDs : ISab; var aNotReferencedDocIds : ISab);
                 // Выделяет из aSourDocIDs те номера документов, на которые отсутствуют гиперссылки.
                 // При этом ссылки внутри документа ("с самого на себя") не учитываются.
                 // Результат пишется во второй параметр.
    procedure   DelWholeHLink(ID : LongInt; aSDocID : LongInt);
    procedure   DelHLink(ID : LongInt;SDoc : TDocID;Dest : PDestHLinkRec);

    function    CheckHLinkOnSub(DestDoc : TDocID;
                                DestSub : TSubID;
                                anIgnoreLinksOnSelf: Boolean = True) : Boolean; overload;

    function   ChangeDestAddr(aOldDestDoc : TDocID; aOldDestSub : TSubID;
                               aNewDestDoc : TDocID; aNewDestSub : TSubID;
                               var aModifiedDocs : ISab) : Cardinal;
     overload;
    function   ChangeDestAddr(aModifyRecs : Sab;
                               aNewDestDoc : TDocID; aNewDestSub : TSubID)  : Cardinal;
     overload;
    function   ChangeDestAddr(anOldDestDoc, aNewDestDoc: TDocID;
                               aNewDestSub: TSubId; // если aNewDestSub = cAnySubId, то DestSub не будет изменен
                               var aSourDocs: ISab;
                               const aSubList: Tl3LongintList = nil) : Cardinal;
     overload;
    {* - в гиперссылках с адресами (DestDoc = anOldDestDoc, DestSub in aSubList, SourDoc in aSourDocs)
         заменяет: DestDoc --> aNewDestDoc, DestSub --> aNewDestSub}

    function   ChangeDestAddr(const aRelaceArr : array of TReplaceDocPair;
                               const aSourDocs: ISab = nil)  : Cardinal;
     overload;
    function    HasLinksWithDest(aDocId: TDocID): Boolean;
  end;

  TSubUniKey = Record
                Doc : TDocID;
                Sub : TSubID;
               end;

  TSubTbl = Class(TDocAttrTbl)
   private
    function    GetName(ComboID : TDestHLinkRec) : AnsiString; overload;

   public
    Constructor Create(aFamily : TFamilyID); Reintroduce;

    function    GetRealNamedSNums(ID : LongInt;Var MaxSub : TSubID) : Sab;

    procedure   AddSub(ID : LongInt;Sub : TSubID;Text : PAnsiChar;RealFlag : Boolean);
    procedure   PureUpdSubName(AbsNum : LongInt;Text : PAnsiChar;RealFlag : Boolean);
    procedure   UpdSubID(AbsNum : LongInt;aID : TSubID);
    function    CheckSub(ID : LongInt;Sub : TSubID;Var AbsNum : LongInt) : Boolean;
    function    CheckKeySAB(KeySab : Sab) : Sab;
    //procedure   PropagateSubNames(aOriginalDoc: TDocID);
     // У всех документов, являющихся версией документа aOriginalDoc
     // выполняется замена имеющихся у них SubName's
     // на соответствующие (соответствие - по SubId) из aOriginalDoc.

    procedure   GetDocSubOnSab(SubSab : Sab;SubList : Tl3StringDataList);
    procedure   GetDocSub(DocID : LongInt;SubList : Tl3StringDataList);
    procedure   GetDocSubOnDictItem(aDocID : TDocID; DictType : TdaDictionaryType; DictID : TDictID;
                                    SubList : Tl3StringDataList);

    function    CheckHyperLink(DestDoc : Longint;DestSub : TSubID) : Boolean;

    function    CheckDocSub(aDocID : TDocID;SubID : TSubID) : Boolean;
    procedure   AddDocSub(aDocID : TDocID; SubID : TSubID;Name : PAnsiChar;RealName : Boolean);
    procedure   PureEditSubName(aDocID : TDocID; SubID : TSubID;Name : PAnsiChar;RealName : Boolean);
    procedure   ChangeSubID(aDocID : TDocID; OldSubID, NewSubID : TSubID);

  end;

Implementation

uses
  WinProcs, Forms,

  l3Types, l3MinMax, l3String, l3KeyWrd, l3Nodes,  l3TreeInterfaces, l3Languages,

  daDataProvider,

  HT_Dll,
  Dt_Err, Dt_Misc,
  dt_Record,
  Dt_Serv, Dt_Log, Dt_List,
  Dt_LinkServ,
  Dt_Free
  ;

Constructor THyperLinkTbl.Create(aFamily : TFamilyID);
begin
 inherited Create(aFamily, Ord(ftHLink));
end;

function THyperLinkTbl.GetHListOnDoc(DocID : TDocID) : ISab;
begin
 Result := MakeSab(Self);
 Result.Select(hlSourD_fld, DocID);
 Result.Sort([hlID_fld]);
end;

Function THyperLinkTbl.GetParentList(DocID : TDocID;SubID : TSubID) : Sab;
Var
 TmpSab : SAB;
 lRefOnSelfSab : Sab;
 lRefOnSelfInvertSab : Sab;
 lFilteredSab : Sab;
 Dest   : TDestHLinkRec;
 lPhoto     : SAB;

begin
 lPhoto  := Table.PhotoOfTable;

 if SubID = cAnySubId then
  htSearch(@lPhoto,TmpSAB, Table.Handle, hlDestD_fld,Equal,@DocID,nil)
 else
  begin
   Dest.Doc:=DocID;
   Dest.Sub:=SubID;
   htSearch(@lPhoto,TmpSAB, Table.Handle, hlDest_key,Equal,@Dest,nil);
  end;
 try
  //htValuesOfKey(Result,hlSourD_fld,TmpSab); это без вычитания исходного документа

  // вычитаем сам документ из списка корреспондентов

  htSearch(@lPhoto,lRefOnSelfSab, Table.Handle,hlSourD_fld,Equal,@DocID,nil);
  try
   htNotResults(lRefOnSelfInvertSab,lRefOnSelfSab);
   try
    htAndResults(lFilteredSab,lRefOnSelfInvertSab,TmpSab);
    try
     htValuesOfKey(Result, hlSourD_fld, lFilteredSab);
    finally
     htClearResults(lFilteredSab);
    end;
   finally
    htClearResults(lRefOnSelfInvertSab);
   end;
  finally
   htClearResults(lRefOnSelfSab);
  end;

 finally
  htClearResults(TmpSAB);
 end;
 htClearResults(lPhoto);
end;

Function THyperLinkTbl.GetParentList(DocID: TDocID; aSubList: Tl3LongintList): Sab;
Var
 l_BuiltSab,
 TmpSab: SAB;
 lRefOnSelfSab: Sab;
 lRefOnSelfInvertSab: Sab;
 lFilteredSab: Sab;
 lPhoto     : SAB;

begin
 lPhoto  := Table.PhotoOfTable;

 l3FillChar(l_BuiltSab, SizeOf(SAB));
 l3FillChar(TmpSAB, SizeOf(SAB));

 // находим записи по DocID и aSubList
 if aSubList = nil then
  htSearch(@lPhoto, TmpSAB, Table.Handle, hlDestD_fld, Equal, @DocID, nil)
 else // aSubList <> nil
 begin
  htCreateEmptySAB(@lPhoto, l_BuiltSab, Table.Handle, hlDest_key, Res_Value);
  try
   GlobalHtServer.FillValueSABfromListEx(l_BuiltSab, DocID, aSubList);
   htRecordsByKey(TmpSAB, l_BuiltSab);
  finally
   htClearResults(l_BuiltSab);
  end;
 end;

 try
  // вычитаем сам документ из списка корреспондентов
  htSearch(@lPhoto, lRefOnSelfSab, Table.Handle, hlSourD_fld, Equal, @DocID, nil);
  try
   htNotResults(lRefOnSelfInvertSab,lRefOnSelfSab);
   try
    htAndResults(lFilteredSab,lRefOnSelfInvertSab,TmpSab);
    try
     htValuesOfKey(Result, hlSourD_fld, lFilteredSab);
    finally
     htClearResults(lFilteredSab);
    end;
   finally
    htClearResults(lRefOnSelfInvertSab);
   end;
  finally
   htClearResults(lRefOnSelfSab);
  end;

 finally
  htClearResults(TmpSAB);
 end;
 htClearResults(lPhoto);
end;

Procedure THyperLinkTbl.GetChildList(DocID: TDocID; var aDestDocIds, aRecs: Sab);
Var
  TmpSab : SAB;
  sortFld : SmallInt;
begin
  htSearch(nil, TmpSAB, Table.Handle,hlSourD_fld,Equal,@DocID,Nil);
  try
   sortFld:=hlDestD_fld;
   htSortResults(aRecs, TmpSab, @sortFld, 1);
   htValuesOfKey(aDestDocIds,hlDestD_fld,TmpSab);
  finally
   htClearResults(TmpSAB);
  end;
end;

Procedure THyperLinkTbl.DelWholeHLink(ID : LongInt; aSDocID : LongInt);
Var
  TmpSAB,
  TmpSab1,
  TmpSab2 : SAB;
begin
  htSearch(nil,TmpSAB,Table.Handle,hlID_fld,Equal,@ID,Nil);
  try
   if TmpSab.gFoundCnt > 0 then
   begin
    htSearch(@TmpSAB,TmpSAB2,Table.Handle,hlSourD_fld,Equal,@aSDocID,Nil);
    try
     htAndResults(TmpSab1,TmpSab,TmpSab2);
     try
      if (TmpSab1.gFoundCnt > 0) then
       Ht(htDeleteRecords(TmpSab1));

      if (TmpSab.gFoundCnt = TmpSab1.gFoundCnt) then Table.PutFreeNum(ID);
     finally
      htClearResults(TmpSAB1);
     end;
    finally
     htClearResults(TmpSAB2);
    end;
   end;
  finally
   htClearResults(TmpSab);
  end;
end;

Procedure THyperLinkTbl.DelHLink(ID : LongInt;SDoc : TDocID;Dest : PDestHLinkRec);
Const
  KeySize = 16;
Var
  AbsNum  : LongInt;
  KeyRec  : PAnsiChar;
  RecH    : RHandle;
begin
  KeyRec := l3StrAlloc(KeySize);
  try
    l3Move(ID,KeyRec[0],4);
    l3Move(SDoc,KeyRec[4],4);
    l3Move(Dest^.Doc,KeyRec[8],4);
    l3Move(Dest^.Sub,KeyRec[12],4);
    AbsNum:=Ht(htRecordByUniq(nil,Table.Handle,hlUni_key,KeyRec,@RecH));
    if AbsNum <= 0 then
     raise EHtErrors.CreateInt(ecNotFound);
    Table.DelRec(AbsNum);
  finally
    l3StrDispose(KeyRec);
  end;
end;

function THyperLinkTbl.CheckHLinkOnSub(DestDoc : TDocID;
                                       DestSub : TSubID;
                                       anIgnoreLinksOnSelf: Boolean = True) : Boolean;
Var
 TmpSAB : SAB;
 l_CorrectedSAB: SAB;
 Dest   : TDestHLinkRec;
begin
 l3FillChar(TmpSAB,SizeOf(SAB));
 if DestSub<>AllSubs
  then
   begin
    Dest.Doc:=DestDoc;
    Dest.Sub:=DestSub;
    htSearch(nil,TmpSAB,Table.Handle,hlDest_key,Equal,@Dest,Nil);
   end
  else
   htSearch(nil,TmpSAB,Table.Handle,hlDestD_fld,Equal,@DestDoc,Nil);
 try
  Result:=TmpSab.gFoundCnt<>0;
  if Result and anIgnoreLinksOnSelf then
  begin
   htSubSearch(TmpSab, l_CorrectedSAB, Table.Handle, hlSourD_fld, NOT_EQUAL, @DestDoc, nil);
   try
    Result := l_CorrectedSAB.gFoundCnt <> 0;
   finally
    htClearResults(l_CorrectedSAB);
   end;
  end;
 finally
  htClearResults(TmpSab);
 end;
end;

function THyperLinkTbl.ChangeDestAddr(aModifyRecs : Sab;
                                       aNewDestDoc : TDocID; aNewDestSub : TSubID)  : Cardinal;

 function lModifyDest(gRecNo : LongInt;fpRecord : Pointer) : MFUNC_RET;
 begin
  PHyperLinkRec(fpRecord)^.DDoc := aNewDestDoc;
  if aNewDestSub <> cAnySubId then
   PHyperLinkRec(fpRecord)^.DSub := aNewDestSub;

  CheckDestDoc(PHyperLinkRec(fpRecord));
  Result := MFUNC_SUCCESS;
 end;

var
 lHTStub : Pointer;

begin
  Result := aModifyRecs.gFoundCnt;
  if (Result = 0) then Exit;

  lHTStub := HTStub3(@lModifyDest);
  try
   Table.ModifyRecs(aModifyRecs, lHTStub, True {DupIgnore});
  finally
   HTStubFree(lHTStub);
  end;
end;

function THyperLinkTbl.ChangeDestAddr(aOldDestDoc : TDocID; aOldDestSub : TSubID;
                                       aNewDestDoc : TDocID; aNewDestSub : TSubID;
                                       var aModifiedDocs: ISab)  : Cardinal;

{* - возвращает в aModifiedDocs номера документов в которых произведена замена}

var
 lDest          : TDestHLinkRec;
begin
 aModifiedDocs := MakeSab(Self);

 if aOldDestSub <> AllSubs then
 begin
  lDest.Doc := aOldDestDoc;
  lDest.Sub := aOldDestSub;
  aModifiedDocs.Select(hlDest_key, lDest);
 end
 else
  aModifiedDocs.Select(hlDestD_fld, aOldDestDoc);

 Result := aModifiedDocs.Count;
 ChangeDestAddr(aModifiedDocs.HTSab, aNewDestDoc, aNewDestSub);

 aModifiedDocs.ValuesOfKey(hlSourD_fld);
end;

function THyperLinkTbl.ChangeDestAddr(anOldDestDoc,
                                       aNewDestDoc: TDocID; aNewDestSub: TSubId;
                                       var aSourDocs: ISab;
                                       const aSubList: Tl3LongintList = nil)  : Cardinal;
 {* - в гиперссылках с адресами (DestDoc = anOldDestDoc, DestSub in aSubList, SourDoc in aSourDocs)
         заменяет: DestDoc --> aNewDestDoc, DestSub --> aNewDestSub,
  возвращает в aSourDocs номера документов в которых произведена замена}

var
 lSab : ISab;
 lDestRec :
  packed record
   rDoc : TDocID;
   rSub : TSubID;
  end;
 lLoadedItem : Integer;

 function lFillBufferProc(aBuffer : Pointer; aBufSize : Longint): Longint;
 var
  lBufCount : Integer;
 begin
  lBufCount := Min(aBufSize div SizeOf(lDestRec), aSubList.Count - lLoadedItem);
  Result := lBufCount * SizeOf(lDestRec);
  while lBufCount > 0 do
  begin
   lDestRec.rSub := aSubList[lLoadedItem];
   l3Move(lDestRec, aBuffer^, SizeOf(lDestRec));

   Inc(PAnsiChar(aBuffer), SizeOf(lDestRec));
   Inc(lLoadedItem);
   Dec(lBufCount);
  end;
 end;

var
 lFillBufferProcStub : TFillBufferProc;

begin
 // находим записи по anOldDestDoc и aSubList
 if aSubList <> nil then
 begin
  lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
  try
   lDestRec.rDoc := anOldDestDoc;
   lLoadedItem := 0;
   lSab := MakeValueSet(Self, hlDest_key, lFillBufferProcStub);
   lSab.RecordsByKey;
  finally
   FreeFillBufferProc(lFillBufferProcStub);
  end;

  // Так делать нельзя - медленно, тк hlDestS_fld не ключ
  //lSab := MakeValueSet(Self, hlDestS_fld, aSubList.ItemSlot(0), aSubList.Count);
  //lSab.RecordsByKey;
  //lSab.SubSelect(hlDestD_fld, anOldDestDoc);
 end
 else
 begin
  lSab := MakeSab(Self);
  lSab.Select(hlDestD_fld, anOldDestDoc);
 end;

 if lSab.Count = 0 then
 begin
  aSourDocs := nil;
  Exit;
 end;

 // учитываем aSourDocs
 if (aSourDocs <> nil) then
 begin
  aSourDocs.RecordsByKey(hlSourD_fld, lSab);
  lSab.AndSab(aSourDocs);
 end;

 aSourDocs := nil;
 if lSab.Count = 0 then Exit;

 aSourDocs := MakeSabCopy(lSab);
 aSourDocs.ValuesOfKey(hlSourD_fld);

 // модификация записей: замена anOldDestDoc --> aNewDestDoc, DestSub --> aNewDestSub
 ChangeDestAddr(lSab.HTSab, aNewDestDoc, aNewDestSub);
end;

function THyperLinkTbl.ChangeDestAddr(const aRelaceArr : array of TReplaceDocPair;
                                      const aSourDocs: ISab = nil)  : Cardinal;
 {* - в гиперссылках с адресами (DestDoc = anOldDestDoc, SourDoc in aSourDocs)
         заменяет: DestDoc --> aNewDestDoc}

var
 lSrcIDSab : ISab;
 lSab : ISab;
 I : Integer;
begin
  // учитываем aSourDocs
 if (aSourDocs <> nil) then
 begin
  lSrcIDSab := MakeSabCopy(aSourDocs);
  lSrcIDSab.RecordsByKey(hlSourD_fld, MakeSab(Self));
 end
 else
  lSrcIDSab := MakePhoto(Self);

 lSab := MakeSab(Self); 
 for I := 0 to Pred(Length(aRelaceArr)) do
  with aRelaceArr[I] do
  begin
   // находим записи по anOldDestDoc
   lSab.Select(hlDestD_fld, aOldDocID, EQUAL, lSrcIDSab);

   if (aSourDocs <> nil) then
    lSab.AndSab(lSrcIDSab);

   // модификация записей: замена anOldDestDoc --> aNewDestDoc
   Result := ChangeDestAddr(lSab.HTSab, aNewDocID, cAnySubId);
  end;
end;

constructor TSubTbl.Create(aFamily : TFamilyID);
begin
 inherited Create(aFamily, Ord(ftSub));
end;

(*
Function TSubTbl.GetName(ComboID : TDestHLinkRec) : PAnsiChar;
Var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
begin
 Result:=Nil;
 AbsNum:=Ht(htRecordByUniq(Nil,Table.Handle,subUniKey,@ComboID,@RecH));
 if AbsNum=0 then raise EHtErrors.CreateInt(ecNotFound);
 Table.ClearFullRec;
 Table.GetFullRec(AbsNum,False);
 Table.GetFromFullRec(subName_fld,Result);
end;
*)

Function TSubTbl.GetName(ComboID : TDestHLinkRec) : AnsiString;
Var
 l_DocRec  : TdtRecord;
begin
 // получаем карточку документа
 l_DocRec := InitRecord(Self);
 if l_DocRec.FindByUniq(subUniKey, ComboID) then
  l_DocRec.GetField(subName_fld, Result);
end;

Function TSubTbl.GetRealNamedSNums(ID : LongInt;Var MaxSub : TSubID) : Sab;
Var
 TmpSab1,
 TmpSab2,
 TmpSab3  : Sab;
begin
 htSearch(nil,TmpSab1,Table.Handle,subDID_fld,Equal,@ID,Nil);
 try
  MaxSub:=0;
  htKeyMaximum(TmpSab1,subSID_fld,@MaxSub);
  htSearch(@TmpSab1,TmpSab2,Table.Handle,subRFlag_fld,Equal,@subRealNameFlag,Nil);
  try
   htAndResults(TmpSab3,TmpSab1,TmpSab2);
   try
    htValuesOfKey(Result,subSID_fld,TmpSab3);
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

Procedure TSubTbl.AddSub(ID : LongInt;Sub : TSubID;Text : PAnsiChar;RealFlag : Boolean);
begin
 Table.ClearFullRec;
 Table.PutToFullRec(subDID_fld,ID);
 Table.PutToFullRec(subSID_fld,Sub);
 Table.PutToFullRec(subRFlag_fld,RealFlag);
 Table.PutToFullRec(subName_fld,Text);
 Table.AddFRec;
end;

Procedure TSubTbl.PureUpdSubName(AbsNum : LongInt;Text : PAnsiChar;RealFlag : Boolean);
begin
 Table.ClearFullRec;
 Table.GetFullRec(AbsNum,True);
 try
  Table.PutToFullRec(subName_fld,Text);
  Table.PutToFullRec(subRFlag_fld,RealFlag);
  Table.UpdFRec(AbsNum);
 finally
  Table.FreeRec(AbsNum);
 end;
end;

Procedure TSubTbl.UpdSubID(AbsNum : LongInt;aID : TSubID);
begin
 Table.ClearFullRec;
 Table.GetFullRec(AbsNum,True);
 try
  Table.PutToFullRec(subSID_fld,aID);
  Table.UpdFRec(AbsNum);
 finally
  Table.FreeRec(AbsNum);
 end;
end;

function TSubTbl.CheckSub(ID : LongInt;Sub : TSubID;Var AbsNum : LongInt) : Boolean;
var
 RecH   : RHANDLE;
 subKey : TSubUniKey;
begin
 subKey.Doc:=ID;
 subKey.Sub:=Sub;
 AbsNum:=Ht(htRecordByUniq(Nil,Table.Handle,subUniKey,@subKey,@RecH));
 Result:=AbsNum <> 0;
end;

function TSubTbl.CheckKeySAB(KeySab : Sab) : Sab;
var
 realSubs,
 valKeys  : Sab;
begin
 l3FillChar(Result,SizeOf(SAB));
 htTransferToTable(KeySab,Table.Handle,subUniKey);
 htRecordsByKey(realSubs,KeySab);
 try
  if KeySab.gFoundCnt > realSubs.gFoundCnt then
   begin
    htValuesOfKey(valKeys,subUniKey,realSubs);
    try
     htXorResults(Result,KeySab,valKeys);
    finally
     htClearResults(valKeys);
    end;
   end;
 finally
  htClearResults(realSubs);
 end;
end;

Type
 TSDocRec = Record
             ID     : TDocID;
             SName  : TFullNameStr;
            end;
Const
 listFldCount = 2;
 listFldArr  : Array[1..listFldCount] of SmallInt = (fId_Fld,fFName_Fld);

Procedure TSubTbl.GetDocSubOnSab(SubSab : Sab;SubList : Tl3StringDataList);
Var
 TmpRec      : PAnsiChar;
 TmpId       : TSubID;
 lSubName    : Tl3PCharLen;

 TmpList     : TAbstractList;
 TmpMode     : TOpenMode;
 I           : LongInt;
begin
 SubList.Changing;
 try
  SubList.Clear;
  SubList.DataSize := Table.fldLength[subSID_fld];
  if SubSab.gFoundCnt>0
   then
    begin
     SubList.NeedAllocStr := True;
     TmpMode.openMode:=ROPEN_READ;
     TmpMode.Count:=subFldCount;
     TmpMode.FldArr:=@subFldArr;
     TmpList:=TAbstractList.Create(@SubSab,TmpMode);
     TmpList.ReadForvard:=True;
     try
      For I:=0 to TmpList.Count-1 do
       begin
        TmpRec:=TmpList.GetItem(I);
        TmpID:=0;
        l3Move(TmpRec[0], TmpID, Table.fldLength[subSID_fld]);
        if TmpRec[Table.fldLength[subSID_fld]] <> ' '
         then
         begin
          lSubName := l3PCharLen(TmpRec + Table.fldLength[subSID_fld], Table.fldLength[subName_fld]);
          lSubName.SLen := l3GetFilledArrayLength(lSubName.S, lSubName.SLen);
         end
         else
          lSubName := l3PCharLen('Метка N ' +IntToStr(TmpID));

        SubList.AddPCharLen(lSubName, @TmpID);
       end;
     finally
      l3Free(TmpList);
     end;
    end;
 finally
  SubList.Changed;
 end;
end;

Procedure TSubTbl.GetDocSub(DocID : LongInt;SubList : Tl3StringDataList);
Var
 SList : Sab;
begin
 htSearch(nil,SList,Table.Handle,subDID_fld,Equal,@DocID,Nil);
 try
  GetDocSubOnSab(SList,SubList);
 finally
  htClearResults(SList);
 end;
end;

Procedure TSubTbl.GetDocSubOnDictItem(aDocID : TDocID;
                                      DictType : TdaDictionaryType; DictID : TDictID;
                                      SubList : Tl3StringDataList);
Var
 TmpSab1,
 TmpSab2,
 TmpSab3,
 SList      : Sab;

 AddNullSub : Boolean;
 TmpId      : TSubID;
 TmpName    : ShortString;
 TmpPChar   : PAnsiChar;

 procedure CheckNullSub(ValList : Sab);
 var
  CurSub : TSubID;
 begin
  AddNullSub:=False;
  Ht(htOpenResults(ValList,ROPEN_READ,Nil,0));
  try
   CurSub:=1;
   if htReadResults(ValList,@CurSub,SizeOf(TSubID))<>0 then
    AddNullSub:=CurSub = 0;
  finally
   htCloseResults(ValList);
  end;
 end;

 var
  lPhoto : Sab;

begin
 if aDocID = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 if Not (DictType In sSubLinkDicts) then exit;

 TmpSab1:=TSubLinkTbl(LinkServer(Table.TblFamily).Links[DictType]).GetAssignedSubsOnID(aDocID, DictID);
 try
  CheckNullSub(TmpSab1);
  lPhoto := Table.PhotoOfTable;
  htTransferToPhoto(TmpSab1, lPhoto, subSID_fld);
  htRecordsByKey(TmpSab2,TmpSab1);
  try
   htSearch(@TmpSab2, TmpSab3, Table.Handle, subDID_fld, Equal, @aDocID, Nil);
   try
    htAndResults(SList, TmpSab2, TmpSab3);
    try
     SubList.Changing;
     try
      GetDocSubOnSab(SList,SubList);
      if AddNullSub then
       begin
        TmpID:=0;
        TmpName:='Начало документа'+#0;
        TmpPChar := l3StrNew(@TmpName[1]);
        SubList.Add(TmpPChar,@TmpID);
       end;
     finally
      SubList.Changed;
     end;
    finally
     htClearResults(SList);
    end;
   finally
    htClearResults(TmpSab3);
   end;
  htClearResults(lPhoto);
  finally
   htClearResults(TmpSab2);
  end;
 finally
  htClearResults(TmpSab1);
 end;
end;

procedure THyperLinkTbl.GetParentList(aDocID : TDocID; //aSubID : TSubID; {cAnySubId}
                                         aResList : TDocumentSabList;
                                         aSubList: Tl3LongintList = nil);
var
 lValList  : SAB;
begin
 { if fDocID = 0 then
  raise EHtErrors.CreateInt(ecNotAssigned);
 }

 if aSubList = nil then
  lValList := GetParentList(aDocID, cAnySubId {aSubID})
 else
  lValList := GetParentList(aDocID, aSubList);
 try
  GetParentList(aResList, lValList);
 finally
  htClearResults(lValList);
 end;
end;

procedure THyperLinkTbl.GetParentList(aResList : TDocumentSabList;
                                         aValList  : SAB);
var
 lTmpList : SAB;
 lSrtFlds  : TFieldArray;
begin
 aResList.ClearCurSab;
 lTmpList:=DocumentServer(Table.TblFamily).GetDocOnValues(aValList, False, Nil);
 try
  aResList.CurSab := MakeSab(DocumentServer(Table.TblFamily).FileTbl, lTmpList);

  lSrtFlds := MakeFieldArray([fPriority_fld, fSDate_Fld]);
  aResList.SortList(lSrtFlds);
 finally
  htClearResults(lTmpList);
 end;
end;

Procedure THyperLinkTbl.GetChildList(aDocID : TDocID; const ResList : Il3Tree;
                                        const aRespondents: TDocumentSabList = nil);
Var
 l_DestDocIds,
 l_FileRecs,
 l_SortedFileRecs,
 l_HLinkRecs: SAB;
 //lName    : Tl3PcharLen;
 SDocRec  : TSDocRec;
 TmpHLRec : TDestHLinkRec;
 //TmpPChar : PAnsiChar;

 lName  : AnsiString;
 CurNode  : Il3Node;
 SubNode  : Il3Node;
 Ok       : Word;
 SrtFlds  : Array [1..2] of SmallInt;
begin
 if aDocID = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 ResList.Clear;
 ResList.Changing;
 try
  GetChildList(aDocID, l_DestDocIds, l_HLinkRecs);
  try
   l_FileRecs:=DocumentServer(Table.TblFamily).GetDocOnValues(l_DestDocIds, False, nil);
   try
    if aRespondents <> nil then
     aRespondents.CurSab := MakeSab(DocumentServer(Table.TblFamily).FileTbl, l_FileRecs);

    SrtFlds[1]:=fPriority_fld;
    SrtFlds[2]:=fSDate_Fld;

    Ht(htSortResults(l_SortedFileRecs, l_FileRecs, @SrtFlds, 2));
   finally
    htClearResults(l_FileRecs);
   end;
   htClearResults(l_DestDocIds);
   try
    Ht(htOpenResults(l_SortedFileRecs, ROPEN_READ, @listFldArr, listFldCount));
    Ht(htOpenResults(l_HLinkRecs, ROPEN_READ, @hlFldArr, hlFldCount));
    try
     l3FillChar(TmpHLRec,SizeOf(TDestHLinkRec));
     Ok:=htReadResults(l_HLinkRecs,@TmpHLRec,SizeOf(TDestHLinkRec));
     While htReadResults(l_SortedFileRecs,@SDocRec,SizeOf(TSDocRec))<>0 do
      begin
       if SDocRec.ID <> aDocID then
        begin
         //TmpPChar:=l3AllocPChar(SDocRec.SName, cFullNameSize);
         //CurNode:=ResList.InsertNode(ResList.CRootNode, MakeNode(l3PCharLen(TmpPChar, -1,
         //                            GlobalDataProvider.BaseLanguage[Table.TblFamily].ANSICodePage)));

         CurNode := ResList.InsertNode(ResList.CRootNode,
                                       MakeNode(l3ArrayToPCharLen(SDocRec.SName,
                                                                  cFullNameSize,
                                                                  GlobalDataProvider.BaseLanguage[Table.TblFamily].ANSICodePage)));

         (CurNode as Il3HandleNode).Handle := SDocRec.ID;
         Repeat
          if (Ok <> 0) and
             (TmpHLRec.Doc = SDocRec.ID) and
             (TmpHLRec.Sub <> 0) and
             (ResList.FindNodeByParam(CurNode,TmpHLRec.Sub,0) = Nil)
            then
             begin
              try
               lName := LinkServer(Table.TblFamily).SubTbl.GetName(TmpHLRec);
               if Length(lName)=0
                then
                 begin
                  //l3StrDispose(TmpPChar);
                  lName:='Метка N ' + IntToStr(TmpHLRec.Sub);
                  //TmpPChar:=l3AllocPChar(TmpName[1],Length(TmpName));
                 end;
              except
               lName:='Не найдена метка N '+IntToStr(TmpHLRec.Sub);
               //TmpPChar:=l3AllocPChar(TmpName[1],Length(TmpName));
              end;

              SubNode := ResList.InsertNode(CurNode, MakeNode(l3PCharLen(lName, GlobalDataProvider.BaseLanguage[Table.TblFamily].ANSICodePage)));

              //SubNode:=ResList.InsertNode(CurNode, MakeNode(l3PCharLen(TmpPChar, -1, GlobalDataProvider.BaseLanguage[Table.TblFamily].ANSICodePage)));
              (SubNode as Il3HandleNode).Handle:=TmpHLRec.Sub;
             end;
          if TmpHLRec.Doc<=SDocRec.ID
           then
            Ok:=htReadResults(l_HLinkRecs,@TmpHLRec,SizeOf(TDestHLinkRec));
         until (Ok = 0) or (TmpHLRec.Doc>SDocRec.ID);
        end
       else
        Repeat
         if TmpHLRec.Doc<=SDocRec.ID then
          Ok:=htReadResults(l_HLinkRecs,@TmpHLRec,SizeOf(TDestHLinkRec));
        until (Ok = 0) or (TmpHLRec.Doc>SDocRec.ID);
      end;
    finally
     htCloseResults(l_HLinkRecs);
     htCloseResults(l_SortedFileRecs);
    end;
   finally
    htClearResults(l_SortedFileRecs);
   end;
  finally
   htClearResults(l_HLinkRecs);
  end;
 finally
  ResList.Changed;
 end;
(* ResList.SetSubTreeLines(ResList.RootNode);
 ResList.Modified:=False;*)
end;

function TSubTbl.CheckHyperLink(DestDoc : Longint;DestSub : TSubID) : Boolean;
var
 AbsN      : LongInt;
 IsRelated : Boolean;
begin
 Result:=DocumentServer(Table.TblFamily).CheckDoc(DestDoc,True,IsRelated) and
         ((DestSub=0) or CheckSub(DestDoc,DestSub,AbsN));
end;

Procedure THyperLinkTbl.DelHyperLink(aDocID : TDocID; aHLinkID : Longint; DestDoc : Longint; DestSub : TSubID);
Var
 Destination : TDestHLinkRec;
begin
 if (aDocID = 0) or (aHLinkID = 0)
  then raise EHtErrors.CreateInt(ecNotAssigned);

 if DestDoc <> 0 then
 begin
  with Destination do
  begin
   Doc := DestDoc;
   Sub := DestSub;
  end;
  DelHLink(aHLinkID, aDocID, @Destination);
 end
 else
  DelWholeHLink(aHLinkID, aDocID);

 GlobalDataProvider.Journal.LogEditDoc(Table.TblFamily, aDocID, da_detHyperLink, da_eoDelete);
end;

Function TSubTbl.CheckDocSub(aDocID : TDocID; SubID : TSubID) : Boolean;
Var
 AbsN : LongInt;
begin
 if aDocID = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 if SubID=0
  then
   Result:=True
  else
   Result:=CheckSub(aDocID, SubID, AbsN);
end;

Procedure TSubTbl.AddDocSub(aDocID : TDocID; SubID : TSubID; Name : PAnsiChar; RealName : Boolean);
begin
 if aDocID = 0 then
  raise EHtErrors.CreateInt(ecNotAssigned);
 AddSub(aDocID, SubID, Name, RealName);
 GlobalDataProvider.Journal.LogEditDoc(Table.TblFamily, aDocID, da_detSub, da_eoAdd);
end;

Procedure TSubTbl.PureEditSubName(aDocID : TDocID; SubID : TSubID;Name : PAnsiChar;RealName : Boolean);
Var
 AbsN        : LongInt;
begin
 if aDocID = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 if CheckSub(aDocID, SubID, AbsN)
  then
   PureUpdSubName(AbsN,Name,RealName);
 GlobalDataProvider.Journal.LogEditDoc(Table.TblFamily, aDocID, da_detSub, da_eoEdit);
end;

Procedure TSubTbl.ChangeSubID(aDocID : TDocID; OldSubID, NewSubID : TSubID);
Var
 AbsN        : LongInt;
 I           : TdaDictionaryType;
begin
 if aDocID = 0 then
  raise EHtErrors.CreateInt(ecNotAssigned);

 if CheckSub(aDocID, NewSubID, AbsN) then
  raise EHtErrors.CreateInt(ecNotEnable);

 if CheckSub(aDocID, OldSubID, AbsN) then
  UpdSubID(AbsN,NewSubID);

 For I:=Low(TdaDictionaryType) to High(TdaDictionaryType) do
  if I in sSubLinkDicts then
   TSubLinkTbl(LinkServer(Table.TblFamily).Links[I]).SetNewDestSub(aDocID, OldSubID, NewSubID);

 //fHLinkTbl.SetNewDestSub(fDocID,OldSubID,NewSubID);
 //не будем трогать ссылки ведущие на саб # OldSubID
 //наверное все-таки внутренние ссылки надо исправить

 GlobalDataProvider.Journal.LogEditDoc(Table.TblFamily, aDocID, da_detSub, da_eoEdit);
end;

procedure THyperLinkTbl.CheckDestInDoc(aDocID : TDocID; aList : Tl3LongintList);

 function lFilterNullSub(gRecNo : LongInt; fpField : Pointer) : Boolean;
 begin
  Result := PSubID(fpField)^ <> 0;
 end;

var
 curDocHL,
 curSubPair,
 destDocsID,
 destPairID : SAB;
 badDocs,
 badSubs    : SAB;

 tmpSab1,
 tmpSab2,
 ListSab    : SAB;

 TmpHandle  : LongInt;
 Field      : SmallInt;

 lHTStub    : Pointer;
 lPhoto     : SAB;

begin
 aList.Clear;
 lPhoto  := Table.PhotoOfTable;

 htSearch(@lPhoto, curDocHL, Table.Handle, hlSourD_fld, Equal, @aDocID, nil);
 try
  htValuesOfKey(destDocsID, hlDestD_fld, curDocHL);
  try
   badDocs := DocumentServer(Table.TblFamily).FileTbl.CheckIDSab(destDocsID);
  finally
   htClearResults(destDocsID);
  end;

  Field:=hlDestS_fld;
  lHTStub := HTStub3(@lFilterNullSub);
  try
   htFilterRecords(curSubPair, curDocHL, @Field, 1, lHTStub, Self);
  finally
   HTStubFree(lHTStub);
  end;

  try
   htValuesOfKey(destPairID,hlDest_key,curSubPair);
   try
    badSubs := LinkServer(Table.TblFamily).SubTbl.CheckKeySAB(destPairID);
   finally
    htClearResults(destPairID);
   end;
  finally
   htClearResults(curSubPair);
  end;

  try
   if (badDocs.gFoundCnt + badSubs.gFoundCnt) > 0 then
    begin
     l3FillChar(tmpSab1,SizeOf(SAB));
     l3FillChar(tmpSab2,SizeOf(SAB));
     if badDocs.gFoundCnt > 0 then
     begin
      htTransferToPhoto(badDocs, lPhoto, hlDestD_fld);
      htRecordsByKey(tmpSab1,badDocs);
     end;
     if badSubs.gFoundCnt > 0 then
     begin
      htTransferToPhoto(badSubs, lPhoto, hlDest_key);
      htRecordsByKey(tmpSab2,badSubs);
     end;
     try
      if (tmpSab1.gFoundCnt <> 0) and
         (tmpSab2.gFoundCnt <> 0) then
       htOrResults(ListSab,tmpSab1,tmpSab2)
      else
       if (tmpSab1.gFoundCnt <> 0) then
        htCopyResults(ListSab,tmpSab1)
       else
        htCopyResults(ListSab,tmpSab2);
      try
       Field:=hlID_fld;
       Ht(htOpenResults(ListSab,ROPEN_BODY,@Field,1));
       try
        while htReadResults(ListSab,@TmpHandle,SizeOf(TmpHandle))<>0 do
         aList.Add(TmpHandle);
       finally
        htCloseResults(ListSab);
       end;
      finally
       htClearResults(ListSab);
      end;
     finally
      htClearResults(tmpSab1);
      htClearResults(tmpSab2);
     end;
    end;
  finally
   htClearResults(badDocs);
   htClearResults(badSubs);
  end;
 finally
  htClearResults(curDocHL);
 end;
 htClearResults(lPhoto);
end;

procedure THyperLinkTbl.CheckDestDoc(aRec: PHyperLinkRec);
begin
 if aRec = nil then Exit;
 with aRec^ do
  if DDoc = 0 then
   l3System.Stack2Log(Format('Внимание! В таблице HLINK появилась ссылка на нулевой ' +
                             'документ. aLinkId = %d, aSourDoc = %d. Стек см. ниже.',
                             [ID, SDoc]));
end;

procedure THyperLinkTbl.ExtractNotReferencedDocIds(const aSourDocIDs : ISab; var aNotReferencedDocIds : ISab);
var
 lRecSab : ISab;
 lIntRefSab : ISab;
begin
 // "внутренняя" ссылка - это ссылка внутри одного и того же документа
 // "внешняя" ссылка - это ссылка с одного документа на строго другой
 // "внешние" ссылки  =  "все ссылки"  -  "внутренние" ссылки

 // 1. Сначала вычислим номера документов, имеющих "внешние" ссылки

 // Фильтрация: записи, которые соотв. aSourDocIDs
 aNotReferencedDocIds := MakeSabCopy(aSourDocIDs);
 lRecSab := MakeSabCopy(aSourDocIDs);
 lRecSab.TransferToPhoto(hlDestD_fld, Self);
 lRecSab.RecordsByKey;

 // "внутренние" ссылки среди фильтрованных записей
 lIntRefSab := MakeSabCopy(lRecSab);
 lIntRefSab.SubSelectTwoFldEq(hlSourD_fld, hlDestD_fld);

 // "внешние" ссылки среди фильтрованных записей
 lRecSab.SubtractSab(lIntRefSab);
 // Теперь, собственно, искомые на первом этапе номера документов, имеющих "внешние" ссылки
 lRecSab.ValuesOfKey(hlDestD_fld);

 // 2. Ну, и наконец, номера документов, на которые отсутствуют гиперссылки
 aNotReferencedDocIds.SubtractSab(lRecSab);
end;

(*
procedure THyperLinkTbl.ExtractNotReferencedDocIds(var aSourDocIDs, aNotReferencedDocIds: Sab);
var
 l_SourDocIds,
 l_FilteredLinks,
 l_InternalFilteredLinks,
 l_Not_InternalFilteredLinks,
 l_ExternalFilteredLinks,
 l_ReferencedDocIds,
 l_Not_ReferencedDocIds: Sab;
begin
 // "внутренняя" ссылка - это ссылка внутри одного и того же документа
 // "внешняя" ссылка - это ссылка с одного документа на строго другой
 // "внешние" ссылки  =  "все ссылки"  -  "внутренние" ссылки

 // 1. Сначала вычислим номера документов, имеющих "внешние" ссылки

 Table.RefreshSrchList;
 // Фильтрация: записи, которые соотв. aSourDocIDs
 Ht(htCopyResults(l_SourDocIds, aSourDocIds));
 try
  htTransferToPhoto(l_SourDocIDs, Table.fSrchList, hlDestD_fld);
  Ht(l_SourDocIDs.nRetCode);
  htRecordsByKey(l_FilteredLinks, l_SourDocIds);
  try
   Ht(l_FilteredLinks.nRetCode);
   // "внутренние" ссылки среди фильтрованных записей
   htRecordsForTwoKeys(l_InternalFilteredLinks, l_FilteredLinks, hlSourD_fld, EQUAL, hlDestD_fld);
   try
    Ht(l_InternalFilteredLinks.nRetCode);
    // "внешние" ссылки среди фильтрованных записей
    htNotResults(l_Not_InternalFilteredLinks, l_InternalFilteredLinks);
    try
     Ht(l_Not_InternalFilteredLinks.nRetCode);
     htAndResults(l_ExternalFilteredLinks, l_FilteredLinks, l_Not_InternalFilteredLinks);
     try
      Ht(l_ExternalFilteredLinks.nRetCode);
      // Теперь, собственно, искомые на первом этапе номера документов, имеющих "внешние" ссылки
      htValuesOfKey(l_ReferencedDocIds, hlDestD_fld, l_ExternalFilteredLinks);
      try
       Ht(l_ReferencedDocIds.nRetCode);
       // 2. Ну, и наконец, номера документов, на которые отсутствуют гиперссылки
       htNotResults(l_Not_ReferencedDocIds, l_ReferencedDocIds);
       Ht(l_Not_ReferencedDocIds.nRetCode);
       htAndResults(aNotReferencedDocIds, l_SourDocIds, l_Not_ReferencedDocIds);
       Ht(aNotReferencedDocIds.nRetCode);
       // Финиш.
      finally
       htClearResults(l_ReferencedDocIds);
      end;
     finally
      htClearResults(l_ExternalFilteredLinks);
     end;
    finally
     htClearResults(l_Not_InternalFilteredLinks);
    end;
   finally
    htClearResults(l_InternalFilteredLinks);
   end;
  finally
   htClearResults(l_FilteredLinks);
  end;
 finally
  htClearResults(l_SourDocIds);
 end;
end;
 *)

function THyperLinkTbl.HasLinksWithDest(aDocId: TDocID): Boolean;
var
 l_FoundRecs,
 l_SelfLinkedRecs,
 l_Not_SelfLinkedRecs,
 l_FoundExternalLinks: Sab;
begin
 //Table.RefreshSrchList;
 htSearch(nil, l_FoundRecs, Table.Handle, hlDestD_fld, Equal, @aDocID, nil);
 try
  Ht(l_FoundRecs.nRetCode);
  if l_FoundRecs.gFoundCnt = 0 then
   Result := False
  else
  begin
   // уберем ссылки на самого себя и снова посмотрим на оставшееся кол-во чисто внешних ссылок
   htRecordsForTwoKeys(l_SelfLinkedRecs, l_FoundRecs, hlSourD_fld, EQUAL, hlDestD_fld);
   try
    Ht(l_SelfLinkedRecs.nRetCode);
    if l_SelfLinkedRecs.gFoundCnt = 0 then
     Result := True
    else
    begin
     htNotResults(l_Not_SelfLinkedRecs, l_SelfLinkedRecs);
     try
      Ht(l_Not_SelfLinkedRecs.nRetCode);
      htAndResults(l_FoundExternalLinks, l_FoundRecs, l_Not_SelfLinkedRecs);
      try
       Ht(l_FoundExternalLinks.nRetCode);
       Result := l_FoundExternalLinks.gFoundCnt > 0;
      finally
       htClearResults(l_FoundExternalLinks);
      end;
     finally
      htClearResults(l_Not_SelfLinkedRecs);
     end;
    end;
   finally
    htClearResults(l_SelfLinkedRecs);
   end;
  end;
 finally
  htClearResults(l_FoundRecs);
 end;
end;

end.
