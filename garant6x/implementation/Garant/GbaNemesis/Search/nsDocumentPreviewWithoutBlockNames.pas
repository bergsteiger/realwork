unit nsDocumentPreviewWithoutBlockNames;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsDocumentPreviewWithoutBlockNames.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TnsDocumentPreviewWithoutBlockNames
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
  nsDocumentPreview
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsDocumentPreviewWithoutBlockNames = class(TnsDocumentPreview)
 protected
 // overridden protected methods
   function NeedAddBlockNames: Boolean; override;
     {* Нужно ли добавлять имена блоков }
 end;//TnsDocumentPreviewWithoutBlockNames
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}

// start class TnsDocumentPreviewWithoutBlockNames

function TnsDocumentPreviewWithoutBlockNames.NeedAddBlockNames: Boolean;
//#UC START# *4A2E97A4021B_54DC54FD024B_var*
//#UC END# *4A2E97A4021B_54DC54FD024B_var*
begin
//#UC START# *4A2E97A4021B_54DC54FD024B_impl*
 Result := False;
//#UC END# *4A2E97A4021B_54DC54FD024B_impl*
end;//TnsDocumentPreviewWithoutBlockNames.NeedAddBlockNames

{$IfEnd} //not Admin

end.