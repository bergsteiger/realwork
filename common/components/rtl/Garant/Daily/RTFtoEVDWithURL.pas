unit RTFtoEVDWithURL;

// ������: "w:\common\components\rtl\Garant\Daily\RTFtoEVDWithURL.pas"
// ���������: "TestCase"
// ������� ������: "RTFtoEVDWithURL" MUID: (56A9CA080124)
// ��� ����: "TRTFtoEVDWithURL"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TRTFtoEVDWithURL = {abstract} class(TRTFtoEVDWriterTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   function GetEnableReadURL: Boolean; override;
 end;//TRTFtoEVDWithURL
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TRTFtoEVDWithURL.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'RTF';
end;//TRTFtoEVDWithURL.GetFolder

function TRTFtoEVDWithURL.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56A9CA080124';
end;//TRTFtoEVDWithURL.GetModelElementGUID

function TRTFtoEVDWithURL.GetEnableReadURL: Boolean;
//#UC START# *56A9C9CE021D_56A9CA080124_var*
//#UC END# *56A9C9CE021D_56A9CA080124_var*
begin
//#UC START# *56A9C9CE021D_56A9CA080124_impl*
 Result := True;
//#UC END# *56A9C9CE021D_56A9CA080124_impl*
end;//TRTFtoEVDWithURL.GetEnableReadURL
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
