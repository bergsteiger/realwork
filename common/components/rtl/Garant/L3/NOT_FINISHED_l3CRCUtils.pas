unit NOT_FINISHED_l3CRCUtils;

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3CRCUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3CRCUtils" MUID: (546F0E690374)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , Classes
;

function l3CalcCRC32(aStream: TStream;
 ReadOffset: Int64 = 0;
 ReadSize: Int64 = -1): Cardinal;
procedure l3AccumulateBufferCRC32(var theCRC: Cardinal;
 aBuffer: Pointer;
 aSize: Cardinal);

implementation

uses
 l3ImplUses
 //#UC START# *546F0E690374impl_uses*
 //#UC END# *546F0E690374impl_uses*
;

function l3CalcCRC32(aStream: TStream;
 ReadOffset: Int64 = 0;
 ReadSize: Int64 = -1): Cardinal;
//#UC START# *546F0E81033E_546F0E690374_var*
const
 c_BufLen = 32 * 1024;
var
 l_TotalBytes: LongWord;
 l_BytesToRead: LongWord;
 l_ActualRead : LongWord;
 l_Buf: array[1..c_BufLen] of Byte;
 I: Integer;
//#UC END# *546F0E81033E_546F0E690374_var*
begin
//#UC START# *546F0E81033E_546F0E690374_impl*
 aStream.Seek(0, soBeginning);
 l_TotalBytes := aStream.Size;
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
//#UC END# *546F0E81033E_546F0E690374_impl*
end;//l3CalcCRC32

procedure l3AccumulateBufferCRC32(var theCRC: Cardinal;
 aBuffer: Pointer;
 aSize: Cardinal);
//#UC START# *5810646503C4_546F0E690374_var*
//#UC END# *5810646503C4_546F0E690374_var*
begin
//#UC START# *5810646503C4_546F0E690374_impl*
 !!! Needs to be implemented !!!
//#UC END# *5810646503C4_546F0E690374_impl*
end;//l3AccumulateBufferCRC32

end.
