unit msmViewController;

// Модуль: "w:\common\components\gui\Garant\msm\msmViewController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmViewController" MUID: (57AB0A810292)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmController
 , msmControllers
;

type
 TmsmViewController = class(TmsmController, ImsmViewController)
  private
   f_View: TmsmView;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   constructor Create(aView: TmsmView;
    const aModel: ImsmModel); reintroduce;
   class function Make(aView: TmsmView;
    const aModel: ImsmModel): ImsmViewController; reintroduce;
  protected
   property View: TmsmView
    read f_View;
 end;//TmsmViewController

implementation

uses
 l3ImplUses
 //#UC START# *57AB0A810292impl_uses*
 , SysUtils
 //#UC END# *57AB0A810292impl_uses*
;

constructor TmsmViewController.Create(aView: TmsmView;
 const aModel: ImsmModel);
//#UC START# *57AB0AD803AD_57AB0A810292_var*
//#UC END# *57AB0AD803AD_57AB0A810292_var*
begin
//#UC START# *57AB0AD803AD_57AB0A810292_impl*
 Assert(aView <> nil);
 Assert(aModel <> nil);
 inherited Create(aModel);
 f_View := aView;
//#UC END# *57AB0AD803AD_57AB0A810292_impl*
end;//TmsmViewController.Create

class function TmsmViewController.Make(aView: TmsmView;
 const aModel: ImsmModel): ImsmViewController;
var
 l_Inst : TmsmViewController;
begin
 l_Inst := Create(aView, aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmViewController.Make

procedure TmsmViewController.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57AB0A810292_var*
//#UC END# *479731C50290_57AB0A810292_var*
begin
//#UC START# *479731C50290_57AB0A810292_impl*
 inherited;
 f_View := nil;
//#UC END# *479731C50290_57AB0A810292_impl*
end;//TmsmViewController.Cleanup

procedure TmsmViewController.InitFields;
//#UC START# *47A042E100E2_57AB0A810292_var*
//#UC END# *47A042E100E2_57AB0A810292_var*
begin
//#UC START# *47A042E100E2_57AB0A810292_impl*
 inherited;
//#UC END# *47A042E100E2_57AB0A810292_impl*
end;//TmsmViewController.InitFields

end.
