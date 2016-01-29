unit ToolsAPI;

interface

uses
 l3IntfUses
;

type
 IOTAModule40 = interface
 end;//IOTAModule40
 
 IOTAModule50 = interface(IOTAModule40)
 end;//IOTAModule50
 
 IOTAModule = interface(IOTAModule50)
 end;//IOTAModule
 
 IOTANotifier = interface
 end;//IOTANotifier
 
 IOTAModuleNotifier = interface(IOTANotifier)
 end;//IOTAModuleNotifier
 
 IOTAEditor = interface
 end;//IOTAEditor
 
 IOTASourceEditor = interface(IOTAEditor)
 end;//IOTASourceEditor
 
implementation

uses
 l3ImplUses
 , DesignIntf
;

end.
