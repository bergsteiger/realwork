unit nscCustomChatMemoDocumentPartGenerator;

interface

uses
 l3IntfUses
 , evDocumentPartGenerator
 , l3Variant
 , k2DocumentGenerator
 , l3StringIDEx
;

type
 TnscCustomChatMemoDocumentPartGenerator = class(TevDocumentPartGenerator)
 end;//TnscCustomChatMemoDocumentPartGenerator
 
implementation

uses
 l3ImplUses
 , k2Tags
 , Document_Const
 , Para_Const
 , evCursorTools
 , evOp
 , evParaTools
 , TextPara_Const
 , l3Defaults
 , k2Base
 , HyperLink_Const
 , evdTypes
 , LeafPara_Const
 , l3Types
 , SysUtils
 , nevBase
 , l3MessageID
;

end.
