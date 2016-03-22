unit InsiderOwnScripter;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\InsiderOwnScripter.pas"
// ���������: "TestCase"
// ������� ������: "InsiderOwnScripter" MUID: (4DB03B1B0055)
// ��� ����: "TInsiderOwnScripter"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomInsiderScripter
;

type
 _F1Test_Parent_ = TCustomInsiderScripter;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1Test.imp.pas}
 TInsiderOwnScripter = {abstract} class(_F1Test_)
  protected
   procedure Run; override;
   procedure Prepare; override;
    {* ���������� � ������ DoIt }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TInsiderOwnScripter
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(Admin)}
 , nsQueryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , nsConst
 , bsTypesNew
 , tfwScriptEngine
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1Test.imp.pas}

procedure TInsiderOwnScripter.Run;
//#UC START# *4DC3D2E00153_4DB03B1B0055_var*
//#UC END# *4DC3D2E00153_4DB03B1B0055_var*
begin
//#UC START# *4DC3D2E00153_4DB03B1B0055_impl*
 OwnScriptFromFile;
//#UC END# *4DC3D2E00153_4DB03B1B0055_impl*
end;//TInsiderOwnScripter.Run

procedure TInsiderOwnScripter.Prepare;
 {* ���������� � ������ DoIt }
//#UC START# *4DC3DE630030_4DB03B1B0055_var*
//#UC END# *4DC3DE630030_4DB03B1B0055_var*
begin
//#UC START# *4DC3DE630030_4DB03B1B0055_impl*
 g_WasBeep := false;
 //Script('"������� ��� ���� ����� ��������" StyleTable:Restore ������������ "���������� ������� �� � ������������� ���������" "��������� ������ �������" clipboard:clear');
 //ScriptFromFile('@\TestProlog.script');
//#UC END# *4DC3DE630030_4DB03B1B0055_impl*
end;//TInsiderOwnScripter.Prepare

function TInsiderOwnScripter.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Core';
end;//TInsiderOwnScripter.GetFolder

function TInsiderOwnScripter.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DB03B1B0055';
end;//TInsiderOwnScripter.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
