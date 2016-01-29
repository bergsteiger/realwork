unit nsMedicContentsTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/nsMedicContentsTree.pas"
// Начат: 30.10.2008 20:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::F1DocumentProcessing::F1DocumentContainers::TnsMedicContentsTree
//
// Документ Инфарма. См. [$121166984]
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
  nsContentsTree,
  afwInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMedicContentsTree = class(TnsContentsTree)
  {* Документ Инфарма. См. [$121166984] }
 protected
 // overridden protected methods
   function SettingsID: TafwSettingId; override;
 end;//TnsMedicContentsTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsConst
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsMedicContentsTree

function TnsMedicContentsTree.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_4909E96D01ED_var*
//#UC END# *48FF56D003E6_4909E96D01ED_var*
begin
//#UC START# *48FF56D003E6_4909E96D01ED_impl*
  Result := gi_cpDrugContents;
//#UC END# *48FF56D003E6_4909E96D01ED_impl*
end;//TnsMedicContentsTree.SettingsID

{$IfEnd} //not Admin AND not Monitorings

end.