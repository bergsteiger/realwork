unit EVDtoEVDWriterTest;

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoEVDWriterTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDWriterTest
;

type
 TEVDtoEVDWriterTest = {abstract} class(TEVDWriterTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   procedure DoIt;
 end;//TEVDtoEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoEVDWriterTest.DoIt;
//#UC START# *4C07B5F90205_4C07B5E300F2_var*
//#UC END# *4C07B5F90205_4C07B5E300F2_var*
begin
//#UC START# *4C07B5F90205_4C07B5E300F2_impl*
 EVDtoEVD(KPage + '.evd');
//#UC END# *4C07B5F90205_4C07B5E300F2_impl*
end;//TEVDtoEVDWriterTest.DoIt

function TEVDtoEVDWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EVD';
end;//TEVDtoEVDWriterTest.GetFolder

function TEVDtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C07B5E300F2';
end;//TEVDtoEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
