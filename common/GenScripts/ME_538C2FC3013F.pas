unit K538550781;
 {* [Requestlink:538550781] }

// ������: "w:\common\components\rtl\Garant\Daily\K538550781.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWithiddenTextExtractor
;

type
 TK538550781 = class(TRTFtoEVDWithiddenTextExtractor)
  {* [Requestlink:538550781] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK538550781
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK538550781.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK538550781.GetFolder

function TK538550781.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '538C2FC3013F';
end;//TK538550781.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538550781.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
