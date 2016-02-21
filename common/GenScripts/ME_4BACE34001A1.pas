unit K199591594;
 {* [$199591594] }

// ������: "w:\common\components\rtl\Garant\Daily\K199591594.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFWriterTest
;

type
 TK199591594 = class(TRTFWriterTest)
  {* [$199591594] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NotTunedDUnit)}
   function EtalonNeedsComputerName: Boolean; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   procedure DoIt;
 end;//TK199591594
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TK199591594.DoIt;
//#UC START# *4BACE4A50338_4BACE34001A1_var*
//#UC END# *4BACE4A50338_4BACE34001A1_var*
begin
//#UC START# *4BACE4A50338_4BACE34001A1_impl*
 EVDtoRTF('199591594.evd', true{false});
//#UC END# *4BACE4A50338_4BACE34001A1_impl*
end;//TK199591594.DoIt

function TK199591594.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK199591594.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TK199591594.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_4BACE34001A1_var*
//#UC END# *4CA45DAA01BA_4BACE34001A1_var*
begin
//#UC START# *4CA45DAA01BA_4BACE34001A1_impl*
 Result := true;
//#UC END# *4CA45DAA01BA_4BACE34001A1_impl*
end;//TK199591594.EtalonNeedsComputerName
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TK199591594.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BACE34001A1';
end;//TK199591594.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK199591594.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
