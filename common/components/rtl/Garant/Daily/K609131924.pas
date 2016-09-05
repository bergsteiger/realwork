unit K609131924;
 {* [Requestlink:609131924] }

// ������: "w:\common\components\rtl\Garant\Daily\K609131924.pas"
// ���������: "TestCase"
// ������� ������: "K609131924" MUID: (561F3A590343)
// ��� ����: "TK609131924"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK609131924 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:609131924] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK609131924
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561F3A590343impl_uses*
 //#UC END# *561F3A590343impl_uses*
;

function TK609131924.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK609131924.GetFolder

function TK609131924.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561F3A590343';
end;//TK609131924.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK609131924.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
