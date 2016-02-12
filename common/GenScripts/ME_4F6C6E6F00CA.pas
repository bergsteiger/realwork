unit afwSettingsPrimPrim;

// Модуль: "w:\common\components\gui\Garant\AFW\afwSettingsPrimPrim.pas"
// Стереотип: "SimpleClass"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
 , afwSettingsImplPrimPrim
 , l3Interfaces
;

type
 _SettingsClass_ = IafwSettingsImpl;
 _afwSettingsPrim_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\gui\Garant\AFW\afwSettingsPrim.imp.pas}
 TafwSettingsPrimPrim = {abstract} class(_afwSettingsPrim_, IafwSettingsPrim)
  public
   constructor Create(const aSettingsImpl: IafwSettingsImpl); reintroduce;
   class function Make(const aSettingsImpl: IafwSettingsImpl): IafwSettingsPrim; reintroduce;
 end;//TafwSettingsPrimPrim

implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , afwAString
 , SysUtils
 , l3VCLStrings
;

{$Include w:\common\components\gui\Garant\AFW\afwSettingsPrim.imp.pas}

constructor TafwSettingsPrimPrim.Create(const aSettingsImpl: IafwSettingsImpl);
//#UC START# *4F6C7E6802B0_4F6C6E6F00CA_var*
//#UC END# *4F6C7E6802B0_4F6C6E6F00CA_var*
begin
//#UC START# *4F6C7E6802B0_4F6C6E6F00CA_impl*
 inherited Create(aSettingsImpl);
//#UC END# *4F6C7E6802B0_4F6C6E6F00CA_impl*
end;//TafwSettingsPrimPrim.Create

class function TafwSettingsPrimPrim.Make(const aSettingsImpl: IafwSettingsImpl): IafwSettingsPrim;
var
 l_Inst : TafwSettingsPrimPrim;
begin
 l_Inst := Create(aSettingsImpl);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TafwSettingsPrimPrim.Make

end.
