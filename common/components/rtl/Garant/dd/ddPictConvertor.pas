//..........................................................................................................................................................................................................................................................
unit ddPictConvertor;

// $Id: ddPictConvertor.pas,v 1.15 2006/12/15 11:44:07 lulin Exp $ 

// $Log: ddPictConvertor.pas,v $
// Revision 1.15  2006/12/15 11:44:07  lulin
// - ��������� �������� �� ��������� ������.
//
// Revision 1.14  2006/12/15 11:40:49  lulin
// - ��������� �������� �� ��������� ������.
//
// Revision 1.13  2006/12/15 11:30:45  lulin
// - ��������� �������� �� ��������� ������.
//
// Revision 1.12  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.11  2004/07/09 12:05:02  fireton
// - change: ����������� ConvertStreamToBitmap - �������� � ������ ��������
//
// Revision 1.10  2004/01/13 15:41:30  narry
// - cleanup
//
// Revision 1.9  2004/01/13 15:40:38  narry
// - update: ������ ����������� �������� � Envision �� ImageEn
//
// Revision 1.8  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.7  2002/12/24 13:01:59  law
// - change: ��������� Int64_Seek c �������� ������.
//
// Revision 1.6.6.1  2002/12/24 11:56:42  law
// - new behavior: ���������� 64-������ Seek ������ 32-�������.
//
// Revision 1.6  2001/07/03 08:51:02  narry
// -update: ������ ������������ ���������� Jpeg �� ��������� ��
//    ���������� Envision
//
// Revision 1.5  2001/07/03 08:44:58  narry
// -update: ������ ������������ ���������� Jpeg �� ��������� ��
//    ���������� Envision
//
// Revision 1.4  2000/12/15 15:29:54  law
// - ��������� ��������� Log � Id.
//

{$I ddDefine.inc }

interface

uses
  Classes,
  Graphics,
  l3Base
  ;

type
  TddFormatConverter = class(Tl3Base)
  public
    procedure ConvertStream(InStream, OutStream: TStream);
    { ��������������� ������� ����� � ������������ ������� � �������� ����� � ������� BMP }
    function CreateBitmapFromStream(InStream: TStream): TBitmap;
    { ������� TBitmap �� ����������� ������ ������������� ������� }
    procedure ConvertStreamToBitmap(Bitmap: TBitmap; InStream: TStream);
    { ��������� �������� �� ����������� ������ � ���������� TBitmap }
  end;//TddFormatConverter

implementation

uses
  l3Memory,
  l3Bitmap,

  ImageEnIO
  ;

procedure TddFormatConverter.ConvertStream(InStream, OutStream: TStream);
var
 l_Detector: TImageEnIO;
begin
 l_Detector:= TImageEnIO.Create(nil);
 try
  l_Detector.LoadFromStream(InStream);
  l_Detector.SaveToStreamBMP(OutStream);
  OutStream.Seek(0, soBeginning);
 finally
  l3Free(l_Detector);
 end;
end;

procedure TddFormatConverter.ConvertStreamToBitmap(Bitmap: TBitmap; InStream: TStream);
var
 l_Detector: TImageEnIO;
begin
 l_Detector := TImageEnIO.Create(nil);
 try
  l_Detector.AttachedBitmap := Bitmap;
  InStream.Seek(0,0);
  l_Detector.LoadFromStream(InStream);
 finally
  l3Free(l_Detector);
 end;
end;

function TddFormatConverter.CreateBitmapFromStream(InStream: TStream): TBitmap;
var
 l_B: TBitmap;
begin
 l_B:= Tl3Bitmap.Create;
 ConvertStreamToBitmap(l_B, InStream);
 Result:= l_B;
end;

end.
