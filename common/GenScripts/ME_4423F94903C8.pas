unit IOUnit;
 {* ����� ����������� �����-������ }

// ������: "w:\shared\tie\Garant\GCI\IOUnit.pas"
// ���������: "Interfaces"

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
  function Get_length: Cardinal;
  function Get_maximum: Cardinal;
  procedure Set_maximum(aValue: Cardinal);
  function Get_data: PAnsiChar;
  function Get_code_page: short;
  procedure Set_code_page(aValue: short);
  procedure reset(var str: PAnsiChar;
   maximum: Cardinal); overload;
   {* ����������� ���������� ������. ���� ��������, �������� �����, ������ ��� strlen(str) + 1, �� ����� ������ ����������� ������ ����� ������ + 1. ������ ��� ������������ �������� str ������ ���� �������� ���������� new[], ��� ��� � ����������� ���������� �������� delete[]. }
  procedure reset(str: PAnsiChar); overload;
   {* ������������� �������� ������ ������ ����������� (���������� ������ �����������) }
  function strdup: IString;
   {* ���������� �������� ����� ������ }
  function add(str: PAnsiChar): PAnsiChar; overload;
   {* ��������� � ������ ���������� ���������, ���������� ��������� �� ���� ����� }
  function add(const str: IString): PAnsiChar; overload;
   {* ��������� � ������ ���������� ���������, ���������� ��������� �� ���� ����� }
  function join(str: PAnsiChar): PAnsiChar; overload;
   {* ���������� ����� ������ ������ ����������� ������� � ���������� }
  function join(const str: IString): PAnsiChar; overload;
   {* ���������� ����� ������ ������ ����������� ������� � ���������� }
  property length: Cardinal
   read Get_length;
   {* ������ ��������� ������ }
  property maximum: Cardinal
   read Get_maximum
   write Set_maximum;
   {* ������ �������������� ������, ��� �������� ��������� ������ }
  property data: PAnsiChar
   read Get_data;
   {* ��������� �� ������ ��������������� ������ (������) }
  property code_page: short
   read Get_code_page
   write Set_code_page;
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
  function read(var buffer: pointer;
   size: Cardinal): Cardinal; { can raise OperationError }
   {* �������� ������ �� ������, ���������� ���������� ����������� ������. }
  function write(buffer: pointer;
   size: Cardinal): Cardinal;
   {* �������� ������ � �����. ���������� ���������� ���������� ������. }
  function seek(offset: Integer;
   whence: Cardinal): Cardinal; { can raise OperationError, NotImplemented }
   {* ����������� ������ ������. ���������� ����� ���� �� ������ ������. }
  procedure copy_to(var dst: IStream;
   size: Cardinal;
   out actually_read: unsigned long long;
   out actually_written: unsigned long long); { can raise OperationError }
   {* �������� ������ �� ������ ������ � ������. }
  function eof: Boolean;
   {* ������� ���������� true ���� ��������� ����� ������. }
  function bad: Boolean;
   {* ���� ������������ true, ���������� ������ � ������� ���������� }
  procedure clear;
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

class function make(str: PAnsiChar): BadFactoryType;
 {* �������, �������� ������ }
class function create(str: PAnsiChar;
 code_page: short): BadFactoryType;
 {* �������, �������� ������ }
class function take(var str: PAnsiChar;
 code_page: short): BadFactoryType;
 {* ����������� ���������� ������. ������ ��� ������������ �������� str ������ ���� �������� ���������� new[], ��� ��� � ����������� ���������� �������� delete[]. }
class function alloc(maximum: Cardinal): BadFactoryType;
 {* ������� ������ ������, � ���������������� ������� ���������� ������� }
class function make: BadFactoryType; overload;
 {* ������� ������ ����� }
class function make(path: PAnsiChar): BadFactoryType; overload;
 {* ������� ����� ��������� � ������ }

implementation

uses
 l3ImplUses
;

class function make(str: PAnsiChar): BadFactoryType;
 {* �������, �������� ������ }
var
 l_Inst : IString;
begin
 l_Inst := Create(str);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function create(str: PAnsiChar;
 code_page: short): BadFactoryType;
 {* �������, �������� ������ }
var
 l_Inst : IString;
begin
 l_Inst := Create(str, code_page);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//create

class function take(var str: PAnsiChar;
 code_page: short): BadFactoryType;
 {* ����������� ���������� ������. ������ ��� ������������ �������� str ������ ���� �������� ���������� new[], ��� ��� � ����������� ���������� �������� delete[]. }
var
 l_Inst : IString;
begin
 l_Inst := Create(str, code_page);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//take

class function alloc(maximum: Cardinal): BadFactoryType;
 {* ������� ������ ������, � ���������������� ������� ���������� ������� }
var
 l_Inst : IString;
begin
 l_Inst := Create(maximum);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//alloc

class function make: BadFactoryType;
 {* ������� ������ ����� }
var
 l_Inst : IStream;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(path: PAnsiChar): BadFactoryType;
 {* ������� ����� ��������� � ������ }
var
 l_Inst : IStream;
begin
 l_Inst := Create(path);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
