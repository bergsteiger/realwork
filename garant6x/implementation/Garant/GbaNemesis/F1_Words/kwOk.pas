unit kwOk;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwOk.pas"
// �����: 20.04.2011 21:54
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::Ok
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
 _F1Test_Parent_ = TtfwRegisterableWord;
 {$Include ..\F1_Words\F1Test.imp.pas}
 TkwOk = {scriptword} class(_F1Test_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOk
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(Admin)}
  ,
  nsQueryInterfaces
  {$IfEnd} //not Admin
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  nsUtils,
  nsConst,
  bsTypesNew
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include ..\F1_Words\F1Test.imp.pas}

// start class TkwOk

procedure TkwOk.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DAF1DD9017F_var*
//#UC END# *4DAEEDE10285_4DAF1DD9017F_var*
begin
//#UC START# *4DAEEDE10285_4DAF1DD9017F_impl*
 aCtx.rCaller.Check(vcmDispatcher.EntityOperation(TdmStdRes.opcode_Result_OkExt, vcmParams), '�������� Result OkExt �� �����������');
//#UC END# *4DAEEDE10285_4DAF1DD9017F_impl*
end;//TkwOk.DoDoIt

class function TkwOk.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ok';
end;//TkwOk.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Ok
 TkwOk.RegisterInEngine;
{$IfEnd} //not NoScripts

end.