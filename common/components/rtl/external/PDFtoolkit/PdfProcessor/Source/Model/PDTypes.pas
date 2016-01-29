unit PDTypes;

interface

uses
  Classes, gtObject, PDArray, PDBaseObject, PDReal, {$IFDEF VCL6ORABOVE}Types, {$ENDIF}gtTypes;

const
  ColorMapMaxComps = 32;

  TgtPDFFontEncoding: array [0..5] of AnsiString = (
    'StandardEncoding',
    'MacRomanEncoding',
    'WinAnsiEncoding',
    'PDFDocEncoding',
    'MacExpertEncoding',
    'CustomEncoding'
  );

type

  TgtPDFormFieldOrientation = (ffo0, ffo90, ffo180, ffo270);

  TgtPDFFontEmbeddingType = (etNone, etFull, etSubset);

  TgtPageDisplayOptions = (None, FitZoom, FitAll, FitHeight, FitWidth, FitRect,
    FitBoundingBox, FitBoundingBoxHeight, FitBoundingBoxWidth);
  TgtPDPageSpec = (psAllPages, psEvenPagesOnly, psOddPagesOnly);
  TgtPDHorizAlign = (haLeft, haCenter, haRight);
  TgtPDVertAlign = (vaTop, vaCenter, vaBottom);

  // Document Action Triggers
  TgtDocActionTrigger = (atBeforeDocClose,
    atBeforeDocSave,
    atAfterDocSave,
    atBeforeDocPrint,
    atAfterDocPrint,
    atBeforeDocOpen);

  //The page layout to be used when the document is opened
  TgtPDLayoutMode =
    (
    lmNone, //equalent to NIL
    lmSinglePage, //(Default) Display one page at a time
    lmOneColumn, //Display the pages in one column
    lmTwoColumnLeft, //Display the pages in two columns, with odd-numbered pages
                     //on the left
    lmTwoColumnRight, //Display the pages in two columns, with odd-numbered pages
                     //on the right
    lmTwoPageLeft, //Display the pages two at a time, with odd-numbered pages
                     //on the left
    lmTwoPageRight //Display the pages two at a time, with odd-numbered pages
                     //on the right
    );

  // FormField Trigger Types
  TgtFormFieldActionTriggers = (
    fftOnEnter,
    fftOnExit,
    fftMouseDown,
    fftMouseUp,
    fftGotFocus,
    fftLostFocus,
    fftOnKeyPress,
    fftFormat,
    fftValidate,
    fftCalculate
    );

  //An enumerated data type that specifies how the document should be displayed
  //when opened
  TgtPDPageMode =
    (
    pmNone, //equalent to NIL
    pmUseNone, //(Default)Neither document outline nor thumbnail images
                        //visible
    pmUseThumbs, //Thumbnail images visible
    pmUseBookmarks, //Document outline visible
    pmFullScreen, //Full-screen mode, with no menu bar, window controls,
                        //or any other window visible
    pmOCVisible, //Optional content group panel visible
    pmAttachmentsVisible //Attachments panel visible
    );

  TgtPDTrapped =
    (
    trapFalse, //The document has not yet been trapped; any desired trapping
                //must still be done.
    trapTrue, //The document has been fully trapped; no further trapping is
                //needed.
    trapUnknown //Either it is unknown whether the document has been trapped or
                //it has been partly but not yet fully trapped; some additional
                //trapping may still be needed.
    );

  //An enumerated data type that specifies the color space in
  //which a color value is specified (for example, RGB or grayscale).
  TgtPDColorSpaceType = (
    Transparent, //No Color
    DeviceGray, //Grayscale. It requires one value entry to specify the color.
    DeviceRGB, //Red-Green-Blue color specification. It requires three value
                 //entries to specify the color.
    DeviceCMYK //Cyan-Magenta-Yellow-Black color specification. It requires
                 //four value entries to specify the color.
    );

  //Level of encryption
  TgtEncryptionLevel = (el40Bits, el128Bits);
  //Constant values that specify permissions which allow operations on a document
  //file.
  TgtPDPermissions = record
    //Print the document
    Print: Boolean;

    //Print the document (possibly not at the highest quality level, depending
    //on whether PrintToDigitalCopy is also set).
    PrintHighQuality: Boolean;

    //Modify the contents of the document by operations other than those
    //controlled by ModifyTextAnnots, FillForms, and AssmbleDoc.
    ModifyContents: Boolean;

    //Copy or otherwise extract text and graphics from the document.
    CopyText: Boolean;

    //Add or modify text annotations, fill in interactive form fields, and, if
    //ModifyContents is also set, create or modify interactive form fields
    //(including signature fields).
    ModifyTextAnnots: Boolean;

    //Fill in existing interactive form fields (including signature fields),
    //even if ModifyTextAnnots is false.
    FillForms: Boolean;

    //Assemble the document (insert, rotate, or delete pages and create bookmarks
    //or thumbnail images), even if ModifyContents is false.
    AssmbleDoc: Boolean;

    //Print the document to a representation from which a faithful digital copy
    //of the PDF content could be generated.
    PrintToDigitalCopy: Boolean;

    //Owner password for encryption
    OwnerPassword: AnsiString;

    //Userpassword for encryption
    UserPassword: AnsiString;

    //Level of encryption
    Level: TgtEncryptionLevel;

    //Inticates whther to set the Ecryption or not
    Enable: Boolean;
  end;

  //Specifies a range of pages in a document. Page numbers begin with 1.
  TgtPDPageRange = record
    //The starting page number.
    StartPage: Integer;

    //The ending page number.
    EndPage: Integer;

    //The pages in the range to print. It must be one of: psAllPages,
    //psEvenPagesOnly, or psOddPagesOnly.
    PageSpec: TgtPDPageSpec;
  end;

  //A data structure representing a color. The number of elements needed in the
  //value field depends on the color space type (specified in the space field).
  TgtPDColorValue = record
    ColorSpace: TgtPDColorSpaceType;
    Value: array[0..3] of Double;
  end;

  // The render mode for text watermark.
  TTextRenderMode = (trmFill, trmStroke, trmFillStroke);

  //Parameters used for adding and describing watermarks.
  TgtPDAddWatermarkParams = record
    //The page range of the document to which the watermark should be added.
    PageRange: TgtPDPageRange;

    //A boolean specifying whether this watermark is a FixedPrint watermark.
    //FixedPrint watermarks maintain their size and position regardless of the
    //dimensions of the target media.
    FixedPrint: Boolean;

    //A boolean specifying where in the page z-order the watermark should be
    //added. If it is true, the watermark is added to the front of the page;
    //otherwise, it is added as a background. This parameter is ignored if
    //fixedPrint is true, as all FixedPrint watermarks are added to the front of
    //the page.
    ZOrderTop: Boolean;

    //A boolean specifying whether the watermark should be visible when viewing
    //on screen.
    ShowOnScreen: Boolean;

    //A boolean specifying whether the watermark should be printed.
    ShowOnPrint: Boolean;

    //The horizontal alignment to be used when adding the watermark to a page.
    HorizAlign: TgtPDHorizAlign;

    //The vertical alignment to be used when adding the watermark to a page.
    VertAlign: TgtPDVertAlign;

    //The horizontal offset value to be used when adding the watermark on a page.
    //If percentageVals is true, this value is a percentage of the page width,
    //with 1.0 meaning 100%. Otherwise this value is in user units.
    HorizValue: Double;

    //The vertical offset value to be used when adding the watermark on a page.
    //If percentageVals is true, this value is a percentage of the page height,
    //with 1.0 meaning 100%. Otherwise this value is in user units.
    VertValue: Double;

    //A boolean specifying the units of horizValue and vertValue. If it is true,
    //horizValue and vertValue represent percentages of the page dimensions.
    //Otherwise horizValue and vertValue are in user units.
    PercentValues: Boolean;

    //The scale factor to be used when adding the watermark, with 1.0 meaning 100%.
    Scale: Double;

    //The counter-clockwise rotation, in degrees, to be used when adding the watermark.
    Rotation: Double;

    //The opacity to be used when adding the watermark, with 0.0 meaning fully
    //transparent and 1.0 meaning fully opaque.
    Opacity: Double;
  end;

  //Parameters used for describing text-based watermarks.
  TgtPDWatermarkTextParams = record
    //The text to be used when generating a text-based watermark.
    SourceText: AnsiString;

    //The alignment to be used when justifying a text-based watermark.
    TextAlign: TgtPDHorizAlign;

    //The TgtPDEFont to be used when generating a text-based watermark. If it is
    //nil, the font specified by sysFontName will be used.
    PDEFont: TgtObject;

    //The name of a system font to be used when generating a text-based watermark.
    //The font will be embedded/subsetted when possible. This parameter is ignored
    //if PDEFont is non-NULL.
    SysFontName: AnsiString;

    //The size of the font, in points, to be used when generating a text-based
    //watermark.
    FontSize: Double;

    //The color to be used when generating a text-based watermark.
    Color: TgtPDColorValue;
  end;

  TgtPageSize = record
    Width: Double;
    Height: Double;
  end;


  //Graphics Related

  TgtImageDecodeArray = array[0..512] of Double;

  TgtColorMapComp = Integer;

  TgtColor = record
    Comps: array[0..ColorMapMaxComps - 1] of TgtColorMapComp;
  end;

  TgtGray = TgtColorMapComp;

  TgtRGB = record
    R: TgtColorMapComp;
    G: TgtColorMapComp;
    B: TgtColorMapComp;
  end;

  TgtCMYK = record
    C: TgtColorMapComp;
    M: TgtColorMapComp;
    Y: TgtColorMapComp;
    K: TgtColorMapComp;
  end;

  //Preferences set in an Acro form field
  TgtAcroFieldPreferencesType = (afpReadOnly, afpRequired, afpNoExport);

//  TgtAdditionalPreferencesType = (afpInvisible, afpHidden, afpPrint, afpNoPrint,
//    afpNoZoom, afpNoRotate, afpNoView, afpReadOnlyAnnots, afpLocked, afpToggleNoView);

  TgtFormFieldVals = record
    FieldName: AnsiString;
    DAValue: AnsiString;
    DefaultValue: AnsiString;
    FontDict: TgtPDBaseObject;
    FFlag: Integer;
    FfFlag: Integer;
  end;

  TPDPoint = record
    X: Double;
    Y: Double;
  end;

  TPDPoints = array of TPDPoint;

  TgtPDTransitionEffect = (teNone, teSplitHorizontalInward,
    teSplitHorizontalOutward, teSplitVerticalInward, teSplitVerticalOutward,
    teBlindsHorizontal, teBlindsVertical, teBoxInward, teBoxOutward,
    teWipeLeftToRight, teWipeBottomToTop, teWipeRightToLeft, teWipeTopToBottom,
    teDissolve, teGlitterLeftToRight, teGlitterTopToBottom,
    teGlitterTopLeftToBottomRight);


implementation



end.

