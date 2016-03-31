unit Document_Module;
 {* �������� }

// ������: "w:\common\components\SandBox\VCM\View\Document\Document_Module.pas"
// ���������: "VCMFormsPack"
// ������� ������: "Document" MUID: (5216345D004A)
// ��� ����: "TDocumentModule"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 TDocumentModule = class(TvcmModule)
  {* �������� }
  public
   class function DocumentPrintAndExportDefaultSetting: Boolean;
    {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
   class function DocumentPrintAndExportCustomSetting: Boolean;
    {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
   class function DocumentPrintAndExportFontSizeSetting: Integer;
    {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
   class procedure WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
    {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 end;//TDocumentModule

implementation

uses
 l3ImplUses
 , DocumentPrintAndExportSettingRes
 , DocumentPrintAndExportFontSizeSettingRes
 , stDocumentPrintAndExportFontSizeItem
 , afwFacade
;

{$If NOT Defined(NoVCM)}
class function TDocumentModule.DocumentPrintAndExportDefaultSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
//#UC START# *17DC451B397C_5216345D004A_var*
//#UC END# *17DC451B397C_5216345D004A_var*
begin
//#UC START# *17DC451B397C_5216345D004A_impl*
 !!! Needs to be implemented !!!
//#UC END# *17DC451B397C_5216345D004A_impl*
end;//TDocumentModule.DocumentPrintAndExportDefaultSetting

class function TDocumentModule.DocumentPrintAndExportCustomSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
//#UC START# *D176CCBDE51D_5216345D004A_var*
//#UC END# *D176CCBDE51D_5216345D004A_var*
begin
//#UC START# *D176CCBDE51D_5216345D004A_impl*
 !!! Needs to be implemented !!!
//#UC END# *D176CCBDE51D_5216345D004A_impl*
end;//TDocumentModule.DocumentPrintAndExportCustomSetting

class function TDocumentModule.DocumentPrintAndExportFontSizeSetting: Integer;
 {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
//#UC START# *12B83765C323_5216345D004A_var*
//#UC END# *12B83765C323_5216345D004A_var*
begin
//#UC START# *12B83765C323_5216345D004A_impl*
 !!! Needs to be implemented !!!
//#UC END# *12B83765C323_5216345D004A_impl*
end;//TDocumentModule.DocumentPrintAndExportFontSizeSetting

class procedure TDocumentModule.WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
 {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
//#UC START# *930B9F1EF1E3_5216345D004A_var*
//#UC END# *930B9F1EF1E3_5216345D004A_var*
begin
//#UC START# *930B9F1EF1E3_5216345D004A_impl*
 !!! Needs to be implemented !!!
//#UC END# *930B9F1EF1E3_5216345D004A_impl*
end;//TDocumentModule.WriteDocumentPrintAndExportFontSizeSetting
{$IfEnd} // NOT Defined(NoVCM)

end.
