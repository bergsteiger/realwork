unit ChromeLikeWindowCaptionButtonsRes;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeWindowCaptionButtonsRes.pas"
// Стереотип: "UtilityPack"

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки WindowCaptionButtonsHints }
 str_Close: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Close'; rValue : 'Закрыть');
  {* 'Закрыть' }
 str_Minimize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Minimize'; rValue : 'Свернуть');
  {* 'Свернуть' }
 str_Restore: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Restore'; rValue : 'Свернуть в окно');
  {* 'Свернуть в окно' }
 str_Maximize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Maximize'; rValue : 'Развернуть');
  {* 'Развернуть' }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_Close.Init;
 {* Инициализация str_Close }
 str_Minimize.Init;
 {* Инициализация str_Minimize }
 str_Restore.Init;
 {* Инициализация str_Restore }
 str_Maximize.Init;
 {* Инициализация str_Maximize }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
