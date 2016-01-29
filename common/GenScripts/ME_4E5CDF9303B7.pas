unit l3SearchNode;

interface

uses
 l3IntfUses
 , l3SearchNodePrim
 , l3SearchNodePrimList
;

type
 Tl3SearchNode = class(Tl3SearchNodePrim)
  procedure AddChild(aChild: Tl3SearchNode);
  procedure Split(aPos: Integer);
   {* ��������� ���� �� ���, �������� ����� �������, ������� ������ ��������� � ����� ����, ������� ��������� ���� � ����, � �� �� ������� ��� ������� ���� � ������ }
  procedure DropChildren;
 end;//Tl3SearchNode
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Interfaces
;

end.
