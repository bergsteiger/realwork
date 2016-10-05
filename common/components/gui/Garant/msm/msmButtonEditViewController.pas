unit msmButtonEditViewController;

// Модуль: "w:\common\components\gui\Garant\msm\msmButtonEditViewController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmButtonEditViewController" MUID: (57EAA0F20125)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmButtonEdit
 , msmControllers
 , msmViewControllersUtils
 , msmEvents
 , msmParentedViewController
 , msmModels
;

type
 _OwnViewClass_ = TmsmButtonEdit;
 _ConcreteModel_ = ImsmCaptionModel;
 _InitContext_ = TmsmDefaultInitContext;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}
 TmsmButtonEditViewController = class(_msmConcreteModelOwnViewController_)
  protected
   procedure DoButtonClick(Sender: TObject); virtual;
   procedure DoCaptionChangedEvent(anEvent: TmsmEvent);
   procedure InitOwnView; override;
   procedure LinkDataToView; override;
   procedure LinkEventHandlers; override;
 end;//TmsmButtonEditViewController

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *57EAA0F20125impl_uses*
 , l3String
 , msmImages
 //#UC END# *57EAA0F20125impl_uses*
;

type
 TmsmButtonEditButtonFriend = {abstract} class(TmsmButtonEditButton)
  {* Друг к классу TmsmButtonEditButton }
 end;//TmsmButtonEditButtonFriend

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}

procedure TmsmButtonEditViewController.DoButtonClick(Sender: TObject);
//#UC START# *57EAA4D102DD_57EAA0F20125_var*
//#UC END# *57EAA4D102DD_57EAA0F20125_var*
begin
//#UC START# *57EAA4D102DD_57EAA0F20125_impl*
 Model.Caption := OwnView.Text;
//#UC END# *57EAA4D102DD_57EAA0F20125_impl*
end;//TmsmButtonEditViewController.DoButtonClick

procedure TmsmButtonEditViewController.DoCaptionChangedEvent(anEvent: TmsmEvent);
//#UC START# *57EAA0F20125_57CD31A200FA_57EAA0F20125_var*
//#UC END# *57EAA0F20125_57CD31A200FA_57EAA0F20125_var*
begin
//#UC START# *57EAA0F20125_57CD31A200FA_57EAA0F20125_impl*
 inherited;
 LinkDataToView;
//#UC END# *57EAA0F20125_57CD31A200FA_57EAA0F20125_impl*
end;//TmsmButtonEditViewController.DoCaptionChangedEvent

procedure TmsmButtonEditViewController.InitOwnView;
//#UC START# *57ADFB33027D_57EAA0F20125_var*
//#UC END# *57ADFB33027D_57EAA0F20125_var*
begin
//#UC START# *57ADFB33027D_57EAA0F20125_impl*
 inherited;
 OwnView.OnButtonClick := Self.DoButtonClick;
 OwnView.OnReturn := Self.DoButtonClick;
 TmsmButtonEditButtonFriend(OwnView.Button).Images := TmsmImages.Instance.GetImagesForOperations;
 TmsmButtonEditButtonFriend(OwnView.Button).ImageIndex := TmsmImages.Instance.GetImageForOperation(12);
//#UC END# *57ADFB33027D_57EAA0F20125_impl*
end;//TmsmButtonEditViewController.InitOwnView

procedure TmsmButtonEditViewController.LinkDataToView;
//#UC START# *57B6A49900F4_57EAA0F20125_var*
//#UC END# *57B6A49900F4_57EAA0F20125_var*
begin
//#UC START# *57B6A49900F4_57EAA0F20125_impl*
 inherited;
 if l3IsNil(Model.Caption) then
  OwnView.TextSource.New
 else
  OwnView.Text := Model.Caption;
//#UC END# *57B6A49900F4_57EAA0F20125_impl*
end;//TmsmButtonEditViewController.LinkDataToView

procedure TmsmButtonEditViewController.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CaptionChangedEvent.Instance, DoCaptionChangedEvent);
end;//TmsmButtonEditViewController.LinkEventHandlers

end.
