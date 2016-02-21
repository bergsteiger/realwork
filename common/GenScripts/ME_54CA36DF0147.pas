unit K522781827;
 {* [Requestlink:522781827] }

// ������: "w:\common\components\rtl\Garant\Daily\K522781827.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK522781827 = class(THTMLtoEVDTest)
  {* [Requestlink:522781827] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK522781827
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK522781827.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK522781827.GetFolder

function TK522781827.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54CA36DF0147';
end;//TK522781827.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK522781827.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
