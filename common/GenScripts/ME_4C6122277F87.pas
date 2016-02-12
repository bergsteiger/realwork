unit DocumentWithFlashKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы DocumentWithFlash }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\DocumentWithFlashKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 , tfwControlString
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
;

type
 Tkw_Form_DocumentWithFlash = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы DocumentWithFlash
----
*Пример использования*:
[code]
'aControl' форма::DocumentWithFlash TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_DocumentWithFlash

class function Tkw_Form_DocumentWithFlash.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::DocumentWithFlash';
end;//Tkw_Form_DocumentWithFlash.GetWordNameForRegister

function Tkw_Form_DocumentWithFlash.GetString: AnsiString;
begin
 Result := 'DocumentWithFlashForm';
end;//Tkw_Form_DocumentWithFlash.GetString

initialization
 Tkw_Form_DocumentWithFlash.RegisterInEngine;
 {* Регистрация Tkw_Form_DocumentWithFlash }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
