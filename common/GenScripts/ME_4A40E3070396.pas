unit evControlsBlockCursor;

interface

uses
 l3IntfUses
 , evDocumentPartCursor
 , evQueryCardInt
 , nevTools
 , l3Core
;

type
 TevControlsBlockCursor = class(TevDocumentPartCursor)
  function GetControl: IevQueryGroup;
   {* Получить контрол по ссылке }
 end;//TevControlsBlockCursor
 
implementation

uses
 l3ImplUses
 , OvcCmd
 , OvcConst
 , k2Tags
 , Windows
;

end.
