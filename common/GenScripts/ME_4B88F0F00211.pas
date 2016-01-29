unit l3FontManagerEx;

interface

uses
 l3IntfUses
 , l3FontManager
;

type
 Tl3FontManagerEx = class(Tl3FontManager)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3FontManagerEx
 
implementation

uses
 l3ImplUses
;

end.
