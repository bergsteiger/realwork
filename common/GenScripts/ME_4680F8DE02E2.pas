unit l3TreeDataObject.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 _l3TreeDataObject_ = class(_l3InterfacedDataObject_)
  {* Объект данных дерева }
  function GetFormats: Tl3ClipboardFormats;
  procedure Create(const aData: _DataType_);
 end;//_l3TreeDataObject_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3TreeInterfaces
 , SysUtils
 , l3TreeConst
 , Windows
;

end.
