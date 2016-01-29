unit uWatermark;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc, gtPDFDoc,
  StdCtrls, ExtCtrls, Spin, ComCtrls, PDTypes, PDFtoolkitUsage, gtExProPDFDoc;

type
  TWatermarkSelection = (wmText, wmRectangle, wmCircle, wmEllipse, wmPolygon,
                         wmCurve, wmComposite, wmImage, wmLine, wmHTMLTextout);


  TForm1 = class(TForm)
    Label13: TLabel;
    Label75: TLabel;
    Label14: TLabel;
    edPDFfilename: TEdit;
    btnLoadPDF: TButton;
    edSavePDFTo: TEdit;
    btnSaveFileName: TButton;
    gtPDFDocument1: TgtPDFDocument;
    OpenDialog1: TOpenDialog;
    btnSave: TButton;
    pgncntrlEnhancement: TPageControl;
    tbshWatermark: TTabSheet;
    Label40: TLabel;
    Label162: TLabel;
    rgrpwatermark: TRadioGroup;
    pgecntrlWatermark: TPageControl;
    tbshTextWatermark: TTabSheet;
    Label41: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label43: TLabel;
    Label120: TLabel;
    Label168: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    edTextWMName: TEdit;
    edTextWMXcord: TEdit;
    edTextWMYCord: TEdit;
    spedTextWMOpacity: TSpinEdit;
    chkOverlay: TCheckBox;
    edTextWMPageno: TEdit;
    btnTextWMFont: TButton;
    cbTextWMWritingmode: TComboBox;
    cbTextWMHorizPos: TComboBox;
    cbTextWMVertPoz: TComboBox;
    edTextWMAngle: TEdit;
    tbshImageWatermark: TTabSheet;
    Label95: TLabel;
    Label97: TLabel;
    Label96: TLabel;
    Label102: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label141: TLabel;
    Label167: TLabel;
    Label175: TLabel;
    Label189: TLabel;
    Label213: TLabel;
    edIamgeWMName: TEdit;
    btnIamgeOpen: TButton;
    edImageWMY: TEdit;
    edImageWMX: TEdit;
    chkImageWMOverlay: TCheckBox;
    spedImageWMOpacityFill: TSpinEdit;
    edImageWMPageno: TEdit;
    edImageWMWidth: TEdit;
    edImageWMHeight: TEdit;
    edImageWMRotation: TEdit;
    cbImageWMHorPas: TComboBox;
    cbImageWMVertPos: TComboBox;
    tbshRectWatermark: TTabSheet;
    Label51: TLabel;
    Label42: TLabel;
    Label47: TLabel;
    Label52: TLabel;
    Label46: TLabel;
    Label48: TLabel;
    Label53: TLabel;
    Label50: TLabel;
    Label49: TLabel;
    Label99: TLabel;
    Label142: TLabel;
    Label145: TLabel;
    edRectWMX1: TEdit;
    edRectWMY1: TEdit;
    edRectWMX2: TEdit;
    edRectWMY2: TEdit;
    spedRectWMPenWidth: TSpinEdit;
    spedRectWMOpacity: TSpinEdit;
    spedRectWMOpacityStroke: TSpinEdit;
    edRectWMPageno: TEdit;
    tbshCircleWatermark: TTabSheet;
    Label71: TLabel;
    Label70: TLabel;
    Label69: TLabel;
    Label68: TLabel;
    Label67: TLabel;
    Label133: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    edCircleX: TEdit;
    edCircleY: TEdit;
    edCircleWMPageno: TEdit;
    spedCircleRadius: TSpinEdit;
    spedCircleOpacity: TSpinEdit;
    spedCirclePenWidth: TSpinEdit;
    tbshPolygonWatermark: TTabSheet;
    Label77: TLabel;
    Label78: TLabel;
    Label80: TLabel;
    Label79: TLabel;
    Label81: TLabel;
    Label134: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    edPolygonX: TEdit;
    edPolygonY: TEdit;
    edPolygomWMPageno: TEdit;
    spedPolygonPenWidth: TSpinEdit;
    spedPolygonSideLen: TSpinEdit;
    spedPolygonNumofSides: TSpinEdit;
    tbshCurveWatermark: TTabSheet;
    Label55: TLabel;
    Label54: TLabel;
    Label56: TLabel;
    Label64: TLabel;
    Label62: TLabel;
    Label59: TLabel;
    Label61: TLabel;
    Label57: TLabel;
    Label60: TLabel;
    Label58: TLabel;
    Label63: TLabel;
    Label135: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    edCurveInitPointX: TEdit;
    edCurveInitPointY: TEdit;
    edCurveFirstPointY: TEdit;
    edCurveFirstPointX: TEdit;
    edCurveSecondPointX: TEdit;
    edCurveSecondPointY: TEdit;
    edCurveWMPageno: TEdit;
    edCurveEndX: TEdit;
    edCurveEndY: TEdit;
    spedCurveWMPenWidth: TSpinEdit;
    tbshLineWatermark: TTabSheet;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label136: TLabel;
    Label157: TLabel;
    edLineInitX1: TEdit;
    edLineInitY1: TEdit;
    edLineEndX2: TEdit;
    edLineEndY2: TEdit;
    edLineWMPageno: TEdit;
    spedLinePenWidth: TSpinEdit;
    spedLineOpacityStroke: TSpinEdit;
    tbshEllipseWatermark: TTabSheet;
    Label72: TLabel;
    Label73: TLabel;
    Label1: TLabel;
    Label74: TLabel;
    Label76: TLabel;
    Label137: TLabel;
    Label159: TLabel;
    edEllipseY: TEdit;
    edEllipseX: TEdit;
    edEllipseWMPageno: TEdit;
    spedEllipseMajorRad: TSpinEdit;
    spedEllipseMinorRad: TSpinEdit;
    spedEllipsePenWidth: TSpinEdit;
    btnAddWatermark: TButton;
    cbMWMeasure: TComboBox;
    FontDialog1: TFontDialog;
    cbOpenAfterCreate: TCheckBox;
    btnReset: TButton;
    SaveDialog1: TSaveDialog;
    procedure btnLoadPDFClick(Sender: TObject);
    procedure btnSaveFileNameClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddWatermarkClick(Sender: TObject);
    procedure rgrpwatermarkClick(Sender: TObject);
    procedure btnTextWMFontClick(Sender: TObject);
    procedure btnIamgeOpenClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ResetControls(Sender: TObject);
  private
    FFont: TFont;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  SelectedWM: TWatermarkSelection;
implementation

uses
  gtPDFUtils;

{$R *.dfm}

procedure TForm1.btnLoadPDFClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    gtPDFDocument1.LoadFromFile(OpenDialog1.FileName);
    edPDFfilename.Text := OpenDialog1.FileName;
  end;
  FFont := TFont.Create;
  FFont.Name := 'Arial';
  FFont.Size := 12;
  FFont.Style := [fsItalic];
  FFont.Color := clBlack;
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
//  btnResetClick(Sender);
end;

procedure TForm1.btnAddWatermarkClick(Sender: TObject);
var
  LInitialPoint, LEndPoint, LFirstcontrolPoint: TgtPoint;
  LSecondControlPoint, LCenterPoint: TgtPoint;
  LImage: TGraphic;
begin
  try
    SetMeasurementUnit(gtPDFDocument1,cbMWMeasure.ItemIndex);
    if Assigned(gtPDFDocument1) then
    begin
      lInitialPoint := TgtPoint.Create;
      LEndPoint := TgtPoint.Create;
      LFirstcontrolPoint := TgtPoint.Create;
      LSecondControlPoint := TgtPoint.Create;
      LCenterPoint := TgtPoint.Create;
      try
        case SelectedWM of
          wmText:
            begin
              InsertTextWatermark(gtPDFDocument1, Trim(edTextWMName.Text), edTextWMPageno.Text,
                FFont, clBlue, chkOverlay.Checked,
                StrToFloat(edTextWMXcord.Text),StrToFloat(edTextWMYCord.Text), cbTextWMHorizPos.ItemIndex,
                cbTextWMVertPoz.ItemIndex, cbTextWMWritingmode.ItemIndex,spedTextWMOpacity.Value,
                StrToInt(edTextWMAngle.Text));
            end;
          wmRectangle:
            begin
              lInitialPoint.X := StrToFloat(Trim(edRectWMX1.Text));
              lInitialPoint.Y := StrToFloat(Trim(edRectWMY1.Text));
              LEndPoint.X := StrToFloat(Trim(edRectWMX2.Text));
              LEndPoint.Y := StrToFloat(Trim(edRectWMY2.Text));

              InsertRectangleWatermark(gtPDFDocument1,lInitialPoint,LEndPoint,spedRectWMPenWidth.Value,
                spedRectWMOpacity.Value, spedRectWMOpacityStroke.Value, clRed,
                clBlue,edRectWMPageno.Text);

            end;
          wmCircle:
            begin
              LCenterPoint.X := StrToFloat(Trim(edCircleX.Text));
              LCenterPoint.Y := StrToFloat(Trim(edCircleY.Text));
              InsertCircleWatermark(gtPDFDocument1,LCenterPoint, spedCircleRadius.Value,
                clRed, clBlue, spedCirclePenWidth.Value,
                spedCircleOpacity.Value,edCircleWMPageno.Text);
            end;
          wmEllipse:
            begin
              LCenterPoint.X :=  StrToFloat(Trim(edEllipseX.Text));
              LCenterPoint.y :=  StrToFloat(Trim(edEllipseY.Text));
              InsertEllipseWatermark(gtPDFDocument1,LCenterPoint, spedEllipseMajorRad.Value,
                 spedEllipseMinorRad.Value, spedEllipsePenWidth.Value, clRed, clBlue,
                 edEllipseWMPageno.Text);
            end;
          wmPolygon:
            begin
              LCenterPoint.X := StrToFloat(Trim(edPolygonX.Text));
              LCenterPoint.Y := StrToFloat(Trim(edPolygonY.Text));
              InsertPolygonWatermark(gtPDFDocument1,LCenterPoint, spedPolygonNumofSides.Value,
                spedPolygonSideLen.Value, spedPolygonPenWidth.Value, clRed,
                clBlue, edPolygomWMPageno.Text);
            end;
          wmCurve:
            begin
              lInitialPoint.X := StrToFloat(Trim(edCurveInitPointX.Text));
              lInitialPoint.Y := StrToFloat(Trim(edCurveInitPointX.Text));

              LFirstcontrolPoint.X := StrToFloat(Trim(edCurveFirstPointX.Text));
              LFirstcontrolPoint.Y := StrToFloat(Trim(edCurveFirstPointY.Text));

              LSecondControlPoint.X := StrToFloat(Trim(edCurveSecondPointX.Text));
              LSecondControlPoint.Y := StrToFloat(Trim(edCurveSecondPointY.Text));

              LEndPoint.X := StrToFloat(Trim(edCurveEndX.Text));
              LEndPoint.Y := StrToFloat(Trim(edCurveEndY.Text));

              InsertCurveWatermark(gtPDFDocument1, lInitialPoint, LFirstcontrolPoint, LSecondControlPoint,
                LEndPoint, clRed, spedCurveWMPenWidth.Value, edCurveWMPageno.Text);
            end;
          wmComposite:
            begin

            end;
          wmImage:
            begin
              LImage := TBitmap.Create;
              LImage.LoadFromFile(edIamgeWMName.Text);
              InsertImageWatermark(gtPDFDocument1,LImage,StrToFloat(Trim(edImageWMX.Text)),
                StrToFloat(Trim(edImageWMY.Text)),StrToFloat(Trim(edImageWMWidth.Text)),
                StrToFloat(Trim(edImageWMHeight.Text)),chkImageWMOverlay.Checked, spedImageWMOpacityFill.Value,
                  cbImageWMHorPas.ItemIndex,cbImageWMVertPos.ItemIndex,StrToInt(edImageWMRotation.Text),edImageWMPageno.Text);
            end;
          wmLine:
            begin
              lInitialPoint.X := StrToFloat(Trim(edLineInitX1.Text));
              lInitialPoint.Y := StrToFloat(Trim(edLineInitY1.Text));

              LEndPoint.X := StrToFloat(Trim(edLineEndX2.Text));
              LEndPoint.Y := StrToFloat(Trim(edLineEndY2.Text));
              InsertLineWatermark(gtPDFDocument1, lInitialPoint, LEndPoint, clRed,
                spedLinePenWidth.Value, spedLineOpacityStroke.Value, edLineWMPageno.Text);
            end;
        end;
      finally
        if Assigned(LImage) then
          FreeAndNil(LImage);
        if Assigned(lInitialPoint) then
          FreeAndNil(lInitialPoint);
        if Assigned(LEndPoint) then
          FreeAndNil(LEndPoint);
        if Assigned(LFirstcontrolPoint) then
          FreeAndNil(LFirstcontrolPoint);
        if Assigned(LSecondControlPoint) then
          FreeAndNil(LSecondControlPoint);
        if Assigned(LCenterPoint) then
          FreeAndNil(LCenterPoint);
      end;
    end;
  except
    //
  end;
end;

procedure TForm1.rgrpwatermarkClick(Sender: TObject);
begin
  case rgrpwatermark.ItemIndex of
    0:
    begin
      pgecntrlWatermark.ActivePageIndex := 0;
      SelectedWM := wmText;
    end;
    1:
    begin
      pgecntrlWatermark.ActivePageIndex := 1;
      SelectedWM := wmImage;
    end;
    2:
    begin
      pgecntrlWatermark.ActivePageIndex := 2;
      SelectedWM := wmRectangle;
    end;
    3:
    begin
      pgecntrlWatermark.ActivePageIndex := 3;
      SelectedWM := wmCircle;
    end;
    4:
    begin
      pgecntrlWatermark.ActivePageIndex := 4;
      SelectedWM := wmPolygon;
    end;
    5:
    begin
      pgecntrlWatermark.ActivePageIndex := 5;
      SelectedWM := wmCurve;
    end;
    6:
    begin
      pgecntrlWatermark.ActivePageIndex := 6;
      SelectedWM := wmLine;
    end;
    7:
    begin
      pgecntrlWatermark.ActivePageIndex := 7;
      SelectedWM := wmEllipse;
    end;
  else
    pgecntrlWatermark.ActivePageIndex := 0;
    SelectedWM := wmText;
  end;
end;

procedure TForm1.btnTextWMFontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    FFont.Assign(FontDialog1.Font);
  end;
end;

procedure TForm1.btnIamgeOpenClick(Sender: TObject);
begin
  OpenDialog1.Filter := '*.bmp';
  OpenDialog1.Execute;
  edIamgeWMName.Text := OpenDialog1.FileName;
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  if Assigned(FFont) then
    FFont.Free;
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
