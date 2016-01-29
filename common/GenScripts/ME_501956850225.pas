unit kwHardKey;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , Windows
;

type
 TInputKeyRecord = record
 end;//TInputKeyRecord
 
 // TInputKeyRecordArray
 
 TInputArray = array of TInput;
 
 TkwHardKey = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwHardKey
 
implementation

uses
 l3ImplUses
 , Menus
 , SysUtils
 , Consts
 , l3MessagesService
;

end.
