unit kwPopControlScrollInfoMax;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMax.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , kwScrollInfoWord
 , tfwScriptingInterfaces
;

type
 TkwPopControlScrollInfoMax = {final} class(TkwScrollInfoWord)
  protected
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfoMax
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Windows
 , Controls
 , Forms
;

procedure TkwPopControlScrollInfoMax.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793B0D02BB_var*
//#UC END# *51793A950073_51793B0D02BB_var*
begin
//#UC START# *51793A950073_51793B0D02BB_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nMax);
//#UC END# *51793A950073_51793B0D02BB_impl*
end;//TkwPopControlScrollInfoMax.DoScrollInfo

class function TkwPopControlScrollInfoMax.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:control:ScrollInfo:Max';
end;//TkwPopControlScrollInfoMax.GetWordNameForRegister

initialization
 TkwPopControlScrollInfoMax.RegisterInEngine;
 {* Регистрация pop_control_ScrollInfo_Max }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
