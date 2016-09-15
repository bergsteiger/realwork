unit msmTabCaptionController;

// Модуль: "w:\common\components\gui\Garant\msm\msmTabCaptionController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmTabCaptionController" MUID: (57DAA6FB0365)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmControllers
 , msmPageControl
 , msmEvents
 , msmViewController
;

type
 _ConcreteModel_ = ImsmCaptionModel;
 _ViewClass_ = TmsmTabSheet;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelAndConcreteViewController.imp.pas}
 TmsmTabCaptionController = class(_msmConcreteModelAndConcreteViewController_)
  protected
   procedure DoCaptionChangedEvent(anEvent: TmsmEvent);
   procedure LinkDataToView; override;
   procedure LinkEventHandlers; override;
 end;//TmsmTabCaptionController

implementation

uses
 l3ImplUses
 //#UC START# *57DAA6FB0365impl_uses*
 , l3String
 //#UC END# *57DAA6FB0365impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelAndConcreteViewController.imp.pas}

procedure TmsmTabCaptionController.DoCaptionChangedEvent(anEvent: TmsmEvent);
//#UC START# *57DAA6FB0365_57CD31A200FA_57DAA6FB0365_var*
//#UC END# *57DAA6FB0365_57CD31A200FA_57DAA6FB0365_var*
begin
//#UC START# *57DAA6FB0365_57CD31A200FA_57DAA6FB0365_impl*
 inherited;
 Self.View.Caption := l3Str(Model.Caption);
//#UC END# *57DAA6FB0365_57CD31A200FA_57DAA6FB0365_impl*
end;//TmsmTabCaptionController.DoCaptionChangedEvent

procedure TmsmTabCaptionController.LinkDataToView;
//#UC START# *57B6A49900F4_57DAA6FB0365_var*
//#UC END# *57B6A49900F4_57DAA6FB0365_var*
begin
//#UC START# *57B6A49900F4_57DAA6FB0365_impl*
 inherited;
 Self.View.Caption := l3Str(Model.Caption);
//#UC END# *57B6A49900F4_57DAA6FB0365_impl*
end;//TmsmTabCaptionController.LinkDataToView

procedure TmsmTabCaptionController.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CaptionChangedEvent.Instance, DoCaptionChangedEvent);
end;//TmsmTabCaptionController.LinkEventHandlers

end.
