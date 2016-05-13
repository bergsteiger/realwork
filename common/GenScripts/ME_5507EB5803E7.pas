unit l3AFWExceptions;

// Модуль: "w:\common\components\rtl\Garant\L3\l3AFWExceptions.pas"
// Стереотип: "Interfaces"
// Элемент модели: "l3AFWExceptions" MUID: (5507EB5803E7)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , SysUtils
;

type
 El3TryEnterModalState = class(Exception)
 end;//El3TryEnterModalState

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3TryEnterModalState));
 {* Регистрация типа El3TryEnterModalState }
{$IfEnd} // NOT Defined(NoScripts)

end.
