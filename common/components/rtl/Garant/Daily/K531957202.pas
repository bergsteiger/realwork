unit K531957202;
 {* [Requestlink:531957202] }

// ������: "w:\common\components\rtl\Garant\Daily\K531957202.pas"
// ���������: "TestCase"
// ������� ������: "K531957202" MUID: (53579D390059)
// ��� ����: "TK531957202"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK531957202 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:531957202] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK531957202
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *53579D390059impl_uses*
 //#UC END# *53579D390059impl_uses*
;

function TK531957202.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK531957202.GetFolder

function TK531957202.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53579D390059';
end;//TK531957202.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK531957202.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
