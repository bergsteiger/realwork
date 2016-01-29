unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ElStatBar, ElXPThemedControl, ElBtnCtl, ElCheckCtl, ELCalculatorEdit,
  ElEdits, ElBtnEdit, ElPopBtn, ElCalc, ElStrUtils;

type
  TForm1 = class(TForm)
    elcbDialogMode: TElCheckBox;
    elSB: TElStatusBar;
    elcbDefaultButtonGlyph: TElCheckBox;
    elcbDefZeroValue: TElCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure elcbDefaultButtonGlyphClick(Sender: TObject);
    procedure elcbDefZeroValueClick(Sender: TObject);
  private
    { Private declarations }
    fELCalEdt :TELCalculatorEdit;
    procedure CalcEditButtonClick(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   fELCalEdt := TELCalculatorEdit.Create(Self);

   fELCalEdt.Left := 10;
   fELCalEdt.Top  := 10;
   fELCalEdt.Width := elcbDialogMode.Left - fELCalEdt.Left - 10;

   fELCalEdt.OnButtonClick := CalcEditButtonClick;

   elcbDefaultButtonGlyph.Checked := fELCalEdt.ButtonGlyphDefault;

   fELCalEdt.Parent := Self;

   elcbDefZeroValue.Checked := fELCalEdt.CalcDlgDefZeroValue;
   
   fELCalEdt.Text := '33';
   
   ActiveControl := fELCalEdt;

end;

procedure TForm1.CalcEditButtonClick(Sender: TObject);
begin
    fELCalEdt.CalcDlgModal := elcbDialogMode.Checked;
end;

procedure TForm1.elcbDefaultButtonGlyphClick(Sender: TObject);
begin
   fELCalEdt.ButtonGlyphDefault := elcbDefaultButtonGlyph.Checked;
end;

procedure TForm1.elcbDefZeroValueClick(Sender: TObject);
begin
   fELCalEdt.CalcDlgDefZeroValue := elcbDefZeroValue.Checked;
end;

end.
