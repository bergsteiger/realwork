unit nsFirstLevelStruct;
 {* �������, ��� ���? }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsFirstLevelStruct.pas"
// ���������: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsAttributeOneLevelTreeStruct
 , l3TreeInterfaces
 , l3Interfaces
;

type
 TnsFirstLevelStruct = class(TnsAttributeOneLevelTreeStruct)
  {* �������, ��� ���? }
  public
   class function Make(const aTag: Il3CString;
    aShowRoot: Boolean): Il3SimpleTree;
    {* ������ ��������� ������ }
 end;//TnsFirstLevelStruct

implementation

uses
 l3ImplUses
 , nsAttributeTreeCacheNew
 , DynamicTreeUnit
;

class function TnsFirstLevelStruct.Make(const aTag: Il3CString;
 aShowRoot: Boolean): Il3SimpleTree;
 {* ������ ��������� ������ }
//#UC START# *4909DCCD018E_4909DC950238_var*
var
 l_Node: INodeBase;
//#UC END# *4909DCCD018E_4909DC950238_var*
begin
//#UC START# *4909DCCD018E_4909DC950238_impl*
 Result := nil;
 l_Node := TnsAttributeTreeCacheNew.Instance.AttributeRootClosed[aTag];
 try
  if (l_Node <> nil) then
   Result := inherited Make(l_Node, aTag, aShowRoot);
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *4909DCCD018E_4909DC950238_impl*
end;//TnsFirstLevelStruct.Make

end.
