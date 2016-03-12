unit dsRightEdition;
 {* Текущая редакция }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsRightEdition.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , EditionsInterfaces
 , l3Tree_TLB
 , nevTools
 , DocumentUnit
 , eeInterfaces
 , l3Interfaces
 , FoldersDomainInterfaces
 , UnderControlUnit
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , UnderControlInterfaces
 , l3Types
 , afwInterfaces
 , DocumentInterfaces
;

type
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsEditionDiff.imp.pas}
 TdsRightEdition = {final} class(_dsEditionDiff_, IdsRightEdition)
  {* Текущая редакция }
  private
   f_NextEditions: Il3Node;
  protected
   function IsLeft: Boolean; override;
   function Get_NextEditions: Il3Node;
   procedure ClearFields; override;
 end;//TdsRightEdition
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsEditionNodes
 , nsTypes
 , deDocInfo
 , nsDocInfoHAFMacroReplacer
 , nsFolderFilterInfo
 , nsEditionFromDTPDocumentContainer
 , l3InterfacesMisc
 , SysUtils
 , l3Base
 , l3Utils
 , afwFacade
;

type _Instance_R_ = TdsRightEdition;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsEditionDiff.imp.pas}

function TdsRightEdition.IsLeft: Boolean;
//#UC START# *4A8443C30125_4A717FA60328_var*
//#UC END# *4A8443C30125_4A717FA60328_var*
begin
//#UC START# *4A8443C30125_4A717FA60328_impl*
 Result := false;
//#UC END# *4A8443C30125_4A717FA60328_impl*
end;//TdsRightEdition.IsLeft

function TdsRightEdition.Get_NextEditions: Il3Node;
//#UC START# *4B55B0DE0078_4A717FA60328get_var*
//#UC END# *4B55B0DE0078_4A717FA60328get_var*
begin
//#UC START# *4B55B0DE0078_4A717FA60328get_impl*
 if (f_NextEditions = nil) then
  f_NextEditions := TnsEditionsRoot.MakeForNextEditions(DoGetDocument);
 Result := f_NextEditions;
//#UC END# *4B55B0DE0078_4A717FA60328get_impl*
end;//TdsRightEdition.Get_NextEditions

procedure TdsRightEdition.ClearFields;
begin
 f_NextEditions := nil;
 inherited;
end;//TdsRightEdition.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
