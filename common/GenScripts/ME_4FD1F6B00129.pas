unit vtPngImgListUtils;

interface

uses
 l3IntfUses
 , l3ObjectList
 , hyieutils
 , Graphics
 , Windows
 , l3Types
 , vtInterfaces
 , l3ProcedureList
 , l3ProtoObject
;

type
 TvtImageListCreatorProc = function: TObject;
 
 PvtImageListCreatorProc = ^TvtImageListCreatorProc;
 
 TAlphaBlendFunc = function(DestDC: hDC;
  X: Integer;
  Y: Integer;
  Width: Integer;
  Height: Integer;
  SrcDC: hDC;
  XSrc: Integer;
  YSrc: Integer;
  SrcWidth: Integer;
  SrcHeight: Integer;
  const BlendFunc: TBlendFunction): Boolean;
 
 TvtilCreators = class(Tl3ProcedureList)
  function IsAssigned: Boolean;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TvtilCreators
 
 ImgLibraryManager = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//ImgLibraryManager
 
 // TaBPPGlyphs
 
 // TaPILSizes
 
 TBitmap = Graphics.TBitmap;
 
implementation

uses
 l3ImplUses
 , l3Bitmap
 , SysUtils
 , l3MinMax
 , l3Base
 , hyiedefs
 , vtPngImgList
;

end.
