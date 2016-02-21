unit kwCFRTF;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCFRTF.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFRTF = {final} class(TtfwClipboardFormatWord)
  protected
   function GetFormat: TevFormat; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCFRTF
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwCFRTF.GetFormat: TevFormat;
//#UC START# *54D231000227_5291E204016B_var*
//#UC END# *54D231000227_5291E204016B_var*
begin
//#UC START# *54D231000227_5291E204016B_impl*
 Result := CF_RTF;
//#UC END# *54D231000227_5291E204016B_impl*
end;//TkwCFRTF.GetFormat

class function TkwCFRTF.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF_RTF';
end;//TkwCFRTF.GetWordNameForRegister

initialization
 TkwCFRTF.RegisterInEngine;
 {* Регистрация CF_RTF }
{$IfEnd} // NOT Defined(NoScripts)

end.
