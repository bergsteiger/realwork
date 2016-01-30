unit K540414443;
 {* [Requestlink:540414443] }

// ������: "w:\common\components\rtl\Garant\Daily\K540414443.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK540414443 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:540414443] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK540414443
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK540414443.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK540414443.GetFolder

function TK540414443.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53901E3D023F';
end;//TK540414443.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540414443.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
