unit NOT_FINISHED_l3Types;
 {* ������� ������ ���� ���������� L3. }

// ������: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Types.pas"
// ���������: "Interfaces"
// ������� ������: "l3Types" MUID: (4678193C009C)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Core
;

const
 {* �������. }
 l3MinIndex = Low(Tl3Index);
  {* ����������� ������ ��������. }
 l3MaxIndex = High(Tl3Index);
  {* ������������ ������ ��������. }
 ntNone = 0;
  {* ������ ��������. }
 ntInsert = 1;
  {* ������� ��������. }
 ntDelete = 3;
  {* �������� ��������. ���������� �� ����������� ������ }
 ntDeleteDone = 4;
  {* �������� ��������. ���������� ����� ����������� ������ }
 ntDataChange = 5;
  {* ���������� ��������. }
 ntMoveBegin = 6;
  {* �������� �������� ��������. }
 ntMoveEnd = 7;
  {* ����������� �������� ��������. }
 ntClear = 8;
  {* �������� ��������� ������. }
 ntClearItem = 9;
  {* �������� �������. }
 ntChildClear = 10;
  {* �������� �������� �������. }
 ntChildInsert = 11;
  {* �������� �������� �������. }
 ntFree = 12;
  {* ������������ ��������. }
 ntCountChange = 13;
  {* ���������� ���������� ���������. }
 ntChangeItemData = 14;
  {* ���������� ������ ��������. }
 ntChanging = 15;
  {* �������� ���������. }
 ntChanged = 16;
  {* ����������� ���������. }
 ntResortChild = 17;
  {* �������� �������� �������� �������� ������������. }
 l3GlyphFontName = '__Glyph__';
 l3_siNative = ;

type
 PIUnknown = ^IUnknown;
  {* ��������� �� IUnknown. }

 PObject = ^TObject;

 Tl3ItemFlag = (
  {* ���� ��������. }
  l3_ifNone
  , l3_ifNew
  , l3_ifDeleted
  , l3_ifModified
 );//Tl3ItemFlag

 TLongArray = array of Integer;
  {* ������������ ������ ����� �����. }

 PLong = Integer;
  {* ��������� �� long. }

 Tl3Rgn = hRgn;
  {* ������. }

 Tl3IteratorAction = function(Data: Pointer;
  Index: Integer): Boolean;
  {* �������������� �������. }

 TByteSet = set of byte;
  {* ��������� ����. }

 Tl3Duplicates = (
  {* �������� ���������� � ����������� ��������� ������ }
  l3_dupIgnore
   {* ������������ ����� �������. }
  , l3_dupAccept
   {* ������� ����� �������. }
  , l3_dupError
   {* ������ ��������� �� ������. }
  , l3_dupAssign
   {* ��������� ����� ������� �������. }
  , l3_dupChange
   {* �������� ������ ������� �����. }
 );//Tl3Duplicates

 Tl3Index = l3Interfaces.Tl3Index;
  {* ������ ���������. }

 Tl3FreeAction = function(Data: Pointer): Boolean;
  {* ������� ��� ���������� � ����������� �� ������������ �������. }

 Tl3SortIndex = type SmallInt;
  {* ������ ����������. }

 Tl3Handle = Integer;
  {* ��� ������������� ���������������. ��������. ������ �� ����������. }

 TSmallIntArray = array of SmallInt;
  {* ������������ ������ �������� ����� �����. }

 PInteger = l3Interfaces.PInteger;

 Large = l3Interfaces.Large;

 EDoChangedAlreadyDone = class
 end;//EDoChangedAlreadyDone

 Tl3Operation = (
  {* �������� }
  l3_opDelete
   {* �������� }
  , l3_opInsert
   {* ������� }
 );//Tl3Operation

 Tl3FileMode = (
  {* ����� ������ � �������:
* l3_fmRead</b> - ������.
* l3_fmWrite</b> - ������.
* l3_fmReadWrite</b> - ������-������.
* l3_fmAppend - ���������� � �����. }
  l3_fmRead
  , l3_fmWrite
  , l3_fmReadWrite
  , l3_fmAppend
  , l3_fmExclusiveReadWrite
  , l3_fmExclusiveWrite
  , l3_fmExclusiveAppend
  , l3_fmCreateReadWrite
  , l3_fmFullShareReadWrite
  , l3_fmFullShareCreateReadWrite
 );//Tl3FileMode

 Tl3Bool = (
 );//Tl3Bool

 Tl3ProgressProc = procedure(aState: Byte;
  aValue: Integer;
  const aMsg: AnsiString = '') of object;

 PWord = ;

 Tl3BMTable = ;

 Tl3Char = record
 end;//Tl3Char

 Tl3PathStr = AnsiString;

 Tl3Method = ;

implementation

uses
 l3ImplUses
;

end.
