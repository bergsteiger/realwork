{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{   File: nb30.h                                        }
{   Copyright (c) 1991-1999 Microsoft Corporation       }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{*******************************************************}
{             NetBIOS 3.0 interface unit                }
{*******************************************************}

unit Winapi.Nb30;

{ This unit contains the definitions
  for portable NetBIOS 3.0 support. }

{$ALIGN ON}
{$MINENUMSIZE 4}

interface

uses Winapi.Windows;

{ Data structure templates }

const
  NCBNAMSZ = 16;               // absolute length of a net name
  {$EXTERNALSYM NCBNAMSZ}
  MAX_LANA = 254;              // lana's in range 0 to MAX_LANA inclusive
  {$EXTERNALSYM MAX_LANA}

type
  // Network Control Block
  PNCB = ^TNCB;

  TNCBPostProc = procedure(P: PNCB);

  TNCB = record
    ncb_command: AnsiChar;         // command code
    ncb_retcode: AnsiChar;         // return code
    ncb_lsn: AnsiChar;             // local session number
    ncb_num: AnsiChar;             // number of our network name
    ncb_buffer: PAnsiChar;         // address of message buffer
    ncb_length: Word;          // size of message buffer
    ncb_callname: array[0..NCBNAMSZ - 1] of AnsiChar;  // blank-padded name of remote
    ncb_name: array[0..NCBNAMSZ - 1] of AnsiChar;      // our blank-padded netname
    ncb_rto: AnsiChar;             // rcv timeout/retry count
    ncb_sto: AnsiChar;             // send timeout/sys timeout
    ncb_post: TNCBPostProc;    // POST routine address
    ncb_lana_num: AnsiChar;        // lana (adapter) number
    ncb_cmd_cplt: AnsiChar;        // 0xff => commmand pending
{$IFDEF WIN64}
    ncb_reserve: array[0..17] of AnsiChar;             // reserved, used by BIOS
{$ELSE}
    ncb_reserve: array[0..9] of AnsiChar;              // reserved, used by BIOS
{$ENDIF}
    ncb_event: THandle;        // HANDLE to Win32 event which
                               // will be set to the signalled
                               // state when an ASYNCH command
                               // completes
  end;

  // Structure returned to the NCB command NCBASTAT is ADAPTER_STATUS followed
  // by an array of NAME_BUFFER structures.
  PAdapterStatus = ^TAdapterStatus;
  TAdapterStatus = record
    adapter_address: array[0..5] of AnsiChar;
    rev_major: AnsiChar;
    reserved0: AnsiChar;
    adapter_type: AnsiChar;
    rev_minor: AnsiChar;
    duration: Word;
    frmr_recv: Word;
    frmr_xmit: Word;
    iframe_recv_err: Word;
    xmit_aborts: Word;
    xmit_success: DWORD;
    recv_success: DWORD;
    iframe_xmit_err: Word;
    recv_buff_unavail: Word;
    t1_timeouts: Word;
    ti_timeouts: Word;
    reserved1: DWORD;
    free_ncbs: Word;
    max_cfg_ncbs: Word;
    max_ncbs: Word;
    xmit_buf_unavail: Word;
    max_dgram_size: Word;
    pending_sess: Word;
    max_cfg_sess: Word;
    max_sess: Word;
    max_sess_pkt_size: Word;
    name_count: Word;
  end;

  PNameBuffer = ^TNameBuffer;
  TNameBuffer = record
    name: array[0..NCBNAMSZ - 1] of AnsiChar;
    name_num: AnsiChar;
    name_flags: AnsiChar;
  end;

const
  // values for name_flags bits.
  NAME_FLAGS_MASK = $87;
  {$EXTERNALSYM NAME_FLAGS_MASK}

  GROUP_NAME      = $80;
  {$EXTERNALSYM GROUP_NAME}
  UNIQUE_NAME     = $00;
  {$EXTERNALSYM UNIQUE_NAME}

  REGISTERING     = $00;
  {$EXTERNALSYM REGISTERING}
  REGISTERED      = $04;
  {$EXTERNALSYM REGISTERED}
  DEREGISTERED    = $05;
  {$EXTERNALSYM DEREGISTERED}
  DUPLICATE       = $06;
  {$EXTERNALSYM DUPLICATE}
  DUPLICATE_DEREG = $07;
  {$EXTERNALSYM DUPLICATE_DEREG}

type
  // Structure returned to the NCB command NCBSSTAT is SESSION_HEADER followed
  // by an array of SESSION_BUFFER structures. If the NCB_NAME starts with an
  // asterisk then an array of these structures is returned containing the
  // status for all names.
  PSessionHeader = ^TSessionHeader;
  TSessionHeader = record
    sess_name: AnsiChar;
    num_sess: AnsiChar;
    rcv_dg_outstanding: AnsiChar;
    rcv_any_outstanding: AnsiChar;
  end;

  PSessionBuffer = ^TSessionBuffer;
  TSessionBuffer = record
    lsn: AnsiChar;
    state: AnsiChar;
    local_name: array[0..NCBNAMSZ - 1] of AnsiChar;
    remote_name: array[0..NCBNAMSZ - 1] of AnsiChar;
    rcvs_outstanding: AnsiChar;
    sends_outstanding: AnsiChar;
  end;

const
  // Values for state
  LISTEN_OUTSTANDING      = $01;
  {$EXTERNALSYM LISTEN_OUTSTANDING}
  CALL_PENDING            = $02;
  {$EXTERNALSYM CALL_PENDING}
  SESSION_ESTABLISHED     = $03;
  {$EXTERNALSYM SESSION_ESTABLISHED}
  HANGUP_PENDING          = $04;
  {$EXTERNALSYM HANGUP_PENDING}
  HANGUP_COMPLETE         = $05;
  {$EXTERNALSYM HANGUP_COMPLETE}
  SESSION_ABORTED         = $06;
  {$EXTERNALSYM SESSION_ABORTED}

type
  // Structure returned to the NCB command NCBENUM.
  // On a system containing lana's 0, 2 and 3, a structure with
  // length =3, lana[0]=0, lana[1]=2 and lana[2]=3 will be returned.
  PLanaEnum = ^TLanaEnum;
  TLanaEnum = record
    length: AnsiChar;         //  Number of valid entries in lana[]
    lana: array[0..MAX_LANA] of AnsiChar;
  end;

  // Structure returned to the NCB command NCBFINDNAME is FIND_NAME_HEADER followed
  // by an array of FIND_NAME_BUFFER structures.
  PFindNameHeader = ^TFindNameHeader;
  TFindNameHeader = record
    node_count: Word;
    reserved: AnsiChar;
    unique_group: AnsiChar;
  end;

  PFindNameBuffer = ^TFindNameBuffer;
  TFindNameBuffer = record
    length: AnsiChar;
    access_control: AnsiChar;
    frame_control: AnsiChar;
    destination_addr: array[0..5] of AnsiChar;
    source_addr: array[0..5] of AnsiChar;
    routing_info: array[0..17] of AnsiChar;
  end;

  // Structure provided with NCBACTION. The purpose of NCBACTION is to provide
  // transport specific extensions to netbios.
  PActionHeader = ^TActionHeader;
  TActionHeader = record
    transport_id: Longint;
    action_code: Word;
    reserved: Word;
  end;

const
  // Values for transport_id
  ALL_TRANSPORTS  = 'M'#0#0#0;
  {$EXTERNALSYM ALL_TRANSPORTS}
  MS_NBF          = 'MNBF';
  {$EXTERNALSYM MS_NBF}


{ Special values and constants }

const
  // NCB Command codes
  NCBCALL         = $10;            // NCB CALL
  {$EXTERNALSYM NCBCALL}
  NCBLISTEN       = $11;            // NCB LISTEN
  {$EXTERNALSYM NCBLISTEN}
  NCBHANGUP       = $12;            // NCB HANG UP
  {$EXTERNALSYM NCBHANGUP}
  NCBSEND         = $14;            // NCB SEND
  {$EXTERNALSYM NCBSEND}
  NCBRECV         = $15;            // NCB RECEIVE
  {$EXTERNALSYM NCBRECV}
  NCBRECVANY      = $16;            // NCB RECEIVE ANY
  {$EXTERNALSYM NCBRECVANY}
  NCBCHAINSEND    = $17;            // NCB CHAIN SEND
  {$EXTERNALSYM NCBCHAINSEND}
  NCBDGSEND       = $20;            // NCB SEND DATAGRAM
  {$EXTERNALSYM NCBDGSEND}
  NCBDGRECV       = $21;            // NCB RECEIVE DATAGRAM
  {$EXTERNALSYM NCBDGRECV}
  NCBDGSENDBC     = $22;            // NCB SEND BROADCAST DATAGRAM
  {$EXTERNALSYM NCBDGSENDBC}
  NCBDGRECVBC     = $23;            // NCB RECEIVE BROADCAST DATAGRAM
  {$EXTERNALSYM NCBDGRECVBC}
  NCBADDNAME      = $30;            // NCB ADD NAME
  {$EXTERNALSYM NCBADDNAME}
  NCBDELNAME      = $31;            // NCB DELETE NAME
  {$EXTERNALSYM NCBDELNAME}
  NCBRESET        = $32;            // NCB RESET
  {$EXTERNALSYM NCBRESET}
  NCBASTAT        = $33;            // NCB ADAPTER STATUS
  {$EXTERNALSYM NCBASTAT}
  NCBSSTAT        = $34;            // NCB SESSION STATUS
  {$EXTERNALSYM NCBSSTAT}
  NCBCANCEL       = $35;            // NCB CANCEL
  {$EXTERNALSYM NCBCANCEL}
  NCBADDGRNAME    = $36;            // NCB ADD GROUP NAME
  {$EXTERNALSYM NCBADDGRNAME}
  NCBENUM         = $37;            // NCB ENUMERATE LANA NUMBERS
  {$EXTERNALSYM NCBENUM}
  NCBUNLINK       = $70;            // NCB UNLINK
  {$EXTERNALSYM NCBUNLINK}
  NCBSENDNA       = $71;            // NCB SEND NO ACK
  {$EXTERNALSYM NCBSENDNA}
  NCBCHAINSENDNA  = $72;            // NCB CHAIN SEND NO ACK
  {$EXTERNALSYM NCBCHAINSENDNA}
  NCBLANSTALERT   = $73;            // NCB LAN STATUS ALERT
  {$EXTERNALSYM NCBLANSTALERT}
  NCBACTION       = $77;            // NCB ACTION
  {$EXTERNALSYM NCBACTION}
  NCBFINDNAME     = $78;            // NCB FIND NAME
  {$EXTERNALSYM NCBFINDNAME}
  NCBTRACE        = $79;            // NCB TRACE
  {$EXTERNALSYM NCBTRACE}

  ASYNCH          = $80;            // high bit set = asynchronous
  {$EXTERNALSYM ASYNCH}

  // NCB Return codes
  NRC_GOODRET     = $00;    // good return
  {$EXTERNALSYM NRC_GOODRET}
                            // also returned when ASYNCH request accepted
  NRC_BUFLEN      = $01;    // illegal buffer length
  {$EXTERNALSYM NRC_BUFLEN}
  NRC_ILLCMD      = $03;    // illegal command
  {$EXTERNALSYM NRC_ILLCMD}
  NRC_CMDTMO      = $05;    // command timed out
  {$EXTERNALSYM NRC_CMDTMO}
  NRC_INCOMP      = $06;    // message incomplete, issue another command
  {$EXTERNALSYM NRC_INCOMP}
  NRC_BADDR       = $07;    // illegal buffer address
  {$EXTERNALSYM NRC_BADDR}
  NRC_SNUMOUT     = $08;    // session number out of range
  {$EXTERNALSYM NRC_SNUMOUT}
  NRC_NORES       = $09;    // no resource available
  {$EXTERNALSYM NRC_NORES}
  NRC_SCLOSED     = $0a;    // session closed
  {$EXTERNALSYM NRC_SCLOSED}
  NRC_CMDCAN      = $0b;    // command cancelled
  {$EXTERNALSYM NRC_CMDCAN}
  NRC_DUPNAME     = $0d;    // duplicate name
  {$EXTERNALSYM NRC_DUPNAME}
  NRC_NAMTFUL     = $0e;    // name table full
  {$EXTERNALSYM NRC_NAMTFUL}
  NRC_ACTSES      = $0f;    // no deletions, name has active sessions
  {$EXTERNALSYM NRC_ACTSES}
  NRC_LOCTFUL     = $11;    // local session table full
  {$EXTERNALSYM NRC_LOCTFUL}
  NRC_REMTFUL     = $12;    // remote session table full
  {$EXTERNALSYM NRC_REMTFUL}
  NRC_ILLNN       = $13;    // illegal name number
  {$EXTERNALSYM NRC_ILLNN}
  NRC_NOCALL      = $14;    // no callname
  {$EXTERNALSYM NRC_NOCALL}
  NRC_NOWILD      = $15;    // cannot put * in NCB_NAME
  {$EXTERNALSYM NRC_NOWILD}
  NRC_INUSE       = $16;    // name in use on remote adapter
  {$EXTERNALSYM NRC_INUSE}
  NRC_NAMERR      = $17;    // name deleted
  {$EXTERNALSYM NRC_NAMERR}
  NRC_SABORT      = $18;    // session ended abnormally
  {$EXTERNALSYM NRC_SABORT}
  NRC_NAMCONF     = $19;    // name conflict detected
  {$EXTERNALSYM NRC_NAMCONF}
  NRC_IFBUSY      = $21;    // interface busy, IRET before retrying
  {$EXTERNALSYM NRC_IFBUSY}
  NRC_TOOMANY     = $22;    // too many commands outstanding, retry later
  {$EXTERNALSYM NRC_TOOMANY}
  NRC_BRIDGE      = $23;    // NCB_lana_num field invalid
  {$EXTERNALSYM NRC_BRIDGE}
  NRC_CANOCCR     = $24;    // command completed while cancel occurring
  {$EXTERNALSYM NRC_CANOCCR}
  NRC_CANCEL      = $26;    // command not valid to cancel
  {$EXTERNALSYM NRC_CANCEL}
  NRC_DUPENV      = $30;    // name defined by anther local process
  {$EXTERNALSYM NRC_DUPENV}
  NRC_ENVNOTDEF   = $34;    // environment undefined. RESET required
  {$EXTERNALSYM NRC_ENVNOTDEF}
  NRC_OSRESNOTAV  = $35;    // required OS resources exhausted
  {$EXTERNALSYM NRC_OSRESNOTAV}
  NRC_MAXAPPS     = $36;    // max number of applications exceeded
  {$EXTERNALSYM NRC_MAXAPPS}
  NRC_NOSAPS      = $37;    // no saps available for netbios
  {$EXTERNALSYM NRC_NOSAPS}
  NRC_NORESOURCES = $38;    // requested resources are not available
  {$EXTERNALSYM NRC_NORESOURCES}
  NRC_INVADDRESS  = $39;    // invalid ncb address or length > segment
  {$EXTERNALSYM NRC_INVADDRESS}
  NRC_INVDDID     = $3B;    // invalid NCB DDID
  {$EXTERNALSYM NRC_INVDDID}
  NRC_LOCKFAIL    = $3C;    // lock of user area failed
  {$EXTERNALSYM NRC_LOCKFAIL}
  NRC_OPENERR     = $3f;    // NETBIOS not loaded
  {$EXTERNALSYM NRC_OPENERR}
  NRC_SYSTEM      = $40;    // system error
  {$EXTERNALSYM NRC_SYSTEM}

  NRC_PENDING     = $ff;    // asynchronous command is not yet finished
  {$EXTERNALSYM NRC_PENDING}

{ main user entry point for NetBIOS 3.0
   Usage: Result = Netbios( pncb ); }


function Netbios(P: PNCB): AnsiChar; stdcall;
{$EXTERNALSYM Netbios}

implementation

function Netbios; external 'netapi32.dll' name 'Netbios';

end.

