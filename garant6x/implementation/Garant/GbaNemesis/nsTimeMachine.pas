unit nsTimeMachine;

// $Id: nsTimeMachine.pas,v 1.42 2013/05/31 06:07:22 lulin Exp $

// $Log: nsTimeMachine.pas,v $
// Revision 1.42  2013/05/31 06:07:22  lulin
// - портируем под XE4.
//
// Revision 1.41  2011/04/18 14:12:05  lulin
// {RequestLink:263750454}.
//
// Revision 1.40  2009/11/12 15:31:43  lulin
// {RequestLink:171540596}.
//
// Revision 1.39  2009/10/29 16:02:53  lulin
// - по-другому называем операции.
//
// Revision 1.38  2009/10/29 14:35:42  lulin
// - вторая волна компании по борьбе со старыми внутренними операциями.
//
// Revision 1.37  2009/08/25 12:47:57  lulin
// {RequestLink:159367405}.
//
// Revision 1.36  2009/08/24 08:36:35  lulin
// - переносим системные операции на модель.
//
// Revision 1.35  2009/07/31 17:29:52  lulin
// - убираем мусор.
//
// Revision 1.34  2009/02/20 10:08:28  lulin
// - чистка комментариев.
//
// Revision 1.33  2009/02/10 19:03:14  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.32  2009/02/10 18:47:16  lulin
// - <K>: 133891247. Выделяем интерфейсы работы с адаптером и советами дня.
//
// Revision 1.31  2008/09/09 11:48:01  oman
// - fix: При переходе в ОМ некорректно отключалась МВ (К-114065588)
//
// Revision 1.30  2008/01/10 07:23:10  oman
// Переход на новый адаптер
//
// Revision 1.29.4.2  2007/11/23 10:15:20  oman
// Перепиливаем на новый адаптер
//
// Revision 1.29.4.1  2007/11/16 14:03:35  oman
// Перепиливаем на новый адаптер
//
// Revision 1.29  2007/10/03 12:49:22  mmorozov
// - new: разрешаем включать машину времени на дату ревизии базы + для документов с открытой датой действия делаем недоступной операцию включить машину времени с даты действия текущей редакции + сопуствующий рефакторинг (в рамках CQ: OIT5-26843; K<56295615>);
//
// Revision 1.28  2007/08/14 19:31:39  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.27  2007/08/14 14:29:48  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.26  2007/03/20 11:51:19  lulin
// - используем строки с кодировкой.
//
// Revision 1.25  2007/02/12 18:55:37  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.24  2007/02/12 18:44:25  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.23  2007/02/07 14:30:31  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.22  2007/02/07 12:45:01  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.21  2007/02/07 09:15:54  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.20  2007/02/06 11:45:24  lulin
// - bug fix: не собирались мониторинги.
//
// Revision 1.19  2007/02/05 09:40:03  lulin
// - две функции объединены в одну.
//
// Revision 1.18  2006/11/03 09:45:26  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.17.4.1  2006/10/26 15:18:39  demon
// - new: изменены константы, отвечающие за типы редакций документа
//
// Revision 1.17  2006/04/19 13:34:29  oman
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.16  2006/03/21 15:03:58  oman
// - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)
//
// Revision 1.15  2005/11/29 07:18:30  mmorozov
// - bugfix: структура TRedactionInfo инициализируется перед использованием;
//
// Revision 1.14  2005/11/23 15:10:01  mmorozov
// bugfix: при открытии толкового словаря не сбрасывалась машина времени (cq: 00018266);
//
// Revision 1.13  2005/08/29 16:10:26  demon
// - new behavior: Операция Open на ноде теперь возвращает IUnknown
//
// Revision 1.12  2005/06/30 07:48:05  cyberz
// READY FOR TIE-TEMPLATE GENERATION
//
// Revision 1.11  2005/05/11 14:05:55  demon
// - fix: при выключении машины времени сбрасываем дату в Null
// - fix: если дата МВ = null, то при ее запросе просто возвращаем дату ревизии базы не кэшируя ее
//
// Revision 1.10  2005/01/19 11:16:37  demon
// - new behavior: операция нотификации об изменении состояния МВ
// - fix: неправильный тип при открытии документа по ссылке
//
// Revision 1.9  2005/01/14 14:00:51  demon
// - new behavior: несколько изменен принцип показа предупреждения для МВ (появилось два вид - красное предупреждение и желтое)
//
// Revision 1.8  2005/01/12 16:22:55  dk3
// change time machime warning
//
// Revision 1.7  2004/12/01 13:29:10  demon
// - new behavior: новый вариант генерации Warning'а для команды NotSure.
//
// Revision 1.6  2004/11/30 12:32:49  dk3
// _move to base in win1251 encode
//
// Revision 1.5  2004/10/08 15:55:30  demon
// - new behavior: переделана работа с документом (состояния) и Машиной времени (она стала глобальной)
//
// Revision 1.4  2004/09/07 16:22:03  law
// - перевел Nemesis на кешированные обьекты.
//
// Revision 1.3  2004/07/21 15:20:27  demon
// - new behavior: Изменен принцип формирования предупреждений к МВ
// - new behavior: операция "Выключить МВ и открыть актуальную редакцию"
//
// Revision 1.2  2004/07/09 11:28:33  demon
// - new behavior: новое предупреждение про "Интервал неуверенности"
//
// Revision 1.1  2004/04/12 09:10:22  demon
// - new _module: nsTimeMachine (объект для работы с машиной времени)
//

interface

uses
  l3Interfaces,
  
  vcmBase,

  BaseTypesUnit,
  DocumentUnit,

  nsTypes,

  DataAdapterInterfaces
  ;

type
  TnsTimeMachine = class(TvcmCacheableBase, InsTimeMachine)
  private
  // fields
    f_Date                : BaseTypesUnit.TDate;
    f_NotShureWarningLink : IDocument;
  private
  // InsTimeMachine
    // property methods
      function  pm_getDate: BaseTypesUnit.TDate;
      procedure pm_setDate(const aValue: BaseTypesUnit.TDate);
        {-}
      function  pm_getDateStr: Il3CString;
        {-}
      function  pm_GetIsOn: Boolean;
        {-}
      function  pm_GetNotSureHelp: IDocument;
        {-}
    // methods
      function  HasTimeMachineWarning(const aDocument: IDocument): Boolean;
        {-}
      function  GetTimeMachineWarning(const aDocument : IDocument;
                                      out aWarning    : Il3CString): TTMWarningType;
        {-}
      function  HasNotSureWarning(const aDocument: IDocument): Boolean;
        {-}
      function  GetNotSureWarning(const aDocument: IDocument;
                                  out aComment: Il3CString): Il3CString;
        {-}
      function  CorrectDocumentEdition(const aDocument: IDocument): IDocument;
        {-}
      procedure SwitchOff(StayInCurrentRedaction: Boolean = False);
        {-}
  protected
      procedure Cleanup;
        override;
        {-}
  private
  // property methods
    function pm_GetIsDateOfRevisionBase: Boolean;
      {-}
  protected
  // properties
    property Date: BaseTypesUnit.TDate
      read pm_GetDate
      write pm_SetDate;
      {-}
    property DateStr: Il3CString
      read pm_GetDateStr;
      {-}
    property IsOn: Boolean
      read pm_GetIsOn;
      {-}
    property NotSureHelp: IDocument
      read pm_GetNotSureHelp;
      {-}
    property IsDateOfRevisionBase: Boolean
      read pm_GetIsDateOfRevisionBase;
      {-}
  public
  // methods
    constructor Create(aDate: BaseTypesUnit.TDate);
      reintroduce;
      {-}
    class function Make(aDate: BaseTypesUnit.TDate) : InsTimeMachine;
      reintroduce;
      {-}
 end;//TnsTimeMachine

implementation

uses
  SysUtils,

  l3String,
  l3Base,

  StdRes,

  DataAdapter,

  bsUtils,

  IOUnit,

  nsConst,

  Document_Strange_Controls
  ;

// Start class TnsTimeMachine


procedure TnsTimeMachine.Cleanup;
begin
 f_Date := cNullDate;
 f_NotShureWarningLink := nil;

 inherited Cleanup;
end;

constructor TnsTimeMachine.Create(aDate: BaseTypesUnit.TDate);
begin
 inherited Create;

 f_Date := aDate;
end;

class function TnsTimeMachine.Make(aDate: BaseTypesUnit.TDate): InsTimeMachine;
var
 l_TM: TnsTimeMachine;
begin
 l_TM := Create(aDate);
 try
  Result := l_TM;
 finally
  vcmFree(l_TM);
 end;
end;

function TnsTimeMachine.pm_getDate: BaseTypesUnit.TDate;
begin
 if f_Date.rDay = 0 then
  Result := DefDataAdapter.CurrentBaseDate
 else
  Result := f_Date;
end;

procedure TnsTimeMachine.pm_setDate(const aValue: BaseTypesUnit.TDate);
begin
 f_Date := aValue;
 op_System_TimeMachineStateChange.Broadcast;
end;

function TnsTimeMachine.pm_getDateStr: Il3CString;
begin
 if IsOn then
  Result := DateToString(Date)
 else
  Result := nsCStr('');
end;

function TnsTimeMachine.pm_GetIsOn: Boolean;
begin
 Result := not IsNullDate(f_Date);
end;

function TnsTimeMachine.pm_GetNotSureHelp: IDocument;
begin
 Result := f_NotShureWarningLink;
end;

function TnsTimeMachine.HasTimeMachineWarning(const aDocument: IDocument): Boolean;
var
 l_Warning: TTimeMachineWarning;
begin
 Result := False;
 if Assigned(aDocument) and IsOn then
 begin
  aDocument.GetTimeMachineWarning(f_Date, l_Warning);
  if not l3IsNil(nsCStr(l_Warning.rWarning)) then
   Result := True;
  if not Result then
   Result := aDocument.IsDateInNotSureInterval(f_Date);
 end;//Assigned(aDocument) and IsOn
end;

function TnsTimeMachine.GetTimeMachineWarning(const aDocument : IDocument;
                                              out aWarning    : Il3CString): TTMWarningType;
var
 l_Warning: TTimeMachineWarning;
begin
 Result := tmwNone;
 if (aDocument <> nil) and IsOn then
 begin
  aDocument.GetTimeMachineWarning(f_Date, l_Warning);
  aWarning := nsCStr(l_Warning.rWarning);
  if not l3IsNil(aWarning) then
   case l_Warning.rType of
    TMWT_RED: Result := tmwError;
    TMWT_YELLOW: Result := tmwWarning;
   end;//case l_Warning.rType
 end;//aDocument <> nil
end;

function TnsTimeMachine.HasNotSureWarning(const aDocument: IDocument): Boolean;
begin
 Result := False;
 if Assigned(aDocument) and IsOn then
  Result := aDocument.IsDateInNotSureInterval(f_Date);
end;

function TnsTimeMachine.GetNotSureWarning(const aDocument : IDocument;
                                          out aComment    : Il3CString): Il3CString;
var
 l_StartDate  : BaseTypesUnit.TDate;
 l_FinishDate : BaseTypesUnit.TDate;
 l_Comment    : IString;
begin
 if Assigned(aDocument) and IsOn then
 begin
  try
   aDocument.GetNotSureInfo(f_Date, l_StartDate, l_FinishDate,
                            f_NotShureWarningLink, l_Comment);
  except
   on ECanNotFindData do
    Result := nsCStr('');
  end;
  aComment := nsCStr(l_Comment);
  Result := vcmFmt(str_UnshureRedactionPeriod, [IntervalToString(l_StartDate, l_FinishDate)]);
 end//Assigned(aDocument)
 else
  Result := nsCStr('');
end;

procedure TnsTimeMachine.SwitchOff(StayInCurrentRedaction: Boolean = False);
begin
 if not bsIsDateEqual(f_Date, cNullDate) then
 begin
  f_Date := cNullDate;
  Op_System_TimeMachineStateChange.Broadcast(StayInCurrentRedaction);
 end;//if not bsIsDateEqual(f_Date, cNullDate) then
end;//SwitchOff

function TnsTimeMachine.CorrectDocumentEdition(const aDocument: IDocument): IDocument;
var
 l_State : IDocumentState;
 l_Info  : TRedactionInfo;
begin
 Result := aDocument;
 if IsOn and not IsDateOfRevisionBase then
 begin
  aDocument.GetCurrentState(l_State);
  try
   l3FillChar(l_Info, SizeOf(l_Info), 0);
   l_State.GetCurrentRedaction(l_Info);
   if l_Info.rActualType in [RT_ACTUAL,
                             RT_ACTUAL_ABOLISHED,
                             RT_ACTUAL_PREACTIVE] then
   begin
    l_State.SetRedactionOnDate(f_Date);
    aDocument.CreateView(l_State, Result);
    // Документ не поменялся:
    if Result = nil then
     Result := aDocument;
   end;//l_Info.rActualType in ..
  finally
   l_State := nil;
  end;//try..finally
 end;//if IsOn then
end;//CorrectDocumentEdition

function TnsTimeMachine.pm_GetIsDateOfRevisionBase: Boolean;
begin
 Result := IsDateEqual(f_Date, defDataAdapter.CurrentBaseDate);
end;//pm_GetIsDateOfRevisionBase

end.
