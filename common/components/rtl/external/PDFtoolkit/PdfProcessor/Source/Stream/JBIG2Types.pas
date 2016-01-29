unit JBIG2Types;

interface

Type
  //for internal allocation of objects
  TgtJBIG2Alloc = function (Allocator: Pointer; Size: Integer): Pointer;
  TgtJBIG2Free = procedure (Allocator, AObject: Pointer);
  TgtJBIG2Realloc = function(Allocator, AObject: Pointer; Size: Integer): Pointer;

  TgtJBIG2Allocator = record
    JBIG2Alloc: TgtJBIG2Alloc;
    JBIG2Free: TgtJBIG2Free;
    JBIG2Realloc: TgtJBIG2Realloc;
  end;

  {
   this is the general image structure used by the jbig2dec library
   images are 1 bpp, packed into rows a byte at a time. stride gives
   the byte offset to the next row, while width and height define
   the size of the image area in pixels.
  }
  TgtJBIG2Image = record
    Width: Integer;
    Height: Integer;
    Stride: Integer;
  end;

  TgtJBIG2Segment = record
    Number: Cardinal;
    Flags: Byte;
    PageAssociation: Cardinal;
    DataLength: Integer;
    ReferredToSegmentCount: Integer;
  end;


implementation

end.
