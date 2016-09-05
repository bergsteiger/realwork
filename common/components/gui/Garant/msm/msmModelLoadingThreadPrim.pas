unit msmModelLoadingThreadPrim;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelLoadingThreadPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelLoadingThreadPrim" MUID: (57C686D301A8)

{$Include w:\common\components\msm.inc}

interface

{$If Defined(seThreadSafe)}
uses
 l3IntfUses
 , l3Base
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TmsmModelLoadingThreadPrim = {abstract} class(Tl3ThreadContainer)
  private
   f_WordToLoad: TtfwWord;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Terminate; virtual;
   constructor Create(aWordToLoad: TtfwWord); reintroduce;
  public
   property WordToLoad: TtfwWord
    read f_WordToLoad;
 end;//TmsmModelLoadingThreadPrim
{$IfEnd} // Defined(seThreadSafe)

implementation

{$If Defined(seThreadSafe)}
uses
 l3ImplUses
 //#UC START# *57C686D301A8impl_uses*
 , SysUtils
 //#UC END# *57C686D301A8impl_uses*
;

procedure TmsmModelLoadingThreadPrim.Terminate;
//#UC START# *57C43912010E_57C686D301A8_var*
//#UC END# *57C43912010E_57C686D301A8_var*
begin
//#UC START# *57C43912010E_57C686D301A8_impl*
 inherited Terminate;
//#UC END# *57C43912010E_57C686D301A8_impl*
end;//TmsmModelLoadingThreadPrim.Terminate

constructor TmsmModelLoadingThreadPrim.Create(aWordToLoad: TtfwWord);
//#UC START# *57C3E9EC02E0_57C686D301A8_var*
//#UC END# *57C3E9EC02E0_57C686D301A8_var*
begin
//#UC START# *57C3E9EC02E0_57C686D301A8_impl*
 aWordToLoad.SetRefTo(f_WordToLoad);
 inherited Create;
//#UC END# *57C3E9EC02E0_57C686D301A8_impl*
end;//TmsmModelLoadingThreadPrim.Create

procedure TmsmModelLoadingThreadPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57C686D301A8_var*
//#UC END# *479731C50290_57C686D301A8_var*
begin
//#UC START# *479731C50290_57C686D301A8_impl*
 FreeAndNil(f_WordToLoad);
 inherited;
//#UC END# *479731C50290_57C686D301A8_impl*
end;//TmsmModelLoadingThreadPrim.Cleanup
{$IfEnd} // Defined(seThreadSafe)

end.
