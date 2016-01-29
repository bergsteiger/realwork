unit DocumentUtil;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUtil.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Работа с документом и списком документов::Document::View::DocumentUtils::DocumentUtil
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
  l3StringIDEx
  ;

var
  { Локализуемые строки Local }
 str_IsDocumentUsefulCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'IsDocumentUsefulCaption'; rValue : 'Полезен ли документ?');
  { 'Полезен ли документ?' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_IsDocumentUsefulCaption
 str_IsDocumentUsefulCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.