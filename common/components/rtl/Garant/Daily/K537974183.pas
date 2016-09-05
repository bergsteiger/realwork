unit K537974183;
 {* [RequestLink:537974183] }

// ������: "w:\common\components\rtl\Garant\Daily\K537974183.pas"
// ���������: "TestCase"
// ������� ������: "K537974183" MUID: (5385BF7E0260)
// ��� ����: "TK537974183"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537974183 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:537974183] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK537974183
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5385BF7E0260impl_uses*
 //#UC END# *5385BF7E0260impl_uses*
;

function TK537974183.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK537974183.GetFolder

function TK537974183.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5385BF7E0260';
end;//TK537974183.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537974183.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
