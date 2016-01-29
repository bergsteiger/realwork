unit evReqIterator;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , evQueryCardInt
 , evQueryCardEditor
;

type
 TevReqIterator = class(Tl3CProtoObject, IevReqIterator)
  procedure Create(const aModel: IevQueryCard); overload;
  function Make(const aModel: IevQueryCard): IevReqIterator; overload;
  procedure Create(anEditor: TevQueryCardEditor); overload;
  function Make(anEditor: TevQueryCardEditor): IevReqIterator; overload;
 end;//TevReqIterator
 
implementation

uses
 l3ImplUses
 , nevTools
;

end.
