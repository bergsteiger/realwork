unit kwVcmOpChecked;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmOpChecked.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_op_Checked
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  kwOperationParamWord,
  vcmExternalInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 TkwVcmOpChecked = {final scriptword} class(TkwOperationParamWord)
 protected
 // realized methods
   function Flag: TvcmOpFlag; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpChecked
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwVcmOpChecked

function TkwVcmOpChecked.Flag: TvcmOpFlag;
//#UC START# *5230151C02BA_5230153303B8_var*
//#UC END# *5230151C02BA_5230153303B8_var*
begin
//#UC START# *5230151C02BA_5230153303B8_impl*
 Result := vcm_ofChecked;
//#UC END# *5230151C02BA_5230153303B8_impl*
end;//TkwVcmOpChecked.Flag

class function TkwVcmOpChecked.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:op:Checked';
end;//TkwVcmOpChecked.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_op_Checked
 TkwVcmOpChecked.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.