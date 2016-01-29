unit evdNativeReader;

interface

uses
 l3IntfUses
 , k2CustomFileParser
;

type
 TevdNativeReader = class(Tk2CustomFileParser)
  {* Читатель тегов в формате evd. }
 end;//TevdNativeReader
 
implementation

uses
 l3ImplUses
 , evdNativeReaderServices
;

end.
