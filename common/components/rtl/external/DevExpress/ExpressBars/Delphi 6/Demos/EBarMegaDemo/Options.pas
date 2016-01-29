unit Options;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, Spin, dxsbar, ExtDlgs;

type
  TOptionsForm = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    tsSideBar: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    pBeginColor: TPanel;
    pEndColor: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    cbFillStyle: TComboBox;
    ColorDialog: TColorDialog;
    Label4: TLabel;
    seStep: TSpinEdit;
    GroupBox2: TGroupBox;
    ImbkPicture: TImage;
    Button1: TButton;
    Button2: TButton;
    OpenPictureDialog: TOpenPictureDialog;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    lbGroupFont: TLabel;
    lbItemFont: TLabel;
    Bevel1: TBevel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    FontDialog: TFontDialog;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    cbBorderStyle: TComboBox;
    cbPaintStyle: TComboBox;
    Label8: TLabel;
    GroupBox5: TGroupBox;
    cbCanSelected: TCheckBox;
    procedure pBeginColorClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure seStepChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FontGroup : TFont;
    FontItem  : TFont;
  end;

var
  OptionsForm: TOptionsForm;

implementation

uses Main;

{$R *.DFM}

procedure TOptionsForm.pBeginColorClick(Sender: TObject);
begin
 if ColorDialog.Execute then
  TPanel(Sender).Color := ColorDialog.Color;
end;

procedure TOptionsForm.FormActivate(Sender: TObject);
begin
 //SideBar
  with MainForm.dxSideBar.bkGround do begin
    pBeginColor.Color := BeginColor;
    pEndColor.Color := EndColor;
    case FillStyle of
     bfsHorz : cbFillStyle.ItemIndex := 0;
     bfsNone : cbFillStyle.ItemIndex := 1;
     bfsVert : cbFillStyle.ItemIndex := 2;
    end;
    seStep.Value := Step;
  end;

  with MainForm.dxSideBar do begin
   FontGroup := GroupFont;
   FontItem  := ItemFont;
   lbGroupFont.Caption := FontGroup.Name + ' ('+IntToStr(FontGroup.Size)+')';
   lbItemFont.Caption := FontItem.Name + ' ('+IntToStr(FontItem.Size)+')';

   case BorderStyle of
    bsNone : cbBorderStyle.ItemIndex := 0;
    bsSingle : cbBorderStyle.ItemIndex := 1;
   end;
   case PaintStyle of
    sbpsFlat : cbPaintStyle.ItemIndex := 0;
    sbpsStandard : cbPaintStyle.ItemIndex := 1;
   end;
   cbCanSelected.Checked := CanSelected;
  end;
end;

procedure TOptionsForm.BitBtn2Click(Sender: TObject);
begin
 //SideBar
  with MainForm.dxSideBar.bkGround do begin
    BeginColor := pBeginColor.Color;
    EndColor := pEndColor.Color;
    case cbFillStyle.ItemIndex of
     0: FillStyle := bfsHorz;
     1: FillStyle := bfsNone;
     2: FillStyle := bfsVert;
    end;
    Step := seStep.Value;
  end;

  with MainForm.dxSideBar do begin
   bkPicture := ImbkPicture.Picture;
   GroupFont := FontGroup;
   ItemFont  := FontItem;

   case cbBorderStyle.ItemIndex of
    0: BorderStyle := bsNone;
    1: BorderStyle := bsSingle;
   end;

   case cbPaintStyle.ItemIndex of
    0: PaintStyle := sbpsFlat;
    1: PaintStyle := sbpsStandard;
   end;

   CanSelected := cbCanSelected.Checked;
  end;
end;

procedure TOptionsForm.seStepChange(Sender: TObject);
begin
 with TSpinEdit(Sender) do
  if Value < 1 then Value := 1;
end;

procedure TOptionsForm.Button1Click(Sender: TObject);
begin
 if OpenPictureDialog.Execute then
  ImbkPicture.Picture.LoadFromFile(OpenPictureDialog.FileName);
end;

procedure TOptionsForm.Button2Click(Sender: TObject);
begin
 ImbkPicture.Picture := nil;
end;

procedure TOptionsForm.SpeedButton1Click(Sender: TObject);
begin
 FontDialog.Font := FontGroup;
 if FontDialog.Execute then
  FontGroup := FontDialog.Font;
 lbGroupFont.Caption := FontGroup.Name + ' ('+IntToStr(FontGroup.Size)+')';
end;

procedure TOptionsForm.SpeedButton2Click(Sender: TObject);
begin
 FontDialog.Font := FontItem;
 if FontDialog.Execute then
  FontItem := FontDialog.Font;
 lbItemFont.Caption := FontItem.Name + ' ('+IntToStr(FontItem.Size)+')';
end;

end.
