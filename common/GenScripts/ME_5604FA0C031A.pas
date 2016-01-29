unit ddHexCharReader;

interface

uses
 l3IntfUses
 , l3CharSkipper
;

type
 TddHexCharReader = class(Tl3CharSkipper)
  {* Читает только шестнадцатиричные символы из потока. Если они представлены в верхнем регистре - переводит в нижний. Всякий мусор пропускает. }
 end;//TddHexCharReader
 
implementation

uses
 l3ImplUses
;

end.
