unit nscRemindersLine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscRemindersLine.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::Reminders::nscRemindersLine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLineWithState
  {$IfEnd} //not NoVGScene
  
  ;

type
 TnscRemindersLine = vgRemindersLineWithState.TvgRemindersLineWithState;
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
{$IfEnd} //Nemesis
end.