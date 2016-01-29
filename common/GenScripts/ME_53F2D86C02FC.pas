unit ChromeLikeTabParams;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3TabbedContainersDispatcher
 , l3Interfaces
;

type
 TChromeLikeTabParams = class(Tl3ProtoObject, Il3TabParams)
  procedure Create(const aText: Il3CString;
   const aHintText: Il3CString;
   aImageIndex: Integer;
   aUpdateOptions: Tl3TabUpdateOptions);
  function Make(const aText: Il3CString;
   const aHintText: Il3CString;
   aImageIndex: Integer;
   aUpdateOptions: Tl3TabUpdateOptions): Il3TabParams;
  function HintText: WideString;
  function Text: WideString;
  function ImageIndex: Integer;
  function UpdateOptions: Tl3TabUpdateOptions;
 end;//TChromeLikeTabParams
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
