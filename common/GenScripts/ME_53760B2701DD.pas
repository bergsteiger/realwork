unit spHelpNotifyManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3SimpleDataContainer
;

type
 IspHelpNotifyListener = interface
  procedure HelpShown;
 end;//IspHelpNotifyListener
 
 TspHelpNotifyListenerList = class(Tl3SimpleDataContainer)
 end;//TspHelpNotifyListenerList
 
 TspHelpNotifyManager = class(Tl3ProtoObject)
  procedure AddListener(const aListener: IspHelpNotifyListener);
  procedure RemoveListener(const aListener: IspHelpNotifyListener);
  procedure HelpShown;
  function Exists: Boolean;
 end;//TspHelpNotifyManager
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
