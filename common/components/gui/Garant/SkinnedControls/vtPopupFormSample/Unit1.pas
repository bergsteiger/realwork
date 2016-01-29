unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
Uses vtPopupForm, vtReminder;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 l_Reminder: TvtReminder;
 l_Memo: TMemo;
 l_Form: TCustomForm;
 l_Rect: TRect;
begin
 l_Form := TCustomForm.CreateNew(Self);

 l_Memo := TMemo.Create(l_Form);
 l_Memo.Color  := cWarningMessageColor;
 l_Memo.Parent := l_Form;
 l_Memo.Align  := alClient;
 l_Memo.Lines.Add('Hello World');
 l_Memo.Ctl3D := False;

 l_Rect := Rect(Self.Left+100, Self.Top+100, Self.Left+700, Self.Top+200);
 l_Reminder := TvtReminder.Create(Self);
 l_Reminder.Parent := Self;

 l_Form.ManualDock(l_Reminder, nil, alClient);
end;

end.
