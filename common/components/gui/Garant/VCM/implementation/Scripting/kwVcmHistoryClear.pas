unit kwVcmHistoryClear;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Scripting"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmHistoryClear.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_History_Clear
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
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include ..\Scripting\VCMWord.imp.pas}
 TkwVcmHistoryClear = {final scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmHistoryClear
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmForm
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  StdRes,
  vcmBase,
  afwAnswer
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

{$Include ..\Scripting\VCMWord.imp.pas}

// start class TkwVcmHistoryClear

procedure TkwVcmHistoryClear.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52F4D3CF01ED_var*
//#UC END# *4DAEEDE10285_52F4D3CF01ED_var*
begin
//#UC START# *4DAEEDE10285_52F4D3CF01ED_impl*
 if (vcmDispatcher.History <> nil) then
  vcmDispatcher.History.Clear(false);
//#UC END# *4DAEEDE10285_52F4D3CF01ED_impl*
end;//TkwVcmHistoryClear.DoDoIt

class function TkwVcmHistoryClear.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:History:Clear';
end;//TkwVcmHistoryClear.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� vcm_History_Clear
 TkwVcmHistoryClear.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.