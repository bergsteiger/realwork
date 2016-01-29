unit kwFiltersList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwFiltersList.pas"
// �����: 29.04.2011 15:11
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::TkwFiltersList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}
 TkwFiltersList = {scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwFiltersList
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  afwAnswer
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}

// start class TkwFiltersList

procedure TkwFiltersList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBA9CE301B4_var*
//#UC END# *4DAEEDE10285_4DBA9CE301B4_var*
begin
//#UC START# *4DAEEDE10285_4DBA9CE301B4_impl*
 aCtx.rCaller.Check(vcmDispatcher.EntityOperation(TdmStdRes.opcode_Filters_FiltersListOpen, vcmParams));
//#UC END# *4DAEEDE10285_4DBA9CE301B4_impl*
end;//TkwFiltersList.DoDoIt

class function TkwFiltersList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'filters:Open';
end;//TkwFiltersList.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwFiltersList
 TkwFiltersList.RegisterInEngine;
{$IfEnd} //not NoScripts

end.