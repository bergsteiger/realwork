unit dsDocumentListCRToPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Document"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Document/dsDocumentListCRToPart.pas"
// Начат: 26.11.2008 19:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Контроллер работы с документом и абстрактная фабрика документа::F1 Document Processing::Document::Document::TdsDocumentListCRToPart
//
// СКР к фрагменту
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
  dsDocumentListCR
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsDocumentListCRToPart = {vac} class(TdsDocumentListCR)
  {* СКР к фрагменту }
 protected
 // overridden protected methods
   function ToPart: Boolean; override;
 end;//TdsDocumentListCRToPart
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsDocumentListCRToPart

function TdsDocumentListCRToPart.ToPart: Boolean;
//#UC START# *492D797E007F_492D78650003_var*
//#UC END# *492D797E007F_492D78650003_var*
begin
//#UC START# *492D797E007F_492D78650003_impl*
 Result := true;
//#UC END# *492D797E007F_492D78650003_impl*
end;//TdsDocumentListCRToPart.ToPart

{$IfEnd} //not Admin AND not Monitorings

end.