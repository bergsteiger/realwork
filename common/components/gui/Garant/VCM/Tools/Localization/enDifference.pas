unit enDifference;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Ten_Difference = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    Label2: TLabel;
    Memo2: TMemo;
    SameBtn: TButton;
    DifferentBtn: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Memo3: TMemo;
    Label5: TLabel;
    Memo4: TMemo;
    procedure Memo4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo4KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    f_Skip: Boolean;
  public
    { Public declarations }
   function Execute(const aName, anOld, aNew, anOldTranslated: String;
    var aNewTranslated: String): Boolean; 
  end;

var
  en_Difference: Ten_Difference;

implementation

{$R *.dfm}

{ Ten_Difference }

function Ten_Difference.Execute(const aName, anOld,
  aNew, anOldTranslated: String; var aNewTranslated: String): Boolean;
begin
 Label3.Caption := FOrmat('Term "%s" has difference in original language.'#13#10+
  'Is the text same (misprinting) or different?',[aName]);
 Memo1.Lines.Text:=Format('<<%s>>',[anOld]);
 Memo2.Lines.Text:=Format('<<%s>>',[aNew]);
 Memo3.Lines.Text:=anOldTranslated;
 Memo4.Lines.Text:=aNewTranslated;
 Result := ShowModal = mrOk;
 if Result then
  aNewTranslated := Memo4.Lines.Text;
end;

procedure Ten_Difference.Memo4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
 begin
  Key := 0;
  DifferentBtn.Click;
 end;
 if (Key = VK_RETURN) and (ssCtrl in Shift) then
 begin
  f_Skip := false;
  Key := 0;
  SameBtn.Click;
 end;
end;

procedure Ten_Difference.Memo4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
  Key := 0;
 if (Key = VK_RETURN) and (ssCtrl in Shift) then
 begin
  f_Skip := true;
  Key := 0;
 end;
end;

procedure Ten_Difference.Memo4KeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #10) and f_Skip then
  Key := #0;
end;

end.
