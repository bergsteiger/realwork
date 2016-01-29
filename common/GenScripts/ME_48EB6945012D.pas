unit evReaderDataObject;

interface

uses
 l3IntfUses
 , evStreamedDataObject
 , l3Interfaces
 , nevTools
 , nevBase
 , evdInterfaces
 , k2CustomFileReader
;

type
 Rk2CustomReader = class of Tk2CustomFileReader;
 
 TevReaderDataObject = class(TevStreamedDataObject)
  procedure Create(const aStream: IStream);
  function Make(const aStream: IStream): InevStorable;
  function ReaderClass: Rk2CustomReader;
  procedure DoStore(const G: InevTagGenerator;
   aFlags: TevdStoreFlags);
   {* сохраняет поток в G }
 end;//TevReaderDataObject
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3SysUtils
 , l3Types
;

end.
