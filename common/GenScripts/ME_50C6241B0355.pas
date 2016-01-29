unit vtHintManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ObjectList
 , vtMultilineHint
;

type
 TvtHintManager = class(Tl3ProtoObject)
  procedure Add(aHint: TvtMultilineHint);
  procedure Remove(aHint: TvtMultilineHint);
  function Exists: Boolean;
 end;//TvtHintManager
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , vtHintWordsPack
;

end.
