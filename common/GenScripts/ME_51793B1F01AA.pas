unit kwPopControlScrollInfoPosition;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPosition.pas"
// ���������: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , kwScrollInfoWord
 , tfwScriptingInterfaces
;

type
 TkwPopControlScrollInfoPosition = {final} class(TkwScrollInfoWord)
  protected
   procedure DoScrollInfo(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopControlScrollInfoPosition
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
;

procedure TkwPopControlScrollInfoPosition.DoScrollInfo(const aCtx: TtfwContext);
//#UC START# *51793A950073_51793B1F01AA_var*
//#UC END# *51793A950073_51793B1F01AA_var*
begin
//#UC START# *51793A950073_51793B1F01AA_impl*
 aCtx.rEngine.PushInt(ScrollInfo.nPos);
//#UC END# *51793A950073_51793B1F01AA_impl*
end;//TkwPopControlScrollInfoPosition.DoScrollInfo

class function TkwPopControlScrollInfoPosition.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:control:ScrollInfo:Position';
end;//TkwPopControlScrollInfoPosition.GetWordNameForRegister

initialization
 TkwPopControlScrollInfoPosition.RegisterInEngine;
 {* ����������� pop_control_ScrollInfo_Position }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
