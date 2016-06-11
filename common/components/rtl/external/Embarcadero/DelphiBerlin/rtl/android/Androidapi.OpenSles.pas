{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.OpenSles;

interface

(*$HPPEMIT '#include <SLES/OpenSLES.h>' *)
(*$HPPEMIT '#include <SLES/OpenSLES_Android.h>' *)

{$I Androidapi.inc}


  { OpenSLES_Platform.h }
  { ------------------- }


type
  sl_uint8_t = Byte;
  {$EXTERNALSYM sl_uint8_t}
  sl_int8_t = Byte;
  {$EXTERNALSYM sl_int8_t}
  sl_uint16_t = UInt16;
  {$EXTERNALSYM sl_uint16_t}
  sl_int16_t = Int16;
  {$EXTERNALSYM sl_int16_t}
  sl_uint32_t = UInt32;
  {$EXTERNALSYM sl_uint32_t}
  sl_int32_t = Int32;
  {$EXTERNALSYM sl_int32_t}
  sl_int64_t = Int64;
  {$EXTERNALSYM sl_int64_t}


  { OpenSLES.h }
  { ------------------- }


const
  KHRONOS_TITLE = 'KhronosTitle';
  {$EXTERNALSYM KHRONOS_TITLE}
  KHRONOS_ALBUM = 'KhronosAlbum';
  {$EXTERNALSYM KHRONOS_ALBUM}
  KHRONOS_TRACK_NUMBER = 'KhronosTrackNumber';
  {$EXTERNALSYM KHRONOS_TRACK_NUMBER}
  KHRONOS_ARTIST = 'KhronosArtist';
  {$EXTERNALSYM KHRONOS_ARTIST}
  KHRONOS_GENRE = 'KhronosGenre';
  {$EXTERNALSYM KHRONOS_GENRE}
  KHRONOS_YEAR = 'KhronosYear';
  {$EXTERNALSYM KHRONOS_YEAR}
  KHRONOS_COMMENT = 'KhronosComment';
  {$EXTERNALSYM KHRONOS_COMMENT}
  KHRONOS_ARTIST_URL = 'KhronosArtistURL';
  {$EXTERNALSYM KHRONOS_ARTIST_URL}
  KHRONOS_CONTENT_URL = 'KhronosContentURL';
  {$EXTERNALSYM KHRONOS_CONTENT_URL}
  KHRONOS_RATING = 'KhronosRating';
  {$EXTERNALSYM KHRONOS_RATING}
  KHRONOS_ALBUM_ART = 'KhronosAlbumArt';
  {$EXTERNALSYM KHRONOS_ALBUM_ART}
  KHRONOS_COPYRIGHT = 'KhronosCopyright';
  {$EXTERNALSYM KHRONOS_COPYRIGHT}

type
  SLint8 = Byte;
  {$EXTERNALSYM SLint8}
  SLuint8 = Byte;
  {$EXTERNALSYM SLuint8}
  SLint16 = Int16;
  {$EXTERNALSYM SLint16}
  SLuint16 = UInt16;
  {$EXTERNALSYM SLuint16}
  SLint32 = Int32;
  {$EXTERNALSYM SLint32}
  SLuint32 = UInt32;
  {$EXTERNALSYM SLuint32}
  SLboolean = SLuint32;
  {$EXTERNALSYM SLboolean}

  PSLint8 = ^SLint8;
  PSLuint8 = ^SLuint8;
  PSLint16 = ^SLint16;
  PSLuint16 = ^SLuint16;
  PSLint32 = ^SLint32;
  PSLuint32 = ^SLuint32;
  PSLboolean = ^SLboolean;

const
  SL_BOOLEAN_FALSE: SLboolean = $00000000;
  {$EXTERNALSYM SL_BOOLEAN_FALSE}
  SL_BOOLEAN_TRUE: SLboolean = $00000001;
  {$EXTERNALSYM SL_BOOLEAN_TRUE}

type
  SLchar = SLuint8; { UTF-8 is to be used }
  {$EXTERNALSYM SLchar}
  SLmillibel = SLint16;
  {$EXTERNALSYM SLmillibel}
  SLmillisecond = SLuint32;
  {$EXTERNALSYM SLmillisecond}
  SLmilliHertz = SLuint32;
  {$EXTERNALSYM SLmilliHertz}
  SLmillimeter = SLint32;
  {$EXTERNALSYM SLmillimeter}
  SLmillidegree = SLint32;
  {$EXTERNALSYM SLmillidegree}
  SLpermille = SLint16;
  {$EXTERNALSYM SLpermille}
  SLmicrosecond = SLuint32;
  {$EXTERNALSYM SLmicrosecond}
  SLresult = SLuint32;
  {$EXTERNALSYM SLresult}

  //PSLchar = ^SLchar;
  PSLchar = MarshaledAString;
  PPSLchar = ^PSLchar;
  PSLmillibel = ^SLmillibel;
  PSLmillisecond = ^SLmillisecond;
  PSLmilliHertz = ^SLmilliHertz;
  PSLmillimeter = ^SLmillimeter;
  PSLmillidegree = ^SLmillidegree;
  PSLpermille = ^SLpermille;
  PSLmicrosecond = ^SLmicrosecond;
  PSLresult = ^SLresult;

const
  SL_MILLIBEL_MAX: SLmillibel = $7FFF;
  {$EXTERNALSYM SL_MILLIBEL_MAX}
  SL_MILLIBEL_MIN: SLmillibel = ((-1) * $7FFF - 1);
  {$EXTERNALSYM SL_MILLIBEL_MIN}

  SL_MILLIHERTZ_MAX: SLmilliHertz = $FFFFFFFF;
  {$EXTERNALSYM SL_MILLIHERTZ_MAX}
  SL_MILLIMETER_MAX: SLmillimeter = $7FFFFFFF;
  {$EXTERNALSYM SL_MILLIMETER_MAX}

type

  SLInterfaceID = ^SLInterfaceID_;
  {$EXTERNALSYM SLInterfaceID}
  PSLInterfaceID = ^SLInterfaceID;

  SLInterfaceID_ = record
    time_low: SLuint32;
    time_mid: SLuint16;
    time_hi_and_version: SLuint16;
    clock_seq: SLuint16;
    node: array [0 .. 5] of SLuint8;
  end;
  {$EXTERNALSYM SLInterfaceID_}

  { --------------------------------------------------------------------------- }
  { Standard Object Interface }
  { --------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_OBJECT;

  PSLObjectItf_ = ^SLObjectItf_;
  SLObjectItf = ^PSLObjectItf_;
  {$EXTERNALSYM SLObjectItf}

  { Object callback }
  slObjectCallback = procedure(caller: SLObjectItf; const pContext: Pointer;
    event: SLuint32; result: SLresult; param: SLuint32; pInterface: Pointer); cdecl;

  SLObjectItf_ = record
    Realize: function(self: SLObjectItf; _async: SLboolean): SLresult; cdecl;
    Resume: function(self: SLObjectItf; async: SLboolean): SLresult; cdecl;
    GetState: function(self: SLObjectItf; pState: PSLuint32): SLresult; cdecl;
    GetInterface: function(self: SLObjectItf; const iid: SLInterfaceID;
      pInterface: Pointer): SLresult; cdecl;
    RegisterCallback: function(self: SLObjectItf; callback: slObjectCallback;
      pContext: Pointer): SLresult; cdecl;
    AbortAsyncOperation: procedure(self: SLObjectItf); cdecl;
    Destroy: procedure(self: SLObjectItf); cdecl;
    SetPriority: function(self: SLObjectItf; priority: SLint32;
      preemptable: SLboolean): SLresult; cdecl;
    GetPriority: function(self: SLObjectItf; pPriority: PSLint32;
      pPreemptable: PSLboolean): SLresult; cdecl;
    SetLossOfControlInterfaces: function(self: SLObjectItf;
      numInterfaces: SLint16; pInterfaceIDs: PSLInterfaceID; enabled: SLboolean)
: SLresult;
  end;
  {$EXTERNALSYM SLObjectItf_}

  PSLObjectItf = ^SLObjectItf;

const
  { Objects ID's }
  SL_OBJECTID_ENGINE: SLuint32 = $00001001;
  {$EXTERNALSYM SL_OBJECTID_ENGINE}
  SL_OBJECTID_LEDDEVICE: SLuint32 = $00001002;
  {$EXTERNALSYM SL_OBJECTID_LEDDEVICE}
  SL_OBJECTID_VIBRADEVICE: SLuint32 = $00001003;
  {$EXTERNALSYM SL_OBJECTID_VIBRADEVICE}
  SL_OBJECTID_AUDIOPLAYER: SLuint32 = $00001004;
  {$EXTERNALSYM SL_OBJECTID_AUDIOPLAYER}
  SL_OBJECTID_AUDIORECORDER: SLuint32 = $00001005;
  {$EXTERNALSYM SL_OBJECTID_AUDIORECORDER}
  SL_OBJECTID_MIDIPLAYER: SLuint32 = $00001006;
  {$EXTERNALSYM SL_OBJECTID_MIDIPLAYER}
  SL_OBJECTID_LISTENER: SLuint32 = $00001007;
  {$EXTERNALSYM SL_OBJECTID_LISTENER}
  SL_OBJECTID_3DGROUP: SLuint32 = $00001008;
  {$EXTERNALSYM SL_OBJECTID_3DGROUP}
  SL_OBJECTID_OUTPUTMIX: SLuint32 = $00001009;
  {$EXTERNALSYM SL_OBJECTID_OUTPUTMIX}
  SL_OBJECTID_METADATAEXTRACTOR: SLuint32 = $0000100A;
  {$EXTERNALSYM SL_OBJECTID_METADATAEXTRACTOR}

  { SL Profiles }
  SL_PROFILES_PHONE: SLuint16 = $0001;
  {$EXTERNALSYM SL_PROFILES_PHONE}
  SL_PROFILES_MUSIC: SLuint16 = $0002;
  {$EXTERNALSYM SL_PROFILES_MUSIC}
  SL_PROFILES_GAME: SLuint16 = $0004;
  {$EXTERNALSYM SL_PROFILES_GAME}

  { Types of voices supported by the system }
  SL_VOICETYPE_2D_AUDIO: SLuint16 = $0001;
  {$EXTERNALSYM SL_VOICETYPE_2D_AUDIO}
  SL_VOICETYPE_MIDI: SLuint16 = $0002;
  {$EXTERNALSYM SL_VOICETYPE_MIDI}
  SL_VOICETYPE_3D_AUDIO: SLuint16 = $0004;
  {$EXTERNALSYM SL_VOICETYPE_3D_AUDIO}
  SL_VOICETYPE_3D_MIDIOUTPUT: SLuint16 = $0008;
  {$EXTERNALSYM SL_VOICETYPE_3D_MIDIOUTPUT}

  { Convenient macros representing various different priority levels, for use with the SetPriority method }
  SL_PRIORITY_LOWEST: SLint32 = -$7FFFFFFF - 1;
  {$EXTERNALSYM SL_PRIORITY_LOWEST}
  SL_PRIORITY_VERYLOW: SLint32 = -$60000000;
  {$EXTERNALSYM SL_PRIORITY_VERYLOW}
  SL_PRIORITY_LOW: SLint32 = -$40000000;
  {$EXTERNALSYM SL_PRIORITY_LOW}
  SL_PRIORITY_BELOWNORMAL: SLint32 = -$20000000;
  {$EXTERNALSYM SL_PRIORITY_BELOWNORMAL}
  SL_PRIORITY_NORMAL: SLint32 = $00000000;
  {$EXTERNALSYM SL_PRIORITY_NORMAL}
  SL_PRIORITY_ABOVENORMAL: SLint32 = $20000000;
  {$EXTERNALSYM SL_PRIORITY_ABOVENORMAL}
  SL_PRIORITY_HIGH: SLint32 = $40000000;
  {$EXTERNALSYM SL_PRIORITY_HIGH}
  SL_PRIORITY_VERYHIGH: SLint32 = $60000000;
  {$EXTERNALSYM SL_PRIORITY_VERYHIGH}
  SL_PRIORITY_HIGHEST: SLint32 = $7FFFFFFF;
  {$EXTERNALSYM SL_PRIORITY_HIGHEST}

  { These macros list the various sample formats that are possible on audio input and output devices. }
  SL_PCMSAMPLEFORMAT_FIXED_8: SLuint16 = $0008;
  {$EXTERNALSYM SL_PCMSAMPLEFORMAT_FIXED_8}
  SL_PCMSAMPLEFORMAT_FIXED_16: SLuint16 = $0010;
  {$EXTERNALSYM SL_PCMSAMPLEFORMAT_FIXED_16}
  SL_PCMSAMPLEFORMAT_FIXED_20: SLuint16 = $0014;
  {$EXTERNALSYM SL_PCMSAMPLEFORMAT_FIXED_20}
  SL_PCMSAMPLEFORMAT_FIXED_24: SLuint16 = $0018;
  {$EXTERNALSYM SL_PCMSAMPLEFORMAT_FIXED_24}
  SL_PCMSAMPLEFORMAT_FIXED_28: SLuint16 = $001C;
  {$EXTERNALSYM SL_PCMSAMPLEFORMAT_FIXED_28}
  SL_PCMSAMPLEFORMAT_FIXED_32: SLuint16 = $0020;
  {$EXTERNALSYM SL_PCMSAMPLEFORMAT_FIXED_32}

  { These macros specify the commonly used sampling rates (in milliHertz) supported by most audio I/O devices. }
  SL_SAMPLINGRATE_8: SLuint32 = 8000000;
  {$EXTERNALSYM SL_SAMPLINGRATE_8}
  SL_SAMPLINGRATE_11_025: SLuint32 = 11025000;
  {$EXTERNALSYM SL_SAMPLINGRATE_11_025}
  SL_SAMPLINGRATE_12: SLuint32 = 12000000;
  {$EXTERNALSYM SL_SAMPLINGRATE_12}
  SL_SAMPLINGRATE_16: SLuint32 = 16000000;
  {$EXTERNALSYM SL_SAMPLINGRATE_16}
  SL_SAMPLINGRATE_22_05: SLuint32 = 22050000;
  {$EXTERNALSYM SL_SAMPLINGRATE_22_05}
  SL_SAMPLINGRATE_24: SLuint32 = 24000000;
  {$EXTERNALSYM SL_SAMPLINGRATE_24}
  SL_SAMPLINGRATE_32: SLuint32 = 32000000;
  {$EXTERNALSYM SL_SAMPLINGRATE_32}
  SL_SAMPLINGRATE_44_1: SLuint32 = 44100000;
  {$EXTERNALSYM SL_SAMPLINGRATE_44_1}
  SL_SAMPLINGRATE_48: SLuint32 = 48000000;
  {$EXTERNALSYM SL_SAMPLINGRATE_48}
  SL_SAMPLINGRATE_64: SLuint32 = 64000000;
  {$EXTERNALSYM SL_SAMPLINGRATE_64}
  SL_SAMPLINGRATE_88_2: SLuint32 = 88200000;
  {$EXTERNALSYM SL_SAMPLINGRATE_88_2}
  SL_SAMPLINGRATE_96: SLuint32 = 96000000;
  {$EXTERNALSYM SL_SAMPLINGRATE_96}
  SL_SAMPLINGRATE_192: SLuint32 = 192000000;
  {$EXTERNALSYM SL_SAMPLINGRATE_192}
  SL_SPEAKER_FRONT_LEFT: SLuint32 = $00000001;
  {$EXTERNALSYM SL_SPEAKER_FRONT_LEFT}
  SL_SPEAKER_FRONT_RIGHT: SLuint32 = $00000002;
  {$EXTERNALSYM SL_SPEAKER_FRONT_RIGHT}
  SL_SPEAKER_FRONT_CENTER: SLuint32 = $00000004;
  {$EXTERNALSYM SL_SPEAKER_FRONT_CENTER}
  SL_SPEAKER_LOW_FREQUENCY: SLuint32 = $00000008;
  {$EXTERNALSYM SL_SPEAKER_LOW_FREQUENCY}
  SL_SPEAKER_BACK_LEFT: SLuint32 = $00000010;
  {$EXTERNALSYM SL_SPEAKER_BACK_LEFT}
  SL_SPEAKER_BACK_RIGHT: SLuint32 = $00000020;
  {$EXTERNALSYM SL_SPEAKER_BACK_RIGHT}
  SL_SPEAKER_FRONT_LEFT_OF_CENTER: SLuint32 = $00000040;
  {$EXTERNALSYM SL_SPEAKER_FRONT_LEFT_OF_CENTER}
  SL_SPEAKER_FRONT_RIGHT_OF_CENTER: SLuint32 = $00000080;
  {$EXTERNALSYM SL_SPEAKER_FRONT_RIGHT_OF_CENTER}
  SL_SPEAKER_BACK_CENTER: SLuint32 = $00000100;
  {$EXTERNALSYM SL_SPEAKER_BACK_CENTER}
  SL_SPEAKER_SIDE_LEFT: SLuint32 = $00000200;
  {$EXTERNALSYM SL_SPEAKER_SIDE_LEFT}
  SL_SPEAKER_SIDE_RIGHT: SLuint32 = $00000400;
  {$EXTERNALSYM SL_SPEAKER_SIDE_RIGHT}
  SL_SPEAKER_TOP_CENTER: SLuint32 = $00000800;
  {$EXTERNALSYM SL_SPEAKER_TOP_CENTER}
  SL_SPEAKER_TOP_FRONT_LEFT: SLuint32 = $00001000;
  {$EXTERNALSYM SL_SPEAKER_TOP_FRONT_LEFT}
  SL_SPEAKER_TOP_FRONT_CENTER: SLuint32 = $00002000;
  {$EXTERNALSYM SL_SPEAKER_TOP_FRONT_CENTER}
  SL_SPEAKER_TOP_FRONT_RIGHT: SLuint32 = $00004000;
  {$EXTERNALSYM SL_SPEAKER_TOP_FRONT_RIGHT}
  SL_SPEAKER_TOP_BACK_LEFT: SLuint32 = $00008000;
  {$EXTERNALSYM SL_SPEAKER_TOP_BACK_LEFT}
  SL_SPEAKER_TOP_BACK_CENTER: SLuint32 = $00010000;
  {$EXTERNALSYM SL_SPEAKER_TOP_BACK_CENTER}
  SL_SPEAKER_TOP_BACK_RIGHT: SLuint32 = $00020000;
  {$EXTERNALSYM SL_SPEAKER_TOP_BACK_RIGHT}

  { *************************************************************************** }
  { Errors }
  {                                                                             }
  { *************************************************************************** }

  SL_RESULT_SUCCESS: SLuint32 = $00000000;
  {$EXTERNALSYM SL_RESULT_SUCCESS}
  SL_RESULT_PRECONDITIONS_VIOLATED: SLuint32 = $00000001;
  {$EXTERNALSYM SL_RESULT_PRECONDITIONS_VIOLATED}
  SL_RESULT_PARAMETER_INVALID: SLuint32 = $00000002;
  {$EXTERNALSYM SL_RESULT_PARAMETER_INVALID}
  SL_RESULT_MEMORY_FAILURE: SLuint32 = $00000003;
  {$EXTERNALSYM SL_RESULT_MEMORY_FAILURE}
  SL_RESULT_RESOURCE_ERROR: SLuint32 = $00000004;
  {$EXTERNALSYM SL_RESULT_RESOURCE_ERROR}
  SL_RESULT_RESOURCE_LOST: SLuint32 = $00000005;
  {$EXTERNALSYM SL_RESULT_RESOURCE_LOST}
  SL_RESULT_IO_ERROR: SLuint32 = $00000006;
  {$EXTERNALSYM SL_RESULT_IO_ERROR}
  SL_RESULT_BUFFER_INSUFFICIENT: SLuint32 = $00000007;
  {$EXTERNALSYM SL_RESULT_BUFFER_INSUFFICIENT}
  SL_RESULT_CONTENT_CORRUPTED: SLuint32 = $00000008;
  {$EXTERNALSYM SL_RESULT_CONTENT_CORRUPTED}
  SL_RESULT_CONTENT_UNSUPPORTED: SLuint32 = $00000009;
  {$EXTERNALSYM SL_RESULT_CONTENT_UNSUPPORTED}
  SL_RESULT_CONTENT_NOT_FOUND: SLuint32 = $0000000A;
  {$EXTERNALSYM SL_RESULT_CONTENT_NOT_FOUND}
  SL_RESULT_PERMISSION_DENIED: SLuint32 = $0000000B;
  {$EXTERNALSYM SL_RESULT_PERMISSION_DENIED}
  SL_RESULT_FEATURE_UNSUPPORTED: SLuint32 = $0000000C;
  {$EXTERNALSYM SL_RESULT_FEATURE_UNSUPPORTED}
  SL_RESULT_INTERNAL_ERROR: SLuint32 = $0000000D;
  {$EXTERNALSYM SL_RESULT_INTERNAL_ERROR}
  SL_RESULT_UNKNOWN_ERROR: SLuint32 = $0000000E;
  {$EXTERNALSYM SL_RESULT_UNKNOWN_ERROR}
  SL_RESULT_OPERATION_ABORTED: SLuint32 = $0000000F;
  {$EXTERNALSYM SL_RESULT_OPERATION_ABORTED}
  SL_RESULT_CONTROL_LOST: SLuint32 = $00000010;
  {$EXTERNALSYM SL_RESULT_CONTROL_LOST}

  { Object state definitions }
  SL_OBJECT_STATE_UNREALIZED: SLuint32 = $00000001;
  {$EXTERNALSYM SL_OBJECT_STATE_UNREALIZED}
  SL_OBJECT_STATE_REALIZED: SLuint32 = $00000002;
  {$EXTERNALSYM SL_OBJECT_STATE_REALIZED}
  SL_OBJECT_STATE_SUSPENDED: SLuint32 = $00000003;
  {$EXTERNALSYM SL_OBJECT_STATE_SUSPENDED}

  { Object event definitions }
  SL_OBJECT_EVENT_RUNTIME_ERROR: SLuint32 = $00000001;
  {$EXTERNALSYM SL_OBJECT_EVENT_RUNTIME_ERROR}
  SL_OBJECT_EVENT_ASYNC_TERMINATION: SLuint32 = $00000002;
  {$EXTERNALSYM SL_OBJECT_EVENT_ASYNC_TERMINATION}
  SL_OBJECT_EVENT_RESOURCES_LOST: SLuint32 = $00000003;
  {$EXTERNALSYM SL_OBJECT_EVENT_RESOURCES_LOST}
  SL_OBJECT_EVENT_RESOURCES_AVAILABLE: SLuint32 = $00000004;
  {$EXTERNALSYM SL_OBJECT_EVENT_RESOURCES_AVAILABLE}
  SL_OBJECT_EVENT_ITF_CONTROL_TAKEN: SLuint32 = $00000005;
  {$EXTERNALSYM SL_OBJECT_EVENT_ITF_CONTROL_TAKEN}
  SL_OBJECT_EVENT_ITF_CONTROL_RETURNED: SLuint32 = $00000006;
  {$EXTERNALSYM SL_OBJECT_EVENT_ITF_CONTROL_RETURNED}
  SL_OBJECT_EVENT_ITF_PARAMETERS_CHANGED: SLuint32 = $00000007;
  {$EXTERNALSYM SL_OBJECT_EVENT_ITF_PARAMETERS_CHANGED}

  { *************************************************************************** }
  { Interface definitions }
  { *************************************************************************** }

  { NULL Interface }
  // extern SLAPIENTRY const SLInterfaceID SL_IID_NULL;

  { --------------------------------------------------------------------------- }
  { Data Source and Data Sink Structures }
  { --------------------------------------------------------------------------- }

  { Data locator macros }
  SL_DATALOCATOR_URI: SLuint32 = $00000001;
  {$EXTERNALSYM SL_DATALOCATOR_URI}
  SL_DATALOCATOR_ADDRESS: SLuint32 = $00000002;
  {$EXTERNALSYM SL_DATALOCATOR_ADDRESS}
  SL_DATALOCATOR_IODEVICE: SLuint32 = $00000003;
  {$EXTERNALSYM SL_DATALOCATOR_IODEVICE}
  SL_DATALOCATOR_OUTPUTMIX: SLuint32 = $00000004;
  {$EXTERNALSYM SL_DATALOCATOR_OUTPUTMIX}
  SL_DATALOCATOR_RESERVED5: SLuint32 = $00000005;
  {$EXTERNALSYM SL_DATALOCATOR_RESERVED5}
  SL_DATALOCATOR_BUFFERQUEUE: SLuint32 = $00000006;
  {$EXTERNALSYM SL_DATALOCATOR_BUFFERQUEUE}
  SL_DATALOCATOR_MIDIBUFFERQUEUE: SLuint32 = $00000007;
  {$EXTERNALSYM SL_DATALOCATOR_MIDIBUFFERQUEUE}
  SL_DATALOCATOR_RESERVED8: SLuint32 = $00000008;
  {$EXTERNALSYM SL_DATALOCATOR_RESERVED8}

type

  { URI-based data locator definition where locatorType must be SL_DATALOCATOR_URI }
  SLDataLocator_URI = record
    locatorType: SLuint32;
    URI: PSLchar;
  end;
  {$EXTERNALSYM SLDataLocator_URI}

  PSLDataLocator_URI = ^SLDataLocator_URI;

  { Address-based data locator definition where locatorType must be SL_DATALOCATOR_ADDRESS }
  SLDataLocator_Address = record
    locatorType: SLuint32;
    pAddress: Pointer;
    length: SLuint32;
  end;
  {$EXTERNALSYM SLDataLocator_Address}

  PSLDataLocator_Address = ^SLDataLocator_Address;

const
  { IODevice-types }
  SL_IODEVICE_AUDIOINPUT: SLuint32 = $00000001;
  {$EXTERNALSYM SL_IODEVICE_AUDIOINPUT}
  SL_IODEVICE_LEDARRAY: SLuint32 = $00000002;
  {$EXTERNALSYM SL_IODEVICE_LEDARRAY}
  SL_IODEVICE_VIBRA: SLuint32 = $00000003;
  {$EXTERNALSYM SL_IODEVICE_VIBRA}
  SL_IODEVICE_RESERVED4: SLuint32 = $00000004;
  {$EXTERNALSYM SL_IODEVICE_RESERVED4}
  SL_IODEVICE_RESERVED5: SLuint32 = $00000005;
  {$EXTERNALSYM SL_IODEVICE_RESERVED5}

type
  { IODevice-based data locator definition where locatorType must be SL_DATALOCATOR_IODEVICE }
  SLDataLocator_IODevice = record
    locatorType: SLuint32;
    deviceType: SLuint32;
    deviceID: SLuint32;
    device: SLObjectItf;
  end;
  {$EXTERNALSYM SLDataLocator_IODevice}

  PSLDataLocator_IODevice = ^SLDataLocator_IODevice;

  { OutputMix-based data locator definition where locatorType must be SL_DATALOCATOR_OUTPUTMIX }
  SLDataLocator_OutputMix = record
    locatorType: SLuint32;
    outputMix: SLObjectItf;
  end;
  {$EXTERNALSYM SLDataLocator_OutputMix}

  PSLDataLocator_OutputMix = ^SLDataLocator_OutputMix;

  { BufferQueue-based data locator definition where locatorType must be SL_DATALOCATOR_BUFFERQUEUE }
  SLDataLocator_BufferQueue = record
    locatorType: SLuint32;
    numBuffers: SLuint32;
  end;
  {$EXTERNALSYM SLDataLocator_BufferQueue}

  PSLDataLocator_BufferQueue = ^SLDataLocator_BufferQueue;

  { MidiBufferQueue-based data locator definition where locatorType must be SL_DATALOCATOR_MIDIBUFFERQUEUE }
  SLDataLocator_MIDIBufferQueue = record
    locatorType: SLuint32;
    tpqn: SLuint32;
    numBuffers: SLuint32;
  end;
  {$EXTERNALSYM SLDataLocator_MIDIBufferQueue}

  PSLDataLocator_MIDIBufferQueue = ^SLDataLocator_MIDIBufferQueue;

const
  { Data format defines }
  SL_DATAFORMAT_MIME: SLuint32 = $00000001;
  {$EXTERNALSYM SL_DATAFORMAT_MIME}
  SL_DATAFORMAT_PCM: SLuint32 = $00000002;
  {$EXTERNALSYM SL_DATAFORMAT_PCM}
  SL_DATAFORMAT_RESERVED3: SLuint32 = $00000003;
  {$EXTERNALSYM SL_DATAFORMAT_RESERVED3}

type
  { MIME-type-based data format definition where formatType must be SL_DATAFORMAT_MIME }
  SLDataFormat_MIME = record
    formatType: SLuint32;
    mimeType: PSLchar;
    containerType: SLuint32;
  end;
  {$EXTERNALSYM SLDataFormat_MIME}

  PSLDataFormat_MIME = ^SLDataFormat_MIME;

const
  { Byte order of a block of 16- or 32-bit data }
  SL_BYTEORDER_BIGENDIAN: SLuint32 = $00000001;
  {$EXTERNALSYM SL_BYTEORDER_BIGENDIAN}
  SL_BYTEORDER_LITTLEENDIAN: SLuint32 = $00000002;
  {$EXTERNALSYM SL_BYTEORDER_LITTLEENDIAN}
  { Container type }
  SL_CONTAINERTYPE_UNSPECIFIED: SLuint32 = $00000001;
  {$EXTERNALSYM SL_CONTAINERTYPE_UNSPECIFIED}
  SL_CONTAINERTYPE_RAW: SLuint32 = $00000002;
  {$EXTERNALSYM SL_CONTAINERTYPE_RAW}
  SL_CONTAINERTYPE_ASF: SLuint32 = $00000003;
  {$EXTERNALSYM SL_CONTAINERTYPE_ASF}
  SL_CONTAINERTYPE_AVI: SLuint32 = $00000004;
  {$EXTERNALSYM SL_CONTAINERTYPE_AVI}
  SL_CONTAINERTYPE_BMP: SLuint32 = $00000005;
  {$EXTERNALSYM SL_CONTAINERTYPE_BMP}
  SL_CONTAINERTYPE_JPG: SLuint32 = $00000006;
  {$EXTERNALSYM SL_CONTAINERTYPE_JPG}
  SL_CONTAINERTYPE_JPG2000: SLuint32 = $00000007;
  {$EXTERNALSYM SL_CONTAINERTYPE_JPG2000}
  SL_CONTAINERTYPE_M4A: SLuint32 = $00000008;
  {$EXTERNALSYM SL_CONTAINERTYPE_M4A}
  SL_CONTAINERTYPE_MP3: SLuint32 = $00000009;
  {$EXTERNALSYM SL_CONTAINERTYPE_MP3}
  SL_CONTAINERTYPE_MP4: SLuint32 = $0000000A;
  {$EXTERNALSYM SL_CONTAINERTYPE_MP4}
  SL_CONTAINERTYPE_MPEG_ES: SLuint32 = $0000000B;
  {$EXTERNALSYM SL_CONTAINERTYPE_MPEG_ES}
  SL_CONTAINERTYPE_MPEG_PS: SLuint32 = $0000000C;
  {$EXTERNALSYM SL_CONTAINERTYPE_MPEG_PS}
  SL_CONTAINERTYPE_MPEG_TS: SLuint32 = $0000000D;
  {$EXTERNALSYM SL_CONTAINERTYPE_MPEG_TS}
  SL_CONTAINERTYPE_QT: SLuint32 = $0000000E;
  {$EXTERNALSYM SL_CONTAINERTYPE_QT}
  SL_CONTAINERTYPE_WAV: SLuint32 = $0000000F;
  {$EXTERNALSYM SL_CONTAINERTYPE_WAV}
  SL_CONTAINERTYPE_XMF_0: SLuint32 = $00000010;
  {$EXTERNALSYM SL_CONTAINERTYPE_XMF_0}
  SL_CONTAINERTYPE_XMF_1: SLuint32 = $00000011;
  {$EXTERNALSYM SL_CONTAINERTYPE_XMF_1}
  SL_CONTAINERTYPE_XMF_2: SLuint32 = $00000012;
  {$EXTERNALSYM SL_CONTAINERTYPE_XMF_2}
  SL_CONTAINERTYPE_XMF_3: SLuint32 = $00000013;
  {$EXTERNALSYM SL_CONTAINERTYPE_XMF_3}
  SL_CONTAINERTYPE_XMF_GENERIC: SLuint32 = $00000014;
  {$EXTERNALSYM SL_CONTAINERTYPE_XMF_GENERIC}
  SL_CONTAINERTYPE_AMR: SLuint32 = $00000015;
  {$EXTERNALSYM SL_CONTAINERTYPE_AMR}
  SL_CONTAINERTYPE_AAC: SLuint32 = $00000016;
  {$EXTERNALSYM SL_CONTAINERTYPE_AAC}
  SL_CONTAINERTYPE_3GPP: SLuint32 = $00000017;
  {$EXTERNALSYM SL_CONTAINERTYPE_3GPP}
  SL_CONTAINERTYPE_3GA: SLuint32 = $00000018;
  {$EXTERNALSYM SL_CONTAINERTYPE_3GA}
  SL_CONTAINERTYPE_RM: SLuint32 = $00000019;
  {$EXTERNALSYM SL_CONTAINERTYPE_RM}
  SL_CONTAINERTYPE_DMF: SLuint32 = $0000001A;
  {$EXTERNALSYM SL_CONTAINERTYPE_DMF}
  SL_CONTAINERTYPE_SMF: SLuint32 = $0000001B;
  {$EXTERNALSYM SL_CONTAINERTYPE_SMF}
  SL_CONTAINERTYPE_MOBILE_DLS: SLuint32 = $0000001C;
  {$EXTERNALSYM SL_CONTAINERTYPE_MOBILE_DLS}
  SL_CONTAINERTYPE_OGG: SLuint32 = $0000001D;
  {$EXTERNALSYM SL_CONTAINERTYPE_OGG}

type
  { PCM-type-based data format definition where formatType must be SL_DATAFORMAT_PCM }
  SLDataFormat_PCM = record
    formatType: SLuint32;
    numChannels: SLuint32;
    samplesPerSec: SLuint32;
    bitsPerSample: SLuint32;
    containerSize: SLuint32;
    channelMask: SLuint32;
    endianness: SLuint32;
  end;
  {$EXTERNALSYM SLDataFormat_PCM}

  PSLDataFormat_PCM = ^SLDataFormat_PCM;

  SLDataSource = record
    pLocator: Pointer;
    pFormat: Pointer;
  end;
  {$EXTERNALSYM SLDataSource}

  PSLDataSource = ^SLDataSource;

  SLDataSink = record
    pLocator: Pointer;
    pFormat: Pointer;
  end;
  {$EXTERNALSYM SLDataSink}

  PSLDataSink = ^SLDataSink;

  { --------------------------------------------------------------------------- }
  { Audio IO Device capabilities interface }
  { --------------------------------------------------------------------------- }
const
  SL_DEFAULTDEVICEID_AUDIOINPUT: SLuint32 = $FFFFFFFF;
  {$EXTERNALSYM SL_DEFAULTDEVICEID_AUDIOINPUT}
  SL_DEFAULTDEVICEID_AUDIOOUTPUT: SLuint32 = $FFFFFFFE;
  {$EXTERNALSYM SL_DEFAULTDEVICEID_AUDIOOUTPUT}
  SL_DEFAULTDEVICEID_LED: SLuint32 = $FFFFFFFD;
  {$EXTERNALSYM SL_DEFAULTDEVICEID_LED}
  SL_DEFAULTDEVICEID_VIBRA: SLuint32 = $FFFFFFFC;
  {$EXTERNALSYM SL_DEFAULTDEVICEID_VIBRA}
  SL_DEFAULTDEVICEID_RESERVED1: SLuint32 = $FFFFFFFB;
  {$EXTERNALSYM SL_DEFAULTDEVICEID_RESERVED1}
  SL_DEVCONNECTION_INTEGRATED: SLint16 = $0001;
  {$EXTERNALSYM SL_DEVCONNECTION_INTEGRATED}
  SL_DEVCONNECTION_ATTACHED_WIRED: SLint16 = $0100;
  {$EXTERNALSYM SL_DEVCONNECTION_ATTACHED_WIRED}
  SL_DEVCONNECTION_ATTACHED_WIRELESS: SLint16 = $0200;
  {$EXTERNALSYM SL_DEVCONNECTION_ATTACHED_WIRELESS}
  SL_DEVCONNECTION_NETWORK: SLint16 = $0400;
  {$EXTERNALSYM SL_DEVCONNECTION_NETWORK}
  SL_DEVLOCATION_HANDSET: SLuint16 = $0001;
  {$EXTERNALSYM SL_DEVLOCATION_HANDSET}
  SL_DEVLOCATION_HEADSET: SLuint16 = $0002;
  {$EXTERNALSYM SL_DEVLOCATION_HEADSET}
  SL_DEVLOCATION_CARKIT: SLuint16 = $0003;
  {$EXTERNALSYM SL_DEVLOCATION_CARKIT}
  SL_DEVLOCATION_DOCK: SLuint16 = $0004;
  {$EXTERNALSYM SL_DEVLOCATION_DOCK}
  SL_DEVLOCATION_REMOTE: SLuint16 = $0005;
  {$EXTERNALSYM SL_DEVLOCATION_REMOTE}
  { Note: SL_DEVLOCATION_RESLTE is deprecated, use SL_DEVLOCATION_REMOTE instead. }
  SL_DEVLOCATION_RESLTE: SLuint16 = $0005;
  {$EXTERNALSYM SL_DEVLOCATION_RESLTE}
  SL_DEVSCOPE_UNKNOWN: SLuint16 = $0001;
  {$EXTERNALSYM SL_DEVSCOPE_UNKNOWN}
  SL_DEVSCOPE_ENVIRONMENT: SLuint16 = $0002;
  {$EXTERNALSYM SL_DEVSCOPE_ENVIRONMENT}
  SL_DEVSCOPE_USER: SLuint16 = $0003;
  {$EXTERNALSYM SL_DEVSCOPE_USER}

type
  SLAudioInputDescriptor = record
    deviceName: PSLchar;
    deviceConnection: SLint16;
    deviceScope: SLint16;
    deviceLocation: SLint16;
    isForTelephony: SLboolean;
    minSampleRate: SLmilliHertz;
    maxSampleRate: SLmilliHertz;
    isFreqRangeContinuous: SLboolean;
    samplingRatesSupported: PSLmilliHertz;
    numOfSamplingRatesSupported: SLint16;
    maxChannels: SLint16;
  end;
  {$EXTERNALSYM SLAudioInputDescriptor}

  PSLAudioInputDescriptor = ^SLAudioInputDescriptor;

  SLAudioOutputDescriptor = record
    pDeviceName: PSLchar;
    deviceConnection: SLint16;
    deviceScope: SLint16;
    deviceLocation: SLint16;
    isForTelephony: SLboolean;
    minSampleRate: SLmilliHertz;
    maxSampleRate: SLmilliHertz;
    isFreqRangeContinuous: SLboolean;
    samplingRatesSupported: PSLmilliHertz;
    numOfSamplingRatesSupported: SLint16;
    maxChannels: SLint16;
  end;
  {$EXTERNALSYM SLAudioOutputDescriptor}

  PSLAudioOutputDescriptor = ^SLAudioOutputDescriptor;

  
  // extern SLAPIENTRY const SLInterfaceID SL_IID_AUDIOIODEVICECAPABILITIES;

  PSLAudioIODeviceCapabilitiesItf_ = ^SLAudioIODeviceCapabilitiesItf_;
  SLAudioIODeviceCapabilitiesItf = ^PSLAudioIODeviceCapabilitiesItf_;
  {$EXTERNALSYM SLAudioIODeviceCapabilitiesItf}

  slAvailableAudioInputsChangedCallback = procedure
    (caller: SLAudioIODeviceCapabilitiesItf; pContext: Pointer;
    deviceID: SLuint32; numInputs: SLint32; isNew: SLboolean); cdecl;
  slAvailableAudioOutputsChangedCallback = procedure
    (caller: SLAudioIODeviceCapabilitiesItf; pContext: Pointer;
    deviceID: SLuint32; numOutputs: SLint32; isNew: SLboolean); cdecl;
  slDefaultDeviceIDMapChangedCallback = procedure
    (caller: SLAudioIODeviceCapabilitiesItf; pContext: Pointer;
    isOutput: SLboolean; numDevices: SLint32); cdecl;

  SLAudioIODeviceCapabilitiesItf_ = record
    GetAvailableAudioInputs: function(self: SLAudioIODeviceCapabilitiesItf;
      pNumInputs: PSLint32; pInputDeviceIDs: PSLuint32): SLresult; cdecl;
    QueryAudioInputCapabilities: function(self: SLAudioIODeviceCapabilitiesItf;
      deviceID: SLuint32; pDescriptor: PSLAudioInputDescriptor): SLresult; cdecl;
    RegisterAvailableAudioInputsChangedCallback: function(self: SLAudioIODeviceCapabilitiesItf;
      callback: slAvailableAudioInputsChangedCallback; pContext: Pointer): SLresult;
    GetAvailableAudioOutputs: function(self: SLAudioIODeviceCapabilitiesItf;
      pNumOutputs: PSLint32; pOutputDeviceIDs: PSLuint32): SLresult; cdecl;
    QueryAudioOutputCapabilities: function(self: SLAudioIODeviceCapabilitiesItf;
      deviceID: SLuint32; pDescriptor: PSLAudioOutputDescriptor): SLresult; cdecl;
    RegisterAvailableAudioOutputsChangedCallback: function(self: SLAudioIODeviceCapabilitiesItf;
      callback: slAvailableAudioOutputsChangedCallback; pContext: Pointer): SLresult;
    RegisterDefaultDeviceIDMapChangedCallback: function(self: SLAudioIODeviceCapabilitiesItf;
      callback: slDefaultDeviceIDMapChangedCallback; pContext: Pointer): SLresult;
    GetAssociatedAudioInputs: function(self: SLAudioIODeviceCapabilitiesItf;
      deviceID: SLuint32; pNumAudioInputs: PSLint32;
      pAudioInputDeviceIDs: PSLuint32): SLresult; cdecl;
    GetAssociatedAudioOutputs: function(self: SLAudioIODeviceCapabilitiesItf;
      deviceID: SLuint32; pNumAudioOutputs: PSLint32;
      pAudioOutputDeviceIDs: PSLuint32): SLresult; cdecl;
    GetDefaultAudioDevices: function(self: SLAudioIODeviceCapabilitiesItf;
      defaultDeviceID: SLuint32; pNumAudioDevices: PSLint32;
      pAudioDeviceIDs: PSLuint32): SLresult; cdecl;
    QuerySampleFormatsSupported: function(self: SLAudioIODeviceCapabilitiesItf;
      deviceID: SLuint32; samplingRate: SLmilliHertz; pSampleFormats: PSLint32;
      pNumOfSampleFormats: PSLint32): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLAudioIODeviceCapabilitiesItf_}


  { --------------------------------------------------------------------------- }
  { Capabilities of the LED array IODevice }
  { --------------------------------------------------------------------------- }

  SLLEDDescriptor = record
    ledCount: SLuint8;
    primaryLED: SLuint8;
    colorMask: SLuint32;
  end;
  {$EXTERNALSYM SLLEDDescriptor}

  PSLLEDDescriptor = ^SLLEDDescriptor;

  { --------------------------------------------------------------------------- }
  { LED Array interface }
  { --------------------------------------------------------------------------- }

  SLHSL = record
    hue: SLmillidegree;
    saturation: SLpermille;
    lightness: SLpermille;
  end;
  {$EXTERNALSYM SLHSL}

  PSLHSL = ^SLHSL;


  // extern SLAPIENTRY const SLInterfaceID SL_IID_LED;

  PSLLEDArrayItf_ = ^SLLEDArrayItf_;
  SLLEDArrayItf = ^PSLLEDArrayItf_;
  {$EXTERNALSYM SLLEDArrayItf}

  SLLEDArrayItf_ = record
    ActivateLEDArray: function(self: SLLEDArrayItf; lightMask: SLuint32): SLresult;
    IsLEDArrayActivated: function(self: SLLEDArrayItf; lightMask: PSLuint32): SLresult;
    SetColor: function(self: SLLEDArrayItf; index: SLuint8; const color: PSLHSL): SLresult;
    GetColor: function(self: SLLEDArrayItf; index: SLuint8; color: PSLHSL): SLresult;
  end;
  {$EXTERNALSYM SLLEDArrayItf_}

  { --------------------------------------------------------------------------- }
  { Capabilities of the Vibra IODevice }
  { --------------------------------------------------------------------------- }

  SLVibraDescriptor = record
    supportsFrequency: SLboolean;
    supportsIntensity: SLboolean;
    minFrequency: SLmilliHertz;
    maxFrequency: SLmilliHertz;
  end;
  {$EXTERNALSYM SLVibraDescriptor}

  PSLVibraDescriptor = ^SLVibraDescriptor;

  { --------------------------------------------------------------------------- }
  { Vibra interface }
  { --------------------------------------------------------------------------- }


  // extern SLAPIENTRY const SLInterfaceID SL_IID_VIBRA;

  PSLVibraItf_ = ^SLVibraItf_;
  SLVibraItf = ^PSLVibraItf_;
  {$EXTERNALSYM SLVibraItf}

  SLVibraItf_ = record
    Vibrate: function(self: SLVibraItf; Vibrate: SLboolean): SLresult; cdecl;
    IsVibrating: function(self: SLVibraItf; pVibrating: PSLboolean): SLresult; cdecl;
    SetFrequency: function(self: SLVibraItf; frequency: SLmilliHertz): SLresult; cdecl;
    GetFrequency: function(self: SLVibraItf; pFrequency: PSLmilliHertz): SLresult;
    SetIntensity: function(self: SLVibraItf; intensity: SLpermille): SLresult; cdecl;
    GetIntensity: function(self: SLVibraItf; pIntensity: PSLpermille): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLVibraItf_}

  { --------------------------------------------------------------------------- }
  { Meta data extraction related types and interface }
  { --------------------------------------------------------------------------- }
const
  SL_CHARACTERENCODING_UNKNOWN: SLuint32 = $00000000;
  {$EXTERNALSYM SL_CHARACTERENCODING_UNKNOWN}
  SL_CHARACTERENCODING_BINARY: SLuint32 = $00000001;
  {$EXTERNALSYM SL_CHARACTERENCODING_BINARY}
  SL_CHARACTERENCODING_ASCII: SLuint32 = $00000002;
  {$EXTERNALSYM SL_CHARACTERENCODING_ASCII}
  SL_CHARACTERENCODING_BIG5: SLuint32 = $00000003;
  {$EXTERNALSYM SL_CHARACTERENCODING_BIG5}
  SL_CHARACTERENCODING_CODEPAGE1252: SLuint32 = $00000004;
  {$EXTERNALSYM SL_CHARACTERENCODING_CODEPAGE1252}
  SL_CHARACTERENCODING_GB2312: SLuint32 = $00000005;
  {$EXTERNALSYM SL_CHARACTERENCODING_GB2312}
  SL_CHARACTERENCODING_HZGB2312: SLuint32 = $00000006;
  {$EXTERNALSYM SL_CHARACTERENCODING_HZGB2312}
  SL_CHARACTERENCODING_GB12345: SLuint32 = $00000007;
  {$EXTERNALSYM SL_CHARACTERENCODING_GB12345}
  SL_CHARACTERENCODING_GB18030: SLuint32 = $00000008;
  {$EXTERNALSYM SL_CHARACTERENCODING_GB18030}
  SL_CHARACTERENCODING_GBK: SLuint32 = $00000009;
  {$EXTERNALSYM SL_CHARACTERENCODING_GBK}
  SL_CHARACTERENCODING_IMAPUTF7: SLuint32 = $0000000A;
  {$EXTERNALSYM SL_CHARACTERENCODING_IMAPUTF7}
  SL_CHARACTERENCODING_ISO2022JP: SLuint32 = $0000000B;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO2022JP}
  SL_CHARACTERENCODING_ISO2022JP1: SLuint32 = $0000000B;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO2022JP1}
  SL_CHARACTERENCODING_ISO88591: SLuint32 = $0000000C;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO88591}
  SL_CHARACTERENCODING_ISO885910: SLuint32 = $0000000D;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO885910}
  SL_CHARACTERENCODING_ISO885913: SLuint32 = $0000000E;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO885913}
  SL_CHARACTERENCODING_ISO885914: SLuint32 = $0000000F;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO885914}
  SL_CHARACTERENCODING_ISO885915: SLuint32 = $00000010;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO885915}
  SL_CHARACTERENCODING_ISO88592: SLuint32 = $00000011;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO88592}
  SL_CHARACTERENCODING_ISO88593: SLuint32 = $00000012;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO88593}
  SL_CHARACTERENCODING_ISO88594: SLuint32 = $00000013;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO88594}
  SL_CHARACTERENCODING_ISO88595: SLuint32 = $00000014;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO88595}
  SL_CHARACTERENCODING_ISO88596: SLuint32 = $00000015;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO88596}
  SL_CHARACTERENCODING_ISO88597: SLuint32 = $00000016;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO88597}
  SL_CHARACTERENCODING_ISO88598: SLuint32 = $00000017;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO88598}
  SL_CHARACTERENCODING_ISO88599: SLuint32 = $00000018;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISO88599}
  SL_CHARACTERENCODING_ISOEUCJP: SLuint32 = $00000019;
  {$EXTERNALSYM SL_CHARACTERENCODING_ISOEUCJP}
  SL_CHARACTERENCODING_SHIFTJIS: SLuint32 = $0000001A;
  {$EXTERNALSYM SL_CHARACTERENCODING_SHIFTJIS}
  SL_CHARACTERENCODING_SMS7BIT: SLuint32 = $0000001B;
  {$EXTERNALSYM SL_CHARACTERENCODING_SMS7BIT}
  SL_CHARACTERENCODING_UTF7: SLuint32 = $0000001C;
  {$EXTERNALSYM SL_CHARACTERENCODING_UTF7}
  SL_CHARACTERENCODING_UTF8: SLuint32 = $0000001D;
  {$EXTERNALSYM SL_CHARACTERENCODING_UTF8}
  SL_CHARACTERENCODING_JAVACONFORMANTUTF8: SLuint32 = $0000001E;
  {$EXTERNALSYM SL_CHARACTERENCODING_JAVACONFORMANTUTF8}
  SL_CHARACTERENCODING_UTF16BE: SLuint32 = $0000001F;
  {$EXTERNALSYM SL_CHARACTERENCODING_UTF16BE}
  SL_CHARACTERENCODING_UTF16LE: SLuint32 = $00000020;
  {$EXTERNALSYM SL_CHARACTERENCODING_UTF16LE}
  SL_METADATA_FILTER_KEY: SLuint8 = $01;
  {$EXTERNALSYM SL_METADATA_FILTER_KEY}
  SL_METADATA_FILTER_LANG: SLuint8 = $02;
  {$EXTERNALSYM SL_METADATA_FILTER_LANG}
  SL_METADATA_FILTER_ENCODING: SLuint8 = $04;
  {$EXTERNALSYM SL_METADATA_FILTER_ENCODING}

type
  SLMetadataInfo = record
    size: SLuint32;
    encoding: SLuint32;
    langCountry: array [0 .. 15] of SLchar;
    data: array [0 .. 0] of SLuint8;
  end;
  {$EXTERNALSYM SLMetadataInfo}

  PSLMetadataInfo = ^SLMetadataInfo;

  // extern SLAPIENTRY const SLInterfaceID SL_IID_METADATAEXTRACTION;

  PSLMetadataExtractionItf_ = ^SLMetadataExtractionItf_;
  SLMetadataExtractionItf = ^PSLMetadataExtractionItf_;
  {$EXTERNALSYM SLMetadataExtractionItf}

  SLMetadataExtractionItf_ = record
    GetItemCount: function(self: SLMetadataExtractionItf; pItemCount: PSLuint32): SLresult;
    GetKeySize: function(self: SLMetadataExtractionItf; index: SLuint32;
      pKeySize: PSLuint32): SLresult; cdecl;
    GetKey: function(self: SLMetadataExtractionItf; index: SLuint32;
      keySize: SLuint32; pKey: PSLMetadataInfo): SLresult; cdecl;
    GetValueSize: function(self: SLMetadataExtractionItf; index: SLuint32;
      pValueSize: PSLuint32): SLresult; cdecl;
    GetValue: function(self: SLMetadataExtractionItf; index: SLuint32;
      valueSize: SLuint32; pValue: PSLMetadataInfo): SLresult; cdecl;
    AddKeyFilter: function(self: SLMetadataExtractionItf; keySize: SLuint32;
      pKey: Pointer; keyEncoding: SLuint32; const pValueLangCountry: PSLchar;
      valueEncoding: SLuint32; filterMask: SLuint8): SLresult; cdecl;
    ClearKeyFilter: function(self: SLMetadataExtractionItf): SLresult; cdecl;
  end;

  { --------------------------------------------------------------------------- }
  { Meta data traversal related types and interface }
  { --------------------------------------------------------------------------- }
const
  SL_METADATATRAVERSALMODE_ALL: SLuint32 = $00000001;
  {$EXTERNALSYM SL_METADATATRAVERSALMODE_ALL}
  SL_METADATATRAVERSALMODE_NODE: SLuint32 = $00000002;
  {$EXTERNALSYM SL_METADATATRAVERSALMODE_NODE}
  SL_NODETYPE_UNSPECIFIED: SLuint32 = $00000001;
  {$EXTERNALSYM SL_NODETYPE_UNSPECIFIED}
  SL_NODETYPE_AUDIO: SLuint32 = $00000002;
  {$EXTERNALSYM SL_NODETYPE_AUDIO}
  SL_NODETYPE_VIDEO: SLuint32 = $00000003;
  {$EXTERNALSYM SL_NODETYPE_VIDEO}
  SL_NODETYPE_IMAGE: SLuint32 = $00000004;
  {$EXTERNALSYM SL_NODETYPE_IMAGE}
  SL_NODE_PARENT = $FFFFFFFF;
  {$EXTERNALSYM SL_NODE_PARENT}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_METADATATRAVERSAL;

  PSLMetadataTraversalItf_ = ^SLMetadataTraversalItf_;
  SLMetadataTraversalItf = ^PSLMetadataTraversalItf_;
  {$EXTERNALSYM SLMetadataTraversalItf}

  SLMetadataTraversalItf_ = record
    SetMode: function(self: SLMetadataTraversalItf; mode: SLuint32): SLresult; cdecl;
    GetChildCount: function(self: SLMetadataTraversalItf; pCount: PSLuint32): SLresult;
    GetChildMIMETypeSize: function(self: SLMetadataTraversalItf;
      index: SLuint32; pSize: PSLuint32): SLresult; cdecl;
    GetChildInfo: function(self: SLMetadataTraversalItf; index: SLuint32;
      pNodeID: PSLint32; pType: PSLuint32; size: SLuint32; pMimeType: PSLchar): SLresult;
    SetActiveNode: function(self: SLMetadataTraversalItf; index: SLuint32): SLresult;
  end;
  {$EXTERNALSYM SLMetadataTraversalItf_}

  { --------------------------------------------------------------------------- }
  { Dynamic Source types and interface }
  { --------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_DYNAMICSOURCE;

  PSLDynamicSourceItf_ = ^SLDynamicSourceItf_;
  SLDynamicSourceItf = ^PSLDynamicSourceItf_;
  {$EXTERNALSYM SLDynamicSourceItf}

  SLDynamicSourceItf_ = record
    SetSource: function(self: SLDynamicSourceItf; pDataSource: PSLDataSource)
: SLresult;
  end;
  {$EXTERNALSYM SLDynamicSourceItf_}

  { --------------------------------------------------------------------------- }
  { Output Mix interface }
  { --------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_OUTPUTMIX;

  PSLOutputMixItf_ = ^SLOutputMixItf_;
  SLOutputMixItf = ^PSLOutputMixItf_;
  {$EXTERNALSYM SLOutputMixItf}

  slMixDeviceChangeCallback = procedure(caller: SLOutputMixItf;
    pContext: Pointer); cdecl;

  SLOutputMixItf_ = record
    GetDestinationOutputDeviceIDs: function(self: SLOutputMixItf;
      pNumDevices: PSLint32; pDeviceIDs: PSLuint32): SLresult; cdecl;
    RegisterDeviceChangeCallback: function(self: SLOutputMixItf;
      callback: slMixDeviceChangeCallback; pContext: Pointer): SLresult; cdecl;
    ReRoute: function(self: SLOutputMixItf; numOutputDevices: SLint32;
      pOutputDeviceIDs: PSLuint32): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLOutputMixItf_}

  { --------------------------------------------------------------------------- }
  { Playback interface }
  { --------------------------------------------------------------------------- }
const
  { Playback states }
  SL_PLAYSTATE_STOPPED: SLuint32 = $00000001;
  {$EXTERNALSYM SL_PLAYSTATE_STOPPED}
  SL_PLAYSTATE_PAUSED: SLuint32 = $00000002;
  {$EXTERNALSYM SL_PLAYSTATE_PAUSED}
  SL_PLAYSTATE_PLAYING: SLuint32 = $00000003;
  {$EXTERNALSYM SL_PLAYSTATE_PLAYING}
  { Play events * }
  SL_PLAYEVENT_HEADATEND: SLuint32 = $00000001;
  {$EXTERNALSYM SL_PLAYEVENT_HEADATEND}
  SL_PLAYEVENT_HEADATMARKER: SLuint32 = $00000002;
  {$EXTERNALSYM SL_PLAYEVENT_HEADATMARKER}
  SL_PLAYEVENT_HEADATNEWPOS: SLuint32 = $00000004;
  {$EXTERNALSYM SL_PLAYEVENT_HEADATNEWPOS}
  SL_PLAYEVENT_HEADMOVING: SLuint32 = $00000008;
  {$EXTERNALSYM SL_PLAYEVENT_HEADMOVING}
  SL_PLAYEVENT_HEADSTALLED: SLuint32 = $00000010;
  {$EXTERNALSYM SL_PLAYEVENT_HEADSTALLED}
  SL_TIME_UNKNOWN: SLuint32 = $FFFFFFFF;
  {$EXTERNALSYM SL_TIME_UNKNOWN}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_PLAY;

  { Playback interface methods }
  PSLPlayItf_ = ^SLPlayItf_;
  SLPlayItf = ^PSLPlayItf_;
  {$EXTERNALSYM SLPlayItf}

  slPlayCallback = procedure(caller: SLPlayItf; pContext: Pointer;
    event: SLuint32); cdecl;

  SLPlayItf_ = record
    SetPlayState: function(self: SLPlayItf; state: SLuint32): SLresult; cdecl;
    GetPlayState: function(self: SLPlayItf; pState: PSLuint32): SLresult; cdecl;
    GetDuration: function(self: SLPlayItf; pMsec: PSLmillisecond): SLresult;
    GetPosition: function(self: SLPlayItf; pMsec: PSLmillisecond): SLresult;
    RegisterCallback: function(self: SLPlayItf; callback: slPlayCallback; pContext: Pointer): SLresult; cdecl;
    SetCallbackEventsMask: function(self: SLPlayItf; eventFlags: SLuint32): SLresult;
    GetCallbackEventsMask: function(self: SLPlayItf; pEventFlags: PSLuint32): SLresult;
    SetMarkerPosition: function(self: SLPlayItf; mSec: SLmillisecond): SLresult;
    ClearMarkerPosition: function(self: SLPlayItf): SLresult; cdecl;
    GetMarkerPosition: function(self: SLPlayItf; pMsec: PSLmillisecond): SLresult;
    SetPositionUpdatePeriod: function(self: SLPlayItf; mSec: SLmillisecond): SLresult;
    GetPositionUpdatePeriod: function(self: SLPlayItf; pMsec: PSLmillisecond): SLresult;
  end;
  {$EXTERNALSYM SLPlayItf_}

  { --------------------------------------------------------------------------- }
  { Prefetch status interface }
  { --------------------------------------------------------------------------- }

const
  SL_PREFETCHEVENT_STATUSCHANGE: SLuint32 = $00000001;
  {$EXTERNALSYM SL_PREFETCHEVENT_STATUSCHANGE}
  SL_PREFETCHEVENT_FILLLEVELCHANGE: SLuint32 = $00000002;
  {$EXTERNALSYM SL_PREFETCHEVENT_FILLLEVELCHANGE}
  SL_PREFETCHSTATUS_UNDERFLOW: SLuint32 = $00000001;
  {$EXTERNALSYM SL_PREFETCHSTATUS_UNDERFLOW}
  SL_PREFETCHSTATUS_SUFFICIENTDATA: SLuint32 = $00000002;
  {$EXTERNALSYM SL_PREFETCHSTATUS_SUFFICIENTDATA}
  SL_PREFETCHSTATUS_OVERFLOW: SLuint32 = $00000003;
  {$EXTERNALSYM SL_PREFETCHSTATUS_OVERFLOW}

type
  { Playback interface methods }
  PSLPrefetchStatusItf_ = ^SLPrefetchStatusItf_;
  SLPrefetchStatusItf = ^PSLPrefetchStatusItf_;
  {$EXTERNALSYM SLPrefetchStatusItf}

  slPrefetchCallback = procedure(caller: SLPrefetchStatusItf; pContext: Pointer;
    event: SLuint32); cdecl;

  SLPrefetchStatusItf_ = record
    GetPrefetchStatus: function(self: SLPrefetchStatusItf; pStatus: PSLuint32): SLresult;
    GetFillLevel: function(self: SLPrefetchStatusItf; pLevel: PSLpermille): SLresult;
    RegisterCallback: function(self: SLPrefetchStatusItf;
      callback: slPrefetchCallback; pContext: Pointer): SLresult; cdecl;
    SetCallbackEventsMask: function(self: SLPrefetchStatusItf;
      eventFlags: SLuint32): SLresult; cdecl;
    GetCallbackEventsMask: function(self: SLPrefetchStatusItf;
      pEventFlags: PSLuint32): SLresult; cdecl;
    SetFillUpdatePeriod: function(self: SLPrefetchStatusItf; period: SLpermille): SLresult;
    GetFillUpdatePeriod: function(self: SLPrefetchStatusItf;
      pPeriod: PSLpermille): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLPrefetchStatusItf_}

  { --------------------------------------------------------------------------- }
  { Playback Rate interface }
  { --------------------------------------------------------------------------- }
const
  SL_RATEPROP_RESERVED1: SLuint32 = $00000001;
  {$EXTERNALSYM SL_RATEPROP_RESERVED1}
  SL_RATEPROP_RESERVED2: SLuint32 = $00000002;
  {$EXTERNALSYM SL_RATEPROP_RESERVED2}
  SL_RATEPROP_SILENTAUDIO: SLuint32 = $00000100;
  {$EXTERNALSYM SL_RATEPROP_SILENTAUDIO}
  SL_RATEPROP_STAGGEREDAUDIO: SLuint32 = $00000200;
  {$EXTERNALSYM SL_RATEPROP_STAGGEREDAUDIO}
  SL_RATEPROP_NOPITCHCORAUDIO: SLuint32 = $00000400;
  {$EXTERNALSYM SL_RATEPROP_NOPITCHCORAUDIO}
  SL_RATEPROP_PITCHCORAUDIO: SLuint32 = $00000800;
  {$EXTERNALSYM SL_RATEPROP_PITCHCORAUDIO}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_PLAYBACKRATE;

  PSLPlaybackRateItf_ = ^SLPlaybackRateItf_;
  SLPlaybackRateItf = ^PSLPlaybackRateItf_;
  {$EXTERNALSYM SLPlaybackRateItf}

  SLPlaybackRateItf_ = record
    SetRate: function(self: SLPlaybackRateItf; rate: SLpermille): SLresult;
    GetRate: function(self: SLPlaybackRateItf; pRate: PSLpermille): SLresult;
    SetPropertyConstraints: function(self: SLPlaybackRateItf;
      constraints: SLuint32): SLresult; cdecl;
    GetProperties: function(self: SLPlaybackRateItf; pProperties: PSLuint32): SLresult;
    GetCapabilitiesOfRate: function(self: SLPlaybackRateItf; rate: SLpermille;
      pCapabilities: PSLuint32): SLresult; cdecl;
    GetRateRange: function(self: SLPlaybackRateItf; index: SLuint8;
      pMinRate: PSLpermille; pMaxRate: PSLpermille; pStepSize: PSLpermille;
      pCapabilities: PSLuint32): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLPlaybackRateItf_}

  { --------------------------------------------------------------------------- }
  { Seek Interface }
  { --------------------------------------------------------------------------- }
const
  SL_SEEKMODE_FAST: SLuint32 = $0001;
  {$EXTERNALSYM SL_SEEKMODE_FAST}
  SL_SEEKMODE_ACCURATE: SLuint32 = $0002;
  {$EXTERNALSYM SL_SEEKMODE_ACCURATE}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_SEEK;
  PSLSeekItf_ = ^SLSeekItf_;
  SLSeekItf = ^PSLSeekItf_;
  {$EXTERNALSYM SLSeekItf}

  SLSeekItf_ = record
    SetPosition: function(self: SLSeekItf; pos: SLmillisecond;
      seekMode: SLuint32): SLresult; cdecl;
    SetLoop: function(self: SLSeekItf; loopEnable: SLboolean;
      startPos: SLmillisecond; endPos: SLmillisecond): SLresult; cdecl;
    GetLoop: function(self: SLSeekItf; pLoopEnabled: PSLboolean;
      pStartPos: PSLmillisecond; pEndPos: PSLmillisecond): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLSeekItf_}

  { --------------------------------------------------------------------------- }
  { Standard Recording Interface }
  { --------------------------------------------------------------------------- }
const
  { Recording states }
  SL_RECORDSTATE_STOPPED: SLuint32 = $00000001;
  {$EXTERNALSYM SL_RECORDSTATE_STOPPED}
  SL_RECORDSTATE_PAUSED: SLuint32 = $00000002;
  {$EXTERNALSYM SL_RECORDSTATE_PAUSED}
  SL_RECORDSTATE_RECORDING: SLuint32 = $00000003;
  {$EXTERNALSYM SL_RECORDSTATE_RECORDING}
  { Record event * }
  SL_RECORDEVENT_HEADATLIMIT: SLuint32 = $00000001;
  {$EXTERNALSYM SL_RECORDEVENT_HEADATLIMIT}
  SL_RECORDEVENT_HEADATMARKER: SLuint32 = $00000002;
  {$EXTERNALSYM SL_RECORDEVENT_HEADATMARKER}
  SL_RECORDEVENT_HEADATNEWPOS: SLuint32 = $00000004;
  {$EXTERNALSYM SL_RECORDEVENT_HEADATNEWPOS}
  SL_RECORDEVENT_HEADMOVING: SLuint32 = $00000008;
  {$EXTERNALSYM SL_RECORDEVENT_HEADMOVING}
  SL_RECORDEVENT_HEADSTALLED: SLuint32 = $00000010;
  {$EXTERNALSYM SL_RECORDEVENT_HEADSTALLED}
  { Note: SL_RECORDEVENT_BUFFER_INSUFFICIENT is deprecated, use SL_RECORDEVENT_BUFFER_FULL instead. }
  SL_RECORDEVENT_BUFFER_INSUFFICIENT: SLuint32 = $00000020;
  {$EXTERNALSYM SL_RECORDEVENT_BUFFER_INSUFFICIENT}
  SL_RECORDEVENT_BUFFER_FULL: SLuint32 = $00000020;
  {$EXTERNALSYM SL_RECORDEVENT_BUFFER_FULL}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_RECORD;
  PSLRecordItf_ = ^SLRecordItf_;
  SLRecordItf = ^PSLRecordItf_;
  {$EXTERNALSYM SLRecordItf}

  slRecordCallback = procedure(caller: SLRecordItf; pContext: Pointer;
    event: SLuint32); cdecl;

  SLRecordItf_ = record
    SetRecordState: function(self: SLRecordItf; state: SLuint32): SLresult;
    GetRecordState: function(self: SLRecordItf; pState: PSLuint32): SLresult;
    SetDurationLimit: function(self: SLRecordItf; mSec: SLmillisecond): SLresult;
    GetPosition: function(self: SLRecordItf; pMsec: PSLmillisecond): SLresult;
    RegisterCallback: function(self: SLRecordItf; callback: slRecordCallback; pContext: Pointer): SLresult; cdecl;
    SetCallbackEventsMask: function(self: SLRecordItf; eventFlags: SLuint32): SLresult;
    GetCallbackEventsMask: function(self: SLRecordItf; pEventFlags: PSLuint32): SLresult;
    SetMarkerPosition: function(self: SLRecordItf; mSec: SLmillisecond): SLresult;
    ClearMarkerPosition: function(self: SLRecordItf): SLresult; cdecl;
    GetMarkerPosition: function(self: SLRecordItf; pMsec: PSLmillisecond): SLresult;
    SetPositionUpdatePeriod: function(self: SLRecordItf; mSec: SLmillisecond): SLresult;
    GetPositionUpdatePeriod: function(self: SLRecordItf; pMsec: PSLmillisecond): SLresult;
  end;
  {$EXTERNALSYM SLRecordItf_}

  { --------------------------------------------------------------------------- }
  { Equalizer interface }
  { --------------------------------------------------------------------------- }

const
  SL_EQUALIZER_UNDEFINED: SLuint16 = $FFFF;
  {$EXTERNALSYM SL_EQUALIZER_UNDEFINED}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_EQUALIZER;
  PSLEqualizerItf_ = ^SLEqualizerItf_;
  SLEqualizerItf = ^PSLEqualizerItf_;
  {$EXTERNALSYM SLEqualizerItf}

  SLEqualizerItf_ = record
    SetEnabled: function(self: SLEqualizerItf; enabled: SLboolean): SLresult;
    IsEnabled: function(self: SLEqualizerItf; pEnabled: PSLboolean): SLresult;
    GetNumberOfBands: function(self: SLEqualizerItf; pAmount: PSLuint16): SLresult;
    GetBandLevelRange: function(self: SLEqualizerItf; pMin: PSLmillibel;pMax: PSLmillibel): SLresult; cdecl;
    SetBandLevel: function(self: SLEqualizerItf; band: SLuint16; level: SLmillibel): SLresult; cdecl;
    GetBandLevel: function(self: SLEqualizerItf; band: SLuint16; pLevel: PSLmillibel): SLresult; cdecl;
    GetCenterFreq: function(self: SLEqualizerItf; band: SLuint16; pCenter: PSLmilliHertz): SLresult; cdecl;
    GetBandFreqRange: function(self: SLEqualizerItf; band: SLuint16; pMin: PSLmilliHertz; pMax: PSLmilliHertz): SLresult; cdecl;
    GetBand: function(self: SLEqualizerItf; frequency: SLmilliHertz; pBand: PSLuint16): SLresult; cdecl;
    GetCurrentPreset: function(self: SLEqualizerItf; pPreset: PSLuint16): SLresult;
    UsePreset: function(self: SLEqualizerItf; index: SLuint16): SLresult; cdecl;
    GetNumberOfPresets: function(self: SLEqualizerItf; pNumPresets: PSLuint16): SLresult;
    GetPresetName: function(self: SLEqualizerItf; index: SLuint16; ppName: PPSLchar): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLEqualizerItf_}

  { --------------------------------------------------------------------------- }
  { Volume Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_VOLUME;

  PSLVolumeItf_ = ^SLVolumeItf;
  SLVolumeItf = ^PSLVolumeItf_;
  {$EXTERNALSYM SLVolumeItf}

  SLVolumeItf_ = record
    SetVolumeLevel: function(self: SLVolumeItf; level: SLmillibel): SLresult;
    GetVolumeLevel: function(self: SLVolumeItf; pLevel: PSLmillibel): SLresult;
    GetMaxVolumeLevel: function(self: SLVolumeItf; pMaxLevel: PSLmillibel): SLresult;
    SetMute: function(self: SLVolumeItf; mute: SLboolean): SLresult; cdecl;
    GetMute: function(self: SLVolumeItf; pMute: PSLboolean): SLresult; cdecl;
    EnableStereoPosition: function(self: SLVolumeItf; enable: SLboolean): SLresult;
    IsEnabledStereoPosition: function(self: SLVolumeItf; pEnable: PSLboolean): SLresult;
    SetStereoPosition: function(self: SLVolumeItf; stereoPosition: SLpermille): SLresult;
    GetStereoPosition: function(self: SLVolumeItf; pStereoPosition: PSLpermille): SLresult;
  end;
  {$EXTERNALSYM SLVolumeItf_}

  { --------------------------------------------------------------------------- }
  { Device Volume Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_DEVICEVOLUME;

  PSLDeviceVolumeItf_ = ^SLDeviceVolumeItf;
  SLDeviceVolumeItf = ^PSLDeviceVolumeItf_;
  {$EXTERNALSYM SLDeviceVolumeItf}

  SLDeviceVolumeItf_ = record
    GetVolumeScale: function(self: SLDeviceVolumeItf; deviceID: SLuint32; pMinValue: PSLint32;
      pMaxValue: PSLint32; pIsMillibelScale: PSLboolean): SLresult;
    SetVolume: function(self: SLDeviceVolumeItf; deviceID: SLuint32; volume: SLint32): SLresult; cdecl;
    GetVolume: function(self: SLDeviceVolumeItf; deviceID: SLuint32; pVolume: PSLint32): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLDeviceVolumeItf_}

  { --------------------------------------------------------------------------- }
  { Buffer Queue Interface }
  { --------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_BUFFERQUEUE;

  { Buffer queue state * }
  SLBufferQueueState = record
    count: SLuint32;
    playIndex: SLuint32;
  end;
  {$EXTERNALSYM SLBufferQueueState}

  PSLBufferQueueState = ^SLBufferQueueState;

  PSLBufferQueueItf_ = ^SLBufferQueueItf;
  SLBufferQueueItf = ^PSLBufferQueueItf_;
  {$EXTERNALSYM SLBufferQueueItf}

  slBufferQueueCallback = procedure(caller: SLBufferQueueItf;
    pContext: Pointer); cdecl;

  SLBufferQueueItf_ = record
    Enqueue: function(self: SLBufferQueueItf; pBuffer: Pointer; size: SLuint32): SLresult;
    Clear: function(self: SLBufferQueueItf): SLresult; cdecl;
    GetState: function(self: SLBufferQueueItf; pState: PSLBufferQueueState): SLresult;
    RegisterCallback: function(self: SLBufferQueueItf; callback: slBufferQueueCallback; pContext: Pointer): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLBufferQueueItf_}

  { --------------------------------------------------------------------------- }
  { PresetReverb }
  { --------------------------------------------------------------------------- }
const
  SL_REVERBPRESET_NONE: SLuint16 = $0000;
  {$EXTERNALSYM SL_REVERBPRESET_NONE}
  SL_REVERBPRESET_SMALLROOM: SLuint16 = $0001;
  {$EXTERNALSYM SL_REVERBPRESET_SMALLROOM}
  SL_REVERBPRESET_MEDIUMROOM: SLuint16 = $0002;
  {$EXTERNALSYM SL_REVERBPRESET_MEDIUMROOM}
  SL_REVERBPRESET_LARGEROOM: SLuint16 = $0003;
  {$EXTERNALSYM SL_REVERBPRESET_LARGEROOM}
  SL_REVERBPRESET_MEDIUMHALL: SLuint16 = $0004;
  {$EXTERNALSYM SL_REVERBPRESET_MEDIUMHALL}
  SL_REVERBPRESET_LARGEHALL: SLuint16 = $0005;
  {$EXTERNALSYM SL_REVERBPRESET_LARGEHALL}
  SL_REVERBPRESET_PLATE: SLuint16 = $0006;
  {$EXTERNALSYM SL_REVERBPRESET_PLATE}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_PRESETREVERB;

  PSLPresetReverbItf_ = ^SLPresetReverbItf;
  SLPresetReverbItf = ^PSLPresetReverbItf_;
  {$EXTERNALSYM SLPresetReverbItf}

  SLPresetReverbItf_ = record
    SetPreset: function(self: SLPresetReverbItf; preset: SLuint16): SLresult;
    GetPreset: function(self: SLPresetReverbItf; pPreset: PSLuint16): SLresult;
  end;
  {$EXTERNALSYM SLPresetReverbItf_}

  { --------------------------------------------------------------------------- }
  { EnvironmentalReverb }
  { --------------------------------------------------------------------------- }

const
  SL_I3DL2_ENVIRONMENT_PRESET_DEFAULT: array [0 .. 9] of Integer =
	( (-1) * $7FFF - 1,    0,  1000,   500, (-1) * $7FFF - 1,  20, (-1) * $7FFF - 1,  40, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_DEFAULT}

  SL_I3DL2_ENVIRONMENT_PRESET_GENERIC: array [0 .. 9] of Integer =
	( -1000, -100, 1490,  830, -2602,   7,   200,  11, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_GENERIC}

  SL_I3DL2_ENVIRONMENT_PRESET_PADDEDCELL: array [0 .. 9] of Integer =
	( -1000,-6000,  170,  100, -1204,   1,   207,   2, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_PADDEDCELL}

  SL_I3DL2_ENVIRONMENT_PRESET_ROOM: array [0 .. 9] of Integer =
	( -1000, -454,  400,  830, -1646,   2,    53,   3, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_ROOM}

  SL_I3DL2_ENVIRONMENT_PRESET_BATHROOM: array [0 .. 9] of Integer =
	( -1000,-1200, 1490,  540,  -370,   7,  1030,  11, 1000, 600 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_BATHROOM}

  SL_I3DL2_ENVIRONMENT_PRESET_LIVINGROOM: array [0 .. 9] of Integer =
	( -1000,-6000,  500,  100, -1376,   3, -1104,   4, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_LIVINGROOM}

  SL_I3DL2_ENVIRONMENT_PRESET_STONEROOM: array [0 .. 9] of Integer =
	( -1000, -300, 2310,  640,  -711,  12,    83,  17, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_STONEROOM}

  SL_I3DL2_ENVIRONMENT_PRESET_AUDITORIUM: array [0 .. 9] of Integer =
	( -1000, -476, 4320,  590,  -789,  20,  -289,  30, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_AUDITORIUM}

  SL_I3DL2_ENVIRONMENT_PRESET_CONCERTHALL: array [0 .. 9] of Integer =
	( -1000, -500, 3920,  700, -1230,  20,    -2,  29, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_CONCERTHALL}

  SL_I3DL2_ENVIRONMENT_PRESET_CAVE: array [0 .. 9] of Integer =
	( -1000,    0, 2910, 1300,  -602,  15,  -302,  22, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_CAVE}

  SL_I3DL2_ENVIRONMENT_PRESET_ARENA: array [0 .. 9] of Integer =
	( -1000, -698, 7240,  330, -1166,  20,    16,  30, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_ARENA}

  SL_I3DL2_ENVIRONMENT_PRESET_HANGAR: array [0 .. 9] of Integer =
	( -1000,-1000, 10050,  230,  -602,  20,   198,  30, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_HANGAR}

  SL_I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY: array [0 .. 9] of Integer =
	( -1000,-4000,  300,  100, -1831,   2, -1630,  30, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY}

  SL_I3DL2_ENVIRONMENT_PRESET_HALLWAY: array [0 .. 9] of Integer =
	( -1000, -300, 1490,  590, -1219,   7,   441,  11, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_HALLWAY}

  SL_I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR: array [0 .. 9] of Integer =
	( -1000, -237, 2700,  790, -1214,  13,   395,  20, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR}

  SL_I3DL2_ENVIRONMENT_PRESET_ALLEY: array [0 .. 9] of Integer =
	( -1000, -270, 1490,  860, -1204,   7,    -4,  11, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_ALLEY}

  SL_I3DL2_ENVIRONMENT_PRESET_FOREST: array [0 .. 9] of Integer =
	( -1000,-3300, 1490,  540, -2560, 162,  -613,  88,  790,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_FOREST}

  SL_I3DL2_ENVIRONMENT_PRESET_CITY: array [0 .. 9] of Integer =
	( -1000, -800, 1490,  670, -2273,   7, -2217,  11,  500,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_CITY}

  SL_I3DL2_ENVIRONMENT_PRESET_MOUNTAINS: array [0 .. 9] of Integer =
	( -1000,-2500, 1490,  210, -2780, 300, -2014, 100,  270,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_MOUNTAINS}

  SL_I3DL2_ENVIRONMENT_PRESET_QUARRY: array [0 .. 9] of Integer =
	( -1000,-1000, 1490,  830, (-1) * $7FFF - 1,  61,   500,  25, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_QUARRY}

  SL_I3DL2_ENVIRONMENT_PRESET_PLAIN: array [0 .. 9] of Integer =
	( -1000,-2000, 1490,  500, -2466, 179, -2514, 100,  210,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_PLAIN}

  SL_I3DL2_ENVIRONMENT_PRESET_PARKINGLOT: array [0 .. 9] of Integer =
	( -1000,    0, 1650, 1500, -1363,   8, -1153,  12, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_PARKINGLOT}

  SL_I3DL2_ENVIRONMENT_PRESET_SEWERPIPE: array [0 .. 9] of Integer =
	( -1000,-1000, 2810,  140,   429,  14,   648,  21,  800, 600 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_SEWERPIPE}

  SL_I3DL2_ENVIRONMENT_PRESET_UNDERWATER: array [0 .. 9] of Integer =
	( -1000,-4000, 1490,  100,  -449,   7,  1700,  11, 1000,1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_UNDERWATER}

  SL_I3DL2_ENVIRONMENT_PRESET_SMALLROOM: array [0 .. 9] of Integer =
	( -1000,-600, 1100, 830, -400, 5, 500, 10, 1000, 1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_SMALLROOM}

  SL_I3DL2_ENVIRONMENT_PRESET_MEDIUMROOM: array [0 .. 9] of Integer =
	( -1000,-600, 1300, 830, -1000, 20, -200, 20, 1000, 1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_MEDIUMROOM}

  SL_I3DL2_ENVIRONMENT_PRESET_LARGEROOM: array [0 .. 9] of Integer =
	( -1000,-600, 1500, 830, -1600, 5, -1000, 40, 1000, 1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_LARGEROOM}

  SL_I3DL2_ENVIRONMENT_PRESET_MEDIUMHALL: array [0 .. 9] of Integer =
	( -1000,-600, 1800, 700, -1300, 15, -800, 30, 1000, 1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_MEDIUMHALL}

  SL_I3DL2_ENVIRONMENT_PRESET_LARGEHALL: array [0 .. 9] of Integer =
	( -1000,-600, 1800, 700, -2000, 30, -1400, 60, 1000, 1000 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_LARGEHALL}

  SL_I3DL2_ENVIRONMENT_PRESET_PLATE: array [0 .. 9] of Integer =
  ( -1000,-200, 1300, 900, 0, 2, 0, 10, 1000, 750 );
  {$EXTERNALSYM SL_I3DL2_ENVIRONMENT_PRESET_PLATE}



type
  SLEnvironmentalReverbSettings = record
    roomLevel: SLmillibel;
    roomHFLevel: SLmillibel;
    decayTime: SLmillisecond;
    decayHFRatio: SLpermille;
    reflectionsLevel: SLmillibel;
    reflectionsDelay: SLmillisecond;
    reverbLevel: SLmillibel;
    reverbDelay: SLmillisecond;
    diffusion: SLpermille;
    density: SLpermille;
  end;
  {$EXTERNALSYM SLEnvironmentalReverbSettings}

  PSLEnvironmentalReverbSettings = ^SLEnvironmentalReverbSettings;

  // extern SLAPIENTRY const SLInterfaceID SL_IID_ENVIRONMENTALREVERB;

  PSLEnvironmentalReverbItf_ = ^SLEnvironmentalReverbItf_;
  SLEnvironmentalReverbItf = ^PSLEnvironmentalReverbItf_;
  {$EXTERNALSYM SLEnvironmentalReverbItf}

  SLEnvironmentalReverbItf_ = record
    SetRoomLevel: function(self: SLEnvironmentalReverbItf; room: SLmillibel): SLresult;
    GetRoomLevel: function(self: SLEnvironmentalReverbItf; pRoom: PSLmillibel): SLresult;
    SetRoomHFLevel: function(self: SLEnvironmentalReverbItf; roomHF: SLmillibel): SLresult;
    GetRoomHFLevel: function(self: SLEnvironmentalReverbItf; pRoomHF: PSLmillibel): SLresult; cdecl;
    SetDecayTime: function(self: SLEnvironmentalReverbItf; decayTime: SLmillisecond): SLresult; cdecl;
    GetDecayTime: function(self: SLEnvironmentalReverbItf;  pDecayTime: PSLmillisecond): SLresult; cdecl;
    SetDecayHFRatio: function(self: SLEnvironmentalReverbItf; decayHFRatio: SLpermille): SLresult; cdecl;
    GetDecayHFRatio: function(self: SLEnvironmentalReverbItf; pDecayHFRatio: PSLpermille): SLresult; cdecl;
    SetReflectionsLevel: function(self: SLEnvironmentalReverbItf; reflectionsLevel: SLmillibel): SLresult; cdecl;
    GetReflectionsLevel: function(self: SLEnvironmentalReverbItf; pReflectionsLevel: PSLmillibel): SLresult; cdecl;
    SetReflectionsDelay: function(self: SLEnvironmentalReverbItf; reflectionsDelay: SLmillisecond): SLresult; cdecl;
    GetReflectionsDelay: function(self: SLEnvironmentalReverbItf; pReflectionsDelay: PSLmillisecond): SLresult; cdecl;
    SetReverbLevel: function(self: SLEnvironmentalReverbItf; reverbLevel: SLmillibel): SLresult; cdecl;
    GetReverbLevel: function(self: SLEnvironmentalReverbItf; pReverbLevel: PSLmillibel): SLresult; cdecl;
    SetReverbDelay: function(self: SLEnvironmentalReverbItf; reverbDelay: SLmillisecond): SLresult; cdecl;
    GetReverbDelay: function(self: SLEnvironmentalReverbItf; pReverbDelay: PSLmillisecond): SLresult; cdecl;
    SetDiffusion: function(self: SLEnvironmentalReverbItf; diffusion: SLpermille): SLresult; cdecl;
    GetDiffusion: function(self: SLEnvironmentalReverbItf; pDiffusion: PSLpermille): SLresult; cdecl;
    SetDensity: function(self: SLEnvironmentalReverbItf; density: SLpermille): SLresult;
    GetDensity: function(self: SLEnvironmentalReverbItf; pDensity: PSLpermille): SLresult;
    SetEnvironmentalReverbProperties: function(self: SLEnvironmentalReverbItf; pProperties: PSLEnvironmentalReverbSettings): SLresult; cdecl;
    GetEnvironmentalReverbProperties: function(self: SLEnvironmentalReverbItf; pProperties: PSLEnvironmentalReverbSettings): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLEnvironmentalReverbItf_}

  { --------------------------------------------------------------------------- }
  { Effects Send Interface }
  { --------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_EFFECTSEND;

  PSLEffectSendItf_ = ^SLEffectSendItf;
  SLEffectSendItf = ^PSLEffectSendItf_;
  {$EXTERNALSYM SLEffectSendItf}

  SLEffectSendItf_ = record
    EnableEffectSend: function(self: SLEffectSendItf; pAuxEffect: Pointer; enable: SLboolean;
      initialLevel: SLmillibel): SLresult; cdecl;
    IsEnabled: function(self: SLEffectSendItf; pAuxEffect: Pointer; pEnable: PSLboolean): SLresult; cdecl;
    SetDirectLevel: function(self: SLEffectSendItf; directLevel: SLmillibel): SLresult;
    GetDirectLevel: function(self: SLEffectSendItf; pDirectLevel: PSLmillibel): SLresult;
    SetSendLevel: function(self: SLEffectSendItf; pAuxEffect: Pointer; sendLevel: SLmillibel): SLresult; cdecl;
    GetSendLevel: function(self: SLEffectSendItf; pAuxEffect: Pointer; pSendLevel: PSLmillibel): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLEffectSendItf_}

  { --------------------------------------------------------------------------- }
  { 3D Grouping Interface }
  { --------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_3DGROUPING;

  PSL3DGroupingItf_ = ^SL3DGroupingItf;
  SL3DGroupingItf = ^PSL3DGroupingItf_;
  {$EXTERNALSYM SL3DGroupingItf}

  SL3DGroupingItf_ = record
    Set3DGroup: function(self: SL3DGroupingItf; group: SLObjectItf): SLresult;
    Get3DGroup: function(self: SL3DGroupingItf; pGroup: PSLObjectItf): SLresult;
  end;
  {$EXTERNALSYM SL3DGroupingItf_}

  { --------------------------------------------------------------------------- }
  { 3D Commit Interface }
  { --------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_3DCOMMIT;

  PSL3DCommitItf_ = ^SL3DCommitItf;
  SL3DCommitItf = ^PSL3DCommitItf_;
  {$EXTERNALSYM SL3DCommitItf}

  SL3DCommitItf_ = record
    Commit: function(self: SL3DCommitItf): SLresult; cdecl;
    SetDeferred: function(self: SL3DCommitItf; deferred: SLboolean): SLresult;
  end;
  {$EXTERNALSYM SL3DCommitItf_}

  { --------------------------------------------------------------------------- }
  { 3D Location Interface }
  { --------------------------------------------------------------------------- }

  SLVec3D = record
    x: SLint32;
    y: SLint32;
    z: SLint32;
  end;
  {$EXTERNALSYM SLVec3D}

  PSLVec3D = ^SLVec3D;

  // extern SLAPIENTRY const SLInterfaceID SL_IID_3DLOCATION;

  PSL3DLocationItf_ = ^SL3DLocationItf;
  SL3DLocationItf = ^PSL3DLocationItf_;
  {$EXTERNALSYM SL3DLocationItf}

  SL3DLocationItf_ = record
    SetLocationCartesian: function(self: SL3DLocationItf; pLocation: PSLVec3D)
: SLresult;
    SetLocationSpherical: function(self: SL3DLocationItf; azimuth: SLmillidegree; elevation: SLmillidegree;
      distance: SLmillimeter): SLresult;
    Move: function(self: SL3DLocationItf; pMovement: PSLVec3D): SLresult; cdecl;
    GetLocationCartesian: function(self: SL3DLocationItf; pLocation: PSLVec3D): SLresult;
    SetOrientationVectors: function(self: SL3DLocationItf; pFront: PSLVec3D; pAbove: PSLVec3D): SLresult; cdecl;
    SetOrientationAngles: function(self: SL3DLocationItf; heading: SLmillidegree; pitch: SLmillidegree;
      roll: SLmillidegree): SLresult;
    Rotate: function(self: SL3DLocationItf; theta: SLmillidegree; pAxis: PSLVec3D): SLresult; cdecl;
    GetOrientationVectors: function(self: SL3DLocationItf; pFront: PSLVec3D; pUp: PSLVec3D): SLresult; cdecl;
  end;
  {$EXTERNALSYM SL3DLocationItf_}

  { --------------------------------------------------------------------------- }
  { 3D Doppler Interface }
  { --------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_3DDOPPLER;

  PSL3DDopplerItf_ = ^SL3DDopplerItf;
  SL3DDopplerItf = ^PSL3DDopplerItf_;
  {$EXTERNALSYM SL3DDopplerItf}

  SL3DDopplerItf_ = record
    SetVelocityCartesian: function(self: SL3DDopplerItf; pVelocity: PSLVec3D): SLresult;
    SetVelocitySpherical: function(self: SL3DDopplerItf; azimuth: SLmillidegree; elevation: SLmillidegree;
      speed: SLmillimeter): SLresult; cdecl;
    GetVelocityCartesian: function(self: SL3DDopplerItf; pVelocity: PSLVec3D): SLresult;
    SetDopplerFactor: function(self: SL3DDopplerItf; dopplerFactor: SLpermille): SLresult;
    GetDopplerFactor: function(self: SL3DDopplerItf; pDopplerFactor: PSLpermille): SLresult; cdecl;
  end;
  {$EXTERNALSYM SL3DDopplerItf_}

  { --------------------------------------------------------------------------- }
  { 3D Source Interface and associated defines }
  { -------------------------------------------------------------------------- }
const
  SL_ROLLOFFMODEL_EXPONENTIAL: SLuint32 = $00000000;
  {$EXTERNALSYM SL_ROLLOFFMODEL_EXPONENTIAL}
  SL_ROLLOFFMODEL_LINEAR: SLuint32 = $00000001;
  {$EXTERNALSYM SL_ROLLOFFMODEL_LINEAR}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_3DSOURCE;

  PSL3DSourceItf_ = ^SL3DSourceItf;
  SL3DSourceItf = ^PSL3DSourceItf_;
  {$EXTERNALSYM SL3DSourceItf}

  SL3DSourceItf_ = record
    SetHeadRelative: function(self: SL3DSourceItf; headRelative: SLboolean): SLresult;
    GetHeadRelative: function(self: SL3DSourceItf; pHeadRelative: PSLboolean): SLresult;
    SetRolloffDistances: function(self: SL3DSourceItf; minDistance: SLmillimeter; maxDistance: SLmillimeter): SLresult; cdecl;
    GetRolloffDistances: function(self: SL3DSourceItf; pMinDistance: PSLmillimeter; pMaxDistance: PSLmillimeter): SLresult;
    SetRolloffMaxDistanceMute: function(self: SL3DSourceItf; mute: SLboolean): SLresult;
    GetRolloffMaxDistanceMute: function(self: SL3DSourceItf; pMute: PSLboolean): SLresult;
    SetRolloffFactor: function(self: SL3DSourceItf; rolloffFactor: SLpermille): SLresult;
    GetRolloffFactor: function(self: SL3DSourceItf; pRolloffFactor: PSLpermille): SLresult;
    SetRoomRolloffFactor: function(self: SL3DSourceItf; roomRolloffFactor: SLpermille): SLresult; cdecl;
    GetRoomRolloffFactor: function(self: SL3DSourceItf; pRoomRolloffFactor: PSLpermille): SLresult; cdecl;
    SetRolloffModel: function(self: SL3DSourceItf; model: SLuint8): SLresult;
    GetRolloffModel: function(self: SL3DSourceItf; pModel: PSLuint8): SLresult;
    SetCone: function(self: SL3DSourceItf; innerAngle: SLmillidegree; outerAngle: SLmillidegree;
      outerLevel: SLmillibel): SLresult; cdecl;
    GetCone: function(self: SL3DSourceItf; pInnerAngle: PSLmillidegree; pOuterAngle: PSLmillidegree;
      pOuterLevel: PSLmillibel): SLresult; cdecl;
  end;
  {$EXTERNALSYM SL3DSourceItf_}


  { --------------------------------------------------------------------------- }
  { 3D Macroscopic Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_3DMACROSCOPIC;

  PSL3DMacroscopicItf_ = ^SL3DMacroscopicItf;
  SL3DMacroscopicItf = ^PSL3DMacroscopicItf_;
  {$EXTERNALSYM SL3DMacroscopicItf}

  SL3DMacroscopicItf_ = record
    SetSize: function(self: SL3DMacroscopicItf; width: SLmillimeter; height: SLmillimeter;
      depth: SLmillimeter): SLresult; cdecl;
    GetSize: function(self: SL3DMacroscopicItf; pWidth: PSLmillimeter; pHeight: PSLmillimeter;
      pDepth: PSLmillimeter): SLresult; cdecl;
    SetOrientationAngles: function(self: SL3DMacroscopicItf; heading: SLmillidegree; pitch: SLmillidegree;
      roll: SLmillidegree): SLresult;
    SetOrientationVectors: function(self: SL3DMacroscopicItf; pFront: PSLVec3D; pAbove: PSLVec3D): SLresult; cdecl;
    Rotate: function(self: SL3DMacroscopicItf; theta: SLmillidegree; pAxis: PSLVec3D): SLresult; cdecl;
    GetOrientationVectors: function(self: SL3DMacroscopicItf; pFront: PSLVec3D; pUp: PSLVec3D): SLresult; cdecl;
  end;
  {$EXTERNALSYM SL3DMacroscopicItf_}

  { --------------------------------------------------------------------------- }
  { Mute Solo Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_MUTESOLO;

  PSLMuteSoloItf_ = ^SLMuteSoloItf;
  SLMuteSoloItf = ^PSLMuteSoloItf_;
  {$EXTERNALSYM SLMuteSoloItf}

  SLMuteSoloItf_ = record
    SetChannelMute: function(self: SLMuteSoloItf; chan: SLuint8; mute: SLboolean): SLresult; cdecl;
    GetChannelMute: function(self: SLMuteSoloItf; chan: SLuint8; pMute: PSLboolean): SLresult; cdecl;
    SetChannelSolo: function(self: SLMuteSoloItf; chan: SLuint8; solo: SLboolean): SLresult; cdecl;
    GetChannelSolo: function(self: SLMuteSoloItf; chan: SLuint8; pSolo: PSLboolean): SLresult; cdecl;
    GetNumChannels: function(self: SLMuteSoloItf; pNumChannels: PSLuint8)
: SLresult;
  end;
  {$EXTERNALSYM SLMuteSoloItf_}

  { --------------------------------------------------------------------------- }
  { Dynamic Interface Management Interface and associated types and macros }
  { -------------------------------------------------------------------------- }
const
  SL_DYNAMIC_ITF_EVENT_RUNTIME_ERROR: SLuint32 = $00000001;
  {$EXTERNALSYM SL_DYNAMIC_ITF_EVENT_RUNTIME_ERROR}
  SL_DYNAMIC_ITF_EVENT_ASYNC_TERMINATION: SLuint32 = $00000002;
  {$EXTERNALSYM SL_DYNAMIC_ITF_EVENT_ASYNC_TERMINATION}
  SL_DYNAMIC_ITF_EVENT_RESOURCES_LOST: SLuint32 = $00000003;
  {$EXTERNALSYM SL_DYNAMIC_ITF_EVENT_RESOURCES_LOST}
  SL_DYNAMIC_ITF_EVENT_RESOURCES_LOST_PERMANENTLY: SLuint32 = $00000004;
  {$EXTERNALSYM SL_DYNAMIC_ITF_EVENT_RESOURCES_LOST_PERMANENTLY}
  SL_DYNAMIC_ITF_EVENT_RESOURCES_AVAILABLE: SLuint32 = $00000005;
  {$EXTERNALSYM SL_DYNAMIC_ITF_EVENT_RESOURCES_AVAILABLE}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_DYNAMICINTERFACEMANAGEMENT;

  PSLDynamicInterfaceManagementItf_ = ^SLDynamicInterfaceManagementItf;
  SLDynamicInterfaceManagementItf = ^PSLDynamicInterfaceManagementItf_;
  {$EXTERNALSYM SLDynamicInterfaceManagementItf}

  slDynamicInterfaceManagementCallback = procedure
    (caller: SLDynamicInterfaceManagementItf; pContext: Pointer;
    event: SLuint32; result: SLresult; iid: SLInterfaceID); cdecl;

  SLDynamicInterfaceManagementItf_ = record
    AddInterface: function(self: SLDynamicInterfaceManagementItf; iid: SLInterfaceID; async: SLboolean): SLresult; cdecl;
    RemoveInterface: function(self: SLDynamicInterfaceManagementItf; iid: SLInterfaceID): SLresult; cdecl;
    ResumeInterface: function(self: SLDynamicInterfaceManagementItf; iid: SLInterfaceID; async: SLboolean): SLresult; cdecl;
    RegisterCallback: function(self: SLDynamicInterfaceManagementItf; callback: slDynamicInterfaceManagementCallback; pContext: Pointer): SLresult;
  end;
  {$EXTERNALSYM SLDynamicInterfaceManagementItf_}

  { --------------------------------------------------------------------------- }
  { Midi Message Interface and associated types }
  { -------------------------------------------------------------------------- }
const
  SL_MIDIMESSAGETYPE_NOTE_ON_OFF: SLuint32 = $00000001;
  {$EXTERNALSYM SL_MIDIMESSAGETYPE_NOTE_ON_OFF}
  SL_MIDIMESSAGETYPE_POLY_PRESSURE: SLuint32 = $00000002;
  {$EXTERNALSYM SL_MIDIMESSAGETYPE_POLY_PRESSURE}
  SL_MIDIMESSAGETYPE_CONTROL_CHANGE: SLuint32 = $00000003;
  {$EXTERNALSYM SL_MIDIMESSAGETYPE_CONTROL_CHANGE}
  SL_MIDIMESSAGETYPE_PROGRAM_CHANGE: SLuint32 = $00000004;
  {$EXTERNALSYM SL_MIDIMESSAGETYPE_PROGRAM_CHANGE}
  SL_MIDIMESSAGETYPE_CHANNEL_PRESSURE: SLuint32 = $00000005;
  {$EXTERNALSYM SL_MIDIMESSAGETYPE_CHANNEL_PRESSURE}
  SL_MIDIMESSAGETYPE_PITCH_BEND: SLuint32 = $00000006;
  {$EXTERNALSYM SL_MIDIMESSAGETYPE_PITCH_BEND}
  SL_MIDIMESSAGETYPE_SYSTEM_MESSAGE: SLuint32 = $00000007;
  {$EXTERNALSYM SL_MIDIMESSAGETYPE_SYSTEM_MESSAGE}

type
  // extern SLAPIENTRY const SLInterfaceID SL_IID_MIDIMESSAGE;

  PSLMIDIMessageItf_ = ^SLMIDIMessageItf;
  SLMIDIMessageItf = ^PSLMIDIMessageItf_;
  {$EXTERNALSYM SLMIDIMessageItf}

  slMetaEventCallback = procedure(caller: SLMIDIMessageItf; pContext: Pointer;
    _type: SLuint8; length: SLuint32; pData: PSLuint8; tick: SLuint32;
    track: SLuint16); cdecl;
  slMIDIMessageCallback = procedure(caller: SLMIDIMessageItf; pContext: Pointer;
    statusByte: SLuint8; length: SLuint32; pData: PSLuint8; tick: SLuint32;
    track: SLuint16); cdecl;

  SLMIDIMessageItf_ = record
    SendMessage: function(self: SLMIDIMessageItf; data: PSLuint8; length: SLuint32): SLresult; cdecl;
    RegisterMetaEventCallback: function(self: SLMIDIMessageItf; callback: slMetaEventCallback; pContext: Pointer): SLresult; cdecl;
    RegisterMIDIMessageCallback: function(self: SLMIDIMessageItf; callback: slMIDIMessageCallback; pContext: Pointer): SLresult; cdecl;
    AddMIDIMessageCallbackFilter: function(self: SLMIDIMessageItf; messageType: SLuint32): SLresult; cdecl;
    ClearMIDIMessageCallbackFilter: function(self: SLMIDIMessageItf) : SLresult;
  end;
  {$EXTERNALSYM SLMIDIMessageItf_}

  { --------------------------------------------------------------------------- }
  { Midi Mute Solo interface }
  { -------------------------------------------------------------------------- }

  PSLMIDIMuteSoloItf_ = ^SLMIDIMuteSoloItf;
  SLMIDIMuteSoloItf = ^PSLMIDIMuteSoloItf_;
  {$EXTERNALSYM SLMIDIMuteSoloItf}

  SLMIDIMuteSoloItf_ = record
    SetChannelMute: function(self: SLMIDIMuteSoloItf; channel: SLuint8; mute: SLboolean): SLresult; cdecl;
    GetChannelMute: function(self: SLMIDIMuteSoloItf; channel: SLuint8; pMute: PSLboolean): SLresult; cdecl;
    SetChannelSolo: function(self: SLMIDIMuteSoloItf; channel: SLuint8; solo: SLboolean): SLresult; cdecl;
    GetChannelSolo: function(self: SLMIDIMuteSoloItf; channel: SLuint8; pSolo: PSLboolean): SLresult; cdecl;
    GetTrackCount: function(self: SLMIDIMuteSoloItf; pCount: PSLuint16): SLresult;
    SetTrackMute: function(self: SLMIDIMuteSoloItf; track: SLuint16;  mute: SLboolean): SLresult; cdecl;
    GetTrackMute: function(self: SLMIDIMuteSoloItf; track: SLuint16; pMute: PSLboolean): SLresult; cdecl;
    SetTrackSolo: function(self: SLMIDIMuteSoloItf; track: SLuint16; solo: SLboolean): SLresult; cdecl;
    GetTrackSolo: function(self: SLMIDIMuteSoloItf; track: SLuint16; pSolo: PSLboolean): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLMIDIMuteSoloItf_}

  { --------------------------------------------------------------------------- }
  { Midi Tempo interface }
  { -------------------------------------------------------------------------- }

  PSLMIDITempoItf_ = ^SLMIDITempoItf;
  SLMIDITempoItf = ^PSLMIDITempoItf_;
  {$EXTERNALSYM SLMIDITempoItf}

  SLMIDITempoItf_ = record
    SetTicksPerQuarterNote: function(self: SLMIDITempoItf; tpqn: SLuint32)
: SLresult;
    GetTicksPerQuarterNote: function(self: SLMIDITempoItf; pTpqn: PSLuint32)
: SLresult;
    SetMicrosecondsPerQuarterNote: function(self: SLMIDITempoItf;
      uspqn: SLmicrosecond): SLresult; cdecl;
    GetMicrosecondsPerQuarterNote: function(self: SLMIDITempoItf;
      uspqn: PSLmicrosecond): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLMIDITempoItf_}

  { --------------------------------------------------------------------------- }
  { Midi Time interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_MIDITIME;

  PSLMIDITimeItf_ = ^SLMIDITimeItf;
  SLMIDITimeItf = ^PSLMIDITimeItf_;
  {$EXTERNALSYM SLMIDITimeItf}

  SLMIDITimeItf_ = record
    GetDuration: function(self: SLMIDITimeItf; pDuration: PSLuint32): SLresult;
    SetPosition: function(self: SLMIDITimeItf; position: SLuint32): SLresult;
    GetPosition: function(self: SLMIDITimeItf; pPosition: PSLuint32): SLresult;
    SetLoopPoints: function(self: SLMIDITimeItf; startTick: SLuint32; numTicks: SLuint32): SLresult; cdecl;
    GetLoopPoints: function(self: SLMIDITimeItf; pStartTick: PSLuint32; pNumTicks: PSLuint32): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLMIDITimeItf_}

  { --------------------------------------------------------------------------- }
  { Audio Decoder Capabilities Interface }
  { -------------------------------------------------------------------------- }
const
  { Audio Codec related defines }

  SL_RATECONTROLMODE_CONSTANTBITRATE: SLuint32 = $00000001;
  {$EXTERNALSYM SL_RATECONTROLMODE_CONSTANTBITRATE}
  SL_RATECONTROLMODE_VARIABLEBITRATE: SLuint32 = $00000002;
  {$EXTERNALSYM SL_RATECONTROLMODE_VARIABLEBITRATE}
  SL_AUDIOCODEC_PCM: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOCODEC_PCM}
  SL_AUDIOCODEC_MP3: SLuint32 = $00000002;
  {$EXTERNALSYM SL_AUDIOCODEC_MP3}
  SL_AUDIOCODEC_AMR: SLuint32 = $00000003;
  {$EXTERNALSYM SL_AUDIOCODEC_AMR}
  SL_AUDIOCODEC_AMRWB: SLuint32 = $00000004;
  {$EXTERNALSYM SL_AUDIOCODEC_AMRWB}
  SL_AUDIOCODEC_AMRWBPLUS: SLuint32 = $00000005;
  {$EXTERNALSYM SL_AUDIOCODEC_AMRWBPLUS}
  SL_AUDIOCODEC_AAC: SLuint32 = $00000006;
  {$EXTERNALSYM SL_AUDIOCODEC_AAC}
  SL_AUDIOCODEC_WMA: SLuint32 = $00000007;
  {$EXTERNALSYM SL_AUDIOCODEC_WMA}
  SL_AUDIOCODEC_REAL: SLuint32 = $00000008;
  {$EXTERNALSYM SL_AUDIOCODEC_REAL}
  SL_AUDIOPROFILE_PCM: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOPROFILE_PCM}
  SL_AUDIOPROFILE_MPEG1_L3: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOPROFILE_MPEG1_L3}
  SL_AUDIOPROFILE_MPEG2_L3: SLuint32 = $00000002;
  {$EXTERNALSYM SL_AUDIOPROFILE_MPEG2_L3}
  SL_AUDIOPROFILE_MPEG25_L3: SLuint32 = $00000003;
  {$EXTERNALSYM SL_AUDIOPROFILE_MPEG25_L3}
  SL_AUDIOCHANMODE_MP3_MONO: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOCHANMODE_MP3_MONO}
  SL_AUDIOCHANMODE_MP3_STEREO: SLuint32 = $00000002;
  {$EXTERNALSYM SL_AUDIOCHANMODE_MP3_STEREO}
  SL_AUDIOCHANMODE_MP3_JOINTSTEREO: SLuint32 = $00000003;
  {$EXTERNALSYM SL_AUDIOCHANMODE_MP3_JOINTSTEREO}
  SL_AUDIOCHANMODE_MP3_DUAL: SLuint32 = $00000004;
  {$EXTERNALSYM SL_AUDIOCHANMODE_MP3_DUAL}
  SL_AUDIOPROFILE_AMR: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOPROFILE_AMR}
  SL_AUDIOSTREAMFORMAT_CONFORMANCE: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_CONFORMANCE}
  SL_AUDIOSTREAMFORMAT_IF1: SLuint32 = $00000002;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_IF1}
  SL_AUDIOSTREAMFORMAT_IF2: SLuint32 = $00000003;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_IF2}
  SL_AUDIOSTREAMFORMAT_FSF: SLuint32 = $00000004;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_FSF}
  SL_AUDIOSTREAMFORMAT_RTPPAYLOAD: SLuint32 = $00000005;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_RTPPAYLOAD}
  SL_AUDIOSTREAMFORMAT_ITU: SLuint32 = $00000006;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_ITU}
  SL_AUDIOPROFILE_AMRWB: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOPROFILE_AMRWB}
  SL_AUDIOPROFILE_AMRWBPLUS: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOPROFILE_AMRWBPLUS}
  SL_AUDIOPROFILE_AAC_AAC: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOPROFILE_AAC_AAC}
  SL_AUDIOMODE_AAC_MAIN: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_MAIN}
  SL_AUDIOMODE_AAC_LC: SLuint32 = $00000002;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_LC}
  SL_AUDIOMODE_AAC_SSR: SLuint32 = $00000003;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_SSR}
  SL_AUDIOMODE_AAC_LTP: SLuint32 = $00000004;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_LTP}
  SL_AUDIOMODE_AAC_HE: SLuint32 = $00000005;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_HE}
  SL_AUDIOMODE_AAC_SCALABLE: SLuint32 = $00000006;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_SCALABLE}
  SL_AUDIOMODE_AAC_ERLC: SLuint32 = $00000007;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_ERLC}
  SL_AUDIOMODE_AAC_LD: SLuint32 = $00000008;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_LD}
  SL_AUDIOMODE_AAC_HE_PS: SLuint32 = $00000009;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_HE_PS}
  SL_AUDIOMODE_AAC_HE_MPS: SLuint32 = $0000000A;
  {$EXTERNALSYM SL_AUDIOMODE_AAC_HE_MPS}
  SL_AUDIOSTREAMFORMAT_MP2ADTS: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_MP2ADTS}
  SL_AUDIOSTREAMFORMAT_MP4ADTS: SLuint32 = $00000002;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_MP4ADTS}
  SL_AUDIOSTREAMFORMAT_MP4LOAS: SLuint32 = $00000003;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_MP4LOAS}
  SL_AUDIOSTREAMFORMAT_MP4LATM: SLuint32 = $00000004;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_MP4LATM}
  SL_AUDIOSTREAMFORMAT_ADIF: SLuint32 = $00000005;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_ADIF}
  SL_AUDIOSTREAMFORMAT_MP4FF: SLuint32 = $00000006;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_MP4FF}
  SL_AUDIOSTREAMFORMAT_RAW: SLuint32 = $00000007;
  {$EXTERNALSYM SL_AUDIOSTREAMFORMAT_RAW}
  SL_AUDIOPROFILE_WMA7: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOPROFILE_WMA7}
  SL_AUDIOPROFILE_WMA8: SLuint32 = $00000002;
  {$EXTERNALSYM SL_AUDIOPROFILE_WMA8}
  SL_AUDIOPROFILE_WMA9: SLuint32 = $00000003;
  {$EXTERNALSYM SL_AUDIOPROFILE_WMA9}
  SL_AUDIOPROFILE_WMA10: SLuint32 = $00000004;
  {$EXTERNALSYM SL_AUDIOPROFILE_WMA10}
  SL_AUDIOMODE_WMA_LEVEL1: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOMODE_WMA_LEVEL1}
  SL_AUDIOMODE_WMA_LEVEL2: SLuint32 = $00000002;
  {$EXTERNALSYM SL_AUDIOMODE_WMA_LEVEL2}
  SL_AUDIOMODE_WMA_LEVEL3: SLuint32 = $00000003;
  {$EXTERNALSYM SL_AUDIOMODE_WMA_LEVEL3}
  SL_AUDIOMODE_WMA_LEVEL4: SLuint32 = $00000004;
  {$EXTERNALSYM SL_AUDIOMODE_WMA_LEVEL4}
  SL_AUDIOMODE_WMAPRO_LEVELM0: SLuint32 = $00000005;
  {$EXTERNALSYM SL_AUDIOMODE_WMAPRO_LEVELM0}
  SL_AUDIOMODE_WMAPRO_LEVELM1: SLuint32 = $00000006;
  {$EXTERNALSYM SL_AUDIOMODE_WMAPRO_LEVELM1}
  SL_AUDIOMODE_WMAPRO_LEVELM2: SLuint32 = $00000007;
  {$EXTERNALSYM SL_AUDIOMODE_WMAPRO_LEVELM2}
  SL_AUDIOMODE_WMAPRO_LEVELM3: SLuint32 = $00000008;
  {$EXTERNALSYM SL_AUDIOMODE_WMAPRO_LEVELM3}
  SL_AUDIOPROFILE_REALAUDIO: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOPROFILE_REALAUDIO}
  SL_AUDIOMODE_REALAUDIO_G2: SLuint32 = $00000001;
  {$EXTERNALSYM SL_AUDIOMODE_REALAUDIO_G2}
  SL_AUDIOMODE_REALAUDIO_8: SLuint32 = $00000002;
  {$EXTERNALSYM SL_AUDIOMODE_REALAUDIO_8}
  SL_AUDIOMODE_REALAUDIO_10: SLuint32 = $00000003;
  {$EXTERNALSYM SL_AUDIOMODE_REALAUDIO_10}
  SL_AUDIOMODE_REALAUDIO_SURROUND: SLuint32 = $00000004;
  {$EXTERNALSYM SL_AUDIOMODE_REALAUDIO_SURROUND}

type
  SLAudioCodecDescriptor = record
    maxChannels: SLuint32;
    minBitsPerSample: SLuint32;
    maxBitsPerSample: SLuint32;
    minSampleRate: SLmilliHertz;
    maxSampleRate: SLmilliHertz;
    isFreqRangeContinuous: SLboolean;
    pSampleRatesSupported: ^SLmilliHertz;
    numSampleRatesSupported: SLuint32;
    minBitRate: SLuint32;
    maxBitRate: SLuint32;
    isBitrateRangeContinuous: SLboolean;
    pBitratesSupported: ^SLuint32;
    numBitratesSupported: SLuint32;
    profileSetting: SLuint32;
    modeSetting: SLuint32;
  end;
  {$EXTERNALSYM SLAudioCodecDescriptor}

  PSLAudioCodecDescriptor = ^SLAudioCodecDescriptor;

  { Structure used to retrieve the profile and level settings supported by an audio encoder }

  SLAudioCodecProfileMode = record
    profileSetting: SLuint32;
    modeSetting: SLuint32;
  end;
  {$EXTERNALSYM SLAudioCodecProfileMode}

  PSLAudioCodecProfileMode = ^SLAudioCodecProfileMode;

  // extern SLAPIENTRY const SLInterfaceID SL_IID_AUDIODECODERCAPABILITIES;

  PSLAudioDecoderCapabilitiesItf_ = ^SLAudioDecoderCapabilitiesItf_;
  SLAudioDecoderCapabilitiesItf = ^PSLAudioDecoderCapabilitiesItf_;
  {$EXTERNALSYM SLAudioDecoderCapabilitiesItf}

  SLAudioDecoderCapabilitiesItf_ = record
    GetAudioDecoders: function(self: SLAudioDecoderCapabilitiesItf; pNumDecoders: PSLuint32; pDecoderIds: PSLuint32): SLresult; cdecl;
    GetAudioDecoderCapabilities: function(self: SLAudioDecoderCapabilitiesItf; decoderId: SLuint32; pIndex: PSLuint32;
      pDescriptor: PSLAudioCodecDescriptor): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLAudioDecoderCapabilitiesItf_}

  { --------------------------------------------------------------------------- }
  { Audio Encoder Capabilities Interface }
  { -------------------------------------------------------------------------- }

  { Structure used when setting audio encoding parameters }

  SLAudioEncoderSettings = record
    encoderId: SLuint32;
    channelsIn: SLuint32;
    channelsOut: SLuint32;
    sampleRate: SLmilliHertz;
    bitRate: SLuint32;
    bitsPerSample: SLuint32;
    rateControl: SLuint32;
    profileSetting: SLuint32;
    levelSetting: SLuint32;
    channelMode: SLuint32;
    streamFormat: SLuint32;
    encodeOptions: SLuint32;
    blockAlignment: SLuint32;
  end;
  {$EXTERNALSYM SLAudioEncoderSettings}

  PSLAudioEncoderSettings = ^SLAudioEncoderSettings;

  // extern SLAPIENTRY const SLInterfaceID SL_IID_AUDIOENCODERCAPABILITIES;

  PSLAudioEncoderCapabilitiesItf_ = ^SLAudioEncoderCapabilitiesItf;
  SLAudioEncoderCapabilitiesItf = ^PSLAudioEncoderCapabilitiesItf_;
  {$EXTERNALSYM SLAudioEncoderCapabilitiesItf}

  SLAudioEncoderCapabilitiesItf_ = record
    GetAudioEncoders: function(self: SLAudioEncoderCapabilitiesItf; pNumEncoders: PSLuint32; pEncoderIds: PSLuint32): SLresult; cdecl;
    GetAudioEncoderCapabilities: function(self: SLAudioEncoderCapabilitiesItf; encoderId: SLuint32; pIndex: PSLuint32;
      pDescriptor: PSLAudioCodecDescriptor): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLAudioEncoderCapabilitiesItf_}

  { --------------------------------------------------------------------------- }
  { Audio Encoder Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_AUDIOENCODER;

  PSLAudioEncoderItf_ = ^SLAudioEncoderItf;
  SLAudioEncoderItf = ^PSLAudioEncoderItf_;
  {$EXTERNALSYM SLAudioEncoderItf}

  SLAudioEncoderItf_ = record
    SetEncoderSettings: function(self: SLAudioEncoderItf; pSettings: PSLAudioEncoderSettings): SLresult; cdecl;
    GetEncoderSettings: function(self: SLAudioEncoderItf; pSettings: PSLAudioEncoderSettings): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLAudioEncoderItf_}

  { --------------------------------------------------------------------------- }
  { Bass Boost Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_BASSBOOST;

  PSLBassBoostItf_ = ^SLBassBoostItf;
  SLBassBoostItf = ^PSLBassBoostItf_;
  {$EXTERNALSYM SLBassBoostItf}

  SLBassBoostItf_ = record
    SetEnabled: function(self: SLBassBoostItf; enabled: SLboolean): SLresult;
    IsEnabled: function(self: SLBassBoostItf; pEnabled: PSLboolean): SLresult;
    SetStrength: function(self: SLBassBoostItf; strength: SLpermille): SLresult;
    GetRoundedStrength: function(self: SLBassBoostItf; pStrength: PSLpermille): SLresult;
    IsStrengthSupported: function(self: SLBassBoostItf; pSupported: PSLboolean): SLresult;
  end;
  {$EXTERNALSYM SLBassBoostItf_}

  { --------------------------------------------------------------------------- }
  { Pitch Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_PITCH;

  PSLPitchItf_ = ^SLPitchItf;
  SLPitchItf = ^PSLPitchItf_;
  {$EXTERNALSYM SLPitchItf}

  SLPitchItf_ = record
    SetPitch: function(self: SLPitchItf; pitch: SLpermille): SLresult; cdecl;
    GetPitch: function(self: SLPitchItf; pPitch: PSLpermille): SLresult; cdecl;
    GetPitchCapabilities: function(self: SLPitchItf; pMinPitch: PSLpermille; pMaxPitch: PSLpermille): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLPitchItf_}

  { --------------------------------------------------------------------------- }
  { Rate Pitch Interface }
  { RatePitchItf is an interface for controlling the rate a sound is played }
  { back. A change in rate will cause a change in pitch. }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_RATEPITCH;

  PSLRatePitchItf_ = ^SLRatePitchItf;
  SLRatePitchItf = ^PSLRatePitchItf_;
  {$EXTERNALSYM SLRatePitchItf}

  SLRatePitchItf_ = record
    SetRate: function(self: SLRatePitchItf; rate: SLpermille): SLresult; cdecl;
    GetRate: function(self: SLRatePitchItf; pRate: PSLpermille): SLresult;
    GetRatePitchCapabilities: function(self: SLRatePitchItf; pMinRate: PSLpermille; pMaxRate: PSLpermille): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLRatePitchItf_}

  { --------------------------------------------------------------------------- }
  { Virtualizer Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_VIRTUALIZER;

  PSLVirtualizerItf_ = ^SLVirtualizerItf;
  SLVirtualizerItf = ^PSLVirtualizerItf_;
  {$EXTERNALSYM SLVirtualizerItf}

  SLVirtualizerItf_ = record
    SetEnabled: function(self: SLVirtualizerItf; enabled: SLboolean): SLresult;
    IsEnabled: function(self: SLVirtualizerItf; pEnabled: PSLboolean): SLresult;
    SetStrength: function(self: SLVirtualizerItf; strength: SLpermille): SLresult;
    GetRoundedStrength: function(self: SLVirtualizerItf; pStrength: PSLpermille): SLresult;
    IsStrengthSupported: function(self: SLVirtualizerItf; pSupported: PSLboolean): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLVirtualizerItf_}

  { --------------------------------------------------------------------------- }
  { Visualization Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_VISUALIZATION;

  PSLVisualizationItf_ = ^SLVisualizationItf;
  SLVisualizationItf = ^PSLVisualizationItf_;
  {$EXTERNALSYM SLVisualizationItf}

  slVisualizationCallback = procedure(pContext: Pointer; waveform: PSLuint8;
    fft: PSLuint8; sampleRate: SLmilliHertz); cdecl;

  SLVisualizationItf_ = record
    RegisterVisualizationCallback: function(self: SLVisualizationItf; callback: slVisualizationCallback; pContext: Pointer;
      rate: SLmilliHertz): SLresult;
    GetMaxRate: function(self: SLVisualizationItf; pRate: PSLmilliHertz): SLresult;
  end;
  {$EXTERNALSYM SLVisualizationItf_}

  { --------------------------------------------------------------------------- }
  { Engine Interface }
  { -------------------------------------------------------------------------- }

  // extern SLAPIENTRY const SLInterfaceID SL_IID_ENGINE;

  PSLEngineItf_ = ^SLEngineItf;
  SLEngineItf = ^PSLEngineItf_;
  {$EXTERNALSYM SLEngineItf}

  SLEngineItf_ = record
    CreateLEDDevice: function(self: SLEngineItf; pDevice: PSLObjectItf; deviceID: SLuint32;
      numInterfaces: SLuint32; pInterfaceIDs: PSLInterfaceID; pInterfaceRequired: PSLboolean): SLresult;
    CreateVibraDevice: function(self: SLEngineItf; pDevice: PSLObjectItf; deviceID: SLuint32;
      numInterfaces: SLuint32; pInterfaceIDs: PSLInterfaceID; pInterfaceRequired: PSLboolean): SLresult;
    CreateAudioPlayer: function(self: SLEngineItf; pPlayer: PSLObjectItf; pAudioSrc: PSLDataSource;
      pAudioSnk: PSLDataSink; numInterfaces: SLuint32; pInterfaceIDs: PSLInterfaceID;
      pInterfaceRequired: PSLboolean): SLresult;
    CreateAudioRecorder: function(self: SLEngineItf; pRecorder: PSLObjectItf; pAudioSrc: PSLDataSource;
      pAudioSnk: PSLDataSink; numInterfaces: SLuint32; pInterfaceIDs: PSLInterfaceID;
      pInterfaceRequired: PSLboolean): SLresult;
    CreateMidiPlayer: function(self: SLEngineItf; pPlayer: PSLObjectItf; pMIDISrc: PSLDataSource;
      pBankSrc: PSLDataSource; pAudioOutput: PSLDataSink; pVibra: PSLDataSink;
      pLEDArray: PSLDataSink; numInterfaces: SLuint32; pInterfaceIDs: PSLInterfaceID;
      pInterfaceRequired: PSLboolean): SLresult; cdecl;
    CreateListener: function(self: SLEngineItf; pListener: PSLObjectItf; numInterfaces: SLuint32;
      pInterfaceIDs: PSLInterfaceID; pInterfaceRequired: PSLboolean): SLresult; cdecl;
    Create3DGroup: function(self: SLEngineItf; pGroup: PSLObjectItf; numInterfaces: SLuint32;
      pInterfaceIDs: PSLInterfaceID; pInterfaceRequired: PSLboolean): SLresult; cdecl;
    CreateOutputMix: function(self: SLEngineItf; pMix: PSLObjectItf; numInterfaces: SLuint32;
      pInterfaceIDs: PSLInterfaceID; pInterfaceRequired: PSLboolean): SLresult; cdecl;
    CreateMetadataExtractor: function(self: SLEngineItf; pMetadataExtractor: PSLObjectItf; pDataSource: PSLDataSource;
      numInterfaces: SLuint32; pInterfaceIDs: PSLInterfaceID; pInterfaceRequired: PSLboolean): SLresult; cdecl;
    CreateExtensionObject: function(self: SLEngineItf; pObject: PSLObjectItf; pParameters: Pointer;
      objectID: SLuint32; numInterfaces: SLuint32; pInterfaceIDs: PSLInterfaceID;
      pInterfaceRequired: PSLboolean): SLresult;
    QueryNumSupportedInterfaces: function(self: SLEngineItf; objectID: SLuint32; pNumSupportedInterfaces: PSLuint32): SLresult; cdecl;
    QuerySupportedInterfaces: function(self: SLEngineItf; objectID: SLuint32; index: SLuint32;
      pInterfaceId: PSLInterfaceID): SLresult; cdecl;
    QueryNumSupportedExtensions: function(self: SLEngineItf; pNumExtensions: PSLuint32): SLresult; cdecl;
    QuerySupportedExtension: function(self: SLEngineItf; index: SLuint32; pExtensionName: PSLchar;
      pNameLength: PSLint16): SLresult; cdecl;
    IsExtensionSupported: function(self: SLEngineItf; pExtensionName: PSLchar; pSupported: PSLboolean): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLEngineItf}

  { --------------------------------------------------------------------------- }
  { Engine Capabilities Interface }
  { -------------------------------------------------------------------------- }


  // extern SLAPIENTRY const SLInterfaceID SL_IID_ENGINECAPABILITIES;

  PSLEngineCapabilitiesItf_ = ^SLEngineCapabilitiesItf;
  SLEngineCapabilitiesItf = ^PSLEngineCapabilitiesItf_;
  {$EXTERNALSYM SLEngineCapabilitiesItf}

  SLEngineCapabilitiesItf_ = record
    QuerySupportedProfiles: function(self: SLEngineCapabilitiesItf; pProfilesSupported: PSLuint16): SLresult; cdecl;
    QueryAvailableVoices: function(self: SLEngineCapabilitiesItf; voiceType: SLuint16; pNumMaxVoices: PSLint16;
      pIsAbsoluteMax: PSLboolean; pNumFreeVoices: PSLint16): SLresult; cdecl;
    QueryNumberOfMIDISynthesizers: function(self: SLEngineCapabilitiesItf; pNumMIDIsynthesizers: PSLint16): SLresult; cdecl;
    QueryAPIVersion: function(self: SLEngineCapabilitiesItf; pMajor: PSLint16; pMinor: PSLint16;
      pStep: PSLint16): SLresult; cdecl;
    QueryLEDCapabilities: function(self: SLEngineCapabilitiesItf; pIndex: PSLuint32; pLEDDeviceID: PSLuint32;
      pDescriptor: PSLLEDDescriptor): SLresult;
    QueryVibraCapabilities: function(self: SLEngineCapabilitiesItf; pIndex: PSLuint32; pVibraDeviceID: PSLuint32;
      pDescriptor: PSLVibraDescriptor): SLresult; cdecl;
    IsThreadSafe: function(self: SLEngineCapabilitiesItf; pIsThreadSafe: PSLboolean): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLEngineCapabilitiesItf_}

  { --------------------------------------------------------------------------- }
  { Thread Sync Interface }
  { -------------------------------------------------------------------------- }


  // extern SLAPIENTRY const SLInterfaceID SL_IID_THREADSYNC;

  PSLThreadSyncItf_ = ^SLThreadSyncItf;
  SLThreadSyncItf = ^PSLThreadSyncItf_;
  {$EXTERNALSYM SLThreadSyncItf}

  SLThreadSyncItf_ = record
    EnterCriticalSection: function(self: SLThreadSyncItf): SLresult; cdecl;
    ExitCriticalSection: function(self: SLThreadSyncItf): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLThreadSyncItf_}

  { *************************************************************************** }
  { SL engine constructor }
  { *************************************************************************** }
const
  SL_ENGINEOPTION_THREADSAFE: SLuint32 = $00000001;
  {$EXTERNALSYM SL_ENGINEOPTION_THREADSAFE}
  SL_ENGINEOPTION_LOSSOFCONTROL: SLuint32 = $00000002;
  {$EXTERNALSYM SL_ENGINEOPTION_LOSSOFCONTROL}

type
  SLEngineOption = record
    feature: SLuint32;
    data: SLuint32;
  end;
  {$EXTERNALSYM SLEngineOption}

  PSLEngineOption = ^SLEngineOption;

function slCreateEngine(pEngine: SLObjectItf; numOptions: SLuint32; const pEngineOptions: PSLEngineOption;
  numInterfaces: SLuint32; const pInterfaceIDs: PSLInterfaceID; const pInterfaceRequired: PSLInterfaceID): SLresult;
  external AndroidOpenSlesLib name 'slCreateEngine';
  {$EXTERNALSYM slCreateEngine}

function slQueryNumSupportedEngineInterfaces(pNumSupportedInterfaces: PSLuint32): SLresult;
  external AndroidOpenSlesLib name 'slQueryNumSupportedEngineInterfaces';
  {$EXTERNALSYM slQueryNumSupportedEngineInterfaces}

function slQuerySupportedEngineInterfaces(index: SLuint32; pInterfaceId: PSLInterfaceID): SLresult;
  external AndroidOpenSlesLib name 'slQuerySupportedEngineInterfaces';
  {$EXTERNALSYM slQuerySupportedEngineInterfaces}



  { OpenSLES_Android.h }
  { ------------------- }



  { ---------------------------------------------------------------------------}
  {  Android common types                                                      }
  { ---------------------------------------------------------------------------}

type
  SLAint64 = sl_int64_t;

  { ---------------------------------------------------------------------------}
  {  Android Effect interface                                                  }
  { ---------------------------------------------------------------------------}

//extern SLAPIENTRY const SLInterfaceID SL_IID_ANDROIDEFFECT;

  { Android Effect interface methods }
  PSLAndroidEffectItf_ = ^SLAndroidEffectItf_;
  SLAndroidEffectItf = ^PSLAndroidEffectItf_;
  {$EXTERNALSYM SLAndroidEffectItf}

  SLAndroidEffectItf_ = record
    CreateEffect: function(self: SLAndroidEffectItf; effectImplementationId: SLInterfaceID): SLresult; cdecl;
    ReleaseEffect: function(self: SLAndroidEffectItf; effectImplementationId: SLInterfaceID): SLresult; cdecl;
    SetEnabled: function(self: SLAndroidEffectItf; effectImplementationId: SLInterfaceID; enabled: SLboolean): SLresult; cdecl;
    IsEnabled: function(self: SLAndroidEffectItf; effectImplementationId: SLInterfaceID; pEnabled: PSLboolean): SLresult; cdecl;
    SendCommand: function(self: SLAndroidEffectItf; effectImplementationId: SLInterfaceID; command: SLuint32;
      commandSize: SLuint32; pCommandData: Pointer; replySize: PSLuint32;
      pReplyData: Pointer): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLAndroidEffectItf_}


  { ---------------------------------------------------------------------------}
  {  Android Effect Send interface                                             }
  { ---------------------------------------------------------------------------}

//extern SLAPIENTRY const SLInterfaceID SL_IID_ANDROIDEFFECTSEND;

  { Android Effect Send interface methods }

  PSLAndroidEffectSendItf_ = ^SLAndroidEffectSendItf_;
  SLAndroidEffectSendItf = ^PSLAndroidEffectSendItf_;
  {$EXTERNALSYM SLAndroidEffectSendItf}

  SLAndroidEffectSendItf_ = record
    EnableEffectSend: function(self: SLAndroidEffectSendItf; effectImplementationId: SLInterfaceID; enable: SLboolean; initialLevel: SLmillibel): SLresult; cdecl;
    IsEnabled: function(self: SLAndroidEffectSendItf; effectImplementationId: SLInterfaceID; pEnable: PSLboolean): SLresult; cdecl;
    SetDirectLevel: function(self: SLAndroidEffectSendItf; directLevel: SLmillibel): SLresult; cdecl;
    GetDirectLevel: function(self: SLAndroidEffectSendItf; pDirectLevel: PSLmillibel): SLresult; cdecl;
    SetSendLevel: function(self: SLAndroidEffectSendItf; effectImplementationId: SLInterfaceID; sendLevel: SLmillibel): SLresult; cdecl;
    GetSendLevel: function(self: SLAndroidEffectSendItf; effectImplementationId: SLInterfaceID; pSendLevel: PSLmillibel): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLAndroidEffectSendItf_}



  { ---------------------------------------------------------------------------}
  {  Android Effect Capabilities interface                                     }
  { ---------------------------------------------------------------------------}

//extern SLAPIENTRY const SLInterfaceID SL_IID_ANDROIDEFFECTCAPABILITIES;

  { Android Effect Capabilities interface methods }

  PSLAndroidEffectCapabilitiesItf_ = ^SLAndroidEffectCapabilitiesItf_;
  SLAndroidEffectCapabilitiesItf = ^PSLAndroidEffectCapabilitiesItf_;
  {$EXTERNALSYM SLAndroidEffectCapabilitiesItf}

  SLAndroidEffectCapabilitiesItf_ = record
    QueryNumEffects: function(self: SLAndroidEffectCapabilitiesItf; pNumSupportedEffects: PSLuint32): SLresult; cdecl;
    QueryEffect: function(self: SLAndroidEffectCapabilitiesItf; index: SLuint32; pEffectType: PSLInterfaceID;
      pEffectImplementation: PSLInterfaceID; pName: PSLchar; pNameSize: PSLuint16): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLAndroidEffectCapabilitiesItf_}


  { ---------------------------------------------------------------------------}
  {  Android Configuration interface                                           }
  { ---------------------------------------------------------------------------}
//extern SLAPIENTRY const SLInterfaceID SL_IID_ANDROIDCONFIGURATION;

  { Android Configuration interface methods }

  PSLAndroidConfigurationItf_ = ^SLAndroidConfigurationItf_;
  SLAndroidConfigurationItf = ^PSLAndroidConfigurationItf_;
  {$EXTERNALSYM SLAndroidConfigurationItf}

  SLAndroidConfigurationItf_ = record
    SetConfiguration: function(self: SLAndroidConfigurationItf; configKey: PSLchar; pConfigValue: Pointer; valueSize: SLuint32): SLresult; cdecl;
    GetConfiguration: function(self: SLAndroidConfigurationItf; configKey: PSLchar; pValueSize: PSLuint32; pConfigValue: Pointer): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLAndroidConfigurationItf_}


  { ---------------------------------------------------------------------------}
  {  Android Simple Buffer Queue Interface                                     }
  { ---------------------------------------------------------------------------}

//extern SLAPIENTRY const SLInterfaceID SL_IID_ANDROIDSIMPLEBUFFERQUEUE;

  { Android simple buffer queue state }
  SLAndroidSimpleBufferQueueState = record
    count: SLuint32;
    index: SLuint32;
  end;
  {$EXTERNALSYM SLAndroidSimpleBufferQueueState}
  PSLAndroidSimpleBufferQueueState = ^SLAndroidSimpleBufferQueueState;

  PSLAndroidSimpleBufferQueueItf_ = ^SLAndroidSimpleBufferQueueItf_;
  SLAndroidSimpleBufferQueueItf = ^PSLAndroidSimpleBufferQueueItf_;
  {$EXTERNALSYM SLAndroidSimpleBufferQueueItf}

  slAndroidSimpleBufferQueueCallback = procedure (caller: SLAndroidSimpleBufferQueueItf; pContext: Pointer); cdecl;

  SLAndroidSimpleBufferQueueItf_ = record
    Enqueue: function(self: SLAndroidSimpleBufferQueueItf; pBuffer: Pointer; size: SLuint32): SLresult; cdecl;
    Clear: function(self: SLAndroidSimpleBufferQueueItf): SLresult; cdecl;
    GetState: function(self: SLAndroidSimpleBufferQueueItf; pState: PSLAndroidSimpleBufferQueueState): SLresult; cdecl;
    RegisterCallback: function(self: SLAndroidSimpleBufferQueueItf; callback: slAndroidSimpleBufferQueueCallback; pContext: Pointer): SLresult; cdecl;
  end;
  {$EXTERNALSYM SLAndroidSimpleBufferQueueItf_}

  { ---------------------------------------------------------------------------}
  {  Android File Descriptor Data Locator                                      }
  { ---------------------------------------------------------------------------}

const
  { Addendum to Data locator macros  }
  SL_DATALOCATOR_ANDROIDFD: SLuint32 = $800007BC;
  {$EXTERNALSYM SL_DATALOCATOR_ANDROIDFD}

  SL_DATALOCATOR_ANDROIDFD_USE_FILE_SIZE: SLAint64 = SLAint64($FFFFFFFFFFFFFFFF);
  {$EXTERNALSYM SL_DATALOCATOR_ANDROIDFD_USE_FILE_SIZE}

type
  { File Descriptor-based data locator definition, locatorType must be SL_DATALOCATOR_ANDROIDFD }
  SLDataLocator_AndroidFD = record
    locatorType: SLuint32;
    fd: SLint32;
    offset: SLAint64;
    length: SLAint64;
  end;
  {$EXTERNALSYM SLDataLocator_AndroidFD}
  PSLDataLocator_AndroidFD = ^SLDataLocator_AndroidFD;

  { ---------------------------------------------------------------------------}
  {  Android Android Simple Buffer Queue Data Locator                          }
  { ---------------------------------------------------------------------------}

const
  { Addendum to Data locator macros  }
  SL_DATALOCATOR_ANDROIDSIMPLEBUFFERQUEUE: SLuint32 = $800007BD;
  {$EXTERNALSYM SL_DATALOCATOR_ANDROIDSIMPLEBUFFERQUEUE}

type
  { BufferQueue-based data locator definition where locatorType must be SL_DATALOCATOR_ANDROIDSIMPLEBUFFERQUEUE}
  SLDataLocator_AndroidSimpleBufferQueue = record
    locatorType: SLuint32;
    numBuffers: SLuint32;
  end;
  {$EXTERNALSYM SLDataLocator_AndroidSimpleBufferQueue}
  PSLDataLocator_AndroidSimpleBufferQueue = ^SLDataLocator_AndroidSimpleBufferQueue;


  { OpenSLES_AndroidConfiguration.h }
  { ------------------- }


  { ---------------------------------------------------------------------------}
  {  Android AudioRecorder configuration                                       }
  { ---------------------------------------------------------------------------}
const
  { Audio recording preset }
  { Audio recording preset key }
  SL_ANDROID_KEY_RECORDING_PRESET: PSLchar = 'androidRecordingPreset';
  {$EXTERNALSYM SL_ANDROID_KEY_RECORDING_PRESET}
  { Audio recording preset values }
  { preset "none" cannot be set, it is used to indicate the current settings
    do not match any of the presets. }
  SL_ANDROID_RECORDING_PRESET_NONE: SLuint32 = $00000000;
  {$EXTERNALSYM SL_ANDROID_RECORDING_PRESET_NONE}
  { generic recording configuration on the platform }
  SL_ANDROID_RECORDING_PRESET_GENERIC: SLuint32 = $00000001;
  {$EXTERNALSYM SL_ANDROID_RECORDING_PRESET_GENERIC}
  { uses the microphone audio source with the same orientation as the camera
    if available, the main device microphone otherwise }
  SL_ANDROID_RECORDING_PRESET_CAMCORDER: SLuint32 = $00000002;
  {$EXTERNALSYM SL_ANDROID_RECORDING_PRESET_CAMCORDER}
  {   uses the main microphone tuned for voice recognition }
  SL_ANDROID_RECORDING_PRESET_VOICE_RECOGNITION: SLuint32 = $00000003;
  {$EXTERNALSYM SL_ANDROID_RECORDING_PRESET_VOICE_RECOGNITION}

  { ---------------------------------------------------------------------------}
  {  Android AudioPlayer configuration                                         }
  { ---------------------------------------------------------------------------}

  { Audio playback stream type }
  { Audio playback stream type key }
  SL_ANDROID_KEY_STREAM_TYPE: PSLchar = 'androidPlaybackStreamType';
  {$EXTERNALSYM SL_ANDROID_KEY_STREAM_TYPE}

  { Audio playback stream type  values }
  {       same as android.media.AudioManager.STREAM_VOICE_CALL }
  SL_ANDROID_STREAM_VOICE: SLint32 = $00000000;
  {$EXTERNALSYM SL_ANDROID_STREAM_VOICE}
  {       same as android.media.AudioManager.STREAM_SYSTEM }
  SL_ANDROID_STREAM_SYSTEM: SLint32 = $00000001;
  {$EXTERNALSYM SL_ANDROID_STREAM_SYSTEM}
  {       same as android.media.AudioManager.STREAM_RING }
  SL_ANDROID_STREAM_RING: SLint32 = $00000002;
  {$EXTERNALSYM SL_ANDROID_STREAM_RING}
  {       same as android.media.AudioManager.STREAM_MUSIC }
  SL_ANDROID_STREAM_MEDIA: SLint32 = $00000003;
  {$EXTERNALSYM SL_ANDROID_STREAM_MEDIA}
  {       same as android.media.AudioManager.STREAM_ALARM }
  SL_ANDROID_STREAM_ALARM: SLint32 = $00000004;
  {$EXTERNALSYM SL_ANDROID_STREAM_ALARM}
  {       same as android.media.AudioManager.STREAM_NOTIFICATION }
  SL_ANDROID_STREAM_NOTIFICATION: SLint32 = $00000005;
  {$EXTERNALSYM SL_ANDROID_STREAM_NOTIFICATION}



implementation

end.
