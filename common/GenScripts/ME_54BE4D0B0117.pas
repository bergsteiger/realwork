unit eePara;

interface

uses
 l3IntfUses
 , eeTagEditorTool
 , eeInterfaces
 , k2Base
 , l3Variant
 , l3Interfaces
;

type
 TeePara = class(TeeTagEditorTool, IeePara)
  function Document: IeeDocument;
  function Parent: IeePara;
  function Block: IeeBlock;
  function Subs: IeeSubList;
  function Markers: IeeSubList;
  function Bookmarks: IeeSubList;
  function Marks: IeeSubList;
  function ID: Integer;
  function IndexInParent: Integer;
  function Prev: IeePara;
  function Next: IeePara;
  function IsKindOf(aType: Tk2Type): Boolean;
  function IsSame(const aPara: IeePara): Boolean;
  function Delete: Boolean;
  function IsUserComment: Boolean;
  function AsObject: Tl3Variant;
 end;//TeePara
 
 TeeLeafPara = class(TeePara, IeeLeafPara)
 end;//TeeLeafPara
 
 TeeStyledLeafPara = class(TeeLeafPara, IeeStyledLeafPara)
  function IsComment: Boolean; overload;
  function IsComment(aType: TeeCommentType): Boolean; overload;
 end;//TeeStyledLeafPara
 
 TeeTextPara = class(TeeStyledLeafPara, IeeTextPara)
  function Text: Il3CString;
 end;//TeeTextPara
 
 TeeParaList = class(TeePara)
 end;//TeeParaList
 
 TeeSBS = class(TeeParaList)
 end;//TeeSBS
 
implementation

uses
 l3ImplUses
 , eeSubList
;

end.
