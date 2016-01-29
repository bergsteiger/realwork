unit ChromeLikeTabSetStyles;

interface

uses
 l3IntfUses
;

type
 TChromeLikeTabSetStyles = class
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TChromeLikeTabSetStyles
 
implementation

uses
 l3ImplUses
 , GDIPUTIL
 , GDIPAPI
 , GDIPOBJ
;

end.
