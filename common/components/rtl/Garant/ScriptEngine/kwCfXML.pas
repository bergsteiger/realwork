unit kwCFXML;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCFXML.pas"
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
 TkwCFXML = {final} class(TtfwClipboardFormatWord)
  protected
   function GetFormat: TevFormat; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCFXML
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwCFXML.GetFormat: TevFormat;
//#UC START# *54D231000227_4FF436960135_var*
//#UC END# *54D231000227_4FF436960135_var*
begin
//#UC START# *54D231000227_4FF436960135_impl*
 Result := CF_XML;
//#UC END# *54D231000227_4FF436960135_impl*
end;//TkwCFXML.GetFormat

class function TkwCFXML.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF_XML';
end;//TkwCFXML.GetWordNameForRegister

initialization
 TkwCFXML.RegisterInEngine;
 {* Регистрация CF_XML }
{$IfEnd} // NOT Defined(NoScripts)

end.
