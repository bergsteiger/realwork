unit D_WizChangeDoc;

{$I arDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TabBBtnDlg, StdCtrls, vtSpin, ComCtrls, Buttons, ExtCtrls,
  Dt_Types, DT_Const, Dt_Dict, Mask, vtCtrls, vtCombo, vtDateEdit, BottomBtnDlg;

type
  TChangeDocWizardDlg = class(TBottomBtnDlg)
    GroupBox2: TGroupBox;
    stChangingDocName: TStaticText;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    Label2: TLabel;
    sbChangeDocIDName: TSpeedButton;
    edtChangeDocID: TEdit;
    stChangeDocName: TStaticText;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    edtEditionDocID: TvtSpinEdit;
    Panel3: TPanel;
    Label1: TLabel;
    sbChangingDocIDName: TSpeedButton;
    edtChangingDocID: TEdit;
    Label4: TLabel;
    edtChangeDate: TvtDateEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtChangerActivDate: TvtDateEdit;
    rbEditionKindOld: TRadioButton;
    rbEditionKindNext: TRadioButton;
    procedure edtChangingDocIDExit(Sender: TObject);
    procedure edtChangeDocIDExit(Sender: TObject);
    procedure sbChangingDocIDNameClick(Sender: TObject);
    procedure sbChangeDocIDNameClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
  private
    fFamily : TFamilyID;
    function  GetChangingID : Integer;
    procedure SetChangingID(aValue : Integer);
    function  GetChangerID : Integer;
    procedure SetChangerID(aValue : Integer);
    function  GetChangerSubID : Integer;

  public
   {$IfDef InsiderTest}
    g_AllowModal : Integer;
     {-}
   function ShowModal: integer;
     override;
     {-}
   {$IfDef l3HackedVCL}
   function NeedCancelModal: Boolean;
     override;
     {-}
   {$EndIf l3HackedVCL}
  {$EndIf InsiderTest}
    procedure SyncroChangingDocID;
    procedure SyncroChangeDocID;

    function Execute(aFamily : TFamilyID) : boolean; reintroduce;
    property ChangingDocID : Integer read GetChangingID write SetChangingID;
    property ChangerDocID : Integer read GetChangerID write SetChangerID;
    property ChangerSubID : Integer read GetChangerSubID;
  end;

implementation

{$R *.DFM}

uses
 l3Date,
 l3Base,
 l3DatLst,
 l3String,
 l3AFWExceptions,
 l3BatchService,

 dt_AttrSchema,
 dt_DictTypes,
 DT_Serv,
 DT_Doc,
 DT_Active,
 DT_LinkServ,
 DocAttrToolsIntf,
 DocIntf,
 DocAttrIntf,

 vtDialogs,
 Main;

function AsInteger(aEditControl : TEdit) : Integer;
begin
 Result := StrToIntDef(ev_psTrim(ev_psPrefix(aEditControl.Text,'.')), 0)
end;

function TChangeDocWizardDlg.Execute(aFamily : TFamilyID) : boolean;
begin
 fFamily := aFamily;
  {edtChangingDocID.Value := 674493;
  edtChangingDocID.Modified := True;
  edtChangingDocIDExit(Self);
  edtChangeDocID.Value   := 12020742;
  edtChangeDocID.Modified := True;
  edtChangeDocIDExit(Self);
  }
 if AsInteger(edtChangingDocID) > 0 then SyncroChangingDocID;

 {$IfDef InsiderTest}
 g_AllowModal := 0;
 {$EndIf InsiderTest}
 fFamily := aFamily;
 if AsInteger(edtChangeDocID) > 0 then SyncroChangeDocID;
 Result := ShowModal = mrOk;
 if Result then
  edtChangeDocIDExit(nil);
end;

procedure TChangeDocWizardDlg.edtChangingDocIDExit(Sender: TObject);
begin
 If edtChangingDocID.Modified then SyncroChangingDocID;
end;

procedure TChangeDocWizardDlg.SyncroChangingDocID;
begin
 try
  stChangingDocName.Caption := GetDocName(AsInteger(edtChangingDocID), True);
  edtChangingDocID.Modified := false;
 except
  stChangingDocName.Caption := 'Документ не найден';
 end;
end;

procedure TChangeDocWizardDlg.edtChangeDocIDExit(Sender: TObject);
begin
 If edtChangeDocID.Modified then SyncroChangeDocID;
end;

procedure TChangeDocWizardDlg.SyncroChangeDocID;
var
 lDocID : TDocID;
 lDate  : TstDate;

begin
 lDocID := LinkServer(fFamily).Renum.ConvertToRealNumber(AsInteger(edtChangeDocID));

 try
 stChangeDocName.Caption := GetDocName(lDocID);
 except
  stChangeDocName.Caption := 'Документ не найден';
 end;

 edtChangeDate.StDate := GetMinPublDate(lDocID);

 lDate := LinkServer(fFamily).ActiveIntervals.MinDate(lDocID);
 if (lDate > minActiveDate) and (lDate < maxActiveDate) then
  edtChangerActivDate.StDate := lDate;
 edtChangeDocID.Modified := false;
end;

procedure TChangeDocWizardDlg.sbChangingDocIDNameClick(Sender: TObject);
begin
 edtChangingDocIDExit(nil);
end;

procedure TChangeDocWizardDlg.sbChangeDocIDNameClick(Sender: TObject);
begin
 edtChangeDocIDExit(nil);
end;

procedure TChangeDocWizardDlg.OKClick(Sender: TObject);
var
 lRelFlag    : Boolean;
 lDocID      : Longint;
 lDocPresent : Boolean;
begin
 lDocPresent := False;
 if edtEditionDocID.IsEmpty then exit;

 lDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(edtEditionDocID.AsInteger);
 if lDocID <> -1 then
  if DocumentServer(CurrentFamily).CheckDoc(lDocID, True, lRelFlag) then
   lDocPresent := True;
 if lDocPresent then
 begin
  vtMessageDlg(l3Fmt('Документ #%d существует. Выберите другой номер.', [edtEditionDocID.AsInteger]), mtWarning);
  ActiveControl := edtEditionDocID;
  ModalResult := mrNone;
 end; // carChangerActivDateField
end;

function TChangeDocWizardDlg.GetChangingID : Integer;
begin
 Result := AsInteger(edtChangingDocID);
end;

procedure TChangeDocWizardDlg.SetChangingID(aValue : Integer);
begin
 edtChangingDocID.Text := IntToStr(aValue);
end;

function TChangeDocWizardDlg.GetChangerID : Integer;
begin
 Result := AsInteger(edtChangeDocID);
end;

procedure TChangeDocWizardDlg.SetChangerID(aValue : Integer);
begin
 edtChangeDocID.Text := IntToStr(aValue);
end;

function  TChangeDocWizardDlg.GetChangerSubID : Integer;
var
 lStr : AnsiString;
begin
 lStr := ev_psTrim(ev_psSuffix(edtChangeDocID.Text,'.'));
 if Length(lStr) > 0 then
  Result := StrToInt(lStr)
 else
  Result := 0;
end;

{$IfDef InsiderTest}
{$IfDef l3HackedVCL}
function TChangeDocWizardDlg.NeedCancelModal: Boolean;
begin
 Result := False;
 {$IfDef InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
 begin
  if Tl3BatchService.Instance.ExecuteCurrentModalWorker then
  begin
   if (ModalResult = 0) then
   begin
    Result := true;
    Exit;
   end;//ModalResult = 0
  end//seExecuteCurrentModalWorker
  else
  begin
   Result := true;
  end;//seExecuteCurrentModalWorker
 end;//g_BatchMode
 {$EndIf InsiderTest}
end;
{$EndIf l3HackedVCL}

function TChangeDocWizardDlg.ShowModal: integer;
begin
 {$IfDef InsiderTest}
 Assert(g_AllowModal >= 0);
 if Tl3BatchService.Instance.IsBatchMode then
  if (g_AllowModal <= 0) then
   if (Application.MainForm <> nil) then
    if not Tl3BatchService.Instance.HasModalWorker then
     raise El3TryEnterModalState.Create('Здесь надо обрабатывать модальность формы');
 {$EndIf InsiderTest}
 Result := inherited ShowModal;
end;
{$ENDIF InsiderTest}

end.

