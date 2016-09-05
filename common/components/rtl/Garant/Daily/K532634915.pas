unit K532634915;
 {* [Requestlink:532634915] }

// ������: "w:\common\components\rtl\Garant\Daily\K532634915.pas"
// ���������: "TestCase"
// ������� ������: "K532634915" MUID: (5369D1DB0248)
// ��� ����: "TK532634915"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TK532634915 = class(TEVDtoNSRCWriterTest)
  {* [Requestlink:532634915] }
  protected
   function IsNSRCPlus: Boolean; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK532634915
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5369D1DB0248impl_uses*
 //#UC END# *5369D1DB0248impl_uses*
;

function TK532634915.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_5369D1DB0248_var*
//#UC END# *4B8545CC03D2_5369D1DB0248_var*
begin
//#UC START# *4B8545CC03D2_5369D1DB0248_impl*
 Result := False;
//#UC END# *4B8545CC03D2_5369D1DB0248_impl*
end;//TK532634915.IsNSRCPlus

function TK532634915.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRC 7.7';
end;//TK532634915.GetFolder

function TK532634915.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5369D1DB0248';
end;//TK532634915.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK532634915.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
