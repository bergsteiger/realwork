unit VCMWordsPack;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "VCMWordsPack" MUID: (4F69B966010B)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , kwVcmDispatcherLock
 , kwVcmDispatcherUnlock
 , kwVcmDispatcherBeginOp
 , kwVcmDispatcherEndOp
 , kwVcmHistoryGetBackCount
 , kwVcmHistoryGetBackItem
 , kwVcmHistoryGetForwardCount
 , kwVcmHistoryGetForwardItem
 , kwVcmOpEnabled
 , kwVcmOpVisible
 , kwVcmOpChecked
 , kwVcmOpDefault
 , kwVcmOpCaption
 , kwVcmOpHint
 , kwVcmOpImageIndex
 , kwVcmOpShortcut
 , kwVcmOpLongHint
 , RegisterVcmControls
 , kwVcmHistoryDeleteBackItem
 , kwVcmFindForm
 , kwVcmHistoryClear
 , kwVcmHistoryDeleteForwardItem
 , kwTryFocusOnForm
 , kwObjectCreate
 , kwVcmDispatcherLockInOp
 , kwVcmDispatcherUnlockInOp
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
