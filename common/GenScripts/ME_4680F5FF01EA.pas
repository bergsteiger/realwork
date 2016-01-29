unit l3DataObjectEnum;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , l3DataObject
 , Windows
 , ActiveX
;

type
 Tl3DataObjectEnum = class(Tl3ProtoObject, IEnumFormatEtc)
  {* Реализация итератора для данных Tl3DataObject. }
  function Make(aDataObject: Tl3DataObject): IEnumFormatEtc;
  procedure Create(aDataObject: Tl3DataObject);
  function Next(celt: Integer;
   out elt;
   pceltFetched: PLongint): HResult; stdcall;
  function Skip(celt: Integer): HResult; stdcall;
  function Reset: HResult; stdcall;
  function Clone(out Enum: IEnumFORMATETC): HResult; stdcall;
 end;//Tl3DataObjectEnum
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , SysUtils
;

end.
