unit afwSettingsChangePublisherPrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
 , IafwSettingListenerPtrList
 , IafwSettingsReplaceListenerPtrList
;

type
 TafwSettingsChangePublisherPrim = class(Tl3ProtoObject)
  procedure NotifySettingChanged(const aSettingID: TafwSettingId);
  procedure NotifyReplace(aStart: Boolean);
  procedure AddListener(const aListener: IafwSettingListener); overload;
  procedure RemoveListener(const aListener: IafwSettingListener); overload;
  procedure AddListener(const aListener: IafwSettingsReplaceListener); overload;
  procedure RemoveListener(const aListener: IafwSettingsReplaceListener); overload;
 end;//TafwSettingsChangePublisherPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
