unit kwVcmOpImageIndex;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Scripting"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmOpImageIndex.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_op_ImageIndex
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
  kwOperationParamWordPrim,
  vcmInterfaces,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 TkwVcmOpImageIndex = {final scriptword} class(TkwOperationParamWordPrim)
 protected
 // realized methods
   procedure DoParams(const aParams: IvcmTestParams;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpImageIndex
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwVcmOpImageIndex

procedure TkwVcmOpImageIndex.DoParams(const aParams: IvcmTestParams;
  const aCtx: TtfwContext);
//#UC START# *5230185F0140_523018AA0227_var*
//#UC END# *5230185F0140_523018AA0227_var*
begin
//#UC START# *5230185F0140_523018AA0227_impl*
 aCtx.rEngine.PushInt(aParams.Op.ImageIndex);
//#UC END# *5230185F0140_523018AA0227_impl*
end;//TkwVcmOpImageIndex.DoParams

class function TkwVcmOpImageIndex.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:op:ImageIndex';
end;//TkwVcmOpImageIndex.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� vcm_op_ImageIndex
 TkwVcmOpImageIndex.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.