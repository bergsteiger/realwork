unit uDocProperties;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, PDFtoolkitUsage, gtPDFClasses, gtCstPDFDoc,
  gtExPDFDoc, gtPDFDoc, gtPDFUtils;

type
  TForm1 = class(TForm)
    pgcntrlDocProp: TPageControl;
    tbshPageProp: TTabSheet;
    gbPageAttrib: TGroupBox;
    lMediaBox: TLabel;
    lCropbox: TLabel;
    lPageNo: TLabel;
    btnGetMediaNCrop: TButton;
    edMediaY: TEdit;
    edMediaX: TEdit;
    edMediaW: TEdit;
    edMediaH: TEdit;
    edCropY: TEdit;
    edCropX: TEdit;
    edCropW: TEdit;
    edCropH: TEdit;
    btnSetCropBox: TButton;
    cbCropPageno: TComboBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label17: TLabel;
    edPageWidth: TEdit;
    edHeight: TEdit;
    btnGetPagesize: TButton;
    cbPageSizeMeasurement: TComboBox;
    cbPageSizePgeNo: TComboBox;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    btnSetPageRotate: TButton;
    cbRotateAngle: TComboBox;
    cbSetPageRotPageNo: TComboBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label15: TLabel;
    edTotalPage: TEdit;
    edPDFversion: TEdit;
    GroupBox8: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    edAngle: TEdit;
    btnPagerotate: TButton;
    cbGetRotatePageNo: TComboBox;
    tbshDocInfo: TTabSheet;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edAuthor: TEdit;
    edProducer: TEdit;
    edCreator: TEdit;
    edCreateDate: TEdit;
    edModDate: TEdit;
    EdTitle: TEdit;
    edSubject: TEdit;
    edKeyword: TEdit;
    btnGetinfo: TButton;
    btnSetInfo: TButton;
    tbshOthers: TTabSheet;
    GroupBox14: TGroupBox;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label20: TLabel;
    btnSetPageTransition: TButton;
    cbTransitionEffect: TComboBox;
    edPageTranRange: TEdit;
    edTransDuration: TEdit;
    GroupBox5: TGroupBox;
    mmXMLMetadata: TMemo;
    btnXMLMatadata: TButton;
    GroupBox6: TGroupBox;
    Label16: TLabel;
    labelPageAlyout: TLabel;
    cbPagemode: TComboBox;
    cbPageLayout: TComboBox;
    btnSetPageModeLayout: TButton;
    tbshViewerPref: TTabSheet;
    GroupBox7: TGroupBox;
    chkHideToolbar: TCheckBox;
    chkHideMenubar: TCheckBox;
    chkHideWindowUI: TCheckBox;
    chkFitWindow: TCheckBox;
    chkCenterWindow: TCheckBox;
    chkDisplayDocTitle: TCheckBox;
    btnSetViewerPref: TButton;
    Label21: TLabel;
    Label22: TLabel;
    Label75: TLabel;
    edPDFfilename: TEdit;
    edSavePDFTo: TEdit;
    btnSaveFileName: TButton;
    btnLoadPDF: TButton;
    gtPDFDocument1: TgtPDFDocument;
    OpenDialog1: TOpenDialog;
    btnSave: TButton;
    cbOpenAfterCreate: TCheckBox;
    btnReset: TButton;
    SaveDialog1: TSaveDialog;
    btnSetMediaBox: TButton;
    procedure btnGetMediaNCropClick(Sender: TObject);
    procedure btnGetPagesizeClick(Sender: TObject);
    procedure btnSetPageRotateClick(Sender: TObject);
    procedure btnPagerotateClick(Sender: TObject);
    procedure btnGetinfoClick(Sender: TObject);
    procedure btnSetInfoClick(Sender: TObject);
    procedure btnSetPageTransitionClick(Sender: TObject);
    procedure btnXMLMatadataClick(Sender: TObject);
    procedure btnSetPageModeLayoutClick(Sender: TObject);
    procedure btnLoadPDFClick(Sender: TObject);
    procedure btnSaveFileNameClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSetViewerPrefClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ResetControls(Sender: TObject);
    procedure btnSetMediaBoxClick(Sender: TObject);
    procedure btnSetCropBoxClick(Sender: TObject);
    
  private
    { Private declarations }
  public
    procedure PopulatePageno(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnGetMediaNCropClick(Sender: TObject);
var
  LRect: TgtRect;
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.MeasurementUnit := muPoints;
    LRect := GetPDFPageMediaBox(gtPDFDocument1,cbCropPageno.ItemIndex + 1);
    edMediaX.Text :=  FloatToStr(LRect.Left);
    edMediaY.Text :=  FloatToStr(LRect.Top);
    edMediaW.Text :=  FloatToStr(LRect.Right);
    edMediaH.Text :=  FloatToStr(LRect.Bottom);

    LRect := GetPDFPageCropBox(gtPDFDocument1, cbCropPageno.ItemIndex + 1);
    edCropX.Text :=  FloatToStr(LRect.Left);
    edCropY.Text :=  FloatToStr(LRect.Top);
    edCropW.Text :=  FloatToStr(LRect.Right);
    edCropH.Text :=  FloatToStr(LRect.Bottom);
  end;
end;

procedure TForm1.btnGetPagesizeClick(Sender: TObject);
var
  LPageSize: TgtPageSize;
begin
  if Assigned(gtPDFDocument1) then
  begin
    {Set Page rotation}
    LPageSize := GetPDFPagesize(gtPDFDocument1,cbPageSizePgeNo.ItemIndex + 1,cbPageSizeMeasurement.ItemIndex);
    edPageWidth.Text := FloatToStr(LPageSize.Width);
    edHeight.Text := FloatToStr(LPageSize.Height);
  end;
end;

procedure TForm1.btnSetPageRotateClick(Sender: TObject);
begin
  {Set Page rotation}
  SetPageRotation(gtPDFDocument1,cbRotateAngle.ItemIndex,IntToStr(cbSetPageRotPageNo.ItemIndex + 1));
end;

procedure TForm1.btnPagerotateClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    {Gets the rotation angle of the page specified}
    edAngle.Text := IntToStr(GetPageRotation(gtPDFDocument1,cbGetRotatePageNo.ItemIndex + 1));
  end;
end;

procedure TForm1.btnGetinfoClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    with gtPDFDocument1.DocInfo do
    begin
       edAuthor.Text := Author;
       edProducer.Text := Producer;
       edCreator.Text := Creator;
       edCreateDate.Text := CreationDate;
       edModDate.Text := ModDate;
       EdTitle.Text := Title;
       edKeyword.Text := Keywords;
       edSubject.Text := Subject;
    end;
  end;
end;

procedure TForm1.btnSetCropBoxClick(Sender: TObject);
var
  LRect: TgtRect;
begin
  gtPDFDocument1.MeasurementUnit := muPoints;
  LRect.Left := StrToFloat(edCropX.Text);
  LRect.Top := StrToFloat(edCropY.Text);
  LRect.Right := StrToFloat(edCropW.Text);
  LRect.Bottom := StrToFloat(edCropH.Text);
  SetPageCrop(gtPDFDocument1,LRect, IntToStr(cbCropPageno.ItemIndex + 1));
end;

procedure TForm1.btnSetInfoClick(Sender: TObject);
begin
  SetDocInfo(gtPDFDocument1, edAuthor.Text, edCreator.Text, edCreateDate.Text, edModDate.Text,
    EdTitle.Text, edKeyword.Text, edSubject.Text);
end;

procedure TForm1.btnSetMediaBoxClick(Sender: TObject);
var
  LRect: TgtRect;
begin
  {Set Page media }
  gtPDFDocument1.MeasurementUnit := muPoints;
  LRect.Left := StrToFloat(edMediaX.Text);
  LRect.Top := StrToFloat(edMediaY.Text);
  LRect.Right := StrToFloat(edMediaW.Text);
  LRect.Bottom := StrToFloat(edMediaH.Text);
  SetPageMedia(gtPDFDocument1,LRect,IntToStr(cbCropPageno.ItemIndex + 1));
end;

procedure TForm1.btnSetPageTransitionClick(Sender: TObject);
begin
  {Set the Page Transition effect}
  SetPDFPageTransitionEffect(gtPDFDocument1,Trim(edPageTranRange.Text),StrToInt(Trim(edTransDuration.Text)),
    TgtTransitionEffect(cbTransitionEffect.ItemIndex));
end;

procedure TForm1.btnXMLMatadataClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    {Get XMLMetadata fro mthe document}
    mmXMLMetadata.Text := GetPageXMLMetadata(gtPDFDocument1);
  end;
end;

procedure TForm1.btnSetPageModeLayoutClick(Sender: TObject);
begin
  SetPagemode(gtPDFDocument1,cbPagemode.ItemIndex);
  SetPageLayout(gtPDFDocument1, cbPageLayout.ItemIndex);
end;

procedure TForm1.btnLoadPDFClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    cbOpenAfterCreate.Checked := True;
    gtPDFDocument1.LoadFromFile(OpenDialog1.FileName);
    edPDFfilename.Text := OpenDialog1.FileName;
    PopulatePageno(cbCropPageno);
    cbCropPageno.ItemIndex := 0;
    PopulatePageno(cbPageSizePgeNo);
    cbPageSizePgeNo.ItemIndex := 0;
    PopulatePageno(cbSetPageRotPageNo);
    cbSetPageRotPageNo.ItemIndex := 0;
    PopulatePageno(cbGetRotatePageNo);
    cbGetRotatePageNo.ItemIndex := 0;
    edTotalPage.Text := IntToStr(gtPDFDocument1.PageCount);
    edPDFversion.Text :=  GetPDFVersion(gtPDFDocument1);
  end;
end;

procedure TForm1.btnSaveFileNameClick(Sender: TObject);
begin
   if SaveDialog1.Execute then
  begin
    edSavePDFTo.Text := SaveDialog1.FileName;
  end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  if (cbOpenAfterCreate.Checked) then
    gtPDFDocument1.OpenAfterSave := True
  else
    gtPDFDocument1.OpenAfterSave := False;
  gtPDFDocument1.SaveToFile(edSavePDFTo.Text);
  edPDFfilename.Text := '';
  btnResetClick(Self);
end;

procedure TForm1.PopulatePageno(Sender: TObject);
var
  Li: Integer;
begin
  if (Sender is TComboBox) then
  begin
    (Sender as TComboBox).Clear;
    for Li := 0 to gtPDFDocument1.PageCount - 1 do
    begin
      (Sender as TComboBox).Items.Add(IntToStr(Li + 1));
    end;
  end;
end;

procedure TForm1.btnSetViewerPrefClick(Sender: TObject);
begin
  SetViewerPreference(gtPDFDocument1, chkHideToolbar.Checked, chkHideMenubar.Checked,
    chkHideWindowUI.Checked, chkFitWindow.Checked, chkCenterWindow.Checked,
    chkDisplayDocTitle.Checked);
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  cbCropPageno.Clear;
  cbPageSizePgeNo.Clear;
  cbSetPageRotPageNo.Clear;
  cbGetRotatePageNo.Clear;
  ResetControls(Form1);
  edSavePDFTo.Text := 'C:\Output.pdf'; 
end;

procedure TForm1.ResetControls(Sender: TObject);
var
  cntrlCnt: Integer;
begin
  if (Sender is TWinControl) then
  begin
    for cntrlCnt := 0 to TWinControl(Sender).ControlCount - 1 do
    begin
      if TWinControl(Sender).ContainsControl(TWinControl(Sender).Controls[cntrlCnt]) then
      begin
        ResetControls(TWinControl(Sender).Controls[cntrlCnt]);
      end;
      if (TWinControl(Sender).Controls[cntrlCnt] is TEdit) then
        (TWinControl(Sender).Controls[cntrlCnt] As TEdit).Text := ''
      else if (TWinControl(Sender).Controls[cntrlCnt] is TCheckBox) then
        (TWinControl(Sender).Controls[cntrlCnt] As TCheckBox).Checked := False
      else if (TWinControl(Sender).Controls[cntrlCnt] is TComboBox) then
        (TWinControl(Sender).Controls[cntrlCnt] As TComboBox).ItemIndex := 0;
    end;
  end;
end;

end.
