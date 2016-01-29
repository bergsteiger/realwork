unit hcJournalView;

// Библиотека : Тестовый слой;
// Автор      : Морозов М.А.
// Начат      : 08.11.2006;
// Модуль     : hcJournalView
// Описание   : Журнал работы с консультациями;
// Версия     : $Id: hcJournalView.pas,v 1.6 2010/06/09 11:29:52 oman Exp $

(*-------------------------------------------------------------------------------
  $Log: hcJournalView.pas,v $
  Revision 1.6  2010/06/09 11:29:52  oman
  - fix: {RequestLink:217680883}

  Revision 1.5  2010/06/09 11:28:40  oman
  - fix: {RequestLink:217680883}

  Revision 1.4  2007/06/29 06:05:19  mmorozov
  - bugfix: эмулятор не был готов к записи события получения оценки в журнал (CQ: OIT5-25586);

  Рефакторинг:
  - вместо самостоятельных парсеров для работы с атрибутами используем XMLDocument;
  - добавлены утилитные функции для поиска атрибута, чтения/записи его значения;
  - ограничеваемся одним перечислимым типом при работе с состоянием консультации;
  - идентификатор консультации стал составным;
  - идентфикатор консультации определяется один раз по первому требованию, а не каждый раз как раньше;
  - изменены названия файлов "журнал" и "настройки" эмулятора, к названию программы добаляем расширение 'jrn', 'sts'. Стало красиво, в свете того, что изменился формат файла журнала может оно и к лучшему;

  Revision 1.3  2007/02/06 14:06:00  mmorozov
  - MERGE WITH B_NEMESIS_6_4;

  Revision 1.1.4.2  2007/02/06 08:43:12  mmorozov
  - new behaviour: не удаляем из журнала при получении ответа от пользователя подтвержденные\откланённые консультации + возможность отправить ответ на подтвержденную консультацию из журнала (CQ: OIT5-24236);

  Revision 1.2  2007/01/22 14:17:21  mmorozov
  - MERGE WITH B_NEMESIS_6_4 (CQ: OIT5-24141);

  Revision 1.1.4.1  2007/01/22 13:49:58  mmorozov
  - new: показ статусов выбранных консультаций (CQ: OIT5-24141);

  Revision 1.1  2006/10/04 08:48:04  mmorozov
  - new: в ручном режиме показываем запросы в интернет обозревателе;
  - new: отправленные уведомления и полученные и не обработанные запросы хранятся  в журнале запросов, из которого можно пачками отправлять ответы на посланные уведомления, отправлять ответы и уведомления на полученные запросы; в случае получания подтверждения от пользователя из журнала чистится соответствующее уведомление;
  - new: вынос бизнес логики с формы;
-------------------------------------------------------------------------------*)

interface

{$Include hcDefine.inc}

uses
  Classes,
  ComCtrls,
  Controls,

  l3Interfaces,

  hcInterfaces
  ;

type
  ThcJournalView = class(TListView,
                         Il3Notify,
                         Il3ItemNotifyRecipient)
  private
  // Il3Base
    function CheckStamp(const aGUID: TGUID): Boolean;
      {* - проверяет метку интерфейса. Используется для того, чтобы определить,
           что интерфейс из нашего же потока и может быть например приведен
           к реализиющим объектам, например через Il3ObjectWrap. }
  private
  // Il3ItemNotifyRecipient
      procedure Notify(const aNotifier  : Il3ChangeNotifier;
                       aOperation       : Integer;
                       aIndex           : Integer);
        {* - прошла операция. }
  private
  // inernal methods
    procedure DeleteQuery(const aQuery: IhcQuery);
      {-}
    procedure QueryDataChanged(const aQuery: IhcQuery);
      {-}
    function FindItem(const aQuery: IhcQuery): TListItem;
      {-}
  public
  // methods
    procedure AddQuery(const aQuery: IhcQuery);
      {-}
    constructor Create(AOwner: TComponent);
      override;
      {-}
    class function Make(const AOwner  : TComponent;
                        const AParent : TWinControl): ThcJournalView;
      {-}
    procedure Load(const aJournal: IhcJournal);
      {* - закрузить данные из журнала. }
    function CanSend(const aItem : TListItem;
                     const aType : ThcAnswerType): Boolean;
      {* - можно ли послать ответ на консультацию. }
    function QueryFromItem(const aItem : TListItem): IhcQuery;
      {-}
  end;//ThcJournalView

implementation

uses
  SysUtils,

  hcConst
  ;

{ ThcJournalView }

procedure ThcJournalView.AddQuery(const aQuery: IhcQuery);
var
 l_Notify: Il3ChangeNotifier;
begin
 if aQuery <> nil then
 begin
  if Items.Count = 500 then
   Items.Clear;
  with Items.Add do
  begin
   Data := Pointer(aQuery);
   with aQuery do
   begin
    Caption := DateTimeToStr(Time);
    SubItems.Add(c_QueryStatusDisplayName[Status]);
    SubItems.Add(' query_id = ' + Id.rQueryId);
   end;//with aQuery do
  end;//with Items.Add do
  if Supports(aQuery, Il3ChangeNotifier, l_Notify) then
   l_Notify.Subscribe(Self);
 end;//if aQuery <> nil then
end;//AddQuery

function ThcJournalView.CheckStamp(const aGUID: TGUID): Boolean;
begin
 Result := False;
end;

constructor ThcJournalView.Create(AOwner: TComponent);
begin
 inherited;
 Columns.Add.Caption := c_cjvTime;
 Columns.Add.Caption := c_cjvType;
 Columns.Add.Caption := c_cjvId;
end;

procedure ThcJournalView.QueryDataChanged(const aQuery: IhcQuery);
  {-}
var
 l_Item: TListItem;
begin
 l_Item := FindItem(aQuery);
 if l_Item <> nil then
  l_Item.SubItems[0] := c_QueryStatusDisplayName[aQuery.Status];
end;//QueryDataChanged

function ThcJournalView.FindItem(const aQuery: IhcQuery): TListItem;
var
 l_Index: Integer;
begin
 Result := nil;
 for l_Index := 0 to Pred(Items.Count) do
  if Items.Item[l_Index].Data = Pointer(aQuery) then
  begin
   Result := Items.Item[l_Index];
   Break;
  end;//if Items.Item[l_Index].Data = Pointer(aQuery) then
end;//FindItem

procedure ThcJournalView.DeleteQuery(const aQuery: IhcQuery);
var
 l_Item: TListItem;
begin
 l_Item := FindItem(aQuery);
 if l_Item <> nil then
  l_Item.Delete;
end;//DeleteQuery

function ThcJournalView.CanSend(const aItem : TListItem;
                                const aType : ThcAnswerType): Boolean;
  {* - можно ли послать ответ на консультацию. }
var
 l_Query: IhcQuery;
begin
 Result := False;
 if Assigned(aItem) then
 begin
  l_Query := QueryFromItem(aItem);
  Result := ((aType = atAnswer) and
             (l_Query.Status in [qsNotificationSent, qsSent, qsApplied])) or
            ((aType = atNotification) and (l_Query.Status = qsSent));
 end;
end;

procedure ThcJournalView.Load(const aJournal: IhcJournal);
  {* - закрузить данные из журнала. }
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(aJournal.Count) do
  AddQuery(aJournal.Items[l_Index]);
end;

class function ThcJournalView.Make(const AOwner  : TComponent;
                                   const AParent : TWinControl): ThcJournalView;
begin
 Result := Create(AOwner);
 with Result do
 begin
  Parent := AParent;
  Align := alClient;
  ViewStyle := vsReport;
  RowSelect := True;
  MultiSelect := True;
  ReadOnly := True;
 end;//with Result do
end;//Make

procedure ThcJournalView.Notify(const aNotifier : Il3ChangeNotifier;
                                aOperation      : Integer;
                                aIndex          : Integer);
var
 l_Query: IhcQuery;
begin
 case ThcNotification(aOperation) of
  n_DeleteAnswerFromJournal:
   if Supports(aNotifier, IhcQuery, l_Query) then
    DeleteQuery(l_Query);
  n_QueryDataChanged:
   if Supports(aNotifier, IhcQuery, l_Query) then
    QueryDataChanged(l_Query);
 end;//case ThcNotification(aOperation) of
end;//Notify

function ThcJournalView.QueryFromItem(const aItem: TListItem): IhcQuery;
begin
 Result := IhcQuery(aItem.Data);
end;//QueryFromItem

end.
