unit l3MetafileContainer;

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. �                 }
{ ������: l3MetafileContainer -       }
{ �����: 17.10.2007 20:01             }
{ $Id: l3MetafileContainer.pas,v 1.21 2009/03/13 18:36:35 lulin Exp $ }

// $Log: l3MetafileContainer.pas,v $
// Revision 1.21  2009/03/13 18:36:35  lulin
// - ������� �����.
//
// Revision 1.20  2008/07/15 20:23:35  lulin
// - ��� ��������� ������� ��������� ���������.
//
// Revision 1.19  2008/07/15 17:12:03  lulin
// - �������� �������� �����������.
// - �������� � ���������� ������ �� ����������, ������� ����� ��������������.
//
// Revision 1.18  2008/07/15 16:53:43  lulin
// - ���������� �������� � <K>: 102957837.
//
// Revision 1.17  2008/07/15 15:48:34  lulin
// - ������� � ����������� ��������, ����� ����������� ���������.
//
// Revision 1.16  2008/07/15 15:38:06  voba
// - bug fix: �� �������� ��������� �� �����.
//
// Revision 1.15  2008/07/15 14:51:43  lulin
// - <K>: 102957837.
//
// Revision 1.14  2007/11/01 10:42:21  fireton
// - ������� ����� ������� � public
//
// Revision 1.13  2007/10/24 15:56:48  lulin
// - ������� ������������� � ���������, ��������� �������� (��������).
//
// Revision 1.12  2007/10/22 13:51:33  lulin
// - �������� �������� � ����� ������ ��������, � �� ����� ������.
//
// Revision 1.11  2007/10/22 12:51:41  lulin
// - ������� ��������� ������ ��������� ��������� ��������� ��������.
//
// Revision 1.10  2007/10/22 12:36:55  lulin
// - ������ ��������� ����� ��� ���������/����������� ����� ��� ����������.
//
// Revision 1.9  2007/10/22 12:25:03  lulin
// - ��� �������� ���.
//
// Revision 1.8  2007/10/22 11:57:11  lulin
// - ������� ��� ���� ������� ��������� �������.
//
// Revision 1.7  2007/10/22 11:31:34  lulin
// - ������� ������� ��������� �������.
//
// Revision 1.6  2007/10/22 11:11:09  lulin
// - bug fix: ������� �� ������������ � ����� ������ � ���� ��������.
//
// Revision 1.5  2007/10/17 17:43:52  lulin
// - ������� ��������� ������ ����� ��������.
//
// Revision 1.4  2007/10/17 17:24:45  lulin
// - ���������� ����� ��������� �������� �� �����.
//
// Revision 1.3  2007/10/17 17:04:49  lulin
// - ������� ����������� ���������� ������� ��������.
//
// Revision 1.2  2007/10/17 16:35:31  lulin
// - ���������� ��������� ��������.
//
// Revision 1.1  2007/10/17 16:07:52  lulin
// - ������ ������ ��� ����������� ���������.
//

{$Include l3Define.inc }

interface

uses
  Classes,
  Graphics,
  
  l3Interfaces,
  l3Units,
  l3InternalInterfaces,
  l3Base,
  l3Metafile,
  l3GraphicContainer
  ;

type
  Tl3MetafileContainer = class(Tl3GraphicContainer)
    protected
    // interface methods
      // Il3Bitmap
      procedure Il3Bitmap_AssignTo(P: TObject);
        override;
        {-}
      function  IsMF: Boolean;
        override;
        {-}
    protected
    // internal methods
      function  pm_GetBitmap: Tl3MetaFile;
        {-}
    public
    // public methods
      function  MakeGraphic: TGraphic;
        override;
        {-}
      function  CanvasToFill: TCanvas;
        override;
        {-}
      procedure FreeCanvas(var C: TCanvas);
        override;
        {-}
      procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);
        override;
        {-}

    public
    // public properties
      property Bitmap: Tl3MetaFile
        read pm_GetBitmap;
        {-}
  end;//Tl3MetafileContainer

implementation

uses
  SysUtils,

  l3Bitmap
  ;

// start class Tl3MetafileContainer

function Tl3MetafileContainer.pm_GetBitmap: Tl3MetaFile;
  {-}
begin
 Result := Tl3MetaFile(Graphic);
end;

function Tl3MetafileContainer.MakeGraphic: TGraphic;
  //override;
  {-}
begin
 Result := Tl3MetaFile.Create;
end;

function Tl3MetafileContainer.CanvasToFill: TCanvas;
  //override;
  {-}
begin
 Result := TMetafileCanvas.Create(Bitmap, 0);
end;

procedure Tl3MetafileContainer.FreeCanvas(var C: TCanvas);
  //override;
  {-}
begin
 FreeAndNil(C);
end;

procedure Tl3MetafileContainer.SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);
  //override;
  {-}
var
 l_B : Tl3Bitmap;  
begin
 if (aFormat = CF_BITMAP) then
 begin
  l_B := Tl3Bitmap.Create;
  try
   Il3Bitmap_AssignTo(l_B);
   l_B.SaveToClipboardFormat(aFormat, aData, aPalette);
  finally
   l3Free(l_B);
  end;//try..finally
 end//aFormat = CF_BITMAP
 else
  inherited;
end;
  
procedure Tl3MetafileContainer.Il3Bitmap_AssignTo(P: TObject);
  {-}
begin
 if (P Is TBitmap) then
 begin
  TBitmap(P).Height := Bitmap.Height;
  TBitmap(P).Width := Bitmap.Width;
  TBitmap(P).Canvas.Draw(0, 0, Bitmap);
 end//P Is TBitmap
 else
  inherited;
end;

function Tl3MetafileContainer.IsMF: Boolean;
  //override;
  {-}
begin
 Result := true;
end;

end.

