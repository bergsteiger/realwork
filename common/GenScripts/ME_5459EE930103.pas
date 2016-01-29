unit l3WideStringManager;

interface

uses
 l3IntfUses
 , l3SizedPoolManager
 , l3Interfaces
;

type
 Tl3WideStringManager = class(Tl3SizedPoolManager)
  {* ћенеджер Unicode-строк }
  procedure Create(aBlockSize: Integer);
  function AllocString(const aString: WideString): PWideChar;
   {* распредел€ет строку }
  procedure FreeString(var theString: PWideChar);
   {* освобождает строку }
  function StringAsPCharLen(aString: PWideChar): Tl3WString;
   {* приводит строку к Tl3PChatLen }
  function StringAsWideString(aString: PWideChar): WideString;
   {* приводит строку к WideString }
 end;//Tl3WideStringManager
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
