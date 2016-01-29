unit l3Filer;

interface

uses
 l3IntfUses
 , l3ProgressComponent
;

type
 Tl3CustomFiler = class(Tl3ProgressComponent)
  {* Реализация компонента-обертки вокруг потока. }
  function DoOpen: Boolean;
  procedure DoClose;
 end;//Tl3CustomFiler
 
 Tl3CustomDosFiler = class(Tl3CustomFiler)
 end;//Tl3CustomDosFiler
 
 Tl3NextTokenFlag = (
 );//Tl3NextTokenFlag
 
 Tl3DOSFiler = class(Tl3CustomDosFiler)
 end;//Tl3DOSFiler
 
implementation

uses
 l3ImplUses
 , l3FilerRes
;

end.
