unit kwBEGIN;
 {* Поддержка скобок BEGIN END в стиле Паскаля. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwBEGIN.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwBeginLikeWord
 , tfwScriptingInterfaces
;

type
 TkwBEGIN = class(TtfwBeginLikeWord)
  {* Поддержка скобок BEGIN END в стиле Паскаля. }
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwBEGIN
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwEND
;

function TkwBEGIN.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4DB9BB8D0388_var*
//#UC END# *4DB6C99F026E_4DB9BB8D0388_var*
begin
//#UC START# *4DB6C99F026E_4DB9BB8D0388_impl*
 Result := TkwEND;
//#UC END# *4DB6C99F026E_4DB9BB8D0388_impl*
end;//TkwBEGIN.EndBracket

class function TkwBEGIN.GetWordNameForRegister: AnsiString;
begin
 Result := 'BEGIN';
end;//TkwBEGIN.GetWordNameForRegister

initialization
 TkwBEGIN.RegisterInEngine;
 {* Регистрация BEGIN }
{$IfEnd} // NOT Defined(NoScripts)

end.
