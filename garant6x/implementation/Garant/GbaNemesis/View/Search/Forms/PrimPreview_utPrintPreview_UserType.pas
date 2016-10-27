unit PrimPreview_utPrintPreview_UserType;
 {* ��������������� �������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPreview_utPrintPreview_UserType.pas"
// ���������: "UserType"
// ������� ������: "utPrintPreview" MUID: (4C6D0F2700E1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utPrintPreviewLocalConstants }
 str_utPrintPreviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utPrintPreviewCaption'; rValue : '��������������� �������� ������');
  {* ��������� ����������������� ���� "��������������� �������� ������" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utPrintPreview = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utPrintPreview }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utPrintPreview
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utPrintPreview.GetInteger: Integer;
begin
 Result := utPrintPreview;
end;//Tkw_FormUserType_utPrintPreview.GetInteger

class function Tkw_FormUserType_utPrintPreview.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utPrintPreview';
end;//Tkw_FormUserType_utPrintPreview.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utPrintPreviewCaption.Init;
 {* ������������� str_utPrintPreviewCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utPrintPreview.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utPrintPreview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
