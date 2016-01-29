unit evNodeStorable;

interface

uses
 l3IntfUses
 , evStringStorable
 , nevBase
 , evdInterfaces
 , nevTools
 , l3Interfaces
;

type
 TevNodeStorable = class(TevStringStorable)
  procedure Create(const aData: InevSimpleNode;
   const aReader: InevTagReader);
  function Make(const aData: InevSimpleNode;
   const aReader: InevTagReader): IevdDataObject;
  function Text: Tl3WString;
 end;//TevNodeStorable
 
implementation

uses
 l3ImplUses
;

end.
