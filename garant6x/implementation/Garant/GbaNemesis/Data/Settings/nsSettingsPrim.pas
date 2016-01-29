unit nsSettingsPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Settings/nsSettingsPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::Settings::TnsSettingsPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  SettingsUnit,
  afwInterfaces,
  l3ProtoObject,
  IOUnit,
  l3Interfaces
  ;

type
 _SettingsClass_ = IBaseSettingsManager;
 _nsSettings_Parent_ = Tl3ProtoObject;
 {$Include ..\Settings\nsSettings.imp.pas}
 TnsSettingsPrim = class(_nsSettings_, IafwSettingsPrim)
 public
 // public methods
   class function Make(const aSettings: IBaseSettingsManager): IafwSettingsPrim; reintroduce;
 end;//TnsSettingsPrim

implementation

uses
  nsTypes,
  SysUtils,
  l3String,
  l3VCLStrings,
  l3Base
  ;

{$Include ..\Settings\nsSettings.imp.pas}

// start class TnsSettingsPrim

class function TnsSettingsPrim.Make(const aSettings: IBaseSettingsManager): IafwSettingsPrim;
var
 l_Inst : TnsSettingsPrim;
begin
 l_Inst := Create(aSettings);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

end.