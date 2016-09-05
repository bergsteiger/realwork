unit K602703982;
 {* [Requestlink:602703982] }

// ������: "w:\common\components\rtl\Garant\Daily\K602703982.pas"
// ���������: "TestCase"
// ������� ������: "K602703982" MUID: (5593B9130064)
// ��� ����: "TK602703982"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK602703982 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:602703982] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK602703982
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5593B9130064impl_uses*
 //#UC END# *5593B9130064impl_uses*
;

function TK602703982.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK602703982.GetFolder

function TK602703982.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5593B9130064';
end;//TK602703982.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK602703982.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
