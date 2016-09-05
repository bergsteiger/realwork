unit K624853474;
 {* [Requestlink:624853474] }

// ������: "w:\common\components\rtl\Garant\Daily\K624853474.pas"
// ���������: "TestCase"
// ������� ������: "K624853474" MUID: (5769053901BB)
// ��� ����: "TK624853474"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK624853474 = class(THTMLtoEVDFull)
  {* [Requestlink:624853474] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK624853474
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5769053901BBimpl_uses*
 //#UC END# *5769053901BBimpl_uses*
;

function TK624853474.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK624853474.GetFolder

function TK624853474.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5769053901BB';
end;//TK624853474.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624853474.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
