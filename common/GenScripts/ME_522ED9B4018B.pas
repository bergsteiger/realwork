unit evStyles_SH;
 {* ����� }

// ������: "w:\common\components\gui\Garant\Everest\evStyles_SH.pas"
// ���������: "SettingsHolder"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evInterface
 , l3ProtoObject
 , afwInterfaces
;

type
 SHevStyles = class(TevInterface)
  {* ����� }
  public
   class function PrintAndExportFontSize: Integer;
    {* ����������� ������ ������ ��� ������ � �������� }
   class function PrintAndExportDefaultSetting: Boolean;
    {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
   class function PrintAndExportCustomSetting: Boolean;
    {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
   class function PrintAndExportFontSizeSetting: Integer;
    {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
   class procedure WritePrintAndExportFontSizeSetting(aValue: Integer);
    {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 end;//SHevStyles

implementation

uses
 l3ImplUses
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , evStylesPrintAndExportSettingRes
 , evStylesPrintAndExportFontSizeSettingRes
 , afwFacade
 , SysUtils
 , afwSettingsChangePublisher
 , l3Base
;

type
 _afwSettingChanged_Parent_ = Tl3ProtoObject;
 {$Include afwSettingChanged.imp.pas}
 TevStylesSettingsListener = class(_afwSettingChanged_)
  {* ��������� evStyles, ������� ������������� � ���������� }
  private
   function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
    {* ����� ��� �������� ���� �����, ��� TevStylesSettingsListener �������� ��������� ��������� ��������� }
  protected
   function DoSettingChanged(const aSettingId: TafwSettingId): Boolean; override;
    {* ���������� ��������� ��������� ��������� }
  public
   class procedure CheckSubscribe;
    {* ����� ��� �������� ���� �����, ��� TevStylesSettingsListener �������� �� ��������� ����������� �������� }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TevStylesSettingsListener;
    {* ����� ��������� ���������� ���������� TevStylesSettingsListener }
 end;//TevStylesSettingsListener

var g_TevStylesSettingsListener: TevStylesSettingsListener = nil;
 {* ��������� ���������� TevStylesSettingsListener }

procedure TevStylesSettingsListenerFree;
 {* ����� ������������ ���������� ���������� TevStylesSettingsListener }
begin
 l3Free(g_TevStylesSettingsListener);
end;//TevStylesSettingsListenerFree

{$Include afwSettingChanged.imp.pas}

class procedure TevStylesSettingsListener.CheckSubscribe;
 {* ����� ��� �������� ���� �����, ��� TevStylesSettingsListener �������� �� ��������� ����������� �������� }
//#UC START# *ADC42F5F57B3_5EDF2B8ACE76_var*
//#UC END# *ADC42F5F57B3_5EDF2B8ACE76_var*
begin
//#UC START# *ADC42F5F57B3_5EDF2B8ACE76_impl*
 !!! Needs to be implemented !!!
//#UC END# *ADC42F5F57B3_5EDF2B8ACE76_impl*
end;//TevStylesSettingsListener.CheckSubscribe

function TevStylesSettingsListener.IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
 {* ����� ��� �������� ���� �����, ��� TevStylesSettingsListener �������� ��������� ��������� ��������� }
//#UC START# *704CA5071A35_5EDF2B8ACE76_var*
//#UC END# *704CA5071A35_5EDF2B8ACE76_var*
begin
//#UC START# *704CA5071A35_5EDF2B8ACE76_impl*
 !!! Needs to be implemented !!!
//#UC END# *704CA5071A35_5EDF2B8ACE76_impl*
end;//TevStylesSettingsListener.IsSettingAffectsUs

class function TevStylesSettingsListener.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TevStylesSettingsListener <> nil;
end;//TevStylesSettingsListener.Exists

class function TevStylesSettingsListener.Instance: TevStylesSettingsListener;
 {* ����� ��������� ���������� ���������� TevStylesSettingsListener }
begin
 if (g_TevStylesSettingsListener = nil) then
 begin
  l3System.AddExitProc(TevStylesSettingsListenerFree);
  g_TevStylesSettingsListener := Create;
 end;
 Result := g_TevStylesSettingsListener;
end;//TevStylesSettingsListener.Instance

function TevStylesSettingsListener.DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
 {* ���������� ��������� ��������� ��������� }
//#UC START# *47EA863A035C_5EDF2B8ACE76_var*
//#UC END# *47EA863A035C_5EDF2B8ACE76_var*
begin
//#UC START# *47EA863A035C_5EDF2B8ACE76_impl*
 !!! Needs to be implemented !!!
//#UC END# *47EA863A035C_5EDF2B8ACE76_impl*
end;//TevStylesSettingsListener.DoSettingChanged

class function SHevStyles.PrintAndExportFontSize: Integer;
 {* ����������� ������ ������ ��� ������ � �������� }
//#UC START# *52387143039D_522ED9B4018B_var*
const
 cSizes : array [PrintAndExportFontSizeEnum] of Integer = (8, 9, 10, 11, 12, 14, 16);
var
 l_Size : Integer;
//#UC END# *52387143039D_522ED9B4018B_var*
begin
//#UC START# *52387143039D_522ED9B4018B_impl*
 TevStylesSettingsListener.CheckSubscribe;
 if PrintAndExportDefaultSetting then
  Result := 0
 else
 begin
  l_Size := PrintAndExportFontSizeSetting;
  if (l_Size >= Ord(Low(PrintAndExportFontSizeEnum))) AND
     (l_Size <= Ord(High(PrintAndExportFontSizeEnum))) then
   Result := cSizes[PrintAndExportFontSizeEnum(l_Size)]
  else
   Result := 12;
 end;//PrintAndExportDefaultSetting
//#UC END# *52387143039D_522ED9B4018B_impl*
end;//SHevStyles.PrintAndExportFontSize

class function SHevStyles.PrintAndExportDefaultSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
//#UC START# *B4F9EAF1647A_522ED9B4018B_var*
//#UC END# *B4F9EAF1647A_522ED9B4018B_var*
begin
//#UC START# *B4F9EAF1647A_522ED9B4018B_impl*
 !!! Needs to be implemented !!!
//#UC END# *B4F9EAF1647A_522ED9B4018B_impl*
end;//SHevStyles.PrintAndExportDefaultSetting

class function SHevStyles.PrintAndExportCustomSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
//#UC START# *C4840679B5EF_522ED9B4018B_var*
//#UC END# *C4840679B5EF_522ED9B4018B_var*
begin
//#UC START# *C4840679B5EF_522ED9B4018B_impl*
 !!! Needs to be implemented !!!
//#UC END# *C4840679B5EF_522ED9B4018B_impl*
end;//SHevStyles.PrintAndExportCustomSetting

class function SHevStyles.PrintAndExportFontSizeSetting: Integer;
 {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
//#UC START# *71C286195AC6_522ED9B4018B_var*
//#UC END# *71C286195AC6_522ED9B4018B_var*
begin
//#UC START# *71C286195AC6_522ED9B4018B_impl*
 !!! Needs to be implemented !!!
//#UC END# *71C286195AC6_522ED9B4018B_impl*
end;//SHevStyles.PrintAndExportFontSizeSetting

class procedure SHevStyles.WritePrintAndExportFontSizeSetting(aValue: Integer);
 {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
//#UC START# *FF5063A3A440_522ED9B4018B_var*
//#UC END# *FF5063A3A440_522ED9B4018B_var*
begin
//#UC START# *FF5063A3A440_522ED9B4018B_impl*
 !!! Needs to be implemented !!!
//#UC END# *FF5063A3A440_522ED9B4018B_impl*
end;//SHevStyles.WritePrintAndExportFontSizeSetting

end.
