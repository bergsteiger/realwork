{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDocDefines.inc}
unit gtPNGEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtGfxDlg, gtPNGEng, gtDocResStrs, gtUtils3;

type
  TgtPNGEngineDlg = class(TgtGraphicsDlg)
    tsAdvanced: TTabSheet;
    gbAdvancedOptions: TGroupBox;
    lblColorType: TLabel;
    cbColorType: TComboBox;
    gbPixelDimension: TGroupBox;
    gbTransparency: TGroupBox;
    chkPixelDimensions: TCheckBox;
    chkTransparency: TCheckBox;
    lblXPixelsPerUnit: TLabel;
    lblYPixelsPerUnit: TLabel;
    lblUnitSpecifier: TLabel;
    edXPixelsPerUnit: TEdit;
    edYPixelsPerUnit: TEdit;
    cbUnitSpecifier: TComboBox;
    lblImageAlpha: TLabel;
    lblTransparencyColor: TLabel;
    edImageAlpha: TEdit;
    shpTransparencyColor: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkPixelDimensionsClick(Sender: TObject);
    procedure chkTransparencyClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cbColorTypeChange(Sender: TObject);
    procedure shpTransparencyColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpTransparencyColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    PNGMousePoint: TPoint;

  protected
    procedure Localize; override;
    
  public
    { Public declarations }
  end;

const
  PNGColorType: array[TgtPNGColorType] of String = (SctGrayScale, SctRGB,
    SctRGBA, SctGrayAlpha);
  PNGUnitSpecifier: array[TgtPNGUnitSpecifier] of String = (SusNone, SusMeter);

implementation

uses gtCstDocEng, gtDocDlg;

{$R *.dfm}

procedure TgtPNGEngineDlg.FormCreate(Sender: TObject);
var
  I: TgtPNGColorType;
  J: TgtPNGUnitSpecifier;
begin
  inherited;
  //tsQualityAndScaling.PageIndex := tsQualityAndScaling.PageIndex + 1;
  //
  {$IFDEF EMailSupport}
  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1, SlblAdvanced);
  {$ELSE}
  lbDocumentDlg.Items.Append(SlblAdvanced);
  {$ENDIF}

  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SQualityScaling));
  tsQualityAndScaling.TabVisible := False;
  //
	for I := Low(TgtPNGColorType) to High(TgtPNGColorType) do
		cbColorType.Items.AddObject(PNGColorType[I], TObject(I));
	for J := Low(TgtPNGUnitSpecifier) to High(TgtPNGUnitSpecifier) do
		cbUnitSpecifier.Items.AddObject(PNGUnitSpecifier[J], TObject(J));
  SetControlsEnabled(gbDocInfo, True);
end;

procedure TgtPNGEngineDlg.FormShow(Sender: TObject);
begin
  with TgtPNGEngine(Engine) do                                                
  begin
    with DocInfo do
    begin
      edAuthor.Text := Author;
      edCreator.Text := Creator;
      edKeywords.Text := Keywords;
      edSubject.Text := Subject;
      edTitle.Text := Title;
    end;
		cbColorType.ItemIndex := cbColorType.Items.IndexOfObject(
      TObject(Ord(ColorType)));
    with PixelDimensions do
    begin
      chkPixelDimensions.Checked := Enabled;
      edXPixelsPerUnit.Text := IntToStr(XPixelsPerUnit);
      edYPixelsPerUnit.Text := IntToStr(YPixelsPerUnit);
      cbUnitSpecifier.ItemIndex := cbUnitSpecifier.Items.IndexOfObject(
        TObject(Ord(UnitSpecifier)));
    end;
    chkPixelDimensionsClick(Sender);
    with Transparency do
    begin
      chkTransparency.Checked := Enabled;
      edImageAlpha.Text := IntToStr(ImageAlpha);
      shpTransparencyColor.Brush.Color := TransColor;
    end;
    chkTransparencyClick(Sender);
  end;
  inherited;
end;

procedure TgtPNGEngineDlg.chkPixelDimensionsClick(Sender: TObject);
begin
	SetControlsEnabled(gbPixelDimension, chkPixelDimensions.Checked);
end;

procedure TgtPNGEngineDlg.chkTransparencyClick(Sender: TObject);
begin
	SetControlsEnabled(gbTransparency, chkTransparency.Checked);
  cbColorTypeChange(Sender);
end;

procedure TgtPNGEngineDlg.btnOKClick(Sender: TObject);
begin
  with TgtPNGEngine(Engine) do
  begin
    with DocInfo do
    begin
      Author := edAuthor.Text;
      Creator := edCreator.Text;
      Keywords := edKeywords.Text;
      Subject := edSubject.Text;
      Title := edTitle.Text;
    end;  
    ColorType := TgtPNGColorType(cbColorType.Items.Objects[
      cbColorType.ItemIndex]);
    with PixelDimensions do
    begin
      Enabled := chkPixelDimensions.Checked;
      XPixelsPerUnit := StrToInt(edXPixelsPerUnit.Text);
      YPixelsPerUnit := StrToInt(edYPixelsPerUnit.Text);
      UnitSpecifier := TgtPNGUnitSpecifier(cbUnitSpecifier.Items.Objects[
        cbUnitSpecifier.ItemIndex]);
    end;
    with Transparency do
    begin
      Enabled := chkTransparency.Enabled;
      ImageAlpha := TgtPercentage(StrToInt(edImageAlpha.Text));
      TransColor := shpTransparencyColor.Brush.Color;
    end;
  end;
  inherited;
end;

procedure TgtPNGEngineDlg.cbColorTypeChange(Sender: TObject);
begin
  if (TgtPNGColorType(cbColorType.Items.Objects[cbColorType.ItemIndex]) =
    ctRGB) or
    (TgtPNGColorType(cbColorType.Items.Objects[cbColorType.ItemIndex]) =
    ctGrayscale) then
  begin
    lblImageAlpha.Enabled := False;
    edImageAlpha.Enabled := False;
    if chkTransparency.Checked then
    begin
      lblTransparencyColor.Enabled := True;
      shpTransparencyColor.Enabled := True;
    end;
  end
  else
  begin
    lblTransparencyColor.Enabled := False;
    shpTransparencyColor.Enabled := False;
    if chkTransparency.Checked then
    begin
      lblImageAlpha.Enabled := True;
      edImageAlpha.Enabled := True;
    end;
  end;
end;

procedure TgtPNGEngineDlg.Localize;
begin
  inherited;
  Caption := SPNGDlgCaption;

  lblColorType.Caption := SlblColorType;
  chkPixelDimensions.Caption := SchkPixelDimensions;
  lblXPixelsPerUnit.Caption := SlblXPixelsPerUnit;
  lblYPixelsPerUnit.Caption := SlblYPixelsPerUnit;
  lblUnitSpecifier.Caption := SlblUnitSpecifier;
  chkTransparency.Caption := SchkTransparency;
  lblImageAlpha.Caption := SlblImageAlpha;
  lblTransparencyColor.Caption := SlblTransparencyColor;
end;

procedure TgtPNGEngineDlg.shpTransparencyColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	PNGMousePoint.X := X;
	PNGMousePoint.Y := Y;
end;

procedure TgtPNGEngineDlg.shpTransparencyColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	ColorDialog.Color := (Sender as TShape).Brush.Color;
	if (((X = PNGMousePoint.x) and (Y = PNGMousePoint.y)) and
    (Button = mbleft)) then
		if ColorDialog.Execute then
			(Sender as TShape).Brush.Color := ColorDialog.Color;
end;

end.
