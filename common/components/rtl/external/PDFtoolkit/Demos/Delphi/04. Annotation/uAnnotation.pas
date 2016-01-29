unit uAnnotation;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc, gtPDFDoc,
  StdCtrls, Spin, ExtCtrls, ComCtrls, PDFtoolkitUsage;

type

  TAnnotationSelection = (atTextAnnot, atFreeTextAnnot, atLinkAnnot, atLineAnnot,
                          atCircleAnnot, atSquareAnnot, atStampAnnot, atMarkupAnnot,
                          atCaretAnnot, atPolygonAnnot, atPolylineAnnot, atInkAnnot);

  TForm1 = class(TForm)
    Label13: TLabel;
    Label75: TLabel;
    Label14: TLabel;
    edPDFfilename: TEdit;
    btnLoadPDF: TButton;
    edSavePDFTo: TEdit;
    btnSaveFileName: TButton;
    btnSave: TButton;
    gtPDFDocument1: TgtPDFDocument;
    OpenDialog1: TOpenDialog;
    pgncntrlEnhancement: TPageControl;
    tbshAnnot: TTabSheet;
    Label98: TLabel;
    Label112: TLabel;
    rgrpAnnotation: TRadioGroup;
    btnAddAnnotation: TButton;
    PageCtrlAnnotate: TPageControl;
    tbshTextannot: TTabSheet;
    Label206: TLabel;
    Label207: TLabel;
    Label208: TLabel;
    Label209: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    Label215: TLabel;
    Label216: TLabel;
    Label217: TLabel;
    Label218: TLabel;
    edTextannotLeft: TEdit;
    edTextannotTop: TEdit;
    edTextannotRight: TEdit;
    edTextannotBottom: TEdit;
    edTextannotName: TEdit;
    edTextannotTitle: TEdit;
    edTextannotContents: TEdit;
    spedTextannotBwidth: TSpinEdit;
    cbTextannotPageno: TComboBox;
    chkTextannotOpen: TCheckBox;
    spedTextannotVCR: TSpinEdit;
    spedTextannotHCR: TSpinEdit;
    tbshFreeTextAnnot: TTabSheet;
    Label219: TLabel;
    Label220: TLabel;
    Label221: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    Label224: TLabel;
    Label226: TLabel;
    Label228: TLabel;
    Label229: TLabel;
    Label230: TLabel;
    edFreeAnnotLeft: TEdit;
    edFreeAnnotTop: TEdit;
    edFreeAnnotContents: TEdit;
    edFreeAnnotTitle: TEdit;
    edFreeAnnotBottom: TEdit;
    edFreeAnnotRight: TEdit;
    edFreeAnnotName: TEdit;
    spedFreeBWidth: TSpinEdit;
    cbFreeAnnotPageno: TComboBox;
    cbFreeAnnotAlign: TComboBox;
    tbshLinkAnnot: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Name: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    edLinkLeft: TEdit;
    edLinkRight: TEdit;
    edLinkBottom: TEdit;
    edLinkTop: TEdit;
    edLinkTitle: TEdit;
    edLinkURIAction: TEdit;
    edLinkName: TEdit;
    cbLinkPageno: TComboBox;
    spedLinkBorderwidth: TSpinEdit;
    tbshLineAnnot: TTabSheet;
    Label100: TLabel;
    Label101: TLabel;
    Label105: TLabel;
    Label104: TLabel;
    Label106: TLabel;
    Label103: TLabel;
    Label111: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    edAnnotLineY1: TEdit;
    edAnnotLineY2: TEdit;
    edAnnotLineContents: TEdit;
    edAnnotLineName: TEdit;
    edAnnotLinetitle: TEdit;
    edAnnotLineX1: TEdit;
    edAnnotLineX2: TEdit;
    cbLineAnnotPageno: TComboBox;
    spedLineAnnotBorderwidth: TSpinEdit;
    tbshCircleAnnot: TTabSheet;
    Label113: TLabel;
    Label114: TLabel;
    Label116: TLabel;
    Label115: TLabel;
    Label121: TLabel;
    Label117: TLabel;
    Label131: TLabel;
    edtcircleLeft: TEdit;
    edtCircleTop: TEdit;
    edtCircleBottom: TEdit;
    edtCircleRight: TEdit;
    ChkCircleCloudy: TCheckBox;
    edtCircleAnnotContents: TEdit;
    spedCirclannotIntensity: TSpinEdit;
    cbCircleAnnotPageno: TComboBox;
    tbshSquareannot: TTabSheet;
    Label122: TLabel;
    Label125: TLabel;
    Label124: TLabel;
    Label126: TLabel;
    Label123: TLabel;
    Label127: TLabel;
    Label132: TLabel;
    edtSqAnnotLeft: TEdit;
    edtSqAnnotRight: TEdit;
    edtSqAnnotTop: TEdit;
    edtSqAnnotBottom: TEdit;
    edtSqAnnotContents: TEdit;
    cbSqAnnotCloudy: TCheckBox;
    spedSquareIntensity: TSpinEdit;
    cbSquareAnnotPageno: TComboBox;
    tbshStampAnnot: TTabSheet;
    Label183: TLabel;
    Label184: TLabel;
    Label185: TLabel;
    Label186: TLabel;
    Label187: TLabel;
    Label188: TLabel;
    Label190: TLabel;
    Label192: TLabel;
    Label193: TLabel;
    Label194: TLabel;
    edStampAnnotLeft: TEdit;
    edStampAnnotTop: TEdit;
    edStampAnnotContents: TEdit;
    edStampAnnotTitle: TEdit;
    edStampAnnotBottom: TEdit;
    edStampAnnotRight: TEdit;
    edStampAnnotStampName: TEdit;
    spedStampAnnotBWidth: TSpinEdit;
    cbStampAnnotPageno: TComboBox;
    cbStampAnnotBStyle: TComboBox;
    tbshMarkupannot: TTabSheet;
    Label195: TLabel;
    Label196: TLabel;
    Label197: TLabel;
    Label198: TLabel;
    Label199: TLabel;
    Label200: TLabel;
    Label201: TLabel;
    Label203: TLabel;
    Label204: TLabel;
    Label205: TLabel;
    edMarkAnnotLeft: TEdit;
    edMarkAnnotTop: TEdit;
    edMarkAnnotBottom: TEdit;
    edMarkAnnotRight: TEdit;
    edMarkAnnotContents: TEdit;
    edMarkAnnotTitle: TEdit;
    edMarkAnnotName: TEdit;
    spedMarkAnnotBWidth: TSpinEdit;
    cbMarkAnnotPageno: TComboBox;
    edMarkAnnotx1: TEdit;
    edMarkAnnotY4: TEdit;
    edMarkAnnotx4: TEdit;
    edMarkAnnotY3: TEdit;
    edMarkAnnotX3: TEdit;
    edMarkAnnotY2: TEdit;
    edMarkAnnotX2: TEdit;
    edMarkAnnotY1: TEdit;
    tbshCaretannot: TTabSheet;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label94: TLabel;
    edCaretAnnotLeft: TEdit;
    edCaretAnnotTop: TEdit;
    edCaretAnnotBottom: TEdit;
    edCaretAnnotright: TEdit;
    edCaretAnnotTitle: TEdit;
    edCaretAnnotContents: TEdit;
    edCaretAnnotName: TEdit;
    cbCaretSymbol: TComboBox;
    cbCaretAnnotPageno: TComboBox;
    spedCaretAnnotBorderwidth: TSpinEdit;
    tbshPolygonannot: TTabSheet;
    Label12: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label138: TLabel;
    edPolygonLeft: TEdit;
    edPolygontop: TEdit;
    edPolygonBottom: TEdit;
    edPolygonRight: TEdit;
    edPolygonTitle: TEdit;
    edPolygonName: TEdit;
    chkIsCloudy: TCheckBox;
    edPolygonContents: TEdit;
    edPolygonVertices: TEdit;
    cbPolygonAnnotPageno: TComboBox;
    spedPolygonAnnotBorderwidth: TSpinEdit;
    spedIntensity: TSpinEdit;
    tbshPolylineannot: TTabSheet;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label139: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    edPolylineAnnotLeft: TEdit;
    edPolylineAnnotTop: TEdit;
    edPolylineAnnotRight: TEdit;
    edPolylineAnnotBottom: TEdit;
    edPolylineAnnotTitle: TEdit;
    edPolylineAnnotContents: TEdit;
    edPolylineAnnotName: TEdit;
    edpolylineVertices: TEdit;
    spedPolylineAnnotBorderWidth: TSpinEdit;
    cbPolylineannotPageno: TComboBox;
    tbshInkannot: TTabSheet;
    Label174: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    Label225: TLabel;
    Label231: TLabel;
    Label232: TLabel;
    edInkAnnotLeft: TEdit;
    edInkAnnotTop: TEdit;
    edInkAnnotBottom: TEdit;
    edInkAnnotRight: TEdit;
    edInkAnnotName: TEdit;
    edInkAnnotContents: TEdit;
    edInkAnnotTitle: TEdit;
    spedInkAnnotBwidth: TSpinEdit;
    cbInkAnnotPageno: TComboBox;
    edInkAnnotInklist: TEdit;
    cbMeasurement: TComboBox;
    btnReset: TButton;
    cbOpenAfterCreate: TCheckBox;
    SaveDialog1: TSaveDialog;
    procedure btnLoadPDFClick(Sender: TObject);
    procedure btnSaveFileNameClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddAnnotationClick(Sender: TObject);
    procedure rgrpAnnotationClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ResetControls(Sender: TObject);
    
  private
    { Private declarations }
  public
procedure PopulatePageno(Sender: TObject);
  end;

var
  Form1: TForm1;
  SelectedAnnot: TAnnotationSelection;
implementation

{$R *.dfm}
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

procedure TForm1.btnLoadPDFClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
  begin
    gtPDFDocument1.LoadFromFile(OpenDialog1.FileName);
    edPDFfilename.Text := OpenDialog1.FileName;
    PopulatePageno(cbTextannotPageno);
    cbTextannotPageno.ItemIndex := 0;
    PopulatePageno(cbFreeAnnotPageno);
    cbFreeAnnotPageno.ItemIndex := 0;
    PopulatePageno(cbLinkPageno);
    cbLinkPageno.ItemIndex := 0;
    PopulatePageno(cbLineAnnotPageno);
    cbLineAnnotPageno.ItemIndex := 0;
    PopulatePageno(cbCircleAnnotPageno);
    cbCircleAnnotPageno.ItemIndex := 0;
    PopulatePageno(cbSquareAnnotPageno);
    cbSquareAnnotPageno.ItemIndex := 0;
    PopulatePageno(cbStampAnnotPageno);
    cbStampAnnotPageno.ItemIndex := 0;
    PopulatePageno(cbCaretAnnotPageno);
    cbCaretAnnotPageno.ItemIndex := 0;
    PopulatePageno(cbPolygonAnnotPageno);
    cbPolygonAnnotPageno.ItemIndex := 0;
    PopulatePageno(cbPolylineannotPageno);
    cbPolylineannotPageno.ItemIndex := 0;
    PopulatePageno(cbInkAnnotPageno);
    cbInkAnnotPageno.ItemIndex := 0;
    PopulatePageno(cbMarkAnnotPageno);
    cbMarkAnnotPageno.ItemIndex := 0;
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
  btnResetClick(Self);
end;

procedure TForm1.btnAddAnnotationClick(Sender: TObject);
var
  LURIAction : TgtPDFURIAction;
begin
  try
    SetMeasurementUnit(gtPDFDocument1, cbMeasurement.ItemIndex);
    if Assigned(gtPDFDocument1) then
    begin
      case SelectedAnnot of
        atTextAnnot:
          begin
            InsertTextAnnotation(gtPDFDocument1,StrToFloat(edTextannotLeft.Text),StrToFloat(edTextannotTop.Text),
              StrToFloat(edTextannotRight.Text),StrToFloat(edTextannotBottom.Text),edTextannotTitle.Text,
              edTextannotName.Text,edTextannotContents.Text,clBlue,
              chkTextannotOpen.Checked, spedTextannotHCR.Value,spedTextannotVCR.Value,
              spedTextannotBwidth.Value, cbTextannotPageno.ItemIndex + 1);
          end;
        atFreeTextAnnot:
          begin
            InsertFreeTextAnnotation(gtPDFDocument1,StrToFloat(edFreeAnnotLeft.Text),StrToFloat(edFreeAnnotTop.Text),
              StrToFloat(edFreeAnnotRight.Text),StrToFloat(edFreeAnnotBottom.Text),edFreeAnnotTitle.Text,
              edFreeAnnotName.Text,edFreeAnnotContents.Text,clBlue,cbFreeAnnotAlign.ItemIndex,
              spedFreeBWidth.Value,cbFreeAnnotPageno.ItemIndex + 1);
          end;
        atLinkAnnot:
          begin
            LURIAction := TgtPDFURIAction.Create;
            LURIAction.URI := edLinkURIAction.Text;
            InsertLinkAnnotation(gtPDFDocument1,LURIAction,StrToFloat(edLinkLeft.Text),StrToFloat(edLinkTop.Text),
              StrToFloat(edLinkRight.Text),StrToFloat(edLinkBottom.Text), edLinkTitle.Text,
              edLinkName.Text, clBlue, cbLinkPageno.ItemIndex + 1);
          end;
        atLineAnnot:
          begin
            InsertLineAnnotation(gtPDFDocument1,StrToFloat(edAnnotLineX1.Text),StrToFloat(edAnnotLineY1.Text),
              StrToFloat(edAnnotLineX2.Text),StrToFloat(edAnnotLineY2.Text),edAnnotLinetitle.Text,
              edAnnotLineName.Text, edAnnotLineContents.Text, spedLineAnnotBorderwidth.Value,
              clBlue, cbLineAnnotPageno.ItemIndex + 1);
          end;
        atCircleAnnot:
          begin
            InsertCircleAnnotation(gtPDFDocument1, StrToFloat(edtcircleLeft.Text),StrToFloat(edtCircleTop.Text),
              StrToFloat(edtCircleRight.Text),StrToFloat(edtCircleBottom.Text), edtCircleAnnotContents.Text,
              clBlue, clRed, ChkCircleCloudy.Checked, spedCirclannotIntensity.Value,
              cbCircleAnnotPageno.ItemIndex + 1);

          end;
        atSquareAnnot:
          begin
            InsertSquareAnnotation(gtPDFDocument1,StrToFloat(edtSqAnnotTop.Text),StrToFloat(edtSqAnnotLeft.Text),
              StrToFloat(edtSqAnnotRight.Text),StrToFloat(edtSqAnnotBottom.Text),edtSqAnnotContents.Text,
              clBlue,clRed,cbSqAnnotCloudy.Checked,spedSquareIntensity.Value,
              cbSquareAnnotPageno.ItemIndex + 1);
          end;
        atStampAnnot:
          begin
            InsertStampAnnotation(gtPDFDocument1,StrToFloat(edStampAnnotLeft.Text),StrToFloat(edStampAnnotTop.Text),
              StrToFloat(edStampAnnotRight.Text),StrToFloat(edStampAnnotBottom.Text),edStampAnnotTitle.Text,
              edStampAnnotStampName.Text,edStampAnnotContents.Text,clBlue,cbStampAnnotBStyle.ItemIndex,
              spedStampAnnotBWidth.Value,cbStampAnnotPageno.ItemIndex + 1);
          end;
        atMarkupAnnot:
          begin
            InsertMarkupAnnotation(gtPDFDocument1,StrToFloat(edMarkAnnotLeft.Text),StrToFloat(edMarkAnnotTop.Text),
              StrToFloat(edMarkAnnotRight.Text),StrToFloat(edMarkAnnotBottom.Text),edMarkAnnotTitle.Text,
              edMarkAnnotName.Text,edMarkAnnotContents.Text,clBlue,spedMarkAnnotBWidth.Value,
              cbMarkAnnotPageno.ItemIndex + 1, StrToFloat(edMarkAnnotx1.Text),StrToFloat(edMarkAnnotY1.Text),
              StrToFloat(edMarkAnnotX2.Text),StrToFloat(edMarkAnnotY2.Text),StrToFloat(edMarkAnnotX3.Text),
              StrToFloat(edMarkAnnotY3.Text),StrToFloat(edMarkAnnotx4.Text),StrToFloat(edMarkAnnotY4.Text));
          end;
        atCaretAnnot:
          begin
            InsertCaretAnnotation(gtPDFDocument1,StrToFloat(edCaretAnnotLeft.Text), StrToFloat(edCaretAnnotTop.Text),
              StrToFloat(edCaretAnnotright.Text), StrToFloat(edCaretAnnotBottom.Text),edCaretAnnotTitle.Text,
              edCaretAnnotName.Text, edCaretAnnotContents.Text, spedCaretAnnotBorderwidth.Value,
              clBlue, cbCaretSymbol.ItemIndex, cbCaretAnnotPageno.ItemIndex + 1);
          end;
        atPolygonAnnot:
          begin
            InsertPolygonAnnotation(gtPDFDocument1, StrToFloat(edPolygonLeft.Text),StrToFloat(edPolygontop.Text),
              StrToFloat(edPolygonRight.Text),StrToFloat(edPolygonBottom.Text), edPolygonTitle.Text,
              edPolygonName.Text, edPolygonContents.Text, edPolygonVertices.Text, clBlue,
              chkIsCloudy.Checked, spedIntensity.Value, spedPolygonAnnotBorderwidth.Value,
              cbPolygonAnnotPageno.ItemIndex + 1);
          end;
        atPolylineAnnot:
          begin
            InsertPolylineAnnotation(gtPDFDocument1, StrToFloat(edPolylineAnnotLeft.Text),StrToFloat(edPolylineAnnotTop.Text),
              StrToFloat(edPolylineAnnotRight.Text),StrToFloat(edPolylineAnnotBottom.Text),edPolylineAnnotTitle.Text,
              edPolylineAnnotName.Text, edPolylineAnnotContents.Text, edpolylineVertices.Text,clBlue,
              spedPolylineAnnotBorderWidth.Value, cbPolylineannotPageno.ItemIndex + 1);
          end;
        atInkAnnot:
          begin
            InsertInkAnnotation(gtPDFDocument1,StrToFloat(edInkAnnotLeft.Text),StrToFloat(edInkAnnotTop.Text),
              StrToFloat(edInkAnnotRight.Text),StrToFloat(edInkAnnotBottom.Text),edInkAnnotTitle.Text,
              edInkAnnotName.Text,edInkAnnotContents.Text,edInkAnnotInklist.Text,clBlue,
              spedInkAnnotBwidth.Value,cbInkAnnotPageno.ItemIndex + 1);
          end;
      end;
    end;
  except
    //
  end;
  if Assigned(LURIAction) then
    FreeAndNil(LURIAction);
end;

procedure TForm1.rgrpAnnotationClick(Sender: TObject);
begin
   case rgrpAnnotation.ItemIndex of
    0:
    begin
      PageCtrlAnnotate.ActivePageIndex := 0;
      SelectedAnnot := atTextAnnot;
    end;
    1:
    begin
      PageCtrlAnnotate.ActivePageIndex := 1;
      SelectedAnnot := atFreeTextAnnot;
    end;
    2:
    begin
      PageCtrlAnnotate.ActivePageIndex := 2;
      SelectedAnnot := atLinkAnnot;
    end;
    3:
    begin
      PageCtrlAnnotate.ActivePageIndex := 3;
      SelectedAnnot := atLineAnnot;
    end;
    4:
    begin
      PageCtrlAnnotate.ActivePageIndex := 4;
      SelectedAnnot := atCircleAnnot;
    end;
    5:
    begin
      PageCtrlAnnotate.ActivePageIndex := 5;
      SelectedAnnot := atSquareAnnot;
    end;
    6:
    begin
      PageCtrlAnnotate.ActivePageIndex := 6;
      SelectedAnnot := atStampAnnot;
    end;
    7:
    begin
      PageCtrlAnnotate.ActivePageIndex := 7;
      SelectedAnnot := atMarkupAnnot;
    end;
    8:
    begin
      PageCtrlAnnotate.ActivePageIndex := 8;
      SelectedAnnot := atCaretAnnot;
    end;
    9:
    begin
      PageCtrlAnnotate.ActivePageIndex := 9;
      SelectedAnnot := atPolygonAnnot;
    end;
    10:
    begin
      PageCtrlAnnotate.ActivePageIndex := 10;
      SelectedAnnot := atPolylineAnnot;
    end;
    11:
    begin
      PageCtrlAnnotate.ActivePageIndex := 11;
      SelectedAnnot := atInkAnnot;
    end;
  else
    PageCtrlAnnotate.ActivePageIndex := 0;
    SelectedAnnot := atTextAnnot;
  end;
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  cbTextannotPageno.Clear;
  cbFreeAnnotPageno.Clear;
  cbLineAnnotPageno.Clear;
  cbLineAnnotPageno.Clear;
  cbCircleAnnotPageno.Clear;
  cbSquareAnnotPageno.Clear;
  cbStampAnnotPageno.Clear;
  cbCaretAnnotPageno.Clear;
  cbPolygonAnnotPageno.Clear;
  cbPolylineannotPageno.Clear;
  cbInkAnnotPageno.Clear;
  cbMarkAnnotPageno.Clear;
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
