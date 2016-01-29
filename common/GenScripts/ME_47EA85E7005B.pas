unit afwSettingChanged.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _afwSettingChanged_ = class(IafwSettingListener, Ml3Unknown)
  {* �������, ����������� IafwSettingListener. }
  function DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
   {* ���������� ��������� ��������� ��������� }
  function SettingChanged(const aSettingId: TafwSettingId): Boolean;
   {* ��������� ����������. }
 end;//_afwSettingChanged_
 
implementation

uses
 l3ImplUses
 , afwFacade
 , afwSettingsChangePublisher
;

end.
