unit nevActiveHyperlink;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevTools
 , l3Variant
;

type
 TnevActiveHyperlink = class(Tl3CProtoObject, InevActiveHyperlink)
  {* Активная гиперссылка }
  procedure Create(const aPara: InevPara;
   aHyperlink: Tl3Variant);
  function Make(const aPara: InevPara;
   aHyperlink: Tl3Variant): InevActiveHyperlink;
  function IsSame(const anElement: InevActiveElement): Boolean;
  function Hyperlink: Tl3Tag;
  function Para: InevPara;
  procedure Invalidate;
   {* Перерисовывает область активного элемента }
 end;//TnevActiveHyperlink
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
;

type
 InevActiveHyperlink = interface(InevActiveElement)
 end;//InevActiveHyperlink
 
end.
