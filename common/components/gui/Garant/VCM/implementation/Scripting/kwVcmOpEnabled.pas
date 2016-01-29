unit kwVcmOpEnabled;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmOpEnabled.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_op_Enabled
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
 TkwVcmOpEnabled = {final scriptword} class(TkwOperationParamWord)
 protected
 // realized methods
   function Flag: TvcmOpFlag; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpEnabled
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwVcmOpEnabled

function TkwVcmOpEnabled.Flag: TvcmOpFlag;
//#UC START# *5230151C02BA_523014A301F2_var*
//#UC END# *5230151C02BA_523014A301F2_var*
begin
//#UC START# *5230151C02BA_523014A301F2_impl*
 Result := vcm_ofEnabled;
//#UC END# *5230151C02BA_523014A301F2_impl*
end;//TkwVcmOpEnabled.Flag

class function TkwVcmOpEnabled.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:op:Enabled';
end;//TkwVcmOpEnabled.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_op_Enabled
 TkwVcmOpEnabled.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.