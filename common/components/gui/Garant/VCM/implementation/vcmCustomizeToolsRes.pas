unit vcmCustomizeToolsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmCustomizeToolsRes.pas"
// Начат: 03.03.2010 20:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmL10nImpl::vcmCustomizeToolsRes
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
  vcmUserControls,
  l3StringIDEx
  ;

var
  { Локализуемые строки ToolbarPos }
 str_vcmetbpTop : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpTop'; rValue : 'Верхняя');
  { 'Верхняя' }
 str_vcmetbpBottom : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpBottom'; rValue : 'Нижняя');
  { 'Нижняя' }
 str_vcmetbpLeft : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpLeft'; rValue : 'Левая');
  { 'Левая' }
 str_vcmetbpRight : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpRight'; rValue : 'Правая');
  { 'Правая' }

const
  { Карта преобразования локализованных строк ToolbarPos }
 ToolbarPosMap : array [TvcmEffectiveToolBarPos] of Pl3StringIDEx = (
  @str_vcmetbpTop
  , @str_vcmetbpBottom
  , @str_vcmetbpLeft
  , @str_vcmetbpRight
 );//ToolbarPosMap

var
  { Локализуемые строки Local }
 str_vcmSeparator : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmSeparator'; rValue : '- Разделитель -');
  { '- Разделитель -' }
 str_vcmAskResoreToolbar : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmAskResoreToolbar'; rValue : 'Вы действительно хотите восстановить позиции и набор операций всех панелей инструментов системы по умолчанию?');
  { 'Вы действительно хотите восстановить позиции и набор операций всех панелей инструментов системы по умолчанию?' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// Инициализация str_vcmetbpTop
 str_vcmetbpTop.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vcmetbpBottom
 str_vcmetbpBottom.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vcmetbpLeft
 str_vcmetbpLeft.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vcmetbpRight
 str_vcmetbpRight.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vcmSeparator
 str_vcmSeparator.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vcmAskResoreToolbar
 str_vcmAskResoreToolbar.Init;
{$IfEnd} //not NoVCM

end.