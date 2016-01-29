unit uContentCreation;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls,PDFtoolkitUsage, gtPDFClasses, gtCstPDFDoc,
  gtExPDFDoc, gtPDFDoc;

type
  TForm1 = class(TForm)
    pgcntrlContentCreation: TPageControl;
    tbchcontCreationMaskNTexout: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label162: TLabel;
    edInsertBlankPage: TEdit;
    btnInsertBlankPage: TButton;
    edPageWidth: TEdit;
    edPageHeight: TEdit;
    cbBlankMeasure: TComboBox;
    tbshFileAttachment: TTabSheet;
    Label10: TLabel;
    GroupBox12: TGroupBox;
    Label30: TLabel;
    Label32: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    edMasKTop: TEdit;
    edMasKLeft: TEdit;
    edMasKRight: TEdit;
    edMasKBottom: TEdit;
    btnMaskRect: TButton;
    cbMaskPageno: TComboBox;
    GroupBox10: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    btnAddCstInfo: TButton;
    edDocName: TEdit;
    edDocValue: TEdit;
    cbSchema: TComboBox;
    GroupBox2: TGroupBox;
    Label82: TLabel;
    Label83: TLabel;
    Label85: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    mmHTMLText: TMemo;
    edHTMLX: TEdit;
    edHTMLY: TEdit;
    edHTMLPages: TEdit;
    btnTextout: TButton;
    cmHTMLMeasure: TComboBox;
    TabSheet1: TTabSheet;
    GroupBox13: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btnFileAttach: TButton;
    edFileAttach: TEdit;
    btnattachOpn: TButton;
    edAttachName: TEdit;
    cbattachIcon: TComboBox;
    edAttachLeft: TEdit;
    edAttachTop: TEdit;
    edAttachright: TEdit;
    edAttachBottom: TEdit;
    cbAttachmentPageno: TComboBox;
    edPDFfilename: TEdit;
    Label13: TLabel;
    edSavePDFTo: TEdit;
    btnSaveFileName: TButton;
    Label14: TLabel;
    btnLoadPDF: TButton;
    gtPDFDocument1: TgtPDFDocument;
    OpenDialog1: TOpenDialog;
    btnSave: TButton;
    Label36: TLabel;
    btnSelectColor: TButton;
    ColorDialog1: TColorDialog;
    Label15: TLabel;
    btnReset: TButton;
    cbOpenAfterCreate: TCheckBox;
    SaveDialog1: TSaveDialog;
    procedure btnInsertBlankPageClick(Sender: TObject);
    procedure btnLoadPDFClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddCstInfoClick(Sender: TObject);
    procedure btnMaskRectClick(Sender: TObject);
    procedure btnSelectColorClick(Sender: TObject);
    procedure pgcntrlContentCreationChange(Sender: TObject);
    procedure btnTextoutClick(Sender: TObject);
    procedure btnattachOpnClick(Sender: TObject);
    procedure btnFileAttachClick(Sender: TObject);
    procedure btnSaveFileNameClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ResetControls(Sender: TObject);

    
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PopulatePageno(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.btnInsertBlankPageClick(Sender: TObject);
begin
  try
   SetMeasurementUnit(gtPDFDocument1, cbBlankMeasure.ItemIndex);
   InsertBlankPDFPage(gtPDFDocument1, StrToInt(edInsertBlankPage.Text),
     StrToFloat(edPageWidth.Text),StrToFloat(edPageHeight.Text) );
  except
    //
  end;
end;

procedure TForm1.btnLoadPDFClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    gtPDFDocument1.LoadFromFile(OpenDialog1.FileName);
    edPDFfilename.Text := OpenDialog1.FileName;
    PopulatePageno(cbMaskPageno);
    cbMaskPageno.ItemIndex := 0;
    PopulatePageno(cbAttachmentPageno);
    cbAttachmentPageno.ItemIndex := 0;
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

procedure TForm1.btnAddCstInfoClick(Sender: TObject);
begin
  AddCustomPDFInfo(gtPDFDocument1, edDocName.Text, edDocValue.Text, cbSchema.ItemIndex);
end;

procedure TForm1.btnMaskRectClick(Sender: TObject);
var
  LRect: TRect;
begin
  if Assigned(gtPDFDocument1) then
  begin
    
    {Mask an area in the PDF}
    LRect.Top := StrToInt(Trim(edMasKTop.Text));
    LRect.Left := StrToInt(Trim(edMasKLeft.Text));
    LRect.Right := StrToInt(Trim(edMasKRight.Text));
    LRect.Bottom := StrToInt(Trim(edMasKBottom.Text));
    MaskRectPDF(gtPDFDocument1, LRect, ColorDialog1.Color,cbMaskPageno.ItemIndex + 1);
  end;
end;

procedure TForm1.btnSelectColorClick(Sender: TObject);
begin
 ColorDialog1.Execute;
end;

procedure TForm1.pgcntrlContentCreationChange(Sender: TObject);
begin
  PopulatePageno(cbMaskPageno);
  cbMaskPageno.ItemIndex := 0;
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

procedure TForm1.btnTextoutClick(Sender: TObject);
begin
  SetMeasurementUnit(gtPDFDocument1, cmHTMLMeasure.ItemIndex);
  AddHTMLText(gtPDFDocument1,StrToFloat(edHTMLX.Text), StrToFloat(edHTMLY.Text), mmHTMLText.Text, edHTMLPages.Text);
end;

procedure TForm1.btnattachOpnClick(Sender: TObject);
begin
  OpenDialog1.Execute;
  edFileAttach.Text := OpenDialog1.FileName;
end;

procedure TForm1.btnFileAttachClick(Sender: TObject);
begin
  try
    if Assigned(gtPDFDocument1) then
    begin
      AddFileAttachment(gtPDFDocument1,edFileAttach.Text, edAttachName.Text,StrToFloat(edAttachLeft.Text),
       StrToFloat(edAttachTop.Text),StrToFloat(edAttachright.Text), StrToFloat(edAttachBottom.Text),
       cbattachIcon.ItemIndex,cbAttachmentPageno.ItemIndex + 1);
    end;
  except
    //
  end;
end;

procedure TForm1.btnSaveFileNameClick(Sender: TObject);
begin
  SaveDialog1.Execute;
  edSavePDFTo.Text := SaveDialog1.FileName;  
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  cbMaskPageno.Clear;
  cbAttachmentPageno.Clear;
  ResetControls(Form1);
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
  edSavePDFTo.Text := 'C:\Output.pdf';
  edPDFfilename.Text := '';
end;

end.
