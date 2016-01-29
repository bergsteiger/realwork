unit dsMedicFirmSynchroView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dsMedicFirmSynchroView.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TdsMedicFirmSynchroView
//
// Бизнес объект формы синхронного просмотра списка препаратов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  MedicInterfaces,
  SimpleListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsMedicFirmListSynchroView;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsMedicFirmSynchroView = {vac} class(_vcmFormDataSourcePrim_, IdsSimpleListSynchroView, IdsMedicFirmListSynchroView)
  {* Бизнес объект формы синхронного просмотра списка препаратов }
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
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
 protected
 // protected fields
   SDS : IsdsMedicFirmList;
    {* Ссылка на сборку}
 end;//TdsMedicFirmSynchroView
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsMedicFirmSynchroView;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

// start class TdsMedicFirmSynchroView

procedure TdsMedicFirmSynchroView.OpenDocument;
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
//#UC START# *47F08A7F0108_4922C66D0013_var*
//#UC END# *47F08A7F0108_4922C66D0013_var*
begin
//#UC START# *47F08A7F0108_4922C66D0013_impl*
 SDS.OpenAttributes;
//#UC END# *47F08A7F0108_4922C66D0013_impl*
end;//TdsMedicFirmSynchroView.OpenAttributes

procedure TdsMedicFirmSynchroView.OpenList;
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

procedure TdsMedicFirmSynchroView.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 SDS := aDS As IsdsMedicFirmList;
end;

procedure TdsMedicFirmSynchroView.ClearRefs;
begin
 inherited;
 SDS := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.