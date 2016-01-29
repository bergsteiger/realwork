unit evContentsNode;

interface

uses
 l3IntfUses
 , l3VirtualNode
 , l3Tree_TLB
;

type
 TevContentsNodeState = (
  {* ��������� ���� ������ ����������. }
  ev_cntNotReady
   {* ���� ������ ��� ������ � �� ���������������. }
  , ev_cntNeedUpdate
   {* ����� ����������� �������� }
  , ev_cntReady
   {* ���� ����� � ����������� � �� ������� ����������. }
  , ev_cntInUpdate
   {* ������ �������. }
  , ev_cntFirstFind
   {* ����� ������� ���� ��� ����. }
 );//TevContentsNodeState
 
 TevContentsNode = class(Tl3VirtualFlagsNode)
  function NeedCreate: Boolean;
  function NotReady: Boolean;
  function CheckChildren: Boolean;
   {* ��������� ���� �� � ������� ��������. }
  procedure TryGetChildren;
  function NeedUpdate: Boolean;
  procedure IncThisChildrenCount;
  procedure Create;
  procedure DoTryGetChildren;
  function NeedMakeChildren: Boolean;
 end;//TevContentsNode
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , l3Types
 , l3Bits
 , l3TreeInterfaces
;

end.
