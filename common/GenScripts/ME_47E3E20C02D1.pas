unit evSavedCursor;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
;

type
 TevSavedCursor = class(Tl3ProtoObject)
  {* Объект для сохранения курсора. }
  procedure Create(const aCursor: InevBasePoint;
   const aOld: IevSavedCursor;
   const aNew: IevSavedCursor);
 end;//TevSavedCursor
 
 PevSavedCursor = ^TevSavedCursor;
 
implementation

uses
 l3ImplUses
;

end.
