unit adminUserNodeList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\adminUserNodeList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TadminUserNodeList" MUID: (559E9F2B02D6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3SimpleNodeList
 , AdminInterfaces
;

type
 TadminUserNodeList = class(Tl3SimpleNodeList, IadminUserNodeList)
  protected
   function pm_GetCount: Integer;
 end;//TadminUserNodeList
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

function TadminUserNodeList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_559E9F2B02D6get_var*
//#UC END# *4BB08B8902F2_559E9F2B02D6get_var*
begin
//#UC START# *4BB08B8902F2_559E9F2B02D6get_impl*
 Result := inherited Count;
//#UC END# *4BB08B8902F2_559E9F2B02D6get_impl*
end;//TadminUserNodeList.pm_GetCount
{$IfEnd} // Defined(Admin)

end.
