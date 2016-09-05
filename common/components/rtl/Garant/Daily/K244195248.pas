unit K244195248;
 {* [RequestLInk:244195248] }

// ������: "w:\common\components\rtl\Garant\Daily\K244195248.pas"
// ���������: "TestCase"
// ������� ������: "K244195248" MUID: (4CF7B1DA026E)
// ��� ����: "TK244195248"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK244195248 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLInk:244195248] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK244195248
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4CF7B1DA026Eimpl_uses*
 //#UC END# *4CF7B1DA026Eimpl_uses*
;

function TK244195248.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK244195248.GetFolder

function TK244195248.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CF7B1DA026E';
end;//TK244195248.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK244195248.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
