unit configDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Mask, ToolEdit, ComCtrls,
  l3Base, vtSpin, ShedulPanel, ddScheduler, ImgList;

type
  TConfigDialog = class(TForm)
    AddEmailButton: TButton;
    AddTaskButton: TBitBtn;
    CancelBtn: TButton;
    cbCopyBase: TCheckBox;
    cbDoEveryday: TCheckBox;
    cbHeaderIndex: TCheckBox;
    cbLoadDelta: TCheckBox;
    cbLoadKW: TCheckBox;
    cbMakeFullCopy: TCheckBox;
    cbPrepareDelta: TCheckBox;
    cbShowEveryday: TCheckBox;
    cbSilentWork: TCheckBox;
    cbUpdateBase: TCheckBox;
    cbUpdateIndex: TCheckBox;
    cbUpdateTextIndex: TCheckBox;
    cbWeekendBase: TCheckBox;
    ChangeDateButton: TButton;
    CheckBox1: TCheckBox;
    DelEmailButton: TButton;
    DelTaskButton: TBitBtn;
    dirAutoClass: TDirectoryEdit;
    dirBackup: TDirectoryEdit;
    dirBackupRoot: TDirectoryEdit;
    dirBadImport: TDirectoryEdit;
    dirFullBackup: TDirectoryEdit;
    dirGarDocPath: TDirectoryEdit;
    dirLocalFamilyPath: TDirectoryEdit;
    dirNSRC: TDirectoryEdit;
    dirPictures: TDirectoryEdit;
    dirSafe: TDirectoryEdit;
    dirWeekendBase: TDirectoryEdit;
    EditEmailButton: TButton;
    editLogin: TLabeledEdit;
    editPassword: TLabeledEdit;
    editPOP3Login: TLabeledEdit;
    editPOP3Password: TLabeledEdit;
    editPOP3Port: TLabeledEdit;
    editPOP3Server: TLabeledEdit;
    editSMTPPort: TLabeledEdit;
    editSMTPServer: TLabeledEdit;
    EditTaskButton: TBitBtn;
    fileArchiLogFileName: TFilenameEdit;
    fileKW: TFilenameEdit;
    fileKWFileName: TFilenameEdit;
    filePrepareDelta: TFilenameEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Label1: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    LabeledEdit1: TLabeledEdit;
    ListBox1: TListBox;
    OKBtn: TButton;
    PageControl2: TPageControl;
    SchedulerTab: TTabSheet;
    spinBackupAge: TvtSpinEdit;
    spinCountYesterday: TvtSpinEdit;
    spinFreeDiskLimit: TvtSpinEdit;
    spinMaxLogSize: TvtSpinEdit;
    TaskImages: TImageList;
    TaskList: TListView;
    tsDelta: TTabSheet;
    tsEveryday: TTabSheet;
    tsMainOptions: TTabSheet;
    tsNotification: TTabSheet;
    procedure AddEmailButtonClick(Sender: TObject);
    procedure AddTaskButtonClick(Sender: TObject);
    procedure cbCopyBaseClick(Sender: TObject);
    procedure cbDoEverydayClick(Sender: TObject);
    procedure cbLoadDeltaClick(Sender: TObject);
    procedure cbLoadKWClick(Sender: TObject);
    procedure cbMakeFullCopyClick(Sender: TObject);
    procedure cbPrepareDeltaClick(Sender: TObject);
    procedure cbShowEverydayClick(Sender: TObject);
    procedure cbWeekendBaseClick(Sender: TObject);
    procedure ChangeDateButtonClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure DelEmailButtonClick(Sender: TObject);
    procedure DelTaskButtonClick(Sender: TObject);
    procedure EditEmailButtonClick(Sender: TObject);
    procedure EditTaskButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure MonthCalendar1GetMonthInfo(Sender: TObject; Month: Cardinal; var
            MonthBoldInfo: Cardinal);
    procedure TaskListSelectItem(Sender: TObject; Item: TListItem; Selected:
            Boolean);
  private
    f_Calendar: TSchedulerCalendar;
    f_Scheduler: TddScheduler;
    f_TaskList: Tl3PVList;
    procedure CreateImages;
    procedure DateChanged(Sender: TObject);
    procedure EditDate(Sender: TObject);
    procedure EditEmailNotify(aNew: Boolean);
    procedure MonthChanged(Sender: TObject);
    procedure RefreshScheduler;
    procedure SetScheduler(const Value: TddScheduler);
  public
    procedure EditTask(aNewTask: Boolean);
    function Execute: Boolean;
    property ConfigScheduler: TddScheduler read f_Scheduler write SetScheduler;
  end;
  
var
  ConfigDialog: TConfigDialog;

implementation

uses
 alcuMailServer, alcuEmailNotifyDlg, alcuTypes, alcuTaskEdit, alcuChangeDateDlg,
 l3Bits,
 Dialogs, DateUtils;

resourcestring
  rsConfirmDeleteSerie = 'Задание "%s" является повторяющимся. Вы хотите удалить всю серию?';
  rsConfirmDeleteTask = 'Вы действительно хотите удалить задание "%s"?';

{$R *.DFM}

{
******************************** TConfigDialog *********************************
}
procedure TConfigDialog.AddEmailButtonClick(Sender: TObject);
begin
  EditEmailNotify(True);
end;

procedure TConfigDialog.AddTaskButtonClick(Sender: TObject);
begin
  EditTask(True);
end;

procedure TConfigDialog.cbCopyBaseClick(Sender: TObject);
begin
  dirBackup.Enabled:= cbCopyBase.Checked;
end;

procedure TConfigDialog.cbDoEverydayClick(Sender: TObject);
begin
  cbCopyBase.Enabled:= cbDoEveryday.Checked;
  dirBackup.Enabled:= cbDoEveryday.Checked;
  cbUpdateBase.Enabled:= cbDoEveryday.Checked;
  cbUpdateIndex.Enabled:= cbDoEveryday.Checked;
  cbLoadKW.Enabled:= cbDoEveryday.Checked;
  fileKWFileName.Enabled:= cbDoEveryday.Checked;
end;

procedure TConfigDialog.cbLoadDeltaClick(Sender: TObject);
begin
  Label3.Enabled:= cbLoadDelta.Checked;
  dirBackupRoot.Enabled:= cbLoadDelta.Checked;
  Label4.Enabled:= cbLoadDelta.Checked;
  dirNSRC.Enabled:= cbLoadDelta.Checked;
  Label2.Enabled:= cbLoadDelta.Checked;
  dirPictures.Enabled:= cbLoadDelta.Checked;
  fileKW.Enabled:= cbLoadDelta.Checked;
  cbUpdateTextIndex.Enabled:= cbLoadDelta.Checked;
  cbWeekendBase.Enabled:= cbLoadDelta.Checked;
  dirWeekendBase.Enabled:= cbLoadDelta.Checked;
  Label13.Enabled:= cbLoadDelta.Checked;
  spinBackupAge.Enabled:= cbLoadDelta.Checked;
  filePrepareDelta.Enabled:= cbLoadDelta.Checked;
end;

procedure TConfigDialog.cbLoadKWClick(Sender: TObject);
begin
  fileKWFileName.Enabled:= cbLoadKW.Checked;
end;

procedure TConfigDialog.cbMakeFullCopyClick(Sender: TObject);
begin
  dirFullBackup.Enabled:= cbMakeFullCopy.Checked;
end;

procedure TConfigDialog.cbPrepareDeltaClick(Sender: TObject);
begin
  filePrepareDelta.Enabled:= cbPrepareDelta.Checked;
end;

procedure TConfigDialog.cbShowEverydayClick(Sender: TObject);
begin
  f_Calendar.RefreshMonth;
end;

procedure TConfigDialog.cbWeekendBaseClick(Sender: TObject);
begin
  dirWeekendBase.Enabled:= cbWeekendBase.Checked;
end;

procedure TConfigDialog.ChangeDateButtonClick(Sender: TObject);
var
  l_Task: TddSchedulerTask;
  l_From, l_To: TDateTime;
begin
  { Смена даты задания }
  l_Task:= TddSchedulerTask(f_TaskList.Items[TaskList.ItemIndex]);
  l_From:= l_Task.FullDateTime[f_Calendar.Date];
  with TalcuChangeDateDialog.Create(Application) do
  try
   if Execute(l_task.Caption, l_From, l_To) then
   begin
    l_Task.ChangeDate(l_From, l_To);
    RefreshScheduler
   end;
  finally
   Free;
  end;
end;

procedure TConfigDialog.CheckBox1Click(Sender: TObject);
begin
  editLogin.Enabled:= CheckBox1.Checked;
  editPassword.Enabled:= CheckBox1.Checked;
end;

procedure TConfigDialog.CreateImages;
var
  l_BMP: Tl3Bitmap;
  i: Integer;
begin
  for i:= Low(TaskColors) to High(TaskColors) do
  begin
   l_BMP:= Tl3Bitmap.Create;
   try
    l_BMP.Width := 16;
    l_BMP.Height := 16;
    with l_BMP.Canvas do
    begin
     Brush.Color := TaskColors[i];
     FillRect(Rect(3,3,13,13));
    end; // with l_BMP.Canvas
    TaskImages.Add(l_BMP, nil{l_BMP})
   finally
    FreeAndNil(l_BMP);
   end;
  end;
end;

procedure TConfigDialog.DateChanged(Sender: TObject);
var
  i: Integer;
  ListItem: TListItem;
begin
  { Изменился день и т.д. }
  f_TaskList.Clear;
  taskList.Items.Clear;
  if ConfigScheduler <> nil then
   ConfigScheduler.GetListOnDate(f_Calendar.Date, f_TaskList);
  for i:= 0 to f_TaskList.Hi do
  begin
   ListItem:= TaskList.Items.Add;
   ListItem.Caption:= TddSchedulerTask(f_TaskList.Items[i]).Caption;
   ListItem.StateIndex:= TddSchedulerTask(f_TaskList.Items[i]).TaskType;
  end;
end;

procedure TConfigDialog.DelEmailButtonClick(Sender: TObject);
begin
  try
   ListBox1.Items.Delete(ListBox1.ItemIndex);
  except
  end;
end;

procedure TConfigDialog.DelTaskButtonClick(Sender: TObject);
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
     if l_Task.IsIncludeDate(f_Calendar.Date) then
      l_Task.DeleteIncludeDate(f_Calendar.Date)
     else
      l_Task.AddExcludeDate(f_Calendar.Date, f_Calendar.Date, False, True);
    end;
   // Перерисовать месяц
   RefreshScheduler;
  
  end;
end;

procedure TConfigDialog.EditDate(Sender: TObject);
begin
  { Инициация редактирования заданий }
  
end;

procedure TConfigDialog.EditEmailButtonClick(Sender: TObject);
begin
  EditEmailNotify(False);
end;

procedure TConfigDialog.EditEmailNotify(aNew: Boolean);
var
  l_Email: TddEmailNotify;
  l_Index: Integer;
  l_S: string;
begin
  if aNew then
   l_Email:= TddEmailNotify.Create(nil)
  else
   l_Email:= TddEmailNotify(ListBox1.Items.Objects[ListBox1.ItemIndex]);
  
  with TEmailNotifyDialog.Create(Application) do
  try
   editAddress.Text:= l_Email.Address;
   editComment.Text:= l_Email.Comment;
   cbOnlyErrors.Checked:= l_Email.OnlyErrors;
   //EventsList.vlbClearAllItems;
   for l_Index:= 0 to EventsList.Total-1 do
    EventsList.Selected[l_Index]:= l3TestBit(l_Email.Events, l_Index);
  
   if (ShowModal = mrOk) and (editAddress.Text <> '') then
   begin
    l_Email.Address:= editAddress.Text;
    l_Email.Comment:= editComment.Text;
    l_Email.OnlyErrors:= cbOnlyErrors.Checked;
    l_Email.Events:= 0;
    for l_Index:= 0 to EventsList.Total-1 do
     if EventsList.Selected[l_Index] then
      l3SetBit(l_Email.Events, l_Index);
    if l_Email.Comment <> '' then
     l_S:= l_Email.Comment
    else
     l_S:= l_Email.Address;
    if aNew then
     ListBox1.Items.AddObject(l_S, l_Email)
    else
     ListBox1.Items.Strings[ListBox1.ItemIndex]:= l_S;
   end // ShowModal
   else
   if aNew then
    l3Free(l_Email);
  finally
   Free;
  end; // with EmailNotifyDialog
end;

procedure TConfigDialog.EditTask(aNewTask: Boolean);
var
  l_Task: TddSchedulerTask;
  l_ID: Integer;
  l_Caption: string;
  l_Time, l_Date: TDateTime;
  l_Day: Word;
  l_Type: Integer;
  l_WrongDays : TddSchedulerDays;
begin
  if (TaskList.ItemIndex > -1) or aNewTask then
  begin
   if aNewTask then
   begin
    l_ID:= -1;
    l_Caption:= '';
    l_Time:= TimeOf(f_Calendar.Date);
    l_Date:= DateOf(f_Calendar.Date);
    l_Day:= 1;
    l_Type:= -1;
    l_WrongDays := [];
   end
   else
   begin
    l_Task:= TddSchedulerTask(f_TaskList.Items[TaskList.ItemIndex]);
    with l_Task do
    begin
     l_ID:= TaskType;
     l_Caption:= Caption;
     l_Time:= TaskTime;
     l_Date:= TaskDate;
     l_Day:= Day;
     l_Type:= Ord(Periodicity);
     l_WrongDays := WrongDays;
    end;
   end;
   with TSchedulerTaskEditDlg.Create(Application) do
   try
    if Execute(l_ID, l_Caption, l_Time, l_Date, l_Day, l_Type, l_WrongDays) then
    begin
     case l_ID of
      0, 1:  // дельта и обновления
       begin
        l_Task:= ConfigScheduler.GetTaskByID(l_ID);
        if l_Task = nil then
         ConfigScheduler.AddTask(l_ID, l_Caption, l_Time, l_Date, l_Day, TddSchedulerTaskPeriodicity(l_Type))
        else
        begin
         l_Task.Caption:= l_Caption;
         ReplaceTime(l_Date, l_Time);
         if not l_Task.ValidDate(l_Date) and not l_Task.IsIncludeDate(l_Date) then
         begin
          if l_Task.IsExcludeDate(l_date) then
           l_Task.DeleteExcludeDate(l_date)
          else
           l_Task.AddIncludeDate(l_Time, l_Date, False, True);
         end;
        end;
       end;
      2:  // д.р.  { TODO -oNarry -cРазвитие : В качестве описания дня рожения можно хранить пару имя-Id }
       begin
       end;
      3:  // праздник
       begin
        if aNewTask then
         ConfigScheduler.AddTask(l_ID, l_Caption, l_Time, l_Date, l_Day, TddSchedulerTaskPeriodicity(l_Type))
        else
        with l_Task do
        begin
         TaskType:= l_ID;
         Caption:= l_Caption;
         TaskTime:= l_Time;
         TaskDate:= l_Date;
         Day:= l_Day;
         Periodicity:= TddSchedulerTaskPeriodicity(l_Type);
        end;
       end;
     end; // case
  
     RefreshScheduler;
    end; // Execute
   finally
    Free;
   end;
  end; // if TaskList.ItemIndex > -1
end;

procedure TConfigDialog.EditTaskButtonClick(Sender: TObject);
begin
  EditTask(False);
end;

function TConfigDialog.Execute: Boolean;
begin
  f_Calendar.Date:= Now;
  RefreshScheduler;
  Result:= ShowModal = mrOk;
end;

procedure TConfigDialog.FormCreate(Sender: TObject);
begin
   {$IFDEF Baranoff}
  Label10.Visible:= False;
  dtpDeltaTime.Visible:= False;
  tsDelta.TabVisible:= False;
  tsNotification.TabVisible:= False;
  cbSafeWork.Visible:= False;
  cbSafeWork.Checked:= False;
  GroupBox5.Visible:= False;
  cbLoadKW.Visible:= False;
  cbLoadKW.Checked:= False;
  fileKWFileName.Visible:= False;
  Label15.Visible:= False;
  dirGarDocPath.Visible:= False;
   {$ENDIF}
  f_Scheduler:= TddScheduler.Create(nil);
  f_TaskList:= Tl3ObjectRefList.Make;
  
  
  // f_Calendar:= TSchedulPanel.Create(SchedulerTab);
  f_Calendar:= TSchedulerCalendar.Create(SchedulerTab);
  f_Calendar.Parent:= SchedulerTab;
  f_Calendar.Top:= 4;
  f_Calendar.Left:= 4;
  f_Calendar.OnChange:= DateChanged;
  f_Calendar.OnMonthChanged:= MonthChanged;
  f_Calendar.OnDblClick:= EditDate;
  
  CreateImages;
  PageControl2.ActivePage:= tsMainOptions
end;

procedure TConfigDialog.FormDestroy(Sender: TObject);
begin
  l3Free(f_Scheduler);
  l3Free(f_TaskList);
end;

procedure TConfigDialog.ListBox1DblClick(Sender: TObject);
begin
  EditEmailNotify(False);
end;

procedure TConfigDialog.MonthCalendar1GetMonthInfo(Sender: TObject; Month:
        Cardinal; var MonthBoldInfo: Cardinal);
begin
  MonthBoldInfo:= $21;
end;

procedure TConfigDialog.MonthChanged(Sender: TObject);
begin
  ConfigScheduler.FillMonthList(f_Calendar.Date, f_Calendar.Schedule, cbShowEveryDay.Checked);
end;

procedure TConfigDialog.RefreshScheduler;
var
  l_Task: TddSchedulerTask;
begin
  f_Calendar.RefreshMonth;
  DateChanged(f_Calendar);
  l_Task:= ConfigScheduler.GetNearestTask(Now);
  if l_Task <> nil then
   LabeledEdit1.Text:= l_Task.Description
  else
   LabeledEdit1.Text:= '';
end;

procedure TConfigDialog.SetScheduler(const Value: TddScheduler);
begin
  f_Scheduler.Assign(Value);
end;

procedure TConfigDialog.TaskListSelectItem(Sender: TObject; Item: TListItem;
        Selected: Boolean);
begin
  EditTaskButton.Enabled:= Selected;
  DelTaskButton.Enabled:= Selected;
  ChangeDateButton.Enabled:= Selected and (f_TaskList <> nil) and (TaskList.ItemIndex <> -1) and
        (TddSchedulerTask(f_TaskList.Items[TaskList.ItemIndex]).Periodicity in Repetitive);
end;


end.




