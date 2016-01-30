unit K228693150;
 {* [RequestLink:228693150] }

// ������: "w:\common\components\rtl\Garant\Daily\K228693150.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TwoEmptyParaForOneReplacerTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK228693150 = class(TTwoEmptyParaForOneReplacerTest)
  {* [RequestLink:228693150] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK228693150
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK228693150.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK228693150.GetFolder

function TK228693150.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C5147EC013F';
end;//TK228693150.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228693150.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
