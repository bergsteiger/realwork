unit K234361767;
 {* [RequestLink:234361767] }

// ������: "w:\common\components\rtl\Garant\Daily\K234361767.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK234361767 = class(TEVDtoRTFWriterTest)
  {* [RequestLink:234361767] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NotTunedDUnit)}
   function EtalonCanHaveDiff: Boolean; override;
    {* ������ ����� ����� ��������� ������� ��� ����������� ����������. �������� ��� � [RequestLink:234362304] }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK234361767
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK234361767.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK234361767.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TK234361767.EtalonCanHaveDiff: Boolean;
 {* ������ ����� ����� ��������� ������� ��� ����������� ����������. �������� ��� � [RequestLink:234362304] }
//#UC START# *4CAEE13D00E1_4C84C7D1022A_var*
//#UC END# *4CAEE13D00E1_4C84C7D1022A_var*
begin
//#UC START# *4CAEE13D00E1_4C84C7D1022A_impl*
 Result := true;
//#UC END# *4CAEE13D00E1_4C84C7D1022A_impl*
end;//TK234361767.EtalonCanHaveDiff
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TK234361767.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C84C7D1022A';
end;//TK234361767.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK234361767.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
