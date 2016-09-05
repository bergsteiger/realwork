unit tfwBeginLikeWord;
 {* ��������� ����-������. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwBeginLikeWord.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwBeginLikeWord" MUID: (4DBAEF29031F)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwAnonimousWord
 , kwCompiledWordPrim
 , tfwScriptingInterfaces
;

type
 TtfwBeginLikeWord = {abstract} class(TtfwAnonimousWord)
  {* ��������� ����-������. }
  protected
   procedure AfterCompile(var theNewContext: TtfwContext;
    aCompiled: TkwCompiledWordPrim); override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
 end;//TtfwBeginLikeWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwBeginLikeCompiledCode
 //#UC START# *4DBAEF29031Fimpl_uses*
 //#UC END# *4DBAEF29031Fimpl_uses*
;

procedure TtfwBeginLikeWord.AfterCompile(var theNewContext: TtfwContext;
 aCompiled: TkwCompiledWordPrim);
//#UC START# *4DB6CE2302C9_4DBAEF29031F_var*
//#UC END# *4DB6CE2302C9_4DBAEF29031F_var*
begin
//#UC START# *4DB6CE2302C9_4DBAEF29031F_impl*
 DoCompiledWord(aCompiled, theNewContext.rPrev^);
 inherited;
//#UC END# *4DB6CE2302C9_4DBAEF29031F_impl*
end;//TtfwBeginLikeWord.AfterCompile

function TtfwBeginLikeWord.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4DBAEF29031F_var*
//#UC END# *4DBAEE0D028D_4DBAEF29031F_var*
begin
//#UC START# *4DBAEE0D028D_4DBAEF29031F_impl*
 Result := TkwBeginLikeCompiledCode;
//#UC END# *4DBAEE0D028D_4DBAEF29031F_impl*
end;//TtfwBeginLikeWord.CompiledWordClass

initialization
 TtfwBeginLikeWord.RegisterClass;
 {* ����������� TtfwBeginLikeWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
