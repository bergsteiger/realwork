Unit Dt_Free;

{ $Id: DT_FREE.PAS,v 1.81 2016/07/13 09:41:59 lukyanets Exp $ }
// $Log: DT_FREE.PAS,v $
// Revision 1.81  2016/07/13 09:41:59  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.80  2016/06/29 13:09:06  lukyanets
// Отладка
//
// Revision 1.79  2016/06/16 05:40:06  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.78  2015/11/30 11:31:05  lukyanets
// Реанимируем починку интервалов
//
// Revision 1.77  2015/11/30 08:51:50  lukyanets
// Реанимируем починку интервалов
//
// Revision 1.75  2015/11/27 12:38:24  lukyanets
// Cleanup
//
// Revision 1.74  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.73  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.72  2013/12/03 09:55:07  voba
// - збавляемся от степановских итераторов
//                                                            
// Revision 1.71  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.70  2011/06/29 16:02:32  fireton
// - даём возможность редактировать ID элемента словаря при создании
//
// Revision 1.69  2011/06/06 13:26:16  fireton
// - не удалялись одиночные номера в таблице FREE (неправильный размер данных)
//
// Revision 1.68  2011/06/03 14:21:58  voba
// - k : 268337658
//
// Revision 1.67  2011/02/04 15:51:55  fireton
// - константа c_EmptyLimit теперь в interface
//
// Revision 1.66  2011/02/03 19:06:22  fireton
// - доработка
//
// Revision 1.65  2009/05/19 12:18:08  voba
// - bug fix
//
// Revision 1.64  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.63  2009/03/16 09:43:58  narry
// - коррекция максимального номера элемента
//
// Revision 1.62  2009/03/04 12:38:09  voba
// - убрал из dt_Const константы HyTech
//
// Revision 1.61  2009/03/02 08:14:17  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.60  2008/04/09 07:34:52  fireton
// - "умное" добавление диапазона свободных номеров
//
// Revision 1.59  2008/04/04 15:16:32  fireton
// - внешние номера документов из диапазона
//
// Revision 1.58  2008/03/20 09:48:35  lulin
// - cleanup.
//
// Revision 1.57  2008/03/03 20:06:05  lulin
// - <K>: 85721135.
//
// Revision 1.56  2008/02/07 14:44:40  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.55  2007/11/26 09:39:50  voba
// - clear BlankID
//
// Revision 1.54  2007/08/14 14:30:07  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.53  2007/05/14 06:32:10  narry
// - неправильный свободный номер после удаления списка номеров
//
// Revision 1.52  2007/04/27 07:49:33  fireton
// - Рефакторинг DT. Перевод THTServer на идентификаторы таблиц.
//
// Revision 1.51  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.50  2007/04/09 11:49:10  fireton
// - учим таблицу свободных значений пилить диапазоны
// - cleanup и форматирование
//
// Revision 1.49  2006/10/04 08:32:10  voba
// - merge with b_archi_ht64
//
// Revision 1.48.72.1  2006/09/19 07:54:34  voba
// - переход на HTStub
//
// Revision 1.48  2004/10/06 18:16:01  lulin
// - борьба за кошерность.
//
// Revision 1.47  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.46  2004/08/09 15:29:41  step
// добавлены raise после RollBackTA
//
// Revision 1.45  2004/08/03 08:52:49  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.44  2004/07/14 13:28:27  step
// продолжительность транзакции задается в StartTA
//
// Revision 1.43  2004/07/13 08:02:34  step
// слияние с веткой b_import_filter_optimization2
//
// Revision 1.42  2004/07/12 10:24:43  step
// изменена TFreeTbl.AddInterval - Интервал содержащий одно значение добавляется не как интервал, а как отдельный элемент
//
// Revision 1.41.6.2  2004/07/12 17:01:56  step
// оптимизация: уменьшение "фрагментации" интервалов в табл. FREE
//
// Revision 1.41.6.1  2004/07/08 17:15:44  step
// TNumSet перенесен из Dt_Free в отдельный модуль;
// новый метод TFreeTbl.ReturnFreeNums
//
// Revision 1.41  2004/06/03 11:32:27  step
// change: TNumSet.Pick
//
// Revision 1.40  2004/06/02 18:12:45  step
// исправлены TNumSet.Pick, TFreeTbl.GetFreeNums, TFreeTbl.GetFreeNumsFromTable
//
// Revision 1.39  2004/06/02 11:20:14  step
// изменен порядок получения номеров в TFreeTbl.GetFreeNums
//
// Revision 1.38  2004/06/01 18:33:06  step
// new: тип TNumSet, несколько методов ...GetNums, ...GetFreeNums.
// изменен тип номеров (в соответствии с типом в БД): LongInt-->LongWord.
//
// Revision 1.37  2004/05/28 18:50:29  step
// new: TFreeTbl.GetFreeNums - заглушка
//
// Revision 1.36  2004/05/21 19:00:56  step
// глобальная SabToList перенеса в GlobalHtServer.SabToList
//
// Revision 1.35  2004/05/17 09:04:36  step
// change: TFreeTableReplica.ExcludeNum, TFreeTbl.ExcludeFreeNumsFromReplica
//
// Revision 1.34  2004/05/14 19:01:45  step
// new: TFreeTbl.CheckDiapasonOfNumbers
//
// Revision 1.32  2004/05/06 13:37:35  step
// TFreeTbl.PrefName обрезает последние 3 символа только если они представляют собой номер семейства
//
// Revision 1.31  2004/05/06 12:28:48  step
// TFreeTbl.NameForSearch обрезает последние 3 символа только если они представляют собой номер семейства
//
// Revision 1.30  2004/05/06 10:30:14  step
// исправлена TFreeTbl.GetFree
//
// Revision 1.29  2004/05/06 09:16:07  voba
// merge with adding_diapasons_table_free2
//
// Revision 1.28.10.7  2004/04/21 11:35:57  step
// change: TFreeTbl.RepairInterval (GetTblObject замена на GetTblObjectEx)
//
// Revision 1.28.10.6  2004/04/21 11:26:23  step
// изменена TFreeTbl.GetFreeFromTable
//
// Revision 1.28.10.5  2004/04/16 18:30:48  step
// new: механизм блокирования-разблокирования интервалов,
// механизм реставрации неразблокированных интервалов.
//
// Revision 1.28.10.4  2004/04/14 15:46:25  step
// bug fix: исправлена TFreeTbl.HasIntersection
//
// Revision 1.28.10.3  2004/04/13 14:19:09  step
// Изменена TFreeTbl.ResetFreeTblNum
//
// Revision 1.28.10.2  2004/04/12 16:11:40  step
// Изменены методы CheckNumber и CheckFreeNumbers
//
// Revision 1.28.10.1  2004/04/09 16:57:55  step
// Переделан класс TFreeTbl (теперь работает с диапазонами)
//
// Revision 1.28  2004/03/09 15:58:06  step
// TFreeTbl.GetFree выполняет 20 попыток получения значения
//
// Revision 1.27  2003/08/04 13:22:02  voba
// - отключил возврат свободных
//
// Revision 1.26  2003/04/04 12:39:55  demon
// - new behavior: уменьшен буфер для чтения записей из выборок
// HyTech до (65k - 1)
//
// Revision 1.25  2003/03/31 13:48:59  demon
// - new: увеличен размер буферов, выделяемых по умолчанию с 64кб до 8Мб
//
// Revision 1.24  2002/09/11 14:50:03  voba
// -small improve : предотвращение записи в таблицу свободных нулевого элемента
//
// Revision 1.23  2002/05/17 12:51:46  demon
// - some fix
//
// Revision 1.22  2002/04/15 12:16:59  demon
// - add Free Tbl in all massive transaction.
//
// Revision 1.21  2002/04/03 09:25:11  demon
// - new behavior: add new param in ResetFreeTblNum
//
// Revision 1.20  2002/03/29 09:43:02  voba
// - add Compile options to remove PutFreeNumbers procedures
//
// Revision 1.19  2001/07/06 14:38:15  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.18  2001/03/20 15:40:34  demon
// - add checking repaired HLinks in Free Tbl & messages to log
//
// Revision 1.17  2000/12/15 15:36:15  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface

Uses
 daTypes,
 Dt_Types,
 Dt_ATbl,
 HT_Const,
 WinTypes,
 l3Base,
 l3LongintList,
 l3RecList,
 Dt_Const,
 dt_Table,
 dt_Sab,
 dtIntf,
 Dt_Containers,
 Classes,
 Contnrs
 ;

const
 MaxFreeOpTime = 900; (* 15 минут *)
 NO_LIMIT = Pred(High(DWORD));
 c_EmptyLimit: Longword = 0; // 0 означает, что это точное значение, а не диапазон

 ftRecNo   : ThtField = 0;
 ftTblName : ThtField = 1;
 ftFreeNum : ThtField = 2;
 ftLimit   : ThtField = 3;

Type
  PFreeRec = ^TFreeRec;
  TFreeRec = packed record
              TblName  : TNameArr;
              FreeNum,
              Limit    : LongWord;
             end;

  TFreeFullRec = packed record
                  RecNo    : LongWord;
                  TblName  : TNameArr;
                  FreeNum,
                  Limit    : LongWord;
                 end;

  PFreeRangeRec = ^TFreeRangeRec;
  TFreeRangeRec = packed record
   rFrom: LongWord;
   rTo  : LongWord;
  end;

  PFreeRangeExRec = ^TFreeRangeExRec;
  TFreeRangeExRec = packed record
   rRecNo : LongWord;
   rFrom  : LongWord;
   rTo    : LongWord;
  end;

  // вспомогательный тип для TFreeTableReplica
  TFreeTableReplicaItem = class(TObject)
  protected
   function Amount: Integer;
  public
   LowNum,
   HiNum,
   OldFreeNum,
   OldLimit: LongWord;
   constructor Create(aLowNum, aHiNum: LongWord);
   function IsEmpty: Boolean;
  end;

  // вспомогательный тип для TFreeTbl
  TFreeTableReplica = class(TObject)
  private
   f_Items:  TStringList;
    // список "захваченных" интервалов
   f_ExhaustedTables:  TStringList;
    // список имен таблиц, для которых невозможно "захватить" интервалы из FREE
   function GetItem(Index: Integer): TFreeTableReplicaItem;
   function GetName(Index: Integer): string;
   procedure RemoveItem(aItemIndex: Integer);
  protected
   function  AmountFor(aName: string): Integer;
    // кол-во захваченных номеров
  public
   constructor Create;
   destructor Destroy; override;
   function  HasDataFor(aName: string): Boolean;
    // "захвачен" ли интервал?
   function  IsIntervalEmpty(aName: string): Boolean;
    // не опустел ли интервал?
   procedure AddInterval(aName: string; aLowNum, aHiNum: LongWord);
    // "захватить" интервал
   procedure DeleteInterval(aName: string);
    // удалить интервал
   procedure SetExhausted(aName: string);
    // установить, что для aName невозможно "захватить" интервал
   function  IsExhausted(aName: string): Boolean;
    // возможно ли "захватить" интервал?
   function  GetNum(const aTblName: string; var aResultValue: LongWord): Boolean;
    // получить свободный номер. В случае неудачи возвращает False
   function  GetNums(const aTblName: string; aAmount: Integer;
                     var aResultLowNum, aResultHiNum: LongWord): Boolean;
    // получить интервал свободных номеров и по возможности столько, сколько
    // запрошено через aAmount. В случае неудачи возвращает False
   function  ExcludeDiapasonOfNums(const aTblName: string; aLowNum, aHiNum: LongWord): Boolean;
    // Пытается убрать из реплики диапазон номеров.
    // Возможно при этом произойдет и удаление из реплики всего того, что левее.
    // Возвращаемое значение говорит о том, весь ли диапазон угодил в
    // реплику (проще говоря, есть ли нужда после этого еще и чистить таблицу).
   function  ExcludeNum(const aTblName: string; aNum: LongWord): Boolean;
    // Пытается сделать свободный номер занятым.
    // По сути представляет собой удаление диапазона, состоящего из одного
    // aNum (см. ExcludeDiapasonOfNums).
    // Если этот номер оказался в реплике, то возвращается True, иначе False.
   function  Count: Integer;
    // кол-во "захваченных" интервалов
   function  ItemByName(const aTblName: string): TFreeTableReplicaItem;
   property  Items[Index: Integer]: TFreeTableReplicaItem read GetItem;
    // собственно "захваченные" интервалы
   property  Names[Index: Integer]: string read GetName;
    // имена "захваченных" интервалов
  end;

  TFreeTbl = Class(TPrometTbl)
   private
    f_TableReplica: TFreeTableReplica; // в том числе играет роль флага
    function  GetExclusiveUse: Boolean;
    procedure SetExclusiveUse(const aValue: Boolean);
    function  NameArrAsStr(aNameArr: TNameArr): string;
   protected
    fFreeRec  : TFreeRec;

    fSrchSab,
    fFreeSab  : SAB;

    fNumList  : Tl3LongintList;
    fListPos  : LongInt;

    Function    NameForSearch(const aTableName: TTblNameStr): TNameArr;
    Function    PrefName(const aTableName: TTblNameStr): TTblNameStr;
     //
    procedure   AddMark(var aNameArr: TNameArr);
     // меняет aName след. образом: 'FILE' --> '$FILE' (если длина превысит
     // максим., то обрезается последний символ)
    function    CaptureInterval(const aName : TTblNameStr): Boolean;
     // забрать интервал из таблицы в реплику. При неудаче (например, если
     // интервалов нету) возвращает False.
     // При этом в таблице соотв. запись не удаляетя, а только на нее ставится отметка.
    function    ReleaseInterval(const aName : TTblNameStr): Boolean;
     // вернуть измененый интервал из реплики в таблицу. При неудаче возвращает False.
    function    RepairInterval(Const aName : TTblNameStr): Boolean;
     // Сначала ищется интервал с неснятой пометкой.
     // Если в таблице такой имеется , то этот интервал
     // корректируется по соответствующей таблице (Limit остается
     // как есть, меняется только FreeNum (сдвигается в большую сторону).
     // В конце всего - пометка снимается. При этом - если интервал
     // становится пустым, то он удаляется и все начинается сначала (ищется интервал с неснятой ...)
     // Возвращаемое значение сообщает о том, удалось ли добавить новые FreeNums.
    function    HasIntersection(aName: TTblNameStr; aLowNum, aHiNum: LongWord): Boolean;
     // имеет ли интервал (aLowNum, aHiNum) пересечение с уже имеющимися
    Function    GetFreeFromReplica(aName : TTblNameStr;
                                   var aResultValue: LongWord): Boolean;
     // Получение ОДНОГО номера (при необходимости подкачает данные из таблицы).
    Function    GetFreeNumsFromReplica(aName : TTblNameStr;
                                       aAmount: Integer;
                                       aResultValue: TNumSet): Boolean;
     // Получение ПАЧКИ номеров (при необходимости подкачает данные из таблицы, но
     // подкачает не более одной записи и, следовательно, может вернуть совсем
     // не столько, сколько просили, и тогда придется добирать из таблицы).
     // Результат как раз и сообщает о том, соответствует ли выданное кол-во запрошенному.
    Function    GetFreeFromTable(aName : TTblNameStr;
                                 var aResultValue: LongWord): Boolean;
     // если получить номер не удастся, то попытается восстановить залоченный
     // интервал (если такой окажется) и повторит попытку получения номера

    Function    GetFreeNumsFromTable(aName : TTblNameStr;
                                     aMinAmount: Integer;
                                     aMaxAmount: Integer;
                                     aResultSet: TNumSet): Boolean;
     // Аналог GetFreeFromTable, с одним отличием - выдает пачку номеров в кол-ве от aMinAmount
     // до aMaxAmount (в зависимости "фрагментации" общего количества -
     // "отрезается" по первой "трещине" между Min и Max (ближайшая к Min), а если такая не найдена,
     // то тогда уж отрезается по максимуму)
    function    ExcludeFreeFromReplica(aName : TTblNameStr; aNum: LongWord): Boolean;
    function    ExcludeFreeNumsFromReplica(aName : TTblNameStr;
                                           aFromNum, aToNum: LongWord): Boolean; overload;
     // Удаление диапазона. Рузультат говорит о том, все ли номера были из
     // реплики (это нужно для выяснения - продолжить ли удаление на таблице)
    function    ExcludeFreeNumsFromReplica(aName : TTblNameStr;
                                           aNums: Tl3LongintList): Boolean; overload;
   public
     // Удаление списка номеров. Кстати, попутно изменяется содержимое aNums.
     // Смысл результата - см. выше.
    procedure   ExcludeFreeFromTable(aName : TTblNameStr; aNum: LongWord);
     // если имеется точное значение = aNum, а не диапазон, то это значение удаляется из таблицы.
     // Иначе - если имеется диапазон, содержащий aNum, то этот диапазон (ТОЛЬКО ЭТОТ!) обрезается слева, по это самое aNum (включительно)
     // Комментарии: диапазон обрезается потому, что это гораздо проще, чем дробить его (и, соответственно, хранить, искать etc.).
     //              По лишним потерянным элементам в результате обрезания приказано не плакать - "лес рубят - щепки летят".
    procedure   ExcludeFreeNumsFromTable(aName : TTblNameStr; aFromNum, aToNum: LongWord); overload;
    procedure   ExcludeFreeNumsFromTable(aName : TTblNameStr; aNums: Tl3LongintList); overload;
    procedure   ExcludeFreeNumsFromTable(aName: TTblNameStr; aNums: ISab); overload;

    Constructor Create(aFamily : TdaFamilyID); Reintroduce;
    procedure   AddInterval(aName: TTblNameStr;
                            aLowNum: LongWord = 1;
                            aHiNum: LongWord = NO_LIMIT);
    procedure AddIntervalPrim(aName: TTblNameStr;
                              aLowNum: LongWord = 1;
                              aHiNum: LongWord = NO_LIMIT);
    function AnyRangesPresent(aName: TTblNameStr): Boolean;
    Function    GetFree(aName : TTblNameStr) : LongWord;
    Procedure   GetFreeNums(aName : TTblNameStr;
                            aMinAmount: Integer;
                            aMaxAmount: Integer;
                            aResultValue: TNumSet);
    Procedure   ReturnFreeNums(aName : TTblNameStr; aFreeNums: TNumSet);
     // возвращает пачку свободных номеров
    Procedure   PutFree(aName : TTblNameStr; aFreeNum : LongWord);
    Procedure   PutFrees(aName : TTblNameStr;aFreeNums : SAB;aWordSized : Boolean);
    Procedure   ExcludeFree(aName : TTblNameStr;aNum : LongWord);
     // "забирает aNum из множества свободных"  и, ИНОГДА, немного тех, "что левее"
     // См. коммент-ии к ExcludeFreeFromTable
    Procedure   ExcludeFreeNums(aName : TTblNameStr; aLowNum, aHiNum: LongWord);
     // "забирает диапазон номеров из множества свободных" и, опять же, ИНОГДА, немного тех, "что левее"
     // См. коммент-ии к ExcludeFreeFromTable

//    Procedure   CheckFreeNumbers(aName : TTblNameStr;aNums : Sab); // -"-
    procedure   DeleteAllIntervals(const aName: TTblNameStr);
    Procedure   ResetFreeTblNum(aName: TTblNameStr;
                                aStartNum: LongWord = 1;
                                aMaxNum: LongWord = NO_LIMIT);
    function    GetIntervalList(aName: TTblNameStr): Tl3RecList;
    function    IsCaptured(const aName: TTblNameStr): Boolean;
    function IsFree(aName: TTblNameStr; aFreeNum: LongWord): Boolean;
    // такой идентификатор может быть выдан
    property    ExclusiveUse: Boolean read GetExclusiveUse write SetExclusiveUse;
  end;

implementation

uses
  daSchemeConsts,

  HT_Dll,

  SysUtils,
  WinProcs,

  l3MinMax,
  l3String,
  l3TempMemoryStream,

  Dt_Err,
  Dt_Serv,
  DT_Misc,
  dt_AttrSchema
  ;

const
 c_CaptureMark = '$';
 ATTEMPT_AMOUNT = 20;
 PAUSE_SIZE = 500; // 0,5 сек

type
 PDataForAddingNumsToFree = ^TDataForAddingNumsToFree;
 TDataForAddingNumsToFree = packed record
                             pTblName: ^TNameArr;
                             Nums: TList;
                            end;

{$Define ReUseNumberOff} // запрещение возврата свободных номеров

(************************* TFreeTbl *******************************)

Constructor TFreeTbl.Create(aFamily : TdaFamilyID);
Begin
 if aFamily = MainTblsFamily then
  inherited Create(aFamily, Ord(mtFree), atpMain {$IfDef FlushTbl}, True {$endIf FlushTbl})
 else
  inherited Create(aFamily, Ord(ftFree), atpMain {$IfDef FlushTbl}, True {$endIf FlushTbl})
end;

Function TFreeTbl.NameForSearch(const aTableName: TTblNameStr): TNameArr;
Var
 TmpStr : ShortString;
Begin
 TmpStr:=PrefName(aTableName);
 l3StringToArray(Result,SizeOf(Result),TmpStr);
end;

function  TFreeTbl.IsFree(aName: TTblNameStr; aFreeNum: LongWord): Boolean;
var
 l_TblName: TNameArr;
 l_FoundByName,
 l_FoundByFreeNum,
 l_FoundByLimit,
 l_FoundByExactFreeNum,
 l_FoundByExactLimit: Sab;
 l_AlreadyExists: Boolean;
Begin
 Result := False;


 l_TblName := NameForSearch(aName);
 htSearch(nil,
          l_FoundByName,
          Handle,
          ftTblName,
          EQUAL,
          @l_TblName,
          nil);
 try
  if l_FoundByName.gFoundCnt > 0 then
  begin
   // записи с FreeNum <= aFreeNum (включая aFreeNum!!!) - ПРОВЕРКА ПО ЛЕВОЙ ГРАНИЦЕ
   htSubSearch(l_FoundByName,
               l_FoundByFreeNum,
               Handle,
               ftFreeNum,
               LESS_EQUAL,
               @aFreeNum,
               nil);
   try
    if l_FoundByFreeNum.gFoundCnt > 0 then
    begin
     // проверка на попадание в уже имеющийся диапазон (Limit >= aFreeNum) - ПРОВЕРКА ПО ПРАВОЙ ГРАНИЦЕ
     htSubSearch(l_FoundByFreeNum,
                 l_FoundByLimit,
                 Handle,
                 ftLimit,
                 GREAT_EQUAL,
                 @aFreeNum,
                 nil);
     try
      if l_FoundByLimit.gFoundCnt > 0 then
       Result := True
      else
      begin
       // поиск точного соответствия (FreeNum = aFreeNum, Limit = 0)
       htSubSearch(l_FoundByFreeNum,
                   l_FoundByExactFreeNum,
                   Handle,
                   ftFreeNum,
                   EQUAL,
                   @aFreeNum,
                   nil);
       try
        if l_FoundByExactFreeNum.gFoundCnt > 0 then
        begin
         htSubSearch(l_FoundByExactFreeNum,
                     l_FoundByExactLimit,
                     Handle,
                     ftLimit,
                     EQUAL,
                     @c_EmptyLimit,
                     nil);
         try
          Result := l_FoundByExactLimit.gFoundCnt > 0;
         finally
          htClearResults(l_FoundByExactLimit);
         end;
        end; // if
       finally
        htClearResults(l_FoundByExactFreeNum);
       end;
      end; // if-else
     finally
      htClearResults(l_FoundByLimit);
     end;
    end; // if
   finally
    htClearResults(l_FoundByFreeNum);
   end;
  end;
 finally
  htClearResults(l_FoundByName);
 end;
end;

function TFreeTbl.GetFreeFromTable(aName : TTblNameStr;
                                   var aResultValue: LongWord): Boolean;
var
 SrchStr : TNameArr;
 l_FoundRec: TFreeFullRec;
 l_AttemptNo: Integer;
 l_SortedRecs: Sab;
begin
 SrchStr:=NameForSearch(aName);

 aResultValue := High(LongWord);
 for l_AttemptNo := 1 to ATTEMPT_AMOUNT + 1 do
 begin
  if l_AttemptNo > ATTEMPT_AMOUNT then
   raise Exception.Create('Не удалось получить свободный номер из таблицы FREE.');

  if StartTA(MaxFreeOpTime) then
  try
   // фильтрация по TblName
   htSearch(nil,fSrchSab,Handle,1,EQUAL,@SrchStr,Nil);
   try
    if fSrchSab.gFoundCnt > 0 then
    begin
     // сортировка по Limit (записи с Limit=0 д.б. первыми)
     Ht(htSortResults(l_SortedRecs, fSrchSab, @ftLimit, 1));
     try
      // читаем запись с наименьшим Limit
      Ht(htOpenResults(l_SortedRecs, ROPEN_READ, nil, 0));
      try
       htReadResults(l_SortedRecs, @l_FoundRec, SizeOf(l_FoundRec));

       aResultValue := l_FoundRec.FreeNum;

       // проверка: диапазон или одиночное значение?
       if (l_FoundRec.Limit > 0) // явно диапазон
        and (l_FoundRec.FreeNum < l_FoundRec.Limit) // диапазон содержит более одного значения
       then
       begin // имееем дело с диапазоном
        Inc(l_FoundRec.FreeNum);
        Ht(htRecordModify(Handle, l_FoundRec.RecNo, @l_FoundRec.TblName));
       end
       else // имееем дело с одиночным значением
        Ht(htRecordDelete(Handle, l_FoundRec.RecNo));
      finally
       htCloseResults(l_SortedRecs);
      end;
     finally
      htClearResults(l_SortedRecs);
     end;
    end; // if
   finally
    htClearResults(fSrchSab);
   end;
   SuccessTA;
   Break; // пора прекращать крутить цикл
  except
   aResultValue := High(LongWord);
   RollBackTA;
   Sleep(PAUSE_SIZE);
  end;
 end; // for

 Result := aResultValue <> High(LongWord);
end;

Procedure TFreeTbl.PutFree(aName : TTblNameStr; aFreeNum : LongWord);
var
 l_Rec: TFreeRec;
Begin
{$IfNDef ReUseNumberOff} // запрещение возврата свободных номеров
 If aFreeNum = 0 then
  Exit;

 if IsFree(aName, aFreeNum) then // такой aFreeNum в таблице уже имеется
  Exit;

 If StartTA(MaxFreeOpTime) then
  Try
   l_Rec.TblName := NameForSearch(aName);
   l_Rec.FreeNum := aFreeNum;
   l_Rec.Limit   := c_EmptyLimit;
   Try
    Ht(htRecordAdd(Handle, @l_Rec));
   except
   end;
   SuccessTA;
  except
   RollBackTA;
   raise EHtErrors.CreateInt(ecFreeTblErr);
  end
 else
  raise EHtErrors.CreateInt(ecFreeTblErr);
{$EndIf}
end;

Procedure TFreeTbl.PutFrees(aName : TTblNameStr;aFreeNums : SAB;aWordSized : Boolean);

 var
  l_TblName : TNameArr;
  l_Nums : TList;

 function lAddNumsToFree(nOrder: ADD_MODE; fpParm: LPAPARM):Cardinal;
 var
  I      : Integer;
  l_Rec  : TFreeRec;
  l_AmountToAdd: Integer;
 begin

  // заполнение l_Rec.TblName
  l3Move(l_TblName, l_Rec.TblName, SizeOf(l_Rec.TblName));
  // заполнение l_Rec.Limit
  l_Rec.Limit := 0;

  l_AmountToAdd := Min(l_Nums.Count,
                       fpParm^.wBufLen div fpParm^.wRecordLen);
  for I := 0 to l_AmountToAdd - 1 do
  begin
   // заполнение l_Rec.FreeNum
   l_Rec.FreeNum := LongWord(l_Nums[I]);
   l_Nums[I] := nil; // таким образом отмечаем уже взятые из списка значения

   l3Move(l_Rec, (PChar(fpParm^.fpBuf) + I * fpParm^.wRecordLen)^, SizeOf(l_Rec));
  end;
  l_Nums.Pack; // удаляем помеченные значения
  Result := l_AmountToAdd * fpParm^.wRecordLen;
 end;

type
 TTableRec = packed record
               FreeNum,
               Limit: LongWord;
              end;
var
 l_AllRecs    : Sab;
 l_Rec        : TFreeFullRec;
 l_ArrSize    : Integer;
 l_TableData  : array of TTableRec;
 I,J          : Integer;
 l_FreeNum    : LongWord;
 l_TmpFreeNum : Word;
 l_AlreadyInTable: Boolean;
 l_DataForAddingNumsToFree: TDataForAddingNumsToFree;
 lHTStub      : Pointer;

begin
{$IfNDef ReUseNumberOff} // запрещение возврата свободных номеров
 if aFreeNums.gFoundCnt = 0 then exit;

 l_TblName := NameForSearch(aName);

 l_Nums := TList.Create;
 try
  // получение данных из таблицы
  htSearch(nil,
           l_AllRecs,
           Handle,
           ftTblName,
           EQUAL,
           @l_TblName,
           nil);
  try
   Ht(htOpenResults(l_AllRecs, ROPEN_READ, nil, 0));
   try
    // переносим данные в локальный массив
    l_ArrSize := l_AllRecs.gFoundCnt;
    SetLength(l_TableData, l_ArrSize);

    for I := 0 to l_AllRecs.gFoundCnt - 1 do
    begin
     htReadResults(l_AllRecs, @l_Rec, SizeOf(l_Rec));
     l_TableData[I].FreeNum := l_Rec.FreeNum;
     l_TableData[I].Limit   := l_Rec.Limit;
    end;
   finally
    htCloseResults(l_AllRecs);
   end;
  finally
   htClearResults(l_AllRecs);
  end;

  // перенос данных из aFreeNums в список
  Ht(htOpenResults(aFreeNums, ROPEN_READ, nil, 0));
  try
   l_Nums.Clear;
   l_Nums.Capacity := aFreeNums.gFoundCnt;
   for I := 0 to aFreeNums.gFoundCnt - 1 do
   begin
    if aWordSized then
    begin
     htReadResults(aFreeNums, @l_TmpFreeNum, SizeOf(l_TmpFreeNum)); // Word
     l_FreeNum := l_TmpFreeNum;
    end
    else
     htReadResults(aFreeNums, @l_FreeNum, SizeOf(l_FreeNum)); // LongWord

    // пропускаем дубликаты и "уже имеющиеся в таблице"
    if l_Nums.IndexOf(Pointer(l_FreeNum)) = -1 then // не дубликат
    begin
     for J := 0 to l_ArrSize - 1 do
     begin
      l_AlreadyInTable := ((l_TableData[J].FreeNum = l_FreeNum) and (l_TableData[J].Limit = c_EmptyLimit)) // точное совпадение
                       or ((l_TableData[J].FreeNum <= l_FreeNum) and (l_FreeNum <= l_TableData[J].Limit)); // попадание в интервал
      if l_AlreadyInTable then
       Break;
     end;

     if not l_AlreadyInTable then
      l_Nums.Add(Pointer(l_FreeNum));
    end;
   end;
  finally
   htCloseResults(aFreeNums);
  end;

  // собственно добавление
  if StartTA(MaxFreeOpTime) then
   try
    try
     lHTStub := HTStub3(@lAddNumsToFree);
     try
      Ht(htPureAddRecords(Handle, l_Nums.Count, lHTStub, nil));
     finally
      HTStubFree(lHTStub);
     end;

    except
    end;
    SuccessTA;
   except
    RollBackTA;
    raise EHtErrors.CreateInt(ecFreeTblErr);
   end
  else
   raise EHtErrors.CreateInt(ecFreeTblErr);

 finally
  l_Nums.Free;
  l_TableData := nil;
 end;
{$EndIf}
end;

Procedure TFreeTbl.ExcludeFree(aName : TTblNameStr;aNum : LongWord);
begin
 if not ExcludeFreeFromReplica(aName, aNum) then
  ExcludeFreeFromTable(aName, aNum);
end;
(*
Procedure TFreeTbl.CheckFreeNumbers(aName : TTblNameStr;aNums : Sab);
var
 l_Nums: Tl3LongintList;
Begin
 Try
  LockTbl;
 except
  raise EHtErrors.CreateInt(ecFreeTblErr);
 end;
 Try

  l_Nums := Tl3LongintList.Create;
  try
   // переносим список номеров в TList
   //GlobalHtServer.SabToList(aNums, l_Nums);
   dtCopyValuesSabToList(aNums, l_Nums);

   // удаляем то, что можно удалить из реплики
   ExcludeFreeNumsFromReplica(aName, l_Nums);

   // удаляем то, что можно удалить из таблицы
   ExcludeFreeNumsFromTable(aName, l_Nums);

  finally
   l3Free(l_Nums);
  end;

 finally
  UnLockTbl;
 end;
end;
*)
Procedure TFreeTbl.ResetFreeTblNum(aName: TTblNameStr;
                                   aStartNum: LongWord = 1;
                                   aMaxNum: LongWord = NO_LIMIT);
Var
 SrchStr : TNameArr;
 ShRec   : TFreeRec;
Begin
 If StartTA(MaxFreeOpTime) then
  Try
   SrchStr:=NameForSearch(aName);
   htSearch(nil,fSrchSab,Handle,1,EQUAL,@SrchStr,Nil);
   Try
    If (fSrchSab.gFoundCnt<>0) then
     htDeleteRecords(fSrchSab);

    ShRec.FreeNum:=aStartNum;
    ShRec.TblName:=SrchStr;
    ShRec.Limit := aMaxNum;
    Ht(htRecordAdd(Handle,@ShRec));
   finally
    htClearResults(fSrchSab);
   end;
   SuccessTA;
  except
   RollBackTA;
   raise;
  end;
end;

procedure TFreeTbl.AddInterval(aName: TTblNameStr;
                               aLowNum: LongWord = 1;
                               aHiNum: LongWord = NO_LIMIT);
var
 l_Tmp: LongWord;
 l_Name: TNameArr;
 l_MergeRecNo : LongInt;
 l_Sab: ISab;
 l_DelSab: ISab;
 l_DelList: Tl3RecList;
 l_Stub: Pointer;

 procedure MergeTo(aRecNo: LongInt);
 begin
  // если текущий диапазон получен слиянием с некоей записью, то ее надо удалить перед слиянием с новой
  if l_MergeRecNo >= 0 then
   l_DelList.Add(l_MergeRecNo);
  l_MergeRecNo := aRecNo;
 end;

 function lCheckRange(gRecNo : LongInt; aRange : PFreeRec) : MFUNC_RET;
 begin
  Result := MFUNC_SUCCESS;
  if l_MergeRecNo < MaxInt then
  begin
   if aLowNum < aRange.FreeNum then
   begin
    if aHiNum >= aRange.FreeNum then // перехлест все-таки есть
    begin
     if aHiNum > aRange.Limit then
     begin
      // существующий диапазон внутри нового, существующий следует удалить
      l_DelList.Add(gRecNo);
     end
     else // aHiNum внутри существующего диапазона
     begin
      MergeTo(gRecNo);
      aRange.FreeNum := aLowNum;
      aHiNum := aRange.Limit;
     end;
    end;
   end
   else
   begin
    if aLowNum <= aRange.Limit then // диапазоны накладываются
    begin
     if aHiNum <= aRange.Limit then
     begin
      // новый диапазон - внутри существующего, дальнейший поиск не имеет смысла
      MergeTo(MaxInt);
     end
     else
     begin
      // aLowNum внутри существующего диапазона
      MergeTo(gRecNo);
      aRange.Limit := aHiNum;
      aLowNum := aRange.FreeNum;
     end;
    end;
   end;
  end;
 end;

begin
 // простое упорядочивание входных данных
 if aLowNum > aHiNum then
 begin
  l_Tmp := aHiNum;
  aHiNum := aLowNum;
  aLowNum := l_Tmp;
 end;

 l_MergeRecNo := -1;

 l_Name := NameForSearch(aName);

 l_Sab := MakeSab(Self);
 try
  l_Sab.Select(ftTblName, l_Name);
  if l_Sab.Count > 0 then
  begin
   l_DelList := Tl3RecList.Create(ht_SizeOfSurrogateKey);
   try
    l_Stub := HTStub3(@lCheckRange);
    try
     l_Sab.ModifyRecs(l_Stub);
    finally
     HTStubFree(l_Stub);
    end;
    if l_DelList.Count > 0 then
    begin
     l_DelSab := MakeValueSet(Self, 0, l_DelList);
     try
      l_DelSab.RecordsByKey;
      l_DelSab.DeleteFromTable;
     finally
      l_DelSab := nil;
     end;
    end;
   finally
    l3Free(l_DelList);
   end;
  end;
 finally
  l_Sab := nil;
 end;

 if l_MergeRecNo = -1 then // если диапазон не был "интегрирован" в уже существующий, то
 begin
  // собственно добавление
  if StartTA(MaxFreeOpTime) then
  try
   AddIntervalPrim(aName, aLowNum, aHiNum);
   SuccessTA;
  except
   RollBackTA;
   raise EHtErrors.CreateInt(ecFreeTblErr);
  end
  else
   raise EHtErrors.CreateInt(ecFreeTblErr);
 end;
end;

function TFreeTbl.HasIntersection(aName: TTblNameStr;
                                  aLowNum, aHiNum: LongWord): Boolean;
var
 l_TblName: TNameArr;
 l_FoundByTblName,
 l_FoundByFreeNum,
 l_FoundByLimit: Sab;
 l_Tmp: LongWord;
begin
 // Алгоритм: Пересечение имеет место, если имеется хоть один интервал, у которого
 //           Limit(т.е. правый конец) > aLowNum  и  FreeNum(т.е. левый конец) < aHiNum
 Result := False;

 l_TblName := NameForSearch(aName);
 htSearch(nil,
          l_FoundByTblName,
          Handle,
          ftTblName,
          EQUAL,
          @l_TblName,
          nil);
 try
  if l_FoundByTblName.gFoundCnt > 0 then
  begin
   htSubSearch(l_FoundByTblName,
               l_FoundByLimit,
               Handle,
               ftLimit,
               GREAT_EQUAL,
               @aLowNum,
               nil);
   try
    if l_FoundByLimit.gFoundCnt > 0 then
    begin
     htSubSearch(l_FoundByLimit,
                 l_FoundByFreeNum,
                 Handle,
                 ftFreeNum,
                 LESS_EQUAL,
                 @aHiNum,
                 nil);
     try
      Result := l_FoundByFreeNum.gFoundCnt > 0;
     finally
      htClearResults(l_FoundByFreeNum);
     end;
    end; // if
   finally
    htClearResults(l_FoundByLimit);
   end;
  end; // if

  // Ну и, плюс к этому, если точные значения лежат между aLowNum, aHiNum, то тоже - нехорошо.
  if not Result then
  begin
   htSubSearch(l_FoundByTblName,
               l_FoundByFreeNum,
               Handle,
               ftFreeNum,
               IN_RANGE,
               @aLowNum,
               @aHiNum);
   try
    if l_FoundByFreeNum.gFoundCnt > 0 then
    begin
     htSubSearch(l_FoundByFreeNum,
                 l_FoundByLimit,
                 Handle,
                 ftLimit,
                 EQUAL,
                 @c_EmptyLimit,
                 nil);
     try
      Result := l_FoundByLimit.gFoundCnt > 0;
     finally
      htClearResults(l_FoundByLimit);
     end;
    end; // if
   finally
    htClearResults(l_FoundByFreeNum);
   end;
  end; // if

 finally
  htClearResults(l_FoundByTblName);
 end;
end;

procedure TFreeTbl.SetExclusiveUse(const aValue: Boolean);
var
 l_Rec   : TFreeRec;
 I: Integer;
begin
 if aValue = GetExclusiveUse then
  Exit;

 if aValue then
 begin
  LockTbl;
  f_TableReplica := TFreeTableReplica.Create;
  // реплика пока пустая, т.к. диапазоны будем забирать в реплику только при запросах
 end
 else
 begin // Перенос данных из реплики в таблицу
  for I := f_TableReplica.Count - 1 downto 0 do
   ReleaseInterval(f_TableReplica.Names[I]);

  FreeAndNil(f_TableReplica);
  UnlockTbl;
 end;
end;

function TFreeTbl.GetExclusiveUse: Boolean;
begin
 Result := f_TableReplica <> nil;
end;

{ TFreeTableReplica }

procedure TFreeTableReplica.AddInterval(aName: string;
                                        aLowNum, aHiNum: LongWord);
begin
 if f_Items.IndexOf(aName) = -1 then
  f_Items.AddObject(aName,
                    TFreeTableReplicaItem.Create(aLowNum, aHiNum));
end;

function TFreeTableReplica.IsExhausted(aName: string): Boolean;
begin
 Result := f_ExhaustedTables.IndexOf(aName) > -1;
end;

function TFreeTableReplica.Count: Integer;
begin
 Result := f_Items.Count;
end;

constructor TFreeTableReplica.Create;
begin
 f_Items := TStringList.Create;
 f_ExhaustedTables := TStringList.Create;
end;

destructor TFreeTableReplica.Destroy;
var
 I: Integer;
begin
 for I := 0 to f_Items.Count - 1 do
  f_Items.Objects[I].Free;
 f_Items.Free;

 f_ExhaustedTables.Free;

 inherited;
end;

function TFreeTableReplica.GetNum(const aTblName: string;
                                  var aResultValue: LongWord): Boolean;
var
 l_ItemIndex: Integer;
begin
 l_ItemIndex := f_Items.IndexOf(aTblName);
 Result := (l_ItemIndex > -1) and not Items[l_ItemIndex].IsEmpty;
 if Result then
 begin
  aResultValue := Items[l_ItemIndex].LowNum;
  Inc(Items[l_ItemIndex].LowNum);
 end;
end;

function TFreeTableReplica.GetItem(Index: Integer): TFreeTableReplicaItem;
begin
 if (Index >= 0) and (Index < f_Items.Count) then
  Result := TFreeTableReplicaItem(f_Items.Objects[Index])
 else
  Result := nil;
end;

function TFreeTableReplica.GetName(Index: Integer): string;
begin
 Result := f_Items[Index];
end;

function TFreeTableReplica.HasDataFor(aName: string): Boolean;
begin
 Result := f_Items.IndexOf(aName) > -1;
end;

procedure TFreeTableReplica.SetExhausted(aName: string);
begin
 if f_ExhaustedTables.IndexOf(aName) = -1 then
  f_ExhaustedTables.Add(aName);
end;

function TFreeTableReplica.ExcludeNum(const aTblName: string;
                                      aNum: LongWord): Boolean;
begin
 Result := ExcludeDiapasonOfNums(aTblName, aNum, aNum); // диапазон из одного элемента aNum
end;

function RangeTruncation(var aMinuendStart, aMinuendEnd: LongWord;
                         var aAddedStart, aAddedEnd: Longword;
                         const aSubtrahendStart, aSubtrahendEnd: LongWord): Boolean;
begin
 Result := (aSubtrahendEnd >= aMinuendStart) and (aSubtrahendStart <= aMinuendEnd);
 // Result =  имеет ли место пересечение Minuend (уменьшаемое) и Subtrahend (вычитаемое)

 aAddedStart := NO_LIMIT; // флажок, что пока новый диапазон мы добавлять не собираемся

 if Result then
 begin
  // - если правый край Subtrahend внутри Minuend (при этом левый м.б. как внутри, так и снаружи)
  if (aMinuendStart <= aSubtrahendEnd) and (aSubtrahendEnd <= aMinuendEnd) then
  begin
   if aMinuendStart < aSubtrahendStart then // левый край внутри?
   begin
    // Subtrahend полностью внутри Minuend - надо делить диапазон на два
    aAddedStart := aMinuendStart;
    aAddedEnd   := aSubtrahendStart-1;
    aMinuendStart := aSubtrahendEnd+1;
   end
   else
    // просто отрезаем левую часть Minuend
    aMinuendStart := aSubtrahendEnd + 1
  end

  // - если левый край Subtrahend внутри Minuend
  else if (aMinuendStart <= aSubtrahendStart) and (aSubtrahendStart <= aMinuendEnd) then
   // то отрезаем правую часть Minuend
   aMinuendEnd := aSubtrahendStart - 1

  // - если Minuend целиком содержится внутри Subtrahend
  else if (aSubtrahendStart <= aMinuendStart) and (aMinuendEnd <= aSubtrahendEnd) then
   // то вырезаем всю Minuend нахрен
   aMinuendStart := aMinuendEnd + 1;
 end;
end;

function TFreeTableReplica.ExcludeDiapasonOfNums(const aTblName: string;
                                                 aLowNum,
                                                 aHiNum: LongWord): Boolean;
var
 l_ReplicaItem: TFreeTableReplicaItem;
 l_AddStart, l_AddEnd: Longword;
begin
 Result := False;

 l_ReplicaItem := ItemByName(aTblName);
 if (l_ReplicaItem = nil) or l_ReplicaItem.IsEmpty then
  Exit;

 // сначала вычислим результат
 Result := (l_ReplicaItem.LowNum <= aLowNum) and (aHiNum <= l_ReplicaItem.HiNum); // диапазон ПОЛНОСТЬЮ уложился в реплику

 // потом начинаем кроить реплику
 RangeTruncation(l_ReplicaItem.LowNum,
                 l_ReplicaItem.HiNum,
                 l_AddStart, l_AddEnd,
                 aLowNum,
                 aHiNum);
 if l_AddStart <> NO_LIMIT then
  AddInterval(aTblName, l_AddStart, l_AddEnd);
end;

function TFreeTableReplica.ItemByName(const aTblName: string): TFreeTableReplicaItem;
var
 l_ItemIndex: Integer;
begin
 l_ItemIndex := f_Items.IndexOf(aTblName);
 if l_ItemIndex > -1 then
  Result := TFreeTableReplicaItem(f_Items.Objects[l_ItemIndex])
 else
  Result := nil;
end;

procedure TFreeTableReplica.RemoveItem(aItemIndex: Integer);
begin
 if f_Items.Objects[aItemIndex] <> nil then
  f_Items.Objects[aItemIndex].Free;
 f_Items.Delete(aItemIndex);
end;

function TFreeTableReplica.IsIntervalEmpty(aName: string): Boolean;
var
 l_Found: Integer;
begin
 l_Found := f_Items.IndexOf(aName);

 Result := (l_Found < 0) or Items[l_Found].IsEmpty;
end;

procedure TFreeTableReplica.DeleteInterval(aName: string);
var
 l_Found: Integer;
begin
 l_Found := f_Items.IndexOf(aName);
 if l_Found > -1 then
  RemoveItem(l_Found);
end;

function TFreeTableReplica.GetNums(const aTblName: string;
                                         aAmount: Integer;
                                     var aResultLowNum,
                                         aResultHiNum: LongWord): Boolean;
var
 l_ItemIndex: Integer;
begin
 l_ItemIndex := f_Items.IndexOf(aTblName);
 Result := (l_ItemIndex > -1) and not Items[l_ItemIndex].IsEmpty;
 if Result then
 begin
  if Items[l_ItemIndex].HiNum - Items[l_ItemIndex].LowNum + 1 >= aAmount then // номеров хватает
  begin
   aResultLowNum := Items[l_ItemIndex].LowNum;
   aResultHiNum  := aResultLowNum + aAmount - 1;
   Items[l_ItemIndex].LowNum := aResultHiNum + 1;
  end
  else // номеров маловато
  begin
   aResultLowNum := Items[l_ItemIndex].LowNum;
   aResultHiNum  := Items[l_ItemIndex].HiNum;
   Items[l_ItemIndex].LowNum := Items[l_ItemIndex].HiNum + 1;
  end;
 end;
end;

function TFreeTableReplica.AmountFor(aName: string): Integer;
var
 l_ReplItem: TFreeTableReplicaItem;
begin
 l_ReplItem := ItemByName(aName);
 if l_ReplItem <> nil then
  Result := l_ReplItem.Amount
 else
  Result := 0;
end;

{ TFreeTableReplicaItem }

function TFreeTableReplicaItem.Amount: Integer;
begin
 Result := HiNum - LowNum + 1;
end;

constructor TFreeTableReplicaItem.Create(aLowNum, aHiNum: LongWord);
begin
 LowNum     := aLowNum;
 HiNum      := aHiNum;
 OldFreeNum := aLowNum;
 OldLimit   := aHiNum;
end;

function TFreeTbl.NameArrAsStr(aNameArr: TNameArr): string;
begin
 SetLength(Result, SizeOf(TNameArr));
 StrLCopy(PChar(Result), @aNameArr, SizeOf(TNameArr));
end;

function TFreeTbl.GetFreeFromReplica(aName: TTblNameStr;
                                     var aResultValue: LongWord): Boolean;
var
 SrchStr : TNameArr;
begin
 Result := False;
 if ExclusiveUse then
 begin
  // если интервал был захвачен и затем полностью израсходован, то он удаляется и из таблицы и из реплики
  if f_TableReplica.HasDataFor(aName)
   and f_TableReplica.IsIntervalEmpty(aName)
  then
   ReleaseInterval(aName);

  // "подкачка" (при необходимости) интервала из таблицы
  if not f_TableReplica.HasDataFor(aName)
   and not f_TableReplica.IsExhausted(aName)
  then
   CaptureInterval(aName);

  Result := f_TableReplica.GetNum(aName, aResultValue);
 end;
end;

function TFreeTbl.GetFree(aName: TTblNameStr): LongWord;
begin
 // первая попытка
 if not GetFreeFromReplica(aName, Result) then
  if not GetFreeFromTable(aName, Result) then
   // поиск и попытка освобождения залоченных интервалов
   if not RepairInterval(aName) then
    raise EHtErrors.CreateInt(ecFreeTblErr)
   else  // вторая попытка
   begin
    if not GetFreeFromReplica(aName, Result) then
     if not GetFreeFromTable(aName, Result) then
      // выстрел в голову
      raise EHtErrors.CreateInt(ecFreeTblErr);
   end;
end;

function TFreeTbl.ExcludeFreeFromReplica(aName: TTblNameStr;
                                         aNum: LongWord): Boolean;
begin
 Result := ExclusiveUse and f_TableReplica.ExcludeNum(aName, aNum);
end;

procedure TFreeTbl.ExcludeFreeFromTable(aName: TTblNameStr;
                                        aNum: LongWord);
var
 SrchStr : TNameArr;
 l_FoundRec: TFreeFullRec;
 l_FoundRecs: Sab;
 I: Integer;
 l_AllDone: Boolean;
 l_AddStart, l_AddEnd: Longword;
 l_Rec: TFreeRec;
begin
 l_AllDone := False;
 SrchStr:=NameForSearch(aName);

 if StartTA(MaxFreeOpTime) then
 try
  // фильтрация по TblName
  htSearch(nil,fSrchSab,Handle,1,EQUAL,@SrchStr,Nil);
  try
   if (fSrchSab.gFoundCnt <> 0) then
   begin
    // ищем точное совпадение
    htSubSearch(fSrchSab,
                l_FoundRecs,
                Handle,
                ftFreeNum,
                EQUAL,
                @aNum,
                nil);
    try
     if l_FoundRecs.gFoundCnt > 0 then
     begin
      Ht(htOpenResults(l_FoundRecs, ROPEN_READ, nil, 0));
      try
       htReadResults(l_FoundRecs, @l_FoundRec, SizeOf(l_FoundRec));
       if (l_FoundRec.Limit = c_EmptyLimit) then // не диапазон
       begin
        Ht(htRecordDelete(Handle, l_FoundRec.RecNo));
        l_AllDone := True;
       end;
      finally
       htCloseResults(l_FoundRecs);
      end;
     end;
    finally
     htClearResults(l_FoundRecs);
    end;

    // точное совпадение не найдено - ищем подходящий диапазон
    if not l_AllDone then
    begin
     htSubSearch(fSrchSab,
                 l_FoundRecs,
                 Handle,
                 ftLimit,
                 NOT_EQUAL,
                 @c_EmptyLimit,
                 nil); // все диапазоны
     try
      if l_FoundRecs.gFoundCnt > 0 then
      begin
       Ht(htOpenResults(l_FoundRecs, ROPEN_READ, nil, 0));
       try
        for I := 0 to l_FoundRecs.gFoundCnt - 1 do
        begin
         htReadResults(l_FoundRecs, @l_FoundRec, SizeOf(l_FoundRec));

         // попали в диапазон?
         if (aNum >= l_FoundRec.FreeNum) and (aNum <= l_FoundRec.Limit) then
         begin
          // проверяем, может это одно из крайних значений?
          // в этом случае достаточно просто смодифицировать запись...
          l_AddStart := NO_LIMIT; // добавлять пока ничего не собираемся
          if l_FoundRec.FreeNum = aNum then
           l_FoundRec.FreeNum := aNum+1
          else
           if l_FoundRec.Limit = aNum then
            l_FoundRec.Limit := aNum-1
           else // число - внутри диапазона. пилим диапазон на два.
           begin
            l_AddStart := aNum+1;
            l_AddEnd   := l_FoundRec.Limit;
            l_FoundRec.Limit := aNum - 1;
           end;
          // записываем в базу что мы навычисляли тут
          if l_FoundRec.FreeNum <= l_FoundRec.Limit then
           Ht(htRecordModify(Handle, l_FoundRec.RecNo, @l_FoundRec.TblName))
          else
           Ht(htRecordDelete(Handle, l_FoundRec.RecNo));
          if l_AddStart <> NO_LIMIT then
          begin
           l_Rec.TblName := l_FoundRec.TblName;
           l_Rec.FreeNum := l_AddStart;
           l_Rec.Limit   := l_AddEnd;
           Ht(htRecordAdd(Handle, @l_Rec));
          end;
          Break;
         end; // if
        end; // for
       finally
        htCloseResults(l_FoundRecs);
       end;
      end; // if
     finally
      htClearResults(l_FoundRecs);
     end;
    end; // if
   end; // if
  finally
   htClearResults(fSrchSab);
  end;
  SuccessTA;
 except
  RollBackTA;
  raise;
 end;
end;

function TFreeTbl.ExcludeFreeNumsFromReplica(aName: TTblNameStr;
                                             aNums: Tl3LongintList): Boolean;
var
 I: Integer;
 l_MaxNum: Integer;
 l_MinNum: Integer;
 l_ReplicaItem: TFreeTableReplicaItem;
begin
 Result := False;
 if not ExclusiveUse
  or not f_TableReplica.HasDataFor(aName)
  or (aNums = nil) or (aNums.Count = 0)
 then
  Exit;

 l_ReplicaItem := f_TableReplica.ItemByName(aName);
 if l_ReplicaItem.IsEmpty then
  Exit;

 l_MaxNum := l_ReplicaItem.LowNum - 1;
 l_MinNum := l_ReplicaItem.HiNum  + 1;
 for I := aNums.Count - 1 downto 0 do
 begin
  if (LongWord(aNums[I]) >= l_ReplicaItem.LowNum)
   and (LongWord(aNums[I]) <= l_ReplicaItem.HiNum) then
  begin
   // вычисление максимального-минимального значений в списке, среди тех, которые попадают в интервал
   l_MaxNum := Max(l_MaxNum, LongWord(aNums[I]));
   l_MinNum := Min(l_MinNum, LongWord(aNums[I]));

   // значение попавшее в интервал - удаляется
   aNums.Delete(I);
  end;
 end; // for

 // обрезаем интервал по вычисленным макс. - миним. значеням
 if l_MaxNum > l_MinNum then
  f_TableReplica.ExcludeDiapasonOfNums(aName, l_MinNum, l_MaxNum);

 Result := aNums.Count = 0; // все номера попали в реплику
end;

procedure TFreeTbl.ExcludeFreeNumsFromTable(aName: TTblNameStr;
                                            aNums: Tl3LongintList);
type
 TTableRec = packed record
               RecNo,
               FreeNum,
               Limit,
               NewFreeNum: LongWord;
               ToDelete: Boolean;
              end;
var
 l_TblName: TNameArr;
 l_AllRecs: Sab;
 l_Rec: TFreeFullRec;
 l_ArrSize: Integer;

 l_TableData: array of TTableRec;

 I,
 J: Integer;
Begin
 if (aNums = nil) or (aNums.Count = 0) then
  Exit;

 l_TblName := NameForSearch(aName);

 // получение данных из таблицы
 try
  htSearch(nil,
           l_AllRecs,
           Handle,
           ftTblName,
           EQUAL,
           @l_TblName,
           nil);
  try
   Ht(htOpenResults(l_AllRecs, ROPEN_READ, nil, 0));
   try
    // переносим данные в локальный массив
    l_ArrSize := l_AllRecs.gFoundCnt;
    SetLength(l_TableData, l_ArrSize);

    for I := 0 to l_AllRecs.gFoundCnt - 1 do
    begin
     htReadResults(l_AllRecs, @l_Rec, SizeOf(l_Rec));
     l_TableData[I].RecNo      := l_Rec.RecNo;
     l_TableData[I].FreeNum    := l_Rec.FreeNum;
     l_TableData[I].NewFreeNum := l_Rec.FreeNum;
     l_TableData[I].Limit      := l_Rec.Limit;
     l_TableData[I].ToDelete   := False;
    end;
   finally
    htCloseResults(l_AllRecs);
   end;
  finally
   htClearResults(l_AllRecs);
  end;

  for I := 0 to aNums.Count - 1 do // перебор  списка
   for J := 0 to l_ArrSize - 1 do   // перебор записей
   begin
    if l_TableData[J].Limit = c_EmptyLimit then
    begin // поиск точного совпадения
     if (l_TableData[J].FreeNum = LongWord(aNums[I])) then
     begin
      l_TableData[J].ToDelete := True;
      Break;
     end; // if
    end
    else
    begin // проверка на попадание в интервал
     if   (LongWord(aNums[I]) >= l_TableData[J].NewFreeNum)
      and (LongWord(aNums[I]) <= l_TableData[J].Limit) then
     begin
      l_TableData[J].NewFreeNum := LongWord(aNums[I]); // обрезаем левую часть интервала
      Break;
     end; // if
    end; // if-else
   end; // for
  // for

  // собственно изменение данных в таблице
  if StartTA(MaxFreeOpTime) then
   try
    for I := 0 to l_ArrSize - 1 do
    begin
     if l_TableData[I].ToDelete then
      Ht(htRecordDelete(Handle, l_TableData[I].RecNo))
     else if l_TableData[I].FreeNum <> l_TableData[I].NewFreeNum then
     begin
      l_Rec.TblName := l_TblName;
      l_Rec.FreeNum := Succ(l_TableData[I].NewFreeNum);
      l_Rec.Limit   := l_TableData[I].Limit;
      Ht(htRecordModify(Handle, l_TableData[I].RecNo, @l_Rec.TblName));
     end;
    end;

    SuccessTA;
   except
    RollBackTA;
    raise EHtErrors.CreateInt(ecFreeTblErr);
   end
  else
   raise EHtErrors.CreateInt(ecFreeTblErr);

 finally
  l_TableData := nil;
 end;
end;

function TFreeTbl.CaptureInterval(const aName: TTblNameStr): Boolean;
var
 SrchStr : TNameArr;
 l_FoundRec: TFreeFullRec;
 l_Intervals,
 l_SortedIntervals: Sab;
begin
 Result := False;
 if StartTA(MaxFreeOpTime) then
 try
  // фильтрация по TblName
  SrchStr := NameForSearch(aName);
  htSearch(nil, fSrchSab, Handle, ftTblName, EQUAL, @SrchStr, nil);
  try
   if (fSrchSab.gFoundCnt > 0) then
   begin
    // фильтрация по Limit (д.б. Limit <> 0)
    htSubSearch(fSrchSab, l_Intervals, Handle, ftLimit, NOT_EQUAL, @c_EmptyLimit, nil);
    try
     if l_Intervals.gFoundCnt > 0 then
     begin
      // читаем интервал с наименьшим FreeNum
      Ht(htSortResults(l_SortedIntervals, l_Intervals, @ftFreeNum, 1));
      try
       Ht(htOpenResults(l_SortedIntervals, ROPEN_READ, nil, 0));
       try
        htReadResults(l_SortedIntervals, @l_FoundRec, SizeOf(l_FoundRec));

        // сначала поставим пометку на этот интервал в таблице
        AddMark(l_FoundRec.TblName);
        Ht(htRecordModify(Handle, l_FoundRec.RecNo, @l_FoundRec.TblName));

        // а потом только копируем в реплику
        f_TableReplica.AddInterval(aName, l_FoundRec.FreeNum, l_FoundRec.Limit);

        Result := True;
       finally
        htCloseResults(l_SortedIntervals);
       end;
      finally
       htClearResults(l_SortedIntervals);
      end;
     end
     else
      f_TableReplica.SetExhausted(aName); // а интервалов-то в таблице больше-то и нету
    finally
     htClearResults(l_Intervals);
    end;
   end; // if
  finally
   htClearResults(fSrchSab);
  end;
  SuccessTA;
 except
  RollBackTA;
  raise;
 end;
end;

function TFreeTbl.ReleaseInterval(const aName: TTblNameStr): Boolean;
var
 l_ReplicaItem: TFreeTableReplicaItem;
 l_MarkedTblName: TNameArr;
 l_FoundRec: TFreeFullRec;

 l_FoundByMarkedName,
 l_FoundByFreeNum,
 l_FoundByLimit: Sab;
begin
 l_ReplicaItem := f_TableReplica.ItemByName(aName);

 if l_ReplicaItem = nil then
  Exit;

 // Проверим на пересечение - если обнаружится хоть одно, то выбрасываем исключение.
 if HasIntersection(aName,
                    l_ReplicaItem.LowNum,
                    l_ReplicaItem.HiNum) then
  raise Exception.Create('Невозможно вернуть интервал в таблицу FREE, ' +
                         'т.к. обнаружен конфликт с уже имеющимися в этой таблице интервалами.');

 // снимаем метку и меняем значения интервала (при необходимости удаляем интервал вообще)
 // Для этого ищем запись с помеченным именем и диапазоном соотв. захваченному.
 if StartTA(MaxFreeOpTime) then
 try
  // фильтрация по TblName с меткой
  l_MarkedTblName := NameForSearch(aName);
  AddMark(l_MarkedTblName);

  htSearch(nil,
           l_FoundByMarkedName,
           Handle,
           ftTblName,
           EQUAL,
           @l_MarkedTblName,
           nil);
  try
   if (l_FoundByMarkedName.gFoundCnt > 0) then
   begin
    // фильтрация по FreeNum
    htSubSearch(l_FoundByMarkedName,
                l_FoundByFreeNum,
                Handle,
                ftFreeNum,
                EQUAL,
                @l_ReplicaItem.OldFreeNum,
                nil);
    try
     if l_FoundByFreeNum.gFoundCnt > 0 then
     begin
      // фильтрация по Limit
      htSubSearch(l_FoundByFreeNum,
                  l_FoundByLimit,
                  Handle,
                  ftLimit,
                  EQUAL,
                  @l_ReplicaItem.OldLimit,
                  nil);
      try
       if l_FoundByLimit.gFoundCnt > 0 then
       begin
        if l_ReplicaItem.IsEmpty then // удаление исчерпанного интервала
         htDeleteRecords(l_FoundByLimit)
        else // снимаем пометку и меняем границы интервала
        begin
         Ht(htOpenResults(l_FoundByLimit, ROPEN_READ, nil, 0));
         try
          htReadResults(l_FoundByLimit, @l_FoundRec, SizeOf(l_FoundRec));

          // снятие метки
          l_FoundRec.TblName := NameForSearch(aName);
          // новые значения интервала
          l_FoundRec.FreeNum := l_ReplicaItem.LowNum;
          l_FoundRec.Limit   := l_ReplicaItem.HiNum;

          Ht(htRecordModify(Handle, l_FoundRec.RecNo, @l_FoundRec.TblName));

          Result := True;
         finally
          htCloseResults(l_FoundByLimit);
         end;
        end; // if-else
       end; // if
      finally
       htClearResults(l_FoundByLimit);
      end;
     end; // if
    finally
     htClearResults(l_FoundByFreeNum);
    end;
   end; // if
  finally
   htClearResults(l_FoundByMarkedName);
  end;
  SuccessTA;
 except
  RollBackTA;
  raise;
 end;
 // удаление из реплики
 f_TableReplica.DeleteInterval(aName);
end;

function TFreeTbl.RepairInterval(const aName: TTblNameStr): Boolean;
var
 l_MarkedTblName: TNameArr;
 l_FoundRec: TFreeFullRec;

 l_FoundByMarkedName,
 l_FoundByFreeNum,
 l_FoundByLimit: Sab;
 l_MaxUsedId: Integer;
 l_Table: TAbsHtTbl;
 l_TableIndex: Integer;
begin
 Result := False;
 l_TableIndex := CalcTableIndex(TblFamily, PrefName(aName));
 if l_TableIndex < 0 then
  Exit;
 if (TblFamily <> CurrentFamily) or not IsTableHasPassport(TFamTbls(l_TableIndex)) then
  Exit;
 if StartTA(MaxFreeOpTime) then
 try
  // фильтрация по TblName с меткой
  l_MarkedTblName := NameForSearch(aName);
  AddMark(l_MarkedTblName);

  htSearch(nil,
           l_FoundByMarkedName,
           Handle,
           ftTblName,
           EQUAL,
           @l_MarkedTblName,
           nil);
  try
   if (l_FoundByMarkedName.gFoundCnt > 0) then
   begin
    l_Table := GlobalHtServer.GetTblObjectEx(TblFamily, l_TableIndex);

    Ht(htOpenResults(l_FoundByMarkedName, ROPEN_READ, nil, 0));
    try
     while htReadResults(l_FoundByMarkedName,
                         @l_FoundRec,
                         SizeOf(l_FoundRec)) > 0 do
     begin
      l_MaxUsedId := l_Table.MaxIdBetween(l_FoundRec.FreeNum,
                                          l_FoundRec.Limit);
      if (l_MaxUsedId < l_FoundRec.FreeNum) then
      begin
       // все в порядке, надо только снять метку
       l_FoundRec.TblName := NameForSearch(aName);

       Ht(htRecordModify(Handle, l_FoundRec.RecNo, @l_FoundRec.TblName));
       Result := True;
       Break;
      end
      else if (l_MaxUsedId >= l_FoundRec.FreeNum) and (l_MaxUsedId < l_FoundRec.Limit) then
      begin
       // Интервал надо корректировать
       // снимаем метку
       l_FoundRec.TblName := NameForSearch(aName);
       // новое значение FreeNum (Limit остается прежним)
       l_FoundRec.FreeNum := l_MaxUsedId + 1;

       Ht(htRecordModify(Handle, l_FoundRec.RecNo, @l_FoundRec.TblName));
       Result := True;
       Break;
      end
      else if (l_MaxUsedId >= l_FoundRec.Limit) then
      begin
       // Увы, интервал исчерпан - его надо удалить
       Ht(htRecordDelete(Handle, l_FoundRec.RecNo));
      end;
     end; // while
    finally
     htCloseResults(l_FoundByMarkedName);
    end;
   end; // if
  finally
   htClearResults(l_FoundByMarkedName);
  end;
  SuccessTA;
 except
  RollBackTA;
  raise;
 end;
end;

procedure TFreeTbl.AddMark(var aNameArr: TNameArr);
begin
 if aNameArr[1] = c_CaptureMark then // отметка уже стоит
  Exit;
 // сдвиг вправо на 1 символ
 l3Move(aNameArr[1], aNameArr[2], Length(aNameArr) - 1);
 // вставка
 aNameArr[1] := c_CaptureMark;
end;

function TFreeTbl.PrefName(const aTableName: TTblNameStr): TTblNameStr;
const
 c_BadFamily = -1;
Begin
 Result:=UpperCase(aTableName);
 if (TblFamily<>MainTblsFamily)
  and (TblFamily = StrToIntDef(Copy(aTableName, Length(aTableName) - 2, 3), c_BadFamily)) // последние 3 символа являются номером семейства
 then
  SetLength(Result, Length(aTableName) - 3);
end;

procedure TFreeTbl.ExcludeFreeNums(aName: TTblNameStr;
                                          aLowNum,
                                          aHiNum: LongWord);
begin
 if not ExcludeFreeNumsFromReplica(aName, aLowNum, aHiNum) then
  ExcludeFreeNumsFromTable(aName, aLowNum, aHiNum);
end;

function TFreeTbl.ExcludeFreeNumsFromReplica(aName: TTblNameStr;
                                              aFromNum,
                                              aToNum: LongWord): Boolean;
begin
 Result := ExclusiveUse and f_TableReplica.ExcludeDiapasonOfNums(aName, aFromNum, aToNum);
end;

procedure TFreeTbl.ExcludeFreeNumsFromTable(aName: TTblNameStr;
                                            aFromNum,
                                            aToNum: LongWord);
var
 SrchStr : TNameArr;
 l_FoundRec: TFreeFullRec;
 l_Rec: TFreeRec;
 l_FoundRecs,
 l_RecsToDelete: Sab;
 I: Integer;
 l_AddStart, l_AddEnd: Longword;
begin
 SrchStr:=NameForSearch(aName);

 if StartTA(MaxFreeOpTime) then
 try
  // фильтрация по TblName
  htSearch(nil, fSrchSab, Handle, ftTblName, EQUAL, @SrchStr, Nil);
  try
   if (fSrchSab.gFoundCnt <> 0) then
   begin
    // ищем "одиночные номера"
    // фильтруем по признаку "одиночного номера"
    htSubSearch(fSrchSab,
                l_FoundRecs,
                Handle,
                ftLimit,
                EQUAL,
                @c_EmptyLimit,
                nil);
    try
     if l_FoundRecs.gFoundCnt > 0 then
     begin
      // фильтруем по попаданию в диапазон
      htSubSearch(l_FoundRecs,
                  l_RecsToDelete,
                  Handle,
                  ftFreeNum,
                  IN_RANGE,
                  @aFromNum,
                  @aToNum);
      try
       if l_RecsToDelete.gFoundCnt > 0 then
        htDeleteRecords(l_RecsToDelete);
      finally
       htClearResults(l_RecsToDelete);
      end;
     end;
    finally
     htClearResults(l_FoundRecs);
    end;

    // ищем подходящие диапазоны
    // фильтруем по признаку отсутствия "одиночного номера"
    htSubSearch(fSrchSab,
                l_FoundRecs,
                Handle,
                ftLimit,
                NOT_EQUAL,
                @c_EmptyLimit,
                nil); // все диапазоны
    try
     if l_FoundRecs.gFoundCnt > 0 then
     begin
      Ht(htOpenResults(l_FoundRecs, ROPEN_READ, nil, 0));
      try
       for I := 0 to l_FoundRecs.gFoundCnt - 1 do
       begin
        htReadResults(l_FoundRecs, @l_FoundRec, SizeOf(l_FoundRec));

        if RangeTruncation(l_FoundRec.FreeNum,
                           l_FoundRec.Limit,
                           l_AddStart, l_AddEnd,
                           aFromNum,
                           aToNum) then // имеет место пересечение?
        begin
         if l_FoundRec.FreeNum <= l_FoundRec.Limit then
         begin
          Ht(htRecordModify(Handle, l_FoundRec.RecNo, @l_FoundRec.TblName));
          if l_AddStart <> NO_LIMIT then // диапазон распилили...
          begin
           l_Rec.TblName := l_FoundRec.TblName;
           l_Rec.FreeNum:=l_AddStart;
           l_Rec.Limit := l_AddEnd;
           Ht(htRecordAdd(Handle, @l_Rec));
          end;
         end
         else
          Ht(htRecordDelete(Handle, l_FoundRec.RecNo));
        end; // if
       end; // for
      finally
       htCloseResults(l_FoundRecs);
      end;
     end; // if
    finally
     htClearResults(l_FoundRecs);
    end;
   end; // if
  finally
   htClearResults(fSrchSab);
  end;
  SuccessTA;
 except
  RollBackTA;
  raise;
 end;
end;

function TFreeTableReplicaItem.IsEmpty: Boolean;
begin
 Result := LowNum > HiNum;
end;

procedure TFreeTbl.AddIntervalPrim(aName: TTblNameStr; aLowNum: LongWord = 1; aHiNum: LongWord = NO_LIMIT);
var
 l_Rec: TFreeRec;
begin
 if aLowNum = aHiNum then
  aHiNum := c_EmptyLimit;
 l_Rec.TblName := NameForSearch(aName);
 l_Rec.FreeNum := aLowNum;
 l_Rec.Limit   := aHiNum;

 Ht(htRecordAdd(Handle, @l_Rec));
end;

function TFreeTbl.AnyRangesPresent(aName: TTblNameStr): Boolean;
var
 l_SrchStr : TNameArr;
 l_Sab: ISab;
begin
 Result := False;
 l_SrchStr := NameForSearch(aName);
 l_Sab := MakeSab(Self);
 try
  l_Sab.Select(ftTblName, l_SrchStr);
  Result := l_Sab.IsValid and (not l_Sab.IsEmpty);
 finally
  l_Sab := nil;
 end;
end;

procedure TFreeTbl.DeleteAllIntervals(const aName: TTblNameStr);
var
 l_Sab  : ISab;
 l_Name : TNameArr;
begin
 if not IsCaptured(aName) then
 begin
  l_Sab := MakeSab(Self);
  try
   l3StringToArray(l_Name, SizeOf(TNameArr), aName);
   l_Sab.Select(ftTblName, l_Name);
   l_Sab.DeleteFromTable;
  finally
   l_Sab := nil;
  end;
 end
 else
  raise EHtErrors.CreateInt(ecFreeTblErr);
end;

procedure TFreeTbl.GetFreeNums(aName: TTblNameStr;
                               aMinAmount: Integer;
                               aMaxAmount: Integer;
                               aResultValue: TNumSet);
var
 l_FreeNumsFromReplica: TNumSet;
 l_ReplicaAmount: LongWord;
 l_TakenAmount: LongWord;
begin
 aResultValue.Clear;

 // достаточно ли номеров в реплике
 if (f_TableReplica <> nil) then
  l_ReplicaAmount := f_TableReplica.AmountFor(aName)
 else
  l_ReplicaAmount := 0;

 if l_ReplicaAmount >= aMinAmount then // все берем из реплики
 begin
  if l_ReplicaAmount < aMaxAmount then
   l_TakenAmount := l_ReplicaAmount
  else
   l_TakenAmount := aMaxAmount;

  GetFreeNumsFromReplica(aName, l_TakenAmount, aResultValue)
 end
 else // часть (а может и всё) берем из таблицы
 begin
  // Внимание! В первую очередь берем данные из таблицы - если что пойдет на так
  // при обращении к БД, то реплика останется правильной и не придется ее восстанавливать.
   if GetFreeNumsFromTable(aName,
                           aMinAmount - l_ReplicaAmount,
                           aMaxAmount - l_ReplicaAmount,
                           aResultValue) and (l_ReplicaAmount > 0) then
   begin
    l_FreeNumsFromReplica := TNumSet.Create;
    try
     if GetFreeNumsFromReplica(aName, l_ReplicaAmount, l_FreeNumsFromReplica) then
      aResultValue.AddSet(l_FreeNumsFromReplica); // объединение
    finally
     l3Free(l_FreeNumsFromReplica);
    end;
   end;

 end; // if-else
end;

function TFreeTbl.GetFreeNumsFromTable(aName: TTblNameStr;
                                       aMinAmount: Integer;
                                       aMaxAmount: Integer;
                                       aResultSet: TNumSet): Boolean;
var
 SrchStr : TNameArr;
 l_AttemptNo: Integer;
 //l_SortedRecs: Sab;
 //l_ValuesIter: TValuesIterator;
 l_AvailableAmount: LongWord;
 //l_RecNo, l_FreeNum, l_Limit: LongWord;
 l_RemainingQuantity: Integer;
 l_AllowedOverload: Integer;

 function lRecAccessProcCount(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  with PFreeRangeRec(aItemPtr)^ do
  begin
   if rTo = c_EmptyLimit then
    Inc(l_AvailableAmount)
   else
    Inc(l_AvailableAmount, rTo - rFrom + 1);

   if l_AvailableAmount >= aMinAmount then
    Result := false; // дальше можно не продолжать
  end;
 end;

 function lRecAccessProcDoIt(aItemPtr : Pointer) : Boolean;
 var
  l_Rec: TFreeRec;
 begin
  Result := True;
  with PFreeRangeExRec(aItemPtr)^ do
  begin
   //l_ValuesIter.Read(ftRecNo,   l_RecNo);
   //l_ValuesIter.Read(ftFreeNum, l_FreeNum);
   //l_ValuesIter.Read(ftLimit,   l_Limit);

   if rTo = c_EmptyLimit then
   begin // имееем дело с одиночным значением
    aResultSet.AddNum(rFrom);
    Ht(htRecordDelete(Handle, rRecNo));
    Dec(l_RemainingQuantity, 1);
   end
   else // имееем дело с диапазоном
   begin
    if rTo - rFrom + 1 > l_RemainingQuantity + l_AllowedOverload then // диапазон больше, чем надо
    begin
     aResultSet.AddRange(rFrom,
                         rFrom + l_RemainingQuantity + l_AllowedOverload - 1);
     l_Rec.TblName := SrchStr;
     l_Rec.FreeNum := rFrom + l_RemainingQuantity + l_AllowedOverload;
     l_Rec.Limit   := rTo;
     Ht(htRecordModify(Handle, rRecNo, @l_Rec));
     l_RemainingQuantity := 0;
    end
    else // диапазон маловат - используется целиком
    begin
     aResultSet.AddRange(rFrom, rTo);
     Ht(htRecordDelete(Handle, rRecNo));
     Dec(l_RemainingQuantity, rTo - rFrom + 1);
    end;
   end;
  end;
  Result := l_RemainingQuantity > 0;
 end;

 var
  lSab        : ISab;
  lRAProcStub : TdtRecAccessProc;

begin
 Result := False;

 SrchStr:=NameForSearch(aName);

 for l_AttemptNo := 1 to ATTEMPT_AMOUNT + 1 do
 begin
  if l_AttemptNo > ATTEMPT_AMOUNT then
   raise Exception.Create('Не удалось получить свободные номера из таблицы FREE.');

  aResultSet.Clear;
  if StartTA(MaxFreeOpTime) then
  try
   lSab := MakeSab(Self);
   lSab.Select(ftTblName, SrchStr);
   if lSab.Count > 0 then
   begin
    // проверка на наличие достаточного кол-ва
    l_AvailableAmount := 0;

    lRAProcStub := L2RecAccessProc(@lRecAccessProcCount);
    try
     lSab.IterateRecords(lRAProcStub, [ftFreeNum, ftLimit]);
    finally
     FreeRecAccessProc(lRAProcStub);
    end;

    if l_AvailableAmount >= aMinAmount then
    begin
     // в первую очередь забираются (подчищаются) одиночные значения -
     // сортировка по Limit (записи с Limit=0 д.б. первыми)

    lSab.Sort([ftLimit]);

    l_RemainingQuantity := aMinAmount;
    l_AllowedOverload := aMaxAmount - aMinAmount;
    lRAProcStub := L2RecAccessProc(@lRecAccessProcDoIt);
    try
     lSab.IterateRecords(lRAProcStub, [ftRecNo, ftFreeNum, ftLimit]);
    finally
     FreeRecAccessProc(lRAProcStub);
    end;

    end; // if
   end; // if
   SuccessTA;
   Result := True;
   Break;
  except
   aResultSet.Clear;
   RollBackTA;
   Sleep(PAUSE_SIZE);
  end;

 end; // for

 if l_AvailableAmount < aMinAmount then
  raise Exception.Create('Запрошенное количество свободных номеров превышает количество доступных.')
end;

function TFreeTbl.GetFreeNumsFromReplica(aName: TTblNameStr;
                                         aAmount: Integer;
                                         aResultValue: TNumSet): Boolean;
var
 SrchStr : TNameArr;
 l_ObtainedLowNum, l_ObtainedHiNum: LongWord;
begin
 Result := False;
 if ExclusiveUse then
 begin
  // если интервал был захвачен и затем полностью израсходован, то он удаляется и из таблицы и из реплики
  if f_TableReplica.HasDataFor(aName)
   and f_TableReplica.IsIntervalEmpty(aName)
  then
   ReleaseInterval(aName);

  // "подкачка" (при необходимости) интервала из таблицы
  if not f_TableReplica.HasDataFor(aName)
   and not f_TableReplica.IsExhausted(aName)
  then
   CaptureInterval(aName);

  // получение номеров из реплики
  if f_TableReplica.GetNums(aName, aAmount, l_ObtainedLowNum, l_ObtainedHiNum) then
   Result := (l_ObtainedHiNum - l_ObtainedLowNum + 1) = aAmount; // ровно столько, сколько просили
 end;
end;

function TFreeTbl.GetIntervalList(aName: TTblNameStr): Tl3RecList;
type
 PFreePortionRec = ^TFreePortionRec;
 TFreePortionRec = packed record
  FreeNum,
  Limit    : LongWord;
 end;
var
 l_Sab  : ISab;
 l_Iter : TdtRecAccessProc;
 l_Res  : Tl3RecList;
 l_Name : TNameArr;

 function Iterator(aRec : PFreePortionRec) : Boolean; register;
 var
  l_ResRec: TFreeRangeRec;
 begin
  Result := True;
  l_ResRec.rFrom := aRec.FreeNum;
  l_ResRec.rTo   := aRec.Limit;
  l_Res.Add(l_ResRec);
 end;

begin
 Result := nil;
 l_Sab := MakeSab(Self);
 try
  l_Name := NameForSearch(aName);
  l_Sab.Select(ftTblName, l_Name);
  if l_Sab.Count > 0 then
  begin
   l_Sab.Sort([ftFreeNum]);
   l_Res := Tl3RecList.Create(SizeOf(TFreeRangeRec));
   l_Iter := L2RecAccessProc(@Iterator);
   try
    l_Sab.IterateRecords(l_Iter, [ftFreeNum, ftLimit]);
   finally
    FreeRecAccessProc(l_Iter);
   end;
   Result := l_Res;
  end;
 finally
  l_Sab := nil;
 end;
end;

function TFreeTbl.IsCaptured(const aName: TTblNameStr): Boolean;
var
 l_Sab: ISab;
 l_NameArr: TNameArr;
begin
 l_Sab := MakeSab(Self);
 try
  l3StringToArray(l_NameArr, SizeOf(TNameArr), aName);
  AddMark(l_NameArr);
  l_Sab.Select(ftTblName, l_NameArr);
  Result := not l_Sab.IsEmpty;
 finally
  l_Sab := nil;
 end;
end;

procedure TFreeTbl.ReturnFreeNums(aName: TTblNameStr; aFreeNums: TNumSet);
var
 I: Integer;
begin
 for I := 0 to aFreeNums.RangesAmount - 1 do
  AddInterval(aName, aFreeNums.Ranges[I].LowNum, aFreeNums.Ranges[I].HiNum);
end;

procedure TFreeTbl.ExcludeFreeNumsFromTable(aName: TTblNameStr;
                                            aNums: ISab);
type
 PFreeTableRec = ^TFreeTableRec;
 TFreeTableRec = packed record
                  rRecNo   : Longword;
                  rLowNum  : Longword;
                  rHighNum : Longword;
                 end;
var
 l_TblName      : TNameArr;
 lNumsCursor    : ISabCursor;
 lNumsCursorPtr : Integer;

 lFreeSab       : ISab;
 lFreeCursor    : ISabCursor;
 lFreeCursorPtr : Integer;

 lNum           : Longword;
 lRecsForDel    : Tl3RecList;
 lAddBuffer     : TStream;
 lCurrentWasChanged  : boolean;

 lSab           : ISab;
 lFreeTableRec  : TFreeTableRec;
 lAddedCnt      : Integer;

procedure lAddRec(aLowNum, aHighNum : Longword);
begin
 if lAddBuffer = nil then
  lAddBuffer := Tl3TempMemoryStream.Create(1024*1024);

 with lAddBuffer do
 begin
  WriteBuffer(l_TblName, SizeOf(l_TblName));
  WriteBuffer(aLowNum, SizeOf(aLowNum));
  Inc(lAddedCnt, aHighNum - aLowNum + 1);
  if aLowNum = aHighNum then aHighNum := 0;
  WriteBuffer(aHighNum, SizeOf(aHighNum));
 end;
end;

procedure NextFreeTableRec;
begin
 Inc(lFreeCursorPtr);
 if lFreeCursorPtr < lFreeCursor.Count then
 lFreeTableRec := PFreeTableRec(lFreeCursor.GetItem(lFreeCursorPtr))^;
 lCurrentWasChanged := False;
end;

begin
 lAddedCnt := 0;
 lAddBuffer := nil;
 if (aNums = nil) or (aNums.Count = 0) then
  Exit;

 lRecsForDel := Tl3RecList.Create(ht_SizeOfSurrogateKey);

 lFreeSab := MakeSab(Self);
 l_TblName := NameForSearch(aName);

 lFreeSab.Select(ftTblName, l_TblName);
 if lFreeSab.Count = 0 then
  Raise Exception.Create(Format('Ресурс %s отсутствует в таблице Free',[aName]));
 lFreeCursor := lFreeSab.MakeSabCursor([ftRecNo, ftFreeNum, ftLimit], cmForward);
 lFreeCursor.Sort([ftFreeNum]);
 lFreeCursorPtr := -1;
 NextFreeTableRec;
 lNumsCursor := aNums.MakeSabCursor([], cmForward);
 lNumsCursor.Sort;

 for lNumsCursorPtr := 0 to Pred(lNumsCursor.Count) do
 begin
  lNum := PInteger(lNumsCursor.GetItem(lNumsCursorPtr))^;
  while lFreeCursorPtr < lFreeCursor.Count do
  begin
   with lFreeTableRec do
   if lNum < rLowNum then // Не попали ни в один диапазон (lNum меньше минимального в диапазонах)
    Break // переходим к след. lNum
   else
   if (lNum >= rLowNum) and (lNum <= rHighNum) then // мы в текущем диапазоне
   begin
    //порезать текущий free-диапазон на две половины
    if (lNum > rLowNum) then //нижний поддиапазон не пустой
     lAddRec(rLowNum, Pred(lNum)); //нижний скинуть в таблицу

    if (lNum = rHighNum) or (rHighNum = 0) then // в текущем номеров не осталось
    begin
     lRecsForDel.Add(rRecNo);//Убиваем текущий free-диапазон
     NextFreeTableRec; //переходим к след. free-диапазону
     Break; //переходим к след. lNum
    end
    else
    begin
     rLowNum := Succ(lNum); //скорректировать rLowNum в текущем диапазоне
     lCurrentWasChanged := True;
     Break; // переходим к след. lNum
    end;
   end
   else // вышли за текущий диапазон
   begin
    // ЕСЛИ текущий корректировали его нужно поправить в таблице или убить и добавить
    if lCurrentWasChanged then
    begin
     lRecsForDel.Add(rRecNo); //Убиваем текущий free-диапазон
     lAddRec(rLowNum, rHighNum);//нижнюю скинуть в таблицу
    end;
    NextFreeTableRec; //переходим к след. free-диапазону
   end;
  end;

  if lFreeCursorPtr >= lFreeCursor.Count then
    Break; // в free диапазонов больше нет
 end;

 //Удаляем
 if (lRecsForDel <> nil) and (lRecsForDel.Count > 0) then
 begin
  lSab := MakeValueSet(Self, 0 {aField}, lRecsForDel);
  lSab.RecordsByKey;
  lSab.DeleteFromTable;
 end;
 l3Free(lRecsForDel);

 //добавляем
 if (lAddBuffer <> nil) and (lAddBuffer.size > 0) then
  AddRecs(lAddBuffer);

 l3Free(lAddBuffer);
end;

end.

