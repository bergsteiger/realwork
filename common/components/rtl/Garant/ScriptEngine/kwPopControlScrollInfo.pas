unit kwPopControlScrollInfo;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfo.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_control_ScrollInfo" MUID: (51793AE70134)
// Имя типа: "TkwPopControlScrollInfo"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , kwScrollInfoWord
 , tfwScriptingInterfaces
;

type
 TkwPopControlScrollInfo = {final} class(TkwScrollInfoWord)
  protected
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfo
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Windows
 , Controls
 , Forms
;

procedure TkwPopControlScrollInfo.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793AE70134_var*
//#UC END# *51793A950073_51793AE70134_var*
begin
//#UC START# *51793A950073_51793AE70134_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nPos);
 aCtx.rEngine.PushInt(ScrollInfo.nPage);
 aCtx.rEngine.PushInt(ScrollInfo.nMin);
 aCtx.rEngine.PushInt(ScrollInfo.nMax);
//#UC END# *51793A950073_51793AE70134_impl*
end;//TkwPopControlScrollInfo.DoScrollInfo

class function TkwPopControlScrollInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:control:ScrollInfo';
end;//TkwPopControlScrollInfo.GetWordNameForRegister

initialization
 TkwPopControlScrollInfo.RegisterInEngine;
 {* Регистрация pop_control_ScrollInfo }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
