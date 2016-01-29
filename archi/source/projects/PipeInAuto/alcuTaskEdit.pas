unit alcuTaskEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  alcuMsgDlg, Dialogs, StdCtrls, ComCtrls, ExtCtrls, ddScheduler,  ddCalendarEvents;

type
  TSchedulerTaskEditDlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    ComboBox1: TComboBox;
    cbTaskType: TComboBox;
    DateTimePicker1: TDateTimePicker;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnSubTasks: TButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure cbTaskTypeChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure AddControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnSubTasksClick(Sender: TObject);
  private
    f_AddControl1: TControl;
    f_AddControl2: TControl;
    f_AddLabel1: TLabel;
    f_AddLabel2: TLabel;
    f_Date: TDateTime;
    f_Day: Word;
    f_IsNewItem: Boolean;
    f_Scheduler: TddScheduler;
    f_WrongDays: TddSchedulerDays;
    procedure ClearAdditionalComponents;
    procedure MakeEveryDayComponents;
    procedure MakeEveryMonthComponents;
    procedure MakeEveryWeekComponents;
    procedure MakeEveryYearComponents;
    procedure MakeOnceComponents;
    function pm_GetTaskType: TddCalendarTaskType;
    procedure pm_SetTaskType(const aValue: TddCalendarTaskType);
  protected
    property TaskType: TddCalendarTaskType read pm_GetTaskType write pm_SetTaskType;
  public
    function Execute(aIsNew: Boolean; var aTaskType: TddCalendarTaskType; var aCaption: String; var aTime, aDate:
        TDateTime; var aDay: Word; var aPeriodicity: Integer; var aWrongDays: TddSchedulerDays; aScheduler: TddScheduler):
        Boolean;
  end;

var
  SchedulerTaskEditDlg: TSchedulerTaskEditDlg;

implementation
Uses
 DateUtils,
 CheckLst,
 l3Base,
 vtDialogs,
 alcuTypes;

{$R *.dfm}

const
 AdditionalTop  = 112;
 AdditionalLeft = 96;

 addDate       = 1;
 addDayOfWeek  = 2;
 addDayOfMonth = 3;
 addDay        = 4;
 addMonth      = 5;
 addWrongDays  = 6;
{
**************************** TSchedulerTaskEditDlg *****************************
}
procedure TSchedulerTaskEditDlg.ClearAdditionalComponents;
begin
  { Здесь удаляются все дополнительные компоненты }
  if f_AddLabel1 <> nil then
   RemoveControl(f_AddLabel1);
  if f_AddLabel2 <> nil then
   RemoveControl(f_AddLabel2);
  if f_AddControl1 <> nil then
   RemoveControl(f_AddControl1);
  if f_AddControl2 <> nil then
   RemoveControl(f_AddControl2);
end;

procedure TSchedulerTaskEditDlg.ComboBox1Change(Sender: TObject);
begin
  ClearAdditionalComponents;
  case ComboBox1.ItemIndex of
   0: MakeOnceComponents;
   1: MakeEveryDayComponents;
   2: MakeEveryWeekComponents;
   3: MakeEveryMonthComponents;
   4: MakeEveryYearComponents;
  end;
  BtnOk.Enabled:= ComboBox1.ItemIndex <> -1;
end;

procedure TSchedulerTaskEditDlg.cbTaskTypeChange(Sender: TObject);
begin
  btnOk.Enabled:= ComboBox1.ItemIndex <> 2;
  ComboBox1.ItemIndex := ddCalendarEventArray[TaskType].DefaultRep;

  case TaskType of
   ctBirthdayTask: // День рождения
     DateTimePicker1.Time:= EncodeTime(12,0,0,0);
     { TODO -oNarry -cОшибка : Нужно создавать компонент для выбора пользователя из списка.
        Можно вместо строки ввода делать выпадающий список }
   ctHolidayTask: // Праздник
     DateTimePicker1.Time:= EncodeTime(12,0,0,0);
  end;
  ComboBox1Change(Self);
  //if Edit1.Text = '' then
   Edit1.Text := cbTaskType.Text;//  Items.Strings[cbTaskType.ItemIndex]
end;

procedure TSchedulerTaskEditDlg.Edit1Change(Sender: TObject);
begin
  if Edit1.Text = '' then
   Caption:= 'Новое задание'
  else
   Caption:= Edit1.Text;
end;

function TSchedulerTaskEditDlg.Execute(aIsNew: Boolean; var aTaskType: TddCalendarTaskType; var aCaption: String; var
    aTime, aDate: TDateTime; var aDay: Word; var aPeriodicity: Integer; var aWrongDays: TddSchedulerDays; aScheduler:
    TddScheduler): Boolean;
begin
  f_IsNewItem := aIsNew;
  if aIsNew then
   cbTaskType.ItemIndex := -1
  else
   TaskType:= aTaskType;
  ComboBox1.ItemIndex:= aPeriodicity;
  Edit1.Text:= aCaption;
  DateTimePicker1.Time:= aTime;
  f_Date:= aDate;
  f_Day:= aDay;
  f_WrongDays := aWrongDays;
  ComboBox1Change(Self);
  f_Scheduler := aScheduler;
  Result:= ShowModal = mrOk;
  if Result then
  begin
   aTaskType:= TaskType;
   aCaption:= Edit1.Text;
   aTime:= DateTimePicker1.Time;
   aDate:= f_Date;
   aDay:= f_Day;
   aPeriodicity:= ComboBox1.ItemIndex;
   aWrongDays := f_WrongDays;
  end;
end;

procedure TSchedulerTaskEditDlg.MakeEveryDayComponents;
var
 i: Integer;
begin
  f_AddLabel1:= TLabel.Create(Self);
  f_AddLabel1.Parent:= Self;
  f_AddLabel1.Top:= AdditionalTop;
  f_AddLabel1.Left:= 8;
  f_AddLabel1.Caption:= 'Кроме';
  f_AddControl1:= TCheckListBox.Create(Self);
  f_AddControl1.Tag:= addWrongDays;
  f_AddControl1.Parent:= Self;
  f_AddControl1.Top:= AdditionalTop;
  f_AddControl1.Left:= AdditionalLeft;
  f_AddControl1.Width:= Edit1.Width;
  f_AddControl1.Height:= btnOk.Top - 4 - AdditionalTop;
  with f_AddControl1 as TCheckListBox do
  begin
   Columns := 2;
   OnClickCheck:= AddControlChange;
   Items.Add('Понедельника');
   Items.Add('Вторника');
   Items.Add('Среды');
   Items.Add('Четверга');
   Items.Add('Пятницы');
   Items.Add('Субботы');
   Items.Add('Воскресенья');
   for i:= 0 to Pred((f_AddControl1 as TCheckListBox).Items.Count) do
    TCheckListBox(f_AddControl1).Checked[i]:= TddSchedulerDayOfWeek(Succ(i)) in f_WrongDays;
  end;
end;

procedure TSchedulerTaskEditDlg.MakeEveryMonthComponents;
var
  i: Integer;
begin
  f_AddLabel1:= TLabel.Create(Self);
  f_AddLabel1.Parent:= Self;
  f_AddLabel1.Top:= AdditionalTop;
  f_AddLabel1.Left:= 8;
  f_AddLabel1.Caption:= 'Каждый месяц';
  f_AddControl1:= TComboBox.Create(Self);
  f_AddControl1.Tag:= addDayOfMonth;
  f_AddControl1.Parent:= Self;
  f_AddControl1.Top:= AdditionalTop;
  f_AddControl1.Left:= AdditionalLeft;
  f_AddControl1.Width:= Edit1.Width;
  with f_AddControl1 as TComboBox do
  begin
   OnChange:= AddControlChange;
   Style:= csDropDownList;
   for i:= 1 to 31 do
    Items.Add(Format('%d-го числа', [i]));
   ItemIndex:= Pred(DayOf(f_Date))
  end;
end;

procedure TSchedulerTaskEditDlg.MakeEveryWeekComponents;
begin
  f_AddLabel1:= TLabel.Create(Self);
  f_AddLabel1.Parent:= Self;
  f_AddLabel1.Top:= AdditionalTop;
  f_AddLabel1.Left:= 8;
  f_AddLabel1.Caption:= 'Еженедельно по';
  f_AddControl1:= TComboBox.Create(Self);
  f_AddControl1.Tag:= addDayOfweek;
  f_AddControl1.Parent:= Self;
  f_AddControl1.Top:= AdditionalTop;
  f_AddControl1.Left:= AdditionalLeft;
  f_AddControl1.Width:= Edit1.Width;
  with f_AddControl1 as TComboBox do
  begin
   Style:= csDropDownList;
   OnChange:= AddControlChange;
   Items.Add('понедельникам');
   Items.Add('вторникам');
   Items.Add('средам');
   Items.Add('четвергам');
   Items.Add('пятницам');
   Items.Add('субботам');
   Items.Add('воскресеньям');
   ItemIndex:= Pred(f_Day);
  end;
end;

procedure TSchedulerTaskEditDlg.MakeEveryYearComponents;
var
  i: Integer;
begin
  f_AddLabel1:= TLabel.Create(Self);
  f_AddLabel1.Parent:= Self;
  f_AddLabel1.Top:= AdditionalTop;
  f_AddLabel1.Left:= 8;
  f_AddLabel1.Caption:= 'Каждый год';
  f_AddControl1:= TComboBox.Create(Self);
  f_AddControl1.Tag:= addDay;
  f_AddControl1.Parent:= Self;
  f_AddControl1.Top:= AdditionalTop;
  f_AddControl1.Left:= AdditionalLeft;
  f_AddControl1.Width:= DateTimePicker1.Width div 2 - 2;
  with f_AddControl1 as TComboBox do
  begin
   Style:= csDropDownList;
   OnChange:= AddControlChange;
   for i:= 1 to 31 do
    Items.Add(Format('%d-го', [i]));
   ItemIndex:= Pred(DayOf(f_Date))
  end;
  f_AddControl2:= TComboBox.Create(Self);
  f_AddControl2.Tag:= addMonth;
  f_AddControl2.Parent:= Self;
  f_AddControl2.Top:= AdditionalTop;
  f_AddControl2.Left:= AdditionalLeft + f_AddControl1.Width + 4;
  f_AddControl2.Width:= Edit1.Width - (f_AddControl2.Left-Edit1.Left);
  with f_AddControl2 as TComboBox do
  begin
   Style:= csDropDownList;
   OnChange:= AddControlChange;
   Items.Add('января');
   Items.Add('февраля');
   Items.Add('марта');
   Items.Add('апреля');
   Items.Add('мая');
   Items.Add('июня');
   Items.Add('июля');
   Items.Add('августа');
   Items.Add('сентября');
   Items.Add('октября');
   Items.Add('ноября');
   Items.Add('декабря');
   ItemIndex:= Pred(MonthOf(f_Date))
  end;
end;

procedure TSchedulerTaskEditDlg.MakeOnceComponents;
begin
  f_AddLabel1:= TLabel.Create(Self);
  f_AddLabel1.Parent:= Self;
  f_AddLabel1.Top:= AdditionalTop;
  f_AddLabel1.Left:= 8;
  f_AddLabel1.Caption:= 'Дата';
  f_AddControl1:= TDateTimePicker.Create(Self);
  f_AddControl1.Tag:= addDate;
  f_AddControl1.Parent:= Self;
  f_AddControl1.Top:= AdditionalTop;
  f_AddControl1.Left:= AdditionalLeft;
  f_AddControl1.Width:= Edit1.Width;
  with f_AddControl1 as TDateTimePicker do
  begin
   Kind:= dtkDate;
   OnChange:= AddControlChange;
   Date:= f_Date;
  end;
end;

procedure TSchedulerTaskEditDlg.AddControlChange(Sender: TObject);
var
 i: Integer;
begin
 case (Sender as TComponent).Tag of
  addDate       : f_Date:= (Sender as TDateTimePicker).Date; // полная дата
  addDayOfWeek  : f_Day:= Succ((Sender as TComboBox).ItemIndex); // день недели
  addDayOfMonth : TryEncodeDate(1900, 1, Succ((Sender as TComboBox).ItemIndex), f_Date); // день месяца
  addDay        : TryEncodeDate(1900, (f_AddControl2 as TComboBox).ItemIndex, (Sender as TComboBox).ItemIndex, f_Date); // число
  addMonth      : TryEncodeDate(1900, (Sender as TComboBox).ItemIndex, (f_AddControl1 as TComboBox).ItemIndex, f_Date); // месяц
  addWrongDays  :
   begin
    f_WrongDays := [];
    for i:= 0 to Pred((f_AddControl1 as TCheckListBox).Items.Count) do
     if TCheckListBox(f_AddControl1).Checked[i] then
      Include(f_WrongDays, TddSchedulerDayOfWeek(Succ(i)));
   end;
 end; // case
end;

procedure TSchedulerTaskEditDlg.FormCreate(Sender: TObject);
var
 i: TddCalendarTaskType;
begin
 with cbTaskType.Items do
 begin
  Clear;
  for i:= Low(TddCalendarTaskType) to High(TddCalendarTaskType) do
   if i in ddEnabledTasks then
    Add(ddCalendarEventArray[i].Caption);
 end;
end;

function TSchedulerTaskEditDlg.pm_GetTaskType: TddCalendarTaskType;
var
 i: TddCalendarTaskType;
begin
 for i:= ctDeltaTask to High(TddCalendarTaskType) do
  if ddCalendarEventArray[i].Caption = cbTaskType.Text then
  begin
   Result := i;
   break;
  end; 
end;

procedure TSchedulerTaskEditDlg.pm_SetTaskType(const aValue: TddCalendarTaskType);
begin
 if TddCalendarTaskType(aValue) in ddEnabledTasks then
  cbTaskType.ItemIndex:= cbTaskType.Items.IndexOf(ddCalendarEventArray[aValue].Caption)
 else
  cbTaskType.ItemIndex:= -1;
end;

procedure TSchedulerTaskEditDlg.btnOkClick(Sender: TObject);
begin
 if cbTaskType.ItemIndex = -1 then
  vtMessageDlg(l3CStr('Выберите тип задания!'), mtError)
 else
  if f_IsNewItem and ddCalendarEventArray[TaskType].Unique and
     (f_Scheduler.GetTaskByTaskType(TaskType) <> nil) then
   vtMessageDlg(l3CStr(Format('Задание типа "%s" может быть только одно!', [ddCalendarEventArray[TaskType].Caption])), mtError)
  else
   ModalResult := mrOK;
end;

procedure TSchedulerTaskEditDlg.btnSubTasksClick(Sender: TObject);
begin
 // Открыть окно со списком вложенных задач
end;

end.
