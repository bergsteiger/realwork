unit afwNavigation;

interface

uses
 l3IntfUses
 , evdInterfaces
 , afwInterfaces
;

type
 IevMoniker = interface
  {* Базовый интерфейс для указателей на различные объекты. }
 end;//IevMoniker
 
 IevURLMoniker = interface(IevMoniker)
  {* Интерфейс для объектов указывающих на URL }
 end;//IevURLMoniker
 
 IevIDMoniker = interface(IevMoniker)
  {* Адрес объекта, имеющего целочисленный идентификатор }
 end;//IevIDMoniker
 
 IevHyperlinkMoniker = interface(IevIDMoniker)
  {* Объект, указывающий на гипертекстовую ссылку }
 end;//IevHyperlinkMoniker
 
 TafwAddress = TevdAddress;
 
 TevAddress = object(TafwAddress)
 end;//TevAddress
 
 IevMonikerSink = interface
  {* Интерфейс для реализации перехода по адресу. }
  function JumpTo(anEffects: TafwJumpToEffects;
   const aMoniker: IevMoniker): Boolean;
   {* перейти по адресу aMoniker. }
 end;//IevMonikerSink
 
 IevAddressMoniker = interface(IevMoniker)
  {* Адрес точки входа }
 end;//IevAddressMoniker
 
implementation

uses
 l3ImplUses
;

end.
