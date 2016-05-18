unit LogoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Logo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LogoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "LogoKeywordsPack" MUID: (4AA7E32D0252_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Logo_Form
 , tfwControlString
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_Logo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Logo
----
*Пример использования*:
[code]форма::Logo TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Logo

function Tkw_Form_Logo.GetString: AnsiString;
begin
 Result := 'LogoForm';
end;//Tkw_Form_Logo.GetString

class procedure Tkw_Form_Logo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TLogoForm);
end;//Tkw_Form_Logo.RegisterInEngine

class function Tkw_Form_Logo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Logo';
end;//Tkw_Form_Logo.GetWordNameForRegister

initialization
 Tkw_Form_Logo.RegisterInEngine;
 {* Регистрация Tkw_Form_Logo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLogoForm));
 {* Регистрация типа TLogoForm }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
