unit vcmCustomizeToolsRes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmCustomizeToolsRes.pas"
// Стереотип: "UtilityPack"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 , l3StringIDEx
;

const
 {* Локализуемые строки ToolbarPos }
 str_vcmetbpTop: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpTop'; rValue : 'Верхняя');
  {* 'Верхняя' }
 str_vcmetbpBottom: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpBottom'; rValue : 'Нижняя');
  {* 'Нижняя' }
 str_vcmetbpLeft: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpLeft'; rValue : 'Левая');
  {* 'Левая' }
 str_vcmetbpRight: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpRight'; rValue : 'Правая');
  {* 'Правая' }
 {* Карта преобразования локализованных строк ToolbarPos }
 Top: Pl3StringIDEx = str_vcmetbpTop;
 Bottom: Pl3StringIDEx = str_vcmetbpBottom;
 Left: Pl3StringIDEx = str_vcmetbpLeft;
 Right: Pl3StringIDEx = str_vcmetbpRight;
 {* Локализуемые строки Local }
 str_vcmSeparator: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmSeparator'; rValue : '- Разделитель -');
  {* '- Разделитель -' }
 str_vcmAskResoreToolbar: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmAskResoreToolbar'; rValue : 'Вы действительно хотите восстановить позиции и набор операций всех панелей инструментов системы по умолчанию?');
  {* 'Вы действительно хотите восстановить позиции и набор операций всех панелей инструментов системы по умолчанию?' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_vcmetbpTop.Init;
 {* Инициализация str_vcmetbpTop }
 str_vcmetbpBottom.Init;
 {* Инициализация str_vcmetbpBottom }
 str_vcmetbpLeft.Init;
 {* Инициализация str_vcmetbpLeft }
 str_vcmetbpRight.Init;
 {* Инициализация str_vcmetbpRight }
 str_vcmSeparator.Init;
 {* Инициализация str_vcmSeparator }
 str_vcmAskResoreToolbar.Init;
 {* Инициализация str_vcmAskResoreToolbar }
{$IfEnd} // NOT Defined(NoVCM)

end.
