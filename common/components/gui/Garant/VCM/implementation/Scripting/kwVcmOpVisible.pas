unit kwVcmOpVisible;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpVisible.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_op_Visible" MUID: (523014D3003C)
// Имя типа: "TkwVcmOpVisible"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwOperationParamWord
 , vcmExternalInterfaces
;

type
 TkwVcmOpVisible = {final} class(TkwOperationParamWord)
  protected
   function Flag: TvcmOpFlag; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpVisible
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 //#UC START# *523014D3003Cimpl_uses*
 //#UC END# *523014D3003Cimpl_uses*
;

function TkwVcmOpVisible.Flag: TvcmOpFlag;
//#UC START# *5230151C02BA_523014D3003C_var*
//#UC END# *5230151C02BA_523014D3003C_var*
begin
//#UC START# *5230151C02BA_523014D3003C_impl*
 Result := vcm_ofVisible;
//#UC END# *5230151C02BA_523014D3003C_impl*
end;//TkwVcmOpVisible.Flag

class function TkwVcmOpVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:op:Visible';
end;//TkwVcmOpVisible.GetWordNameForRegister

initialization
 TkwVcmOpVisible.RegisterInEngine;
 {* Регистрация vcm_op_Visible }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
