unit K586706776;
 {* [Requestlink:586706776] }

// ������: "w:\common\components\rtl\Garant\Daily\K586706776.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFRender
;

type
 TK586706776 = class(TEVDtoRTFRender)
  {* [Requestlink:586706776] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK586706776
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK586706776.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK586706776.GetFolder

function TK586706776.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54C64695023F';
end;//TK586706776.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK586706776.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
