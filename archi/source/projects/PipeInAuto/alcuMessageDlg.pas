unit alcuMessageDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, alcuMsgDlg,
  StdCtrls, Buttons, ComCtrls;

type
  TalcuDialogType = (adtMessage, adtLockBase);
  TalcuMessageDialog = class(TForm)
    cbLockBase: TCheckBox;
    cbToAll: TCheckBox;
    comboDefined: TComboBox;
    dtpLockDate: TDateTimePicker;
    dtpLockTime: TDateTimePicker;
    dtpStartLockDate: TDateTimePicker;
    dtpStartLockTime: TDateTimePicker;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OkBtn: TButton;
    CancelBtn: TButton;
    procedure cbLockBaseClick(Sender: TObject);
    procedure cbToAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    f_DialogType: TalcuDialogType;
    function GetLockDateTime: TDateTime;
    function GetStartLockDateTime: TDateTime;
    procedure pm_SetDialogType(const Value: TalcuDialogType);
    property DialogType: TalcuDialogType read f_DialogType write pm_SetDialogType;
  public
    DoLockBase: Boolean;
    Text: string;
    ToAllUsers: Boolean;
    UserName: string;
    function Execute: Boolean;
    property LockDateTime: TDateTime read GetLockDateTime;
    property StartLockDateTime: TDateTime read GetStartLockDateTime;
  end;

function GetUserMessage(aUserName: String; var aMsg: String; var aToAll, aLockBase: Boolean; var
    aLockDateTime, aStartLock: TDateTime): Boolean;

function alcuMessageDialog(const aCaption: string; var aMessage: String; aDlgType: TalcuDialogType;
    var aToAll, aLockBase: Boolean; var aStartDate, aFinishDate: TDateTime): Boolean;

function GetLockBaseMessage(var aMsg: String; var aDateStart, aDateEnd: TDateTime): Boolean;



implementation

{$R *.DFM}

Uses
 l3IniFile,
 DateUtils, ddAppConfig, StrUtils, ddAppConfigDataAdapters;

{
******************************* TALCUMessageDlg ********************************
}
procedure TalcuMessageDialog.cbLockBaseClick(Sender: TObject);
begin
  (*
  dtpLockTime.Enabled:= cbLockBase.Checked;
  dtpLockDate.Enabled:= cbLockBase.Checked;
  *)
  GroupBox1.Enabled:= cbLockBase.Checked;
end;

procedure TalcuMessageDialog.cbToAllClick(Sender: TObject);
begin
  if cbToAll.Checked then
   Caption:= 'Сообщение для всех пользователей'
  else
   Caption:= Format('Сообщение для %s', [UserName]);
  cbLockBase.Enabled:= cbToAll.Checked;
  ToAllUsers:= cbToAll.Checked;
end;

function TalcuMessageDialog.Execute: Boolean;
var
 l_Texts: TStringList;
 S: string;
 l_List: String;
begin
 if DialogType = adtMessage then
  Caption:= Format('Сообщение для %s', [UserName]);
 comboDefined.ItemIndex:= -1;
  // прочитать новые элементы из ини-файла
 l_List:= IfThen(DialogType = adtMessage, 'InfoMessages', 'LockMessages');
 comboDefined.Items.AddStrings(TddStringDataAdapter(ddAppConfiguration.AsObject[l_List]).GetStrings);
  dtpStartLockTime.Time:= Time;
  dtpStartLockDate.Date:= Date;
  dtpLockTime.Time:= IncMinute(Time, 30);
  dtpLockDate.Date:= Date;

  Result:= ShowModal = mrOk;
  if Result then
  begin
   Text:= comboDefined.Text;
   DoLockBase:= cbLockBase.Checked;
   if comboDefined.Items.IndexOf(comboDefined.Text) = -1 then
    (TddStringDataAdapter(ddAppConfiguration.AsObject[l_List]).GetStrings).Add(comboDefined.Text);
   ddAppConfiguration.Save;
  end; // Result
end;

procedure TalcuMessageDialog.FormCreate(Sender: TObject);
begin
  UserName:= 'всех пользователей';
end;

function TalcuMessageDialog.GetLockDateTime: TDateTime;
begin
  Result:= dtpLockDate.Date;
  ReplaceTime(Result, dtpLockTime.Time)
end;

function TalcuMessageDialog.GetStartLockDateTime: TDateTime;
begin
  Result:= dtpStartLockDate.Date;
  ReplaceTime(Result, dtpStartLockTime.Time)
end;

procedure TalcuMessageDialog.pm_SetDialogType(const Value: TalcuDialogType);
begin
 f_DialogType := Value;
 if DialogType = adtLockBase then
 begin
  Caption:= 'Закрытие базы от входа в нее пользователей';
  cbToAll.Visible:= False;
  cbLockBase.Visible:= False;
  comboDefined.Items.Clear;
  GroupBox1.Caption:= 'Закрыть базу на период'
 end;
end;


function GetUserMessage(aUserName: String; var aMsg: String; var aToAll, aLockBase: Boolean; var
    aLockDateTime, aStartLock: TDateTime): Boolean;
begin
 Result:= alcuMessageDialog(aUserName, aMsg, adtMessage, aToAll, aLockBase, aStartLock, aLockDateTime);
end;

function alcuMessageDialog(const aCaption: string; var aMessage: String; aDlgType: TalcuDialogType;
    var aToAll, aLockBase: Boolean; var aStartDate, aFinishDate: TDateTime): Boolean;
begin
  with TalcuMessageDialog.Create(Application) do
  try
   UserName:= aCaption;
   cbToAll.Checked:= aToAll;
   cbLOckBase.Checked:= aLockBase;
   DialogType:= aDlgType;
   if Execute then
   begin
    Result:= True;
    aMessage:= Text;
    aToAll:= ToAllUsers;
    aLockBase:= DoLockBase;
    aFinishDate:= LockDateTime;
    aStartDate:= StartLockDateTime;
   end
   else
    Result:= False;
  finally
    Free;
  end;

end;

function GetLockBaseMessage(var aMsg: String; var aDateStart, aDateEnd: TDateTime): Boolean;
var
 l_L, l_A: Boolean;
begin
 l_L:= True;
 l_A:= True;
 Result:= alcuMessageDialog('', aMsg, adtLockBase, l_A, l_L, aDateStart, aDateEnd);
end;



end.
