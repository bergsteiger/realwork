unit adminUserNodeList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/adminUserNodeList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::Admin::TadminUserNodeList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  l3SimpleNodeList,
  AdminInterfaces
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TadminUserNodeList = class(Tl3SimpleNodeList, IadminUserNodeList)
 protected
 // realized methods
   function pm_GetCount: Integer;
 end;//TadminUserNodeList
{$IfEnd} //Admin

implementation

{$If defined(Admin)}

// start class TadminUserNodeList

function TadminUserNodeList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_559E9F2B02D6get_var*
//#UC END# *4BB08B8902F2_559E9F2B02D6get_var*
begin
//#UC START# *4BB08B8902F2_559E9F2B02D6get_impl*
 Result := inherited Count;
//#UC END# *4BB08B8902F2_559E9F2B02D6get_impl*
end;//TadminUserNodeList.pm_GetCount

{$IfEnd} //Admin

end.