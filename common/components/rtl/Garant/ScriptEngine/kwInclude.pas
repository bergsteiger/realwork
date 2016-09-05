unit kwInclude;
 {* Зарезервированное слово: INCLUDE
Пример:
[code]
 INCLUDE 'Included.script'
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwInclude.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Include" MUID: (4DC1949F00E1)
// Имя типа: "TkwInclude"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwIncludeLike
 , tfwScriptingInterfaces
;

type
 TkwInclude = class(TtfwIncludeLike)
  {* Зарезервированное слово: INCLUDE
Пример:
[code]
 INCLUDE 'Included.script'
[code] }
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   class function GetWordNameForRegister: AnsiString; override;
   function AfterWordMaxCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwInclude
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwIncluded
 , l3String
 //#UC START# *4DC1949F00E1impl_uses*
 //#UC END# *4DC1949F00E1impl_uses*
;

function TkwInclude.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4DC1949F00E1_var*
//#UC END# *4DB6C99F026E_4DC1949F00E1_var*
begin
//#UC START# *4DB6C99F026E_4DC1949F00E1_impl*
 Result := DisabledEndBracket(aContext, aSilent);
//#UC END# *4DB6C99F026E_4DC1949F00E1_impl*
end;//TkwInclude.EndBracket

class function TkwInclude.GetWordNameForRegister: AnsiString;
begin
 Result := 'INCLUDE';
end;//TkwInclude.GetWordNameForRegister

function TkwInclude.AfterWordMaxCount(const aCtx: TtfwContext): Integer;
//#UC START# *4DB9B446039A_4DC1949F00E1_var*
//#UC END# *4DB9B446039A_4DC1949F00E1_var*
begin
//#UC START# *4DB9B446039A_4DC1949F00E1_impl*
 Result := -1;
//#UC END# *4DB9B446039A_4DC1949F00E1_impl*
end;//TkwInclude.AfterWordMaxCount

initialization
 TkwInclude.RegisterInEngine;
 {* Регистрация Include }
{$IfEnd} // NOT Defined(NoScripts)

end.
