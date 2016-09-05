unit msmSingleViewParent;

// Модуль: "w:\common\components\gui\Garant\msm\msmSingleViewParent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSingleViewParent" MUID: (57B435880088)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmControllers
;

type
 TmsmSingleViewParent = class(Tl3ProtoObject, ImsmViewParent)
  private
   f_View: TmsmView;
   f_Parent: TmsmViewParentControl;
  protected
   procedure InsertView(aView: TmsmView;
    const aContext: TmsmViewContext);
   procedure RemoveView(aView: TmsmView);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aParent: TmsmViewParentControl); reintroduce;
   class function Make(aParent: TmsmViewParentControl): ImsmViewParent; reintroduce;
 end;//TmsmSingleViewParent

implementation

uses
 l3ImplUses
 //#UC START# *57B435880088impl_uses*
 , Controls
 //#UC END# *57B435880088impl_uses*
;

constructor TmsmSingleViewParent.Create(aParent: TmsmViewParentControl);
//#UC START# *57B436360189_57B435880088_var*
//#UC END# *57B436360189_57B435880088_var*
begin
//#UC START# *57B436360189_57B435880088_impl*
 Assert(aParent <> nil);
 f_Parent := aParent;
 f_View := nil;
 inherited Create;
//#UC END# *57B436360189_57B435880088_impl*
end;//TmsmSingleViewParent.Create

class function TmsmSingleViewParent.Make(aParent: TmsmViewParentControl): ImsmViewParent;
var
 l_Inst : TmsmSingleViewParent;
begin
 l_Inst := Create(aParent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmSingleViewParent.Make

procedure TmsmSingleViewParent.InsertView(aView: TmsmView;
 const aContext: TmsmViewContext);
//#UC START# *57B345EC0195_57B435880088_var*
//#UC END# *57B345EC0195_57B435880088_var*
begin
//#UC START# *57B345EC0195_57B435880088_impl*
 Assert(f_View = nil);
 Assert(aView.Parent = nil);
 aView.Parent := f_Parent;
 aView.Align := alClient;
 f_View := aView;
//#UC END# *57B345EC0195_57B435880088_impl*
end;//TmsmSingleViewParent.InsertView

procedure TmsmSingleViewParent.RemoveView(aView: TmsmView);
//#UC START# *57B3461C0319_57B435880088_var*
//#UC END# *57B3461C0319_57B435880088_var*
begin
//#UC START# *57B3461C0319_57B435880088_impl*
 Assert(f_View = aView);
 Assert(aView.Parent = f_Parent);
 aView.Parent := nil;
 f_View := nil;
//#UC END# *57B3461C0319_57B435880088_impl*
end;//TmsmSingleViewParent.RemoveView

procedure TmsmSingleViewParent.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B435880088_var*
//#UC END# *479731C50290_57B435880088_var*
begin
//#UC START# *479731C50290_57B435880088_impl*
 Assert(f_View = nil);
 f_View := nil;
 f_Parent := nil;
 inherited;
//#UC END# *479731C50290_57B435880088_impl*
end;//TmsmSingleViewParent.Cleanup

end.
