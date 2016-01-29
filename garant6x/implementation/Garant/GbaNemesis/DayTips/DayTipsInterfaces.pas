unit DayTipsInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DayTips"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/DayTips/DayTipsInterfaces.pas"
// Начат: 10.02.2009 21:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Интерфейсные элементы::DayTips::DayTips::DayTipsInterfaces
//
// Интерфейсы работы с советами дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces
  ;

type
 InsStartupTips = interface(IUnknown)
   ['{620A7D19-668A-40BC-8A2F-F4AE63DE6C6A}']
   function pm_GetDontShow: Boolean;
   procedure pm_SetDontShow(aValue: Boolean);
   function pm_GetTipCaption: Il3CString;
   procedure Next;
   procedure Prev;
   procedure ShowDetails;
   procedure GotoWeb;
   property DontShow: Boolean
     read pm_GetDontShow
     write pm_SetDontShow;
   property TipCaption: Il3CString
     read pm_GetTipCaption;
 end;//InsStartupTips
{$IfEnd} //not Admin AND not Monitorings

implementation

end.