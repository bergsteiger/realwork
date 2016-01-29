unit nsAACDocumentSynchroViewContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/nsAACDocumentSynchroViewContainer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::F1DocumentProcessing::F1DocumentContainers::TnsAACDocumentSynchroViewContainer
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
 TnsAACDocumentSynchroViewContainer = class(TnsAACDocumentContainerPrim)
 protected
 // realized methods
   function AcceptableBlockViewKinds: TnsBlockViewKinds; override;
 end;//TnsAACDocumentSynchroViewContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  evdTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsAACDocumentSynchroViewContainer

function TnsAACDocumentSynchroViewContainer.AcceptableBlockViewKinds: TnsBlockViewKinds;
//#UC START# *500E7677002B_5024E55600ED_var*
//#UC END# *500E7677002B_5024E55600ED_var*
begin
//#UC START# *500E7677002B_5024E55600ED_impl*
 Result := [ev_bvkLeft, ev_bvkRight];
//#UC END# *500E7677002B_5024E55600ED_impl*
end;//TnsAACDocumentSynchroViewContainer.AcceptableBlockViewKinds

{$IfEnd} //not Admin AND not Monitorings

end.