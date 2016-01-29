unit dt_DictTypes;

interface

uses
 l3IntfUses
;

type
 TDictMessageRec = record
 end;//TDictMessageRec
 
 IDictChangeNotifyRecipient = interface
  procedure dcn__DictionaryChange(const Info: TDictMessageRec);
 end;//IDictChangeNotifyRecipient
 
implementation

uses
 l3ImplUses
;

end.
