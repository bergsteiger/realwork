unit archiExportActionTest;

// ������: "w:\archi\source\projects\PipeInAuto\Tests\NewActions\Export\archiExportActionTest.pas"
// ���������: "TestCase"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
;

type
 TarchiExportActionTest = class(TBaseTest)
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} // Defined(nsTest)
  public
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

procedure TarchiExportActionTest.DoIt;
//#UC START# *5395D1AB0313_5395D124034E_var*
//#UC END# *5395D1AB0313_5395D124034E_var*
begin
//#UC START# *5395D1AB0313_5395D124034E_impl*
 Check(true);
//#UC END# *5395D1AB0313_5395D124034E_impl*
end;//TarchiExportActionTest.DoIt

{$If Defined(nsTest)}
function TarchiExportActionTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Tasked Actions';
end;//TarchiExportActionTest.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TarchiExportActionTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5395D124034E';
end;//TarchiExportActionTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TarchiExportActionTest.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
