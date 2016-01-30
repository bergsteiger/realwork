unit K590758825;
 {* [Requestlink:590758825] }

// ������: "w:\common\components\rtl\Garant\Daily\K590758825.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK590758825 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:590758825] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK590758825
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK590758825.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK590758825.GetFolder

function TK590758825.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55100F3F014E';
end;//TK590758825.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590758825.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
