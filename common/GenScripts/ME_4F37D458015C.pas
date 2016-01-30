unit kwUsesLike;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwUsesLike.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwIncludeLike
 , tfwScriptingInterfaces
;

type
 TkwUsesLike = {abstract} class(TtfwIncludeLike)
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   procedure UnknownWord(var aContext: TtfwContext;
    aWordNumber: Integer); override;
 end;//TkwUsesLike
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwStandardProcedureCloseBracket
 , l3String
;

function TkwUsesLike.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4F37D458015C_var*
//#UC END# *4DB6C99F026E_4F37D458015C_var*
begin
//#UC START# *4DB6C99F026E_4F37D458015C_impl*
 Result := TkwStandardProcedureCloseBracket;
//#UC END# *4DB6C99F026E_4F37D458015C_impl*
end;//TkwUsesLike.EndBracket

procedure TkwUsesLike.UnknownWord(var aContext: TtfwContext;
 aWordNumber: Integer);
//#UC START# *4DB6F2760023_4F37D458015C_var*
//#UC END# *4DB6F2760023_4F37D458015C_var*
begin
//#UC START# *4DB6F2760023_4F37D458015C_impl*
 DoIncluded(aContext, l3Str(aContext.rParser.TokenLongString));
//#UC END# *4DB6F2760023_4F37D458015C_impl*
end;//TkwUsesLike.UnknownWord

initialization
 TkwUsesLike.RegisterClass;
 {* Регистрация TkwUsesLike }
{$IfEnd} // NOT Defined(NoScripts)

end.
