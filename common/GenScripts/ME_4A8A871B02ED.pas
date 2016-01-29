unit nscCustomChatMemo;

interface

uses
 l3IntfUses
 , evCustomChatMemo
 , evInternalInterfaces
 , nevTools
 , nevBase
 , l3Variant
 , evCustomMemo
 , evEditorWithOperations
;

type
 TnscCustomChatMemo = class(TevCustomChatMemo, IevF1LikeEditor)
  {* Мемо-поле для чата F1 }
  function ValidateInsertionPoint: Boolean;
   {* Проверить точку вставки на возможность оной, и если невозможно, то сместить курсор }
  function IsParaInF1Doc(aPara: Tl3Variant;
   out theDoc: InevPara): Boolean;
   {* Находится параграф ли в документе, скопированном из F1 }
  function IsInF1Doc(out theDoc: InevPara): Boolean;
   {* Находимся ли в документе, скопированном из F1 }
  function CanInsertParaOnMove: Boolean;
   {* Можно ли вставлять параграфы при движении курсора }
  function IsInReadOnlyPara(const aPara: InevPara;
   NeedDeleteIfReadOnly: Boolean): Boolean;
   {* Находимся ли в параграфе, в котором запрещено редактирование }
 end;//TnscCustomChatMemo
 
implementation

uses
 l3ImplUses
 , nscCustomChatMemoTextSource
 , evMsgCode
 , TtfwClassRef_Proxy
 , evOp
 , TextPara_Const
 , k2Tags
 , Document_Const
 , Para_Const
 , evParaTools
;

end.
