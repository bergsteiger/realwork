unit PrimAttributeSelectOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimAttributeSelectOptions_Form.pas"
// Начат: 09.09.2010 15:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::PrimAttributeSelectOptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  PrimAttributeSelect_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;

type
 TPrimAttributeSelectOptionsForm = {form} class(TPrimAttributeSelectForm)
 protected
  procedure InitEntities; override;
 end;//TPrimAttributeSelectOptionsForm

 TvcmContainerFormRef = TPrimAttributeSelectOptionsForm;

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
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

// start class TPrimAttributeSelectOptionsForm

procedure TPrimAttributeSelectOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  
  ShowInContextMenu(en_Result, op_ClearAll, true);
  ShowInToolbar(en_Result, op_ClearAll, true);
  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Result, op_Cancel, true);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Result, op_OkExt, true);
  ShowInToolbar(en_Result, op_OkExt, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

initialization
{$If not defined(NoScripts)}
// Регистрация PrimAttributeSelectOptions
 TtfwClassRef.Register(TPrimAttributeSelectOptionsForm);
{$IfEnd} //not NoScripts

end.