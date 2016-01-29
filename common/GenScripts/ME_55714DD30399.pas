unit vcmStringIDExHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3StringIDEx
 , l3Interfaces
;

type
 TvcmStringIDExHelper = class(Tl3ProtoObject, Il3StringIDExHelper)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure Init(var theStr: Tl3StringIDEx);
  function AsCStr(const aStr: Tl3StringIDEx): Il3CString;
  function AsStr(const aStr: Tl3StringIDEx): AnsiString;
 end;//TvcmStringIDExHelper
 
implementation

uses
 l3ImplUses
 , vcmBase
 , l3Base
;

end.
