unit evTreeData.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3InternalInterfaces
 , l3IID
;

type
 // _DataClass_
 
 RDataClass = class of _DataClass_;
 
 _evTreeData_ = class(_ddTreeDataObject_)
  procedure Create(const aData: _DataType_;
   const aBitmap: Il3Bitmap);
  function Make(const aData: _DataType_;
   const aBitmap: Il3Bitmap): IDataObject;
  function ExtData: IDataObject;
  function MakeExtData: IDataObject;
  function ExtDataClass: RDataClass;
 end;//_evTreeData_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3InterfacesMisc
 , k2Tags
 , ddRTFWriter
 , l3Filer
 , l3TreeInterfaces
 , Windows
 , l3String
 , l3Types
 , Document_Const
 , TextPara_Const
 , l3TreeConst
;

end.
