unit DocumentWithFlashKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы DocumentWithFlash }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocumentWithFlashKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "DocumentWithFlashKeywordsPack" MUID: (4989E67D00C0_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , DocumentWithFlash_Form
 , tfwControlString
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_DocumentWithFlash = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы DocumentWithFlash
----
*Пример использования*:
[code]форма::DocumentWithFlash TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_DocumentWithFlash

function Tkw_Form_DocumentWithFlash.GetString: AnsiString;
begin
 Result := 'DocumentWithFlashForm';
end;//Tkw_Form_DocumentWithFlash.GetString

class procedure Tkw_Form_DocumentWithFlash.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TDocumentWithFlashForm);
end;//Tkw_Form_DocumentWithFlash.RegisterInEngine

class function Tkw_Form_DocumentWithFlash.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::DocumentWithFlash';
end;//Tkw_Form_DocumentWithFlash.GetWordNameForRegister

initialization
 Tkw_Form_DocumentWithFlash.RegisterInEngine;
 {* Регистрация Tkw_Form_DocumentWithFlash }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDocumentWithFlashForm));
 {* Регистрация типа TDocumentWithFlashForm }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
