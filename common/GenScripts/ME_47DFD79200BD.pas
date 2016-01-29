unit l3Metafile;

interface

uses
 l3IntfUses
 , Graphics
 , l3Interfaces
 , Classes
 , Windows
;

type
 Tl3Metafile = class(_l3Unknown_)
  {* Метафайл }
  procedure LoadWMFFromStream(Stream: TStream);
  function TryMakeFromStream(Stream: TStream): Tl3Metafile;
  procedure LoadFromIStream(const aStream: IStream);
  procedure SaveToIStream(const aStream: IStream);
 end;//Tl3Metafile
 
implementation

uses
 l3ImplUses
 , l3Stream
 , SysUtils
 , l3Base
 , l3Core
 , l3MemUtils
 , l3Interlocked
 , Consts
 , l3MetafileHeader
;

type
 THackMetafile = class(TGraphic)
 end;//THackMetafile
 
 THackSharedImage = class(TSharedImage)
 end;//THackSharedImage
 
 THackImage = class(TSharedImage)
 end;//THackImage
 
end.
