unit nsTabbedContainerUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TabInterface"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/TabInterface/nsTabbedContainerUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Базовые определения предметной области::LegalDomain::TabInterface::TabbedInterfaceSupport::nsTabbedContainerUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  ;

function nsDocumentsFromListOpenKind: TvcmMainFormOpenKind;
function nsLinksFromDocumentOpenKind: TvcmMainFormOpenKind;

implementation

uses
  nsConst,
  afwFacade
  ;

// unit methods

function nsGetOpenKindSettingsValue(const aSettingsName: AnsiString): TvcmMainFormOpenKind;
//#UC START# *53A40360003B_53A403330029_var*
//#UC END# *53A40360003B_53A403330029_var*
begin
//#UC START# *53A40360003B_53A403330029_impl*
 Result := TvcmMainFormOpenKind(afw.Settings.LoadInteger(aSettingsName));
//#UC END# *53A40360003B_53A403330029_impl*
end;//nsGetOpenKindSettingsValue

function nsDocumentsFromListOpenKind: TvcmMainFormOpenKind;
//#UC START# *53A4034102D5_53A403330029_var*
//#UC END# *53A4034102D5_53A403330029_var*
begin
//#UC START# *53A4034102D5_53A403330029_impl*
 Result := nsGetOpenKindSettingsValue(pi_OpenDocumentsFromList);
//#UC END# *53A4034102D5_53A403330029_impl*
end;//nsDocumentsFromListOpenKind

function nsLinksFromDocumentOpenKind: TvcmMainFormOpenKind;
//#UC START# *53A403510223_53A403330029_var*
//#UC END# *53A403510223_53A403330029_var*
begin
//#UC START# *53A403510223_53A403330029_impl*
 Result := nsGetOpenKindSettingsValue(pi_OpenLinksFromDocument);
//#UC END# *53A403510223_53A403330029_impl*
end;//nsLinksFromDocumentOpenKind

end.