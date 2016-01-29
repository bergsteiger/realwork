unit eeEditor;

interface

uses
 l3IntfUses
 , eeEditorExport
 , eeInterfaces
 , Classes
;

type
 TeeCustomEditor = class(TeeEditorExport)
 end;//TeeCustomEditor
 
 TeeEditor = class(TeeCustomEditor)
 end;//TeeEditor
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
