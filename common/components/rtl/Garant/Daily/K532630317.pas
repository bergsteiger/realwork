unit K532630317;
 {* [Requestlink:532630317] }

// ������: "w:\common\components\rtl\Garant\Daily\K532630317.pas"
// ���������: "TestCase"
// ������� ������: "K532630317" MUID: (5369D18401D2)
// ��� ����: "TK532630317"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TK532630317 = class(TEVDtoNSRCWriterTest)
  {* [Requestlink:532630317] }
  protected
   function IsNSRCPlus: Boolean; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK532630317
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK532630317.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_5369D18401D2_var*
//#UC END# *4B8545CC03D2_5369D18401D2_var*
begin
//#UC START# *4B8545CC03D2_5369D18401D2_impl*
 Result := False;
//#UC END# *4B8545CC03D2_5369D18401D2_impl*
end;//TK532630317.IsNSRCPlus

function TK532630317.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRC 7.7';
end;//TK532630317.GetFolder

function TK532630317.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5369D18401D2';
end;//TK532630317.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK532630317.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
