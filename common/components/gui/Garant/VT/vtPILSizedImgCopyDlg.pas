unit vtPILSizedImgCopyDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, vtPngImgList,
  vtInterfaces
  ;

type
  TvtPILCopySizedDlg = class(TForm)
    cbxFrom: TGroupBox;
    rb16from: TRadioButton;
    Label1: TLabel;
    rb24from: TRadioButton;
    rb32from: TRadioButton;
    GroupBox1: TGroupBox;
    rb16to: TRadioButton;
    rb24to: TRadioButton;
    rb32to: TRadioButton;
    Image1: TImage;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    procedure rb16fromClick(Sender: TObject);
    procedure rb24fromClick(Sender: TObject);
    procedure rb32fromClick(Sender: TObject);
    procedure rb16toClick(Sender: TObject);
    procedure rb24toClick(Sender: TObject);
    procedure rb32toClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    f_SizeFrom: TvtPILSize;
    f_SizeTo: TvtPILSize;
    procedure EnableRBTo(aSize: TvtPILSize; aEnable: Boolean);
    procedure pm_SetSizeFrom(const Value: TvtPILSize);
    procedure pm_SetSizeTo(const Value: TvtPILSize);
    function SizeToRB(aSize: TvtPILSize): TRadiobutton;
    { Private declarations }
  public
    property SizeFrom: TvtPILSize read f_SizeFrom write pm_SetSizeFrom;
    property SizeTo: TvtPILSize read f_SizeTo write pm_SetSizeTo;
    { Public declarations }
  end;

var
  vtPILCopySizedDlg: TvtPILCopySizedDlg;

implementation

{$R *.dfm}

procedure TvtPILCopySizedDlg.EnableRBTo(aSize: TvtPILSize; aEnable: Boolean);
var
 l_RadioButton: TRadioButton;
begin
 l_Radiobutton := SizeToRB(aSize);
 if (not aEnable) and (aSize = SizeTo) then
 begin
  case SizeTo of
   ps16x16: SizeTo := ps24x24;
   ps24x24,
   ps32x32: SizeTo := ps16x16;
  end;
 end;
 l_RadioButton.Enabled := aEnable
end;

procedure TvtPILCopySizedDlg.pm_SetSizeFrom(const Value: TvtPILSize);
begin
 if f_SizeFrom <> Value then
 begin
  EnableRBTo(f_SizeFrom, True);
  f_SizeFrom := Value;
  EnableRBTo(f_SizeFrom, False);
 end;
end;

procedure TvtPILCopySizedDlg.pm_SetSizeTo(const Value: TvtPILSize);
begin
 f_SizeTo := Value;
 SizeToRB(Value).Checked := True;
end;

procedure TvtPILCopySizedDlg.rb16fromClick(Sender: TObject);
begin
 SizeFrom := ps16x16;
end;

function TvtPILCopySizedDlg.SizeToRB(aSize: TvtPILSize): TRadiobutton;
begin
 case aSize of
  ps16x16: Result := rb16to;
  ps24x24: Result := rb24to;
  ps32x32: Result := rb32to;
 end;
end;

procedure TvtPILCopySizedDlg.rb24fromClick(Sender: TObject);
begin
 SizeFrom := ps24x24;
end;

procedure TvtPILCopySizedDlg.rb32fromClick(Sender: TObject);
begin
 SizeFrom := ps32x32;
end;

procedure TvtPILCopySizedDlg.rb16toClick(Sender: TObject);
begin
 SizeTo := ps16x16;
end;

procedure TvtPILCopySizedDlg.rb24toClick(Sender: TObject);
begin
 SizeTo := ps24x24;
end;

procedure TvtPILCopySizedDlg.rb32toClick(Sender: TObject);
begin
 SizeTo := ps32x32;
end;

procedure TvtPILCopySizedDlg.FormCreate(Sender: TObject);
begin
 f_SizeFrom := ps16x16;
 f_SizeTo := ps24x24;
end;

end.
