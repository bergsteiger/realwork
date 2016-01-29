{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnTwain
|
| Description: Twain types and routines.
|              See Twain developer's toolkit for documentation of types.
|              www.twain.org
|
| History: Feb 28, 1999. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnTwain;

{$I Envision.Inc}

interface

uses
    Windows,  { for THandle }
    SysUtils, { for Exception }
    EnMisc;   { for TImageFormat }

const

TWRC_SUCCESS           = 0;
TWRC_FAILURE           = 1;
TWRC_CANCEL            = 3;
TWRC_CHECKSTATUS       = 2;
TWRC_DSEVENT           = 4;
TWRC_XFERDONE          = 6;

TWCC_SUCCESS           = 0;

DG_CONTROL             = $00001;
DG_IMAGE               = $00002;

DAT_CAPABILITY         = $00001;
DAT_EVENT              = $00002;
DAT_PENDINGXFERS       = $00005;
DAT_USERINTERFACE      = $00009;
DAT_IMAGEINFO          = $00101;
DAT_IMAGENATIVEXFER    = $00104;


TWON_PROTOCOLMINOR     = 5;
TWON_PROTOCOLMAJOR     = 1;

TWON_ONEVALUE          = 5;

TWTY_INT16             = $00001;   
TWTY_UINT16            = $00004;
TWTY_FIX32             = $00007;

TWPT_BW                = 0;
TWPT_GRAY              = 1;
TWPT_RGB               = 2;
TWPT_PALETTE           = 3;

TWSX_NATIVE            = 0;

TWLG_DAN               =  0; { Danish                 }
TWLG_DUT               =  1; { Dutch                  }
TWLG_ENG               =  2; { International English  }
TWLG_FCF               =  3; { French Canadian        }
TWLG_FIN               =  4; { Finnish                }
TWLG_FRN               =  5; { French                 }
TWLG_GER               =  6; { German                 }
TWLG_ICE               =  7; { Icelandic              }
TWLG_ITN               =  8; { Italian                }
TWLG_NOR               =  9; { Norwegian              }
TWLG_POR               = 10; { Portuguese             }
TWLG_SPA               = 11; { Spanish                }
TWLG_SWE               = 12; { Swedish                }
TWLG_USA               = 13; { U.S. English           }

TWCY_AFGHANISTAN       = 1001;
TWCY_ALGERIA           =  213;
TWCY_AMERICANSAMOA     =  684;
TWCY_ANDORRA           =  033;
TWCY_ANGOLA            = 1002;
TWCY_ANGUILLA          = 8090;
TWCY_ANTIGUA           = 8091;
TWCY_ARGENTINA         =   54;
TWCY_ARUBA             =  297;
TWCY_ASCENSIONI        =  247;
TWCY_AUSTRALIA         =   61;
TWCY_AUSTRIA           =   43;
TWCY_BAHAMAS           = 8092;
TWCY_BAHRAIN           =  973;
TWCY_BANGLADESH        =  880;
TWCY_BARBADOS          = 8093;
TWCY_BELGIUM           =   32;
TWCY_BELIZE            =  501;
TWCY_BENIN             =  229;
TWCY_BERMUDA           = 8094;
TWCY_BHUTAN            = 1003;
TWCY_BOLIVIA           =  591;
TWCY_BOTSWANA          =  267;
TWCY_BRITAIN           =    6;
TWCY_BRITVIRGINIS      = 8095;
TWCY_BRAZIL            =   55;
TWCY_BRUNEI            =  673;
TWCY_BULGARIA          =  359;
TWCY_BURKINAFASO       = 1004;
TWCY_BURMA             = 1005;
TWCY_BURUNDI           = 1006;
TWCY_CAMAROON          =  237;
TWCY_CANADA            =    2;
TWCY_CAPEVERDEIS       =  238;
TWCY_CAYMANIS          = 8096;
TWCY_CENTRALAFREP      = 1007;
TWCY_CHAD              = 1008;
TWCY_CHILE             =   56;
TWCY_CHINA             =   86;
TWCY_CHRISTMASIS       = 1009;
TWCY_COCOSIS           = 1009;
TWCY_COLOMBIA          =   57;
TWCY_COMOROS           = 1010;
TWCY_CONGO             = 1011;
TWCY_COOKIS            = 1012;
TWCY_COSTA_RICA        =  506;
TWCY_CUBA              =  005;
TWCY_CYPRUS            =  357;
TWCY_CZECHOSLOVAKIA    =   42;
TWCY_DENMARK           =   45;
TWCY_DJIBOUTI          = 1013;
TWCY_DOMINICA          = 8097;
TWCY_DOMINCANREP       = 8098;
TWCY_EASTERIS          = 1014;
TWCY_ECUADOR           =  593;
TWCY_EGYPT             =   20;
TWCY_ELSALVADOR        =  503;
TWCY_EQGUINEA          = 1015;
TWCY_ETHIOPIA          =  251;
TWCY_FALKLANDIS        = 1016;
TWCY_FAEROEIS          =  298;
TWCY_FIJIISLANDS       =  679;
TWCY_FINLAND           =  358;
TWCY_FRANCE            =   33;
TWCY_FRANTILLES        =  596;
TWCY_FRGUIANA          =  594;
TWCY_FRPOLYNEISA       =  689;
TWCY_FUTANAIS          = 1043;
TWCY_GABON             =  241;
TWCY_GAMBIA            =  220;
TWCY_GERMANY           =   49;
TWCY_GHANA             =  233;
TWCY_GIBRALTER         =  350;
TWCY_GREECE            =   30;
TWCY_GREENLAND         =  299;
TWCY_GRENADA           = 8099;
TWCY_GRENEDINES        = 8015;
TWCY_GUADELOUPE        =  590;
TWCY_GUAM              =  671;
TWCY_GUANTANAMOBAY     = 5399;
TWCY_GUATEMALA         =  502;
TWCY_GUINEA            =  224;
TWCY_GUINEABISSAU      = 1017;
TWCY_GUYANA            =  592;
TWCY_HAITI             =  509;
TWCY_HONDURAS          =  504;
TWCY_HONG_KONG         =  852;
TWCY_HUNGARY           =   36;
TWCY_ICELAND           =  354;
TWCY_INDIA             =   91;
TWCY_INDONESIA         =   62;
TWCY_IRAN              =   98;
TWCY_IRAQ              =  964;
TWCY_IRELAND           =  353;
TWCY_ISRAEL            =  972;
TWCY_ITALY             =   39;
TWCY_IVORY_COAST       =  225;
TWCY_JAMAICA           = 8010;
TWCY_JAPAN             =   81;
TWCY_JORDAN            =  962;
TWCY_KENYA             =  254;
TWCY_KIRIBATI          = 1018;
TWCY_KOREA             =   82;
TWCY_KUWAIT            =  965;
TWCY_LAOS              = 1019;
TWCY_LEBANON           = 1020;
TWCY_LIBERIA           =  231;
TWCY_LIBYA             =  218;
TWCY_LIECHTENSTEIN     =   41;
TWCY_LUXENBOURG        =  352;
TWCY_MACAO             =  853;
TWCY_MADAGASCAR        = 1021;
TWCY_MALAWI            =  265;
TWCY_MALAYSIA          =   60;
TWCY_MALDIVES          =  960;
TWCY_MALI              = 1022;
TWCY_MALTA             =  356;
TWCY_MARSHALLIS        =  692;
TWCY_MAURITANIA        = 1023;
TWCY_MAURITIUS         =  230;
TWCY_MEXICO            =    3;
TWCY_MICRONESIA        =  691;
TWCY_MIQUELON          =  508;
TWCY_MONACO            =   33;
TWCY_MONGOLIA          = 1024;
TWCY_MONTSERRAT        = 8011;
TWCY_MOROCCO           =  212;
TWCY_MOZAMBIQUE        = 1025;
TWCY_NAMIBIA           =  264;
TWCY_NAURU             = 1026;
TWCY_NEPAL             =  977;
TWCY_NETHERLANDS       =   31;
TWCY_NETHANTILLES      =  599;
TWCY_NEVIS             = 8012;
TWCY_NEWCALEDONIA      =  687;
TWCY_NEWZEALAND        =   64;
TWCY_NICARAGUA         =  505;
TWCY_NIGER             =  227;
TWCY_NIGERIA           =  234;
TWCY_NIUE              = 1027;
TWCY_NORFOLKI          = 1028;
TWCY_NORWAY            =   47;
TWCY_OMAN              =  968;
TWCY_PAKISTAN          =   92;
TWCY_PALAU             = 1029;
TWCY_PANAMA            =  507;
TWCY_PARAGUAY          =  595;
TWCY_PERU              =   51;
TWCY_PHILLIPPINES      =   63;
TWCY_PITCAIRNIS        = 1030;
TWCY_PNEWGUINEA        =  675;
TWCY_POLAND            =   48;
TWCY_PORTUGAL          =  351;
TWCY_QATAR             =  974;
TWCY_REUNIONI          = 1031;
TWCY_ROMANIA           =   40;
TWCY_RWANDA            =  250;
TWCY_SAIPAN            =  670;
TWCY_SANMARINO         =  039;
TWCY_SAOTOME           = 1033;
TWCY_SAUDIARABIA       =  966;
TWCY_SENEGAL           =  221;
TWCY_SEYCHELLESIS      = 1034;
TWCY_SIERRALEONE       = 1035;
TWCY_SINGAPORE         =   65;
TWCY_SOLOMONIS         = 1036;
TWCY_SOMALI            = 1037;
TWCY_SOUTH_AFRICA      =   27;
TWCY_SPAIN             =   34;
TWCY_SRILANKA          =   94;
TWCY_STHELENA          = 1032;
TWCY_STKITTS           = 8013;
TWCY_STLUCIA           = 8014;
TWCY_STPIERRE          =  508;
TWCY_STVINCENT         = 8015;
TWCY_SUDAN             = 1038;
TWCY_SURINAME          =  597;
TWCY_SWAZILAND         =  268;
TWCY_SWEDEN            =   46;
TWCY_SWITZERLAND       =   41;
TWCY_SYRIA             = 1039;
TWCY_TAIWAN            =  886;
TWCY_TANZANIA          =  255;
TWCY_THAILAND          =   66;
TWCY_TOBAGO            = 8016;
TWCY_TOGO              =  228;
TWCY_TONGAIS           =  676;
TWCY_TRINIDAD          = 8016;
TWCY_TUNISIA           =  216;
TWCY_TURKEY            =   90;
TWCY_TURKSCAICOS       = 8017;
TWCY_TUVALU            = 1040;
TWCY_UGANDA            =  256;
TWCY_USSR              =    7;
TWCY_UAEMIRATES        =  971;
TWCY_UNITEDKINGDOM     =   44;
TWCY_USA               =    1;
TWCY_URUGUAY           =  598;
TWCY_VANUATU           = 1041;
TWCY_VATICANCITY       =   39;
TWCY_VENEZUELA         =   58;
TWCY_WAKE              = 1042;
TWCY_WALLISIS          = 1043;
TWCY_WESTERNSAHARA     = 1044;
TWCY_WESTERNSAMOA      = 1045;
TWCY_YEMEN             = 1046;
TWCY_YUGOSLAVIA        =   38;
TWCY_ZAIRE             =  243;
TWCY_ZAMBIA            =  260;
TWCY_ZIMBABWE          =  263;


DAT_IDENTITY           = $00003;
DAT_PARENT             = $00004;
DAT_STATUS             = $00008;

MSG_NULL               = $00000;
MSG_GET                = $00001;
MSG_SET                = $00006;
MSG_RESET              = $00007;
MSG_XFERREADY          = $00101;
MSG_CLOSEDSREQ         = $00102;
MSG_ENDXFER            = $00701;
MSG_PROCESSEVENT       = $00601;

MSG_OPENDSM            = $00301;
MSG_CLOSEDSM           = $00302;
MSG_OPENDS             = $00401;
MSG_CLOSEDS            = $00402;
MSG_USERSELECT         = $00403;
MSG_DISABLEDS          = $00501; 
MSG_ENABLEDS           = $00502;

ICAP_PIXELTYPE         = $00101;
ICAP_UNITS             = $00102;
ICAP_XFERMECH          = $00103;
ICAP_BITDEPTH          = $0112b;
ICAP_XRESOLUTION       = $01118;
ICAP_YRESOLUTION       = $01119;

TWUN_INCHES            = 0;

CAP_XFERCOUNT          = $00001;


const

{$ifdef Win32}
CTwainDLLFileName = 'TWAIN_32.DLL';
{$else}
CTwainDLLFileName = 'TWAIN.DLL';
{$endif}

type

TW_INT8    = ShortInt;
TW_INT16   = smallint;
TW_INT32   = longint;
TW_UINT8   = byte;
TW_UINT16  = word;
TW_UINT32  = longint;
TW_BOOL    = WordBool;

pTW_INT8   = ^TW_INT8;
pTW_INT16  = ^TW_INT16;
pTW_INT32  = ^TW_INT32;
pTW_UINT8  = ^TW_UINT8;
pTW_UINT16 = ^TW_UINT16;
pTW_UINT32 = ^TW_UINT32;
pTW_BOOL   = ^TW_BOOL;

TW_STR32   = array[0..33] of char;
pTW_STR32  = ^TW_STR32;

TW_MEMREF  = Pointer;

TW_HANDLE  = THandle;

TW_EVENT  = packed record
    pEvent    : TW_MEMREF;
    TWMessage : TW_UINT16;
end;
pTW_EVENT = ^TW_EVENT;


TW_FIX32 = packed record
    case Word of
    0 : (Long  : Longint);
    1 : (Whole : TW_INT16;
         Frac  : TW_UINT16);
end;
pTW_FIX32  = ^TW_FIX32;

TW_USERINTERFACE = packed record
    ShowUI  : TW_BOOL;
    ModalUI : TW_BOOL;
    hParent : TW_HANDLE; 
end;
pTW_USERINTERFACE = ^TW_USERINTERFACE;

TW_IMAGEINFO = packed record
    XResolution     : TW_FIX32;
    YResolution     : TW_FIX32;
    ImageWidth      : TW_INT32;
    ImageLength     : TW_INT32;
    SamplesPerPixel : TW_INT16;
    BitsPerSample   : array[0..7] of TW_INT16;
    BitsPerPixel    : TW_INT16;
    Planar          : TW_BOOL;
    PixelType       : TW_INT16;
    Compression     : TW_UINT16;
end;
pTW_IMAGEINFO = ^TW_IMAGEINFO;


TW_PENDINGXFERS = packed record
    Count           : TW_UINT16;
    Reserved        : TW_UINT32;
end;
pTW_PENDINGXFERS = ^TW_PENDINGXFERS;


TW_ONEVALUE = packed record
    ItemType    : TW_UINT16;
    Item        : TW_UINT32;
end;
pTW_ONEVALUE = ^TW_ONEVALUE;

TW_CAPABILITY = packed record
    Cap        : TW_UINT16;
    ConType    : TW_UINT16;
    hContainer : TW_HANDLE;
end;
pTW_CAPABILITY = ^TW_CAPABILITY;

TW_VERSION = packed record
    MajorNum   : TW_UINT16;
    MinorNum   : TW_UINT16;
    Language   : TW_UINT16;
    Country    : TW_UINT16;
    Info       : TW_STR32;
end;
pTW_VERSION = ^TW_VERSION;


TW_IDENTITY = packed record
    Id              : TW_UINT32;
    Version         : TW_VERSION;
    ProtocolMajor   : TW_UINT16;
    ProtocolMinor   : TW_UINT16;
    SupportedGroups : TW_UINT32;
    Manufacturer    : TW_STR32;
    ProductFamily   : TW_STR32;
    ProductName     : TW_STR32;
end;
pTW_IDENTITY = ^TW_IDENTITY;


TW_STATUS = packed record
    ConditionCode : TW_UINT16;
    Reserved      : TW_UINT16;
end;
pTW_STATUS = ^TW_STATUS;


TDSM_Entry = function( pOrigin : pTW_IDENTITY;
                       pDest   : pTW_IDENTITY;
                       DG      : TW_UINT32;
                       DAT     : TW_UINT16;
                       MSG     : TW_UINT16;
                       pData   : TW_MEMREF) : TW_UINT16; {$ifdef Win32}
                                                          stdcall;
                                                          {$endif}

TTwainData = record

    DllHandle     : THandle;
    DSMEntry      : TDSM_Entry;
    ParentHandle  : THandle;

    AppId         : TW_IDENTITY;
    SourceId      : TW_IDENTITY;

    ShowUI        : Boolean;
    XDpi          : Word;
    YDpi          : Word;
    ImageFormat   : TImageFormat;
end;

ETwainError = class(Exception);

function CallTriplet( const pSourceId    : PTW_IDENTITY;
                      const pAppId       : PTW_IDENTITY;
                      const DataGroup    : TW_UINT32;
                      const DataType     : TW_UINT16;
                      const Msg          : TW_UINT16;
                      const pData        : TW_MEMREF;
                      const pTwainResult : PTW_UINT16;
                      const DsmEntry     : TDSM_Entry ) : Boolean;

{ set a single value capability. }
procedure SetSingleValueCap( const CapId      : TW_UINT16;
                             const ItemType   : TW_UINT16;
                             const Value      : TW_UINT32;
                             const pSourceId  : pTW_IDENTITY;
                             const pAppId     : pTW_IDENTITY;
                             const DsmEntry   : TDSM_Entry );

{ Abort a TWAIN transfer. Changes from TWAIN state 6 to 5. }
procedure AbortTransfer( const pSourceId  : pTW_IDENTITY;
                         const pAppId     : pTW_IDENTITY;
                         const DsmEntry   : TDSM_Entry );

{ Concludes a transfer with TWAIN. Returns True if there are more images
  to transfer. On return, if PendingTransfers returns False, TWAIN is
  in state 5; if PendingTranfser is True, TWAIN is in State 6.}
procedure ConcludeTransfer( var   PendingTransfers : TW_BOOL;
                            const pSourceId  : pTW_IDENTITY;
                            const pAppId     : pTW_IDENTITY;
                            const DsmEntry   : TDSM_Entry );

procedure ProcessImages( const AcquireEvent : TAcquireEvent;
                         const pSourceId    : pTW_IDENTITY;
                         const pAppId       : pTW_IDENTITY;
                         const DsmEntry     : TDSM_Entry;
                         const CallBackData : LongInt );

procedure GetAllImages( var   Msg          : TMsg;
                        var   TwainQuit    : Boolean;
                        const AcquireEvent : TAcquireEvent;
                        const pSourceId    : pTW_IDENTITY;
                        const pAppId       : pTW_IDENTITY;
                        const DsmEntry     : TDSM_Entry;
                        const CallBackData : LongInt );

{--------------------------------------------------------------------------}

implementation

uses
    EnMsg,    { for msgOutOfResources }
    Classes;  { for EOutOfResources }

procedure RaiseOutOfResources;
begin
    raise EOutOfResources.Create(msgOutOfResources);
end;

{--------------------------------------------------------------------------}

function CallTriplet( const pSourceId    : PTW_IDENTITY;
                      const pAppId       : PTW_IDENTITY;
                      const DataGroup    : TW_UINT32;
                      const DataType     : TW_UINT16;
                      const Msg          : TW_UINT16;
                      const pData        : TW_MEMREF;
                      const pTwainResult : PTW_UINT16;
                      const DsmEntry     : TDSM_Entry ) : Boolean;
var
    TwainResult : TW_UINT16;
    TwStatus    : TW_STATUS;
begin

    TwainResult := DSMEntry(
                           pAppId, pSourceId,
                           DataGroup,
                           DataType,
                           Msg, pData );

    Result := (TwainResult = TWRC_SUCCESS);

    if pTwainResult <> nil then
        pTwainResult^ := TwainResult;

    if not Result then
    begin
         { for debugging }
         DSMEntry( pAppId, pSourceId,
                   DG_CONTROL,
                   DAT_STATUS,
                   MSG_GET,
                   @TwStatus );

         { in some cases, (ie, when hiding the user interface on
           HP ScanJet 5s), TwainResult = TWRC_CHECKSTATUS, so the result
           seems the be dependent on the status. }
         Result := (TwainResult            = TWRC_CHECKSTATUS) and
                   (TwStatus.ConditionCode = TWCC_SUCCESS);
    end;
end;

{--------------------------------------------------------------------------}

procedure SetSingleValueCap( const CapId      : TW_UINT16;
                             const ItemType   : TW_UINT16;
                             const Value      : TW_UINT32;
                             const pSourceId  : pTW_IDENTITY;
                             const pAppId     : pTW_IDENTITY;
                             const DsmEntry   : TDSM_Entry );
var
    Cap         : TW_CAPABILITY;
    pOneValue   : PTW_ONEVALUE;
begin
    FillChar(Cap, SizeOf(Cap), 0);

    Cap.Cap        := CapId;
    Cap.ConType    := TWON_ONEVALUE;
    Cap.hContainer := GlobalAlloc(GHND, sizeof (TW_ONEVALUE));
    if Cap.hContainer = 0 then
        RaiseOutOfResources;
    try
        pOneValue := GlobalLock(Cap.hContainer);
        try
            pOneValue^.ItemType := ItemType;
            pOneValue^.Item     := Value;
        finally
            GlobalUnlock(Cap.hContainer);
        end;

	CallTriplet( pSourceId, pAppId, DG_CONTROL, DAT_CAPABILITY, MSG_SET,
                     @Cap, nil, DsmEntry);
    finally
	GlobalFree(cap.hContainer);
    end;
end;

{--------------------------------------------------------------------------}

{ Abort a TWAIN transfer. Changes from TWAIN state 6 to 5. }
procedure AbortTransfer( const pSourceId  : pTW_IDENTITY;
                         const pAppId     : pTW_IDENTITY;
                         const DsmEntry   : TDSM_Entry );
var
    PendingXFers     : TW_PENDINGXFERS;
begin
    FillChar(PendingXFers, SizeOf(PendingXFers), 0);
    CallTriplet( pSourceId, pAppId,
                 DG_CONTROL, DAT_PENDINGXFERS,
                 MSG_RESET, @PendingXFers, nil, DsmEntry );
end;

{--------------------------------------------------------------------------}

procedure ConcludeTransfer( var   PendingTransfers : TW_BOOL;
                            const pSourceId  : pTW_IDENTITY;
                            const pAppId     : pTW_IDENTITY;
                            const DsmEntry   : TDSM_Entry );
var
    PendingXFers     : TW_PENDINGXFERS;
    TwainResult      : TW_UINT16;
begin
    { acknowledge end of transfer }
    CallTriplet( pSourceId, pAppId,
                 DG_CONTROL, DAT_PENDINGXFERS,
                 MSG_ENDXFER, @PendingXfers, @TwainResult, DsmEntry);

    if TwainResult = TWRC_SUCCESS then
        { PendingTransfers may be -1, so check <> 0 }
        PendingTransfers := (PendingXfers.Count <> 0)
    else
    begin
        PendingTransfers := False;

        { if Result is False due to an error the transition to state
          5 is not automatic. }
        AbortTransfer(pSourceId, pAppId, DsmEntry);
    end;
end;

{--------------------------------------------------------------------------}

procedure GetAllImages( var   Msg          : TMsg;
                        var   TwainQuit    : Boolean;
                        const AcquireEvent : TAcquireEvent;
                        const pSourceId    : pTW_IDENTITY;
                        const pAppId       : pTW_IDENTITY;
                        const DsmEntry     : TDSM_Entry;
                        const CallBackData : LongInt );
var
    TwainResult      : TW_UINT16;
    hDib             : TW_UINT32;
    PendingTransfers : TW_BOOL;
    ImageInfo        : TW_IMAGEINFO;
begin
    PendingTransfers := True;

    while PendingTransfers do
    begin
        FillChar(ImageInfo, SizeOf(ImageInfo), 0);
        CallTriplet( pSourceId, pAppId,
                     DG_IMAGE, DAT_IMAGEINFO,
                     MSG_GET, @ImageInfo, @TwainResult, DsmEntry );

        if TwainResult = TWRC_SUCCESS then
        begin
            hDib := 0;
            try
                CallTriplet( pSourceId, pAppId,
                             DG_IMAGE, DAT_IMAGENATIVEXFER,
                             MSG_GET, @hDib, @TwainResult, DsmEntry );

                case TwainResult of

                    TWRC_XFERDONE :
                    begin
                        AcquireEvent( hDib,
                                      ImageInfo.XResolution.Whole,
                                      ImageInfo.YResolution.Whole,
                                      CallBackData );

                        ConcludeTransfer( PendingTransfers,
                                          pSourceId, pAppId, DsmEntry );

                        { MB July 31, 1999. Twain message loop not terminating
                          properly }
                        if not PendingTransfers then
                            TwainQuit := True;
                    end;

                    TWRC_CANCEL:
                    begin
                        { Application must still check for pending transfers as
                          specified by TWAIN. }
                        ConcludeTransfer( PendingTransfers,
                                          pSourceId, pAppId, DsmEntry);
                        if PendingTransfers then
                        begin
                            AbortTransfer(pSourceId, pAppId, DsmEntry);
                            PendingTransfers := False;
                        end;

                        TwainQuit        := True;
                    end;

                    else
                    begin
                        { assume any other result is a failure, including
                          TWRC_FAILURE result code.
                          - the transfer failed (e.g. insufficient memory).
                          - hNative is invalid
                          - image data is still pending

                          Still conclude the transfer, but then
                        }

                        ConcludeTransfer( PendingTransfers,
                                          pSourceId, pAppId, DsmEntry);
                        AbortTransfer(pSourceId, pAppId, DsmEntry);
                        PendingTransfers := False;
                        TwainQuit := True;
                    end;
                end; { case }

            finally
                { In some cases under Win16, call GlobalFree raised a
                  fatal GPF, so GlobalSize is used to ensure the hDib
                  is a valid memory handle }

                if (hDib <> 0) and (GlobalSize(hDib) > 0) then
                     GlobalFree(hDib);
            end;
        end;
    end; { while }
end;


{--------------------------------------------------------------------------}

{ processs a message. Returns True if message is processed by twain source }
function TwainProcessMessage( var   Msg          : TMsg;
                              var   TwainQuit    : Boolean;
                              const AcquireEvent : TAcquireEvent;
                              const pSourceId    : pTW_IDENTITY;
                              const pAppId       : pTW_IDENTITY;
                              const DsmEntry     : TDSM_Entry;
                              const CallBackData : LongInt ) : Boolean;
var
    TwainEvent  : TW_EVENT;
    TwainResult : TW_UINT16;
begin
    TwainQuit := False;

    TwainEvent.pEvent    := @Msg;
    TwainEvent.TWMessage := MSG_NULL;

    CallTriplet( pSourceId, pAppId,
                 DG_CONTROL, DAT_EVENT,
                 MSG_PROCESSEVENT, @TwainEvent, @TwainResult, DsmEntry );

    Result := (TwainResult = TWRC_DSEVENT);

    case TwainEvent.TWMessage of

        MSG_XFERREADY :
        begin
            GetAllImages( Msg, TwainQuit, AcquireEvent, pSourceId, pAppId,
                          DsmEntry, CallBackData );
        end;

        MSG_CLOSEDSREQ :
        begin
            TwainQuit := True;
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure ProcessImages( const AcquireEvent : TAcquireEvent;
                         const pSourceId    : pTW_IDENTITY;
                         const pAppId       : pTW_IDENTITY;
                         const DsmEntry     : TDSM_Entry;
                         const CallBackData : LongInt );
var
    Msg       : TMsg;
    TwainQuit : Boolean;

begin
    TwainQuit := False;

    while (not TwainQuit) and GetMessage(Msg, 0, 0, 0) do
    begin
	if not TwainProcessMessage( Msg, TwainQuit, AcquireEvent,
                                    pSourceId, pAppId,
                                    DsmEntry, CallBackData) then
        begin
	    TranslateMessage(Msg);
            DispatchMessage(Msg);
        end;
    end;
end;

{--------------------------------------------------------------------------}

end.
