unit K558471539;
 {* [Requestlink:558471539] }

// ������: "w:\common\components\rtl\Garant\Daily\K558471539.pas"
// ���������: "TestCase"
// ������� ������: "TK558471539" MUID: (53DA02000037)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFRender
;

type
 TK558471539 = class(TEVDtoRTFRender)
  {* [Requestlink:558471539] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK558471539
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK558471539.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK558471539.GetFolder

function TK558471539.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53DA02000037';
end;//TK558471539.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK558471539.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
