unit l3CRCUtils;

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes
  ;


function l3CalcCRC32(aStream: TStream;
 ReadOffset: Int64 = 0;
 ReadSize: Int64 = -1): Cardinal;

procedure l3AccumulateBufferCRC32(var theCRC: Cardinal;
 aBuffer: Pointer;
 aSize: Cardinal);

implementation

// unit methods

uses zlibh;

function l3CalcCRC32(aStream: TStream; ReadOffset: Int64 = 0; ReadSize: Int64 = -1): Cardinal;
const
 c_BufLen = 32 * 1024;
var
 l_TotalBytes: Int64;
 l_BytesToRead: LongWord;
 l_ActualRead : LongWord;
 l_Buf: array[1..c_BufLen] of Byte;
 I: Integer;
begin
 aStream.Seek(ReadOffset, soBeginning);
 l_TotalBytes := aStream.Size - aStream.Position;
 if (ReadSize >= 0) and (l_TotalBytes > ReadSize) then
  l_TotalBytes := ReadSize;
 Result := zlibh.crc32(0, nil, 0);
 while l_TotalBytes > 0 do
 begin
  if l_TotalBytes > c_BufLen then
   l_BytesToRead := c_BufLen
  else
   l_BytesToRead := l_TotalBytes;
  l_ActualRead := aStream.Read(l_Buf, l_BytesToRead);
  if l_ActualRead <> l_BytesToRead then
   raise EReadError.Create('FileReadError');
  Result := zlibh.crc32(Result, @l_Buf, l_BytesToRead);
  l_TotalBytes := l_TotalBytes - l_BytesToRead;
 end;
end;//L3CalcCRC32

procedure l3AccumulateBufferCRC32(var theCRC: Cardinal;
 aBuffer: Pointer;
 aSize: Cardinal);
begin
 theCRC := zlibh.crc32(theCRC, aBuffer, aSize);
end;//l3AccumulateBufferCRC32

end.