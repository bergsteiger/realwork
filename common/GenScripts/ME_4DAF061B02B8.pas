unit F1ScriptEngine;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ScriptEngine\F1ScriptEngine.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptEngineEX
;

type
 _F1WordsUser_Parent_ = TtfwScriptEngineEX;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1WordsUser.imp.pas}
 TF1ScriptEngine = class(_F1WordsUser_)
 end;//TF1ScriptEngine
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwAttributeSearch
 , kwMainMenu
 , kwOk
 , kwOpenDocument
 , F1ShellWordsPack
 , TreeViewWordsPack
 , Integration
 , InterfacedNodeWordsPack
 , f1WordsPack
 , kwPopEditorDeleteUserComment
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1WordsUser.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
