unit List_Module;
 {* ������ }

// ������: "w:\common\components\SandBox\VCM\View\List\List_Module.pas"
// ���������: "VCMFormsPack"
// ������� ������: "List" MUID: (521DA6370197)
// ��� ����: "TListModule"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TListModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ������ }
  public
   class function ListPrintAndExportDefaultSetting: Boolean;
    {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
   class function ListPrintAndExportCustomSetting: Boolean;
    {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
   class function ListPrintAndExportFontSizeSetting: Integer;
    {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
   class procedure WriteListPrintAndExportFontSizeSetting(aValue: Integer);
    {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 end;//TListModule

implementation

uses
 l3ImplUses
 , ListPrintAndExportSettingRes
 , ListPrintAndExportFontSizeSettingRes
 , stListPrintAndExportFontSizeItem
 , afwFacade
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *521DA6370197impl_uses*
 //#UC END# *521DA6370197impl_uses*
;

{$If NOT Defined(NoVCM)}
class function TListModule.ListPrintAndExportDefaultSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
//#UC START# *7C0BFDDC64B7_521DA6370197_var*
//#UC END# *7C0BFDDC64B7_521DA6370197_var*
begin
//#UC START# *7C0BFDDC64B7_521DA6370197_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C0BFDDC64B7_521DA6370197_impl*
end;//TListModule.ListPrintAndExportDefaultSetting

class function TListModule.ListPrintAndExportCustomSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
//#UC START# *3BB8CB52B214_521DA6370197_var*
//#UC END# *3BB8CB52B214_521DA6370197_var*
begin
//#UC START# *3BB8CB52B214_521DA6370197_impl*
 !!! Needs to be implemented !!!
//#UC END# *3BB8CB52B214_521DA6370197_impl*
end;//TListModule.ListPrintAndExportCustomSetting

class function TListModule.ListPrintAndExportFontSizeSetting: Integer;
 {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
//#UC START# *1044DD7C8862_521DA6370197_var*
//#UC END# *1044DD7C8862_521DA6370197_var*
begin
//#UC START# *1044DD7C8862_521DA6370197_impl*
 !!! Needs to be implemented !!!
//#UC END# *1044DD7C8862_521DA6370197_impl*
end;//TListModule.ListPrintAndExportFontSizeSetting

class procedure TListModule.WriteListPrintAndExportFontSizeSetting(aValue: Integer);
 {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
//#UC START# *35644933EC2C_521DA6370197_var*
//#UC END# *35644933EC2C_521DA6370197_var*
begin
//#UC START# *35644933EC2C_521DA6370197_impl*
 !!! Needs to be implemented !!!
//#UC END# *35644933EC2C_521DA6370197_impl*
end;//TListModule.WriteListPrintAndExportFontSizeSetting
{$IfEnd} // NOT Defined(NoVCM)

end.
