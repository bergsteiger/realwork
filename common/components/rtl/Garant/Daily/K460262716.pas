unit K460262716;
 {* [RequestLink:460262716] }

// ������: "w:\common\components\rtl\Garant\Daily\K460262716.pas"
// ���������: "TestCase"
// ������� ������: "K460262716" MUID: (51B1AE6001BB)
// ��� ����: "TK460262716"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CheckingFilesInFolderTest
;

type
 TK460262716 = class(TCheckingFilesInFolderTest)
  {* [RequestLink:460262716] }
  protected
   procedure DoDoit; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK460262716
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TK460262716.DoDoit;
//#UC START# *51B1C57B014C_51B1AE6001BB_var*
//#UC END# *51B1C57B014C_51B1AE6001BB_var*
begin
//#UC START# *51B1C57B014C_51B1AE6001BB_impl*
 
//#UC END# *51B1C57B014C_51B1AE6001BB_impl*
end;//TK460262716.DoDoit

function TK460262716.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SandBoxTests';
end;//TK460262716.GetFolder

function TK460262716.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51B1AE6001BB';
end;//TK460262716.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK460262716.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
