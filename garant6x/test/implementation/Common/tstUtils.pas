unit tstUtils;

{------------------------------------------------------------------------------}
{ ���������� : �������� ����;                                                  }
{ �����      : ������� �.�.                                                    }
{ �����      : 03.04.2006 16.48;                                               }
{ ������     : tstUtils                                                        }
{ ��������   : ����� ��������� � ������� ������������ �������� �����;          }
{------------------------------------------------------------------------------}

// $Id: tstUtils.pas,v 1.5 2006/04/10 09:29:21 mmorozov Exp $
// $Log: tstUtils.pas,v $
// Revision 1.5  2006/04/10 09:29:21  mmorozov
// - add comment;
//
// Revision 1.4  2006/04/10 09:28:42  mmorozov
// - bugfix: ���� �������� � �������������� ������������ �� ������ � ������;
//
// Revision 1.3  2006/04/04 07:59:15  mmorozov
// - new: ������������� ������� ������ + � ������ ��������� ��������� ������ ��������� ������� DataReceived;
//
// Revision 1.2  2006/04/03 14:06:15  mmorozov
// - new: ����������� ������, ����������� ������;
//
// Revision 1.1  2006/04/03 10:49:30  mmorozov
// - new: �������� ������� tstFileToStream;
//

interface

uses
  ActiveX
  ;

function tstFileToStream(const aFileName : String;
                         const aDest     : IStream): Boolean;
  {* - �������� ���� � �����. }
function tstReadStream(const aStream  : IStream;
                       const aSuccess : PBoolean = nil): String;
  {* - ���������� ��������� �� ������ � �������� ����������. }

implementation

uses
  SysUtils,
  Classes
  ;

function tstReadStream(const aStream  : IStream;
                       const aSuccess : PBoolean = nil): String;
  {* - ���������� ����������� �� ������ � �������� ����������. }
const
 c_BufferSize = 512;
var
 l_Written : Longint;
 l_Result  : HRESULT;
 l_Str     : String;
begin
 Result := '';
 if Assigned(aSuccess) then
  aSuccess^ := False;
 if Assigned(aStream) then
 begin
  SetLength(l_Str, c_BufferSize);
  while True do
  begin
   l_Result := aStream.Read(@l_Str[1], c_BufferSize, @l_Written);
   if l_Result <> S_OK then
   begin
    if (l_Result = S_FALSE) and Assigned(aSuccess) then
     aSuccess^ := True;
    Break;
   end;//if l_Result <> S_OK then
   if l_Written < c_BufferSize then
    Result := Result + Copy(l_Str, 1, l_Written)
   else
    Result := Result + l_Str;
  end;//while True do
 end;//if Assigned(aStream) then
end;//tstReadStream

function tstFileToStream(const aFileName : String;
                         const aDest     : IStream): Boolean;
var
 l_FileStream : TFileStream;
 l_Stream     : IStream;
 l_Read       : Int64;
 l_Written    : Int64;
begin
 Result := False;
 if Assigned(aDest) and FileExists(aFileName) then
 begin
  l_FileStream := TFileStream.Create(aFileName, fmOpenRead);
  try
   if Supports(TStreamAdapter.Create(l_FileStream), IStream, l_Stream) then
   try
    Result := l_Stream.CopyTo(aDest, l_FileStream.Size, l_Read,
     l_Written) = S_OK;
   finally
    l_Stream := nil;
   end;{try..finally}
  finally
   FreeAndNil(l_FileStream);
  end;{try..finally}
 end;//if Assigned(aStream)..
end;//tstFileToStream

end.