unit tfwDictionaryExPrim;

interface

uses
 l3IntfUses
 , tfwDictionary
;

type
 TtfwDictionaryExPrim = class(TtfwDictionary)
  function UsesDictionary(anOther: TtfwDictionaryExPrim): Boolean;
  function IsValidCode: Boolean;
 end;//TtfwDictionaryExPrim
 
implementation

uses
 l3ImplUses
;

end.
