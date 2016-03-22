unit kwVcmOpDefault;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpDefault.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_op_Default" MUID: (5230156001B9)
// Имя типа: "TkwVcmOpDefault"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwOperationParamWord
 , vcmExternalInterfaces
;

type
 TkwVcmOpDefault = {final} class(TkwOperationParamWord)
  protected
   function Flag: TvcmOpFlag; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpDefault
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

function TkwVcmOpDefault.Flag: TvcmOpFlag;
//#UC START# *5230151C02BA_5230156001B9_var*
//#UC END# *5230151C02BA_5230156001B9_var*
begin
//#UC START# *5230151C02BA_5230156001B9_impl*
 Result := vcm_ofDefault;
//#UC END# *5230151C02BA_5230156001B9_impl*
end;//TkwVcmOpDefault.Flag

class function TkwVcmOpDefault.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:op:Default';
end;//TkwVcmOpDefault.GetWordNameForRegister

initialization
 TkwVcmOpDefault.RegisterInEngine;
 {* Регистрация vcm_op_Default }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
