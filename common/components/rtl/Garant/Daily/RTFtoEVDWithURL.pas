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
   function GetEnableReadURL: Boolean; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TRTFtoEVDWithURL
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56A9CA080124impl_uses*
 //#UC END# *56A9CA080124impl_uses*
;

function TRTFtoEVDWithURL.GetEnableReadURL: Boolean;
//#UC START# *56A9C9CE021D_56A9CA080124_var*
//#UC END# *56A9C9CE021D_56A9CA080124_var*
begin
//#UC START# *56A9C9CE021D_56A9CA080124_impl*
 Result := True;
//#UC END# *56A9C9CE021D_56A9CA080124_impl*
end;//TRTFtoEVDWithURL.GetEnableReadURL

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
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
