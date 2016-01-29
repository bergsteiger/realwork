unit l3InterfacedDataObject.imp;

interface

uses
 l3IntfUses
 , l3DataObject
 , l3Interfaces
 , l3IID
;

type
 // _DataType_
 
 _l3InterfacedDataObject_ = class(Tl3DataObject)
  {* Для хранения в буфере обмена интерфейса }
  procedure Create(const aData: _DataType_;
   const aFormats: Tl3ClipboardFormats);
  function Make(const aData: _DataType_;
   const aFormats: Tl3ClipboardFormats): IDataObject;
 end;//_l3InterfacedDataObject_
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
