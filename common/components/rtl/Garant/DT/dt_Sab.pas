Unit dt_Sab;

{ $Id: dt_Sab.pas,v 1.142 2016/05/26 14:01:24 voba Exp $ }

// $Log: dt_Sab.pas,v $
// Revision 1.142  2016/05/26 14:01:24  voba
// -k:623267081
//
// Revision 1.141  2016/05/17 11:59:35  voba
// -k:623081921
//
// Revision 1.140  2016/04/18 12:54:15  fireton
// - переводим исправление таблицы FREE на Tl3CardinalList
//
// Revision 1.139  2015/09/10 15:05:11  voba
// no message
//
// Revision 1.138  2015/06/16 13:14:37  lukyanets
// Не собиралось
//
// Revision 1.137  2014/12/25 15:40:52  voba
// - функции восстановления Priority и SortDate
//
// Revision 1.136  2014/12/16 15:25:07  voba
// - сс
//
// Revision 1.135  2014/12/08 14:53:37  voba
// k:ловушка для hterr -42
//
// Revision 1.134  2014/12/02 11:19:58  voba
// - htExcludeResults криво работает
//
// Revision 1.133  2014/11/28 12:03:58  voba
// k:ловушка для hterr -42
//
// Revision 1.132  2014/11/17 13:42:46  voba
// -add function SamePhoto
//
// Revision 1.131  2014/10/09 13:54:39  voba
//  k:565492100
//
// Revision 1.130  2014/10/02 07:45:23  lukyanets
// Аккуратней убиваемся
//
// Revision 1.129  2014/08/20 10:06:56  lulin
// - вставляем диагностику.
//
// Revision 1.128  2014/07/10 14:40:59  voba
// - поменяли var на const где надо
//
// Revision 1.127  2014/07/09 15:27:43  lulin
// - заворачиваем список номеров документов в теги.
//
// Revision 1.126  2014/07/09 12:52:22  lulin
// - заворачиваем список номеров документов в теги.
//
// Revision 1.125  2014/07/03 14:33:12  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.124  2014/06/26 11:14:38  fireton
// - новый хайтек возвращает параметры полей не в том порядке, ставим заплатку
//
// Revision 1.123  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.122  2014/03/05 12:03:15  voba
// - адаптация под новый HyTech
//
// Revision 1.121  2014/02/18 10:59:12  voba
// - bugfix
//
// Revision 1.120  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.119  2013/11/12 12:00:35  voba
// - k:236721575 (Атрибуты в EVD)
//
// Revision 1.118  2013/10/30 09:22:19  fireton
// - список должен быть вегда сортированным (К 497224311)
//
// Revision 1.117  2013/10/25 07:18:17  voba
// - k:236721575
//
// Revision 1.116  2013/07/31 11:23:57  voba
// - K:236721575 (Загрузка и запись атрибутов из тегов EVD)
//
// Revision 1.115  2013/07/09 07:13:23  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.114  2013/07/08 09:27:28  voba
// - Новая реализация SubtractSab без инвертирования списка.
// - Новая реализация TransferToPhoto для списков значений. Берет поле из Photo
//
// Revision 1.113  2012/11/19 11:42:12  voba
// - add режим открытия для procedure IterateRecords
//
// Revision 1.112  2012/05/05 07:48:02  voba
// no message
//
// Revision 1.111  2012/04/06 10:10:48  narry
// Bugfix: TranslateFieldNumber
//
// Revision 1.110  2012/02/08 11:09:15  voba
// -k:314213043
//
// Revision 1.109  2012/02/01 12:03:23  voba
// no message
//
// Revision 1.108  2011/10/05 09:49:47  voba
// - bug fix
//
// Revision 1.107  2011/07/28 08:42:53  voba
// - add function  GetMinValue
//
// Revision 1.106  2011/06/03 14:24:57  voba
// - поменял название функции TSabCursor.Sort на SortJoin тк проблемы с вызовом (не может отличить overload)
//
// Revision 1.105  2011/05/31 12:33:08  voba
// -buf fix Subselect не корректно работала
//
// Revision 1.104  2011/04/08 07:57:50  voba
// - add procedure SubSelectByMask
//
// Revision 1.103  2011/03/01 13:21:25  fireton
// - всегда строим декартово произведение при JOIN
//
// Revision 1.102  2010/02/17 07:18:17  voba
// - add procedure SelectByMask
//
// Revision 1.101  2010/02/02 13:57:42  voba
// - add overload function MakeEmptySab
// - enh procedure TSab.Refresh теперь умеет рефрешить списки значений
//
// Revision 1.100  2010/02/02 08:53:45  fireton
// - Refresh для сабов значений
//
// Revision 1.99  2010/02/01 13:55:26  voba
// - enh. procedure TSab.Refresh;
//
// Revision 1.98  2009/11/10 09:14:45  narry
// - обновление
//
// Revision 1.97  2009/10/22 13:04:54  voba
// - add procedure ValuesOfKeyByCount
//
// Revision 1.96  2009/09/29 13:00:13  voba
// - нумерация полей для сортировки теперь начинается с 1
//
// Revision 1.95  2009/09/15 08:49:07  narry
// - обновление
//
// Revision 1.94  2009/09/14 08:58:56  narry
// - Обновление для исправления
//
// Revision 1.93  2009/09/11 13:17:12  voba
// - bug fix
//
// Revision 1.92  2009/09/11 11:10:57  voba
// - bug fix
//
// Revision 1.91  2009/09/11 09:04:24  voba
// - add function dtMakeRecListBySab
//
// Revision 1.90  2009/09/11 08:51:05  narry
// - bug fix from voba
//
// Revision 1.89  2009/09/10 13:12:36  voba
// - add some function
//
// Revision 1.88  2009/09/04 12:33:15  voba
// - add procedure Distinct
//
// Revision 1.87  2009/07/14 12:39:10  voba
// - add procedure AddSelect
//
// Revision 1.86  2009/05/18 14:13:10  narry
// - появился итератор по объединенным записям
//
// Revision 1.85  2009/05/14 13:00:47  voba
// - add procedure SubSelectTwoFldEq
//
// Revision 1.84  2009/05/12 08:40:41  voba
// - заменил в ISab ссылки на таблицу на интерфейсы
//
// Revision 1.83  2009/05/08 11:10:08  voba
// - заменил TblH на Handle
//
// Revision 1.82  2009/04/21 08:06:39  voba
// - отпилил от TdtTable информационную часть TdtTableInfo
//
// Revision 1.81  2009/03/25 13:54:04  voba
// - add Sort по юзерской функции
//
// Revision 1.80  2009/03/19 08:52:38  voba
// - сс
//
// Revision 1.79  2009/02/24 07:06:32  voba
// - add procedure Histogram
//
// Revision 1.78  2009/02/06 07:27:21  voba
// - enh. проверка на пустой список в _MakeValueSet
//
// Revision 1.77  2009/01/30 13:55:08  voba
// - bug fix синхронизация Сабов перед логическими операциями
//
// Revision 1.76  2009/01/29 17:00:51  voba
// - add  param aPhoto to procedure SelectAll
//
// Revision 1.75  2009/01/28 13:01:09  fireton
// - создаем пустые сабы значений правильно
//
// Revision 1.74  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.73.2.5  2009/01/23 14:06:29  fireton
// - перенос Парня на Query
//
// Revision 1.73.2.4  2009/01/13 08:06:32  voba
// - bug fix
//
// Revision 1.73.2.3  2009/01/11 11:19:59  voba
// - bug fix
//
// Revision 1.73.2.2  2008/12/25 10:17:44  fireton
// - перевод спецпоисков на TdtQuery
//
// Revision 1.73.2.1  2008/12/22 11:09:17  fireton
// - перевод поисков на TdtQuery
//
// Revision 1.73  2008/11/21 12:30:36  voba
// no message
//
// Revision 1.72  2008/11/20 09:07:25  voba
// no message
//
// Revision 1.71  2008/11/19 14:22:02  voba
// - add  procedure SyncWith
//
// Revision 1.70  2008/11/17 07:40:44  voba
// - add Sort on ISabCursor
//
// Revision 1.69  2008/10/31 09:53:00  voba
// - add comment
//
// Revision 1.68  2008/09/19 13:09:05  voba
// - add aMode to MakeJoin
//
// Revision 1.67  2008/09/15 09:03:36  voba
// - bug fix
//
// Revision 1.66  2008/08/14 04:45:17  voba
// - bug fix
//
// Revision 1.65  2008/08/11 08:43:57  voba
// - add IValueSetFiller - новое средство заполнения списка значений
//
// Revision 1.64  2008/05/21 13:38:26  narry
// - новая функция dtSyncResults
//
// Revision 1.63  2008/04/29 14:03:36  voba
// - в процедурах объединения сабов вставил синхронизацию
//
// Revision 1.62  2008/04/07 10:15:33  voba
// - enh.
//
// Revision 1.61  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.60  2008/03/13 12:49:48  voba
// - add procedure CopyRecordsToBuffer
// - add  property  SizeOfItem
// - add function dtMakeRecListBySab
//
// Revision 1.59  2008/02/22 18:26:35  lulin
// - доперевёл списки на модель.
//
// Revision 1.58  2008/02/18 16:47:36  lulin
// - подчистил логику списков, связанную с сортированностью и добавлением элемента.
//
// Revision 1.57  2008/02/18 07:32:15  lulin
// - bug fix: не собирался архивариус.
//
// Revision 1.56  2008/02/13 13:43:16  voba
// - add overload function _MakeValueSet
//
// Revision 1.55  2008/02/12 14:37:30  voba
// - add procedure IterateBlockOfRecords
// - add procedure dtOutSabToStream
//
// Revision 1.54  2008/02/08 08:54:11  voba
// - add function _MakeValueSet  overload;
// - del function StreamToSab
//
// Revision 1.53  2008/02/07 14:44:41  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.52  2008/01/22 13:30:27  voba
// - add   procedure InvertSab;
//
// Revision 1.51  2008/01/14 14:43:33  voba
// - move function GetValueSAB to dt_Sab
//
// Revision 1.50  2007/12/29 12:38:29  fireton
// - bug fix
//
// Revision 1.49  2007/12/28 16:32:37  voba
// - add function MakeEmptySab(aPhoto : ISab) : ISab;
//
// Revision 1.48  2007/12/28 16:19:31  fireton
// - добавлен SelectUserDefined - выборка по call-back (НЕ ТЕСТИРОВАЛАСЬ)
//
// Revision 1.47  2007/12/18 08:41:37  fireton
// - ISabCursor.AddItem теперь умеет добавлять значение в список значений
//
// Revision 1.46  2007/12/04 12:17:27  voba
// - add procedure ModifyRecs overload
// - add procedure TransferToPhoto overload;
//
// Revision 1.45  2007/11/26 09:36:46  voba
// - use  cUndefItem
//
// Revision 1.44  2007/11/16 12:25:12  voba
// - bug fix TSabCursor.OpenSab
//
// Revision 1.43  2007/11/12 12:40:41  fireton
// - bug fix: неверное определение типа саба БД
//
// Revision 1.42  2007/11/06 12:42:58  voba
// - add procedure TSab.ModifyRecs
//
// Revision 1.41  2007/10/16 11:06:51  narry
// - новый метод SubtactSab - вычитание
//
// Revision 1.40  2007/10/11 06:10:30  voba
// - cc
//
// Revision 1.39  2007/10/09 08:56:45  voba
// - cc
//
// Revision 1.38  2007/10/09 08:53:53  voba
// - merge with b_archi_export_refact2
//
// Revision 1.37  2007/10/08 10:13:26  voba
// - bug fix
//
// Revision 1.36  2007/09/26 12:13:34  voba
// - add function TSabCursor.Find
//
// Revision 1.35  2007/09/25 07:41:29  narry
// - range check error
//
// Revision 1.34  2007/09/21 13:37:29  voba
// no message
//
// Revision 1.33  2007/09/19 08:57:16  voba
// no message
//
// Revision 1.32  2007/09/19 07:57:22  voba
// no message
//
// Revision 1.29  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.28  2007/08/14 14:30:09  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.27.2.1  2007/08/13 06:41:47  voba
// - add   function  ExtractHTSab
//
// Revision 1.27  2007/07/24 12:32:33  narry
// - рефакторинг системы сообщений
//
// Revision 1.26  2007/07/03 15:11:12  voba
// - bug fix procedure TSab.UnSort;
//
// Revision 1.25  2007/07/03 13:32:05  voba
// - new ISabCursor
//
// Revision 1.24  2007/06/28 11:13:03  voba
// - add class TSabCursor
//
// Revision 1.23  2007/06/22 14:40:20  voba
// - add   property HTSabAddr to ISab (временно!)
// - add func Refresh, Unsort, IsOpened
//
// Revision 1.22  2007/05/25 15:31:20  voba
// - bug fix constructor TSab._MakeValueSet(aTable : TdtTable;
//
// Revision 1.21  2007/05/24 14:38:35  fireton
// - версия SubSelect для диапазона значений
//
// Revision 1.20  2007/05/11 07:40:26  voba
// - bug fix procedure _dtCopyValuesSabToList
//
// Revision 1.19  2007/04/27 14:29:58  voba
// - add procedure IterateRecords
//
// Revision 1.18  2007/04/19 08:08:36  voba
// - change format procedure TSab.TransferToPhoto
//
// Revision 1.16  2007/04/13 06:16:54  voba
// - add procedure TSab.OrSab(aSab : ISab);
//
// Revision 1.15  2007/04/12 08:45:13  voba
// - add function TSab.GetMaxValue
//
// Revision 1.12  2007/04/03 14:23:18  voba
// - add procedure TSab.SelectAll;
//
// Revision 1.10  2007/03/30 13:23:18  voba
// - merge with b_archi_ChangeHLinks
//
// Revision 1.9  2007/03/09 07:33:51  voba
// - _move function dtMakeRecListBySab to dt_Sab
//
// Revision 1.8  2007/03/06 08:15:05  voba
// - add фабрика для изготовления "пустого" ISab
//
// Revision 1.6  2007/03/02 09:49:03  voba
// - bug fix htSubSearch Bug
//
// Revision 1.5  2007/02/28 19:32:56  voba
// -add procedure TSab.RecFilter - замена htSubSearch в режиме USER_DEF
//
// Revision 1.2  2007/02/22 09:25:07  voba
// - add TSub, ISub
//

interface

uses
 Classes,
 l3Types,
 l3Interfaces,
 l3Memory, l3Base, l3RecList,
 HT_Const,
 dt_Types,
 dtIntf,
 //dt_TblInfo, dt_Table,
 l3IDList,
 l3LongintList,
 l3CardinalList,
 l3ProtoPtrRecList,
 l3FieldSortRecList,
 k2SizedMemoryPool,
 evdTasksHelpers
 ;

var
 cNeedTrace42err : boolean = false;
type
 TSabCursor = class;

 TSab = class(Tl3Base, ISab)
  private
   fSab   : Sab;
   fTable : ITblInfo;
   fSabCursor : TSabCursor;
   f_IsPhoto: Boolean;

   function  Get_HTSabAddr : PSab;

   function  Get_HTSab : Sab;
   function  Get_Table : ITblInfo;
   function  Get_TypeOfSab : SmallInt;
   function  Get_SizeOfItem : Cardinal;

   function GetFieldSizeArray : TSmallIntArray;
    overload;
   function GetFieldSizeArray(const aFldArr : array of ThtField) : TSmallIntArray;
    overload;

   procedure SetSabCursor(aSabCursor : TSabCursor);

   function  InternalGetMaskSab(aElemNum : ThtField; aMask : Integer) : ISab;
  protected
   procedure Cleanup; override;
  public
   constructor Create;
   constructor Make(const aTable : ITblInfo; aSab : PSab);
   constructor MakePhotoOfTable(const aTable : ITblInfo);
   constructor MakeEmpty(const aPhoto : ISab);     overload;
   constructor MakeEmpty(const aTable : ITblInfo); overload;
   constructor MakeEmptyValue(const aPhoto : ISab; aField: SmallInt);
    {* - создает пустой SAB типа RES_RECORD использует aPhoto как фотографию}

   constructor MakeValueSet(const aTable : ITblInfo;
                            aField : ThtField;
                            aFillBufferProc: TFillBufferProc
                            );
    overload;

   constructor MakeValueSet(const aTable : ITblInfo;
                            aField : ThtField;
                            aBuffer : Pointer;
                            aMaxNumOfElem : Integer);
    overload;

   procedure BuildValueSet(aField : ThtField;
                           aFillBufferProc: TFillBufferProc);


   function  MakeSabCursor(const aFields :  array of ThtField;
                           aCacheMethod : TCacheMethod = cmForward;
                           aOpenMode : SmallInt = ROPEN_BODY) : ISabCursor;

   function  MakeValueSetFiller(aField : ThtField; const aPhoto : ISab = nil) : IValueSetFiller;

   procedure RecFilter(aCheckRecProc : Pointer);

   procedure Refresh;
   procedure Clear;
   function  IsEmpty : Boolean;
   function  IsValid : Boolean;

   function  Count : Integer;

   procedure RecordsByKey(aKeyFld : ThtField; const aPhoto : ISab = nil);
    overload;
   procedure RecordsByKey;
    overload;
   procedure ValuesOfKey(aKeyFld : ThtField);

   procedure ValuesOfKeyByCount(aKeyFld : ThtField; aMinRepeat : Longint = 2);
    {* - значения поля с заданным (не меньше aMinRepeat) количеством упоминаний}

   procedure TransferToPhoto(aKeyFld : ThtField; const aPhoto : ISab = nil); overload;
   procedure TransferToPhoto(aKeyFld : ThtField; const aTable : ITblInfo);   overload;
   procedure TransferToPhoto(const aPhoto : ISab = nil); overload;


   procedure SyncWith(const aPhoto : ISab);
   procedure SyncWithExt(var aAnotherSab : ISab); // синхронизирует в обе стороны, если aAnotherSab окажется старше с него снимем копию и освежим
   function  Age : Int64;

   procedure Select(aElemNum : ThtField; const aValue; aCond : ThtCondition = EQUAL; const aPhoto : ISab = nil);
    overload;
   procedure Select(aElemNum : ThtField; const aLoValue; const aHiValue;const  aPhoto : ISab = nil);
    overload;

   procedure SelectByMask(aElemNum : ThtField; aMask : Integer; const  aPhoto : ISab = nil);
   procedure SubSelectByMask(aElemNum : ThtField; aMask : Integer);

   // ФУНКЦИЯ НЕ ТЕСТИРОВАЛАСЬ
   procedure SelectUserDefined(aElemNum : ThtField; const aUserSearchProc: TdtRecAccessProc; const aPhoto : ISab = nil);
   procedure SubSelectUserDefined(aElemNum : ThtField; const aUserSearchProc: TdtRecAccessProc);

   procedure SelectAll(const aPhoto : ISab = nil);

   procedure SubSelect(aElemNum : ThtField; const aValue; aCond : ThtCondition = EQUAL); overload;
    {* - ишет в ранее найденном, фактически реализует пересечение поисков}
   procedure SubSelect(aElemNum : ThtField; const aLoValue; const aHiValue); overload;

   procedure AddSelect(aElemNum : ThtField; const aValue; aCond : ThtCondition = EQUAL); overload;
    {* - ишет и объединяет с ранее найденным}
   procedure AddSelect(aElemNum : ThtField; const aLoValue; const aHiValue); overload;

   procedure SubSelectTwoFldEq(aElemNum1 : ThtField; aElemNum2 : ThtField);
    {* - Функция предназначена для получения подмножества записей, c одинаковыми значениями полей aElemNum1 и aElemNum2}

   procedure Histogram(aElemNum : ThtField; aMinRepeat : Longint = 2);

   procedure DeleteFromTable;

   procedure Sort(const aElemNum : array of ThtField);
    overload;
   procedure Sort(aSortProc : TUserSortProc; const aElemNum : array of ThtField);
    overload;
   procedure Sort;
    overload;

   procedure UnSort;

   procedure Distinct(const aElemNum : array of ThtField);
    {* - убирает повторяющиеся значения для поля/группы полей (уникализовать)}

   procedure AndSab(const aSab: ISab);
   procedure SubtractSab(const aSab: ISab);
   procedure OrSab(const aSab: ISab);
   procedure XorSab(const aSab: ISab);
   procedure InvertSab;

   function  GetMaxValue(aElemNum : ThtField) : Longint;
   function  GetMinValue(aElemNum : ThtField) : Longint;

   procedure Flush; //выместить на диск

   procedure ModifyRecs(aModifyProc : Pointer; aDupIgnore : Boolean = False);
    overload;
   procedure ModifyRecs(aField : ThtField; var aValue; aDupIgnore : Boolean = False);
    overload;

   procedure IterateRecords(aRecProc : TdtRecAccessProc);
    overload;
   procedure IterateRecords(aRecProc : TdtRecAccessProc; const aFldArr : array of ThtField; aOpenMode : SmallInt = ROPEN_BODY);
    overload;

   procedure IterateBlockOfRecords(aBlockProc : TdtBlockAccessProc);
    overload;
   procedure IterateBlockOfRecords(aBlockProc : TdtBlockAccessProc; const aFldArr : array of ThtField);
    overload;

   procedure CopyRecordsToBuffer(aBuffer : Pointer);
    overload;
    {* - копирует все записи в буфер. Буфер длиной не менее Count*SizeOfItem должен быть выделен заранее }
   procedure CopyRecordsToBuffer(aBuffer : Pointer; const aFldArr : array of ThtField);
    overload;
    {* - копирует выбранные поля записей в буфер. Буфер длиной не менее Count*SizeOfItem должен быть выделен заранее }

   function  IsOpened : Boolean;
   procedure OpenSab;
   procedure CloseSab;

   function  ExtractHTSab : Sab;
   {- "Извлекает" HTSab из объекта. При этом объект перестает владеть им и HTSab не будет уничтожен вместе с объектом
       !!Функция переходного периода, для сопряжения с ранее написанным кодом}

   property  HTSab     : Sab read Get_HTSab;
   property  HTSabAddr : PSab read Get_HTSabAddr;
   property  Table     : ITblInfo read Get_Table;
   property  TypeOfSab : SmallInt read Get_TypeOfSab;
   property  SizeOfItem : Cardinal read Get_SizeOfItem;
 end;

 TJoinSab = class(TSab, IJoinSab)
  private
   //fTables : array of ITblInfo;
  public
   constructor MakeJoin(aSab1 : ISab; aJoinField1 : ThtField;
                        aSab2 : ISab; aJoinField2 : ThtField;
                        aMode : SmallInt = Draft_Zero);
    overload;

   constructor MakeJoin(aJoinSab1 : IJoinSab;
                        aJoinSab2 : IJoinSab;
                        aSkipLink : boolean = false;
                        aMode : SmallInt = Draft_Zero);
    overload;

   procedure   IterateJoinRecords(aRecProc : TdtRecAccessProc; const aFldArr : array of TJoinFieldRec);

   procedure   CopyJoinRecordsToBuffer(aBuffer : Pointer; const aFldArr : array of TJoinFieldRec);

   procedure   SortJoin(aElemNum : array of TJoinFieldRec);
    overload;
   procedure   SortJoin(aSortProc : TUserSortProc; aElemNum : array of TJoinFieldRec);
    overload;
   function    TranslateFieldNumber(const aFields : array of TJoinFieldRec) : TFieldArray;
    overload;
   function    TranslateFieldNumber(const aField : TJoinFieldRec) : ThtField;
    overload;

   function    MakeJoinSabCursor(const aFields : array of TJoinFieldRec;
                                       aCacheMethod : TCacheMethod = cmForward;
                                       aOpenMode : SmallInt = ROPEN_BODY) : ISabCursor;
 end;

 TSabCursor = class(Tl3Base, ISabCursor)
  private
  fSab         : TSab;
  fOpenMode    : SmallInt;
  fFields      : TFieldArray;
  fCacheMethod : TCacheMethod;

  fItemSize    : Cardinal;
  fBuffer      : Pointer;
  fBufRecCount : Cardinal;
  fFirstItem   : Cardinal; //номер первой записи в буфере
  fLastItem    : Cardinal; //номер последней записи в буфере

  procedure OpenSab;
  procedure CloseSab;
  procedure Cleanup; override;

  procedure PurgeCache;
  procedure ResetBuffer;

  procedure RestructBufferPrim(aItem : Cardinal);
  procedure RestructBuffer(aItem : Cardinal);

  function GetItemPrim(aIndex : Cardinal) : Pointer;
 public
  constructor Make(aSab : TSab;
                   const aFields :  array of ThtField;
                   aCacheMethod : TCacheMethod = cmForward;
                   aOpenMode : SmallInt = ROPEN_BODY);

  function Count : Integer;

  //function GetMarker(aIndex : Cardinal) : ThtMarker;
  //function GetMarkerIndex(aMarker : ThtMarker) : Cardinal;

  function ReadBuffer(aBuffer : Pointer; aBuffSize : integer) : Cardinal;
   {* - Считывает пачку записей в буффер aBuffer. Курсор переставляется на конец пачки}

  function GetItem(aIndex : Cardinal) : Pointer;
   {* - возвращает указатель на тело записи }
  function AddItem(aAbsNum : Cardinal) : Cardinal; overload;
   {* - возвращает индекс вставленного элемента }
  procedure AddItem(aData : Pointer); overload;
   {* - вставляет данные в список значений }
  function DelItem(aIndex : Cardinal) : Cardinal;
   {* - возвращает Abs номер удаленного элемента }
  function GetRecHandle(aIndex : Cardinal): RHandle;
   {* - возвращает Handle элемента }
  function GetIndex(aAbsNum : Cardinal) : Cardinal;
   {* - возвращает Index элемента по AbsNum}
  function ItemSize : Cardinal;
   {* - возвращает размер элемента}
  function Find(const aCompareProc : Tl3PtrCompareProc;
                      aCompareData : Pointer;
                      aLow, aHi : Longint;
                  out theIndex  : Longint;
                      aNeedLast : boolean = false): Boolean;
   {* - ищет элемент методом дихотомии, адаптированной к использованию на буфере.
        Данные должны быть сортированы!!! Сортировка не проверяется!!!}

  procedure Sort(const aElemNum : array of ThtField);
   overload;
  procedure SortJoin(const aElemNum : array of TJoinFieldRec);
   //overload;
  procedure Sort(aSortProc : TUserSortProc; const aElemNum : array of ThtField);
   overload;
  procedure Sort(aSortProc : TUserSortProc; const aElemNum : array of TJoinFieldRec);
   overload;
  procedure Sort;
   overload;
 end;

TValueSetFiller = class(Tl3Base, IValueSetFiller)
 private
  fSab     : TSab;
  fBuffer  : Pointer;
  fIncludePos : Integer;
  fFieldLen   : Cardinal;
  fFilledBufLen : Cardinal;

  constructor Create(aSab : TSab);
  procedure   Cleanup; override;
  function    GetBuffLen : integer;
  function    GetBuffer : Pointer;
  procedure   AddBuffer;

 public
  procedure AddValue(var aValue);
end;

//фабрики
function MakeSab(const aTable : ITblInfo; const aSab : Sab) : ISab; overload;
function MakeSab(const aTable : ITblInfo) : ISab;             overload;

function MakeEmptySab(const aPhoto : ISab): ISab;     overload;
function MakeEmptySab(const aTable : ITblInfo): ISab; overload;

function MakeJoinSab(const aSab1 : ISab; aJoinField1 : ThtField;
                     const aSab2 : ISab; aJoinField2 : ThtField;
                     aMode : SmallInt = Draft_Zero) : IJoinSab; overload;

function MakeJoinSab(const aJoinSab1 : IJoinSab;
                     const aJoinSab2 : IJoinSab;
                     aSkipLink : boolean = false;
                     aMode : SmallInt = Draft_Zero) : IJoinSab; overload;

function MakePhoto(const aTable : ITblInfo) : ISab;

function MakeAllRecords(const aTable : ITblInfo) : ISab; overload;
function MakeAllRecords(const aPhoto : ISab) : ISab;     overload;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aFillBufferProc: TFillBufferProc
                      ) : ISab; overload;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aBuffer : Pointer;
                      aMaxNumOfElem : Integer) : ISab;     overload;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : Tl3ProtoPtrRecList) : ISab;     overload;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : Tl3LongintList) : ISab;     overload;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : Il3IDList) : ISab;     overload;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : DocumentIDListHelper) : ISab;     overload;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : Il3IntegerList) : ISab;     overload;


function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      const aStream: TStream) : ISab;     overload;
{* - грузит список значений в из Stream}

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      const aStream: Tk2RawData) : ISab;     overload;
{* - грузит список значений в из Stream}

procedure dtOutSabToStream(const aSab : ISAB; aStream : TStream); overload;
{* - выводит список значений в Stream}
procedure dtOutSabToStream(const aSab : ISAB; aStream : Tk2RawData); overload;
{* - выводит список значений в Stream}
procedure dtOutSabToStream(const aSab : ISAB; aStream : DocumentIDListHelper); overload;
{* - выводит список значений в Stream}

function MakeSabCopy(const aSab : ISab) : ISab;

function SamePhoto(const aSab1 : ISab; const aSab2 : ISab) : boolean;

function GetValueSAB(const aFullSAB : SAB; aFld : Word): SAB;

function dtCleanSab(var aSab : SAB) : SAB;
  {* - зачистка саба перед использованием}

procedure dtFreeSab(var aSab : SAB);
  {* - удаление данных  Sab`а}

function dtMakeSabCopy(const aSab : SAB) : SAB;
  {* - делает копию Sab`а}

function dtSortSab(var aSab : SAB) : SAB; overload;
function dtSortSab(var aSab : SAB; const aElemNum : array of Smallint) : SAB; overload;
 {* - сортирует саб, результаты возвращает в нем же}

function BuildSab(aFillBufferProc: TFillBufferProc;
                  const aTable: ITblInfo;
                  aFieldNum: Smallint): Sab;

function dtSABHasData(var aSAB: SAB) : Boolean;
 {* - проверка на наличие данных в aSAB}

function dtAndResults(var fpDst : SAB; var fpSrc1: SAB; var fpSrc2: SAB) : LPSAB;
 {* - Уточнение результата условием}

function dtOrResults(var fpDst : SAB; var fpSrc1: SAB; var fpSrc2: SAB) : LPSAB;
 {* - Расширение результата условием}

function dtXorResults(var fpDst : SAB; var fpSrc1: SAB; var fpSrc2: SAB) : LPSAB;
 {* - Исключение результата}

//function dtNotResults(var fpDst: SAB; var fpSrc: SAB):LPSAB;
 {* - Отрицание результата}

procedure dtCopyValuesSabToList(const aValuesSab : SAB; aList : Tl3LongintList); overload;
procedure dtCopyValuesSabToList(const aValuesSab : SAB; aList : Tl3CardinalList); overload;
procedure dtCopyValuesSabToList(const aValuesSab : SAB; aList : DocumentIDListHelper); overload;

procedure dtCopyValuesSabToList(const aValuesSab : ISab; aList : Tl3LongintList); overload;
procedure dtCopyValuesSabToList(const aValuesSab : ISab; aList : Il3IDList); overload;
procedure dtCopyValuesSabToList(const aValuesSab : ISab; aList : DocumentIDListHelper); overload;
 {* - копирует список значений в Tl3LongintList}

function dtMakeSortedIDListBySab(const aSab : ISAB): Il3IDList;
function dtMakeSortedLongListBySab(const aSab : ISAB): Tl3LongintList;

function dtMakeRecListBySab(const aSab : SAB;
                            const aFldArr : array of ThtField;
                            const aElemNum : array of Smallint): Tl3FieldSortRecList; overload;
 {* - копирует запись из заданных в aFldArr полей в Tl3FieldSortRecList}

function dtMakeRecListBySab(const aSab : SAB;
                            const aFldArr : array of ThtField): Tl3FieldSortRecList;     overload;
 {* - копирует запись из заданных в aFldArr полей в Tl3FieldSortRecList,
      сортировка по всем полям последовательно}

function dtMakeRecListBySab(const aSab : ISAB;
                            const aSortArr : array of Smallint): Tl3FieldSortRecList; overload;
{* - копирует запись из всех полей в Tl3FieldSortRecList}

function dtMakeRecListBySab(const aSab : ISAB;
                            const aFieldsArr : array of ThtField;
                            const aSortArr : array of Smallint): Tl3FieldSortRecList; overload;
 {* - копирует запись из заданных в aFldArr полей в Tl3FieldSortRecList}


function dtMakeRecListByJoinSab(const aSab : IJoinSAB;
                                const aFieldsArr : array of TJoinFieldRec;
                                const aSortArr : array of Smallint): Tl3FieldSortRecList;

//function dtMakeRecListBySab(aSab : ISAB;
//                            //const aFldArr : array of ThtField;
///                            const aElemNum : array of ThtField): Tl3FieldSortRecList; overload;
// {* - копирует запись из заданных в aFldArr полей в Tl3FieldSortRecList}


function JFRec(const aTable : ITblInfo; aField : ThtField) : TJoinFieldRec;

function MakeEmptyValueSab(const aPhoto : ISab; aField: SmallInt): ISab;

implementation
uses
 l3MinMax,
 l3Bits,
 l3MemorySizeUtils,

 HT_Dll,
 DT_Err, DT_Const,
 DT_Misc,
 Math,
 SysUtils,
 l3Stream
 ;

const
 cUndefItem = High(Cardinal);

//фабрики
function MakeSab(const aTable : ITblInfo; const aSab : Sab) : ISab; overload;
var
 lSab : TSab;
begin
 lSab := TSab.Make(aTable, @aSab);
 Result := lSab;
 l3Free(lSab);
end;

function MakeSab(const aTable : ITblInfo) : ISab; overload;
var
 lSab : TSab;
begin
 lSab := TSab.Make(aTable, nil);
 Result := lSab;
 l3Free(lSab);
end;

function MakeEmptyValueSab(const aPhoto : ISab; aField: SmallInt): ISab;
var
 lSab : TSab;
begin
 lSab := TSab.MakeEmptyValue(aPhoto, aField);
 Result := lSab;
 l3Free(lSab);
end;

function MakeJoinSab(const aSab1 : ISab; aJoinField1 : ThtField;
                     const aSab2 : ISab; aJoinField2 : ThtField;
                     aMode : SmallInt = Draft_Zero) : IJoinSab; overload;
var
 lSab : TJoinSab;
begin
 lSab := TJoinSab.MakeJoin(aSab1, aJoinField1, aSab2, aJoinField2, aMode);
 Result := lSab;
 l3Free(lSab);
end;

function MakeJoinSab(const aJoinSab1 : IJoinSab;
                     const aJoinSab2 : IJoinSab;
                     aSkipLink : boolean = false;
                     aMode : SmallInt = Draft_Zero) : IJoinSab; overload;
var
 lSab : TJoinSab;
begin
 lSab := TJoinSab.MakeJoin(aJoinSab1, aJoinSab2, aSkipLink, aMode);
 Result := lSab;
 l3Free(lSab);
end;

function MakePhoto(const aTable : ITblInfo) : ISab;
var
 l_Sab : TSab;
begin
 if aTable = nil then exit;
 l_Sab := TSab.MakePhotoOfTable(aTable);
 Result := l_Sab;
 l3Free(l_Sab);
end;

function MakeAllRecords(const aTable : ITblInfo) : ISab;
begin
 Result := MakeSab(aTable);
 Result.SelectAll;
end;

function MakeAllRecords(const aPhoto : ISab) : ISab;
begin
 Result := MakeEmptySab(aPhoto);
 Result.SelectAll(aPhoto);
end;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aFillBufferProc: TFillBufferProc) : ISab;
var
 lSab : TSab;
begin
 lSab := TSab.MakeValueSet(aTable, aField, aFillBufferProc);
 Result := lSab;
 l3Free(lSab);
end;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aBuffer : Pointer;
                      aMaxNumOfElem : Integer) : ISab;
var
 lSab : TSab;
begin
 lSab := TSab.MakeValueSet(aTable, aField, aBuffer, aMaxNumOfElem);
 Result := lSab;
 l3Free(lSab);
end;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : Tl3ProtoPtrRecList) : ISab;     overload;
var
 lSab : TSab;
begin
 if (aList <> nil) and (aList.Count > 0) then
 begin
  lSab := TSab.MakeValueSet(aTable, aField, aList.ItemSlot(0), aList.Count);
  Result := lSab;
  l3Free(lSab);
 end
 else
  Result := MakeEmptyValueSab(MakePhoto(aTable), aField);
end;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : Tl3LongintList) : ISab;     overload;
var
 lSab : TSab;
begin
 if (aList <> nil) and (aList.Count > 0) then
 begin
  lSab := TSab.MakeValueSet(aTable, aField, aList.ItemSlot(0), aList.Count);
  Result := lSab;
  l3Free(lSab);
 end
 else
  Result := MakeEmptyValueSab(MakePhoto(aTable), aField);
end;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : Il3IDList) : ISab;     overload;
begin
 Result := MakeValueSet(aTable, aField, aList.GetSelf);
end;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : DocumentIDListHelper) : ISab;
var
 l_List : Tl3LongintList;
 l_Index : Integer;
begin
 l_List := Tl3LongintList.Create;
 try
  for l_Index := 0 to Pred(aList.Count) do
   l_List.Add(aList.Items[l_Index]);
  Result := MakeValueSet(aTable, aField, l_List);
 finally
  FreeAndNil(l_List);
 end;//try..finally
end;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      aList : Il3IntegerList) : ISab;     overload;
var
 lSab : TSab;
 lVSF : TValueSetFiller;
 I    : Integer;
 lInt : Integer;
begin
 lSab := TSab.MakeEmptyValue(MakePhoto(aTable), aField);
 try
  if (aList <> nil) and (aList.Count > 0) then
  begin
   lVSF := TValueSetFiller.Create(lSab);
   try
    for I := 0 to pred(aList.Count) do
    begin
     lInt := aList.Items[I];
     lVSF.AddValue(lInt);
    end;
   finally
    l3Free(lVSF);
   end;
  end;

  Result := lSab;
 finally
  l3Free(lSab);
 end;
end;

function MakeValueSet(const aTable : ITblInfo; aField : ThtField; const aStream : TStream) : ISab; overload;

 function lFillBufferProc(aBuffer: Pointer; aBufSize: Longint): Longint; register;
 begin
  Result := aStream.Read(aBuffer^, aBufSize);
 end;

var
 lSab : TSab;
 lFillBufferProcStub : TFillBufferProc;
begin
 lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
 try
  lSab := TSab.MakeValueSet(aTable, aField, lFillBufferProcStub);
 finally
  FreeFillBufferProc(lFillBufferProcStub);
 end;

 Result := lSab;
 l3Free(lSab);
end;

function MakeSabCopy(const aSab : ISab) : ISab;
var
 lIsOpened : Boolean;
begin
 lIsOpened := aSab.IsOpened;
 if lIsOpened then
  aSab.CloseSab;

 Result := MakeSab(aSab.Table, aSab.HTSab);

 if lIsOpened then
  aSab.OpenSab;
end;

function SamePhoto(const aSab1 : ISab; const aSab2 : ISab) : boolean;
begin
 if aSab1 = aSab2 then
 begin
  Result := True;
  exit;
 end;

 if (aSab1 = nil) or (aSab2 = nil) then
 begin
  Result := False;
  exit;
 end;

 Result := (aSab1.Table = aSab2.Table) and (aSab1.Age = aSab2.Age);
end;

function GetValueSAB(const aFullSAB : SAB; aFld : Word): SAB;
begin
 l3FillChar(Result, SizeOf(SAB));
 htValuesOfKey(Result, aFld, aFullSAB);
end;

function dtSyncResults(
      Var fpFresh : SAB;    (* Блок для приема "свежего" результата *)
      Var fpPhoto : SAB;    (* Блок с заданным снимком *)
      Var fpOld   : SAB     (* Блок со старым результатом  *)
  ):LPSAB;{$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
begin
 if htResultsType(fpOld) = RES_RECORD then
  Result := htSyncResults(fpFresh, fpPhoto, fpOld)
 else
 begin
  Ht(htCopyResults(fpFresh, fpOld));
  Result := @fpFresh;
 end;

end;

(*
// не использовалась, не проверялась
function dtSyncResult(var fpSrc1: SAB; var fpSrc2: SAB): Boolean;
//только для RES_REC
var
 lFreshSab : Sab;
 lInvert : Boolean;
begin
 lInvert := False;
 // способ определить кто свежее
 //if htGetDiffLength(fpSrc1) < htGetDiffLength(fpSrc2) then

 if htSyncResults(lFreshSab, fpSrc1, fpSrc2) = nil then
  if lFreshSab.nRetCode = HT_ERR_OLD_OPERAND then //не в том порядке подали
  begin
   lInvert := True;
   htSyncResults(lFreshSab, fpSrc2, fpSrc1);
  end;

 Result := lFreshSab.nRetCode;

 if Result = 0 then
  if lInvert then
  begin
   htClearResults(fpSrc1);
   fpSrc1 := lFreshSab;
  end
  else
  begin
   htClearResults(fpSrc2);
   fpSrc2 := lFreshSab;
  end
end;
*)


{TSab}
constructor TSab.Create;
begin
 Inherited Create;
 l3FillChar(fSab, SizeOf(SAB));
end;

procedure TSab.Cleanup;
begin
 Assert(fSabCursor = nil, 'fSabCursor не уничтожился'); // невероятная ситуация, т к SabCursor держит ссылку на Sab и должен убиться раньше
 Clear;
 fTable := nil;
 Inherited;
end;

constructor TSab.Make(const aTable : ITblInfo; aSab : PSab);
begin
 Create;
 fTable := aTable;
 if (aSab <> nil) and (htResultsType(aSab^) <> Res_NProc) then
  Ht(htCopyResults(fSab, aSab^));
end;

constructor TSab.MakeValueSet(const aTable : ITblInfo;
                              aField : ThtField;
                              aFillBufferProc: TFillBufferProc);
begin
 Create;
 fTable := aTable;
 BuildValueSet(aField, aFillBufferProc);
end;

constructor TSab.MakeValueSet(const aTable : ITblInfo;
                              aField : ThtField;
                              aBuffer : Pointer;
                              aMaxNumOfElem : Integer);
const
 c_MaxBufLen = MAX_BUF_LEN;

var
 l_ValuesSab  : Sab;
 lAddCount    : Integer; // количество уже добавленных
 lElemSize    : Integer;
 lPartCount   : Integer; //элементов в порции
begin
 lAddCount := 0;
 lElemSize := aTable.fldLength[aField];
 lPartCount := (c_MaxBufLen div lElemSize);

 Create;
 fTable := aTable;
 htCreateEmptySAB(nil, l_ValuesSab, fTable.Handle, aField, Res_Value);
 try
  Ht(htOpenResults(l_ValuesSab, ROPEN_READ, nil, 0));
  try
   while lAddCount < aMaxNumOfElem do
   begin
    Ht(htIncludeResultsBlock(l_ValuesSab,
                             lAddCount,
                             PChar(aBuffer) + lAddCount * lElemSize,
                             Min(lPartCount, aMaxNumOfElem - lAddCount) * lElemSize));
    Inc(lAddCount, lPartCount); // последний шаг может быть меньше, но нам только конец отследить
   end;
  finally
   htCloseResults(l_ValuesSab);
  end;
  //Clear;
  Ht(htSortResults(fSab, l_ValuesSab, 0, 0));
 finally
  htClearResults(l_ValuesSab);
 end;

end;

function TSab.MakeValueSetFiller(aField : ThtField; const aPhoto : ISab = nil) : IValueSetFiller;
var
 lSab : PSab;
 lVSF : TValueSetFiller;
begin
 Clear;
 if aPhoto = nil then
  lSab := nil
 else
  lSab := aPhoto.HTSabAddr;

 htCreateEmptySAB(lSab, fSab, fTable.Handle, aField, Res_Value);
 lVSF := TValueSetFiller.Create(Self);
 Result := lVSF;
 l3Free(lVSF);
end;

procedure TSab.BuildValueSet(aField : ThtField;
                            aFillBufferProc: TFillBufferProc);

const
 c_MaxBufLen = MAX_BUF_LEN;
var
 l_FieldLen   : Integer;
 l_Buf        : Pointer;
 l_Buffer     : array[0..pred(MAX_BUF_LEN)] of byte;
 l_BytesInBuf : Cardinal;
 l_IncludePos : Integer;
 l_ValuesSab  : Sab;
begin
 htCreateEmptySAB(nil, l_ValuesSab, fTable.Handle, aField, Res_Value);
 try
  // наполнение
  l_FieldLen := fTable.fldLength[aField];
  {l_BytesInBuf := (c_MaxBufLen div l_FieldLen) * l_FieldLen;
  if aMaxNumOfElem <> 0 then
   l_BytesInBuf :=  Min(l_FieldLen * aMaxNumOfElem, l_BytesInBuf);}

   l_Buf := @l_Buffer;
   Ht(htOpenResults(l_ValuesSab, ROPEN_READ, nil, 0));
   try
    l_IncludePos := 0;
    while True do
    begin
     l_BytesInBuf := aFillBufferProc(l_Buf, c_MaxBufLen);
     if l_BytesInBuf = 0 then
      Break;

     Ht(htIncludeResultsBlock(l_ValuesSab,
                              l_IncludePos,
                              l_Buf,
                              l_BytesInBuf));

     l_IncludePos := l_IncludePos + (l_BytesInBuf div l_FieldLen);
    end; // while
   finally
    htCloseResults(l_ValuesSab);
   end;
 // сортировка
  Clear;
  Ht(htSortResults(fSab, l_ValuesSab, @aField, 1));
 finally
  htClearResults(l_ValuesSab);
 end;
end;

function TSab.MakeSabCursor(const aFields :  array of ThtField;
                             aCacheMethod : TCacheMethod = cmForward;
                             aOpenMode : SmallInt = ROPEN_BODY) : ISabCursor;
var
 lSabCursor : TSabCursor;
begin
 Assert(fSabCursor = nil, 'fSabCursor уже создан');
 lSabCursor := TSabCursor.Make(Self, aFields, aCacheMethod, aOpenMode);
 Result := lSabCursor;
 l3Free(lSabCursor);
end;

procedure TSab.RecFilter(aCheckRecProc : Pointer);
var
 I : Integer;
 lSabCopy : Sab;
 lRecNo   : Integer;
 lRecBuf  : Pointer;
 lBufLen  : Integer;
begin
 Ht(htCopyResults(lSabCopy, fSab));

 lBufLen := fTable.RecSize + SizeOf(LongWord);
 l3System.GetLocalMem(lRecBuf, lBufLen);
 try
  Ht(htOpenResults(lSabCopy, ROPEN_READ, Nil, 0));
  Ht(htOpenResults(fSab, ROPEN_READ, Nil, 0));
  try
   for I := 0 to Pred(Count) do
   begin
    htReadResults(lSabCopy, lRecBuf, lBufLen);
    if CFUNC(aCheckRecProc)(PChar(lRecBuf) + SizeOf(LongWord), nil) = CFUNC_FALSE then
    begin
     lRecNo := PInteger(lRecBuf)^;
     htExcludeResultsItem(fSab, lRecNo);
    end;
   end;
  finally
   htCloseResults(fSab);
   htCloseResults(lSabCopy);
   htClearResults(lSabCopy);
  end;
 finally
  l3System.FreeLocalMem(lRecBuf);
 end;
end;

constructor TSab.MakeEmpty(const aPhoto : ISab);
var
 lSab : Sab;
begin
 Create;
 fTable := aPhoto.Table;
 lSab := aPhoto.HTSab;
 htCreateEmptySAB(@lSab, fSab, fTable.Handle, 0, RES_RECORD);
end;

constructor TSab.MakeEmpty(const aTable : ITblInfo);
begin
 Create;
 fTable := aTable;
 htCreateEmptySAB(nil, fSab, fTable.Handle, 0, RES_RECORD);
end;

constructor TSab.MakeEmptyValue(const aPhoto : ISab; aField: SmallInt);
var
 lSab : Sab;
begin
 Create;
 fTable := aPhoto.Table;
 lSab := aPhoto.HTSab;
 htCreateEmptySAB(@lSab, fSab, fTable.Handle, aField, RES_VALUE);
end;

constructor TSab.MakePhotoOfTable(const aTable : ITblInfo);
begin
 Create;
 fTable := aTable;
 htMakePhoto(fSab, fTable.Handle);
 f_IsPhoto := True;
end;

function TSab.Get_HTSab : Sab;
begin
 Result := fSab;
end;

function TSab.Get_Table : ITblInfo;
begin
 Result := fTable;
end;

function TSab.Get_HTSabAddr : PSab;
begin
 Result := @fSab;
end;

function TSab.Get_TypeOfSab : SmallInt;
begin
 if f_IsPhoto then
  Result := RES_PHOTO
 else
  Result := htResultsType(fSab);
end;

function TSab.Get_SizeOfItem : Cardinal;
var
 lIsOpened : Boolean;
begin
 lIsOpened := IsOpened;
 try
  if not lIsOpened then
   Ht(htOpenResults(fSab, ROPEN_BODY, nil, 0));

  try
   Ht(htResultsItemLen(fSab, Result));
  except
   Result := 0;
  end;

 finally
  if not lIsOpened then
   htCloseResults(fSab);
 end;
end;

function TSab.GetFieldSizeArray : TSmallIntArray;
begin
 Result := GetFieldSizeArray([]);
end;

function TSab.GetFieldSizeArray(const aFldArr : array of ThtField) : TSmallIntArray;
var
 lIsOpened : Boolean;
 I, J : Integer;
 lFldCount : Integer;
 lOPELArr : array of OPEL;

begin
 lIsOpened := IsOpened;
 try
  if not lIsOpened then
   if Length(aFldArr) = 0 then
    Ht(htOpenResults(fSab, ROPEN_BODY, nil, 0))
   else
    Ht(htOpenResults(fSab, ROPEN_BODY, @aFldArr[0], Length(aFldArr)));

  lFldCount := htResultsItemCnt(fSab);
  if lFldCount < 0 then
   HT(lFldCount);
  SetLength(lOPELArr, lFldCount);
  SetLength(Result, lFldCount);
  htResultsItemParm(fSab, @lOPELArr[0]);
  // дело в том, что htResultsItemParm возвращает результат не в том порядке полей, в котором они были переданы
  // изначально, поэтому приходится искать соответствие с помощью поля nNum записи

  if Length(aFldArr) > 0 then
  begin
   for I := 0 to Pred(lFldCount) do
   begin
    Result[I] := 0;
    for J := 0 to Pred(lFldCount) do
     if lOPELArr[J].nNum = aFldArr[I] then
     begin
      Result[I] := lOPELArr[J].wLen;
      Break;
     end;
    Assert(Result[I] <> 0);
   end;
  end
  else // список полей не задан, просто возвращаем как есть
  begin
   for I := 0 to Pred(lFldCount) do
    Result[I] := lOPELArr[I].wLen;
  end;
 finally
  if not lIsOpened then
   htCloseResults(fSab);
 end;
end;

procedure TSab.SetSabCursor(aSabCursor : TSabCursor);
begin
 fSabCursor := aSabCursor;
end;

procedure TSab.Clear;
begin
 if not f_IsPhoto then
  htClearResults(fSab);
end;

procedure TSab.Refresh;
var
 lSab      : Sab;
 lIsOpened : Boolean;
 lField    : ThtField;
begin
 lIsOpened := IsOpened;
 try
  if lIsOpened then
   CloseSab;

  if IsValid then
   if (TypeOfSab = RES_VALUE) then
   begin
    htResultsElement(fSab, lField);
    lSab := fTable.PhotoOfTable;
    HT(htTransferToPhoto(fSab, lSab, lField)^.nRetCode);
   end
   else
   begin
    htTouchResults(lSab, fSab);
    Ht(lSab.nRetCode);
    Clear;
    fSab := lSab;
   end;

 finally
  if lIsOpened then
   OpenSab;
 end;
end;

function TSab.IsEmpty : Boolean;
begin
 Result := (htResultsType(fSab) = Res_NProc) or (fSab.gFoundCnt = 0);
end;

function TSab.IsValid : Boolean;
begin
 Result := (Self <> nil) and (htResultsType(fSab) <> Res_NProc);
end;

function TSab.Count : Integer;
begin
 if IsValid then
  Result := fSab.gFoundCnt
 else
  Result := 0;
end;

procedure TSab.RecordsByKey(aKeyFld : ThtField; const aPhoto : ISab = nil);
var
 lSab : Sab;
begin
 TransferToPhoto(aKeyFld, aPhoto);
 RecordsByKey;
end;

procedure TSab.RecordsByKey;
var
 lSab : Sab;
begin
 Assert(TypeOfSab = RES_VALUE, 'RecordsByKey: Неверный тип SAB');

 //Sort;
 HT(htRecordsByKey(lSab, fSab)^.nRetCode);
 Clear;
 fSab := lSab;
end;

procedure TSab.ValuesOfKey(aKeyFld : ThtField);
var
 lSab : Sab;
begin
 if IsValid then
 begin
  if (TypeOfSab = RES_VALUE) then
   RecordsByKey
  else
   Unsort;
  htValuesOfKey(lSab, aKeyFld, fSab);
 end;
 Ht(lSab.nRetCode);

 Clear;
 fSab := lSab;
end;

procedure TSab.ValuesOfKeyByCount(aKeyFld : ThtField; aMinRepeat : Longint = 2);
var
 lSab : Sab;
begin
 if IsValid then
 begin
  if (TypeOfSab = RES_VALUE) then
   RecordsByKey
  else
   Unsort;

  htValuesByCount(lSab, aKeyFld, fSab, aMinRepeat, High(Longint));
 end;
 Ht(lSab.nRetCode);

 Clear;
 fSab := lSab;
end;

procedure TSab.TransferToPhoto(aKeyFld : ThtField; const aPhoto : ISab = nil);
var
 lSab : Sab;
begin
 Assert(TypeOfSab = RES_VALUE, 'TSab.TransferToPhoto: Неверный тип SAB');
 if aPhoto = nil then
  htTransferToTable(fSab, fTable.Handle, aKeyFld)
 else
 begin
  fTable := aPhoto.Table;
  lSab := aPhoto.HTSab;
  htTransferToPhoto(fSab, lSab, aKeyFld);
 end;
end;

procedure TSab.TransferToPhoto(const aPhoto : ISab);
var
 lKeyFld : ThtField;
 lSab : Sab;
begin
 lSab := aPhoto.HTSab;
 Ht(htResultsElement(lSab, lKeyFld));
 TransferToPhoto(lKeyFld, aPhoto);
end;

procedure TSab.TransferToPhoto(aKeyFld : ThtField; const aTable : ITblInfo);
begin
 TransferToPhoto(aKeyFld, MakePhoto(aTable));
end;

procedure TSab.SyncWith(const aPhoto : ISab);
//только для RES_REC
var
 lSab : Sab;
 lPhoto : Sab;
begin
 if TypeOfSab <> RES_RECORD then Exit;
 //Assert(TypeOfSab = RES_RECORD, 'TSab.SyncWith: Неверный тип SAB');

 lPhoto := aPhoto.HTSab;
 htSyncResults(lSab, lPhoto, fSab);

 HT(lSab.nRetCode);

 Clear;
 fSab := lSab;
end;

procedure TSab.SyncWithExt(var aAnotherSab : ISab); // синхронизирует в обе стороны, если aAnotherSab окажется старше с него снимем копию и освежим
var
 lAgeDif : Int64;
begin
 lAgeDif := Age - aAnotherSab.Age;
 if lAgeDif = 0 then
 begin
  //if cNeedTrace42err then l3System.Msg2Log('SyncWithExt : EQ');
  Exit;
 end
 else
 begin
  if cNeedTrace42err then l3System.Msg2Log('SyncWithExt : %d - %d', [Age, aAnotherSab.Age]);
  if lAgeDif > 0 then // мы свежее
  begin
   aAnotherSab := MakeSabCopy(aAnotherSab);
   aAnotherSab.SyncWith(ISab(Self));
  end
  else
   SyncWith(aAnotherSab);
  if cNeedTrace42err then l3System.Msg2Log('SyncWithExt aftersync: %d - %d', [Age, aAnotherSab.Age]);
 end;
end;

function TSab.Age : Int64;
begin
 htGetDiffLength(fSab, Result);
end;

procedure TSab.Select(aElemNum : ThtField; const aValue; aCond : ThtCondition = EQUAL; const aPhoto : ISab = nil);
var
 lPhoto : Sab;
 lPhotoAddr : PSab;
begin
 Clear;

 if aPhoto <> nil then
 begin
  lPhoto := aPhoto.HTSab;
  lPhotoAddr := @lPhoto;
 end
 else
  lPhotoAddr := Nil;

 if htSearch(lPhotoAddr, fSab, fTable.Handle, aElemNum, aCond, @aValue, nil) = nil then
  HT(fSab.nRetCode);
end;

procedure TSab.Select(aElemNum : ThtField; const aLoValue; const aHiValue; const aPhoto : ISab = nil);
var
 lPhoto : Sab;
 lPhotoAddr : PSab;
begin
 Clear;

 if aPhoto <> nil then
 begin
  lPhoto := aPhoto.HTSab;
  lPhotoAddr := @lPhoto;
 end
 else
  lPhotoAddr := Nil;

 if htSearch(lPhotoAddr, fSab, fTable.Handle, aElemNum, IN_RANGE, @aLoValue, @aHiValue) = nil then
  HT(fSab.nRetCode);
end;

procedure TSab.SelectByMask(aElemNum : ThtField; aMask : Integer; const  aPhoto : ISab = nil);
var
 lSab : ISab;
begin
 // !! проверить тип aElemNum
 SelectAll(aPhoto);
 lSab := InternalGetMaskSab(aElemNum, aMask);

 Clear;
 fSab := lSab.ExtractHTSab;
end;

procedure TSab.SubSelectByMask(aElemNum : ThtField; aMask : Integer);
var
 lSab : ISab;
begin
 // !! проверить тип aElemNum
 if IsEmpty then Exit;

 lSab := InternalGetMaskSab(aElemNum, aMask);

 AndSab(lSab);
end;

function TSab.InternalGetMaskSab(aElemNum : ThtField; aMask : Integer) : ISab;
var
 lVSFiller : IValueSetFiller;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  if l3TestMask(PInteger(aItemPtr)^, aMask) then
   lVSFiller.AddValue(PInteger(aItemPtr)^);
 end;

var
 lValues     : ISab;
 lRAProcStub : TdtRecAccessProc;

begin
 lValues := MakeSabCopy(Self);
 lValues.ValuesOfKey(aElemNum);

 // фильтрация
 Result := MakeEmptySab(lValues);
 lVSFiller := Result.MakeValueSetFiller(aElemNum);

 lRAProcStub := L2RecAccessProc(@lRecAccessProc);
 try
  lValues.IterateRecords(lRAProcStub);
 finally
  FreeRecAccessProc(lRAProcStub);
 end;
 lVSFiller := nil;  // сброс кеша в SAB

 Result.RecordsByKey;
end;

procedure TSab.SelectAll(const aPhoto : ISab = nil);
begin
 Select(AbsNumFld, Zero, GREAT, aPhoto);
end;

procedure TSab.SubSelect(aElemNum : ThtField; const aValue; aCond : ThtCondition = EQUAL);
var
 lSab : Sab;
begin
 if (fSab.gFoundCnt = 0) then Exit;
 if htSubSearch(fSab, lSab, fTable.Handle, aElemNum, aCond, @aValue, nil) = nil then
  HT(lSab.nRetCode);
 Clear;
 fSab := lSab;
end;

procedure TSab.SubSelect(aElemNum : ThtField; const aLoValue; const aHiValue);
var
 lSab : Sab;
begin
 if (fSab.gFoundCnt = 0) then Exit;
 if htSubSearch(fSab, lSab, fTable.Handle, aElemNum, IN_RANGE, @aLoValue, @aHiValue) = nil then
  HT(lSab.nRetCode);
 Clear;
 fSab := lSab;
end;

procedure TSab.AddSelect(aElemNum : ThtField; const aValue; aCond : ThtCondition = EQUAL);
var
 lSab : Sab;
 lSab2 : Sab;
begin
 if htSearch(@fSab {as photo}, lSab, fTable.Handle, aElemNum, aCond, @aValue, nil) = nil then
  HT(lSab.nRetCode);

 if (lSab.gFoundCnt = 0) then Exit;

 if IsEmpty then
 begin
  Clear;
  fSab := lSab;
 end
 else
 begin
  if htOrResults(lSab2, fSab, lSab) = nil then
   HT(lSab2.nRetCode);
  htClearResults(lSab);
  Clear;
  fSab := lSab2;
 end;
end;

procedure TSab.AddSelect(aElemNum : ThtField; const aLoValue; const aHiValue);
var
 lSab : Sab;
 lSab2 : Sab;
begin
 if htSearch(@fSab {as photo}, lSab, fTable.Handle, aElemNum, IN_RANGE, @aLoValue, @aHiValue) = nil then
  HT(lSab.nRetCode);

 if (lSab.gFoundCnt = 0) then Exit;

 if IsEmpty then
 begin
  Clear;
  fSab := lSab;
 end
 else
 begin
  if htOrResults(lSab2, fSab, lSab) = nil then
   HT(lSab2.nRetCode);
  htClearResults(lSab);
  Clear;
  fSab := lSab2;
 end;
end;

procedure TSab.SubSelectTwoFldEq(aElemNum1 : ThtField; aElemNum2 : ThtField);
var
 lSab : Sab;
begin
 if htRecordsForTwoKeys(lSab, fSab, aElemNum1, EQUAL, aElemNum2) = nil then
  HT(lSab.nRetCode);
 Clear;
 fSab := lSab;
end;

procedure TSab.Histogram(aElemNum : ThtField; aMinRepeat : Longint = 2);
var
 lSab : Sab;
begin
 HT(htHistogramByCount(lSab, aElemNum, fSab, aMinRepeat, High(Longint)));
 Clear;
 fSab := lSab;
end;

procedure TSab.DeleteFromTable;
begin
 if not IsEmpty then
  HT(htDeleteRecords(fSab));
end;

procedure TSab.Distinct(const aElemNum : array of ThtField);
var
 lSab : Sab;
 lIsOpened : Boolean;
begin
 Assert(TypeOfSab <> RES_VALUE, 'TSab.Distinct: Неверный тип SAB');

 lIsOpened := IsOpened;
 try
  if lIsOpened then
   CloseSab;

  HT(htDistinctResults(lSab, fSab, @aElemNum[0], Length(aElemNum)));

  Clear;
  fSab := lSab;
 finally
  if lIsOpened then
   OpenSab;
 end;
end;

procedure TSab.Sort(const aElemNum : array of ThtField);
var
 lSab : Sab;
 lIsOpened : Boolean;
begin
 Assert(TypeOfSab <> RES_VALUE, 'TSab.Sort: Неверный тип SAB');

 lIsOpened := IsOpened;
 try
  if lIsOpened then
   CloseSab;

  HT(htSortResults(lSab, fSab, @aElemNum[0], Length(aElemNum)));

  Clear;
  fSab := lSab;
 finally
  if lIsOpened then
   OpenSab;
 end;
end;

 //function gUserSortProc(aValue1 : Pointer; aValue2 : Pointer; aUserParam : Pointer) : Integer; stdcall;
 //var
 // lSortProc : TUserSortProc absolute aUserParam;
 //begin
 // Result := lSortProc(aValue1, aValue2);
 //end;

procedure TSab.Sort(aSortProc : TUserSortProc; const aElemNum : array of ThtField);

//  Пример использования
//  procedure TSome.Sort;
//   function lUserSortProc(aValue1 : Pointer; aValue2 : Pointer; aUserParam : Pointer) : Integer;
//   begin
//    Result := l3Compare(l3PCharLen(PChar(aValue1), 1000), l3PCharLen(PChar(aValue2), 1000));
//   end;

//  var
//   lSortProc   : TUserSortProc;

//  begin
//   lSortFields := MakeJoinFieldArray([JFRec(lMainTbl, fFName_Fld)]);
//   lSortProc := L2UserSortProc(@lUserSortProc);
//   try
//    fSabCursor.Sort(lSortProc, lSortFields);
//   finally
//    FreeUserSortProc(lSortProc);
//   end;
//  end;

 function lUserSortProc(aValue1 : Pointer; aValue2 : Pointer{; aUserParam : Pointer}) : Integer;
 begin
  Result := aSortProc(aValue1, aValue2);
 end;

var
 lSab : Sab;
 lIsOpened : Boolean;
 lNothing  : Pointer; //nothing
 x : LPOFUNC absolute aSortProc;
 lHTStub : Pointer;
 l_len : Integer;
 l_Head  : Pointer;
 lElemNum : array[0..1] of integer;
begin
 Assert(TypeOfSab <> RES_VALUE, 'TSab.Sort: Неверный тип SAB');

 lIsOpened := IsOpened;
 try
  if lIsOpened then
   CloseSab;

  l_Len := Length(aElemNum);
  l_Head := @aElemNum[0];

  //HT(htSortResultsByUser(lSab, fSab, l_Head, l_len, @gUserSortProc, x));

  lHTStub := HTStub3(@lUserSortProc);
  try
   HT(htSortResultsByUser(lSab, fSab, l_Head, l_len, lHTStub, nil{self}));
  finally
   HTStubFree(lHTStub);
  end;

  Clear;
  fSab := lSab;
 finally
  if lIsOpened then
   OpenSab;
 end;
end;

(*procedure TSab.SelectUserDefined(aElemNum : ThtField; const aUserSearchProc: TdtRecAccessProc; const  aPhoto : ISab = nil);
var
 lHTStub : Pointer;
 lPhoto  : Sab;
 lPhotoAddr : PSab;

 function lFilterProc(aValue: Pointer; fpUser: Pointer) : CFUNC_RET;
 begin
  Result := BoolToCFUNC_RET[aUserSearchProc(aValue)];
 end;

begin
 if aPhoto <> nil then
 begin
  lPhoto := aPhoto.HTSab;
  lPhotoAddr := @lPhoto;
 end
 else
  lPhotoAddr := Nil;

 lHTStub := HTStub2(@lFilterProc);
 try
  if htSearch(lPhotoAddr, fSab, fTable.Handle, aElemNum, USER_DEF, lHTStub, nil) = nil then
   HT(fSab.nRetCode);
 finally
  HTStubFree(lHTStub);
 end;
end;*)


procedure TSab.Sort;
var
 lSab : Sab;
 lIsOpened : Boolean;
begin
 Assert(TypeOfSab = RES_VALUE, 'TSab.Sort: Неверный тип SAB');

 lIsOpened := IsOpened;
 try
  if lIsOpened then
   CloseSab;

  HT(htSortResults(lSab, fSab, nil, 0));
  Clear;
  fSab := lSab;

 finally
  if lIsOpened then
   OpenSab;
 end;
end;

procedure TSab.UnSort;
var
 lSab : Sab;
 lIsOpened : Boolean;
begin
 if TypeOfSab <> RES_SORTED then Exit;

 lIsOpened := IsOpened;
 try
  if lIsOpened then
   CloseSab;

  htSortedRecords(lSab, fSab);
  Clear;
  fSab := lSab;

 finally
  if lIsOpened then
   OpenSab;
 end;
end;

procedure TSab.InvertSab;
var
 lSab : Sab;
begin
 htNotResults(lSab, fSab);
 Clear;
 fSab := lSab;
end;

procedure TSab.AndSab(const aSab: ISab);
var
 lSab : Sab;
 laSabHT : Sab;
 laSab : ISab;

begin
 if IsEmpty or aSab.IsEmpty then
  htCreateEmptySAB(@fSab, lSab, fTable.Handle, 0, TypeOfSab)
 else
 begin
  laSab := MakeSabCopy(aSab);

  if TypeOfSab = RES_VALUE then
   laSab.TransferToPhoto(Self)
  else
   SyncWithExt(laSab);

  laSabHT := laSab.HTSab;
  if htAndResults(lSab, fSab, laSabHT) = nil then
  begin
   if cNeedTrace42err and (lSab.nRetCode = -42) then l3System.Msg2Log('TSab.AndSab: %d - %d', [Age, laSab.Age]);
   HT(lSab.nRetCode);
  end;
 end;
 Clear;
 fSab := lSab;
end;

procedure TSab.OrSab(const aSab: ISab);
var
 lSab : Sab;
 laSabHT : Sab;
 laSab : ISab;
begin
 if aSab.IsEmpty then Exit;

 if IsEmpty then
 begin
  Clear;
  laSabHT := aSab.HTSab;
  Ht(htCopyResults(lSab, laSabHT));
 end
 else
 begin
  laSab := MakeSabCopy(aSab);

  if TypeOfSab = RES_VALUE then
   laSab.TransferToPhoto(Self)
  else
   SyncWithExt(laSab);

  laSabHT := laSab.HTSab;

  if htOrResults(lSab, fSab, laSabHT) = nil then
   HT(lSab.nRetCode);
 end;

 Clear;
 fSab := lSab;
end;

procedure TSab.SubtractSab(const aSab: ISab);
var
 lSab : Sab;
 laSabHT : Sab;
 laSab : ISab;
 lSab2 : Sab;

begin
 if IsEmpty or aSab.IsEmpty then Exit;

 laSab := MakeSabCopy(aSab);

 if TypeOfSab = RES_VALUE then
  laSab.TransferToPhoto(Self)
 else
  SyncWithExt(laSab);

 laSabHT := laSab.HTSab;


{$IFDEF HT_NEWDLL}
 if TypeOfSab = RES_RECORD then
 begin
  htExcludeResults(lSab, fSab, laSabHT);
  //if htExcludeResults(lSab, fSab, laSabHT) <> nil then
  HT(lSab.nRetCode);
 end
 else
 begin
{$endif}
  //lSab = fSab - laSabHT =  fSab xor (fSab and laSabHT);

  if htAndResults(lSab2, fSab, laSabHT) = nil then
   HT(lSab2.nRetCode);
  try
   if htXorResults(lSab, fSab, lSab2) = nil then
    HT(lSab.nRetCode);
  finally
   htClearResults(lSab2);
  end;
{$IFDEF HT_NEWDLL}
 end;
{$endif}

 Clear;
 fSab := lSab;
end;

function TSab.GetMaxValue(aElemNum : ThtField) : Longint;
begin
 Assert(Table.FldLength[aElemNum] <= SizeOf(Result));

 Result := 0;
 htKeyMaximum(fSab, aElemNum, @Result);
 HT(fSab.nRetCode);
end;

function TSab.GetMinValue(aElemNum : ThtField) : Longint;
begin
 Assert(Table.FldLength[aElemNum] <= SizeOf(Result));

 Result := 0;
 htKeyMinimum(fSab, aElemNum, @Result);
 HT(fSab.nRetCode);
end;

procedure TSab.Flush;
begin
 htResultsToHard(fSab);
end;

procedure TSab.ModifyRecs(aModifyProc : Pointer; aDupIgnore : Boolean = False);
begin
 Assert(TypeOfSab in [RES_RECORD, RES_SORTED], 'TSab.ModifyRecs работает только для RES_RECORD');
 if not IsEmpty then
  (Table as IEditTbl).ModifyRecs(fSab, aModifyProc, aDupIgnore);
end;

procedure TSab.ModifyRecs(aField : ThtField; var aValue; aDupIgnore : Boolean = False);
begin
 Assert(TypeOfSab = RES_RECORD, 'TSab.ModifyRecs работает только для RES_RECORD');
 if not IsEmpty then
  (Table as IEditTbl).ModifyRecs(fSab, aField, @aValue, aDupIgnore);
end;

procedure TSab.IterateBlockOfRecords(aBlockProc : TdtBlockAccessProc);
begin
 Assert(TypeOfSab = RES_VALUE);
 IterateBlockOfRecords(aBlockProc, []);
end;

procedure TSab.IterateBlockOfRecords(aBlockProc : TdtBlockAccessProc; const aFldArr : array of ThtField);
var
 lBuffer: Pointer;
 lBufSize: Longint;
begin
 Assert(TypeOfSab <> Res_NProc);

 if Length(aFldArr) = 0 then
  Ht(htOpenResults(fSab, ROPEN_BODY, nil, 0))
 else
 Ht(htOpenResults(fSab, ROPEN_BODY, @aFldArr[0], Length(aFldArr)));
 try
  l3System.GetLocalMem(lBuffer, MAX_BUF_LEN);
  try
   while True do
   begin
    lBufSize := htReadResults(fSab, lBuffer, MAX_BUF_LEN);
    if lBufSize = 0 then Break;
    if lBufSize > MAX_BUF_LEN then
     HT(Smallint(lBufSize));

    if not aBlockProc(lBuffer, lBufSize) then Break;
   end;
  finally
   l3System.FreeLocalMem(lBuffer);
  end;
 finally
  htCloseResults(fSab);
 end;
end;

procedure TSab.CopyRecordsToBuffer(aBuffer : Pointer);
begin
 CopyRecordsToBuffer(aBuffer, []);
end;

procedure TSab.CopyRecordsToBuffer(aBuffer : Pointer; const aFldArr : array of ThtField);
var
 lItemSize     : Cardinal;
 lNumTotalRead : Cardinal;
 lMaxReadLen   : Cardinal;
 lFldArr       : TFieldArray;

begin
 if Length(aFldArr) = 0 then
  Ht(htOpenResults(fSab, ROPEN_BODY, nil, 0))
 else
 Ht(htOpenResults(fSab, ROPEN_BODY, @aFldArr[0], Length(aFldArr)));

 Ht(htResultsItemLen(fSab, lItemSize));
 lMaxReadLen := Min(MAX_BUF_LEN div lItemSize, Count) * lItemSize;
 try
  lNumTotalRead := 0;
  while lNumTotalRead < Count do
   Inc(lNumTotalRead, htReadResults(fSab, PChar(aBuffer) + lNumTotalRead * lItemSize, lMaxReadLen) div lItemSize);
 finally
  htCloseResults(fSab);
 end;
end;

procedure TSab.IterateRecords(aRecProc : TdtRecAccessProc);
begin
 Assert(TypeOfSab = RES_VALUE);
 IterateRecords(aRecProc, []);
end;

procedure TSab.IterateRecords(aRecProc : TdtRecAccessProc; const aFldArr : array of ThtField; aOpenMode : SmallInt = ROPEN_BODY);
var
 lItemSize     : Cardinal;
 I             : Cardinal;
 lBuffer       : PChar;
 lReadSize     : Word;
 lBreak        : boolean;
begin
 Assert(TypeOfSab <> Res_NProc);

 //if Length(aFldArr) = 0 then Exit;
 if Length(aFldArr) = 0 then
  Ht(htOpenResults(fSab, aOpenMode, nil, 0))
 else
  Ht(htOpenResults(fSab, aOpenMode, @aFldArr[0], Length(aFldArr)));

 try
  Ht(htResultsItemLen(fSab, lItemSize));
  l3System.GetLocalMem(lBuffer, MAX_BUF_LEN);
  try
   lBreak := false;
   while not lBreak do
   begin
    lReadSize := htReadResults(fSab, lBuffer, MAX_BUF_LEN);
    if lReadSize = 0 then Break;
    if lReadSize > MAX_BUF_LEN then
     HT(Smallint(lReadSize));
    for I := 0 to Pred(lReadSize div lItemSize) do
     if not aRecProc(lBuffer + I * lItemSize) then
     begin
      lBreak := True;
      Break;
     end;
   end;
  finally
   l3System.FreeLocalMem(lBuffer);
  end;
 finally
  htCloseResults(fSab);
 end;
end;

function TSab.IsOpened : Boolean;
begin
 Result := htIsResultOpen(fSab);
end;

procedure TSab.OpenSab;
begin
 if fSabCursor <> nil then
  fSabCursor.OpenSab;
end;

procedure TSab.CloseSab;
begin
 if fSabCursor <> nil then
  fSabCursor.CloseSab;
end;

function TSab.ExtractHTSab : Sab;
begin
 Result := fSab;
 l3ZeroMemory(@fSab, SizeOf(SAB));
end;

procedure TSab.XorSab(const aSab: ISab);
var
 lSab : Sab;
 lSab2 : Sab;
 lSyncSub : Sab;
begin
 if aSab.IsEmpty then Exit;

 if IsEmpty then
 begin
  Clear;
  lSab2 := aSab.HTSab;
  Ht(htCopyResults(fSab, lSab2));
 end
 else
 begin
  lSab2 := aSab.HTSab;
  if dtSyncResults(lSyncSub, fSab, lSab2) = nil then
   HT(lSyncSub.nRetCode);
  try
   if htXorResults(lSab, fSab, lSyncSub) = nil then
    HT(lSab.nRetCode);
  finally
   htClearResults(lSyncSub);
  end;

  Clear;
  fSab := lSab;
 end;
end;

procedure TSab.SelectUserDefined(aElemNum : ThtField; const aUserSearchProc: TdtRecAccessProc; const  aPhoto : ISab = nil);
var
 lHTStub : Pointer;
 lPhoto  : Sab;
 lPhotoAddr : PSab;

 function lFilterProc(aValue: Pointer; fpUser: Pointer) : CFUNC_RET;
 begin
  Result := BoolToCFUNC_RET[aUserSearchProc(aValue)];
 end;

begin
 if aPhoto <> nil then
 begin
  lPhoto := aPhoto.HTSab;
  lPhotoAddr := @lPhoto;
 end
 else
  lPhotoAddr := Nil;

 lHTStub := HTStub2(@lFilterProc);
 try
  if htSearch(lPhotoAddr, fSab, fTable.Handle, aElemNum, USER_DEF, lHTStub, nil) = nil then
   HT(fSab.nRetCode);
 finally
  HTStubFree(lHTStub);
 end;
end;

procedure TSab.SubSelectUserDefined(aElemNum : ThtField; const aUserSearchProc: TdtRecAccessProc);
var
 lHTStub : Pointer;
 lSab : Sab;

 function lFilterProc(aValue: Pointer; fpUser: Pointer) : CFUNC_RET;
 begin
  Result := BoolToCFUNC_RET[aUserSearchProc(aValue)];
 end;

begin
 if (fSab.gFoundCnt = 0) then Exit;

 lHTStub := HTStub2(@lFilterProc);
 try
  if htSubSearch(fSab, lSab, fTable.Handle, aElemNum, USER_DEF, lHTStub, nil) = nil then
   HT(fSab.nRetCode);
 finally
  HTStubFree(lHTStub);
 end;
 Clear;
 fSab := lSab;
end;

{TJoinSab}
constructor TJoinSab.MakeJoin(aSab1 : ISab; aJoinField1 : ThtField;
                              aSab2 : ISab; aJoinField2 : ThtField;
                              aMode : SmallInt = Draft_Zero);
var
 lSab1 : Sab;
 lSab2 : Sab;
begin
 //SetLength(fTables, 2);
 //fTables[0] := aSab1.Table;
 //fTables[1] := aSab2.Table;

 lSab1 := aSab1.HTSab;
 lSab2 := aSab2.HTSab;

 if htTablesJoin(fSab,
              lSab1,aJoinField1,
              EQUAL,
              lSab2,aJoinField2,
              nil, True, aMode) = nil then
  Ht(fSab.nRetCode);
end;

constructor TJoinSab.MakeJoin(aJoinSab1 : IJoinSab;
                              aJoinSab2 : IJoinSab;
                              aSkipLink : boolean = false;
                              aMode : SmallInt = Draft_Zero);
var
 lSab1 : Sab;
 lSab2 : Sab;
begin
 lSab1 := aJoinSab1.HTSab;
 lSab2 := aJoinSab2.HTSab;

 if htTablesLink(fSab,
                 lSab1,
                 lSab2,
                 aSkipLink,
                 aMode or LINK_MULT) = nil then
  Ht(fSab.nRetCode);
end;

function TJoinSab.TranslateFieldNumber(const aFields : array of TJoinFieldRec) : TFieldArray;
var
 lHandlesArr : array of ThtTblHandle;
 lTablesCnt  : Integer;
 lFldOffsets : TFieldArray;
 lFldIndex   : Integer;
 I, J        : Integer;
 lTblOffs    : Integer;

 function lNumOfFields(aTblH : ThtTblHandle)  : Integer;
 var
  sTbl : ThtTableInfoRec;
 begin
  //CheckIsOpen;
  Ht(htTableInfo(aTblH, sTbl));
  Result := sTbl.nFieldCnt;
 end;

begin
 SetLength(lHandlesArr, MAX_TAB_LINK);
 lTablesCnt := htTellJoinOrder(fSab, @lHandlesArr[0]);

 SetLength(lFldOffsets, lTablesCnt);

 lFldOffsets[0] := 0;
 for I := 1 to Pred(lTablesCnt) do
  lFldOffsets[I] := lFldOffsets[I - 1] + lNumOfFields(lHandlesArr[I - 1]) + 1{Surrogate};

 SetLength(Result, Length(aFields));
 for I := 0 to Pred(Length(aFields)) do
 begin
  // найдем смещение таблицы в объединении (lTblIndex)
  lTblOffs := -1;
  for J := 0 to Pred(lTablesCnt) do
   if lHandlesArr[J] = aFields[I].rTable.Handle then
   begin
    lTblOffs := lFldOffsets[J];
    Break;
   end;
  Assert(lTblOffs >= 0);

  Result[I] := Ifthen(aFields[I].rField < 0, -1, 1) * (lTblOffs + Abs(aFields[I].rField));
 end;
end;

function TJoinSab.TranslateFieldNumber(const aField : TJoinFieldRec) : ThtField;
var
 lHandlesArr : array of ThtTblHandle;
 lTablesCnt  : Integer;
 lFldOffset  : Integer;
 I           : Integer;

 function lNumOfFields(aTblH : ThtTblHandle)  : Integer;
 var
  sTbl : ThtTableInfoRec;
 begin
  //CheckIsOpen;
  Ht(htTableInfo(aTblH, sTbl));
  Result := sTbl.nFieldCnt;
 end;

begin
 SetLength(lHandlesArr, MAX_TAB_LINK);
 lTablesCnt := htTellJoinOrder(fSab, @lHandlesArr[0]);

 lFldOffset := 0;
 for I := 0 to Pred(lTablesCnt) do
  if lHandlesArr[I] = aField.rTable.Handle then
   break
  else
   Inc(lFldOffset, lNumOfFields(lHandlesArr[I]) + 1{Surrogate});


 Result := Ifthen(aField.rField < 0, -1, 1) * (lFldOffset + Abs(aField.rField));
end;

procedure TJoinSab.SortJoin(aElemNum : array of TJoinFieldRec);
begin
 Sort(TranslateFieldNumber(aElemNum));
end;

procedure TJoinSab.SortJoin(aSortProc : TUserSortProc; aElemNum : array of TJoinFieldRec);
begin
 Sort(aSortProc, TranslateFieldNumber(aElemNum));
end;

procedure TJoinSab.IterateJoinRecords(aRecProc : TdtRecAccessProc; const aFldArr : array of TJoinFieldRec);
begin
 IterateRecords(aRecProc, TranslateFieldNumber(aFldArr));
end;

procedure TJoinSab.CopyJoinRecordsToBuffer(aBuffer : Pointer; const aFldArr : array of TJoinFieldRec);
begin
 CopyRecordsToBuffer(aBuffer, TranslateFieldNumber(aFldArr));
end;

function TJoinSab.MakeJoinSabCursor(const aFields : array of TJoinFieldRec;
                                    aCacheMethod : TCacheMethod = cmForward;
                                    aOpenMode : SmallInt = ROPEN_BODY) : ISabCursor;
begin
 //lJoinFields
 Result := MakeSabCursor(TranslateFieldNumber(aFields), aCacheMethod, aOpenMode);
end;

{TSabCursor}

constructor TSabCursor.Make(aSab : TSab; const aFields :  array of ThtField;
                            aCacheMethod : TCacheMethod = cmForward; aOpenMode : SmallInt = ROPEN_BODY);
begin
  Create;
  l3Set(fSab, aSab);
  fSab.SetSabCursor(Self);

  fFields := MakeFieldArray(aFields);
  fCacheMethod := aCacheMethod;
  fOpenMode := aOpenMode;
  OpenSab;
end;

function TSabCursor.Count : Integer;
begin
 Result := fSab.Count;
end;

procedure TSabCursor.Cleanup;
begin
 fSab.SetSabCursor(nil);
 CloseSab;
 l3System.FreeLocalMem(fBuffer);
 l3Free(fSab);
 Inherited Cleanup;
end;

procedure TSabCursor.OpenSab;
begin
 if not fSab.IsValid then
  raise EHtErrors.CreateInt(ecNotValidSrchType);

 if Length(fFields) = 0 then
  Ht(htOpenResults(fSab.fSab, fOpenMode, nil, 0))
 else
  Ht(htOpenResults(fSab.fSab, fOpenMode, @fFields[0], Length(fFields)));

 Ht(htResultsItemLen(fSab.fSab, fItemSize));
 ResetBuffer;
end;

function TSabCursor.ItemSize : Cardinal;
begin
 Result := fItemSize;
end;

procedure TSabCursor.CloseSab;
begin
 Assert(fSab <> nil);
 if fSab.IsOpened then
  htCloseResults(fSab.fSab);

 if fSab.TypeOfSab = RES_VALUE then
  fSab.Sort;
end;

procedure TSabCursor.PurgeCache;
begin
 fFirstItem := cUndefItem;
end;

procedure TSabCursor.ResetBuffer;
var
 lCurSize : Cardinal;
begin
 fBufRecCount := l3MinMax.Max(MAX_BUF_LEN div fItemSize, 1);
 if (fBuffer <> nil) then
  if l3MemorySize(fBuffer) >= fItemSize * fBufRecCount then
   l3FillChar(fBuffer^, fItemSize * fBufRecCount)
  else
   l3System.FreeLocalMem(fBuffer);

 if (fBuffer = nil) then
  l3System.GetLocalMemZ(fBuffer, fItemSize * fBufRecCount);

 //l3System.GetLocalMemz(fCurItem,fItemSize);
 PurgeCache;
end;

function TSabCursor.ReadBuffer(aBuffer : Pointer; aBuffSize : integer) : Cardinal;
{- Result - количество считанных байт}
var
 lRCnt      : Cardinal;
begin
 Result := 0;
 while aBuffSize > 0 do
 begin
  lRCnt := htReadResults(fSab.fSab,  Pointer(Cardinal(aBuffer) + Result), Min(aBuffSize, MAX_BUF_LEN));

  if lRCnt = 0 then Break;
  if lRCnt > MAX_BUF_LEN then
   HT(Smallint(lRCnt));

  Inc(Result, lRCnt);
  Dec(aBuffSize, lRCnt);
 end;
end;

procedure TSabCursor.RestructBufferPrim(aItem : Cardinal);
var
 lNewFirst,
 lNewLast   : Cardinal;

 lMoveSrc,
 lMoveDest,
 lReadPoint : Pointer;
 lMoveSize,
 lReadSize  : Cardinal;
 lSeekItem,
 lReadCount : Cardinal;
 //lRCnt      : Cardinal;
Begin
 lReadSize := 0;

 lNewFirst := aItem;
 lNewLast := lNewFirst + fBufRecCount - 1;

 if lNewLast >= Count then
 begin
  lNewLast := l3MinMax.CardinalDec(Count, 1);
  if lNewFirst <> 0 then
   lNewFirst := l3MinMax.CardinalDec(lNewLast, fBufRecCount - 1);
 end;

 if (fFirstItem = cUndefItem) or
    (lNewFirst >= fLastItem) or
    (lNewLast <= fFirstItem) then
 begin
  fFirstItem := lNewFirst;
  Ht(htSeekResults(fSab.fSab, fFirstItem, RSEEK_SET));

  // Это функция-обвязка вокруг htReadResults
  lReadCount := ReadBuffer(fBuffer, fItemSize * fBufRecCount);

  (*
  lReadCount := 0;
  lReadSize := fItemSize * fBufRecCount;
  lReadPoint := fBuffer;
  while lReadSize > 0 do
  begin
   lRCnt := htReadResults(fSab.fSab,  Pointer(Cardinal(lReadPoint) + lReadCount), Min(lReadSize, MAX_BUF_LEN));

   if lRCnt = 0 then Break;
   if lRCnt > MAX_BUF_LEN then
    HT(Smallint(lRCnt));

   Inc(lReadCount, lRCnt);
   Dec(lReadSize, lRCnt);
  end;
  *)
  // Это функция-обвязка вокруг htReadResults

  fLastItem := fFirstItem + (lReadCount div fItemSize) - 1;
 end
 else
 begin
  lMoveSize  := 0;
  lMoveSrc   := Nil;
  lMoveDest  := Nil;
  lReadPoint := Nil;
  lSeekItem  := cUndefItem;

  if (lNewFirst >= fFirstItem) then
  begin
   lMoveSrc   := Pointer(Cardinal(fBuffer) + (lNewFirst - fFirstItem) * fItemSize);
   lMoveDest  := fBuffer;
   lMoveSize  := (fLastItem - lNewFirst + 1) * fItemSize;
   lReadPoint := Pointer(Cardinal(fBuffer) + (fLastItem - lNewFirst + 1) * fItemSize);
   lReadSize  := (lNewLast - fLastItem) * fItemSize;
   lSeekItem  := fLastItem + 1;
  end;

  if (lNewLast <= fLastItem) then
  begin
   lMoveSrc   := fBuffer;
   lMoveDest  := Pointer(Cardinal(fBuffer) + (fFirstItem - lNewFirst) * fItemSize);
   lMoveSize  := (lNewLast - fFirstItem + 1) * fItemSize;
   lReadPoint := fBuffer;
   lReadSize  := (fFirstItem - lNewFirst) * fItemSize;
   lSeekItem  := lNewFirst;
  end;

  if (lMoveSize <> 0) and (lMoveSrc <> Nil) and (lMoveDest <> Nil) then
   l3Move(lMoveSrc^, lMoveDest^, lMoveSize);

  lReadCount := 0;
  if (lReadSize <> 0) and (lReadPoint <> Nil) and (lSeekItem <> cUndefItem) then
  begin
   Ht(htSeekResults(fSab.fSab, lSeekItem, RSEEK_SET));

   // Это функция - обвязка вокруг htReadResults
   lReadCount := ReadBuffer(lReadPoint, lReadSize);
   (*
   lReadCount := 0;
   while lReadSize > 0 do
   begin
    lRCnt := htReadResults(fSab.fSab,  Pointer(Cardinal(lReadPoint) + lReadCount), Min(lReadSize, MAX_BUF_LEN));

    if lRCnt = 0 then Break;
    if lRCnt > MAX_BUF_LEN then
     HT(Smallint(lRCnt));

    Inc(lReadCount, lRCnt);
    Dec(lReadSize, lRCnt);
   end;
   *)
   // Это функция - обвязка вокруг htReadResults
  end;

  fFirstItem := lNewFirst;
  fLastItem := fFirstItem + (lMoveSize + lReadCount) div fItemSize - 1;
 end;
end;

procedure TSabCursor.RestructBuffer(aItem : Cardinal);
begin
 if fCacheMethod = cmForward then
  aItem := l3MinMax.CardinalDec(aItem, 1)
 else
  aItem := l3MinMax.CardinalDec(aItem, (fBufRecCount div 2));

 RestructBufferPrim(aItem);
end;

//function TSabCursor.GetMarker(aIndex : Cardinal) : ThtMarker;
//begin
// Ht(htSeekResults(fSab.fSab, aIndex, RSEEK_SET));
// Ht(htMarkRecord(fSab.fSab, Result));
//end;

function TSabCursor.GetItem(aIndex : Cardinal) : Pointer;
begin
 if fSab.IsEmpty or (aIndex >= Count) then
 begin
  Result := Nil;
  Exit;
 end;

 if (fFirstItem = cUndefItem) or
    Not ((aIndex >= fFirstItem) and (aIndex <= fLastItem)) then
  RestructBuffer(aIndex);

 Result := GetItemPrim(aIndex);
end;

function TSabCursor.GetItemPrim(aIndex : Cardinal) : Pointer;
begin
 Result := Pointer(Cardinal(fBuffer) + (aIndex - fFirstItem) * fItemSize);
end;

function TSabCursor.AddItem(aAbsNum : Cardinal) : Cardinal;
begin
 if not fSab.IsValid then
  raise EHtErrors.CreateInt(ecNotValidSrchType);
 Assert(fSab.TypeOfSab = RES_RECORD, 'Саб должен быть RES_RECORD');
 Ht(htIncludeResultsItem(fSab.fSab, aAbsNum, nil));
 Result := htRecordOrdinalNumber(fSab.fSab, aAbsNum);
 PurgeCache;
end;

procedure TSabCursor.AddItem(aData : Pointer);
begin
 if not fSab.IsValid then
  raise EHtErrors.CreateInt(ecNotValidSrchType);
 Assert(fSab.TypeOfSab = RES_VALUE, 'Саб должен быть RES_VALUE');
 Ht(htIncludeResultsItem(fSab.fSab, fSab.Count, aData));
 PurgeCache;
end;

function TSabCursor.GetIndex(aAbsNum : Cardinal) : Cardinal;
begin
 if not fSab.IsValid then
  raise EHtErrors.CreateInt(ecNotValidSrchType);

 Assert(fSab.TypeOfSab in [RES_RECORD, RES_SORTED], 'TSabCursor.GetIndex работает только для RES_RECORD');

 Result := HT(htRecordOrdinalNumber(fSab.fSab, aAbsNum));
end;

function TSabCursor.DelItem(aIndex : Cardinal) : Cardinal;
begin
 if fSab.IsEmpty then
  raise EHtErrors.CreateInt(ecSrchEmpty);

 if aIndex >= Count then
 begin
  Result := 0;
  exit;
 end;

 Result := Ht(htSeekResults(fSab.fSab, aIndex, RSEEK_SET));
 Ht(htExcludeResultsItem(fSab.fSab, Result));

 PurgeCache;
end;

function TSabCursor.GetRecHandle(aIndex : Cardinal): RHandle;
begin
 Assert(fSab.TypeOfSab in [RES_RECORD, RES_SORTED], 'TSabCursor.GetRecHandle работает только для RES_RECORD');
 Result := -1;
 Ht(htGetResultsItem(fSab.fSab, aIndex, @Result));
end;

function TSabCursor.Find(const aCompareProc : Tl3PtrCompareProc;
                               aCompareData : Pointer;
                               aLow, aHi : Longint;
                           out theIndex  : Longint;
                               aNeedLast : boolean = false): Boolean;
(* - Уникальный алгоритм "Дихотомия на буфере" :)
     перебираем фреймы (размером с буфер) сравнивая границы фрейма с поисковым значением,
     по результатам сравнения корректируем aLow или aHi до тех пор, пока aLow и aHi не окажутся в буфере.
     после этого запускаем чистую дихотомию по буферу *)
var
 i, C: Longint;
 lBufOrg : Longint;
begin
 //Assert(fCacheMethod = cmForward, 'TSabCursor.Find: fCacheMethod must be cmForward');

 aLow := Max(aLow, 0);
 aHi := Min(aHi, Pred(Count));

 theIndex := 0;
 Result := false;

 if aHi < aLow then Exit;

 if (fFirstItem = cUndefItem) or         // буфер не инициализирован
    (fFirstItem > aHi) or (fLastItem < aLow) or // буфер вообще не пересекается с диапазоном
    (((aHi - aLow) <= fBufRecCount) and         // весь диапазон может уместится в буфере
     (aHi > fLastItem)) then                    // но сейчас не лежит там
  RestructBufferPrim(aLow);

 while True do
  if (aLow >= fFirstItem) then
  begin
   if (aHi <= fLastItem) then
    begin // все в буфере, запускаем дихотомию
     if (aHi - aLow) < 0 then Exit;
     while (aLow <= aHi) do
     begin
      i := (aLow + aHi) shr 1;
      C := aCompareProc(GetItemPrim(i), aCompareData);
      if (C < 0) then
       aLow := Succ(i)
      else
      begin
       if (C = 0) then
       begin
        Result := true;
        theIndex := i;
        if aNeedLast then
         aLow := Succ(i)
        else
         aHi := Pred(i);
       end//C = 0
       else
        aHi := Pred(i);
      end;//C < 0
     end;//while (aLow..
     if not Result then
      theIndex := aLow;
     Break;
    end //...дихотомия
   else
   begin
    C := aCompareProc(GetItemPrim(fLastItem), aCompareData);
    if (C < 0) or ((C = 0) and aNeedLast) then
    begin
     aLow := fLastItem;
     if (C < 0) then Inc(aLow);
     // если при реструктуризации получится aHi < fLastItem, то натянем Hi на fLastItem, но aLow сдвигать не будем
     lBufOrg := Max(Min(aLow,  aHi - Pred(fBufRecCount)), 0);
     RestructBufferPrim(lBufOrg);
    end
    else
     if (C > 0) or ((C = 0) and not aNeedLast) then
      aHi := fLastItem;
   end
  end
  else //if (aLow >= fFirstItem) then
  begin
   C := aCompareProc(GetItemPrim(fFirstItem), aCompareData);
   if (C < 0) or ((C = 0) and aNeedLast) then
   begin
    aLow := fFirstItem;
    if (C < 0) then Inc(aLow);
   end
   else
    if (C > 0) or ((C = 0) and not aNeedLast) then
    begin
     aHi := fFirstItem;
     // если при реструктуризации получится aLow > fFirstItem, то натянем aLow на fFirstItem, но aHi сдвигать не будем
     lBufOrg := Max(Min(aLow,  aHi - Pred(fBufRecCount)), 0);
     RestructBufferPrim(lBufOrg);
    end;
  end;
end;

procedure TSabCursor.Sort(const aElemNum : array of ThtField);
begin
 Assert(Not(fSab is TJoinSab));
 if not fSab.IsValid then
  raise EHtErrors.CreateInt(ecNotValidSrchType);
 fSab.Sort(aElemNum);
end;

procedure TSabCursor.Sort(aSortProc : TUserSortProc; const aElemNum : array of ThtField);
begin
 Assert(Not(fSab is TJoinSab));
 if not fSab.IsValid then
  raise EHtErrors.CreateInt(ecNotValidSrchType);
 fSab.Sort(aSortProc, aElemNum);
end;

procedure TSabCursor.SortJoin(const aElemNum : array of TJoinFieldRec);
begin
 Assert(fSab is TJoinSab);
 if not fSab.IsValid then
  raise EHtErrors.CreateInt(ecNotValidSrchType);
 TJoinSab(fSab).SortJoin(aElemNum);
end;

procedure TSabCursor.Sort(aSortProc : TUserSortProc; const aElemNum : array of TJoinFieldRec);
begin
 Assert(fSab is TJoinSab);
 if not fSab.IsValid then
  raise EHtErrors.CreateInt(ecNotValidSrchType);
 TJoinSab(fSab).SortJoin(aSortProc, aElemNum);
end;

procedure TSabCursor.Sort;
begin
 Assert(Not(fSab is TJoinSab));
 if not fSab.IsValid then
  raise EHtErrors.CreateInt(ecNotValidSrchType);
 fSab.Sort;
end;

{TValueSetFiller}
constructor TValueSetFiller.Create(aSab : TSab);
begin
 fSab := aSab.Use;
 //l_FieldLen := fSab.Table.fldLength[aField];

 fIncludePos := 0;
 fFilledBufLen := 0;
 fFilledBufLen := 0;
 //htCreateEmptySAB(nil, fValuesSab, fSab.fTable.Handle, aField, Res_Value);
 Ht(htOpenResults(fSab.HTSabAddr^, ROPEN_READ, nil, 0));

 Ht(htResultsItemLen(fSab.HTSabAddr^, fFieldLen));
 l3System.GetLocalMem(fBuffer, MAX_BUF_LEN);
end;

procedure TValueSetFiller.Cleanup;
begin
 AddBuffer;
 htCloseResults(fSab.HTSabAddr^);
 fSab.Sort;
 l3System.FreeLocalMem(fBuffer);
 l3Free(fSab);
end;

function  TValueSetFiller.GetBuffLen : integer;
begin
 Result := MAX_BUF_LEN div fFieldLen * fFieldLen;
end;

function  TValueSetFiller.GetBuffer : Pointer;
begin
 Result := fBuffer;
end;

procedure TValueSetFiller.AddBuffer;
begin
 if fFilledBufLen = 0 then Exit;

 //Ht(htOpenResults(fSab.HTSabAddr^, ROPEN_READ, nil, 0));
 //try
  Ht(htIncludeResultsBlock(fSab.HTSabAddr^,
                           fIncludePos,
                           fBuffer,
                           fFilledBufLen));
 //finally
 // htCloseResults(lSab);
 //end;

 fIncludePos := fIncludePos + (fFilledBufLen div fFieldLen);
 fFilledBufLen := 0;
end;

procedure TValueSetFiller.AddValue(var aValue);
begin
 l3Move(aValue, (PChar(fBuffer) + fFilledBufLen)^, fFieldLen);

 Inc(fFilledBufLen, fFieldLen);
 if fFilledBufLen = GetBuffLen then
  AddBuffer;
end;

{---}
function dtMakeSabCopy(const aSab : SAB) : SAB;
begin
 Ht(htCopyResults(Result, aSab));
end;

function dtCleanSab(var aSab : SAB) : SAB;
begin
 l3FillChar(aSab, SizeOf(SAB));
 Result := aSab;
end;

procedure dtFreeSab(var aSab : SAB);
begin
 htClearResults(aSab);
end;

function dtSortSab(var aSab : SAB) : SAB; overload;
begin
 Result := dtSortSab(aSab, []);
end;

function dtSortSab(var aSab : SAB; const aElemNum : array of Smallint) : SAB;
var
 lSorted  : Sab;
begin
 if aSab.gFoundCnt <= 1 then exit;
 if Length(aElemNum) = 0 then
  Ht(htSortResults(lSorted, aSab, 0, 0))
 else
  Ht(htSortResults(lSorted, aSab, @aElemNum[0], Length(aElemNum)));
 dtFreeSab(aSab);
 aSab := lSorted;
 //dtCleanSab(lSorted);
 Result := aSab;
end;

function BuildSab(aFillBufferProc: TFillBufferProc;
                  const aTable: ITblInfo;
                  aFieldNum: Smallint): Sab;

const
 c_MaxBufLen = MAX_BUF_LEN;
var
 l_FieldLen: Integer;
 l_Buf: Pointer;
 l_BytesInBuf: Cardinal;
 l_ValuesSab: Sab;
 l_IncludePos: Integer;
begin
 htCreateEmptySAB(nil, l_ValuesSab, aTable.Handle, aFieldNum, RES_VALUE);
 try
  // наполнение
  l_FieldLen := aTable.fldLength[aFieldNum];
  l3System.GetLocalMem(l_Buf, c_MaxBufLen);
  try
   Ht(htOpenResults(l_ValuesSab, ROPEN_READ, nil, 0));
   try
    l_IncludePos := 0;
    while True do
    begin
     l_BytesInBuf := aFillBufferProc(l_Buf, c_MaxBufLen);
     if l_BytesInBuf = 0 then
      Break;

     Ht(htIncludeResultsBlock(l_ValuesSab,
                              l_IncludePos,
                              l_Buf,
                              l_BytesInBuf));

     l_IncludePos := l_IncludePos + (l_BytesInBuf div l_FieldLen);
    end; // while
   finally
    htCloseResults(l_ValuesSab);
   end;
  finally
   l3System.FreeLocalMem(l_Buf);
  end;
  // сортировка
  Ht(htSortResults(Result, l_ValuesSab, @aFieldNum, 1));
 finally
  htClearResults(l_ValuesSab);
 end;
end;

function dtSABHasData(var aSAB: SAB) : Boolean;
begin
 Result :=(htResultsType(aSab) <> Res_NProc) and (aSab.gFoundCnt <> 0);
end;

function dtAndResults(var fpDst : SAB; var fpSrc1: SAB; var fpSrc2: SAB) : LPSAB;
begin
 dtCleanSab(fpDst);
 Result := @fpDst;
 if dtSABHasData(fpSrc1) and dtSABHasData(fpSrc2) then
 begin
  Result := htAndResults(fpDst, fpSrc1, fpSrc2);
  if Result = nil then
   HT(fpDst.nRetCode);
 end;
end;

function dtOrResults(var fpDst : SAB; var fpSrc1: SAB; var fpSrc2: SAB) : LPSAB;
var
 lSab1Exist : Boolean;
 lSab2Exist : Boolean;
begin
 dtCleanSab(fpDst);
 Result := @fpDst;

 lSab1Exist := dtSABHasData(fpSrc1);
 lSab2Exist := dtSABHasData(fpSrc2);

 if lSab1Exist and lSab2Exist then
 begin
  Result := htOrResults(fpDst, fpSrc1, fpSrc2);
  if Result = nil then
   HT(fpDst.nRetCode);
 end
 else
  if lSab1Exist then
   Ht(htCopyResults(fpDst, fpSrc1))
  else
   if lSab2Exist then
    Ht(htCopyResults(fpDst, fpSrc2))
end;

function dtXorResults(var fpDst : SAB; var fpSrc1: SAB; var fpSrc2: SAB) : LPSAB;
var
 lSab1Exist : Boolean;
 lSab2Exist : Boolean;
begin
 dtCleanSab(fpDst);
 Result := @fpDst;

 lSab1Exist := dtSABHasData(fpSrc1);
 lSab2Exist := dtSABHasData(fpSrc2);

 if lSab1Exist and lSab2Exist then
 begin
  Result := htXorResults(fpDst, fpSrc1, fpSrc2);
  if Result = nil then
   HT(fpDst.nRetCode);
 end
 else
  if lSab1Exist then
   Ht(htCopyResults(fpDst, fpSrc1))
  else
   if lSab2Exist then
    Ht(htCopyResults(fpDst, fpSrc2))
end;

procedure dtCopyValuesSabToList(const aValuesSab : SAB; aList : Tl3LongintList);
var
 lCnt : Integer;
 lMaxNumRead   : Cardinal;
 lNumTotalRead : Cardinal;

begin
 Assert(htResultsType(aValuesSab) = RES_VALUE, 'dtCopyValuesSabToList: Неверный тип SAB');
 lCnt := aValuesSab.gFoundCnt;
 if lCnt = 0 then Exit;

 aList.Count := lCnt;
 Ht(htOpenResults(aValuesSab, ROPEN_READ, nil, 0));
 try
  lNumTotalRead := 0;
  lMaxNumRead := Min((MAX_BUF_LEN div SizeOf(Longint)), lCnt);
  while lNumTotalRead < lCnt do
   Inc(lNumTotalRead, htReadResults(aValuesSab, aList.ItemSlot(lNumTotalRead), lMaxNumRead * SizeOf(Longint)) div SizeOf(Longint));

   //Ht(htResultsItemLen(aValuesSab, lItemSize));
   //while htReadResults(aValuesSab, @lValue, lItemSize) <> 0 do
   // aList.Add(lValue);
 finally
  htCloseResults(aValuesSab);
 end;
end;

procedure dtCopyValuesSabToList(const aValuesSab : SAB; aList : Tl3CardinalList);
var
 lValue    : Cardinal;
 lItemSize : Cardinal;
begin
 lValue := 0;
 if aValuesSab.gFoundCnt > 0 then
 begin
  Ht(htOpenResults(aValuesSab, ROPEN_READ, nil, 0));
  try
   Ht(htResultsItemLen(aValuesSab, lItemSize));
   while htReadResults(aValuesSab, @lValue, lItemSize) <> 0 do
    aList.Add(lValue);
  finally
   htCloseResults(aValuesSab);
  end;
 end;
end;

procedure dtCopyValuesSabToList(const aValuesSab : SAB; aList : DocumentIDListHelper); overload;
var
 lValue    : Longint;
 lItemSize : Cardinal;
begin
 Assert(htResultsType(aValuesSab) = RES_VALUE, 'dtCopyValuesSabToList: Неверный тип SAB');
 lValue := 0;
 if aValuesSab.gFoundCnt > 0 then
 begin
  Ht(htOpenResults(aValuesSab, ROPEN_READ, nil, 0));
  try
   Ht(htResultsItemLen(aValuesSab, lItemSize));
   while htReadResults(aValuesSab, @lValue, lItemSize) <> 0 do
    aList.Add(lValue);
  finally
   htCloseResults(aValuesSab);
  end;
 end;
end;

function dtGetSabFieldSizeArray(const aSab : SAB) : TFieldArray;
var
 I : Integer;
 lFldCount : Integer;
 lOPELArr : array of OPEL;
begin
 lFldCount := htResultsItemCnt(aSab);
 SetLength(lOPELArr, lFldCount);
 SetLength(Result, lFldCount);
 htResultsItemParm(aSab, @lOPELArr[0]);
 for I := 0 to Pred(lFldCount) do
  Result[I] := lOPELArr[I].wLen;
end;

procedure dtOutSabToStream(const aSab : ISAB; aStream : TStream);

function lBlockAccessProc(aBuffer: Pointer; aBufSize: Longint) : Boolean; register;
 begin
  Result := (aStream.Write(aBuffer^, aBufSize) = aBufSize);
 end;

var
 lBlockAccessProcStub : TdtBlockAccessProc;
begin
 lBlockAccessProcStub := L2BlockAccessProc(@lBlockAccessProc);
 try
  aSab.IterateBlockOfRecords(lBlockAccessProcStub);
 finally
  FreeBlockAccessProc(lBlockAccessProcStub);
 end;
end;

procedure dtOutSabToStream(const aSab : ISAB; aStream : Tk2RawData);
{* - выводит список значений в Stream}
var
 l_IStream : IStream;
 l_Stream : TStream;
begin
 l_IStream := aStream As IStream;
 l3IStream2Stream(l_IStream, l_Stream);
 try
  dtOutSabToStream(aSab, l_Stream)
 finally
  FreeAndNil(l_Stream);
 end;//try..finally
end;

procedure dtOutSabToStream(const aSab : ISAB; aStream : DocumentIDListHelper);
{* - выводит список значений в Stream}
begin
 dtCopyValuesSabToList(aSab, aStream);
end;

function dtMakeSortedLongListBySab(const aSab : ISAB): Tl3LongintList;
var
 lMaxNumRead   : Cardinal;
 lNumTotalRead : Cardinal;
 lResultsType  : SmallInt;
begin
 aSab.Sort;
 lResultsType := aSab.TypeOfSab;
 if (lResultsType = Res_NProc) then Exit;
 Assert(lResultsType = RES_VALUE, 'dtMakeIDListBySab: Неверный тип SAB');

 Result := Tl3IDList.Create;
 Result.Sorted := True;
 Result.Count := aSab.Count;

 dtCopyValuesSabToList(aSab, Result);
end;

function dtMakeSortedIDListBySab(const aSab : ISAB): Il3IDList;
var
 lMaxNumRead   : Cardinal;
 lNumTotalRead : Cardinal;
 lResultsType  : SmallInt;
 lIDList       : Tl3IDList;
begin
 aSab.Sort;
 lResultsType := aSab.TypeOfSab;
 if (lResultsType = Res_NProc) then Exit;
 Assert(lResultsType = RES_VALUE, 'dtMakeIDListBySab: Неверный тип SAB');

 try
  lIDList := Tl3IDList.Create;
  dtCopyValuesSabToList(aSab, lIDList);
  Result := lIDList;
 finally
  l3Free(lIDList);
 end;
end;

function dtMakeRecListBySab(const aSab : SAB;
                            const aFldArr : array of ThtField): Tl3FieldSortRecList;
begin
 Result := dtMakeRecListBySab(aSab, aFldArr, []);
end;

function dtMakeRecListBySab(const aSab : SAB;
                            const aFldArr : array of ThtField;
                            const aElemNum : array of Smallint): Tl3FieldSortRecList;
var
 lItemSize     : Cardinal;
 lMaxNumRead   : Cardinal;
 lNumTotalRead : Cardinal;
 lFldArr       : TFieldArray;
 lResultsType  : SmallInt;
begin
 Result := Nil;
 lResultsType := htResultsType(aSab);
 if (lResultsType = Res_NProc) then Exit;
 if Length(aFldArr) = 0 then Exit;

 //if htIsResultOpen(aSab^) then Exit;

 Ht(htOpenResults(aSab, ROPEN_BODY, @aFldArr[0], Length(aFldArr)));
 try
  Ht(htResultsItemLen(aSab, lItemSize));
  lFldArr := dtGetSabFieldSizeArray(aSab);
  Result := Tl3FieldSortRecList.Create(lItemSize, lFldArr, aElemNum);
  Result.Sorted := lResultsType in [RES_SORTED, RES_SORTJOIN];
  Result.Count := aSab.gFoundCnt;

  lNumTotalRead := 0;
  lMaxNumRead := Min((MAX_BUF_LEN div Result.ItemSize), Result.Count);
  while lNumTotalRead < Result.Count do
   Inc(lNumTotalRead, htReadResults(aSab, Result.ItemSlot(lNumTotalRead), lMaxNumRead * Result.ItemSize) div Result.ItemSize);
 finally
  htCloseResults(aSab);
 end;
end;

function dtMakeRecListByJoinSab(const aSab : IJoinSAB;
                                const aFieldsArr : array of TJoinFieldRec;
                                const aSortArr : array of Smallint): Tl3FieldSortRecList;
begin
 Result := dtMakeRecListBySab(aSab, aSab.TranslateFieldNumber(aFieldsArr), aSortArr);
end;

function dtMakeRecListBySab(const aSab : ISAB;
                            const aSortArr : array of Smallint): Tl3FieldSortRecList; overload;
begin
 Result := dtMakeRecListBySab(aSab, [], aSortArr);
end;

function dtMakeRecListBySab(const aSab : ISAB;
                            const aFieldsArr : array of ThtField;
                            const aSortArr : array of Smallint): Tl3FieldSortRecList;

 function GetTotalSize(const aSizeArr : array of Smallint) : integer;
 var
  I : Integer;
 begin
  Result := 0;
  for I := 0 to Pred(Length(aSizeArr)) do
   Inc(Result, aSizeArr[I]);
 end;

var
 lResultsType  : SmallInt;
 lSizeArr      : TSmallIntArray;

begin
 Result := Nil;
 lResultsType := aSab.TypeOfSab;

 if (lResultsType = Res_NProc) then Exit;
 //if Length(aFldArr) = 0 then Exit;

 lSizeArr := aSab.GetFieldSizeArray(aFieldsArr);
 Result := Tl3FieldSortRecList.Create(GetTotalSize(lSizeArr), lSizeArr, aSortArr);

 Result.Count := aSab.Count;
 aSab.CopyRecordsToBuffer(Result.ItemSlot(0), aFieldsArr);
 
 Result.Sorted := True;
end;

function JFRec(const aTable : ITblInfo; aField : ThtField) : TJoinFieldRec;
begin
 with Result do
 begin
  rTable := aTable;
  rField := aField;
 end;
end;

procedure dtCopyValuesSabToList(const aValuesSab : ISab; aList : Il3IDList); overload;
begin
 dtCopyValuesSabToList(aValuesSab.HTSab, aList.GetSelf);
end;

procedure dtCopyValuesSabToList(const aValuesSab : ISab; aList : Tl3LongintList); overload;
begin
 dtCopyValuesSabToList(aValuesSab.HTSab, aList);
end;


procedure dtCopyValuesSabToList(const aValuesSab : ISab; aList : DocumentIDListHelper); overload;
begin
 dtCopyValuesSabToList(aValuesSab.HTSab, aList);
end;

function MakeEmptySab(const aPhoto : ISab): ISab;
var
 lSab : TSab;
begin
 lSab := TSab.MakeEmpty(aPhoto);
 Result := lSab;
 l3Free(lSab);
end;

function MakeEmptySab(const aTable : ITblInfo): ISab;
var
 lSab : TSab;
begin
 lSab := TSab.MakeEmpty(aTable);
 Result := lSab;
 l3Free(lSab);
end;

function MakeValueSet(const aTable : ITblInfo;
                      aField : ThtField;
                      const aStream: Tk2RawData) : ISab;     //overload;
{* - грузит список значений в из Stream}
var
 l_IStream : IStream;
 l_Stream : TStream;
begin
 l_IStream := aStream As IStream;
 l3IStream2Stream(l_IStream, l_Stream);
 try
  Result := MakeValueSet(aTable, aField, l_Stream)
 finally
  FreeAndNil(l_Stream);
 end;//try..finally
end;

end.

(*
//// пример использования IterateRecords

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  with PRenumRec(aItemPtr)^ do
   .....
 end;

 var
  lSab        : ISab;
  lRAProcStub : TdtRecAccessProc;

 begin
  ...
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSab.IterateRecords(lRAProcStub, [rnRealID_fld, rnImportID_fld]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
 end;


function TVersionListAttribute.MakeDocSab : ISab;
const
 cHandleSize = SizeOf(Longint);
var
 lListCursor : Integer;
 lCount : Integer;

 function lFillBufferProc(aBuffer: Pointer; aBufSize: Longint): Longint; register;
 var
  lRealSize : Longint;
  I : Integer;
 begin
  lRealSize := Min(aBufSize div cHandleSize, lCount - lListCursor);

  for I := lListCursor to lListCursor + pred(lRealSize) do
  begin
   PLongint(aBuffer)^ := Handle[I];
   Inc(PChar(aBuffer), cHandleSize);
  end;

  Result := lRealSize * cHandleSize;
  Inc(lListCursor, lRealSize);
 end;

var
 lSab : TSab;
 lFillBufferProcStub : TFillBufferProc;
begin
 lListCursor := 0;
 lCount := Count;
 lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
 try
  lSab := TSab.MakeValueSet(DocumentServer(fAttrManager.DocFamily).FileTbl, fId_Fld, lFillBufferProcStub);
 finally
  FreeFillBufferProc(lFillBufferProcStub);
 end;

 Result := lSab;
 l3Free(lSab);
end;

*)
