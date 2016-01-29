unit l3BitmapContainer;

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. �                 }
{ ������: l3BitmapContainer -         }
{ �����: 03.11.2004 13:06             }
{ $Id: l3BitmapContainer.pas,v 1.18 2008/07/15 20:23:35 lulin Exp $ }

// $Log: l3BitmapContainer.pas,v $
// Revision 1.18  2008/07/15 20:23:35  lulin
// - ��� ��������� ������� ��������� ���������.
//
// Revision 1.17  2008/07/15 16:53:43  lulin
// - ���������� �������� � <K>: 102957837.
//
// Revision 1.16  2007/11/29 08:27:57  lulin
// - ������ �������� �� ������ ����������� � PNG.
//
// Revision 1.15  2007/10/22 14:23:55  lulin
// - ������ �������� ���� ����������� ���� � ��������� - ������� ������ �� ���� �� ���� ����������.
//
// Revision 1.14  2007/10/22 13:01:49  lulin
// - ��������� ����� ��������� �� ������� �����.
//
// Revision 1.13  2007/10/22 12:51:41  lulin
// - ������� ��������� ������ ��������� ��������� ��������� ��������.
//
// Revision 1.12  2007/10/22 12:36:55  lulin
// - ������ ��������� ����� ��� ���������/����������� ����� ��� ����������.
//
// Revision 1.11  2007/10/22 12:25:03  lulin
// - ��� �������� ���.
//
// Revision 1.10  2007/10/22 12:11:20  lulin
// - cleanup.
//
// Revision 1.9  2007/10/22 11:57:11  lulin
// - ������� ��� ���� ������� ��������� �������.
//
// Revision 1.8  2007/10/22 11:31:34  lulin
// - ������� ������� ��������� �������.
//
// Revision 1.7  2007/08/02 16:08:51  lulin
// - bug fix: �� ��������� �������.
//
// Revision 1.6  2007/03/30 12:38:13  lulin
// - ����� ��������� �� ������.
//
// Revision 1.5  2006/12/15 11:04:13  lulin
// - ��������� �������� �� ��������� ������.
//
// Revision 1.4  2006/12/15 10:59:36  lulin
// - ��� ������������� �������� ������ �� DnD ����� ������ �������������.
//
// Revision 1.3  2004/11/03 14:21:12  lulin
// - ����������� ������ Il3Bitmap.Assign � _AssignTo.
//
// Revision 1.2  2004/11/03 13:41:39  voba
// - new method: Tl3BitmapContainer._Make.
//
// Revision 1.1  2004/11/03 10:14:36  lulin
// - new unit: l3BitmapContainer.
//
// Revision 1.3  2000/12/15 15:13:40  law
// - ��������� ��������� Log.
//

{$Include l3Define.inc }

interface

uses
  Windows,

  Classes,
  Graphics,

  l3Types,
  l3InternalInterfaces,
  l3Base,
  l3GraphicContainer,
  l3Units,
  l3Bitmap
  ;

type
  Tl3BitmapContainer = class(Tl3GraphicContainer)
   {* - ������ - ��������� ��� �������� (TBitmap). }
    protected
    // property methods
      function  pm_GetBitmap: Tl3Bitmap;
        {-}
      function  pm_GetCanvas: Il3Canvas;
        {-}
    protected
    // internal methods
      function  CanvasToFill: TCanvas;
        override;
        {-}
      procedure FreeCanvas(var C: TCanvas);
        override;
        {-}
      procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);
        override;
        {-}
      procedure Il3Bitmap_AssignTo(P: TObject);
        override;
        {-}
    public
    // public methods
      function  MakeGraphic: TGraphic;
        override;
        {-}
    public
    // public properties
      property Bitmap: Tl3Bitmap
        read pm_GetBitmap;
        {-}
      property Canvas: Il3Canvas
        read pm_GetCanvas;
        {-}
  end;//Tl3BitmapContainer

implementation

uses
  Forms,

  l3Metafile
  ;

// start class Tl3BitmapContainer

function Tl3BitmapContainer.CanvasToFill: TCanvas;
  //override;
  {-}
begin
 Result := Bitmap.Canvas;
end;

procedure Tl3BitmapContainer.FreeCanvas(var C: TCanvas);
  //override;
  {-}
begin
 C := nil;
end;

procedure Tl3BitmapContainer.SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);
  //override;
  {-}
var
 l_B : Tl3MetaFile;
begin
 if (aFormat = CF_ENHMETAFILE) then
 begin
  l_B := Tl3MetaFile.Create;
  try
   Il3Bitmap_AssignTo(l_B);
   l_B.SaveToClipboardFormat(aFormat, aData, aPalette);
  finally
   l3Free(l_B);
  end;//try..finally
 end//aFormat = CF_ENHMETAFILE
 else
  inherited;
end;
  
procedure Tl3BitmapContainer.Il3Bitmap_AssignTo(P: TObject);
  {-}
const
 c_Inch = 2540;
var
 l_C : TMetafileCanvas;
begin
 if (P Is TMetafile) then
 begin
  TMetafile(P).Width := Bitmap.Width;
  TMetafile(P).Height := Bitmap.Height;
  TMetafile(P).MMWidth := Bitmap.Width * c_Inch div Screen.PixelsPerInch;//mm*100
  TMetafile(P).MMHeight := Bitmap.Height * c_Inch div Screen.PixelsPerInch;
  l_C := TMetafileCanvas.Create(TMetafile(P), 0);
  try
   l_C.Draw(0, 0, Bitmap);
  finally
   l3Free(l_C);
  end;//try..finally
 end//P Is TBitmap
 else
  inherited;
end;

function Tl3BitmapContainer.pm_GetBitmap: Tl3Bitmap;
  {-}
begin
 Result := Tl3Bitmap(Graphic);
end;

function Tl3BitmapContainer.pm_GetCanvas: Il3Canvas;
  {-}
begin
 Result := Bitmap.CanvasEx;
end;

function Tl3BitmapContainer.MakeGraphic: TGraphic;
  //override;
  {-}
begin
 Result := Tl3Bitmap.Create;
 Tl3Bitmap(Result).PixelFormat := pf24bit;
end;

end.

