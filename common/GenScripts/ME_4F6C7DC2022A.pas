unit afwSettingsImplSing;

interface

uses
 l3IntfUses
 , afwSettingsImplPersistent
;

type
 TafwSettingsImplSing = class(TafwSettingsImplPersistent)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TafwSettingsImplSing
 
implementation

uses
 l3ImplUses
;

end.
