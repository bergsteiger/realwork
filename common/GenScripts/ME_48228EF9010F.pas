unit NOT_FINISHED_nsFolders;
 {* Для работы с моими документами. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\NOT_FINISHED_nsFolders.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

const

type
 TFoldersTree = class
  {* Дерево моих документов. }
 end;//TFoldersTree

 TFolderSecurity = class
 end;//TFolderSecurity

procedure UserFoldersTree;
procedure CheckFolderElementRights;
procedure nsDeleteBookmark;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

procedure UserFoldersTree;
//#UC START# *4AC095C002E6_48228EF9010F_var*
//#UC END# *4AC095C002E6_48228EF9010F_var*
begin
//#UC START# *4AC095C002E6_48228EF9010F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC095C002E6_48228EF9010F_impl*
end;//UserFoldersTree

procedure CheckFolderElementRights;
//#UC START# *4C7E77AD014A_48228EF9010F_var*
//#UC END# *4C7E77AD014A_48228EF9010F_var*
begin
//#UC START# *4C7E77AD014A_48228EF9010F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E77AD014A_48228EF9010F_impl*
end;//CheckFolderElementRights

procedure nsDeleteBookmark;
//#UC START# *4C879EFC02C7_48228EF9010F_var*
//#UC END# *4C879EFC02C7_48228EF9010F_var*
begin
//#UC START# *4C879EFC02C7_48228EF9010F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C879EFC02C7_48228EF9010F_impl*
end;//nsDeleteBookmark
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
