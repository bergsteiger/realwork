unit evConstStringStorable;

interface

uses
 l3IntfUses
 , evStringStorable
 , evdInterfaces
 , nevTools
 , l3Interfaces
 , afwNavigation
;

type
 TevConstStringStorable = class(TevStringStorable)
  procedure Create(const aData: IevdHyperlinkInfo;
   const aReader: InevTagReader);
  function Make(const aData: IevdHyperlinkInfo;
   const aReader: InevTagReader): IevdDataObject;
  function Text: Tl3WString;
 end;//TevConstStringStorable
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3String
;

end.
