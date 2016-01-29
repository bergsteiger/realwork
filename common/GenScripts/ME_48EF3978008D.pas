unit evDataObject;

interface

uses
 l3IntfUses
 , l3StorableDataObject
 , evdInterfaces
 , nevBase
 , l3Interfaces
 , l3IID
;

type
 TevDataObject = class(Tl3StorableDataObject)
  {* ���������� ���������� IDataObject ��� ��������� ������ ��������� }
  procedure Create(const aBlock: IevdDataObject;
   const aFormats: Tl3ClipboardFormats;
   const aFilters: InevTagGenerator);
  function Store(aFormat: Tl3ClipboardFormat;
   const aPool: IStream): Boolean;
 end;//TevDataObject
 
implementation

uses
 l3ImplUses
;

end.
