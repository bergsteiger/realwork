unit vgReminderConsts;

// Модуль: "w:\common\components\gui\Garant\VT\vgReminderConsts.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
;

const
 c_ReminderDistance = 0;
  {* Расстояние между медалями в линии }
 c_FlashInterval = 400;
  {* Полпериода мигания медали }
 c_DefaultReminderOpacity = 0.7;
  {* Прозрачность медали по умолчанию }
 c_FlashingReminderOpacity = 0.4;
  {* Прозрачность медали при мигании }
 c_ReminderTextHIndent = 7;
  {* Отступ текста по горизонтали в плашке с текстом }
 c_ReminderTextVIndent = 5;
  {* Отступ текста по вертикали в плашке с текстом }
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
