(*
   Procedures & Functions

   DLL HyTech для Win95/NT

   HyTech 2.56  Copyright (c) 1993, 99 by SKAZ_M Ltd
*)

// $Id: HT_Dll.pas,v 1.25 2016/10/31 07:01:48 lukyanets Exp $

// $Log: HT_Dll.pas,v $
// Revision 1.25  2016/10/31 07:01:48  lukyanets
// Не собиралось
//
// Revision 1.24  2016/10/28 14:32:06  voba
// no message
//
// Revision 1.23  2016/07/21 06:01:26  fireton
// - не собиралось
//
// Revision 1.22  2016/07/20 13:50:24  voba
// no message
//
// Revision 1.21  2014/07/10 14:40:49  voba
// - поменяли var на const где надо
//
// Revision 1.20  2014/02/18 11:02:44  voba
// - add some func
//
// Revision 1.19  2013/07/08 09:29:45  voba
// - Вытащил Function htExcludeResults, но она только в новой DLL :(
//
// Revision 1.18  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.17  2012/11/07 09:42:05  voba
// - убрал поддержку старых библиотек HT
//
// Revision 1.16  2009/09/11 08:27:26  voba
// - поменял невзрачное название типа ELEMENT на клевое ThtElementInfo
//
// Revision 1.15  2007/03/09 07:34:41  voba
// no message
//
// Revision 1.14  2007/03/02 10:09:40  voba
// - bug fix htSubSearch Bug
//
// Revision 1.13  2007/03/02 10:00:04  voba
// no message
//
// Revision 1.12  2007/03/02 09:52:49  voba
// no message
//
// Revision 1.11  2007/02/22 13:35:39  fireton
// - переход на 64 бита в HyTech
//
// Revision 1.10  2007/02/16 16:06:16  voba
// - rename type Condition ->ThtCondition
//
// Revision 1.9  2006/12/08 15:23:48  voba
// - rename type Format->htFormat
//
// Revision 1.8  2006/11/07 11:18:24  voba
// - bug fix
//
// Revision 1.7  2006/10/27 07:46:50  voba
// no message
//
// Revision 1.6  2006/09/07 10:33:58  voba
// - mode64 support
//
// Revision 1.5  2003/04/11 07:32:50  demon
// - изменен тип, возвращаемый операцией htReadResults с Word на Cardinal
// (для правильной работы с большими буферами)
//
// Revision 1.4  2002/01/16 10:42:22  demon
// - some new functions added
//
// Revision 1.3  2000/12/15 15:36:17  law
// - вставлены директивы Log.
//

Unit HT_Dll;

Interface

Uses HT_Const;

{$I HTDefine.inc}

(*======================== Функции СУБД =======================*)

(*-------------------- Инициализация и завершение -------------*)

(* Первичная инициализация библиотеки API - одна на все приложения *)
  Function  htGlobalInit( hInstance: Integer ):Integer; stdcall;
(* Первичное завершение библиотеки API - одно на все приложения *)
  Procedure htGlobalShut;

(* Инициализация СУБД. Выполняется один раз в начале программы. *)
(* Эта функция должна быть вызвана ДО первого обращения к СУБД *)
  Function htInit(
      fpInit:LPINIT;  (* Параметры для функции или Nil *)
      nSize:SmallInt  (* Размер заполненной части записи *)
  ):Integer;stdcall;

(* Завершение работы СУБД             *)
(* Эта процедура вызывается последней *)
  Procedure htShut;

(*------------------ Работа с таблицами ------------------*)

(* Закрыть все открытые таблицы *)
  Procedure htCloseAllTables;

(* Сравнить обработчики таблиц *)
(* =0 - обработчика указывают на одну и ту же таблицу *)
  Function htCompareTabHandles(
      hTable1 : THANDLE;  (* Обработчик таблицы *)
      hTable2 : THANDLE   (* Другой обработчик таблицы *)
  ):SmallInt;stdcall;

(* Дублировать обработчик таблицы       *)
(* Дубли не входят в общее число таблиц *)
  Function htDupTableHandle(
      hTable     : THANDLE;  (* Исходный обработчик *)
      Var fpTable: THANDLE   (* Дубль обработчика   *)
  ):SmallInt;stdcall;

(* Удалить таблицу и связанные с ней файлы *)
(* Таблица должна быть закрыта             *)
  Function htDropTable(
      fpTableName: PAnsiChar;  (* Имя таблицы (можно без расширения) *)
      fpReadPswd : PAnsiChar;  (* Пароль для доступа на чтение *)
      fpWritePswd: PAnsiChar   (* Пароль для доступа на запись *)
  ):SmallInt;stdcall;

(* Удалить изменения, выполненные для таблицы *)
(* Таблица должна быть закрыта                *)
  Function htDropTableChanges(
      fpTableName: PAnsiChar; (* Имя таблицы (можно без расширения) *)
      fpReadPswd : PAnsiChar; (* Пароль для доступа на чтение       *)
      fpWritePswd: PAnsiChar  (* Пароль для доступа на запись       *)
  ):SmallInt;stdcall;

(* Удалить все данные таблицы (оставить один описатель) *)
(* Таблица должна быть закрыта *)
  Function htDropTableData(
      fpTableName: PAnsiChar; (* Имя таблицы (можно без расширения) *)
      fpReadPswd : PAnsiChar; (* Пароль для доступа на чтение       *)
      fpWritePswd: PAnsiChar  (* Пароль для доступа на запись       *)
  ):SmallInt;stdcall;

(* Сброс буферов В/В таблицы на диск *)
(* Полезна после операций обновления *)
  Function htFlushTable(
      hTable: THANDLE     (* Обработчик для таблицы *)
  ):SmallInt;stdcall;

(* Закрыть открытую таблицу *)
  Function htTableClose(
      hTable: THANDLE     (* Обработчик для таблицы *)
  ):SmallInt;stdcall;

(* Копировать таблицу в другую *)
(* Если таблица с заданным именем существует, она будет уничтожена *)
(* Исходная таблица должна быть закрыта *)
  Function htTableCopy(
      fpDstTable: PAnsiChar;     (* Имя таблицы-копии (можно без расширения) *)
      fpSrcTable: PAnsiChar;     (* Имя исходной таблицы (можно без расширения) *)
      fpSrcRdPswd:PAnsiChar;     (* Пароль для доступа на чтение *)
      nSrcOpenMode: SmallInt (* Режим открытия исходной таблицы *)
  ):SmallInt;stdcall;

(* Создать новую таблицу и получить к ней доступ *)
  Function htTableCreate(
      fpTableName: PAnsiChar;      (* Имя таблицы (можно без расширения) *)
      fpElems     : LPELEMENT; (* Описатели элементов таблицы        *)
      nElemCnt    : SmallInt;  (* Число описателей элементов         *)
      fpCryptoKey : PAnsiChar;     (* Ключ для крипто-закрытия данных    *)
      fpReadPswd  : PAnsiChar;     (* Пароль для доступа на чтение       *)
      fpWritePswd : PAnsiChar;     (* Пароль для доступа на запись       *)
      nOpenMode   : SmallInt;  (* Режим открытия (константы TAB_????)*)
      Var fpHandle: THANDLE    (* Для приема обработчика таблицы     *)
  ):SmallInt;stdcall;

(* Добавление агрегатов (групп и/или подстрок) в таблицу *)
(* Таблица должна быть закрыта *)
  Function htTableAgregateAppend(
      fpTableName: PAnsiChar;    (* Имя таблицы (можно без расширения) *)
      fpReadPswd:  PAnsiChar;    (* Пароль для доступа на чтение *)
      fpWritePswd: PAnsiChar;    (* Пароль для доступа на запись *)
      fpAgres:     LPELEMENT;(* Массив структур описаний агрегатов *)
      nAgreCnt:    SmallInt  (* Число элементов *)
  ):SmallInt;stdcall;

(* Удаление агрегатов (групп и/или подстрок) из таблицы *)
(* Таблица должна быть закрыта *)
  Function htTableAgregateDelete(
      fpTableName: PAnsiChar;    (* Имя таблицы (можно без расширения) *)
      fpReadPswd:  PAnsiChar;    (* Пароль для доступа на чтение *)
      fpWritePswd: PAnsiChar;    (* Пароль для доступа на запись *)
      nPos:      SmallInt; (* Номер первого агрегата из группы *)
      nDelCnt:     SmallInt  (* Число удалемых элементов *)
  ):SmallInt;stdcall;

(* Модификация агрегатов (групп и/или подстрок) в таблице *)
(* Таблица должна быть закрыта *)
  Function htTableAgregateModify(
      fpTableName: PAnsiChar;    (* Имя таблицы (можно без расширения) *)
      fpReadPswd:  PAnsiChar;    (* Пароль для доступа на чтение *)
      fpWritePswd: PAnsiChar;    (* Пароль для доступа на запись *)
      fpAgres:     LPELEMENT;(* Массив структур описаний агрегатов *)
      nAgreCnt:    SmallInt; (* Число элементов *)
      nFirstNo:    SmallInt  (* Номер первого агрегата из группы *)
  ):SmallInt;stdcall;

(* Получить описание элемента открытой таблицы.             *)
(* Первый элемент таблицы имеет номер 1, второй - 2 и т.п.  *)
(* Характеристики элемента берутся из системных переменных. *)
(* Имя элемента считывается из файла описания таблицы, если *)
(* задан флаг чтения, иначе поле имени ничего не содержит.  *)
  Function htTableElement(
      hTable   : THANDLE;   (* Обработчик для таблицы                *)
      nElemNo  : SmallInt;  (* Номер элемента таблицы (от 1)         *)
      Var sElem: ThtElementInfo;   (* Структура для описания элемента       *)
      bReadName: Boolean    (* Для true читать имя элемента из файла *)
  ):SmallInt;stdcall;

(* Получить описание всех элементов открытой таблицы.      *)
(* Первый элемент таблицы имеет номер 1, второй - 2 и т.п. *)
(* Необходимо выделить массив структур длиной по числу     *)
(* элементов таблицы. Число можно узнать из htTableInfo    *)
  Function htTableElementList(
      hTable   : THANDLE;   (* Обработчик для таблицы             *)
      fpElement: LPELEMENT  (* Массив структур описаний элементов *)
  ):SmallInt;stdcall;

(* Определить обработчик для открытой таблицы по имени *)
  Function htTableHandleByName(
      fpTabName    : PAnsiChar;   (* Имя таблицы (можно без расширения) *)
      Var fpHandle : THANDLE  (* Для приема обработчика таблицы     *)
  ):SmallInt;stdcall;

(* Получить параметры открытой таблицы *)
  Function htTableInfo(
      hTable    : THANDLE;   (* Обработчик для таблицы         *)
      Var sTable: TABLE      (* Структура для описания таблицы *)
  ):SmallInt;stdcall;

(* Получить состояние открытой таблицы *)
  Function htTableState(
      hTable    : THANDLE;   (* Обработчик для таблицы         *)
      Var sStat : STATT      (* Структура для описания таблицы *)
  ):SmallInt;stdcall;

(* Открыть доступ к таблице    *)
(* Таблица должна быть закрыта *)
  Function htTableOpen(
      fpTableName : PAnsiChar;    (* Имя таблицы (можно без расширения)  *)
      fpReadPswd  : PAnsiChar;    (* Пароль доступа на чтение            *)
      fpWritePswd : PAnsiChar;    (* Пароль доступа на запись            *)
      nOpenMode   : SmallInt; (* Режим открытия (константы TAB_????) *)
      Var fpHandle: THANDLE   (* Для приема обработчика таблицы      *)
  ):SmallInt;stdcall;

(* Переименовать таблицу                              *)
(* Таблица должна быть закрыта                        *)
(* Переименование возможно лишь в пределах устройства *)
  Function htTableRename(
      fpTableName: PAnsiChar;   (* Имя таблицы (можно без расширения)          *)
      fpReadPswd : PAnsiChar;   (* Пароль доступа на чтение                    *)
      fpWritePswd: PAnsiChar;   (* Пароль доступа на запись                    *)
      fpNewName  : PAnsiChar    (* Новое имя таблицы (можно в другом каталоге) *)
  ):SmallInt;stdcall;

(* Проверить таблицу *)
(* Таблица должна быть закрыта *)
  Function htTableVerify(
      fpTableName: PAnsiChar;   (* Имя таблицы (можно без расширения) *)
      fpReadPswd : PAnsiChar;   (* Пароль доступа на чтение           *)
      fpWritePswd: PAnsiChar;   (* Пароль доступа на запись           *)
      nMode      : SmallInt (* Режим проверки (HTVF_????)         *)
  ):SmallInt;stdcall;

(* Восстановить таблицу адресов постоянной части *)
(* Таблица должна быть закрыта                   *)
  Function htRepairTable(
      fpTableName: PAnsiChar;   (* Имя таблицы (можно без расширения)          *)
      fpReadPswd : PAnsiChar;   (* Пароль доступа на чтение                    *)
      fpWritePswd: PAnsiChar    (* Пароль доступа на запись                    *)
  ):LongInt;stdcall;

(* Восстановить журнал изменений таблицы *)
(* Таблица должна быть закрыта           *)
  Function htRepairTableLog(
      fpTableName: PAnsiChar;   (* Имя таблицы (можно без расширения) *)
      fpReadPswd : PAnsiChar;   (* Пароль доступа на чтение           *)
      fpWritePswd: PAnsiChar;   (* Пароль доступа на запись           *)
      gItemCnt   : LongInt  (* Число элементов к восстановлению   *)
          (*   <0 - число элементов из HDN      *)
          (*   =0 - по умолчанию                *)
          (*   >0 - число элементов из HDR      *)
  ):SmallInt;stdcall;

(* Перенести изменения в постоянную часть таблицы *)
(* Таблица должна быть закрыта                    *)
  Function htUpdateTable(
      fpTableName: PAnsiChar;   (* Имя таблицы (можно без расширения)  *)
      fpReadPswd : PAnsiChar;   (* Пароль доступа на чтение            *)
      fpWritePswd: PAnsiChar;   (* Пароль доступа на запись            *)
      bReIndex   : Boolean; (* Для true перепостроение индексов    *)
      bTestSpace : Boolean  (* Для true проверка места на диске    *)
  ):SmallInt;stdcall;

(*------------- Работа с индексами таблицы ------------*)

(* Построение индексов для ключевых элементов *)
(* Таблица должна быть закрыта                *)
(* Возвращает число отвергнутых записей или код ошибки *)
  Function htBuildIndexes(
      fpTableName: PAnsiChar;    (* Имя таблицы (можно без расширения)  *)
      fpReadPswd : PAnsiChar;    (* Пароль доступа на чтение            *)
      fpWritePswd: PAnsiChar;    (* Пароль доступа на запись            *)
      bTestSpace : Boolean;  (* Проверка пространства на диске      *)
      bDenyOut   : Boolean   (* Для true вывод отвергнутых записей в таблицу *)
  ):LongInt;stdcall;

(* Сменить тип ключа для элемента таблицы *)
(* Таблица должна быть закрыта            *)
(* Возвращает число отвергнутых записей или код ошибки *)
  Function htChangeKeyType(
      fpTableName: PAnsiChar;    (* Имя таблицы (можно без расширения)           *)
      fpReadPswd : PAnsiChar;    (* Пароль доступа на чтение                     *)
      fpWritePswd: PAnsiChar;    (* Пароль доступа на запись                     *)
      nElemNo    : SmallInt; (* Номер элемента таблицы (от 1)                *)
      nNewKeyType: SmallInt; (* Новый тип ключа                              *)
      bTestSpace : Boolean;  (* Проверка пространства на диске               *)
      bDenyOut   : Boolean   (* Для true вывод отвергнутых записей в таблицу *)
  ):LongInt;stdcall;

(* Удаление индексов           *)
(* Таблица должна быть закрыта *)
  Function htDropIndexes(
      fpTableName: PAnsiChar;  (* Имя таблицы (можно без расширения)  *)
      fpReadPswd : PAnsiChar;  (* Пароль доступа на чтение            *)
      fpWritePswd: PAnsiChar   (* Пароль доступа на запись            *)
  ):SmallInt;stdcall;

(*------------- Операции модификации таблицы -------------*)

(* Добавление записи в таблицу                    *)
(* Возвращает физический номер добавленной записи *)
  Function htRecordAdd(
      hTable  : THANDLE;    (* Обработчик для таблицы *)
      fpRecord: Pointer     (* Тело записи            *)
  ):LongInt;stdcall;

(* Удаление записи из таблицы *)
  Function htRecordDelete(
      hTable    : THANDLE;  (* Обработчик для таблицы            *)
      gRecordNo : LongInt   (* Физический номер удаляемой записи *)
  ):SmallInt;stdcall;

(* Модификация записи в таблице *)
  Function htRecordModify(
      hTable    : THANDLE;  (* Обработчик для таблицы                 *)
      gRecordNo : LongInt;  (* Физический номер модифицируемой записи *)
      fpRecord  : Pointer   (* Тело записи                            *)
  ):SmallInt;stdcall;

(*----------- Пакетные операции модификации ------------*)

(* Добавление группы записей в таблицу *)
(* Возвращает число отвергнутых записей или код ошибки *)
  Function htAddRecords(
      hTable    : THANDLE;  (* Обработчик для таблицы                     *)
      gAppendLim: LongInt;  (* Максимальное число записей для добавления  *)
      fpfAddProc: LPAFUNC;  (* Пользовательская функция подготовки данных *)
      fpfErrProc: LPEFUNC;  (* Пользовательская функция обработки ошибок  *)
          (* Nil - ошибки отменяют операцию *)
      fpUser    : Pointer;  (* Доп.параметр пользователя *)
      bDenyOut  : Boolean   (* True - вывод отвергнутых записей в таблицу *)
  ):LongInt;stdcall;

(* Добавление пачки записей в постоянную часть таблицы *)
(* Возвращает число отвергнутых записей или код ошибки *)
  Function htLoadRecords(
      fpTableName: PAnsiChar;   (* Имя таблицы *)
      fpReadPswd : PAnsiChar;   (* Пароль доступа на чтение *)
      fpWritePswd: PAnsiChar;   (* Пароль доступа на запись *)
      gLoadLim   : LongInt; (* Максимальное число записей для добавления  *)
      fpfAddProc : LPAFUNC; (* Пользовательская функция подготовки данных *)
      fpfErrProc : LPEFUNC; (* Пользовательская функция обработки ошибок  *)
                            (* Nil - ошибки отменяют операцию *)
      fpUser     : Pointer; (* Доп.параметр пользователя *)
      bDenyOut   : Boolean  (* Для true вывод отвергнутых записей в таблицу *)
  ):LongInt;stdcall;

(* Удаление подмножества записей из таблицы *)
  Function htDeleteRecords(
      Var fpSrc: SAB    (* Адрес БДС, содержащего подмножество записей *)
  ):LongInt;stdcall;

(* Модификация подмножества записей из таблицы *)
(* Возвращает число отвергнутых записей или код ошибки *)
  Function htModifyRecords(
      Var fpSrc : SAB;      (* Адрес БДС, содержащего подмножество записей *)
      fpfMdfProc: LPMFUNC;  (* Функция модификации записей                 *)
      fpfErrProc: LPEFUNC;  (* Пользовательская функция обработки ошибок   *)
                            (* Nil - ошибки отменяют операцию *)
      fpUser    : Pointer;  (* Доп.параметр пользователя *)
      bDenyOut  : Boolean   (* Для true вывод отвергнутых записей в таблицу *)
  ):LongInt;stdcall;

(* Безусловное добавление группы записей в таблицу *)
(* Добавляются либо все заданные записи, либо ничего *)
(* Появление проблемных записей приводит к отказу от операции *)
  Function htPureAddRecords(
      hTable    : THANDLE;  (* Обработчик для таблицы                     *)
      gAppendLim: LongInt;  (* Максимальное число записей для добавления  *)
      fpfAddProc: LPAFUNC;  (* Пользовательская функция подготовки данных *)
      fpUser    : Pointer   (* Доп.параметр пользователя *)
  ):SmallInt;stdcall;

(* Безусловная модификация подмножества записей из таблицы *)
(* Модифицируются либо все заданные записи, либо ничего *)
(* Появление проблемных записей приводит к отказу от операции *)
  Function htPureModifyRecords(
      Var fpSrc : SAB;      (* Адрес БДС, содержащего подмножество записей *)
      fpfMdfProc: LPMFUNC;  (* Функция модификации записей                 *)
      fpUser    : Pointer   (* Доп.параметр пользователя *)
  ):SmallInt;stdcall;

(*============== Поисковые операции в таблице ===============*)

(*----------------------- Атомарный поиск ------------------------*)
(* Элементы таблицы (поля, группы и подстроки) имеют сквозную     *)
(* нумерацию от 1. Номер 0 отведен для доступа по физическому     *)
(* номеру записи (значение задается как LongInt).                 *)

(* Поиск по условию для элемента таблицы (поля, группы, подстроки) *)
(* Поиск производится в заданном временном снимке таблицы *)
  Function htSearch(
      fpPhoto   : LPSAB;    (* БДС "снимка" (Nil - если первый запрос) *)
      Var fpSave: SAB;      (* БДС для сохранения результата *)
      hTable    : THANDLE;  (* Обработчик для таблицы *)
      nElemNum  : SmallInt;  (* Номер элемента таблицы         *)
          (* (0-физ.номер, 1-первый и т.п.) *)
      nCond     : ThtCondition;(* Условие, см. константы условий *)
      fpValue1  : Pointer;  (* Пеpвое пороговое значение или функция *)
      fpValue2  : Pointer   (* Второе пороговое значение или параметр функции *)
          (* Nil, если не нужно    *)
  ):LPSAB;stdcall;

(* Поиск по условию для элемента таблицы (поля, группы, подстроки) *)
(* Поиск производится в заданном множествев записей таблицы *)
  Function htSubSearch(
      Var fpSet : SAB;      (* БДС множества записей *)
      Var fpSave: SAB;      (* БДС для сохранения результата *)
      hTable    : THANDLE;  (* Обработчик для таблицы *)
      nElemNum  : SmallInt;  (* Номер элемента таблицы         *)
          (* (0-физ.номер, 1-первый и т.п.) *)
      nCond     : ThtCondition;(* Условие, см. константы условий *)
      fpValue1  : Pointer;  (* Пеpвое пороговое значение или функция *)
      fpValue2  : Pointer   (* Второе пороговое значение или параметр функции *)
          (* Nil, если не нужно    *)
  ):LPSAB;stdcall;


(*---------------- Сложные поиски записей ---------------*)

(* Получить записи по списку значений элемента *)
(* Отбираются записи, для которых элемент принимает значения из списка *)
  Function htRecordsByKey(
      Var fpDst : SAB;    (* Для приема результата *)
      Var fpList: SAB     (* Адрес БДС, содержащего список значений *)
  ):LPSAB;stdcall;

(* Найти запись по значению уникального ключа *)
(* Возвращает физ.номер записи с заданным значением ключа *)
(* 0 нет таких записей, <0 - код ошибки *)
  Function htRecordByUniq(
      fpPHO:     LPSAB; (* БДС "снимка" *)
      hTable:    THANDLE; (* Обработчик таблицы *)
      nKeyNo:    SmallInt;  (* Номер ключа (0-физ.номер, 1-первое поле и т.д.) *)
      fpValue:   Pointer; (* Искомоме значение уникального ключа *)
      fphRecord: LPRHANDLE  (* Для обработчика записи *)
  ):LongInt;stdcall;

(* Получить записи для заданного соотношения значений двух элементов *)
(* Отбираются записи, для которых значения элемента nElemNo1 и  *)
(* nElemNo2 удовлетворяют заданному соотношению на подмножестве *)
(* записей fpSrc.  *)
  Function htRecordsForTwoKeys(
      Var fpDst: SAB;       (* Для приема результата *)
      Var fpSrc: SAB;       (* Адрес БДС, содержащего список записей таблицы *)
      nElemNo1 : SmallInt;   (* Номер первого элемента записи *)
      nCond    : ThtCondition; (* Условие сравнения (пока только EQUAL) *)
      nElemNo2 : SmallInt    (* Номер второго элемента записи *)
  ):LPSAB;stdcall;

(* Определить подмножество записей таблицы, попавших в результат сортировки *)
  Function htSortedRecords(
      Var fpDst : SAB;    (* Блок для приема результата *)
      Var fpSort: SAB     (* Результат сортировки       *)
  ):LPSAB;stdcall;

(* Определить подмножество записей таблицы, попавших в результат сортировки, *)
(* для заданного снимка *)
  Function htSortedRecordsEx(
      Var fpDst : SAB;    (* Блок для приема результата *)
      Var fpSort: SAB;    (* Результат сортировки       *)
      Var fpPhoto:SAB     (* Снимок для множества       *)
  ):LPSAB;stdcall;


(*------------ Операции над значениями элемента записи -------------*)

(* Импликация (деление) столбцов таблицы *)
  Function htDivision(
      Var fpDst: SAB;     (* Для приема результата *)
      const fpSET: SAB;     (* Подмножество записей *)
      nElemNo  : SmallInt;(* Номер поля делимого *)
      const fpLST: SAB      (* Список значений делителя *)
  ):LPSAB;stdcall;

(* Получить гистограмму значений элемента для подмножества записей *)
  Function htHistogramOfKey(
      Var fpDst: SAB;     (* Для приема результата *)
      nElemNo  : SmallInt;(* Номер элемента записи *)
      const fpSrc: SAB      (* Подмножество записей *)
  ):SmallInt;stdcall;

(* Получить гистограмму значений элемента с заданным числом повторов *)
  Function htHistogramByCount(
      Var  fpDst: SAB;     (* Для приема результата *)
      nElemNo   : SmallInt;(* Номер элемента записи *)
      const fpSrc : SAB;     (* Подмножество записей  *)
      gMin      : LongInt; (* Минимальное число повторов (не менее 1) *)
      gMax      : LongInt  (* Максимальное число повтоpов             *)
  ):SmallInt;stdcall;

(* Перенести список значений элемента в другую таблицу *)
(* Может быть использована для смены номера элемента *)
  Function htTransferToTable(
      Var fpSrc: SAB;     (* Адpес БДС, содержащего список значений *)
      hTable   : THANDLE; (* Обработчик для другой таблицы          *)
      nElemNo  : SmallInt (* Номер элемента в другой таблице        *)
  ):LPSAB;stdcall;

(* Перенести список значений элемента в заданный "снимок" другой таблицы *)
  Function htTransferToPhoto(
      Var fpSrc  : SAB;    (* Адpес БДС, содержащего список значений *)
      const fpPhoto: SAB;    (* Адрес БДС, содержащего снимок другой таблицы *)
      nElemNo    : SmallInt (* Номер элемента в другой таблице              *)
  ):LPSAB;stdcall;

(* Получить список значений элемента для подмножества записей *)
  Function htValuesOfKey(
      Var fpDst: SAB;     (* Для приема результата *)
      nElemNo  : SmallInt;(* Номер элемента записи *)
      const fpSrc: SAB      (* Подмножество записей *)
  ):LPSAB;stdcall;

(* Получить список значений элемента с заданным числом повторов *)
  Function htValuesByCount(
      Var  fpDst: SAB;     (* Для приема результата *)
      nElemNo   : SmallInt;(* Номер элемента записи *)
      const fpSrc : SAB;     (* Подмножество записей *)
      gMin      : LongInt; (* Минимальное число повторов (не менее 1) *)
      gMax      : LongInt  (* Максимальное число повтоpов             *)
  ):LPSAB;stdcall;


(*----------------- Обработка значений элемента -------------------*)

(* Получить среднее значение элемента для подмножества записей *)
  Function htAverageOfKeyValues(
      Var fpSrc: SAB;     (* Адрес БДС, содержащего подмножество записей *)
      nElemNo  : SmallInt; (* Номер элемента записи *)
      fpAverage: Pointer  (* Сюда поместят среднее значение *)
       (* LongInt для - целочисленных, Double - для действительных *)
  ):SmallInt;stdcall;

(* Получить максимальное значение элемента для подмножества записей *)
  Function htKeyMaximum(
      Var fpSrc: SAB;     (* Адрес БДС, содержащего подмножество записей *)
      nElemNo  : SmallInt; (* Номер элемента записи *)
      fpMax    : Pointer  (* Сюда поместят максимальное значение *)
  ):SmallInt;stdcall;

(* Получить минимальное значение элемента для подмножества записей *)
  Function htKeyMinimum(
     Var fpSrc: SAB;     (* Адрес БДС, содержащего подмножество записей *)
     nElemNo  : SmallInt; (* Номер элемента записи *)
      fpMin   : Pointer  (* Сюда поместят минимальное значение *)
  ):SmallInt;stdcall;

(* Получить сумму значений элемента для подмножества записей *)
  Function htSumOfKeyValues(
      Var fpSrc: SAB;     (* Адрес БДС, содержащего подмножество записей *)
      nElemNo  : SmallInt; (* Номер элемента записи *)
      fpSum    : Pointer  (* Сюда поместят сумму значений элемента *)
     (* LongInt для - целочисленных, Double - для действительных *)
  ):SmallInt;stdcall;

(*--------- Логические операции над результатами поиска ---------*)

(* Уточнение результата условием *)
  Function htAndResults(
      Var fpDst : SAB;    (* Блок для приема результата *)
      const fpSrc1: SAB;    (* Блок с первым результатом  *)
      const fpSrc2: SAB     (* Блок со вторым результатом *)
  ):LPSAB;stdcall;

(* Расширение результата условием *)
  Function htOrResults(
     Var fpDst : SAB;    (* Блок для приема результата *)
     const fpSrc1: SAB;    (* Блок с первым результатом  *)
     const fpSrc2: SAB     (* Блок со вторым результатом *)
  ):LPSAB;stdcall;

(* Отрицание результата *)
  Function htNotResults(
     Var fpDst: SAB;    (* Блок для приема результата    *)
     const fpSrc: SAB     (* Блок с отрицаемым результатом *)
  ):LPSAB;stdcall;

(* Дополнение? результата *)
  Function htXorResults(
     Var fpDst : SAB;    (* Блок для приема результата    *)
     const fpSrc1: SAB;    (* Блок с первым операндом       *)
     const fpSrc2: SAB     (* Блок со вторым операндом      *)
  ):LPSAB;stdcall;

{$IFDEF HT_NEWDLL}
(* Исключение результата *)
  Function htExcludeResults(
     Var fpDst : SAB;    (* Блок для приема результата    *)
     const fpSrc1: SAB;    (* Блок с первым операндом       *)
     const fpSrc2: SAB     (* Блок со вторым операндом      *)
  ):LPSAB;stdcall;

(* Исключение результата *)
  Function htRecordsByValues(
     Var fpDst : SAB;       (* Блок для приема результата    *)
     fpPHO     : LPSAB;     (* БДС "снимка" *)
     nKeyNo    : SmallInt;  (* Номер ключа (0-физ.номер, 1-первое поле и т.д.) *)
     nCond     : SmallInt;  (*  0 - in, 1 - not in *)
     fpValues  : Pointer;   (* Список значений ключа *)
     gCount    : longint    (* Количество значений *)
  ):SmallInt;stdcall;

  (* Функция возвращает указатель на строку содержащую сообщение *)
(* в зависимости от типа ошибки (В/В или прочие), например:    *)
(*  "Нет памяти для работы" или                                *)
(*  "Ошибка открытия d:\xxxx файл не найден".                  *)
  Function  htLastErrorText(
      lpszBuff: PAnsiChar;   (* Буфер для приема текста сообщения *)
      nBuffSize : longint
  ):longint;stdcall;
{$endif}

(*---------------- Операции над группами  -----------------*)
(* В результате выполнения операции образуется массив элементов. *)
(* Каждый элемент содержит значения полей, входящих в группу, за *)
(* которыми следуют значения функционалов для заданных полей.    *)

(* Отработка групповой операции на подмножестве записей таблицы *)
(* На каждое сформированное значение группы вызывается функция  *)
(* fpfHavingTo, которая может выполнить обработку значения и    *)
(* примет решению о выводе данного элемента группы. *)
  Function htGroupByHavingTo(
      Var fpDst  : SAB;      (* Блок для приема результата              *)
      const fpSrc  : SAB;      (* БДС, задающий подмножество записей      *)
      fpnGroup   : PSmallInt;(* Номера полей, образующих группу         *)
      nGroupCnt  : SmallInt; (* Число таких полей (до MAX_SORT_ORDER+1) *)
      fpsFunc    : LPGROUP;  (* Описатели вычислимых выражений          *)
      nFuncCnt   : SmallInt; (* Их число                                *)
      fpfHavingTo: LPHAVING; (* Функция, реализующая условие HavingTo   *)
      fpUser     : Pointer   (* Доп.параметр пользователя *)
  ):SmallInt;stdcall;

(* Отработка групповой операции на подмножестве записей таблицы *)
(* контролируемая пользователем *)
  Function htGroupByUser(
      Var fpDst  : SAB;      (* Блок для приема результата              *)
      const fpSrc  : SAB;      (* БДС, задающий подмножество записей      *)
      fpnGroup   : PSmallInt;(* Номера полей, образующих группу         *)
      nGroupCnt  : SmallInt; (* Число таких полей (до MAX_SORT_ORDER+1) *)
      fpsFunc    : LPGROUP;  (* Описатели вычислимых выражений          *)
      nFuncCnt   : SmallInt; (* Их число                                *)
      fpfSort  : LPOFUNC;  (* Функция сравнения для сортировки        *)
      fpfDiff  : LPOFUNC;  (* Функция сравнения для группировки       *)
      fpfHavingTo: LPHAVING; (* Функция, реализующая условие HavingTo   *)
      fpUser     : Pointer   (* Доп.параметр пользователя *)
  ):SmallInt;stdcall;

(* Построение списка значений ключа по результатам группировки *)
(* Доступ к исходным результатам должен быть закрыт *)
  Function htValuesFromGroup(
      Var fpDst  : SAB;      (* Блок для приема списка значений ключа    *)
      nKeyNo     : SmallInt; (* Номер поля, значения которого собираются *)
      wOffset    : Word;     (* Смещение начала поля в группе            *)
      const fpSrc  : SAB       (* БДС, задающий результаты группировки     *)
  ):LPSAB;stdcall;

(*---------------- Межтабличные операции  -----------------*)

(* Слияние двух таблиц через общий элемент *)
  Function htTablesJoin(
      Var fpDst : SAB;       (* Блок для приема результата               *)
      Var fpFRST: SAB;       (* Условие для первой таблицы               *)
      nFiElNo   : SmallInt;  (* Номер элемента-связки в первой таблице   *)
      nCond     : ThtCondition; (* Тип слияния (пока только EQUAL)          *)
      Var fpSCND: SAB;       (* Условие для второй таблицы               *)
      nScElNo   : SmallInt;  (* Номер элемента-связки во второй таблице  *)
      fpCOND    : LPSAB;     (* Если не Nil, выполняется отбор  записей, *)
           (* попавших в JOIN, для одной из таблиц     *)
      bFirst    : Boolean;   (* Если true, то отбор записей из первой    *)
           (* таблицы                                  *)
      nMode     : SmallInt   (* Режим отобра неполных пар *)
  ):LPSAB;stdcall;

(* Объединение/слияние нескольких связанных таблиц *)
  Function htTablesLink(
      Var fpDst: SAB;    (* Блок для приема результата         *)
      const fpGroup: SAB;  (* Группа связанных таблиц            *)
      const fpPair: SAB;   (* Пара связанных таблиц              *)
      bSkipLink: Boolean;(* Для true выходная группа будет без *)
       (* таблицы-связки                     *)
      nMode: SmallInt     (* Режим работы (DRAFT_??? Or LINK_???*)
  ):LPSAB;stdcall;


(* Определить подмножество записей таблицы, попавших в слияние *)
  Function htJoinedRecords(
      fpStart    : LPSAB;  (* "Снимок" таблицы для подмножества *)
      Var fpDst  : SAB;    (* Блок для приема результата        *)
      const fpGroup: SAB;    (* Группа связанных таблиц           *)
      nTabNo     : SmallInt (* Номер таблицы группе таблиц (отсчет от 0) *)
  ):LPSAB;stdcall;

(* Определить число таблиц в выходной группе таблиц и *)
(* порядок их расположения. Возвращает число таблиц и *)
(* заполняет массив обработчиками таблиц в порядке их *)
(* расположения в выходной группе. Размер массива для *)
(* приема обработчиков подсхе должен быть не менее    *)
(* константы MAX_TAB_LINK                             *)
(* Если обработчики не нужны, можно задать Nil        *)
  Function htTellJoinOrder(
      Var fpSrc: SAB;       (* Результат связи                 *)
      fpHandles: LPTHANDLE  (* Сюда занесут обработчики таблиц *)
  ):SmallInt;stdcall;

(* Определить характеристики элемента одной из таблиц,  *)
(* входящих в группу слияния. Смещение элемента будет   *)
(* определено от начала обобщенной записи, т.е. записи, *)
(* состоящей из записей всех таблиц группы.             *)
  Function htJoinElement(
      Var fpSrc: SAB;       (* Результат связи                       *)
      nTableNo : SmallInt;   (* Номер таблицы в группе таблиц (от 1)  *)
      nElemNo  : SmallInt;   (* Номер элемента в таблице (от 0, включая физ.номер) *)
      fpElement: LPELEMENT; (* Структура для описания элемента       *)
      bReadName: Boolean    (* Для true читать имя элемента из файла *)
  ):SmallInt;stdcall;

(*----------------------- Кластеры ----------------------*/

(* Создать кластерную таблицу для связки таблиц *)
  Function htCreateClusterTable(
      Var fpLink:  SAB;       (* БДС со связкой таблиц *)
      fpTableName: PAnsiChar;     (* Имя таблицы кластеров *)
      fpCryptoKey: PAnsiChar;     (* Ключ для крипто-закрытия данных *)
      fpReadPswd : PAnsiChar;     (* Пароль для доступа на чтение *)
      fpWritePswd: PAnsiChar;     (* Пароль для доступа на запись *)
      bIndex:    Boolean    (* True - индексировать таблицу кластеров *)
  ):SmallInt;stdcall;

(* Преобразовать запись кластерной таблицы в результат связи таблиц *)
  Function htClusterItemToLink(
      Var fpDst: SAB;     (* Для приема результата *)
      hTable:  THANDLE;     (* Таблица кластеров *)
      hRecord: RHANDLE;     (* Запись таблицы кластеров *)
      fpHandles: LPTHANDLE  (* Обработчики связываемых таблиц *)
  ):LPSAB;stdcall;

(* Преобразовать записи кластерной таблицы в результат связи таблиц *)
  Function htClusterRecsToLink(
      Var fpDst: SAB;     (* Для приема результата *)
      const fpSrc: SAB;     (* Записи таблицы кластеров *)
      fpHandles: LPTHANDLE  (* Обработчики связываемых таблиц *)
  ):LPSAB;stdcall;

(*----------------------- Фильтры ----------------------*)

(* Фильтрация списка записей пользователем *)
(* Можно заказать выборку некоторых полей записи *)
  Function htFilterRecords(
      Var fpDst: SAB;      (* Для приема результата *)
      const fpSrc: SAB;      (* Адрес БДС, содержащего список записей *)
      fpFieldNo: PSmallInt;(* Номера полей, подлежащих выборке из записи *)
         (* Nil - все поля записи *)
      nFieldCnt: SmallInt; (* Число выбираемых полей *)
      fpfFilter: LPSFUNC;  (* Адрес пользовательской функции фильтрации *)
      fpUser   : Pointer   (* Доп.параметр пользователя *)
  ):LPSAB;stdcall;

(* Фильтрация записей группы связаных таблиц *)
  Function htFilterTables(
      Var fpDst: SAB;      (* Для приема результата *)
      fppSABs:   LPPSAB;   (* Группа таблиц и подмножества записей в них *)
      nTableCnt: SmallInt; (* Число таблиц (БДС'ов) *)
      fpFieldNo: PSmallInt;(* Номера полей таблиц для анализа *)
      nFieldCnt: SmallInt; (* Число выбираемых полей *)
      fpLinks:   LPLINK;   (* Описатели связей таблиц *)
      nLinkCnt:  SmallInt; (* Число связей *)
      fpfFilter: LPSFUNC;  (* Адрес пользовательской функции фильтрации *)
      fpUser   : Pointer;  (* Доп.параметр пользователя *)
      nMode    : SmallInt  (* Режимы связывания таблиц *)
  ):LPSAB;stdcall;

(*------------ Работа с результатами поиска ------------*)

(* Удалить результаты поиска для БДС {HTCOD2] *)
  Procedure htClearResults( Var fpSrc: SAB );stdcall;

(* Закрыть доступ к результатам поиска в БДС *)
  Procedure htCloseResults(const fpSrc: SAB );stdcall;

(* Скопировать результаты поиска                    *)
(* Доступ к исходным результатам должен быть закрыт *)
  Function htCopyResults(
      var fpDst: SAB;      (* Адрес БДС для приема копии *)
      const fpSrc: SAB       (* Адрес исходного БДС        *)
  ):SmallInt;stdcall;

(* Уникализовать результаты поиска по заданным полям *)
(* Доступ к исходным результатам должен быть закрыт  *)
  Function htDistinctResults(
      Var fpDst: SAB;      (* Для приема уникализованных результатов *)
      const fpSrc: SAB;      (* Неуникализованные результаты поиска    *)
      fpFieldNo: PSmallInt;(* Список полей - критериев уникализации  *)
			   (* Nil - по всей записи в совокупности    *)
      nFieldCnt: SmallInt  (* Число полей-критериев                  *)
  ):SmallInt;stdcall;

(* Уникализовать результаты поиска по счетчику повторов *)
(* Оставляет те результаты, число повторов которых по   *)
(* заданному критерию попадает в определенный диапазон  *)
(* Доступ к исходным результатам должен быть закрыт *)
  Function htDistinctResultsByCount(
      Var fpDst: SAB;      (* Для приема уникализованных результатов *)
      const fpSrc: SAB;      (* Неуникализованные результаты поиска    *)
      fpFieldNo: PSmallInt;(* Список полей - критериев уникализации  *)
			   (* Nil - по всей записи в совокупности    *)
      nFieldCnt: SmallInt; (* Число полей-критериев                  *)
      gMin:	 LongInt;  (* Минимальное число повторов *)
      gMax:	 LongInt   (* Максимальное число повторов *)
  ):SmallInt;stdcall;

(* Открыть доступ к результатам поиска в БДС *)
  Function htOpenResults(
      const fpSrc: SAB;      (* Адрес исходного БДС                       *)
      (* Следующие параметры имеют смысл только для результатов-записей *)
      nMode   : SmallInt;  (* Режим открытия (см.ROPEN_????)            *)
      fpElemNo: PSmallInt; (* Номера читаемых элементов записи          *)
         (* Если Nil - выводятся все элементы записи  *)
      nElemCnt: SmallInt   (* Число выводимых элементов                 *)
  ):SmallInt;stdcall;

(* Читать результаты поиска из БДС                      *)
(* Возвращает число считанных байтов.                   *)
(* Размер читаемого блока не более MAX_BUF_LEN байтов.  *)
(* Коды возврата от MAX_BUF_LEN до $FFFF - коды ошибок *)
  Function htReadResults(
      const fpSrc: SAB;        (* Адрес исходного БДС     *)
      fpBuff   : Pointer;    (* Буфер для чтения данных *)
      wLen     : Cardinal    (* Длина буфера            *)
  ):Cardinal;stdcall;

(* Определить длину одного элемента результата *)
(* Доступ к результатам должен быть открыт     *)
  Function htResultsItemLen(
      const fpSrc   : SAB;     (* Адрес исходного БДС *)
      Var wItemLen: Cardinal (* Длина элемента      *)
  ):SmallInt;stdcall;

(* Определить число полей отбора в открытом результате *)
  Function htResultsItemCnt(
      const fpSAB: SAB    (* Адрес открытого БДС *)
  ): SmallInt;stdcall;

(* Получить описатели полей отбора в открытом результате *)
  Function htResultsItemParm(
      const fpSAB: SAB;   (* Адрес открытого БДС *)
      fpParm: LPOPEL          (* Для приема параметров *)
  ): SmallInt;stdcall;

(* Перемещение логического указателя по результатам поиска *)
  Function htSeekResults(
      const fpSrc : SAB;        (* Адрес исходного БДС  *)
      gOffset   : LongInt;    (* Величина перемещения *)
      nFromWhere: RSEEK_MODE  (* Режим перемещения    *)
  ):LongInt;stdcall;

(* Получить порядковый номер записи по ее физическому номеру. *)
(* Отсчет от 0. Доступ к результатам должен быть открыт. *)
(* Имеет смысл для результатов типа RES_RCRD *)
  Function htRecordOrdinalNumber(
      const fpSrc : SAB;        (* Адрес исходного БДС *)
      gNumber   : LongInt     (* Физический номер *)
  ):LongInt;stdcall;

(* Установить маркер на текущую запись открытого результата поиска *)
  Function htMarkRecord(
      const fpSrc   : SAB;   (* Адрес открытого для чтения БДС *)
      Var fpMark  : MARKER     (* Маркер записи *)
  ):SmallInt;stdcall;

(* Установить маркер на текущую запись одной из таблиц слияния *)
  Function htMarkJoinedRecord(
      const fpSrc   : SAB;   (* Адрес открытого для чтения БДС *)
      nTabNo      : SmallInt;  (* Номер таблицы группе таблиц (отсчет от 0) *)
      Var fpMark  : MARKER     (* Маркер записи *)
  ):SmallInt;stdcall;

(* Установить маркер на текущую запись слияния таблиц *)
  Function htMarkJoinedRecordEx(
      const fpSrc   : SAB;   (* Адрес открытого для чтения БДС *)
      fpMark   : LPMARK    (* Массив маркеров (по числу таблиц) *)
  ):SmallInt;stdcall;

(* Перемещение логического указателя на установленный ранее маркер *)
  Function htSeekMarkedJoin(
      const fpSrc   : SAB;   (* Адрес открытого для чтения БДС *)
      nTabNo      : SmallInt;  (* Номер таблицы группе таблиц (отсчет от 0) *)
      Var fpMark  : MARKER     (* Маркер записи *)
  ):SmallInt;stdcall;

(* Перемещение логического указателя на маркированную связку *)
  Function htSeekMarkedJoinEx(
      const fpSrc   : SAB;   (* Адрес открытого для чтения БДС *)
      fpMark   : LPMARK    (* Массив маркеров (по числу таблиц) *)
  ):SmallInt;stdcall;

(* Перемещение логического указателя на установленный ранее маркер *)
  Function htSeekMarkedRecord(
      const fpSrc   : SAB;   (* Адрес открытого для чтения БДС *)
      Var fpMark  : MARKER     (* Маркер записи *)
  ):SmallInt;stdcall;

(* Сортировка результатов поиска (если это записи)       *)
(* Положительный номер ключа - сортировка по возрастанию *)
(* Отрицательный номер ключа - сортировка по убыванию    *)
  Function htSortResults(
      Var fpDst: SAB;        (* Для приема результата        *)
      const fpSrc: SAB;        (* Адрес исходного БДС          *)
      mOrder   : PSmallInt;  (* Номера ключей упорядочивания *)
      nOrderCnt: SmallInt    (* Число ключей упорядочивания  *)
  ):SmallInt;stdcall;

(* Сортировка результатов поиска под контролем пользователя *)
   Function htSortResultsByUser(
      Var fpDst: SAB;        (* Для приема результата        *)
      const fpSrc: SAB;        (* Адрес исходного БДС          *)
      mOrder   : PSmallInt;  (* Номера ключей упорядочивания *)
      nOrderCnt: SmallInt;   (* Число ключей упорядочивания  *)
      fpfComp  : LPOFUNC;    (* Функция сравнения элементов  *)
      fpUser   : Pointer     (* Параметр пользователя для функции *)
   ):SmallInt;stdcall;

(* Проверить адекватность результатов поиска.        *)
(* Имеет смысл для всех результатов, кроме RES_JOIN. *)
  Function htIsResultObsolete(
      Var fpSrc   : SAB     (* Результаты поиска  *)
  ):LPSAB;stdcall;

(* "Сравнять" результаты поиска (записи), привести  *)
(* их в соответствие с заданным состоянием таблицы. *)
(* Доступ к исходным результатам должен быть закрыт *)
  Function htSyncResults(
      Var fpFresh : SAB;    (* Блок для приема "свежего" результата *)
      const fpPhoto : SAB;    (* Блок с заданным снимком *)
      const fpOld   : SAB     (* Блок со старым результатом  *)
  ):LPSAB;stdcall;

(* "Освежить" результаты поиска (записи), привести  *)
(* их в соответствие с текущим состоянием таблицы.  *)
(* Доступ к исходным результатам должен быть закрыт *)
  Function htTouchResults(
      Var fpFresh : SAB;    (* Блок для приема "свежего" результата *)
      const fpOld   : SAB     (* Блок со старым результатом  *)
  ):LPSAB;stdcall;

(* Определить номер элемента, для которого получен результат в БДС *)
(* Имеет смысл для результатов типа RES_VALUE и RES_HISTO.         *)
  Function htResultsElement(
      const fpSrc   : SAB;     (* Адрес исходного БДС  *)
      Var fpElemNo: SmallInt  (* Номер элемента *)
  ):SmallInt;stdcall;

(* Определить таблицу, для которой получен результат в БДС *)
(* Имеет смысл для всех результатов, кроме RES_JOIN.       *)
  Function htResultsTable(
      const fpSrc   : SAB;    (* Адрес исходного БДС                    *)
      Var fpHandle: THANDLE (* Таблица, для которой получен результат *)
  ):SmallInt;stdcall;

(* Определить тип результата для БДС     *)
(* Возвращает одну из констант RES_????? *)
  Function htResultsType(const  fpSrc: SAB ):SmallInt;stdcall;

(* Освободить память из-под результата   *)
(* Переносит результаты из памяти в файл *)
  Function htResultsToHard( Var fpSrc: SAB ):SmallInt;stdcall;

(* Проверить, открыт ли доступ к результатам поиска *)
(* 0 - нет, !=0 - да *)
  Function htIsResultOpen( Var fpSrc: SAB ):Boolean;stdcall;

(* Подменить обработчик таблицы в результатах на дубль *)
(* Результаты должны быть закрыты *)
  Function htReplaceResultsTable(
      const fpSrc : SAB;     (* Адрес исходного БДС       *)
      hTable    : THANDLE; (* Другой обработчик таблицы *)
      nTabNo    : SmallInt (* Порядковый номер таблицы для JOIN (от 0) *)
  ):SmallInt;stdcall;


(*---------- Работа с отдельными записями ----------*)

(* Определить обработчик записи по физ.номеру и снимку *)
(* Если снимок пуст (Nil), берется последнее состояние таблицы *)
  Function htHandleFromRecNo(
      fpPHO: LPSAB;   (* Снимок для записи *)
      hTable: THANDLE;  (* Обработчик таблицы *)
      gRecNo:LongInt;   (* Номер записи *)
      Var fphHandle:RHANDLE (* Для приема обработчика *)
  ):SmallInt;stdcall;

(* Определить номер записи по обработчику *)
  Function htRecNoFromHandle(
      hTable: THANDLE;  (* Обработчик таблицы *)
      hHandle: RHANDLE  (* Обработчик записи *)
  ):LongInt;stdcall;

(* Добавление записи в таблицу. Аналогична htRecordAdd, *)
(* но возвращает также обработчик добавленной записи. *)
  Function htHandleAdd(
      hTable: THANDLE;  (* Обработчик для таблицы *)
      fpRecord: Pointer;  (* Тело записи *)
      Var fphRecord: RHANDLE  (* Обработчик добавленной записи *)
  ):LongInt;stdcall;

(* Модификация записи в таблице. Аналогична htRecordModify, *)
(* но возвращает также обработчик модифицированной записи. *)
  Function htHandleModify(
      hTable: THANDLE;  (* Дескриптор таблицы *)
      gRecNumber: LongInt;  (* Номер модифицируемой записи *)
      fpRecord: Pointer;  (* Тело записи *)
      Var fphRecord: RHANDLE  (* Обработчик измененной записи *)
  ):SmallInt;stdcall;

(* Считать тело записи по ее номеру в пределах "снимка" *)
(* Если снимка нет (Nill), читает последнее состояние записи *)
  Function htReadRecord(
      fpPHO: LPSAB;   (* Снимок для записи *)
      hTable: THANDLE;  (* Дескриптор таблицы *)
      gRecNo: LongInt;  (* Номер читаемой записи *)
      fpBody: Pointer   (* Для приема тела записи *)
  ):SmallInt;stdcall;

(* Считать запись по ее обработчику *)
(* Проверки корректности обработчика не производится *)
  Function htReadRecordByHandle(
      hTable: THANDLE;  (* Обработчик таблицы *)
      hHandle: RHANDLE; (* Обработчик читаемой записи *)
      fpRecord: Pointer (* Для приема тела записи C НОМЕРОМ *)
  ):SmallInt;stdcall;

(*---------- Редактирование результатов поиска ----------*)

(* Создать пустой результат для таблицы *)
  Function htCreateEmptySAB(
      fpPHO: LPSAB;   (* Снимок таблицы *)
      Var fpSAB: SAB;   (* Адрес БДС *)
      hTable: THANDLE;  (* Обработчик таблицы *)
      nItemNo: SmallInt;  (* Номер элемента *)
      nType: SmallInt   (* Тип БДС (см.RES_????) *)
  ):LPSAB;stdcall;

(* Создать пустой результат для связки таблиц *)
  Function htCreateEmptyJoin(
      Var fpSAB: SAB;   (* БДС *)
      fphTabs: LPTHANDLE; (* Обработчики таблиц *)
      nTabCnt: SmallInt (* Число таблиц *)
  ):LPSAB;stdcall;

(* Исключить элемент из результатов поиска *)
(* Доступ к исходным результатам должен быть открыт *)
  Function htExcludeResultsItem(
      const fpSrc: SAB;   (* Адрес исходного БДС *)
      gItemNo: LongInt  (* Порядковый номер элемента (от 0) *)
                        (* RES_RECORD - физ.номер записи *)
  ):SmallInt;stdcall;

(* Считать элемент результата поиска - обработчик записи(ей) *)
(* Доступ к исходным результатам должен быть открыт *)
(* Допустим для результатов RES_SORTED и RES_JOIN *)
  Function htGetResultsItem(
      const fpSrc: SAB;   (* Адрес исходного БДС *)
      gItemNo: LongInt; (* Порядковый номер элемента (от 0) *)
      fpItem: LPRHANDLE       (* Для чтения элемента результата *)
      (* Длина элемента определяется типом результата: *)
      (* RES_SORTED - sizeof(RHANDLE) *)
      (* RES_JOIN - sizeof(RHANDLE) * число_таблиц_слияния *)
  ):SmallInt;stdcall;

(* Добавить пачку элементов в результаты поиска *)
(* Доступ к исходным результатам должен быть открыт *)
  Function htIncludeResultsBlock(
      const fpSrc: SAB;         (* Адрес исходного БДС *)
      gInsPos: LongInt;       (* Позиция вставки элемента (отсчет от 0) *)
                              (* RES_RECORD - не имеет смысла *)
      fpBlock: Pointer;       (* Пачка новых элементов результата *)
      wBlockLen: Cardinal     (* Длина пачки в байтах *)
  ):SmallInt;stdcall;


(* Добавить элемент в результаты поиска *)
(* Доступ к исходным результатам должен быть открыт *)
  Function htIncludeResultsItem(
      const fpSrc: SAB;   (* Адрес исходного БДС *)
      gItemNo: LongInt; (* Позиция вставки элемента (отсчет от 0) *)
            (* RES_RECORD - физ.номер записи *)
      fpNewItem: Pointer  (* Новый элемент результата: *)
        (* RES_SORTED - обработчик записи *)
        (* RES_JOIN - группа обработчиков записей для таблиц слияния *)
        (* RES_VALUE, RES_HISTO, RES_GROUP - тело элемента *)
  ):SmallInt;stdcall;

(* Заменить элемент в результатах поиска *)
(* Доступ к исходным результатам должен быть открыт *)
  Function htReplaceResultsItem(
      const fpSrc: SAB;   (* Адрес исходного БДС *)
      gItemNo: LongInt; (* Позиция элемента (отсчет от 0) *)
      fpNewItem: Pointer  (* Новый элемент результата: *)
        (* RES_SORTED - обработчик записи *)
        (* RES_JOIN - группа обработчиков записей для таблиц слияния *)
        (* RES_VALUE, RES_HISTO, RES_GROUP - тело элемента *)
  ):SmallInt;stdcall;

(*---------- Вывод результатов поиска в таблицу ----------*)

(* Преобразование результатов в таблицу                                 *)
(* Выполняется чтение результатов и запись их в таблицу hOutTable.      *)
(* На каждый элемент результата выполняется вызов fpfRecProc(), которая *)
(* может произвести необходимую доработку элемента результата по прев-  *)
(* ращению его в запись таблицы hOutTable. Каждая запись этой таблицы   *)
(* проверяется на допустимость значений. В случае ошибки вызывается     *)
(* функция fpfErrProc. Для результатов-записей (RES_RECORD, RES_SORTED, *)
(* RES_JOIN) могут быть заданы номера полей, которые будут отбираться   *)
(* для формирования выходной записи.                                    *)
(* Возвращает число отвергнутых записей или код ошибки *)
  Function htResultsToTable(
      const fpSrc : SAB;      (* Адрес исходного БДС                       *)
      hOutTable : THANDLE;  (* Обработчик для заполняемой таблицы        *)
      fpfRecProc: LPRFUNC;  (* Пользовательская функция обработки записи *)
          (* Nil - обработка не нужна (все готово)     *)
      fpfErrProc: LPEFUNC;  (* Пользовательская функция обработки ошибок *)
          (* Nil - ошибки прерывают ввод               *)
      fpUser    : Pointer;  (* Доп.параметр пользователя                 *)
      (* Следующие имеют смысл для результатов - записей *)
      fpElemNo  : PSmallInt;(* Номера выводимых элементов исх.записи     *)
      nElemCnt  : SmallInt; (* Число выводимых элементов                 *)
      bDenyOut  : Boolean;  (* Для true вывод отвергнутых записей в таблицу  *)
      bCorrect  : Boolean   (* Для true коррекция суррогатного и авто-ключей *)
  ):LongInt;stdcall;

(*------------------- Управление доступом ------------------*)

(* Сменить крипто-ключ закрытия данных *)
(* Таблица должна быть закрыта         *)
  Function htChangeCryptoKey(
      fpTableName: PAnsiChar;   (* Имя таблицы (можно без расширения) *)
      fpReadPswd : PAnsiChar;   (* Пароль доступа на чтение           *)
      fpWritePswd: PAnsiChar;   (* Пароль доступа на запись           *)
      fpOldCrypto: PAnsiChar;   (* Старый крипто-ключ закрытия данных *)
      fpNewCrypto: PAnsiChar;   (* Новый крипто-ключ закрытия данных  *)
      bReIndex   : Boolean  (* Перепостроить индексы *)
  ):SmallInt;stdcall;

(* Сменить пароль доступа на чтение *)
(* Таблица должна быть закрыта      *)
  Function htChangeReadPassword(
      fpTableName  : PAnsiChar; (* Имя таблицы (можно без расширения) *)
      fpWritePswd  : PAnsiChar; (* Пароль доступа на запись           *)
      fpOldReadPswd: PAnsiChar; (* Старый пароль доступа на чтение    *)
      fpNewReadPswd: PAnsiChar  (* Новый пароль доступа на чтение     *)
  ):SmallInt;stdcall;

(* Сменить пароль доступа на запись *)
(* Таблица должна быть закрыта      *)
  Function htChangeWritePassword(
      fpTableName   : PAnsiChar;  (* Имя таблицы (можно без расширения) *)
      fpReadPswd    : PAnsiChar;  (* Пароль доступа на чтение           *)
      fpOldWritePswd: PAnsiChar;  (* Старый пароль доступа на запись    *)
      fpNewWritePswd: PAnsiChar   (* Новый пароль доступа на запись     *)
  ):SmallInt;stdcall;

(*-------------------- Сетевая поддержка -------------------*)

(* Определить свободные от захвата записи и захватить их *)
  Function htHoldFreeRecords(
      hTable   : THANDLE;  (* Обработчик таблицы                           *)
      Var fdDst: SAB       (* Блок для списка свободных от захвата записей *)
  ):LPSAB;stdcall;

(* Захватить запись таблицы *)
  Function htHoldRecord(
      hTable: THANDLE;   (* Обработчик таблицы         *)
      gRecNo: LongInt    (* Номер захватываемой записи *)
  ):SmallInt;stdcall;

(* Захватить запись таблицы и считать ее тело *)
  Function htHoldReadRecord(
      hTable  : THANDLE; (* Обработчик таблицы         *)
      gRecNo  : LongInt; (* Номер захватываемой записи *)
      fpRecord: Pointer  (* Для приема тела записи *)
  ):SmallInt;stdcall;

(* Захватить результаты поиска - множество записей *)
  Function htHoldResults( Var fpSrc: SAB ):SmallInt;stdcall;

(* Захватить таблицу целиком *)
  Function htHoldTable( hTable: THANDLE ):SmallInt;stdcall;

(* Освободить захваченную запись таблицы *)
  Function htReleaseRecord(
      hTable: THANDLE;   (* Обработчик таблицы         *)
      gRecNo: LongInt    (* Номер захватываемой записи *)
  ):SmallInt;stdcall;

(* Освободить захваченные результаты поиска - множество записей *)
  Function htReleaseResults( Var fpSrc: SAB ):SmallInt;stdcall;

(* Освободить захваченную таблицу *)
  Function htReleaseTable( hTable: THANDLE ):SmallInt;stdcall;

(* Установить таймаут для сетевых операций *)
  Procedure htSetLockTimeOut(
      Second:Word             (* Величина таймаута в секундах *)
  );stdcall;

(*------------------- Поддержка транзакций -----------------*)

(* Установить таймаут для транзакций *)
  Procedure htSetTransTimeOut(
      Second:Word             (* Величина таймаута в секундах *)
  );stdcall;

(* Начать транзакцию на группе таблиц *)
  Function htStartTransaction(
      fpTables:   LPTHANDLE;  (* Список обработчиков таблиц *)
      nTabCnt :   SmallInt;   (* Число таблиц в списке *)
      Var fpTrans:TRID        (* Для приема идентификатора транзакции *)
  ):SmallInt;stdcall;

(* Успешное завершение транзакции *)
  Function htCommitTransaction(
      Var fpTrans:TRID        (* Идентификатор транзакции *)
  ):SmallInt;stdcall;

(* Аварийное завершение транзакции *)
  Function htRollBackTransaction(
      Var fpTrans:TRID        (* Идентификатор транзакции *)
  ):SmallInt;stdcall;

(* Проверить необходимость отката транзакции для таблицы *)
(* Можно вызывать после получения ошибки HT_ERR_TRT_ROLLED *)
(* при поиске таблиц, вызвавших эту ошибку и их транзакции *)
  Function htIsNeedToRoll(
      hTable     : THANDLE;   (* Обработчик таблицы *)
      Var fpTrans:TRID        (* Идентификатор транзакции *)
  ):SmallInt;stdcall;

(* Проверить принадлежность таблицы какой-либо транзакции *)
  Function htIsTransactionalTable(
      hTable     : THANDLE    (* Обработчик таблицы *)
  ):SmallInt;stdcall;

(*--------------------- Кодификаторы ----------------------*)
(* Кодификатор - упорядоченные пары {ключ:толкование}.     *)
(* Используются для расширенного толкования значений ключа *)
(* при операциях чтения результатов.                       *)
(* Длина толкования ключа не может быть короче ключа.      *)
(* Перед использованием кодификатор должен быть загружен   *)
(* в память.   *)

(* Получить информацию о кодификаторе *)
  Function htCoderInfo(
      hCoder    : CHANDLE;      (* Обработчик кодификатора *)
      Var fpInfo: CODINF        (* Структура для заполнения *)
  ):SmallInt;stdcall;

(* Найти ключ для заданного толкования *)
  Function htFindCoderKey(
      hCoder : CHANDLE;      (* Обработчик кодификатора *)
      fpKey  : Pointer;      (* Для приема значения ключа *)
      fpValue: Pointer       (* Тестируемое значение толкования *)
  ):SmallInt;stdcall;

(* Найти для заданного ключа его толкование *)
  Function htFindCoderValue(
      hCoder : CHANDLE;      (* Обработчик кодификатора *)
      fpKey  : Pointer;      (* Тестируемое значение ключа *)
      fpValue: Pointer       (* Для приема значения толкования *)
  ):SmallInt;stdcall;

(* Загрузить кодификатор в память *)
(* Таблица может быть уже открыта *)
  Function htLoadCoder(
      fpTableName : PAnsiChar;    (* Имя таблицы (можно без расширения) *)
      fpReadPswd  : PAnsiChar;    (* Пароль доступа на чтение           *)
      nOpenMode   : SmallInt; (* Режим ее открытия (если еще не открыта) *)
      anFieldsNum : PSmallInt;(* Задействованные номера полей таблицы *)
      (* Первый номер - номер ключа для кодификатора *)
      (* Последующие номера задают поля, образующие толкование ключа *)
      nFieldCnt   : SmallInt; (* Число полей в массиве *)
      Var fpCoder : CHANDLE   (* Для приема обработчика кодификатора *)
  ):SmallInt;stdcall;

(* Удалить кодификатор из памяти *)
  Procedure htPurgeCoder(
      hCoder : CHANDLE        (* Обработчик кодификатора *)
  );stdcall;

(* Считать кодификатор в прямом или обратном порядке *)
(* Прямой порядок - сортировка по значению кода *)
(* Буфер содержит пары {ключ:толкование} *)
(* Обратный порядок - сортировка по значению толкования *)
(* Буфер содержит пары {толкование:ключ} *)
  Function htReadCoder(
      hCoder  : CHANDLE;     (* Обработчик кодификатора *)
      fpBuf   : Pointer;     (* Буфер для чтения *)
      bInverse: Boolean      (* true - вывод в обратном порядке *)
  ):SmallInt;stdcall;

(* Открыть доступ к результатам поиска в БДС *)
(* в случае, если поля записей имеют кодификаторы *)
  Function htOpenCodedResults(
      const fpSrc : SAB;       (* Адрес исходного БДС *)
      fpFields  : LPCDF;     (* Описатели читаемых элементов *)
      nFieldCnt : SmallInt   (* Число читаемых элементов *)
  ):SmallInt;stdcall;

(* Преобразование кодированных результатов в таблицу *)
(* Функция аналогична htResultsToTable, но позволяет выполнить *)
(* декодирование полей.  *)
  Function htCodedResultsToTable(
      const fpSrc : SAB;      (* Адрес исходного БДС                       *)
      hOutTable : THANDLE;  (* Обработчик для заполняемой таблицы        *)
      fpfRecProc: LPRFUNC;  (* Пользовательская функция обработки записи *)
          (* Nil - обработка не нужна (все готово)     *)
      fpfErrProc: LPEFUNC;  (* Пользовательская функция обработки ошибок *)
          (* Nil - ошибки прерывают ввод               *)
      fpUser    : Pointer;  (* Доп.параметр пользователя                 *)
      fpElemNo  : LPCDF;    (* Номера выводимых элементов исх.записи     *)
      nElemCnt  : SmallInt; (* Число выводимых элементов                 *)
      bDenyOut  : Boolean;  (* Для true вывод отвергнутых записей в таблицу *)
      bCorrect  : Boolean   (* Для true коррекция суррогатного и авто-ключей *)
  ):LongInt;stdcall;

(*------------------------ Импорт/экспорт --------------------------*)

(* Операция экспорта данных таблицы в файлы других форматов *)
(* Таблица может быть открыта *)
  Function htExport(
      nMode:       EXPMODE;   (* Тип экспорта *)
      fpSrcTabName:PAnsiChar; (* Имя таблицы исходного файла *)
      fpReadPswd:  PAnsiChar;     (* Пароль чтения *)
      nOpenMode:   SmallInt;  (* Режим открытия исходной таблицы *)
      fpDstName:   PAnsiChar;     (* Имя порождаемого файла *)
      fpFmt:       PhtFormat (* Описатель форматов *)
  ):SmallInt;stdcall;

(* Операция импорта данных таблицы из файлов других форматов *)
(* Таблица должна быть закрыта *)
  Function htImport(
      nMode:       IMPMODE;   (* Тип импорта *)
      fpDstTabName:PAnsiChar;     (* Имя таблицы, образуемой при импорте *)
      fpReadPswd:  PAnsiChar;     (* Пароль доступа на чтение *)
      fpWritePswd: PAnsiChar;     (* Пароль доступа на запись *)
      nOpenMode:   SmallInt;  (* Режим открытия образуемой таблицы *)
      fpSrcName:   PAnsiChar;     (* Имя исходного файла *)
      fpSrcTabName:PAnsiChar;     (* Имя таблицы для исходного ASCII файла *)
      fpFmt:       PhtFormat;  (* Описатель форматов *)
      bLogFile:    Boolean;   (* !=0 вести журнал импорта *)
      bToConst:    Boolean    (* !=0 вывод в постоянную часть таблицы *)
  ):LongInt;stdcall;

(* Операция импорта описателя таблицы из файлов других форматов *)
(* Допустимы только типы dBase и HyTech1.6 *)
  Function htImportTitle(
      fpSrcName  : PAnsiChar;    (* Имя исходного файла dBase или HyTech 1.6 *)
      fpTableName: PAnsiChar;    (* Имя таблицы, образуемой при импорте *)
      fpCryptoKey: PAnsiChar;    (* Пароль шифрования данных *)
      fpReadPswd : PAnsiChar;    (* Пароль доступа на чтение *)
      fpWritePswd: PAnsiChar;    (* Пароль доступа на запись *)
      bAnsi      : Boolean   (* Образуем ANSI-таблицу    *)
  ):SmallInt;stdcall;

(* Операция вывода данных таблицы в другую таблицу *)
(* Исходная таблица может быть открыта, *)
(* таблица-приемник - должна быть закрыта *)
  Function htOutTo(
      fpSrcTabName:  PAnsiChar; (* Имя таблицы исходного файла *)
      fpReadPswd:    PAnsiChar; (* Пароль чтения *)
      nOpenMode:     SmallInt;(* Режим открытия исходной таблицы *)
      fpDstTabName:  PAnsiChar; (* Имя таблицы, образуемой при выводе *)
      fpDstReadPswd: PAnsiChar; (* Пароль доступа на чтение *)
      fpDstWritePswd:PAnsiChar; (* Пароль доступа на запись *)
      fpFmt:         PhtFormat;(* Описатель форматов *)
      bLogFile:      Boolean; (* TRUE - вести журнал вывода *)
      bCorrect:      Boolean  (* TRUE - коррекция суррогатного и авто-ключей *)
  ):LongInt;stdcall;

(*------------- Поддержка распределенных таблиц ------------*)

(* Закрыть доступ к журналу изменений *)
  Procedure htLogClose(
      Var sLog:LOGON          (* Описатель доступа к журналу *)
  );stdcall;

(* Открыть доступ к журналу изменений *)
  Function htLogOpen(
      fpTableName: PAnsiChar;      (* Имя таблицы (можно без расширения)*)
      fpReadPswd : PAnsiChar;      (* Пароль доступа на чтение          *)
      fpWritePswd: PAnsiChar;      (* Пароль доступа на запись          *)
      fpElemNo:    PSmallInt;  (* Номера читаемых элементов записи  *)
             (* Если Nil - читаются все элементы записи *)
      nElemCnt:    SmallInt;   (* Число читаемых элементов *)
      Var sLog:    LOGON       (* Описатель доступа к журналу *)
  ):SmallInt;stdcall;

(* Считать пачку записей (или их полей) из журнала изменений *)
(* Читаются элементы журнала изменений таблицы, начиная с заданного.   *)
(* Каждый элемент предваряется байтом с признаком операции (LOG_???).  *)
(* Под элементом понимается вся запись с номером или ее заданнные поля.*)
  Function htLogRead(
      Var sLog: LOGON;  (* Описатель доступа к журналу *)
      gStart:   LongInt;  (* Номер первого читаемого элемента журнала (от 0) *)
      fpBuf:    Pointer;      (* Буфер для чтения записей *)
      wBufLen:  Cardinal      (* Длина буфера *)
  ):Word;stdcall;

(*------------ Резервное копирование/восстановление таблицы -----------*)

(* Сделать резервную копию таблицы от заданного снимка. *)
(* Копия представляет собой неиндексированную постоянную часть. *)
  Function htBackupTable(
	cpPhoto: LPSAB;       (* Снимок таблицы *)
	hTable: THANDLE;      (* Таблица *)
	cpNewName: PAnsiChar      (* Имя резервной копии *)
  ):SmallInt;stdcall;

(* Сделать резервную копию таблицы от заданного снимка. *)
(* Копия представляет собой неиндексированную постоянную часть. *)
  Function htBackupTableGroup(
	ppNames: PPChar;      (* Имена таблиц группы *)
	ppRd: PPChar;         (* Пароли чтения для таблиц группы *)
	ppWr: PPChar;         (* Пароли записи для таблиц группы *)
	ppNewNames: PPChar;   (* Имена резервных копий таблиц группы *)
	nNameCnt: Integer     (* Число таблиц *)
  ):SmallInt;stdcall;

(* Восстановить таблицу с резервной копии (копирует и индексирует). *)
(* Требуется совпадение паролей у копии и существующей таблицы.     *)
(* Возвращает: число отвергнутых при индексировании записей или код ошибки. *)
  Function htRestoreTable(
	pBackName :  PAnsiChar;  (* Имя резервной копии *)
	pReadPswd :  PAnsiChar;  (* Пароль доступа на чтение к резервной копии *)
	pWritePswd : PAnsiChar;  (* Пароль доступа на запись к исходной таблице *)
	pTabName :   PAnsiChar   (* Имя восстанавливаемой таблицы *)
  ):LongInt;stdcall;

(*------------------------ Работа с заголовком ----------------------*)

(* Закрыть доступ к открытому заголовку таблицы *)
  Procedure htTableHeadClose( Var Head: THEAD ); stdcall;

(* Открыть доступ к заголовку таблицы *)
  Function htTableHeadOpen(
	pTabName: PAnsiChar;        (* Имя таблицы *)
	pCryptoKey: PAnsiChar;      (* Крипто-ключ закрытия данных *)
	pReadPswd: PAnsiChar;       (* Пароль на чтение *)
	pWritePswd: PAnsiChar;      (* Пароль на запись *)
	nMode: SmallInt;        (* Режим открытия (HTHO_????) *)
	Var Head: THEAD         (* Описатель заголовка таблицы *)
  ) : SmallInt; stdcall;

(* Определить наличие паролей у таблицы *)
  Function htTableHeadPswd(
        pTabName: PAnsiChar;        (* Имя таблицы *)
	Var Mode: Integer       (* Для приема флагов паролей *)
  ) : SmallInt; stdcall;

(* Считать пачку описателей элементов таблицы *)
  Function htTableHeadRead(
	Var HEad: THEAD; 	(* Описатель заголовка таблицы *)
	pElem: LPELEMENT; 	(* Буфер для чтения описателей элементов *)
	nElemCnt: SmallInt      (* Число описателей для чтения *)
  ) : SmallInt; stdcall;

(* Записать пачку описателей таблицы *)
  Function htTableHeadWrite(
	Var Head: THEAD;        (* Описатель заголовка таблицы *)
	pElem: LPELEMENT;       (* Описатели элементов для записи *)
	nElemCnt: SmallInt;     (* Число описателей для записи *)
	nMode: SmallInt;        (* Режим записи (см.HTRW_????) *)
	ppError: LPELEMENT      (* Адрес "плохого" описателя элемента *)
  ) : SmallInt; stdcall;

(*------------------------ Прочее --------------------------*)

(* Прервать выполнение текущей операции HyTech         *)
(* Не меняет содержимое регистров и флагов процессора. *)
(* Можно вызывать, например, из обработчика Ctrl-Break *)
  Procedure htBreak;stdcall;

(* Установить задержку опроса сети *)
  Procedure htSetPollDelay( wMSec: Word );stdcall;

(* Получить "снимок" таблицы без выполнения поиска *)
  Function htMakePhoto(
      Var fpPhoto : SAB;  (* БДС для "снимка" *)
      hTable : THANDLE  (* Обработчик для таблицы *)
  ):LPSAB;stdcall;

(* Получить "снимки" нескольких таблиц одномоментно *)
  Function htMakeGroupPhoto(
      fpPhotos :  LPSAB;  (* БДС'ы для "снимков" *)
      fphTables : LPTHANDLE;  (* Обработчики таблиц *)
      nTabCnt:    SmallInt  (* Число таблиц в группе *)
  ):SmallInt;stdcall;

(* Получить текстовую строку по коду завершения функции *)
(* Возвращает сообщение типа 'Нет памяти для работы'.   *)
  Function htErrorMessage(
      nCode: SmallInt;    (* Код завершения *)
      lpszBuff80: PAnsiChar  (* Буфер для приема текста сообщения *)
  ):PAnsiChar;stdcall;

(* Получить дополнительную информацию о последней ошибке HyTech *)
(* Возвращает имя файла, при работе с которым произошла ошибка, *)
(* а также код ошибки ДОС и код операции, приведшей к ошибке.   *)
(* Последующие ошибки переписывают данные о предыдущей.         *)
  Function htExtError(
      Var nDosError : SmallInt; (* Сюда занесут код, возвращенный ДОС            *)
      Var nOperation: SmallInt; (* Сюда занесут код операции, приведшей /к ошибке *)
      lpszBuff140: PAnsiChar       (* Буфер для приема имени файла *)
  ):PAnsiChar;stdcall;

(* Получить дополнительную информацию о последней ошибке HyTech *)
(* Возвращает текстовую строку, содержащую название операции, *)
(* имя файла и возможную причину ошибки. *)
(* Последующие ошибки переписывают данные о предыдущей.         *)
  Function htIOMessage(
      lpszBuff220: PAnsiChar   (* Буфер для приема текста сообщения *)
  ):PAnsiChar;stdcall;

(* Функция возвращает указатель на строку содержащую сообщение *)
(* в зависимости от типа ошибки (В/В или прочие), например:    *)
(*  "Нет памяти для работы" или                                *)
(*  "Ошибка открытия d:\xxxx файл не найден".                  *)
  Function  htMessage(
      nRetCode:  SmallInt; (* Код сообщения *)
      lpszBuff220: PAnsiChar   (* Буфер для приема текста сообщения *)
  ):PAnsiChar;stdcall;

(* Очистить информацию о предыдущей ошибке СУБД *)
  Procedure htPurgeError;stdcall;

(* Определить каталог сетевых замков              *)
(* Имя каталога имеет замыкающий '\'              *)
  Procedure htNetPath( Var stBuf: PathStr );stdcall;

(* Определить каталог временных файлов            *)
(* Имя каталога имеет замыкающий '\'              *)
  Procedure htTmpPath( Var stBuf: PathStr );stdcall;

(* Дата и время инициализации HyTech *)
(* Формат даты и времени как принято в ДОС для файлов *)
(* Младшее слово возврата - время, старшее - дата     *)
  Function htStartTimeDate: LongInt;stdcall;

(* Проверка установки поля в "пустое" значение *)
  Function htIsFieldNull(
      nType  :SmallInt;         (* Тип поля *)
      wLen   :Cardinal;         (* Длина поля *)
      pField :Pointer   (* Тело проверямого поля *)
  ):SmallInt;stdcall;

(* Установка поля в "пустое" значение *)
  Function htNullField(
      nType   :SmallInt;        (* Тип поля *)
      nKeyType:SmallInt;  (* Тип ключа *)
      wLen    :Cardinal;  (* Длина поля *)
      fpField :Pointer    (* Тело ключа *)
  ):SmallInt;stdcall;

(* Установка записи в "пустое" значение *)
  Function htNullRecord(
      hTable:THANDLE;   (* Обработчик таблицы *)
      fpRec :Pointer    (* Адрес тела записи *)
  ):SmallInt;stdcall;

(* Преобразование строки в массив байтов *)
(* Копирует строку в массив и дополняет символами #0 *)
  Procedure htStringToArray(
      fpArray : Pointer;    (* Адрес массива-приемника *)
      fpString: PAnsiChar;      (* Адрес исходной строки *)
      wDimens : Cardinal    (* Длина массива *)
  );stdcall;

(* Преобразование строки в массив символов *)
(* Копирует строку в массив и дополняет пробелами *)
  Procedure htStringToChars(
      fpChars : Pointer;    (* Адрес массива символов *)
      fpString: PAnsiChar;      (* Адрес исходной строки *)
      wDimens : Cardinal    (* Длина массива *)
  );stdcall;

(* Сравнить массив символов с шаблоном *)
(* =0 - равны, <>0 - не равны *)
  Function htWildCmp(
      fpArray : PAnsiChar;      (* Адрес сканируемого массива *)
      wDimens : Word;       (* Длина массива *)
      fpWild  : PAnsiChar;      (* Адрес шаблона (ASCIIZ-строки) *)
      nCaseMode: CASE_MODE  (* Режим капитализации регистра *)
  ):SmallInt;stdcall;

(* Преобразование даты во внутренний формат (целое без знака) *)
(* Неверно заданные даты дают на выходе 0.                    *)
  Function htDateToWord( sDate: DATE ):Word;stdcall;

(* Преобразование даты из внутреннего формата в структуру *)
  Procedure htWordToDate( wWord: Word; Var sDate: DATE);stdcall;

(* Получить состояние таблицы (снимок) для БДС *)
  Function htTableSABStat(
      Var pSAB: SAB;          (* Результат поиска *)
      Var pStat: STATT  (* Состояние таблицы *)
  ):SmallInt;stdcall;

(* Определить длину диф.части для БДС на момент поиска *)
  Function htGetDiffLength(Var fpSAB:SAB; Var aDiffLength:Int64):SmallInt; stdcall;

(* Считать пачку описателей изменений БДС с заданной позиции журнала *)
  Function htReadSABChanges(
      Var fpSAB:SAB;
      fpBuf:LPCHANGER;
      nCnt:SmallInt;
      Var gPos:LongInt
  ):SmallInt;stdcall;

(* Считать пачку описателей изменений с заданной позиции журнала *)
  Function htReadTableChanges(
      hTable:THANDLE;
      gStart:LongInt;
      fpBuf:LPCHANGER;
      nCnt:SmallInt;
      Var gPos:LongInt
  ):SmallInt;stdcall;

(* Определить захватчика записи *)
  Function htWhoLockRecord(
      fpTabName:PAnsiChar;
      gRecNo:LongInt;
      Var sOwner:OWNER
  ):SmallInt;stdcall;

(* Определить захватчика множества записей *)
  Function htWhoLockSet(Var sSAB:SAB;Var sOwner:OWNER):SmallInt;stdcall;

(* Определить захватчика таблицы *)
  Function htWhoLockTable(fpTabName: PAnsiChar; var sOwner: OWNER):SmallInt;stdcall;

(* Управление флагом подмены обработчика CtrlBreak (вызов SetConsoleCtrlHandler) *)
(* Возвращает старое состояние флаги и проставляет новое *)
(* Ненулевой флаг запрещает подмену обработчика в функциях HyTech *)
  Function htCtrlCtrl(NewState: Integer):Integer;stdcall;

(* Свободная память в заданной куче процесса *)
(* hTask - получается с помощью функции GetCurrentThreadID *)
(* bGlobal - 0 или 1 тип кучи... *)
  Function htMemoAvailByTask(hTask : LongWord;bGlobal : ShortInt) : LongInt;stdcall;

(* Печать заданной кучи процесса *)
(* печать идет в файл HtHeap.dmp в текущем каталоге *)
  Procedure htPrintHytechHeap(hTask : LongWord;bGlobal : ShortInt);stdcall;

{$IFDEF HT_NEWDLL}
//* Выводить сведения о выполнении операций ядра СУБД */
//HTRET HTAPI htSetParam( const char* cpName, const char* cpValue );
 function htSetParam(aParamName: PAnsiChar; aParamValue: PAnsiChar): SmallInt; stdcall;
{$ENDIF HT_NEWDLL}

 // Константы для конвертации таблиц
 const
  HT_34 = 1;
  HT_38 = 2;
  HT_48 = 3;

(* Конвертация таблиц в HT_MODE64 *)
  function htConvertTable(pSrcName, pDestName, pReadPswd, pWritePswd: PAnsiChar; cCnvType: SmallInt): SmallInt; stdcall;

(* Определить длину записи таблицы *)
 // не проверялась
//function htTableRecordLen(aTable : THANDLE; var aRecLen : Cardinal): SmallInt;

Implementation
 {$I htProcName.inc}

  Function  htAddRecords;                external HTDLL name sHTADDRECORDS;
  Function  htAndResults;                external HTDLL name sHTANDRESULTS;
  Function  htAverageOfKeyValues;        external HTDLL name sHTAVERAGEOFKEYVALUES;
  Function  htBuildIndexes;              external HTDLL name sHTBUILDINDEXES;
  Function  htBackupTable;               external HTDLL name sHTBACKUPTABLE;
  Function  htBackupTableGroup;          external HTDLL name sHTBACKUPTABLEGROUP;
  Function  htChangeCryptoKey;           external HTDLL name sHTCHANGECRYPTOKEY;
  Function  htChangeKeyType;             external HTDLL name sHTCHANGEKEYTYPE;
  Function  htChangeReadPassword;        external HTDLL name sHTCHANGEREADPASSWORD;
  Function  htChangeWritePassword;       external HTDLL name sHTCHANGEWRITEPASSWORD;
  Procedure htCloseResults;              external HTDLL name sHTCLOSERESULTS;
  Function  htClusterItemToLink;         external HTDLL name sHTCLUSTERITEMTOLINK;
  Function  htClusterRecsToLink;         external HTDLL name sHTCLUSTERRECSTOLINK;
  Function  htCodedResultsToTable;       external HTDLL name sHTCODEDRESULTSTOTABLE;
  Function  htCoderInfo;                 external HTDLL name sHTCODERINFO;
  Function  htCommitTransaction;         external HTDLL name sHTCOMMITTRANSACTION;
  Function  htCompareTabHandles;         external HTDLL name sHTCOMPARETABHANDLES;
  Function  htCopyResults;               external HTDLL name sHTCOPYRESULTS;
  Function  htCreateClusterTable;        external HTDLL name sHTCREATECLUSTERTABLE;
  Function  htCreateEmptySAB;            external HTDLL name sHTCREATEEMPTYSAB;
  Function  htCreateEmptyJoin;           external HTDLL name sHTCREATEEMPTYJOIN;
  Function  htDateToWord;                external HTDLL name sHTDATETOWORD;
  Function  htDeleteRecords;             external HTDLL name sHTDELETERECORDS;
  Function  htDistinctResults;           external HTDLL name sHTDISTINCTRESULTS;
  Function  htDistinctResultsByCount;    external HTDLL name sHTDISTINCTRESULTSBYCOUNT;
  Function  htDivision;                  external HTDLL name sHTDIVISION;
  Function  htDropIndexes;               external HTDLL name sHTDROPINDEXES;
  Function  htDropTable;                 external HTDLL name sHTDROPTABLE;
  Function  htDropTableChanges;          external HTDLL name sHTDROPTABLECHANGES;
  Function  htDropTableData;             external HTDLL name sHTDROPTABLEDATA;
  Function  htDupTableHandle;            external HTDLL name sHTDUPTABLEHANDLE;
  Function  htErrorMessage;              external HTDLL name sHTERRORMESSAGE;
  Function  htExcludeResultsItem;        external HTDLL name sHTEXCLUDERESULTSITEM;
  Function  htExport;                    external HTDLL name sHTEXPORT;
  Function  htExtError;                  external HTDLL name sHTEXTERROR;
  Function  htFilterRecords;             external HTDLL name sHTFILTERRECORDS;
  Function  htFilterTables;              external HTDLL name sHTFILTERTABLES;
  Function  htFindCoderKey;              external HTDLL name sHTFINDCODERKEY;
  Function  htFindCoderValue;            external HTDLL name sHTFINDCODERVALUE;
  Function  htFlushTable;                external HTDLL name sHTFLUSHTABLE;
  Function  htGetDiffLength;             external HTDLL name sHTGETDIFFLENGTH;
  Function  htGetResultsItem;            external HTDLL name sHTGETRESULTSITEM;
  Function  htGlobalInit;                external HTDLL name sHTGLOBALINIT;
  Procedure htGlobalShut;                external HTDLL name sHTGLOBALSHUT;
  Function  htGroupByHavingTo;           external HTDLL name sHTGROUPBYHAVINGTO;
  Function  htGroupByUser;               external HTDLL name sHTGROUPBYUSER;
  Function  htHandleAdd;                 external HTDLL name sHTHANDLEADD;
  Function  htHandleFromRecNo;           external HTDLL name sHTHANDLEFROMRECNO;
  Function  htHandleModify;              external HTDLL name sHTHANDLEMODIFY;
  Function  htHistogramByCount;          external HTDLL name sHTHISTOGRAMBYCOUNT;
  Function  htHistogramOfKey;            external HTDLL name sHTHISTOGRAMOFKEY;
  Function  htHoldFreeRecords;           external HTDLL name sHTHOLDFREERECORDS;
  Function  htHoldReadRecord;            external HTDLL name sHTHOLDREADRECORD;
  Function  htHoldRecord;                external HTDLL name sHTHOLDRECORD;
  Function  htHoldResults;               external HTDLL name sHTHOLDRESULTS;
  Function  htHoldTable;                 external HTDLL name sHTHOLDTABLE;
  Function  htImport;                    external HTDLL name sHTIMPORT;
  Function  htImportTitle;               external HTDLL name sHTIMPORTTITLE;
  Function  htIncludeResultsBlock;       external HTDLL name sHTINCLUDERESULTSBLOCK;
  Function  htIncludeResultsItem;        external HTDLL name sHTINCLUDERESULTSITEM;
  Function  htInit;                      external HTDLL name sHTINIT;
  Function  htIOMessage;                 external HTDLL name sHTIOMESSAGE;
  Function  htIsNeedToRoll;              external HTDLL name sHTISNEEDTOROLL;
  Function  htIsResultObsolete;          external HTDLL name sHTISRESULTOBSOLETE;
  Function  htIsResultOpen;              external HTDLL name sHTISRESULTOPEN;
  Function  htIsTransactionalTable;      external HTDLL name sHTISTRANSACTIONALTABLE;
  Function  htJoinedRecords;             external HTDLL name sHTJOINEDRECORDS;
  Function  htJoinElement;               external HTDLL name sHTJOINELEMENT;
  Function  htKeyMaximum;                external HTDLL name sHTKEYMAXIMUM;
  Function  htKeyMinimum;                external HTDLL name sHTKEYMINIMUM;
  Function  htLoadCoder;                 external HTDLL name sHTLOADCODER;
  Function  htLoadRecords;               external HTDLL name sHTLOADRECORDS;
  Procedure htLogClose;                  external HTDLL name sHTLOGCLOSE;
  Function  htLogOpen;                   external HTDLL name sHTLOGOPEN;
  Function  htLogRead;                   external HTDLL name sHTLOGREAD;
  Function  htMakeGroupPhoto;            external HTDLL name sHTMAKEGROUPPHOTO;
  Function  htMakePhoto;                 external HTDLL name sHTMAKEPHOTO;
  Function  htMarkJoinedRecord;          external HTDLL name sHTMARKJOINEDRECORD;
  Function  htMarkJoinedRecordEx;        external HTDLL name sHTMARKJOINEDRECORDEX;
  Function  htMarkRecord;                external HTDLL name sHTMARKRECORD;
  Function  htMemoAvailByTask;           external HTDLL name sHTMEMOAVAILBYTASK;
  Function  htMessage;                   external HTDLL name sHTMESSAGE;
  Function  htModifyRecords;             external HTDLL name sHTMODIFYRECORDS;
  Function  htNotResults;                external HTDLL name sHTNOTRESULTS;
  Function  htNullField;                 external HTDLL name sHTNULLFIELD;
  Function  htNullRecord;                external HTDLL name sHTNULLRECORD;
  Function  htOpenCodedResults;          external HTDLL name sHTOPENCODEDRESULTS;
  Function  htOpenResults;               external HTDLL name sHTOPENRESULTS;
  Function  htOrResults;                 external HTDLL name sHTORRESULTS;
  Function  htOutTo;                     external HTDLL name sHTOUTTO;
  Procedure htPrintHytechHeap;           external HTDLL name sHTPRINTHYTECHHEAP;
  Function  htPureAddRecords;            external HTDLL name sHTPUREADDRECORDS;
  Function  htPureModifyRecords;         external HTDLL name sHTPUREMODIFYRECORDS;
  Function  htReadCoder;                 external HTDLL name sHTREADCODER;
  Function  htReadRecord;                external HTDLL name sHTREADRECORD;
  Function  htReadRecordByHandle;        external HTDLL name sHTREADRECORDBYHANDLE;
  Function  htReadResults;               external HTDLL name sHTREADRESULTS;
  Function  htReadSABChanges;            external HTDLL name sHTREADSABCHANGES;
  Function  htReadTableChanges;          external HTDLL name sHTREADTABLECHANGES;
  Function  htRecNoFromHandle;           external HTDLL name sHTRECNOFROMHANDLE;
  Function  htRecordAdd;                 external HTDLL name sHTRECORDADD;
  Function  htRecordByUniq;              external HTDLL name sHTRECORDBYUNIQ;
  Function  htRecordDelete;              external HTDLL name sHTRECORDDELETE;
  Function  htRecordModify;              external HTDLL name sHTRECORDMODIFY;
  Function  htRecordOrdinalNumber;       external HTDLL name sHTRECORDORDINALNUMBER;
  Function  htRecordsByKey;              external HTDLL name sHTRECORDSBYKEY;
  Function  htRecordsForTwoKeys;         external HTDLL name sHTRECORDSFORTWOKEYS;
  Function  htReleaseRecord;             external HTDLL name sHTRELEASERECORD;
  Function  htReleaseResults;            external HTDLL name sHTRELEASERESULTS;
  Function  htReleaseTable;              external HTDLL name sHTRELEASETABLE;
  Function  htRepairTable;               external HTDLL name sHTREPAIRTABLE;
  Function  htRepairTableLog;            external HTDLL name sHTREPAIRTABLELOG;
  Function  htReplaceResultsItem;        external HTDLL name sHTREPLACERESULTSITEM;
  Function  htReplaceResultsTable;       external HTDLL name sHTREPLACERESULTSTABLE;
  Function  htRestoreTable;              external HTDLL name sHTRESTORETABLE;
  Function  htResultsElement;            external HTDLL name sHTRESULTSELEMENT;
  Function  htResultsItemCnt;            external HTDLL name sHTRESULTSITEMCNT;
  Function  htResultsItemLen;            external HTDLL name sHTRESULTSITEMLEN;
  Function  htResultsItemParm;           external HTDLL name sHTRESULTSITEMPARM;
  Function  htResultsTable;              external HTDLL name sHTRESULTSTABLE;
  Function  htResultsToHard;             external HTDLL name sHTRESULTSTOHARD;
  Function  htResultsToTable;            external HTDLL name sHTRESULTSTOTABLE;
  Function  htResultsType;               external HTDLL name sHTRESULTSTYPE;
  Function  htRollBackTransaction;       external HTDLL name sHTROLLBACKTRANSACTION;
  Function  htSearch;                    external HTDLL name sHTSEARCH;
  Function  htSeekMarkedJoin;            external HTDLL name sHTSEEKMARKEDJOIN;
  Function  htSeekMarkedJoinEx;          external HTDLL name sHTSEEKMARKEDJOINEX;
  Function  htSeekMarkedRecord;          external HTDLL name sHTSEEKMARKEDRECORD;
  Function  htSeekResults;               external HTDLL name sHTSEEKRESULTS;
  Function  htSortedRecords;             external HTDLL name sHTSORTEDRECORDS;
  Function  htSortedRecordsEx;           external HTDLL name sHTSORTEDRECORDSEX;
  Function  htSortResults;               external HTDLL name sHTSORTRESULTS;
  Function  htSortResultsByUser;         external HTDLL name sHTSORTRESULTSBYUSER;
  Function  htStartTimeDate;             external HTDLL name sHTSTARTTIMEDATE;
  Function  htStartTransaction;          external HTDLL name sHTSTARTTRANSACTION;
  Function  htSubSearch;                 external HTDLL name sHTSUBSEARCH;
  Function  htSumOfKeyValues;            external HTDLL name sHTSUMOFKEYVALUES;
  Function  htSyncResults;               external HTDLL name sHTSYNCRESULTS;
  Function  htTableClose;                external HTDLL name sHTTABLECLOSE;
  Function  htTableCopy;                 external HTDLL name sHTTABLECOPY;
  Function  htTableCreate;               external HTDLL name sHTTABLECREATE;
  Function  htTableElement;              external HTDLL name sHTTABLEELEMENT;
  Function  htTableElementList;          external HTDLL name sHTTABLEELEMENTLIST;
  Function  htTableHandleByName;         external HTDLL name sHTTABLEHANDLEBYNAME;
  Function  htTableInfo;                 external HTDLL name sHTTABLEINFO;
  Function  htTableOpen;                 external HTDLL name sHTTABLEOPEN;
  Function  htTableRename;               external HTDLL name sHTTABLERENAME;
  Function  htTableVerify;               external HTDLL name sHTTABLEVERIFY;
  Function  htTellJoinOrder;             external HTDLL name sHTTELLJOINORDER;
  Function  htTouchResults;              external HTDLL name sHTTOUCHRESULTS;
  Function  htTransferToPhoto;           external HTDLL name sHTTRANSFERTOPHOTO;
  Function  htTransferToTable;           external HTDLL name sHTTRANSFERTOTABLE;
  Function  htUpdateTable;               external HTDLL name sHTUPDATETABLE;
  Function  htValuesByCount;             external HTDLL name sHTVALUESBYCOUNT;
  Function  htValuesFromGroup;           external HTDLL name sHTVALUESFROMGROUP;
  Function  htValuesOfKey;               external HTDLL name sHTVALUESOFKEY;
  Function  htXorResults;                external HTDLL name sHTXORRESULTS;
  Procedure htBreak;                     external HTDLL name sHTBREAK;
  Procedure htClearResults;              external HTDLL name sHTCLEARRESULTS;
  Procedure htCloseAllTables;            external HTDLL name sHTCLOSEALLTABLES;
  Procedure htNetPath;                   external HTDLL name sHTNETPATH;
  Procedure htPurgeCoder;                external HTDLL name sHTPURGECODER;
  Procedure htPurgeError;                external HTDLL name sHTPURGEERROR;
  Procedure htSetLockTimeOut;            external HTDLL name sHTSETLOCKTIMEOUT;
  Procedure htSetPollDelay;              external HTDLL name sHTSETPOLLDELAY;
  Procedure htSetTransTimeOut;           external HTDLL name sHTSETTRANSTIMEOUT;
  Procedure htShut;                      external HTDLL name sHTSHUT;
  Procedure htStringToArray;             external HTDLL name sHTSTRINGTOARRAY;
  Procedure htStringToChars;             external HTDLL name sHTSTRINGTOCHARS;
  Function  htTableSABStat;              external HTDLL name sHTTABLESABSTAT;
  Procedure htTableHeadClose;		 external HTDLL name sHTTABLEHEADCLOSE;
  Function  htTableHeadOpen;		 external HTDLL name sHTTABLEHEADOPEN;
  Function  htTableHeadPswd;		 external HTDLL name sHTTABLEHEADPSWD;
  Function  htTableHeadRead;		 external HTDLL name sHTTABLEHEADREAD;
  Function  htTableHeadWrite;		 external HTDLL name sHTTABLEHEADWRITE;
  Function  htTablesJoin;                external HTDLL name sHTTABLESJOIN;
  Function  htTablesLink;                external HTDLL name sHTTABLESLINK;
  Procedure htTmpPath;                   external HTDLL name sHTTMPPATH;
  Function  htWhoLockRecord;             external HTDLL name sHTWHOLOCKRECORD;
  Function  htWhoLockSet;                external HTDLL name sHTWHOLOCKSET;
  Function  htWhoLockTable;              external HTDLL name sHTWHOLOCKTABLE;
  Function  htWildCmp;                   external HTDLL name sHTWILDCMP;
  Procedure htWordToDate;                external HTDLL name sHTWORDTODATE;
  Function  htTableState;                external HTDLL name sHTTABLESTATE;
  Function  htTableAgregateModify;       external HTDLL name sHTTABLEAGREGATEMODIFY;
  Function  htTableAgregateDelete;       external HTDLL name sHTTABLEAGREGATEDELETE;
  Function  htTableAgregateAppend;       external HTDLL name sHTTABLEAGREGATEAPPEND;
  Function  htIsFieldNull;               external HTDLL name sHTISFIELDNULL;
  Function  htCtrlCtrl;			 external HTDLL name sHTCTRLCTRL;
  function  htConvertTable;              external HTDLL name sHTCONVERTTABLE;
  //function  htTableRecordLen;            external HTDLL name shtTableRecordLen;
  {$IFDEF HT_NEWDLL}
  Function  htExcludeResults;            external HTDLL name sHTEXCLUDERESULTS;
  Function  htRecordsByValues;           external HTDLL name sHTRECORDSBYVALUES;
  Function  htLastErrorText;             external HTDLL name sHTLASTERRORTEXT;
  Function  htSetParam;                  external HTDLL name sHTSETPARAM;

  {$endif}

end.
