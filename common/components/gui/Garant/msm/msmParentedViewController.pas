unit msmParentedViewController;

// Модуль: "w:\common\components\gui\Garant\msm\msmParentedViewController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmParentedViewController" MUID: (57ADB523009E)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmViewController
 , msmControllers
;

type
 TmsmParentedViewController = class(TmsmViewController)
  private
   f_Parent: ImsmViewParent;
  protected
   function pm_GetViewContext: TmsmViewContext;
   procedure InitViewContext(var theContext: TmsmViewContext); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoActivate; override;
   procedure ClearFields; override;
  public
   constructor Create(aView: TmsmView;
    const aModel: ImsmModel;
    const aParent: ImsmViewParent); reintroduce;
   class function Make(aView: TmsmView;
    const aModel: ImsmModel;
    const aParent: ImsmViewParent): ImsmViewController; reintroduce;
  public
   property ViewContext: TmsmViewContext
    read pm_GetViewContext;
 end;//TmsmParentedViewController

implementation

uses
 l3ImplUses
 //#UC START# *57ADB523009Eimpl_uses*
 , Controls
 //#UC END# *57ADB523009Eimpl_uses*
;

function TmsmParentedViewController.pm_GetViewContext: TmsmViewContext;
//#UC START# *57B4909B0293_57ADB523009Eget_var*
//#UC END# *57B4909B0293_57ADB523009Eget_var*
begin
//#UC START# *57B4909B0293_57ADB523009Eget_impl*
 Result := TmsmViewContext_C;
 InitViewContext(Result);
//#UC END# *57B4909B0293_57ADB523009Eget_impl*
end;//TmsmParentedViewController.pm_GetViewContext

constructor TmsmParentedViewController.Create(aView: TmsmView;
 const aModel: ImsmModel;
 const aParent: ImsmViewParent);
//#UC START# *57ADB54D017E_57ADB523009E_var*
//#UC END# *57ADB54D017E_57ADB523009E_var*
begin
//#UC START# *57ADB54D017E_57ADB523009E_impl*
 Assert(aView <> nil);
 Assert(aParent <> nil);
 f_Parent := aParent;
 inherited Create(aView, aModel);
//#UC END# *57ADB54D017E_57ADB523009E_impl*
end;//TmsmParentedViewController.Create

class function TmsmParentedViewController.Make(aView: TmsmView;
 const aModel: ImsmModel;
 const aParent: ImsmViewParent): ImsmViewController;
var
 l_Inst : TmsmParentedViewController;
begin
 l_Inst := Create(aView, aModel, aParent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmParentedViewController.Make

procedure TmsmParentedViewController.InitViewContext(var theContext: TmsmViewContext);
//#UC START# *57B490B60385_57ADB523009E_var*
//#UC END# *57B490B60385_57ADB523009E_var*
begin
//#UC START# *57B490B60385_57ADB523009E_impl*
//#UC END# *57B490B60385_57ADB523009E_impl*
end;//TmsmParentedViewController.InitViewContext

procedure TmsmParentedViewController.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57ADB523009E_var*
//#UC END# *479731C50290_57ADB523009E_var*
begin
//#UC START# *479731C50290_57ADB523009E_impl*
 Assert(View <> nil);
 Assert(f_Parent <> nil);
 f_Parent.RemoveView(View);
 f_Parent := nil;
 inherited;
//#UC END# *479731C50290_57ADB523009E_impl*
end;//TmsmParentedViewController.Cleanup

procedure TmsmParentedViewController.DoActivate;
//#UC START# *57B1ABC80368_57ADB523009E_var*
//#UC END# *57B1ABC80368_57ADB523009E_var*
begin
//#UC START# *57B1ABC80368_57ADB523009E_impl*
 inherited;
 Assert(f_Parent <> nil);
 f_Parent.InsertView(View, Self.ViewContext);
//#UC END# *57B1ABC80368_57ADB523009E_impl*
end;//TmsmParentedViewController.DoActivate

procedure TmsmParentedViewController.ClearFields;
begin
 f_Parent := nil;
 inherited;
end;//TmsmParentedViewController.ClearFields

end.
