unit nsSaveQueryEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\nsSaveQueryEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , SearchUnit
;

type
 TnsSaveQueryEvent = class(TnsLogEvent)
  public
   class procedure Log(const aQuery: IQuery);
 end;//TnsSaveQueryEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

class procedure TnsSaveQueryEvent.Log(const aQuery: IQuery);
//#UC START# *51BEFAF401A3_51BEFA6F00E3_var*
var
 l_Data: InsLogEventData;
//#UC END# *51BEFAF401A3_51BEFA6F00E3_var*
begin
//#UC START# *51BEFAF401A3_51BEFA6F00E3_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aQuery);
 GetLogger.AddEvent(LE_SAVE_QUERY, l_Data);
//#UC END# *51BEFAF401A3_51BEFA6F00E3_impl*
end;//TnsSaveQueryEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
