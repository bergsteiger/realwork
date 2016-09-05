unit kwScrollInfoWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwScrollInfoWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwScrollInfoWord" MUID: (517939B9033C)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , kwWinControlFromStackWord
 , Windows
 , tfwScriptingInterfaces
 , Controls
;

type
 TkwScrollInfoWord = {abstract} class(TkwWinControlFromStackWord)
  private
   f_ScrollInfo: TScrollInfo;
  protected
   procedure DoScrollInfo(const aCtx: TtfwContext); virtual; abstract;
   procedure DoWinControl(aControl: TWinControl;
    const aCtx: TtfwContext); override;
   procedure ClearFields; override;
  protected
   property ScrollInfo: TScrollInfo
    read f_ScrollInfo;
 end;//TkwScrollInfoWord
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Forms
 //#UC START# *517939B9033Cimpl_uses*
 //#UC END# *517939B9033Cimpl_uses*
;

procedure TkwScrollInfoWord.DoWinControl(aControl: TWinControl;
 const aCtx: TtfwContext);
//#UC START# *4F212C930149_517939B9033C_var*
//#UC END# *4F212C930149_517939B9033C_var*
begin
//#UC START# *4F212C930149_517939B9033C_impl*
 RunnerAssert(aCtx.rEngine.IsTopBool, 'Не указано, для какого скроллбара получаем информацию.', aCtx);

 f_ScrollInfo.cbSize := SizeOf(TScrollInfo);
 f_ScrollInfo.fMask := SIF_ALL;

 if aCtx.rEngine.PopBool
  then GetScrollInfo(aControl.Handle, SB_VERT, f_ScrollInfo)
  else GetScrollInfo(aControl.Handle, SB_HORZ, f_ScrollInfo);

 DoScrollInfo(aCtx);
//#UC END# *4F212C930149_517939B9033C_impl*
end;//TkwScrollInfoWord.DoWinControl

procedure TkwScrollInfoWord.ClearFields;
begin
 Finalize(f_ScrollInfo);
 inherited;
end;//TkwScrollInfoWord.ClearFields

initialization
 TkwScrollInfoWord.RegisterClass;
 {* Регистрация TkwScrollInfoWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
