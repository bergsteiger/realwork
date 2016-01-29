unit ddMessageDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls;

type
  TALCUMessageDlg = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
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
    procedure cbLockBaseClick(Sender: TObject);
    procedure cbToAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetLockDateTime: TDateTime;
    function GetStartLockDateTime: TDateTime;
  public
    DoLockBase: Boolean;
    Text: string;
    ToAllUsers: Boolean;
    UserName: string;
    function Execute: Boolean;
    property LockDateTime: TDateTime read GetLockDateTime;
    property StartLockDateTime: TDateTime read GetStartLockDateTime;
  end;
  
var
  ALCUMessageDlg: TALCUMessageDlg;

function GetALCUMessage(aUserName: String; var aMsg: String;
                        var aToAll, aLockBase: Boolean;
                        var aLockDateTime, aStartLock: TDateTime): Boolean;

implementation

{$R *.DFM}

Uses
 l3IniFile,
 DateUtils;

{
******************************* TALCUMessageDlg ********************************
}
procedure TALCUMessageDlg.cbLockBaseClick(Sender: TObject);
begin
  (*
  dtpLockTime.Enabled:= cbLockBase.Checked;
  dtpLockDate.Enabled:= cbLockBase.Checked;
  *)
  GroupBox1.Enabled:= cbLockBase.Checked;
end;

procedure TALCUMessageDlg.cbToAllClick(Sender: TObject);
begin
  if cbToAll.Checked then
   Caption:= 'Сообщение для всех пользователей'
  else
   Caption:= Format('Сообщение для %s', [UserName]);
  cbLockBase.Enabled:= cbToAll.Checked;
  ToAllUsers:= cbToAll.Checked;
end;

function TALCUMessageDlg.Execute: Boolean;
var
  l_Texts: TStringList;
  S: string;
begin
   Caption:= Format('Сообщение для %s', [UserName]);
   comboDefined.ItemIndex:= -1;
  // прочитать новые элементы из ини-файла
  with StationConfig do
  try
   l_Texts:= TStringList.Create;
   try
    Section := 'MessageList';
    ReadSectionValues(l_Texts);
    comboDefined.Items.AddStrings(l_Texts);
    S:= IntToStr(l_Texts.Count);
   finally
    l_Texts.Free;
   end;
  except
  
  end;
  dtpStartLockTime.Time:= Time;
  dtpStartLockDate.Date:= Date;
  dtpLockTime.Time:= IncMinute(Time, 30);
  dtpLockDate.Date:= Date;
  
  Result:= ShowModal = mrOk;
  if Result then
  begin
   Text:= comboDefined.Text;
   DoLockBase:= cbLockBase.Checked;
   if comboDefined.Items.IndexOf(Text) = -1 then // добавить новый текст в ини-файл
    StationConfig.WriteParamStr(S, Text);
  end; // Result
end;

procedure TALCUMessageDlg.FormCreate(Sender: TObject);
begin
  UserName:= 'всех пользователей';
end;

function TALCUMessageDlg.GetLockDateTime: TDateTime;
begin
  Result:= dtpLockDate.Date;
  ReplaceTime(Result, dtpLockTime.Time)
end;

function TALCUMessageDlg.GetStartLockDateTime: TDateTime;
begin
  Result:= dtpStartLockDate.Date;
  ReplaceTime(Result, dtpStartLockTime.Time)
end;


function GetALCUMessage(aUserName: String; var aMsg: String;
                        var aToAll, aLockBase: Boolean;
                        var aLockDateTime, aStartLock: TDateTime): Boolean;
begin
  with TALCUMessageDlg.Create(Application) do
  try
   UserName:= aUserName;
   if Execute then
   begin
    Result:= True;
    aMsg:= Text;
    aToAll:= ToAllUsers;
    aLockBase:= DoLockBase;
    aLockDateTime:= LockDateTime;
    aStartLock:= StartLockDateTime;
   end
   else
    Result:= False;
  finally
    Free;
  end;
end;



end.
