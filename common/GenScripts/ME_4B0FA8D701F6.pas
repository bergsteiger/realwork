unit nsListPrintEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsListPrintEvent.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , LoggingInterfaces
 , DynamicDocListUnit
;

type
 TnsListPrintEvent = class(TnsLogEvent, InsDefferedEvent)
  private
   f_List: IDynList;
   f_Count: Cardinal;
   f_Selection: Boolean;
  protected
   procedure FireLog;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aList: IDynList;
    aCount: Cardinal;
    aSelection: Boolean); reintroduce;
   class function Make(const aList: IDynList;
    aCount: Cardinal;
    aSelection: Boolean): InsDefferedEvent; reintroduce;
 end;//TnsListPrintEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
;

constructor TnsListPrintEvent.Create(const aList: IDynList;
 aCount: Cardinal;
 aSelection: Boolean);
//#UC START# *4B0FA9940328_4B0FA8D701F6_var*
//#UC END# *4B0FA9940328_4B0FA8D701F6_var*
begin
//#UC START# *4B0FA9940328_4B0FA8D701F6_impl*
 inherited Create;
 f_List := aList;
 f_Count := aCount;
 f_Selection := aSelection;
//#UC END# *4B0FA9940328_4B0FA8D701F6_impl*
end;//TnsListPrintEvent.Create

class function TnsListPrintEvent.Make(const aList: IDynList;
 aCount: Cardinal;
 aSelection: Boolean): InsDefferedEvent;
var
 l_Inst : TnsListPrintEvent;
begin
 l_Inst := Create(aList, aCount, aSelection);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsListPrintEvent.Make

procedure TnsListPrintEvent.FireLog;
//#UC START# *4B0FA5CB0254_4B0FA8D701F6_var*
var
 l_Data: InsLogEventData;
const
 cMap: array [Boolean] of Cardinal = (0, 1); 
//#UC END# *4B0FA5CB0254_4B0FA8D701F6_var*
begin
//#UC START# *4B0FA5CB0254_4B0FA8D701F6_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(f_List);
 l_Data.AddULong(f_Count);
 l_Data.AddULong(cMap[f_Selection]);
 GetLogger.AddEvent(LE_LIST_PRINT, l_Data);
//#UC END# *4B0FA5CB0254_4B0FA8D701F6_impl*
end;//TnsListPrintEvent.FireLog

procedure TnsListPrintEvent.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B0FA8D701F6_var*
//#UC END# *479731C50290_4B0FA8D701F6_var*
begin
//#UC START# *479731C50290_4B0FA8D701F6_impl*
 f_List := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4B0FA8D701F6_impl*
end;//TnsListPrintEvent.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
