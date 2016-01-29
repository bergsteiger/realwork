unit l3CustomString;

interface

uses
 l3IntfUses
 , l3Variant
 , l3Types
 , l3Interfaces
 , l3IID
 , Classes
;

type
 Tl3CustomString = class(Tl3PrimString)
  {* ������� ����� ��� "�����". ���������� �������� � ��������, �� �� ������ �������� ������. }
  function Offset(Delta: Integer): Tl3CustomString;
  procedure DoSetCodePage(aValue: Integer);
  procedure CheckUnicode;
  function AssignSt(aSt: PAnsiChar;
   O1: Integer;
   O2: Integer;
   aCodePage: Integer): Tl3CustomString;
  procedure LPad(aCh: AnsiChar;
   aCodePage: Integer;
   aRepeat: Integer);
   {* ��������� � ������ ����� ������ aCh aRepeat ��� }
  procedure Append(const aSt: Tl3WString;
   aRepeat: Integer); overload;
   {* ��������� ������ aSt � ������ ������ aRepeat ��� }
  procedure Append(const aCh: Tl3Char;
   aRepeat: Integer); overload;
   {* ��������� ������ aCh � ������ ������ aRepeat ��� }
  procedure Append(aCh: AnsiChar;
   aRepeat: Integer;
   aCodePage: Integer); overload;
   {* ��������� ������ aCh � ������ ������ aRepeat ��� }
  procedure Insert(const aSt: Tl3WString;
   aPos: Integer;
   aRepeat: Integer); overload;
   {* ��������� ������ aSt � ������� aPos, aRepeat ��� }
  procedure Insert(aCh: AnsiChar;
   aPos: Integer;
   aRepeat: Integer); overload;
   {* ��������� ������ aCh � ������� aPos, aRepeat ��� }
  procedure Insert(S: Tl3CustomString;
   aPos: Integer;
   aRepeat: Integer); overload;
   {* ��������� ������ S � ������� aPos, aRepeat ��� }
  function Trim: Tl3CustomString;
   {* ������� �������� � ��������� ������� }
  function TrimAll: Tl3CustomString;
   {* ������� ��������, ��������� � ������������� ������� }
  procedure LTrim;
   {* ������� �� ������ ������� ������� }
  function RTrim: Tl3CustomString;
   {* ������� �� ������ �������� ������� }
  procedure TrimEOL;
   {* ������� �� ������ �������� cc_SoftEnter � cc_HardEnter }
  function DeleteDoubleSpace: Tl3CustomString;
   {* ������� �� ������ ������������� ������� }
  function DeleteAllChars(aChar: AnsiChar): Integer;
   {* ������� �� ������ ��� ������� aChar � ���������� ���������� ��������� }
  function ReplaceNonReadable: Tl3CustomString;
   {* �������� "����������" ������� ��������� }
  function FindChar(Pos: Integer;
   C: AnsiChar): Integer;
   {* ���� ������ � ������ � ������� Pos � ���������� ������� ���������� ������� ��� -1 }
  procedure FindCharEx(C: AnsiChar;
   aSt: Tl3CustomString);
  function Indent: Integer;
  procedure MakeBMTable(var BT: Tl3BMTable);
   {* ������� ������� Boyer-Moore ��� ������ }
  function BMSearch(S: Tl3CustomString;
   BT: Tl3BMTable;
   var Pos: Cardinal): Boolean;
   {* ���� ������ ������ � ������ S � ������ �������� }
  function BMSearchUC(S: Tl3CustomString;
   BT: Tl3BMTable;
   var Pos: Cardinal): Boolean;
   {* ���� ������ ������ � ������ S ��� ����� ��������
��������! ��� ��������� ������ ��� ����� �������� ��������� (S) ������ ���� � ������� ��������!
� ������� (BT) ������ ���� ��������� ��� ���� ������ � ������� ��������! }
  procedure MakeUpper;
   {* ����������� ������ � �������� �������� }
  procedure MakeLower;
   {* ����������� ������ � ������� �������� }
  function Delete(aPos: Integer;
   aCount: Integer): PAnsiChar;
   {* ������� aCount �������� � ������� aPos }
  procedure SetSt(aStr: PAnsiChar;
   aLen: Integer);
   {* ����������� ����� �������� ������, ������, ��� aStr ����� �� �� ���������, ��� � ������ }
  function JoinWith(P: Tl3PrimString): Integer;
   {* �������� ����������� ���� �������� }
  procedure l3SayConstString;
 end;//Tl3CustomString
 
implementation

uses
 l3ImplUses
 , l3BMSearch
 , SysUtils
 , l3Base
 , l3String
 , l3StringEx
 , l3Memory
 , l3StringAdapter
 , l3Chars
;

end.
