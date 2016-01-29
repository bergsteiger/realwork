unit ddTreeDataObject.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3InternalInterfaces
 , l3StringList
;

type
 _ddTreeDataObject_ = class(_l3TreeDataObject_)
  {* Объект данных дерева }
  procedure Create(const aData: _DataType_;
   const aBitmap: Il3Bitmap);
  function Make(const aData: _DataType_;
   const aBitmap: Il3Bitmap): IDataObject;
  function GetCaptions: Tl3WString;
  function CreateFileName: AnsiString;
 end;//_ddTreeDataObject_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , ddRTFWriter
 , l3Filer
 , l3TreeInterfaces
 , Windows
 , l3String
 , l3Types
 , l3Base
 , Document_Const
 , TextPara_Const
 , l3TreeConst
;

end.
