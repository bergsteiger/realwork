unit D_WizIzm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TabBBtnDlg, StdCtrls, vtSpin, ComCtrls, Buttons, ExtCtrls,
  daTypes, DT_Const, Dt_Dict, Mask, vtCombo, vtDateEdit;

type
  TIzmWizardDlg = class(TTabBBtnDlg)
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    stChangingDocName: TStaticText;
    stChangeDocName: TStaticText;
    Label3: TLabel;

    sbChangeDocIDName: TSpeedButton;
    sbChangingDocIDName: TSpeedButton;

    edtChangingDocID: TvtSpinEdit;
    edtChangeDocID: TvtSpinEdit;
    edtOldEditionDocID: TvtSpinEdit;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    edtChangeDate: TvtDateEdit;
    edtChangeName: TEdit;

    procedure edtChangingDocIDExit(Sender: TObject);
    procedure edtChangeDocIDExit(Sender: TObject);
    procedure sbChangingDocIDNameClick(Sender: TObject);
    procedure sbChangeDocIDNameClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
  private
    fFamily : TdaFamilyID;
    function GetChangeDocNum : string;
  public
    function Execute(aFamily : TdaFamilyID) : boolean; reintroduce;
    property ChangeDocNum : String read GetChangeDocNum;
  end;

implementation

{$R *.DFM}

uses
 l3String,
 l3Base, l3DatLst,
 daSchemeConsts,
 dt_AttrSchema,
 DT_Serv, DT_Doc,
 DT_LinkServ,
 l3Date,
 DocIntf,
 DocAttrIntf, DocAttrToolsIntf,
 vtDialogs,
 Main, dt_DictTypes;

function TIzmWizardDlg.Execute(aFamily : TdaFamilyID) : boolean;
 begin
  fFamily := aFamily;
  {edtChangingDocID.Value := 674493;
  edtChangingDocID.Modified := True;
  edtChangingDocIDExit(Self);
  edtChangeDocID.Value   := 12020742;
  edtChangeDocID.Modified := True;
  edtChangeDocIDExit(Self);
  }

  Result := ShowModal = mrOk;
  edtChangeDocIDExit(nil);
 end;

procedure TIzmWizardDlg.edtChangingDocIDExit(Sender: TObject);
 var
  lList : Tl3StringDataList;
  lHasVerlink : boolean;
 begin
  If Not edtChangingDocID.Modified then Exit;
  try
   stChangingDocName.Caption := GetDocName(edtChangingDocID.AsInteger, True, lHasVerlink);

   if lHasVerlink then
   begin
    vtMessageDlg(l3Fmt('Документ #%d имеет полнотекстовую редакцию. Построение кусочной редакции недопустимо!', [edtChangingDocID.AsInteger]),
                 mtWarning);
    edtChangingDocID.AsInteger := 0;
    edtChangingDocID.Modified := False;
    PageCtrl.ActivePage := TabSheet1;
    ActiveControl := edtChangingDocID;
   end;

  except
   stChangingDocName.Caption := 'Документ не найден';
  end;
  edtChangingDocID.Modified := false;
 end;

procedure TIzmWizardDlg.edtChangeDocIDExit(Sender: TObject);
 var
  I           : Integer;
  lList       : Tl3StringDataList;
  lSrcDictRec : TSourDictRec;
  lNum        : ANSIString;
 begin
  If Not edtChangeDocID.Modified then Exit;
  try
   stChangeDocName.Caption := GetDocName(edtChangeDocID.AsInteger, True);
   edtChangeDate.StDate := GetMinPublDate(edtChangeDocID.AsInteger, True, @lNum);
   edtChangeName.Text := lNum;
  except
   stChangeDocName.Caption := 'Документ не найден';
  end;
  edtChangeDocID.Modified := false;
 end;

function TIzmWizardDlg.GetChangeDocNum : string;
 begin
  Result := edtChangeName.Text;
 end;

procedure TIzmWizardDlg.sbChangingDocIDNameClick(Sender: TObject);
 begin
  edtChangingDocIDExit(nil);
 end;

procedure TIzmWizardDlg.sbChangeDocIDNameClick(Sender: TObject);
 begin
  edtChangeDocIDExit(nil);
 end;

procedure TIzmWizardDlg.OKClick(Sender: TObject);
 var
  lRelFlag   : Boolean;
  lDocID     : Longint;
  lDocPresent : Boolean;
 begin
  lDocPresent := False;
  lDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(edtOldEditionDocID.AsInteger);
  If lDocID <> -1 then
  begin
   If DocumentServer(CurrentFamily).CheckDoc(lDocID, True, lRelFlag) then
    lDocPresent := True;
  end;

  If lDocPresent then
  begin
   If (vtMessageDlg(l3Fmt('Документ #%d существует. Хотите добавить старую редакцию в него?',
        [edtOldEditionDocID.AsInteger]), mtConfirmation, [mbYes, mbNo], 0, mbNo, mbNo) <> mrYes) then
   begin
    PageCtrl.ActivePage := TabSheet3;
    ActiveControl := edtOldEditionDocID;
    ModalResult := mrNone;
   end;
  end;
end;

end.
