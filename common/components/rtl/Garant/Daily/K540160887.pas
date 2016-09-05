unit K540160887;
 {* [Requestlink:538550781] }

// ������: "w:\common\components\rtl\Garant\Daily\K540160887.pas"
// ���������: "TestCase"
// ������� ������: "K540160887" MUID: (538C696A01FF)
// ��� ����: "TK540160887"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWithiddenTextExtractor
;

type
 TK540160887 = class(TRTFtoEVDWithiddenTextExtractor)
  {* [Requestlink:538550781] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK540160887
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *538C696A01FFimpl_uses*
 //#UC END# *538C696A01FFimpl_uses*
;

function TK540160887.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK540160887.GetFolder

function TK540160887.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '538C696A01FF';
end;//TK540160887.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540160887.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
