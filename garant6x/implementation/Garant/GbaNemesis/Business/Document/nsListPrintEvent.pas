unit nsListPrintEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsListPrintEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::Document::TnsListPrintEvent
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
  DynamicDocListUnit,
  LoggingInterfaces,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsListPrintEvent = class(TnsLogEvent, InsDefferedEvent)
 private
 // private fields
   f_List : IDynList;
   f_Count : Cardinal;
   f_Selection : Boolean;
 protected
 // realized methods
   procedure FireLog;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aList: IDynList;
    aCount: Cardinal;
    aSelection: Boolean); reintroduce;
   class function Make(const aList: IDynList;
    aCount: Cardinal;
    aSelection: Boolean): InsDefferedEvent; reintroduce;
 end;//TnsListPrintEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsListPrintEvent

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
end;

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
//#UC START# *479731C50290_4B0FA8D701F6_var*
//#UC END# *479731C50290_4B0FA8D701F6_var*
begin
//#UC START# *479731C50290_4B0FA8D701F6_impl*
 f_List := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4B0FA8D701F6_impl*
end;//TnsListPrintEvent.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.