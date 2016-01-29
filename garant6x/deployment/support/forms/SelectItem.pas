unit SelectItem;

interface

uses
 Windows,
 Classes,
 Graphics,
 Controls,
 Forms,
 Dialogs,
 StdCtrls,
 ExtCtrls,
 FileCtrl;

type
 TSelectItemForm = class(TForm)
  f_MainPanel: TPanel;
  f_SelectItemPanel: TPanel;
  //
  f_SplashImage: TImage;
  //
  f_DescriptionLabel: TLabel;
  //
  f_ItemsComboBox: TComboBox;
  f_OKButton: TButton;
  //
  procedure FormCreate(a_Sender: TObject);
  //
 private
  function  GetDescription: string;
  procedure SetDescription(const a_Value: string);
  //
  procedure OnShowNotifyEvent(a_Sender: TObject);
 public
  property Description: string read GetDescription write SetDescription;
  property ItemsComboBox: TComboBox read f_ItemsComboBox;
 end;

var
 SelectItemForm: TSelectItemForm;

implementation {$R *.DFM}

uses
 SysUtils
 ;

procedure TSelectItemForm.FormCreate(a_Sender: TObject);
begin
 OnShow := OnShowNotifyEvent;
end;

function TSelectItemForm.GetDescription: string;
 //
 var
  l_Position: Integer;
  l_Value: string;
 //
begin
 Result := f_DescriptionLabel.Caption;
 //
 repeat
  l_Position := Pos(#10, Result);
  //
  if (l_Position <> 0) then
  begin
   Delete(l_Value, l_Position, 1);
   Insert('\n', l_Value, l_Position);
  end
  else
  begin
   l_Position := Pos(#13, l_Value);
   //
   if (l_Position <> 0) then
   begin
    Delete(l_Value, l_Position, 1);
    Insert('\r', l_Value, l_Position);
   end;
  end;
 until (l_Position = 0);
end;

procedure TSelectItemForm.SetDescription(const a_Value: string);
 //
 var
  l_Position: Integer;
  l_Value: string;
 //
begin
 l_Value := a_Value;
 //
 repeat
  l_Position := Pos('\n', l_Value);
  //
  if (l_Position <> 0) then
  begin
   Delete(l_Value, l_Position, 2);
   Insert(#10, l_Value, l_Position);
  end
  else
  begin
   l_Position := Pos('\r', l_Value);
   //
   if (l_Position <> 0) then
   begin
    Delete(l_Value, l_Position, 2);
    Insert(#13, l_Value, l_Position);
   end;
  end;
 until (l_Position = 0);
 //
 f_DescriptionLabel.Caption := l_Value;
end;

procedure TSelectItemForm.OnShowNotifyEvent(a_Sender: TObject);
begin
 SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW and not(WS_EX_TOOLWINDOW));
end;

end.
