unit msmControllers;

// Модуль: "w:\common\components\gui\Garant\msm\msmControllers.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmControllers" MUID: (57AAE8D403E5)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , msmEvents
 , msmOperations
 , msmModels
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TmsmView = TControl;

 ImsmCaptionModel = interface(ImsmModel)
  ['{6EB7EA6F-9066-4F62-985E-950805DD8F72}']
  function Get_Caption: Il3CString;
  procedure Set_Caption(const aValue: Il3CString);
  property Caption: Il3CString
   read Get_Caption
   write Set_Caption;
 end;//ImsmCaptionModel

 (*
 MmsmActivateable = interface
  procedure Activate;
  procedure Activated;
 end;//MmsmActivateable
 *)

 TmsmModelEvent = {abstract} class(TmsmEvent)
 end;//TmsmModelEvent

 ImsmActivateable = interface
  ['{CB680824-B54D-4D57-A3DB-87EF7504489D}']
  procedure Activate;
  procedure Activated;
 end;//ImsmActivateable

 TmsmViewParentControl = TWinControl;

 ImsmController = interface(ImsmActivateable)
  ['{EC037151-8355-41ED-BEB3-C02739D2D3B1}']
  function Get_Model: ImsmModel;
  function Get_Operations: ImsmOperationsList;
  function As_ImsmEventsSubscriber: ImsmEventsSubscriber;
   {* Метод приведения нашего интерфейса к ImsmEventsSubscriber }
  procedure DisableEvent(anEvent: TmsmEvent);
  procedure EnableEvent(anEvent: TmsmEvent);
  procedure AddOperation(const anOp: ImsmOperation);
  property Model: ImsmModel
   read Get_Model;
  property Operations: ImsmOperationsList
   read Get_Operations;
 end;//ImsmController

 CaptionChangedEvent = class(TmsmModelEvent)
  public
   class function Instance: CaptionChangedEvent;
    {* Метод получения экземпляра синглетона CaptionChangedEvent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//CaptionChangedEvent

 ImsmViewController = interface(ImsmController)
  ['{97253C71-CB39-4199-AC67-944EFFE8FC5A}']
 end;//ImsmViewController

 TmsmViewContext = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rCaptionModel: ImsmCaptionModel;
  public
   function Caption: AnsiString;
 end;//TmsmViewContext

 ImsmViewParent = interface(ImsmActivateable)
  ['{991389C5-7B8F-4E22-9499-24C2CF2A9309}']
  procedure RemoveView(aView: TmsmView);
  procedure InsertView(aView: TmsmView;
   const aContext: TmsmViewContext);
 end;//ImsmViewParent

function TmsmViewContext_C: TmsmViewContext;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3String
;

var g_CaptionChangedEvent: CaptionChangedEvent = nil;
 {* Экземпляр синглетона CaptionChangedEvent }

procedure CaptionChangedEventFree;
 {* Метод освобождения экземпляра синглетона CaptionChangedEvent }
begin
 l3Free(g_CaptionChangedEvent);
end;//CaptionChangedEventFree

function TmsmViewContext_C: TmsmViewContext;
//#UC START# *57B490440207_57B49009009A_var*
//#UC END# *57B490440207_57B49009009A_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57B490440207_57B49009009A_impl*
//#UC END# *57B490440207_57B49009009A_impl*
end;//TmsmViewContext_C

class function CaptionChangedEvent.Instance: CaptionChangedEvent;
 {* Метод получения экземпляра синглетона CaptionChangedEvent }
begin
 if (g_CaptionChangedEvent = nil) then
 begin
  l3System.AddExitProc(CaptionChangedEventFree);
  g_CaptionChangedEvent := Create;
 end;
 Result := g_CaptionChangedEvent;
end;//CaptionChangedEvent.Instance

class function CaptionChangedEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_CaptionChangedEvent <> nil;
end;//CaptionChangedEvent.Exists

function TmsmViewContext.Caption: AnsiString;
//#UC START# *57DA9C7800B7_57B49009009A_var*
//#UC END# *57DA9C7800B7_57B49009009A_var*
begin
//#UC START# *57DA9C7800B7_57B49009009A_impl*
 if (rCaptionModel = nil) then
  Result := ''
 else
  Result := l3Str(rCaptionModel.Caption);
//#UC END# *57DA9C7800B7_57B49009009A_impl*
end;//TmsmViewContext.Caption

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TmsmView));
 {* Регистрация типа TmsmView }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TmsmViewParentControl));
 {* Регистрация типа TmsmViewParentControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
