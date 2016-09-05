unit HTMLtoEVDTest;

// ������: "w:\common\components\rtl\Garant\Daily\HTMLtoEVDTest.pas"
// ���������: "TestCase"
// ������� ������: "HTMLtoEVDTest" MUID: (4E847E770184)
// ��� ����: "THTMLtoEVDTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDWriterTest
;

type
 THTMLtoEVDTest = {abstract} class(THTMLtoEVDWriterTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//THTMLtoEVDTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E847E770184impl_uses*
 //#UC END# *4E847E770184impl_uses*
;

procedure THTMLtoEVDTest.DoIt;
//#UC START# *4E847F290293_4E847E770184_var*
//#UC END# *4E847F290293_4E847E770184_var*
begin
//#UC START# *4E847F290293_4E847E770184_impl*
 HTMLtoEVD(KPage + '.htm');
//#UC END# *4E847F290293_4E847E770184_impl*
end;//THTMLtoEVDTest.DoIt

function THTMLtoEVDTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'HTML';
end;//THTMLtoEVDTest.GetFolder

function THTMLtoEVDTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E847E770184';
end;//THTMLtoEVDTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
