unit evNode;

interface

uses
 l3IntfUses
 , nevBase
 , l3Variant
 , l3NodesModelPart
 , l3TreeInterfaces
 , l3Tree_TLB
;

type
 TevCustomNode = class(_k2TagHolder_, Il3HandleNode)
  function Handle: Integer;
   {* ������������� ����. }
  procedure Remove;
   {* ������� ���� �� ������. }
  function AllChildrenCount: Integer;
   {* ����� �������� ���������, ������� ��� ���������. }
  function NextNode: Il3Node;
   {* ��������� ���� ���� �� ������. }
  function PrevNode: Il3Node;
   {* ���������� ���� ���� �� ������. }
  function ParentNode: Il3Node;
   {* ������������ ����. }
  function ChildNode: Il3Node;
   {* ������ �������� �������. }
 end;//TevCustomNode
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2NullTagImpl
 , k2Tags
 , k2Base
 , k2InterfaceFactory
;

end.
