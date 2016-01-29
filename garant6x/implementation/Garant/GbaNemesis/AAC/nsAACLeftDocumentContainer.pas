unit nsAACLeftDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AAC$DataSources"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/AAC/nsAACLeftDocumentContainer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::AAC::AAC$DataSources::AACImplementation::TnsAACLeftDocumentContainer
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
  nsAACDocumentContainerPrim
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsAACLeftDocumentContainer = class(TnsAACDocumentContainerPrim)
 protected
 // realized methods
   function AcceptableBlockViewKinds: TnsBlockViewKinds; override;
 end;//TnsAACLeftDocumentContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  evdTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsAACLeftDocumentContainer

function TnsAACLeftDocumentContainer.AcceptableBlockViewKinds: TnsBlockViewKinds;
//#UC START# *500E7677002B_500E75A000B0_var*
//#UC END# *500E7677002B_500E75A000B0_var*
begin
//#UC START# *500E7677002B_500E75A000B0_impl*
 Result := [ev_bvkLeft];
//#UC END# *500E7677002B_500E75A000B0_impl*
end;//TnsAACLeftDocumentContainer.AcceptableBlockViewKinds

{$IfEnd} //not Admin AND not Monitorings

end.