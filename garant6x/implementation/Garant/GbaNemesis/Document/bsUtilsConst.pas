unit bsUtilsConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Document"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Document/bsUtilsConst.pas"
// Начат: 21.07.2011 19:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Контроллер работы с документом и абстрактная фабрика документа::F1 Document Processing::Document::Document::bsUtilsConst
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
 str_wgReferenceHyperlinkSearchText : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkSearchText'; rValue : 'Подробнее см. в справке к документу');
  { 'Подробнее см. в справке к документу' }
 str_wgReferenceHyperlinkReplaceText : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkReplaceText'; rValue : 'Подробнее [см. в справке к документу|script:оп::Документ_Справка_к_документу|Ссылка на справку к документу]');
  { 'Подробнее [см. в справке к документу|script:оп::Документ_Справка_к_документу|Ссылка на справку к документу]' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_wgReferenceHyperlinkSearchText
 str_wgReferenceHyperlinkSearchText.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_wgReferenceHyperlinkReplaceText
 str_wgReferenceHyperlinkReplaceText.Init;
{$IfEnd} //not Admin AND not Monitorings

end.