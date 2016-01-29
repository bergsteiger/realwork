unit alcuLockMessageDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  alcuMsgDlg, StdCtrls, ComCtrls;

type
  TLockMessageDialog = class(TForm)
    Button1: TButton;
    Button2: TButton;
    comboMessage: TComboBox;
    dtpLockDate: TDateTimePicker;
    dtpLockTime: TDateTimePicker;
    dtpStartLockDate: TDateTimePicker;
    dtpStartLockTime: TDateTimePicker;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  public
    function Execute: Boolean;
  end;
  
var
  LockMessageDialog: TLockMessageDialog;

implementation

{$R *.dfm}
Uses
 l3IniFile,
 DateUtils;

{
****************************** TLockMessageDialog ******************************
}
function TLockMessageDialog.Execute: Boolean;
var
  l_Texts: TStringList;
  S: string;
begin
   comboMessage.ItemIndex:= -1;
  { TODO 1 -oДмитрий Дудко -cнедоделка : Восстановить функциональность чтения-записи сообщений }
  // прочитать новые элементы из ини-файла
  (*
  with StationConfig do
  try
   l_Texts:= TStringList.Create;
   try
    Section := 'LockMessageList';
    ReadSectionValues(l_Texts);
    comboMessage.Items.AddStrings(l_Texts);
    S:= IntToStr(l_Texts.Count);
   finally
    l_Texts.Free;
   end;
  except
  end;
  *)
  dtpStartLockTime.Time:= Time;
  dtpStartLockDate.Date:= Date;
  dtpLockTime.Time:= IncMinute(Time, 30);
  dtpLockDate.Date:= Date;
  Result:= ShowModal = mrOk;
  if Result then
  begin
   (*
   if comboMessage.Items.IndexOf(comboMessage.Text) = -1 then // добавить новый текст в ини-файл
    StationConfig.WriteParamStr(S, comboMessage.Text);
   *) 
  end; // Result
end;

end.
