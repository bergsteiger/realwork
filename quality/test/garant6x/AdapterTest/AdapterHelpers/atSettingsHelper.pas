unit atSettingsHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atSettingsHelper.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatSettingsHelper
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  atStringToStringConverterBase,
  atFilterHelper
  ;

type
 TatTreeTagToSettingIDConverter = class(TatStringToStringConverterBase)
  {* ����������� ����� ��������������� ����������� ������ � ��������� ��������� � ������� ��������� ��������� ������������ ������� ��� ����� ������ (� �������� ��������� ������������/����������� ����������) }
 protected
 // realized methods
   procedure InitConvertMap; override;
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TatTreeTagToSettingIDConverter;
    {- ���������� ��������� ����������. }
 end;//TatTreeTagToSettingIDConverter

 TatSettingsHelper = class
 private
 // private methods
   class function GetContextFilterParamsFromSettings(const aSettingsID: AnsiString;
    out theParams: ContextFilterParams): Boolean;
 public
 // public methods
   class function GetContextFilterParamsByTreeTag(const aTreeTag: AnsiString;
    out theParams: ContextFilterParams): Boolean;
 end;//TatSettingsHelper

implementation

uses
  l3Base {a},
  atTreeLevelConverter,
  atWordOrderConverter,
  atWordPositionConverter,
  atGblAdapterWorker,
  atLogger,
  DynamicTreeUnit
  ;


// start class TatTreeTagToSettingIDConverter

var g_TatTreeTagToSettingIDConverter : TatTreeTagToSettingIDConverter = nil;

procedure TatTreeTagToSettingIDConverterFree;
begin
 l3Free(g_TatTreeTagToSettingIDConverter);
end;

class function TatTreeTagToSettingIDConverter.Instance: TatTreeTagToSettingIDConverter;
begin
 if (g_TatTreeTagToSettingIDConverter = nil) then
 begin
  l3System.AddExitProc(TatTreeTagToSettingIDConverterFree);
  g_TatTreeTagToSettingIDConverter := Create;
 end;
 Result := g_TatTreeTagToSettingIDConverter;
end;


class function TatTreeTagToSettingIDConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatTreeTagToSettingIDConverter <> nil;
end;//TatTreeTagToSettingIDConverter.Exists

procedure TatTreeTagToSettingIDConverter.InitConvertMap;
//#UC START# *503E3A040395_503F83120326_var*
  const
    CONVERT_MAP : array [0..20] of atStringToStringConverterBase.Synonyms = (
      (First : AT_KW; Second : AT_KW), // ����� �� ��������, gi_cpKeywordSerch
      (First : AT_PUBLISH_SOURCE; Second : AT_PUBLISH_SOURCE), // ����� �� ��������� �������������, gi_cpPublishSource
      (First : 'ExplanatoryDiction'; Second : 'stcpDiction'), // �������� �������, c_Diction_NodeClass, gi_cpDiction
      (First : 'MainMenu'; Second : 'stidNavigator'), // �������� ���������, c_MainMenu_NodeClass, gi_cpNavigator
      (First : AT_TYPE; Second : AT_TYPE), //���, gi_cpType
      (First : AT_CLASS; Second : AT_CLASS), // ������/����
      (First : AT_SOURCE; Second : AT_SOURCE), // �����/��������
      (First : AT_REG_NUM; Second : AT_REG_NUM), // ����� ���������, gi_cpRegNumber
      (First : AT_REG_IN_MU_NUM; Second : AT_REG_IN_MU_NUM), // ��������������� ����� � �������, gi_cpMURegNumber
      (First : AT_REG_IN_MU; Second : AT_REG_IN_MU), // ������ �����������, gi_cpMURegStatus
      (First : AT_STATUS; Second : AT_STATUS), // ������, gi_cpStatus
      (First : AT_NORM; Second : AT_NORM), // ����������, gi_cpNorm
      (First : AT_PREFIX; Second : AT_PREFIX), // ��� �������� ����������
      (First : AT_TERRITORY; Second : AT_TERRITORY), // ���������� �������������, gi_cpTerritory
      (First : AT_BASES; Second : AT_BASES), // �������������� ����, gi_cpBases
//      (First : ; Second : 'stcpContents'), // ��������� ���������, gi_cpContents
//      (First : ; Second : 'stcpUserList'), // ������ �������������, gi_cpUserList
//      (First : ; Second : 'stcpDayTips'), // ����� ���, gi_cpDayTips
//      (First : ; Second : 'stcpDrugContents'), // ��������� ���������, gi_cpDrugContents
      (First : 'MedExplanatoryDiction'; Second : 'stcpMedicDiction'), // ������� ����������� ��������, c_MedDiction_NodeClass, gi_cpMedicDiction
      (First : AT_PHARM_FIRM; Second : 'stcpMedicFirms'), // ? ���������������� �����, gi_cpMedicFirms
//      (First : ; Second : 'stcpDrugList'), // ? ������ ����������, gi_cpDrugList
      (First : AT_PHARM_GROUP; Second : 'stcpGroupList'), // ? ������ �����, gi_cpGroupList
      (First : AT_PREFIX_REVIEW; Second : AT_PREFIX_REVIEW), // ��� �������� ���������� � ���
      (First : AT_CLASS_REVIEW; Second : AT_CLASS_REVIEW), // ������/���� � ���
      (First : AT_SOURCE_REVIEW; Second : AT_SOURCE_REVIEW) // �����/�������� � ���
    );
//#UC END# *503E3A040395_503F83120326_var*
begin
//#UC START# *503E3A040395_503F83120326_impl*
  InitConvertMap(CONVERT_MAP);
//#UC END# *503E3A040395_503F83120326_impl*
end;//TatTreeTagToSettingIDConverter.InitConvertMap

class function TatSettingsHelper.GetContextFilterParamsFromSettings(const aSettingsID: AnsiString;
  out theParams: ContextFilterParams): Boolean;
//#UC START# *503F849A033F_503F81C30303_var*
  var
    l_IDs : array [0..2] of String;
    i, l_SettingVal : Integer;
//#UC END# *503F849A033F_503F81C30303_var*
begin
//#UC START# *503F849A033F_503F81C30303_impl*
  Result := false;
  //
  l_IDs[0] := aSettingsID + '/stWordPosition';
  l_IDs[1] := aSettingsID + '/stWordOrder';
  l_IDs[2] := aSettingsID + '/stTreeLevelDist';
  // �������� ��������� ��������
  for i := 0 to 2 do
    if TatGblAdapterWorker.Instance.SettingsManager.GetLong(PAnsiChar(l_IDs[i]), l_SettingVal) then
      case i of
        0 : theParams.ContextPlace := TatWordPositionConverter.Instance.FirstToSecond(l_SettingVal);
        1 : theParams.FindOrder := TatWordOrderConverter.Instance.FirstToSecond(l_SettingVal);
        2 : theParams.SearchArea := TatTreeLevelConverter.Instance.FirstToSecond(l_SettingVal);
      end
    else
    begin
      Logger.Error('�� ������� ��������� %s', [l_IDs[i]]);
      Exit;
    end;
  //  
  Result := true;;
//#UC END# *503F849A033F_503F81C30303_impl*
end;//TatSettingsHelper.GetContextFilterParamsFromSettings

class function TatSettingsHelper.GetContextFilterParamsByTreeTag(const aTreeTag: AnsiString;
  out theParams: ContextFilterParams): Boolean;
//#UC START# *503F85DF00DA_503F81C30303_var*
  var
    l_SettingID : String;
//#UC END# *503F85DF00DA_503F81C30303_var*
begin
//#UC START# *503F85DF00DA_503F81C30303_impl*
  Result := false;
  try
    l_SettingID := TatTreeTagToSettingIDConverter.Instance.FirstToSecondCI(aTreeTag);
  except
    on EConvertError do ; // ��� ����� ��������
  end;

  if l_SettingID <> '' then
    Result := GetContextFilterParamsFromSettings(l_SettingID, theParams);
//#UC END# *503F85DF00DA_503F81C30303_impl*
end;//TatSettingsHelper.GetContextFilterParamsByTreeTag

end.