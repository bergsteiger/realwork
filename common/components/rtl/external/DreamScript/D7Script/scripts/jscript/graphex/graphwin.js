//USEUNIT StdCtrls
//USEUNIT Dialogs
//USEUNIT Menus
//USEUNIT Forms
//USEUNIT ComCtrls
//USEUNIT dcedit
//USEUNIT DCGen
//USEUNIT ExtCtrls
//USEUNIT about
//USEUNIT BMPDLG
var  dtLine = 0;
var  dtRectangle = 1;
var  dtEllipse = 2;
var  dtRoundRect = 3;

var  BrushStyle;
var  PenStyle;
var  PenWide;
var  Drawing;
var  OriginX;
var  OriginY;
var  MovePtX;
var  MovePtY;
var  DrawingTool = dtLine;
var  CurrentFile='';
var  CF_BITMAP = 2;
//-------------------------------------------------------------------

function FormMouseDown(Sender, Button, Shift, X, Y)
{
  Drawing = true;
  Image.Canvas.MoveTo(X, Y);
  OriginX = X;
  OriginY = Y;
  MovePtX = X;
  MovePtY = Y;
  StatusBar1.Panels(0).Text = "Origin: " + X + " " + Y;
}

//-------------------------------------------------------------------

function FormMouseUp(Sender, Button, Shift, X, Y)
{
  if (Drawing)
  {
    DrawShape(OriginX,OriginY, X, Y, pmCopy);
    Drawing = false;
  }
}

//-------------------------------------------------------------------

function FormMouseMove(Sender, Shift, X, Y)
{
  if (Drawing)
  {
    DrawShape(OriginX, OriginY,MovePtX, MovePtY, pmNotXor);
    MovePtX = X;
    MovePtY = Y;
    DrawShape(OriginX, OriginY, MovePtX,MovePtY ,pmNotXor);
  }
  StatusBar1.Panels(1).Text = "Current: " + X + " " + Y;
}

//-------------------------------------------------------------------

function LineButtonClick(Sender)
{
  DrawingTool = dtLine;
}

//-------------------------------------------------------------------

function RectangleButtonClick(Sender)
{
  DrawingTool = dtRectangle;
}

//-------------------------------------------------------------------

function EllipseButtonClick(Sender)
{
  DrawingTool = dtEllipse;
}

//-------------------------------------------------------------------

function RoundRectButtonClick(Sender)
{
  DrawingTool = dtRoundRect;
}

//-------------------------------------------------------------------

function DrawShape(TopLeftX, TopLeftY ,BottomRightX,BottomRightY, AMode)
{
  with (Image.Canvas)
  {
    Pen.Mode = AMode;
    switch (DrawingTool)
    {
      case dtLine:
        {
          MoveTo(TopLeftX, TopLeftY);
          LineTo(BottomRightX, BottomRightY);
          break;
        }
      case dtRectangle:
        {
          Rectangle(TopLeftX, TopLeftY, BottomRightX, BottomRightY);
          break;
        }
      case dtEllipse:
        {
          Ellipse(TopLeftX, TopLeftY, BottomRightX, BottomRightY);
          break;
        }
      case dtRoundRect:
        {
           RoundRect(TopLeftX, TopLeftY, BottomRightX, BottomRightY,
           (TopLeftX - BottomRightX) / 2,(TopLeftY - BottomRightY) / 2);
          break;
        }
    }
  }
}

//-------------------------------------------------------------------

function PenStyleEditChange(Sender)
{
  Image.Canvas.Pen.Style = PenStyleEdit.PenStyle;
}

function BrushStyleEditChange(Sender)
{
  Image.Canvas.Brush.Style = BrushStyleEdit.BrushStyle;
}

//-------------------------------------------------------------------

function PenColorEditChange(Sender)
{
  Image.Canvas.Pen.Color = PenColorEdit.SelectedColor;
}

//-------------------------------------------------------------------

function BrushColorEditChange(Sender)
{
  Image.Canvas.Brush.Color = BrushColorEdit.SelectedColor;
}

//-------------------------------------------------------------------

function PenSizeChange(Sender)
{
  if (PenSizeEdit.Text != "" )
    Image.Canvas.Pen.Width = PenSizeEdit.Text;
}

//-------------------------------------------------------------------

function FormCreate(Sender)
{
var  Bitmap;
  Bitmap = TBitmap.Create;
  Bitmap.Width = 200;
  Bitmap.Height = 200;
  Image.Picture.Bitmap.Assign(Bitmap);
  Bitmap.Free;
  with (Image.Canvas)
  {
    PenStyleEdit.PenStyle = Pen.Style;
    BrushStyleEdit.BrushStyle = Brush.Style;
    PenColorEdit.SelectedColor = Pen.Color;
    BrushColorEdit.SelectedColor = Brush.Color;
  }
}

//-------------------------------------------------------------------

function Exit1Click(Sender)
{
  Close;
}

//-------------------------------------------------------------------

function miAboutClick(Sender)
{
  Formabout.ShowModal;
}

//-------------------------------------------------------------------

function Open1Click(Sender)
{
  if (OpenDialog1.Execute)
  {
    CurrentFile = OpenDialog1.FileName;
    SaveStyles();
    Image.Picture.LoadFromFile(CurrentFile);
    RestoreStyles();
  }
}

//-------------------------------------------------------------------

function Save1Click(Sender)
{
  if (CurrentFile != "")
    Image.Picture.SaveToFile(CurrentFile);
  else
    Saveas1Click(Sender);
}

//-------------------------------------------------------------------

function Saveas1Click(Sender)
{
  if (SaveDialog1.Execute)
  {
    CurrentFile = SaveDialog1.FileName;
    Save1Click(Sender);
  }
}

//-------------------------------------------------------------------

function New1Click(Sender)
{
var Bitmap;
  with (NewBMPForm)
  {
//    ActiveControl = WidthEdit;
    WidthEdit.Text = IntToStr(Image.Picture.Graphic.Width);
    HeightEdit.Text = IntToStr(Image.Picture.Graphic.Height);
    if (ShowModal == mrOk)
    {
      Bitmap = TBitmap.Create;
      Bitmap.Width = StrToInt(WidthEdit.Text);
      Bitmap.Height = StrToInt(HeightEdit.Text);
      SaveStyles();
      Image.Picture.Bitmap.Assign(Bitmap);
      Bitmap.Free;
      RestoreStyles();
      CurrentFile = "";
    }
  }
}

//-------------------------------------------------------------------

function Copy1Click(Sender)
{
  Clipboard.Assign(Image.Picture);
}

//-------------------------------------------------------------------

function Cut1Click(Sender)
{
var OldBrushColor ;
var OldPenColor;
var OldBrushStyle;
  Copy1Click(Sender)
  with (Image.Canvas)
  {
    OldBrushColor = Brush.Color;
    OldPenColor = Pen.Color;
    OldBrushStyle = Brush.Style;
    Brush.Color = clWhite;
    Brush.Style = bsSolid;
    Pen.Color = clWhite;
    Rectangle(0,0,Image.Width,Image.Height);
    Brush.Color = OldBrushColor;
    Brush.Style  = OldBrushStyle;
    Pen.Color =OldPenColor;
  }
}

//-------------------------------------------------------------------

function Paste1Click(Sender)
{
var Bitmap;
  if (Clipboard.HasFormat(CF_BITMAP))
  {
    Bitmap = TBitmap.Create;
    Bitmap.Assign(Clipboard);
    Image.Canvas.Draw(0, 0, Bitmap);
    Bitmap.Free;
  }
}

//-------------------------------------------------------------------

function SaveStyles()
{
  with (Image.Canvas)
  {
    BrushStyle = Brush.Style;
    PenStyle = Pen.Style;
    PenWide = Pen.Width;
  }
}

//-------------------------------------------------------------------

function RestoreStyles()
{
  with (Image.Canvas)
  {
    Brush.Style = BrushStyle;
    Pen.Style = PenStyle;
    Pen.Width = PenWide;
  }
}