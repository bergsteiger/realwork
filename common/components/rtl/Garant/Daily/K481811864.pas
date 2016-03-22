unit K481811864;

// ������: "w:\common\components\rtl\Garant\Daily\K481811864.pas"
// ���������: "TestCase"
// ������� ������: "TK481811864" MUID: (522D92550289)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK481811864 = class(TNSRCtoEVDTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK481811864
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK481811864.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.9';
end;//TK481811864.GetFolder

function TK481811864.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '522D92550289';
end;//TK481811864.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK481811864.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
