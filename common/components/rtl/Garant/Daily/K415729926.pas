unit K415729926;
 {* [Requestlink:415729926] }

// ������: "w:\common\components\rtl\Garant\Daily\K415729926.pas"
// ���������: "TestCase"
// ������� ������: "K415729926" MUID: (50C898FC02F5)
// ��� ����: "TK415729926"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK415729926 = class(TEVDtoRTFWriterTest)
  {* [Requestlink:415729926] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK415729926
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK415729926.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK415729926.GetFolder

function TK415729926.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50C898FC02F5';
end;//TK415729926.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK415729926.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
