unit kwCFHTML;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCFHTML.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFHTML = {final} class(TtfwClipboardFormatWord)
  protected
   function GetFormat: TevFormat; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCFHTML
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwCFHTML.GetFormat: TevFormat;
//#UC START# *54D231000227_4FF436880055_var*
//#UC END# *54D231000227_4FF436880055_var*
begin
//#UC START# *54D231000227_4FF436880055_impl*
 Result := CF_HTML;
//#UC END# *54D231000227_4FF436880055_impl*
end;//TkwCFHTML.GetFormat

class function TkwCFHTML.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF_HTML';
end;//TkwCFHTML.GetWordNameForRegister

initialization
 TkwCFHTML.RegisterInEngine;
 {* Регистрация CF_HTML }
{$IfEnd} // NOT Defined(NoScripts)

end.
