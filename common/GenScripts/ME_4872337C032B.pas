unit ctComboBoxStringsItemNode;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , ComboBoxStrings
 , l3Interfaces
;

type
 TctComboBoxStringsItemNode = class(Tl3CacheableBase, Il3SimpleNode, IctNodeWrap)
  procedure Create(aStrings: TComboBoxStrings;
   anIndex: Integer);
  procedure Make(aStrings: TComboBoxStrings;
   anIndex: Integer);
  function IsFirst: Boolean;
   {* ��� ������ ���� ������ ��������? }
  function IsLast: Boolean;
   {* ��� ��������� ���� ������ ��������? }
  function HasChild: Boolean;
   {* ���� �� �������� ����? }
  function MaybeChild: Boolean;
   {* ����� �� ����� �������� ����? }
  function GetLevel: Integer;
  function GetLevelFor(const aNode: Il3SimpleNode): Integer;
  function IsSame(const aNode: Il3SimpleNode): Boolean;
   {* ���������� ����. }
  function IsDisappeared: Boolean;
   {* True ���� ��������� �� ��������� ����,
             ����������� � ����������� ����� - ���������� �� ������. }
  procedure BeginMove(var aUserParam: Pointer);
   {* ������ ����������� ����. }
  procedure EndMove(aUserParam: Pointer);
   {* ��������� ����������� ����. }
  procedure Delete;
   {* ������� ���� �� ������, � ��� ������ � ����������� �������� (�������� �� ��) ��� ��������� �������. }
  function Text: Tl3PCharLenPrim;
   {* ����� ����. }
  function Parent: Il3SimpleNode;
   {* ������������ ����. }
  function Child: Il3SimpleNode;
   {* ������ �������� �������. }
  function Next: Il3SimpleNode;
   {* ��������� �����. }
  function Flag: Boolean;
  function Flags: Integer;
  function ThisChildrenCount: Integer;
   {* ����� �������� ���������, ��� ����� ���� ���������. }
  function IndexInParent: Integer;
   {* ������ ���� � ������������. }
  function CanAcceptData(const aData: Tl3TreeData): Boolean;
   {* ����� �� ���� ������� ������ }
  function DropData(const aData: Tl3TreeData): Boolean;
   {* ������� ������ }
  function CanMove: Boolean;
   {* ���������� ����������� ����������� ���� }
  function Prev: Il3SimpleNode;
   {* ���������� �����. }
  function GetSelf: TctComboBoxStringsItemNode;
 end;//TctComboBoxStringsItemNode
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
 , l3InterfacesMisc
 , l3Bits
;

type
 IctNodeWrap = interface
  {* ������ ��� �����, ����������� �������� ����������. }
  function GetSelf: TctComboBoxStringsItemNode;
 end;//IctNodeWrap
 
end.
