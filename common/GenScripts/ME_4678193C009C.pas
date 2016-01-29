unit l3Types;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Core
;

type
 Tl3ItemFlag = (
  {* ���� ��������. }
  l3_ifNone
  , l3_ifNew
  , l3_ifDeleted
  , l3_ifModified
 );//Tl3ItemFlag
 
 Tl3PCharLenBase = object(Tl3PCharLenPrim)
 end;//Tl3PCharLenBase
 
 Tl3PCharLen = object(Tl3PCharLenBase)
 end;//Tl3PCharLen
 
 Tl3PCharLenConst = object(Tl3PCharLenBase)
 end;//Tl3PCharLenConst
 
 TLongArray = array of Integer;
  {* ������������ ������ ����� �����. }
 
 PLong = Integer;
  {* ��������� �� long. }
 
 Tl3Rgn = hRgn;
  {* ������. }
 
 PIUnknown = ^IUnknown;
  {* ��������� �� IUnknown. }
 
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
 
 PObject = ^TObject;
 
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
  const aMsg: AnsiString) of object;
 
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
