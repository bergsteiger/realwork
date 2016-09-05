unit K611202391;
 {* [Requestlink:611202391] }

// ������: "w:\common\components\rtl\Garant\Daily\K611202391.pas"
// ���������: "TestCase"
// ������� ������: "K611202391" MUID: (56559A5F02D0)
// ��� ����: "TK611202391"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK611202391 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:611202391] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK611202391
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56559A5F02D0impl_uses*
 //#UC END# *56559A5F02D0impl_uses*
;

function TK611202391.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK611202391.GetFolder

function TK611202391.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56559A5F02D0';
end;//TK611202391.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK611202391.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
