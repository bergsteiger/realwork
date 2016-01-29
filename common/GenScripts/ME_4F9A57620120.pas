unit nsUnknownComponent.imp;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , afwInterfaces
;

type
 _nsUnknownComponent_ = class(IvcmSettingsSource, Ml3Unknown)
  {* Базовые интерфейсы и методы, которыми обладает каждый компонент проекта Немезис. }
  function CheckSettings: Boolean;
  procedure LoadSettings;
  procedure SaveSettings;
  procedure CheckLoadSettings;
  procedure CheckSaveSettings;
  function Settings: IafwSettings;
   {* интерфейс настроек передаваемый объекту. }
  function BaseId: AnsiString;
   {* базовый идентификатор настройки. Используется как первая часть пути для идентификаторов настроек. }
 end;//_nsUnknownComponent_
 
implementation

uses
 l3ImplUses
;

end.
