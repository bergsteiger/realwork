unit kwCFEVEREST;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCFEVEREST.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "CF_EVEREST" MUID: (5052EB1003B3)
// Имя типа: "TkwCFEVEREST"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFEVEREST = {final} class(TtfwClipboardFormatWord)
  protected
   function GetFormat: TevFormat; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCFEVEREST
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwCFEVEREST.GetFormat: TevFormat;
//#UC START# *54D231000227_5052EB1003B3_var*
//#UC END# *54D231000227_5052EB1003B3_var*
begin
//#UC START# *54D231000227_5052EB1003B3_impl*
 Result := CF_EverestTxt;
//#UC END# *54D231000227_5052EB1003B3_impl*
end;//TkwCFEVEREST.GetFormat

class function TkwCFEVEREST.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF_EVEREST';
end;//TkwCFEVEREST.GetWordNameForRegister

initialization
 TkwCFEVEREST.RegisterInEngine;
 {* Регистрация CF_EVEREST }
{$IfEnd} // NOT Defined(NoScripts)

end.
