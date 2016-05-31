unit nscCustomTreeComboWithHistoryRes;
 {* Ресурсы для TnscCustomTreeComboWithHistory }

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscCustomTreeComboWithHistoryRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nscCustomTreeComboWithHistoryRes" MUID: (4B97EE59039E)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки MiscMessages }
 str_nsc_CloseHyperlinkText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_CloseHyperlinkText'; rValue : 'Закрыть');
  {* 'Закрыть' }
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

initialization
 str_nsc_CloseHyperlinkText.Init;
 {* Инициализация str_nsc_CloseHyperlinkText }
{$IfEnd} // Defined(Nemesis)

end.
