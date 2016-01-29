unit PrimSaveLoadOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadOptions_Form.pas"
// Начат: 09.09.2010 15:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadOptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  PrimSaveLoad_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TPrimSaveLoadOptionsForm = {form} class(TPrimSaveLoadForm)
 protected
  procedure InitEntities; override;
 end;//TPrimSaveLoadOptionsForm

 TvcmContainerFormRef = TPrimSaveLoadOptionsForm;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils,
  afwFacade
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3Interfaces,
  l3String,
  StdRes {a},
  Search_Strange_Controls,
  SearchLite_Strange_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TPrimSaveLoadOptionsForm

procedure TPrimSaveLoadOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  
  ShowInContextMenu(en_File, op_SaveToFolder, true);
  ShowInToolbar(en_File, op_SaveToFolder, true);
  
  ShowInContextMenu(en_File, op_LoadFromFolder, true);
  ShowInToolbar(en_File, op_LoadFromFolder, true);
  
  ShowInContextMenu(en_Result, op_ClearAll, true);
  ShowInToolbar(en_Result, op_ClearAll, true);
  
  ShowInContextMenu(en_Query, op_GetOldQuery, true);
  ShowInToolbar(en_Query, op_GetOldQuery, true);
  
  ShowInContextMenu(en_Query, op_SearchType, false);
  ShowInToolbar(en_Query, op_SearchType, true);
  
  ShowInContextMenu(en_LogicOperation, op_LogicOr, true);
  ShowInToolbar(en_LogicOperation, op_LogicOr, true);
  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Result, op_Cancel, true);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Result, op_OkExt, true);
  ShowInToolbar(en_Result, op_OkExt, true);
  {$IfEnd} //not NoVCM

  
  ShowInContextMenu(en_Filters, op_FiltersListOpen, false);
  ShowInToolbar(en_Filters, op_FiltersListOpen, true);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimSaveLoadOptions
 TtfwClassRef.Register(TPrimSaveLoadOptionsForm);
{$IfEnd} //not Admin AND not NoScripts

end.