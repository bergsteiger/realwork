unit EVDtoRTFWriterTest;
 {* ���� �������������� EVD � RTF }

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoRTFWriterTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFWriterTest
;

type
 TEVDtoRTFWriterTest = {abstract} class(TRTFWriterTest)
  {* ���� �������������� EVD � RTF }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   procedure DoIt;
 end;//TEVDtoRTFWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoRTFWriterTest.DoIt;
//#UC START# *4BACF19600F5_4BACF173038C_var*
//#UC END# *4BACF19600F5_4BACF173038C_var*
begin
//#UC START# *4BACF19600F5_4BACF173038C_impl*
 EVDtoRTF(KPage + '.evd', true);
//#UC END# *4BACF19600F5_4BACF173038C_impl*
end;//TEVDtoRTFWriterTest.DoIt

function TEVDtoRTFWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'RTF';
end;//TEVDtoRTFWriterTest.GetFolder

function TEVDtoRTFWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BACF173038C';
end;//TEVDtoRTFWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
