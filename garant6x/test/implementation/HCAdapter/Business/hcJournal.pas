unit hcJournal;

{------------------------------------------------------------------------------}
{  Автор      : М. Морозов                                                     }
{  Назначение : Журнал отправленных пользователю ответов.                      }
{  Дата       : 2 октября 2006 г.                                              }
{                                                                              }
{------------------------------------------------------------------------------}

//$Id: hcJournal.pas,v 1.11 2010/06/09 11:28:38 oman Exp $
//$Log: hcJournal.pas,v $
//Revision 1.11  2010/06/09 11:28:38  oman
//- fix: {RequestLink:217680883}
//
//Revision 1.10  2009/12/14 07:35:53  oman
//Не собирались
//
//Revision 1.9  2008/02/08 07:18:03  oman
//- Не собиралось
//
//Revision 1.8  2008/02/05 07:21:22  oman
//Не собиралось
//
//Revision 1.7  2007/08/31 09:57:09  mmorozov
//- bugfix: при получении консультации полностью обновляем информацию о ней в журнале (CQ: OIT5-26555);
//
//Revision 1.6  2007/08/15 06:27:04  mmorozov
//- new: использование l3FillChar;
//
//Revision 1.5  2007/08/13 07:06:35  mmorozov
//- new: поддержка операций "Правка" при работе с xml-ми;
//- change: использование версии запроса, при формировании идентификатора запроса (CQ: OIT5-25922);
//
//Revision 1.4  2007/06/29 06:05:21  mmorozov
//- bugfix: эмулятор не был готов к записи события получения оценки в журнал (CQ: OIT5-25586);
//
//Рефакторинг:
//- вместо самостоятельных парсеров для работы с атрибутами используем XMLDocument;
//- добавлены утилитные функции для поиска атрибута, чтения/записи его значения;
//- ограничеваемся одним перечислимым типом при работе с состоянием консультации;
//- идентификатор консультации стал составным;
//- идентфикатор консультации определяется один раз по первому требованию, а не каждый раз как раньше;
//- изменены названия файлов "журнал" и "настройки" эмулятора, к названию программы добаляем расширение 'jrn', 'sts'. Стало красиво, в свете того, что изменился формат файла журнала может оно и к лучшему;
//
//Revision 1.3  2007/02/06 14:05:58  mmorozov
//- MERGE WITH B_NEMESIS_6_4;
//
//Revision 1.1.4.3  2007/02/06 08:43:10  mmorozov
//- new behaviour: не удаляем из журнала при получении ответа от пользователя подтвержденные\откланённые консультации + возможность отправить ответ на подтвержденную консультацию из журнала (CQ: OIT5-24236);
//
//Revision 1.2  2007/01/22 14:17:19  mmorozov
//- MERGE WITH B_NEMESIS_6_4 (CQ: OIT5-24141);
//
//Revision 1.1.4.1  2007/01/22 13:49:56  mmorozov
//- new: показ статусов выбранных консультаций (CQ: OIT5-24141);
//
//Revision 1.1  2006/10/04 08:48:02  mmorozov
//- new: в ручном режиме показываем запросы в интернет обозревателе;
//- new: отправленные уведомления и полученные и не обработанные запросы хранятся  в журнале запросов, из которого можно пачками отправлять ответы на посланные уведомления, отправлять ответы и уведомления на полученные запросы; в случае получания подтверждения от пользователя из журнала чистится соответствующее уведомление;
//- new: вынос бизнес логики с формы;
//

interface

{$Include hcDefine.inc}

uses                             
  Classes,

  l3Base,
  l3Interfaces,
  l3InterfaceList,
  l3LongintList,
  l3NotifyPtrList,

  hcInterfaces
  ;

type
  ThcAnswerFields = (
  {* Поля ответа. }
    afTime,
    afType,
    afQueryId,
    afVersion
  );//ThcAnswerFields

  _l3Notifier_Parent_ = Tl3Base;
  {$Include l3Notifier.imp.pas}
  ThcQuery = class(_l3Notifier_, IhcQuery)
  private
    f_Time    : TDateTime;
    f_Id      : ThcConsultationId;
    f_Type    : ThcQueryStatus;
  private
  // methods
    function pm_GetTime: TDateTime;
      {* - время ответа. }
    function pm_GetId: ThcConsultationId;
    procedure pm_SetId(const aValue: ThcConsultationId);
      {* - идентификатор консультации. }
    function pm_GetStatus: ThcQueryStatus;
    procedure pm_SetStatus(const aValue: ThcQueryStatus);
      {* - статус консультации }
    procedure Delete;
      {* - удалить событие. }
    function Save: String;
      {-}
    procedure Load(const aData: String);
      {-}
  public
  // methods
    constructor Create(const aTime   : TDateTime;
                       const aId     : ThcConsultationId;
                       const aStatus : ThcQueryStatus);
      reintroduce;
      overload;
      {-}
    constructor Create(const aLoadData: String);
      reintroduce;
      overload;
      {-}
    class function Make(const aTime   : TDateTime;
                        const aId     : ThcConsultationId;
                        const aStatus : ThcQueryStatus): IhcQuery;
      overload;
      {-}
    class function Make(const aLoadData: String): IhcQuery;
      overload;
      {-}
  end;

  ThcJournal = class(Tl3InterfaceList,
                     IhcJournal,
                     Il3ItemNotifyRecipient,
                     Il3Notify)
  private
  // Il3ItemNotifyRecipient
    procedure Notify(const aNotifier  : Il3ChangeNotifier;
                     aOperation       : Integer;
                     aIndex           : Integer);
      {* - прошла операция. }
  private
  // IhcJournal
    function IhcJournal_pm_GetCount: Integer;
    function IhcJournal.pm_GetCount = IhcJournal_pm_GetCount;
      {-}
    function pm_GetItem(const anIndex: Integer): IhcQuery;
      {-}
    function AddQuery(const aTime   : TDateTime;
                      const aId     : ThcConsultationId;
                      const aStatus : ThcQueryStatus): IhcQuery;
      {* - добавить ответ. }
    procedure UpdateQueryStatus(const aId     : ThcConsultationId;
                                const aStatus : ThcQueryStatus);
      {-}
    function FindQuery(const aId: ThcConsultationId): IhcQuery;
      {-}
    procedure Save(const aFileName: String);
      {-}
    procedure Load(const aFileName: String);
      {-}
    procedure IhcAnswersJournal_Delete(const aId: ThcConsultationId);
    procedure IhcJournal.Delete = IhcAnswersJournal_Delete;
      {-}
    procedure IhcAnswersJournal_Clear;
    procedure IhcJournal.Clear = IhcAnswersJournal_Clear;
      {-}
  public
  // methods
    class function Make: IhcJournal;
      {-}
  end;

implementation

uses
  SysUtils,
  StrUtils,

  hcConst,
  hcUtils
  ;

{$Include l3Notifier.imp.pas}

{ ThcJournal }

function ThcJournal.AddQuery(const aTime   : TDateTime;
                             const aId     : ThcConsultationId;
                             const aStatus : ThcQueryStatus): IhcQuery;
  {* - добавить ответ. }
var
 l_Notify: Il3ChangeNotifier;
begin
 Result := FindQuery(aId);
 if Result <> nil then
 begin
  Result.Status := aStatus;
  Result := nil;
 end//if Result <> nil then
 else
 begin
  Result := ThcQuery.Make(aTime, aId, aStatus);
  if Supports(Result, Il3ChangeNotifier, l_Notify) then
  try
   l_Notify.Subscribe(Self);
  finally
   l_Notify := nil;
  end;{try..finally}
  Add(Result);
 end;//if Result <> nil then
end;//AddQuery

function ThcJournal.FindQuery(const aId: ThcConsultationId): IhcQuery;
var
 l_Index: Integer;
begin
 Result := nil;
 for l_Index := 0 to Pred(Count) do
 begin
  Result := pm_GetItem(l_Index);
  if hcIsSame(Result.Id, aId) then
   Break
  else
   Result := nil;
 end;//for l_Index := 0 to Pred(Count) do
end;//FindQuery

procedure ThcJournal.UpdateQueryStatus(const aId     : ThcConsultationId;
                                       const aStatus : ThcQueryStatus);
  {-}
var
 l_Query: IhcQuery;
begin
 l_Query := FindQuery(aId);
 if l_Query <> nil then
 begin
  l_Query.Status := aStatus;
  l_Query.Id := aId;
   // - у консультации может измениться например версия, когда консультация была
   //   создана на 6.4, дальше подтверждение было получено на 7.0 и пользователь
   //   ответил; 
 end;//if l_Query <> nil then
end;

procedure ThcJournal.IhcAnswersJournal_Clear;
begin
 Clear;
end;//ThcJournal

procedure ThcJournal.IhcAnswersJournal_Delete(const aId: ThcConsultationId);
var
 l_Index  : Integer;
 l_Answer : IhcQuery;
begin
 for l_Index := 0 to Pred(Count) do
  if Supports(Items[l_Index], IhcQuery, l_Answer) and
   hcIsSame(l_Answer.Id, aId) then
  begin
   l_Answer.Delete;
   Break;
  end;
end;

procedure ThcJournal.Load(const aFileName: String);
var
 l_Strings : TStrings;
 l_Index   : Integer;
begin
 if not FileExists(aFileName) then
  Exit;
 l_Strings := TStringList.Create;
 try
  l_Strings.LoadFromFile(aFileName);
  for l_Index := 0 to Pred(l_Strings.Count) do
   Add(ThcQuery.Make(l_Strings[l_Index]));
 finally
  FreeAndNil(l_Strings);
 end;
end;

class function ThcJournal.Make: IhcJournal;
var
 l_Class: ThcJournal;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

procedure ThcJournal.Notify(const aNotifier : Il3ChangeNotifier;
                            aOperation      : Integer;
                            aIndex          : Integer);
var
 l_Query : IhcQuery;
 l_Index  : Integer;
begin
 case ThcNotification(aOperation) of
  n_DeleteAnswerFromJournal:
   if Supports(aNotifier, IhcQuery, l_Query) then
   try
    l_Index := IndexOf(l_Query);
    if l_Index <> -1 then
     Delete(l_Index);
   finally
    l_Query := nil;
   end;{try..finally}
 end;//case ThcNotification(aOperation) of
end;//Notify

function ThcJournal.IhcJournal_pm_GetCount: Integer;
begin
 Result := Count;
end;

function ThcJournal.pm_GetItem(const anIndex: Integer): IhcQuery;
begin
 Supports(inherited Items[anIndex], IhcQuery, Result);
end;

procedure ThcJournal.Save(const aFileName: String);
var
 l_Strings : TStrings;
 l_Query   : IhcQuery;
 l_Index   : Integer;
begin
 l_Strings := TStringList.Create;
 try
  for l_Index := 0 to Pred(Count) do
   if Supports(Items[l_Index], IhcQuery, l_Query) then
   try
    l_Strings.Add(l_Query.Save);
   finally
    l_Query := nil;
   end;
  l_Strings.SaveToFile(aFileName);
 finally
  FreeAndNil(l_Strings);
 end;
end;

{ ThcQuery }

constructor ThcQuery.Create(const aLoadData: String);
  // reintroduce;
  // overload;
  {-}
var
 l_Id: ThcConsultationId;
begin
 l3FillChar(l_Id, SizeOf(l_Id), 0);
 Create(0, l_Id, qsNone);
 Load(aLoadData);
end;

constructor ThcQuery.Create(const aTime    : TDateTime;
                             const aId     : ThcConsultationId;
                             const aStatus : ThcQueryStatus);
begin
 inherited Create;
 f_Time := aTime;
 f_Id := aId;
 f_Type := aStatus;
end;//Create

procedure ThcQuery.Delete;
begin
 CallNotify(Ord(n_DeleteAnswerFromJournal), 0);
end;//Delete

class function ThcQuery.Make(const aLoadData: String): IhcQuery;
  // overload;
  {-}
var
 l_Class: ThcQuery;
begin
 l_Class := Create(aLoadData);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

class function ThcQuery.Make(const aTime    : TDateTime;
                              const aId     : ThcConsultationId;
                              const aStatus : ThcQueryStatus): IhcQuery;
var
 l_Class: ThcQuery;
begin
 l_Class := Create(aTime, aId, aStatus);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

procedure ThcQuery.pm_SetStatus(const aValue: ThcQueryStatus);
begin
 f_Type := aValue;
 CallNotify(Ord(n_QueryDataChanged), 0);
end;//pm_SetStatus

function ThcQuery.pm_GetStatus: ThcQueryStatus;
begin
 Result := f_Type;
end;

function ThcQuery.pm_GetTime: TDateTime;
  {* - время ответа. }
begin
 Result := f_Time;
end;//pm_GetTime

procedure ThcQuery.pm_SetId(const aValue: ThcConsultationId);
begin
 f_Id := aValue;
end;

function ThcQuery.pm_GetId: ThcConsultationId;
begin
 Result := f_Id;
end;

procedure ThcQuery.Load(const aData: String);
var
 l_Pos    : Integer;
 l_Marker : Integer;
 l_Field  : ThcAnswerFields;

 procedure lp_ProcessValue(const aValue: String);
 var
  l_Type: ThcQueryStatus;
 begin
  case l_Field of
   afTime:
    f_Time := StrToFloat(aValue);
   afType:
    for l_Type := Low(ThcQueryStatus) to High(ThcQueryStatus) do
     if aValue = c_QueryStatus[l_Type] then
     begin
      f_Type := l_Type;
      Break;
     end;
   afQueryId:
    f_Id.rQueryId := aValue;
   afVersion:
    f_Id.rVersion := aValue;
  end;//case l_Field of
 end;//lp_ProcessValue

begin
 l_Marker := 1;
 l_Field := afTime;
 repeat
  l_Pos := PosEx(c_AnswerDataSeparator, aData, l_Marker);
  if l_Pos <> 0 then
  begin
   lp_ProcessValue(Copy(aData, l_Marker, l_Pos - l_Marker));
   if l_Field = High(ThcAnswerFields) then
    Break
   else
   begin
    Inc(l_Field);
    l_Marker := Succ(l_Pos);
   end;
  end;
 until l_Pos = 0;
 lp_ProcessValue(Copy(aData, l_Marker, Length(aData) - Pred(l_Marker)));
end;

function ThcQuery.Save: String;
const
 c_Record = '%f;%s;%s;%s';
begin
 Result := Format(c_Record, [f_Time, c_QueryStatus[f_Type],  f_Id.rQueryId, f_Id.rVersion]);
end;//Save

end.