Unit ddPictDetector;

// $Id: ddPictDetector.pas,v 1.15 2016/09/14 11:40:10 lulin Exp $ 

// $Log: ddPictDetector.pas,v $
// Revision 1.15  2016/09/14 11:40:10  lulin
// - подтачиваем.
//
// Revision 1.14  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.13  2007/08/14 14:30:05  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.12  2006/12/15 11:30:45  lulin
// - добавлена картинка со счетчиком ссылок.
//
// Revision 1.11  2004/09/21 12:21:05  lulin
// - Release заменил на Cleanup.
//
// Revision 1.10  2004/04/05 11:15:05  narry
// - update: подчистка артефактов использования предыдущей графической библиотеки
//
// Revision 1.9  2003/11/06 15:15:05  narry
// - bug fix: сохранение картинки в RTF. Реализовано для BMP
//
// Revision 1.8  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.7  2000/12/15 15:29:54  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

Uses
  Classes,
  l3Types,
  l3ProtoObject,
  l3Base,
  ddConst
  ;

type
  TddPictureFormatDetector = class(Tl3ProtoObject)
  private
    f_PictureFormat: Longint;
    f_Height: Longint;
    f_Width: Longint;
    f_BPP: Integer;
  protected
    procedure Cleanup; override;
   procedure BMPDimension(aStream: TStream);
  public
    constructor Create;

    function Check(Stream: TStream): Boolean; overload;
    function Check(FileName: AnsiString): Boolean; overload;

    property PictureFormat: Longint
      read f_PictureFormat write f_PictureFormat;
    property Height: Longint
     read f_Height;
    property Width: Longint
     read f_Width;
    property BPP: Integer
     read f_BPP;
  end;



implementation
Uses
  SysUtils, Graphics,
  l3Bitmap,
  l3Stream;

constructor TddPictureFormatDetector.Create;
begin
  inherited;
  f_PictureFormat:= 0;
end;

procedure TddPictureFormatDetector.Cleanup;
begin

  inherited;
end;


const
  sigBMP   = 'BM';
  sigGIF   = 'GIF';
  sigJPG   = $FFD9FFE0;
  sigJPG1  = $FFD8FFE0;
  sigJPG2  = $E0FFD8FF;
  sigPNG   = $89;
  sigTIFF  = 'II';
  sigTIFF2 = 'MM';
  sigWMF   = $9AC6CDD7;
  sigPCX   = $0A;
  sigICO   = #0#0#1;

type
  TBufArray = Array[0..7] of Char;

function InnerCheck(B: TBufArray): Longint;
var
  S: AnsiString;
  DW: LongWord;
begin
  SetLength(S, SizeOf(B));
  l3Move(B, S[1], SizeOf(B));
  l3Move(B, DW, SizeOf(longword));
  if Pos(sigBMP, S) = 1 then
    Result:= pictBMP
  else
  if Pos(sigGIF, S) = 1 then
    Result:= pictGIF
  else
  if (DW = sigJPG) or (DW = sigJPG1) or (DW = sigJPG2) then
    Result:= pictJPG
  else
  if ord(B[0]) = sigPNG then
    Result:= pictPNG
  else
  if (Pos(sigTIFF, S) = 1) or (Pos(sigTIFF2, S) = 1) then
    Result:= pictTIFF
  else
  if DW = sigWMF then
    Result:= pictWMF
  else
  if ord(B[0]) = sigPCX then
    Result:= pictPCX
  else
  if Pos(sigICO, S) = 1 then
    Result:= pictICO
  else Result:= pictNONE;
end;

function TddPictureFormatDetector.Check(Stream: TStream): Boolean;
var
  Buf: TBufArray;
begin
  f_PictureFormat:= 0;
  Stream.Position:= 0;
  Stream.Read(Buf, SizeOf(Buf));
  Stream.Position:= 0;
  f_PictureFormat:= InnerCheck(Buf);
  case f_PictureFormat of
   pictBMP: BMPDimension(Stream);
  end;
  Result:= F_PictureFormat <> pictNONE;
end;

function TddPictureFormatDetector.Check(FileName: AnsiString): Boolean;
var
  S: TStream;
begin
  S:= Tl3FileStream.Create(FileName, l3_fmRead);
  try
    Result:= Check(S);
  finally
    l3Free(S);
  end;
end;

procedure TddPictureFormatDetector.BMPDimension;
var
 l_Bitmap: TBitmap;
begin
 l_Bitmap:= Tl3Bitmap.Create;
 try
  aStream.Position:= 0;
  l_Bitmap.LoadFromStream(aStream);
  aStream.Position:= 0;
  f_Width:= l_Bitmap.Width;
  f_Height:= l_Bitmap.Height;
  case l_Bitmap.PixelFormat of
   pf4bit : f_BPP:= 4;
   pf8bit : f_BPP:= 8;
   pf15bit: f_BPP:= 15;
   pf16bit: f_BPP:= 16;
   pf24bit: f_BPP:= 24;
   pf32bit: f_BPP:= 32;
  else
   f_BPP:= 1;
  end;
 finally
  l3Free(l_Bitmap);
 end;
end;

end.
