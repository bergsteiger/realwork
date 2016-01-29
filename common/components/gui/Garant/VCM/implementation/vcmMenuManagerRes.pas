unit vcmMenuManagerRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmMenuManagerRes.pas"
// Начат: 03.03.2010 20:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmL10nImpl::vcmMenuManagerRes
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
  { Локализуемые строки TvcmUserTypeHints }
 str_vcmCloseHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmCloseHint'; rValue : 'Закрыть');
  { 'Закрыть' }
 str_vcmMaximizedHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmMaximizedHint'; rValue : 'Открыть в новом окне');
  { 'Открыть в новом окне' }
 str_vcmOpenHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmOpenHint'; rValue : 'Открыть в текущем окне');
  { 'Открыть в текущем окне' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// Инициализация str_vcmCloseHint
 str_vcmCloseHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vcmMaximizedHint
 str_vcmMaximizedHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vcmOpenHint
 str_vcmOpenHint.Init;
{$IfEnd} //not NoVCM

end.