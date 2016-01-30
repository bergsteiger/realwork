unit K610745702;
 {* [Requestlink:610745702] }

// ������: "w:\common\components\rtl\Garant\Daily\K610745702.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610745702 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610745702] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK610745702
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK610745702.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK610745702.GetFolder

function TK610745702.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '563B43FA0140';
end;//TK610745702.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610745702.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
