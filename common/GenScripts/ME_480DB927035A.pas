unit evStyleInterface;

interface

uses
 l3IntfUses
 , evStyles_SH
 , l3Interfaces
 , evFontInterface
 , l3Variant
 , Classes
 , k2Base
 , evdStyles
 , k2Dictionary
 , l3Types
 , l3Tree_TLB
 , nevBase
 , k2Tags
;

type
 RevStyleInterface = class of TevStyleInterface;
 
 Tk2TagID = k2Tags.Tk2TagID;
 
 TevStyleInterface = class(SHevStyles, Il3Strings)
  {* ���������� ��� ������ � �������� ������ }
  function MakeList(aType: Tk2Type): Il3Strings;
  procedure Make(aType: Tk2Type;
   aStyle: Integer);
  function MakeListForBlock(aType: Tk2Type): Il3Strings;
  function GetVT: Tk2Dictionary;
   {* ���������� ������ ������ }
  procedure Add(const S: AnsiString;
   ID: Integer);
   {* ��������� ����� ����� � ������������� ������ �� ���� }
  procedure Delete;
   {* ������� ������� ��������� ����� }
  procedure SelectStyledObjectType(aType: Tk2Type);
   {* ����������� ���������� �� ������ �� ������� ��� ��������� ���� �������� }
  procedure SelectStyledObject(anObject: Tl3Variant);
   {* ����������� ���������� �� ������ �� ������� ��� ��������� ���� �������� }
  function SelectStyle(const S: AnsiString): Tl3Variant; overload;
   {* ������������� ������ �� ����� �� ����� }
  function SelectStyle(ID: Integer): Tl3Variant; overload;
   {* ������������� ������ �� ����� �� �������������� }
  procedure IncFontSize;
  procedure DecFontSize;
  procedure IncAllFontSize;
  procedure DecAllFontSize;
  function Iterate(Action: Tl3IteratorAction): Integer;
   {* ���������� ��� �������� ��������� � aLo �� aHi � ����������� �������� ��� Action }
  function IterateF(Action: Tl3IteratorAction): Integer;
   {* ���������� ��� �������� ��������� � aLo �� aHi � ����������� �������� ��� Action }
  function MakeStylesTreeRoot(const aIncludeIdArray: array of Integer): Il3Node;
   {* ������� ������ ������ � ���������� ��������� �� �������� ���� }
  function Items: TStrings;
   {* ������. }
 end;//TevStyleInterface
 
implementation

uses
 l3ImplUses
 , l3Base
 , TextPara_Const
 , l3Nodes
 , l3TreeInterfaces
 , k2SimpleTagList
 , l3Chars
 , evStyleTableSpy
;

end.
