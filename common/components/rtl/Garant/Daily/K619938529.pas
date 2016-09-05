unit K619938529;
 {* [Requestlink:619938529] }

// ������: "w:\common\components\rtl\Garant\Daily\K619938529.pas"
// ���������: "TestCase"
// ������� ������: "K619938529" MUID: (56E90B390171)
// ��� ����: "TK619938529"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK619938529 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:619938529] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619938529
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56E90B390171impl_uses*
 //#UC END# *56E90B390171impl_uses*
;

function TK619938529.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619938529.GetFolder

function TK619938529.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E90B390171';
end;//TK619938529.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619938529.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
