unit evStyles_SH;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evStyles_SH.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SettingsHolder::Class>> Shared Delphi::Everest::StyleTable::evStyles
//
// �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  afwInterfaces,
  l3ProtoObject,
  evInterface
  ;

type
 SHevStyles = class(TevInterface)
  {* ����� }
 public
 // public methods
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
  Classes
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  ,
  evStylesPrintAndExportSettingRes,
  afwFacade,
  evStylesPrintAndExportFontSizeSettingRes,
  l3Base {a},
  SysUtils,
  afwSettingsChangePublisher
  ;

type
  _afwSettingChanged_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}
  TevStylesSettingsListener = class(_afwSettingChanged_)
   {* ��������� evStyles, ������� ������������� � ���������� }
  private
  // private methods
   function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
     {* ����� ��� �������� ���� �����, ��� TevStylesSettingsListener �������� ��������� ��������� ��������� }
  protected
  // overridden protected methods
   function DoSettingChanged(const aSettingId: TafwSettingId): Boolean; override;
     {* ���������� ��������� ��������� ��������� }
  public
  // public methods
   class procedure CheckSubscribe;
     {* ����� ��� �������� ���� �����, ��� TevStylesSettingsListener �������� �� ��������� ����������� �������� }
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
  public
  // singleton factory method
    class function Instance: TevStylesSettingsListener;
     {- ���������� ��������� ����������. }
  end;//TevStylesSettingsListener


// start class TevStylesSettingsListener

var g_TevStylesSettingsListener : TevStylesSettingsListener = nil;

procedure TevStylesSettingsListenerFree;
begin
 l3Free(g_TevStylesSettingsListener);
end;

class function TevStylesSettingsListener.Instance: TevStylesSettingsListener;
begin
 if (g_TevStylesSettingsListener = nil) then
 begin
  l3System.AddExitProc(TevStylesSettingsListenerFree);
  g_TevStylesSettingsListener := Create;
 end;
 Result := g_TevStylesSettingsListener;
end;


{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}

// start class TevStylesSettingsListener

class procedure TevStylesSettingsListener.CheckSubscribe;
 {-}
begin
 if (g_TevStylesSettingsListener = nil) then
  if (afw.Application <> nil) then
   if (afw.Application.Settings <> nil) then
    TevStylesSettingsListener.Instance;
end;//TevStylesSettingsListener.CheckSubscribe

function TevStylesSettingsListener.IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
 {-}
begin
 Result := ANSISameText(aSettingId, pi_evStyles_PrintAndExport_Default) OR
  ANSISameText(aSettingId, pi_evStyles_PrintAndExport_Custom) OR
  ANSISameText(aSettingId, pi_evStyles_PrintAndExportFontSize);
end;//TevStylesSettingsListener.IsSettingAffectsUs

class function TevStylesSettingsListener.Exists: Boolean;
 {-}
begin
 Result := g_TevStylesSettingsListener <> nil;
end;//TevStylesSettingsListener.Exists

function TevStylesSettingsListener.DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
//#UC START# *47EA863A035C_5EDF2B8ACE76_var*
//#UC END# *47EA863A035C_5EDF2B8ACE76_var*
begin
 Result := inherited DoSettingChanged(aSettingId);
 if IsSettingAffectsUs(aSettingId) then
 begin
  Result := true;
  //#UC START# *522ED9B4018BSettingChanged*
  {$IfNDef DesignTimeLibrary}
  EvNotifyStyleTableChanging;
  EvNotifyStyleTableChanged;
  {$EndIf  DesignTimeLibrary}
  //#UC END# *522ED9B4018BSettingChanged*
 end;//IsSettingAffectsUs(aSettingId)
end;//TevStylesSettingsListener.DoSettingChanged

class function SHevStyles.PrintAndExportFontSize: Integer;
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
 {-}
begin
 if (afw.Settings = nil) then
  Result := true
 else
  Result := afw.Settings.LoadBoolean(pi_evStyles_PrintAndExport_Default, true);
end;//SHevStyles.PrintAndExportDefaultSetting

class function SHevStyles.PrintAndExportCustomSetting: Boolean;
 {-}
begin
 if (afw.Settings = nil) then
  Result := false
 else
  Result := afw.Settings.LoadBoolean(pi_evStyles_PrintAndExport_Custom, false);
end;//SHevStyles.PrintAndExportCustomSetting

class function SHevStyles.PrintAndExportFontSizeSetting: Integer;
 {-}
begin
 if (afw.Settings = nil) then
  Result := dv_evStyles_PrintAndExportFontSize
 else
  Result := afw.Settings.LoadInteger(pi_evStyles_PrintAndExportFontSize, dv_evStyles_PrintAndExportFontSize);
end;//SHevStyles.PrintAndExportFontSizeSetting

class procedure SHevStyles.WritePrintAndExportFontSizeSetting(aValue: Integer);
 {-}
begin
 if (afw.Settings <> nil) then
  afw.Settings.SaveInteger(pi_evStyles_PrintAndExportFontSize, aValue);
end;//SHevStyles.WritePrintAndExportFontSizeSetting

end.