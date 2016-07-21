unit IOUnit;
 {* ����� ����������� �����-������ }

// ������: "w:\shared\tie\Garant\GCI\IOUnit.pas"
// ���������: "Interfaces"
// ������� ������: "IO" MUID: (4423F94903C8)

interface

uses
 l3IntfUses
;

type
 OperationError = class
  {* �� ����� ���������� �������� copy_to ���� �� �������, ������������� � �������� ������� � ������������ ���������. }
 end;//OperationError

 NotImplemented = class
  {* ������� �� ����������� }
 end;//NotImplemented

 IString = interface
  {* ��������� ��� ������ �� ��������. ��������������� ������������ ������ ���� ��� ��� ������ �� ����� ���������� �������. }
  ['{952E8D0E-1685-49D2-BFDB-D854F4BF0156}']
  function GetLength: Cardinal; stdcall;
  function GetMaximum: Cardinal; stdcall;
  procedure SetMaximum(aValue: Cardinal); stdcall;
  function GetData: PAnsiChar; stdcall;
  function GetCodePage: short; stdcall;
  procedure SetCodePage(aValue: short); stdcall;
  procedure Reset(var str: PAnsiChar;
   maximum: Cardinal); overload; stdcall;
   {* ����������� ���������� ������. ���� ��������, �������� �����, ������ ��� strlen(str) + 1, �� ����� ������ ����������� ������ ����� ������ + 1. ������ ��� ������������ �������� str ������ ���� �������� ���������� new[], ��� ��� � ����������� ���������� �������� delete[]. }
  procedure Reset(str: PAnsiChar); overload; stdcall;
   {* ������������� �������� ������ ������ ����������� (���������� ������ �����������) }
  procedure Strdup(out aRet
   {* IString }); stdcall;
   {* ���������� �������� ����� ������ }
  function Add(str: PAnsiChar): PAnsiChar; overload; stdcall;
   {* ��������� � ������ ���������� ���������, ���������� ��������� �� ���� ����� }
  function Add(const str: IString): PAnsiChar; overload; stdcall;
   {* ��������� � ������ ���������� ���������, ���������� ��������� �� ���� ����� }
  function Join(str: PAnsiChar): PAnsiChar; overload; stdcall;
   {* ���������� ����� ������ ������ ����������� ������� � ���������� }
  function Join(const str: IString): PAnsiChar; overload; stdcall;
   {* ���������� ����� ������ ������ ����������� ������� � ���������� }
  property Length: Cardinal
   read GetLength;
   {* ������ ��������� ������ }
  property Maximum: Cardinal
   read GetMaximum
   write SetMaximum;
   {* ������ �������������� ������, ��� �������� ��������� ������ }
  property Data: PAnsiChar
   read GetData;
   {* ��������� �� ������ ��������������� ������ (������) }
  property CodePage: short
   read GetCodePage
   write SetCodePage;
   {* ������� �������� }
 end;//IString

 TStreamSeekDirection = (
  {* ����� �� ������� ��������� ��������. ��������� ������ ��������� �� �������� � MSDN-������� }
  SSD_BEGIN
   {* �������� ������������ ������ ������ }
  , SSD_CURRENT
   {* �������� ������������������� ������� � ������ }
  , SSD_END
   {* �������� ������������ ����� ������ }
 );//TStreamSeekDirection

 IStream = interface
  {* ��������� ��� ������ � ������� }
  ['{D99F458B-CF9F-4286-AD02-59ABA1662465}']
  function Read(var buffer: pointer;
   size: Cardinal): Cardinal; stdcall; { can raise OperationError }
   {* �������� ������ �� ������, ���������� ���������� ����������� ������. }
  function Write(buffer: pointer;
   size: Cardinal): Cardinal; stdcall;
   {* �������� ������ � �����. ���������� ���������� ���������� ������. }
  function Seek(offset: Integer;
   whence: Cardinal): Cardinal; stdcall; { can raise OperationError, NotImplemented }
   {* ����������� ������ ������. ���������� ����� ���� �� ������ ������. }
  procedure CopyTo(var dst: IStream;
   size: Cardinal;
   out actually_read: unsigned long long;
   out actually_written: unsigned long long); stdcall; { can raise OperationError }
   {* �������� ������ �� ������ ������ � ������. }
  function Eof: ByteBool; stdcall;
   {* ������� ���������� true ���� ��������� ����� ������. }
  function Bad: ByteBool; stdcall;
   {* ���� ������������ true, ���������� ������ � ������� ���������� }
  procedure Clear; stdcall;
   {* ������ ����� ������ }
 end;//IStream

 TDateTimeBox = record
  {* ��� ������������� �������� ������� ����� ������� �������, �����������. }
  day: short;
   {* ���� � ������ (1-31) }
  mounth: short;
   {* ����� � ���� (1-12) }
  year: short;
   {* ��� }
  hour: short;
   {* ��� (0-23) }
  minute: short;
   {* ������ � ���� (0-59) }
  second: short;
   {* ������� � ������ (0-59) }
  millisecond: short;
   {* ������������ (0-999) }
 end;//TDateTimeBox

implementation

uses
 l3ImplUses
;

end.
