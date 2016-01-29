unit ddProcessDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, l3Base, StdCtrls, ComCtrls, ExtCtrls, l3Types, l3ObjectRefList;

type
 TddProcessState = (pcIdle, pcWork, pcDone, pcError);

 TddProcessHandler = function (aProgressProc: Tl3ProgressProc): Boolean of object;

 TddProcess = class(Tl3Base)
 public
  Descript: AnsiString;
  Handler: TddProcessHandler;
  NeedProgress: Boolean;
  Value: Integer;
  Next: TddProcess;
 end;

  TddProcessDialog = class(TForm)
    LabelTitle: TLabel;
    panelItems: TPanel;
    butCancel: TButton;
    groupItems: TGroupBox;
    PanelProgress: TPanel;
    Progress: TProgressBar;
    labelDescript: TLabel;
    IdleTimer: TTimer;
    procedure butCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IdleTimerTimer(Sender: TObject);
  private
    f_Index: Integer;
    f_Items: Tl3ObjectRefList;
    procedure MakeItem(aIndex: Integer);
    function pm_GetTitle: AnsiString;
    procedure pm_SetTitle(const aValue: AnsiString);
    procedure SetItemState(aIndex: Integer; aState: TddProcessState);
    procedure WaitForInput;
    { Private declarations }
  public
   procedure Abort(AllStages: Boolean = True);
   procedure Add(aDescript: AnsiString; aValue: Integer = -1); overload;
    procedure Add(aProcess: TddProcess); overload;
    function Execute: Boolean;
   procedure Finish(aError: Boolean = False; const aFinalText: AnsiString = '');
    procedure ProgressProc(aState : Byte; aValue: Long; const aMsg : AnsiString = '');
   procedure Start(const aMessage: AnsiString = ''; aValue: Integer = -1);
   procedure Update(const aMessage: AnsiString = ''; aCurrent: Integer = -1);
   property Title: AnsiString read pm_GetTitle write pm_SetTitle;
  end;

function NewProcess(aDescript: AnsiString; aHandler: TddProcessHandler; aNeedProgress: Boolean; aNext: TddProcess = nil):
    TddProcess; overload;
function NewProcess(aDescript: AnsiString; aValue: Integer; aNext: TddProcess = nil): TddProcess; overload;

function MakeProcessDialog(aTitle: AnsiString; aProcess: TddProcess): TddProcessDialog;



implementation

{$R *.dfm}
Uses
 StrUtils, Math;

type
 TddProcessInfo = record
  Symbol: Char;
  Color: TColor;
  Style: TFontStyles;
 end;

function MakeProcessDialog(aTitle: AnsiString; aProcess: TddProcess): TddProcessDialog;
var
 l_Next: TddProcess;
begin
 Result:= TddProcessDialog.Create(Application);
 with Result do
 begin
  Title:= aTitle;
  while aProcess <> nil do
  begin
   l_Next:= aProcess.Next;
   Add(aProcess);
   aProcess:= l_Next;
  end;
 end;
end;

function NewProcess(aDescript: AnsiString; aHandler: TddProcessHandler; aNeedProgress: Boolean; aNext: TddProcess = nil):
    TddProcess;
begin
 Result := TddProcess.Create;
 Result.Descript:= aDescript;
 Result.Handler:= aHandler;
 Result.NeedProgress:= aNeedProgress;
 Result.Next:= aNext;
end;

function NewProcess(aDescript: AnsiString; aValue: Integer; aNext: TddProcess = nil): TddProcess;
begin
 Result := TddProcess.Create;
 Result.Descript:= aDescript;
 Result.Value:= aValue;
 Result.Next:= aNext;
end;

const
 ProcessStates : array[TddProcessState] of TddProcessInfo = (
  {pcIdle}  (Symbol: ' '; Color: clGrayText;      Style: []),
  {pcWork}  (Symbol: ' '; Color: clActiveCaption; Style: [fsBold]),
  {pcDone}  (Symbol: #$FC; Color: clGreen;         Style: []),
  {pcError} (Symbol: #$FB; Color: clRed;           Style: [fsItalic])
  );

procedure TddProcessDialog.Abort(AllStages: Boolean = True);
begin
 Finish(True);
 if AllStages then
  while f_Index < f_Items.Count do
   Finish(True);
end;

procedure TddProcessDialog.Add(aDescript: AnsiString; aValue: Integer = -1);
var
 l_P: TddProcess;
begin
 l_P:= TddProcess.Create;
 l_P.Descript:= aDescript;
 l_P.Value:= aValue;
 l_P.Handler:= nil;
 l_P.Next:= nil;
 Add(l_P);
end;

procedure TddProcessDialog.Add(aProcess: TddProcess);
begin
 f_Items.Add(aProcess);
 l3Free(aProcess);
 MakeItem(f_Items.Hi);
end;

procedure TddProcessDialog.Finish(aError: Boolean = False; const aFinalText: AnsiString = '');
begin
 if f_Index < f_Items.Count then
 begin
  IdleTimer.Enabled:= False;
  if not aError then
  begin
   Progress.Position:= Progress.Max;
   SetItemState(f_Index, pcDone);
  end
  else
   SetItemState(f_Index, pcError);
  labelDescript.Caption:= aFinalText;
  Application.ProcessMessages;
  Inc(f_Index);
  if f_Index >= f_Items.Count then
   WaitForInput;
 end;
end;

procedure TddProcessDialog.Start(const aMessage: AnsiString = ''; aValue: Integer = -1);
var
 l_Value: Integer;
begin
 if not Visible then
  Show;
 // Запускаем i-ый процесс, номер увеличиваем сами в Finish или Abort
 if f_Index < f_Items.Count then
 begin
  SetItemState(f_Index, pcWork);
  l_Value:= Max(TddProcess(f_Items.Items[f_Index]).Value, aValue);
  IdleTimer.Enabled:= l_Value <= 0;
  Progress.Min:= 0;
  Progress.Position:= 0;
  Progress.Max:= ifThen(l_Value > 0, l_Value, 100);
  labelDescript.Caption:= aMessage;
  Application.ProcessMessages;
 end; 
end;

procedure TddProcessDialog.Update(const aMessage: AnsiString = ''; aCurrent: Integer = -1);
begin
 if aMessage <> '' then
  labelDescript.Caption:= aMessage;
 if aCurrent > 0 then
  Progress.Position:= aCurrent
 else
  If Progress.Position < Progress.Max then
   Progress.StepIt
  else
   Progress.Position:= 0;
 Application.ProcessMessages;
end;


procedure TddProcessDialog.butCancelClick(Sender: TObject);
begin
 // спросить подтверждение, если "да" - пометить все задания, начиная с текущего, как ошибочные
 Abort;
end;

function TddProcessDialog.Execute: Boolean;
var
 i: Integer;
 l_P: TddProcess;
begin
 Result := True;
 for i:= 0 to f_Items.hi do
 begin
  l_p:= TddProcess(f_Items.Items[i]);
  if Assigned(l_P.Handler) then
  begin
   if not l_P.NeedProgress then
    Start(l_P.Descript, l_P.Value);
   if not l_P.Handler(ProgressProc) then
   begin
    Abort(True);
    Result:= False;
    break;
   end
   else
   if not l_P.NeedProgress then
    Finish;
  end;
 end;
end;

procedure TddProcessDialog.MakeItem(aIndex: Integer);
var
 l_Label: TLabel;
begin
 // Увеличиваем размер панели
 panelItems.ClientHeight:= (aIndex+2)*21;
 PanelProgress.Top:= 21 + panelItems.Top + panelItems.Height;
 butCancel.Top:= 8 + PanelProgress.Top + PanelProgress.Height;
 ClientHeight:= 8 + butCancel.Top + butCancel.Height;
 // Создает пару TLabel с описанием элемента
 l_Label:= TLabel.Create(Self);
 l_Label.Height:= 21;
 l_Label.Width:= 17;
 l_Label.Font.Name:= 'Wingdings';
 //l_Label.Font.Size:= 12;
 l_Label.Font.Style:= [fsBold];
 l_Label.Left:= 8;
 l_Label.Top:= 2*8+(l_Label.Height+8)*aIndex;
 groupItems.InsertControl(l_Label);

 l_Label:= TLabel.Create(Self);
 l_Label.Caption:= TddProcess(f_Items.Items[aIndex]).Descript;
 l_Label.Height:= 21;
 l_Label.Width:= 450;
 l_Label.Font.Name:= 'Arial';
 //l_Label.Font.Size:= 10;
 l_Label.Left:= 32;
 l_Label.Top:= 2*8+(l_Label.Height+8)*aIndex;
 groupItems.InsertControl(l_Label);
 SetItemState(aIndex, pcIdle);
end;

procedure TddProcessDialog.FormCreate(Sender: TObject);
begin
 f_Items:= Tl3ObjectRefList.Make;
 f_Index:= 0;
end;

procedure TddProcessDialog.FormDestroy(Sender: TObject);
begin
 l3Free(f_Items);
end;

function TddProcessDialog.pm_GetTitle: AnsiString;
begin
 Result := Caption;
end;

procedure TddProcessDialog.pm_SetTitle(const aValue: AnsiString);
begin
 Caption:= aValue;
 LabelTitle.Caption:= aValue;
end;

procedure TddProcessDialog.ProgressProc(aState : Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 case aState of
  0: Start(aMsg, aValue);
  1: Update(aMsg, aValue);
  2: Finish(False, aMsg);
 end;
end;

procedure TddProcessDialog.SetItemState(aIndex: Integer; aState: TddProcessState);
var
 l_Label: TLabel;
begin
 // Символ
 l_Label:= (groupItems.Controls[aIndex*2] as TLabel);
 l_Label.Caption:= ProcessStates[aState].Symbol;
 l_Label.Font.Color:= ProcessStates[aState].Color;
 // Текст
 l_Label:= (groupItems.Controls[aIndex*2+1] as TLabel);
 l_Label.Font.Style:= ProcessStates[aState].Style;
end;

procedure TddProcessDialog.WaitForInput;
begin
 //labelDescript.Caption:= '';
 butCancel.Caption:= 'ОК';
 butCancel.ModalResult:= mrOk;
 Hide;
 ShowModal;
end;

procedure TddProcessDialog.IdleTimerTimer(Sender: TObject);
begin
 Update;
end;

end.
