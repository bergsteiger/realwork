unit kwPopControlScrollInfoMin;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMin.pas"
// ���������: "ScriptKeyword"
// ������� ������: "pop_control_ScrollInfo_Min" MUID: (51793B050115)
// ��� ����: "TkwPopControlScrollInfoMin"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , kwScrollInfoWord
 , tfwScriptingInterfaces
;

type
 TkwPopControlScrollInfoMin = {final} class(TkwScrollInfoWord)
  protected
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfoMin
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Windows
 , Controls
 , Forms
 //#UC START# *51793B050115impl_uses*
 //#UC END# *51793B050115impl_uses*
;

procedure TkwPopControlScrollInfoMin.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793B050115_var*
//#UC END# *51793A950073_51793B050115_var*
begin
//#UC START# *51793A950073_51793B050115_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nMin);
//#UC END# *51793A950073_51793B050115_impl*
end;//TkwPopControlScrollInfoMin.DoScrollInfo

class function TkwPopControlScrollInfoMin.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:control:ScrollInfo:Min';
end;//TkwPopControlScrollInfoMin.GetWordNameForRegister

initialization
 TkwPopControlScrollInfoMin.RegisterInEngine;
 {* ����������� pop_control_ScrollInfo_Min }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
