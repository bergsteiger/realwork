unit diaMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, ComCtrls, XPMan, l3Types, diaEngine;

type
  TMainForm = class(TForm)
    XPManifest1: TXPManifest;
    cbDiaName: TComboBox;
    lblDiaName: TLabel;
    edDiapason: TEdit;
    lblDiapason: TLabel;
    btnStart: TButton;
    ProgressBar: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure CheckInput(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbDiaNameSelect(Sender: TObject);
  private
    f_Builder: TdiaFreeBuilder;
    procedure ChangeInterface(aInWork: Boolean);
    procedure OnProgressProc(aState: Byte; aValue: Long; const aMsg : String = '');
    procedure InvalidateInput;
    procedure ReloadDiapasones;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 l3Base,
 l3Interfaces,
 l3RangeManager
 ;

{$R *.dfm}

const
 cStart = 'Начать обработку';
 cBreak = 'Остановить';

procedure TMainForm.CheckInput(Sender: TObject);
begin
 InvalidateInput;
end;

procedure TMainForm.OnProgressProc(aState: Byte; aValue: Long; const aMsg : String = '');
begin
 case aState of
  piStart:
   begin
    ProgressBar.Max := aValue;
    ProgressBar.Position := 0;
   end;
  piCurrent:
   begin
    ProgressBar.Position := aValue;
   end;
  piEnd:
   begin
    ProgressBar.Position := ProgressBar.Max;
   end;
 end;
 Application.ProcessMessages;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 ReloadDiapasones;
end;

procedure TMainForm.InvalidateInput;
var
 l_IsAllOK: Boolean;
 l_RM: Tl3RangeManager;

 procedure ColorLabel(const aLbl: TLabel; aCond: Boolean);
 begin
  if aCond then
   aLbl.Font.Color := clWindowText
  else
  begin
   aLbl.Font.Color := clRed;
   l_IsAllOK := False;
  end;
 end;

begin
 l_IsAllOK := True;
 ColorLabel(lblDiaName, cbDiaName.Text <> '');

 l_RM := Tl3RangeManager.Create;
 try
  try
   l_RM.SrcString := edDiapason.Text;
   ColorLabel(lblDiapason, True);
  except
   ColorLabel(lblDiapason, False);
  end;
 finally
  FreeAndNil(l_RM);
 end;

 btnStart.Enabled := l_IsAllOK;
end;



procedure TMainForm.btnStartClick(Sender: TObject);
var
 l_LastNumCount : Longword;
 l_Idx: Integer;
 l_Obj: TdiaLimitsHolder;
begin
 if f_Builder <> nil then
  f_Builder.IsTerminated := True
 else
 begin
  ChangeInterface(True);
  try
   f_Builder := TdiaFreeBuilder.Create;
   try
    l_Idx := cbDiaName.Items.IndexOf(cbDiaName.Text);
    if l_Idx >= 0 then
     l_LastNumCount := TdiaLimitsHolder(cbDiaName.Items.Objects[l_Idx]).NumCount
    else
     l_LastNumCount := 0;
    f_Builder.OnProgress := OnProgressProc;
    if f_Builder.BuildIntervals(cbDiaName.Text, edDiapason.Text) then
    begin
     ReloadDiapasones;
     if cbDiaName.ItemIndex > -1 then
     begin
      l_Obj := TdiaLimitsHolder(cbDiaName.Items.Objects[cbDiaName.ItemIndex]);
      MessageDlg(Format('Всё сделано!'#10#13'Значений в диапазоне: %d'#10#13'Освобождено: %d', [l_Obj.NumCount, l_Obj.NumCount - l_LastNumCount]),
          mtInformation, [mbOk], 0);
     end
     else
      MessageDlg('Всё сделано!', mtInformation, [mbOk], 0);
    end
    else
     MessageDlg('Обработка прекращена!', mtWarning, [mbOk], 0);
   finally
    FreeAndNil(f_Builder);
   end;
  finally
   ChangeInterface(False);
  end;
 end;
end;

procedure TMainForm.ChangeInterface(aInWork: Boolean);
begin
 if aInWork then
 begin
  btnStart.Caption := cBreak;
  //Screen.Cursor := crHourGlass;
 end
 else
 begin
  //Screen.Cursor := crDefault;
  btnStart.Caption := cStart;
 end;
 ProgressBar.Visible := aInWork;
 cbDiaName.Enabled := not aInWork;
 edDiapason.Enabled := not aInWork;
 Application.ProcessMessages;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 ClearObjects(cbDiaName.Items);
end;

procedure TMainForm.cbDiaNameSelect(Sender: TObject);
var
 l_Obj: TdiaLimitsHolder;
begin
 l_Obj := TdiaLimitsHolder(cbDiaName.Items.Objects[cbDiaName.ItemIndex]);
 edDiapason.Text := IntToStr(l_Obj.Min) + '-' + IntToStr(l_Obj.Max);
end;

procedure TMainForm.ReloadDiapasones;
var
 l_Cur: string;
 l_Idx: Integer;
begin
 l_Cur := cbDiaName.Text;
 FillDiapasonList(cbDiaName.Items);
 if l_Cur <> '' then
 begin
  edDiapason.Text := '';
  l_Idx := cbDiaName.Items.IndexOf(l_Cur);
  if l_Idx >= 0 then
  begin
   cbDiaName.ItemIndex := l_Idx;
   cbDiaNameSelect(nil);
  end
  else
   cbDiaName.Text := '';
 end;
end;

end.
