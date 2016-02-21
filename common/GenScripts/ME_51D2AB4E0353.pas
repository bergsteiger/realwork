unit K466751465;
 {* [Requestlink:466751465] }

// ������: "w:\common\components\rtl\Garant\Daily\K466751465.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK466751465 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:466751465] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK466751465
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK466751465.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.9';
end;//TK466751465.GetFolder

function TK466751465.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51D2AB4E0353';
end;//TK466751465.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK466751465.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
