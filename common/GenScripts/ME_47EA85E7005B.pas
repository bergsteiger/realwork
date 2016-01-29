unit afwSettingChanged.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _afwSettingChanged_ = class(IafwSettingListener, Ml3Unknown)
  {* Примесь, реализующая IafwSettingListener. }
  function DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
   {* Обработчик изменения указанной настройки }
  function SettingChanged(const aSettingId: TafwSettingId): Boolean;
   {* настройки изменились. }
 end;//_afwSettingChanged_
 
implementation

uses
 l3ImplUses
 , afwFacade
 , afwSettingsChangePublisher
;

end.
