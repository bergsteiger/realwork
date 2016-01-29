{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnMsg
|
| Description: Centralization of exceptions and messages.
|
| History: Nov 28, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnMsg;

{$I Envision.Inc}

interface

const

{$J+}

msgInvalidBitmap
        = 'Invalid bitmap';

msgTiffCompressionNotSupported
        = '%s compression not supported with %s images';

msgLZWCompressionNotSupported
        = 'LZW compression not supported';

msgUnsupportedCompressionTag
        = 'Unsupported compression tag, %d';

msgInvalidImageFormat
        = 'Internal error: Invalid image format';

msgMethodNotImplemented
        = 'Method %s not implemented for %s class';

msgImageDoesNotHavePalette
        = 'The image does not have a palette';

msgUseNewImageToChangeSize
        = 'Dimensions must be change with the NewImage method';

msgNotAGrayScaleFormat
        = 'Not a gray scale image format';

msgCannotAssign
        = 'Cannot assign a %s to a %s';

msgNotAValidPngFile
        = 'PNG file is not valid or corrupted';

msgInvalidColorTypeForBitDepth
        = 'Invalid color type for bit depth';

msgInvalidBitDepth
        = 'Invalid bit depth';

msgInvalidSampleCount
        = 'Invalid number of samples';

msgJpegMustBeTrueColorOrGrayscale
        = 'JPEG image must be gray scale or true color';

msgTGAMustBeTrueColorOr8Bit
        = 'TARGA image must be true color or 8 bit with palette';

msgFileFormatNotSupported
        = 'Graphic files of %s format are not supported or not registered';

msgGifCannotBeTrueColor
        = 'GIF image cannot be a true color image';

msgUnsupportedClipboardFormat
        = 'Unknown clipboard format, %d';

msgFrameDoesNotExist
        = 'Frame %d does not exist';

msgScannerIsBusy
        = 'Scanner is busy';

msgOnlyOneScannerObjectPermitted
        = 'Only one scanner object is permitted';

msgUnableToOpenTWAINSourceManager
        = 'Unable to open TWAIN source manager';

msgInvalidCropParameters
        = 'Invalid crop parameters';

msgOutOfResources
        = 'Out of resources';

msgSourceTooSmall
        = 'Source graphic too small';

msgDestTooSmall
        = 'Destination graphic too small';

msgSingleImageFileFormat
        = 'The %s format does not support multiple images';

msgInvalidDcxHeader
        = 'The DCX file header is not valid';

msgDcxHeaderIsFull
        = 'The DCX file header is full';

{--------------------------------------------------------------------------}

implementation

{--------------------------------------------------------------------------}

end.




