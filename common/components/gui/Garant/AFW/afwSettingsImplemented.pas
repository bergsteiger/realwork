unit afwSettingsImplemented;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Модуль: "w:/common/components/gui/Garant/AFW/afwSettingsImplemented.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::AFW::afwSettings::TafwSettingsImplemented
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\AFW\afwDefine.inc}

interface

uses
  afwInterfaces,
  afwSettings
  ;

type
 TafwSettingsImplemented = class(TafwSettings)
 public
 // public methods
   constructor Create; reintroduce;
   class function Make: IafwSettings; reintroduce;
     {* Сигнатура фабрики TafwSettingsImplemented.Make }
 end;//TafwSettingsImplemented

implementation

uses
  afwSettingsImplSing
  ;

// start class TafwSettingsImplemented

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
end;

end.