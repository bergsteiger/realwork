unit LogoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Logo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\LogoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Logo_Form
 , tfwControlString
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , TtfwClassRef_Proxy
;

type
 Tkw_Form_Logo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Logo
----
*Пример использования*:
[code]
'aControl' форма::Logo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Form_Logo

class function Tkw_Form_Logo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Logo';
end;//Tkw_Form_Logo.GetWordNameForRegister

function Tkw_Form_Logo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6D62B6080174_var*
//#UC END# *4DDFD2EA0116_6D62B6080174_var*
begin
//#UC START# *4DDFD2EA0116_6D62B6080174_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6D62B6080174_impl*
end;//Tkw_Form_Logo.GetString

class procedure Tkw_Form_Logo.RegisterInEngine;
//#UC START# *52A086150180_6D62B6080174_var*
//#UC END# *52A086150180_6D62B6080174_var*
begin
//#UC START# *52A086150180_6D62B6080174_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6D62B6080174_impl*
end;//Tkw_Form_Logo.RegisterInEngine

initialization
 Tkw_Form_Logo.RegisterInEngine;
 {* Регистрация Tkw_Form_Logo }
{$IfEnd} // NOT Defined(NoScripts)

end.
