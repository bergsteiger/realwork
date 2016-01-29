unit dsBaseContentsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsBaseContentsRes.pas"
// Начат: 27.01.2011 16:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Common::Business::BaseDocument::dsBaseContentsRes
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
 str_CommentStub : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CommentStub'; rValue : 'Комментарий №%d к параграфу %d');
  { 'Комментарий №%d к параграфу %d' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_CommentStub
 str_CommentStub.Init;
{$IfEnd} //not Admin AND not Monitorings

end.