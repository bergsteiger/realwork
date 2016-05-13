unit K622418668;
 {* [Requestlink:622418668] }

// ������: "w:\common\components\rtl\Garant\Daily\K622418668.pas"
// ���������: "TestCase"
// ������� ������: "K622418668" MUID: (572B0C270341)
// ��� ����: "TK622418668"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK622418668 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:622418668] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK622418668
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK622418668.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK622418668.GetFolder

function TK622418668.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '572B0C270341';
end;//TK622418668.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK622418668.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
