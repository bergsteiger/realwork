unit evDataObjectFromStorable.imp;

interface

uses
 l3IntfUses
 , evPersistentDataObjectEx
 , l3Interfaces
;

type
 // _StorableClass_
 
 RStorable = class of _StorableClass_;
 
 _evDataObjectFromStorable_ = class(TevPersistentDataObjectEx)
  procedure Create(const aData: _DataType_);
  function Make(const aData: _DataType_): IDataObject;
  function DataClass: RStorable;
 end;//_evDataObjectFromStorable_
 
implementation

uses
 l3ImplUses
 , evFormats
 , evTypes
 , nevTools
 , l3Base
;

end.
