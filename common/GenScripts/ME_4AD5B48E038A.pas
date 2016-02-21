unit NOT_FINISHED_nsFolderNodes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\NOT_FINISHED_nsFolderNodes.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , FoldersDomainInterfaces
;

type
 TnsNodeWithRights = class
  private
   f_AcceptedRights: TFoldersActionsSet;
   f_RestrictedRights: TFoldersActionsSet;
 end;//TnsNodeWithRights

 TnsFoldersNode = class(TnsNodeWithRights)
 end;//TnsFoldersNode

procedure nsFindInsertPosition;
procedure nsHasNodeAnyFlag;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

procedure nsFindInsertPosition;
//#UC START# *4C7E782B01A4_4AD5B48E038A_var*
//#UC END# *4C7E782B01A4_4AD5B48E038A_var*
begin
//#UC START# *4C7E782B01A4_4AD5B48E038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E782B01A4_4AD5B48E038A_impl*
end;//nsFindInsertPosition

procedure nsHasNodeAnyFlag;
//#UC START# *4C7E785A02DA_4AD5B48E038A_var*
//#UC END# *4C7E785A02DA_4AD5B48E038A_var*
begin
//#UC START# *4C7E785A02DA_4AD5B48E038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E785A02DA_4AD5B48E038A_impl*
end;//nsHasNodeAnyFlag
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
