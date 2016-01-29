unit vcmMakeParams;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , Classes
;

type
 TvcmMakeParams = class(Tl3ProtoObject, IvcmMakeParams)
  procedure Create(const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer;
   anOwner: TComponent);
  procedure Make(const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer;
   anOwner: TComponent);
  function Owner: TComponent;
  function Aggregate: IvcmAggregate;
   {* Агрегация, к которой относятся параметры }
  function Container: IvcmContainer;
 end;//TvcmMakeParams
 
implementation

uses
 l3ImplUses
;

end.
