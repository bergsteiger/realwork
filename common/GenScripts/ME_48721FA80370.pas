unit ComboBoxStrings;

interface

uses
 l3IntfUses
 , l3VCLStrings
 , l3TreeInterfaces
 , l3Interfaces
;

type
 TComboBoxStrings = class(Tl3Strings, Il3SimpleNode, Il3SimpleRootNode)
  function DoMakeChild: Il3SimpleNode;
   {* ������� ������� ������� }
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
  function CanExpandCollapseAll: Boolean;
  procedure ExpandCollapseAll(anExpand: Boolean);
  function CanAcceptData(const aData: Tl3TreeData): Boolean;
   {* ����� �� ���� ������� ������ }
  function DropData(const aData: Tl3TreeData): Boolean;
   {* ������� ������ }
  function CanMove: Boolean;
   {* ���������� ����������� ����������� ���� }
  function Prev: Il3SimpleNode;
   {* ���������� �����. }
 end;//TComboBoxStrings
 
implementation

uses
 l3ImplUses
 , l3String
 , ctComboBoxStringsItemNode
 , l3InterfacesMisc
 , l3Bits
;

end.
