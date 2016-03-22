unit dsMedicFirmSynchroView;
 {* Бизнес объект формы синхронного просмотра списка препаратов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsMedicFirmSynchroView.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsMedicFirmSynchroView" MUID: (4922C66D0013)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , SimpleListInterfaces
 , MedicInterfaces
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
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _FormDataSourceType_ = IdsMedicFirmListSynchroView;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsMedicFirmSynchroView = class(_vcmFormDataSourcePrim_, IdsSimpleListSynchroView, IdsMedicFirmListSynchroView)
  {* Бизнес объект формы синхронного просмотра списка препаратов }
  protected
   SDS: IsdsMedicFirmList;
    {* Ссылка на сборку }
  protected
   procedure OpenDocument;
    {* Открыть документ. }
   function pm_GetHasDocument: Boolean;
   function pm_GetIsDocumentActive: Boolean;
   function pm_GetHasAttributes: Boolean;
   function pm_GetIsAttributesActive: Boolean;
   procedure OpenAttributes;
    {* Открыть атрибуты. }
   procedure OpenList;
    {* Открыть список. }
   function pm_GetHasList: Boolean;
   function pm_GetIsListActive: Boolean;
   procedure OpenDrugList;
    {* Открывает ViewArea "список производимых препаратов" }
   function pm_GetIsDrugListActive: Boolean;
   function pm_GetHasDrugList: Boolean;
 end;//TdsMedicFirmSynchroView
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TdsMedicFirmSynchroView;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

procedure TdsMedicFirmSynchroView.OpenDocument;
 {* Открыть документ. }
//#UC START# *47ECD5280007_4922C66D0013_var*
//#UC END# *47ECD5280007_4922C66D0013_var*
begin
//#UC START# *47ECD5280007_4922C66D0013_impl*
 SDS.OpenDocument;
//#UC END# *47ECD5280007_4922C66D0013_impl*
end;//TdsMedicFirmSynchroView.OpenDocument

function TdsMedicFirmSynchroView.pm_GetHasDocument: Boolean;
//#UC START# *47ECD54803CB_4922C66D0013get_var*
//#UC END# *47ECD54803CB_4922C66D0013get_var*
begin
//#UC START# *47ECD54803CB_4922C66D0013get_impl*
 Result := SDS.HasDocument;
//#UC END# *47ECD54803CB_4922C66D0013get_impl*
end;//TdsMedicFirmSynchroView.pm_GetHasDocument

function TdsMedicFirmSynchroView.pm_GetIsDocumentActive: Boolean;
//#UC START# *47ECD5490012_4922C66D0013get_var*
//#UC END# *47ECD5490012_4922C66D0013get_var*
begin
//#UC START# *47ECD5490012_4922C66D0013get_impl*
 Result := SDS.IsDocumentActive;
//#UC END# *47ECD5490012_4922C66D0013get_impl*
end;//TdsMedicFirmSynchroView.pm_GetIsDocumentActive

function TdsMedicFirmSynchroView.pm_GetHasAttributes: Boolean;
//#UC START# *47F08A0E035F_4922C66D0013get_var*
//#UC END# *47F08A0E035F_4922C66D0013get_var*
begin
//#UC START# *47F08A0E035F_4922C66D0013get_impl*
 Result := SDS.HasAttributes;
//#UC END# *47F08A0E035F_4922C66D0013get_impl*
end;//TdsMedicFirmSynchroView.pm_GetHasAttributes

function TdsMedicFirmSynchroView.pm_GetIsAttributesActive: Boolean;
//#UC START# *47F08A2A03E6_4922C66D0013get_var*
//#UC END# *47F08A2A03E6_4922C66D0013get_var*
begin
//#UC START# *47F08A2A03E6_4922C66D0013get_impl*
 Result := SDS.IsAttributesActive;
//#UC END# *47F08A2A03E6_4922C66D0013get_impl*
end;//TdsMedicFirmSynchroView.pm_GetIsAttributesActive

procedure TdsMedicFirmSynchroView.OpenAttributes;
 {* Открыть атрибуты. }
//#UC START# *47F08A7F0108_4922C66D0013_var*
//#UC END# *47F08A7F0108_4922C66D0013_var*
begin
//#UC START# *47F08A7F0108_4922C66D0013_impl*
 SDS.OpenAttributes;
//#UC END# *47F08A7F0108_4922C66D0013_impl*
end;//TdsMedicFirmSynchroView.OpenAttributes

procedure TdsMedicFirmSynchroView.OpenList;
 {* Открыть список. }
//#UC START# *494692790065_4922C66D0013_var*
//#UC END# *494692790065_4922C66D0013_var*
begin
//#UC START# *494692790065_4922C66D0013_impl*
 Self.OpenDrugList;
//#UC END# *494692790065_4922C66D0013_impl*
end;//TdsMedicFirmSynchroView.OpenList

function TdsMedicFirmSynchroView.pm_GetHasList: Boolean;
//#UC START# *4946928403A8_4922C66D0013get_var*
//#UC END# *4946928403A8_4922C66D0013get_var*
begin
//#UC START# *4946928403A8_4922C66D0013get_impl*
 Result := Self.pm_GetHasDrugList;
//#UC END# *4946928403A8_4922C66D0013get_impl*
end;//TdsMedicFirmSynchroView.pm_GetHasList

function TdsMedicFirmSynchroView.pm_GetIsListActive: Boolean;
//#UC START# *49469292003A_4922C66D0013get_var*
//#UC END# *49469292003A_4922C66D0013get_var*
begin
//#UC START# *49469292003A_4922C66D0013get_impl*
 Result := Self.pm_GetIsDrugListActive;
//#UC END# *49469292003A_4922C66D0013get_impl*
end;//TdsMedicFirmSynchroView.pm_GetIsListActive

procedure TdsMedicFirmSynchroView.OpenDrugList;
 {* Открывает ViewArea "список производимых препаратов" }
//#UC START# *AE873C4154C0_4922C66D0013_var*
//#UC END# *AE873C4154C0_4922C66D0013_var*
begin
//#UC START# *AE873C4154C0_4922C66D0013_impl*
 SDS.OpenDrugList;
//#UC END# *AE873C4154C0_4922C66D0013_impl*
end;//TdsMedicFirmSynchroView.OpenDrugList

function TdsMedicFirmSynchroView.pm_GetIsDrugListActive: Boolean;
//#UC START# *EA414DEF2CED_4922C66D0013get_var*
//#UC END# *EA414DEF2CED_4922C66D0013get_var*
begin
//#UC START# *EA414DEF2CED_4922C66D0013get_impl*
 Result := SDS.IsDrugListActive;
//#UC END# *EA414DEF2CED_4922C66D0013get_impl*
end;//TdsMedicFirmSynchroView.pm_GetIsDrugListActive

function TdsMedicFirmSynchroView.pm_GetHasDrugList: Boolean;
//#UC START# *F5E686C6B9A6_4922C66D0013get_var*
//#UC END# *F5E686C6B9A6_4922C66D0013get_var*
begin
//#UC START# *F5E686C6B9A6_4922C66D0013get_impl*
 Result := True;
//#UC END# *F5E686C6B9A6_4922C66D0013get_impl*
end;//TdsMedicFirmSynchroView.pm_GetHasDrugList
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
