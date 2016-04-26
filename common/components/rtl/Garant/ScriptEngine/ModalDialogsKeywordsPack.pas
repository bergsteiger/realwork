unit ModalDialogsKeywordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ModalDialogsKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ModalDialogsKeywordsPack" MUID: (4FFFDEE701EA)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
 , kwWasWait
 , kwWaitNo
 , kwWaitOk
 , kwWaitYes
 , kwWaitCancel
 , kwWaitChoice
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
