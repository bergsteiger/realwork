unit nscContextFilterRes;
 {* Ресурсы для TnscContextFilter }

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscContextFilterRes.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ContextFilterMessages }
 str_nsc_LabelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_LabelCaption'; rValue : 'Контекстный фильтр');
  {* 'Контекстный фильтр' }
 str_nsc_ContextEmptyMessage: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ContextEmptyMessage'; rValue : 'Введите слова для поиска и фильтрации');
  {* 'Введите слова для поиска и фильтрации' }
 str_nsc_ButtonActiveHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ButtonActiveHint'; rValue : 'Выключить контекстный фильтр');
  {* 'Выключить контекстный фильтр' }
 str_nsc_ButtonInActiveHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ButtonInActiveHint'; rValue : 'Включить контекстный фильтр');
  {* 'Включить контекстный фильтр' }
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_nsc_LabelCaption.Init;
 {* Инициализация str_nsc_LabelCaption }
 str_nsc_ContextEmptyMessage.Init;
 {* Инициализация str_nsc_ContextEmptyMessage }
 str_nsc_ButtonActiveHint.Init;
 {* Инициализация str_nsc_ButtonActiveHint }
 str_nsc_ButtonInActiveHint.Init;
 {* Инициализация str_nsc_ButtonInActiveHint }
{$IfEnd} // Defined(Nemesis)

end.
