unit csNotifyObj;

// Модуль: "w:\common\components\rtl\Garant\cs\csNotifyObj.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsNotifyObj" MUID: (52FB990303A4)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , CsNotification
;

type
 TCsOnNotificationProc = function(aNotificationType: TCsNotificationType;
  aNumber: Integer;
  const aText: AnsiString): Boolean of object;

 TcsNotifyObj = class(Tl3ProtoObject)
  public
   Proc: TCsOnNotificationProc;
  public
   constructor Create(aProc: TCsOnNotificationProc); reintroduce;
 end;//TcsNotifyObj
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *52FB990303A4impl_uses*
 //#UC END# *52FB990303A4impl_uses*
;

constructor TcsNotifyObj.Create(aProc: TCsOnNotificationProc);
//#UC START# *52FB999100DA_52FB990303A4_var*
//#UC END# *52FB999100DA_52FB990303A4_var*
begin
//#UC START# *52FB999100DA_52FB990303A4_impl*
 inherited Create;
 Proc := aProc;
//#UC END# *52FB999100DA_52FB990303A4_impl*
end;//TcsNotifyObj.Create
{$IfEnd} // NOT Defined(Nemesis)

end.
