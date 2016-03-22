unit D_ExtNameEd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, D_NameEd, OvcBase,  evEditorWindow, evEditor, evMemo, StdCtrls,
  Buttons, ExtCtrls, evMultiSelectEditorWindow,
  evCustomEditor, evEditorWithOperations, afwControl,
  afwControlPrim, afwBaseControl, nevControl, evCustomMemo,
  daTypes,
  dt_Types, dt_AttrSchema, evCustomEditorWindowPrim, evCustomEditorWindow,
  evCustomEditorWindowModelPart, evCustomEditorModelPart
  ;

type
  TExtNameEditDlg = class(TNameEditDlg)
    AddedDataPanel: TPanel;
    pnlExtCode: TPanel;
    Label2: TLabel;
    edtCode: TEdit;
    pnlExtPrivate: TPanel;
    cbxPrivate: TCheckBox;
    cbxIsNonPeriodic: TCheckBox;
    pnlID: TPanel;
    edID: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    procedure OKClick(Sender: TObject);
  private
    f_DictID: TdaDictionaryType;
    function pm_GetElemID: TDictID;
  protected
   f_ExtParams: TDictExtParams;
   f_ExtNeedFillParams: TDictExtParams;
   procedure SetROnly(aValue : boolean); override;
   function GetIsPrivate : Byte;
   function GetIsNonPeriodic : Byte;
   function GetCode : String;

  public
    function Execute(aAttrID: TdaDictionaryType; const aNew: Boolean = False): Boolean;
    property IsPrivate : Byte read GetIsPrivate;
    property IsNonPeriodic : Byte read GetIsNonPeriodic;
    property Code : String read GetCode;
    property ElemID: TDictID read pm_GetElemID;
  end;

implementation

{$R *.dfm}

uses
  StrShop,

  daSchemeConsts,

  DT_Const,
  dt_DictConst,
  DT_Dict,
  DictsSup
  ;

procedure TExtNameEditDlg.SetROnly(aValue : boolean);
begin
 Inherited;
 edtCode.Enabled := Not aValue;
 cbxPrivate.Enabled := Not aValue;
 cbxIsNonPeriodic.Enabled := Not aValue;
end;

function TExtNameEditDlg.GetIsPrivate : Byte;
begin
 if depPrivate in f_ExtParams then
 begin
  if cbxPrivate.Checked then
   Result := 1
  else
   Result := 0;
 end
 else
  Result := cEmptyByte;
end;

function TExtNameEditDlg.GetIsNonPeriodic : Byte;
begin
 if depPrivate in f_ExtParams then
 begin
  if cbxIsNonPeriodic.Checked then
   Result := 1
  else
   Result := 0;
 end
 else
  Result := cEmptyByte;
end;

function TExtNameEditDlg.GetCode : String;
begin
 if depCode in f_ExtParams then
  Result := edtCode.Text
 else
  Result := PChar(nil);
end;

function TExtNameEditDlg.Execute(aAttrID: TdaDictionaryType; const aNew: Boolean = False): Boolean;
var
 lHeight : Integer;
begin
 f_DictID := aAttrID;
 f_ExtParams := GetDictExtParams(aAttrID);
 lHeight := 0;

 if f_ExtParams = [] then
 begin
  pnlID.Visible := False;
  pnlExtCode.Visible := False;
  pnlExtPrivate.Visible := False;
 end
 else
 begin
  if depCode in f_ExtParams then
   Inc(lHeight, pnlExtCode.Height);
  pnlExtCode.Visible := depCode in f_ExtParams;

  pnlExtPrivate.Visible := (depPrivate in f_ExtParams) and (depNonPeriodic in f_ExtParams);
  if pnlExtPrivate.Visible then
   Inc(lHeight, pnlExtPrivate.Height);

  pnlID.Visible := aNew and (depID in f_ExtParams);  // ID редактируетс€ только дл€ новых
  if pnlID.Visible then
  begin
   Inc(lHeight, pnlID.Height);
   //edtID.Text :=
  end;

  cbxIsNonPeriodic.Enabled := not ROnly and (depNonPeriodic in f_ExtParams);
 end;

 if lHeight > 0 then
  AddedDataPanel.Height := lHeight;
 AddedDataPanel.Visible := lHeight > 0;

 Result := inherited Execute(GetDictNameLength(aAttrID));
end;

procedure TExtNameEditDlg.OKClick(Sender: TObject);
var
 l_Str: string;
 l_ID : Longint;
begin
 inherited;
 if (depCode in f_ExtNeedFillParams) and (Trim(edtCode.Text) = '') then
 begin
  ShowMessage(Format(sidFieldEmptyErr, [' од']));
  ActiveControl := edtCode;
  ModalResult := mrNone;
 end;

 if pnlID.Visible then
 begin
  l_Str := Trim(edID.Text);
  if l_Str <> '' then
  begin
   l_ID := StrToIntDef(l_Str, -1);
   if l_ID < 0 then
   begin
    ShowMessage('Ќевалидный ID');
    ActiveControl := edID;
    ModalResult := mrNone;
    Exit;
   end;
   if not DictServer(CurrentFamily).Dict[f_DictID].IsDictIDFree(l_ID) then
   begin
    ShowMessage('Ёлемент с таким ID уже существует!');
    ActiveControl := edID;
    ModalResult := mrNone;
   end;
  end;
 end;
end;

function TExtNameEditDlg.pm_GetElemID: TDictID;
var
 l_Str: string;
begin
 Result := cUndefDictID;
 if pnlID.Visible then
 begin
  l_Str := Trim(edID.Text);
  if l_Str <> '' then
   Result := StrToInt(l_Str);
 end;
end;

end.
