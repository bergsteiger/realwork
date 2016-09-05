unit kwVcmOpEnabled;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpEnabled.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_op_Enabled" MUID: (523014A301F2)
// Имя типа: "TkwVcmOpEnabled"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwOperationParamWord
 , vcmExternalInterfaces
;

type
 TkwVcmOpEnabled = {final} class(TkwOperationParamWord)
  protected
   function Flag: TvcmOpFlag; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpEnabled
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 //#UC START# *523014A301F2impl_uses*
 //#UC END# *523014A301F2impl_uses*
;

function TkwVcmOpEnabled.Flag: TvcmOpFlag;
//#UC START# *5230151C02BA_523014A301F2_var*
//#UC END# *5230151C02BA_523014A301F2_var*
begin
//#UC START# *5230151C02BA_523014A301F2_impl*
 Result := vcm_ofEnabled;
//#UC END# *5230151C02BA_523014A301F2_impl*
end;//TkwVcmOpEnabled.Flag

class function TkwVcmOpEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:op:Enabled';
end;//TkwVcmOpEnabled.GetWordNameForRegister

initialization
 TkwVcmOpEnabled.RegisterInEngine;
 {* Регистрация vcm_op_Enabled }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
