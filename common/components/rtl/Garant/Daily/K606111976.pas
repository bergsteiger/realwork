unit K606111976;
 {* [Requestlink:606111976] }

// ������: "w:\common\components\rtl\Garant\Daily\K606111976.pas"
// ���������: "TestCase"
// ������� ������: "K606111976" MUID: (55D729C902E7)
// ��� ����: "TK606111976"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606111976 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606111976] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK606111976
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606111976.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK606111976.GetFolder

function TK606111976.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55D729C902E7';
end;//TK606111976.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606111976.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
