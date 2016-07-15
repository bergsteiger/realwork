unit OfficeLikeRes;

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "OfficeLike" MUID: (4ADDCE970294)
// Имя типа: "TOfficeLikeRes"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmApplication
 , vcmExternalInterfaces
;

type
 TOfficeLikeRes = {abstract} class(TvcmApplication)
  public
   class function mod_opcode_ToolbarMenu_Customize: TvcmMOPID;
   class function mod_opcode_ToolbarMenu_AvailableOperations: TvcmMOPID;
   class function mod_opcode_ToolbarMenu_IconsSize: TvcmMOPID;
   class function mod_opcode_ToolbarMenu_Fasten: TvcmMOPID;
 end;//TOfficeLikeRes
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , moToolbarMenu
 , vcmBaseOperationsCollectionItem
 , vcmUserControls
 , PrimToolbarMenu_Module
 , OfficeLikeMain_Form
 , evExtFormat
 //#UC START# *4ADDCE970294impl_uses*
 //#UC END# *4ADDCE970294impl_uses*
;

class function TOfficeLikeRes.mod_opcode_ToolbarMenu_Customize: TvcmMOPID;
begin
 Result := g_module_opcode_ToolbarMenu_Customize;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TOfficeLikeRes.mod_opcode_ToolbarMenu_Customize

class function TOfficeLikeRes.mod_opcode_ToolbarMenu_AvailableOperations: TvcmMOPID;
begin
 Result := g_module_opcode_ToolbarMenu_AvailableOperations;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TOfficeLikeRes.mod_opcode_ToolbarMenu_AvailableOperations

class function TOfficeLikeRes.mod_opcode_ToolbarMenu_IconsSize: TvcmMOPID;
begin
 Result := g_module_opcode_ToolbarMenu_IconsSize;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TOfficeLikeRes.mod_opcode_ToolbarMenu_IconsSize

class function TOfficeLikeRes.mod_opcode_ToolbarMenu_Fasten: TvcmMOPID;
begin
 Result := g_module_opcode_ToolbarMenu_Fasten;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TOfficeLikeRes.mod_opcode_ToolbarMenu_Fasten
{$IfEnd} // NOT Defined(NoVCM)

end.
