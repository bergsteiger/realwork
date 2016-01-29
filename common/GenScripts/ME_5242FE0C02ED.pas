unit afwSettingsChangePublisher;

interface

uses
 l3IntfUses
 , afwSettingsChangePublisherPrim
;

type
 TafwSettingsChangePublisher = class(TafwSettingsChangePublisherPrim)
  function Exists: Boolean;
 end;//TafwSettingsChangePublisher
 
implementation

uses
 l3ImplUses
;

end.
