unit msmFindWordBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmFindWordBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmFindWordBinding" MUID: (57EA877F01EB)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmCaptionToListLikeBinding
 , msmEvents
;

type
 TmsmFindWordBinding = class(TmsmCaptionToListLikeBinding)
  protected
   procedure DoCaptionChangedEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmFindWordBinding

implementation

uses
 l3ImplUses
 , msmControllers
 , msmWordsManaging
 , msmModelElement
 //#UC START# *57EA877F01EBimpl_uses*
 //#UC END# *57EA877F01EBimpl_uses*
;

procedure TmsmFindWordBinding.DoCaptionChangedEvent(anEvent: TmsmEvent);
//#UC START# *57EA877F01EB_57CD31A200FA_57EA877F01EB_var*
//#UC END# *57EA877F01EB_57CD31A200FA_57EA877F01EB_var*
begin
//#UC START# *57EA877F01EB_57CD31A200FA_57EA877F01EB_impl*
 inherited;
 ModelToFire.CurrentElement := TmsmModelElement.MakeFromWord(TmsmWordsManaging.FindWord(ModelToListen.Caption));
//#UC END# *57EA877F01EB_57CD31A200FA_57EA877F01EB_impl*
end;//TmsmFindWordBinding.DoCaptionChangedEvent

procedure TmsmFindWordBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CaptionChangedEvent.Instance, DoCaptionChangedEvent);
end;//TmsmFindWordBinding.LinkEventHandlers

end.
