{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
(*$HPPEMIT '#include <linux/tcp.h>' *)

type
  tcphdr = record
    source  : UInt16;
    dest    : UInt16;
    seq     : UInt32;
    ack_seq : UInt32;
    {$IFNDEF CPUARM} //__LITTLE_ENDIAN_BITFIELD
     res1   : UInt16;  //:4,
     doff   : UInt16;  //:4,
     fin    : UInt16;  //:1,
     syn    : UInt16;  //:1,
     rst    : UInt16;  //:1,
     psh    : UInt16;  //:1,
     ack    : UInt16;  //:1,
     urg    : UInt16;  //:1,
     ece    : UInt16;  //:1,
     cwr    : UInt16;  //:1;
    {$ELSE} //defined(__BIG_ENDIAN_BITFIELD)}
     doff   : UInt16;  //:4,
     res1   : UInt16;  //:4,
     cwr    : UInt16;  //:1,
     ece    : UInt16;  //:1,
     urg    : UInt16;  //:1,
     ack    : UInt16;  //:1,
     psh    : UInt16;  //:1,
     rst    : UInt16;  //:1,
     syn    : UInt16;  //:1,
     fin    : UInt16;  //:1;
    {$ENDIF}
    window  : UInt16;
    check   : UInt16;
    urg_ptr : UInt16;
  end;
  {$EXTERNALSYM tcphdr}

  tcp_word_hdr = record
    case byte of
      0: (hdr  : tcphdr);
      1: (words: array[0..4] of UInt32);
  end;

  {$EXTERNALSYM tcp_word_hdr}
  Ptcp_word_hdr = ^tcp_word_hdr;

const
  {
    Those constants are originally created by the macro __constant_htonl
  }
  TCP_FLAG_CWR = (((UInt32($00800000) and UInt32($000000FF))  shl 24) or
                  ((UInt32($00800000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($00800000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($00800000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_FLAG_CWR}
  TCP_FLAG_ECE = (((UInt32($00400000) and UInt32($000000FF))  shl 24) or
                  ((UInt32($00400000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($00400000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($00400000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_FLAG_ECE}
  TCP_FLAG_URG = (((UInt32($00200000) and UInt32($000000FF))  shl 24) or
                  ((UInt32($00200000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($00200000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($00200000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_FLAG_URG}
  TCP_FLAG_ACK = (((UInt32($00100000) and UInt32($000000FF))  shl 24) or
                  ((UInt32($00100000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($00100000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($00100000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_FLAG_ACK}
  TCP_FLAG_PSH = (((UInt32($00080000) and UInt32($000000FF))  shl 24) or
                  ((UInt32($00080000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($00080000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($00080000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_FLAG_PSH}
  TCP_FLAG_RST = (((UInt32($00040000) and UInt32($000000FF))  shl 24) or
                  ((UInt32($00040000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($00040000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($00040000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_FLAG_RST}
  TCP_FLAG_SYN = (((UInt32($00020000) and UInt32($000000FF))  shl 24) or
                  ((UInt32($00020000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($00020000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($00020000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_FLAG_SYN}
  TCP_FLAG_FIN = (((UInt32($00010000) and UInt32($000000FF))  shl 24) or
                  ((UInt32($00010000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($00010000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($00010000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_FLAG_FIN}
  TCP_RESERVED_BITS = (((UInt32($0F000000) and UInt32($000000FF))  shl  24) or
                  ((UInt32($0F000000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($0F000000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($0F000000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_RESERVED_BITS}
  TCP_DATA_OFFSET = (((UInt32($F0000000) and UInt32($000000FF))  shl  24) or
                  ((UInt32($F0000000) and UInt32($0000FF00))  shl 8) or
                  ((UInt32($F0000000) and UInt32($00FF0000))  shr 8) or
                  ((UInt32($F0000000) and UInt32($FF000000))  shr 24));
  {$EXTERNALSYM TCP_DATA_OFFSET}

const

  TCP_NODELAY       = 1;
  {$EXTERNALSYM TCP_NODELAY}
  TCP_MAXSEG        = 2;
  {$EXTERNALSYM TCP_MAXSEG}
  TCP_CORK          = 3;
  {$EXTERNALSYM TCP_CORK}
  TCP_KEEPIDLE      = 4;
  {$EXTERNALSYM TCP_KEEPIDLE}
  TCP_KEEPINTVL     = 5;
  {$EXTERNALSYM TCP_KEEPINTVL}
  TCP_KEEPCNT       = 6;
  {$EXTERNALSYM TCP_KEEPCNT}
  TCP_SYNCNT        = 7;
  {$EXTERNALSYM TCP_SYNCNT}
  TCP_LINGER2       = 8;
  {$EXTERNALSYM TCP_LINGER2}
  TCP_DEFER_ACCEPT  = 9;
  {$EXTERNALSYM TCP_DEFER_ACCEPT}
  TCP_WINDOW_CLAMP  = 10;
  {$EXTERNALSYM TCP_WINDOW_CLAMP}
  TCP_INFO          = 11;
  {$EXTERNALSYM TCP_INFO}
  TCP_QUICKACK      = 12;
  {$EXTERNALSYM TCP_QUICKACK}
  TCP_CONGESTION    = 13;
  {$EXTERNALSYM TCP_CONGESTION}

  TCPI_OPT_TIMESTAMPS = 1;
  {$EXTERNALSYM TCPI_OPT_TIMESTAMPS}
  TCPI_OPT_SACK       = 2;
  {$EXTERNALSYM TCPI_OPT_SACK}
  TCPI_OPT_WSCALE     = 4;
  {$EXTERNALSYM TCPI_OPT_WSCALE}
  TCPI_OPT_ECN        = 8;
  {$EXTERNALSYM TCPI_OPT_ECN}

  //ENUM tcp_ca_state
  TCP_CA_Open       = 0;
  {$EXTERNALSYM TCP_CA_Open}
  TCPF_CA_Open      = (1 shl TCP_CA_Open);
  {$EXTERNALSYM TCPF_CA_Open}
  TCP_CA_Disorder   = 1;
  {$EXTERNALSYM TCP_CA_Disorder}
  TCPF_CA_Disorder  = (1 shl TCP_CA_Disorder);
  {$EXTERNALSYM TCPF_CA_Disorder }
  TCP_CA_CWR        = 2;
  {$EXTERNALSYM TCP_CA_CWR}
  TCPF_CA_CWR       = (1 shl TCP_CA_CWR);
  {$EXTERNALSYM TCPF_CA_CWR}
  TCP_CA_Recovery   = 3;
  {$EXTERNALSYM TCP_CA_Recovery}
  TCPF_CA_Recovery  = (1 shl TCP_CA_Recovery);
  {$EXTERNALSYM TCPF_CA_Recovery}
  TCP_CA_Loss       = 4;
  {$EXTERNALSYM TCP_CA_Loss}
  TCPF_CA_Loss    = (1 shl TCP_CA_Loss);
  {$EXTERNALSYM TCPF_CA_Loss}

type
  _tcp_info = record
    tcpi_state        : Byte;
    tcpi_ca_state     : Byte;
    tcpi_retransmits  : Byte;
    tcpi_probes       : Byte;
    tcpi_backoff      : Byte;
    tcpi_options      : Byte;
    tcpi_snd_wscale   : Byte; //: 4,
    tcpi_rcv_wscale   : Byte; //: 4;

    tcpi_rto    : UInt32;
    tcpi_ato    : UInt32;
    tcpi_snd_mss: UInt32;
    tcpi_rcv_mss: UInt32;

    tcpi_unacked: UInt32;
    tcpi_sacked : UInt32;
    tcpi_lost   : UInt32;
    tcpi_retrans: UInt32;
    tcpi_fackets: UInt32;

    tcpi_last_data_sent : UInt32;
    tcpi_last_ack_sent  : UInt32;
    tcpi_last_data_recv : UInt32;
    tcpi_last_ack_recv  : UInt32;

    tcpi_pmtu         : UInt32;
    tcpi_rcv_ssthresh : UInt32;
    tcpi_rtt          : UInt32;
    tcpi_rttvar       : UInt32;
    tcpi_snd_ssthresh : UInt32;
    tcpi_snd_cwnd     : UInt32;
    tcpi_advmss       : UInt32;
    tcpi_reordering   : UInt32;

    tcpi_rcv_rtt  : UInt32;
    tcpi_rcv_space: UInt32;

    tcpi_total_retrans: UInt32;
  end;
  {$EXTERNALSYM _tcp_info}

