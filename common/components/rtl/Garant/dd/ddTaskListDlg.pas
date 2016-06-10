unit ddTaskListDlg;

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, l3Base, StdCtrls, ActnList, Menus, ExtCtrls,
  Buttons, ImgList,
  l3ObjectRefList, dt_Types, csProcessTask,

  ddTaskItemList,
  daArchiUserList
  ;

type
  TddTerminateTask = procedure (aTaskID: AnsiString) of object;

  TTaskListDialog = class(TForm)
    TaskListView: TListView;
    ActionList1: TActionList;
    PopupMenu1: TPopupMenu;
    ImageList1: TImageList;
    actShowOnlyMyTasks: TAction;
    actShowAllTasks: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    actSortByPriority: TAction;
    actSortByStatus: TAction;
    actSortByUser: TAction;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    actTerminate: TAction;
    N4: TMenuItem;
    N8: TMenuItem;
    actSortByDate: TAction;
    N9: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TaskListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure actShowOnlyMyTasksUpdate(Sender: TObject);
    procedure actShowOnlyMyTasksExecute(Sender: TObject);
    procedure actShowAllTasksUpdate(Sender: TObject);
    procedure actShowAllTasksExecute(Sender: TObject);
    procedure actSortByPriorityUpdate(Sender: TObject);
    procedure actSortByStatusUpdate(Sender: TObject);
    procedure actSortByUserUpdate(Sender: TObject);
    procedure actSortByPriorityExecute(Sender: TObject);
    procedure actSortByStatusExecute(Sender: TObject);
    procedure actSortByUserExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actTerminateExecute(Sender: TObject);
    procedure actTerminateUpdate(Sender: TObject);
    procedure actSortByDateUpdate(Sender: TObject);
    procedure actSortByDateExecute(Sender: TObject);
  private
    f_Changing: Boolean;
    { Private declarations }
    f_TaskList : TddTaskItemList;
    f_UserList: TdaArchiUserList;
    f_ShowOnlyMyTasks: Boolean;
    f_MyUserID: TUserID;
    f_CompareKind: TcsTaskCompareKind;
    f_OnTerminateTask: TddTerminateTask;
   procedure SetTaskList(Value: TddTaskItemList);
   function FindTask(const aTaskID: ShortString): TListItem;
    procedure SetShowOnlyMyTasks(const Value: Boolean);
    procedure pm_SetCompareKind(const Value: TcsTaskCompareKind);
  protected
  public
    { Public declarations }
   function Execute: Boolean;
    function FindUserName(aUserID: TUserID): AnsiString;
   procedure UpdateListView;
  public
   property TaskLst: TddTaskItemList
    read f_TaskList
    write SetTaskList;
   property UserList: TdaArchiUserList read f_UserList write f_UserList;
   property ShowOnlyMyTasks: Boolean read f_ShowOnlyMyTasks write SetShowOnlyMyTasks;
   property MyUserID: TUserID read f_MyUserID write f_MyUserID;
   property CompareKind: TcsTaskCompareKind read f_CompareKind write pm_SetCompareKind;
   property OnTerminateTask: TddTerminateTask read f_OnTerminateTask write f_OnTerminateTask;
  end;

var
  TaskListDialog: TTaskListDialog;

implementation

{$R *.dfm}

Uses
 ArchiUserRequestManager, ddServerTask,
 DateUtils, Math, csTaskTypes;

const
 itmStatus   = 0;
 itmDate     = 1;
 itmProgress = 2;
 itmDescript = 3;
 itmPriority = 4;
 itmTaskID   = 5;
 

function TTaskListDialog.FindTask(const aTaskID: ShortString): TListItem;
var
 i: Integer;
 l_item: TListItem;
begin
 // itmTaskID - идентификатор задачи
 Result:= nil;
 for i:= 0 to Pred(TaskListView.Items.Count) do
 begin
  l_Item:= TaskListView.Items[i];
  if l_Item.SubItems.Strings[itmTaskID] = aTaskID then
  begin
   Result:= l_Item;
   break;
  end;
 end;
end;

procedure TTaskListDialog.UpdateListView;
 procedure Task2Item(aTask: TddTaskItem; aItem: TListItem; Update: Boolean);
 var
  j: Integer;
  l_St: AnsiString;
  l_UserName: ShortString;

  function lp_CalcComment(const aTask: TddProcessTask): AnsiString;
  begin
   if (aTask.Status in cs_tsStatusesWithProgress) and (aTask.RunProgress >= 0) then
    Result := Format('%d%% - %s', [aTask.RunProgress, aTask.Comment])
   else
    Result := aTask.Comment;
  end;

 begin
  if not Update then
  begin
   aItem.Data := aTask;
   for j:= itmStatus to itmTaskID do
    aitem.SubItems.Add('');
  end;
  case aTask.TaskType of
   cs_ttImport: aItem.ImageIndex:= 0;
   cs_ttExport: aItem.ImageIndex:= 1;
   cs_ttAutoClass: aItem.ImageIndex:= 2;
  end; // case aTask.TaskType
  with aitem.SubItems do
  begin
   if not Update then
   begin
    l_UserName := FindUserName(aTask.UserID);
    aItem.Caption:= l_UserName;
    Strings[itmDate]:= FormatDateTime('dd/mm/yy hh:nn', aTask.Date);
    Strings[itmDescript]:= atask.Description;
    Strings[itmPriority]:= IntToStr(aTask.Priority);
    Strings[itmTaskID]:= aTask.TaskID;
   end // not Update
   else
    if Strings[itmDescript] <> atask.Description then
     Strings[itmDescript]:= atask.Description;

   if aTask is TddProcessTask then
   begin
    case TddProcessTask(aTask).Status of
     cs_tsQuery  :
      begin
       //l_st:= 'ожидание';
       aItem.SubItemImages[itmStatus] := 9;
      end;
     cs_tsDone   :
      begin
       //l_st:= 'выполнено';
       aItem.SubItemImages[itmStatus] := 11;
      end;
     cs_tsRun,
     cs_tsAsyncRun    :
      begin
       //l_st:= 'выполняется';
       aItem.SubItemImages[itmStatus] := 7;
      end;
     cs_tsDeleted:
      begin
       //l_st:= 'удалено';
       aItem.SubItemImages[itmStatus] := 10;
      end;
     cs_tsFrozen :
      begin
       //l_st:= 'отложено';
       aItem.SubItemImages[itmStatus] := 13;
      end;
     cs_tsAborting,
     cs_tsError,
     cs_tsAsyncError:
      begin
       //l_st:= 'завершается';
       aItem.SubItemImages[itmStatus] := 12;
      end;
     cs_tsReadyToDelivery:
      begin
       //l_st:= 'завершается';
       aItem.SubItemImages[itmStatus] := 15;
      end;
    end; // case aTask.Status
 //   if Strings[itmStatus] <> l_St then
 //    Strings[itmStatus]:= l_St;
    if Strings[itmProgress] <> lp_CalcComment(TddProcessTask(aTask)) then
     Strings[itmProgress]:= lp_CalcComment(TddProcessTask(aTask));
   end;  //if aTask is TddProcessTask then
  end; // with aitem.SubItems
 end; // Task2Item
var
 i: Integer;
 item: TListItem;
 l_Task: TddTaskItem;
 l_S: AnsiString;
 l_Find: Boolean;
 l_Update: Boolean;
begin
 if not f_Changing then
 begin
  f_Changing:= True;
  try
   l_Update := False;
   l_Find:= TaskListView.Items.Count > 0;
   for i:= 0 to f_TaskList.Hi do
   begin
    l_Task:= f_TaskList.Items[i];
    if ShowOnlyMyTasks and (l_Task.UserID <> MyUserID) then
     Continue;
    l_Update:= False;
    if l_Find then
    begin
     Item:= FindTask(l_Task.TaskID);
     if Item = nil then
      item:= TaskListView.Items.Add
     else
      l_Update:= True;
    end
    else
     item:= TaskListView.Items.Add;
    Task2Item(l_task, item, l_Update);
   end; // for i
   TaskListView.AlphaSort;
  finally
   f_Changing:= False;
  end;
 end;
end;

procedure TTaskListDialog.SetTaskList(Value: TddTaskItemList);
begin
 if Value <> nil then
 begin
  f_TaskList := Value;
  UpdateListView;
 end;
end;

function TTaskListDialog.Execute: Boolean;
begin
 f_Changing:= False;
 Result:= ShowModal = mrOk;
end;

function TTaskListDialog.FindUserName(aUserID: TUserID): AnsiString;
var
 i: Integer;
begin
 Result := 'Инкогнито';
 if UserList <> nil then
  for i:= 0 to f_UserList.Hi do
   if f_UserList.Items[i].ID = aUserID then
   begin
    Result:= f_UserList.Items[i].UserName;
    break
   end;
end;

procedure TTaskListDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 { Нужно послать отказ от обновлений очереди }
 ArchiRequestManager.StopMonitoring;
end;

procedure TTaskListDialog.TaskListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
 l_Task1, l_Task2: TddProcessTask;
begin
 l_Task1 := TddProcessTask(Item1.Data);
 l_Task2 := TddProcessTask(Item2.Data);
 Compare := CompareTaskByKind(CompareKind, l_Task1, Item1.Caption, l_Task2, Item2.Caption);
end;

procedure TTaskListDialog.actShowOnlyMyTasksUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := ShowOnlyMyTasks;
end;

procedure TTaskListDialog.actShowOnlyMyTasksExecute(Sender: TObject);
begin
 ShowOnlyMyTasks := True;
end;

procedure TTaskListDialog.SetShowOnlyMyTasks(const Value: Boolean);
begin
 if f_ShowOnlyMyTasks <> Value then
 begin
  f_ShowOnlyMyTasks := Value;
  TaskListView.Items.Clear;
  UpdateListView;
 end;
end;

procedure TTaskListDialog.actShowAllTasksUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := not ShowOnlyMyTasks;
end;

procedure TTaskListDialog.actShowAllTasksExecute(Sender: TObject);
begin
 ShowOnlyMyTasks := False;
end;

procedure TTaskListDialog.pm_SetCompareKind(
  const Value: TcsTaskCompareKind);
begin
 if f_CompareKind <> Value then
 begin
  f_CompareKind := Value;
  TaskListView.AlphaSort;
 end;
end;

procedure TTaskListDialog.actSortByPriorityUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := CompareKind = cs_tckByPriority;
end;

procedure TTaskListDialog.actSortByStatusUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := CompareKind = cs_tckByStatus;
end;

procedure TTaskListDialog.actSortByUserUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := CompareKind = cs_tckByUser;
end;

procedure TTaskListDialog.actSortByPriorityExecute(Sender: TObject);
begin
 CompareKind := cs_tckByPriority;
end;

procedure TTaskListDialog.actSortByStatusExecute(Sender: TObject);
begin
 CompareKind := cs_tckByStatus;
end;

procedure TTaskListDialog.actSortByUserExecute(Sender: TObject);
begin
 CompareKind := cs_tckByUser;
end;

procedure TTaskListDialog.FormCreate(Sender: TObject);
begin
 f_CompareKind := cs_tckByDate;
end;

procedure TTaskListDialog.actTerminateExecute(Sender: TObject);
begin
 f_OnTerminateTask(TddProcessTask(TaskListView.Selected.Data).TaskID);
end;

procedure TTaskListDialog.actTerminateUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := Assigned(f_OnTerminateTask) and
  Assigned(TaskListView.Selected) and
  Assigned(TaskListView.Selected.Data) and
  (TObject(TaskListView.Selected.Data) is TddProcessTask) and
  (TddProcessTask(TaskListView.Selected.Data).UserID = MyUserID) and
  (TddProcessTask(TaskListView.Selected.Data).Status in cs_tsCanDeleteStatuses);
end;

procedure TTaskListDialog.actSortByDateUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := CompareKind = cs_tckByDate;
end;

procedure TTaskListDialog.actSortByDateExecute(Sender: TObject);
begin
 CompareKind := cs_tckByDate;
end;

end.
