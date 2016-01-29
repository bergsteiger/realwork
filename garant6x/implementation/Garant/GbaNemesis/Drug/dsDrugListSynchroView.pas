unit dsDrugListSynchroView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Drug"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Drug/dsDrugListSynchroView.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Inpharm::Drug::sdsDrugList::TdsDrugListSynchroView
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
 _FormDataSourceType_ = IdsDrugListSynchroView;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsDrugListSynchroView = {vac} class(_vcmFormDataSourcePrim_, IdsSimpleListSynchroView, IdsDrugListSynchroView)
  {* Бизнес объект формы синхронного просмотра списка препаратов }
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   function pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
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
   function pm_GetHasDrugInternationalNameSynonims: Boolean;
   procedure OpenDrugInternationalNameSynonims;
     {* Открывает ViewArea "Бизнес объект "Синонимы по международному названию"" }
 protected
 // protected fields
   SDS : IsdsDrugList;
    {* Ссылка на сборку}
 end;//TdsDrugListSynchroView
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

type _Instance_R_ = TdsDrugListSynchroView;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

// start class TdsDrugListSynchroView

function TdsDrugListSynchroView.pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
//#UC START# *33C4CFE7BE58_47ECD5A6015Aget_var*
//#UC END# *33C4CFE7BE58_47ECD5A6015Aget_var*
begin
//#UC START# *33C4CFE7BE58_47ECD5A6015Aget_impl*
 Result := SDS.IsDrugInternationalNameSynonimsActive;
//#UC END# *33C4CFE7BE58_47ECD5A6015Aget_impl*
end;//TdsDrugListSynchroView.pm_GetIsDrugInternationalNameSynonimsActive

procedure TdsDrugListSynchroView.OpenDocument;
//#UC START# *47ECD5280007_47ECD5A6015A_var*
//#UC END# *47ECD5280007_47ECD5A6015A_var*
begin
//#UC START# *47ECD5280007_47ECD5A6015A_impl*
 SDS.OpenDocument
//#UC END# *47ECD5280007_47ECD5A6015A_impl*
end;//TdsDrugListSynchroView.OpenDocument

function TdsDrugListSynchroView.pm_GetHasDocument: Boolean;
//#UC START# *47ECD54803CB_47ECD5A6015Aget_var*
//#UC END# *47ECD54803CB_47ECD5A6015Aget_var*
begin
//#UC START# *47ECD54803CB_47ECD5A6015Aget_impl*
 Result := SDS.HasDocument;
//#UC END# *47ECD54803CB_47ECD5A6015Aget_impl*
end;//TdsDrugListSynchroView.pm_GetHasDocument

function TdsDrugListSynchroView.pm_GetIsDocumentActive: Boolean;
//#UC START# *47ECD5490012_47ECD5A6015Aget_var*
//#UC END# *47ECD5490012_47ECD5A6015Aget_var*
begin
//#UC START# *47ECD5490012_47ECD5A6015Aget_impl*
  Result := SDS.IsDocumentActive;
//#UC END# *47ECD5490012_47ECD5A6015Aget_impl*
end;//TdsDrugListSynchroView.pm_GetIsDocumentActive

function TdsDrugListSynchroView.pm_GetHasAttributes: Boolean;
//#UC START# *47F08A0E035F_47ECD5A6015Aget_var*
//#UC END# *47F08A0E035F_47ECD5A6015Aget_var*
begin
//#UC START# *47F08A0E035F_47ECD5A6015Aget_impl*
 Result := SDS.HasAttributes;
//#UC END# *47F08A0E035F_47ECD5A6015Aget_impl*
end;//TdsDrugListSynchroView.pm_GetHasAttributes

function TdsDrugListSynchroView.pm_GetIsAttributesActive: Boolean;
//#UC START# *47F08A2A03E6_47ECD5A6015Aget_var*
//#UC END# *47F08A2A03E6_47ECD5A6015Aget_var*
begin
//#UC START# *47F08A2A03E6_47ECD5A6015Aget_impl*
  Result := SDS.IsAttributesActive;
//#UC END# *47F08A2A03E6_47ECD5A6015Aget_impl*
end;//TdsDrugListSynchroView.pm_GetIsAttributesActive

procedure TdsDrugListSynchroView.OpenAttributes;
//#UC START# *47F08A7F0108_47ECD5A6015A_var*
//#UC END# *47F08A7F0108_47ECD5A6015A_var*
begin
//#UC START# *47F08A7F0108_47ECD5A6015A_impl*
 SDS.OpenAttributes;
//#UC END# *47F08A7F0108_47ECD5A6015A_impl*
end;//TdsDrugListSynchroView.OpenAttributes

procedure TdsDrugListSynchroView.OpenList;
//#UC START# *494692790065_47ECD5A6015A_var*
//#UC END# *494692790065_47ECD5A6015A_var*
begin
//#UC START# *494692790065_47ECD5A6015A_impl*
 Self.OpenDrugInternationalNameSynonims;
//#UC END# *494692790065_47ECD5A6015A_impl*
end;//TdsDrugListSynchroView.OpenList

function TdsDrugListSynchroView.pm_GetHasList: Boolean;
//#UC START# *4946928403A8_47ECD5A6015Aget_var*
//#UC END# *4946928403A8_47ECD5A6015Aget_var*
begin
//#UC START# *4946928403A8_47ECD5A6015Aget_impl*
 Result := Self.pm_GetHasDrugInternationalNameSynonims;
//#UC END# *4946928403A8_47ECD5A6015Aget_impl*
end;//TdsDrugListSynchroView.pm_GetHasList

function TdsDrugListSynchroView.pm_GetIsListActive: Boolean;
//#UC START# *49469292003A_47ECD5A6015Aget_var*
//#UC END# *49469292003A_47ECD5A6015Aget_var*
begin
//#UC START# *49469292003A_47ECD5A6015Aget_impl*
 Result := Self.pm_GetIsDrugInternationalNameSynonimsActive;
//#UC END# *49469292003A_47ECD5A6015Aget_impl*
end;//TdsDrugListSynchroView.pm_GetIsListActive

function TdsDrugListSynchroView.pm_GetHasDrugInternationalNameSynonims: Boolean;
//#UC START# *EBEDED9E4D65_47ECD5A6015Aget_var*
//#UC END# *EBEDED9E4D65_47ECD5A6015Aget_var*
begin
//#UC START# *EBEDED9E4D65_47ECD5A6015Aget_impl*
 Result := SDS.HasDrugInternationalNameSynonims;
//#UC END# *EBEDED9E4D65_47ECD5A6015Aget_impl*
end;//TdsDrugListSynchroView.pm_GetHasDrugInternationalNameSynonims

procedure TdsDrugListSynchroView.OpenDrugInternationalNameSynonims;
//#UC START# *FED42B6D17CA_47ECD5A6015A_var*
//#UC END# *FED42B6D17CA_47ECD5A6015A_var*
begin
//#UC START# *FED42B6D17CA_47ECD5A6015A_impl*
 SDS.OpenDrugInternationalNameSynonims;
//#UC END# *FED42B6D17CA_47ECD5A6015A_impl*
end;//TdsDrugListSynchroView.OpenDrugInternationalNameSynonims

procedure TdsDrugListSynchroView.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 SDS := aDS As IsdsDrugList;
end;

procedure TdsDrugListSynchroView.ClearRefs;
begin
 inherited;
 SDS := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.