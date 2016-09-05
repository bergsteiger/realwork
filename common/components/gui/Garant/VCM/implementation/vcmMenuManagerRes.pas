unit vcmMenuManagerRes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmMenuManagerRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmMenuManagerRes" MUID: (4B8E967F00BE)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки TvcmUserTypeHints }
 str_vcmCloseHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmCloseHint'; rValue : 'Закрыть');
  {* 'Закрыть' }
 str_vcmMaximizedHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmMaximizedHint'; rValue : 'Открыть в новом окне');
  {* 'Открыть в новом окне' }
 str_vcmOpenHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmOpenHint'; rValue : 'Открыть в текущем окне');
  {* 'Открыть в текущем окне' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 //#UC START# *4B8E967F00BEimpl_uses*
 //#UC END# *4B8E967F00BEimpl_uses*
;

initialization
 str_vcmCloseHint.Init;
 {* Инициализация str_vcmCloseHint }
 str_vcmMaximizedHint.Init;
 {* Инициализация str_vcmMaximizedHint }
 str_vcmOpenHint.Init;
 {* Инициализация str_vcmOpenHint }
{$IfEnd} // NOT Defined(NoVCM)

end.
