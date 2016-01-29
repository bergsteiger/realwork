unit k2DictionaryEx;

interface

uses
 l3IntfUses
 , k2Dictionary
 , k2Base
 , l3Variant
;

type
 TLastRec = record
  {* Предыдущий элемент, к которому обращались }
 end;//TLastRec
 
 Tk2DictionaryEx = class(Tk2Dictionary)
  procedure Create(aType: Tk2Type);
 end;//Tk2DictionaryEx
 
implementation

uses
 l3ImplUses
 , k2Tags
;

end.
