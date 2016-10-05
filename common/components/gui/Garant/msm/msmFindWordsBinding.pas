unit msmFindWordsBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmFindWordsBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmFindWordsBinding" MUID: (57EA9BC1025E)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmCaptionToListBinding
 , msmEvents
;

type
 TmsmFindWordsBinding = class(TmsmCaptionToListBinding)
  protected
   procedure DoCaptionChangedEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmFindWordsBinding

implementation

uses
 l3ImplUses
 , msmControllers
 , msmWordsManaging
 , msmModelElement
 , msmSomeModelElementsList
 //#UC START# *57EA9BC1025Eimpl_uses*
 //#UC END# *57EA9BC1025Eimpl_uses*
;

procedure TmsmFindWordsBinding.DoCaptionChangedEvent(anEvent: TmsmEvent);
//#UC START# *57EA9BC1025E_57CD31A200FA_57EA9BC1025E_var*
//#UC END# *57EA9BC1025E_57CD31A200FA_57EA9BC1025E_var*
begin
//#UC START# *57EA9BC1025E_57CD31A200FA_57EA9BC1025E_impl*
 inherited;
 ModelToFire.SetList(TmsmSomeModelElementsList.Make(TmsmWordsManaging.FindWords(ModelToListen.Caption)));
//#UC END# *57EA9BC1025E_57CD31A200FA_57EA9BC1025E_impl*
end;//TmsmFindWordsBinding.DoCaptionChangedEvent

procedure TmsmFindWordsBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CaptionChangedEvent.Instance, DoCaptionChangedEvent);
end;//TmsmFindWordsBinding.LinkEventHandlers

end.
