{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit calc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    StarButton: TButton;
    Edit1: TEdit;
    Dig7: TButton;
    Dig8: TButton;
    Dig9: TButton;
    Dig4: TButton;
    Dig5: TButton;
    Dig6: TButton;
    Dig1: TButton;
    Dig2: TButton;
    Dig3: TButton;
    Dig0: TButton;
    DigPlusMinus: TButton;
    ClearButton: TButton;
    DelimButton: TButton;
    EnterButton: TButton;
    MinusButton: TButton;
    PlusButton: TButton;
    SlashButton: TButton;
    procedure Dig7Click(Sender: TObject);
    procedure Dig8Click(Sender: TObject);
    procedure Dig9Click(Sender: TObject);
    procedure Dig4Click(Sender: TObject);
    procedure Dig5Click(Sender: TObject);
    procedure Dig6Click(Sender: TObject);
    procedure Dig1Click(Sender: TObject);
    procedure Dig2Click(Sender: TObject);
    procedure Dig3Click(Sender: TObject);
    procedure Dig0Click(Sender: TObject);
    procedure DigPlusMinusClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure DelimButtonClick(Sender: TObject);
    procedure EnterButtonClick(Sender: TObject);
    procedure MinusButtonClick(Sender: TObject);
    procedure PlusButtonClick(Sender: TObject);
    procedure StarButtonClick(Sender: TObject);
    procedure SlashButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    InOp:Boolean;
    OpCode:Integer;
    PrevText:String;
    procedure OpAction(OCode:Integer);
    procedure DigitInsert(Const SSS:String);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DigitInsert(Const SSS:String);
begin
  If (InOp=1) or (InOp=3) then
  begin
    InOp:=2;
    PrevText:=Edit1.Text;
    Edit1.Text:='';
  end;
  If Edit1.Text='0' then
    Edit1.Text:='';
  Edit1.Text:=Edit1.Text+SSS;
end;

procedure TForm1.Dig7Click(Sender: TObject);
begin
  DigitInsert('7');
end;

procedure TForm1.Dig8Click(Sender: TObject);
begin
  DigitInsert('8');
end;

procedure TForm1.Dig9Click(Sender: TObject);
begin
  DigitInsert('9');
end;

procedure TForm1.Dig4Click(Sender: TObject);
begin
  DigitInsert('4');
end;

procedure TForm1.Dig5Click(Sender: TObject);
begin
  DigitInsert('5');
end;

procedure TForm1.Dig6Click(Sender: TObject);
begin
  DigitInsert('6');
end;

procedure TForm1.Dig1Click(Sender: TObject);
begin
  DigitInsert('1');
end;

procedure TForm1.Dig2Click(Sender: TObject);
begin
  DigitInsert('2');
end;

procedure TForm1.Dig3Click(Sender: TObject);
begin
  DigitInsert('3');
end;

procedure TForm1.Dig0Click(Sender: TObject);
begin
  If Edit1.Text<>'0' then
    DigitInsert('0');
end;

procedure TForm1.DigPlusMinusClick(Sender: TObject);
Var
  S:String;
begin
  If Pos('-',Edit1.Text)=1 then
  begin
    S:=Edit1.Text;
    S:=Copy(S,2,Length(s)-1);
    Edit1.Text:=S;
  end else
    Edit1.Text:='-'+Edit1.Text;
end;

procedure TForm1.ClearButtonClick(Sender: TObject);
begin
  Edit1.Text:='';
  InOp:=0;
end;

procedure TForm1.DelimButtonClick(Sender: TObject);
begin
  If Edit1.Text='' then
    Edit1.Text:='0';
  If Pos(',',Edit1.Text)=0
  then
    Edit1.Text:=Edit1.Text+',';
end;

procedure TForm1.EnterButtonClick(Sender: TObject);

  procedure CalcProc;
  Var
    A,B,C:Double;
  begin
    A:=StrToFloat(PrevText);
    B:=StrToFloat(Edit1.Text);
// - 0
// + 1
// * 2
// / 3

    If opCode=0 then
      C:=A-B else
    If OpCode=1 then
      C:=A+B else
    If OpCode=2 then
      C:=A*B else
      C:=A/B;
    Edit1.Text:=FloatToStr(C);
  end;

begin

  If InOp=1 then
  begin
    InOp:=3;
  end else
    If InOp=2 then
    begin
      CalcProc;
      InOp:=3;
    end;
end;

procedure TForm1.OpAction(OCode:Integer);
begin
  If Edit1.Text<>'' then
  begin
    InOp:=1;
    OpCode:=OCode;
  end;
end;

procedure TForm1.MinusButtonClick(Sender: TObject);
begin
  OpAction(0);
end;

procedure TForm1.PlusButtonClick(Sender: TObject);
begin
  OpAction(1);
end;

procedure TForm1.StarButtonClick(Sender: TObject);
begin
  OpAction(2);
end;

procedure TForm1.SlashButtonClick(Sender: TObject);
begin
  OpAction(3);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text:='0';
end;

end.
