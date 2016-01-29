unit evdConst;

interface

uses
 l3IntfUses
;

type
 TevTypeID = (
  {* Тип данных тега. }
  ev_idChild
  , ev_idAtom
  , ev_idLong
  , ev_idString32
  , ev_idComponent
  , ev_idSInt8
  , ev_idUInt8
  , ev_idSInt16
  , ev_idUInt16
  , ev_idSInt32
  , ev_idUInt32
  , ev_idSInt64
  , ev_idUInt64
  , ev_idString8
  , ev_idString16
  , ev_idStream
  , ev_idTransparent
  , ev_idCodePage
  , ev_idFontName
  , ev_idFontID
  , ev_idShortCodePage
 );//TevTypeID
 
implementation

uses
 l3ImplUses
;

end.
