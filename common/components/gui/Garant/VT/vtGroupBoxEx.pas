unit vtGroupBoxEx;

{ Библиотека "VT"         }
{ Начал: Люлин А.В.       }
{ Модуль: vtGroupBoxEx -  }
{ Начат: 30.05.2005 14:34 }
{ $Id: vtGroupBoxEx.pas,v 1.4 2009/01/26 14:17:55 fireton Exp $ }

// $Log: vtGroupBoxEx.pas,v $
// Revision 1.4  2009/01/26 14:17:55  fireton
// - теперь можно использовать любых наследников TCustomCheckBox, а не только TCheckBox
//
// Revision 1.3  2006/03/31 14:20:56  voba
// no message
//
// Revision 1.2  2005/05/30 11:35:47  lulin
// - new unit: vtGroupBox.
//
// Revision 1.1  2005/05/30 10:47:53  lulin
// - new unit: vtGroupBoxEx.
//

{$I vtDefine.inc }

interface

uses
  Windows,
  
  Messages,
  
  vtGroupBox
  ;

type
 TvtShapeType = (stRectangle, stLine, stNone);

 TvtGroupBoxEx = class(TvtGroupBox)
  private
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
   fShapeType : TvtShapeType;
   procedure SetShapeType(aValue: TvtShapeType);
    //procedure AdjustClientRect(var Rect: TRect); override;
    //procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;

    function  GetGCData : Longint;
    procedure SetGCData(Value : Longint);

  published
    property ShapeType: TvtShapeType read FShapeType write SetShapeType default stRectangle;
    property GroupCheckData : Longint Read GetGCData Write SetGCData Stored False;
    {CheckBoxes должны распологаться в порядке их вставки.
     В принципе можно сделать порядок TabOrder используя FindNextControl}

    //constructor Create(AOwner: TComponent); override;
  end;//TvtGroupBoxEx

implementation

uses
  Types,

  Graphics,

  StdCtrls
  ;

type
 THackCheckBox = class(TCustomCheckBox)
 public
  property Checked;
 end;


// start class TvtGroupBoxEx

procedure TvtGroupBoxEx.Paint;
var
 H: Integer;
 R: TRect;
 Flags: Longint;

 procedure DrawShape(const aRect : TRect; aColor : TColor);
 begin
  case fShapeType of
   stRectangle :
   begin
    Canvas.Brush.Color := aColor;
    Canvas.FrameRect(aRect);
   end;
   stLine :
   begin
    Canvas.Pen.Color := aColor;
    Canvas.MoveTo(aRect.Left, aRect.Top);
    Canvas.LineTo(aRect.Right, aRect.Top);
   end;
  end;
 end;

begin
 with Canvas do
 begin
  Font := Self.Font;
  H := TextHeight('0');
  R := Rect(0, H div 2 - 1, Width, Height);

  if Ctl3D then
  begin
   Inc(R.Left);
   Inc(R.Top);
   DrawShape(R, clBtnHighlight);
   OffsetRect(R, -1, -1);
   DrawShape(R, clBtnShadow);
  end
  else
   DrawShape(R, clWindowFrame);

  if Text <> '' then
  begin
   if not UseRightToLeftAlignment then
     R := Rect(8, 0, 0, H)
   else
     R := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H);
   Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
   DrawText(Handle, PChar(Text), Length(Text), R, Flags or DT_CALCRECT);
   Brush.Color := Color;
   DrawText(Handle, PChar(Text), Length(Text), R, Flags);
  end;
 end;
end;

procedure TvtGroupBoxEx.SetShapeType(aValue: TvtShapeType);
begin
 if aValue <> fShapeType then
 begin
  fShapeType := aValue;
  Invalidate;
 end;
end;

function TvtGroupBoxEx.GetGCData : Longint;
var
 I,C : Byte;
begin
 Result:=0;
 if ControlCount = 0 then Exit;
 C:=0;
 for I:= 0 to Pred(ControlCount) do
  if (Controls[I] is TCustomCheckBox) then
  begin
   if THackCheckBox(Controls[I]).Checked then
    Inc(Result, 1 shl C);
   Inc(C);
   if C >= 32 then exit;
  end;
end;

procedure TvtGroupBoxEx.SetGCData(Value : Longint);
var
 I,C : Byte;
begin
 if ControlCount = 0 then Exit;
 C:=0;
 for I:= 0 to Pred(ControlCount) do
 if Controls[I] is TCustomCheckBox then
 begin
  THackCheckBox(Controls[I]).Checked := (Value Shr C) and 1 = 1;
  Inc(C);
  if C >= 32 then exit;
 end;
end;

procedure TvtGroupBoxEx.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  inherited;
  //DefaultHandler(Message);
end;

end.

