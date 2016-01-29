unit l3AsincMessageWindow;

interface

uses
 l3IntfUses
 , Classes
;

type
 Tl3AsincMessageWindow = class(TThread)
  procedure Execute;
 end;//Tl3AsincMessageWindow
 
implementation

uses
 l3ImplUses
 , l3AsincMessageWindowRes
;

end.
