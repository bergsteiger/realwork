const
  {string table constants for STREGINI}
  stscFalseString          = 0;
  stscTrueString           = 1;
  stscNoFileKey            = 2;
  stscInvalidPKey          = 3;
  stscNoWin32S             = 4;
  stscCreateKeyFail        = 5;
  stscOpenKeyFail          = 6;
  stscIniWriteFail         = 7;
  stscRegWriteFail         = 8;
  stscNoKeyName            = 9;
  stscQueryKeyFail         = 10;
  stscEnumKeyFail          = 11;
  stscEnumValueFail        = 12;
  stscIniDeleteFail        = 13;
  stscKeyHasSubKeys        = 14;
  stscDeleteKeyFail        = 15;
  stscIniDelValueFail      = 16;
  stscRegDelValueFail      = 17;
  stscOutputFileExists     = 18;
  stscFileHasExtension     = 19;
  stscSaveKeyFail          = 20;
  stscNo16bitSupport       = 21;
  stscCantFindInputFile    = 22;
  stscLoadKeyFail          = 23;
  stscUnloadKeyFail        = 24;
  stscNotWinNTPlatform     = 25;
  stscBadOptionsKeyCombo   = 26;
  stscRestoreKeyFail       = 27;
  stscReplaceKeyFail       = 28;
  stscNoIniFileSupport     = 29;
  stscRemoteKeyIsOpen      = 30;
  stscConnectRemoteKeyFail = 31;
  stscCloseRemoteKeyFail   = 32;
  stscFlushKeyFail         = 33;
  stscBufferDataSizesDif   = 34;
  stscKeyIsEmptyNotExists  = 35;
  stscGetSecurityFail      = 36;
  stscSetSecurityFail      = 37;
  stscByteArrayTooLarge    = 38;
  stscQueryValueFail       = 39;
  stscNoValueNameSpecified = 40;

  {string table constants for container classes}
  stscNoCompare        = 51; {Compare property must be set}
  stscBadType          = 52; {an incompatible class is passed to a method}
  stscBadSize          = 53; {bad size for TStDictionary, TStBits, TStCollection}
  stscDupNode          = 54; {attempt to add duplicate node to TStTree}
  stscBadIndex         = 55; {bad index passed to TStBits or large array}
  stscBadWinMode       = 56; {requires enhanced mode operation}
  stscUnknownClass     = 57; {container class name not registered}
  stscUnknownNodeClass = 58; {container node class name not registered}
  stscNoStoreData      = 59; {container has no store data routine}
  stscNoLoadData       = 60; {container has no load data routine}
  stscWrongClass       = 61; {container class and streamed class not equal}
  stscWrongNodeClass   = 62; {container node class and streamed class not equal}
  stscBadCompare       = 63; {invalid compare function or unable to assign now}
  stscTooManyCols      = 64; {assign a matrix with >1 col to array}
  stscBadColCount      = 65; {assign a matrix with wrong col count to virtual matrix}
  stscBadElSize        = 66; {assign a matrix with wrong elem size to virtual matrix}
  stscBadDups          = 67; {setting Dups to False in a non-empty sorted collection}

  {string table constants for sorting unit}
  stscTooManyFiles = 71; {too many merge files in TStSorter}
  stscFileCreate   = 72; {error creating file in TStSorter}
  stscFileOpen     = 73; {error opening file in TStSorter}
  stscFileWrite    = 74; {error writing file in TStSorter}
  stscFileRead     = 75; {error reading file in TStSorter}
  stscBadState     = 76; {TStSorter in wrong state}

  {string table constants for Bcd unit}
  stscBcdBadFormat   = 81; {bad BCD format}
  stscBcdOverflow    = 82; {BCD larger than 10**64}
  stscBcdDivByZero   = 83; {BCD divide by zero}
  stscBcdBadInput    = 84; {BCD negative input to sqrt, ln, or power}
  stscBcdBufOverflow = 85; {buffer overflow in FormatBcd}

  stscNoVerInfo      = 100; {no version info in file}
  stscVerInfoFail    = 101; {error reading version info}

  {shell string constants}
  stscShellVersionError   = 110; {not available in this version of Shell32.dll}
  stscShellFileOpSrcError = 111; {no source files specified}
  stscShellFileOpDstError = 112; {no destination files specified}
  stscShellFileOpMapError = 113; {mapping incomplete}
  stscShellFormatError    = 114; {format error}
  stscShellFormatCancel   = 115; {format cancelled}
  stscShellFormatNoFormat = 116; {drive cannot be formatted}
  stscShellFormatBadDrive = 117; {not removable drive}
  stscTrayIconInvalidOS   = 118; {bad OS (NT 3.51)}
  stscTrayIconCantAdd     = 119; {can't add icon to the tray}
  stscTrayIconCantDelete  = 120; {can't delete icon from the tray}
  stscTrayIconError       = 121; {general tray icon error}
  stscBadDropTarget       = 122; {drop target is not TWinControl}
  stscCOMInitFailed       = 123; {COInitialize failed}
  stscNoPathSpecified     = 124; {No destination path for shortcut}
  stscIShellLinkError     = 125; {Error creating IShellLink}
  stscNotShortcut         = 126; {File is not a shortcut}
  stscTrayIconClose       = 127; {Close}
  stscTrayIconRestore     = 128; {Restore}
  stscInvalidTargetFile   = 130; {Shortcut target file not found}
  stscShellFileOpDelete   = 131; {Can't use file mappings with delete op}
  stscShellFileNotFound   = 132; {One or more source files is missing}
  stscTrayIconDuplicate   = 133; {Cant' have more than one tray icon}
  stscBadVerInfoKey       = 134; {User-defined key not found in ver info}
  stscImageListInvalid    = 135; {No image list assigned.}

  {barcode errors}
  stscInvalidUPCACodeLen    = 140;
  stscInvalidCharacter      = 141;
  stscInvalidCheckCharacter = 142;
  stscInvalidUPCECodeLen    = 143;
  stscInvalidEAN8CodeLen    = 144;
  stscInvalidEAN13CodeLen   = 145;
  stscInvalidSupCodeLen     = 146;

  {stexpr errors}
  stscExprEmpty      = 150;  {empty expression}
  stscExprBadNum     = 151;  {error in floating point number}
  stscExprBadChar    = 152;  {unknown character}
  stscExprOpndExp    = 153;  {expected function, number, sign, or (}
  stscExprNumeric    = 154;  {numeric error}
  stscExprBadExp     = 155;  {invalid expression}
  stscExprOpndOvfl   = 156;  {operand stack overflow}
  stscExprUnkFunc    = 157;  {unknown function identifier}
  stscExprLParExp    = 158;  {left parenthesis expected}
  stscExprRParExp    = 159;  {right parenthesis expected}
  stscExprCommExp    = 160;  {comma expected}
  stscExprDupIdent   = 161;  {duplicate identifier}

  {ststat errors}
  stscStatBadCount   = 170;  {unequal or bad counts of array elements}
  stscStatBadParam   = 171;  {invalid parameter}
  stscStatBadData    = 172;  {invalid data point in array}
  stscStatNoConverge = 173;  {no convergence in numerical routine}

  {stfin errors}
  stscFinBadArg       = 180;
  stscFinNoConverge   = 181;

  {stmime errors}
  stscBadEncodeFmt    = 190;
  stscBadAttachment   = 191;
  stscDupeString      = 192;
  stscInStream        = 193;

  {ststring errors}
  stscOutOfBounds     = 200;  {Index out of string bounds}


  {stBarPN errors}
  stscInvalidLength   = 210;

  {StHTML errors}
  stscNoInputFile     = 215;
  stscNoOutputFile    = 216;
  stscInFileError     = 217;
  stscOutFileError    = 218;
  stscWordDelimiters  = 219;
  stscInvalidSLEntry  = 220;
  stscBadStream       = 221;  

  {StShlCtl constansts}
  stscName            = 230;
  stscSize            = 231;
  stscType            = 232;
  stscModified        = 233;
  stscAttributes      = 234;
  stscFileFolder      = 235;
  stscSystemFolder    = 236;
  stscOriginalLoc     = 237;
  stscDateDeleted     = 238;
  stscFile            = 239;
  stscInvalidFolder   = 240;
  stscFolderReadOnly  = 241;
  
  {StSpawnApplication errors}
  stscInsufficientData= 250;

  {StMemoryMappedFile errors}
  stscCreateFileFailed = 260;
  stscFileMappingFailed= 261;
  stscCreateViewFailed = 262;
  stscBadOrigin        = 263;
  stscGetSizeFailed    = 264;

  {buffered stream errors}
  stscNilStream        = 270;
  stscNoSeekForRead    = 271;
  stscNoSeekForWrite   = 272;
  stscCannotWrite      = 273;
  stscBadTerminator    = 274;
  stscBadLineLength    = 275;

  {RegEx errors}
  stscUnknownError              = 290;
  stscExpandingClass            = 291;
  stscAlternationFollowsClosure = 292;
  stscUnbalancedParens          = 293;
  stscFollowingClosure          = 294;
  stscPatternError              = 295;
  stscUnbalancedTag             = 296;
  stscNoPatterns                = 297;
  stscPatternTooLarge           = 298;
  stscStreamsNil                = 299;
  stscInTextStreamError         = 300;
  stscOutTextStreamError        = 301;
  stscClosureMaybeEmpty         = 302;
  stscInFileNotFound            = 303;
  stscREInFileError             = 304;
  stscOutFileDelete             = 305;
  stscOutFileCreate             = 306;


  {StNet errors 320-339}
  stscNetNoManualCreate          = 320;
  stscNetUnknownError            = 321;
  stscNetGroupNotSpecified       = 322;
  stscNetDateSpecifiedOutOfRange = 323;
  stscNetInvalidParameter        = 324;
  stscNetInvalidItemType         = 325;

  {StNetConnection errors 330-334}

  {StNetPerformance errors 335-339}

  {StNetMessage errors 340-344}



