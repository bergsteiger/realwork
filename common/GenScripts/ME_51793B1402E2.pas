unit kwPopControlScrollInfoPageSize;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPageSize.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , kwScrollInfoWord
 , tfwScriptingInterfaces
;

type
 TkwPopControlScrollInfoPageSize = {final} class(TkwScrollInfoWord)
  protected
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfoPageSize
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
;

procedure TkwPopControlScrollInfoPageSize.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793B1402E2_var*
//#UC END# *51793A950073_51793B1402E2_var*
begin
//#UC START# *51793A950073_51793B1402E2_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nPage);
//#UC END# *51793A950073_51793B1402E2_impl*
end;//TkwPopControlScrollInfoPageSize.DoScrollInfo

class function TkwPopControlScrollInfoPageSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:control:ScrollInfo:PageSize';
end;//TkwPopControlScrollInfoPageSize.GetWordNameForRegister

initialization
 TkwPopControlScrollInfoPageSize.RegisterInEngine;
 {* Регистрация pop_control_ScrollInfo_PageSize }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
