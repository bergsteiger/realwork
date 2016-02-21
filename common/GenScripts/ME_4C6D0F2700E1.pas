unit PrimPreview_utPrintPreview_UserType;
 {* ��������������� �������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPreview_utPrintPreview_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utPrintPreview }
 utPrintPreviewName = 'utPrintPreview';
  {* ��������� ������������� ����������������� ���� "��������������� �������� ������" }
 utPrintPreview = TvcmUserType(0);
  {* ��������������� �������� ������ }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utPrintPreview = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utPrintPreview }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utPrintPreview
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utPrintPreview.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utPrintPreview';
end;//Tkw_FormUserType_utPrintPreview.GetWordNameForRegister

function Tkw_FormUserType_utPrintPreview.GetInteger: Integer;
begin
 Result := utPrintPreview;
end;//Tkw_FormUserType_utPrintPreview.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utPrintPreview.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utPrintPreview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
