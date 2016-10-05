unit msmUseCase;

// Модуль: "w:\common\components\gui\Garant\msm\msmUseCase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmUseCase" MUID: (57AD94F00212)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , ImsmControllerList
 , msmUseCases
 , msmViewRefList
 , msmControllers
 , msmModels
;

type
 TmsmUseCase = class(TImsmControllerList, ImsmUseCase)
  private
   f_OwnedViews: TmsmViewRefList;
  protected
   function AddViewForRelease(aView: TmsmView): TmsmView;
   procedure ReleaseControllers; virtual;
   procedure ReleaseViews; virtual;
   function BindViewToModelAndZone(aView: TmsmView;
    const aModel: ImsmModel;
    const aZone: ImsmViewParent): TmsmView;
   function AddViewParentForRelease(aView: TmsmViewParentControl): TmsmViewParentControl;
   function BindViewParentToModelAndZone(aView: TmsmViewParentControl;
    const aModel: ImsmModel;
    const aZone: ImsmViewParent): TmsmViewParentControl;
   function AddController(const aController: ImsmController): ImsmController;
   function Bind(const aController: ImsmController): ImsmController;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: ImsmUseCase; reintroduce;
 end;//TmsmUseCase

implementation

uses
 l3ImplUses
 , msmParentedViewController
 //#UC START# *57AD94F00212impl_uses*
 , SysUtils
 //#UC END# *57AD94F00212impl_uses*
;

constructor TmsmUseCase.Create;
//#UC START# *57B1AEDB0188_57AD94F00212_var*
//#UC END# *57B1AEDB0188_57AD94F00212_var*
begin
//#UC START# *57B1AEDB0188_57AD94F00212_impl*
 inherited Create;
//#UC END# *57B1AEDB0188_57AD94F00212_impl*
end;//TmsmUseCase.Create

class function TmsmUseCase.Make: ImsmUseCase;
var
 l_Inst : TmsmUseCase;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmUseCase.Make

function TmsmUseCase.AddViewForRelease(aView: TmsmView): TmsmView;
//#UC START# *57EA53180247_57AD94F00212_var*
//#UC END# *57EA53180247_57AD94F00212_var*
begin
//#UC START# *57EA53180247_57AD94F00212_impl*
 Assert(aView.Owner = nil);
 if (f_OwnedViews = nil) then
  f_OwnedViews := TmsmViewRefList.Create;
 f_OwnedViews.Add(aView);
 Result := aView;
 aView.Free; // - чтобы снаружи этого не делать
//#UC END# *57EA53180247_57AD94F00212_impl*
end;//TmsmUseCase.AddViewForRelease

procedure TmsmUseCase.ReleaseControllers;
//#UC START# *57EA53C501FF_57AD94F00212_var*
//#UC END# *57EA53C501FF_57AD94F00212_var*
begin
//#UC START# *57EA53C501FF_57AD94F00212_impl*
 Self.Clear;
//#UC END# *57EA53C501FF_57AD94F00212_impl*
end;//TmsmUseCase.ReleaseControllers

procedure TmsmUseCase.ReleaseViews;
//#UC START# *57EA53D80032_57AD94F00212_var*
//#UC END# *57EA53D80032_57AD94F00212_var*
begin
//#UC START# *57EA53D80032_57AD94F00212_impl*
 FreeAndNil(f_OwnedViews);
//#UC END# *57EA53D80032_57AD94F00212_impl*
end;//TmsmUseCase.ReleaseViews

function TmsmUseCase.BindViewToModelAndZone(aView: TmsmView;
 const aModel: ImsmModel;
 const aZone: ImsmViewParent): TmsmView;
//#UC START# *57EA5DFA0355_57AD94F00212_var*
//#UC END# *57EA5DFA0355_57AD94F00212_var*
begin
//#UC START# *57EA5DFA0355_57AD94F00212_impl*
 Assert(aView.Owner = nil);
 AddController(TmsmParentedViewController.Make(aView, aModel, aZone));
 Result := aView;
//#UC END# *57EA5DFA0355_57AD94F00212_impl*
end;//TmsmUseCase.BindViewToModelAndZone

function TmsmUseCase.AddViewParentForRelease(aView: TmsmViewParentControl): TmsmViewParentControl;
//#UC START# *57EA65280280_57AD94F00212_var*
//#UC END# *57EA65280280_57AD94F00212_var*
begin
//#UC START# *57EA65280280_57AD94F00212_impl*
 AddViewForRelease(aView);
 Result := aView;
//#UC END# *57EA65280280_57AD94F00212_impl*
end;//TmsmUseCase.AddViewParentForRelease

function TmsmUseCase.BindViewParentToModelAndZone(aView: TmsmViewParentControl;
 const aModel: ImsmModel;
 const aZone: ImsmViewParent): TmsmViewParentControl;
//#UC START# *57EA656D0399_57AD94F00212_var*
//#UC END# *57EA656D0399_57AD94F00212_var*
begin
//#UC START# *57EA656D0399_57AD94F00212_impl*
 BindViewToModelAndZone(aView, aModel, aZone);
 Result := aView;
//#UC END# *57EA656D0399_57AD94F00212_impl*
end;//TmsmUseCase.BindViewParentToModelAndZone

function TmsmUseCase.AddController(const aController: ImsmController): ImsmController;
//#UC START# *57AD949C0005_57AD94F00212_var*
//#UC END# *57AD949C0005_57AD94F00212_var*
begin
//#UC START# *57AD949C0005_57AD94F00212_impl*
 Add(aController);
 Result := aController;
//#UC END# *57AD949C0005_57AD94F00212_impl*
end;//TmsmUseCase.AddController

function TmsmUseCase.Bind(const aController: ImsmController): ImsmController;
//#UC START# *57D29826015D_57AD94F00212_var*
//#UC END# *57D29826015D_57AD94F00212_var*
begin
//#UC START# *57D29826015D_57AD94F00212_impl*
 Result := AddController(aController);
//#UC END# *57D29826015D_57AD94F00212_impl*
end;//TmsmUseCase.Bind

procedure TmsmUseCase.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57AD94F00212_var*
//#UC END# *479731C50290_57AD94F00212_var*
begin
//#UC START# *479731C50290_57AD94F00212_impl*
 ReleaseControllers;
 ReleaseViews;
 inherited;
//#UC END# *479731C50290_57AD94F00212_impl*
end;//TmsmUseCase.Cleanup

end.
