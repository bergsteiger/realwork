unit CustomizeToolsKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы CustomizeTools }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\CustomizeToolsKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "CustomizeToolsKeywordsPack" MUID: (4C8E42D40131_Pack)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , CustomizeTools_Form
 , tfwControlString
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4C8E42D40131_Packimpl_uses*
 //#UC END# *4C8E42D40131_Packimpl_uses*
;

type
 Tkw_Form_CustomizeTools = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы CustomizeTools
----
*Пример использования*:
[code]форма::CustomizeTools TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_CustomizeTools

function Tkw_Form_CustomizeTools.GetString: AnsiString;
begin
 Result := 'CustomizeToolsForm';
end;//Tkw_Form_CustomizeTools.GetString

class procedure Tkw_Form_CustomizeTools.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TCustomizeToolsForm);
end;//Tkw_Form_CustomizeTools.RegisterInEngine

class function Tkw_Form_CustomizeTools.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::CustomizeTools';
end;//Tkw_Form_CustomizeTools.GetWordNameForRegister

initialization
 Tkw_Form_CustomizeTools.RegisterInEngine;
 {* Регистрация Tkw_Form_CustomizeTools }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomizeToolsForm));
 {* Регистрация типа TCustomizeToolsForm }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
