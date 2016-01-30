unit vcmHistoryRes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmHistoryRes.pas"
// Стереотип: "UtilityPack"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_vcmWrongHistoryElement: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmWrongHistoryElement'; rValue : 'Ошибочный элемент истории');
  {* 'Ошибочный элемент истории' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_vcmWrongHistoryElement.Init;
 {* Инициализация str_vcmWrongHistoryElement }
{$IfEnd} // NOT Defined(NoVCM)

end.
