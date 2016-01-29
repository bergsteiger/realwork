(* ***** BEGIN LICENSE BLOCK *****
  * Version: MPL 1.1
  *
  * The contents of this file are subject to the Mozilla Public License Version
  * 1.1 (the "License"); you may not use this file except in compliance with
  * the License. You may obtain a copy of the License at
  * http://www.mozilla.org/MPL/
  *
  * Software distributed under the License is distributed on an "AS IS" basis,
  * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  * for the specific language governing rights and limitations under the
  * License.
  *
  * The Original Code is TurboPower Abbrevia
  *
  * The Initial Developer of the Original Code is
  * TurboPower Software
  *
  * Portions created by the Initial Developer are Copyright (C) 1997-2002
  * the Initial Developer. All Rights Reserved.
  *
  * Contributor(s):
  *
  * ***** END LICENSE BLOCK ***** *)

{ ********************************************************* }
{ * ABBREVIA: AbExcept.pas                                * }
{ ********************************************************* }
{ * ABBREVIA: Exception classes                           * }
{ ********************************************************* }
{ *************************************************************************** }
{ "Unit names renamed for integration with Gnostice libraries  - Gnostice"
  {*************************************************************************** }

unit gtAbExcept;

{$I gtAbDefine.inc}

interface

uses
  SysUtils,
  gtAbUtils;

type
{$EXTERNALSYM     EAbException  }
  EAbException = class(Exception)
  public
    ErrorCode: Integer;
  end;
{$EXTERNALSYM     EAbArchiveBusy }

  EAbArchiveBusy = class(EAbException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbBadStream }

  EAbBadStream = class(EAbException)
  protected
    FInnerException: Exception;
  public
    constructor Create; overload;
    constructor CreateInner(aInnerException: Exception);
    property InnerException: Exception read FInnerException;
  end;
{$EXTERNALSYM     EAbDuplicateName }

  EAbDuplicateName = class(EAbException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbFileNotFound }

  EAbFileNotFound = class(EAbException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbNoArchive }

  EAbNoArchive = class(EAbException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbUserAbort }

  EAbUserAbort = class(EAbException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbNoSuchDirectory}

  EAbNoSuchDirectory = class(EAbException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbUnhandledType}

  EAbUnhandledType = class(EAbException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbSpanningNotSupported}

  EAbSpanningNotSupported = class(EAbException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbInvalidSpanningThreshold}

  EAbInvalidSpanningThreshold = class(EAbException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbZipException }

  EAbZipException = class(EAbException); { Zip exception }
{$EXTERNALSYM    EAbCabException }
  EAbCabException = class(EAbException); { Cab exception }
{$EXTERNALSYM    EAbTarException }
  EAbTarException = class(EAbException); { Tar Exception }
{$EXTERNALSYM    EAbGzipException  }
  EAbGzipException = class(EAbException); { GZip exception }
{$EXTERNALSYM    EAbZipBadSpanStream }

  EAbZipBadSpanStream = class(EAbZipException)
  public
    constructor Create; overload;
  end;

{$EXTERNALSYM    EAbZipBadCRC }

  EAbZipBadCRC = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipInflateBlock }

  EAbZipInflateBlock = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM     EAbZipInvalid }

  EAbZipInvalid = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbInvalidIndex }

  EAbInvalidIndex = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipInvalidFactor  }

  EAbZipInvalidFactor = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipInvalidLFH  }

  EAbZipInvalidLFH = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipInvalidMethod }

  EAbZipInvalidMethod = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipInvalidPassword}

  EAbZipInvalidPassword = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipInvalidStub}

  EAbZipInvalidStub = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipNoExtraction}

  EAbZipNoExtraction = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipNoInsertion}

  EAbZipNoInsertion = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipSpanOverwrite}

  EAbZipSpanOverwrite = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipStreamFull}

  EAbZipStreamFull = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipTruncate }

  EAbZipTruncate = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipUnsupported }

  EAbZipUnsupported = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbZipVersion }

  EAbZipVersion = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbReadError  }

  EAbReadError = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbGzipBadCRC }

  EAbGzipBadCRC = class(EAbGzipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbGzipBadFileSize}

  EAbGzipBadFileSize = class(EAbGzipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbGzipInvalid}

  EAbGzipInvalid = class(EAbGzipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbTarInvalid}

  EAbTarInvalid = class(EAbTarException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbTarBadFileName}

  EAbTarBadFileName = class(EAbTarException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbTarBadLinkName}

  EAbTarBadLinkName = class(EAbTarException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbTarBadOp }

  EAbTarBadOp = class(EAbTarException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbVMSInvalidOrigin}

  EAbVMSInvalidOrigin = class(EAbZipException)
  public
    constructor Create(Value: Integer); overload;
  end;
{$EXTERNALSYM    EAbVMSErrorOpenSwap}

  EAbVMSErrorOpenSwap = class(EAbZipException)
  public
    constructor Create(const Value: string); overload;
  end;
{$EXTERNALSYM    EAbVMSSeekFail}

  EAbVMSSeekFail = class(EAbZipException)
  public
    constructor Create(const Value: string); overload;
  end;
{$EXTERNALSYM    EAbVMSReadFail}

  EAbVMSReadFail = class(EAbZipException)
  public
    constructor Create(Count: Integer; const Value: string); overload;
  end;
{$EXTERNALSYM    EAbVMSWriteFail}

  EAbVMSWriteFail = class(EAbZipException)
  public
    constructor Create(Count: Integer; const Value: string); overload;
  end;
{$EXTERNALSYM    EAbVMSWriteTooManyBytes}

  EAbVMSWriteTooManyBytes = class(EAbZipException)
  public
    constructor Create(Count: Integer); overload;
  end;
{$EXTERNALSYM    EAbBBSReadTooManyBytes }

  EAbBBSReadTooManyBytes = class(EAbZipException)
  public
    constructor Create(Count: Integer); overload;
  end;
{$EXTERNALSYM    EAbBBSSeekOutsideBuffer }

  EAbBBSSeekOutsideBuffer = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbBBSInvalidOrigin}

  EAbBBSInvalidOrigin = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbBBSWriteTooManyBytes}

  EAbBBSWriteTooManyBytes = class(EAbZipException)
  public
    constructor Create(Count: Integer); overload;
  end;
{$EXTERNALSYM    EAbSWSNotEndofStream}

  EAbSWSNotEndofStream = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbSWSSeekFailed }

  EAbSWSSeekFailed = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbSWSWriteFailed }

  EAbSWSWriteFailed = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbSWSInvalidOrigin}

  EAbSWSInvalidOrigin = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbSWSInvalidNewOrigin}

  EAbSWSInvalidNewOrigin = class(EAbZipException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbNoCabinetDll}

  EAbNoCabinetDll = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM    EAbFCIFileOpenError}

  EAbFCIFileOpenError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM   EAbFCIFileReadError }

  EAbFCIFileReadError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM   EAbFCIFileWriteError  }

  EAbFCIFileWriteError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM   EAbFCIFileCloseError }

  EAbFCIFileCloseError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM   EAbFCIFileSeekError }

  EAbFCIFileSeekError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM   EAbFCIFileDeleteError}

  EAbFCIFileDeleteError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM   EAbFCIAddFileError}

  EAbFCIAddFileError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM   EAbFCICreateError}

  EAbFCICreateError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM  EAbFCIFlushCabinetError}

  EAbFCIFlushCabinetError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM EAbFCIFlushFolderError}

  EAbFCIFlushFolderError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM EAbFDICopyError}

  EAbFDICopyError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM EAbFDICreateError}

  EAbFDICreateError = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM EAbInvalidCabTemplate}

  EAbInvalidCabTemplate = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM EAbInvalidCabFile }

  EAbInvalidCabFile = class(EAbCabException)
  public
    constructor Create; overload;
  end;
{$EXTERNALSYM EAbFileTooLarge }

  EAbFileTooLarge = class(EAbException)
  public
    constructor Create; overload;
  end;

procedure AbConvertException(const E: Exception; var eClass: TAbErrorClass;
  var eErrorCode: Integer);

implementation

uses
  Classes,
  gtAbConst,
  gtAbResString;

constructor EAbArchiveBusy.Create;
begin
  inherited Create(AbArchiveBusyS);
  ErrorCode := AbArchiveBusy;
end;

constructor EAbBadStream.Create;
begin
  inherited Create(AbBadStreamTypeS);
  FInnerException := nil;
  ErrorCode := AbBadStreamType;
end;

constructor EAbBadStream.CreateInner(aInnerException: Exception);
begin
  inherited Create(AbBadStreamTypeS + #13#10 + aInnerException.Message);
  FInnerException := aInnerException;
  ErrorCode := AbBadStreamType;
end;

constructor EAbDuplicateName.Create;
begin
  inherited Create(AbDuplicateNameS);
  ErrorCode := AbDuplicateName;
end;

constructor EAbNoSuchDirectory.Create;
begin
  inherited Create(AbNoSuchDirectoryS);
  ErrorCode := AbNoSuchDirectory;
end;

constructor EAbInvalidSpanningThreshold.Create;
begin
  inherited Create(AbInvalidThresholdS);
  ErrorCode := AbInvalidThreshold;
end;

constructor EAbFileNotFound.Create;
begin
  inherited Create(AbFileNotFoundS);
  ErrorCode := AbFileNotFound;
end;

constructor EAbNoArchive.Create;
begin
  inherited Create(AbNoArchiveS);
  ErrorCode := AbNoArchive;
end;

constructor EAbUserAbort.Create;
begin
  inherited Create(AbUserAbortS);
  ErrorCode := AbUserAbort;
end;

constructor EAbZipBadSpanStream.Create;
begin
  inherited Create(AbBadSpanStreamS);
  ErrorCode := AbBadSpanStream;
end;

constructor EAbZipBadCRC.Create;
begin
  inherited Create(AbZipBadCRCS);
  ErrorCode := AbZipBadCRC;
end;

constructor EAbZipInflateBlock.Create;
begin
  inherited Create(AbInflateBlockErrorS);
  ErrorCode := AbInflateBlockError;
end;

constructor EAbZipInvalid.Create;
begin
  inherited Create(AbErrZipInvalidS);
  ErrorCode := AbErrZipInvalid;
end;

constructor EAbInvalidIndex.Create;
begin
  inherited Create(AbInvalidIndexS);
  ErrorCode := AbInvalidIndex;
end;

constructor EAbZipInvalidFactor.Create;
begin
  inherited Create(AbInvalidFactorS);
  ErrorCode := AbInvalidFactor;
end;

constructor EAbZipInvalidLFH.Create;
begin
  inherited Create(AbInvalidLFHS);
  ErrorCode := AbInvalidLFH;
end;

constructor EAbZipInvalidMethod.Create;
begin
  inherited Create(AbUnknownCompressionMethodS);
  ErrorCode := AbUnknownCompressionMethod;
end;

constructor EAbZipInvalidPassword.Create;
begin
  inherited Create(AbInvalidPasswordS);
  ErrorCode := AbInvalidPassword;
end;

constructor EAbZipInvalidStub.Create;
begin
  inherited Create(AbZipBadStubS);
  ErrorCode := AbZipBadStub;
end;

constructor EAbZipNoExtraction.Create;
begin
  inherited Create(AbNoExtractionMethodS);
  ErrorCode := AbNoExtractionMethod;
end;

constructor EAbZipNoInsertion.Create;
begin
  inherited Create(AbNoInsertionMethodS);
  ErrorCode := AbNoInsertionMethod;
end;

constructor EAbZipSpanOverwrite.Create;
begin
  inherited Create(AbNoOverwriteSpanStreamS);
  ErrorCode := AbNoOverwriteSpanStream;
end;

constructor EAbZipStreamFull.Create;
begin
  inherited Create(AbStreamFullS);
  ErrorCode := AbStreamFull;
end;

constructor EAbZipTruncate.Create;
begin
  inherited Create(AbTruncateErrorS);
  ErrorCode := AbTruncateError;
end;

constructor EAbZipUnsupported.Create;
begin
  inherited Create(AbUnsupportedCompressionMethodS);
  ErrorCode := AbUnsupportedCompressionMethod;
end;

constructor EAbZipVersion.Create;
begin
  inherited Create(AbZipVersionNeededS);
  ErrorCode := AbZipVersionNeeded;
end;

constructor EAbReadError.Create;
begin
  inherited Create(AbReadErrorS);
  ErrorCode := AbReadError;
end;

constructor EAbVMSInvalidOrigin.Create(Value: Integer);
begin
  inherited Create(Format(AbVMSInvalidOriginS, [Value]));
  ErrorCode := AbVMSInvalidOrigin;
end;

constructor EAbBBSReadTooManyBytes.Create(Count: Integer);
begin
  inherited Create(Format(AbBBSReadTooManyBytesS, [Count]));
  ErrorCode := AbBBSReadTooManyBytes;
end;

constructor EAbBBSSeekOutsideBuffer.Create;
begin
  inherited Create(AbBBSSeekOutsideBufferS);
  ErrorCode := AbBBSSeekOutsideBuffer;
end;

constructor EAbBBSInvalidOrigin.Create;
begin
  inherited Create(AbBBSInvalidOriginS);
  ErrorCode := AbBBSInvalidOrigin;
end;

constructor EAbBBSWriteTooManyBytes.Create(Count: Integer);
begin
  inherited Create(Format(AbBBSWriteTooManyBytesS, [Count]));
  ErrorCode := AbBBSWriteTooManyBytes;
end;

constructor EAbVMSErrorOpenSwap.Create(const Value: string);
begin
  inherited Create(Format(AbVMSErrorOpenSwapS, [Value]));
  ErrorCode := AbVMSErrorOpenSwap;
end;

constructor EAbVMSSeekFail.Create(const Value: string);
begin
  inherited Create(Format(AbVMSSeekFailS, [Value]));
  ErrorCode := AbVMSSeekFail;
end;

constructor EAbVMSReadFail.Create(Count: Integer; const Value: string);
begin
  inherited Create(Format(AbVMSReadFailS, [Count, Value]));
  ErrorCode := AbVMSReadFail;
end;

constructor EAbVMSWriteFail.Create(Count: Integer; const Value: string);
begin
  inherited Create(Format(AbVMSWriteFailS, [Count, Value]));
  ErrorCode := AbVMSWriteFail;
end;

constructor EAbVMSWriteTooManyBytes.Create(Count: Integer);
begin
  inherited Create(Format(AbVMSWriteTooManyBytesS, [Count]));
  ErrorCode := AbVMSWriteTooManyBytes;
end;

constructor EAbSWSNotEndofStream.Create;
begin
  inherited Create(AbSWSNotEndofStreamS);
  ErrorCode := AbSWSNotEndofStream;
end;

constructor EAbSWSSeekFailed.Create;
begin
  inherited Create(AbSWSSeekFailedS);
  ErrorCode := AbSWSSeekFailed;
end;

constructor EAbSWSWriteFailed.Create;
begin
  inherited Create(AbSWSWriteFailedS);
  ErrorCode := AbSWSWriteFailed;
end;

constructor EAbSWSInvalidOrigin.Create;
begin
  inherited Create(AbSWSInvalidOriginS);
  ErrorCode := AbSWSInvalidOrigin;
end;

constructor EAbSWSInvalidNewOrigin.Create;
begin
  inherited Create(AbSWSInvalidNewOriginS);
  ErrorCode := AbSWSInvalidNewOrigin;
end;

constructor EAbFCIFileOpenError.Create;
begin
  inherited Create(AbFCIFileOpenErrorS);
  ErrorCode := AbFCIFileOpenError;
end;

constructor EAbNoCabinetDll.Create;
begin
  inherited Create(AbNoCabinetDllErrorS);
  ErrorCode := AbNoCabinetDllError;
end;

constructor EAbFCIFileReadError.Create;
begin
  inherited Create(AbFCIFileReadErrorS);
  ErrorCode := AbFCIFileReadError;
end;

constructor EAbFCIFileWriteError.Create;
begin
  inherited Create(AbFCIFileWriteErrorS);
  ErrorCode := AbFCIFileWriteError;
end;

constructor EAbFCIFileCloseError.Create;
begin
  inherited Create(AbFCIFileCloseErrorS);
  ErrorCode := AbFCIFileCloseError;
end;

constructor EAbFCIFileSeekError.Create;
begin
  inherited Create(AbFCIFileSeekErrorS);
  ErrorCode := AbFCIFileSeekError;
end;

constructor EAbFCIFileDeleteError.Create;
begin
  inherited Create(AbFCIFileDeleteErrorS);
  ErrorCode := AbFCIFileDeleteError;
end;

constructor EAbFCIAddFileError.Create;
begin
  inherited Create(AbFCIAddFileErrorS);
  ErrorCode := AbFCIAddFileError;
end;

constructor EAbFCICreateError.Create;
begin
  inherited Create(AbFCICreateErrorS);
  ErrorCode := AbFCICreateError;
end;

constructor EAbFCIFlushCabinetError.Create;
begin
  inherited Create(AbFCIFlushCabinetErrorS);
  ErrorCode := AbFCIFlushCabinetError;
end;

constructor EAbFCIFlushFolderError.Create;
begin
  inherited Create(AbFCIFlushFolderErrorS);
  ErrorCode := AbFCIFlushFolderError;
end;

constructor EAbFDICopyError.Create;
begin
  inherited Create(AbFDICopyErrorS);
  ErrorCode := AbFDICopyError;
end;

constructor EAbFDICreateError.Create;
begin
  inherited Create(AbFDICreateErrorS);
  ErrorCode := AbFDICreateError;
end;

constructor EAbInvalidCabTemplate.Create;
begin
  inherited Create(AbInvalidCabTemplateS);
  ErrorCode := AbInvalidCabTemplate;
end;

constructor EAbInvalidCabFile.Create;
begin
  inherited Create(AbInvalidCabFileS);
  ErrorCode := AbInvalidCabFile;
end;

procedure AbConvertException(const E: Exception; var eClass: TAbErrorClass;
  var eErrorCode: Integer);
begin
  eClass := ecOther;
  eErrorCode := 0;
  if E is EAbException then
  begin
    eClass := ecAbbrevia;
    eErrorCode := (E as EAbException).ErrorCode;
  end
  else if E is EInOutError then
  begin
    eClass := ecInOutError;
    eErrorCode := (E as EInOutError).ErrorCode;
  end
  else if E is EFilerError then
    eClass := ecFilerError
  else if E is EFOpenError then
    eClass := ecFileOpenError
  else if E is EFCreateError then
    eClass := ecFileCreateError;
end;

{ EAbUnhandledType }

constructor EAbUnhandledType.Create;
begin
  inherited Create(AbUnhandledFileTypeS);
  ErrorCode := AbUnhandledFileType;
end;

{ EAbGzipBadCRC }

constructor EAbGzipBadCRC.Create;
begin
  inherited Create(AbGzipBadCRCS);
  ErrorCode := AbGzipBadCRC;
end;

{ EAbGzipBadFileSize }

constructor EAbGzipBadFileSize.Create;
begin
  inherited Create(AbGzipBadFileSizeS);
  ErrorCode := AbGzipBadFileSize;
end;

{ EAbGzipInvalid }

constructor EAbGzipInvalid.Create;
begin
  inherited Create(AbSpanningNotSupportedS);
  ErrorCode := AbSpanningNotSupported;

end;

{ EAbTarInvalid }

constructor EAbTarInvalid.Create;
begin
  inherited Create(AbTarInvalidS);
  ErrorCode := AbTarInvalid;
end;

{ EAbTarBadFileName }

constructor EAbTarBadFileName.Create;
begin
  inherited Create(AbTarBadFileNameS);
  ErrorCode := AbTarBadFileName;
end;

{ EAbTarBadLinkName }

constructor EAbTarBadLinkName.Create;
begin
  inherited Create(AbTarBadLinkNameS);
  ErrorCode := AbTarBadLinkName;
end;

{ EAbTarBadOp }

constructor EAbTarBadOp.Create;
begin
  inherited Create(AbTarBadOpS);
  ErrorCode := AbTarBadOp;
end;

{ EAbSpanningNotSupported }

constructor EAbSpanningNotSupported.Create;
begin
  inherited Create(AbSpanningNotSupportedS);
  ErrorCode := AbSpanningNotSupported;
end;

{ EAbFileTooLarge }

constructor EAbFileTooLarge.Create;
begin
  { TODO Create const and fix wording }
  inherited Create(AbFileSizeTooBigS);
end;

end.
