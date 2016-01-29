unit alcuSchedulerFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  alcuMsgDlg, Dialogs, StdCtrls, ExtCtrls, ImgList, Buttons, ComCtrls, l3ObjectRefList,
  ShedulPanel, ddCalendarEvents, ddScheduler, l3Base;

type
  TSchedulerFrame = class(TFrame)
    AddTaskButton: TBitBtn;
    cbShowEveryday: TCheckBox;
    ChangeDateButton: TButton;
    DelTaskButton: TBitBtn;
    EditTaskButton: TBitBtn;
    SchedulerCalendar: TSchedulerCalendar;
    TaskImages: TImageList;
    TaskList: TListView;
    Label1: TLabel;
    listQuery: TListBox;
    procedure AddTaskButtonClick(Sender: TObject);
    procedure ChangeDateButtonClick(Sender: TObject);
    procedure DelTaskButtonClick(Sender: TObject);
    procedure EditTaskButtonClick(Sender: TObject);
    procedure SchedulerCalendarChange(Sender: TObject);
    procedure SchedulerCalendarMonthChanged(Sender: TObject);
    procedure TaskListSelectItem(Sender: TObject; Item: TListItem; Selected:
            Boolean);
    procedure cbShowEverydayClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    f_Scheduler: TddScheduler;
    f_TaskList: Tl3ObjectRefList;
    procedure EditTask(aNewTask: Boolean);
    procedure RefreshScheduler;
    procedure SetScheduler(const Value: TddScheduler);
    procedure OnTaskColor(aTaskType: TddCalendarTaskType; out aColor: TColor);
    procedure CreateImages;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property ConfigScheduler: TddScheduler read f_Scheduler write SetScheduler;
  end;


implementation

{$R *.dfm}

Uses
 alcuChangeDateDlg, alcuTypes,
 DateUtils, Types, ddAppConfigConst;

resourcestring
  rsConfirmDeleteSerie = 'Задание "%s" является повторяющимся. Вы хотите удалить всю серию?';
  rsConfirmDeleteTask = 'Вы действительно хотите удалить задание "%s"?';


{
******************************* TSchedulerFrame ********************************
}
constructor TSchedulerFrame.Create(aOwner: TComponent);
begin
  inherited;
  CreateImages;
  f_Scheduler:= TddScheduler.Create;
  f_Scheduler.OnTaskColor:= OnTaskColor;
  f_TaskList:= Tl3ObjectRefList.Make;
  SchedulerCalendar.Date:= Date;
end;

destructor TSchedulerFrame.Destroy;
begin
  l3Free(f_Scheduler);
  l3Free(f_TaskList);
  inherited;
end;

procedure TSchedulerFrame.AddTaskButtonClick(Sender: TObject);
begin
  EditTask(True);
end;

procedure TSchedulerFrame.ChangeDateButtonClick(Sender: TObject);
var
  l_Task: TddSchedulerTask;
  l_From, l_To: TDateTime;
begin
  { Смена даты задания }
  l_Task:= TddSchedulerTask(f_TaskList.Items[TaskList.ItemIndex]);
  l_From:= l_Task.FullDateTime[SchedulerCalendar.Date];
  with TalcuChangeDateDialog.Create(Application) do
  try
   if Execute(l_task.Caption, l_From, l_To) then
   begin
    ReplaceTime(l_From, l_Task.FullDateTime[SchedulerCalendar.Date]);
    ReplaceTime(l_To, l_Task.FullDateTime[SchedulerCalendar.Date]);
    l_Task.ChangeDate(l_From, l_To);
    l_Task.Changed;
    ConfigScheduler.IsChanged := True;
    RefreshScheduler
   end;
  finally
   Free;
  end;
end;

procedure TSchedulerFrame.DelTaskButtonClick(Sender: TObject);
var
  l_Task: TddSchedulerTask;
begin
  l_Task:= TddSchedulerTask(f_TaskList.Items[TaskList.ItemIndex]);
  if alcuMsgDialog(Format(rsConfirmDeleteTask, [l_Task.Caption]),
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
   if l_Task.Periodicity in Repetitive then
    if alcuMsgDialog(Format(rsConfirmDeleteSerie, [l_Task.Caption]),
                     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
     // Удаляем задание
     ConfigScheduler.DeleteTask(l_Task);
    end
    else
    begin
     // Добавляем дату исключения
     if l_Task.IsIncludeDate(SchedulerCalendar.Date) then
      l_Task.DeleteIncludeDate(SchedulerCalendar.Date)
     else
      l_Task.AddExcludeDate(SchedulerCalendar.Date, SchedulerCalendar.Date, False, True);
    end
    else
     ConfigScheduler.DeleteTask(l_Task);
   // Перерисовать месяц
   ConfigScheduler.IsChanged := True;
   RefreshScheduler;
  end;
end;

procedure TSchedulerFrame.EditTask(aNewTask: Boolean);
var
 l_Task: TddSchedulerTask;
begin
 if (TaskList.ItemIndex > -1) or aNewTask then
 begin
  if aNewTask then
   l_Task:= TddSchedulerTask.Create
  else
   l_Task:= TddSchedulerTask(f_TaskList.Items[TaskList.ItemIndex]);
  if l_Task.Edit then
  begin
   if aNewTask then
    ConfigScheduler.AddTask(l_Task)
   else
    ConfigScheduler.NotifyTaskEdited(l_Task);
   ConfigScheduler.IsChanged := True;
   RefreshScheduler;
  end; // l_Task.Edit
  if aNewTask then
   l3Free(l_Task);
 end; // if TaskList.ItemIndex > -1
end;

procedure TSchedulerFrame.EditTaskButtonClick(Sender: TObject);
begin
  EditTask(False);
end;

procedure TSchedulerFrame.RefreshScheduler;
begin
 SchedulerCalendar.RefreshMonth;
 SchedulerCalendarChange(SchedulerCalendar);
 ConfigScheduler.FillTaskListDescription(Now, listQuery.Items);
end;

procedure TSchedulerFrame.SchedulerCalendarChange(Sender: TObject);
var
  i: Integer;
  ListItem: TListItem;
begin
  { Изменился день и т.д. }
  f_TaskList.Clear;
  taskList.Items.Clear;
  if ConfigScheduler <> nil then
   ConfigScheduler.GetListOnDate(SchedulerCalendar.Date, f_TaskList);
  for i:= 0 to f_TaskList.Hi do
  begin
   ListItem:= TaskList.Items.Add;
   ListItem.Caption:= TddSchedulerTask(f_TaskList.Items[i]).Caption;
   ListItem.StateIndex:= Ord(TddSchedulerTask(f_TaskList.Items[i]).TaskType);
  end;
end;

procedure TSchedulerFrame.SchedulerCalendarMonthChanged(Sender: TObject);
begin
  ConfigScheduler.FillMonthList(SchedulerCalendar.Date, SchedulerCalendar.Schedule, cbShowEveryDay.Checked);
end;

procedure TSchedulerFrame.SetScheduler(const Value: TddScheduler);
begin
 f_Scheduler.Assign(Value);
 RefreshScheduler;
end;

procedure TSchedulerFrame.TaskListSelectItem(Sender: TObject; Item: TListItem;
        Selected: Boolean);
begin
  EditTaskButton.Enabled:= Selected;
  DelTaskButton.Enabled:= Selected;
  ChangeDateButton.Enabled:= Selected and (f_TaskList <> nil) and (TaskList.ItemIndex <> -1) and
        (TddSchedulerTask(f_TaskList.Items[TaskList.ItemIndex]).Periodicity in Repetitive);
end;


procedure TSchedulerFrame.OnTaskColor(aTaskType: TddCalendarTaskType; out aColor: TColor);
begin
 try
  aColor:= ddCalendarEventArray[aTaskType].Color;
 except
  aColor:= clBlack;
 end;
end;

procedure TSchedulerFrame.CreateImages;
var
  l_BMP: TBitmap;
  i: TddCalendarTaskType;
begin
  for i:= Low(TddCalendarTaskType) to High(TddCalendarTaskType) do
  begin
   l_BMP:= TBitmap.Create;
   l_BMP.Width := 16;
   l_BMP.Height := 16;
   with l_BMP.Canvas do
   begin
    Brush.Color := ddCalendarEventArray[i].Color;
    FillRect(Rect(3,3,13,13));
   end; // with l_BMP.Canvas
   TaskImages.Add(l_BMP, nil{l_BMP})
  end;// for i
end;

procedure TSchedulerFrame.cbShowEverydayClick(Sender: TObject);
begin
 SchedulerCalendar.RefreshMonth;
end;

procedure TSchedulerFrame.FrameResize(Sender: TObject);
begin
 TaskList.Width:= ClientWidth - TaskList.Left - c_ConfigItemRight;
 listQuery.Width:= ClientWidth - listQuery.Left - c_ConfigItemRight;
 listQuery.Height:= ClientHeight - listQuery.Top - c_ConfigItemTop;
end;

end.




