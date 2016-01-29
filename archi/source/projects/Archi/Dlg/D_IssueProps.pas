unit D_IssueProps;

{ $Id: D_IssueProps.pas,v 1.15 2013/04/19 13:05:03 lulin Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask,
  l3Date,
  DT_Types, DT_Const, DT_Dict,
  BottomBtnDlg, ToolEdit, vtCombo, vtDateEdit, ActnList,
  tb97GraphicControl, TB97Ctls, vtSpeedButton, dt_DictTypes;

type
  TGetIssuePropsDlg = class(TBottomBtnDlg)
    edtDate1: TvtDateEdit;
    edtDate2: TvtDateEdit;
    edtNumber: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    lblPubSource: TLabel;
    Label6: TLabel;
    Bevel3: TBevel;
    Label7: TLabel;
    Bevel4: TBevel;
    ActionList1: TActionList;
    acAddIssueImage: TAction;
    vtSpeedButton1: TvtSpeedButton;
    Bevel5: TBevel;
    Label1: TLabel;
    edtComment: TEdit;
    procedure edtDate2Enter(Sender: TObject);
    procedure acAddIssueImageExecute(Sender: TObject);
  private
    { Private declarations }
    fDocFam : TFamilyID;
    fSourID : TDictID;
    fOrigIssueRec : PPublishedDictRec;
    fNonPeriodic : Boolean;

    procedure CheckImageIcon(aEnabled : boolean);
  public
    function Execute(aDocFamily: TFamilyID; const aPubSource : AnsiString; aSourceNonPeriodic : boolean;
                     aIssueRec : PPublishedDictRec; aWasEmpty: Boolean): Boolean;
  end;

function RunGetIssuePropsDlg(aOwner: TComponent; aDocFamily : TFamilyID;
                             const aPubSource : AnsiString; aSourceNonPeriodic : boolean;
                             aIssueRec : PPublishedDictRec; aWasEmpty : Boolean): Boolean;

implementation

{$R *.DFM}

uses
  l3String, l3Tree, l3Nodes,
  l3TreeInterfaces, l3Tree_TLB,
  l3IniFile, l3FileUtils,
  vtDialogs,
  DT_DocImages,
  IniShop, StrShop, ResShop,
  DictMetaForm, TreeDWin;

(*
PPublishedDictRec = ^TPublishedDictRec;
TPublishedDictRec = Record
                       ID     : Longint;
                       Sour   : TDictID;
                       SDate  : TStDate;
                       EDate  : TStDate;
                       Num    : Word;
                       Coment : Array[1..70] of Char;
                      end;
*)

procedure TGetIssuePropsDlg.CheckImageIcon(aEnabled : boolean);
begin
 with fOrigIssueRec^ do
  if aEnabled and DocImageServer.IsImageExists(Sour, SDate, EDate, l3ArrayToString(Num, SizeOf(Num)), fNonPeriodic) then
   acAddIssueImage.ImageIndex := picSrcCheck
  else
   acAddIssueImage.ImageIndex := picPublishSrc;
end;

function TGetIssuePropsDlg.Execute(aDocFamily: TFamilyID; const aPubSource : AnsiString; aSourceNonPeriodic : boolean; aIssueRec : PPublishedDictRec; aWasEmpty: Boolean): Boolean;
 var
  lSDate : TstDate;
  lEDate : TstDate;
 begin
  fOrigIssueRec := aIssueRec;
  fNonPeriodic := aSourceNonPeriodic;
  fDocFam := aDocFamily;
  lblPubSource.Caption := aPubSource;

  with aIssueRec^ do
   if not aWasEmpty then
   begin
    edtDate1.StDate := SDate;
    edtDate2.StDate := EDate;
    edtNumber.Text  := l3ArrayToString(Num, SizeOf(Num));
    edtComment.Text  := l3ArrayToString(Comment, SizeOf(Comment));
   end
   else
    l3StringToArray(Comment, SizeOf(Comment), '');

  ActionList1.Images := ArchiResources.CommonImageList;
  acAddIssueImage.Enabled := not fNonPeriodic;
  CheckImageIcon(not (aWasEmpty or fNonPeriodic));

  Result := ShowModal = mrOk;

  if Result then
   with aIssueRec^ do
   begin
    Result := False;
    lSDate := StDateToDemon(edtDate1.StDate);
    lEDate := StDateToDemon(edtDate2.StDate);
    If lEDate = BlankDate then
     lEDate := lSDate
    else
     If lSDate = BlankDate then
      lSDate := lEDate;

    if SDate <> lSDate then
    begin
     SDate := lSDate;
     Result := True;
    end;

    if EDate <> lEDate then
    begin
     EDate := lEDate;
     Result := True;
    end;

    if l3ArrayToString(Num, SizeOf(Num)) <> edtNumber.Text then
    begin
     l3StringToArray(Num, SizeOf(Num), edtNumber.Text);
     Result := True;
    end;

    if l3ArrayToString(Comment, SizeOf(Comment)) <> edtComment.Text then
    begin
     l3StringToArray(Comment, SizeOf(Comment), edtComment.Text);
     Result := True;
    end;
   end;
 end;

procedure TGetIssuePropsDlg.edtDate2Enter(Sender: TObject);
begin
 if (edtDate2.Date = NullDate) and (edtDate1.Date <> NullDate) then
  edtDate2.Date := edtDate1.Date;
end;

procedure TGetIssuePropsDlg.acAddIssueImageExecute(Sender: TObject);
var
 lFileName: AnsiString;
begin
 UserConfig.Section := PrefSectName;
 lFileName := UserConfig.ReadParamStrDef('ImageOpenInitialDir','');
 if vtExecuteOpenDialog(lFileName, sidDocImageDlgFilter) then
 begin
  try
   with fOrigIssueRec^ do
    DocImageServer.AddImageFile(lFileName, Sour, SDate, EDate, l3ArrayToString(Num, SizeOf(Num)), fNonPeriodic);
  except
   On E : Exception do
   begin
    Application.ShowException(E);
    Exit;
   end;
  end;
  UserConfig.WriteParamStr('ImageOpenInitialDir',ExtractDirName(lFileName)+'\');
 end;

 CheckImageIcon(not fNonPeriodic);
end;

function RunGetIssuePropsDlg(aOwner: TComponent; aDocFamily : TFamilyID;
                             const aPubSource : AnsiString; aSourceNonPeriodic : boolean;
                             aIssueRec : PPublishedDictRec; aWasEmpty : Boolean): Boolean;
begin
 with TGetIssuePropsDlg.Create(aOwner) do
  try
   Result := Execute(aDocFamily, aPubSource, aSourceNonPeriodic, aIssueRec, aWasEmpty);
  finally
   Free;
  end;
end;

end.
