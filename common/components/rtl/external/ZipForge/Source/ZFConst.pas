unit ZFConst;

{$I ZFVer.Inc}

interface

const
  InternalCurrentVersion = 5.05;
// current version of the engine (for visual property)
var
  internalCurrentVersionText: string = '';

const
  DefaultSearchAttr = 63 + $2000 + $800 + $80;

  ZF_MAX_IVECTOR_SIZE = 16;
  ZF_MAX_SAVED_IVECTOR_SIZE = 16;


resourcestring
  SConfirmOverwrite = 'Overwrite file "%s" with "%s"';
  SPasswordTitle = 'Password for "%s"';
  SPasswordPrompt = 'Enter password: ';
  SOnRequestBlankDisk = 'Please insert a blank disk #%d';
  SOnRequestFirstDisk = 'Please insert the first disk';
  SOnRequestLastDisk = 'Please insert the last disk';
  SOnRequestMiddleDisk = 'Please insert disk #%d';
  SOnDiskFull =
    'Disk is full. Required free space: %d bytes, but available only: %d bytes. Clean the disk or find another blank disk';
  SOnProcessFileFailure = '%s. File processing error, possibly disk is full';
  SWrongDiskRequestLastDisk =
    'File ''%s'' not found on inserted disk. Please insert last disk with required file';

const
  ErUnknownError  = 0;
  ErIndexOutOfBounds = 1;
  ErInvalidCompressionMode = 2;
  ErUnexpectedNil = 3;
  ErInvalidCheckSum = 4;
  ErBlankFileName = 5;
  ErFileNotFound  = 6;
  ErArchiveIsNotOpen = 7;
  ErStubNotSpecified = 8;
  ErCannotCreateFile = 9;
  ErCannotCreateDir = 10;
  ErNotInUpdate   = 11;
  ErCannotOpenFile = 12;
  ErInUpdate      = 13;
  ErCannotDeleteFile = 14;
  ErInMemoryArchiveCanBeCreatedOnly = 15;
  ErFileIsInReadonlyMode = 16;
  ErInvalidCompressedSize = 17;
  ErInvalidFormat = 18;
  ErCannotCreateOutputFile = 19;
  ErArchiveIsOpen = 20;
  ErUnableToCreateDirectory = 21;
  ErUnableToFindZip64DirEnd = 22;
  ErHugeFileModeIsNotEnabled = 23;
  ErCannotOpenArchiveFile = 24;
  ErCannotWriteToStream = 25;
  ErCannotFitSFXStubOnVolume = 26;
  ErDamagedArchive = 27;
  ErMakeSFXIsNotAllowed = 28;
  ErArchiveAlreadyHasSFXStub = 29;
  ErMultiVolumeArchiveIsNotAllowed = 30;
  ErSpanningModificationIsNotAllowed = 31;
  ErDeflate64NotSupported = 32;
  ErMakeSFXError  = 33;
  ErInvalidHashedNamesList = 34;
  ErCannotDeleteFolder = 35;
  ErFileNameTooLong = 36;
  ErMultipleTransactionsNotAllowedForMutlivolumeArchives = 37;
  ErInvalidIVIndex = 38;
  ErDiskFull = 39;
  ErInvalidPassword = 40;


  ZFMaxError = 40;

  ZFErrorMessages: array[0..ZFMaxError] of string =
    (
    'Unknown error',
    'Index out of bounds',
    'Invalid compression mode. Mode must be in [0-9] range',
    'Unexpected nil pointer',
    'Invalid size or check sum of file or unsupported compression format',
    'File name is blank. Specify appropriate file name',
    'File "%s" not found',
    'Archive is not open',
    'SFXStub property is not specified',
    'Cannot create file "%s"',
    'Cannot create directory "%s"',
    'Internal error. Update is not started',
    'Cannot open file "%s"',
    'Cannot proceed when update is not ended. Preceding EndUpdate call is required.',
    'Cannot delete file "%s"',
    'In-memory archive can be created only',
    'File is open in read-only mode',
    'Invalid compressed size, rfs.size = %d, count = %d',
    'Invalid archive file.',
    'Cannot create output file. Probably file is locked by another process. FileName = ''%s''.',
    'Archive is open. You should close it beore performing this operation.',
    'Unable to create directory',
    'Cannot find 64-bit directory end record',
    'Cannot compress file ''%s''. Zip64 mode is not enabled',
    'Cannot open archive file. Opening aborted or invalid file',
    'Write to stream error',
    'Cannot place SFX stub on volume. Volume size limit is too small',
    'Archive is damaged. Open failed',
    'MakeSFX is not allowed for splitted or spanned archives. Set SFXStub before archive creation instead of MakeSFX',
    'Archive already has SFX stub',
    'Multi-volume archive is not allowed for custom stream',
    'Multi-spanned archive is not allowed for modification. Use BeginUpdate/EndUpdate methods to add files several times',
    'Deflate64 compression method is not supported',
    'MakeSFX error',
    'Hashed list of file names is invalid',
    'Cannot delete folder "%s"',
    'File name is too long: ' + #13#10 + '"%s"',
    'Multiple transactions are not supported for multi-volume archives',
    'Invalid InitVector index = %d. Index should be >= 0 and < %d',
    'Disk is full. There is not enough free space on disk.',
    'Invalid password. Cannot decompress encrypted file.'
    );

  ZFMaxNativeError = 67;
  ZFNativeToErrorCode: array[0..ZFMaxNativeError, 0..1] of integer =
    (
    (00000, ErUnknownError),
    (00001, ErIndexOutOfBounds),
    (00002, ErIndexOutOfBounds),
    (00003, ErIndexOutOfBounds),
    (00004, ErIndexOutOfBounds),
    (00005, ErInvalidCompressionMode),
    (00006, ErUnexpectedNil),
    (00007, ErIndexOutOfBounds),
    (00008, ErInvalidCheckSum),
    (00009, ErBlankFileName),
    (00010, ErBlankFileName),
    (00011, ErFileNotFound),
    (00012, ErFileNotFound),
    (00013, ErArchiveIsNotOpen),
    (00014, ErArchiveIsNotOpen),
    (00015, ErFileNotFound),
    (00016, ErIndexOutOfBounds),
    (00017, ErStubNotSpecified),
    (00018, ErFileNotFound),
    (00019, ErCannotCreateFile),
    (00020, ErCannotCreateDir),
    (00021, ErIndexOutOfBounds),
    (00022, ErNotInUpdate),
    (00023, ErCannotCreateFile),
    (00024, ErIndexOutOfBounds),
    (00025, ErNotInUpdate),
    (00026, ErInUpdate),
    (00027, ErCannotDeleteFile),
    (00028, ErInMemoryArchiveCanBeCreatedOnly),
    (00029, ErBlankFileName),
    (00030, ErFileNotFound),
    (00031, ErFileNotFound),
    (00032, ErFileIsInReadonlyMode),
    (00033, ErCannotOpenFile),
    (00034, ErInvalidCompressedSize),
    (00035, ErInvalidFormat),
    (00036, ErCannotCreateOutputFile),
    (00037, ErArchiveIsOpen),
    (00038, ErFileNotFound),
    (00039, ErUnableToCreateDirectory),
    (00040, ErUnableToFindZip64DirEnd),
    (00041, ErHugeFileModeIsNotEnabled),
    (00042, ErFileNotFound),
    (00043, ErHugeFileModeIsNotEnabled),
    (00044, ErCannotOpenArchiveFile),
    (00045, ErCannotOpenArchiveFile),
    (00046, ErCannotWriteToStream),
    (00047, ErCannotFitSFXStubOnVolume),
    (00048, ErDamagedArchive),
    (00049, ErMakeSFXIsNotAllowed),
    (00050, ErArchiveAlreadyHasSFXStub),
    (00051, ErMultiVolumeArchiveIsNotAllowed),
    (00052, ErSpanningModificationIsNotAllowed),
    (00053, ErFileNotFound),
    (00054, ErFileNotFound),
    (00055, ErDeflate64NotSupported),
    (00056, ErMakeSFXError),
    (00057, ErDamagedArchive),
    (00058, ErInvalidHashedNamesList),
    (00059, ErInvalidHashedNamesList),
    (00060, ErCannotDeleteFolder),
    (00061, ErFileNameTooLong),
    (00062, ErMultipleTransactionsNotAllowedForMutlivolumeArchives),
    (00063, ErInvalidIVIndex),
    (00064, ErInvalidIVIndex),
    (00065, ErDiskFull),
    (00066, ErDiskFull),
    (00067, ErInvalidPassword)
    );

const
  CRC32_TABLE: array[0..255] of longword =
    (
    $00000000, $77073096, $ee0e612c, $990951ba, $076dc419, $706af48f, $e963a535, $9e6495a3,
    $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988, $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91,
    $1db71064, $6ab020f2, $f3b97148, $84be41de, $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
    $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec, $14015c4f, $63066cd9, $fa0f3d63, $8d080df5,
    $3b6e20c8, $4c69105e, $d56041e4, $a2677172, $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b,
    $35b5a8fa, $42b2986c, $dbbbc9d6, $acbcf940, $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
    $26d930ac, $51de003a, $c8d75180, $bfd06116, $21b4f4b5, $56b3c423, $cfba9599, $b8bda50f,
    $2802b89e, $5f058808, $c60cd9b2, $b10be924, $2f6f7c87, $58684c11, $c1611dab, $b6662d3d,
    $76dc4190, $01db7106, $98d220bc, $efd5102a, $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
    $7807c9a2, $0f00f934, $9609a88e, $e10e9818, $7f6a0dbb, $086d3d2d, $91646c97, $e6635c01,
    $6b6b51f4, $1c6c6162, $856530d8, $f262004e, $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457,
    $65b0d9c6, $12b7e950, $8bbeb8ea, $fcb9887c, $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
    $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2, $4adfa541, $3dd895d7, $a4d1c46d, $d3d6f4fb,
    $4369e96a, $346ed9fc, $ad678846, $da60b8d0, $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9,
    $5005713c, $270241aa, $be0b1010, $c90c2086, $5768b525, $206f85b3, $b966d409, $ce61e49f,
    $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4, $59b33d17, $2eb40d81, $b7bd5c3b, $c0ba6cad,
    $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a, $ead54739, $9dd277af, $04db2615, $73dc1683,
    $e3630b12, $94643b84, $0d6d6a3e, $7a6a5aa8, $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
    $f00f9344, $8708a3d2, $1e01f268, $6906c2fe, $f762575d, $806567cb, $196c3671, $6e6b06e7,
    $fed41b76, $89d32be0, $10da7a5a, $67dd4acc, $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5,
    $d6d6a3e8, $a1d1937e, $38d8c2c4, $4fdff252, $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b,
    $d80d2bda, $af0a1b4c, $36034af6, $41047a60, $df60efc3, $a867df55, $316e8eef, $4669be79,
    $cb61b38c, $bc66831a, $256fd2a0, $5268e236, $cc0c7795, $bb0b4703, $220216b9, $5505262f,
    $c5ba3bbe, $b2bd0b28, $2bb45a92, $5cb36a04, $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
    $9b64c2b0, $ec63f226, $756aa39c, $026d930a, $9c0906a9, $eb0e363f, $72076785, $05005713,
    $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38, $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21,
    $86d3d2d4, $f1d4e242, $68ddb3f8, $1fda836e, $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
    $88085ae6, $ff0f6a70, $66063bca, $11010b5c, $8f659eff, $f862ae69, $616bffd3, $166ccf45,
    $a00ae278, $d70dd2ee, $4e048354, $3903b3c2, $a7672661, $d06016f7, $4969474d, $3e6e77db,
    $aed16a4a, $d9d65adc, $40df0b66, $37d83bf0, $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
    $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6, $bad03605, $cdd70693, $54de5729, $23d967bf,
    $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94, $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d
    );

implementation

end.
