unit LongProcess_ut_LongProcess_UserType;
 {* Информация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LongProcess_ut_LongProcess_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы ut_LongProcess }
 ut_LongProcessName = 'ut_LongProcess';
  {* Строковый идентификатор пользовательского типа "Информация" }
 ut_LongProcess = TvcmUserType(0);
  {* Информация }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_LongProcess = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_LongProcess }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_LongProcess
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_LongProcess';
end;//Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_LongProcess.GetInteger: Integer;
begin
 Result := ut_LongProcess;
end;//Tkw_FormUserType_ut_LongProcess.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_LongProcess.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_LongProcess }
{$IfEnd} // NOT Defined(NoScripts)

end.
