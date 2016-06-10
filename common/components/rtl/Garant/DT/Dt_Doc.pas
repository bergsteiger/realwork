Unit Dt_Doc;

{ $Id: Dt_Doc.pas,v 1.310 2016/05/17 11:57:53 voba Exp $ }

// $Log: Dt_Doc.pas,v $
// Revision 1.310  2016/05/17 11:57:53  voba
// -k:623081921
//
// Revision 1.309  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.308  2015/11/23 11:37:15  lukyanets
// Заготовки Renum
//
// Revision 1.307  2015/10/23 14:15:50  voba
// -bf : замена ссылок в корреспондентах выдавала AV если ссылок не найдено
//
// Revision 1.306  2015/07/03 15:21:07  voba
// - обжтопики старые не грузились
//
// Revision 1.305  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.304  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.303  2015/05/28 11:09:25  fireton
// - убираем неиспользующийся параметр из ExpandAllEdition
//
// Revision 1.302  2015/04/30 11:14:54  lukyanets
// Заготовки Большого Брата
//
// Revision 1.301  2015/04/07 07:37:09  lukyanets
// Изолируем HT
//
// Revision 1.300  2015/04/02 15:25:35  voba
// - снес TDocumentData
//
// Revision 1.299  2015/03/19 10:32:34  fireton
// - не собиралось listimport
//
// Revision 1.298  2015/03/13 11:55:46  voba
// - локальное автосохранение документов
//
// Revision 1.297  2015/01/22 14:31:40  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.296  2014/12/25 15:40:52  voba
// - функции восстановления Priority и SortDate
//
// Revision 1.295  2014/11/25 14:16:49  voba
// -bug fix  Исправление VerLink не записывалось
//
// Revision 1.293  2014/09/09 09:16:22  fireton
// - удалённая было процедура TFileTbl.AddDoc нужна утилите listimport, поэтому восстановлена
//
// Revision 1.292  2014/09/04 13:19:36  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.291  2014/07/15 12:47:22  fireton
// - получаем строку, а не PAnsiChar
//
// Revision 1.290  2014/07/14 12:20:12  fireton
// - улучшенная проверка критерия существования документа в базе
//
// Revision 1.289  2014/06/18 16:55:20  voba
// - bugfix Конфликт Анно-Док
//
// Revision 1.288  2014/06/17 10:33:25  lulin
// - переименовываем метод, чтобы название отражало его суть.
//
// Revision 1.287  2014/06/16 15:53:16  lulin
// - чистим код.
//
// Revision 1.286  2014/06/06 14:24:39  lulin
// - чистим код.
//
// Revision 1.285  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.284  2014/03/27 08:16:30  voba
// - новая функция  CheckDocPriorityEx(NullOnly : Boolean;aProgress : Tl3ProgressProc = nil);
//
// Revision 1.283  2014/02/17 16:25:59  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.282  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.281  2014/02/12 12:35:19  lulin
// - рефакторим списки заданий.
//
// Revision 1.280  2013/12/11 10:39:13  fireton
// - проверяем больше видов записи в логах, чтобы избежать потерь
//
// Revision 1.279  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.278  2013/07/26 12:58:20  dinishev
// {Requestlink:474582850}. Выключаем изменяющуюся информацию при выливке.
//
// Revision 1.277  2013/07/08 09:12:32  voba
// - K:468028619
//
// Revision 1.276  2013/05/17 15:57:53  voba
// - оптимизация скорости
//
// Revision 1.275  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.274  2012/04/20 15:20:01  lulin
// {RequestLink:283610570}
//
// Revision 1.273  2012/01/13 09:29:19  fireton
// - функция проверки наличия документа не только по таблице FILE, но и по логу (K 326776318)
//
// Revision 1.272  2011/12/22 11:18:03  fireton
// - добавляем rStatus в результирующую запись (К 321986415)
//
// Revision 1.271  2011/12/19 13:37:08  fireton
// - получаем внешние ID через JOIN (К 320745075)
//
// Revision 1.270  2011/08/31 09:00:13  voba
// - k : 281515440
//
// Revision 1.269  2011/07/28 08:42:26  voba
// - add function  GetMinValue
//
// Revision 1.268  2011/06/10 11:52:18  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать, по-старому тоже работает
//
// Revision 1.267  2011/02/18 11:27:32  voba
// - k : 236721575
//
// Revision 1.266  2011/01/28 11:27:23  voba
// - k : 251343383
//
// Revision 1.265  2010/12/23 11:49:35  voba
// - k:248195617
//
// Revision 1.264  2010/09/28 13:06:08  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.263  2010/09/28 13:00:40  voba
// [$235058492].
//
// Revision 1.262  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.261  2010/03/16 11:59:36  voba
// no message
//
// Revision 1.260  2010/02/24 11:54:50  narry
// - удаление зависимости проектов от парня
//
// Revision 1.259  2010/02/15 14:39:52  voba
// - K : 190679759
//
// Revision 1.258  2010/02/10 09:23:38  voba
// - add procedure ExpandAllEdition
//
// Revision 1.257  2010/02/02 13:54:42  voba
// - K:178324176
//
// Revision 1.256  2009/10/19 11:04:22  voba
// - избавляемся от старой библиотеки регулярных выражений
//
// Revision 1.255  2009/09/28 08:54:24  voba
// - избавляемся от старого анализатора фраз
//
// Revision 1.254  2009/09/17 11:44:33  lulin
// {RequestLink:163065542}.
//
// Revision 1.253  2009/09/15 14:32:46  voba
// - bug fix удалялись ссылки на удаляемый документ
//
// Revision 1.252  2009/09/15 12:34:07  voba
// - cc поремил неиспользуемые функции
//
// Revision 1.251  2009/09/11 08:39:48  voba
// - убрал лишние методы
//
// Revision 1.250  2009/07/29 15:05:42  voba
// - refact. удаление документа - цикл по атрибутам
//
// Revision 1.249  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.248  2009/07/20 12:38:48  voba
// - Засунул renum в атрибуты
//
// Revision 1.247  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.246  2009/06/08 13:23:24  voba
// - enh. унификация атрибутов. Избавился от псевдоатрибутов atDateNumsChDate, atRelHLink,
//
// Revision 1.245  2009/05/19 12:22:42  voba
// - переписал (не до конца) процедуру удаления доков
//
// Revision 1.244  2009/05/15 08:24:37  narry
// - восстановление
//
// Revision 1.243  2009/05/14 13:02:01  voba
// - add dlDoc2DocLink в транзакцию удаления
//
// Revision 1.242  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.241  2009/05/08 08:48:42  voba
// - del несколько неиспользуемых процедур
// - bug fix процедур удаления доков
//
// Revision 1.240  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.239  2009/04/09 06:05:05  voba
// - cc
//
// Revision 1.238  2009/03/31 09:02:58  fireton
// - импорт/экспорт атрибута "Комментарий к документу" [$121164344]
//
// Revision 1.237  2009/03/26 10:24:06  fireton
// - новое поле (Comment)
//
// Revision 1.236  2009/03/23 13:25:16  voba
// - add {$Define V131}
//
// Revision 1.235  2009/03/19 08:47:08  voba
// no message
//
// Revision 1.234  2009/03/03 12:33:55  voba
// - сс убил fDateNums
//
// Revision 1.233  2009/03/03 08:42:44  fireton
// - GetFullRecOnID теперь возвращает номер записи
//
// Revision 1.232  2009/03/02 08:10:41  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.231  2009/02/20 13:27:58  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.230  2009/02/03 12:01:04  voba
// - выкрутил флажок  "Подключен" из записи для скорости (см  {$ifdef NeedInclInDocRec})
//
// Revision 1.229  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.228.2.1  2009/01/23 14:06:29  fireton
// - перенос Парня на Query
//
// Revision 1.228  2008/11/10 14:31:44  fireton
// - пара новых сервисных функций (рефакторинг)
//
// Revision 1.227  2008/10/31 09:58:12  voba
// - перевел  property Docs  на ISab
//
// Revision 1.226  2008/09/19 13:14:56  voba
// - add type TDocListAccessRec
//
// Revision 1.225  2008/09/17 14:47:47  fireton
// - новая версия базы (130)
// - срочность документа
//
// Revision 1.224  2008/05/22 13:06:29  voba
// - add  function IsValidDocID
//
// Revision 1.223  2008/05/07 15:53:40  voba
// - Refact. function .GetRelImportNum и GetINumber убил, вместо нех использовать GetExtDocID
//
// Revision 1.222  2008/05/05 10:39:54  voba
// - избавлялся от старой автоклассификации
//
// Revision 1.221  2008/04/30 10:14:46  voba
// - add  procedure ChangeHLAddr
//
// Revision 1.220  2008/04/23 09:03:40  voba
// no message
//
// Revision 1.219  2008/04/07 11:37:57  voba
// - bug fix
//
// Revision 1.218  2008/03/28 10:00:56  voba
// - ren GetRecordByUniq -> GetRecordIDByUniq
// - ren HasRecordsWith -> HasRecord
//
// Revision 1.217  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.216  2008/02/19 11:38:38  lulin
// - восстановил компилируемость Архивариуса.
//
// Revision 1.215  2008/02/13 16:03:08  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.214  2008/02/13 14:07:34  voba
// - del  procedure DocSAB2Stream, Stream2NumSAB, Stream2DocSab (пользуйтесь функциями из dt_sab)
//
// Revision 1.213  2008/02/12 14:39:28  voba
// - refact.
//
// Revision 1.212  2008/02/07 14:44:41  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.211  2008/02/01 16:41:34  lulin
// - используем кошерные потоки.
//
// Revision 1.210  2008/01/29 07:29:13  voba
// - add comment.
//
// Revision 1.209  2007/12/06 11:40:59  lulin
// - cleanup.
//
// Revision 1.208  2007/11/30 09:05:05  voba
// - bug fix
//
// Revision 1.207  2007/11/26 10:08:30  voba
// - use cUndefDictID, cUndefDocID, cUndefSubID
//
// Revision 1.206  2007/11/12 12:40:41  fireton
// - bug fix: неверное определение типа саба БД
//
// Revision 1.205  2007/08/30 12:37:59  lulin
// - удален ненужный модуль.
//
// Revision 1.204  2007/08/22 13:02:28  narry
// - обновление своих выборок, не дожидаясь ответа с сервера
//
// Revision 1.203  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.202  2007/08/14 19:31:55  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.201  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.200  2007/07/24 12:32:33  narry
// - рефакторинг системы сообщений
//
// Revision 1.199  2007/07/13 14:04:26  voba
// no message
//
// Revision 1.198  2007/07/04 07:45:41  narry
// - не пересылалась выборка документов
//
// Revision 1.197  2007/07/03 15:07:11  voba
// - change function TDocumentSabList.GetIndex
//
// Revision 1.196  2007/07/03 13:30:59  voba
// - переход на ISabCursor
//
// Revision 1.195  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.194  2007/06/22 14:35:00  voba
// - change Sab to ISab
//
// Revision 1.193  2007/05/25 15:27:21  voba
// - DeleteRecsByKeys теперь возвращает количество удаленных и подывмает exception в случае ошибок
//
// Revision 1.192  2007/05/18 12:23:40  fireton
// - реорганизация Большого Брата:
//   * логика перенесена из вызывающего кода в ББ
//   * изничтожен OperationHandle
//
// Revision 1.191  2007/04/27 14:24:37  voba
// - add procedure   SprIDs2DocIDs
// - del function TDocumentServer.AddDoc
//
// Revision 1.190  2007/04/27 07:49:33  fireton
// - Рефакторинг DT. Перевод THTServer на идентификаторы таблиц.
//
// Revision 1.189  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.188  2007/04/23 07:30:03  voba
// - change Sab to ISab
//
// Revision 1.187  2007/04/19 08:07:41  voba
// - del function TFileTbl.JoinIDSabs
//
// Revision 1.186  2007/04/17 11:15:43  voba
// no message
//
// Revision 1.185  2007/04/10 10:59:54  voba
// - refact.
//
// Revision 1.184  2007/03/30 14:03:16  voba
// - merge
//
// Revision 1.183.2.1  2007/03/30 13:43:42  voba
// - change Sab to ISab
//
// Revision 1.183  2007/03/26 09:34:03  fireton
// - изменился формат l3System.FreeLocalMem
//
// Revision 1.182  2007/03/02 10:09:40  voba
// - bug fix htSubSearch Bug
//
// Revision 1.181  2007/02/22 09:22:19  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.180  2007/02/16 16:13:06  voba
// - rename type Condition ->ThtCondition
//
// Revision 1.179  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.178  2006/10/04 08:30:14  voba
// - merge with b_archi_ht64
//
// Revision 1.177.2.2  2006/09/19 14:41:38  voba
// - при удалении дока не трогаем ссылки на него
//
// Revision 1.177.2.1  2006/09/19 07:49:10  voba
// - переход на HTStub
//
// Revision 1.177  2006/09/07 16:12:16  voba
// - bug fix
//
// Revision 1.176  2006/08/23 07:56:38  voba
// - merge
//
// Revision 1.175.10.2  2006/07/14 14:07:03  voba
// - imp. procedure   GetAnnoSABonDocSAB добавил параметр aHasAnno : Boolean = True теперь можно получить список доков БЕЗ HasAnno
//
// Revision 1.175  2006/02/06 13:32:55  voba
// - new beh. выпилил поддержку стаго хранилища (часть 2)
//
// Revision 1.174  2005/12/06 11:59:39  voba
// - открутил зануление ссылок при удалении документа
// - del Procedure   SetEmptyDestOnDocs(DestDocs : SAB);
// - del Procedure   SetEmptyDestOnSab(RecSab : Sab;IDSab : Sab);
//
// Revision 1.173  2005/11/11 15:09:48  voba
// - del procedure BaseStatistic
//
// Revision 1.172  2005/10/18 12:34:00  step
// в GetPublishData добавлена сортировка по SourceId
//
// Revision 1.171  2005/10/17 13:23:01  step
// изменена TDocumentData.GetPublishedList (возвращает другие данные)
//
// Revision 1.170  2005/10/06 11:40:47  voba
// - enh. use l3ConcatText in GroupUpdateDoc
//
// Revision 1.169  2005/09/08 09:35:20  step
// no message
//
// Revision 1.168  2005/09/08 09:27:27  step
// new: TFileTbl.GetFutureVersions
//
// Revision 1.167  2005/08/12 07:46:53  voba
// - bug fix: не сбрасывался Modified у fDateNums после записи
//
// Revision 1.166  2005/08/03 17:38:06  step
// исправлен метод FindDocs и перенесен из модуля Dt_Active в Dt_Doc
//
// Revision 1.165  2005/07/28 15:12:13  voba
// - improve : в procedure SetCorrectLisеt, SetPublishedList убрал неиспользуемые параметры
//
// Revision 1.164  2005/07/25 13:07:25  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.163  2005/06/09 10:54:31  step
// new: TDocumentSabList.GetDocIds
//
// Revision 1.162  2005/05/17 13:28:59  voba
// no message
//
// Revision 1.161  2005/05/16 11:05:32  voba
// add parameter   aPreventNumFree to procedure DelDocEx
//
// Revision 1.160  2005/04/07 08:19:13  step
// bug fix: TFileTbl.GetHasAnno
//
// Revision 1.159  2005/04/04 09:45:42  step
// new: TFileTbl.GetHasAnno
//
// Revision 1.158  2005/03/30 09:26:52  narry
// - экспорт важности для специальных Аннотаций
//
// Revision 1.157  2005/03/22 14:41:56  step
// исправлено название метода у LinkServer
//
// Revision 1.156  2005/03/22 11:59:49  step
// change:TDocumentServer.DelDocEx, TDocumentServer.DelDocsEx - добавлен параметр aDeleteText
//
// Revision 1.155  2005/03/22 11:26:11  step
// new: TDocumentServer.DelDocEx, TDocumentServer.DelDocsEx
//
// Revision 1.154  2005/03/16 08:47:28  voba
// - почистил
//
// Revision 1.153  2005/03/16 08:44:31  voba
// - improve заменил PAnsiChar на String
// - временно перекрыл PutToFullRec и GetFromFullRec из-за перехода на String, Надо будет поправить в базовом классе и заменить на String все места использования
//
// Revision 1.152  2005/03/15 09:35:40  step
// убран флаг f_CardIsEmpty
//
// Revision 1.151  2005/03/14 12:57:04  step
// изменены параметры TDocumentServer.GroupUpdateDoc: PAnsiChar --> string
//
// Revision 1.150  2005/03/14 09:42:37  step
// в структуре TCardRec: замена PAnsiChar --> string
// в TDocumentData: поле f_CardModified заменено функцией CardModified
//
// Revision 1.149  2005/03/10 16:44:03  step
// убраны типы: TCardEditRec, TFullCardRec, TFullCardEditRec.
// рефакторинг: TFileTbl.UpdDoc, TDocumentData.Card, TDocumentServer.GroupUpdateDoc
// замена: FullCard^.Card --> Card
//
// Revision 1.148  2005/03/09 11:29:14  step
// no message
//
// Revision 1.147  2005/03/09 11:24:13  step
// TFileTbl.UpdDoc теперь обрабатывает и HasAnno
//
// Revision 1.146  2005/03/02 16:02:23  narry
// - Новые методы: JoinIDSabs и GetAnnoSABonDocSAB
//
// Revision 1.145  2005/02/28 18:37:52  step
// new: TFileTbl.SetHasAnno, TFileTbl.DelDocsEx
//
// Revision 1.144  2005/02/22 17:40:21  step
// Добавление поля HasAnno в табл. FILE
//
// Revision 1.143  2005/02/22 15:09:46  step
// начинаем обработку аннотаций
//
// Revision 1.142  2005/02/11 10:16:42  voba
// - improve TDocumentData.SetLogRec
//
// Revision 1.141  2005/01/14 14:34:38  voba
// - improvement RefreshVersionsList : обработка ссылок на отсутствующие документы
//
// Revision 1.140  2005/01/11 10:56:33  step
// В TDocumentSabList добавлена поддержка интерфейса Il3ChangeNotifier
//
// Revision 1.139  2005/01/11 09:58:22  voba
// - rename TFileTbl.GetAllRelated to TFileTbl.GetAllVerLinkOrder
//
// Revision 1.138  2004/12/23 10:19:30  step
// TDocumentSabList.SetDocIds использует BuildSab
//
// Revision 1.137  2004/12/22 12:56:41  step
// new: procedure TDocumentSabList.SetDocIds
//
// Revision 1.136  2004/12/09 09:48:35  voba
// - synchro
//
// Revision 1.135  2004/11/15 16:23:11  step
// повторяющийся код убран в метод CheckFamilyNum
//
// Revision 1.134  2004/11/15 14:38:06  step
// изменена TDocumentSabList.GetDocs
//
// Revision 1.133  2004/11/15 12:13:15  step
// new: property TDocumentSabList.Docs
//
// Revision 1.132  2004/11/10 12:43:12  step
// изменены TDocumentServer.DelDoc и TDocumentServer.DelDocs (учитывается наличие ссылок на документы)
//
// Revision 1.130  2004/11/04 18:23:52  step
// чистка fOrderIndex в "деструкторе"
//
// Revision 1.129  2004/11/04 17:43:11  step
// форматирование
//
// Revision 1.128  2004/11/04 13:47:23  step
// new: property TDocumentData.RespondentsList
//
// Revision 1.127  2004/11/03 17:41:37  voba
// - optimize work in textbase
//
// Revision 1.126  2004/10/29 08:14:55  voba
// - попытка побороться с зависаниями при удалении
//
// Revision 1.125  2004/10/12 13:52:50  voba
// - improvement DelDoc уменьшено время, которое остается захваченной текстовая БД
//
// Revision 1.123  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.122  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.121  2004/08/30 14:43:13  law
// - cleanup.
//
// Revision 1.120  2004/08/27 15:13:34  voba
// - merge with B_New_Text_Base
//
// Revision 1.119.2.1  2004/08/25 16:36:31  law
// - постепенно отказываемся от прямого использования старого хранилища.
//
// Revision 1.119  2004/08/24 16:59:39  voba
// - add поддержка нового метода удаления топиков (см Define OldTextBaseAccess)
//
// Revision 1.118  2004/08/19 12:11:31  step
// изменена посылка сообщений об удаленных документах с ипользованием новой TDocumentServer.SendMessageAboutDeletedDocs
//
// Revision 1.117  2004/08/17 12:16:53  step
// code clean: TDocumentServer.DelDocs
//
// Revision 1.116  2004/08/17 09:36:38  step
// изменена TFileTbl.GetRelated - добавлен параметр aRelatedToTheseDocsOnly
//
// Revision 1.115  2004/08/16 15:49:12  step
// new: TDocumentServer.DelDocs, TFileTbl.GetRelated
//
// Revision 1.114  2004/08/06 08:55:16  voba
// -  спец. заточка для ловли фантомных справок
// - function TFileTbl.SetRelated возвращает старый ID
//
// Revision 1.113  2004/08/03 08:52:47  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.112  2004/07/22 14:16:58  voba
// - rename fPriceLevel_Fld ->  fStatus_Fld  PriceLevel ->  Status, который выполняет функцию набора флагов состояния документа (см.dstatChargeFree, dstatNotTM   в  Dt_Const)
//
// Revision 1.111  2004/07/22 10:32:49  voba
// вывод реального exception в UpdDoc в лог
//
// Revision 1.110  2004/07/14 13:28:27  step
// продолжительность транзакции задается в StartTA
//
// Revision 1.109  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.108.2.1  2004/06/17 18:03:48  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.108  2004/06/03 10:14:21  step
// change: TDocumentServer.ChangeDestDoc - параметр aSubList может отсутствовать
//
// Revision 1.107  2004/05/21 19:00:15  step
// переписана TFileTbl.GetAllVersionsOfDoc
//
// Revision 1.106  2004/05/21 15:53:04  step
// new: TFileTbl.GetAllVersionsOfDoc
//
// Revision 1.105  2004/05/13 16:32:18  step
// замена: "TFreeTbl.Create ..." --> "GlobalHtServer.FreeTbl[...]"
//
// Revision 1.104  2004/05/13 13:59:21  step
// замена GlobalHTServer.StartTransactionWithWait на GlobalHTServer.StartTransaction
//
// Revision 1.103  2004/05/12 13:22:36  voba
// -rename ev_lpRTrim -> l3RTrim
//
// Revision 1.102  2004/03/31 15:52:24  voba
// -bug fix: в TDocumentData.Create поданный DocID=0 преобразовывался в номер справки
//
// Revision 1.101  2004/03/29 09:32:44  voba
// no message
//
// Revision 1.100  2004/03/25 17:17:15  voba
// -bug fix: при удалении документа удалялись источники опубликования
//
// Revision 1.99.2.1  2004/03/25 17:15:09  voba
// -bug fix: при удалении документа удалялись источники опубликования
//
// Revision 1.99  2004/03/16 08:17:12  voba
// -new behavior: SetDocStages стала virtual
//
// Revision 1.98  2004/03/05 16:52:23  step
// чистка кода
//
// Revision 1.97  2004/03/03 18:22:21  law
// - rename unit: l3Tree2 -> l3Tree.
//
// Revision 1.96  2004/02/26 09:06:32  step
// изменена ChangeDestDoc (добавлен параметр aNewDestSub)
//
// Revision 1.95  2004/02/20 08:23:06  voba
// no message
//
// Revision 1.94  2004/01/23 15:51:38  voba
// no message
//
// Revision 1.93  2004/01/14 13:09:31  voba
// no message
//
// Revision 1.92  2004/01/13 15:14:46  voba
// - code clean
//
// Revision 1.91  2003/12/15 10:43:04  step
// Использование htSortedRecords в теле TDocumentSabList.GetValueSub
//
// Revision 1.90  2003/12/10 16:21:44  voba
// -bug fix in TDocumentSabList.GetValueSub
//
// Revision 1.89  2003/12/05 16:58:23  voba
// -code clean
//
// Revision 1.88  2003/12/04 18:33:28  step
// исправлен метод ChangeDestDoc (добавлен параметр aDocList)
//
// Revision 1.87  2003/12/02 14:08:50  fireton
// - refactoring: перенос функции анализа заголовка в TDocumentAttrData и частичная отвязка оной от базы
//
// Revision 1.86  2003/12/02 08:20:35  voba
// -code clean
//
// Revision 1.85  2003/12/01 17:02:08  law
// - buf fix: восстановил вызовы (через локальные процедуры).
//
// Revision 1.84  2003/12/01 16:43:25  law
// - buf fix: восстановил вызовы (через локальные процедуры).
//
// Revision 1.83  2003/12/01 16:20:37  law
// - change: переходим от вызовов методов объектов к вызовам глобальных/локальных процедур.
//
// Revision 1.82  2003/11/17 17:20:36  voba
// -add method ChangeDestDoc
//
// Revision 1.81  2003/11/04 14:03:06  voba
// -new behavior вытащилDateNums из TFullCardRec для стандартизации обработки
//
// Revision 1.80  2003/10/02 13:51:28  voba
// - bug fix
//
// Revision 1.79  2003/09/22 13:57:53  voba
// - add comment
//
// Revision 1.78  2003/06/19 09:10:03  voba
// - code improvement
//
// Revision 1.77  2003/05/28 15:44:43  voba
// - add: propertyt TDocumentSabList.WithOrder (еслиTrue объект отдает Items  в порядке их вставки)
//
// Revision 1.76  2003/05/19 15:41:52  demon
// - add: добавлен новый атрибут dlAutoClasses
//
// Revision 1.75  2003/05/08 13:58:19  voba
// - bug fix
//
// Revision 1.74  2003/05/08 08:13:28  voba
// - improvement: ускорили процесс получения списка активных документов
//
// Revision 1.73  2003/05/07 08:31:39  voba
// добавил свойство TDocumentData CorespondentsList
//
// Revision 1.72  2003/05/06 14:04:57  step
// Добавлено проверка на зацикленность ссылок в TDocumentData.GetVersionsList
//
// Revision 1.71  2003/05/06 11:27:18  step
// Добавлено property TDocumentData.VersionsList
//
// Revision 1.70  2003/04/29 15:45:16  voba
// - improvement: CheckVerLink выдает номер топика в котором уже стоит такойже VerLink
//
// Revision 1.69  2003/04/07 13:07:35  voba
// no message
//
// Revision 1.68  2003/04/04 12:39:55  demon
// - new behavior: уменьшен буфер для чтения записей из выборок
// HyTech до (65k - 1)
//
// Revision 1.67  2003/04/01 13:34:44  voba
// -merge
//
// Revision 1.66  2003/04/01 06:54:58  voba
// -bug fix: TDocReadRec.NoActive вычислялась неправильно
//
// Revision 1.65  2003/03/31 13:48:59  demon
// - new: увеличен размер буферов, выделяемых по умолчанию с 64кб до 8Мб
//
// Revision 1.64  2003/03/26 16:21:03  voba
// -bug fix: неудавалось присвоить пустое значение (0) VerLink
//
// Revision 1.63  2003/03/13 10:02:37  demon
// - new: добавлена обработка нового поля в данных документа - VerLink
// (+ все функции работы с этим параметром аналогичны Releated)
//
// Revision 1.62  2003/03/12 15:47:40  demon
// - new behavior: поддержка работы со "звоночками" (Alarms)
//
// Revision 1.61  2003/03/12 14:58:21  demon
// - new behavior: в работу TDocumentSabList добавлена возможность
//  проверки статуса документов
//
// Revision 1.60  2003/03/12 13:45:09  demon
// - new behavior: удалены поля NoActive и PreActive.
//
// Revision 1.59  2003/03/11 15:11:22  demon
// - add: добавлена работа с таблицей ActiveInterval
//
// Revision 1.58  2003/03/11 09:45:31  step
// Добавлена пара методов в класс TFileTbl: WrongDocs и GetDocIdsOnRelated
//
// Revision 1.57  2003/01/21 09:50:47  demon
// - sintax check
//
// Revision 1.56  2003/01/20 09:26:11  voba
// no message
//
// Revision 1.55  2003/01/14 14:28:36  demon
// - add new operation GetAllDocumentIDs in DocumentServer
//
// Revision 1.54  2002/11/21 17:14:54  law
// - bug fix: неправильно обрабатывалась директива MonoUser.
//
// Revision 1.53  2002/10/28 16:41:54  voba
// - small code improving
//
// Revision 1.52  2002/06/20 07:01:51  narry
// - bug fix: range check error при записи пустого саба
//
// Revision 1.51  2002/04/15 12:17:00  demon
// - add Free Tbl in all massive transaction.
//
// Revision 1.50  2002/04/04 15:38:13  demon
// - change fullNameSize to 1000
//
// Revision 1.49  2002/04/03 13:58:56  demon
// - bug fix in reading deleting Dicts records
//
// Revision 1.48  2002/01/10 14:14:44  voba
// -lib sincro: replace l3GetStrLen to l3StrLen
//
// Revision 1.47  2001/11/21 12:50:31  demon
// - new: add new doc attribute - _dictionary #F (dlAccGroups)
//
// Revision 1.46  2001/09/04 13:59:09  voba

// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.45  2001/08/23 10:27:44  demon
// - add new Type - TDocType its replaced some constants
//
// Revision 1.44  2001/08/08 11:22:12  voba
// bug fix
//
// Revision 1.43  2001/08/03 12:12:19  demon
// - new behavior: add function CheckDestInDoc for checking dead Hyperlinks in Doc
//
// Revision 1.42  2001/07/06 14:38:14  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.41  2001/06/29 10:41:54  narry
// -bug fix: урезание текста сообщений до килобайт
//
// Revision 1.40  2001/01/19 16:21:23  demon
// - now Warning link tbl become usual link tbl (witout uniq key and additional feelds)
//
// Revision 1.39  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
Uses
 Classes,SysUtils, WinTypes,
 l3Base, l3Types, l3Date, l3DatLst, l3ChangeNotifier,
 l3BaseRefInterfacedList,
 l3InternalInterfaces, l3Interfaces,
 HT_Const,

 Dt_Types,Dt_Const,
 dt_Record,
 dt_AttrSchema, dt_ImpExpTypes,
 dtIntf, Dt_Sab, Dt_ATbl, Dt_List,
 Dt_Free, Dt_Log, Dt_ReNum,
 Dt_Stage, Dt_Active, Dt_Alarm, CsClient,
 l3LongintList
 ;
Const
 cFullNameSize   = 1000;  // ограничение БД на размер FullName
 cUserFullNameSize = 730; //пользовательское ограничение на размер FullName и AnnoName
 cShortNameSize  = 70;
 cDocCommentSize = 100;
 cPaperPlaceSize = 100;
 ArchivePlace   = $FFFE;

 docIdFld : ThtField = 1;
 docRelatedIdFld: ThtField = 9;

 fId_Fld         = 1;
 fSName_Fld      = 2;
 fFName_Fld      = 3;
 fStatus_Fld     = 4;
 fPriority_fld   = 5;
 fSDate_Fld      = 6;
 fType_Fld       = 7;
 fUserType_Fld   = 8;
 fRelated_fld    = 9;
 fPaperUser_fld  = 10;
 fPaperPlace_fld = 11;
 fPriorFlag_fld  = 12;
 fStageMask_fld  = 13;
 fVerLink_fld    = 14;
 fHasAnno_fld    = 15;
 fUrgency_fld    = 16;
 fComment_fld    = 17;

 urgRegular      = 0;
 urgUrgent       = 1;
 urgToVersion    = 2;

 cMaxUrgency     = 2;

 cUrgencyCaption: array[0..cMaxUrgency] of string = ('обычный','срочный','в версию');

 DocReadFldCount = 4;
 DocReadFldArr : Array[1..DocReadFldCount] of SmallInt = (fId_Fld,fType_Fld,
                                                          fUserType_Fld,fFName_Fld);

Type
 TShortNameStr  = Array [1..cShortNameSize] Of Char;
 TFullNameStr   = Array [1..cFullNameSize] Of Char;
 TDocCommentStr = Array [1..cDocCommentSize] Of Char;

(* Структура данных документа при чтении из таблицы *)
 PDocReadTblRec = ^TDocReadTblRec;
 TDocReadTblRec = record
                   ID       : TDocID;
                   Typ      : Byte;
                   Flag     : Byte;
                   Name     : TFullNameStr;
                   Urgency  : Byte;
                  end;

(* Структура данных документа при выводе на экран *)
 PDocReadRec = ^TDocReadRec;
 TDocReadRec = record
                ID       : TDocID;
                Typ      : Byte;
                Flag     : Byte;
                Name     : TFullNameStr;
                Urgency  : Byte;
                NoActive : Boolean; // не табличный параметр, заполняется в момент
                                    // чтения, на основе данных из таблицы ActiveInterval
               end;

 PDocListAccessRec = ^TDocListAccessRec;
 TDocListAccessRec = record
                rID        : TDocID;
                rExtID     : TDocID;
                rTyp       : Byte;
                rFlag      : Byte;
                rName      : TFullNameStr;
                rUrgency   : Byte;
                rStatus    : Word;
                rIsActive  : LongBool;
               {$ifdef NeedInclInDocRec}
                rIsInclude : LongBool;
               {$Endif}
                rComment   : TDocCommentStr;
                //rSDate     : TstDate;
               end;

 PIDFNameRec = ^TIDFNameRec;
 TIDFNameRec = packed record
  rDocID : TDocID;
  rName  : TFullNameStr;
 end;

 TFileTbl = Class(TPrometTbl)
  private
   procedure   PutFieldToRecord(aRecord : PAnsiChar; aField : ThtField; const aBody); override;
   procedure   GetFieldFromRecord(aRecord : PAnsiChar; aField : ThtField;var aBody);  override;
  public
   Constructor Create(aFamily : TFamilyID); Reintroduce;

   function    AddDoc : LongInt; // нужна утилите listimport
   Procedure   DelDoc(ID : LongInt);
   Procedure   DelDocs(IDs : ISab);
   function    CheckDoc(ID : TDocID; aDocRec : PdtRecord = nil) : Boolean;
   function    GetDocRecord(var aID : TDocID; var aDocRec : TdtRecord) : Boolean;
   Function    CheckRel(aRelID : TDocID) : LongInt;

   Function    GetDocIdOnRelated(aRelID : TDocID) : TDocID;

   function    GetRelated(aDocID : TDocID; Var LastRel : Boolean) : TDocID; overload;

   procedure   GetRelated(var aDocIDs: ISab;
                          out aRelatedIds: ISab;
                          aRelatedToTheseDocsOnly: Boolean); overload;

   procedure   SetVerLink(ID,VL_ID : LongInt);
   function    GetVerLink(aDocID : TDocID) : TDocID;
   function    HasVerLink(aLinkID : TDocID) : boolean;
   function    CheckVerLink(aLinkID : TDocID) : TDocID; // Возвращает номер документа,
                                                        // у которого стоит указанный aLinkID
                                                        // или 0, если этот aLinkID уникальный.
   function    GetHasAnno(aDocID : TDocID): Boolean;
   procedure   GetAllVerLinkOrder(aDocID: TDocID; aDocList: TL3LongintList);
   procedure   ExpandAllEdition(aDocSet: ISab);

   procedure   SprIDs2DocIDs(const aDocIDs : ISab);
    {* - переводит список номеров, среди которорых могут содержаться справки
         в список номеров, в котором номера справок заменены на номера доков}

   procedure   SetHasAnno(var aDocIds: Sab; aValue: Boolean); overload;
   procedure   GetAnnoSABonDocSAB(aDocIds: Sab; out AnnoSAB: SAB; aHasAnno : Boolean = True);
   //function GetFullRecOnID(anID: LongInt; aNeedHold: Boolean): Longint;
 end;

 TDocumentSabList = class; // forward declaration

 TDocumentServer = Class(TL3Base)
  private
   f_CSClient: TcsClient;
   procedure SendMessageAboutDeletedDocs(aDocIdsArray: array of Longint);
   procedure CheckFamilyNum; // выбрасывает исключение
  protected
   fFamily          : TFamilyID;

   fFileTbl         : TFileTbl;

   fProgressProc    : Tl3ProgressProc;
   fCurProgress     : LongInt;
   fCurProgressDelta: LongInt;

   procedure SetFamily(aValue : TFamilyID);
   function  MakeAttrTableArray : Il3CBaseList;
  public
   procedure Cleanup; override;
   function  CheckDoc(aDocID : TDocID;WithRel : Boolean; var RelFlag : Boolean) : Boolean;

   procedure Update;

   function  GetDocOnValues(Values : SAB;WithSort : Boolean;Photo  : LPSab) : SAB;

   procedure CheckDocPriorityEx(NullOnly : Boolean;aProgress : Tl3ProgressProc = nil);
   { В штатном софте не используется, решал проблемы с перерассчетом "на коленке"}
   procedure CheckDocPriority(NullOnly : Boolean;aProgress : Tl3ProgressProc);
   { Используется в Парне и Трубе. Желательно вынести в отдельный модуль }
   procedure DelDoc(aDelDocID: TDocID);
   { Удаляет документ с aDelDocID.
     Если на документ имеются гиперсылки или verlink, то при удалении остаются записи в таблице Renum,
     не добавляется элемент во Free и не чистятся ссылки на удаляемый документ. }
   procedure DelDocEx(aDelDocID: TDocID; aDeleteAnnos, aDeleteText: Boolean; aPreventNumFree : Boolean = false);
   { Удаляет документ с aDelDocID.
     Если на документ имеются гиперсылки или verlink или aPreventNumFree, то при удалении остаются записи в таблице Renum,
     не добавляется элемент во Free и не чистятся ссылки на удаляемый документ}

   procedure DelDocs(aDocIDs: ISab);
    // аналог процедуры DelDoc, с одним только отличием - удаляет не один, а несколько документов
   procedure DelDocsEx(aDocIDs: ISab; aDeleteAnnos, aDeleteTexts: Boolean);

   procedure DelRel(RelID : TDocID);

   function  GetRelImportNum(DocImpNum : TDocID) : TDocID;

   function  ChangeDestDoc(anOldDestDoc, aNewDestDoc: TDocID;
                           aNewDestSub: TSubID; // если aNewDestSub = cUndefSubID, то DestSub не будет изменен
                           const aSubList: Tl3LongintList = nil;
                           const aDocList: ISab = nil) : cardinal;
    overload;
   {* - замена в гиперссылках
       с адресами (DestDoc = anOldDestDoc,
                   DestSub = из aSubList, если aSubList <> nil)
       DestDoc --> aNewDestDoc и
       DestSub --> aNewDestSub (см. условие выше)
   }

   function  ChangeDestDoc(const aRelaceArr : array of TReplaceDocPair;
                           const aDocList: ISab) : cardinal;
    overload;

   procedure ChangeHLAddr(aOldDestDoc : TDocID; aOldDestSub : TSubID;
                          aNewDestDoc : TDocID; aNewDestSub : TSubID);
   function CheckDocEx(aDocID : TDocID): Boolean;

   property  Family : TFamilyID read fFamily write SetFamily;

   property  FileTbl : TFileTbl read fFileTbl;
   property  CSClient: TcsClient read f_CSClient write f_CSClient;
 end;

 TDocumentSabList = class(Tl3Base, Il3ChangeNotifier)
  private
   f_ChangeNotifier : Tl3ChangeNotifier;
   procedure CheckFamilyNum; // выбрасывает исключение
  protected
   fFamily        : TFamilyID;
   fFileTbl       : TFileTbl;
   fCurSab        : ISab;
   fSabCursor     : ISabCursor;
   fActiveList    : Tl3LongintList;
   fCheckActive   : Boolean;
   fOrderIndex    : Tl3LongintList;

   procedure SetFamily(aValue : TFamilyID);
   procedure SetCurSab(aValue : ISab);
   function  GetSabCursor : ISabCursor;
   function  GetChkActive : Boolean;
   procedure SetChkActive(aValue : Boolean);

   function  GetWithOrder : Boolean;
   procedure AddToOrderIndex(aValue : Integer);
   procedure DelFromOrderIndex(aIndex : Integer);
   procedure ClearOrderIndex;
   function  ConvertIndex(aValue : Integer) : Integer;

   procedure GetActiveStatusList;
   function  GetDocs: ISab;

   procedure Cleanup; override;
   property  ChangeNotifier: Tl3ChangeNotifier read f_ChangeNotifier implements Il3ChangeNotifier;
   property    SabCursor : ISabCursor read GetSabCursor;
  public
   constructor Create;
   constructor CreateEmpty(aFamily : TFamilyID);

   procedure   SetEmptySab;

   procedure   SortList(aSortFields : array of ThtField);
   procedure   ClearCurSab;

   function    GetDoc(aItem : LongInt) : TDocReadRec;
   procedure   DelDoc(aItem : LongInt);
   function    AddDoc(aID : LongInt) : LongInt;

   procedure   SaveList(DataName : TFileName;Comment : PAnsiChar);
   procedure   LoadList(DataName : TFileName;var Comment : PAnsiChar);

   function    Count: Integer;

   property    Family : TFamilyID read fFamily write SetFamily;
   property    CheckActiveStatus : Boolean read  GetChkActive
                                           write SetChkActive; // По умолчанию - False
   property    CurSab    : ISab read fCurSab write SetCurSab;
   property    WithOrder : Boolean read GetWithOrder {write SetWithOrder};
   property    Docs      : ISab read GetDocs;

 end;

Const
 cDocumentServer : TDocumentServer = nil;

function DocumentServer(aFamily : TFamilyID = High(TFamilyID)) : TDocumentServer; // -1 временно, что бы компиляция не отвалилвсь
function IsValidDocID(aDocID : TDocID) : boolean;

function GetDocName(aDocID : TDocID; aIsExternalID : boolean = false) : String; overload;
function GetDocName(aDocID : TDocID; aIsExternalID : boolean; var aHasVerlink : boolean) : String; overload;
function GetMinPublDate(aDocID : TDocID; aIsExternalID : boolean = false; aNum : PANSIString = nil) : TstDate;
function GetFreeDocID(aFamily : TFamilyID) : TDocID;
Implementation

uses
     WinProcs, Contnrs, Windows, Forms,
     daDataProvider,
     daTypes,
     daInterfaces,
     daSchemeConsts,
     HT_Dll,
     Dt_Err, Dt_Misc,  Dt_Serv, Dt_Link, Dt_LinkServ, Dt_DictConst, Dt_Prior,
     Dt_Hyper,
     StDateSt, VConst,
     l3Parser, l3Tree, l3Tree_TLB, l3Nodes, l3String,
     l3MinMax, l3Memory,
     m3DBInterfaces, m3DB,
     ddServerTask,
     csUserRequestManager,
     csQueryTypes,
     l3FieldSortRecList,
     l3Stream, dt_Dict, csServerTaskTypes;

{ TFileTbl }

Constructor TFileTbl.Create(aFamily : TFamilyID);
Begin
  Assert(aFamily <> MainTblsFamily);
  Inherited Create(aFamily, Ord(ftFile));
end;

function TFileTbl.AddDoc : LongInt;
Begin
 GetFromFullRec(fId_Fld,Result);
 if Result = 0 then
 begin
  Result := GetFreeNum;
  PutToFullRec(fId_Fld,Result);
 end;
 AddFRec;
end;

procedure TFileTbl.PutFieldToRecord(aRecord : PAnsiChar; aField : ThtField; const aBody);
var
 lStr    : PAnsiChar;
begin
 if ElementType[aField] = ET_CHAR then
 begin
  lStr := PAnsiChar(String(aBody));
  inherited PutFieldToRecord(aRecord, aField, lStr);
 end
 else
  inherited PutFieldToRecord(aRecord, aField, aBody);
end;

procedure TFileTbl.GetFieldFromRecord(aRecord : PAnsiChar; aField : ThtField; var aBody);
var
 lStr    : PAnsiChar;
begin
 if ElementType[aField] = ET_CHAR then
 try
  inherited GetFieldFromRecord(aRecord, aField, lStr);
  String(aBody) := l3GetStrPas(lStr);
 finally
  l3StrDispose(lStr);
 end
 else
  inherited GetFieldFromRecord(aRecord, aField, aBody);
end;

Procedure TFileTbl.DelDoc(ID : LongInt);
Var
 RecH    : RHANDLE;
 AbsNum  : LongInt;
Begin
 AbsNum:=Ht(htRecordByUniq(nil,Handle,fId_Fld,@ID,@RecH));
 if AbsNum <> 0 then
  DelRec(AbsNum);
end;

procedure TFileTbl.DelDocs(IDs : ISab);
begin
 DeleteRecsByKeys(IDs,fID_Fld);
end;

function TFileTbl.CheckDoc(ID : TDocID; aDocRec : PdtRecord = nil) : Boolean;
begin
 if aDocRec <> nil then
 begin
  aDocRec^ := InitRecord(Self);
  Result := aDocRec^.FindByUniq(fId_Fld, ID);
 end
 else
  Result := InitRecord(Self).FindByUniq(fId_Fld, ID);
end;

function TFileTbl.GetDocRecord(var aID : TDocID; var aDocRec : TdtRecord) : Boolean;
// aID может быть справкой, тогда возвращаем ID дока
begin
 aDocRec := InitRecord(Self);
 Result := aDocRec.FindByUniq(fId_Fld, aID);
 if Result then Exit;

 aID := GetDocIdOnRelated(aID);
 if aID > 0 then
  Result := aDocRec.FindByUniq(fId_Fld, aID);
end;

function TDocumentServer.CheckDocEx(aDocID : TDocID): Boolean;
var
 l_TmpNum : LongInt;
 l_Name   : AnsiString;
 lDocRec : TdtRecord;
begin
 Result := False;
 CheckFamilyNum;
 if fFileTbl.CheckDoc(aDocID, @lDocRec) then
 begin
  // в таблице FILE есть запись, но это ничего не значит, т.к. запись могла быть создана в результате
  // импорта аннотации, например. Поэтому надо ещё проверить второстепенные признаки.
  // Непустое имя или записи в логах, чтобы понять, что документ был создан в результате заливки или в Архивариусе

  Result := (lDocRec.GetStrField(fFName_Fld) <> '') or
             LinkServer(CurrentFamily).LogBook.IsDocHadActions(aDocID, [acNew, acWasImported, acAttrWork,
                                                                        acTextWork, acHLWork, acKWWork, acClassWork]);

  //Result := l_HasTitle or l_HasLog;
 end;
end;


Function TFileTbl.CheckRel(aRelID : TDocID) : LongInt;
Var
 TmpSab   : Sab;
Begin
 htSearch(nil,TmpSab,Handle,fRelated_fld,EQUAL,@aRelID,nil);
 Try
  Result:=TmpSab.gFoundCnt
 finally
  htClearResults(TmpSab);
 end;
end;

function TFileTbl.GetVerLink(aDocID : TDocID) : TDocID;
var
 lDocRec  : TdtRecord;
begin
 Result:=0;
 lDocRec := InitRecord(self);
 if lDocRec.FindByUniq(fId_Fld, aDocID) then
  lDocRec.GetField(fVerLink_fld, Result);
end;

function TFileTbl.HasVerLink(aLinkID : TDocID) : boolean;
begin
 Result := InitRecord(self).FindByUniq(fVerLink_fld, aLinkID);
end;

function TFileTbl.CheckVerLink(aLinkID : TDocID) : TDocID;
var
 lDocRec  : TdtRecord;
begin
 Result := 0;
 lDocRec := InitRecord(self);
 if lDocRec.FindByUniq(fVerLink_fld, aLinkID) then
  lDocRec.GetField(fId_Fld, Result);
end;

procedure TFileTbl.SetVerLink(ID,VL_ID : LongInt);
var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
begin
 AbsNum:=Ht(htRecordByUniq(nil,Handle,fId_Fld,@ID,@RecH));
 if AbsNum = 0 then
  raise EHtErrors.CreateInt(ecNotFound);
 ClearFullRec;
 GetFullRec(AbsNum,False);
 if StartTA then
 try
  PutToFullRec(fVerLink_fld,VL_ID);
  UpdFRec(AbsNum);
  SuccessTA;
 except
  RollBackTA;
  raise EHtErrors.CreateInt(ecUnableUpd);
 end;
end;

function TFileTbl.GetDocIdOnRelated(aRelID : TDocID) : TDocID;
Var
 TmpSab1   : Sab;
 openField : SmallInt;
begin
 Result := 0;
 htSearch(nil, TmpSab1, Handle, fRelated_fld, EQUAL, @aRelID, nil);
 try
  if TmpSab1.gFoundCnt <> 0 then
  begin
   openField := fID_fld;
   Ht(htOpenResults(TmpSab1,ROPEN_READ,@openField,1));
   try
    htReadResults(TmpSab1,@Result,SizeOf(TDocID));
   finally
    htCloseResults(TmpSab1);
   end;
  end;
 finally
  htClearResults(TmpSab1);
 end;
end;

function TFileTbl.GetRelated(aDocID : TDocID; Var LastRel : Boolean) : TDocID;
Var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
 TmpSab  : Sab;
Begin
 Result:=0;
 LastRel:=False;
 AbsNum:=Ht(htRecordByUniq(nil,Handle,fId_Fld,@aDocID,@RecH));
 if AbsNum=0 then exit;

 ClearFullRec;
 GetFullRec(AbsNum,False);
 GetFromFullRec(fRelated_fld,Result);
 htSearch(nil,TmpSab,Handle,fRelated_fld,EQUAL,@Result,nil);
 Try
  LastRel:=(TmpSab.gFoundCnt=1);
 finally
  htClearResults(TmpSab);
 end;
end;

procedure TFileTbl.SetHasAnno(var aDocIds: Sab; aValue: Boolean);
var
 l_Value: Byte;
 l_Recs: Sab;
 lPhoto : Sab;
begin
 l_Value := c_BoolToByte[aValue];
 lPhoto := PhotoOfTable;
 htTransferToPhoto(aDocIds, lPhoto, fId_Fld);
 htRecordsByKey(l_Recs, aDocIds);
 Ht(l_Recs.nRetCode);
 try
  ModifyRecs(l_Recs, fHasAnno_fld, @l_Value);
 finally
  htClearResults(l_Recs);
 end;
 htClearResults(lPhoto);
end;

procedure TFileTbl.GetAnnoSABonDocSAB(aDocIds: Sab; out AnnoSAB: SAB; aHasAnno : Boolean = True);
var
 l_AnnoDocs,
 l_CurDocs : SAB;
 l_HasAnno : Byte;
 l_NeedConvInSub : Boolean;
begin
 l_NeedConvInSub := htResultsType(aDocIds) = RES_VALUE;
 if l_NeedConvInSub then
  htRecordsByKey(l_CurDocs, aDocIds)
 else
  l_CurDocs := aDocIds;
 try
  l_HasAnno := c_BoolToByte[aHasAnno];
  htSubSearch(l_CurDocs, l_AnnoDocs, Handle, fHasAnno_fld, EQUAL, @l_HasAnno, nil);
  try
   htValuesOfKey(AnnoSab, fId_Fld, l_AnnoDocs);
  finally
   htClearResults(l_AnnoDocs);
  end;
 finally
  if l_NeedConvInSub then
   htClearResults(l_CurDocs);
 end;
end;

function TFileTbl.GetHasAnno(aDocID: TDocID): Boolean;
var
 l_RecNum: LongInt;
 l_FieldValue: Byte;
begin
 l_RecNum := Ht(htRecordByUniq(nil, Handle, fId_Fld, @aDocID, nil));
 if l_RecNum = 0 then
  Result := False
 else
 begin
  ClearFullRec;
  GetFullRec(l_RecNum, False);
  GetFromFullRec(fHasAnno_fld, l_FieldValue);
  Result := Boolean(l_FieldValue);
 end;
end;

procedure TFileTbl.SprIDs2DocIDs(const aDocIDs : ISab);
var
 aSab : ISab;
begin
 if not Assigned(aDocIDs) or (aDocIDs.Count = 0) then
  Exit;
 aSab := MakeSabCopy(aDocIDs);
 aSab.RecordsByKey(fRelated_fld, MakePhoto(Self));

 aDocIDs.RecordsByKey(fId_Fld, aSab);
 aDocIDs.OrSab(aSab);

 aDocIDs.ValuesOfKey(fId_Fld);
end;

{ TDocumentServer }

procedure TDocumentServer.Update;
begin
 if Assigned(fFileTbl) then
  fFileTbl.UpdateTbl;
end;

procedure TDocumentServer.SendMessageAboutDeletedDocs(aDocIdsArray: array of Longint);
var
 l_Q: TDeleteDocsQuery;
 l_A: TDocArray;
 Index: Integer;
begin
 { Нужно обновить свои выборки }
 for Index:= 0 to Length(aDocIDsArray)-1 do
  Windows.SendMessage(Application.MainForm.Handle, wm_DelDoc, 0, aDocIDsArray[Index]);
 Windows.SendMessage(Application.MainForm.Handle, wm_RefreshDocs, 0, 0);
 { Послать сообщение остальным }
 if (CSClient <> nil) then
 begin
  l_Q:= TDeleteDocsQuery.Create(CSClient.ClientID);
  try
   SetLength(l_A, Length(aDocIDsArray));
   l3Move(aDocIDsArray[0], l_A[0], Length(aDocIDsArray)*SizeOf(Longint));
   l_Q.Docs:= l_A;
   UserRequestManager.SendTask(l_Q);
  finally
   l3Free(l_Q);
  end;
 end;
end;

procedure TDocumentServer.SetFamily(aValue : TFamilyID);
begin
 if fFamily = aValue then Exit;
 fFamily := aValue;
 fFileTbl := TFileTbl(GlobalHtServer.GetTblObject(fFamily, Ord(ftFile)));
 if fFileTbl = nil then
  fFileTbl := TFileTbl.Create(fFamily)
 else
  fFileTbl.Use;

 //fReNumTbl := GlobalHtServer.ReNumTbl[fFamily];
 //fReNumTbl.UpdateInterval := 0;
end;

procedure TDocumentServer.Cleanup;
begin
 l3Free(fFileTbl);
 Inherited;
end;

function TDocumentServer.CheckDoc(aDocID : TDocID; WithRel : Boolean; var RelFlag : Boolean) : Boolean;
begin
 Result:=False;
 RelFlag:=False;
 CheckFamilyNum;
 if fFileTbl.CheckDoc(aDocID) then
  Result := True
 else
  if WithRel and (fFileTbl.CheckRel(aDocID) > 0) then
   begin
    RelFlag:=True;
    Result:=True;
   end;
end;

function TDocumentServer.GetDocOnValues(Values : SAB;WithSort : Boolean;
                                        Photo  : LPSab) : SAB;
var
 TmpSab  : Sab;
 Tmp_fld : SmallInt;
 lPhoto : Sab;
begin
 if Photo<>nil then
   htTransferToPhoto(Values,Photo^,fID_Fld)
 else
  begin
   lPhoto := fFileTbl.PhotoOfTable;
   htTransferToPhoto(Values,lPhoto,fID_Fld);
  end;
 if WithSort then
  begin
   htRecordsByKey(TmpSab,Values);
   try
    Tmp_Fld:=fID_fld;
    htSortResults(Result,TmpSab,@Tmp_Fld,1);
   finally
    htClearResults(TmpSab);
   end;
  end
 else
  htRecordsByKey(Result,Values);
end;

function TDocumentServer.GetRelImportNum(DocImpNum : TDocID) : TDocID;
var
 lRelDocID : TDocID;
 lDocID : TDocID;
begin
 //Result:=fRenumTbl.GetRelImportNum(DocImpNum);

 Result := DocImpNum + cNormalRelIndent;
 // не нашли в Renum, значит новый
 if not LinkServer(fFamily)[atRenum].Table.FindByUniqKey(rnImportID_fld, Result, rnRealID_fld, lRelDocID) then Exit;

 // в Renum есть, поищем есть ли у кого-нибудь такая справка
 lDocID := FileTbl.GetDocIdOnRelated(lRelDocID);

 if (lDocID > 0) // номер занят и надо полагать не нашим топиком (может проверить это?)
    or FileTbl.HasRecord(fID_fld, lRelDocID) then // это номер документа
  Result := 0;
end;

procedure TDocumentServer.ChangeHLAddr(aOldDestDoc : TDocID; aOldDestSub : TSubID;
                                       aNewDestDoc : TDocID; aNewDestSub : TSubID);
var
 lModifiedDocs : ISab;
begin
 LinkServer(fFamily).HLinkTbl.ChangeDestAddr(aOldDestDoc, aOldDestSub, aNewDestDoc, aNewDestSub, lModifiedDocs);
 LinkServer(fFamily).LogBook.PutLogRecToDocs(lModifiedDocs, acHLWork);
end;

function TDocumentServer.ChangeDestDoc(anOldDestDoc, aNewDestDoc: TDocID;
                                        aNewDestSub: TSubID;
                                        const aSubList: Tl3LongintList = nil;
                                        const aDocList: ISab = nil) : cardinal;
var
 lValList  : ISAB;
begin
 if aDocList = nil then
  lValList := MakeSab(LinkServer(fFamily).HLinkTbl, LinkServer(fFamily).HLinkTbl.GetParentList(anOldDestDoc, aSubList))
 else
 begin
  lValList := MakeSabCopy(aDocList);
  if lValList.TypeOfSab <> RES_VALUE then
   lValList.ValuesOfKey(docIdFld);
 end;

 if (lValList <> nil) and (lValList.Count > 0) then
 begin
  Result := LinkServer(fFamily).HLinkTbl.ChangeDestAddr(anOldDestDoc, aNewDestDoc, aNewDestSub, lValList, aSubList);
  LinkServer(fFamily).LogBook.PutLogRecToDocs(lValList, acHLWork);
 end
 else
  Result := 0;
end;

function TDocumentServer.ChangeDestDoc(const aRelaceArr : array of TReplaceDocPair;
                                        const aDocList: ISab)  : cardinal;
begin
 Result := LinkServer(fFamily).HLinkTbl.ChangeDestAddr(aRelaceArr, aDocList);
 LinkServer(fFamily).LogBook.PutLogRecToDocs(aDocList, acHLWork);
end;

procedure TDocumentServer.DelDoc(aDelDocID: TDocID);
begin
 DelDocEx(aDelDocID, True, True);
end;

procedure TDocumentServer.DelDocs(aDocIDs: ISab);
begin
 DelDocsEx(aDocIDs, True, True);
end;

procedure TDocumentServer.DelRel(RelID : TDocID);
const
 MaxDelTime = 120; // 2 минут
var
 l_TransId  : Ht_Const.TrId;
 lDB : Im3DB;
begin
 if fFileTbl.CheckRel(RelID) > 1 then exit;

 CheckFamilyNum;

 if GlobalHTServer.StartTransaction([LinkServer(fFamily)[atHLink].Table,
                                     LinkServer(fFamily)[atSub].Table,
                                     LinkServer(fFamily)[atRenum].Table,
                                     GlobalHtServer.FreeTbl[fFamily]],
                                    l_TransID,
                                    MaxDelTime) then
  try
   LinkServer(fFamily)[atSub].DelAllLinkItems(RelID);
   LinkServer(fFamily)[atHLink].DelAllLinkItems(RelID);

   fFileTbl.PutFreeNum(RelID);

   lDB := Tm3DB.Make(GlobalDataProvider.TextBase[fFamily]);
   try
    lDB.GetDocument(RelID).Delete;
   finally
    lDB := nil;
   end;

   GlobalHTServer.CommitTransaction(l_TransID);
  except
   GlobalHTServer.RollBackTransaction(l_TransID);
   raise;
  end;
end;

function TDocumentServer.MakeAttrTableArray : Il3CBaseList;
var
 I : TdtAttribute;
 lList : Tl3BaseRefInterfacedList;
begin
 lList := Tl3BaseRefInterfacedList.Create;
 try
  lList.Add(fFileTbl);
  lList.Add(GlobalHtServer.FreeTbl[fFamily]);
  for I := Low(TdtAttribute) to High(TdtAttribute) do
  with cAttrPassport[I] do
  begin
   if (rLink <> ftNone) and (rLink <> ftFile) then
    lList.Add(LinkServer(fFamily)[I].Table);
   if (rDict <> da_dlNone) and (cDLPassports[rDict].rClass = atcSingle) then
    lList.Add(DictServer(Family).GroupTbl[rDict]);
  end;
  Result := lList;
 finally
  lList.Free;
 end;//try..finally
end;

procedure TDocumentServer.DelDocEx(aDelDocID: TDocID; aDeleteAnnos, aDeleteText: Boolean; aPreventNumFree : Boolean = false);
const
 MaxDelTime = 300; // 5 минут
var
 NumsID    : Sab;
 RelID     : TDocID;
 lIsDelRel : Boolean;

 l_TransId  : Ht_Const.TrId;

 l_DocIdsArray: array of Longint;
 l_PreventNumFree: Boolean;
 lAttr : TdtAttribute;

 procedure DeleteText;
 var
  lDB : Im3DB;
 begin
  lDB := Tm3DB.Make(GlobalDataProvider.TextBase[fFamily]);
  try
   lDB.GetDocument(aDelDocID).Delete;
   if RelID <> 0 then
    lDB.GetDocument(RelID).Delete;
  finally
   lDB := nil;
  end;
 end;

begin
 CheckFamilyNum;

 RelID:=fFileTbl.GetRelated(aDelDocID,lIsDelRel);
 lIsDelRel := lIsDelRel and (RelID > 0);

 if GlobalHTServer.StartTransaction(MakeAttrTableArray,
                                    l_TransId,
                                    MaxDelTime) then
 begin
  try
   l_PreventNumFree := aPreventNumFree or fFileTbl.HasVerLink(aDelDocID) or LinkServer(fFamily).HLinkTbl.HasLinksWithDest(aDelDocID);

   fFileTbl.DelDoc(aDelDocID);
   if not l_PreventNumFree then
    fFileTbl.PutFreeNum(aDelDocID);

   for lAttr := Low(TdtAttribute) to High(TdtAttribute) do
    with cAttrPassport[lAttr] do
    begin
     if cAttrPassport[lAttr].rLink = ftNone then Continue;
     if cAttrPassport[lAttr].rLink = ftFile then Continue;
     if (lAttr = atAnnoClasses) and not aDeleteAnnos then Continue;
     if (lAttr = atRenum) then
     begin
      if not l_PreventNumFree then
      begin
       LinkServer(fFamily)[atRenum].DelAllLinkItems(aDelDocID);
       if lIsDelRel then
        LinkServer(fFamily)[atRenum].DelAllLinkItems(RelID);
      end
     end
     else
      LinkServer(fFamily)[lAttr].DelAllLinkItems(aDelDocID);
    end;

   if lIsDelRel then
   begin
    LinkServer(fFamily)[atSub].DelAllLinkItems(RelID);
    LinkServer(fFamily)[atHLink].DelAllLinkItems(RelID);
   end;

   GlobalHTServer.CommitTransaction(l_TransId);
  except
   GlobalHTServer.RollBackTransaction(l_TransId);
   raise;
  end;

  GlobalDataProvider.Journal.LogDeleteDoc(fFamily, aDelDocID);

  if not lIsDelRel then
   RelID := 0
  else
   if not l_PreventNumFree then
    fFileTbl.PutFreeNum(RelID);

  if aDeleteText then
   DeleteText;

   SetLength(l_DocIdsArray, 1);
   try
    l_DocIdsArray[0] := aDelDocID;
    SendMessageAboutDeletedDocs(l_DocIdsArray);
   finally
    l_DocIdsArray := nil;
   end;
 end;
end;

procedure TDocumentServer.DelDocsEx(aDocIDs: ISab; aDeleteAnnos, aDeleteTexts: Boolean);

var
 lArrIdx : Integer;
 lInDoc  : boolean; // обрабатываем доки или справки
 l_DocIdsArray: array of Integer;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  if lInDoc then
   GlobalDataProvider.Journal.LogDeleteDoc(fFamily, PInteger(aItemPtr)^);
  l_DocIdsArray[lArrIdx] := PInteger(aItemPtr)^;
  Inc(lArrIdx);
 end;

const
 MaxDelTime = 300; (* 5 минут *)
var
 l_DictIds: Sab;
 I: Integer;

 l_RelatedIds: ISab;
 l_NotReferencedDocIds: ISab;
 l_RelatedToNotReferencedDocIds: ISab;

 l_TransId  : Ht_Const.TrId;

 lRAProcStub : TdtRecAccessProc;
 lAttr : TdtAttribute;

begin
 if (aDocIDs.Count = 0) then
  Exit;
 CheckFamilyNum;

 fFileTbl.GetRelated(aDocIDs, l_RelatedIds, True);

 // Вычисление документов, на которые НЕТ ссылок.
 // В эту же категорию подпадают и те документы, у которых имеются ссылки только на самих себя.
 LinkServer(fFamily).HLinkTbl.ExtractNotReferencedDocIds(aDocIDs, l_NotReferencedDocIds);
 fFileTbl.GetRelated(l_NotReferencedDocIds, l_RelatedToNotReferencedDocIds, True);

 if GlobalHTServer.StartTransaction(MakeAttrTableArray,
                                    l_TransId,
                                    MaxDelTime) then
 begin
  try
   fFileTbl.DelDocs(aDocIDs);
   fFileTbl.PutFreeNums(l_NotReferencedDocIds.HTSab);

   for lAttr := Low(TdtAttribute) to High(TdtAttribute) do
    with cAttrPassport[lAttr] do
    begin
     if cAttrPassport[lAttr].rLink = ftNone then Continue;
     if cAttrPassport[lAttr].rLink = ftFile then Continue;
     if (lAttr = atAnnoClasses) and not aDeleteAnnos then Continue;
     if (lAttr = atRenum) then
     begin
      LinkServer(fFamily)[atRenum].DelAllLinkItems(l_NotReferencedDocIds);
      LinkServer(fFamily)[atRenum].DelAllLinkItems(l_RelatedToNotReferencedDocIds);
     end
     else
      LinkServer(fFamily)[lAttr].DelAllLinkItems(aDocIDs);
    end;

   if l_RelatedIds.Count > 0 then
   begin
    LinkServer(fFamily)[atSub].DelAllLinkItems(l_RelatedIds);
    LinkServer(fFamily)[atHLink].DelAllLinkItems(l_RelatedIds);
   end;

   if l_RelatedToNotReferencedDocIds.Count > 0 then
    fFileTbl.PutFreeNums(l_RelatedToNotReferencedDocIds.HTSab);
   
   GlobalHTServer.CommitTransaction(l_TransId);
  except
   GlobalHTServer.RollBackTransaction(l_TransId);
   raise;
  end;

  SetLength(l_DocIdsArray, aDocIDs.Count + l_RelatedIds.Count);
  lArrIdx := 0;
  try
   GlobalDataProvider.Journal.StartCaching;
   try
    lRAProcStub := L2RecAccessProc(@lRecAccessProc);
    try
     // Документы
     lInDoc := True;
     aDocIDs.IterateRecords(lRAProcStub);

     // Справки
     lInDoc:= false;
     l_RelatedIds.IterateRecords(lRAProcStub);
    finally
     FreeRecAccessProc(lRAProcStub);
    end;

   finally
    GlobalDataProvider.Journal.StopCaching;
   end;

   if aDeleteTexts then
    with dtGetDB(fFamily) do
     for I := 0 to Length(l_DocIdsArray) - 1 do
      GetDocument(l_DocIdsArray[I]).Delete;

    SendMessageAboutDeletedDocs(l_DocIdsArray);
  finally
   l_DocIdsArray := nil;
  end;
 end;
end;

{ TDocumentSabList }

constructor TDocumentSabList.Create;
begin
 inherited Create;

 fCheckActive := False;

 f_ChangeNotifier := Tl3ChangeNotifier.Create;
end;

constructor TDocumentSabList.CreateEmpty(aFamily : TFamilyID);
begin
 inherited Create;
 f_ChangeNotifier := Tl3ChangeNotifier.Create;

 fCheckActive:=False;
 Family:=aFamily;
 SetEmptySab;
end;

procedure TDocumentSabList.Cleanup;
begin
 ClearCurSab;

 l3Free(fActiveList);
 fCheckActive := False;

 l3Free(fOrderIndex);
 l3Free(f_ChangeNotifier);
 inherited;
end;

procedure TDocumentSabList.SetFamily(aValue : TFamilyID);
begin
 if fFamily<>aValue then
 begin
  ClearCurSab;
  fFamily:=aValue;
  if fFamily <> 0 then
   fFileTbl := TFileTbl(GlobalHtServer.GetTblObjectEx(fFamily, Ord(ftFile)));
 end;
end;

function TDocumentSabList.GetSabCursor : ISabCursor;
begin
 if fSabCursor = nil then
  fSabCursor := fCurSab.MakeSabCursor(MakeFieldArray([fId_Fld, fType_Fld, fUserType_Fld, fFName_Fld, fUrgency_fld]),
                                      cmBalanced,
                                      ROPEN_READ);
 Result := fSabCursor;
end;

procedure TDocumentSabList.SetCurSab(aValue : ISab);
begin
 CheckFamilyNum;

 ClearCurSab;

 if not aValue.IsEmpty then
 begin
  fCurSab := MakeSabCopy(aValue);
  GetActiveStatusList;
 end;
end;

function TDocumentSabList.GetChkActive : Boolean;
begin
 Result:=fCheckActive;
end;

procedure TDocumentSabList.SetChkActive(aValue : Boolean);
begin
 if aValue <> fCheckActive then
 begin
  fCheckActive := aValue;
  if aValue then
   GetActiveStatusList
  else
   L3Free(fActiveList);
 end;
end;

function  TDocumentSabList.GetWithOrder : Boolean;
begin
 Result := fOrderIndex <> nil;
end;

procedure TDocumentSabList.AddToOrderIndex(aValue : Integer);
var
 I : Integer;
begin
 if not WithOrder then Exit;

 for I := 0 to Pred(fOrderIndex.Count) do
  if fOrderIndex[I] >= aValue then
   fOrderIndex[I] := fOrderIndex[I] + 1;
 fOrderIndex.Add(aValue);
end;

procedure TDocumentSabList.DelFromOrderIndex(aIndex : Integer);
var
 I : Integer;
 lValue : Integer;
begin
 if not WithOrder then Exit;

 lValue := fOrderIndex[I];

 for I := 0 to Pred(fOrderIndex.Count) do
  if fOrderIndex[I] > lValue then
   fOrderIndex[I] := fOrderIndex[I] - 1;
 fOrderIndex.Delete(aIndex);
end;

procedure TDocumentSabList.ClearOrderIndex;
begin
 if not WithOrder then Exit;
 fOrderIndex.Clear;
end;

function TDocumentSabList.ConvertIndex(aValue : Integer) : Integer;
begin
 if WithOrder then
  Result := fOrderIndex[aValue]
 else
  Result := aValue;
end;

procedure TDocumentSabList.SetEmptySab;
var
 lSab : Sab;
begin
 CheckFamilyNum;
 ClearCurSab;

 fCurSab := MakeEmptySab(fFileTbl);
end;

procedure TDocumentSabList.ClearCurSab;
begin
 fSabCursor := nil;
 fCurSab := nil;
 l3Free(fActiveList);
 ClearOrderIndex;
end;

procedure TDocumentSabList.GetActiveStatusList;
var
 lDiapason  : ISAB;
begin
 if CheckActiveStatus then
 begin
  if (fCurSab <> nil) and not fCurSab.IsEmpty then
  begin
   lDiapason := MakeSabCopy(fCurSab);
   lDiapason.ValuesOfKey(fId_Fld);
   fActiveList := LinkServer(fFamily).ActiveIntervals.GetActiveDocNumbers(lDiapason);
  end;
 end;
end;

function TDocumentSabList.GetDoc(aItem : LongInt) : TDocReadRec;
var
 lIndex : Longint;
begin
 aItem := ConvertIndex(aItem);
 l3FillChar(Result,sizeOf(TDocReadRec));
 l3Move(PAnsiChar(SabCursor.GetItem(aItem))^,Result,SizeOf(TDocReadTblRec));

 // Получение Active статуса
 if CheckActiveStatus then
  Result.NoActive := (fActiveList = nil) or
                    not fActiveList.FindData(Result.ID, lIndex);
end;

procedure TDocumentSabList.DelDoc(aItem : LongInt);
begin
 SabCursor.DelItem(ConvertIndex(aItem));
 DelFromOrderIndex(aItem);
end;

function TDocumentSabList.AddDoc(aID : LongInt) : LongInt;
var
 AbsNum : LongInt;
begin
 CheckFamilyNum;
 if (fCurSab = nil) or not fCurSab.IsValid then
  raise EHtErrors.CreateInt(ecNotAssigned);

 AbsNum := fFileTbl.GetRecordIDByUniq(fId_Fld, aID, nil, fCurSab.HTSabAddr);
 if AbsNum = 0 then
 begin
  f_ChangeNotifier.Changing;

  fCurSab.Refresh;

  AbsNum := fFileTbl.GetRecordIDByUniq(fId_Fld, aID, nil, fCurSab.HTSabAddr);

  if AbsNum = 0 then raise EHtErrors.CreateInt(ecNotFound);
  f_ChangeNotifier.Changed;
 end;

 Result := SabCursor.AddItem(AbsNum);
 AddToOrderIndex(Result);
end;

procedure TDocumentSabList.SortList(aSortFields : array of ThtField);
begin
 if (fCurSab <> nil) and fCurSab.IsValid then
  fCurSab.Sort(aSortFields);
end;

Const
 cHeaderSize = 10;
 cHeader  : Array[1..cHeaderSize] of Char = 'Saved Data';
 cVersion : Char = #05;

procedure TDocumentSabList.SaveList(DataName : TFileName;Comment : PAnsiChar);
var
 fStrm : Tl3FileStream;
 lDocList : ISab;
 lLen  : Cardinal;
 lDataType : Byte;

begin
 CheckFamilyNum;
 if (fCurSab = nil) or fCurSab.IsEmpty then
  raise EHtErrors.CreateInt(ecNotAssigned);

 fStrm := Tl3FileStream.Create(DataName,l3_fmReadWrite);
 try
  fStrm.WriteBuffer(cVersion, 1);
  fStrm.WriteBuffer(cHeader[1], cHeaderSize);
  fStrm.WriteBuffer(Zero, 4);

  if Comment <> nil then
  begin
   lDataType := Byte(sdtComment);
   fStrm.WriteBuffer(lDataType,SizeOf(lDataType));
   lLen := StrLen(Comment);
   fStrm.WriteBuffer(lLen, SizeOf(lLen));
   fStrm.WriteBuffer(Comment^, lLen);
  end;

  lDocList := MakeSabCopy(fCurSab);
  lDocList.ValuesOfKey(fID_fld);
  lDocList.Sort;

  lDataType := Byte(sdtDocs);
  fStrm.WriteBuffer(lDataType,SizeOf(lDataType));
  lLen := lDocList.Count * 4;
  fStrm.WriteBuffer(lLen, SizeOf(lLen));
  dtOutSabToStream(lDocList, fStrm);
 finally
  l3Free(fStrm);
 end;
end;

procedure TDocumentSabList.LoadList(DataName : TFileName;var Comment : PAnsiChar);
var
 fStrm : Tl3FileStream;
 lDocList : ISab;
 lLen  : Cardinal;
 lDataType : Byte;
 lCheckSum : LongWord;
 lDataVer  : Char;
begin
 Comment := nil;
 CheckFamilyNum;

 fStrm := Tl3FileStream.Create(DataName,l3_fmReadWrite);
 try
  fStrm.ReadBuffer(lDataVer, SizeOf(lDataVer));
  if (lDataVer <> #04) and (lDataVer <> cVersion) then
    raise Exception.Create('Несовпадение версии данных!'#13+'Загрузка не возможна.');

  fStrm.ReadBuffer(cHeader[1], cHeaderSize);
  fStrm.ReadBuffer(lCheckSum, SizeOf(lCheckSum));

  while true do
  begin
   fStrm.ReadBuffer(lDataType, SizeOf(lDataType));

   if lDataVer = #04 then
    fStrm.ReadBuffer(lLen,SizeOf(Word))
   else
    fStrm.ReadBuffer(lLen,SizeOf(lLen));

   case TSaveDocDT(lDataType) of
    sdtDocs :
     begin
      fCurSab := MakeValueSet(fFileTbl, fId_Fld, fStrm);
      fCurSab.RecordsByKey;
      Break;
     end;
    sdtComment :
     begin
      if lLen > 0 then
      begin
       Comment := l3StrAlloc(lLen + 1);
       //l3FillChar(Com  ment^, lLen + 1);
       fStrm.ReadBuffer(Comment^, lLen);
       Comment[lLen] := #0;
      end;
     end;
   end; // case
  end; //while true do 

 finally
   l3Free(fStrm);
 end;
end;

procedure TFileTbl.GetAllVerLinkOrder(aDocID: TDocID; aDocList: TL3LongintList);
var
 l_CurId: TDocId;
begin
 if aDocList = nil then
  Exit;

 // Пусть:    A -> B -> C -> aDocID -> D -> E -> F
 // Поочередная вставка в НАЧАЛО списка  (DocId, C, B, A)
 aDocList.Clear;
 l_CurId := aDocID;
 repeat
  // проверка на дубликаты (опасность зацикливания)
  if aDocList.IndexOf(l_CurId) > -1 then
   raise EHtErrors.CreateInt(ecWrongVerLink);
  aDocList.Insert(0, l_CurId);
  l_CurId := CheckVerLink(l_CurId);
 until l_CurId <= 0;

 // Поочередное добавление в КОНЕЦ cписка (D, E, F)
 l_CurId := GetVerLink(aDocID);
 while l_CurId > 0 do
 begin
  // проверка на дубликаты (опасность зацикливания)
  if aDocList.IndexOf(l_CurId) > -1 then
   raise EHtErrors.CreateInt(ecWrongVerLink);
  aDocList.Add(l_CurId);
  l_CurId := GetVerLink(l_CurId);
 end;
end;

procedure TFileTbl.ExpandAllEdition(aDocSet: ISab);
var
 lSab1 : ISab;
 lSab2 : ISab;
 lCurCount : Integer;
 lSaveCount : Integer;
 lVal : Integer;
begin
 //aDocSet - список записей на FileTbl

 lSab1 := MakeSabCopy(aDocSet);
 lSab2 := MakeSabCopy(aDocSet);

 lSaveCount := aDocSet.Count;

 while True do
 begin
  lSab1.ValuesOfKey(fVerLink_fld);
  lSab1.RecordsByKey(fId_Fld);
  aDocSet.OrSab(lSab1);
  lCurCount := aDocSet.Count;
  if lCurCount = lSaveCount then Break;
  lSaveCount := lCurCount;
 end;

 lSaveCount := aDocSet.Count;

 while True do
 begin
  lSab2.ValuesOfKey(fId_Fld);
  lSab2.RecordsByKey(fVerLink_fld);
  aDocSet.OrSab(lSab2);

  lCurCount := aDocSet.Count;
  if lCurCount = lSaveCount then Break;
  lSaveCount := lCurCount;
 end;
end;

procedure TFileTbl.GetRelated(var aDocIDs: ISab;
                              out aRelatedIds: ISab;
                              aRelatedToTheseDocsOnly: Boolean);
var
 lSab : ISab;
 lSab2 : ISab;
begin
 aRelatedIds := MakeSabCopy(aDocIDs);

 aRelatedIds.TransferToPhoto(fID_Fld, Self);
  // (1) значения DocIds

 if not aRelatedToTheseDocsOnly then
 begin
  aRelatedIds.ValuesOfKey(fRelated_fld);
  Exit; // result = (3)
 end;

 aRelatedIds.RecordsByKey;
  // (2) записи по исходным DocIds. (1) --> (2)

 lSab := MakeSabCopy(aRelatedIds);

 aRelatedIds.ValuesOfKey(fRelated_fld);
  // (3) значения RelatedIds для исходных DocIds (и не только !!!). (2) --> (3)

 lSab2 := MakeSabCopy(aRelatedIds);
 lSab2.RecordsByKey;
  // (4) записи по RelatedIds. (3) --> (4)

 lSab2.XorSab(lSab);
  // (5) записи с RelatedIds, которые использованы не только в записях по исходным DocIds. (5) = (4) - (2)

 lSab2.ValuesOfKey(fRelated_fld);
 // (6) значения RelatedIds которые использованы не только в записях по исходным DocIds. (5) --> (6)

 aRelatedIds.XorSab(lSab2);
  // (7) все RelatedIds, кроме общих (т.е. использованых не только в записях по исходным DocIds). result = (3) - (6)
end;

function TDocumentSabList.GetDocs: ISab;
var
 l_SabIsOpen: Boolean;
 lSab : Sab;
begin
 Result := Nil;
 if (fCurSab = nil) or fCurSab.IsEmpty then Exit;

 Result := MakeSabCopy(fCurSab);
 Result.ValuesOfKey(fId_Fld);
end;

procedure TDocumentServer.CheckFamilyNum;
begin
 if (fFamily = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);
end;

procedure TDocumentServer.CheckDocPriorityEx(NullOnly : Boolean;aProgress : Tl3ProgressProc = nil);
type
 PRecAcc = ^TRecAcc;
 TRecAcc = record
  rID : DWORD;
  rPrior : WORD;
 end;
var
 lCnt : Integer;
 lValSab : TSab;
 lVSF : IValueSetFiller;
 lRecList   : Tl3FieldSortRecList;
 lStopTime : TDateTime;

 function lCheckPriority(gRecNo : LongInt;fpRecord : Pointer) : MFUNC_RET;
 var
  lID    : LongInt;
  lPrior : Word;
  lRec : TdtRecordAccess;
  lInd : Integer;

 begin
  lRec := InitRecordAccess(lValSab.Table, fpRecord);
  lRec.GetField(fId_Fld, lID);
  if lRecList.FindRecord(lID, lInd) then
  begin
   lPrior := PRecAcc(lRecList.ItemSlot(lInd))^.rPrior;
   lRec.FillField(fPriority_fld, [lPrior]);
   l3System.Msg2Log(Format('load #%d %d',[lID, lPrior]));
  end
  else
   l3System.Msg2Log(Format('load fault #%d',[lID]));

  Inc(fCurProgress);
  if Assigned(fProgressProc) and (fCurProgress mod fCurProgressDelta = 0) then
   fProgressProc(piCurrent,fCurProgress,'');
  Result := MFUNC_SUCCESS;
 end;


 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  lRec : TRecAcc;
 begin
  {if lCnt > 10 then
  begin
   Result := false;                   now
   Exit;
  end; }

  //Result := True;
  Result := lCnt > 10;
  //Result := Time < lStopTime;
  lRec := PRecAcc(aItemPtr)^;
  with lRec do
  begin
   rPrior := LinkServer(fFamily).GetPriority(rID);
   Inc(fCurProgress);
   if Assigned(fProgressProc) and (fCurProgress mod fCurProgressDelta = 0) then
    fProgressProc(piCurrent,fCurProgress,'');

   if rPrior = 999 then Exit;

   inc(lCnt);

   lVSF.AddValue(rID);
   lRecList.Add(lRec);
   l3System.Msg2Log(Format('#%d %d',[rID, rPrior]));

  end;
 end;

 //загрузка из файла
 procedure LoadFromFile(aFileName : TFileName);
 var
  lRec : TRecAcc;
  l_Stream    : Tl3FileStream;
  l_Parser    : Tl3Parser;

 begin
  l_Stream := Tl3FileStream.Create(aFileName, l3_fmRead);
  try
   l_Parser := Tl3Parser.Create;
   try
    l_Parser.NullAsEOF := True;
    l_Parser.CheckFloat := False;
    l_Parser.CheckFiler.Stream := l_Stream;
    l_Parser.NextTokenSp;
    l_Parser.Filer.SoftEnterAsEOL := True;

    while l_Parser.TokenType <> l3_ttEOF do
    begin
     if l_Parser.TokenType = l3_ttInteger then
     begin
      try
       lRec.rID := l_Parser.TokenInt;
       l_Parser.NextTokenSp;
       lRec.rPrior := l_Parser.TokenInt;

       lVSF.AddValue(lRec.rID);
       lRecList.Add(lRec);
      except
      end;
     end;
     l_Parser.Filer.ReadLn;
     l_Parser.NextTokenSp;
    end;
   finally
    l3Free(l_Parser);
   end;
  finally
   l3Free(l_Stream);
  end;
 end;

const
 MaxCDPTime = 3600; // 1 час
 cZero : integer = 999;
 cDocType : word = 1;
var
 TmpFullRec : PAnsiChar;
 lSab       : ISab;
 lSabAttr   : ISab;

 lTransID   : HT_Const.TRID;
 lHTStub    : Pointer;
 lRAProcStub : TdtRecAccessProc;

begin
 lCnt := 0;
 if Assigned(aProgress) then
  fProgressProc:=aProgress;
 //TmpFullRec:=FileTbl.fFullRecord;
 lSab := MakeSab(FileTbl);
 (*if NullOnly then
 begin
  lSab.Select(fPriority_fld, cZero);
  lSab.SubSelect(fUserType_Fld, cDocType, LESS_EQUAL); {0 и 1, только доки}
  lSab.SubSelect(fType_Fld, cDocType, LESS_EQUAL); {только текстовые}

  lSabAttr := MakeSab(LinkServer(Family).Links[da_dlSources]);
  lSabAttr.SelectAll;
  lSabAttr.ValuesOfKey(lnkDocIDFld);
  lSabAttr.TransferToPhoto(fId_Fld, lSab);
  lSabAttr.RecordsByKey;
  lSab.AndSab(lSabAttr);

  lSabAttr := MakeSab(LinkServer(Family).Links[da_dlTypes]);
  lSabAttr.SelectAll;
  lSabAttr.ValuesOfKey(lnkDocIDFld);
  lSabAttr.TransferToPhoto(fId_Fld, lSab);
  lSabAttr.RecordsByKey;
  lSab.AndSab(lSabAttr);

  //htSearch(nil,TmpSab,FileTbl.Handle,fPriority_fld,EQUAL,@cZero,nil);
 end
 else*)
  lSab.SelectAll;
  //htSearch(nil,TmpSab,FileTbl.Handle,fPriority_fld,GREAT_EQUAL,@Zero,nil); //типа все выбрали

 try
  lStopTime := EncodeTime(20, 00, 0, 0);
  while Time < lStopTime do
   sleep(60*1000);

  fCurProgress := 0;
  fCurProgressDelta := lSab.Count div 400;
  if fCurProgressDelta = 0 then fCurProgressDelta := 1;
  if Assigned(fProgressProc) then
   fProgressProc(piStart,lSab.Count,'Расчет юридической силы документов');

  (*lHTStub := HTStub3(@lCheckPriority);
  try
   //lSab.ModifyRecs(lHTStub);
   IterateRecords(aRecProc : TdtRecAccessProc; const aFldArr : array of ThtField
  finally
   HTStubFree(lHTStub);
  end;
  *)

  lValSab := TSab.MakeEmptyValue(lSab, fId_Fld);
  try
   lRecList := Tl3FieldSortRecList.Create(SizeOf(TRecAcc), [4]);
   try
    lVSF := lValSab.MakeValueSetFiller(fID_fld);
    try
     (*lRAProcStub := L2RecAccessProc(@lRecAccessProc);
     try
       lSab.IterateRecords(lRAProcStub, [fID_fld, fPriority_fld]);
     finally
      FreeRecAccessProc(lRAProcStub);
     end;
     *)
     LoadFromFile('D:\#WORK#.PAS\#ARCHI32\EXE\1\archi.log');
    finally
     lVSF := nil;
    end;
    lRecList.SortBy([1]);

    if Assigned(aProgress) then fProgressProc(piEnd,0,'');
    fCurProgress := 0;
    fCurProgressDelta := lvalSab.Count div 400;

    if Assigned(fProgressProc) then
     fProgressProc(piStart, lValSab.Count, 'Расставляем юридическую силу документов');

    lValSab.RecordsByKey;

    lHTStub := HTStub3(@lCheckPriority);
    try
     lValSab.ModifyRecs(lHTStub);
    finally
     HTStubFree(lHTStub);
    end;

   finally
    l3Free(lRecList);
   end;
  finally
   l3Free(lValSab);
  end;

 finally
  if Assigned(aProgress) then
   begin
    fProgressProc(piEnd,0,'');
    fProgressProc:=nil;
   end;
 end;
end;

procedure TDocumentServer.CheckDocPriority(NullOnly : Boolean;aProgress : Tl3ProgressProc);

 function lCheckPriority(gRecNo : LongInt;fpRecord : Pointer) : MFUNC_RET;
 var
  TmpID    : LongInt;
  TmpPrior : Word;
 begin
  try
   FileTbl.fFullRecord:=PAnsiChar(fpRecord);
   FileTbl.GetFromFullRec(fId_Fld,TmpID);
   TmpPrior:=LinkServer(fFamily).GetPriority(TmpID);
   FileTbl.PutToFullRec(fPriority_fld,TmpPrior);
   Inc(fCurProgress);
   if Assigned(fProgressProc) and (fCurProgress mod fCurProgressDelta = 0) then
    fProgressProc(piCurrent,fCurProgress,'');
   Result := MFUNC_SUCCESS;
  except
   Result := MFUNC_ABORT;
  end;
 end;

const
 MaxCDPTime = 3600; // 1 час
var
 TmpFullRec : PAnsiChar;
 TmpSab     : Sab;
 lTransID   : HT_Const.TRID;
 lHTStub    : Pointer;
begin
 if Assigned(aProgress) then
  fProgressProc:=aProgress;
 TmpFullRec:=FileTbl.fFullRecord;
 if NullOnly then
  htSearch(nil,TmpSab,FileTbl.Handle,fPriority_fld,EQUAL,@Zero,nil)
 else
  htSearch(nil,TmpSab,FileTbl.Handle,fPriority_fld,GREAT_EQUAL,@Zero,nil); //типа все выбрали
 try
  fCurProgress:=0;
  fCurProgressDelta:=TmpSab.gFoundCnt div 400;
  if fCurProgressDelta = 0 then fCurProgressDelta := 1;
  if Assigned(fProgressProc) then
   fProgressProc(piStart,TmpSab.gFoundCnt,'Расчет юридической силы документов');
  Ht(htHoldResults(TmpSab));
  try
   if GlobalHTServer.StartTransaction([FileTbl], lTransID, MaxCDPTime) then
    try
     lHTStub := HTStub3(@lCheckPriority);
     try
      FileTbl.ModifyRecs(TmpSab, lHTStub, True {aFastMode});
     finally
      HTStubFree(lHTStub);
     end;
     GlobalHTServer.CommitTransaction(lTransID);
    except
     GlobalHTServer.RollBackTransaction(lTransID);
     raise;
    end;
  finally
   htReleaseResults(TmpSab);
   FileTbl.fFullRecord:=TmpFullRec;
  end;
 finally
  if NullOnly then
   htClearResults(TmpSab);
  if Assigned(aProgress) then
   begin
    fProgressProc(piEnd,0,'');
    fProgressProc:=nil;
   end;
 end;
end;

procedure TDocumentSabList.CheckFamilyNum;
begin
 if (fFamily = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);
end;

function TDocumentSabList.Count: Integer;
begin
 if fCurSab = nil then
  Result := 0
 else
  Result := fCurSab.Count;
end;

function DocumentServer(aFamily : TFamilyID = High(TFamilyID)) : TDocumentServer;
begin
 if aFamily <> High(TFamilyID) then
  cDocumentServer.Family := aFamily;
 Result := cDocumentServer;
end;

function IsValidDocID(aDocID : TDocID) : boolean;
begin
 Result := (aDocID <> cUndefDocID) and (aDocID > 0);
end;

function GetDocName(aDocID : TDocID; aIsExternalID : boolean = false) : String;
var
 lDocRec : TdtRecord;
begin
 if aIsExternalID then
  aDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(aDocID);

 if DocumentServer(CurrentFamily).fFileTbl.CheckDoc(aDocID, @lDocRec) then
  Result := lDocRec.GetStrField(fFName_Fld)
 else
  Result := '';
end;

function GetDocName(aDocID : TDocID; aIsExternalID : boolean; var aHasVerlink : boolean) : String;
var
 lVerLink : integer;
 lDocRec : TdtRecord;
begin
 if aIsExternalID then
  aDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(aDocID);

 if DocumentServer(CurrentFamily).fFileTbl.CheckDoc(aDocID, @lDocRec) then
 begin
  Result := lDocRec.GetStrField(fFName_Fld);
  aHasVerlink := lDocRec.GetIntField(fVerLink_fld) <> 0;
 end
 else
 begin
  Result := '';
  aHasVerlink := false;
 end;
end;

function GetMinPublDate(aDocID : TDocID; aIsExternalID : boolean = false; aNum : PANSIString = nil) : TstDate;
type
 TDNRec = packed record
  rDate    : TStDate;
  rNum     : TNumberStr;
 end;
 PDNRec = ^TDNRec;

var
 lSab : ISab;
 lType  : Byte;
 lEmptyDate : TStDate;
 lDNRec : TDNRec;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := false; // только первую запись
  lDNRec := PDNRec(aItemPtr)^;
 end;

 var
  lRAProcStub : TdtRecAccessProc;

begin
 if aIsExternalID then
  aDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(aDocID);

 lSab := MakeSab(LinkServer(CurrentFamily)[atDateNums].Table);
 lSab.Select(lnkDocIDFld, aDocID);
 lSab.ValuesOfKey(lnkDictIDFld);
 lSab.RecordsByKey(dtIDFld, MakePhoto(DictServer(CurrentFamily).DictTbl[da_dlDateNums]));
 lType := Ord(dnPublish);
 lSab.SubSelect(dnTypFld, lType);

 lEmptyDate := 0;
 lSab.SubSelect(dnDateFld, lEmptyDate, GREAT);

 lSab.Sort([dnDateFld]);

 l3ZeroMemory(@lDNRec, SizeOf(lDNRec));
 lRAProcStub := L2RecAccessProc(@lRecAccessProc);
 try
  lSab.IterateRecords(lRAProcStub, [dnDateFld, dnNumFld]);
 finally
  FreeRecAccessProc(lRAProcStub);
 end;

 Result := lDNRec.rDate;
 if aNum <> nil then
  aNum^ := l3ArrayToString(lDNRec.rNum, SizeOf(lDNRec.rNum));
end;

function GetFreeDocID(aFamily : TFamilyID) : TDocID;
begin
 Result := DocumentServer(aFamily).FileTbl.GetFreeNum;
end;
end.

