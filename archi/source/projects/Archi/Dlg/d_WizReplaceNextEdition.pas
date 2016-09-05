unit d_WizReplaceNextEdition;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TabBBtnDlg, StdCtrls, vtSpin, ComCtrls, Buttons, ExtCtrls,
  daTypes, DT_Const, Dt_Dict, Mask, vtCombo, vtDateEdit, BottomBtnDlg;

type
  TReplaceNextEditionDlg = class(TBottomBtnDlg)
    GroupBox2: TGroupBox;
    stChangingDocName: TStaticText;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    Label2: TLabel;
    sbChangeDocIDName: TSpeedButton;
    edtCurEditionDocID: TvtSpinEdit;
    stChangeDocName: TStaticText;
    Panel3: TPanel;
    Label1: TLabel;
    sbChangingDocIDName: TSpeedButton;
    edtNextEditionDocID: TvtSpinEdit;

    procedure edtNextEditionDocIDExit(Sender: TObject);
    procedure edtCurEditionDocIDExit(Sender: TObject);
    procedure sbChangingDocIDNameClick(Sender: TObject);
    procedure sbChangeDocIDNameClick(Sender: TObject);
  private
    fFamily : TdaFamilyID;
    //function GetChangeDocNum : string;

  public
    //ChangingDocType : string;
    //ChangeDocType   : string;
    //ChangeDocSrc    : string;

    procedure SyncroNextEditionDocID;
    procedure SyncroCurEdittionDocID;

    function Execute(aFamily : TdaFamilyID) : boolean; reintroduce;
    //property ChangeDocNum : String read GetChangeDocNum;
  end;

implementation

{$R *.DFM}

uses
 l3Base, l3DatLst, l3String,
 DT_Serv, DT_Doc, DT_Active,
 DictsSup,
 l3Date,
 DocIntf,
 vtDialogs,
 Main, dt_DictTypes;

function TReplaceNextEditionDlg.Execute(aFamily : TdaFamilyID) : boolean;
 begin
  fFamily := aFamily;
  {edtChangingDocID.Value := 674493;
  edtChangingDocID.Modified := True;
  edtChangingDocIDExit(Self);
  edtChangeDocID.Value   := 12020742;
  edtChangeDocID.Modified := True;
  edtChangeDocIDExit(Self);
  }
  if edtNextEditionDocID.AsInteger > 0 then SyncroNextEditionDocID;
  if edtCurEditionDocID.AsInteger > 0 then SyncroCurEdittionDocID;

  Result := ShowModal = mrOk;

  edtCurEditionDocIDExit(nil);
 end;

procedure TReplaceNextEditionDlg.edtNextEditionDocIDExit(Sender: TObject);
 begin
  If edtNextEditionDocID.Modified then SyncroNextEditionDocID;
 end;

procedure TReplaceNextEditionDlg.SyncroNextEditionDocID;
 begin
  if edtNextEditionDocID.AsInteger > 0 then
  try
   stChangingDocName.Caption := GetDocName(edtNextEditionDocID.AsInteger, True{aIsExternalID});
  except
   stChangingDocName.Caption := 'Документ не найден';
  end;
  edtNextEditionDocID.Modified := false;
 end;

procedure TReplaceNextEditionDlg.edtCurEditionDocIDExit(Sender: TObject);
 var
  I           : Integer;
  lList       : Tl3StringDataList;
  lSrcDictRec : TSourDictRec;
  lDate       : TstDate;
 begin
  If edtCurEditionDocID.Modified then SyncroCurEdittionDocID;
 end;

procedure TReplaceNextEditionDlg.SyncroCurEdittionDocID;
 var
  I           : Integer;
  lSrcDictRec : TSourDictRec;
  lDate       : TstDate;
 begin
  if edtCurEditionDocID.AsInteger > 0 then
  try
   stChangeDocName.Caption := GetDocName(edtCurEditionDocID.AsInteger, True{aIsExternalID});
  except
   stChangeDocName.Caption := 'Документ не найден';
  end;
  edtCurEditionDocID.Modified := false;
 end;

procedure TReplaceNextEditionDlg.sbChangingDocIDNameClick(Sender: TObject);
 begin
  edtNextEditionDocIDExit(nil);
 end;

procedure TReplaceNextEditionDlg.sbChangeDocIDNameClick(Sender: TObject);
 begin
  edtCurEditionDocIDExit(nil);
 end;

end.

