unit kwInnerIncluded;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwInnerIncluded.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwIncluded
 , tfwScriptingInterfaces
;

type
 TkwInnerIncluded = class(TkwIncluded)
  protected
   procedure FillContext(const anOldContext: TtfwContext;
    var theNewContext: TtfwContext); override;
 end;//TkwInnerIncluded
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3ParserInterfaces
;

procedure TkwInnerIncluded.FillContext(const anOldContext: TtfwContext;
 var theNewContext: TtfwContext);
//#UC START# *4F3AA59B025A_4F3AA545006F_var*
var
 l_F : TtfwKeywordFinder;
 l_C : TtfwCompiler;
//#UC END# *4F3AA59B025A_4F3AA545006F_var*
begin
//#UC START# *4F3AA59B025A_4F3AA545006F_impl*
 inherited;
 //l_P.KeyWords := aCtx.rEngine.As_Il3KeywordFinder; {!!! - ����� ����� �������� � ScriptEngine}
 //l_Ctx.rCompiler := nil; {!!! - ����� ����� �������� � ScriptEngine}
 if (anOldContext.rCompiler <> nil) then
 begin
  l_F := anOldContext.rCompiler.KeywordFinder(anOldContext).ParentFinder;
  l_C := l_F;
  theNewContext.rKeyWords := l_F;
  {!!! - ����� ����� �������� ������� � ����������� �����}
  theNewContext.rCompiler := l_C;
  {!!! - ����� ����� �������� �� ���������� �����}
 end;//anOldContext.rCompiler <> nil
//#UC END# *4F3AA59B025A_4F3AA545006F_impl*
end;//TkwInnerIncluded.FillContext

initialization
!!! Lost ini !!!
 {* ����������� TkwInnerIncluded }
{$IfEnd} // NOT Defined(NoScripts)

end.
