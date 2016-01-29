unit vcmBaseMenuManagerRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmBaseMenuManagerRes.pas"
// Начат: 04.03.2010 13:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmL10nImpl::vcmBaseMenuManagerRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3StringIDEx
  ;

var
  { Локализуемые строки Local }
 str_vcmShowTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmShowTab'; rValue : 'Показать вкладку "%s"');
  { 'Показать вкладку "%s"' }
 str_vcmHideTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmHideTab'; rValue : 'Скрыть вкладку "%s"');
  { 'Скрыть вкладку "%s"' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// Инициализация str_vcmShowTab
 str_vcmShowTab.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vcmHideTab
 str_vcmHideTab.Init;
{$IfEnd} //not NoVCM

end.