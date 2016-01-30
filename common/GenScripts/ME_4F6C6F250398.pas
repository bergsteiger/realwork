unit afwSettingsImplemented;

// Модуль: "w:\common\components\gui\Garant\AFW\afwSettingsImplemented.pas"
// Стереотип: "SimpleClass"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
 , afwSettings
 , afwInterfaces
;

type
 TafwSettingsImplemented = class(TafwSettings)
  public
   constructor Create; reintroduce;
   class function Make: IafwSettings; reintroduce;
 end;//TafwSettingsImplemented

implementation

uses
 l3ImplUses
 , afwSettingsImplSing
;

constructor TafwSettingsImplemented.Create;
//#UC START# *4F6C8EF600AE_4F6C6F250398_var*
//#UC END# *4F6C8EF600AE_4F6C6F250398_var*
begin
//#UC START# *4F6C8EF600AE_4F6C6F250398_impl*
 inherited Create(TafwSettingsImplSing.Instance);
//#UC END# *4F6C8EF600AE_4F6C6F250398_impl*
end;//TafwSettingsImplemented.Create

class function TafwSettingsImplemented.Make: IafwSettings;
var
 l_Inst : TafwSettingsImplemented;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TafwSettingsImplemented.Make

end.
