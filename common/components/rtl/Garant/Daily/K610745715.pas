unit K610745715;
 {* [Requestlink:610745715] }

// ������: "w:\common\components\rtl\Garant\Daily\K610745715.pas"
// ���������: "TestCase"
// ������� ������: "K610745715" MUID: (563B44190171)
// ��� ����: "TK610745715"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610745715 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610745715] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK610745715
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *563B44190171impl_uses*
 //#UC END# *563B44190171impl_uses*
;

function TK610745715.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK610745715.GetFolder

function TK610745715.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '563B44190171';
end;//TK610745715.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610745715.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
