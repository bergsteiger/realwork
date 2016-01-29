unit nscTreeSource;

{ Библиотека "Nemesis Controls" }
{ Начал: Люлин А.В.             }
{ Модуль: nscTreeSource -       }
{ Начат: 23.12.2004 15:38       }
{ $Id: nscTreeSource.pas,v 1.1 2004/12/23 12:45:47 lulin Exp $ }

// $Log: nscTreeSource.pas,v $
// Revision 1.1  2004/12/23 12:45:47  lulin
// - new unit: nscTreeSource.
//

{$I nscDefine.inc }

interface

uses
  vtTreeSource
  ;

type
  TnscCustomTreeSource = class(TvtCustomTreeSource)
  end;//TnscCustomTreeSource

  TnscTreeSource = class(TnscCustomTreeSource)
  end;//TnscTreeSource

implementation

end.

