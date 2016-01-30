unit K342865677;
 {* [RequestLink:342865677] }

// ������: "w:\common\components\rtl\Garant\Daily\K342865677.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK342865677 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:342865677] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK342865677
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK342865677.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRC 7.7';
end;//TK342865677.GetFolder

function TK342865677.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F5497DD004E';
end;//TK342865677.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342865677.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
