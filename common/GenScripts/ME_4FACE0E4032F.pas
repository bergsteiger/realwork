unit ddDocumentAtom;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddCustomDestination
 , k2Interfaces
;

type
 TddDocumentAtom = class(Tl3ProtoDataContainer)
  procedure Clear;
  procedure DoClose;
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aNeedProcessRow: Boolean;
   LiteVersion: Boolean);
  function JoinWith(P: TObject;
   aCorrectSegment: Boolean): Integer;
  function HasSoftEnter: Boolean;
  function IsTable: Boolean;
  function IsTextPara: Boolean;
  function IsPicture: Boolean;
  function IsBreak: Boolean;
  function IsRow: Boolean;
  function GetLastPara: TddDocumentAtom;
  function CanWrite: Boolean;
   {* Проверяет возможность записи объекта. Например, если у картинки нет размеров ширины и высоты, то она не записывается. }
  procedure Create(aDetination: TddCustomDestination);
 end;//TddDocumentAtom
 
implementation

uses
 l3ImplUses
 , ddTypes
;

end.
