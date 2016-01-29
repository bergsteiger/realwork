unit l3IID;

interface

uses
 l3IntfUses
;

type
 Tl3_IID = object
 end;//Tl3_IID
 
 Tl3IID = object(Tl3_IID)
 end;//Tl3IID
 
 Tl3_GUID = object
  {* Объект-обертка вокруг GUID (без методов). }
 end;//Tl3_GUID
 
 Tl3GUID = object(Tl3_GUID)
  {* Объект-обертка вокруг GUID. }
 end;//Tl3GUID
 
 Tl3HResult = object
  {* Результат COM-операции }
 end;//Tl3HResult
 
implementation

uses
 l3ImplUses
;

end.
