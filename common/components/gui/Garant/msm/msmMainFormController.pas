unit msmMainFormController;

// Модуль: "w:\common\components\gui\Garant\msm\msmMainFormController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmMainFormController" MUID: (57AE06A901F9)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmControllers
 , msmEvents
 , msmViewController
;

type
 _ConcreteModel_ = ImsmCaptionModel;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelViewController.imp.pas}
 TmsmMainFormController = class(_msmConcreteModelViewController_)
  protected
   procedure DoCaptionChangedEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmMainFormController

implementation

uses
 l3ImplUses
 //#UC START# *57AE06A901F9impl_uses*
 , Forms
 , l3String
 //#UC END# *57AE06A901F9impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelViewController.imp.pas}

procedure TmsmMainFormController.DoCaptionChangedEvent(anEvent: TmsmEvent);
//#UC START# *57AE06A901F9_57CD31A200FA_57AE06A901F9_var*
//#UC END# *57AE06A901F9_57CD31A200FA_57AE06A901F9_var*
begin
//#UC START# *57AE06A901F9_57CD31A200FA_57AE06A901F9_impl*
 inherited;
 TForm(View).Caption := l3Str(Model.Caption);
//#UC END# *57AE06A901F9_57CD31A200FA_57AE06A901F9_impl*
end;//TmsmMainFormController.DoCaptionChangedEvent

procedure TmsmMainFormController.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CaptionChangedEvent.Instance, DoCaptionChangedEvent);
end;//TmsmMainFormController.LinkEventHandlers

end.
