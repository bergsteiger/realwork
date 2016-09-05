unit nsSettingsPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\nsSettingsPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSettingsPrim" MUID: (4AD58F5E0242)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
 , SettingsUnit
 , IOUnit
 , l3Interfaces
;

type
 _SettingsClass_ = IBaseSettingsManager;
 _nsSettings_Parent_ = Tl3ProtoObject;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\nsSettings.imp.pas}
 TnsSettingsPrim = class(_nsSettings_, IafwSettingsPrim)
  public
   class function Make(const aSettings: IBaseSettingsManager): IafwSettingsPrim; reintroduce;
 end;//TnsSettingsPrim

implementation

uses
 l3ImplUses
 , nsTypes
 , SysUtils
 , l3String
 , l3VCLStrings
 , l3Base
 //#UC START# *4AD58F5E0242impl_uses*
 //#UC END# *4AD58F5E0242impl_uses*
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\nsSettings.imp.pas}

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
end;//TnsSettingsPrim.Make

end.
