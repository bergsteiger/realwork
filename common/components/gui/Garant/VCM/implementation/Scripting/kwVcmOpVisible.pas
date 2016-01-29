unit kwVcmOpVisible;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Scripting"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmOpVisible.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_op_Visible
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
 TkwVcmOpVisible = {final scriptword} class(TkwOperationParamWord)
 protected
 // realized methods
   function Flag: TvcmOpFlag; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpVisible
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwVcmOpVisible

function TkwVcmOpVisible.Flag: TvcmOpFlag;
//#UC START# *5230151C02BA_523014D3003C_var*
//#UC END# *5230151C02BA_523014D3003C_var*
begin
//#UC START# *5230151C02BA_523014D3003C_impl*
 Result := vcm_ofVisible;
//#UC END# *5230151C02BA_523014D3003C_impl*
end;//TkwVcmOpVisible.Flag

class function TkwVcmOpVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:op:Visible';
end;//TkwVcmOpVisible.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� vcm_op_Visible
 TkwVcmOpVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.