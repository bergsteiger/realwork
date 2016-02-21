unit K235052988;
 {* [RequestLink:235052988]. }

// ������: "w:\common\components\rtl\Garant\Daily\K235052988.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK235052988 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:235052988]. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235052988
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235052988.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235052988.GetFolder

function TK235052988.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C971C9E0204';
end;//TK235052988.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235052988.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
