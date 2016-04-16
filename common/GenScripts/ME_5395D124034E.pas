unit archiExportActionTest;

// ������: "w:\archi\source\projects\PipeInAuto\Tests\NewActions\Export\archiExportActionTest.pas"
// ���������: "TestCase"
// ������� ������: "TarchiExportActionTest" MUID: (5395D124034E)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
;

type
 TarchiExportActionTest = class({$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 )
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} // Defined(nsTest)
  published
   procedure DoIt;
 end;//TarchiExportActionTest
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
procedure TarchiExportActionTest.DoIt;
//#UC START# *5395D1AB0313_5395D124034E_var*
//#UC END# *5395D1AB0313_5395D124034E_var*
begin
//#UC START# *5395D1AB0313_5395D124034E_impl*
 Check(true);
//#UC END# *5395D1AB0313_5395D124034E_impl*
end;//TarchiExportActionTest.DoIt

function TarchiExportActionTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Tasked Actions';
end;//TarchiExportActionTest.GetFolder

function TarchiExportActionTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5395D124034E';
end;//TarchiExportActionTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TarchiExportActionTest.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)
end.
