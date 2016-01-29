unit kwVcmOpDefault;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmOpDefault.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_op_Default
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
 TkwVcmOpDefault = {final scriptword} class(TkwOperationParamWord)
 protected
 // realized methods
   function Flag: TvcmOpFlag; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpDefault
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwVcmOpDefault

function TkwVcmOpDefault.Flag: TvcmOpFlag;
//#UC START# *5230151C02BA_5230156001B9_var*
//#UC END# *5230151C02BA_5230156001B9_var*
begin
//#UC START# *5230151C02BA_5230156001B9_impl*
 Result := vcm_ofDefault;
//#UC END# *5230151C02BA_5230156001B9_impl*
end;//TkwVcmOpDefault.Flag

class function TkwVcmOpDefault.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:op:Default';
end;//TkwVcmOpDefault.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_op_Default
 TkwVcmOpDefault.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.