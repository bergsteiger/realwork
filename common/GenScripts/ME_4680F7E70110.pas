unit l3StorableDataObject;

interface

uses
 l3IntfUses
 , l3DataObject
 , l3Interfaces
 , Classes
;

type
 Tl3StorableDataObject = class(Tl3DataObject)
  {* Класс для реализации интерфейса IDataObject для выделения текста редактора. }
  function Store(aFormat: Tl3ClipboardFormat;
   aPool: TStream): Boolean; overload;
  function Store(aFormat: Tl3ClipboardFormat;
   const aPool: IStream): Boolean; overload;
 end;//Tl3StorableDataObject
 
implementation

uses
 l3ImplUses
 , l3Stream
 , l3Memory
 , l3Base
 , l3Chars
;

end.
