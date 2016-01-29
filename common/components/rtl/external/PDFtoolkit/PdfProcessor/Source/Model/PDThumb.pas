unit PDThumb;

interface

uses
  PDElement, gtTypes;

type
  TgtPDThumb = class;

  TgtPDThumbGetThumbDataEvent =
    procedure(Sender: TObject;
    Page: TgtPDElement; //The page for which to create a thumbnail image.
    var Scale: Double; //The scale to map from the page size to the
                                  //thumbnail size, which is either 1/8 of the
                                  //page size or is limited to MAX_THUMBPAGE_WIDTH
                                  //and MAX_THUMBPAGE_HEIGHT, whichever is smaller.
    var Width: Double; //The width of the thumbnail image to create.
    var Height: Double; //The height of the thumbnail image to create.
    var ImageData: Bytes) of object;
                //A buffer into which the thumbnail data is copied.
                //This buffer has the following values:
                // * rowBytes = (width * bitsPerPixel + 7) / 8;
                // * size = rowBytes * height;
                //where bitsPerPixel is specified as numComponents *
                //bitsPerComponent. numComponents is dependent upon the color
                //space. For DeviceRGB, numComponents is 3. For an indexed color
                //space, numComponents is 1.

  TgtPDThumbReturnThumbEvent =
    procedure(Sender: TObject; Thumbnail: TgtPDThumb) of object;

  TgtPDThumbsCreationServer = record
    GetThumbData: TgtPDThumbGetThumbDataEvent;
    ReturnThumb: TgtPDThumbReturnThumbEvent;
  end;

  TgtPDThumb = class(TgtPDElement)
  private
  public
  end;

implementation

end.
