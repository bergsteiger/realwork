unit msmController;

// Модуль: "w:\common\components\gui\Garant\msm\msmController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmController" MUID: (57B1F28B030D)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmControllers
 , msmModels
 , msmEvents
 , msmOperations
 , msmOperationsList
 , msmEventList
 , msmEventHandlers
;

type
 _msmOperationsManaging_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\gui\Garant\msm\msmOperationsManaging.imp.pas}
 _msmEventsSubscriber_Parent_ = _msmOperationsManaging_;
 {$Include w:\common\components\gui\Garant\msm\msmEventsSubscriber.imp.pas}
 TmsmController = class(_msmEventsSubscriber_, ImsmController)
  private
   f_Model: ImsmModel;
  protected
   procedure DoActivate; virtual;
   procedure LinkDataToView; virtual;
   procedure DoActivated; virtual;
   function As_ImsmEventsSubscriber: ImsmEventsSubscriber;
    {* Метод приведения нашего интерфейса к ImsmEventsSubscriber }
   function Get_Model: ImsmModel;
   function Publisher: ImsmEventsPublisher; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   constructor Create(const aModel: ImsmModel); reintroduce;
   class function Make(const aModel: ImsmModel): ImsmController; reintroduce;
   procedure Activate;
   procedure Activated;
  protected
   property Model: ImsmModel
    read f_Model;
 end;//TmsmController

implementation

uses
 l3ImplUses
 , SysUtils
 , msmNullOperationsList
 //#UC START# *57B1F28B030Dimpl_uses*
 //#UC END# *57B1F28B030Dimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmOperationsManaging.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmEventsSubscriber.imp.pas}

procedure TmsmController.DoActivate;
//#UC START# *57B1ABC80368_57B1F28B030D_var*
//#UC END# *57B1ABC80368_57B1F28B030D_var*
begin
//#UC START# *57B1ABC80368_57B1F28B030D_impl*
//#UC END# *57B1ABC80368_57B1F28B030D_impl*
end;//TmsmController.DoActivate

constructor TmsmController.Create(const aModel: ImsmModel);
//#UC START# *57B1F34803E0_57B1F28B030D_var*
//#UC END# *57B1F34803E0_57B1F28B030D_var*
begin
//#UC START# *57B1F34803E0_57B1F28B030D_impl*
 Assert(aModel <> nil);
 f_Model := aModel;
 inherited Create;
//#UC END# *57B1F34803E0_57B1F28B030D_impl*
end;//TmsmController.Create

class function TmsmController.Make(const aModel: ImsmModel): ImsmController;
var
 l_Inst : TmsmController;
begin
 l_Inst := Create(aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmController.Make

procedure TmsmController.LinkDataToView;
//#UC START# *57B6A49900F4_57B1F28B030D_var*
//#UC END# *57B6A49900F4_57B1F28B030D_var*
begin
//#UC START# *57B6A49900F4_57B1F28B030D_impl*
//#UC END# *57B6A49900F4_57B1F28B030D_impl*
end;//TmsmController.LinkDataToView

procedure TmsmController.DoActivated;
//#UC START# *57CEC64E0063_57B1F28B030D_var*
//#UC END# *57CEC64E0063_57B1F28B030D_var*
begin
//#UC START# *57CEC64E0063_57B1F28B030D_impl*
//#UC END# *57CEC64E0063_57B1F28B030D_impl*
end;//TmsmController.DoActivated

function TmsmController.As_ImsmEventsSubscriber: ImsmEventsSubscriber;
 {* Метод приведения нашего интерфейса к ImsmEventsSubscriber }
begin
 Result := Self;
end;//TmsmController.As_ImsmEventsSubscriber

function TmsmController.Get_Model: ImsmModel;
//#UC START# *57ADBECA0388_57B1F28B030Dget_var*
//#UC END# *57ADBECA0388_57B1F28B030Dget_var*
begin
//#UC START# *57ADBECA0388_57B1F28B030Dget_impl*
 Result := f_Model;
//#UC END# *57ADBECA0388_57B1F28B030Dget_impl*
end;//TmsmController.Get_Model

procedure TmsmController.Activate;
//#UC START# *57B1AB98014B_57B1F28B030D_var*
//#UC END# *57B1AB98014B_57B1F28B030D_var*
begin
//#UC START# *57B1AB98014B_57B1F28B030D_impl*
 DoActivate;
//#UC END# *57B1AB98014B_57B1F28B030D_impl*
end;//TmsmController.Activate

procedure TmsmController.Activated;
//#UC START# *57B6A3EF0191_57B1F28B030D_var*
//#UC END# *57B6A3EF0191_57B1F28B030D_var*
begin
//#UC START# *57B6A3EF0191_57B1F28B030D_impl*
 LinkDataToView;
 DoActivated;
//#UC END# *57B6A3EF0191_57B1F28B030D_impl*
end;//TmsmController.Activated

function TmsmController.Publisher: ImsmEventsPublisher;
//#UC START# *57B6B9CD03B7_57B1F28B030D_var*
//#UC END# *57B6B9CD03B7_57B1F28B030D_var*
begin
//#UC START# *57B6B9CD03B7_57B1F28B030D_impl*
 Result := Model.As_ImsmEventsPublisher;
//#UC END# *57B6B9CD03B7_57B1F28B030D_impl*
end;//TmsmController.Publisher

procedure TmsmController.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B1F28B030D_var*
//#UC END# *479731C50290_57B1F28B030D_var*
begin
//#UC START# *479731C50290_57B1F28B030D_impl*
 inherited;
//#UC END# *479731C50290_57B1F28B030D_impl*
end;//TmsmController.Cleanup

procedure TmsmController.InitFields;
//#UC START# *47A042E100E2_57B1F28B030D_var*
//#UC END# *47A042E100E2_57B1F28B030D_var*
begin
//#UC START# *47A042E100E2_57B1F28B030D_impl*
 Assert(Model <> nil);
 inherited;
//#UC END# *47A042E100E2_57B1F28B030D_impl*
end;//TmsmController.InitFields

procedure TmsmController.ClearFields;
begin
 f_Model := nil;
 inherited;
end;//TmsmController.ClearFields

end.
