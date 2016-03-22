unit K226001945;
 {* [RequestLink:226001945] }

// ������: "w:\common\components\rtl\Garant\Daily\K226001945.pas"
// ���������: "TestCase"
// ������� ������: "K226001945" MUID: (4C75166400F1)
// ��� ����: "TK226001945"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK226001945 = class(TEVDtoRTFWriterTest)
  {* [RequestLink:226001945] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NotTunedDUnit)}
   function EtalonCanHaveDiff: Boolean; override;
    {* ������ ����� ����� ��������� ������� ��� ����������� ����������. �������� ��� � [RequestLink:234362304] }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK226001945
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK226001945.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK226001945.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TK226001945.EtalonCanHaveDiff: Boolean;
 {* ������ ����� ����� ��������� ������� ��� ����������� ����������. �������� ��� � [RequestLink:234362304] }
//#UC START# *4CAEE13D00E1_4C75166400F1_var*
//#UC END# *4CAEE13D00E1_4C75166400F1_var*
begin
//#UC START# *4CAEE13D00E1_4C75166400F1_impl*
 Result := true;
//#UC END# *4CAEE13D00E1_4C75166400F1_impl*
end;//TK226001945.EtalonCanHaveDiff
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TK226001945.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C75166400F1';
end;//TK226001945.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK226001945.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
