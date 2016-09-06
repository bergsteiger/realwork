unit msmControllers;

// Модуль: "w:\common\components\gui\Garant\msm\msmControllers.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmControllers" MUID: (57AAE8D403E5)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmEvents
 , msmOperations
 , msmModels
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TmsmView = TControl;

 TmsmViewContext = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rCaption: AnsiString;
 end;//TmsmViewContext

 ImsmViewParent = interface
  ['{991389C5-7B8F-4E22-9499-24C2CF2A9309}']
  procedure RemoveView(aView: TmsmView);
  procedure InsertView(aView: TmsmView;
   const aContext: TmsmViewContext);
 end;//ImsmViewParent

 ImsmController = interface
  ['{EC037151-8355-41ED-BEB3-C02739D2D3B1}']
  function Get_Model: ImsmModel;
  function Get_Operations: ImsmOperationsList;
  procedure Activate;
  procedure Activated;
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

 TmsmModelEvent = {abstract} class(TmsmEvent)
 end;//TmsmModelEvent

 ImsmViewController = interface(ImsmController)
  ['{97253C71-CB39-4199-AC67-944EFFE8FC5A}']
 end;//ImsmViewController

 TmsmViewParentControl = TWinControl;

function TmsmViewContext_C: TmsmViewContext;

implementation

uses
 l3ImplUses
;

function TmsmViewContext_C: TmsmViewContext;
//#UC START# *57B490440207_57B49009009A_var*
//#UC END# *57B490440207_57B49009009A_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57B490440207_57B49009009A_impl*
//#UC END# *57B490440207_57B49009009A_impl*
end;//TmsmViewContext_C

end.
