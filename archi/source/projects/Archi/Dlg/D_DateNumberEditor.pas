unit D_DateNumberEditor;

{ $Id: D_DateNumberEditor.pas,v 1.29 2014/10/31 14:22:36 voba Exp $ }

interface
{$I arDefine.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask,
  k2Interfaces, k2Tags,
  l3Date,
  DT_Const, DT_Types, DT_DictTypes,
  BottomBtnDlg, vtCombo, vtDateEdit,
  
  l3Variant
  ;

type
  TDateNumEditorDlg = class(TBottomBtnDlg)
    Bevel3: TBevel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label1: TLabel;
    lblDate: TLabel;
    lblNumber: TLabel;
    edtDate: TvtDateEdit;
    cbDNType: TComboBox;
    edtNumber: TEdit;
    cbMOJNOTREG: TCheckBox;
    procedure cbDNTypeChange(Sender: TObject);
    procedure edtNumberChange(Sender: TObject);
    procedure edtDateChange(Sender: TObject);
    procedure cbMOJNOTREGClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure edtDateExit(Sender: TObject);
  private
    { Private declarations }
    //fDocFam : TFamilyID;
    lSaveDNType : TDNType; //для запоминания последнего обработанного переключения. Использутся для настройки контролов ввода параметров
    fSaveEdtNumberText : string;
    fSaveEdtDate : TStDate;
    procedure CheckFlagedMOJNOTREG;
    function pm_GetCurDNType: TDNType;
    procedure pm_SetCurDNType(const Value: TDNType);
  protected
    property CurDNType: TDNType read pm_GetCurDNType write pm_SetCurDNType;
  public
    function Execute({aDocFam : TFamilyID;} aRec : Tl3Tag; WasEmpty : Boolean) : Boolean;
  end;

  function GetAttrDateNum(aRec : Tl3Tag; aRecEmpty : Boolean = False) : boolean;

implementation

{$R *.DFM}

uses
  l3Base,
  l3String,
  l3MinMax,
  vtDialogs,
  //DictsSup,
  DocAttrUtils,
  StrShop,
  AddrSup,
  DT_Serv,
  DT_LinkServ,
  Dt_ReNum, dt_DictConst;

{TDNDictRec = Record
                ID     : Longint;
                Date   : TStDate;
                Num    : TNumberStr;
                Typ    : TDNType;
                Coment : Array[1..70] of Char;
               end;
}


function GetAttrDateNum(aRec : Tl3Tag; aRecEmpty : Boolean = False) : boolean;
begin
 With TDateNumEditorDlg.Create(nil) do
 try
  Result := Execute(aRec, aRecEmpty);
 finally
  Free;
 end;
end;

function TDateNumEditorDlg.Execute(aRec : Tl3Tag; WasEmpty : Boolean) : Boolean;
var
 lDocID : TDocID;
 lRDocID : TDocID;
 lSubID : TSubID;

 begin
  GetDNTypeList(cbDNType.Items);
  cbDNType.Items.Delete(0); // dnDoc - не нужен
  //LoadStringList(cbDNType.Items, NumOfDNStr, sidFirstDataNumRec);

  //fDocFam := aDocFam;
  if not WasEmpty then
  with aRec do
  begin
   //if Date <> BlankDate then
   edtDate.StDate  := IntA[k2_tiStart];
   fSaveEdtDate := edtDate.StDate;
   CurDNType       := TDNType(IntA[k2_tiType]);
   lSaveDNType := CurDNType;
   if CurDNType = dnChangerDate then
   begin
   {$ifdef DBver134}
    lblNumber.Caption := 'Ссылка на изменяющий';
    with Attr[k2_tiLinkAddress] do
     if IsValid then
     begin
      lDocID := IntA[k2_tiDocID];
    if lDocID  > 0 then
     lDocID := LinkServer(CurrentFamily).Renum.GetExtDocID(lDocID);
    if lDocID  > 0 then
      edtNumber.Text  := format('%d.%d', [lDocID, IntA[k2_tiSubID]]);
     end;
   {$else}
    edtNumber.Enabled := false;
   {$endif}
   end
   else
   begin
    lblNumber.Caption := 'Номер';
    edtNumber.Text := StrA[k2_tiNumber];
   end;
  end
  else
  begin
   //aRec.ID := cUndefDictID;
   cbDNType.ItemIndex := 0;
  end;

  cbDNTypeChange(Self);
  edtNumberChange(Self);

  Result := ShowModal = mrOk;
  If Result then
  with aRec do
  begin
   AttrW[k2_tiName, nil] := nil;
   IntA[k2_tiStart]   := StDateToDemon(edtDate.StDate);
   IntA[k2_tiType]    := Ord(CurDNType);

   AttrW[k2_tiLinkAddress, nil] := nil;

   if CurDNType = dnChangerDate then
   begin
   {$ifdef DBver134}
    StrToDocAddr(edtNumber.Text, lDocID, lSubID);
    if lDocID < 0 then lDocID := 0;
    if lSubID < 0 then lSubID := 0;

    if lDocID > 0 then
     lRDocID := Max(LinkServer(CurrentFamily).Renum.ConvertToRealNumber(lDocID), 0)
    else
     lRDocID := 0;

    if lRDocID = 0 then
     lSubID := 0;

    with cAtom(k2_tiLinkAddress) do
    begin
     IntA[k2_tiDocID] := lRDocID;
     IntA[k2_tiSubID] := lSubID;
    end;
   {$endif}
    StrA[k2_tiNumber]  := '';
   end
   else
   begin
    StrA[k2_tiNumber]  := l3MakeSimpleANSIStr(edtNumber.Text);
   end

  end; //with aRec do
end;

procedure TDateNumEditorDlg.cbDNTypeChange(Sender: TObject);
begin
 if lSaveDNType = CurDNType then Exit;

 cbMOJNOTREG.Visible := CurDNType = dnMU;
 if CurDNType = dnChangerDate then
 begin
  {$ifdef DBver134}
  lblNumber.Caption := 'Ссылка на изменяющий';
  {$else}
  edtNumber.Enabled := False;
  {$endif}
  edtNumber.Clear;
 end
 else
 begin
  {$ifndef DBver134}
  edtNumber.Enabled := True;
  {$endif}
  lblNumber.Caption := 'Номер';
  if lSaveDNType = dnChangerDate then
   edtNumber.Text := fSaveEdtNumberText;
   //edtNumber.Clear;
 end;

 if CurDNType in [dnLawCaseNum{, dnAddNum}] then
 begin
  edtDate.Enabled := False;
  lblDate.Enabled := False;
  edtDate.Clear;
 end
 else
 begin
  edtDate.Enabled := True;
  lblDate.Enabled := True;
  edtDate.StDate := fSaveEdtDate;
 end;

 CheckFlagedMOJNOTREG;
 lSaveDNType := CurDNType;
end;

type
 TButtonControlHack = class(TButtonControl)
 public
  property ClicksDisabled;
 end;

procedure TDateNumEditorDlg.CheckFlagedMOJNOTREG;
begin
 TButtonControlHack(cbMOJNOTREG).ClicksDisabled := True;
 try
  cbMOJNOTREG.Checked := (CurDNType = dnMU) and
                         (edtNumber.Text = '') and (edtDate.Date = NullDate);
 finally
  TButtonControlHack(cbMOJNOTREG).ClicksDisabled := False;
 end;
end;

procedure TDateNumEditorDlg.edtNumberChange(Sender: TObject);
begin
 CheckFlagedMOJNOTREG;

 if CurDNType <> dnChangerDate then
  fSaveEdtNumberText := edtNumber.Text;
end;

procedure TDateNumEditorDlg.edtDateExit(Sender: TObject);
begin
 inherited;
 fSaveEdtDate := edtDate.StDate;
end;

procedure TDateNumEditorDlg.edtDateChange(Sender: TObject);
begin
 CheckFlagedMOJNOTREG;
end;

procedure TDateNumEditorDlg.cbMOJNOTREGClick(Sender: TObject);
begin
 If cbMOJNOTREG.Checked
  then
   begin
    edtNumber.Clear;
    edtDate.Clear;
   end;
end;

procedure TDateNumEditorDlg.OKClick(Sender: TObject);
begin
 ModalResult := mrOK;
end;

function TDateNumEditorDlg.pm_GetCurDNType: TDNType;
begin
 Result := TDNType(cbDNType.ItemIndex + 1);
end;

procedure TDateNumEditorDlg.pm_SetCurDNType(const Value: TDNType);
begin
 cbDNType.ItemIndex := Ord(Value) - 1;
end;

end.
