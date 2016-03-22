unit kwVcmOpChecked;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpChecked.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_op_Checked" MUID: (5230153303B8)
// Имя типа: "TkwVcmOpChecked"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwOperationParamWord
 , vcmExternalInterfaces
;

type
 TkwVcmOpChecked = {final} class(TkwOperationParamWord)
  protected
   function Flag: TvcmOpFlag; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpChecked
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

function TkwVcmOpChecked.Flag: TvcmOpFlag;
//#UC START# *5230151C02BA_5230153303B8_var*
//#UC END# *5230151C02BA_5230153303B8_var*
begin
//#UC START# *5230151C02BA_5230153303B8_impl*
 Result := vcm_ofChecked;
//#UC END# *5230151C02BA_5230153303B8_impl*
end;//TkwVcmOpChecked.Flag

class function TkwVcmOpChecked.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:op:Checked';
end;//TkwVcmOpChecked.GetWordNameForRegister

initialization
 TkwVcmOpChecked.RegisterInEngine;
 {* Регистрация vcm_op_Checked }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
