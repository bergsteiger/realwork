Unit Dt_err;

{ $Id: DT_ERR.PAS,v 1.38 2014/12/12 16:07:28 voba Exp $ }

// $Log: DT_ERR.PAS,v $
// Revision 1.38  2014/12/12 16:07:28  voba
// - настройка вывода в лог
//
// Revision 1.37  2014/11/28 12:04:33  voba
// k:ловушка для hterr -42
//
// Revision 1.36  2014/11/21 10:35:46  fireton
// - наследуем исключения от l3
//
// Revision 1.35  2014/09/22 13:42:29  voba
// - bf AddUser proc
//
// Revision 1.34  2014/05/21 14:31:42  voba
// - add function HTBLen
//
// Revision 1.33  2014/03/05 12:03:15  voba
// - адаптация под новый HyTech
//
// Revision 1.32  2013/12/12 11:44:02  voba
// - Вставил логирование отката транзакции bugfix
//
// Revision 1.31  2013/12/12 11:40:58  voba
// - Вставил логирование отката транзакции bugfix
//
// Revision 1.30  2013/12/12 11:30:46  voba
// - Вставил логирование отката транзакции
//
// Revision 1.29  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.28  2008/04/04 15:16:32  fireton
// - внешние номера документов из диапазона
//
// Revision 1.27  2008/02/06 16:16:31  voba
// no message
//
// Revision 1.26  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.25  2006/12/01 11:39:05  voba
// no message
//
// Revision 1.24  2006/08/29 15:28:08  voba
// - add procedure HTErr_NeedStackOut
//
// Revision 1.23  2005/10/21 08:09:36  step
// убрана StrAlloc из EHtErrors.CreateInt
//
// Revision 1.22  2005/04/28 15:04:06  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.21  2005/04/25 08:56:48  voba
// - add type of exception
//
// Revision 1.20.12.1  2005/04/25 14:05:05  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.21  2005/04/25 08:56:48  voba
// - add type of exception
//
// Revision 1.20  2005/01/20 09:27:55  step
// Исправлен текст исключения (по просьбе Гарри)
//
// Revision 1.19  2004/08/03 08:52:50  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.18  2004/07/22 10:33:49  voba
// - изменил строковую константу ecUnableUpd
//
// Revision 1.17  2004/07/16 14:55:36  step
// добавлены новые ошибки
//
// Revision 1.16  2004/01/14 11:53:13  step
// Добавлена const ecCanNotRead
//
// Revision 1.15  2003/05/06 14:04:57  step
// Добавлено проверка на зацикленность ссылок в TDocumentData.GetVersionsList
//
// Revision 1.14  2003/04/29 15:47:27  voba
// - добавил нове сообщение об ошибке
//
// Revision 1.13  2003/04/16 09:19:00  voba
// - improvement: добавлена возможность передачи параметров в сообщение об exception
//
// Revision 1.12  2003/03/13 10:03:20  demon
// - new: ecIDAlreadyUsed (попытка повторно использовать идентификатор)
//
// Revision 1.11  2003/01/16 15:30:35  demon
// - new behavior: Новая ошибка - Не задан идентификатор (для загрузки аттрибутов в трубу)
//
// Revision 1.10  2002/01/16 11:03:06  demon
// - cleanup HtDebugInfo and merge with tag NullJournal_bug
//
// Revision 1.9.2.2  2001/09/06 12:05:53  narry
// - change: совместимость с Delphi 6.
//
// Revision 1.9.2.1  2001/07/09 15:28:47  demon
// no message
//
// Revision 1.9  2001/04/18 08:51:37  voba
// Поправил грамматику. Извини, не удержался :)
//
// Revision 1.8  2000/12/15 15:36:15  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
Uses
 Dt_Types,
 l3Except,
 SysUtils;

Const
 ecOk                 =  0;
 ecNotFound           =  101;
 ecNotEmpty           =  102;
 ecTblNotOpen         =  103;
 ecTblOpen            =  104;
 ecUnableDel          =  105;
 ecNotFamilyID        =  106;
 ecFreeTblErr         =  107;
 ecNotFreeMem         =  108;
 ecUnableUpd          =  109;
 ecSrchNotOpen        =  110;
 ecPathNotFound       =  111;
 ecLocked             =  112;
 ecImportAbort        =  113;
 ecNotAssigned        =  114;
 ecNotGroup           =  115;
 ecUnSynhronize       =  116;
 ecNotEnable          =  117;
 ecNotUniqName        =  118;
 ecCircleLabel        =  119;
 ecTooManyElements    =  120;
 ecFamilyLocked       =  121;
 ecUnableLockFamily   =  122;
 ecAccessDenied       =  123;
 ecEmpty              =  124;
 ecNotField           =  125;
 ecInvalidHome        =  126;
 ecSrchEmpty          =  127;
 ecNotValidSrchType   =  128;
 ecNotValidSab        =  129;
 ecDataCorrupted      =  130;
 ecNotKeyField        =  131;
 ecNotUniqID          =  132;
 ecIDNotAssigned      =  133;
 ecIDAlreadyUsed      =  134;
 ecIDAlreadyUsedParam =  135;
 ecIDAlreadyUsedInDoc =  136;
 ecWrongVerLink       =  137;
 ecCanNotRead         =  138;
 ecWrongFieldNumber   =  139;
 ecWrongFieldValue    =  140;
 ecFullRecordNotInit  =  141;
 ecUserRejectedOperation = 142;
 ecTransactionDoNotStart = 143;
Type
 ETableError = class(El3Error);

 EBaseInitError = class(El3Error);

 EHtErrors = Class(El3Error)
  fErrorValue : Integer;
  Constructor CreateInt(aErrCode : Integer); overload;
  Constructor CreateInt(aErrCode : Integer; const Params : array of const); overload;
  property ErrorValue : Integer read fErrorValue;
 end;

 EHtErrors_IDAlreadyUsed = Class(EHtErrors)
 end;

 EHtErrors_LockTblError = class(EHterrors)
 end;

 function  DTErrMsg(aErrCode : Integer) : ShortString;
 function  Ht(ID : Integer) : LongInt;
 function  HTBLen(ID : Cardinal) : Cardinal;

 procedure HTErr_NeedStackOut(aErrNum : Integer);
  {* - вызывается из DT_Serv.fn_OnIOError, взводит флаг необходимости выгрузить стек в лог, который проверяется в Ht() }
Implementation
Uses
 HT_Const,
 HT_Dll,
 l3Base;

var
 lNeedStackOut_ErrNum : Integer = 0;
 lNeedStackOut_DescrStr : String;

procedure HTErr_NeedStackOut(aErrNum : Integer);
begin
 lNeedStackOut_ErrNum := aErrNum;
 {$IFDEF HT_NEWDLL}
  SetLength(lNeedStackOut_DescrStr, 300);
  SetLength(lNeedStackOut_DescrStr, htLastErrorText(@lNeedStackOut_DescrStr[1], 300));
 {$ENDIF}
end;

Constructor EHtErrors.CreateInt(aErrCode : Integer);
begin
 CreateInt(aErrCode, []);
end;

function GenErrString(aErrCode : Integer; aErrDescrStr : AnsiString) : AnsiString; overload;
var
 l_Buff220: array[0..220] of AnsiChar;
begin
 if aErrCode <> 0 then
 begin
  if aErrCode < 0 then
  begin
   {Это строка с сообщением об ошибке HT}
   htMessage(aErrCode, @l_Buff220);
   Result := SysUtils.Format('HTERROR = %d; %s', [aErrCode, PAnsiChar(@l_Buff220)]);
  end
  else
   {Это строка с сообщением об ошибке внутри программы}
   Result := DTErrMsg(aErrCode);

  if Length(aErrDescrStr) > 0 then
   Result := Result + ' ['+ aErrDescrStr +']';
 end
 else
  Result := 'ОШИБОК НЕТ !!!';
end;

function GenErrString(aErrCode : Integer) : AnsiString; overload;
var
 lErrDescr : AnsiString;
begin
 lErrDescr := '';
 {$IFDEF HT_NEWDLL}
 SetLength(lErrDescr, 300);
 SetLength(lErrDescr, htLastErrorText(@lErrDescr[1], 300));
 {$ENDIF}

 Result := GenErrString(aErrCode, lErrDescr);
end;

Constructor  EHtErrors.CreateInt(aErrCode : Integer; const Params : array of const);
var
 lErrStr : AnsiString;

begin
 lErrStr := GenErrString(aErrCode);
 if High(Params) >= Low(Params) then
  lErrStr := Format(lErrStr, Params);

 Inherited Create(lErrStr);
 fErrorValue := aErrCode;
end;

Function DTErrMsg(aErrCode : Integer) : ShortString;
Begin
 Case aErrCode of
  ecOk               : Result:= 'Ошибок нет';
  ecNotFound         : Result:= 'Элемент не найден';
  ecTblNotOpen       : Result:= 'Таблица не открыта';
  ecSrchNotOpen      : Result:= 'Выборка не открыта';
  ecTblOpen          : Result:= 'Таблица открыта';
  ecUnableDel        : Result:= 'Удаление невозможно';
  ecUnableUpd        : Result:= 'Сохранение изменений невозможно';
  ecNotEmpty         : Result:= 'Элемент не пустой';
  ecEmpty            : Result:= 'Элемент пустой';
  ecNotFamilyID      : Result:= 'Семейство таблиц не задано';
  ecFamilyLocked     : Result:= 'Семейство таблиц закрыто';
  ecUnableLockFamily : Result:= 'Невозможно закрыть семейство таблиц';
  ecFreeTblErr       : Result:= 'Ошибка получения свободного номера';
  ecNotFreeMem       : Result:= 'Мало свободной памяти';
  ecPathNotFound     : Result:= 'Путь не найден';
  ecLocked           : Result:= 'Элемент закрыт';
  ecImportAbort      : Result:= 'Импорт данных не прошел';
  ecNotAssigned      : Result:= 'Ключевое свойство не задано';
  ecNotGroup         : Result:= 'Группа отсутствует';
  ecUnSynhronize     : Result:= 'Рассинхронизация';
  ecNotEnable        : Result:= 'Операция невозможна';
  ecNotUniqName      : Result:= 'Имя не уникальное';
  ecCircleLabel      : Result:= 'Циклические ссылки';
  ecTooManyElements  : Result:= 'Слишком много элементов';
  ecAccessDenied     : Result:= 'Нет прав для доступа';
  ecNotField         : Result:= 'Не поле таблицы';
  ecInvalidHome      : Result:= 'Неверный личный каталог';
  ecSrchEmpty        : Result:= 'Выборка пустая';
  ecNotValidSrchType : Result:= 'Неверный тип выборки';
  ecNotValidSab      : Result:= 'Недопустимый БДС';
  ecDataCorrupted    : Result:= 'Нарушена структура данных таблицы';
  ecNotKeyField      : Result:= 'Поле не ключевое';
  ecNotUniqID        : Result:= 'Неуникальный идентификатор';
  ecIDNotAssigned    : Result:= 'Идентификатор не задан';
  ecIDAlreadyUsed    : Result:= 'Идентификатор уже используется';
  ecIDAlreadyUsedParam  : Result:= 'Идентификатор %d уже используется';
  ecIDAlreadyUsedInDoc : Result:= 'Идентификатор #%d уже используется (в документе #%d)';
  ecWrongVerLink     : Result:= 'Обнаружен цикл в списке редакций документа';
  ecCanNotRead       : Result:= 'Ошибка при чтении результатов поиска';
  ecWrongFieldNumber : Result:= 'Неверный номер поля таблицы';
  ecWrongFieldValue  : Result:= 'Значение %s недопустимо для поля %s таблицы %s.';
  ecFullRecordNotInit: Result:= 'fFullRecord не инициализирован';
  ecUserrejectedOperation: Result:= 'Операция отвергнута пользователем';
  ecTransactionDoNotStart : Result:= 'Таблицы захвачены, попробуйте позже';
  else
   Result:= 'Неизвестная ошибка';
 end;
end;

function Ht(ID : LongInt) : LongInt;
{var
 nDosError : SmallInt; // Сюда занесут код, возвращенный ДОС
 nOperation: SmallInt; // Сюда занесут код операции, приведшей к ошибке
 lErrstr : array[0..1000] of AnsiChar;
 lErrstr2 : PAnsiChar;
}

begin
 Result := ID;

 if (lNeedStackOut_ErrNum <> 0) and (lNeedStackOut_ErrNum <> Abs(ID)) then
 begin
  l3System.Stack2Log('[presaved] ' + GenErrString(lNeedStackOut_ErrNum, lNeedStackOut_DescrStr));
  lNeedStackOut_ErrNum := 0;
  lNeedStackOut_DescrStr := '';
 end;

{ if ID = -1 then
  lErrstr2 := htExtError(nDosError, nOperation, @lErrstr[0]);
}

 if ID = HT_ERR_TRT_ROLLED then
  l3System.Stack2Log('HTERROR = HT_ERR_TRT_ROLLED STACK OUT');

 if ID < 0 then
  raise EHtErrors.CreateInt(ID);
end;

function HTBLen(ID : Cardinal) : Cardinal;
{ В функциях, которые возвращают количество считанных байт,
  превышение значения MAX_BUF_LEN трактуется как ошибка.
  Значение приводится к отрицательному знаковому целому. }
begin
 if ID > MAX_BUF_LEN then
 begin
  HT(longint(ID));
  Result := 0;
 end
 else
 begin
  if lNeedStackOut_ErrNum <> 0 then HT(0);
  Result := ID;
 end;
end;

end.
