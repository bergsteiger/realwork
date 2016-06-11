{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{             FireDAC Oracle Call Interface             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.OracleCli;

interface

uses
  FireDAC.Stan.Intf;

  {----------------------------------------------------------------------------}
  { ORATYPES.H                                                                 }
  {----------------------------------------------------------------------------}

type
  // Generic Oracle Types
  sword    = Integer;
  eword    = Integer;
  uword    = Cardinal;
  sb8      = Int64;
  ub8      = UInt64;
  sb4      = Integer;
  ub4      = Cardinal;
  sb2      = SmallInt;
  ub2      = Word;
  sb1      = ShortInt;
  ub1      = Byte;
  dvoid    = Pointer;
  pOCIText = PByte;

  pUb1 = ^ub1;
  pSb1 = ^sb1;
  pUb2 = ^ub2;
  pSb2 = ^sb2;
  pUb4 = ^ub4;
  pSb4 = ^sb4;

  ppUb1 = ^pUb1;
  ppUb4 = ^pUb4;

  TUB1Array = array[0..$FFFF] of ub1;
  PUB1Array = ^TUB1Array;
  TSB2Array = array[0..$FFFF] of sb2;
  PSB2Array = ^TSB2Array;
  TUB2Array = array[0..$FFFF] of ub2;
  PUB2Array = ^TUB2Array;
  TUB4Array = array[0..$FFFF] of ub4;
  PUB4Array = ^TUB4Array;
  TBoolArray = array[0..$FFFF] of Boolean;
  PBoolArray = ^TBoolArray;

const
  MAXUB4 = High(ub4);
  MAXSB4 = High(sb4);
  MINUB4MAXVAL = MAXUB4;
  UB4MAXVAL = MAXUB4;

type
  TOraDate = packed record
    century, year, month, day,
    hour, minute, second: ub1;
  end;
  POraDate = ^TOraDate;

  {----------------------------------------------------------------------------}
  { OCI.H                                                                      }
  {----------------------------------------------------------------------------}

  //-----------------------Handle Definitions----------------------------------
  pOCIHandle = pointer;
  ppOCIHandle = ^pOCIHandle;
  pOCIEnv = pOCIHandle;
  pOCIServer = pOCIHandle;
  pOCIError = pOCIHandle;
  pOCISvcCtx = pOCIHandle;
  pOCIStmt = pOCIHandle;
  pOCIDefine = pOCIHandle;
  pOCISession = pOCIHandle;
  pOCITrans = pOCIHandle;
  pOCIBind = pOCIHandle;
  pOCIDescribe = pOCIHandle;
  pOCIDirPathCtx = pOCIHandle;
  pOCIDirPathColArray = pOCIHandle;
  pOCIDirPathStream = pOCIHandle;
  pOCIAdmin = pOCIHandle;
  pOCISubscription = pOCIHandle;

  //-----------------------Descriptor Definitions------------------------------
  pOCIDescriptor = pOCIHandle;
  pOCISnapshot = pOCIDescriptor;
  pOCILobLocator = pOCIDescriptor;
  pOCIParam = pOCIDescriptor;
  pOCIRowid = pOCIDescriptor;
  pOCIComplexObjectComp = pOCIDescriptor;
  pOCIAQEnqOptions = pOCIDescriptor;
  pOCIAQDeqOptions = pOCIDescriptor;
  pOCIAQMsgProperties = pOCIDescriptor;
  pOCIAQAgent = pOCIDescriptor;
  pOCIDirPathDesc = pOCIDescriptor;
  pOCIDateTime = pOCIDescriptor;
  pOCIInterval = pOCIDescriptor;

const
  //-----------------------------Handle Types----------------------------------
  OCI_HTYPE_FIRST     = 1;
  OCI_HTYPE_ENV       = 1;
  OCI_HTYPE_ERROR     = 2;
  OCI_HTYPE_SVCCTX    = 3;
  OCI_HTYPE_STMT      = 4;
  OCI_HTYPE_BIND      = 5;
  OCI_HTYPE_DEFINE    = 6;
  OCI_HTYPE_DESCRIBE  = 7;
  OCI_HTYPE_SERVER    = 8;
  OCI_HTYPE_SESSION   = 9;
  OCI_HTYPE_TRANS     = 10;
  OCI_HTYPE_COMPLEXOBJECT  = 11;
  OCI_HTYPE_SECURITY       = 12;
  OCI_HTYPE_SUBSCRIPTION   = 13;        // subscription handle
  OCI_HTYPE_DIRPATH_CTX    = 14;        // direct path context
  OCI_HTYPE_DIRPATH_COLUMN_ARRAY = 15;  // direct path column array
  OCI_HTYPE_DIRPATH_STREAM = 16;        // direct path stream
  OCI_HTYPE_PROC           = 17;        // process handle
  // post 8.1
  OCI_HTYPE_DIRPATH_FN_CTX = 18;        // direct path function context
  OCI_HTYPE_DIRPATH_FN_COL_ARRAY = 19;  // dp object column array
  OCI_HTYPE_XADSESSION     = 20;        // access driver session
  OCI_HTYPE_XADTABLE       = 21;        // access driver table
  OCI_HTYPE_XADFIELD       = 22;        // access driver field
  OCI_HTYPE_XADGRANULE     = 23;        // access driver granule
  OCI_HTYPE_XADRECORD      = 24;        // access driver record
  OCI_HTYPE_XADIO          = 25;        // access driver I/O
  OCI_HTYPE_CPOOL          = 26;        // connection pool handle
  OCI_HTYPE_SPOOL          = 27;        // session pool handle
  // post 10.2
  OCI_HTYPE_ADMIN          = 28;        // admin handle
  OCI_HTYPE_EVENT          = 29;        // HA event handle
  OCI_HTYPE_LAST           = 29;

  //-------------------------Descriptor Types----------------------------------
  OCI_DTYPE_FIRST     = 50;
  OCI_DTYPE_LOB       = 50;
  OCI_DTYPE_SNAP      = 51;
  OCI_DTYPE_RSET      = 52;
  OCI_DTYPE_PARAM     = 53;
  OCI_DTYPE_ROWID     = 54;
  OCI_DTYPE_COMPLEXOBJECTCOMP = 55;
  OCI_DTYPE_FILE      = 56;
  OCI_DTYPE_AQENQ_OPTIONS     = 57;
  OCI_DTYPE_AQDEQ_OPTIONS     = 58;
  OCI_DTYPE_AQMSG_PROPERTIES  = 59;
  OCI_DTYPE_AQAGENT           = 60;
  OCI_DTYPE_LOCATOR           = 61;           // LOB locator
  // >= 9.0
  OCI_DTYPE_INTERVAL_YM       = 62;           // Interval year month
  OCI_DTYPE_INTERVAL_DS       = 63;           // Interval day second
  OCI_DTYPE_AQNFY_DESCRIPTOR  = 64;           // AQ notify descriptor
  // >= 8.1
  OCI_DTYPE_DATE      = 65;                   // Date
  OCI_DTYPE_TIME      = 66;                   // Time
  OCI_DTYPE_TIME_TZ   = 67;                   // Time with timezone
  OCI_DTYPE_TIMESTAMP = 68;                   // Timestamp
  OCI_DTYPE_TIMESTAMP_TZ      = 69;           // Timestamp with timezone
  OCI_DTYPE_TIMESTAMP_LTZ     = 70;           // Timestamp with local tz
  OCI_DTYPE_UCB               = 71;           // user callback descriptor
  OCI_DTYPE_SRVDN             = 72;           // server DN list descriptor
  OCI_DTYPE_SIGNATURE         = 73;           // signature
  OCI_DTYPE_RESERVED_1        = 74;           // reserved for internal use
  OCI_DTYPE_AQLIS_OPTIONS     = 75;           // AQ listen options
  OCI_DTYPE_AQLIS_MSG_PROPERTIES = 76;        // AQ listen msg props
  OCI_DTYPE_CHDES             = 77;           // Top level change notification desc
  OCI_DTYPE_TABLE_CHDES       = 78;           // Table change descriptor
  OCI_DTYPE_ROW_CHDES         = 79;           // Row change descriptor
  OCI_DTYPE_CQDES             = 80;           // Query change descriptor
  OCI_DTYPE_LOB_REGION        = 81;           // LOB Share region descriptor
  OCI_DTYPE_RESERVED_82       = 82;           // reserved
  OCI_DTYPE_LAST              = 82;           // last value of a descriptor type

  // --------------------------------LOB types ---------------------------------
  OCI_TEMP_BLOB = 1;                // LOB type - BLOB
  OCI_TEMP_CLOB = 2;                // LOB type - CLOB
  OCI_TEMP_NCLOB = 3;

  //-------------------------Object Ptr Types----------------------------------
  OCI_OTYPE_NAME = 1;               // object name
  OCI_OTYPE_REF = 2;                // REF to TDO
  OCI_OTYPE_PTR = 3;                // PTR to TDO

  // -------------------------Attributes Types----------------------------------
  OCI_ATTR_FNCODE =   1;                              // the OCI function code
  OCI_ATTR_OBJECT =    2;                             // is the environment initialized in object mode
  OCI_ATTR_NONBLOCKING_MODE =   3;                    // non blocking mode
  OCI_ATTR_SQLCODE =   4;                             // the SQL verb
  OCI_ATTR_ENV =   5;                                 // the environment handle
  OCI_ATTR_SERVER =  6;                               // the server handle
  OCI_ATTR_SESSION =  7;                              // the user session handle
  OCI_ATTR_TRANS =    8;                              // the transaction handle
  OCI_ATTR_ROW_COUNT =    9;                          // the rows processed so far
  OCI_ATTR_SQLFNCODE =  10;                           // the SQL verb of the statement
  OCI_ATTR_PREFETCH_ROWS =   11;                      // sets the number of rows to prefetch
  OCI_ATTR_NESTED_PREFETCH_ROWS =  12;                // the prefetch rows of nested table
  OCI_ATTR_PREFETCH_MEMORY =  13;                     // memory limit for rows fetched
  OCI_ATTR_NESTED_PREFETCH_MEMORY =  14;              // memory limit for nested rows
  OCI_ATTR_CHAR_COUNT =   15;                         // this specifies the bind and define size in characters
  OCI_ATTR_PDSCL =    16;                             // packed decimal scale
  OCI_ATTR_FSPRECISION = OCI_ATTR_PDSCL;              // fs prec for datetime data types
  OCI_ATTR_PDPRC =    17;                             // packed decimal format
  OCI_ATTR_LFPRECISION = OCI_ATTR_PDPRC;              // fs prec for datetime data types
  OCI_ATTR_PARAM_COUNT =  18;                         // number of column in the select list
  OCI_ATTR_ROWID =    19;                             // the rowid
  OCI_ATTR_CHARSET =   20;                            // the character set value
  OCI_ATTR_NCHAR =    21;                             // NCHAR type
  OCI_ATTR_USERNAME =  22;                            // username attribute
  OCI_ATTR_PASSWORD =  23;                            // password attribute
  OCI_ATTR_STMT_TYPE =    24;                         // statement type
  OCI_ATTR_INTERNAL_NAME =    25;                     // user friendly global name
  OCI_ATTR_EXTERNAL_NAME =    26;                     // the internal name for global txn
  OCI_ATTR_XID =      27;                             // XOPEN defined global transaction id
  OCI_ATTR_TRANS_LOCK =  28;                          //
  OCI_ATTR_TRANS_NAME =  29;                          // string to identify a global transaction
  OCI_ATTR_HEAPALLOC =  30;                           // memory allocated on the heap
  OCI_ATTR_CHARSET_ID =  31;                          // Character Set ID
  OCI_ATTR_CHARSET_FORM =  32;                        // Character Set Form
  OCI_ATTR_MAXDATA_SIZE =  33;                        // Maximumsize of data on the server
  OCI_ATTR_CACHE_OPT_SIZE =  34;                      // object cache optimal size
  OCI_ATTR_CACHE_MAX_SIZE =  35;                      // object cache maximum size percentage
  OCI_ATTR_PINOPTION =  36;                           // object cache default pin option
  OCI_ATTR_ALLOC_DURATION =  37;                      // object cache default allocation duration
  OCI_ATTR_PIN_DURATION =  38;                        // object cache default pin duration
  OCI_ATTR_FDO =           39;                        // Format Descriptor object attribute
  OCI_ATTR_POSTPROCESSING_CALLBACK =  40;             // Callback to process outbind data
  OCI_ATTR_POSTPROCESSING_CONTEXT =  41;              // Callback context to process outbind data
  OCI_ATTR_ROWS_RETURNED =  42;                       // Number of rows returned in current iter - for Bind handles
  OCI_ATTR_FOCBK =         43;                        // Failover Callback attribute
  OCI_ATTR_IN_V8_MODE  = 44;                          // is the server/service context in V8 mode
  OCI_ATTR_LOBEMPTY =      45;                        // empty lob ?
  OCI_ATTR_SESSLANG =      46;                        // session language handle

  OCI_ATTR_VISIBILITY =              47;              // visibility
  OCI_ATTR_RELATIVE_MSGID =          48;              // relative message id
  OCI_ATTR_SEQUENCE_DEVIATION =      49;              // sequence deviation

  OCI_ATTR_CONSUMER_NAME =           50;              // consumer name
  OCI_ATTR_DEQ_MODE =                51;              // dequeue mode
  OCI_ATTR_NAVIGATION =              52;              // navigation
  OCI_ATTR_WAIT =                    53;              // wait
  OCI_ATTR_DEQ_MSGID =               54;              // dequeue message id

  OCI_ATTR_PRIORITY =                55;              // priority
  OCI_ATTR_DELAY =                   56;              // delay
  OCI_ATTR_EXPIRATION =              57;              // expiration
  OCI_ATTR_CORRELATION =             58;              // correlation id
  OCI_ATTR_ATTEMPTS =                59;              // # of attempts
  OCI_ATTR_RECIPIENT_LIST =          60;              // recipient list
  OCI_ATTR_EXCEPTION_QUEUE =         61;              // exception queue name
  OCI_ATTR_ENQ_TIME =                62;              // enqueue time (only OCIAttrGet)
  OCI_ATTR_MSG_STATE =               63;              // message state (only OCIAttrGet)
                                                      // NOTE: 64-66 used below
  OCI_ATTR_AGENT_NAME =              64;              // agent name
  OCI_ATTR_AGENT_ADDRESS =           65;              // agent address
  OCI_ATTR_AGENT_PROTOCOL =          66;              // agent protocol

  OCI_ATTR_SENDER_ID =               68;              // sender id
  OCI_ATTR_ORIGINAL_MSGID =          69;              // original message id

  OCI_ATTR_QUEUE_NAME =              70;              // queue name
  OCI_ATTR_NFY_MSGID =               71;              // message id
  OCI_ATTR_MSG_PROP =                72;              // message properties

  OCI_ATTR_NUM_DML_ERRORS =          73;              // num of errs in array DML
  OCI_ATTR_DML_ROW_OFFSET =          74;              // row offset in the array

  OCI_ATTR_DATEFORMAT =              75;              // default date format string
  OCI_ATTR_BUF_ADDR =                76;              // buffer address
  OCI_ATTR_BUF_SIZE =                77;              // buffer size
  OCI_ATTR_NUM_ROWS =                81;              // number of rows in column array
                                                      // NOTE that OCI_ATTR_NUM_COLS is a column
                                                      // array attribute too.

  OCI_ATTR_COL_COUNT =               82;              // columns of column array processed so far.
  OCI_ATTR_STREAM_OFFSET =           83;              // str off of last row processed
  OCI_ATTR_SHARED_HEAPALLOC =        84;              // Shared Heap Allocation Size

  OCI_ATTR_SERVER_GROUP =            85;              // server group name

  OCI_ATTR_MIGSESSION =              86;              // migratable session attribute

  OCI_ATTR_NOCACHE =                 87;              // Temporary LOBs

  OCI_ATTR_MEMPOOL_SIZE =            88;              // Pool Size
  OCI_ATTR_MEMPOOL_INSTNAME =        89;              // Instance name
  OCI_ATTR_MEMPOOL_APPNAME =         90;              // Application name
  OCI_ATTR_MEMPOOL_HOMENAME =        91;              // Home Directory name
  OCI_ATTR_MEMPOOL_MODEL =           92;              // Pool Model (proc,thrd,both)
  OCI_ATTR_MODES =                   93;              // Modes

  OCI_ATTR_SUBSCR_NAME =             94;              // name of subscription
  OCI_ATTR_SUBSCR_CALLBACK =         95;              // associated callback
  OCI_ATTR_SUBSCR_CTX =              96;              // associated callback context
  OCI_ATTR_SUBSCR_PAYLOAD =          97;              // associated payload
  OCI_ATTR_SUBSCR_NAMESPACE =        98;              // associated namespace

  OCI_ATTR_PROXY_CREDENTIALS =       99;              // Proxy user credentials
  OCI_ATTR_INITIAL_CLIENT_ROLES =   100;              // Initial client role list

  OCI_ATTR_UNK =               101;                   // unknown attribute
  OCI_ATTR_NUM_COLS =          102;                   // number of columns
  OCI_ATTR_LIST_COLUMNS =      103;                   // parameter of the column list
  OCI_ATTR_RDBA =              104;                   // DBA of the segment header
  OCI_ATTR_CLUSTERED =         105;                   // whether the table is clustered
  OCI_ATTR_PARTITIONED =       106;                   // whether the table is partitioned
  OCI_ATTR_INDEX_ONLY =        107;                   // whether the table is index only
  OCI_ATTR_LIST_ARGUMENTS =    108;                   // parameter of the argument list
  OCI_ATTR_LIST_SUBPROGRAMS =  109;                   // parameter of the subprogram list
  OCI_ATTR_REF_TDO =           110;                   // REF to the type descriptor
  OCI_ATTR_LINK =              111;                   // the database link name
  OCI_ATTR_MIN =               112;                   // minimum value
  OCI_ATTR_MAX =               113;                   // maximum value
  OCI_ATTR_INCR =              114;                   // increment value
  OCI_ATTR_CACHE =             115;                   // number of sequence numbers cached
  OCI_ATTR_ORDER =             116;                   // whether the sequence is ordered
  OCI_ATTR_HW_MARK =           117;                   // high-water mark
  OCI_ATTR_TYPE_SCHEMA =       118;                   // type's schema name
  OCI_ATTR_TIMESTAMP =         119;                   // timestamp of the object
  OCI_ATTR_NUM_ATTRS =         120;                   // number of sttributes
  OCI_ATTR_NUM_PARAMS =        121;                   // number of parameters
  OCI_ATTR_OBJID =             122;                   // object id for a table or view
  OCI_ATTR_PTYPE =             123;                   // type of info described by
  OCI_ATTR_PARAM =             124;                   // parameter descriptor
  OCI_ATTR_OVERLOAD_ID =       125;                   // overload ID for funcs and procs
  OCI_ATTR_TABLESPACE =        126;                   // table name space
  OCI_ATTR_TDO =               127;                   // TDO of a type
  OCI_ATTR_LTYPE =             128;                   // list type
  OCI_ATTR_PARSE_ERROR_OFFSET =129;                   // Parse Error offset
  OCI_ATTR_IS_TEMPORARY =      130;                   // whether table is temporary
  OCI_ATTR_IS_TYPED =          131;                   // whether table is typed
  OCI_ATTR_DURATION =          132;                   // duration of temporary table
  OCI_ATTR_IS_INVOKER_RIGHTS = 133;                   // is invoker rights
  OCI_ATTR_OBJ_NAME =          134;                   // top level schema obj name
  OCI_ATTR_OBJ_SCHEMA =        135;                   // schema name
  OCI_ATTR_OBJ_ID =            136;                   // top level schema object id

  OCI_ATTR_TRANS_TIMEOUT =            142;            // transaction timeout
  OCI_ATTR_SERVER_STATUS =            143;            // state of the server handle
  OCI_ATTR_STATEMENT =                144;            // statement txt in stmt hdl
  OCI_ATTR_NO_CACHE =                 145;            // statement should not be executed in cache
  OCI_ATTR_DEQCOND =                  146;            // dequeue condition
  OCI_ATTR_RESERVED_2 =               147;            // reserved

  OCI_ATTR_SUBSCR_RECPT =             148;            // recepient of subscription
  OCI_ATTR_SUBSCR_RECPTPROTO =        149;            // protocol for recepient

  OCI_ATTR_LDAP_HOST =         153;                   // LDAP host to connect to
  OCI_ATTR_LDAP_PORT =         154;                   // LDAP port to connect to
  OCI_ATTR_BIND_DN =           155;                   // bind DN
  OCI_ATTR_LDAP_CRED =         156;                   // credentials to connect to LDAP
  OCI_ATTR_WALL_LOC =          157;                   // client wallet location
  OCI_ATTR_LDAP_AUTH =         158;                   // LDAP authentication method
  OCI_ATTR_LDAP_CTX =          159;                   // LDAP adminstration context DN
  OCI_ATTR_SERVER_DNS =        160;                   // list of registration server DNs

  OCI_ATTR_DN_COUNT =          161;                   // the number of server DNs
  OCI_ATTR_SERVER_DN =         162;                   // server DN attribute

  OCI_ATTR_MAXCHAR_SIZE =      163;                   // max char size of data

  OCI_ATTR_CURRENT_POSITION =  164;                   // for scrollable result sets

  // Added to get attributes for ref cursor to statement handle
  OCI_ATTR_RESERVED_3 =        165;                   // reserved
  OCI_ATTR_RESERVED_4 =        166;                   // reserved
  OCI_ATTR_DIGEST_ALGO =       168;                   // digest algorithm
  OCI_ATTR_CERTIFICATE =       169;                   // certificate
  OCI_ATTR_SIGNATURE_ALGO =    170;                   // signature algorithm
  OCI_ATTR_CANONICAL_ALGO =    171;                   // canonicalization algo.
  OCI_ATTR_PRIVATE_KEY =       172;                   // private key
  OCI_ATTR_DIGEST_VALUE =      173;                   // digest value
  OCI_ATTR_SIGNATURE_VAL =     174;                   // signature value
  OCI_ATTR_SIGNATURE =         175;                   // signature

  // attributes for setting OCI stmt caching specifics in svchp
  OCI_ATTR_STMTCACHESIZE =     176;                   // size of the stm cache

  // ------------------------ Connection Pool Attributes -----------------------
  OCI_ATTR_CONN_NOWAIT =       178;
  OCI_ATTR_CONN_BUSY_COUNT =   179;
  OCI_ATTR_CONN_OPEN_COUNT =   180;
  OCI_ATTR_CONN_TIMEOUT =      181;
  OCI_ATTR_STMT_STATE =        182;
  OCI_ATTR_CONN_MIN =          183;
  OCI_ATTR_CONN_MAX =          184;
  OCI_ATTR_CONN_INCR =         185;

  // For value 187, see DirPathAPI attribute section in this file

  OCI_ATTR_NUM_OPEN_STMTS =    188;                   // open stmts in session
  OCI_ATTR_DESCRIBE_NATIVE =   189;                   // get native info via desc

  OCI_ATTR_BIND_COUNT =        190;                   // number of bind postions
  OCI_ATTR_HANDLE_POSITION =   191;                   // pos of bind/define handle
  OCI_ATTR_RESERVED_5 =        192;                   // reserverd
  OCI_ATTR_SERVER_BUSY =       193;                   // call in progress on server

  // For value 194, see DirPathAPI attribute section in this file

  // notification presentation for recipient
  OCI_ATTR_SUBSCR_RECPTPRES =  195;
  OCI_ATTR_TRANSFORMATION =    196;                   // AQ message transformation

  OCI_ATTR_ROWS_FETCHED =      197;                   // rows fetched in last call

  // --------------------------- Snapshot attributes ---------------------------
  OCI_ATTR_SCN_BASE =          198;                   // snapshot base
  OCI_ATTR_SCN_WRAP =          199;                   // snapshot wrap

  // --------------------------- Miscellanous attributes -----------------------
  OCI_ATTR_RESERVED_6 =        200;                   // reserved */
  OCI_ATTR_READONLY_TXN =      201;                   // txn is readonly
  OCI_ATTR_RESERVED_7 =        202;                   // reserved
  OCI_ATTR_ERRONEOUS_COLUMN =  203;                   // position of erroneous col
  OCI_ATTR_RESERVED_8 =        204;                   // reserved
  OCI_ATTR_ASM_VOL_SPRT =      205;                   // ASM volume supported?

  // For value 206, see DirPathAPI attribute section in this file

  OCI_ATTR_INST_TYPE =         207;                   // oracle instance type
  // USED attribute 208 for  OCI_ATTR_SPOOL_STMTCACHESIZE

  OCI_ATTR_ENV_UTF16 =         209;                   // is env in utf16 mode?
  OCI_ATTR_ENV_CHARSET_ID =     31;                   // = OCI_ATTR_CHARSET_ID - charset id in env
  OCI_ATTR_ENV_NCHARSET_ID =   262;                   // = OCI_ATTR_NCHARSET_ID - ncharset id in env
  OCI_ATTR_RESERVED_9 =        210;                   // reserved
  OCI_ATTR_RESERVED_10 =       211;                   // reserved

  // For values 212 and 213, see DirPathAPI attribute section in this file

  OCI_ATTR_RESERVED_12 =       214;                   // reserved
  OCI_ATTR_RESERVED_13 =       215;                   // reserved
  OCI_ATTR_IS_EXTERNAL =       216;                   // whether table is external

  // -------------------------- Statement Handle Attributes ------------------
  OCI_ATTR_RESERVED_15 =       217;                   // reserved
  OCI_ATTR_STMT_IS_RETURNING = 218;                   // stmt has returning clause
  OCI_ATTR_RESERVED_16 =       219;                   // reserved
  OCI_ATTR_RESERVED_17 =       220;                   // reserved
  OCI_ATTR_RESERVED_18 =       221;                   // reserved

  // --------------------------- session attributes ---------------------------
  OCI_ATTR_RESERVED_19 =       222;                   // reserved
  OCI_ATTR_RESERVED_20 =       223;                   // reserved
  OCI_ATTR_CURRENT_SCHEMA =    224;                   // Current Schema
  OCI_ATTR_RESERVED_21 =       415;                   // reserved
  OCI_ATTR_LAST_LOGON_TIME_UTC=463;                   // Last Successful Logon Time

  // ------------------------- notification subscription ----------------------
  OCI_ATTR_SUBSCR_QOSFLAGS =   225;                   // QOS flags
  OCI_ATTR_SUBSCR_PAYLOADCBK = 226;                   // Payload callback
  OCI_ATTR_SUBSCR_TIMEOUT =    227;                   // Timeout
  OCI_ATTR_SUBSCR_NAMESPACE_CTX=228;                  // Namespace context
  OCI_ATTR_SUBSCR_CQ_QOSFLAGS =229;                   // change notification (CQ) specific QOS flags
  OCI_ATTR_SUBSCR_CQ_REGID =   230;                   // change notification registration id
  OCI_ATTR_SUBSCR_NTFN_GROUPING_CLASS =       231;    // ntfn grouping class
  OCI_ATTR_SUBSCR_NTFN_GROUPING_VALUE =       232;    // ntfn grouping value
  OCI_ATTR_SUBSCR_NTFN_GROUPING_TYPE =        233;    // ntfn grouping type
  OCI_ATTR_SUBSCR_NTFN_GROUPING_START_TIME =  234;    // ntfn grp start time
  OCI_ATTR_SUBSCR_NTFN_GROUPING_REPEAT_COUNT =235;    // ntfn grp rep count
  OCI_ATTR_AQ_NTFN_GROUPING_MSGID_ARRAY =     236;    // aq grp msgid array
  OCI_ATTR_AQ_NTFN_GROUPING_COUNT =           237;    // ntfns recd in grp

  // ----------------------- row callback attributes -------------------------
  OCI_ATTR_BIND_ROWCBK =                      301;    // bind row callback
  OCI_ATTR_BIND_ROWCTX =                      302;    // ctx for bind row callback
  OCI_ATTR_SKIP_BUFFER =                      303;    // skip buffer in array ops

  // ----------------------- XStream API attributes --------------------------
  OCI_ATTR_XSTREAM_ACK_INTERVAL =             350;    // XStream ack interval
  OCI_ATTR_XSTREAM_IDLE_TIMEOUT =             351;    // XStream idle timeout

  //-----  Db Change Notification (CQ) statement handle attributes------------
  OCI_ATTR_CQ_QUERYID =                       304;
  // ------------- DB Change Notification reg handle attributes ---------------
  OCI_ATTR_CHNF_TABLENAMES =                  401;    // out: array of table names
  OCI_ATTR_CHNF_ROWIDS =                      402;    // in: rowids needed
  OCI_ATTR_CHNF_OPERATIONS =                  403;    // in: notification operation filter
  OCI_ATTR_CHNF_CHANGELAG =                   404;    // txn lag between notifications

  // DB Change: Notification Descriptor attributes -----------------------
  OCI_ATTR_CHDES_DBNAME =                     405;    // source database
  OCI_ATTR_CHDES_NFYTYPE =                    406;    // notification type flags
  OCI_ATTR_CHDES_XID =                        407;    // XID  of the transaction
  OCI_ATTR_CHDES_TABLE_CHANGES =              408;    // array of table chg descriptors

  OCI_ATTR_CHDES_TABLE_NAME =                 409;    // table name
  OCI_ATTR_CHDES_TABLE_OPFLAGS =              410;    // table operation flags
  OCI_ATTR_CHDES_TABLE_ROW_CHANGES =          411;    // array of changed rows
  OCI_ATTR_CHDES_ROW_ROWID =                  412;    // rowid of changed row
  OCI_ATTR_CHDES_ROW_OPFLAGS =                413;    // row operation flags

  // Statement handle attribute for db change notification
  OCI_ATTR_CHNF_REGHANDLE =                   414;    // IN: subscription handle
  OCI_ATTR_NETWORK_FILE_DESC =                415;    // network file descriptor

  // client name for single session proxy
  OCI_ATTR_PROXY_CLIENT =                     416;

  // 415 is already taken - see OCI_ATTR_RESERVED_21

  // TDE attributes on the Table
  OCI_ATTR_TABLE_ENC =                        417;    // does table have any encrypt columns
  OCI_ATTR_TABLE_ENC_ALG =                    418;    // Table encryption Algorithm
  OCI_ATTR_TABLE_ENC_ALG_ID =                 419;    // Internal Id of encryption Algorithm

  // -------- Attributes related to Statement cache callback -----------------
  OCI_ATTR_STMTCACHE_CBKCTX =                 420;    // opaque context on stmt
  OCI_ATTR_STMTCACHE_CBK =                    421;    // callback fn for stmtcache

  // ---------------- Query change descriptor attributes -----------------------
  OCI_ATTR_CQDES_OPERATION =                  422;
  OCI_ATTR_CQDES_TABLE_CHANGES =              423;
  OCI_ATTR_CQDES_QUERYID =                    424;

  OCI_ATTR_CHDES_QUERIES =                    425;    // Top level change desc array of queries

  // --------- Attributes added to support server side session pool ----------
  OCI_ATTR_CONNECTION_CLASS =                 425;
  OCI_ATTR_PURITY =                           426;

  OCI_ATTR_PURITY_DEFAULT =                   $00;
  OCI_ATTR_PURITY_NEW =                       $01;
  OCI_ATTR_PURITY_SELF =                      $02;

  // -------- Attributes for Network Session Time Out--------------------------
  // >= 11.2
  OCI_ATTR_SEND_TIMEOUT =                     435;    // NS send timeout in MSec
  OCI_ATTR_RECEIVE_TIMEOUT =                  436;    // NS receive timeout in MSec

  //--------- Attributes related to LOB prefetch------------------------------
  OCI_ATTR_DEFAULT_LOBPREFETCH_SIZE =         438;    // default prefetch size
  OCI_ATTR_LOBPREFETCH_SIZE =                 439;    // prefetch size
  OCI_ATTR_LOBPREFETCH_LENGTH =               440;    // prefetch length & chunk

  //--------- Attributes related to LOB Deduplicate Regions ------------------
  OCI_ATTR_LOB_REGION_PRIMARY =               442;    // Primary LOB Locator
  OCI_ATTR_LOB_REGION_PRIMOFF =               443;    // Offset into Primary LOB
  OCI_ATTR_LOB_REGION_OFFSET =                445;    // Region Offset
  OCI_ATTR_LOB_REGION_LENGTH =                446;    // Region Length Bytes/Chars
  OCI_ATTR_LOB_REGION_MIME =                  447;    // Region mime type

  //--------------------Attribute to fetch ROWID ------------------------------
  OCI_ATTR_FETCH_ROWID =                      448;

  // server attribute
  OCI_ATTR_RESERVED_37 =                      449;

  //-------------------Attributes for OCI column security-----------------------
  OCI_ATTR_NO_COLUMN_AUTH_WARNING =           450;
  OCI_ATTR_XDS_POLICY_STATUS =                451;

  OCI_XDS_POLICY_NONE =                       0;
  OCI_XDS_POLICY_ENABLED =                    1;
  OCI_XDS_POLICY_UNKNOWN =                    2;

  // --------------- ip address attribute in environment handle --------------
  OCI_ATTR_SUBSCR_IPADDR =                    452;    // ip address to listen on

  // server attribute
  OCI_ATTR_RESERVED_40 =                      453;
  OCI_ATTR_RESERVED_42 =                      455;
  OCI_ATTR_RESERVED_43 =                      456;

  // statement attribute
  OCI_ATTR_UB8_ROW_COUNT =                    457;    // ub8 value of row count

  // ------------- round trip callback attributes in the process  handle -----
  OCI_ATTR_RESERVED_458 =                     458;    // reserved
  OCI_ATTR_RESERVED_459 =                     459;    // reserved

  // invisible columns attributes
  OCI_ATTR_SHOW_INVISIBLE_COLUMNS =           460;    // invisible columns support
  OCI_ATTR_INVISIBLE_COL =                    461;    // invisible columns support

  // support at most once transaction semantics
  OCI_ATTR_LTXID =                            462;    // logical transaction id

  // statement handle attribute
  OCI_ATTR_IMPLICIT_RESULT_COUNT =            463;

  OCI_ATTR_RESERVED_464 =                     464;
  OCI_ATTR_RESERVED_465 =                     465;
  OCI_ATTR_RESERVED_466 =                     466;
  OCI_ATTR_RESERVED_467 =                     467;

  // SQL translation profile session attribute
  OCI_ATTR_SQL_TRANSLATION_PROFILE =          468;

  // Per Iteration array DML rowcount attribute
  OCI_ATTR_DML_ROW_COUNT_ARRAY =              469;
  OCI_ATTR_RESERVED_470 =                     470;

  // session handle attribute
  OCI_ATTR_MAX_OPEN_CURSORS =                 471;

  { Can application failover and recover from this error?
    e.g. ORA-03113 is recoverable while ORA-942 (table or view does not exist)
    is not. }
  OCI_ATTR_ERROR_IS_RECOVERABLE =             472;

  // ONS specific private attribute
  OCI_ATTR_RESERVED_473 =                     473;

  // Attribute to check if ILM Write Access Tracking is enabled or not
  OCI_ATTR_ILM_TRACK_WRITE =                  474;

  // Notification subscription failure callback and context
  OCI_ATTR_SUBSCR_FAILURE_CBK =               477;
  OCI_ATTR_SUBSCR_FAILURE_CTX =               478;

  // Reserved
  OCI_ATTR_RESERVED_479 =                     479;
  OCI_ATTR_RESERVED_480 =                     480;
  OCI_ATTR_RESERVED_481 =                     481;
  OCI_ATTR_RESERVED_482 =                     482;

  { A SQL translation profile with FOREIGN_SQL_SYNTAX attribute is set in the
    database session. }
  OCI_ATTR_TRANS_PROFILE_FOREIGN =            483;

  // is a transaction active on the session?
  OCI_ATTR_TRANSACTION_IN_PROGRESS =          484;

  // add attribute for DBOP: DataBase OPeration
  OCI_ATTR_DBOP =                             485;

  // FAN-HA private attribute
  OCI_ATTR_RESERVED_486 =                     486;

  // reserved
  OCI_ATTR_RESERVED_487 =                     487;

  OCI_ATTR_RESERVED_488 =                     488;

  OCI_ATTR_VARTYPE_MAXLEN_COMPAT =            489;

  // Max Lifetime for session
  OCI_ATTR_SPOOL_MAX_LIFETIME_SESSION =       490;

  OCI_ATTR_RESERVED_491 =                     491;

  OCI_ATTR_RESERVED_492 =                     492;

  OCI_ATTR_RESERVED_493 =                     493;

  OCI_ATTR_ITERS_PROCESSED =                  494;

  OCI_ATTR_BREAK_ON_NET_TIMEOUT =             495;    // Break on timeout

  //---------------------------- DB Change: Event types ------------------------
  OCI_EVENT_NONE =              $0;                   // None
  OCI_EVENT_STARTUP =           $1;                   // Startup database
  OCI_EVENT_SHUTDOWN =          $2;                   // Shutdown database
  OCI_EVENT_SHUTDOWN_ANY =      $3;                   // Startup instance
  OCI_EVENT_DROP_DB =           $4;                   // Drop database
  OCI_EVENT_DEREG =             $5;                   // Subscription deregistered
  OCI_EVENT_OBJCHANGE =         $6;                   // Object change notification
  OCI_EVENT_QUERYCHANGE =       $7;                   // query result change

  //---------------------------- DB Change: Operation types --------------------
  OCI_OPCODE_ALLROWS =          $01;                  // all rows invalidated
  OCI_OPCODE_ALLOPS =           $00;                  // interested in all operations
  OCI_OPCODE_INSERT =           $02;                  // INSERT
  OCI_OPCODE_UPDATE =           $04;                  // UPDATE
  OCI_OPCODE_DELETE =           $08;                  // DELETE
  OCI_OPCODE_ALTER =            $10;                  // ALTER
  OCI_OPCODE_DROP =             $20;                  // DROP TABLE
  OCI_OPCODE_UNKNOWN =          $40;                  // GENERIC/ UNKNOWN

  // ----------------------- ha event callback attributes --------------------
  OCI_ATTR_EVTCBK =             304;                  // ha callback
  OCI_ATTR_EVTCTX =             305;                  // ctx for ha callback

  // ------------------ User memory attributes (all handles) -----------------
  OCI_ATTR_USER_MEMORY =        306;                  // pointer to user memory

  // ------- unauthorised access and user action auditing banners ------------
  OCI_ATTR_ACCESS_BANNER =      307;                  // access banner
  OCI_ATTR_AUDIT_BANNER =       308;                  // audit banner

  // ----------------- port no attribute in environment  handle  -------------
  OCI_ATTR_SUBSCR_PORTNO =      390;                  // port no to listen

  //------------- Supported Values for protocol for recepient -----------------
  OCI_SUBSCR_PROTO_OCI =        0;                    // oci
  OCI_SUBSCR_PROTO_MAIL =       1;                    // mail
  OCI_SUBSCR_PROTO_SERVER =     2;                    // server
  OCI_SUBSCR_PROTO_HTTP =       3;                    // http
  OCI_SUBSCR_PROTO_MAX =        4;                    // max current protocols

  //------------- Supported Values for presentation for recepient -------------
  OCI_SUBSCR_PRES_DEFAULT =     0;                    // default
  OCI_SUBSCR_PRES_XML =         1;                    // xml
  OCI_SUBSCR_PRES_MAX =         2;                    // max current presentations

  //------------- Supported QOS values for notification registrations ---------
  OCI_SUBSCR_QOS_RELIABLE =                   $01;    // reliable
  OCI_SUBSCR_QOS_PAYLOAD =                    $02;    // payload delivery
  OCI_SUBSCR_QOS_REPLICATE =                  $04;    // replicate to director
  // internal qos - 12c secure ntfns with client initiated connections
  OCI_SUBSCR_QOS_SECURE =                     $08;    // secure payload delivery
  OCI_SUBSCR_QOS_PURGE_ON_NTFN =              $10;    // purge on first ntfn
  OCI_SUBSCR_QOS_MULTICBK =                   $20;    // multi instance callback
  // 0x40 is used for a internal flag
  OCI_SUBSCR_QOS_HAREG =                      $80;    // HA reg
  // non-durable registration. For now supported only with secure ntfns
  OCI_SUBSCR_QOS_NONDURABLE =                 $100;   // non-durable reg
  OCI_SUBSCR_QOS_ASYNC_DEQ =                  $200;   // Asyncronous Deq
  OCI_SUBSCR_QOS_AUTO_ACK =                   $400;   // auto acknowledgement
  OCI_SUBSCR_QOS_TX_ACK =                     $800;   // transacted acks

  // ----QOS flags specific to change notification/ continuous queries CQ -----
  OCI_SUBSCR_CQ_QOS_QUERY =                   $01;    // query level notification
  OCI_SUBSCR_CQ_QOS_BEST_EFFORT =             $02;    // best effort notification
  OCI_SUBSCR_CQ_QOS_CLQRYCACHE =              $04;    // client query caching

  //------------- Supported Values for notification grouping class ------------
  OCI_SUBSCR_NTFN_GROUPING_CLASS_TIME =       1;      // time

  //------------- Supported Values for notification grouping type -------------
  OCI_SUBSCR_NTFN_GROUPING_TYPE_SUMMARY =     1;      // summary
  OCI_SUBSCR_NTFN_GROUPING_TYPE_LAST =        2;      // last

  //--------- Temporary attribute value for UCS2/UTF16 character set ID -------
  OCI_US7ASCIIID =                            1;      // US7ASCII charset ID
  OCI_UTF8ID =                              871;      // UTF8 charset ID
  OCI_UCS2ID =                             1000;      // UCS2 charset ID
  OCI_UTF16ID =                            1000;      // UTF16 charset ID

  // -------------------------- Implicit Result types ------------------------
  OCI_RESULT_TYPE_SELECT =                    1;

  //---------------- Server Handle Attribute Values ---------------------------
  // OCI_ATTR_SERVER_STATUS
  OCI_SERVER_NOT_CONNECTED =                  $0;
  OCI_SERVER_NORMAL =                         $1;

  //------------------------- Supported Namespaces  ---------------------------
  OCI_SUBSCR_NAMESPACE_ANONYMOUS =            0;      // Anonymous Namespace
  OCI_SUBSCR_NAMESPACE_AQ =                   1;      // Advanced Queues
  OCI_SUBSCR_NAMESPACE_DBCHANGE =             2;      // change notification
  OCI_SUBSCR_NAMESPACE_RESERVED1 =            3;
  OCI_SUBSCR_NAMESPACE_MAX =                  4;      // Max Name Space Number

  //-------------------------Credential Types----------------------------------
  OCI_CRED_RDBMS =                            1;      // database username/password
  OCI_CRED_EXT =                              2;      // externally provided credentials
  OCI_CRED_PROXY =                            3;      // proxy authentication
  OCI_CRED_RESERVED_1 =                       4;      // reserved
  OCI_CRED_RESERVED_2 =                       5;      // reserved
  OCI_CRED_RESERVED_3 =                       6;      // reserved

  //------------------------Error Return Values--------------------------------
  OCI_SUCCESS =                               0;      // maps to SQL_SUCCESS of SAG CLI
  OCI_SUCCESS_WITH_INFO =                     1;      // maps to SQL_SUCCESS_WITH_INFO
  OCI_RESERVED_FOR_INT_USE =                200;      // reserved
  OCI_NO_DATA =                             100;      // maps to SQL_NO_DATA
  OCI_ERROR =                                -1;      // maps to SQL_ERROR
  OCI_INVALID_HANDLE =                       -2;      // maps to SQL_INVALID_HANDLE
  OCI_NEED_DATA =                            99;      // maps to SQL_NEED_DATA
  OCI_STILL_EXECUTING =                   -3123;      // OCI would block error

  //--------------------- User Callback Return Values -------------------------
  OCI_CONTINUE =                         -24200;      // Continue with the body of the OCI function
  OCI_ROWCBK_DONE =                      -24201;                                    

  // ------------------DateTime and Interval check Error codes------------------
  // DateTime Error Codes used by OCIDateTimeCheck() */
  OCI_DT_INVALID_DAY          = $1;       // Bad day
  OCI_DT_DAY_BELOW_VALID      = $2;       // Bad DAy Low/high bit (1=low)
  OCI_DT_INVALID_MONTH        = $4;       // Bad MOnth
  OCI_DT_MONTH_BELOW_VALID    = $8;       // Bad MOnth Low/high bit (1=low)
  OCI_DT_INVALID_YEAR         = $10;      // Bad YeaR
  OCI_DT_YEAR_BELOW_VALID     = $20;      // Bad YeaR Low/high bit (1=low)
  OCI_DT_INVALID_HOUR         = $40;      // Bad HouR
  OCI_DT_HOUR_BELOW_VALID     = $80;      // Bad HouR Low/high bit (1=low)
  OCI_DT_INVALID_MINUTE       = $100;     // Bad MiNute
  OCI_DT_MINUTE_BELOW_VALID   = $200;     // Bad MiNute Low/high bit (1=low)
  OCI_DT_INVALID_SECOND       = $400;     // Bad SeCond
  OCI_DT_SECOND_BELOW_VALID   = $800;     // Bad second Low/high bit (1=low)
  OCI_DT_DAY_MISSING_FROM_1582=$1000;     // Day is one of those "missing" from 1582
  OCI_DT_YEAR_ZERO            = $2000;    // Year may not equal zero
  OCI_DT_INVALID_TIMEZONE     = $4000;    // Bad Timezone
  OCI_DT_INVALID_FORMAT       = $8000;    // Bad date format input

  // Interval Error Codes used by OCIInterCheck()
  OCI_INTER_INVALID_DAY         = $1;     // Bad day
  OCI_INTER_DAY_BELOW_VALID     = $2;     // Bad DAy Low/high bit (1=low)
  OCI_INTER_INVALID_MONTH       = $4;     // Bad MOnth
  OCI_INTER_MONTH_BELOW_VALID   = $8;     // Bad MOnth Low/high bit (1=low)
  OCI_INTER_INVALID_YEAR        = $10;    // Bad YeaR
  OCI_INTER_YEAR_BELOW_VALID    = $20;    // Bad YeaR Low/high bit (1=low)
  OCI_INTER_INVALID_HOUR        = $40;    // Bad HouR
  OCI_INTER_HOUR_BELOW_VALID    = $80;    // Bad HouR Low/high bit (1=low)
  OCI_INTER_INVALID_MINUTE      = $100;   // Bad MiNute
  OCI_INTER_MINUTE_BELOW_VALID  = $200;   // Bad MiNute Low/high bit(1=low)
  OCI_INTER_INVALID_SECOND      = $400;   // Bad SeCond
  OCI_INTER_SECOND_BELOW_VALID  = $800;   // Bad second Low/high bit(1=low)
  OCI_INTER_INVALID_FRACSEC     = $1000;  // Bad Fractional second
  OCI_INTER_FRACSEC_BELOW_VALID = $2000;  // Bad fractional second Low/High

  //------------------------Parsing Syntax Types-------------------------------
  OCI_V7_SYNTAX =                 2;                  // V815 language - for backwards compatibility
  OCI_V8_SYNTAX =                 3;                  // V815 language - for backwards compatibility
  OCI_NTV_SYNTAX =                1;                  // Use what so ever is the native lang of server
  OCI_FOREIGN_SYNTAX =    UB4MAXVAL;                  // Foreign syntax - require translation

  //------------------------(Scrollable Cursor) Fetch Options-------------------
  { For non-scrollable cursor, the only valid (and default) orientation is
    OCI_FETCH_NEXT }
  OCI_FETCH_CURRENT =             $00000001;          // refetching current position
  OCI_FETCH_NEXT =                $00000002;          // next row
  OCI_FETCH_FIRST =               $00000004;          // first row of the result set
  OCI_FETCH_LAST =                $00000008;          // the last row of the result set
  OCI_FETCH_PRIOR =               $00000010;          // previous row relative to current
  OCI_FETCH_ABSOLUTE =            $00000020;          // absolute offset from first
  OCI_FETCH_RELATIVE =            $00000040;          // offset relative to current
  OCI_FETCH_RESERVED_1 =          $00000080;          // reserved
  OCI_FETCH_RESERVED_2 =          $00000100;          // reserved
  OCI_FETCH_RESERVED_3 =          $00000200;          // reserved
  OCI_FETCH_RESERVED_4 =          $00000400;          // reserved
  OCI_FETCH_RESERVED_5 =          $00000800;          // reserved
  OCI_FETCH_RESERVED_6 =          $00001000;          // reserved

  //------------------------Bind and Define Options----------------------------
  OCI_SB2_IND_PTR =               $00000001;          // unused
  OCI_DATA_AT_EXEC =              $00000002;          // data at execute time
  OCI_DYNAMIC_FETCH =             $00000002;          // fetch dynamically
  OCI_PIECEWISE =                 $00000004;          // piecewise DMLs or fetch
  OCI_DEFINE_RESERVED_1 =         $00000008;          // reserved
  OCI_BIND_RESERVED_2 =           $00000010;          // reserved
  OCI_DEFINE_RESERVED_2 =         $00000020;          // reserved
  OCI_BIND_SOFT =                 $00000040;          // soft bind or define
  OCI_DEFINE_SOFT =               $00000080;          // soft bind or define
  OCI_BIND_RESERVED_3 =           $00000100;          // reserved
  OCI_IOV =                       $00000200;          // For scatter gather bind/define

  //-----------------------------  Various Modes ------------------------------
  OCI_DEFAULT =                   $00000000;          // the default value for parameters and attributes

  //-------------OCIInitialize Modes / OCICreateEnvironment Modes -------------
  OCI_THREADED =                  $00000001;          // appl. in threaded environment
  OCI_OBJECT =                    $00000002;          // application in object environment
  OCI_EVENTS =                    $00000004;          // >= 8.1.5 application is enabled for events
  OCI_RESERVED1 =                 $00000008;          // reserved
  OCI_SHARED =                    $00000010;          // >= 8.1.5 the application is in shared mode
  OCI_RESERVED2 =                 $00000020;          // reserved
  // The following /TWO/ are only valid for OCICreateEnvironment call
  OCI_NO_UCB =                    $00000040;          // No user callback called during ini
  OCI_NO_MUTEX =                  $00000080;          // if not OCI_THREADED and < 8.1
                                                      // the environment handle will not be
                                                      // protected by a mutex internally
  // >= 8.1
  OCI_SHARED_EXT =                $00000100;          // Used for shared forms
  // $00000200 free
  OCI_ALWAYS_BLOCKING =           $00000400;          // all connections always blocking
  // $00000800 free
  OCI_USE_LDAP =                  $00001000;          // allow  LDAP connections
  OCI_REG_LDAPONLY =              $00002000;          // only register to LDAP
  OCI_UTF16 =                     $00004000;          // mode for all UTF16 metadata
  OCI_AFC_PAD_ON =                $00008000;          // turn on AFC blank padding when rlenp present
  OCI_ENVCR_RESERVED3 =           $00010000;          // reserved
  OCI_NEW_LENGTH_SEMANTICS =      $00020000;          // adopt new length semantics
       // the new length semantics, always bytes, is used by OCIEnvNlsCreate
  OCI_NO_MUTEX_STMT =             $00040000;          // Do not mutex stmt handle
  OCI_MUTEX_ENV_ONLY =            $00080000;          // Mutex only the environment handle
  OCI_SUPPRESS_NLS_VALIDATION =   $00100000;          // suppress nls validation
      // nls validation suppression is on by default; use OCI_ENABLE_NLS_VALIDATION to disable it
  // >= 10.2
  OCI_MUTEX_TRY =                 $00200000;          // try and acquire mutex
  OCI_NCHAR_LITERAL_REPLACE_ON =  $00400000;          // nchar literal replace on
  OCI_NCHAR_LITERAL_REPLACE_OFF = $00800000;          // nchar literal replace off//
  OCI_ENABLE_NLS_VALIDATION =     $01000000;          // enable nls validation
  OCI_ENVCR_RESERVED4 =           $02000000;          // reserved
  OCI_ENVCR_RESERVED5 =           $04000000;          // reserved
  OCI_ENVCR_RESERVED6 =           $08000000;          // reserved
  OCI_ENVCR_RESERVED7 =           $10000000;          // reserved
  // >= 12
  // client initiated notification listener connections, applicable only for 12c queues and above
  OCI_SECURE_NOTIFICATION =       $20000000;
  OCI_DISABLE_DIAG =              $40000000;          // disable diagnostics

  //----------------------- Execution Modes -----------------------------------
  OCI_BATCH_MODE =                $00000001;          // batch the oci stmt for exec
  OCI_EXACT_FETCH =               $00000002;          // fetch exact rows specified
  // $00000004 available
  OCI_STMT_SCROLLABLE_READONLY =  $00000008;          // if result set is scrollable
  OCI_DESCRIBE_ONLY =             $00000010;          // only describe the statement
  OCI_COMMIT_ON_SUCCESS =         $00000020;          // commit, if successful exec
  OCI_NON_BLOCKING =              $00000040;          // non-blocking
  OCI_BATCH_ERRORS =              $00000080;          // batch errors in array dmls
  OCI_PARSE_ONLY =                $00000100;          // only parse the statement
  OCI_EXACT_FETCH_RESERVED_1 =    $00000200;          // reserved
  OCI_SHOW_DML_WARNINGS =         $00000400;          // return OCI_SUCCESS_WITH_INFO for delete/update w/no where clause
  OCI_EXEC_RESERVED_2 =           $00000800;          // reserved
  OCI_DESC_RESERVED_1 =           $00001000;          // reserved
  OCI_EXEC_RESERVED_3 =           $00002000;          // reserved
  OCI_EXEC_RESERVED_4 =           $00004000;          // reserved
  OCI_EXEC_RESERVED_5 =           $00008000;          // reserved
  OCI_EXEC_RESERVED_6 =           $00010000;          // reserved
  OCI_RESULT_CACHE =              $00020000;          // hint to use query caching
  OCI_NO_RESULT_CACHE =           $00040000;          // hint to bypass query caching
  OCI_EXEC_RESERVED_7 =           $00080000;          // reserved
  OCI_RETURN_ROW_COUNT_ARRAY =    $00100000;          // Per Iter DML Row Count mode

  //------------------------Authentication Modes-------------------------------
  OCI_MIGRATE =                   $00000001;          // migratable auth context
  OCI_SYSDBA =                    $00000002;          // for SYSDBA authorization
  OCI_SYSOPER =                   $00000004;          // for SYSOPER authorization
  OCI_PRELIM_AUTH =               $00000008;          // for preliminary authorization
  OCIP_ICACHE =                   $00000010;          // Private OCI cache mode
  OCI_AUTH_RESERVED_1 =           $00000020;          // reserved
  OCI_STMT_CACHE =                $00000040;          // enable OCI Stmt Caching
  OCI_STATELESS_CALL =            $00000080;          // stateless at call boundary
  OCI_STATELESS_TXN =             $00000100;          // stateless at txn boundary
  OCI_STATELESS_APP =             $00000200;          // stateless at user-specified pts
  OCI_AUTH_RESERVED_2 =           $00000400;          // reserved
  OCI_AUTH_RESERVED_3 =           $00000800;          // reserved
  OCI_AUTH_RESERVED_4 =           $00001000;          // reserved
  OCI_AUTH_RESERVED_5 =           $00002000;          // reserved
  OCI_SYSASM =                    $00008000;          // for SYSASM authorization
  OCI_AUTH_RESERVED_6 =           $00010000;          // reserved
  OCI_SYSBKP =                    $00020000;          // for SYSBACKUP authorization
  OCI_SYSDGD =                    $00040000;          // for SYSDG authorization
  OCI_SYSKMT =                    $00080000;          // for SYSKM authorization

  //---------------------OCIStmtPrepare2 Modes---------------------------------
  OCI_PREP2_CACHE_SEARCHONLY =    $0010;              // ONly Search
  OCI_PREP2_GET_PLSQL_WARNINGS =  $0020;              // Get PL/SQL warnings
  OCI_PREP2_RESERVED_1 =          $0040;              // reserved
  OCI_PREP2_RESERVED_2 =          $0080;              // reserved
  OCI_PREP2_RESERVED_3 =          $0100;              // reserved
  OCI_PREP2_RESERVED_4 =          $0200;              // reserved
  OCI_PREP2_IMPL_RESULTS_CLIENT = $0400;              // client for implicit results
  OCI_PREP2_RESERVED_5 =          $0800;              // reserved

  //---------------------OCIStmtRelease Modes----------------------------------
  OCI_STRLS_CACHE_DELETE =        $0010;              // Delete from Cache

  //------------------------Piece Information----------------------------------
  OCI_PARAM_IN =                  $01;                // in parameter
  OCI_PARAM_OUT =                 $02;                // out parameter

  //------------------------ Transaction Start Flags --------------------------
  // NOTE: OCI_TRANS_JOIN and OCI_TRANS_NOMIGRATE not supported in 8.0.X
  OCI_TRANS_NEW =                 $00000001;          // start a new local or global txn
  OCI_TRANS_JOIN =                $00000002;          // join an existing global txn
  OCI_TRANS_RESUME =              $00000004;          // resume the global txn branch
  OCI_TRANS_PROMOTE =             $00000008;          // promote the local txn to global
  OCI_TRANS_STARTMASK =           $000000ff;          // mask for start operation flags

  OCI_TRANS_READONLY =            $00000100;          // start a readonly txn
  OCI_TRANS_READWRITE =           $00000200;          // start a read-write txn
  OCI_TRANS_SERIALIZABLE =        $00000400;          // start a serializable txn
  OCI_TRANS_ISOLMASK =            $0000ff00;          // mask for start isolation flags

  OCI_TRANS_LOOSE =               $00010000;          // a loosely coupled branch
  OCI_TRANS_TIGHT =               $00020000;          // a tightly coupled branch
  OCI_TRANS_TYPEMASK =            $000f0000;          // mask for branch type flags

  OCI_TRANS_NOMIGRATE =           $00100000;          // non migratable transaction
  OCI_TRANS_SEPARABLE =           $00200000;          // separable transaction (8.1.6+)
  OCI_TRANS_OTSRESUME =           $00400000;          // OTS resuming a transaction
  OCI_TRANS_OTHRMASK =            $fff00000;          // mask for other start flags

  //------------------------ Transaction End Flags ----------------------------
  OCI_TRANS_TWOPHASE =            $01000000;          // use two phase commit
  OCI_TRANS_WRITEBATCH =          $00000001;          // force cmt-redo for local txns
  OCI_TRANS_WRITEIMMED =          $00000002;          // no force cmt-redo
  OCI_TRANS_WRITEWAIT =           $00000004;          // no sync cmt-redo
  OCI_TRANS_WRITENOWAIT =         $00000008;          // sync cmt-redo for local txns

  //------------------------- AQ Constants ------------------------------------
  // ------------------------- Visibility flags -------------------------------
  OCI_ENQ_IMMEDIATE =             1;                  // enqueue is an independent transaction
  OCI_ENQ_ON_COMMIT =             2;                  // enqueue is part of current transaction

  // ----------------------- Dequeue mode flags -------------------------------
  OCI_DEQ_BROWSE =                1;                  // read message without acquiring a lock
  OCI_DEQ_LOCKED =                2;                  // read and obtain write lock on message
  OCI_DEQ_REMOVE =                3;                  // read the message and delete it
  OCI_DEQ_REMOVE_NODATA =         4;                  // delete message w'o returning payload
  OCI_DEQ_GETSIG =                5;                  // get signature only

  // ----------------- Dequeue navigation flags -------------------------------
  OCI_DEQ_FIRST_MSG =             1;                  // get first message at head of queue
  OCI_DEQ_NEXT_MSG =              3;                  // next message that is available
  OCI_DEQ_NEXT_TRANSACTION =      2;                  // get first message of next txn group
  OCI_DEQ_FIRST_MSG_MULTI_GROUP = 4;                  // start from first message and array deq across txn groups
  OCI_DEQ_MULT_TRANSACTION =      5;                  // array dequeue across txn groups
  OCI_DEQ_NEXT_MSG_MULTI_GROUP =  OCI_DEQ_MULT_TRANSACTION; // array dequeue across txn groups

  // ----------------- Dequeue Option Reserved flags -------------------------
  OCI_DEQ_RESERVED_1 =            $000001;

  // --------------------- Message states -------------------------------------
  OCI_MSG_WAITING =               1;                  // the message delay has not yet completed
  OCI_MSG_READY =                 0;                  // the message is ready to be processed
  OCI_MSG_PROCESSED =             2;                  // the message has been processed
  OCI_MSG_EXPIRED =               3;                  // message has moved to exception queue

  // --------------------- Sequence deviation ---------------------------------
  OCI_ENQ_BEFORE =                2;                  // enqueue message before another message
  OCI_ENQ_TOP =                   3;                  // enqueue message before all messages

  // ------------------------- Visibility flags -------------------------------
  OCI_DEQ_IMMEDIATE =             1;                  // dequeue is an independent transaction
  OCI_DEQ_ON_COMMIT =             2;                  // dequeue is part of current transaction

  // ------------------------ Wait --------------------------------------------
  OCI_DEQ_WAIT_FOREVER =         -1;                  // wait forever if no message available
  OCI_NTFN_GROUPING_FOREVER =    -1;                  // send grouping notifications forever
  OCI_DEQ_NO_WAIT =               0;                  // do not wait if no message is available

  OCI_FLOW_CONTROL_NO_TIMEOUT =  -1;                  // streaming enqueue: no timeout for flow control

  // ------------------------ Delay -------------------------------------------
  OCI_MSG_NO_DELAY =              0;                  // message is available immediately

  // ------------------------- Expiration -------------------------------------
  OCI_MSG_NO_EXPIRATION =        -1;                  // message will never expire

  OCI_MSG_PERSISTENT_OR_BUFFERED =3;
  OCI_MSG_BUFFERED =              2;
  OCI_MSG_PERSISTENT =            1;

  // ----------------------- Reserved/AQE pisdef flags ------------------------
  OCI_AQ_RESERVED_1 =             $0002;
  OCI_AQ_RESERVED_2 =             $0004;
  OCI_AQ_RESERVED_3 =             $0008;
  OCI_AQ_RESERVED_4 =             $0010;

  OCI_AQ_STREAMING_FLAG =         $02000000;

  // AQ JMS message types
  OCI_AQJMS_RAW_MSG =             $00000001;          // raw message
  OCI_AQJMS_TEXT_MSG =            $00000002;          // text message
  OCI_AQJMS_MAP_MSG =             $00000004;          // map message
  OCI_AQJMS_BYTE_MSG =            $00000008;          // byte message
  OCI_AQJMS_STREAM_MSG =          $00000010;          // stream message
  OCI_AQJMS_ADT_MSG =             $00000020;          // adt message

  // AQ JMS Message streaming flags
  OCI_AQMSG_FIRST_CHUNK =         $00000001;          // first chunk of message
  OCI_AQMSG_NEXT_CHUNK =          $00000002;          // next chunk of message
  OCI_AQMSG_LAST_CHUNK =          $00000004;          // last chunk of message

  // ------------------------------ Replay Info -------------------------------
  OCI_AQ_LAST_ENQUEUED =          0;
  OCI_AQ_LAST_ACKNOWLEDGED =      1;

  //=======================Describe Handle Parameter Attributes ===============
  //===========================================================================

  // Attributes common to Columns and Stored Procs
  OCI_ATTR_DATA_SIZE      = 1;    // maximum size of the data
  OCI_ATTR_DATA_TYPE      = 2;    // the SQL type of the column/argument
  OCI_ATTR_DISP_SIZE      = 3;    // the display size
  OCI_ATTR_NAME           = 4;    // the name of the column/argument
  OCI_ATTR_PRECISION      = 5;    // precision if number type
  OCI_ATTR_SCALE          = 6;    // scale if number type
  OCI_ATTR_IS_NULL        = 7;    // is it null ?
  OCI_ATTR_TYPE_NAME      = 8;    // name of the named data type or a package name for package private types
  OCI_ATTR_SCHEMA_NAME    = 9;    // the schema name
  OCI_ATTR_SUB_NAME       = 10;   // type name if package private type
  OCI_ATTR_POSITION       = 11;   // relative position of col/arg in the list of cols/args

  // complex object retrieval parameter attributes
  OCI_ATTR_COMPLEXOBJECTCOMP_TYPE         = 50;
  OCI_ATTR_COMPLEXOBJECTCOMP_TYPE_LEVEL   = 51;
  OCI_ATTR_COMPLEXOBJECT_LEVEL            = 52;
  OCI_ATTR_COMPLEXOBJECT_COLL_OUTOFLINE   = 53;

  // Only Columns
  OCI_ATTR_DISP_NAME      = 100;  // the display name
  OCI_ATTR_ENCC_SIZE      = 101;  // encrypted data size
  OCI_ATTR_COL_ENC        = 102;  // column is encrypted ?
  OCI_ATTR_COL_ENC_SALT   = 103;  // is encrypted column salted ?
  OCI_ATTR_COL_PROPERTIES = 104;  // column properties

  // Flags coresponding to the column properties
  OCI_ATTR_COL_PROPERTY_IS_IDENTITY           = $0000000000000001;
  OCI_ATTR_COL_PROPERTY_IS_GEN_ALWAYS         = $0000000000000002;
  OCI_ATTR_COL_PROPERTY_IS_GEN_BY_DEF_ON_NULL = $0000000000000004;

  // Only Stored Procs
  OCI_ATTR_OVERLOAD       = 210;  // is this position overloaded
  OCI_ATTR_LEVEL          = 211;  // level for structured types
  OCI_ATTR_HAS_DEFAULT    = 212;  // has a default value
  OCI_ATTR_IOMODE         = 213;  // in, out inout
  OCI_ATTR_RADIX          = 214;  // returns a radix
  OCI_ATTR_NUM_ARGS       = 215;  // total number of arguments

  // only named type attributes
  OCI_ATTR_TYPECODE                  = 216;   // object or collection
  OCI_ATTR_COLLECTION_TYPECODE       = 217;   // varray or nested table
  OCI_ATTR_VERSION                   = 218;   // user assigned version
  OCI_ATTR_IS_INCOMPLETE_TYPE        = 219;   // is this an incomplete type
  OCI_ATTR_IS_SYSTEM_TYPE            = 220;   // a system type
  OCI_ATTR_IS_PREDEFINED_TYPE        = 221;   // a predefined type
  OCI_ATTR_IS_TRANSIENT_TYPE         = 222;   // a transient type
  OCI_ATTR_IS_SYSTEM_GENERATED_TYPE  = 223;   // system generated type
  OCI_ATTR_HAS_NESTED_TABLE          = 224;   // contains nested table attr
  OCI_ATTR_HAS_LOB                   = 225;   // has a lob attribute
  OCI_ATTR_HAS_FILE                  = 226;   // has a file attribute
  OCI_ATTR_COLLECTION_ELEMENT        = 227;   // has a collection attribute
  OCI_ATTR_NUM_TYPE_ATTRS            = 228;   // number of attribute types
  OCI_ATTR_LIST_TYPE_ATTRS           = 229;   // list of type attributes
  OCI_ATTR_NUM_TYPE_METHODS          = 230;   // number of type methods
  OCI_ATTR_LIST_TYPE_METHODS         = 231;   // list of type methods
  OCI_ATTR_MAP_METHOD                = 232;   // map method of type
  OCI_ATTR_ORDER_METHOD              = 233;   // order method of type

  // only collection element
  OCI_ATTR_NUM_ELEMS                 = 234;   // number of elements

  // only type methods
  OCI_ATTR_ENCAPSULATION             = 235;   // encapsulation level
  OCI_ATTR_IS_SELFISH                = 236;   // method selfish
  OCI_ATTR_IS_VIRTUAL                = 237;   // virtual
  OCI_ATTR_IS_INLINE                 = 238;   // inline
  OCI_ATTR_IS_CONSTANT               = 239;   // constant
  OCI_ATTR_HAS_RESULT                = 240;   // has result
  OCI_ATTR_IS_CONSTRUCTOR            = 241;   // constructor
  OCI_ATTR_IS_DESTRUCTOR             = 242;   // destructor
  OCI_ATTR_IS_OPERATOR               = 243;   // operator
  OCI_ATTR_IS_MAP                    = 244;   // a map method
  OCI_ATTR_IS_ORDER                  = 245;   // order method
  OCI_ATTR_IS_RNDS                   = 246;   // read no data state method
  OCI_ATTR_IS_RNPS                   = 247;   // read no process state
  OCI_ATTR_IS_WNDS                   = 248;   // write no data state method
  OCI_ATTR_IS_WNPS                   = 249;   // write no process state

  OCI_ATTR_DESC_PUBLIC               = 250;   // public object

  // Object Cache Enhancements : attributes for User Constructed Instances
  OCI_ATTR_CACHE_CLIENT_CONTEXT      = 251;
  OCI_ATTR_UCI_CONSTRUCT             = 252;
  OCI_ATTR_UCI_DESTRUCT              = 253;
  OCI_ATTR_UCI_COPY                  = 254;
  OCI_ATTR_UCI_PICKLE                = 255;
  OCI_ATTR_UCI_UNPICKLE              = 256;
  OCI_ATTR_UCI_REFRESH               = 257;

  // for type inheritance
  OCI_ATTR_IS_SUBTYPE                = 258;
  OCI_ATTR_SUPERTYPE_SCHEMA_NAME     = 259;
  OCI_ATTR_SUPERTYPE_NAME            = 260;

  // for schemas
  OCI_ATTR_LIST_OBJECTS              = 261;   // list of objects in schema

  // for database
  OCI_ATTR_NCHARSET_ID               = 262;   // char set id
  OCI_ATTR_LIST_SCHEMAS              = 263;   // list of schemas
  OCI_ATTR_MAX_PROC_LEN              = 264;   // max procedure length
  OCI_ATTR_MAX_COLUMN_LEN            = 265;   // max column name length
  OCI_ATTR_CURSOR_COMMIT_BEHAVIOR    = 266;   // cursor commit behavior
  OCI_ATTR_MAX_CATALOG_NAMELEN       = 267;   // catalog namelength
  OCI_ATTR_CATALOG_LOCATION          = 268;   // catalog location
  OCI_ATTR_SAVEPOINT_SUPPORT         = 269;   // savepoint support
  OCI_ATTR_NOWAIT_SUPPORT            = 270;   // nowait support
  OCI_ATTR_AUTOCOMMIT_DDL            = 271;   // autocommit DDL
  OCI_ATTR_LOCKING_MODE              = 272;   // locking mode

  // for externally initialized context
  OCI_ATTR_APPCTX_SIZE               = 273;   // count of context to be init
  OCI_ATTR_APPCTX_LIST               = 274;   // count of context to be init
  OCI_ATTR_APPCTX_NAME               = 275;   // name  of context to be init
  OCI_ATTR_APPCTX_ATTR               = 276;   // attr  of context to be init
  OCI_ATTR_APPCTX_VALUE              = 277;   // value of context to be init

  // for client id propagation
  OCI_ATTR_CLIENT_IDENTIFIER         = 278;   // value of client id to set

  // for inheritance - part 2
  OCI_ATTR_IS_FINAL_TYPE             = 279;   // is final type ?
  OCI_ATTR_IS_INSTANTIABLE_TYPE      = 280;   // is instantiable type ?
  OCI_ATTR_IS_FINAL_METHOD           = 281;   // is final method ?
  OCI_ATTR_IS_INSTANTIABLE_METHOD    = 282;   // is instantiable method ?
  OCI_ATTR_IS_OVERRIDING_METHOD      = 283;   // is overriding method ?

  // slot 284 available

  OCI_ATTR_CHAR_USED                 = 285;   // char length semantics
  OCI_ATTR_CHAR_SIZE                 = 286;   // char length

  // SQLJ support
  OCI_ATTR_IS_JAVA_TYPE              = 287;   // is java implemented type ?

  // N-Tier support
  OCI_ATTR_DISTINGUISHED_NAME        = 300;   // use DN as user name
  OCI_ATTR_KERBEROS_TICKET           = 301;   // Kerberos ticket as cred.

  // for multilanguage debugging
  OCI_ATTR_ORA_DEBUG_JDWP            = 302;   // ORA_DEBUG_JDWP attribute

  OCI_ATTR_RESERVED_14               = 303;   // reserved

  // For values 303 - 307, see DirPathAPI attribute section in this file

  // ----------------------- Session Pool Attributes -------------------------
  OCI_ATTR_SPOOL_TIMEOUT =             308;   // session timeout
  OCI_ATTR_SPOOL_GETMODE =             309;   // session get mode
  OCI_ATTR_SPOOL_BUSY_COUNT =          310;   // busy session count
  OCI_ATTR_SPOOL_OPEN_COUNT =          311;   // open session count
  OCI_ATTR_SPOOL_MIN =                 312;   // min session count
  OCI_ATTR_SPOOL_MAX =                 313;   // max session count
  OCI_ATTR_SPOOL_INCR =                314;   // session increment count
  OCI_ATTR_SPOOL_STMTCACHESIZE =       208;   // Stmt cache size of pool
  OCI_ATTR_SPOOL_AUTH =                460;   // Auth handle on pool handle

  //---------------------------- For XML Types -------------------------------
  // For table, view and column
  OCI_ATTR_IS_XMLTYPE =                315;   // Is the type an XML type?
  OCI_ATTR_XMLSCHEMA_NAME =            316;   // Name of XML Schema
  OCI_ATTR_XMLELEMENT_NAME =           317;   // Name of XML Element
  OCI_ATTR_XMLSQLTYPSCH_NAME =         318;   // SQL type's schema for XML Ele
  OCI_ATTR_XMLSQLTYPE_NAME =           319;   // Name of SQL type for XML Ele
  OCI_ATTR_XMLTYPE_STORED_OBJ =        320;   // XML type stored as object?
  OCI_ATTR_XMLTYPE_BINARY_XML =        422;   // XML type stored as binary?

  //---------------------------- For Subtypes -------------------------------
  // For type
  OCI_ATTR_HAS_SUBTYPES =              321;   // Has subtypes?
  OCI_ATTR_NUM_SUBTYPES =              322;   // Number of subtypes
  OCI_ATTR_LIST_SUBTYPES =             323;   // List of subtypes

  // XML flag
  OCI_ATTR_XML_HRCHY_ENABLED =         324;   // hierarchy enabled?

  // Method flag
  OCI_ATTR_IS_OVERRIDDEN_METHOD =      325;   // Method is overridden?

  // For values 326 - 335, see DirPathAPI attribute section in this file

  //------------- Attributes for 10i Distributed Objects ----------------------
  OCI_ATTR_OBJ_SUBS =                  336;   // obj col/tab substitutable

  // For values 337 - 338, see DirPathAPI attribute section in this file

  //---------- Attributes for 10i XADFIELD (NLS language, territory -----------
  OCI_ATTR_XADFIELD_RESERVED_1 =       339;   // reserved
  OCI_ATTR_XADFIELD_RESERVED_2 =       340;   // reserved

  //------------- Kerberos Secure Client Identifier ---------------------------
  OCI_ATTR_KERBEROS_CID =              341;   // Kerberos db service ticket

  //------------------------ Attributes for Rules objects ---------------------
  OCI_ATTR_CONDITION =                 342;   // rule condition
  OCI_ATTR_COMMENT =                   343;   // comment
  OCI_ATTR_VALUE =                     344;   // Anydata value
  OCI_ATTR_EVAL_CONTEXT_OWNER =        345;   // eval context owner
  OCI_ATTR_EVAL_CONTEXT_NAME =         346;   // eval context name
  OCI_ATTR_EVALUATION_FUNCTION =       347;   // eval function name
  OCI_ATTR_VAR_TYPE =                  348;   // variable type
  OCI_ATTR_VAR_VALUE_FUNCTION =        349;   // variable value function
  OCI_ATTR_VAR_METHOD_FUNCTION =       350;   // variable method function
  OCI_ATTR_ACTION_CONTEXT =            351;   // action context
  OCI_ATTR_LIST_TABLE_ALIASES =        352;   // list of table aliases
  OCI_ATTR_LIST_VARIABLE_TYPES =       353;   // list of variable types
  OCI_ATTR_TABLE_NAME =                356;   // table name

  // For values 357 - 359, see DirPathAPI attribute section in this file

  OCI_ATTR_MESSAGE_CSCN =              360;   // message cscn
  OCI_ATTR_MESSAGE_DSCN =              361;   // message dscn

  //--------------------- Audit Session ID ------------------------------------
  OCI_ATTR_AUDIT_SESSION_ID =          362;   // Audit session ID

  //--------------------- Kerberos TGT Keys -----------------------------------
  OCI_ATTR_KERBEROS_KEY =              363;   // n-tier Kerberos cred key
  OCI_ATTR_KERBEROS_CID_KEY =          364;   // SCID Kerberos cred key

  OCI_ATTR_TRANSACTION_NO =            365;   // AQ enq txn number

  // ----------------------- Attributes for End To End Tracing -----------------
  // >= 10.1
  OCI_ATTR_MODULE =                    366;   // module for tracing
  OCI_ATTR_ACTION =                    367;   // action for tracing
  OCI_ATTR_CLIENT_INFO =               368;   // client info
  OCI_ATTR_COLLECT_CALL_TIME =         369;   // collect call time
  OCI_ATTR_CALL_TIME =                 370;   // extract call time
  OCI_ATTR_ECONTEXT_ID =               371;   // execution-id context
  OCI_ATTR_ECONTEXT_SEQ =              372;   // execution-id sequence num

  //------------------------------ Session attributes -------------------------
  OCI_ATTR_SESSION_STATE =             373;   // session state
  OCI_SESSION_STATELESS = 1;                  // valid states
  OCI_SESSION_STATEFUL =  2;

  OCI_ATTR_SESSION_STATETYPE =         374;   // session state type
  OCI_SESSION_STATELESS_DEF = 0;              // valid state types
  OCI_SESSION_STATELESS_CAL = 1;
  OCI_SESSION_STATELESS_TXN = 2;
  OCI_SESSION_STATELESS_APP = 3;

  OCI_ATTR_SESSION_STATE_CLEARED =     376;   // session state cleared
  OCI_ATTR_SESSION_MIGRATED =          377;   // did session migrate
  OCI_ATTR_SESSION_PRESERVE_STATE =    388;   // preserve session state
  OCI_ATTR_DRIVER_NAME =               424;   // Driver Name

  // -------------------------- Admin Handle Attributes ----------------------
  // >= 10.2
  OCI_ATTR_ADMIN_PFILE =               389;   // client-side param file

  // -------------------------- HA Event Handle Attributes -------------------
  OCI_ATTR_HOSTNAME =                  390;   // SYS_CONTEXT hostname
  OCI_ATTR_DBNAME =                    391;   // SYS_CONTEXT dbname
  OCI_ATTR_INSTNAME =                  392;   // SYS_CONTEXT instance name
  OCI_ATTR_SERVICENAME =               393;   // SYS_CONTEXT service name
  OCI_ATTR_INSTSTARTTIME =             394;   // v$instance instance start time
  OCI_ATTR_HA_TIMESTAMP =              395;   // event time
  OCI_ATTR_RESERVED_22 =               396;   // reserved
  OCI_ATTR_RESERVED_23 =               397;   // reserved
  OCI_ATTR_RESERVED_24 =               398;   // reserved
  OCI_ATTR_DBDOMAIN =                  399;   // db domain
  OCI_ATTR_RESERVED_27 =               425;   // reserved

  OCI_ATTR_EVENTTYPE =                 400;   // event type
  // valid value for OCI_ATTR_EVENTTYPE
  OCI_EVENTTYPE_HA = 0;

  OCI_ATTR_HA_SOURCE =                 401;
  // valid values for OCI_ATTR_HA_SOURCE
  OCI_HA_SOURCE_INSTANCE =           0;
  OCI_HA_SOURCE_DATABASE =           1;
  OCI_HA_SOURCE_NODE =               2;
  OCI_HA_SOURCE_SERVICE =            3;
  OCI_HA_SOURCE_SERVICE_MEMBER =     4;
  OCI_HA_SOURCE_ASM_INSTANCE =       5;
  OCI_HA_SOURCE_SERVICE_PRECONNECT = 6;

  OCI_ATTR_HA_STATUS =                 402;
  // valid values for OCI_ATTR_HA_STATUS
  OCI_HA_STATUS_DOWN = 0;
  OCI_HA_STATUS_UP =   1;

  OCI_ATTR_HA_SRVFIRST =               403;
  OCI_ATTR_HA_SRVNEXT =                404;

  // ------------------------- Server Handle Attributes -----------------------
  OCI_ATTR_TAF_ENABLED =               405;

  // Extra notification attributes
  OCI_ATTR_NFY_FLAGS =                 406;

  OCI_ATTR_MSG_DELIVERY_MODE =         407;   // msg delivery mode

  OCI_ATTR_DB_CHARSET_ID =             416;   // database charset ID
  OCI_ATTR_DB_NCHARSET_ID =            417;   // database ncharset ID
  OCI_ATTR_RESERVED_25 =               418;   // reserved

  OCI_ATTR_FLOW_CONTROL_TIMEOUT =      423;   // AQ: flow control timeout

  OCI_ATTR_ENV_NLS_LANGUAGE =          424;
  OCI_ATTR_ENV_NLS_TERRITORY =         425;

  //===================DirPathAPI attribute Section============================
  //===========================================================================

  //------------- Supported Values for Direct Path Stream Version -------------
  OCI_DIRPATH_STREAM_VERSION_1 =       100;
  OCI_DIRPATH_STREAM_VERSION_2 =       200;
  OCI_DIRPATH_STREAM_VERSION_3 =       300;   // default


  OCI_ATTR_DIRPATH_MODE =              78;    // mode of direct path operation
  OCI_ATTR_DIRPATH_NOLOG =             79;    // nologging option
  OCI_ATTR_DIRPATH_PARALLEL =          80;    // parallel (temp seg) option

  // >= 8.1
  OCI_ATTR_DIRPATH_SORTED_INDEX =      137;   // index that data is sorted on

  // direct path index maint method (see oci8dp.h)
  OCI_ATTR_DIRPATH_INDEX_MAINT_METHOD= 138;

  // parallel load: db file, initial and next extent sizes
  OCI_ATTR_DIRPATH_FILE =              139;   // DB file to load into
  OCI_ATTR_DIRPATH_STORAGE_INITIAL =   140;   // initial extent size
  OCI_ATTR_DIRPATH_STORAGE_NEXT =      141;   // next extent size

  // 8.2 dpapi support of FDTs
  OCI_ATTR_DIRPATH_EXPR_TYPE =         150;   // expr type of OCI_ATTR_NAME

  OCI_ATTR_DIRPATH_INPUT =             151;   // input in text or stream format
  OCI_DIRPATH_INPUT_TEXT =             $01;
  OCI_DIRPATH_INPUT_STREAM =           $02;
  OCI_DIRPATH_INPUT_UNKNOWN =          $04;

  OCI_ATTR_DIRPATH_FN_CTX =            167;   // fn ctx FDT attrs or args

  OCI_ATTR_DIRPATH_OID =               187;   // loading into an OID col
  OCI_ATTR_DIRPATH_SID =               194;   // loading into an SID col
  OCI_ATTR_DIRPATH_OBJ_CONSTR =        206;   // obj type of subst obj tbl

  // Attr to allow setting of the stream version PRIOR to calling Prepare
  OCI_ATTR_DIRPATH_STREAM_VERSION =    212;   // version of the stream//

  OCIP_ATTR_DIRPATH_VARRAY_INDEX =     213;   // varray index column

  //------------- Supported Values for Direct Path Date cache -----------------
  OCI_ATTR_DIRPATH_DCACHE_NUM =        303;   // date cache entries
  OCI_ATTR_DIRPATH_DCACHE_SIZE =       304;   // date cache limit
  OCI_ATTR_DIRPATH_DCACHE_MISSES =     305;   // date cache misses
  OCI_ATTR_DIRPATH_DCACHE_HITS =       306;   // date cache hits
  OCI_ATTR_DIRPATH_DCACHE_DISABLE =    307;   { on set: disable datecache on overflow.
                                                on get: datecache disabled? could be due to overflow or others }

  //------------- Attributes for 10i Updates to the DirPath API ---------------
  OCI_ATTR_DIRPATH_RESERVED_7 =        326;   // reserved
  OCI_ATTR_DIRPATH_RESERVED_8 =        327;   // reserved
  OCI_ATTR_DIRPATH_CONVERT =           328;   // stream conversion needed?
  OCI_ATTR_DIRPATH_BADROW =            329;   // info about bad row
  OCI_ATTR_DIRPATH_BADROW_LENGTH =     330;   // length of bad row info
  OCI_ATTR_DIRPATH_WRITE_ORDER =       331;   // column fill order
  OCI_ATTR_DIRPATH_GRANULE_SIZE =      332;   // granule size for unload
  OCI_ATTR_DIRPATH_GRANULE_OFFSET =    333;   // offset to last granule
  OCI_ATTR_DIRPATH_RESERVED_1 =        334;   // reserved
  OCI_ATTR_DIRPATH_RESERVED_2 =        335;   // reserved

  //------ Attributes for 10i DirPathAPI conversion (NLS lang, terr, cs) ------
  OCI_ATTR_DIRPATH_RESERVED_3 =        337;   // reserved
  OCI_ATTR_DIRPATH_RESERVED_4 =        338;   // reserved
  OCI_ATTR_DIRPATH_RESERVED_5 =        357;   // reserved
  OCI_ATTR_DIRPATH_RESERVED_6 =        358;   // reserved

  OCI_ATTR_DIRPATH_LOCK_WAIT =         359;   // wait for lock in dpapi

  // values for OCI_ATTR_DIRPATH_MODE attribute
  OCI_DIRPATH_LOAD       = 1;    // direct path load operation
  OCI_DIRPATH_UNLOAD     = 2;    // direct path unload operation
  OCI_DIRPATH_CONVERT    = 3;    // direct path convert only operation

  // values for OCI_ATTR_DIRPATH_INDEX_MAINT_METHOD attribute
  OCI_DIRPATH_INDEX_MAINT_SINGLE_ROW    = 1;
  OCI_DIRPATH_INDEX_MAINT_SKIP_UNUSABLE = 2;
  OCI_DIRPATH_INDEX_MAINT_SKIP_ALL      = 3;

  // values for OCI_ATTR_STATE attribute of OCIDirPathCtx
  OCI_DIRPATH_NORMAL       = 1;    // can accept rows, last row complete
  OCI_DIRPATH_PARTIAL      = 2;    // last row was partial
  OCI_DIRPATH_NOT_PREPARED = 3;    // direct path context is not prepared

  // values for cflg argument to OCIDirpathColArrayEntrySet
  OCI_DIRPATH_COL_COMPLETE = 0;    // column data is complete
  OCI_DIRPATH_COL_NULL     = 1;    // column is null
  OCI_DIRPATH_COL_PARTIAL  = 2;    // column data is partial

  // values for action parameter to OCIDirPathDataSave
  OCI_DIRPATH_DATASAVE_SAVEONLY = 0;  // data save point only
  OCI_DIRPATH_DATASAVE_FINISH   = 1;  // execute finishing logic

  //================ Describe Handle Parameter Attribute Values ===============
  //===========================================================================

  // OCI_ATTR_CURSOR_COMMIT_BEHAVIOR
  OCI_CURSOR_OPEN   = 0;
  OCI_CURSOR_CLOSED = 1;

  // OCI_ATTR_CATALOG_LOCATION
  OCI_CL_START = 0;
  OCI_CL_END   = 1;

  // OCI_ATTR_SAVEPOINT_SUPPORT
  OCI_SP_SUPPORTED   = 0;
  OCI_SP_UNSUPPORTED = 1;

  // OCI_ATTR_NOWAIT_SUPPORT
  OCI_NW_SUPPORTED   = 0;
  OCI_NW_UNSUPPORTED = 1;

  // OCI_ATTR_AUTOCOMMIT_DDL
  OCI_AC_DDL    = 0;
  OCI_NO_AC_DDL = 1;

  // OCI_ATTR_LOCKING_MODE
  OCI_LOCK_IMMEDIATE = 0;
  OCI_LOCK_DELAYED   = 1;

  // ------------------- Instance type attribute values -----------------------
  OCI_INSTANCE_TYPE_UNKNOWN = 0;
  OCI_INSTANCE_TYPE_RDBMS   = 1;
  OCI_INSTANCE_TYPE_OSM     = 2;
  OCI_INSTANCE_TYPE_PROXY   = 3;
  OCI_INSTANCE_TYPE_IOS     = 4;

  // ---------------- ASM Volume Device Support attribute values --------------
  OCI_ASM_VOLUME_UNSUPPORTED = 0;
  OCI_ASM_VOLUME_SUPPORTED   = 1;

  //---------------------------OCIPasswordChange-------------------------------
  OCI_AUTH  = $08;     // Change the password but do not login

  //------------------------Other Constants------------------------------------
  OCI_MAX_FNS =                     100;    // max number of OCI Functions
  OCI_SQLSTATE_SIZE =                 5;
  OCI_ERROR_MAXMSG_SIZE =          1024;    // max size of an error message
  OCI_ERROR_MAXMSG_SIZE2 =         3072;    // new len max size of an error message
  OCI_LOBMAXSIZE =         MINUB4MAXVAL;    // maximum lob data size
  OCI_ROWID_LEN =                    23;
  OCI_LOB_CONTENTTYPE_MAXSIZE =     128;    // max size of securefile contenttype
  OCI_LOB_CONTENTTYPE_MAXBYTESIZE = 128;
  OCI_MAX_ATTR_LEN =               1024;
  OCI_NLS_MAXBUFSZ =                100;    // Max buffer size may need for OCINlsGetInfo

  //------------------------ Fail Over Events ---------------------------------
  OCI_FO_END =         $00000001;
  OCI_FO_ABORT =       $00000002;
  OCI_FO_REAUTH =      $00000004;
  OCI_FO_BEGIN =       $00000008;
  OCI_FO_ERROR =       $00000010;

  //------------------------ Fail Over Callback Return Codes ------------------
  OCI_FO_RETRY =       25410;

  //------------------------- Fail Over Types ---------------------------------
  OCI_FO_NONE =        $00000001;
  OCI_FO_SESSION =     $00000002;
  OCI_FO_SELECT =      $00000004;
  OCI_FO_TXNAL =       $00000008;

  //--------------------- OCI_ATTR_VARTYPE_MAXLEN_COMPAT values ---------------
  OCI_ATTR_MAXLEN_COMPAT_STANDARD = 1;
  OCI_ATTR_MAXLEN_COMPAT_EXTENDED = 2;

  //----------------------------Piece Definitions------------------------------
  OCI_ONE_PIECE       = 0;    // one piece
  OCI_FIRST_PIECE     = 1;    // the first piece
  OCI_NEXT_PIECE      = 2;    // the next of many pieces
  OCI_LAST_PIECE      = 3;    // the last piece

  //--------------------------- FILE open modes -------------------------------
  OCI_FILE_READONLY   = 1;    // readonly mode open for FILE types

  //--------------------------- LOB open modes --------------------------------
  OCI_LOB_READONLY      = 1;  // readonly mode open for ILOB types
  OCI_LOB_READWRITE     = 2;  // read write mode open for ILOBs
  OCI_LOB_WRITEONLY     = 3;  // Writeonly mode open for ILOB types
  OCI_LOB_APPENDONLY    = 4;  // Appendonly mode open for ILOB types
  OCI_LOB_FULLOVERWRITE = 5;  // Completely overwrite ILOB
  OCI_LOB_FULLREAD      = 6;  // Doing a Full Read of ILOB

  //----------------------- LOB Buffering Flush Flags -------------------------
  OCI_LOB_BUFFER_FREE     = 1;
  OCI_LOB_BUFFER_NOFREE   = 2;

  //---------------------------LOB Option Types -------------------------------
  OCI_LOB_OPT_COMPRESS     = 1;    // SECUREFILE Compress
  OCI_LOB_OPT_ENCRYPT      = 2;    // SECUREFILE Encrypt
  OCI_LOB_OPT_DEDUPLICATE  = 4;    // SECUREFILE Deduplicate
  OCI_LOB_OPT_ALLOCSIZE    = 8;    // SECUREFILE Allocation Size
  OCI_LOB_OPT_CONTENTTYPE  = 16;   // SECUREFILE Content Type
  OCI_LOB_OPT_MODTIME      = 32;   // SECUREFILE Modification Time

  //------------------------   LOB Option Values ------------------------------
  // Compression
  OCI_LOB_COMPRESS_OFF = 0;        // Compression off
  OCI_LOB_COMPRESS_ON  = 1;        // Compression on
  // Encryption
  OCI_LOB_ENCRYPT_OFF  = 0;        // Encryption Off
  OCI_LOB_ENCRYPT_ON   = 2;        // Encryption On
  // Deduplciate
  OCI_LOB_DEDUPLICATE_OFF = 0;     // Deduplicate Off
  OCI_LOB_DEDUPLICATE_ON  = 4;     // Deduplicate Lobs

  //--------------------------- OCI Statement Types ---------------------------
  OCI_STMT_SELECT  = 1;   // select statement
  OCI_STMT_UPDATE  = 2;   // update statement
  OCI_STMT_DELETE  = 3;   // delete statement
  OCI_STMT_INSERT  = 4;   // Insert Statement
  OCI_STMT_CREATE  = 5;   // create statement
  OCI_STMT_DROP    = 6;   // drop statement
  OCI_STMT_ALTER   = 7;   // alter statement
  OCI_STMT_BEGIN   = 8;   // begin ... (pl/sql statement)
  OCI_STMT_DECLARE = 9;   // declare .. (pl/sql statement)
  OCI_STMT_CALL     = 10; // corresponds to kpu call
  OCI_STMT_EXPLAIN1 = 14; // explain (on 8.0)
  OCI_STMT_EXPLAIN2 = 15; // explain (on 8.1 and higher)

  //--------------------------- OCI Parameter Types ---------------------------
  OCI_PTYPE_UNK                 = 0;    // unknown
  OCI_PTYPE_TABLE               = 1;    // table
  OCI_PTYPE_VIEW                = 2;    // view
  OCI_PTYPE_PROC                = 3;    // procedure
  OCI_PTYPE_FUNC                = 4;    // function
  OCI_PTYPE_PKG                 = 5;    // package
  OCI_PTYPE_TYPE                = 6;    // user-defined type
  OCI_PTYPE_SYN                 = 7;    // synonym
  OCI_PTYPE_SEQ                 = 8;    // sequence
  OCI_PTYPE_COL                 = 9;    // column
  OCI_PTYPE_ARG                 = 10;   // argument
  OCI_PTYPE_LIST                = 11;   // list
  OCI_PTYPE_TYPE_ATTR           = 12;   // user-defined type's attribute
  OCI_PTYPE_TYPE_COLL           = 13;   // collection type's element
  OCI_PTYPE_TYPE_METHOD         = 14;   // user-defined type's method
  OCI_PTYPE_TYPE_ARG            = 15;   // user-defined type method's argument
  OCI_PTYPE_TYPE_RESULT         = 16;   // user-defined type method's result
  OCI_PTYPE_SCHEMA              = 17;   // schema
  OCI_PTYPE_DATABASE            = 18;   // database
  OCI_PTYPE_RULE                = 19;   // rule
  OCI_PTYPE_RULE_SET            = 20;   // rule set
  OCI_PTYPE_EVALUATION_CONTEXT  = 21;   // evaluation context
  OCI_PTYPE_TABLE_ALIAS         = 22;   // table alias
  OCI_PTYPE_VARIABLE_TYPE       = 23;   // variable type
  OCI_PTYPE_NAME_VALUE          = 24;   // name value pair

  //--------------------- NLS service type and constance ----------------------
  OCI_NLS_CHARSET_ID  = 93;       // Character set id
  OCI_NLS_NCHARSET_ID = 94;       // NCharacter set id
  // ............. more ................

  // ------------------------- Database Startup Flags --------------------------
  OCI_DBSTARTUPFLAG_FORCE    = $00000001; // Abort running instance, start
  OCI_DBSTARTUPFLAG_RESTRICT = $00000002; // Restrict access to DBA

  // ------------------------- Database Shutdown Modes -------------------------
  OCI_DBSHUTDOWN_TRANSACTIONAL       = 1; // Wait for all the transactions
  OCI_DBSHUTDOWN_TRANSACTIONAL_LOCAL = 2; // Wait for local transactions
  OCI_DBSHUTDOWN_IMMEDIATE           = 3; // Terminate and roll back
  OCI_DBSHUTDOWN_ABORT               = 4; // Terminate and don't roll back
  OCI_DBSHUTDOWN_FINAL               = 5; // Orderly shutdown

  {----------------------------------------------------------------------------}
  { ORO.H                                                                      }
  {----------------------------------------------------------------------------}

  //--------------------------- OBJECT INDICATOR ------------------------------
type
  OCIInd = sb2;
  pOCIInd = ^OCIInd;
const
  OCI_IND_NOTNULL                    =  0;          // not NULL
  OCI_IND_NULL                       = -1;          // NULL
  OCI_IND_BADNULL                    = -2;          // BAD NULL
  OCI_IND_NOTNULLABLE                = -3;          // not NULLable

  //-------------------------- Object Cache ----------------------------------
  OCI_ATTR_OBJECT_NEWNOTNULL         = $10;
  OCI_ATTR_OBJECT_DETECTCHANGE       = $20;
  OCI_ATTR_CACHE_ARRAYFLUSH          = $40;

  //-------------------------- OBJECT Duration -------------------------------
type
  OCIDuration = ub2;
const
  OCI_DURATION_INVALID = $FFFF;                     // Invalid duration
  OCI_DURATION_BEGIN = 10;
                                                    // beginning sequence of duration
  OCI_DURATION_NULL = OCI_DURATION_BEGIN-1;         // null duration
  OCI_DURATION_DEFAULT = OCI_DURATION_BEGIN-2;      // default
  OCI_DURATION_USER_CALLBACK = OCI_DURATION_BEGIN-3;
  OCI_DURATION_NEXT = OCI_DURATION_BEGIN-4;         // next special duration
  OCI_DURATION_SESSION = OCI_DURATION_BEGIN;        // the end of user session
  OCI_DURATION_TRANS = OCI_DURATION_BEGIN+1;        // the end of user transaction

  //--------------------------- Type parameter mode ---------------------------
  // Proc/Func param type
  OCI_TYPEPARAM_IN    = 0;
  OCI_TYPEPARAM_OUT   = 1;
  OCI_TYPEPARAM_INOUT = 2;

  {----------------------------------------------------------------------------}
  { ORL.H                                                                      }
  {----------------------------------------------------------------------------}

  //------------------------ NUMBER/FLOAT/DECIMAL TYPE ------------------------
const
  OCI_NUMBER_SIZE = 22;
type
  OCINumber = array [0 .. OCI_NUMBER_SIZE-1] of ub1;
  pOCINumber = ^OCINumber;

  //-------------------------- OCINumberToInt ---------------------------------
const
  OCI_NUMBER_UNSIGNED = 0;
  OCI_NUMBER_SIGNED   = 2;

  //------------------------- COLLECTION FUNCTIONS ----------------------------
type
  // OCIColl - generic collection type
  pOCIColl = pOCIHandle;

  // OCIArray - varray collection type
  pOCIArray = pOCIColl;

  // OCITable - nested table collection type
  pOCITable = pOCIColl;

  // OCIIter - collection iterator
  pOCIIter = pOCIHandle;

  {----------------------------------------------------------------------------}
  { XA.H                                                                       }
  {----------------------------------------------------------------------------}

  //-------------- Transaction branch identification: XID and NULLXID ---------
const
  MAXTXNAMELEN = 64;
  XIDDATASIZE  = 128;   // size in bytes
  MAXGTRIDSIZE = 64;    // maximum size in bytes of gtrid
  MAXBQUALSIZE = 64;    // maximum size in bytes of bqual
  NULLXID_ID   = -1;

type
  PXID = ^TXID;
  TXID = record
    formatID: sb4;      // format identifier
    gtrid_length: sb4;  // value from 1 through 64
    bqual_length: sb4;  // value from 1 through 64
    data: array [0 .. XIDDATASIZE - 1] of ub1;
  end;

{
  If call SQLConnection1.StartTransaction(rDesc) with following rDesc:
    rDesc.TransactionID := 100;
    rDesc.GlobalID := 100;
  then dbExpress driver will setup following XID:
    formatID = .....
    gtrid_length := 3
    bqual_length := 1;
    data := '100'#1
}

  {----------------------------------------------------------------------------}
  { OCIDFN.H                                                                   }
  {----------------------------------------------------------------------------}

const
  // OCI Data Types
  SQLT_CHR = 1  ;            // (ORANET TYPE) character string
  SQLT_NUM = 2  ;            // (ORANET TYPE) oracle numeric
  SQLT_INT = 3  ;            // (ORANET TYPE) integer
  SQLT_FLT = 4  ;            // (ORANET TYPE) Floating point number
  SQLT_STR = 5  ;            // zero terminated string
  SQLT_VNU = 6  ;            // NUM with preceding length byte
  SQLT_PDN = 7  ;            // (ORANET TYPE) Packed Decimal Numeric
  SQLT_LNG = 8  ;            // long
  SQLT_VCS = 9  ;            // Variable character string
  SQLT_NON = 10 ;            // Null/empty PCC Descriptor entry
  SQLT_RID = 11 ;            // rowid
  SQLT_DAT = 12 ;            // date in oracle format
  SQLT_VBI = 15 ;            // binary in VCS format
  SQLT_BIN = 23 ;            // binary data(DTYBIN)
  SQLT_LBI = 24 ;            // long binary
  _SQLT_PLI = 29;
  SQLT_UIN = 68 ;            // unsigned integer
  SQLT_SLS = 91 ;            // Display sign leading separate
  SQLT_LVC = 94 ;            // Longer longs (char)
  SQLT_LVB = 95 ;            // Longer long binary
  SQLT_AFC = 96 ;            // Ansi fixed char
  SQLT_AVC = 97 ;            // Ansi Var char
  SQLT_CUR = 102;            // cursor  type
  SQLT_RDD = 104;            // rowid descriptor
  SQLT_LAB = 105;            // label type
  SQLT_OSL = 106;            // oslabel type
  SQLT_NTY = 108;            // named object type
  SQLT_REF = 110;            // ref type
  SQLT_CLOB = 112;           // character lob
  SQLT_BLOB = 113;           // binary lob
  SQLT_BFILEE = 114;         // binary file lob
  SQLT_CFILEE = 115;         // character file lob
  SQLT_RSET = 116;           // result set type
  SQLT_NCO = 122;            // named collection type (varray or nested table)
  SQLT_VST = 155;            // OCIString type
  SQLT_ODT = 156;            // OCIDate type
  SQLT_REC = 250;
  SQLT_TAB = 251;
  SQLT_BOL = 252;
  // post 8.1
  // datetimes and intervals
  SQLT_DATE = 184;           // ANSI Date
  SQLT_TIME = 185;           // TIME
  SQLT_TIME_TZ = 186;        // TIME WITH TIME ZONE
  SQLT_TIMESTAMP = 187;      // TIMESTAMP
  SQLT_TIMESTAMP_TZ = 188;   // TIMESTAMP WITH TIME ZONE
  SQLT_INTERVAL_YM = 189;    // INTERVAL YEAR TO MONTH
  SQLT_INTERVAL_DS = 190;    // INTERVAL DAY TO SECOND
  SQLT_TIMESTAMP_LTZ = 232;  // TIMESTAMP WITH LOCAL TZ
  SQLT_PNTY = 241;           // pl/sql representation of named types
  // >= 10
  // binary
  SQLT_IBFLOAT = 100;        // binary float canonical
  SQLT_IBDOUBLE = 101;       // binary double canonical

  // CHAR/NCHAR/VARCHAR2/NVARCHAR2/CLOB/NCLOB char set "form" information
  SQLCS_IMPLICIT = 1;     // for CHAR, VARCHAR2, CLOB w/o a specified set
  SQLCS_NCHAR    = 2;     // for NCHAR, NCHAR VARYING, NCLOB
  SQLCS_EXPLICIT = 3;     // for CHAR, etc, with "CHARACTER SET ..." syntax
  SQLCS_FLEXIBLE = 4;     // for PL/SQL "flexible" parameters
  SQLCS_LIT_NULL = 5;     // for typecheck of NULL and empty_clob() lits

  {----------------------------------------------------------------------------}
  { OCIAP.H                                                                    }
  {----------------------------------------------------------------------------}

type
  TOCIInitialize = function(mode: ub4; ctxp: pointer; malocfp: pointer;
                ralocfp: pointer; mfreefp: pointer): sword; cdecl;
  TOCIEnvInit = function(var envhpp: pOCIEnv; mode: ub4; xtramemsz: TFDsize_t;
               usrmempp: PPointer): sword; cdecl;
  TOCIEnvCreate = function(var envhpp: pOCIEnv; mode: ub4; ctxp: pointer; malocfp: pointer;
               ralocfp: pointer; mfreefp: pointer; xtramemsz: TFDsize_t;
               usrmempp: PPointer): sword; cdecl;
  TOCIEnvNlsCreate = function(var envhpp: pOCIEnv; mode: ub4; ctxp: pointer; malocfp: pointer;
               ralocfp: pointer; mfreefp: pointer; xtramemsz: TFDsize_t;
               usrmempp: PPointer; charset: ub2; ncharset: ub2): sword; cdecl;
  TOCIHandleAlloc = function(parenth: pOCIHandle; var hndlpp: pOCIHandle; atype: ub4;
                 xtramem_sz: TFDsize_t; usrmempp: PPointer): sword; cdecl;
  TOCIServerAttach = function(srvhp: pOCIServer; errhp: pOCIError; dblink: pOCIText;
                dblink_len: sb4; mode: ub4): sword; cdecl;
  TOCIAttrSet = function(trgthndlp: pOCIHandle; trghndltyp: ub4; attributep: pointer;
               size: ub4; attrtype: ub4; errhp: pOCIError): sword; cdecl;
  TOCISessionBegin = function(svchp: pOCISvcCtx; errhp: pOCIError; usrhp: pOCISession;
                credt: ub4; mode: ub4): sword; cdecl;
  TOCISessionEnd = function(svchp: pOCISvcCtx; errhp: pOCIError; usrhp: pOCISession;
                mode: ub4): sword; cdecl;
  TOCIServerDetach = function(srvhp: pOCIServer; errhp: pOCIError;
                mode: ub4): sword; cdecl;
  TOCIHandleFree = function(hndlp: pointer; atype: ub4): sword; cdecl;
  TOCIErrorGet = function(hndlp: pointer; recordno: ub4; sqlstate: pOCIText;
              var errcodep: sb4; bufp: pOCIText; bufsiz: ub4;
              atype: ub4): sword; cdecl;
  TOCIStmtPrepare = function(stmtp: pOCIStmt; errhp: pOCIError; stmt: pOCIText;
                 stmt_len: ub4; language: ub4; mode: ub4): sword; cdecl;
  TOCIStmtPrepare2 = function(svchp: pOCISvcCtx; var stmtp: pOCIStmt; errhp: pOCIError;
                 stmt: pOCIText; stmt_len: ub4; key: pOCIText; key_len: ub4; language: ub4;
                 mode: ub4): sword; cdecl;
  TOCIStmtExecute = function(svchp: pOCISvcCtx; stmtp: pOCIStmt; errhp: pOCIError;
                 iters: ub4; rowoff: ub4; snap_in: pOCISnapshot;
                 snap_out: pOCISnapshot; mode: ub4): sword; cdecl;
  TOCIStmtGetNextResult = function (stmtp: pOCIStmt; errhp: pOCIError;
                        var result: Pointer; var rtype: ub4; mode: ub4): sword; cdecl;
  TOCIParamGet = function(hndlp: pointer; htype: ub4; errhp: pOCIError;
              var parmdpp: pointer; pos: ub4): sword; cdecl;
  TOCIAttrGet = function(trgthndlp: pOCIHandle; trghndltyp: ub4; attributep: pointer;
               sizep: pointer; attrtype: ub4; errhp: pOCIError):sword; cdecl;
  TOCIStmtFetch = function(stmtp: pOCIStmt; errhp: pOCIError; nrows: ub4;
               orientation: ub2; mode: ub4): sword; cdecl;
  TOCIStmtFetch2 = function(stmtp: pOCIStmt; errhp: pOCIError; nrows: ub4;
               orientation: ub2; scrollOffset: ub4; mode: ub4): sword; cdecl;
  TOCIDefineByPos = function(stmtp: pOCIStmt; var defnpp: pOCIDefine;
                 errhp: pOCIError; position: ub4; valuep: pointer;
                 value_sz: sb4; dty: ub2; indp: pointer; rlenp: pUb2;
                 rcodep: pUb2; mode: ub4): sword; cdecl;
  TOCIDefineByPos2 = function(stmtp: pOCIStmt; var defnpp: pOCIDefine;
                 errhp: pOCIError; position: ub4; valuep: pointer;
                 value_sz: sb8; dty: ub2; indp: pointer; rlenp: pUb4;
                 rcodep: pUb2; mode: ub4): sword; cdecl;
  TOCIDefineArrayOfStruct = function(defnpp: pOCIDefine; errhp: pOCIError;
                     pvskip: ub4; indskip: ub4; rlskip: ub4;
                     rcskip: ub4): sword; cdecl;
  TOCIRowidToChar = function (rowidDesc: pOCIRowid; outbfp: pOCIText; var outbflp: ub2;
               errhp: pOCIError): sword; cdecl;
  TOCIBindByPos = function(stmtp: pOCIStmt; var bindpp: pOCIBind; errhp: pOCIError;
               position: ub4; valuep: pointer; value_sz: sb4; dty: ub2;
               indp: pointer; alenp: pUb2; rcodep: pUb2;
               maxarr_len: ub4; curelep: pUb4; mode: ub4): sword; cdecl;
  TOCIBindByPos2 = function(stmtp: pOCIStmt; var bindpp: pOCIBind; errhp: pOCIError;
               position: ub4; valuep: pointer; value_sz: sb8; dty: ub2;
               indp: pointer; alenp: pUb4; rcodep: pUb2;
               maxarr_len: ub4; curelep: pUb4; mode: ub4): sword; cdecl;
  TOCIBindByName = function(stmtp: pOCIStmt; var bindpp: pOCIBind; errhp: pOCIError;
                placeholder: pOCIText; placeh_len: sb4; valuep: pointer;
                value_sz: sb4; dty: ub2; indp: pointer; alenp: pUb2;
                rcodep: pUb2; maxarr_len: ub4; curelep: pUb4;
                mode: ub4): sword; cdecl;
  TOCIBindByName2 = function(stmtp: pOCIStmt; var bindpp: pOCIBind; errhp: pOCIError;
                placeholder: pOCIText; placeh_len: sb4; valuep: pointer;
                value_sz: sb8; dty: ub2; indp: pointer; alenp: pUb4;
                rcodep: pUb2; maxarr_len: ub4; curelep: pUb4;
                mode: ub4): sword; cdecl;
  TOCIInCBFunc = function(ictxp: Pointer; bindp: pOCIBind; iter: ub4; index: ub4;
                var bufpp: Pointer; var alenp: Ub4; var piecep: Ub1; var indp: pSb2): sword; cdecl;
  TOCIOutCBFunc = function(octxp: Pointer; bindp: pOCIBind; iter: ub4; index: ub4;
                var bufpp: Pointer; var alenpp: pUb4; var piecep: ub1; var indpp: pSb2;
                var rcodepp: pUb2): sword; cdecl;
  TOCIBindDynamic = function(bindp: pOCIBind; errhp: pOCIError; ictxp: Pointer;
                 icbfp: TOCIInCBFunc; octxp: Pointer; ocbfp: TOCIOutCBFunc): sword; cdecl;
  TOCITransStart = function(svchp: pOCISvcCtx; errhp: pOCIError; timeout: uword;
                flags: ub4): sword; cdecl;
  TOCITransRollback = function(svchp: pOCISvcCtx; errhp: pOCIError; flags: ub4): sword; cdecl;
  TOCITransCommit = function(svchp: pOCISvcCtx; errhp: pOCIError; flags: ub4): sword; cdecl;
  TOCITransDetach = function(svchp: pOCISvcCtx; errhp: pOCIError; flags: ub4): sword; cdecl;
  TOCITransPrepare = function(svchp: pOCISvcCtx; errhp: pOCIError; flags: ub4): sword; cdecl;
  TOCITransForget = function(svchp: pOCISvcCtx; errhp: pOCIError; flags: ub4): sword; cdecl;
  TOCIDescribeAny = function(svchp: pOCISvcCtx; errhp: pOCIError; objptr: pOCIText;
                 objnm_len: ub4; objptr_typ: ub1; info_level: ub1;
                 objtyp: ub1; dschp: pOCIDescribe): sword; cdecl;
  TOCIBreak = function(svchp: pOCISvcCtx; errhp: pOCIError): sword; cdecl;
  TOCIReset = function(svchp: pOCISvcCtx; errhp: pOCIError): sword; cdecl;
  TOCIDescriptorAlloc = function(parenth: pOCIEnv; var descpp: pOCIDescriptor; htype: ub4;
               xtramem_sz: integer; usrmempp: pointer): sword; cdecl;
  TOCIDescriptorFree = function(descp: pointer; htype: ub4): sword; cdecl;
  TOCILobAppend = function(svchp: pOCISvcCtx; errhp: pOCIError; dst_locp,
               src_locp: pOCILobLocator): sword; cdecl;
  TOCILobAssign = function(envhp: pOCIEnv; errhp: pOCIError;
               src_locp: pOCILobLocator; var dst_locpp: pOCILobLocator): sword; cdecl;
  TOCILobCharSetForm = function (envhp: pOCIEnv; errhp: pOCIError; locp: pOCILobLocator;
               var csfrm: ub1): sword; cdecl;
  TOCILobClose = function(svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator): sword; cdecl;
  TOCILobCopy = function(svchp: pOCISvcCtx; errhp: pOCIError; dst_locp: pOCILobLocator;
               src_locp: pOCILobLocator; amount: ub4; dst_offset: ub4;
               src_offset: ub4): sword; cdecl;
  TOCILobEnableBuffering = function(svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator): sword; cdecl;
  TOCILobDisableBuffering = function(svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator): sword; cdecl;
  TOCILobErase = function(svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator;
               var amount: ub4; offset: ub4): sword; cdecl;
  TOCILobFileExists = function(svchp: pOCISvcCtx; errhp: pOCIError;
               filep: pOCILobLocator; var flag: LongBool): sword; cdecl;
  TOCILobFileGetName = function(envhp: pOCIEnv; errhp: pOCIError; filep: pOCILobLocator;
               dir_alias: pOCIText; var d_length: ub2; filename: pOCIText;
               var f_length: ub2): sword; cdecl;
  TOCILobFileSetName = function(envhp: pOCIEnv; errhp: pOCIError; var filep: pOCILobLocator;
               dir_alias: pOCIText; d_length: ub2; filename: pOCIText;
               f_length: ub2): sword; cdecl;
  TOCILobFlushBuffer = function(svchp: pOCISvcCtx; errhp: pOCIError;
               locp: pOCILobLocator; flag: ub4): sword; cdecl;
  TOCILobGetLength = function (svchp: pOCISvcCtx; errhp: pOCIError;
               locp: pOCILobLocator; var lenp: ub4): sword; cdecl;
  TOCILobIsOpen = function(svchp: pOCISvcCtx; errhp: pOCIError;
               locp: pOCILobLocator; var flag: LongBool): sword; cdecl;
  TOCILobLoadFromFile = function (svchp: pOCISvcCtx; errhp: pOCIError;
               dst_locp: pOCILobLocator; src_locp: pOCILobLocator;
               amount: ub4; dst_offset: ub4; src_offset: ub4): sword; cdecl;
  TOCILobLocatorIsInit = function (envhp: pOCIEnv; errhp: pOCIError;
               locp: pOCILobLocator; var is_initialized: LongBool): sword; cdecl;
  TOCILobOpen = function (svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator;
               mode: ub1): sword; cdecl;
  TOCILobRead = function (svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator;
              var amtp: ub4; offset: ub4; bufp: Pointer; bufl: ub4;
              ctxp: Pointer; cbfp: Pointer; csid: ub2; csfrm: ub1): sword; cdecl;
  TOCILobTrim = function (svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator;
              newlen: ub4): sword; cdecl;
  TOCILobWrite = function(svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator;
              var amtp: ub4; offset: ub4; bufp: pointer; bufl: ub4;
              piece: ub1; ctxp: pointer; cbfp: pointer;
              csid: ub2; csfrm: ub1): sword; cdecl;
  TOCILobCreateTemporary = function(svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator;
              csid: ub2; csfrm: ub1; lobtype: ub1; cache: LongBool; duration: OCIDuration): sword; cdecl;
  TOCILobFreeTemporary = function(svchp: pOCISvcCtx; errhp: pOCIError; locp: pOCILobLocator): sword; cdecl;
  TOCILobIsTemporary = function(envhp: pOCIEnv; errhp: pOCIError; locp: pOCILobLocator;
              var is_temporary: LongBool): sword; cdecl;
  TOCIStmtGetPieceInfo = function(stmtp: pOCIStmt; errhp: pOCIError; var hndlpp: pointer;
                  var typep: ub4; var in_outp: ub1; var iterp: ub4;
                  var idxp: ub4; var piecep: ub1): sword; cdecl;
  TOCIStmtSetPieceInfo = function(handle: pointer; typep: ub4; errhp: pOCIError;
                  buf: pointer; var alenp: ub4; piece: ub1;
                  indp: pointer; var rcodep: ub2): sword; cdecl;
  TOCIPasswordChange = function(svchp: pOCISvcCtx; errhp: pOCIError; user_name: pOCIText;
                  usernm_len: ub4; opasswd: pOCIText; opasswd_len: ub4;
                  npasswd: pOCIText; npasswd_len: sb4; mode: ub4): sword; cdecl;
  TOCIServerVersion = function(hndlp: pOCIHandle; errhp: pOCIError; bufp: pOCIText;
                 bufsz: ub4; hndltype: ub1): sword; cdecl;
  TOCIResultSetToStmt = function(rsetdp: pOCIHandle; errhp: pOCIError): sword; cdecl;
  TOCIDirPathAbort = function(dpctx: pOCIDirPathCtx; errhp: pOCIError): sword; cdecl;
  TOCIDirPathDataSave = function(dpctx: pOCIDirPathCtx; errhp: pOCIError; action: ub4): sword; cdecl;
  TOCIDirPathFinish = function(dpctx: pOCIDirPathCtx; errhp: pOCIError): sword; cdecl;
  TOCIDirPathFlushRow = function(dpctx: pOCIDirPathCtx; errhp: pOCIError): sword; cdecl;
  TOCIDirPathPrepare = function(dpctx: pOCIDirPathCtx; svchp: pOCISvcCtx; errhp: pOCIError): sword; cdecl;
  TOCIDirPathLoadStream = function(dpctx: pOCIDirPathCtx; dpstr: pOCIDirPathStream;
             errhp: pOCIError): sword; cdecl;
  TOCIDirPathColArrayEntryGet = function(dpca: pOCIDirPathColArray; errhp: pOCIError;
                 rownum: ub4; colIdx: ub2; var cvalpp: pUb1; var clenp: ub4;
                 var cflgp: ub1): sword; cdecl;
  TOCIDirPathColArrayEntrySet = function(dpca: pOCIDirPathColArray; errhp: pOCIError;
                 rownum: ub4; colIdx: ub2; cvalp: pUb1; clen: ub4;
                 cflg: ub1): sword; cdecl;
  TOCIDirPathColArrayRowGet = function(dpca: pOCIDirPathColArray; errhp: pOCIError;
               rownum: ub4; var cvalppp: ppUb1; var clenpp: pUb4;
               var cflgpp: pUb1): sword; cdecl;
  TOCIDirPathColArrayReset = function(dpca: pOCIDirPathColArray; errhp: pOCIError): sword; cdecl;
  TOCIDirPathColArrayToStream = function(dpca: pOCIDirPathColArray; dpctx: pOCIDirPathCtx;
                 dpstr: pOCIDirPathStream; errhp: pOCIError;
                 rowcnt: ub4; rowoff: ub4): sword; cdecl;
  TOCIDirPathStreamReset = function(dpstr: pOCIDirPathStream; errhp: pOCIError): sword; cdecl;
  TOCIDirPathStreamToStream = function(istr: pOCIDirPathStream; ostr: pOCIDirPathStream;
               dpctx: pOCIDirPathCtx; errhp: pOCIError;
               isoff: ub4; osoff: ub4): sword; cdecl;
  TOCILogon = function(envhp: pOCIEnv; errhp: pOCIError; var svchp: pOCISvcCtx;
           username: pOCIText; uname_len: ub4; password: pOCIText; passwd_len: ub4;
           dbname: pOCIText; dbname_len: ub4): sword; cdecl;
  TOCILogon2 = function(envhp: pOCIEnv; errhp: pOCIError; var svchp: pOCISvcCtx;
           username: pOCIText; uname_len: ub4; password: pOCIText; passwd_len: ub4;
           dbname: pOCIText; dbname_len: ub4; mode: ub4): sword; cdecl;
  TOCILogoff = function(svchp: pOCISvcCtx; errhp: pOCIError): sword; cdecl;
  TOCIDateTimeGetDate = function(envhp: pOCIEnv; errhp: pOCIError; datetime: pOCIDateTime;
           var year: sb2; var month: ub1; var day: ub1): sword; cdecl;
  TOCIDateTimeGetTime =  function(envhp: pOCIEnv; errhp: pOCIError; datetime: pOCIDateTime;
           var hour: ub1; var min: ub1; var sec: ub1; var fsec: ub4): sword; cdecl;
  TOCIDateTimeConstruct = function(envhp: pOCIEnv; errhp: pOCIError; datetime: pOCIDateTime;
           year: sb2; month: ub1; day: ub1; hour: ub1; min: ub1; sec: ub1; fsec: ub4;
           timezone: pOCIText; timezone_length: ub4): sword; cdecl;
  TOCIDateTimeGetTimeZoneOffset = function(envhp: pOCIEnv; errhp: pOCIError;
           datetime: pOCIDateTime; var hour: sb1; var minute: sb1): sword; cdecl;
  TOCIDateTimeAssign = function(envhp: pOCIEnv; err: pOCIError;
           from: pOCIDateTime; to_: pOCIDateTime): sword; cdecl;
  TOCIPing = function(svchp: pOCISvcCtx; errhp: pOCIError; mode: ub4): sword; cdecl;
  TOCINlsCharSetNameToId = function(envhp: pOCIEnv; name: pOCIText): ub2; cdecl;
  TOCINlsCharSetIdToName = function(envhp: pOCIEnv; buf: pOCIText; buflen: TFDsize_t;
           id: ub2): sword; cdecl;
  TOCINlsEnvironmentVariableGet = function(valp: Pointer; size: TFDsize_t; item: ub2;
           charset: ub2; var rsize: TFDsize_t): sword; cdecl;
  TOCIClientVersion = function(var major_version, minor_version, update_num,
           patch_num, port_update_num: sword): sword; cdecl;
  TOCIIntervalAssign = function(envhp: pOCIEnv; err: pOCIError;
           from: pOCIInterval; to_: pOCIInterval): sword; cdecl;
  TOCIIntervalCheck = function (envhp: pOCIEnv; err: pOCIError;
           interval: pOCIInterval; var valid: ub4): sword; cdecl;
  TOCIIntervalSetYearMonth = function (envhp: pOCIEnv; err: pOCIError; yr, mnth: sb4;
           result: pOCIInterval): sword; cdecl;
  TOCIIntervalGetYearMonth = function (envhp: pOCIEnv; err: pOCIError; out yr, mnth: sb4;
           result: pOCIInterval): sword; cdecl;
  TOCIIntervalSetDaySecond = function (envhp: pOCIEnv; err: pOCIError; dy, hr,
           mm, ss, fsec: sb4; result: pOCIInterval): sword; cdecl;
  TOCIIntervalGetDaySecond = function (envhp: pOCIEnv; err: pOCIError; out dy, hr,
           mm, ss, fsec: sb4; result: pOCIInterval): sword; cdecl;
  TOCIDBStartup = function (svchp: pOCISvcCtx; errhp: pOCIError; admhp: pOCIAdmin;
           mode: ub4; flags: ub4): sword; cdecl;
  TOCIDBShutdown = function (svchp: pOCISvcCtx; errhp: pOCIError; admhp: pOCIAdmin;
           mode: ub4): sword; cdecl;
  TOCISubscriptionRegister = function (svchp: pOCISvcCtx; subscrhpp: ppOCIHandle;
           count: ub2; errhp: pOCIError; mode: ub4): sword; cdecl;
  TOCISubscriptionPost = function (svchp: pOCISvcCtx; subscrhpp: ppOCIHandle;
           count: ub2; errhp: pOCIError; mode: ub4): sword; cdecl;
  TOCISubscriptionUnRegister = function (svchp: pOCISvcCtx; subscrhp: pOCISubscription;
           errhp: pOCIError; mode: ub4): sword; cdecl;
  TOCISubscriptionDisable = function (subscrhp: pOCISubscription;
           errhp: pOCIError; mode: ub4): sword; cdecl;
  TOCISubscriptionEnable = function (subscrhp: pOCISubscription;
           errhp: pOCIError; mode: ub4): sword; cdecl;

  {----------------------------------------------------------------------------}
  { ORL.H                                                                      }
  {----------------------------------------------------------------------------}

  TOCINumberToText = function(errhp: pOCIError; number: pOCINumber;
           fmt: pOCIText; fmt_length: ub4; nls_params: pOCIText; nls_p_length: ub4;
           var buf_size: ub4; buf: pOCIText): sword; cdecl;

  TOCICollSize = function (envhp: pOCIEnv; err: pOCIError; coll: pOCIColl;
    var size: sb4): sword; cdecl;
  TOCICollMax = function (env: pOCIEnv; coll: pOCIColl): sb4; cdecl;
  TOCICollGetElem = function (envhp: pOCIEnv; err: pOCIError; coll: pOCIColl;
    index: sb4; var exists: LongBool; var elem: Pointer; var elemind: Pointer): sword; cdecl;
  TOCICollAssignElem = function (envhp: pOCIEnv; err: pOCIError; index: sb4;
    elem: Pointer; elemind: Pointer; coll: pOCIColl): sword; cdecl;
  TOCICollAssign = function (envhp: pOCIEnv; err: pOCIError; rhs, lhs: pOCIColl): sword; cdecl;
  TOCICollAppend = function (envhp: pOCIEnv; err: pOCIError;
    elem: Pointer; elemind: Pointer; coll: pOCIColl): sword; cdecl;
  TOCICollTrim = function (envhp: pOCIEnv; err: pOCIError; trim_num: sb4;
    coll: pOCIColl): sword; cdecl;
  TOCICollIsLocator = function (envhp: pOCIEnv; err: pOCIError; coll: pOCIColl;
    var result: LongBool): sword; cdecl;

  TOCIIterCreate = function (envhp: pOCIEnv; err: pOCIError; coll: pOCIColl;
    var itr: pOCIIter): sword; cdecl;
  TOCIIterDelete = function (envhp: pOCIEnv; err: pOCIError; var itr: pOCIIter): sword; cdecl;
  TOCIIterInit = function (envhp: pOCIEnv; err: pOCIError; coll: pOCIColl;
    itr: pOCIIter): sword; cdecl;
  TOCIIterGetCurrent = function (envhp: pOCIEnv; err: pOCIError; itr: pOCIIter;
    var elem: Pointer; var elemind: Pointer): sword; cdecl;
  TOCIIterNext = function (envhp: pOCIEnv; err: pOCIError; itr: pOCIIter;
    var elem: Pointer; var elemind: Pointer; var eoc: LongBool): sword; cdecl;
  TOCIIterPrev = function (envhp: pOCIEnv; err: pOCIError; itr: pOCIIter;
    var elem: Pointer; var elemind: Pointer; var boc: LongBool): sword; cdecl;

implementation

end.

