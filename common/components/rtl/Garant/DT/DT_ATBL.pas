unit Dt_aTbl;

{ $Id: DT_ATBL.pas,v 1.172 2015/05/05 12:42:07 lukyanets Exp $ }

// $Log: DT_ATBL.pas,v $
// Revision 1.172  2015/05/05 12:42:07  lukyanets
// Cleanup
//
// Revision 1.171  2015/05/05 07:35:38  lukyanets
// Cleanup
//
// Revision 1.170  2015/04/29 08:13:30  lukyanets
// Cleanup
//
// Revision 1.169  2015/03/02 18:34:37  voba
// - Замена htReadRecord на htReadRecordByHandle bugfix
//
// Revision 1.168  2015/03/02 16:30:38  voba
// - Замена htReadRecord на htReadRecordByHandle
//
// Revision 1.167  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.166  2013/12/03 09:55:07  voba
// - збавляемся от степановских итераторов
//
// Revision 1.165  2013/10/25 07:49:00  fireton
// - не собиралось
//
// Revision 1.163  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.162  2011/06/29 16:02:31  fireton
// - даём возможность редактировать ID элемента словаря при создании
//
// Revision 1.161  2010/09/28 13:06:08  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.160  2010/09/21 11:06:54  fireton
// - переводим деревья с PAnsiChar на Tl3WString
//
// Revision 1.159  2009/12/18 09:02:18  voba
// - заменил механизм захвата семейства
//
// Revision 1.158  2009/10/26 14:36:13  voba
// - opt. переделал кешатор записей, снес неиспользуемые функции
//
// Revision 1.157  2009/07/14 12:34:59  voba
// - refact.
//
// Revision 1.156  2009/06/23 07:32:58  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.155  2009/05/19 12:12:31  voba
// - сс
//
// Revision 1.154  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.153  2009/03/23 08:32:23  voba
// - move procedure TemporalCloseTbl;ReOpenTbl; DropTblData; UpdateTbl to dt_Table
//
// Revision 1.152  2009/03/10 09:23:47  voba
// - bug fix
//
// Revision 1.151  2009/03/04 12:34:32  voba
// - убрал из dt_Const константы HyTech
//
// Revision 1.150  2009/03/02 07:54:40  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.149  2008/05/07 15:39:47  voba
// - Refact. function .HasRecord переехала на dt_Table
//
// Revision 1.148  2008/05/04 12:25:29  voba
// no message
//
// Revision 1.147  2008/04/29 14:04:47  voba
// no message
//
// Revision 1.146  2008/04/17 06:55:35  voba
// - bug fix function TAbsHtTbl.FindByUniqKey
//
// Revision 1.145  2008/04/16 14:18:09  voba
// - перенес залочку таблиц на TdtTable
//
// Revision 1.144  2008/04/14 11:03:04  voba
// - bug fix: hterror=-44 in function TAbsHtTbl.FindByUniqKey
//
// Revision 1.143  2008/04/04 15:16:32  fireton
// - внешние номера документов из диапазона
//
// Revision 1.142  2008/04/03 07:56:39  voba
// - сс
//
// Revision 1.141  2008/03/28 10:00:27  voba
// - ren HasRecordsWith -> HasRecord
//
// Revision 1.140  2008/02/13 14:11:39  voba
// - cc
//
// Revision 1.139  2008/02/01 17:00:28  lulin
// - используем кошерные потоки.
//
// Revision 1.138  2008/01/14 14:43:22  voba
// - move function GetValueSAB to dt_Sab
//
// Revision 1.137  2007/12/19 13:00:32  fireton
// - перенос части функционала из DT_ATbl в DT_Table
// - Ok теперь локальная переменная (l_Ok)
//
// Revision 1.136  2007/11/21 08:35:40  voba
// - cc
//
// Revision 1.135  2007/11/15 14:21:34  voba
// - use function TdtTable.DeleteRecByUniq
//
// Revision 1.134  2007/10/08 12:17:27  voba
// no message
//
// Revision 1.133  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.132  2007/08/14 19:31:55  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.131  2007/08/14 14:30:07  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.130  2007/07/04 09:11:50  narry
// - рефакторинг процедуры инициализации HyTech
//
// Revision 1.129  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.128  2007/04/17 13:07:40  narry
// - устал добавлять слэш к имени папки
//
// Revision 1.127  2007/04/10 11:00:15  voba
// - cc
//
// Revision 1.126  2007/03/09 07:31:07  voba
// - refact.
//
// Revision 1.125  2007/03/06 14:49:37  fireton
// - в функцию TAbsHtTbl.RecNumOf добавлен параметр aUniqueKey
// - избавление от ненужных ссылок на fSrchList
//
// Revision 1.124  2007/02/22 09:20:26  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.123  2007/02/16 16:09:40  voba
// - _move some func to TdtTable
// - _move some func to Dt_Misc
//
// Revision 1.122  2007/02/12 16:10:59  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.121  2006/12/14 10:13:16  fireton
// - bug fix: TAbsHtTbl.SetBuffering - не освобождался f_CachedUpdates если в ApplyUpdates поднимался exception
//
// Revision 1.120  2006/11/17 15:17:05  voba
// - add утилитные функции работы с Sab
//
// Revision 1.119  2006/11/07 11:23:37  voba
// - add ht64 support
//
// Revision 1.118  2006/10/09 12:14:14  voba
// - add function AllRecords : Sab;
// - add procedure AddRecs
// - add overload function ModifyRecs
// - add function MaxID
//
// Revision 1.117  2006/10/04 08:27:37  voba
// - merge with b_archi_ht64
//
// Revision 1.116.2.1  2006/09/19 07:18:16  voba
// - переход на HTStub
//
// Revision 1.116  2006/09/07 16:11:24  voba
// - обработка ошибок в dtOrResults dtXorResults dtAndResults
//
// Revision 1.115  2006/08/23 07:44:11  voba
// - merge
//
// Revision 1.114.6.5  2006/08/23 07:06:57  voba
// - add some service function
//
// Revision 1.114.6.4  2006/07/14 14:05:34  voba
// no message
//
// Revision 1.114.6.3  2006/06/14 12:01:44  voba
// - add another one TValuesIteratorForJoinedRecs.Create
//
// Revision 1.114.6.2  2006/05/30 11:50:36  voba
// no message
//
// Revision 1.114.6.1  2006/05/04 12:57:29  voba
// - add type TFieldArray
// - add type TBufferedAddRecords - callback процедура для htAddRecords
//
// Revision 1.114  2006/03/06 08:41:07  voba
// no message
//
// Revision 1.113  2006/02/10 11:35:34  voba
// - bugfix номера гиперссылок теперь берем из документа
//
// Revision 1.112  2005/11/18 10:42:11  step
// new: property TValuesIteratorForJoinedRecs.FullRec
//
// Revision 1.111  2005/11/18 07:40:15  step
// new: TValuesIteratorForJoinedRecs
//
// Revision 1.110.6.2  2006/03/06 08:39:06  voba
// - new function FindByFields - поиск по произвольному набору полей.
//
// Revision 1.110.6.1  2006/02/10 10:38:07  voba
// - bugfix номера гиперссылок теперь берем из документа
//
// Revision 1.110  2005/10/20 11:27:33  step
// убран вызов отладочной процедуры LogDeletion
//
// Revision 1.109  2005/10/17 12:53:05  step
// new: перегруженный TAbsHtTbl.ModifyRecs
//
// Revision 1.108  2005/10/14 12:04:57  step
// new: TValuesIterator.ReadStr
//
// Revision 1.107  2005/05/27 08:30:59  step
// исправлена function CharsToStr
//
// Revision 1.106  2005/05/20 14:33:55  step
// THtCachedUpdates.ApplyUpdates: добавлен вывод в лог сведений об отклоненном дубликате
//
// Revision 1.105  2005/05/17 09:27:38  lulin
// - new unit: evResultFont.
//
// Revision 1.104  2005/04/08 14:55:10  step
// no message
//
// Revision 1.103  2005/04/08 14:49:37  step
// Исправлена THtCachedUpdates.ApplyUpdates (учитывает игнорирование дубликатов)
//
// Revision 1.102  2005/03/30 12:37:29  step
// подправлен THtCachedUpdates - сделан более устойчивым к сбоям при ApplyUpdates
//
// Revision 1.101  2005/03/28 10:06:03  step
// подправлена TAbsHtTbl.RecordAsString
//
// Revision 1.100  2005/03/16 11:15:14  step
// переименована TAbsHtTbl.FieldAsString --> TAbsHtTbl.ValueAsString и убрана в секцию private
//
// Revision 1.99  2005/03/16 08:45:31  voba
// - сделал PutToFullRec и GetFromFullRec virtual из-за перехода на AnsiString, Надо будет поправить в базовом классе и заменить на AnsiString все места использования
//
// Revision 1.98  2005/02/16 15:07:48  step
// new: TValuesIterator.ValueSize
//
// Revision 1.97  2005/02/11 10:42:09  step
// подправлены LockTbl и TblHold
//
// Revision 1.96  2005/02/08 11:16:10  step
// из TAbsHtTbl.RecNumOf убрано обновление снимка
//
// Revision 1.95  2005/02/07 08:54:09  step
// оставляем исключение таким какое оно есть, и не выдумываем ничего постороннего
//
// Revision 1.94  2005/02/03 14:34:21  step
// добавлен временный код для ловли факта удаления в табл. DT#B
//
// Revision 1.93  2005/01/31 14:27:43  step
// добавлена возможность изменять записи не только по номеру, но и по значению уник. ключа
//
// Revision 1.92  2005/01/25 12:32:14  lulin
// - bug fix: был потерян var - соответственно затирались чужие данные.
//
// Revision 1.91  2004/12/23 10:17:07  step
// new: function BuildSab
//
// Revision 1.90  2004/12/22 12:56:12  step
// new: function StreamToSab
//
// Revision 1.89  2004/11/26 10:52:55  step
// no message
//
// Revision 1.88  2004/11/26 10:50:24  step
// no message
//
// Revision 1.87  2004/11/26 10:07:25  step
// no message
//
// Revision 1.86  2004/11/26 10:05:30  step
// no message
//
// Revision 1.85  2004/11/26 10:00:00  step
// TValuesIterator теперь может работать и с Sab'ми содержащими значения поля
//
// Revision 1.84  2004/11/15 14:38:33  step
// изменена TPrometSAB.SetCurSab
//
// Revision 1.83  2004/11/10 12:40:41  step
// переименование метода
//
// Revision 1.82  2004/11/09 09:34:08  step
// new: TAbsHtTbl.IsRecordExists
//
// Revision 1.81  2004/11/04 13:44:46  step
// изменена TPrometSAB.SetCurSab
//
// Revision 1.80  2004/10/29 09:27:43  step
// отказ от использования TPrometTbl в TValuesIterator
//
// Revision 1.79  2004/10/22 16:07:13  step
// добавлен критерий, определяющий выбор метода добавления пачки записей
//
// Revision 1.78  2004/09/27 11:33:56  step
// ограничен размер кешируеммых данных (при превышении - слив)
//
// Revision 1.77  2004/09/21 12:04:19  lulin
// - Release заменил на Cleanup.
//
// Revision 1.76  2004/09/13 13:29:52  voba
// - new behavior: оптимизация скорости procedure THtCachedUpdates.ApplyUpdates; (HyTech очень медленно добавляет пачку, надо разбираться)
//
// Revision 1.75  2004/08/19 14:09:53  step
// исправление опечаток
//
// Revision 1.74  2004/08/19 13:55:23  step
// Добавлены константы - коды ошибок, возвращаемые HT-функциями
//
// Revision 1.73  2004/08/05 18:01:47  step
// в TAbsHtTbl.RefreshSrchList вставлена проверка
//
// Revision 1.72  2004/08/03 08:52:48  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.71  2004/07/20 19:47:03  step
// переделана TAbsHtTbl.CheckFieldValue - теперь плохие строки исправляет (вместо выбрасывания исключения)
//
// Revision 1.70  2004/07/20 13:43:54  step
// функция TAbsHtTbl.GetOffset снова стала статической
//
// Revision 1.69  2004/07/20 08:01:01  step
// отключена CheckRecord (временно)
//
// Revision 1.68  2004/07/16 14:56:59  step
// добавлена проверка HT-правильности данных
//
// Revision 1.67  2004/07/14 15:26:15  step
// property Buffering перенесено в секцию private
//
// Revision 1.66  2004/07/14 13:28:27  step
// продолжительность транзакции задается в StartTA
//
// Revision 1.65  2004/07/14 12:52:48  step
// время продолжительности транзакции задается теперь через параметр метода TAbsHtTbl.StartTA
//
// Revision 1.64  2004/07/14 10:29:05  step
// Убран неявный слив кэша. Соответственно добавлен медот явного слива оного.
//
// Revision 1.63  2004/07/13 08:02:33  step
// слияние с веткой b_import_filter_optimization2
//
// Revision 1.62  2004/07/12 08:36:12  step
// исправление: THtCachedUpdates.ModifiedRec учитывает повторное изменение одной и той же записи
//
// Revision 1.61.2.2  2004/07/12 17:01:56  step
// оптимизация: уменьшение "фрагментации" интервалов в табл. FREE
//
// Revision 1.61.2.1  2004/07/08 17:14:26  step
// в TPrometTbl встроен кэш номеров (получаемых из табл. FREE)
//
// Revision 1.61  2004/07/08 09:47:28  step
// добавлена запись в лог сообщений о дубликатах
//
// Revision 1.60  2004/07/07 15:15:09  step
// новое property TAbsHtTbl.IgnoreDuplicates
//
// Revision 1.59  2004/07/07 14:15:12  step
// bug fix: вызов CloseSab перед изменением-удалением записей в THtCachedUpdates.ApplyUpdates
//
// Revision 1.58  2004/07/02 15:29:19  step
// небольшое уточнение
//
// Revision 1.57  2004/07/01 14:14:26  voba
// - merge newCashe
//
// Revision 1.56.2.8  2004/06/25 09:10:02  step
// избавление от повторных блокировок
//
// Revision 1.56.2.7  2004/06/18 14:41:26  step
// замена Buffering на StartCaching/StopCaching
//
// Revision 1.56.2.6  2004/06/18 13:52:29  step
// clean code
//
// Revision 1.56.2.5  2004/06/18 13:21:00  step
// в TAbsHtTbl для управления кешированием добавлены свойства CachedOperations, CachedUpdatesLocking
//
// Revision 1.56.2.4  2004/06/18 08:33:25  step
// при кешировании таблица блокируется целиком
//
// Revision 1.56.2.3  2004/06/18 08:08:37  step
// code clean
//
// Revision 1.56.2.2  2004/06/18 08:00:35  step
// Вставлен слив кеша в операции, при которых кеширование не допускается
//
// Revision 1.56.2.1  2004/06/17 18:00:21  step
// Класс THtCachedUpdates изменен. В TAbsHtTbl полностью изменено кеширование (использован THtCachedUpdates).
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.56  2004/06/16 14:26:01  step
// переписана THtCachedUpdates.ApplyUpdates
//
// Revision 1.55  2004/06/15 15:05:29  step
// new: class THtCachedUpdates
// new: procedure ValuesToSab
// add: property TAbsHtTbl.Handle
//
// Revision 1.54  2004/06/10 11:38:17  step
// new property: TAbsHtTbl.ElementKeyKind
//
// Revision 1.53  2004/06/09 11:43:52  step
// new properties: TAbsHtTbl.ElementClass и TAbsHtTbl.ElementType
//
// Revision 1.52  2004/06/09 09:39:58  step
// new property: TAbsHtTbl.ElementsCount
//
// Revision 1.51  2004/06/02 18:09:03  step
// change: TAbsHtTbl.GetLength, TValuesIterator.Create
//
// Revision 1.50  2004/06/01 18:23:06  step
// исправлен TValuesIterator.Create
//
// Revision 1.49  2004/05/25 08:31:14  step
// исправлена TValuesIterator.FieldOffset
//
// Revision 1.48  2004/05/24 17:20:44  step
// new: TValuesIterator
//
// Revision 1.47  2004/05/18 12:05:57  step
// bug fix: избавление от зацикливания
//
// Revision 1.46  2004/05/18 09:07:37  step
// change: GlobalFamPaths[] --> GlobalHtServer.FamilyTbl.FamilyPath()
//
// Revision 1.45  2004/05/13 16:28:05  step
// замена: "TFreeTbl.Create ..." --> "GlobalHtServer.FreeTbl[...]"
//
// Revision 1.44  2004/05/13 13:45:53  step
// Убраны методы SetTransOn, SetTransOff. Добавлены InTransaction, ClearTransId, TransID
//
// Revision 1.43  2004/05/06 09:15:51  voba
// merge with adding_diapasons_table_free2
//
// Revision 1.42  2004/04/19 13:21:18  voba
// - code clean
//
// Revision 1.41.10.2  2004/04/21 11:39:07  step
// change: TAbsHtTbl.MaxIdBetween
//
// Revision 1.41.10.1  2004/04/16 18:15:52  step
// new: TAbsHtTbl.MaxIdBetween
//
// Revision 1.41  2004/03/09 15:56:23  step
// Изменена TPrometTbl.GetFreeNum (удален возврат -1)
//
// Revision 1.40  2004/03/05 17:07:09  step
// чистка кода
//
// Revision 1.39  2004/02/12 11:47:34  step
// изменена procedure TPrometSAB.SetCurSab и добавлена временная обработка ошибок (туда же)
//
// Revision 1.38  2004/02/02 10:36:17  step
// bug fix
//
// Revision 1.37  2004/01/30 18:30:07  step
// add: TAbsHtTbl.GroupFieldSize
//
// Revision 1.36  2004/01/28 20:16:13  step
// исправлена TAbsHtTbl.GetLength
//
// Revision 1.35  2004/01/15 18:08:59  step
// Добавлена сортировка к TFilteredData
//
// Revision 1.34  2004/01/15 12:58:14  step
// добавлен модификатор const к параметрам типа AnsiString
//
// Revision 1.33  2004/01/15 09:51:07  step
// bug fix: TAbsHtTbl.ElemNumByName
//
// Revision 1.32  2004/01/14 16:52:10  step
// исправлен идентификатор
//
// Revision 1.31  2004/01/14 11:52:02  step
// Добавлен класс TFilteredData, методы TAbsHtTbl.ElemNumByName и TAbsHtTbl.FindByUniqKey
//
// Revision 1.30  2003/11/11 10:15:57  voba
// -bug fix : в PutToFullRec вставлена проверка на валидный индекс поля
//
// Revision 1.29  2003/09/22 13:55:08  voba
// -enhance: добавил процедуры TemporalCloseTbl и ReOpenTbl - скобки для "временного" закрытия талицы и последующего ее переоткрытия, если она была открыта
//
// Revision 1.28  2003/09/04 17:31:49  step
// Метод TAbsHtTbl.GetOffset сделан виртуальным для переопределения в TDictionaryTbl.
//
// Revision 1.27  2003/08/28 17:00:41  step
// bug fix: исправлена StartTA
//
// Revision 1.26  2003/03/31 13:48:59  demon
// - new: увеличен размер буферов, выделяемых по умолчанию с 64кб до 8Мб
//
// Revision 1.25  2003/01/23 16:37:36  demon
// - new: some fixes in object TUniKeySAB
//
// Revision 1.24  2003/01/22 15:23:36  demon
// - new: add new object TUniKeySAB
//
// Revision 1.23  2002/04/02 12:17:22  demon
// - new behavior: add methods for copyTo and copyFrom JournaledDicts
//
// Revision 1.22  2002/01/17 13:14:27  voba
// - new: add functions GetValueSAB and FreeSAB in AbsHTTbl
//
// Revision 1.21  2002/01/17 12:49:38  demon
// no message
//
// Revision 1.20  2001/08/06 08:36:07  demon
// no message
//
// Revision 1.19.2.1  2001/07/10 14:09:01  voba
// - bug fix: Демон правил
//
// Revision 1.19  2001/07/06 14:38:14  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.18  2000/12/15 15:36:15  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

interface
uses HT_Const,
     SysUtils, WinTypes, Classes, Contnrs,
     l3Base, l3DatLst,
     Dt_Const, dt_Table, dt_Sab, Dt_Types, Dt_Containers,
     l3Interfaces,
     l3Memory,
     l3String,
     l3TempMemoryStream
     ;
type

  TAbsHtTbl = class;

  TRecordOperation = (roInsert, roDelete, roUpdate);
  TRecordOperations = set of TRecordOperation;
  TLockType = (ltNoLocks, ltCachedRecords, ltTable);

  TSabPurpose = (spToDelete, spToModify); // только для THtCachedUpdates

  THtCachedUpdates = class(Tl3Base)
  private
   f_InsertedRecs: Tl3TempMemoryStream;
   f_ModifiedRecs: Tl3TempMemoryStream;

   f_Sabs: array [TSabPurpose] of Sab;
   f_SabHasInit: array [TSabPurpose] of Boolean;
   f_ModifiedRecNums: TBucketList; // отображение RecNum --> f_ModifiedRecs.Position

   f_TableIsHeld: Boolean;
   f_LockType: TLockType;

   // установка-снятие замков
   procedure SetLock(aRecNum: Longint);
   procedure RemoveLocks;

   procedure InitSab(aSabPurpose: TSabPurpose);
   function SabIsOpen(aSabPurpose: TSabPurpose): Boolean;
   procedure OpenSab(aSabPurpose: TSabPurpose);
   procedure CloseSab(aSabPurpose: TSabPurpose);
   procedure AddToSab(aSabPurpose: TSabPurpose; aRecNum: Longint);
   function  SabIsEmpty(aSabPurpose: TSabPurpose): Boolean;
   procedure FreeSab(aSabPurpose: TSabPurpose);

   procedure ClearCache; // снимает залочки и чистит кэши.
  protected
   f_Table: TAbsHtTbl;
   function RecLen: Integer;

   procedure Cleanup; override;
   procedure CancelUpdates;
   function  BufferedTooMuch: Boolean;
  public
   constructor Create(aTable: TAbsHtTbl; aLockType: TLockType);
   procedure InsertedRec(aRec: PAnsiChar);
   procedure DeletedRec(aRecNum: Longint);

   procedure ModifiedRec(aRecNum: Longint; aRec: PAnsiChar); overload;
   function  IsEmpty: Boolean;

   procedure ApplyUpdates;
  end;

{+------------------------------------------------------------------------+
 | Абстрактная таблица (объект - предок всех таблиц)                      |
 +------------------------------------------------------------------------+}
  TAbsHtTbl = class(TdtTable)
   public

    fSrchList   : SAB;
   private
    f_CachedUpdates: THtCachedUpdates;
    f_CachedOperations: TRecordOperations;
    f_CachedUpdatesLocking: TLockType;
    f_IgnoreDuplicates: Boolean;
    procedure SetBuffering(aValue: Boolean);
                 // вкл.-выкл. кеширование. При выключении происходит слив в БД.
                 // Кеширование рапространяется только на операции с одиночными записями.
                 // Никакой поиск не видит кешированных данных.
    function  GetBuffering: Boolean;
    //function RecordsAdditionCriteria: Integer;
    property    Buffering : Boolean read GetBuffering write SetBuffering;
   protected
//    f_TransID   : HT_Const.TRID;

    fFullRecord : PAnsiChar;

//    f_InOwnTransaction: Boolean;  // таблица находится в "своей собственной" транзакции,
                                  // т.е. в транзакции запущенной методом Self.StartTA (только так)
    //f_RoughRecsAmount: Integer; // приблизительное кол-во записей в таблице (для вычисления RecordsAdditionCriteria)

    function    GetProtectFlag : Boolean;

    procedure   BeforeRelease; override;
    procedure   Cleanup; override;

    property    ProtectFlag : Boolean read GetProtectFlag;
    function    Check(aResultCode: LongInt; aRec: PAnsiChar = nil): LongInt;
                 // заменяет функцию Ht - отличается игнорированием некоторых ошибок
                 // Через параметр aRec можно передать указатель на запись - для отражения в логе.
   public
    procedure   RefreshSrchList;
    function    AllRecords : Sab;

    function    MakeAllRecordsSab : Sab;

    procedure   ClearFullRec;

    function    GetFullRecord : PAnsiChar;
    procedure   GetFullRec(aRecNum  : Longint; aWithHold : Boolean = false);
    procedure   PutToFullRec(Field : Word; const aBody);
    procedure PutWStrToFullRec(Field : Word; const aStr: Tl3WString);
    procedure   GetFromFullRec(Field : Word;var aBody);
    function    GetCount : LongInt;
    procedure   OpenTbl; override;
    procedure   CloseTbl; override;

    procedure   HoldRec(AbsNum : LongInt);
    procedure   FreeRec(AbsNum : LongInt);

    procedure   AddRec(aRec: Pointer); override;
    procedure   AddFRec;

    procedure   UpdRec(aAbsNum  : LongInt; aRec : Pointer); override;
    procedure   UpdFRec(AbsNum  : LongInt); overload;

    procedure   DelRec(aAbsNum  : Longint); override;
    function    FindByUniqKey(aKeyElemNum: Smallint;
                              const aKeyElemValue;
                              aResultElemNum: Smallint;
                              var aResult): Boolean;
    function    MaxIdBetween(aFirst, aLast: LongWord): LongWord;

    function    MaxID: LongWord;

                 // Управление кешированием.
                 // Кеширование рапространяется только на операции с одиночными записями.
                 // Никакой поиск не видит кешированных данных.
                 // Перед редактированием или поиском лучше лишний вызвать FlushCache.
    procedure   StartCaching(aCachedOperations: TRecordOperations = [roInsert];
                              // те операции, при выполнении которых будет использовано кеширование
                             aLocking: TLockType = ltNoLocks);
                              // какие ставятся замки (на изменяемые записи, на таблицу, или вообще не ставятся)
    procedure   FlushCache; // сливает изменения в таблицу
    procedure   StopCaching; // сливает изменения в таблицу и заканчивает кэширование

                 // см. комментарий к CheckRecord
    procedure   CheckRecord(aRec: Pointer);  // выбрасывает исключение
                 // 1. проверяет допустимость значения по целочисленным полям
                 // 2. в коротких (длиной менее 255) символьных полях меняет #160 (#255) на пробел


    property    FullRecord : PAnsiChar read GetFullRecord;
    property    IgnoreDuplicates : Boolean read f_IgnoreDuplicates write f_IgnoreDuplicates;
  end;

{+------------------------------------------------------------------------+
 | Таблица связанная с Сервером таблиц (GlobalHtServer - модуль Dt_Serv)  |
 +------------------------------------------------------------------------+}

  TPrometTbl = class(TAbsHtTbl)
   private
    f_FreeNumsCacheSize: Integer;
    f_FreeNumsCache: TNumSet;
    function  GetFreeNumsCacheSize: Integer;
    procedure SetFreeNumsCacheSize(const aValue: Integer);
    procedure FillFreeNumsCache;
   protected
    fTblFamily   : TFamilyID;

    procedure   SetTblInfo(aTblID : Integer; aATP : TdtAttrTblPart = atpMain);
    procedure   DelTblInfo;
    function    StartTA(aTransTime: Word = DefaultTransTime): Boolean; override;
    procedure   SuccessTA; override;
    procedure   RollBackTA; override;

    procedure   BeforeRelease; override;
   public
    constructor Create(aFamily    : TFamilyID;
                       aTblID     : Integer;
                       aTblPart   : TdtAttrTblPart = atpMain;
                       aWithFlush : boolean = false);

    constructor CreateWithFlush(aFamily  : TFamilyID;
                                aTblID   : Integer;
                                aTblPart : TdtAttrTblPart = atpMain);
    procedure   ClaimFreeNum(aNum: Longint);

    procedure   OpenTbl; override;
    procedure   CloseTbl; override;

    function    GetFreeNum : LongInt; virtual;
    procedure   PutFreeNum(aNum : LongInt);
    procedure   PutFreeNums(aNums : SAB; WordSized : Boolean = False);

    procedure   ClearFreeNumsCache; // возвращает неиспользованные номера обратно в табл. FREE
    function    IsNumFree(aNum: Longint): Boolean;
    property    FreeNumsCacheSize: Integer read GetFreeNumsCacheSize write SetFreeNumsCacheSize;
    property    TblFamily   : TFamilyID read fTblFamily;
  end;

implementation
uses
 WinProcs,
 l3Types,
 l3MinMax, //l3FileUtils,
 HT_Dll,
 Dt_Serv, Dt_Err, DT_Misc, Dt_Free,
 vtDebug;

procedure TAbsHtTbl.BeforeRelease;
begin
 Buffering := False;
 CloseTbl;

 inherited;
end;

procedure TAbsHtTbl.Cleanup;
begin
 if Assigned(fFullRecord) then
  l3StrDispose(fFullRecord);

 inherited;
end;

procedure TAbsHtTbl.OpenTbl;
var
 l_Ok : Longint;
begin
 inherited;
 if IsTableOpened then
 try
  if ProtectFlag then
   TblHold(l_Ok);

  dtCleanSab(fSrchList);
  RefreshSrchList;
 except
  inherited CloseTbl;
  raise;
 end;
end;

procedure TAbsHtTbl.CloseTbl;
begin
 if IsTableOpened then
 begin
  Buffering := False;
  if htResultsType(fSrchList)<>Res_NProc then
   htClearResults(fSrchList);
  inherited;
 end;
end;

function TAbsHtTbl.GetProtectFlag : Boolean;
begin
 Result:= IsTblHeld or Buffering;
end;

procedure TAbsHtTbl.SetBuffering(aValue: Boolean);
begin
 if Buffering <> aValue then
  if aValue then
   f_CachedUpdates := THtCachedUpdates.Create(Self, f_CachedUpdatesLocking)
  else
  begin
   try
    f_CachedUpdates.ApplyUpdates;
   finally
    FreeAndNil(f_CachedUpdates);
   end;
  end;
end;

procedure TAbsHtTbl.RefreshSrchList;
begin
 CheckIsOpen;
 // видимо применение IsResultObsolete может ускорить
 if htResultsType(fSrchList)<>Res_NProc then
  htClearResults(fSrchList);
 htSearch(nil,fSrchList,Handle,AbsNumFld,GREAT,@Zero,nil);
 Ht(fSrchList.nRetCode);
 //f_RoughRecsAmount := fSrchList.gFoundCnt;
end;

function TAbsHtTbl.AllRecords : Sab;
begin
 RefreshSrchList;
 Result := fSrchList;
end;

function TAbsHtTbl.MakeAllRecordsSab : Sab;
begin
 CheckIsOpen;
 htSearch(nil,Result,Handle,AbsNumFld,GREAT,@Zero,nil);
 Ht(Result.nRetCode);
end;

procedure TAbsHtTbl.HoldRec(AbsNum:LongInt);
begin
 CheckIsOpen;
 if not ProtectFlag then
  Ht(htHoldRecord(Handle,AbsNum));
end;

procedure TAbsHtTbl.FreeRec(AbsNum:LongInt);
begin
 CheckIsOpen;
 if not ProtectFlag then
  Ht(htReleaseRecord(Handle,AbsNum));
end;

procedure TAbsHtTbl.ClearFullRec;
begin
 if fFullRecord <> nil then
  l3FillChar(fFullRecord^, RecSize);
end;

function TAbsHtTbl.GetFullRecord : PAnsiChar;
begin
 if fFullRecord = nil then
 begin
  fFullRecord := l3StrAlloc(RecSize);
  l3FillChar(fFullRecord^, RecSize);
 end;
 Result := fFullRecord;
end;

procedure TAbsHtTbl.GetFullRec(aRecNum  : Longint; aWithHold : Boolean = false);
begin
 CheckIsOpen;
 if (not ProtectFlag) and aWithHold then
  Ht(htHoldReadRecord(Handle, aRecNum, FullRecord))
 else
  //Ht(htReadRecordByHandle(Handle, aRecNum, FullRecord));
  Ht(htReadRecord(nil, Handle, aRecNum, FullRecord));
end;

procedure TAbsHtTbl.PutToFullRec(Field : Word;const aBody);
begin
 PutFieldToRecord(FullRecord, Field, aBody);
end;

procedure TAbsHtTbl.GetFromFullRec(Field : Word; var aBody);
begin
 GetFieldFromRecord(FullRecord, Field, aBody);
end;

procedure TAbsHtTbl.AddRec(aRec: Pointer);
begin
 CheckIsOpen;
 CheckRecord(aRec);

 if Buffering and (roInsert in f_CachedOperations) then
  f_CachedUpdates.InsertedRec(aRec)
 else
  Check(htRecordAdd(Handle, aRec), aRec);
end;

procedure TAbsHtTbl.UpdRec(aAbsNum  : Longint; aRec : Pointer);
begin
 CheckIsOpen;
 CheckRecord(aRec);

 if Buffering and (roUpdate in f_CachedOperations) then
  f_CachedUpdates.ModifiedRec(aAbsNum, aRec)
 else
  Check(htRecordModify(Handle, aAbsNum, aRec), aRec);
end;

procedure TAbsHtTbl.AddFRec;
begin
 Assert(fFullRecord <> nil, DTErrMsg(ecFullRecordNotInit));
 AddRec(fFullRecord);
end;

procedure TAbsHtTbl.UpdFRec(AbsNum  : LongInt);
begin
 Assert(fFullRecord <> nil, DTErrMsg(ecFullRecordNotInit));
 UpdRec(AbsNum, fFullRecord);
end;

procedure TAbsHtTbl.DelRec(aAbsNum : Longint);
begin
 CheckIsOpen;
 if Buffering and (roDelete in f_CachedOperations) then
  f_CachedUpdates.DeletedRec(aAbsNum)
 else
  inherited;
end;

function TAbsHtTbl.FindByUniqKey(aKeyElemNum: Smallint;
                                 const aKeyElemValue;
                                 aResultElemNum: Smallint;
                                 var aResult): Boolean;
var
 l_RecNo: Longint;
 lPhoto : Sab;

begin
 Result := False;

 CheckIsOpen;
 CheckElementNum(aKeyElemNum);

 if (ElementKeyKind[aKeyElemNum] <> EK_UNIQUE) then
  raise EHtErrors.CreateInt(ecNotKeyField);

 lPhoto := PhotoOfTable;
 l_RecNo := GetRecordIDByUniq(aKeyElemNum, aKeyElemValue, nil, @lPhoto);

 if l_RecNo > 0 then
 begin
  ClearFullRec;
  if Ht(htReadRecord(@lPhoto, Handle, l_RecNo, FullRecord)) = 0 then
  begin
   GetFromFullRec(aResultElemNum, aResult);
   Result := True;
  end;
 end;
end;

function TAbsHTTbl.GetCount : LongInt;
begin
 RefreshSrchList;
 Result:=fSrchList.gFoundCnt;
end;

{ TPrometTbl }

constructor TPrometTbl.Create(aFamily    : TFamilyID;
                              aTblID     : Integer;
                              aTblPart   : TdtAttrTblPart = atpMain;
                              aWithFlush : boolean = false);
var
 aPath : TPathStr;
 aOpenMode : Byte;
begin
 Assert(Assigned(GlobalHtServer), 'GlobalHtServer = nil');
 if aFamily = MainTblsFamily then // Этот случай специально обрабатывается отдельно.
                                  // Просто оставить GlobalHtServer.FamilyTbl.FamilyPath(aFamily)
                                  // нельзя, т.к. попадем в рекурсию при вызове FamilyTbl.Create.
  aPath := GlobalHtServer.CurTblPath
 else
  aPath := GlobalHtServer.FamilyTbl.FamilyPath(aFamily);


 aOpenMode := GlobalHtServer.HyTechTableOpenMode;
 if aWithFlush then
  aOpenMode := aOpenMode or TAB_FLUSH;

 inherited Create(aPath,
                  TablePassword(aFamily, aTblID),
                  TableName(aFamily, aTblID, aTblPart),
                  aOpenMode);
 fTblFamily := aFamily;
 OpenTbl;
 AllocTblInfo;
 SetTblInfo(aTblID, aTblPart); // регистрация на HTServ
 f_FreeNumsCacheSize := 0;
end;

constructor TPrometTbl.CreateWithFlush(aFamily    : TFamilyID;
                                       aTblID     : Integer;
                                       aTblPart   : TdtAttrTblPart = atpMain);
begin
 Create(aFamily, aTblID, aTblPart, True);
end;

procedure TPrometTbl.BeforeRelease;
begin
 ClearFreeNumsCache;
 DelTblInfo;
 inherited;
end;

function TPrometTbl.StartTA(aTransTime: Word = DefaultTransTime): Boolean;
begin
 CheckIsOpen;
 if InTransaction then
  Result:=True
 else
 begin
  Result := GlobalHtServer.StartTransaction([Self], f_TransID, aTransTime);
  if Result then
  f_InOwnTransaction := True;
 end;
end;

procedure TPrometTbl.OpenTbl;
begin
 if not IsTableOpened then
  begin
   inherited;
   try
    //if fFamilyID <> MainTblsFamily then  // захватывать Main семейство не получается (рекурсия)
     GlobalHtServer.Family[fTblFamily].Lock(TblShareFlag)
    //OpenCtrlTbl;
   except
    raise EHtErrors.CreateInt(ecFamilyLocked);
   end;
  end;
end;

procedure TPrometTbl.CloseTbl;
begin
 if IsTableOpened then
  begin
   //if fFamilyID <> MainTblsFamily then
   GlobalHtServer.Family[fTblFamily].Unlock;
   //CloseCtrlTbl;
   inherited;
  end;
end;

procedure TPrometTbl.SetTblInfo(aTblID : Integer; aATP : TdtAttrTblPart = atpMain);
var
 lOTRec : TOpenTblRec;
begin
 l3FillChar(lOTRec, SizeOf(lOTRec));
 with lOTRec do
  begin
   rFamily := fTblFamily;
   rTblID  := aTblID;
   rATP    := aATP;
   rObj    := Self;
  end;

 GlobalHtServer.AddTblObj(lOTRec);
end;

procedure TPrometTbl.DelTblInfo;
begin
 GlobalHtServer.DelTblObj(Self);
end;

function TPrometTbl.GetFreeNum : LongInt;
begin
 FillFreeNumsCache;

 if f_FreeNumsCache = nil then
  Result := GlobalHtServer.FreeTbl[fTblFamily].GetFree(TblName)
 else
  Result := f_FreeNumsCache.Pick;
end;

procedure TPrometTbl.PutFreeNum(aNum : LongInt);
begin
 GlobalHtServer.FreeTbl[fTblFamily].PutFree(TblName, aNum);
end;

procedure TPrometTbl.PutFreeNums(aNums : SAB; WordSized : Boolean);
begin
 GlobalHtServer.FreeTbl[fTblFamily].PutFrees(TblName, aNums, WordSized);
end;

function TAbsHtTbl.MaxIdBetween(aFirst, aLast: LongWord): LongWord;
const
 c_IdField = 1;
var
 l_RecsInInterval: Sab;
begin
 CheckIsOpen;
 htSearch(nil,
          l_RecsInInterval,
          Handle,
          c_IdField,
          IN_RANGE,
          @aFirst,
          @aLast);
 try
  if l_RecsInInterval.gFoundCnt > 0 then
   Ht(htKeyMaximum(l_RecsInInterval, c_IdField, @Result))
  else
   Result := 0;
 finally
  htClearResults(l_RecsInInterval);
 end;
end;

function TAbsHtTbl.MaxID: LongWord;
const
 c_IdField = 1;
var
 l_Sab : Sab;
begin
 l_Sab := AllRecords;
 Result := 0; // для двухбайтных старший word почистим
 Ht(htKeyMaximum(l_Sab, c_IdField, @Result));
end;

procedure TPrometTbl.RollBackTA;
begin
 CheckIsOpen;
 if f_InOwnTransaction then
 begin
  f_InOwnTransaction := False;
  GlobalHtServer.RollBackTransaction(f_TransID);
 end;
end;

procedure TPrometTbl.SuccessTA;
begin
 CheckIsOpen;
 if f_InOwnTransaction then
 begin
  f_InOwnTransaction := False;
  GlobalHtServer.CommitTransaction(f_TransID);
 end;
end;

{ THtCachedUpdates }

procedure THtCachedUpdates.AddToSab(aSabPurpose: TSabPurpose;
                                    aRecNum: Integer);
begin
 if not f_SabHasInit[aSabPurpose] then
  InitSab(aSabPurpose);
 if not SabIsOpen(aSabPurpose) then
  OpenSab(aSabPurpose);
 f_Table.Check(htIncludeResultsItem(f_Sabs[aSabPurpose], aRecNum, nil));
 SetLock(aRecNum);
end;

procedure THtCachedUpdates.ApplyUpdates;

  function lApplyInsertUpdates(aBuffer: Pointer; aBufSize: Longint): Longint;
  begin
   Result := f_InsertedRecs.Read(aBuffer^, aBufSize);
  end;

  function lApplyModifyUpdate(gRecNo  : LongInt; fpRecord: Pointer) : MFUNC_RET;
  begin
   Result := BoolToMFUNC_RET[f_ModifiedRecs.Read(fpRecord^, RecLen) = RecLen];
  end;

  {var
   l_NewRec: Pointer;
   l_Pos: Pointer;
  begin
   if f_ModifiedRecNums.Find(Pointer(gRecNo), l_Pos) then
   begin
    l_NewRec := f_ModifiedRecs.MemoryPool.AsPointer + Integer(l_Pos);
    l3Move(l_NewRec^, fpRecord^, RecLen);
    Result := True;
   end
   else
    Result := False;
  end; }

var
 lRecCount : Integer;
 lBuf : PAnsiChar;
 I : Integer;

 lApplyInsertUpdatesStub  : TFillBufferProc;
 lHTStub : Pointer;
begin
 if IsEmpty then
  Exit;

 if not f_Table.IsTableOpened then
  raise EHtErrors.CreateInt(ecTblNotOpen);

 f_Table.StartTA(cMaxModTime);
 try
  // Добавление
  if (f_InsertedRecs <> nil) and (f_InsertedRecs.Size > 0) then
  begin
   lRecCount := f_InsertedRecs.Size div RecLen;
   f_InsertedRecs.Position := 0;
   lApplyInsertUpdatesStub := L2FillBufferProc(@lApplyInsertUpdates);
   try
    f_Table.AddRecs(lRecCount, lApplyInsertUpdatesStub);
   finally
    FreeFillBufferProc(lApplyInsertUpdatesStub);
   end;
  end; // Добавление

  // Изменение
  if not SabIsEmpty(spToModify) then
  begin
   CloseSab(spToModify);
   if f_LockType = ltNoLocks then
    f_Table.Check(htHoldResults(f_Sabs[spToModify]));
   f_ModifiedRecs.Position := 0;
   try
    lHTStub := HTStub3(@lApplyModifyUpdate);
    try
     f_Table.ModifyRecs(f_Sabs[spToModify], lHTStub, True {DupIgnore});
    finally
     HTStubFree(lHTStub);
    end;

   finally
    if f_LockType = ltNoLocks then
     f_Table.Check(htReleaseResults(f_Sabs[spToModify]));
   end;
  end; // Изменение

  // Удаление
  if not SabIsEmpty(spToDelete) then
  begin
   CloseSab(spToDelete);
   f_Table.Check(htDeleteRecords(f_Sabs[spToDelete]));
  end; // Удаление

  f_Table.SuccessTA;

  // Сброс замков и кэшей - только после удачного коммита!
  ClearCache;
 except
  f_Table.RollBackTA;
  raise;
 end;
end;

procedure THtCachedUpdates.CancelUpdates;
begin
 if IsEmpty then
  Exit;

 ClearCache;
end;

procedure THtCachedUpdates.ClearCache;
begin
 // сброс замков
 RemoveLocks;
 FreeSab(spToDelete);
 FreeSab(spToModify);
 // очистка
 FreeAndNil(f_InsertedRecs);
 FreeAndNil(f_ModifiedRecs);
 FreeAndNil(f_ModifiedRecNums);
end;

procedure THtCachedUpdates.FreeSab(aSabPurpose: TSabPurpose);
begin
 if not f_SabHasInit[aSabPurpose] then
  Exit;

 CloseSab(aSabPurpose);
 htClearResults(f_Sabs[aSabPurpose]);

 f_SabHasInit[aSabPurpose] := False;
end;

procedure THtCachedUpdates.CloseSab(aSabPurpose: TSabPurpose);
begin
 if f_SabHasInit[aSabPurpose] and htIsResultOpen(f_Sabs[aSabPurpose]) then
  htCloseResults(f_Sabs[aSabPurpose]);
end;

constructor THtCachedUpdates.Create(aTable: TAbsHtTbl; aLockType: TLockType);
begin
 f_LockType := aLockType;
 f_Table := aTable;
end;

procedure THtCachedUpdates.DeletedRec(aRecNum: Longint);
begin
 AddToSab(spToDelete, aRecNum);
end;

procedure THtCachedUpdates.InitSab(aSabPurpose: TSabPurpose);
begin
 if f_SabHasInit[aSabPurpose] then
  Exit;

 htCreateEmptySab(nil,
                  f_Sabs[aSabPurpose],
                  f_Table.Handle,
                  0,
                  RES_RECORD);
 f_SabHasInit[aSabPurpose] := True;
end;

procedure THtCachedUpdates.InsertedRec(aRec: PAnsiChar);
begin
 //if BufferedTooMuch then
 // ApplyUpdates;

 if f_InsertedRecs = nil then
  f_InsertedRecs := Tl3TempMemoryStream.Create; //Tl3MemoryStream.Make;

 f_InsertedRecs.Write(aRec^, RecLen);
end;

function THtCachedUpdates.IsEmpty: Boolean;
begin
 Result := SabIsEmpty(spToDelete)
       and SabIsEmpty(spToModify)
       and (f_InsertedRecs = nil);
end;

procedure THtCachedUpdates.ModifiedRec(aRecNum: Longint;
                                       aRec: PAnsiChar);
var
 l_RecPos: Pointer;
 lSavePos : Int64;
begin
 //if BufferedTooMuch then
 // ApplyUpdates;

 if f_ModifiedRecs = nil then
  f_ModifiedRecs := Tl3TempMemoryStream.Create;
 if f_ModifiedRecNums = nil then
  f_ModifiedRecNums := TBucketList.Create;


 if f_ModifiedRecNums.Find(Pointer(aRecNum), l_RecPos) then
 begin // изменение этой записи уже имеется в кэше
  //l3Move(aRec^, (f_ModifiedRecs.MemoryPool.AsPointer + Int64(l_RecPos))^, RecLen);
  lSavePos := f_ModifiedRecs.Position;
  f_ModifiedRecs.Position := Int64(l_RecPos);

  f_ModifiedRecs.Write(aRec^, RecLen);

  f_ModifiedRecs.Position := lSavePos;
 end
 else
 begin // изменение этой записи проходит через кэш впервые
  AddToSab(spToModify, aRecNum);

  f_ModifiedRecNums.Add(Pointer(aRecNum), Pointer(f_ModifiedRecs.Position));
  f_ModifiedRecs.Write(aRec^, RecLen);
 end;
end;

function THtCachedUpdates.RecLen: Integer;
begin
 Result := f_Table.RecSize;
end;

procedure THtCachedUpdates.Cleanup;
begin
 CancelUpdates;

 inherited;
end;

function TAbsHtTbl.GetBuffering: Boolean;
begin
 Result := f_CachedUpdates <> nil;
end;

procedure THtCachedUpdates.RemoveLocks;
begin
 case f_LockType of
  ltTable:
   if f_TableIsHeld then
   begin
    f_Table.UnlockTbl;
    f_TableIsHeld := False;
   end;

  ltCachedRecords :
   begin
    if not SabIsEmpty(spToDelete) then
     f_Table.Check(htReleaseResults(f_Sabs[spToDelete]));
    if not SabIsEmpty(spToModify) then
     f_Table.Check(htReleaseResults(f_Sabs[spToModify]));
   end;
 end; // case
end;

function THtCachedUpdates.SabIsEmpty(aSabPurpose: TSabPurpose): Boolean;
begin
 Result := not f_SabHasInit[aSabPurpose] or (f_Sabs[aSabPurpose].gFoundCnt = 0);
end;

procedure THtCachedUpdates.SetLock(aRecNum: Longint);
begin
 case f_LockType of
  ltTable:
   if not f_TableIsHeld then
   begin
    f_Table.LockTbl;
    f_TableIsHeld := True;
   end;

  ltCachedRecords:
   if not f_Table.IsTblHeld then
    htHoldRecord(f_Table.Handle, aRecNum);
 end; // case
end;

procedure TAbsHtTbl.StartCaching(aCachedOperations: TRecordOperations = [roInsert];
                                 aLocking: TLockType = ltNoLocks);
begin
 Buffering := False;
 f_CachedOperations := aCachedOperations;
 f_CachedUpdatesLocking := aLocking;
 Buffering := True;
end;

procedure TAbsHtTbl.StopCaching;
begin
 Buffering := False;
end;

function TAbsHtTbl.Check(aResultCode: Integer; aRec: PAnsiChar = nil): LongInt;
begin
 // Игнорируем ошибку о найденом дубликате
 if (aResultCode = HT_ERR_KEY_DOUBLET) then
  if f_IgnoreDuplicates then
  begin
   aResultCode := 0;
   if aRec = nil then
    l3System.Msg2Log(
     Format('Таблица %s: операция добавления (изменения) отменена из-за нарушения условия уникальности.',
            [TblName]))
   else
    l3System.Msg2Log(
     Format('Таблица %s: операция добавления (изменения) отменена из-за нарушения условия уникальности. ' +
            'Отвергнутая запись: %s',
            [TblName, RecordAsString(aRec)]));
  end;

 Result := Ht(aResultCode);
end;

procedure TPrometTbl.ClaimFreeNum(aNum: Longint);
begin
 if not IsNumFree(aNum) then
  raise EHtErrors.CreateInt(ecIDAlreadyUsedParam, [aNum]);
 GlobalHtServer.FreeTbl[fTblFamily].ExcludeFreeFromTable(TblName, aNum); 
end;

function TPrometTbl.GetFreeNumsCacheSize: Integer;
begin
 Result := f_FreeNumsCacheSize;
end;

procedure TPrometTbl.SetFreeNumsCacheSize(const aValue: Integer);
begin
 if aValue = f_FreeNumsCacheSize then
  Exit;

 if aValue = 0 then
  ClearFreeNumsCache;

 f_FreeNumsCacheSize := aValue;
end;

procedure TPrometTbl.FillFreeNumsCache;
begin
 if f_FreeNumsCacheSize = 0 then
 begin
  // использовать остатки, затем убрать кэш
  if f_FreeNumsCache <> nil then
   if (f_FreeNumsCache.Amount = 0) then
    FreeAndNil(f_FreeNumsCache);
 end
 else
 begin
  // использовать остатки, когда опустеет - дополнить. При необходимости - создать кэш.
  if f_FreeNumsCache = nil then
   f_FreeNumsCache := TNumSet.Create;
  if f_FreeNumsCache.Amount = 0 then
   GlobalHtServer.FreeTbl[fTblFamily].GetFreeNums(TblName,
                                                 1,
                                                 f_FreeNumsCacheSize,
                                                 f_FreeNumsCache);
 end;
end;

procedure TPrometTbl.ClearFreeNumsCache;
begin
 if f_FreeNumsCache = nil then
  Exit;

 GlobalHtServer.FreeTbl[fTblFamily].ReturnFreeNums(TblName, f_FreeNumsCache);
 FreeAndNil(f_FreeNumsCache);
end;

function TPrometTbl.IsNumFree(aNum: Longint): Boolean;
begin
 Result := GlobalHtServer.FreeTbl[fTblFamily].IsFree(TblName, aNum);
end;

procedure TAbsHtTbl.FlushCache;
begin
 if f_CachedUpdates <> nil then
  f_CachedUpdates.ApplyUpdates;
end;

procedure TAbsHtTbl.CheckRecord(aRec: Pointer);
var
 I: Integer;
begin
 if aRec = nil then
  raise EHtErrors.CreateInt(ecEmpty);

 for I := 1 to fldCount do
  CheckFieldValue(I, PAnsiChar(aRec) + fldOffset[I]);
end;

procedure TAbsHtTbl.PutWStrToFullRec(Field : Word; const aStr: Tl3WString);
var
 l_Rec: Tl3PCharRec;
begin
 l_Rec := l3PCharLenToPCharRec(aStr);
 try
  PutToFullRec(Field, l_Rec.rS);
 finally
  l3FreePCharRec(l_Rec);
 end;
end;


function THtCachedUpdates.BufferedTooMuch: Boolean;
const
 c_MaxMemoryStreamSize = 1024*1024; // 1 Mb
begin
 Result := (f_InsertedRecs <> nil) and (f_InsertedRecs.Size > c_MaxMemoryStreamSize)
        or (f_ModifiedRecs <> nil) and (f_ModifiedRecs.Size > c_MaxMemoryStreamSize);
end;

procedure THtCachedUpdates.OpenSab(aSabPurpose: TSabPurpose);
begin
 Assert(f_SabHasInit[aSabPurpose], 'Попытка открыть неинициализированный Sab в THtCachedUpdates.OpenSab');

 if not htIsResultOpen(f_Sabs[aSabPurpose]) then
  Ht(htOpenResults(f_Sabs[aSabPurpose],
                   ROPEN_READ,
                   nil,
                   0));
end;

function THtCachedUpdates.SabIsOpen(aSabPurpose: TSabPurpose): Boolean;
begin
 Result := f_SabHasInit[aSabPurpose] and htIsResultOpen(f_Sabs[aSabPurpose]);
end;

end.


