unit Brddlg;

{ $Id: brddlg.PAS,v 1.44 2009/07/23 17:40:13 lulin Exp $ }

// $Log: brddlg.PAS,v $
// Revision 1.44  2009/07/23 17:40:13  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.43  2009/03/23 15:09:13  lulin
// [$139442655]. Переименовываем файл.
//
// Revision 1.42  2009/03/23 14:54:31  lulin
// [$139442655]. Переименовываем новый контрол.
//
// Revision 1.41  2009/03/23 14:36:02  lulin
// [$139442655]. Поменял все контролы и свойства.
//
// Revision 1.40  2009/03/03 09:15:25  fireton
// - убираем с глаз долой неработающую кнопку "Параметры"  (K 125894726)
//
// Revision 1.39  2008/06/02 08:23:34  voba
// no message
//
// Revision 1.38  2008/05/28 11:27:43  voba
// no message
//
// Revision 1.37  2007/12/24 15:25:11  lulin
// - удалены ненужные файлы.
//
// Revision 1.36  2007/12/06 12:14:38  lulin
// - используем стандартный контрол выбора цвета.
//
// Revision 1.35  2007/12/05 18:16:47  lulin
// - вычищен ненужный код.
//
// Revision 1.34  2007/12/03 09:04:00  dinishev
// Используем редактор из ветки
//
// Revision 1.33  2005/05/30 13:54:24  lulin
// - bug fix: не компилировалось.
//
// Revision 1.32  2005/05/27 14:44:22  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.31  2005/05/26 13:42:03  lulin
// - new unit: l3ScreenIC.
//
// Revision 1.30  2005/05/24 14:53:14  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.29  2004/05/05 14:31:29  voba
// -rename vCtrls to vtCtrls
//
// Revision 1.28  2004/03/05 13:00:48  voba
// TCustomVLister -> TvtCustomLister
//
// Revision 1.27  2003/02/06 10:25:29  law
// - cleanup: используем код операции по умолчанию.
//
// Revision 1.26  2003/01/21 09:48:29  law
// - bug fix: неправильно отрабатывалосьнажатие на примере рамки.
//
// Revision 1.25  2002/10/18 11:31:26  law
// - new folder: Meta.
//
// Revision 1.24  2002/07/15 14:27:26  law
// no message
//
// Revision 1.23  2002/07/10 08:27:00  voba
// -bug fix : не компилировался
//
// Revision 1.22  2002/07/09 12:12:56  law
// - rename unit: l3UnitsTools -> l3Units.
//
// Revision 1.21  2001/09/28 09:07:28  law
// - cleanup: удалены ненужные ссылки на RX.
//
// Revision 1.20  2001/09/10 11:00:38  law
// - rename proc: evPoint* -> l3Point*.
//
// Revision 1.19  2001/06/25 11:26:43  narry
// -new behavior: при вызове из таблицы, по умолчанию
//                         устанавливается на работу с ячейкой
//
// Revision 1.18  2001/04/02 11:30:53  law
// - убраны ненужные AutoCreat формы.
//
// Revision 1.17  2000/12/15 16:21:58  law
// - вставлены директивы Log.
//

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, vtlister, ExtCtrls, Buttons, Mask,
  l3Types, l3Base, vtCtrls,
  l3Interfaces,
  evEditorInterfaces, ImgList, ActnList, D_Base, vtStringLister,
  afwControl, afwInputControl, afwControlPrim, afwBaseControl, vtColorBox,

  nevBase
  ;

type
  TddApplyToPrim = (dd_atChar, dd_atPara, dd_atCell, dd_atTable, dd_atAuto);
  TddApplyTo = dd_atChar .. dd_atTable;
  TddApplyToSet = set of TddApplyTo;

  TevFramePart = record
    Exists  : Bool;
    Visible : Bool;
    Color   : TColor;
    Width   : Long;
    Style   : TedLineStyle;
  end;{TevFramePart}

  TBorderDlg = class(TBaseDlg)
    Label2: TLabel;
    Label3: TLabel;
    cbLineColor: TvtColorBox;
    Label4: TLabel;
    Bevel2: TBevel;
    Label5: TLabel;
    sbTopLine: TSpeedButton;
    sbHorizontalLine: TSpeedButton;
    sbBottomLine: TSpeedButton;
    sbLeftLine: TSpeedButton;
    sbVerticalLine: TSpeedButton;
    sbRightLine: TSpeedButton;
    Label6: TLabel;
    cbApplyTo: TComboBox;
    LineStyleList: TvtStringlister;
    Example: TPaintBox;
    Button3: TButton;
    Label1: TLabel;
    sbNone: TSpeedButton;
    ComboPenWidth: TComboBox;
    sbBox: TSpeedButton;
    sbAll: TSpeedButton;
    sbGrid: TSpeedButton;
    sbOther: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    lblAll: TLabel;
    lblGrid: TLabel;
    Label11: TLabel;
    ImageList1: TImageList;
    procedure rbBorderClick(Sender: TObject);
    procedure rbAllClick(Sender: TObject);
    procedure rbNoneClick(Sender: TObject);
    procedure rbInnerClick(Sender: TObject);
    procedure rbOtherClick(Sender: TObject);
    procedure sbTopLineClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbLineColorChange(Sender: TObject);
    procedure comboPenWidthChange(Sender: TObject);
    procedure LineStyleListClick(Sender: TObject);
    procedure ExampleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure ExamplePaint(Sender: TObject);
    procedure cbApplyToChange(Sender: TObject);
    procedure comboPenWidthDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    f_Frames        : array [TddApplyTo, TedFramePartIndex] of TevFramePart;
    f_Buttons       : array [TedFramePartIndex] of TSpeedButton;
    f_ApplyIndexes  : array [TddApplyTo] of Integer;
    f_ParamsChanged : array [TedFramePartIndex] of Boolean;
    f_ApplyTo       : TddApplyTo;
    procedure UpdateExample;
    procedure UpdateParameters;
    function PenWidth: Longint;
    { Ширина пера  пикселях }
    procedure ChangeFrame(VisibleParts: TedFramePartIndexes);
    procedure ChangeFramePart(Index: TedFramePartIndex; aVisible: Boolean);
    function Pixel2Inch(aWidth: Long): Long;
    function Inch2Pixel(aWidth: Long): Long;
    procedure SetButtonGlyph(aButton: TSpeedButton; aList: TImageList; Index: Integer);
  public
    { Public declarations }
    procedure ExecutePrim(const aParagraph : IedParagraph;
                          const aTable     : IedTable;
                          const aProcessor : InevProcessor;
                          anApplyTo        : TddApplyToPrim = dd_atAuto);
      {* - вызывает выполнение диалога для aRange. }
    procedure Execute(const aRange: IedRange);
      {* - вызывает выполнение диалога для aRange. }
  end;

function BorderDlg: TBorderDlg;
  {-}

implementation

{$R *.DFM}

Uses
  D_Params,

  l3MinMax,
  l3Units,
  l3ScreenIC,

  evMsgCode
  ;

var
  l_BorderDlg: TBorderDlg = nil;

const
  GapWidth = 20;
  WidthArray : Array[0..8] of Long = ( //массив соответствия пунктов дюймам
   Round(0.25*1000/72),
   Round(0.5 *1000/72),
   Round(0.75*1000/72),
   Round(1*1000/72),
   Round(1.5*1000/72),
   Round(2.25*1000/72),
   Round(3*1000/72),
   Round(4.5*1000/72),
   Round(6*1000/72)
   );
  TextArray : Array[0..8] of String = ( // массив толщин
    #188, #189, #190, '1', '1 '#189, '2 '#188, '3', '4 '#189, '6'
    );
  stApplyToChar = 'тексту';
  stApplyToPara = 'абзацу';
  stApplyToCell = 'ячейке';
  stApplyToTable = 'таблице';

procedure TBorderDlg.FormCreate(Sender: TObject);
begin
 LineStyleList.Current:= 0;
 cbLineColor.Selected:= clBlack;
 comboPenWidth.ItemIndex:= 0;
 f_ApplyTo:= dd_atPara;
 f_Buttons[ed_fpiUp] := sbTopLine;
 f_Buttons[ed_fpiDown] := sbBottomLine;
 f_Buttons[ed_fpiLeft] := sbLeftLine;
 f_Buttons[ed_fpiRight] := sbRightLine;
 f_Buttons[ed_fpiVert] := sbVerticalLine;
 f_Buttons[ed_fpiHorz] := sbHorizontalLine;
 ChangeFrame(edNoneFrame);
end;


function TBorderDlg.Pixel2Inch(aWidth: Long): Long;
var
  i: Integer;
begin
  Result:= 0;
  for i:= 0 to 8 do
    if aWidth = WidthArray[i] then
    begin
      Result:= i;
      break;
    end;
end;

function TBorderDlg.Inch2Pixel(aWidth: Long): Long;
begin
  Result:= Max(l3CrtIC.LP2DP(l3PointY(WidthArray[aWidth])).Y, 1);
end;


procedure TBorderDlg.rbBorderClick(Sender: TObject);
begin
 if sbBox.Down then
  ChangeFrame(edBoxFrame)
 else
   rbNoneClick(Self);
end;

procedure TBorderDlg.rbAllClick(Sender: TObject);
begin
 if sbAll.Down then
  ChangeFrame(edGridFrame)
 else
  rbNoneClick(Self);
end;

procedure TBorderDlg.rbNoneClick(Sender: TObject);
begin
 ChangeFrame(edNoneFrame);
end;

procedure TBorderDlg.rbInnerClick(Sender: TObject);
begin
 if sbGrid.Down then
  ChangeFrame(edGridFrame)
 else
  rbNoneClick(Self);
end;

procedure TBorderDlg.rbOtherClick(Sender: TObject);
begin
  {???}
end;

procedure TBorderDlg.ChangeFrame(VisibleParts: TedFramePartIndexes);
var
 l_Index : TedFramePartIndex;
begin
 for l_Index := Low(TedFramePartIndex) to High(TedFramePartIndex) do
  ChangeFramePart(l_Index, l_Index in VisibleParts);
 UpdateExample; 
end;

procedure TBorderDlg.ChangeFramePart(Index: TedFramePartIndex; aVisible: Boolean);
begin
 f_Buttons[Index].Down := aVisible;
 f_Frames[f_ApplyTo, Index].Visible:= aVisible;
 if f_Frames[f_ApplyTo, Index].Visible then begin
  f_Frames[f_ApplyTo, Index].Color:= cbLineColor.Selected;
  f_Frames[f_ApplyTo, Index].Style:= TedLineStyle(LineStyleList.Current);
  f_Frames[f_ApplyTo, Index].Width:= ComboPenWidth.ItemIndex;
 end;
end;

procedure TBorderDlg.sbTopLineClick(Sender: TObject);
var
 l_Index : TedFramePartIndex;
begin
 sbOther.Down:= True;
 for l_Index := Low(TedFramePartIndex) to High(TedFramePartIndex) do
  if (f_Buttons[l_Index] = Sender) then begin
   ChangeFramePart(l_Index, f_Buttons[l_Index].Down);
   break;
  end;//f_Buttons[l_Index] = Sender
 UpdateExample;
end;

procedure TBorderDlg.UpdateExample;

 procedure ApplyFramePen(const aFrame: TevFramePart; aPen: TPen);
 begin//ApplyFramePen
  with aPen do begin
   Color:= aFrame.Color;
   Width:= Inch2Pixel(aFrame.Width);
   case aFrame.Style of
    ed_lsSingle : Style := psSolid;
     // A solid line.
    ed_lsDashSmall : Style := psDash;
     // A line made up of a series of dashes
    ed_lsDotDash : Style := psDot;
     // A line made up of a series of dots
    ed_lsDotDotDash : Style := psDashDot;
     // A line made up of alternating dashes and dots
    ed_lsTriple : Style := psDashDotDot;
     // A line made up of a serious of dash-dot-dot combinations
    else
     Style:= psSolid;
   end;//case Ord(aFrame.Style)
  end;//with aPen
 end;//ApplyFramePen

var
  l_MaxCell,
  l_MaxRow  : Long;
  l_Cell,
  l_Row     : Long;
  l_Width,
  l_Height  : Long;
  l_X, l_Y  : Long;
  l_Line    : Long;
begin
 with Example.Canvas do begin
  Brush.Color:= clWhite;
  FillRect(Bounds(0, 0, Example.Width, Example.Height));
  Pen.Style:= psDashDotDot;
  Pen.Color:= clBlack;
  Pen.Width:= 1;

  MoveTo(GapWidth div 2, GapWidth);
  LineTo(GapWidth, GapWidth);
  LineTo(GapWidth, GapWidth div 2);

  MoveTo(GapWidth div 2, Example.Height - GapWidth);
  LineTo(GapWidth, Example.Height - GapWidth);
  LineTo(GapWidth, Example.Height - GapWidth div 2);

  MoveTo(Example.Width-GapWidth div 2, GapWidth);
  LineTo(Example.Width-GapWidth, GapWidth);
  LineTo(Example.Width-GapWidth, GapWidth div 2);

  MoveTo(Example.Width-GapWidth div 2, Example.Height - GapWidth);
  LineTo(Example.Width-GapWidth, Example.Height - GapWidth);
  LineTo(Example.Width-GapWidth, Example.Height - GapWidth div 2);

  { Рисуем собственно пример }

  Pen.Style:= psSolid;
  Pen.Color:= clSilver;
  Pen.Width:= 3;

  if sbHorizontalLine.Visible then
   l_MaxRow := 1
  else
   l_MaxRow := 0;

  if sbVerticalLine.Visible then
   l_MaxCell := 1
  else
   l_MaxCell := 0;

  l_Width := ((Example.Width - 2 * GapWidth) div Succ(l_MaxCell)) - 2 * 10;
  l_Height := ((Example.Height - 2 * GapWidth) div Succ(l_MaxRow)) - 2 * 10;

  l_X := GapWidth + 10;
  for l_Cell := 0 to l_MaxCell do begin
   for l_Row := 0 to l_MaxRow do begin
    l_Y := GapWidth + 10 + ((l_Height + 2 * 10) * l_Row);
    MoveTo(l_X + 10, l_Y);
    LineTo(l_X + l_Width, l_Y);
    for l_Line := 1 to (l_Height div 5) - 1 do begin
     Inc(l_Y, 5);
     MoveTo(l_X, l_Y);
     LineTo(l_X + l_Width, l_Y);
    end;//for l_Line
    Inc(l_Y, 5);
    MoveTo(l_X, l_Y);
    LineTo(l_X + l_Width - 10, l_Y);
   end;//for l_Row
   Inc(l_X, l_Width + 2 * 10);
  end;//for l_Cell

  if sbTopLine.Down AND sbTopLine.Visible then begin
   ApplyFramePen(f_Frames[f_ApplyTo, ed_fpiUp], Pen);
   MoveTo(GapWidth, GapWidth);
   LineTo(Example.Width-GapWidth, GapWidth);
  end;//sbTopLine.Down

  if sbBottomLine.Down AND sbBottomLine.Visible then begin
   ApplyFramePen(f_Frames[f_ApplyTo, ed_fpiDown], Pen);
   MoveTo(GapWidth, Example.Height-GapWidth);
   LineTo(Example.Width-GapWidth, Example.Height-GapWidth);
  end;//sbBottomLine.Down

  if sbLeftLine.Down AND sbLeftLine.Visible then begin
   ApplyFramePen(f_Frames[f_ApplyTo, ed_fpiLeft], Pen);
   MoveTo(GapWidth, GapWidth);
   LineTo(GapWidth, Example.Height-GapWidth);
  end;//sbLeftLine.Down

  if sbRightLine.Down AND sbRightLine.Visible then begin
   ApplyFramePen(f_Frames[f_ApplyTo, ed_fpiRight], Pen);
   MoveTo(Example.Width-GapWidth, GapWidth);
   LineTo(Example.Width-GapWidth, Example.Height-GapWidth);
  end;//sbRightLine.Down

  if sbVerticalLine.Down and sbVerticalLine.Visible then begin
   ApplyFramePen(f_Frames[f_ApplyTo, ed_fpiVert], Pen);
   MoveTo(Example.Width div 2, GapWidth);
   LineTo(Example.Width div 2, Example.Height-GapWidth);
  end;//sbVerticalLine.Down..

  if sbHorizontalLine.Down and sbHorizontalLine.Visible then begin
   ApplyFramePen(f_Frames[f_ApplyTo, ed_fpiHorz], Pen);
   MoveTo(GapWidth, Example.Height div 2);
   LineTo(Example.Width-GapWidth, Example.Height div 2);
  end;//sbHorizontalLine.Down

 end;//with Example.Canvas
end;

procedure TBorderDlg.cbLineColorChange(Sender: TObject);
var
 i : TedFramePartIndex;
begin
 for i:= Low(TedFramePartIndex) to High(TedFramePartIndex) do
  f_ParamsChanged[i] := true;
end;

procedure TBorderDlg.comboPenWidthChange(Sender: TObject);
var
 l_Index : TedFramePartIndex;
begin
 for l_Index := Low(TedFramePartIndex) to High(TedFramePartIndex) do
  f_ParamsChanged[l_Index] := true;
end;

function TBorderDlg.PenWidth: Longint;
begin
  Result:= Inch2Pixel(WidthArray[ComboPenWidth.ItemIndex]);
end;

procedure TBorderDlg.LineStyleListClick(Sender: TObject);
var
 i : TedFramePartIndex;
begin
 for i := Low(TedFramePartIndex) to High(TedFramePartIndex) do
  f_ParamsChanged[i] := true;
end;


procedure TBorderDlg.ExampleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 { Calculate area for border }
 if sbLeftLine.Visible AND
    (X <= GapWidth) and
    (Y >= GapWidth) and
    (Y <= (Example.Height - GapWidth)) then begin
  if f_ParamsChanged[ed_fpiLeft] and sbLeftLine.Down then
   f_ParamsChanged[ed_fpiLeft] := false
  else
   sbLeftLine.Down:= not sbLeftLine.Down;
  sbTopLineClick(sbLeftLine);
 end;//X <= GapWidth..
 if sbRightLine.Visible AND
    (X >= (Example.Width - GapWidth)) and
    (Y >= GapWidth) and
    (Y <= (Example.Height - GapWidth)) then begin
  if f_ParamsChanged[ed_fpiRight] and sbRightLine.Down then
    f_ParamsChanged[ed_fpiRight] := false
  else
    sbRightLine.Down:= not sbRightLine.Down;
  sbTopLineClick(sbRightLine);
 end;//X >= (Example.Width - GapWidth)..
 if sbTopLine.Visible AND
    (X > GapWidth) and
    (X < (Example.Width - GapWidth)) and (Y < GapWidth) then begin
  if f_ParamsChanged[ed_fpiUp] and sbTopLine.Down then
    f_ParamsChanged[ed_fpiUp] := false
  else
    sbTopLine.Down:= not sbTopLine.Down;
  sbTopLineClick(sbTopLine);
 end;//X > GapWidth..
 if sbBottomLine.Visible AND 
    (X > GapWidth) and
    (X < (Example.Width - GapWidth)) and
    (Y>(Example.Height - GapWidth)) then begin
   if f_ParamsChanged[ed_fpiDown] and sbBottomLine.Down then
     f_ParamsChanged[ed_fpiDown] := false
   else
     sbBottomLine.Down:= not sbBottomLine.Down;
   sbTopLineClick(sbBottomLine);
 end;//X > GapWidth..
 if sbHorizontalLine.Visible AND
    (X > GapWidth) and (X < (Example.Width-GapWidth)) and
    (Y >= (Example.Height div 2 - GapWidth)) and
    (Y <= (Example.Height div 2 + GapWidth)) then begin
   sbHorizontalLine.Down := not sbHorizontalLine.Down;
   sbTopLineClick(sbHorizontalLine);
 end;//sbHorizontalLine.Visible..
 if sbVerticalLine.Visible AND
    (X >= (Example.Width div 2 - GapWidth)) and
    (X <= (Example.Width div 2 + GapWidth)) and
    (Y >= GapWidth) and (Y <= (Example.Height - GapWidth)) then begin
  sbVerticalLine.Down:= not sbVerticalLine.Down;
  sbTopLineClick(sbVerticalLine);
 end;//sbVerticalLine.Visible..
end;

procedure TBorderDlg.Button3Click(Sender: TObject);
begin
 with TBorderParamDlg.Create(Self) do begin
  TopIndent:= 1;
  BottomIndent:= 1;
  LeftIndent:= 2;
  RightIndent:= 2;
  if (ShowModal = mrOk) then begin
   { Забираем информацию }
  end;//ShowModal = mrOk..
  Free;
 end;
end;

procedure TBorderDlg.ExamplePaint(Sender: TObject);
begin
 UpdateExample
end;

procedure TBorderDlg.SetButtonGlyph(aButton: TSpeedButton; aList: TImageList; Index: Integer);
var
 l_Bitmap: TBitmap;
begin
 l_Bitmap:= TBitmap.Create;
 try
  aList.GetBitmap(Index, l_Bitmap);
  aButton.Glyph:= l_Bitmap;
 finally
  l_Bitmap.Free;
 end;
end;

procedure TBorderDlg.cbApplyToChange(Sender: TObject);
var
 l_Bitmap  : TBitmap;
 l_ApplyTo : TddApplyTo;
begin
 f_ApplyTo := dd_atPara;
 for l_ApplyTo := Low(TddApplyTo) to High(TddApplyTo) do
  if (cbApplyTo.ItemIndex = f_ApplyIndexes[l_ApplyTo]) then begin
   f_ApplyTo := l_ApplyTo;
   break;
  end;{cbApplyTo.ItemIndex..}

 if (f_ApplyTo = dd_atTable) then begin
  SetButtonGlyph(sbNone, ImageList1, 0);
  SetButtonGlyph(sbBox, ImageList1, 1);
  SetButtonGlyph(sbAll, ImageList1, 2);
  SetButtonGlyph(sbGrid, ImageList1, 3);
  SetButtonGlyph(sbOther, ImageList1, 4);
 end else begin
  SetButtonGlyph(sbNone, ImageList1, 5);
  SetButtonGlyph(sbBox, ImageList1, 6);
  SetButtonGlyph(sbAll, ImageList1, 7);
  SetButtonGlyph(sbGrid, ImageList1, 8);
  SetButtonGlyph(sbOther, ImageList1, 9);
 end;//f_ApplyTo = dd_atTable

 UpdateParameters;
 UpdateExample;
end;

procedure TBorderDlg.UpdateParameters;
var
 l_Index  : TedFramePartIndex;
 l_Button : TSpeedButton;
 l_Box    : Integer;
 l_VisBox : Integer;
begin
 Label11.Visible := false;
 sbOther.Visible := false;
 sbBox.Visible := false;
 Label8.Visible := false;
 sbAll.Visible := false;
 sbGrid.Visible := false;
 lblAll.Visible := false;
 lblGrid.Visible := false;
 sbNone.Down := true;
 l_Box := 0;
 l_VisBox := 0;
 for l_Index := Low(TedFramePartIndex) to High(TedFramePartIndex) do begin
  l_Button := f_Buttons[l_Index];
  with f_Frames[f_ApplyTo, l_Index] do
   if Exists then begin
    Inc(l_VisBox);
    l_Button.Visible := true;
    if (l_VisBox = 1) then begin
     Label11.Visible := true;
     sbOther.Visible := true;
    end else if (l_VisBox = 4) and (l_Index = ed_fpiRight) then begin
     sbBox.Visible := true;
     Label8.Visible := true;
    end else if (l_VisBox = 6) AND (l_Index = ed_fpiHorz) then begin
     sbAll.Visible := true;
     sbGrid.Visible := true;
     lblAll.Visible := true;
     lblGrid.Visible := true;
    end;//l_VisBox = 6..
    if Visible then begin
     l_Button.Down:= true;
     Inc(l_Box);
     if (l_Box = 1) and sbOther.Visible then
      sbOther.Down:= true
     else if (l_Box = 4) and (l_Index = ed_fpiRight) and sbBox.Visible then
      sbBox.Down:= true
     else if (l_Box = 6) and (l_Index = ed_fpiHorz) and sbAll.Visible then
      sbAll.Down:= true;
     comboPenWidth.ItemIndex := Width;
     LineStyleList.Current:= Ord(Style);
     if (Color > 0) then
      cbLineColor.Selected := Color;
    end else
     l_Button.Down:= false;
    //f_Frames[f_ApplyTo, l_Index].Exists
   end else
    l_Button.Visible := false;
 end;{for l_Index}
end;


procedure TBorderDlg.ExecutePrim(const aParagraph : IedParagraph;
                                 const aTable     : IedTable;
                                 const aProcessor : InevProcessor;
                                 anApplyTo        : TddApplyToPrim = dd_atAuto);
  {* - Вызывает выполнение диалога для aRange. }

 procedure ReadParameters(aBorderPart  : TddApplyTo;
                          const aFrame : IedFrame);
 var
  l_Index     : TedFramePartIndex;
  l_FramePart : IedFramePart;
 begin
  if (aFrame <> nil) then 
  begin
   for l_Index := Low(TedFramePartIndex) to High(TedFramePartIndex) do 
   begin
    l_FramePart := aFrame[l_Index];
    with f_Frames[aBorderPart, l_Index] do
     if (l_FramePart = nil) then
      Exists := False
     else begin
      Exists := True;
      if l_FramePart.Visible then 
      begin
       Visible := True;
       Width:= Pixel2Inch(l_FramePart.Width);
       Style:= l_FramePart.Style;
       Color:= l_FramePart.Color;
       //l_FramePart.Visible
      end 
      else
       Visible := False;
      l_FramePart := nil;
     end;{l_FramePart <> nil}
   end;{for l_Index}
  end;{aFrame <> nil}
 end;

var
 l_ApplyTo   : TddApplyTo;
 l_FramePart : IedFramePart;
 l_Frame     : IedFrame;
 l_Index     : TedFramePartIndex;
 l_Cell      : IedCells;
 l_Op        : InevOp;
begin
 if (aTable = nil) and (aParagraph = nil) then Exit;

 for l_ApplyTo := Low(TddApplyTo) to High(TddApplyTo) do
  f_ApplyIndexes[l_ApplyTo] := -1;
  
 cbApplyTo.Items.Clear;
 if (aParagraph <> nil) then 
 begin
  f_ApplyIndexes[dd_atChar] := cbApplyTo.Items.Count;
  cbApplyTo.Items.Add(stApplyToChar);
  f_ApplyIndexes[dd_atPara] := cbApplyTo.Items.Count;
  cbApplyTo.Items.Add(stApplyToPara);
  l_Frame:= aParagraph.Frame;
  ReadParameters(dd_atPara, l_Frame);
  l_Frame:= nil;
  {
  l_Frame:= aParagraph.Character.Frame;
  ReadParameters(Ord(dd_atChar));
  l_Frame:= nil;
  }
  cbApplyTo.ItemIndex:= f_ApplyIndexes[dd_atPara];
 end;//aParagraph <> nil

 if (aTable <> nil) then 
 begin
  l_Cell := aTable.Cells;
  if (l_Cell <> nil) then 
  begin
   f_ApplyIndexes[dd_atCell] := cbApplyTo.Items.Count;
   cbApplyTo.Items.Add(stApplyToCell);
  end;//l_Cell <> nil
  f_ApplyIndexes[dd_atTable] := cbApplyTo.Items.Count;
  cbApplyTo.Items.Add(stApplyToTable);
  l_Frame:= aTable.Frame;
  ReadParameters(dd_atTable, l_Frame);
  l_Frame:= nil;
  if (l_Cell <> nil) then
   l_Frame:= l_Cell.Frame;
  ReadParameters(dd_atCell, l_Frame);
  l_Frame:= nil;
  cbApplyTo.ItemIndex:= f_ApplyIndexes[dd_atCell];
 end;//aTable <> nil

 if (anApplyTo <> dd_atAuto) AND (f_ApplyIndexes[anApplyTo] >= 0) then
  cbApplyTo.ItemIndex:= f_ApplyIndexes[anApplyTo];

 cbApplyToChange(Self);
 UpdateParameters;

 if ((aTable <> nil) or (aParagraph <> nil)) AND (ShowModal = mrOk) then 
 begin
  case f_ApplyTo of
   dd_atChar: l_Frame := aParagraph.Frame; { text }
   dd_atPara: l_Frame := aParagraph.Frame;
   dd_atCell: l_Frame := l_Cell.Frame;
   dd_atTable: l_Frame := aTable.Frame;
  end; { case f_ApplyTo }

  if (l_Frame <> nil) then begin
   if (aProcessor = nil) then
    l_Op := nil
   else
    l_Op := aProcessor.StartOp;
   try
    for l_Index := Low(TedFramePartIndex) to High(TedFramePartIndex) do 
    begin
     l_FramePart := l_Frame[l_Index];
     if (l_FramePart <> nil) then 
     begin
      with f_Frames[f_ApplyTo, l_Index] do 
      begin
       if Visible then 
       begin
        l_FramePart.Visible := True;
        l_FramePart.Width := WidthArray[Width];
        l_FramePart.Style := Style;
        l_FramePart.Color := Color;
       end else
        l_FramePart.Visible := False;
      end;{with f_Frames[l_Index]..}
      l_FramePart := nil;
     end;{l_FramePart <> nil}
    end;{for l_Index}
   finally
    l_Op := nil;
   end;{try..finally}
   l_Frame := nil;
  end;{l_Frame <> nil}
 end;{aTable <> nil .. aParagraph <> nil..}
 
 l_Cell := nil;
end;

procedure TBorderDlg.Execute(const aRange: IedRange);
  {-}
var
 l_Processor : InevProcessor;
begin
 if (aRange <> nil) then with aRange do begin
  if l3IFail(QueryInterface(InevProcessor, l_Processor)) then
   l_Processor := nil;
  try
   ExecutePrim(Paragraph, Table, l_Processor);
  finally
   l_Processor := nil;
  end;//try..finally
 end;{aRange <> nil}
end;

procedure TBorderDlg.comboPenWidthDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Text: String;
begin
 with TComboBox(Control).Canvas do begin
  Brush.Color:= clWhite;
  FillRect(Rect);
  case LineStyleList.Current of
   0: Pen.Style:= psSolid; //	A solid line.
   1: Pen.Style:= psDash;  //	A line made up of a series of dashes
   2: Pen.Style:= psDot; //	A line made up of a series of dots
   3: Pen.Style:= psDashDot;//	A line made up of alternating dashes and dots
   4: Pen.Style:= psDashDotDot;//	A line made up of a serious of dash-dot-dot combinations
   else
    Pen.Style:= psSolid;
  end;//case LineStyleList.Current

  Pen.Color:= clBlack;
  Pen.Width:= 1;
  Font.Color:= clBlack;
  if (Index < 9) then begin
   Pen.Color:= cbLineColor.Selected;
   Pen.Width:= Inch2Pixel(Index);
   Font.CharSet:= ANSI_CHARSET;
   TextOut(Rect.Left +(25-TextWidth(TextArray[Index])), Rect.Top + 2, TextArray[Index]);
   Font.CharSet:= RUSSIAN_CHARSET;
   TextOut(Rect.Left + 40-TextWidth('пт'), Rect.Top+2, 'пт');
   MoveTo(50, Rect.Top+(Rect.Bottom-Rect.Top) div 2);
   LineTo(Rect.Right - 10, Rect.Top+(Rect.Bottom-Rect.Top) div 2);
  end;//Index < 9
 end;//with TComboBox(Control).Canvas
end;

function BorderDlg: TBorderDlg;
  {-}
begin
 if (l_BorderDlg = nil) then
  l_BorderDlg := TBorderDlg.Create(Application);
 Result := l_BorderDlg;  
end;

end.

