unit PrefixTreeUnit;
 {* Дерево для Вид правовой информации }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\PrefixTreeUnit.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , BaseTypesUnit
 , IOUnit
 , DynamicTreeDefinesUnit
;

type
 IPrefixNode = interface(INodeBase)
  {* Нода деревьев вид правовой информации }
  ['{9EC9825A-DC26-4939-8C4B-D8473E03E283}']
 end;//IPrefixNode

class function make: BadFactoryType; overload; { can raise CanNotFindData }
class function make(var owner_tree: IFakeFacetForFactory;
 const snode): BadFactoryType; overload;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType; { can raise CanNotFindData }
var
 l_Inst : IPrefixNode;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(var owner_tree: IFakeFacetForFactory;
 const snode): BadFactoryType;
var
 l_Inst : IPrefixNode;
begin
 l_Inst := Create(owner_tree, snode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
