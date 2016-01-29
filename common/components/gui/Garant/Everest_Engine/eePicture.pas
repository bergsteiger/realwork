unit eePicture;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eePicture -     }
{ Начат: 12.02.2003 18:34 }
{ $Id: eePicture.pas,v 1.1 2015/01/20 11:54:23 lulin Exp $ }

// $Log: eePicture.pas,v $
// Revision 1.1  2015/01/20 11:54:23  lulin
// - правим зависимости.
//
// Revision 1.1  2014/12/09 14:16:03  kostitsin
// {requestlink: 580710238 }
//
// Revision 1.7  2014/12/05 14:51:04  kostitsin
// {requestlink: 570118718 } - eeInterfaces
//
// Revision 1.6  2009/04/06 17:51:28  lulin
// [$140837386]. №11.
//
// Revision 1.5  2007/12/04 12:47:33  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.4.8.7  2007/09/14 13:26:09  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.4.8.6.2.1  2007/09/12 19:56:50  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.4.8.6  2007/09/03 12:29:06  lulin
// - переименовываем тег.
//
// Revision 1.4.8.5  2007/04/18 11:00:13  oman
// warning fix
//
// Revision 1.4.8.4  2007/02/16 17:54:08  lulin
// - избавляемся от стандартного строкового типа.
//
// Revision 1.4.8.3  2006/11/03 11:00:11  lulin
// - объединил с веткой 6.4.
//
// Revision 1.4.8.2.22.1  2006/10/26 11:24:15  lulin
// - избавляемся от лишних преобразований типов.
//
// Revision 1.4.8.2  2005/10/28 09:31:30  lulin
// - cleanup.
//
// Revision 1.4.8.1  2005/10/28 08:21:42  lulin
// - bug fix: не открывались картинки по ссылке.
//
// Revision 1.4  2005/03/19 16:39:54  lulin
// - спрятаны ненужные методы.
//
// Revision 1.3  2003/11/06 11:27:08  law
// - new prop: IeePicture.Name.
//
// Revision 1.2  2003/11/05 15:54:40  law
// - new method: IeePicture.SaveToStream.
//
// Revision 1.1  2003/02/12 15:50:20  law
// - new interface: IeePicture.
// - new unit: eePicture.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Base,

  eeInterfaces,
  eePara
  ;

type
  TeePicture = class(TeePara, IeePicture)
    private
    // interface methods
      // IeePicture
      function  Get_Name: Il3CString;
        {-}
      procedure SaveToStream(const aStream: IStream);
        {-}
  end;//TeePicture

implementation

uses
  k2Base,
  k2Tags
  ;

// start class TeePicture

function TeePicture.Get_Name: Il3CString;
  {-}
begin
 Result := l3CStr(TagInst.PCharLenA[k2_tiShortName]);
end;

procedure TeePicture.SaveToStream(const aStream: IStream);
  {-}
var
 l_Stream   : IStream;
 l_Read     : Int64;
 l_Written  : Int64;
 l_Position : Int64;
begin
 with TagInst.Attr[k2_tiData] do
  if IsValid AND l3IOk(QueryInterface(IStream, l_Stream)) then
   try
    l_Stream.Seek(0, STREAM_SEEK_SET, l_Position);
    l_Stream.CopyTo(aStream, High(Int64), l_Read, l_Written);
   finally
    l_Stream := nil;
   end;{try..finally}
end;
  
end.

