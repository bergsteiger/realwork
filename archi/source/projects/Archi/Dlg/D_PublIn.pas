unit D_PublIn;

{ $Id: D_PublIn.pas,v 1.26 2014/08/13 12:50:00 dinishev Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask,
  k2Interfaces, k2Tags,
  DT_Types, DT_Const, dt_AttrSchema, DT_Dict,
  BottomBtnDlg, ToolEdit, tb97GraphicControl, TB97Ctls, vtSpeedButton,
  ActnList,
  
  l3Variant
  ;

type
  TPublishedInEditDlg = class(TBottomBtnDlg)
    Label3: TLabel;
    edtPageNumbers: TEdit;
    Label4: TLabel;
    edtComment: TEdit;
    Bevel4: TBevel;
    Label7: TLabel;
    lblPubSource: TLabel;
    ActionList1: TActionList;
    acAddIssueImage: TAction;
    vtSpeedButton1: TvtSpeedButton;
    cbClone: TCheckBox;
    procedure acAddIssueImageExecute(Sender: TObject);
  private
   fRec : Il3TagRef; //PPublishDataRec;
   fDocID : TDocID;
   procedure CheckImageIcon;

  public
    function Execute(const aPubSourceName : AnsiString; aRec : Tl3Tag; aDocID : TDocID) : Boolean; reintroduce;
  end;

function RunPublishedInEditDlg(aOwner: TComponent; const aPubSourceName : AnsiString; aRec : Tl3Tag; aDocID : TDocID): Boolean;

implementation
{$R *.DFM}
 uses
  l3Base, l3Tree, l3Nodes, l3Tree_TLB, l3Date, l3String, l3IniFile,
  l3FileUtils,
  IniShop, StrShop, ResShop,
  vtDialogs,
  DT_DocImages,
  DictMetaForm, TreeDWin, D_ShowInfo,
  arInterfaces;

function RunPublishedInEditDlg(aOwner: TComponent; const aPubSourceName : String; aRec : Tl3Tag; aDocID : TDocID): Boolean;
 begin
 with TPublishedInEditDlg.Create(aOwner) do
  try
   Result := Execute(aPubSourceName, aRec, aDocID);
  finally
   Free;
  end;
end;

function TPublishedInEditDlg.Execute(const aPubSourceName : AnsiString; aRec : Tl3Tag; aDocID : TDocID) : Boolean;
 begin
  fDocID := aDocID;
  fRec := aRec.AsRef;
  with aRec do
  begin
   edtPageNumbers.Text := StrA[k2_tiPages];
   edtComment.Text := StrA[k2_tiLinkComment];
   cbClone.Checked := (IntA[k2_tiFlags] and pinfClone) > 0;
   lblPubSource.Caption := aPubSourceName;
  end;
  ActionList1.Images := ArchiResources.CommonImageList;
  //acAddIssueImage.Enabled := not fNonPeriodic;
  CheckImageIcon;

  Result := ShowModal = mrOk;

  if Result then
   with aRec do
   begin
    AttrW[k2_tiName, nil] := nil;
    StrA[k2_tiPages] := edtPageNumbers.Text;
    StrA[k2_tiLinkComment] := edtComment.Text;
    if cbClone.Checked then
     IntA[k2_tiFlags]  := IntA[k2_tiFlags]  or pinfClone
    else
     IntA[k2_tiFlags] := IntA[k2_tiFlags] and not pinfClone;
   end;
 end;

procedure TPublishedInEditDlg.CheckImageIcon;
begin
 try
  with fRec.AsObject do
   if DocImageServer.IsImageExists(Attr[k2_tiSource].IntA[k2_tiHandle], IntA[k2_tiStart], IntA[k2_tiFinish],
                    StrA[k2_tiNumber], not BoolA[k2_tiIsPeriodic], fDocID) then

   //if DocImageServer.IsImageExists(fRec) then
    acAddIssueImage.ImageIndex := picSrcCheck
   else
    acAddIssueImage.ImageIndex := picPublishSrc;
 except
  acAddIssueImage.ImageIndex := picPublishSrc;
 end;
end;

procedure TPublishedInEditDlg.acAddIssueImageExecute(Sender: TObject);
var
 lFileName: AnsiString;
begin
 UserConfig.Section := PrefSectName;
 lFileName := UserConfig.ReadParamStrDef('ImageOpenInitialDir','');
 if vtExecuteOpenDialog(lFileName, sidDocImageDlgFilter) then
 begin
  try
   with fRec.AsObject do
    DocImageServer.AddImageFile(lFileName, Attr[k2_tiSource].IntA[k2_tiHandle], IntA[k2_tiStart], IntA[k2_tiFinish],
                                           StrA[k2_tiNumber], not BoolA[k2_tiIsPeriodic], fDocID);
  except
   On E : Exception do
   begin
    Application.ShowException(E);
    Exit;
   end;
  end;
  UserConfig.WriteParamStr('ImageOpenInitialDir',ExtractDirName(lFileName)+'\');
 end;

 CheckImageIcon;
end;

end.
