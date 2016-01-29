unit VCMWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Scripting"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Scripting/VCMWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi::VCM$Scripting::VCMWords::VCMWordsPack
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  kwVcmDispatcherLock,
  kwVcmDispatcherUnlock,
  kwVcmDispatcherBeginOp,
  kwVcmDispatcherEndOp,
  kwVcmHistoryGetBackCount,
  kwVcmHistoryGetBackItem,
  kwVcmHistoryGetForwardCount,
  kwVcmHistoryGetForwardItem,
  kwVcmOpEnabled,
  kwVcmOpVisible,
  kwVcmOpChecked,
  kwVcmOpDefault,
  kwVcmOpCaption,
  kwVcmOpHint,
  kwVcmOpImageIndex,
  kwVcmOpShortcut,
  kwVcmOpLongHint,
  RegisterVcmControls,
  kwVcmHistoryDeleteBackItem,
  kwVcmFindForm,
  kwVcmHistoryClear,
  kwVcmHistoryDeleteForwardItem,
  kwTryFocusOnForm,
  kwObjectCreate,
  kwVcmDispatcherLockInOp,
  kwVcmDispatcherUnlockInOp,
  tfwScriptingTypes
  ;

{$IfEnd} //not NoScripts AND not NoVCM
end.