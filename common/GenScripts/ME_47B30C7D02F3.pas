unit TipsUnit;
 {* Совет дня }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\TipsUnit.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , BaseTypesUnit
;

type
 ITipsManager = interface
  {* Менеджер Советов дня }
  ['{E7AFD5DA-77C8-4E4E-95C3-D54CBB8CD5D7}']
  function Get_tips_tree_root: INodeBase; { can raise CanNotFindData }
  function get_current_tip: INodeIndexPath;
   {* Получить текущий (по сценарию) Совет дня }
  function is_exist: Boolean;
  property tips_tree_root: INodeBase
   read Get_tips_tree_root;
   {* Рут дерева совет дня }
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
