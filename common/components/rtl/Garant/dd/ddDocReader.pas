//..........................................................................................................................................................................................................................................................
unit ddDocReader;

{ ���������� "Readers & Writers" }
{ �����: ����� �.�. �            }
{ ������: ddDocReader - �����-������ ��� ������ ������ MS Word }
{ �����: 01.02.2000 11:59        }
{ $Id: ddDocReader.pas,v 1.46 2015/10/28 08:31:18 fireton Exp $ }


// $Log: ddDocReader.pas,v $
// Revision 1.46  2015/10/28 08:31:18  fireton
// - ���������� ���
//
// Revision 1.45  2015/08/26 11:52:19  fireton
// - ������ ������ ��� � Assert
//
// Revision 1.44  2013/08/26 14:11:53  lulin
// - �������� ������� �������� ����������.
//
// Revision 1.43  2012/11/09 08:52:29  narry
// ������� ����� � �������� ������ (407750788)
//
// Revision 1.42  2012/09/04 09:40:24  fireton
// - ������������ �������� ����������� DOC � DOCX
//
// Revision 1.41  2012/08/30 14:20:41  lulin
// {RequestLink:390564295}
//
// Revision 1.40  2012/08/29 10:25:36  fireton
// - ��������� ������ DOC � DOCX �� DLL �� Sub Systems (K 388859727)
//
// Revision 1.39  2012/03/13 10:06:41  narry
// ������� ��� �����
//
// Revision 1.38  2010/03/10 13:57:24  narry
// - �� ����������
//
// Revision 1.37  2009/05/29 11:35:04  narry
// - ���������� ������ ������ ����������
//
// Revision 1.36  2009/03/03 15:47:36  voba
// - ����� ������ �������� ������ ����� dll �����������. ������ ��� dll ������ � ������ ������. ������ �������������� ������ ����� Word OLE ��� ����� - ��� ������ doc ������
//
// Revision 1.35  2007/08/28 13:59:51  lulin
// - bug fix: �� ��������� �������.
//
// Revision 1.34  2007/08/14 14:30:05  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.33  2005/07/18 06:43:51  mmorozov
// - warning fix;
//
// Revision 1.32  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.31  2004/09/21 12:21:04  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.30  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.29  2002/12/24 13:01:59  law
// - change: ��������� Int64_Seek c �������� ������.
//
// Revision 1.28.6.2  2002/12/24 11:56:42  law
// - new behavior: ���������� 64-������ Seek ������ 32-�������.
//
// Revision 1.28.6.1  2002/12/23 15:51:25  law
// - bug fix: �� �������� � ���������� > 2��.
//
// Revision 1.28  2002/05/23 11:22:56  law
// -bug fix: �������� ������������ ����������� Narry.
//
// Revision 1.27  2002/05/20 14:24:12  law
// - new behavior: �������� ������������ ��� ����������.
//
// Revision 1.26  2002/05/20 14:14:38  narry
// - bug fix: ������ ��� ������ DOC-����� (����� �� ��������� �� ������)
//
// Revision 1.25  2002/04/22 07:52:14  law
// - new behavior: ��� ����������� ����� Word ���� �� �������� � MRU.
//
// Revision 1.24  2002/04/16 12:06:13  law
// - new behavior: ���� �� ��������� ����� ����������, �� ������ ����� Word.
//
// Revision 1.23  2002/03/27 17:09:33  law
// - bug fix.
//
// Revision 1.22  2001/09/28 07:11:28  narry
// - bug fix: ���� ������ � ������� ��� ������ �����.
//
// Revision 1.21  2001/08/30 16:34:45  law
// - new version: ���������� �� Delphi 6.
//
// Revision 1.20  2000/12/15 15:29:53  law
// - ��������� ��������� Log � Id.
//

{$I ddDefine.inc }
{.$DEFINE WriteSource}


interface

{$IfNDef Nemesis}
{$IfNDef NoZIP}
uses
  Windows,
  Classes,

  l3Types,
  l3Base,
  l3Memory,
  l3Except,

  k2TagGen,

  ddRTFReader
  ;

const
  def_UseOle = false;

type
  TddCustomDocReader = class(TddRTFReader)
    private
    {property fields}
    public
    {public methods}
        {-}
      procedure Execute;
        override;
        {-}
    public
    {public properties}
        {-}
  end;{TddCustomDocReader}

  TddDocReader = class(TddCustomDocReader)
    published
      property Filer;
        {-}
      property Generator;
        {-}
  end;{TddDocReader}

  EddDocReaderError = class(El3ReadError);
{$EndIf NoZIP}  
{$EndIf Nemesis}

implementation

{$IfNDef Nemesis}
{$IfNDef NoZIP}
uses
 SysUtils,

 l3Stream,
 l3Filer,

 ddFileFormats,
 ddDoc2Rtf
;

procedure TddCustomDocReader.Execute;
  {override;}
  {-}
var
 l_Type      : TddFileFormat;
 l_IsConvAvail : Boolean;
 l_RTFHandle : THandle;
 l_RTFSize: Integer;
 l_OldFiler, l_ProxyFiler: Tl3CustomFiler;
 l_RTFStream: Tl3HMemoryStream;
 l_Size: Integer;
 l_IStream    : IStream;
 l_FilerStream: TStream;
 //l_File : Tl3FileStream;

begin
 Filer.Mode := l3_fmRead;
 Filer.Open;
 try
  if not Supports(Filer, IStream, l_IStream) then
   raise El3Error.Create('TddCustomDocReader.Execute: Filer �� ������������ IStream!');
  l3IStream2Stream(l_IStream, l_FilerStream);
  try
   l_Type := ddGetFileFormat(l_FilerStream);

   if l_Type in [ffRTF, ffDOC, ffDOCX] then
   begin
    if l_Type = ffRTF then
     inherited
    else
    begin
     case l_Type of
      ffDoc  : l_IsConvAvail := IsDocConvertAvailable;
      ffDocx : l_IsConvAvail := IsDocxConvertAvailable;
     end;
     if l_IsConvAvail then
     begin
      case l_Type of
       ffDoc  : l_RTFHandle := ConvertDocFromStream(l_FilerStream);
       ffDocx : l_RTFHandle := ConvertDocxFromStream(l_FilerStream);
      end;
      if l_RTFHandle <> 0 then
      begin
       l_OldFiler := Filer.Use;
       try
        l_ProxyFiler := Tl3CustomFiler.Create;
        try
         l_ProxyFiler.OnCheckAbortedLoad := l_OldFiler.OnCheckAbortedLoad;
         l_RTFStream := Tl3HMemoryStream.Create(l_RTFHandle);
         try
          (*
          l_File := Tl3FileStream.Create('c:\temp\saved.rtf', l3_fmWrite);
          try
           l_File.CopyFrom(l_RTFStream, l_RTFStream.Size);
           l_RTFStream.Seek(0, soFromBeginning);
          finally
           FreeAndNil(l_File);
          end; (* *)

          l_ProxyFiler.Stream := l_RTFStream;
          Filer := l_ProxyFiler;
          l_ProxyFiler.Mode := l3_fmRead;
          l_ProxyFiler.Open;
          try
           inherited;
          finally
           l_ProxyFiler.Close;
          end;
         finally
          FreeAndNil(l_RTFStream);
          GlobalFree(l_RTFHandle);
         end;
        finally
         FreeAndNil(l_ProxyFiler);
        end;
       finally
        Filer := l_OldFiler;
        FreeAndNil(l_OldFiler);
       end;
      end
      else
       raise EddDocReaderError.CreateFmt('������ ������: �� ������� ��������������� �������� (%s)', [c_SFileFormat[l_Type]]);
     end
     else
      raise EddDocReaderError.CreateFmt('������ ������: ��������� %s ����������', [c_SFileFormat[l_Type]]);
    end;
   end
   else
    raise EddDocReaderError.CreateFmt('������ ������: �������� ������ ������ (%s)', [c_SFileFormat[l_Type]]);
  finally
   FreeAndNil(l_FilerStream);
  end;
 finally
  Filer.Close;
 end;{try..finally}
end;
{$EndIf NoZIP}
{$EndIf Nemesis}

end.

