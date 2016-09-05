unit K595967367;
 {* [RequestLink:595967367] }

// ������: "w:\common\components\rtl\Garant\Daily\K595967367.pas"
// ���������: "TestCase"
// ������� ������: "K595967367" MUID: (551D1EAB032E)
// ��� ����: "TK595967367"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK595967367 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:595967367] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK595967367
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *551D1EAB032Eimpl_uses*
 //#UC END# *551D1EAB032Eimpl_uses*
;

function TK595967367.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK595967367.GetFolder

function TK595967367.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '551D1EAB032E';
end;//TK595967367.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK595967367.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
