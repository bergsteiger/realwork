unit K267324701;
 {* [$267324701] }

// ������: "w:\common\components\rtl\Garant\Daily\K267324701.pas"
// ���������: "TestCase"
// ������� ������: "K267324701" MUID: (4DDF8309020E)
// ��� ����: "TK267324701"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TK267324701 = class(TEVDtoNSRCWriterTest)
  {* [$267324701] }
  protected
   function IsNSRCPlus: Boolean; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK267324701
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4DDF8309020Eimpl_uses*
 //#UC END# *4DDF8309020Eimpl_uses*
;

function TK267324701.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4DDF8309020E_var*
//#UC END# *4B8545CC03D2_4DDF8309020E_var*
begin
//#UC START# *4B8545CC03D2_4DDF8309020E_impl*
 Result := False;
//#UC END# *4B8545CC03D2_4DDF8309020E_impl*
end;//TK267324701.IsNSRCPlus

function TK267324701.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRC 7.7';
end;//TK267324701.GetFolder

function TK267324701.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DDF8309020E';
end;//TK267324701.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK267324701.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
