unit vcmHistoryRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmHistoryRes.pas"
// Начат: 04.03.2010 14:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmL10nImpl::vcmHistoryRes
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
 str_vcmWrongHistoryElement : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmWrongHistoryElement'; rValue : 'Ошибочный элемент истории');
  { 'Ошибочный элемент истории' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// Инициализация str_vcmWrongHistoryElement
 str_vcmWrongHistoryElement.Init;
{$IfEnd} //not NoVCM

end.