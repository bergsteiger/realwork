unit TipsUnit;
 {* ����� ��� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\TipsUnit.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , BaseTypesUnit
;

type
 ITipsManager = interface
  {* �������� ������� ��� }
  ['{E7AFD5DA-77C8-4E4E-95C3-D54CBB8CD5D7}']
  function Get_tips_tree_root: INodeBase; { can raise CanNotFindData }
  function get_current_tip: INodeIndexPath;
   {* �������� ������� (�� ��������) ����� ��� }
  function is_exist: Boolean;
  property tips_tree_root: INodeBase
   read Get_tips_tree_root;
   {* ��� ������ ����� ��� }
 end;//ITipsManager

class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
var
 l_Inst : ITipsManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
