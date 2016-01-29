unit D_PicSizeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls, vtSpin,
  tb97GraphicControl, TB97Ctls, vtSpeedButton;

type
  TPicSizeEditDlg = class(TBottomBtnDlg)
    edWidth: TvtSpinEdit;
    edHeight: TvtSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbProportional: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    pnlChained: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Label5: TLabel;
    edDPI: TvtSpinEdit;
    lbDPI: TLabel;
    procedure edWidthChange(Sender: TObject);
    procedure edHeightChange(Sender: TObject);
    procedure cbProportionalClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    f_PageWidth: Extended;
    f_PropCoeff: Extended; // width/height coeff
    f_SettingSize: Boolean;
    function pm_GetPicHeight: Extended;
    function pm_GetPicWidth: Extended;
    procedure pm_SetPicHeight(const Value: Extended);
    procedure pm_SetPicWidth(const Value: Extended);
    function pm_GetPicDPI: Integer;
    procedure pm_SetPicDPI(Value: Integer);
  public
    procedure FixProportion;
    property PageWidth: Extended
      read f_PageWidth
      write f_PageWidth;
    property PicHeight: Extended
      read pm_GetPicHeight
      write pm_SetPicHeight;
    property PicWidth: Extended
      read pm_GetPicWidth
      write pm_SetPicWidth;
    property PicDPI: Integer
      read pm_GetPicDPI
      write pm_SetPicDPI;
  end;//TPicSizeEditDlg

var
  PicSizeEditDlg: TPicSizeEditDlg;

implementation

{$R *.dfm}

function TPicSizeEditDlg.pm_GetPicHeight: Extended;
begin
 Result := edHeight.Value;
end;

function TPicSizeEditDlg.pm_GetPicWidth: Extended;
begin
 Result := edWidth.Value;
end;

procedure TPicSizeEditDlg.pm_SetPicHeight(const Value: Extended);
begin
 f_SettingSize := True;
 try
  edHeight.Value := Value;
 finally
  f_SettingSize := False;
 end;
end;

function TPicSizeEditDlg.pm_GetPicDPI: Integer;
begin
 Result := Round(edDPI.Value);
end;

procedure TPicSizeEditDlg.pm_SetPicDPI(Value: Integer);
begin
 edDPI.Value := Value;
end;

procedure TPicSizeEditDlg.pm_SetPicWidth(const Value: Extended);
begin
 f_SettingSize := True;
 try
  edWidth.Value := Value;
 finally
  f_SettingSize := False;
 end;
end;

procedure TPicSizeEditDlg.edWidthChange(Sender: TObject);
begin
 if cbProportional.Checked and not f_SettingSize then
 begin
  f_SettingSize := True;
  try
   edHeight.Value := PicWidth / f_PropCoeff;
  finally
   f_SettingSize := False;
  end;
 end;
end;

procedure TPicSizeEditDlg.edHeightChange(Sender: TObject);
begin
 if cbProportional.Checked and not f_SettingSize then
 begin
  f_SettingSize := True;
  try
   edWidth.Value := PicHeight * f_PropCoeff;
  finally
   f_SettingSize := False;
  end;
 end;
end;

procedure TPicSizeEditDlg.cbProportionalClick(Sender: TObject);
begin
 pnlChained.Visible := cbProportional.Checked;
 if cbProportional.Checked then
  PicHeight := PicWidth / f_PropCoeff;
end;

procedure TPicSizeEditDlg.FixProportion;
begin
 if (PicWidth = 0) or (PicHeight = 0) then
  f_PropCoeff := 1
 else
  f_PropCoeff := PicWidth / PicHeight;
end;

procedure TPicSizeEditDlg.Label5Click(Sender: TObject);
begin
 edWidth.Value := f_PageWidth;
end;

end.
