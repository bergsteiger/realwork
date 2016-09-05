unit vcmBaseMenuManagerRes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmBaseMenuManagerRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmBaseMenuManagerRes" MUID: (4B8F8EA1013C)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_vcmShowTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmShowTab'; rValue : 'Показать вкладку "%s"');
  {* 'Показать вкладку "%s"' }
 str_vcmHideTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmHideTab'; rValue : 'Скрыть вкладку "%s"');
  {* 'Скрыть вкладку "%s"' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 //#UC START# *4B8F8EA1013Cimpl_uses*
 //#UC END# *4B8F8EA1013Cimpl_uses*
;

initialization
 str_vcmShowTab.Init;
 {* Инициализация str_vcmShowTab }
 str_vcmHideTab.Init;
 {* Инициализация str_vcmHideTab }
{$IfEnd} // NOT Defined(NoVCM)

end.
