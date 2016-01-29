unit vgReminderConsts;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/vgReminderConsts.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT$Rem::NewReminders::vgReminderConsts
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
const
  { New Reminder Consts }
 c_ReminderDistance = 0;
  { Расстояние между медалями в линии }
 c_FlashInterval = 400;
  { Полпериода мигания медали }
 c_DefaultReminderOpacity = 0.7;
  { Прозрачность медали по умолчанию }
 c_FlashingReminderOpacity = 0.4;
  { Прозрачность медали при мигании }
 c_ReminderTextHIndent = 7;
  { Отступ текста по горизонтали в плашке с текстом }
 c_ReminderTextVIndent = 5;
  { Отступ текста по вертикали в плашке с текстом }
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
{$IfEnd} //not NoVGScene
end.