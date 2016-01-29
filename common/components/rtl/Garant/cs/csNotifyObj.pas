unit csNotifyObj;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csNotifyObj.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsNotifyObj
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  CsNotification
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TCsOnNotificationProc = function (aNotificationType: TCsNotificationType;
  aNumber: Integer;
  const aText: AnsiString): Boolean of object;

 TcsNotifyObj = class(Tl3ProtoObject)
 public
 // public fields
   Proc : TCsOnNotificationProc;
 public
 // public methods
   constructor Create(aProc: TCsOnNotificationProc); reintroduce;
 end;//TcsNotifyObj
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}

// start class TcsNotifyObj

constructor TcsNotifyObj.Create(aProc: TCsOnNotificationProc);
//#UC START# *52FB999100DA_52FB990303A4_var*
//#UC END# *52FB999100DA_52FB990303A4_var*
begin
//#UC START# *52FB999100DA_52FB990303A4_impl*
 inherited Create;
 Proc := aProc;
//#UC END# *52FB999100DA_52FB990303A4_impl*
end;//TcsNotifyObj.Create

{$IfEnd} //not Nemesis

end.