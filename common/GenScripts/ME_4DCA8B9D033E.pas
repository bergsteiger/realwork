unit kwStyleTableSaveToFile;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwStyleTableSaveToFile = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStyleTableSaveToFile
 
implementation

uses
 l3ImplUses
 , evStyleInterfaceEx
 , l3Stream
 , l3Types
 , SysUtils
;

end.
