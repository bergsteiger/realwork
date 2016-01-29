{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{             Native Plain Drivers for Oracle             }
{                                                         }
{        Originally written by Sergey Seroukhov           }
{                                                         }
{*********************************************************}

{@********************************************************}
{    Copyright (c) 1999-2012 Zeos Development Group       }
{                                                         }
{ License Agreement:                                      }
{                                                         }
{ This library is distributed in the hope that it will be }
{ useful, but WITHOUT ANY WARRANTY; without even the      }
{ implied warranty of MERCHANTABILITY or FITNESS FOR      }
{ A PARTICULAR PURPOSE.  See the GNU Lesser General       }
{ Public License for more details.                        }
{                                                         }
{ The source code of the ZEOS Libraries and packages are  }
{ distributed under the Library GNU General Public        }
{ License (see the file COPYING / COPYING.ZEOS)           }
{ with the following  modification:                       }
{ As a special exception, the copyright holders of this   }
{ library give you permission to link this library with   }
{ independent modules to produce an executable,           }
{ regardless of the license terms of these independent    }
{ modules, and to copy and distribute the resulting       }
{ executable under terms of your choice, provided that    }
{ you also meet, for each linked independent module,      }
{ the terms and conditions of the license of that module. }
{ An independent module is a module which is not derived  }
{ from or based on this library. If you modify this       }
{ library, you may extend this exception to your version  }
{ of the library, but you are not obligated to do so.     }
{ If you do not wish to do so, delete this exception      }
{ statement from your version.                            }
{                                                         }
{                                                         }
{ The project web site is located on:                     }
{   http://zeos.firmos.at  (FORUM)                        }
{   http://sourceforge.net/p/zeoslib/tickets/ (BUGTRACKER)}
{   svn://svn.code.sf.net/p/zeoslib/code-0/trunk (SVN)    }
{                                                         }
{   http://www.sourceforge.net/projects/zeoslib.          }
{                                                         }
{                                                         }
{                                 Zeos Development Group. }
{********************************************************@}

unit ZPlainOracleDriver;

interface

{$I ZPlain.inc}

{$J+}

uses
{$IFNDEF UNIX}
//  Windows,
{$ENDIF}
  ZPlainLoader, ZCompatibility, ZPlainOracleConstants, ZPlainDriver;

{***************** Plain API types definition ****************}

const
  WINDOWS_DLL_LOCATION = 'oci.dll';
//  WINDOWS_DLL_LOCATION = 'ora803.dll';
  LINUX_DLL_LOCATION = 'libclntsh'+SharedSuffix;
//  LINUX_DLL_LOCATION = 'libwtc8.so';

type

  {** Represents a generic interface to Oracle native API. }
  IZOraclePlainDriver = interface (IZPlainDriver)
    ['{22404660-C95F-4346-A3DB-7C6DFE15F115}']

    function Initializ(mode: ub4; ctxp: Pointer; malocfp: Pointer;
      ralocfp: Pointer; mfreefp: Pointer): sword;
    function EnvInit(var envhpp: POCIEnv; mode: ub4; xtramemsz: size_T;
      usrmempp: PPointer): sword;
    function EnvCreate(var envhpp: POCIEnv; mode: ub4; ctxp: Pointer;
      malocfp: Pointer; ralocfp: Pointer; mfreefp: Pointer; xtramemsz: size_T;
      usrmempp: PPointer): sword;
    function EnvNlsCreate(var envhpp: POCIEnv; mode: ub4; ctxp: Pointer;
      malocfp: Pointer; ralocfp: Pointer; mfreefp: Pointer; xtramemsz: size_T;
      usrmempp: PPointer; charset, ncharset: ub2): sword;

    function HandleAlloc(parenth: POCIHandle; var hndlpp: POCIHandle;
      atype: ub4; xtramem_sz: size_T; usrmempp: PPointer): sword;
    function ServerAttach(srvhp: POCIServer; errhp: POCIError; dblink: text;
      dblink_len: sb4; mode: ub4): sword;
    function AttrSet(trgthndlp: POCIHandle; trghndltyp: ub4;
      attributep: Pointer; size: ub4; attrtype: ub4; errhp: POCIError):sword;
    function SessionBegin(svchp: POCISvcCtx; errhp: POCIError;
      usrhp: POCISession; credt: ub4; mode: ub4):sword;
    function SessionEnd(svchp: POCISvcCtx; errhp: POCIError;
      usrhp: POCISession; mode: ub4): sword;
    function ServerDetach(srvhp: POCIServer; errhp: POCIError;
      mode: ub4): sword;
    function HandleFree(hndlp: Pointer; atype: ub4): sword;
    function ErrorGet(hndlp: Pointer; recordno: ub4; sqlstate: text;
      var errcodep: sb4; bufp: text; bufsiz: ub4; atype: ub4): sword;

    function StmtPrepare(stmtp: POCIStmt; errhp: POCIError; stmt: text;
      stmt_len: ub4; language:ub4; mode: ub4):sword;
    function StmtExecute(svchp: POCISvcCtx; stmtp: POCIStmt;
      errhp: POCIError; iters: ub4; rowoff: ub4; snap_in: POCISnapshot;
      snap_out: POCISnapshot; mode: ub4): sword;
    function ParamGet(hndlp: Pointer; htype: ub4; errhp: POCIError;
      var parmdpp: Pointer; pos: ub4): sword;
    function AttrGet(trgthndlp: POCIHandle; trghndltyp: ub4;
      attributep: Pointer; sizep: Pointer; attrtype: ub4;
      errhp: POCIError): sword;
    function StmtFetch(stmtp: POCIStmt; errhp: POCIError; nrows: ub4;
      orientation: ub2; mode: ub4): sword;
    function DefineByPos(stmtp: POCIStmt; var defnpp: POCIDefine;
      errhp: POCIError; position: ub4; valuep: Pointer; value_sz: sb4; dty: ub2;
      indp: Pointer; rlenp: Pointer; rcodep: Pointer; mode: ub4): sword;
    function DefineArrayOfStruct(defnpp: POCIDefine; errhp: POCIError;
      pvskip: ub4; indskip: ub4; rlskip: ub4; rcskip: ub4): sword;

    function BindByPos(stmtp: POCIStmt; var bindpp: POCIBind;
      errhp: POCIError; position: ub4; valuep: Pointer; value_sz: sb4; dty: ub2;
      indp: Pointer; alenp: Pointer; rcodep: Pointer; maxarr_len: ub4;
      curelep: Pointer; mode: ub4): sword;
    function BindByName(stmtp: POCIStmt; var bindpp: POCIBind;
      errhp: POCIError; placeholder: text; placeh_len: sb4; valuep: Pointer;
      value_sz: sb4; dty: ub2; indp: Pointer; alenp: Pointer; rcodep: Pointer;
      maxarr_len: ub4; curelep: Pointer; mode: ub4): sword;
    function BindDynamic(bindp: POCIBind; errhp: POCIError; ictxp: Pointer;
    icbfp: Pointer; octxp: Pointer; ocbfp: Pointer): sword;
    function BindObject(bindp: POCIBind; errhp: POCIError;
                    const _type: POCIType; pgvpp: PPointer;
                    pvszsp: pub4; indpp: PPointer;
                    indszp: pub4): sword;

    function DefineObject(defnpp: POCIDefine; errhp: POCIError;
      _type: POCIHandle; pgvpp, pvszsp, indpp, indszp: pointer): sword;

    { > ori.h}
    function ObjectNew(env: POCIEnv; err: POCIError; const svc: POCISvcCtx;
                       typecode: OCITypeCode; tdo: POCIType; table: Pointer;
                       duration: OCIDuration; value: Longbool;
                       instance: PPointer): sword;
    function ObjectPin(env: POCIEnv; err: POCIError;
      const object_ref: POCIRef; const corhdl: POCIComplexObject;
      const pin_option: OCIPinOpt; const pin_duration: OCIDuration;
      const lock_option: OCILockOpt; _object: PPointer): sword;
    function ObjectUnpin(env: POCIEnv; err: POCIError;
      const _object: Pointer): sword;
    function ObjectPinCountReset(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectLock(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectLockNoWait(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectMarkUpdate(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectUnmark(env: POCIEnv; err: POCIError;
      const _object:pointer): sword;
    function ObjectUnmarkByRef(env: POCIEnv; err: POCIError;
      const ref: POCIRef): sword;
    function ObjectFree(hndl: POCIEnv; err: POCIError;
      instance: POCIHandle;flags :ub2):sword;
    function ObjectMarkDeleteByRef(env: POCIEnv; err: POCIError;
      const object_ref:POCIRef): sword;
    function ObjectMarkDelete(env: POCIEnv; err: POCIError;
      const instance:pointer): sword;
    function ObjectFlush(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectRefresh(env: POCIEnv; err: POCIError;
      _object: pointer): sword;
    function ObjectCopy(env: POCIEnv; err: POCIError; const svc: POCISvcCtx;
      const source, null_source, target, null_target: pointer; const tdo: POCIType;
      const duration: OCIDuration; const option: ub1): sword;
    function ObjectGetTypeRef(env: POCIEnv; err: POCIError;
      const instance:pointer; type_ref: POCIRef): sword;
    function ObjectGetObjectRef(env: POCIEnv; err: POCIError;
      const _object: pointer; object_ref: POCIRef): sword;
    function ObjectMakeObjectRef(env: POCIEnv; err: POCIError;
      const svc: POCISvcCtx; const table: pointer; const values: PPointer;
      const array_len: ub4; object_ref: POCIRef): sword;
    function ObjectGetPrimaryKeyTypeRef(env: POCIEnv; err: POCIError;
      const svc:POCISvcCtx; const table: pointer; type_ref: POCIRef): sword;
    function ObjectGetInd(env: POCIEnv; err: POCIError;
      const instance: pointer; null_struct: PPointer): sword;
    function ObjectExists(env: POCIEnv; err: POCIError; const ins: pointer;
      exist: PBoolean): sword;
    function ObjectGetProperty(envh: POCIEnv; errh: POCIError;
      const obj: pointer; const propertyId: OCIObjectPropId;
      _property: pointer; size: Pub4): sword;
    function ObjectIsLocked(env: POCIEnv; err: POCIError; const ins: pointer;
      lock: Pboolean): sword;
    function ObjectIsDirty(env: POCIEnv; err: POCIError; const ins: pointer;
      dirty: PBoolean): sword;
    function ObjectPinTable(env: POCIEnv; err: POCIError;
      const svc:POCISvcCtx; const schema_name: Poratext; const s_n_length: ub4;
      const object_name: Poratext; const o_n_length:ub4;
      const scope_obj_ref: POCIRef; const pin_duration: OCIDuration;
      _object: PPointer): sword;
    function ObjectArrayPin(env: POCIEnv; err: POCIError;
      const ref_array: PPOCIRef; const array_size: ub4;
      const cor_array: PPOCIComplexObject; const cor_array_size: ub4;
      const pin_option: OCIPinOpt; const pin_duration: OCIDuration;
      const lock: OCILockOpt; obj_array: PPointer;
      pos: Pub4): sword;
    function CacheFlush(env: POCIEnv; err: POCIError; const svc:POCISvcCtx;
      const context: pointer; const get: TOCICacheFlushGet;
      ref: PPOCIRef): sword;
    function CacheRefresh(env: POCIEnv; err: POCIError;
      const svc:POCISvcCtx; const option: OCIRefreshOpt; const context: pointer;
      get: TOCICacheRefreshGet; ref: PPOCIRef): sword;
    function CacheUnpin(env: POCIEnv; err: POCIError;
      const svc:POCISvcCtx): sword;
    function CacheFree(env: POCIEnv; err: POCIError;
      const svc: POCISvcCtx): sword;
    function CacheUnmark(env: POCIEnv; err: POCIError;
      const svc: POCISvcCtx): sword;
    function DurationBegin(env: POCIEnv; err: POCIError;
      svc: POCISvcCtx; const parent: OCIDuration;
      dur: POCIDuration): sword;
    function DurationEnd(env: POCIEnv; err: POCIError; svc: POCISvcCtx;
      duration: OCIDuration): sword;
    { < ori.h}

    function TransStart(svchp: POCISvcCtx; errhp: POCIError; timeout: word;
      flags: ub4): sword;
    function TransRollback(svchp: POCISvcCtx; errhp: POCIError;
      flags: ub4): sword;
    function TransCommit(svchp: POCISvcCtx; errhp: POCIError;
      flags: ub4): sword;
    function TransDetach(svchp: POCISvcCtx; errhp: POCIError;
      flags: ub4): sword;
    function TransPrepare(svchp: POCISvcCtx; errhp: POCIError;
      flags: ub4): sword;
    function TransForget(svchp: POCISvcCtx; errhp: POCIError;
      flags: ub4): sword;

    function DescribeAny(svchp: POCISvcCtx; errhp: POCIError;
      objptr: Pointer; objnm_len: ub4; objptr_typ: ub1; info_level: ub1;
      objtyp: ub1; dschp: POCIDescribe): sword;
    function Break(svchp: POCISvcCtx; errhp:POCIError): sword;
    function Reset(svchp: POCISvcCtx; errhp:POCIError): sword;
    function DescriptorAlloc(parenth: POCIEnv; var descpp: POCIDescriptor;
      htype: ub4; xtramem_sz: integer; usrmempp: Pointer): sword;
    function DescriptorFree(descp: Pointer; htype: ub4): sword;

    function DateTimeAssign(hndl: POCIEnv; err: POCIError;
      const from: POCIDateTime;_to: POCIDateTime): sword;
    function DateTimeCheck(hndl: POCIEnv; err: POCIError;
      const date: POCIDateTime; var valid: ub4): sword;
    function DateTimeCompare(hndl: POCIEnv; err: POCIError;
      const date1: POCIDateTime; const date2: POCIDateTime;
      var result: sword): sword;
    function DateTimeConvert(hndl: POCIEnv; err: POCIError;
      indate: POCIDateTime; outdate: POCIDateTime): sword;
    function DateTimeFromText(hndl: POCIEnv; err: POCIError;
      const date_str: text; d_str_length: size_t; const fmt: text;
      fmt_length: ub1; const lang_name: text; lang_length: size_t;
      date: POCIDateTime): sword;
    function DateTimeGetDate(hndl: POCIEnv; err: POCIError;
      const date: POCIDateTime; var year: sb2; var month: ub1;
      var day: ub1): sword;
    function DateTimeGetTime(hndl: POCIEnv; err: POCIError;
      datetime: POCIDateTime; var hour: ub1; var minute: ub1; var sec: ub1;
      var fsec: ub4): sword;
    function DateTimeGetTimeZoneOffset(hndl: POCIEnv; err: POCIError;
      const datetime: POCIDateTime; var hour: sb1; var minute: sb1): sword;
    function DateTimeSysTimeStamp(hndl: POCIEnv; err: POCIError;
      sys_date: POCIDateTime): sword;
    function DateTimeConstruct(hndl: POCIEnv; err: POCIError;
      datetime: POCIDateTime; year: sb2; month: ub1; day: ub1; hour: ub1;
      min: ub1; sec: ub1; fsec: ub4; timezone: text;
      timezone_length: size_t): sword;
    function DateTimeToText(hndl: POCIEnv; err: POCIError;
      const date: POCIDateTime; const fmt: text; fmt_length: ub1;
      fsprec: ub1; const lang_name: text; lang_length: size_t;
      var buf_size: ub4; buf: text): sword;
    function DateTimeGetTimeZoneName(hndl: POCIEnv; err: POCIError;
      datetime: POCIDateTime; var buf: ub1; var buflen: ub4): sword;

    function LobAppend(svchp: POCISvcCtx; errhp: POCIError; dst_locp,
      src_locp: POCILobLocator): sword;
    function LobAssign(svchp: POCISvcCtx; errhp: POCIError;
      src_locp: POCILobLocator; var dst_locpp: POCILobLocator): sword;
    function LobClose(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator): sword;
    function LobCopy(svchp: POCISvcCtx; errhp: POCIError;
      dst_locp: POCILobLocator; src_locp: POCILobLocator; amount: ub4;
      dst_offset: ub4; src_offset: ub4): sword;
    function LobEnableBuffering(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator): sword;
    function LobDisableBuffering(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator): sword;
    function LobErase(svchp: POCISvcCtx; errhp: POCIError; locp: POCILobLocator;
      var amount: ub4; offset: ub4): sword;
    function LobFileExists(svchp: POCISvcCtx; errhp: POCIError;
      filep: POCILobLocator; var flag: Boolean): sword;
    function LobFileGetName(envhp: POCIEnv; errhp: POCIError;
      filep: POCILobLocator; dir_alias: text; var d_length: ub2; filename: text;
      var f_length: ub2): sword;
    function LobFileSetName(envhp: POCIEnv; errhp: POCIError;
      var filep: POCILobLocator; dir_alias: text; d_length: ub2; filename: text;
      f_length: ub2): sword;
    function LobFlushBuffer(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; flag: ub4): sword;
    function LobGetLength(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var lenp: ub4): sword;
    function LobIsOpen(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var flag: LongBool): sword;
    function LobLoadFromFile(svchp: POCISvcCtx; errhp: POCIError;
      dst_locp: POCILobLocator; src_locp: POCILobLocator; amount: ub4;
      dst_offset: ub4; src_offset: ub4): sword;
    function LobLocatorIsInit(envhp: POCIEnv; errhp: POCIError;
     locp: POCILobLocator; var is_initialized: LongBool): sword;
    function LobOpen(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; mode: ub1): sword;
    function LobRead(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var amtp: ub4; offset: ub4; bufp: Pointer; bufl: ub4;
      ctxp: Pointer; cbfp: Pointer; csid: ub2; csfrm: ub1): sword;
    function LobTrim(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; newlen: ub4): sword;
    function LobWrite(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var amtp: ub4; offset: ub4; bufp: Pointer; bufl: ub4;
      piece: ub1; ctxp: Pointer; cbfp: Pointer; csid: ub2; csfrm: ub1): sword;
    function LobCreateTemporary(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; csid: ub2; csfrm: ub1; lobtype: ub1;
      cache: LongBool; duration: OCIDuration): sword;
    function LobIsTemporary(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var is_temporary: LongBool): sword;
    function LobFreeTemporary(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator): sword;
    function LobCharSetForm ( envhp: POCIEnv; errhp: POCIError;
        const locp: POCILobLocator; csfrm: pub1): sword;
    function LobCharSetId ( envhp: POCIEnv; errhp: POCIError;
        const locp: POCILobLocator; csid: pub2): sword;

    function StmtGetPieceInfo(stmtp: POCIStmt; errhp: POCIError;
      var hndlpp: Pointer; var typep: ub4; var in_outp: ub1; var iterp: ub4;
      var idxp: ub4; var piecep: ub1): sword;
    function StmtSetPieceInfo(handle: Pointer; typep: ub4; errhp: POCIError;
      buf: Pointer; var alenp: ub4; piece: ub1; indp: Pointer;
      var rcodep: ub2): sword;
    function PasswordChange(svchp: POCISvcCtx; errhp: POCIError;
      user_name: text; usernm_len: ub4; opasswd: text; opasswd_len: ub4;
      npasswd: text; npasswd_len: sb4; mode: ub4): sword;
    function ServerVersion(hndlp: POCIHandle; errhp: POCIError; bufp: text;
      bufsz: ub4; hndltype: ub1): sword;
    function ServerRelease(hndlp: POCIHandle;
      errhp: POCIError; bufp: text; bufsz: ub4; hndltype: ub1; version:pointer): sword;
    function ResultSetToStmt(rsetdp: POCIHandle; errhp: POCIError): sword;

    function GetEnvCharsetByteWidth(hndl: POCIEnv; err: POCIError;
      Value: sb4): sword;
    procedure ClientVersion(major_version, minor_version, update_num,
      patch_num, port_update_num: psword);

    function NumberInc(err: POCIError; number: POCINumber): sword;
    function NumberDec(err: POCIError; number: POCINumber): sword;
    procedure NumberSetZero(err: POCIError; number: POCINumber);
    procedure NumberSetPi(err: POCIError; number: POCINumber);
    function  NumberAdd(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberSub(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberMul(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberDiv(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberMod(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberIntPower(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberShift(err: POCIError; const number: POCINumber;
      const nDig: sword; _result: POCINumber): sword;
    function NumberNeg(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberToText(err: POCIError; const number: POCINumber;
      const fmt: Poratext; fmt_length: ub4; const nls_params: Poratext;
      nls_p_length: ub4; buf_size: pub4; buf: poratext): sword;
    function NumberFromText(err: POCIError; const str: poratext;
      str_length: ub4; const fmt: poratext; fmt_length: ub4;
      const nls_params: poratext; nls_p_length: ub4; number: POCINumber): sword;
    function NumberToInt(err: POCIError; const number: POCINumber;
      rsl_length: uword; rsl_flag: uword; rsl: Pointer): sword;
    function NumberFromInt(err: POCIError; const inum: Pointer;
      inum_length: uword; inum_s_flag: uword; number: POCINumber): sword;
    function NumberToReal(err: POCIError; const number: POCINumber;
      rsl_length: uword; rsl: Pointer): sword;
    function NumberToRealArray(err: POCIError; const number: PPOCINumber;
      elems: uword; rsl_length: uword; rsl: Pointer): sword;
    function NumberFromReal(err: POCIError; const rnum: Pointer;
      rnum_length: uword; number: POCINumber): sword;
    function NumberCmp(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: psword): sword;
    function NumberSign(err: POCIError; const number: POCINumber;
      _result: psword): sword;
    function NumberIsZero(err: POCIError; const number: POCINumber;
      _Result: pboolean): sword;
    function NumberIsInt(err: POCIError; const number: POCINumber;
      _result: Pboolean): sword;
    function NumberAssign(err: POCIError; const from: POCINumber;
      _to: POCINumber): sword;
    function NumberAbs(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberCeil(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberFloor(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberSqrt(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberTrunc(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberPower(err: POCIError; const base: POCINumber;
      const number: POCINumber; _result: POCINumber): sword;
    function NumberRound(err: POCIError; const number: POCINumber;
      decplace: sword; _result: POCINumber): sword;
    function NumberPrec(err: POCIError; const number: POCINumber;
      nDigs: sword; _result: POCINumber): sword;
    function NumberSin(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberArcSin(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberHypSin(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberCos(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberArcCos(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberHypCos(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberTan(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberArcTan(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberArcTan2(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberHypTan(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberExp(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberLn(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberLog(err: POCIError; const base: POCINumber;
      const number: POCINumber; _result: POCINumber): sword;

    function TableSize(hndl: POCIEnv; err: POCIError; const tbl: POCITable;
                    size: psb4): sword;
    function TableExists(hndl: POCIEnv; err: POCIError; const tbl: POCITable;
                             index: sb4; exists: PBoolean): sword;
    function TableDelete(hndl: POCIEnv; err: POCIError; index: sb4;
                      tbl: POCITable): sword;
    function TableFirst(hndl: POCIEnv; err: POCIError; const tbl: POCITable;
                             index: sb4): sword;
    function TableLast(hndl: POCIEnv; err: POCIError; const tbl: POCITable;
                             index: sb4): sword;
    function TableNext(hndl: POCIEnv; err: POCIError; index: sb4;
      const tbl: POCITable; next_index: psb4; exists: PBoolean): sword;
    function TablePrev(hndl: POCIEnv; err: POCIError; index: sb4;
      const tbl: POCITable; prev_index: psb4; exists: PBoolean): sword;
    function ObjectSetAttr(env: POCIEnv; err: POCIError; instance: Pointer;
                  null_struct: pointer; tdo: POCIType; const names: PPAnsiChar;
                  const lengths: pub4; const name_count: ub4;
                  const indexes: pub4; const index_count: ub4;
                  const null_status: POCIInd; const attr_null_struct: Pointer;
                  const attr_value: Pointer): sword; cdecl;
    function ObjectGetAttr(env: POCIEnv; err: POCIError; instance: Pointer;
                  null_struct: Pointer; tdo: POCIType;
                  const names: PPoratext; const lengths: pub4;
                  const name_count: ub4; const indexes: pub4;
                  const index_count: ub4; attr_null_status: POCIInd;
                  attr_null_struct, attr_value: PPointer;
                  attr_tdo: PPOCIType): sword;
    {ociap.h}
    function Ping(svchp: POCISvcCtx; errhp: POCIError; mode: ub4 = OCI_DEFAULT): sword;
    {ort.h}
    function TypeIterNew(env: POCIEnv; err: POCIError; const tdo: POCIType;
                      iterator_ort: PPOCITypeIter):sword;
    function TypeIterSet(env: POCIEnv; err: POCIError; const tdo: POCIType;
                              iterator_ort: POCITypeIter): sword;
    function TypeIterFree(env: POCIEnv; err: POCIError;
                        iterator_ort: POCITypeIter): sword;
    function TypeByName(env: POCIEnv; err: POCIError; const svc: POCISvcCtx;
      schema_name: Poratext; const s_length: ub4; const type_name: Poratext;
      const t_length: ub4; version_name: Poratext; const v_length: ub4;
      const pin_duration: OCIDuration; const get_option: OCITypeGetOpt;
      tdo: PPOCIType): sword;
    function TypeArrayByName(env: POCIEnv; err: POCIError; svc: POCISvcCtx;
      array_len: ub4; schema_name:  PPoratext; s_length: Pub4;
      type_name: PPoratext; t_length: Pub4; version_name: PPoratext;
      v_length: Pub4; pin_duration: OCIDuration; get_option: OCITypeGetOpt;
      tdo: PPOCIType): sword;
    function TypeByRef(env: POCIEnv; err: POCIError; type_ref: POCIRef;
      pin_duration: OCIDuration; get_option: OCITypeGetOpt;
      tdo: PPOCIType): sword;
    function TypeArrayByRef(env: POCIEnv; err: POCIError; array_len: ub4;
      type_ref: PPOCIRef; pin_duration: OCIDuration; get_option: OCITypeGetOpt;
      tdo: PPOCIType): sword;
    function TypeName(env: POCIEnv; err: POCIError; tdo: POCIType;
      n_length: Pub4): poratext;
    function TypeSchema(env: POCIEnv; err: POCIError; const tdo: POCIType;
      n_length: Pub4): poratext;
    function TypeTypeCode(env: POCIEnv; err: POCIError;
                  const tdo: POCIType): OCITypeCode;
    function TypeCollTypeCode(env:POCIEnv; err:POCIError;
      const tdo: POCIType): OCITypeCode;
    function TypeVersion(env: POCIEnv; err: POCIError; const tdo: POCIType;
      v_length: Pub4): poratext;
    function TypeAttrs(env: POCIEnv; err: POCIError;
      const tdo:POCIType): ub4;
    function TypeMethods(env: POCIEnv; err: POCIError;
      const tdo: POCIType): ub4;
    function TypeElemName(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem; n_length:Pub4): poratext;
    function TypeElemTypeCode(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): OCITypeCode;
    function TypeElemType(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem; elem_tdo:PPOCIType): sword;
    function TypeElemFlags(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): ub4;
    function TypeElemNumPrec(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): ub1;
    function TypeElemNumScale(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): sb1;
    function TypeElemLength(env: POCIEnv; err: POCIError;
      const elem:POCITypeElem): ub4;
    function TypeElemCharSetID(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): ub2;
    function TypeElemCharSetForm(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): ub2;
    function TypeElemParameterizedType(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem; type_stored: PPOCIType): sword;
    function TypeElemExtTypeCode(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): OCITypeCode;
    function TypeAttrByName(env: POCIEnv; err: POCIError;
      const tdo: POCIType; const name: Poratext; const n_length: ub4;
      elem: PPOCITypeElem): sword;
    function TypeAttrNext(env: POCIEnv; err: POCIError;
      iterator_ort: POCITypeIter; elem: PPOCITypeElem): sword;
    function TypeCollElem(env: POCIEnv; err: POCIError; const tdo:POCIType;
      element: PPOCITypeElem): sword;
    function TypeCollSize(env: POCIEnv; err: POCIError; const tdo: POCIType;
      num_elems: Pub4): sword;
    function TypeCollExtTypeCode(env: POCIEnv; err: POCIError;
      const tdo:POCIType; sqt_code: POCITypeCode): sword;
    function TypeMethodOverload(env: POCIEnv; err: POCIError;
      const tdo: POCIType; const method_name: Poratext;
      const m_length: ub4): ub4;
    function TypeMethodByName(env: POCIEnv; err: POCIError;
      const tdo: POCIType; const method_name: Poratext; const m_length: ub4;
      mdos: PPOCITypeMethod): sword;
    function TypeMethodNext(env: POCIEnv; err: POCIError;
      iterator_ort: POCITypeIter; mdo: PPOCITypeMethod): sword;
    function TypeMethodName(env:POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; n_length: Pub4): poratext;
    function TypeMethodEncap(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod): OCITypeEncap;
    function TypeMethodFlags(env: POCIEnv; err: POCIError;
        const mdo:POCITypeMethod): OCITypeMethodFlag;
    function TypeMethodMap(env: POCIEnv; err: POCIError; const tdo: POCIType;
      mdo: PPOCITypeMethod): sword;
    function TypeMethodOrder(env: POCIEnv; err: POCIError;
      const tdo: POCIType; mdo: PPOCITypeMethod): sword;
    function TypeMethodParams(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod): ub4;
    function TypeResult(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; elem: PPOCITypeElem): sword;
    function TypeParamByPos(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; const position: ub4;
      elem: PPOCITypeElem): sword;
    function TypeParamByName(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; const name: Poratext; const n_length: ub4;
      elem:PPOCITypeElem): sword;
    function TypeParamPos(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; const name: Poratext; const n_length: ub4;
      position: Pub4; elem: PPOCITypeElem): sword;
    function TypeElemParamMode(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): OCITypeParamMode;
    function TypeElemDefaultValue(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem; d_v_length: Pub4): poratext;
    function TypeVTInit(env: POCIEnv; err: POCIError): sword;
    function TypeVTInsert(env: POCIEnv; err: POCIError;
      const schema_name: Poratext; const s_n_length: ub4;
      const type_name: Poratext; const t_n_length: ub4;
      const user_version:Poratext; const u_v_length:ub4): sword;
    function TypeVTSelect(env: POCIEnv; err: POCIError;
      const schema_name: Poratext; const s_n_length: ub4;
      const type_name: Poratext; const t_n_length: ub4; user_version: PPoratext;
      u_v_length: Pub4; version: Pub2): sword;
  end;

  {** Implements a driver for Oracle 9i }
  TZOracle9iPlainDriver = class (TZAbstractPlainDriver, IZPlainDriver,
    IZOraclePlainDriver)
  private
    OracleAPI: OracleOCI_API;
  protected
    procedure LoadApi; override;
    function Clone: IZPlainDriver; override;
  public
    constructor Create;

    function GetUnicodeCodePageName: String; override;
    procedure LoadCodePages; override;
    function GetProtocol: string; override;
    function GetDescription: string; override;
    procedure Initialize(const Location: String); override;

    function Initializ(mode: ub4; ctxp: Pointer; malocfp: Pointer;
      ralocfp: Pointer; mfreefp: Pointer): sword;
    function EnvInit(var envhpp: POCIEnv; mode: ub4; xtramemsz: size_T;
      usrmempp: PPointer): sword;
    function EnvCreate(var envhpp: POCIEnv; mode: ub4; ctxp: Pointer;
      malocfp: Pointer; ralocfp: Pointer; mfreefp: Pointer; xtramemsz: size_T;
      usrmempp: PPointer): sword;
    function EnvNlsCreate(var envhpp: POCIEnv; mode: ub4; ctxp: Pointer;
      malocfp: Pointer; ralocfp: Pointer; mfreefp: Pointer; xtramemsz: size_T;
      usrmempp: PPointer; charset, ncharset: ub2): sword;

    function HandleAlloc(parenth: POCIHandle; var hndlpp: POCIHandle;
      atype: ub4; xtramem_sz: size_T; usrmempp: PPointer): sword;
    function ServerAttach(srvhp: POCIServer; errhp: POCIError; dblink: text;
      dblink_len: sb4; mode: ub4): sword;
    function AttrSet(trgthndlp: POCIHandle; trghndltyp: ub4;
      attributep: Pointer; size: ub4; attrtype: ub4; errhp: POCIError):sword;
    function SessionBegin(svchp: POCISvcCtx; errhp: POCIError;
      usrhp: POCISession; credt: ub4; mode: ub4):sword;
    function SessionEnd(svchp: POCISvcCtx; errhp: POCIError;
      usrhp: POCISession; mode: ub4): sword;
    function ServerDetach(srvhp: POCIServer; errhp: POCIError;
      mode: ub4): sword;
    function HandleFree(hndlp: Pointer; atype: ub4): sword;
    function ErrorGet(hndlp: Pointer; recordno: ub4; sqlstate: text;
      var errcodep: sb4; bufp: text; bufsiz: ub4; atype: ub4): sword;

    function StmtPrepare(stmtp: POCIStmt; errhp: POCIError; stmt: text;
      stmt_len: ub4; language:ub4; mode: ub4):sword;
    function StmtExecute(svchp: POCISvcCtx; stmtp: POCIStmt;
      errhp: POCIError; iters: ub4; rowoff: ub4; snap_in: POCISnapshot;
      snap_out: POCISnapshot; mode: ub4): sword;
    function ParamGet(hndlp: Pointer; htype: ub4; errhp: POCIError;
      var parmdpp: Pointer; pos: ub4): sword;
    function AttrGet(trgthndlp: POCIHandle; trghndltyp: ub4;
      attributep: Pointer; sizep: Pointer; attrtype: ub4;
      errhp: POCIError): sword;
    function StmtFetch(stmtp: POCIStmt; errhp: POCIError; nrows: ub4;
      orientation: ub2; mode: ub4): sword;
    function DefineByPos(stmtp: POCIStmt; var defnpp: POCIDefine;
      errhp: POCIError; position: ub4; valuep: Pointer; value_sz: sb4; dty: ub2;
      indp: Pointer; rlenp: Pointer; rcodep: Pointer; mode: ub4): sword;
    function DefineArrayOfStruct(defnpp: POCIDefine; errhp: POCIError;
      pvskip: ub4; indskip: ub4; rlskip: ub4; rcskip: ub4): sword;

    function BindByPos(stmtp: POCIStmt; var bindpp: POCIBind;
      errhp: POCIError; position: ub4; valuep: Pointer; value_sz: sb4; dty: ub2;
      indp: Pointer; alenp: Pointer; rcodep: Pointer; maxarr_len: ub4;
      curelep: Pointer; mode: ub4): sword;
    function BindByName(stmtp: POCIStmt; var bindpp: POCIBind;
      errhp: POCIError; placeholder: text; placeh_len: sb4; valuep: Pointer;
      value_sz: sb4; dty: ub2; indp: Pointer; alenp: Pointer; rcodep: Pointer;
      maxarr_len: ub4; curelep: Pointer; mode: ub4): sword;
    function BindDynamic(bindp: POCIBind; errhp: POCIError; ictxp: Pointer;
      icbfp: Pointer; octxp: Pointer; ocbfp: Pointer): sword;
    function BindObject(bindp: POCIBind; errhp: POCIError;
                    const _type: POCIType; pgvpp: PPointer;
                    pvszsp: pub4; indpp: PPointer;
                    indszp: pub4): sword;

    function DefineObject(defnpp:POCIDefine; errhp:POCIError;
      _type:POCIHandle; pgvpp,pvszsp,indpp,indszp:pointer): sword;

    { > ori.h}
    function ObjectNew(env: POCIEnv; err: POCIError; const svc: POCISvcCtx;
                       typecode: OCITypeCode; tdo: POCIType; table: Pointer;
                       duration: OCIDuration; value: Longbool;
                       instance: PPointer): sword;
    function ObjectPin(env: POCIEnv; err: POCIError;
      const object_ref: POCIRef; const corhdl: POCIComplexObject;
      const pin_option: OCIPinOpt; const pin_duration: OCIDuration;
      const lock_option: OCILockOpt; _object: PPointer): sword;
    function ObjectUnpin(env: POCIEnv; err: POCIError;
      const _object: Pointer): sword;
    function ObjectPinCountReset(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectLock(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectLockNoWait(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectMarkUpdate(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectUnmark(env: POCIEnv; err: POCIError;
      const _object:pointer): sword;
    function ObjectUnmarkByRef(env: POCIEnv; err: POCIError;
      const ref: POCIRef): sword;
    function ObjectFree(hndl: POCIEnv; err: POCIError;
      instance:POCIHandle;flags :ub2):sword;
    function ObjectMarkDeleteByRef(env: POCIEnv; err: POCIError;
      const object_ref:POCIRef): sword;
    function ObjectMarkDelete(env: POCIEnv; err: POCIError;
      const instance:pointer): sword;
    function ObjectFlush(env: POCIEnv; err: POCIError;
      const _object: pointer): sword;
    function ObjectRefresh(env: POCIEnv; err: POCIError;
      _object: pointer): sword;
    function ObjectCopy(env: POCIEnv; err: POCIError; const svc: POCISvcCtx;
      const source, null_source, target, null_target: pointer; const tdo: POCIType;
      const duration: OCIDuration; const option: ub1): sword;
    function ObjectGetTypeRef(env: POCIEnv; err: POCIError;
      const instance:pointer; type_ref: POCIRef): sword;
    function ObjectGetObjectRef(env: POCIEnv; err: POCIError;
      const _object: pointer; object_ref: POCIRef): sword;
    function ObjectMakeObjectRef(env: POCIEnv; err: POCIError;
      const svc: POCISvcCtx; const table: pointer; const values: PPointer;
      const array_len: ub4; object_ref: POCIRef): sword;
    function ObjectGetPrimaryKeyTypeRef(env: POCIEnv; err: POCIError;
      const svc:POCISvcCtx; const table: pointer; type_ref: POCIRef): sword;
    function ObjectGetInd(env: POCIEnv; err: POCIError;
      const instance: pointer; null_struct: PPointer): sword;
    function ObjectExists(env: POCIEnv; err: POCIError; const ins: pointer;
      exist: PBoolean): sword;
    function ObjectGetProperty(envh: POCIEnv; errh: POCIError;
      const obj: pointer; const propertyId: OCIObjectPropId;
      _property: pointer; size: Pub4): sword;
    function ObjectIsLocked(env: POCIEnv; err: POCIError; const ins: pointer;
      lock: Pboolean): sword;
    function ObjectIsDirty(env: POCIEnv; err: POCIError; const ins: pointer;
      dirty: PBoolean): sword;
    function ObjectPinTable(env: POCIEnv; err: POCIError;
      const svc:POCISvcCtx; const schema_name: Poratext; const s_n_length: ub4;
      const object_name: Poratext; const o_n_length:ub4;
      const scope_obj_ref: POCIRef; const pin_duration: OCIDuration;
      _object: PPointer): sword;
    function ObjectArrayPin(env: POCIEnv; err: POCIError;
      const ref_array: PPOCIRef; const array_size: ub4;
      const cor_array: PPOCIComplexObject; const cor_array_size: ub4;
      const pin_option: OCIPinOpt; const pin_duration: OCIDuration;
      const lock: OCILockOpt; obj_array: PPointer;
      pos: Pub4): sword;
    function CacheFlush(env: POCIEnv; err: POCIError; const svc:POCISvcCtx;
      const context: pointer; const get: TOCICacheFlushGet;
      ref: PPOCIRef): sword;
    function CacheRefresh(env: POCIEnv; err: POCIError;
      const svc:POCISvcCtx; const option: OCIRefreshOpt; const context: pointer;
      get: TOCICacheRefreshGet; ref: PPOCIRef): sword;
    function CacheUnpin(env: POCIEnv; err: POCIError;
      const svc:POCISvcCtx): sword;
    function CacheFree(env: POCIEnv; err: POCIError;
      const svc: POCISvcCtx): sword;
    function CacheUnmark(env: POCIEnv; err: POCIError;
      const svc: POCISvcCtx): sword;
    function DurationBegin(env: POCIEnv; err: POCIError;
      svc: POCISvcCtx; const parent: OCIDuration;
      dur: POCIDuration): sword;
    function DurationEnd(env: POCIEnv; err: POCIError; svc: POCISvcCtx;
      duration: OCIDuration): sword;
    { < ori.h}

    function TransStart(svchp: POCISvcCtx; errhp: POCIError; timeout: word;
      flags: ub4): sword;
    function TransRollback(svchp:POCISvcCtx; errhp:POCIError;
      flags: ub4): sword;
    function TransCommit(svchp: POCISvcCtx; errhp: POCIError;
      flags: ub4): sword;
    function TransDetach(svchp: POCISvcCtx; errhp: POCIError;
      flags: ub4): sword;
    function TransPrepare(svchp: POCISvcCtx; errhp: POCIError;
      flags: ub4): sword;
    function TransForget(svchp: POCISvcCtx; errhp: POCIError;
      flags: ub4): sword;

    function DescribeAny(svchp: POCISvcCtx; errhp: POCIError;
      objptr: Pointer; objnm_len: ub4; objptr_typ: ub1; info_level: ub1;
      objtyp: ub1; dschp: POCIDescribe): sword;
    function Break(svchp: POCISvcCtx; errhp:POCIError): sword;
    function Reset(svchp: POCISvcCtx; errhp:POCIError): sword;
    function DescriptorAlloc(parenth: POCIEnv; var descpp: POCIDescriptor;
      htype: ub4; xtramem_sz: integer; usrmempp: Pointer): sword;
    function DescriptorFree(descp: Pointer; htype: ub4): sword;

    function DateTimeAssign(hndl: POCIEnv; err: POCIError;
      const from: POCIDateTime;_to: POCIDateTime): sword;
    function DateTimeCheck(hndl: POCIEnv; err: POCIError;
      const date: POCIDateTime; var valid: ub4): sword;
    function DateTimeCompare(hndl: POCIEnv; err: POCIError;
      const date1: POCIDateTime; const date2: POCIDateTime;
      var _result: sword): sword;
    function DateTimeConvert(hndl: POCIEnv; err: POCIError;
      indate: POCIDateTime; outdate: POCIDateTime): sword;
    function DateTimeFromText(hndl: POCIEnv; err: POCIError;
      const date_str: text; d_str_length: size_t; const fmt: text;
      fmt_length: ub1; const lang_name: text; lang_length: size_t;
      date: POCIDateTime): sword;
    function DateTimeGetDate(hndl: POCIEnv; err: POCIError;
      const date: POCIDateTime; var year: sb2; var month: ub1;
      var day: ub1): sword;
    function DateTimeGetTime(hndl: POCIEnv; err: POCIError;
      datetime: POCIDateTime; var hour: ub1; var minute: ub1; var sec: ub1;
      var fsec: ub4): sword;
    function DateTimeGetTimeZoneOffset(hndl: POCIEnv; err: POCIError;
      const datetime: POCIDateTime; var hour: sb1; var minute: sb1): sword;
    function DateTimeSysTimeStamp(hndl: POCIEnv; err: POCIError;
      sys_date: POCIDateTime): sword;
    function DateTimeConstruct(hndl: POCIEnv; err: POCIError;
      datetime: POCIDateTime; year: sb2; month: ub1; day: ub1; hour: ub1;
      min: ub1; sec: ub1; fsec: ub4; timezone: text;
      timezone_length: size_t): sword;
    function DateTimeToText(hndl: POCIEnv; err: POCIError;
      const date: POCIDateTime; const fmt: text; fmt_length: ub1;
      fsprec: ub1; const lang_name: text; lang_length: size_t;
      var buf_size: ub4; buf: text): sword;
    function DateTimeGetTimeZoneName(hndl: POCIEnv; err: POCIError;
      datetime: POCIDateTime; var buf: ub1; var buflen: ub4): sword;

    function LobAppend(svchp: POCISvcCtx; errhp: POCIError; dst_locp,
      src_locp: POCILobLocator): sword;
    function LobAssign(svchp: POCISvcCtx; errhp: POCIError;
      src_locp: POCILobLocator; var dst_locpp: POCILobLocator): sword;
    function LobClose(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator): sword;
    function LobCopy(svchp: POCISvcCtx; errhp: POCIError;
      dst_locp: POCILobLocator; src_locp: POCILobLocator; amount: ub4;
      dst_offset: ub4; src_offset: ub4): sword;
    function LobEnableBuffering(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator): sword;
    function LobDisableBuffering(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator): sword;
    function LobErase(svchp: POCISvcCtx; errhp: POCIError; locp: POCILobLocator;
      var amount: ub4; offset: ub4): sword;
    function LobFileExists(svchp: POCISvcCtx; errhp: POCIError;
      filep: POCILobLocator; var flag: Boolean): sword;
    function LobFileGetName(envhp: POCIEnv; errhp: POCIError;
      filep: POCILobLocator; dir_alias: text; var d_length: ub2; filename: text;
      var f_length: ub2): sword;
    function LobFileSetName(envhp: POCIEnv; errhp: POCIError;
      var filep: POCILobLocator; dir_alias: text; d_length: ub2; filename: text;
      f_length: ub2): sword;
    function LobFlushBuffer(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; flag: ub4): sword;
    function LobGetLength(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var lenp: ub4): sword;
    function LobIsOpen(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var flag: LongBool): sword;
    function LobLoadFromFile(svchp: POCISvcCtx; errhp: POCIError;
      dst_locp: POCILobLocator; src_locp: POCILobLocator; amount: ub4;
      dst_offset: ub4; src_offset: ub4): sword;
    function LobLocatorIsInit(envhp: POCIEnv; errhp: POCIError;
     locp: POCILobLocator; var is_initialized: LongBool): sword;
    function LobOpen(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; mode: ub1): sword;
    function LobRead(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var amtp: ub4; offset: ub4; bufp: Pointer; bufl: ub4;
      ctxp: Pointer; cbfp: Pointer; csid: ub2; csfrm: ub1): sword;
    function LobTrim(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; newlen: ub4): sword;
    function LobWrite(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var amtp: ub4; offset: ub4; bufp: Pointer; bufl: ub4;
      piece: ub1; ctxp: Pointer; cbfp: Pointer; csid: ub2; csfrm: ub1): sword;
    function LobCreateTemporary(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; csid: ub2; csfrm: ub1; lobtype: ub1;
      cache: LongBool; duration: OCIDuration): sword;
    function LobIsTemporary(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator; var is_temporary: LongBool): sword;
    function LobFreeTemporary(svchp: POCISvcCtx; errhp: POCIError;
      locp: POCILobLocator): sword;
    function LobCharSetForm ( envhp: POCIEnv; errhp: POCIError;
        const locp: POCILobLocator; csfrm: pub1): sword;
    function LobCharSetId ( envhp: POCIEnv; errhp: POCIError;
        const locp: POCILobLocator; csid: pub2): sword;

    function StmtGetPieceInfo(stmtp: POCIStmt; errhp: POCIError;
      var hndlpp: Pointer; var typep: ub4; var in_outp: ub1; var iterp: ub4;
      var idxp: ub4; var piecep: ub1): sword;
    function StmtSetPieceInfo(handle: Pointer; typep: ub4; errhp: POCIError;
      buf: Pointer; var alenp: ub4; piece: ub1; indp: Pointer;
      var rcodep: ub2): sword;
    function PasswordChange(svchp: POCISvcCtx; errhp: POCIError;
      user_name: text; usernm_len: ub4; opasswd: text; opasswd_len: ub4;
      npasswd: text; npasswd_len: sb4; mode: ub4): sword;
    function ServerVersion(hndlp: POCIHandle; errhp: POCIError; bufp: text;
      bufsz: ub4; hndltype: ub1): sword;
    function ServerRelease(hndlp: POCIHandle;
      errhp: POCIError; bufp: text; bufsz: ub4; hndltype: ub1; version:pointer): sword;
    function ResultSetToStmt(rsetdp: POCIHandle; errhp: POCIError): sword;
    function GetEnvCharsetByteWidth(hndl: POCIEnv; err: POCIError;
      Value: sb4): sword;
    procedure ClientVersion(major_version, minor_version, update_num,
      patch_num, port_update_num: psword);

    function NumberInc(err: POCIError; number: POCINumber): sword;
    function NumberDec(err: POCIError; number: POCINumber): sword;
    procedure NumberSetZero(err: POCIError; number: POCINumber);
    procedure NumberSetPi(err: POCIError; number: POCINumber);
    function  NumberAdd(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberSub(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberMul(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberDiv(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberMod(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberIntPower(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberShift(err: POCIError; const number: POCINumber;
      const nDig: sword; _result: POCINumber): sword;
    function NumberNeg(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberToText(err: POCIError; const number: POCINumber;
      const fmt: Poratext; fmt_length: ub4; const nls_params: Poratext;
      nls_p_length: ub4; buf_size: pub4; buf: poratext): sword;
    function NumberFromText(err: POCIError; const str: poratext;
      str_length: ub4; const fmt: poratext; fmt_length: ub4;
      const nls_params: poratext; nls_p_length: ub4; number: POCINumber): sword;
    function NumberToInt(err: POCIError; const number: POCINumber;
      rsl_length: uword; rsl_flag: uword; rsl: Pointer): sword;
    function NumberFromInt(err: POCIError; const inum: Pointer;
      inum_length: uword; inum_s_flag: uword; number: POCINumber): sword;
    function NumberToReal(err: POCIError; const number: POCINumber;
      rsl_length: uword; rsl: Pointer): sword;
    function NumberToRealArray(err: POCIError; const number: PPOCINumber;
      elems: uword; rsl_length: uword; rsl: Pointer): sword;
    function NumberFromReal(err: POCIError; const rnum: Pointer;
      rnum_length: uword; number: POCINumber): sword;
    function NumberCmp(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: psword): sword;
    function NumberSign(err: POCIError; const number: POCINumber;
      _result: psword): sword;
    function NumberIsZero(err: POCIError; const number: POCINumber;
      _Result: pboolean): sword;
    function NumberIsInt(err: POCIError; const number: POCINumber;
      _result: Pboolean): sword;
    function NumberAssign(err: POCIError; const from: POCINumber;
      _to: POCINumber): sword;
    function NumberAbs(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberCeil(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberFloor(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberSqrt(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberTrunc(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberPower(err: POCIError; const base: POCINumber;
      const number: POCINumber; _result: POCINumber): sword;
    function NumberRound(err: POCIError; const number: POCINumber;
      decplace: sword; _result: POCINumber): sword;
    function NumberPrec(err: POCIError; const number: POCINumber;
      nDigs: sword; _result: POCINumber): sword;
    function NumberSin(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberArcSin(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberHypSin(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberCos(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberArcCos(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberHypCos(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberTan(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberArcTan(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberArcTan2(err: POCIError; const number1: POCINumber;
      const number2: POCINumber; _result: POCINumber): sword;
    function NumberHypTan(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberExp(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberLn(err: POCIError; const number: POCINumber;
      _result: POCINumber): sword;
    function NumberLog(err: POCIError; const base: POCINumber;
      const number: POCINumber; _result: POCINumber): sword;

    function TableSize(hndl: POCIEnv; err: POCIError; const tbl: POCITable;
                    size: psb4): sword;
    function TableExists(hndl: POCIEnv; err: POCIError; const tbl: POCITable;
                             index: sb4; exists: PBoolean): sword;
    function TableDelete(hndl: POCIEnv; err: POCIError; index: sb4;
                      tbl: POCITable): sword;
    function TableFirst(hndl: POCIEnv; err: POCIError; const tbl: POCITable;
                             index: sb4): sword;
    function TableLast(hndl: POCIEnv; err: POCIError; const tbl: POCITable;
                             index: sb4): sword;
    function TableNext(hndl: POCIEnv; err: POCIError; index: sb4;
      const tbl: POCITable; next_index: psb4; exists: PBoolean): sword;
    function TablePrev(hndl: POCIEnv; err: POCIError; index: sb4;
      const tbl: POCITable; prev_index: psb4; exists: PBoolean): sword;

    function ObjectSetAttr(env: POCIEnv; err: POCIError; instance: Pointer;
                  null_struct: pointer; tdo: POCIType; const names: PPAnsiChar;
                  const lengths: pub4; const name_count: ub4;
                  const indexes: pub4; const index_count: ub4;
                  const null_status: POCIInd; const attr_null_struct: Pointer;
                  const attr_value: Pointer): sword; cdecl;
    function ObjectGetAttr(env: POCIEnv; err: POCIError; instance: Pointer;
                  null_struct: Pointer; tdo: POCIType;
                  const names: PPoratext; const lengths: pub4;
                  const name_count: ub4; const indexes: pub4;
                  const index_count: ub4; attr_null_status: POCIInd;
                  attr_null_struct, attr_value: PPointer;
                  attr_tdo: PPOCIType): sword;
    {ociap.h}
    function Ping(svchp: POCISvcCtx; errhp: POCIError; mode: ub4 = OCI_DEFAULT): sword;
    {ort.h}
    function TypeIterNew(env: POCIEnv; err: POCIError; const tdo: POCIType;
                      iterator_ort: PPOCITypeIter):sword;
    function TypeIterSet(env: POCIEnv; err: POCIError; const tdo: POCIType;
                              iterator_ort: POCITypeIter): sword;
    function TypeIterFree(env: POCIEnv; err: POCIError;
                        iterator_ort: POCITypeIter): sword;
    function TypeByName(env: POCIEnv; err: POCIError; const svc: POCISvcCtx;
      schema_name: Poratext; const s_length: ub4; const type_name: Poratext;
      const t_length: ub4; version_name: Poratext; const v_length: ub4;
      const pin_duration: OCIDuration; const get_option: OCITypeGetOpt;
      tdo: PPOCIType): sword;
    function TypeArrayByName(env: POCIEnv; err: POCIError; svc: POCISvcCtx;
      array_len: ub4; schema_name:  PPoratext; s_length: Pub4;
      type_name: PPoratext; t_length: Pub4; version_name: PPoratext;
      v_length: Pub4; pin_duration: OCIDuration; get_option: OCITypeGetOpt;
      tdo: PPOCIType): sword;
    function TypeByRef(env: POCIEnv; err: POCIError; type_ref: POCIRef;
      pin_duration: OCIDuration; get_option: OCITypeGetOpt;
      tdo: PPOCIType): sword;
    function TypeArrayByRef(env: POCIEnv; err: POCIError; array_len: ub4;
      type_ref: PPOCIRef; pin_duration: OCIDuration; get_option: OCITypeGetOpt;
      tdo: PPOCIType): sword;
    function TypeName(env: POCIEnv; err: POCIError; tdo: POCIType;
      n_length: Pub4): poratext;
    function TypeSchema(env: POCIEnv; err: POCIError; const tdo: POCIType;
      n_length: Pub4): poratext;
    function TypeTypeCode(env: POCIEnv; err: POCIError;
                  const tdo: POCIType): OCITypeCode;
    function TypeCollTypeCode(env:POCIEnv; err:POCIError;
      const tdo: POCIType): OCITypeCode;
    function TypeVersion(env: POCIEnv; err: POCIError; const tdo: POCIType;
      v_length: Pub4): poratext;
    function TypeAttrs(env: POCIEnv; err: POCIError;
      const tdo:POCIType): ub4;
    function TypeMethods(env: POCIEnv; err: POCIError;
      const tdo: POCIType): ub4;
    function TypeElemName(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem; n_length:Pub4): poratext;
    function TypeElemTypeCode(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): OCITypeCode;
    function TypeElemType(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem; elem_tdo:PPOCIType): sword;
    function TypeElemFlags(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): ub4;
    function TypeElemNumPrec(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): ub1;
    function TypeElemNumScale(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): sb1;
    function TypeElemLength(env: POCIEnv; err: POCIError;
      const elem:POCITypeElem): ub4;
    function TypeElemCharSetID(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): ub2;
    function TypeElemCharSetForm(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): ub2;
    function TypeElemParameterizedType(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem; type_stored: PPOCIType): sword;
    function TypeElemExtTypeCode(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): OCITypeCode;
    function TypeAttrByName(env: POCIEnv; err: POCIError;
      const tdo: POCIType; const name: Poratext; const n_length: ub4;
      elem: PPOCITypeElem): sword;
    function TypeAttrNext(env: POCIEnv; err: POCIError;
      iterator_ort: POCITypeIter; elem: PPOCITypeElem): sword;
    function TypeCollElem(env: POCIEnv; err: POCIError; const tdo:POCIType;
      element: PPOCITypeElem): sword;
    function TypeCollSize(env: POCIEnv; err: POCIError; const tdo: POCIType;
      num_elems: Pub4): sword;
    function TypeCollExtTypeCode(env: POCIEnv; err: POCIError;
      const tdo:POCIType; sqt_code: POCITypeCode): sword;
    function TypeMethodOverload(env: POCIEnv; err: POCIError;
      const tdo: POCIType; const method_name: Poratext;
      const m_length: ub4): ub4;
    function TypeMethodByName(env: POCIEnv; err: POCIError;
      const tdo: POCIType; const method_name: Poratext; const m_length: ub4;
      mdos: PPOCITypeMethod): sword;
    function TypeMethodNext(env: POCIEnv; err: POCIError;
      iterator_ort: POCITypeIter; mdo: PPOCITypeMethod): sword;
    function TypeMethodName(env:POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; n_length: Pub4): poratext;
    function TypeMethodEncap(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod): OCITypeEncap;
    function TypeMethodFlags(env: POCIEnv; err: POCIError;
        const mdo:POCITypeMethod): OCITypeMethodFlag;
    function TypeMethodMap(env: POCIEnv; err: POCIError; const tdo: POCIType;
      mdo: PPOCITypeMethod): sword;
    function TypeMethodOrder(env: POCIEnv; err: POCIError;
      const tdo: POCIType; mdo: PPOCITypeMethod): sword;
    function TypeMethodParams(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod): ub4;
    function TypeResult(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; elem: PPOCITypeElem): sword;
    function TypeParamByPos(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; const position: ub4;
      elem: PPOCITypeElem): sword;
    function TypeParamByName(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; const name: Poratext; const n_length: ub4;
      elem:PPOCITypeElem): sword;
    function TypeParamPos(env: POCIEnv; err: POCIError;
      const mdo: POCITypeMethod; const name: Poratext; const n_length: ub4;
      position: Pub4; elem: PPOCITypeElem): sword;
    function TypeElemParamMode(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem): OCITypeParamMode;
    function TypeElemDefaultValue(env: POCIEnv; err: POCIError;
      const elem: POCITypeElem; d_v_length: Pub4): poratext;
    function TypeVTInit(env: POCIEnv; err: POCIError): sword;
    function TypeVTInsert(env: POCIEnv; err: POCIError;
      const schema_name: Poratext; const s_n_length: ub4;
      const type_name: Poratext; const t_n_length: ub4;
      const user_version:Poratext; const u_v_length:ub4): sword;
    function TypeVTSelect(env: POCIEnv; err: POCIError;
      const schema_name: Poratext; const s_n_length: ub4;
      const type_name: Poratext; const t_n_length: ub4; user_version: PPoratext;
      u_v_length: Pub4; version: Pub2): sword;
  end;

implementation

uses ZEncoding;

{ TZOracle9iPlainDriver }

function TZOracle9iPlainDriver.GetUnicodeCodePageName: String;
begin
  Result := 'UTF8';
end;

procedure TZOracle9iPlainDriver.LoadCodePages;
begin
(*  AddCodePage('AL16UTF16', 2000, ceUTF16, zCP_UTF16); {Unicode 3.1 UTF-16 Universal character set}
  AddCodePage('AL32UTF8', 873, ceUTF8, zCP_UTF8); {Unicode 3.1 UTF-8 Universal character set}
  //AddCodePage('AR8ADOS710', 3); {Arabic MS-DOS 710 Server 8-bit Latin/Arabic}
//  AddCodePage('AR8ADOS710T', 4); {Arabic MS-DOS 710 8-bit Latin/Arabic}
  AddCodePage('AR8ADOS720', 558); {Arabic MS-DOS 720 Server 8-bit Latin/Arabic}
//  AddCodePage('AR8ADOS720T', 6); {Arabic MS-DOS 720 8-bit Latin/Arabic}
//  AddCodePage('AR8APTEC715', 7); {APTEC 715 Server 8-bit Latin/Arabic}
//  AddCodePage('AR8APTEC715T', 8); {APTEC 715 8-bit Latin/Arabic}
//  AddCodePage('AR8ASMO708PLUS', 9); {ASMO 708 Plus 8-bit Latin/Arabic}
  AddCodePage('AR8ASMO8X', 500); {ASMO Extended 708 8-bit Latin/Arabic}
//  AddCodePage('BN8BSCII', 11); {Bangladesh National Code 8-bit BSCII}
//  AddCodePage('TR7DEC', 12); {DEC VT100 7-bit Turkish}
//  AddCodePage('TR8DEC', 13); {DEC 8-bit Turkish}
//  AddCodePage('EL8DEC', 14); {DEC 8-bit Latin/Greek}
//  AddCodePage('EL8GCOS7', 15); {Bull EBCDIC GCOS7 8-bit Greek}
//  AddCodePage('IN8ISCII', 16); {Multiple-Script Indian Standard 8-bit Latin/Indian Languages}
//  AddCodePage('JA16DBCS', 17); {IBM EBCDIC 16-bit Japanese UDC}
//  AddCodePage('JA16EBCDIC930', 18); {IBM DBCS Code Page 290 16-bit Japanese UDC}
  AddCodePage('JA16EUC', 830); {EUC 24-bit Japanese}
  AddCodePage('JA16EUCTILDE', 837); {The same as JA16EUC except for the way that the wave dash and the tilde are mapped to and from Unicode.}
//  AddCodePage('JA16EUCYEN', 21); {EUC 24-bit Japanese with '\' mapped to the Japanese yen character}
//  AddCodePage('JA16MACSJIS', 22); {Mac client Shift-JIS 16-bit Japanese}
  AddCodePage('JA16SJIS', 832); {Shift-JIS 16-bit Japanese UDC}
  AddCodePage('JA16SJISTILDE', 838); {The same as JA16SJIS except for the way that the wave dash and the tilde are mapped to and from Unicode. UDC}
//  AddCodePage('JA16SJISYEN', 25); {Shift-JIS 16-bit Japanese with '\' mapped to the Japanese yen character UDC}
//  AddCodePage('JA16VMS', 26); {JVMS 16-bit Japanese}
//  AddCodePage('RU8BESTA', 27); {BESTA 8-bit Latin/Cyrillic}
//  AddCodePage('SF7ASCII', 28); {ASCII 7-bit Finnish}
//  AddCodePage('KO16DBCS', 29); {IBM EBCDIC 16-bit Korean UDC}
//  AddCodePage('KO16KSCCS', 30); {KSCCS 16-bit Korean}
  AddCodePage('KO16KSC5601', 840); {KSC5601 16-bit Korean}
  AddCodePage('KO16MSWIN949', 846); {MS Windows Code Page 949 Korean UDC}
//  AddCodePage('TH8MACTHAI', 33); {Mac Client 8-bit Latin/Thai}
//  AddCodePage('TH8MACTHAIS', 34); {Mac Server 8-bit Latin/Thai}
  AddCodePage('TH8TISASCII', 41); {Thai Industrial Standard 620-2533 - ASCII 8-bit}
//  AddCodePage('TH8TISEBCDIC', 36); {Thai Industrial Standard 620-2533 - EBCDIC 8-bit}
//  AddCodePage('TH8TISEBCDICS', 37); {Thai Industrial Standard 620-2533-EBCDIC Server 8-bit}
  AddCodePage('US7ASCII', 1); {U.S. 7-bit ASCII American}
  AddCodePage('VN8MSWIN1258', 45); {MS Windows Code Page 1258 8-bit Vietnamese}
//  AddCodePage('VN8VN3', 38); {VN3 8-bit Vietnamese}
//  AddCodePage('WE8GCOS7', 41); {Bull EBCDIC GCOS7 8-bit West European}
//  AddCodePage('YUG7ASCII', 42); {ASCII 7-bit Yugoslavian}
  AddCodePage('ZHS16CGB231280', 850); {CGB2312-80 16-bit Simplified Chinese}
//  AddCodePage('ZHS16DBCS', 44); {IBM EBCDIC 16-bit Simplified Chinese UDC}
  AddCodePage('ZHS16GBK', 852); {GBK 16-bit Simplified Chinese UDC}
//  AddCodePage('ZHS16MACCGB231280', 46); {Mac client CGB2312-80 16-bit Simplified Chinese}
  AddCodePage('ZHS32GB18030', 854); {GB18030-2000}
  AddCodePage('ZHT16BIG5', 856); {BIG5 16-bit Traditional Chinese}
//  AddCodePage('ZHT16CCDC', 49); {HP CCDC 16-bit Traditional Chinese}
//  AddCodePage('ZHT16DBCS', 50); {IBM EBCDIC 16-bit Traditional Chinese UDC}
//  AddCodePage('ZHT16DBT', 51); {Taiwan Taxation 16-bit Traditional Chinese}
  AddCodePage('ZHT16HKSCS', 868); {MS Windows Code Page 950 with Hong Kong Supplementary Character Set}
  AddCodePage('ZHT16MSWIN950', 867); {MS Windows Code Page 950 Traditional Chinese UDC}
  AddCodePage('ZHT32EUC', 860); {EUC 32-bit Traditional Chinese}
//  AddCodePage('ZHT32SOPS', 55); {SOPS 32-bit Traditional Chinese}
//  AddCodePage('ZHT32TRIS', 56); {TRIS 32-bit Traditional Chinese}

//  AddCodePage('WE8DEC', 57); {DEC 8-bit West European}
//  AddCodePage('D7DEC', 58); {DEC VT100 7-bit German}
//  AddCodePage('F7DEC', 59); {DEC VT100 7-bit French}
//  AddCodePage('S7DEC', 60); {DEC VT100 7-bit Swedish}
//  AddCodePage('E7DEC', 61); {DEC VT100 7-bit Spanish}
//  AddCodePage('NDK7DEC', 62); {DEC VT100 7-bit Norwegian/Danish}
//  AddCodePage('I7DEC', 63); {DEC VT100 7-bit Italian}
//  AddCodePage('NL7DEC', 64); {DEC VT100 7-bit Dutch}
//  AddCodePage('CH7DEC', 65); {DEC VT100 7-bit Swiss (German/French)}
//  AddCodePage('SF7DEC', 66); {DEC VT100 7-bit Finnish}
//  AddCodePage('WE8DG', 67); {DG 8-bit West European}
//  AddCodePage('WE8EBCDIC37', 68, ceAnsi, zCP_EBC037); {EBCDIC Code Page 37 8-bit West European}
//  AddCodePage('D8EBCDIC273', 69, ceAnsi, zCP_EBC273); {EBCDIC Code Page 273/1 8-bit Austrian German}
//  AddCodePage('DK8EBCDIC277', 70, ceAnsi, zCP_EBC277); {EBCDIC Code Page 277/1 8-bit Danish}
//  AddCodePage('S8EBCDIC278', 71, ceAnsi, zCP_EBC278); {EBCDIC Code Page 278/1 8-bit Swedish}
//  AddCodePage('I8EBCDIC280', 72, ceAnsi, zCP_EBC280); {EBCDIC Code Page 280/1 8-bit Italian}
//  AddCodePage('WE8EBCDIC284', 73, ceAnsi, zCP_EBC284); {EBCDIC Code Page 284 8-bit Latin American/Spanish}
//  AddCodePage('WE8EBCDIC285', 74); {EBCDIC Code Page 285 8-bit West European}
//  AddCodePage('WE8EBCDIC924', 75); {Latin 9 EBCDIC 924}
//  AddCodePage('WE8EBCDIC1047', 76); {EBCDIC Code Page 1047 8-bit West European}
//  AddCodePage('WE8EBCDIC1047E', 77); {Latin 1/Open Systems 1047}
//  AddCodePage('WE8EBCDIC1140', 78); {EBCDIC Code Page 1140 8-bit West European}
//  AddCodePage('WE8EBCDIC1140C', 79); {EBCDIC Code Page 1140 Client 8-bit West European}
//  AddCodePage('WE8EBCDIC1145', 80); {EBCDIC Code Page 1145 8-bit West European}
//  AddCodePage('WE8EBCDIC1146', 81); {EBCDIC Code Page 1146 8-bit West European}
//  AddCodePage('WE8EBCDIC1148', 82); {EBCDIC Code Page 1148 8-bit West European}
//  AddCodePage('WE8EBCDIC1148C', 83); {EBCDIC Code Page 1148 Client 8-bit West European}
//  AddCodePage('F8EBCDIC297', 84); {EBCDIC Code Page 297 8-bit French}
//  AddCodePage('WE8EBCDIC500', 85); {EBCDIC Code Page 500 8-bit West European}
//  AddCodePage('EE8EBCDIC870', 85); {EBCDIC Code Page 870 8-bit East European}
//  AddCodePage('EE8EBCDIC870C', 87); {EBCDIC Code Page 870 Client 8-bit East European}
//  AddCodePage('EE8EBCDIC870S', 88); {EBCDIC Code Page 870 Server 8-bit East European}
//  AddCodePage('WE8EBCDIC871', 89); {EBCDIC Code Page 871 8-bit Icelandic}
  AddCodePage('EL8EBCDIC875', 90); {EBCDIC Code Page 875 8-bit Greek}
  AddCodePage('EL8EBCDIC875R', 91); {EBCDIC Code Page 875 Server 8-bit Greek}
  AddCodePage('CL8EBCDIC1025', 92); {EBCDIC Code Page 1025 8-bit Cyrillic}
  AddCodePage('CL8EBCDIC1025C', 93); {EBCDIC Code Page 1025 Client 8-bit Cyrillic}
  AddCodePage('CL8EBCDIC1025R', 94); {EBCDIC Code Page 1025 Server 8-bit Cyrillic}
  AddCodePage('CL8EBCDIC1025S', 95); {EBCDIC Code Page 1025 Server 8-bit Cyrillic}
  AddCodePage('CL8EBCDIC1025X', 96); {EBCDIC Code Page 1025 (Modified) 8-bit Cyrillic}
  AddCodePage('BLT8EBCDIC1112', 97); {EBCDIC Code Page 1112 8-bit Baltic Multilingual}
  AddCodePage('BLT8EBCDIC1112S', 98); {EBCDIC Code Page 1112 8-bit Server Baltic Multilingual}
  AddCodePage('D8EBCDIC1141', 99); {EBCDIC Code Page 1141 8-bit Austrian German}
  AddCodePage('DK8EBCDIC1142', 100); {EBCDIC Code Page 1142 8-bit Danish}
  AddCodePage('S8EBCDIC1143', 101); {EBCDIC Code Page 1143 8-bit Swedish}
  AddCodePage('I8EBCDIC1144', 102); {EBCDIC Code Page 1144 8-bit Italian}
  AddCodePage('F8EBCDIC1147', 103); {EBCDIC Code Page 1147 8-bit French}
  AddCodePage('EEC8EUROASCI', 104); {EEC Targon 35 ASCI West European/Greek}
  AddCodePage('EEC8EUROPA3', 105); {EEC EUROPA3 8-bit West European/Greek}
  AddCodePage('LA8PASSPORT', 106); {German Government Printer 8-bit All-European Latin}
  AddCodePage('WE8HP', 107); {HP LaserJet 8-bit West European}
  AddCodePage('WE8ROMAN8', 108); {HP Roman8 8-bit West European}
  AddCodePage('HU8CWI2', 109); {Hungarian 8-bit CWI-2}
  AddCodePage('HU8ABMOD', 110); {Hungarian 8-bit Special AB Mod}
  AddCodePage('LV8RST104090', 111); {IBM-PC Alternative Code Page 8-bit Latvian (Latin/Cyrillic)}
  AddCodePage('US8PC437', 112); {IBM-PC Code Page 437 8-bit American}
  AddCodePage('BG8PC437S', 113); {IBM-PC Code Page 437 8-bit (Bulgarian Modification)}
  AddCodePage('EL8PC437S', 114); {IBM-PC Code Page 437 8-bit (Greek modification)}
  AddCodePage('EL8PC737', 115); {IBM-PC Code Page 737 8-bit Greek/Latin}
  AddCodePage('LT8PC772', 116); {IBM-PC Code Page 772 8-bit Lithuanian (Latin/Cyrillic)}
  AddCodePage('LT8PC774', 117); {IBM-PC Code Page 774 8-bit Lithuanian (Latin)}
  AddCodePage('BLT8PC775', 118); {IBM-PC Code Page 775 8-bit Baltic}
  AddCodePage('WE8PC850', 119); {IBM-PC Code Page 850 8-bit West European}
  AddCodePage('EL8PC851', 120); {IBM-PC Code Page 851 8-bit Greek/Latin}
  AddCodePage('EE8PC852', 121); {IBM-PC Code Page 852 8-bit East European}
  AddCodePage('RU8PC855', 122); {IBM-PC Code Page 855 8-bit Latin/Cyrillic}
  AddCodePage('WE8PC858', 123); {IBM-PC Code Page 858 8-bit West European}
  AddCodePage('WE8PC860', 124); {IBM-PC Code Page 860 8-bit West European}
  AddCodePage('IS8PC861', 125); {IBM-PC Code Page 861 8-bit Icelandic}
  AddCodePage('CDN8PC863', 126); {IBM-PC Code Page 863 8-bit Canadian French}
  AddCodePage('N8PC865', 127); {IBM-PC Code Page 865 8-bit Norwegian}
  AddCodePage('RU8PC866', 128); {IBM-PC Code Page 866 8-bit Latin/Cyrillic}
  AddCodePage('EL8PC869', 129); {IBM-PC Code Page 869 8-bit Greek/Latin}
  AddCodePage('LV8PC1117', 130); {IBM-PC Code Page 1117 8-bit Latvian}
  AddCodePage('US8ICL', 131); {ICL EBCDIC 8-bit American}
  AddCodePage('WE8ICL', 132); {ICL EBCDIC 8-bit West European}
  AddCodePage('WE8ISOICLUK', 133); {ICL special version ISO8859-1}
  AddCodePage('WE8ISO8859P1', 134); {ISO 8859-1 West European}
  AddCodePage('EE8ISO8859P2', 135); {ISO 8859-2 East European}
  AddCodePage('SE8ISO8859P3', 136); {ISO 8859-3 South European}
  AddCodePage('NEE8ISO8859P4', 137); {ISO 8859-4 North and North-East European}
  AddCodePage('CL8ISO8859P5', 138); {ISO 8859-5 Latin/Cyrillic}
  AddCodePage('EL8ISO8859P7', 139); {ISO 8859-7 Latin/Greek}
  AddCodePage('NE8ISO8859P10', 140); {ISO 8859-10 North European}
  AddCodePage('BLT8ISO8859P13', 141); {ISO 8859-13 Baltic}
  AddCodePage('CEL8ISO8859P14', 142); {ISO 8859-13 Celtic}
  AddCodePage('WE8ISO8859P15', 143); {ISO 8859-15 West European}
  AddCodePage('AR8ARABICMAC', 144); {Mac Client 8-bit Latin/Arabic}
  AddCodePage('EE8MACCE', 145); {Mac Client 8-bit Central European}
  AddCodePage('EE8MACCROATIAN', 146); {Mac Client 8-bit Croatian}
  AddCodePage('WE8MACROMAN8', 147); {Mac Client 8-bit Extended Roman8 West European}
  AddCodePage('EL8MACGREEK', 148); {Mac Client 8-bit Greek}
  AddCodePage('IS8MACICELANDIC', 149); {Mac Client 8-bit Icelandic}
  AddCodePage('CL8MACCYRILLIC', 150); {Mac Client 8-bit Latin/Cyrillic}
  AddCodePage('EE8MACCES', 151); {Mac Server 8-bit Central European}
  AddCodePage('EE8MACCROATIANS', 152); {Mac Server 8-bit Croatian}
  AddCodePage('WE8MACROMAN8S', 153); {Mac Server 8-bit Extended Roman8 West European}
  AddCodePage('CL8MACCYRILLICS', 154); {Mac Server 8-bit Latin/Cyrillic}
  AddCodePage('EL8MACGREEKS', 155); {Mac Server 8-bit Greek}
  AddCodePage('IS8MACICELANDICS', 156); {Mac Server 8-bit Icelandic}
  AddCodePage('BG8MSWIN', 157); {MS Windows 8-bit Bulgarian Cyrillic}
  AddCodePage('LT8MSWIN921', 158); {MS Windows Code Page 921 8-bit Lithuanian}
  AddCodePage('ET8MSWIN923', 159); {MS Windows Code Page 923 8-bit Estonian}
  AddCodePage('EE8MSWIN1250', 160, ceAnsi, zCP_WIN1250); {MS Windows Code Page 1250 8-bit East European}
  AddCodePage('CL8MSWIN1251', 161, ceAnsi, zCP_WIN1251); {MS Windows Code Page 1251 8-bit Latin/Cyrillic}
  AddCodePage('WE8MSWIN1252', 162, ceAnsi, zCP_WIN1252); {MS Windows Code Page 1252 8-bit West European}
  AddCodePage('EL8MSWIN1253', 163, ceAnsi, zCP_WIN1253); {MS Windows Code Page 1253 8-bit Latin/Greek}
  AddCodePage('BLT8MSWIN1257', 164, ceAnsi, zCP_WIN1257); {MS Windows Code Page 1257 8-bit Baltic}
  AddCodePage('BLT8CP921', 165); {Latvian Standard LVS8-92(1) Windows/Unix 8-bit Baltic}
  AddCodePage('LV8PC8LR', 166, ceAnsi, zCP_DOS866); {Latvian Version IBM-PC Code Page 866 8-bit Latin/Cyrillic}
  AddCodePage('WE8NCR4970', 167); {NCR 4970 8-bit West European}
  AddCodePage('WE8NEXTSTEP', 168); {NeXTSTEP PostScript 8-bit West European}
  AddCodePage('CL8ISOIR111', 169); {ISOIR111 Cyrillic}
  AddCodePage('CL8KOI8R', 170, ceAnsi, zCP_KOI8R); {RELCOM Internet Standard 8-bit Latin/Cyrillic}
  AddCodePage('CL8KOI8U', 171); {KOI8 Ukrainian Cyrillic}
  AddCodePage('US8BS2000', 172); {Siemens 9750-62 EBCDIC 8-bit American}
  AddCodePage('DK8BS2000', 173); {Siemens 9750-62 EBCDIC 8-bit Danish}
  AddCodePage('F8BS2000', 174); {Siemens 9750-62 EBCDIC 8-bit French}
  AddCodePage('D8BS2000', 175); {Siemens 9750-62 EBCDIC 8-bit German}
  AddCodePage('E8BS2000', 176); {Siemens 9750-62 EBCDIC 8-bit Spanish}
  AddCodePage('S8BS2000', 177); {Siemens 9750-62 EBCDIC 8-bit Swedish}
  AddCodePage('DK7SIEMENS9780X', 178); {Siemens 97801/97808 7-bit Danish}
  AddCodePage('F7SIEMENS9780X', 179); {Siemens 97801/97808 7-bit French}
  AddCodePage('D7SIEMENS9780X', 180); {Siemens 97801/97808 7-bit German}
  AddCodePage('I7SIEMENS9780X', 181); {Siemens 97801/97808 7-bit Italian}
  AddCodePage('N7SIEMENS9780X', 182); {Siemens 97801/97808 7-bit Norwegian}
  AddCodePage('E7SIEMENS9780X', 183); {Siemens 97801/97808 7-bit Spanish}
  AddCodePage('S7SIEMENS9780X', 184); {Siemens 97801/97808 7-bit Swedish}
  AddCodePage('EE8BS2000', 185); {Siemens EBCDIC.DF.04 8-bit East European}
  AddCodePage('WE8BS2000', 186); {Siemens EBCDIC.DF.04 8-bit West European}
  AddCodePage('WE8BS2000E', 187); {Siemens EBCDIC.DF.04 8-bit West European}
  AddCodePage('CL8BS2000', 188); {Siemens EBCDIC.EHC.LC 8-bit Cyrillic}
  AddCodePage('WE8EBCDIC37C', 189); {EBCDIC Code Page 37 8-bit Oracle/c}
  AddCodePage('IW8EBCDIC424', 190); {EBCDIC Code Page 424 8-bit Latin/Hebrew}
  AddCodePage('IW8EBCDIC424S', 191); {EBCDIC Code Page 424 Server 8-bit Latin/Hebrew}
  AddCodePage('WE8EBCDIC500C', 192); {EBCDIC Code Page 500 8-bit Oracle/c}
  AddCodePage('IW8EBCDIC1086', 193); {EBCDIC Code Page 1086 8-bit Hebrew}
  AddCodePage('AR8EBCDIC420S', 194); {EBCDIC Code Page 420 Server 8-bit Latin/Arabic}
  AddCodePage('AR8EBCDICX', 195); {EBCDIC XBASIC Server 8-bit Latin/Arabic}
  AddCodePage('TR8EBCDIC1026', 196, ceAnsi, zCP_IBM1026); {EBCDIC Code Page 1026 8-bit Turkish}
  AddCodePage('TR8EBCDIC1026S', 197); {EBCDIC Code Page 1026 Server 8-bit Turkish}
  AddCodePage('AR8HPARABIC8T', 198); {HP 8-bit Latin/Arabic}
  AddCodePage('TR8PC857', 199); {IBM-PC Code Page 857 8-bit Turkish}
  AddCodePage('IW8PC1507', 200); {IBM-PC Code Page 1507/862 8-bit Latin/Hebrew}
  AddCodePage('AR8ISO8859P6', 201); {ISO 8859-6 Latin/Arabic}
  AddCodePage('IW8ISO8859P8', 201); {ISO 8859-8 Latin/Hebrew}
  AddCodePage('WE8ISO8859P9', 203); {ISO 8859-9 West European & Turkish}
  AddCodePage('LA8ISO6937', 204); {ISO 6937 8-bit Coded Character Set for Text Communication}
  AddCodePage('IW7IS960', 205); {Israeli Standard 960 7-bit Latin/Hebrew}
  AddCodePage('IW8MACHEBREW', 206); {Mac Client 8-bit Hebrew}
  AddCodePage('AR8ARABICMACT', 207); {Mac 8-bit Latin/Arabic}
  AddCodePage('TR8MACTURKISH', 208); {Mac Client 8-bit Turkish}
  AddCodePage('IW8MACHEBREWS', 209); {Mac Server 8-bit Hebrew}
  AddCodePage('TR8MACTURKISHS', 210); {Mac Server 8-bit Turkish}
  AddCodePage('TR8MSWIN1254', 211); {MS Windows Code Page 1254 8-bit Turkish}
  AddCodePage('IW8MSWIN1255', 212); {MS Windows Code Page 1255 8-bit Latin/Hebrew}
  AddCodePage('AR8MSWIN1256', 213); {MS Windows Code Page 1256 8-Bit Latin/Arabic}
  AddCodePage('IN8ISCII', 214); {Multiple-Script Indian Standard 8-bit Latin/Indian Languages}
  AddCodePage('AR8MUSSAD768', 215); {Mussa'd Alarabi/2 768 Server 8-bit Latin/Arabic}
  AddCodePage('AR8MUSSAD768T', 216); {Mussa'd Alarabi/2 768 8-bit Latin/Arabic}
  AddCodePage('AR8NAFITHA711', 217); {Nafitha Enhanced 711 Server 8-bit Latin/Arabic}
  AddCodePage('AR8NAFITHA711T', 218); {Nafitha Enhanced 711 8-bit Latin/Arabic}
  AddCodePage('AR8NAFITHA721', 219); {Nafitha International 721 Server 8-bit Latin/Arabic}
  AddCodePage('AR8NAFITHA721T', 220); {Nafitha International 721 8-bit Latin/Arabic}
  AddCodePage('AR8SAKHR706', 221); {SAKHR 706 Server 8-bit Latin/Arabic}
  AddCodePage('AR8SAKHR707', 222); {SAKHR 707 Server 8-bit Latin/Arabic}
  AddCodePage('AR8SAKHR707T', 223); {SAKHR 707 8-bit Latin/Arabic}
  AddCodePage('AR8XBASIC', 224); {XBASIC 8-bit Latin/Arabic}
  AddCodePage('WE8BS2000L5', 225); {Siemens EBCDIC.DF.04.L5 8-bit West European/Turkish})
  AddCodePage('UTF8', 871, ceUTF8, zCP_UTF8); {Unicode 3.0 UTF-8 Universal character set, CESU-8 compliant}
  AddCodePage('UTFE', 227, ceUTF8, zCP_UTF8); {EBCDIC form of Unicode 3.0 UTF-8 Universal character set}
*)

  //All supporteds from XE
  AddCodePage('US7ASCII', 1, ceAnsi, zCP_us_ascii);
  AddCodePage('US8PC437', 4, ceAnsi, zCP_DOS437);
  AddCodePage('WE8PC850', 10, ceAnsi, zCP_DOS850);
  AddCodePage('WE8PC858', 28, ceAnsi, zCP_DOS858);
  AddCodePage('WE8ISO8859P1', 31, ceAnsi, zCP_L1_ISO_8859_1);
  AddCodePage('EE8ISO8859P2', 32, ceAnsi, zCP_L2_ISO_8859_2);
  AddCodePage('SE8ISO8859P3', 33, ceAnsi, zCP_L3_ISO_8859_3);
  AddCodePage('NEE8ISO8859P4', 34, ceAnsi, zCP_L4_ISO_8859_4);
  AddCodePage('CL8ISO8859P5', 35, ceAnsi, zCP_L5_ISO_8859_5);
  AddCodePage('AR8ISO8859P6', 36, ceAnsi, zCP_L6_ISO_8859_6);
  AddCodePage('EL8ISO8859P7', 37, ceAnsi, zCP_L7_ISO_8859_7);
  AddCodePage('IW8ISO8859P8', 38, ceAnsi, zCP_L8_ISO_8859_8);
  AddCodePage('WE8ISO8859P9', 39, ceAnsi, zCP_L5_ISO_8859_9);
  AddCodePage('NE8ISO8859P10', 40, ceAnsi, zCP_L6_ISO_8859_10);
  AddCodePage('TH8TISASCII', 41, ceAnsi);
  AddCodePage('VN8MSWIN1258', 45, ceAnsi, zCP_WIN1258);
  AddCodePage('WE8ISO8859P15', 46, ceAnsi, zCP_L9_ISO_8859_15);
  AddCodePage('BLT8ISO8859P13', 47, ceAnsi, zCP_L7_ISO_8859_13);
  AddCodePage('CEL8ISO8859P14', 48, ceAnsi, zCP_L8_ISO_8859_14);
  AddCodePage('CL8KOI8U', 51, ceAnsi, zCP_KOI8U);
  AddCodePage('AZ8ISO8859P9E', 52, ceAnsi);
  AddCodePage('EE8PC852', 150, ceAnsi, zCP_DOS852);
  AddCodePage('RU8PC866', 152, ceAnsi, zCP_DOS856);
  AddCodePage('TR8PC857', 156, ceAnsi, zCP_DOS857);
  AddCodePage('EE8MSWIN1250', 170, ceAnsi, zCP_WIN1250);
  AddCodePage('CL8MSWIN1251', 171, ceAnsi, zCP_WIN1251);
  AddCodePage('ET8MSWIN923', 172, ceAnsi, zCP_MSWIN923);
  AddCodePage('EL8MSWIN1253', 174, ceAnsi, zCP_WIN1253);
  AddCodePage('IW8MSWIN1255', 175, ceAnsi, zCP_WIN1255);
  AddCodePage('LT8MSWIN921', 176, ceAnsi, zCP_MSWIN921);
  AddCodePage('TR8MSWIN1254', 177, ceAnsi, zCP_WIN1254);
  AddCodePage('WE8MSWIN1252', 178, ceAnsi, zCP_WIN1252);
  AddCodePage('BLT8MSWIN1257', 179, ceAnsi, zCP_WIN1257);
  AddCodePage('BLT8CP921', 191, ceAnsi, 921);
  AddCodePage('CL8KOI8R', 196, ceAnsi, zCP_KOI8R);
  AddCodePage('BLT8PC775', 197, ceAnsi, zCP_DOS775);
  AddCodePage('EL8PC737', 382, ceAnsi, zCP_DOS737);
  AddCodePage('AR8ASMO8X', 500, ceAnsi);
  AddCodePage('AR8ADOS720', 558, ceAnsi, zCP_DOS720);
  AddCodePage('AR8MSWIN1256', 560, ceAnsi, cCP_WIN1256);
  AddCodePage('JA16EUC', 830, ceAnsi, zCP_euc_JP_win);
  AddCodePage('JA16SJIS', 832, ceAnsi, zCP_csISO2022JP);
  AddCodePage('JA16EUCTILDE', 837, ceAnsi);
  AddCodePage('JA16SJISTILDE', 838, ceAnsi);
  AddCodePage('KO16KSC5601', 840, ceAnsi, 601);
  AddCodePage('KO16MSWIN949', 846, ceAnsi, zCP_EUCKR);
  AddCodePage('ZHS16CGB231280', 850, ceAnsi, zCP_GB2312);
  AddCodePage('ZHS16GBK', 852, ceAnsi);
  AddCodePage('ZHS32GB18030', 854, ceAnsi, zCP_GB18030);
  AddCodePage('ZHT32EUC', 860, ceAnsi, zCP_EUCKR);
  AddCodePage('ZHT16BIG5', 865, ceAnsi, zCP_Big5);
  AddCodePage('ZHT16MSWIN950', 867, ceAnsi, zCP_Big5);
  AddCodePage('ZHT16HKSCS', 868, ceAnsi);
  AddCodePage('UTF8', 871, ceUTF8, zCP_UTF8);
  AddCodePage('AL32UTF8', 873, ceUTF8, zCP_UTF8);
  AddCodePage('UTF16', 1000, ceUTF16, zCP_UTF16);
  AddCodePage('AL16UTF16', 2000, ceUTF16, zCP_UTF16);
  AddCodePage('AL16UTF16LE', 2002, ceUTF16, zCP_UTF16);
end;

procedure TZOracle9iPlainDriver.LoadApi;
begin
{ ************** Load adresses of API Functions ************* }
  with Loader do
  begin
    @OracleAPI.OCIEnvCreate       := GetAddress('OCIEnvCreate');
    @OracleAPI.OCIEnvNlsCreate    := GetAddress('OCIEnvNlsCreate');
    @OracleAPI.OCIInitialize      := GetAddress('OCIInitialize');
    @OracleAPI.OCIEnvInit         := GetAddress('OCIEnvInit');

    @OracleAPI.OCIHandleAlloc     := GetAddress('OCIHandleAlloc');
    @OracleAPI.OCIHandleFree      := GetAddress('OCIHandleFree');
    @OracleAPI.OCIAttrSet         := GetAddress('OCIAttrSet');
    @OracleAPI.OCIAttrGet         := GetAddress('OCIAttrGet');
    @OracleAPI.OCIDescriptorAlloc := GetAddress('OCIDescriptorAlloc');
    @OracleAPI.OCIDescriptorFree  := GetAddress('OCIDescriptorFree');
    @OracleAPI.OCIErrorGet        := GetAddress('OCIErrorGet');

    @OracleAPI.OCIServerAttach    := GetAddress('OCIServerAttach');
    @OracleAPI.OCIServerDetach    := GetAddress('OCIServerDetach');
    @OracleAPI.OCIServerVersion   := GetAddress('OCIServerVersion');
    @OracleAPI.OCIServerRelease   := GetAddress('OCIServerRelease');
    @OracleAPI.OCIBreak           := GetAddress('OCIBreak');

    { For Oracle >= 8.1 }
    @OracleAPI.OCIReset           := GetAddress('OCIReset');

    @OracleAPI.OCISessionBegin    := GetAddress('OCISessionBegin');
    @OracleAPI.OCISessionEnd      := GetAddress('OCISessionEnd');
    @OracleAPI.OCIPasswordChange  := GetAddress('OCIPasswordChange');

    @OracleAPI.OCITransStart      := GetAddress('OCITransStart');
    @OracleAPI.OCITransCommit     := GetAddress('OCITransCommit');
    @OracleAPI.OCITransRollback   := GetAddress('OCITransRollback');
    @OracleAPI.OCITransDetach     := GetAddress('OCITransDetach');
    @OracleAPI.OCITransPrepare    := GetAddress('OCITransPrepare');
    @OracleAPI.OCITransForget     := GetAddress('OCITransForget');

    @OracleAPI.OCIStmtPrepare     := GetAddress('OCIStmtPrepare');
    @OracleAPI.OCIStmtExecute     := GetAddress('OCIStmtExecute');
    @OracleAPI.OCIStmtFetch       := GetAddress('OCIStmtFetch');
    @OracleAPI.OCIStmtGetPieceInfo := GetAddress('OCIStmtGetPieceInfo');
    @OracleAPI.OCIStmtSetPieceInfo := GetAddress('OCIStmtSetPieceInfo');
    @OracleAPI.OCIParamGet        := GetAddress('OCIParamGet');
    @OracleAPI.OCIResultSetToStmt := GetAddress('OCIResultSetToStmt');

    @OracleAPI.OCIDefineByPos     := GetAddress('OCIDefineByPos');
    @OracleAPI.OCIDefineArrayOfStruct := GetAddress('OCIDefineArrayOfStruct');

    @OracleAPI.OCIBindByPos       := GetAddress('OCIBindByPos');
    @OracleAPI.OCIBindByName      := GetAddress('OCIBindByName');
    @OracleAPI.OCIBindDynamic     := GetAddress('OCIBindDynamic');
    @OracleAPI.OCIBindObject      := GetAddress('OCIBindObject');

    @OracleAPI.OCIDefineObject    := GetAddress('OCIDefineObject');

    { > ori.h }
    @OracleAPI.OCIObjectNew                   := GetAddress('OCIObjectNew');
    @OracleAPI.OCIObjectPin                   := GetAddress('OCIObjectPin');
    @OracleAPI.OCIObjectUnpin                 := GetAddress('OCIObjectUnpin');
    @OracleAPI.OCIObjectPinCountReset         := GetAddress('OCIObjectPinCountReset');
    @OracleAPI.OCIObjectLock                  := GetAddress('OCIObjectLock');
    @OracleAPI.OCIObjectLockNoWait            := GetAddress('OCIObjectLockNoWait');
    @OracleAPI.OCIObjectMarkUpdate            := GetAddress('OCIObjectMarkUpdate');
    @OracleAPI.OCIObjectUnmark                := GetAddress('OCIObjectUnmark');
    @OracleAPI.OCIObjectUnmarkByRef           := GetAddress('OCIObjectUnmarkByRef');
    @OracleAPI.OCIObjectFree                  := GetAddress('OCIObjectFree');
    @OracleAPI.OCIObjectMarkDeleteByRef       := GetAddress('OCIObjectMarkDeleteByRef');
    @OracleAPI.OCIObjectMarkDelete            := GetAddress('OCIObjectMarkDelete');
    @OracleAPI.OCIObjectFlush                 := GetAddress('OCIObjectFlush');
    @OracleAPI.OCIObjectRefresh               := GetAddress('OCIObjectRefresh');
    @OracleAPI.OCIObjectCopy                  := GetAddress('OCIObjectCopy');
    @OracleAPI.OCIObjectGetTypeRef            := GetAddress('OCIObjectGetTypeRef');
    @OracleAPI.OCIObjectGetObjectRef          := GetAddress('OCIObjectGetObjectRef');
    @OracleAPI.OCIObjectMakeObjectRef         := GetAddress('OCIObjectMakeObjectRef');
    @OracleAPI.OCIObjectGetPrimaryKeyTypeRef  := GetAddress('OCIObjectGetPrimaryKeyTypeRef');
    @OracleAPI.OCIObjectGetInd                := GetAddress('OCIObjectGetInd');
    @OracleAPI.OCIObjectExists                := GetAddress('OCIObjectExists');
    @OracleAPI.OCIObjectGetProperty           := GetAddress('OCIObjectGetProperty');
    @OracleAPI.OCIObjectIsLocked              := GetAddress('OCIObjectIsLocked');
    @OracleAPI.OCIObjectIsDirty               := GetAddress('OCIObjectIsDirty');
    @OracleAPI.OCIObjectPinTable              := GetAddress('OCIObjectPinTable');
    @OracleAPI.OCIObjectArrayPin              := GetAddress('OCIObjectArrayPin');
    @OracleAPI.OCICacheFlush                  := GetAddress('OCICacheFlush');
    @OracleAPI.OCICacheRefresh                := GetAddress('OCICacheRefresh');
    @OracleAPI.OCICacheUnpin                  := GetAddress('OCICacheUnpin');
    @OracleAPI.OCICacheFree                   := GetAddress('OCICacheFree');
    @OracleAPI.OCICacheUnmark                 := GetAddress('OCICacheUnmark');
    @OracleAPI.OCIDurationBegin               := GetAddress('OCIDurationBegin');
    @OracleAPI.OCIDurationEnd                 := GetAddress('OCIDurationEnd');
    { < ori.h }

    @OracleAPI.OCILobAppend                   := GetAddress('OCILobAppend');
    @OracleAPI.OCILobAssign                   := GetAddress('OCILobAssign');
    @OracleAPI.OCILobCopy                     := GetAddress('OCILobCopy');
    @OracleAPI.OCILobEnableBuffering          := GetAddress('OCILobEnableBuffering');
    @OracleAPI.OCILobDisableBuffering         := GetAddress('OCILobDisableBuffering');
    @OracleAPI.OCILobErase                    := GetAddress('OCILobErase');
    @OracleAPI.OCILobFileExists               := GetAddress('OCILobFileExists');
    @OracleAPI.OCILobFileGetName              := GetAddress('OCILobFileGetName');
    @OracleAPI.OCILobFileSetName              := GetAddress('OCILobFileSetName');
    @OracleAPI.OCILobFlushBuffer              := GetAddress('OCILobFlushBuffer');
    @OracleAPI.OCILobGetLength                := GetAddress('OCILobGetLength');
    @OracleAPI.OCILobLoadFromFile             := GetAddress('OCILobLoadFromFile');
    @OracleAPI.OCILobLocatorIsInit            := GetAddress('OCILobLocatorIsInit');
    @OracleAPI.OCILobRead                     := GetAddress('OCILobRead');
    @OracleAPI.OCILobTrim                     := GetAddress('OCILobTrim');
    @OracleAPI.OCILobWrite                    := GetAddress('OCILobWrite');

    { For Oracle >= 8.1 }
    @OracleAPI.OCILobCreateTemporary          := GetAddress('OCILobCreateTemporary');
    @OracleAPI.OCILobFreeTemporary            := GetAddress('OCILobFreeTemporary');
    @OracleAPI.OCILobCharSetForm              := GetAddress('OCILobCharSetForm');
    @OracleAPI.OCILobCharSetId                := GetAddress('OCILobCharSetId');
    @OracleAPI.OCILobClose                    := GetAddress('OCILobClose');
    @OracleAPI.OCILobIsOpen                   := GetAddress('OCILobIsOpen');
    @OracleAPI.OCILobIsTemporary              := GetAddress('OCILobIsTemporary');
    @OracleAPI.OCILobOpen                     := GetAddress('OCILobOpen');

    @OracleAPI.OCIDateTimeAssign              := GetAddress('OCIDateTimeAssign');
    @OracleAPI.OCIDateTimeCheck               := GetAddress('OCIDateTimeCheck');
    @OracleAPI.OCIDateTimeCompare             := GetAddress('OCIDateTimeCompare');
    @OracleAPI.OCIDateTimeConvert             := GetAddress('OCIDateTimeConvert');
    @OracleAPI.OCIDateTimeFromText            := GetAddress('OCIDateTimeFromText');
    @OracleAPI.OCIDateTimeGetDate             := GetAddress('OCIDateTimeGetDate');
    @OracleAPI.OCIDateTimeGetTime             := GetAddress('OCIDateTimeGetTime');
    @OracleAPI.OCIDateTimeGetTimeZoneOffset   := GetAddress('OCIDateTimeGetTimeZoneOffset');
    @OracleAPI.OCIDateTimeSysTimeStamp        := GetAddress('OCIDateTimeSysTimeStamp');
    @OracleAPI.OCIDateTimeConstruct           := GetAddress('OCIDateTimeConstruct');
    @OracleAPI.OCIDateTimeToText              := GetAddress('OCIDateTimeToText');
    @OracleAPI.OCIDateTimeGetTimeZoneName     := GetAddress('OCIDateTimeGetTimeZoneName');
    @OracleAPI.OCINlsNumericInfoGet           := GetAddress('OCINlsNumericInfoGet');
    @OracleAPI.OCIClientVersion               := GetAddress('OCIClientVersion');

    { For Oracle < 8.1 }
    //@OracleAPI.OCILobClose        := GetAddress('OCILobFileClose');
    //@OracleAPI.OCILobIsOpen       := GetAddress('OCILobFileIsOpen');
    //@OracleAPI.OCILobOpen         := GetAddress('OCILobFileOpen');

    @OracleAPI.OCIDescribeAny     := GetAddress('OCIDescribeAny');

    { OCI Number mapping }
    @OracleAPI.OCINumberInc       := GetAddress('OCINumberInc');
    @OracleAPI.OCINumberDec       := GetAddress('OCINumberDec');
    @OracleAPI.OCINumberSetZero   := GetAddress('OCINumberSetZero');
    @OracleAPI.OCINumberSetPi     := GetAddress('OCINumberSetPi');
    @OracleAPI.OCINumberAdd       := GetAddress('OCINumberAdd');
    @OracleAPI.OCINumberSub       := GetAddress('OCINumberSub');
    @OracleAPI.OCINumberMul       := GetAddress('OCINumberMul');
    @OracleAPI.OCINumberDiv       := GetAddress('OCINumberDiv');
    @OracleAPI.OCINumberMod       := GetAddress('OCINumberMod');
    @OracleAPI.OCINumberIntPower  := GetAddress('OCINumberIntPower');
    @OracleAPI.OCINumberShift     := GetAddress('OCINumberShift');
    @OracleAPI.OCINumberNeg       := GetAddress('OCINumberNeg');
    @OracleAPI.OCINumberToText    := GetAddress('OCINumberToText');
    @OracleAPI.OCINumberFromText  := GetAddress('OCINumberFromText');
    @OracleAPI.OCINumberToInt     := GetAddress('OCINumberToInt');
    @OracleAPI.OCINumberFromInt   := GetAddress('OCINumberFromInt');
    @OracleAPI.OCINumberToReal    := GetAddress('OCINumberToReal');
    @OracleAPI.OCINumberToRealArray := GetAddress('OCINumberToRealArray');
    @OracleAPI.OCINumberFromReal  := GetAddress('OCINumberFromReal');
    @OracleAPI.OCINumberCmp       := GetAddress('OCINumberCmp');
    @OracleAPI.OCINumberSign      := GetAddress('OCINumberSign');
    @OracleAPI.OCINumberIsZero    := GetAddress('OCINumberIsZero');
    @OracleAPI.OCINumberIsInt     := GetAddress('OCINumberIsInt');
    @OracleAPI.OCINumberAssign    := GetAddress('OCINumberAssign');
    @OracleAPI.OCINumberAbs       := GetAddress('OCINumberAbs');
    @OracleAPI.OCINumberCeil      := GetAddress('OCINumberCeil');
    @OracleAPI.OCINumberFloor     := GetAddress('OCINumberFloor');
    @OracleAPI.OCINumberSqrt      := GetAddress('OCINumberSqrt');
    @OracleAPI.OCINumberTrunc     := GetAddress('OCINumberTrunc');
    @OracleAPI.OCINumberPower     := GetAddress('OCINumberPower');
    @OracleAPI.OCINumberRound     := GetAddress('OCINumberRound');
    @OracleAPI.OCINumberPrec      := GetAddress('OCINumberPrec');
    @OracleAPI.OCINumberSin       := GetAddress('OCINumberSin');
    @OracleAPI.OCINumberArcSin    := GetAddress('OCINumberArcSin');
    @OracleAPI.OCINumberHypSin    := GetAddress('OCINumberHypSin');
    @OracleAPI.OCINumberCos       := GetAddress('OCINumberCos');
    @OracleAPI.OCINumberArcCos    := GetAddress('OCINumberArcCos');
    @OracleAPI.OCINumberHypCos    := GetAddress('OCINumberHypCos');
    @OracleAPI.OCINumberTan       := GetAddress('OCINumberTan');
    @OracleAPI.OCINumberArcTan    := GetAddress('OCINumberArcTan');
    @OracleAPI.OCINumberArcTan2   := GetAddress('OCINumberArcTan2');
    @OracleAPI.OCINumberHypTan    := GetAddress('OCINumberHypTan');
    @OracleAPI.OCINumberExp       := GetAddress('OCINumberExp');
    @OracleAPI.OCINumberLn        := GetAddress('OCINumberLn');
    @OracleAPI.OCINumberLog       := GetAddress('OCINumberLog');

    @OracleAPI.OCITableSize       := GetAddress('OCITableSize');
    @OracleAPI.OCITableExists     := GetAddress('OCITableExists');
    @OracleAPI.OCITableDelete     := GetAddress('OCITableDelete');
    @OracleAPI.OCITableFirst      := GetAddress('OCITableFirst');
    @OracleAPI.OCITableLast       := GetAddress('OCITableLast');
    @OracleAPI.OCITableNext       := GetAddress('OCITableNext');
    @OracleAPI.OCITablePrev       := GetAddress('OCITablePrev');

    @OracleAPI.OCIObjectGetAttr   := GetAddress('OCIObjectGetAttr');
    @OracleAPI.OCIObjectSetAttr   := GetAddress('OCIObjectSetAttr');
    {ociap.h}
    @OracleAPI.OCIPing            := GetAddress('OCIPing');
    {ort.h}
    @OracleAPI.OCITypeIterNew     := GetAddress('OCITypeIterNew');
    @OracleAPI.OCITypeIterFree    := GetAddress('OCITypeIterFree');
    @OracleAPI.OCITypeByName      := GetAddress('OCITypeByName');
    @OracleAPI.OCITypeArrayByName := GetAddress('OCITypeArrayByName');
    @OracleAPI.OCITypeByRef       := GetAddress('OCITypeByRef');
    @OracleAPI.OCITypeArrayByRef  := GetAddress('OCITypeArrayByRef');
    @OracleAPI.OCITypeName        := GetAddress('OCITypeName');
    @OracleAPI.OCITypeSchema      := GetAddress('OCITypeSchema');
    @OracleAPI.OCITypeTypeCode    := GetAddress('OCITypeTypeCode');
    @OracleAPI.OCITypeCollTypeCode:= GetAddress('OCITypeCollTypeCode');
    @OracleAPI.OCITypeVersion     := GetAddress('OCITypeVersion');
    @OracleAPI.OCITypeAttrs       := GetAddress('OCITypeAttrs');
    @OracleAPI.OCITypeMethods     := GetAddress('OCITypeMethods');
    @OracleAPI.OCITypeElemName    := GetAddress('OCITypeElemName');
    @OracleAPI.OCITypeElemTypeCode:= GetAddress('OCITypeElemTypeCode');
    @OracleAPI.OCITypeElemType    := GetAddress('OCITypeElemType');
    @OracleAPI.OCITypeElemFlags   := GetAddress('OCITypeElemFlags');
    @OracleAPI.OCITypeElemNumPrec := GetAddress('OCITypeElemNumPrec');
    @OracleAPI.OCITypeElemNumScale:= GetAddress('OCITypeElemNumScale');
    @OracleAPI.OCITypeElemLength  := GetAddress('OCITypeElemLength');
    @OracleAPI.OCITypeElemCharSetID := GetAddress('OCITypeElemCharSetID');
    @OracleAPI.OCITypeElemCharSetForm := GetAddress('OCITypeElemCharSetForm');
    @OracleAPI.OCITypeElemParameterizedType := GetAddress('OCITypeElemParameterizedType');
    @OracleAPI.OCITypeElemExtTypeCode := GetAddress('OCITypeElemExtTypeCode');
    @OracleAPI.OCITypeAttrByName  := GetAddress('OCITypeAttrByName');
    @OracleAPI.OCITypeAttrNext    := GetAddress('OCITypeAttrNext');
    @OracleAPI.OCITypeCollElem    := GetAddress('OCITypeCollElem');
    @OracleAPI.OCITypeCollSize    := GetAddress('OCITypeCollSize');
    @OracleAPI.OCITypeCollExtTypeCode := GetAddress('OCITypeCollExtTypeCode');
    @OracleAPI.OCITypeMethodOverload  := GetAddress('OCITypeMethodOverload');
    @OracleAPI.OCITypeMethodByName:= GetAddress('OCITypeMethodByName');
    @OracleAPI.OCITypeMethodNext  := GetAddress('OCITypeMethodNext');
    @OracleAPI.OCITypeMethodName  := GetAddress('OCITypeMethodName');
    @OracleAPI.OCITypeMethodEncap := GetAddress('OCITypeMethodEncap');
    @OracleAPI.OCITypeMethodFlags := GetAddress('OCITypeMethodFlags');
    @OracleAPI.OCITypeMethodMap   := GetAddress('OCITypeMethodMap');
    @OracleAPI.OCITypeMethodOrder := GetAddress('OCITypeMethodOrder');
    @OracleAPI.OCITypeMethodParams:= GetAddress('OCITypeMethodParams');
    @OracleAPI.OCITypeResult      := GetAddress('OCITypeResult');
    @OracleAPI.OCITypeParamByPos  := GetAddress('OCITypeParamByPos');
    @OracleAPI.OCITypeParamByName := GetAddress('OCITypeParamByName');
    @OracleAPI.OCITypeParamPos    := GetAddress('OCITypeParamPos');
    @OracleAPI.OCITypeElemParamMode := GetAddress('OCITypeElemParamMode');
    @OracleAPI.OCITypeElemDefaultValue := GetAddress('OCITypeElemDefaultValue');
    @OracleAPI.OCITypeVTInit      := GetAddress('OCITypeVTInit');
    @OracleAPI.OCITypeVTInsert    := GetAddress('OCITypeVTInsert');
    @OracleAPI.OCITypeVTSelect    := GetAddress('OCITypeVTSelect');
  end;
end;

function TZOracle9iPlainDriver.Clone: IZPlainDriver;
begin
  Result := TZOracle9iPlainDriver.Create;
end;

constructor TZOracle9iPlainDriver.Create;
begin
  inherited create;
  FLoader := TZNativeLibraryLoader.Create([]);
  {$IFNDEF UNIX}
    FLoader.AddLocation(WINDOWS_DLL_LOCATION);
  {$ELSE}
    FLoader.AddLocation(LINUX_DLL_LOCATION);
  {$ENDIF}
  LoadCodePages;
end;

function TZOracle9iPlainDriver.GetProtocol: string;
begin
  Result := 'oracle-9i';
end;

function TZOracle9iPlainDriver.GetDescription: string;
begin
  Result := 'Native Plain Driver for Oracle 9i';
end;

procedure TZOracle9iPlainDriver.Initialize(const Location: String);
begin
  inherited Initialize(Location);
  OracleAPI.OCIInitialize(OCI_THREADED, nil, nil, nil, nil);
end;

function TZOracle9iPlainDriver.AttrGet(trgthndlp: POCIHandle;
  trghndltyp: ub4; attributep, sizep: Pointer; attrtype: ub4;
  errhp: POCIError): sword;
begin
  Result := OracleAPI.OCIAttrGet(trgthndlp, trghndltyp, attributep, sizep,
    attrtype, errhp);
end;

function TZOracle9iPlainDriver.AttrSet(trgthndlp: POCIHandle;
  trghndltyp: ub4; attributep: Pointer; size, attrtype: ub4;
  errhp: POCIError): sword;
begin
  Result := OracleAPI.OCIAttrSet(trgthndlp, trghndltyp, attributep, size,
    attrtype, errhp);
end;

function TZOracle9iPlainDriver.BindByName(stmtp: POCIStmt;
  var bindpp: POCIBind; errhp: POCIError; placeholder: text;
  placeh_len: sb4; valuep: Pointer; value_sz: sb4; dty: ub2; indp, alenp,
  rcodep: Pointer; maxarr_len: ub4; curelep: Pointer; mode: ub4): sword;
begin
  Result := OracleAPI.OCIBindByName(stmtp, bindpp, errhp, placeholder,
    placeh_len, valuep, value_sz, dty, indp, alenp, rcodep, maxarr_len,
    curelep, mode);
end;

function TZOracle9iPlainDriver.BindByPos(stmtp: POCIStmt;
  var bindpp: POCIBind; errhp: POCIError; position: ub4; valuep: Pointer;
  value_sz: sb4; dty: ub2; indp, alenp, rcodep: Pointer; maxarr_len: ub4;
  curelep: Pointer; mode: ub4): sword;
begin
  Result := OracleAPI.OCIBindByPos(stmtp, bindpp, errhp, position, valuep,
    value_sz, dty, indp, alenp, rcodep, maxarr_len, curelep, mode);
end;

function TZOracle9iPlainDriver.BindDynamic(bindp: POCIBind;
  errhp: POCIError; ictxp, icbfp, octxp, ocbfp: Pointer): sword;
begin
  Result := OracleAPI.OCIBindDynamic(bindp, errhp, ictxp, icbfp, octxp,
    ocbfp);
end;

function TZOracle9iPlainDriver.BindObject(bindp: POCIBind; errhp: POCIError;
                const _type: POCIType; pgvpp: PPointer;
                pvszsp: pub4; indpp: PPointer;
                indszp: pub4): sword;
begin
  Result := OracleAPI.OCIBindObject(bindp, errhp, _type, pgvpp, pvszsp, indpp,
    indszp);
end;

function TZOracle9iPlainDriver.DefineObject(defnpp: POCIDefine;
  errhp: POCIError; _type: POCIHandle; pgvpp,pvszsp,indpp,indszp:pointer): sword;
begin
  Result := OracleAPI.OCIDefineObject(defnpp, errhp, _type, pgvpp, pvszsp,
    indpp, indszp);
end;

{ > ori.h}
function TZOracle9iPlainDriver.ObjectNew(env: POCIEnv; err: POCIError;
  const svc: POCISvcCtx; typecode: OCITypeCode; tdo: POCIType; table: Pointer;
  duration: OCIDuration; value: Longbool; instance: PPointer): sword;
begin
  Result := OracleAPI.OCIObjectNew(env, err, svc, typecode, tdo, table,
    duration, value, instance);
end;

function TZOracle9iPlainDriver.ObjectPin(env: POCIEnv; err: POCIError;
  const object_ref: POCIRef; const corhdl: POCIComplexObject;
  const pin_option: OCIPinOpt; const pin_duration: OCIDuration;
  const lock_option: OCILockOpt; _object: PPointer): sword;
begin
  Result := OracleAPI.OCIObjectPin(env, err, object_ref, corhdl,
    pin_option, pin_duration, lock_option, _object);
end;

function TZOracle9iPlainDriver.ObjectUnpin(env: POCIEnv; err: POCIError;
  const _object: Pointer): sword;
begin
  Result := OracleAPI.OCIObjectUnpin(env, err, _object);
end;

function TZOracle9iPlainDriver.ObjectPinCountReset(env: POCIEnv; err: POCIError;
  const _object: pointer): sword;
begin
  Result := OracleAPI.OCIObjectPinCountReset(env, err, _object);
end;

function TZOracle9iPlainDriver.ObjectLock(env: POCIEnv; err: POCIError;
  const _object: pointer): sword;
begin
  Result := OracleAPI.OCIObjectLock(env, err, _object);
end;

function TZOracle9iPlainDriver.ObjectLockNoWait(env: POCIEnv; err: POCIError;
  const _object: pointer): sword;
begin
  Result := OracleAPI.OCIObjectLockNoWait(env, err, _object);
end;

function TZOracle9iPlainDriver.ObjectMarkUpdate(env: POCIEnv; err: POCIError;
  const _object: pointer): sword;
begin
  Result := OracleAPI.OCIObjectMarkUpdate(env, err, _object);
end;

function TZOracle9iPlainDriver.ObjectUnmark(env: POCIEnv; err: POCIError;
  const _object:pointer): sword;
begin
  Result := OracleAPI.OCIObjectUnmark(env, err, _object);
end;

function TZOracle9iPlainDriver.ObjectUnmarkByRef(env: POCIEnv; err: POCIError;
  const ref: POCIRef): sword;
begin
  Result := OracleAPI.OCIObjectUnmarkByRef(env, err, ref);
end;

function TZOracle9iPlainDriver.ObjectFree(hndl: POCIEnv; err: POCIError;
  instance:POCIHandle;flags :ub2):sword;
begin
  Result := OracleAPI.OCIObjectFree(hndl, err, instance, flags);
end;

function TZOracle9iPlainDriver.ObjectMarkDeleteByRef(env: POCIEnv;
  err: POCIError; const object_ref:POCIRef): sword;
begin
  Result := OracleAPI.OCIObjectMarkDeleteByRef(env, err, object_ref);
end;

function TZOracle9iPlainDriver.ObjectMarkDelete(env: POCIEnv; err: POCIError;
  const instance:pointer): sword;
begin
  Result := OracleAPI.OCIObjectMarkDelete(env, err, instance);
end;

function TZOracle9iPlainDriver.ObjectFlush(env: POCIEnv; err: POCIError;
  const _object: pointer): sword;
begin
  Result := OracleAPI.OCIObjectFlush(env, err, _object);
end;

function TZOracle9iPlainDriver.ObjectRefresh(env: POCIEnv; err: POCIError;
  _object: pointer): sword;
begin
  Result := OracleAPI.OCIObjectRefresh(env, err, _object);
end;

function TZOracle9iPlainDriver.ObjectCopy(env: POCIEnv; err: POCIError;
  const svc: POCISvcCtx; const source, null_source, target, null_target: pointer;
  const tdo: POCIType; const duration: OCIDuration; const option: ub1): sword;
begin
  Result := OracleAPI.OCIObjectCopy(env, err, svc, source, null_source, target,
    null_target, tdo, duration, option);
end;

function TZOracle9iPlainDriver.ObjectGetTypeRef(env: POCIEnv; err: POCIError;
  const instance:pointer; type_ref: POCIRef): sword;
begin
  Result := OracleAPI.OCIObjectGetTypeRef(env, err, instance, type_ref);
end;

function TZOracle9iPlainDriver.ObjectGetObjectRef(env: POCIEnv; err: POCIError;
  const _object: pointer; object_ref: POCIRef): sword;
begin
  Result := OracleAPI.OCIObjectGetObjectRef(env, err, _object, object_ref);
end;

function TZOracle9iPlainDriver.ObjectMakeObjectRef(env: POCIEnv; err: POCIError;
  const svc: POCISvcCtx; const table: pointer; const values: PPointer;
  const array_len: ub4; object_ref: POCIRef): sword;
begin
  Result := OracleAPI.OCIObjectMakeObjectRef(env, err, svc, table, values,
    array_len, object_ref);
end;

function TZOracle9iPlainDriver.ObjectGetPrimaryKeyTypeRef(env: POCIEnv;
  err: POCIError; const svc:POCISvcCtx; const table: pointer;
  type_ref: POCIRef): sword;
begin
  Result := OracleAPI.OCIObjectGetPrimaryKeyTypeRef(env, err, svc, table,
    type_ref);
end;

function TZOracle9iPlainDriver.ObjectGetInd(env: POCIEnv; err: POCIError;
  const instance: pointer; null_struct: PPointer): sword;
begin
  Result := OracleAPI.OCIObjectGetInd(env, err, instance, null_struct);
end;

function TZOracle9iPlainDriver.ObjectExists(env: POCIEnv; err: POCIError;
  const ins: pointer; exist: PBoolean): sword;
begin
  Result := OracleAPI.OCIObjectExists(env, err, ins, exist);
end;

function TZOracle9iPlainDriver.ObjectGetProperty(envh: POCIEnv; errh: POCIError;
  const obj: pointer; const propertyId: OCIObjectPropId;
  _property: pointer; size: Pub4): sword;
begin
  Result := OracleAPI.OCIObjectGetProperty(envh, errh, obj, propertyId,
    _property, size);
end;

function TZOracle9iPlainDriver.ObjectIsLocked(env: POCIEnv; err: POCIError;
  const ins: pointer; lock: Pboolean): sword;
begin
  Result := OracleAPI.OCIObjectIsLocked(env, err, ins, lock);
end;

function TZOracle9iPlainDriver.ObjectIsDirty(env: POCIEnv; err: POCIError;
  const ins: pointer; dirty: PBoolean): sword;
begin
  Result := OracleAPI.OCIObjectIsDirty(env, err, ins, dirty);
end;

function TZOracle9iPlainDriver.ObjectPinTable(env: POCIEnv; err: POCIError;
  const svc:POCISvcCtx; const schema_name: Poratext; const s_n_length: ub4;
  const object_name: Poratext; const o_n_length:ub4;
  const scope_obj_ref: POCIRef; const pin_duration: OCIDuration;
  _object: PPointer): sword;
begin
  Result := OracleAPI.OCIObjectPinTable(env, err, svc, schema_name, s_n_length,
    object_name, o_n_length, scope_obj_ref, pin_duration, _object);
end;

function TZOracle9iPlainDriver.ObjectArrayPin(env: POCIEnv; err: POCIError;
  const ref_array: PPOCIRef; const array_size: ub4;
  const cor_array: PPOCIComplexObject; const cor_array_size: ub4;
  const pin_option: OCIPinOpt; const pin_duration: OCIDuration;
  const lock: OCILockOpt; obj_array: PPointer;
  pos: Pub4): sword;
begin
  Result := OracleAPI.OCIObjectArrayPin(env, err, ref_array, array_size,
    cor_array, cor_array_size, pin_option, pin_duration, lock, obj_array, pos);
end;

function TZOracle9iPlainDriver.CacheFlush(env: POCIEnv; err: POCIError;
  const svc:POCISvcCtx; const context: pointer; const get: TOCICacheFlushGet;
  ref: PPOCIRef): sword;
begin
  Result := OracleAPI.OCICacheFlush(env, err, svc, context, get, ref);
end;

function TZOracle9iPlainDriver.CacheRefresh(env: POCIEnv; err: POCIError;
  const svc:POCISvcCtx; const option: OCIRefreshOpt; const context: pointer;
  get: TOCICacheRefreshGet; ref: PPOCIRef): sword;
begin
  Result := OracleAPI.OCICacheRefresh(env, err, svc, option, context, get, ref);
end;

function TZOracle9iPlainDriver.CacheUnpin(env: POCIEnv; err: POCIError;
  const svc:POCISvcCtx): sword;
begin
  Result := OracleAPI.OCICacheUnpin(env, err, svc);
end;

function TZOracle9iPlainDriver.CacheFree(env: POCIEnv; err: POCIError;
  const svc: POCISvcCtx): sword;
begin
  Result := OracleAPI.OCICacheFree(env, err, svc);
end;

function TZOracle9iPlainDriver.CacheUnmark(env: POCIEnv; err: POCIError;
  const svc: POCISvcCtx): sword;
begin
  Result := OracleAPI.OCICacheUnmark(env, err, svc);
end;

function TZOracle9iPlainDriver.DurationBegin(env: POCIEnv; err: POCIError;
  svc: POCISvcCtx; const parent: OCIDuration;
  dur: POCIDuration): sword;
begin
  Result := OracleAPI.OCIDurationBegin(env, err, svc, parent, dur);
end;

function TZOracle9iPlainDriver.DurationEnd(env: POCIEnv; err: POCIError;
  svc: POCISvcCtx; duration: OCIDuration): sword;
begin
  Result := OracleAPI.OCIDurationEnd(env, err, svc, duration);
end;
{ < ori.h}

function TZOracle9iPlainDriver.Break(svchp: POCISvcCtx;
  errhp: POCIError): sword;
begin
  Result := OracleAPI.OCIBreak(svchp, errhp);
end;

function TZOracle9iPlainDriver.DefineArrayOfStruct(defnpp: POCIDefine;
  errhp: POCIError; pvskip, indskip, rlskip, rcskip: ub4): sword;
begin
  Result := OracleAPI.OCIDefineArrayOfStruct(defnpp, errhp, pvskip,
    indskip, rlskip, rcskip);
end;

function TZOracle9iPlainDriver.DefineByPos(stmtp: POCIStmt;
  var defnpp: POCIDefine; errhp: POCIError; position: ub4; valuep: Pointer;
  value_sz: sb4; dty: ub2; indp, rlenp, rcodep: Pointer; mode: ub4): sword;
begin
  Result := OracleAPI.OCIDefineByPos(stmtp, defnpp, errhp, position,
    valuep, value_sz, dty, indp, rlenp, rcodep, mode);
end;

function TZOracle9iPlainDriver.DescribeAny(svchp: POCISvcCtx;
  errhp: POCIError; objptr: Pointer; objnm_len: ub4; objptr_typ,
  info_level, objtyp: ub1; dschp: POCIDescribe): sword;
begin
  Result := OracleAPI.OCIDescribeAny(svchp, errhp, objptr,
    objnm_len, objptr_typ, info_level, objtyp, dschp);
end;

function TZOracle9iPlainDriver.DescriptorAlloc(parenth: POCIEnv;
  var descpp: POCIDescriptor; htype: ub4; xtramem_sz: integer;
  usrmempp: Pointer): sword;
begin
  Result := OracleAPI.OCIDescriptorAlloc(parenth, descpp, htype,
    xtramem_sz, usrmempp);
end;

function TZOracle9iPlainDriver.DescriptorFree(descp: Pointer;
  htype: ub4): sword;
begin
  Result := OracleAPI.OCIDescriptorFree(descp, htype);
end;

function TZOracle9iPlainDriver.EnvCreate(var envhpp: POCIEnv; mode: ub4;
  ctxp: Pointer; malocfp: Pointer; ralocfp: Pointer; mfreefp: Pointer;
  xtramemsz: size_T; usrmempp: PPointer): sword;
begin
  Result := OracleAPI.OCIEnvCreate(envhpp, mode, ctxp, malocfp, ralocfp,
    mfreefp, xtramemsz, usrmempp);
end;

function TZOracle9iPlainDriver.EnvNlsCreate(var envhpp: POCIEnv; mode: ub4;
  ctxp: Pointer; malocfp: Pointer; ralocfp: Pointer; mfreefp: Pointer;
  xtramemsz: size_T; usrmempp: PPointer; charset, ncharset: ub2): sword;
begin
  Result := OracleAPI.OCIEnvNlsCreate(envhpp, mode, ctxp, malocfp, ralocfp,
    mfreefp, xtramemsz, usrmempp, charset, ncharset);
end;

function TZOracle9iPlainDriver.EnvInit(var envhpp: POCIEnv; mode: ub4;
  xtramemsz: size_T; usrmempp: PPointer): sword;
begin
  Result := OracleAPI.OCIEnvInit(envhpp, mode, xtramemsz, usrmempp);
end;

function TZOracle9iPlainDriver.ErrorGet(hndlp: Pointer; recordno: ub4;
  sqlstate: text; var errcodep: sb4; bufp: text; bufsiz,
  atype: ub4): sword;
begin
  Result := OracleAPI.OCIErrorGet(hndlp, recordno, sqlstate, errcodep,
    bufp, bufsiz, atype);
end;

function TZOracle9iPlainDriver.HandleAlloc(parenth: POCIHandle;
  var hndlpp: POCIHandle; atype: ub4; xtramem_sz: size_T;
  usrmempp: PPointer): sword;
begin
  Result := OracleAPI.OCIHandleAlloc(parenth, hndlpp, atype, xtramem_sz,
    usrmempp);
end;

function TZOracle9iPlainDriver.HandleFree(hndlp: Pointer; atype: ub4): sword;
begin
  Result := OracleAPI.OCIHandleFree(hndlp, atype);
end;

function TZOracle9iPlainDriver.Initializ(mode: ub4; ctxp, malocfp,
  ralocfp, mfreefp: Pointer): sword;
begin
  Result := OracleAPI.OCIInitialize(mode, ctxp, malocfp, ralocfp, mfreefp);
end;

function TZOracle9iPlainDriver.LobAppend(svchp: POCISvcCtx;
  errhp: POCIError; dst_locp, src_locp: POCILobLocator): sword;
begin
  Result := OracleAPI.OCILobAppend(svchp, errhp, dst_locp, src_locp);
end;

function TZOracle9iPlainDriver.LobAssign(svchp: POCISvcCtx; errhp: POCIError;
  src_locp: POCILobLocator; var dst_locpp: POCILobLocator): sword;
begin
  Result := OracleAPI.OCILobAssign(svchp, errhp, src_locp, dst_locpp);
end;

function TZOracle9iPlainDriver.LobClose(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator): sword;
begin
  Result := OracleAPI.OCILobClose(svchp, errhp, locp);
end;

function TZOracle9iPlainDriver.LobCopy(svchp: POCISvcCtx; errhp: POCIError;
  dst_locp, src_locp: POCILobLocator; amount, dst_offset,
  src_offset: ub4): sword;
begin
  Result := OracleAPI.OCILobCopy(svchp, errhp, dst_locp, src_locp,
    amount, dst_offset, src_offset);
end;

function TZOracle9iPlainDriver.LobDisableBuffering(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator): sword;
begin
  Result := OracleAPI.OCILobDisableBuffering(svchp, errhp, locp);
end;

function TZOracle9iPlainDriver.LobEnableBuffering(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator): sword;
begin
  Result := OracleAPI.OCILobEnableBuffering(svchp, errhp, locp);
end;

function TZOracle9iPlainDriver.LobErase(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator; var amount: ub4;
  offset: ub4): sword;
begin
  Result := OracleAPI.OCILobErase(svchp, errhp, locp, amount, offset);
end;

function TZOracle9iPlainDriver.LobFileExists(svchp: POCISvcCtx;
  errhp: POCIError; filep: POCILobLocator; var flag: Boolean): sword;
begin
  Result := OracleAPI.OCILobFileExists(svchp, errhp, filep, flag);
end;

function TZOracle9iPlainDriver.LobFileGetName(envhp: POCIEnv;
  errhp: POCIError; filep: POCILobLocator; dir_alias: text;
  var d_length: ub2; filename: text; var f_length: ub2): sword;
begin
  Result := OracleAPI.OCILobFileGetName(envhp, errhp, filep, dir_alias,
    d_length, filename, f_length);
end;

function TZOracle9iPlainDriver.LobFileSetName(envhp: POCIEnv;
  errhp: POCIError; var filep: POCILobLocator; dir_alias: text;
  d_length: ub2; filename: text; f_length: ub2): sword;
begin
  Result := OracleAPI.OCILobFileSetName(envhp, errhp, filep, dir_alias,
    d_length, filename, f_length);
end;

function TZOracle9iPlainDriver.LobFlushBuffer(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator; flag: ub4): sword;
begin
  Result := OracleAPI.OCILobFlushBuffer(svchp, errhp, locp, flag);
end;

function TZOracle9iPlainDriver.LobGetLength(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator; var lenp: ub4): sword;
begin
  Result := OracleAPI.OCILobGetLength(svchp, errhp, locp, lenp);
end;

function TZOracle9iPlainDriver.LobIsOpen(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator; var flag: LongBool): sword;
begin
  Result := OracleAPI.OCILobIsOpen(svchp, errhp, locp, flag);
end;

function TZOracle9iPlainDriver.LobLoadFromFile(svchp: POCISvcCtx;
  errhp: POCIError; dst_locp, src_locp: POCILobLocator; amount, dst_offset,
  src_offset: ub4): sword;
begin
  Result := OracleAPI.OCILobLoadFromFile(svchp, errhp, dst_locp, src_locp,
    amount, dst_offset, src_offset);
end;

function TZOracle9iPlainDriver.LobLocatorIsInit(envhp: POCIEnv;
  errhp: POCIError; locp: POCILobLocator;
  var is_initialized: LongBool): sword;
begin
  Result := OracleAPI.OCILobLocatorIsInit(envhp, errhp, locp,
    is_initialized);
end;

function TZOracle9iPlainDriver.LobOpen(svchp: POCISvcCtx; errhp: POCIError;
  locp: POCILobLocator; mode: ub1): sword;
begin
  Result := OracleAPI.OCILobOpen(svchp, errhp, locp, mode);
end;

function TZOracle9iPlainDriver.LobRead(svchp: POCISvcCtx; errhp: POCIError;
  locp: POCILobLocator; var amtp: ub4; offset: ub4; bufp: Pointer;
  bufl: ub4; ctxp, cbfp: Pointer; csid: ub2; csfrm: ub1): sword;
begin
  Result := OracleAPI.OCILobRead(svchp, errhp, locp, amtp, offset, bufp,
    bufl, ctxp, cbfp, csid, csfrm);
end;

function TZOracle9iPlainDriver.LobTrim(svchp: POCISvcCtx; errhp: POCIError;
  locp: POCILobLocator; newlen: ub4): sword;
begin
  Result := OracleAPI.OCILobTrim(svchp, errhp, locp, newlen);
end;

function TZOracle9iPlainDriver.LobWrite(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator; var amtp: ub4; offset: ub4;
  bufp: Pointer; bufl: ub4; piece: ub1; ctxp, cbfp: Pointer; csid: ub2;
  csfrm: ub1): sword;
begin
  Result := OracleAPI.OCILobWrite(svchp, errhp, locp, amtp, offset,
    bufp, bufl, piece, ctxp, cbfp, csid, csfrm);
end;

function TZOracle9iPlainDriver.LobCreateTemporary(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator; csid: ub2; csfrm, lobtype: ub1;
  cache: LongBool; duration: OCIDuration): sword;
begin
  Result := OracleAPI.OCILobCreateTemporary(svchp, errhp, locp,
    csid, csfrm, lobtype, cache, duration);
end;

function TZOracle9iPlainDriver.LobFreeTemporary(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator): sword;
begin
  Result := OracleAPI.OCILobFreeTemporary(svchp, errhp, locp);
end;

function TZOracle9iPlainDriver.LobCharSetForm ( envhp: POCIEnv; errhp: POCIError;
    const locp: POCILobLocator; csfrm: pub1): sword;
begin
  Result := OracleAPI.OCILobCharSetForm(envhp, errhp, locp, csfrm);
end;

function TZOracle9iPlainDriver.LobCharSetId ( envhp: POCIEnv; errhp: POCIError;
    const locp: POCILobLocator; csid: pub2): sword;
begin
  Result := OracleAPI.OCILobCharSetId (envhp, errhp, locp, csid);
end;

function TZOracle9iPlainDriver.LobIsTemporary(svchp: POCISvcCtx;
  errhp: POCIError; locp: POCILobLocator;
  var is_temporary: LongBool): sword;
begin
  Result := OracleAPI.OCILobIsTemporary(svchp, errhp, locp, is_temporary);
end;

function TZOracle9iPlainDriver.ParamGet(hndlp: Pointer; htype: ub4;
  errhp: POCIError; var parmdpp: Pointer; pos: ub4): sword;
begin
  Result := OracleAPI.OCIParamGet(hndlp, htype, errhp, parmdpp, pos);
end;

function TZOracle9iPlainDriver.PasswordChange(svchp: POCISvcCtx;
  errhp: POCIError; user_name: text; usernm_len: ub4; opasswd: text;
  opasswd_len: ub4; npasswd: text; npasswd_len: sb4; mode: ub4): sword;
begin
  Result := OracleAPI.OCIPasswordChange(svchp, errhp, user_name,
    usernm_len, opasswd, opasswd_len, npasswd, npasswd_len, mode);
end;

function TZOracle9iPlainDriver.Reset(svchp: POCISvcCtx;
  errhp: POCIError): sword;
begin
  Result := OracleAPI.OCIReset(svchp, errhp);
end;

function TZOracle9iPlainDriver.ResultSetToStmt(rsetdp: POCIHandle;
  errhp: POCIError): sword;
begin
  Result := OracleAPI.OCIResultSetToStmt(rsetdp, errhp);
end;

function TZOracle9iPlainDriver.GetEnvCharsetByteWidth(hndl: POCIEnv; err: POCIError;
  Value: sb4): sword;
begin
  Result := OracleAPI.OCINlsNumericInfoGet(hndl, err, @value, OCI_NLS_CHARSET_MAXBYTESZ);
end;

procedure TZOracle9iPlainDriver.ClientVersion(major_version, minor_version,
  update_num, patch_num, port_update_num: psword);
begin
  OracleAPI.OCIClientVersion(major_version, minor_version,
    update_num, patch_num, port_update_num);
end;

function TZOracle9iPlainDriver.NumberInc(err: POCIError; number: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberInc(err, number);
end;

function TZOracle9iPlainDriver.NumberDec(err: POCIError; number: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberDec(err, number);
end;

procedure TZOracle9iPlainDriver.NumberSetZero(err: POCIError; number: POCINumber);
begin
  OracleAPI.OCINumberSetZero(err, number);
end;

procedure TZOracle9iPlainDriver.NumberSetPi(err: POCIError; number: POCINumber);
begin
  OracleAPI.OCINumberSetPi(err, number);
end;

function  TZOracle9iPlainDriver.NumberAdd(err: POCIError; const number1: POCINumber;
  const number2: POCINumber; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberAdd(err, number1, number2, _result);
end;

function TZOracle9iPlainDriver.NumberSub(err: POCIError; const number1: POCINumber;
  const number2: POCINumber; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberSub(err, number1, number2, _result);
end;

function TZOracle9iPlainDriver.NumberMul(err: POCIError; const number1: POCINumber;
  const number2: POCINumber; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberMul(err, number1, number2, _result);
end;

function TZOracle9iPlainDriver.NumberDiv(err: POCIError; const number1: POCINumber;
  const number2: POCINumber; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberDiv(err, number1, number2, _result);
end;

function TZOracle9iPlainDriver.NumberMod(err: POCIError; const number1: POCINumber;
  const number2: POCINumber; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberMod(err, number1, number2, _result);
end;

function TZOracle9iPlainDriver.NumberIntPower(err: POCIError; const number1: POCINumber;
  const number2: POCINumber; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberIntPower(err, number1, number2, _result);
end;

function TZOracle9iPlainDriver.NumberShift(err: POCIError; const number: POCINumber;
  const nDig: sword; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberShift(err, number, nDig, _result);
end;

function TZOracle9iPlainDriver.NumberNeg(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberNeg(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberToText(err: POCIError; const number: POCINumber;
  const fmt: Poratext; fmt_length: ub4; const nls_params: Poratext;
  nls_p_length: ub4; buf_size: pub4; buf: poratext): sword;
begin
  Result := OracleAPI.OCINumberToText(err, number, fmt, fmt_length, nls_params,
    nls_p_length, buf_size, buf);
end;

function TZOracle9iPlainDriver.NumberFromText(err: POCIError; const str: poratext;
  str_length: ub4; const fmt: poratext; fmt_length: ub4;
  const nls_params: poratext; nls_p_length: ub4; number: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberFromText(err, str, str_length, fmt, fmt_length,
    nls_params, nls_p_length, number);
end;

function TZOracle9iPlainDriver.NumberToInt(err: POCIError; const number: POCINumber;
  rsl_length: uword; rsl_flag: uword; rsl: Pointer): sword;
begin
  Result := OracleAPI.OCINumberToInt(err, number, rsl_length, rsl_flag, rsl);
end;

function TZOracle9iPlainDriver.NumberFromInt(err: POCIError; const inum: Pointer;
  inum_length: uword; inum_s_flag: uword; number: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberFromInt(err, inum, inum_length, inum_s_flag, number);
end;

function TZOracle9iPlainDriver.NumberToReal(err: POCIError; const number: POCINumber;
  rsl_length: uword; rsl: Pointer): sword;
begin
  Result := OracleAPI.OCINumberToReal(err, number, rsl_length, rsl);
end;

function TZOracle9iPlainDriver.NumberToRealArray(err: POCIError; const number: PPOCINumber;
  elems: uword; rsl_length: uword; rsl: Pointer): sword;
begin
  Result := OracleAPI.OCINumberToRealArray(err, number, elems, rsl_length, rsl);
end;

function TZOracle9iPlainDriver.NumberFromReal(err: POCIError; const rnum: Pointer;
  rnum_length: uword; number: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberFromReal(err, rnum, rnum_length, number);
end;

function TZOracle9iPlainDriver.NumberCmp(err: POCIError; const number1: POCINumber;
  const number2: POCINumber; _result: psword): sword;
begin
  Result := OracleAPI.OCINumberCmp(err, number1, number2, _result);
end;

function TZOracle9iPlainDriver.NumberSign(err: POCIError; const number: POCINumber;
  _result: psword): sword;
begin
  Result := OracleAPI.OCINumberSign(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberIsZero(err: POCIError; const number: POCINumber;
  _Result: pboolean): sword;
begin
  Result := OracleAPI.OCINumberIsZero(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberIsInt(err: POCIError; const number: POCINumber;
  _result: Pboolean): sword;
begin
  Result := OracleAPI.OCINumberIsInt(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberAssign(err: POCIError; const from: POCINumber;
  _to: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberAssign(err, from, _to);
end;

function TZOracle9iPlainDriver.NumberAbs(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberAbs(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberCeil(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberCeil(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberFloor(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberFloor(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberSqrt(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberSqrt(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberTrunc(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberTrunc(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberPower(err: POCIError; const base: POCINumber;
  const number: POCINumber; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberPower(err, base, number, _result);
end;

function TZOracle9iPlainDriver.NumberRound(err: POCIError; const number: POCINumber;
  decplace: sword; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberRound(err, number, decplace, _result);
end;

function TZOracle9iPlainDriver.NumberPrec(err: POCIError; const number: POCINumber;
  nDigs: sword; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberPrec(err, number, nDigs, _result);
end;

function TZOracle9iPlainDriver.NumberSin(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberSin(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberArcSin(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberArcSin(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberHypSin(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberHypSin(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberCos(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberCos(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberArcCos(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberArcCos(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberHypCos(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberHypCos(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberTan(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberTan(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberArcTan(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberArcTan(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberArcTan2(err: POCIError; const number1: POCINumber;
  const number2: POCINumber; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberArcTan2(err, number1, number2, _result);
end;

function TZOracle9iPlainDriver.NumberHypTan(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberHypTan(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberExp(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberExp(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberLn(err: POCIError; const number: POCINumber;
  _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberLn(err, number, _result);
end;

function TZOracle9iPlainDriver.NumberLog(err: POCIError; const base: POCINumber;
  const number: POCINumber; _result: POCINumber): sword;
begin
  Result := OracleAPI.OCINumberLog(err, base, number, _result);
end;

function TZOracle9iPlainDriver.TableSize(hndl: POCIEnv; err: POCIError;
  const tbl: POCITable; size: psb4): sword;
begin
  Result := OracleAPI.OCITableSize(hndl, err, tbl, size);
end;

function TZOracle9iPlainDriver.TableExists(hndl: POCIEnv; err: POCIError;
  const tbl: POCITable; index: sb4; exists: PBoolean): sword;
begin
  Result := OracleAPI.OCITableExists(hndl, err, tbl, index, exists);
end;

function TZOracle9iPlainDriver.TableDelete(hndl: POCIEnv; err: POCIError;
  index: sb4; tbl: POCITable): sword;
begin
  Result := OracleAPI.OCITableDelete(hndl, err, index, tbl);
end;

function TZOracle9iPlainDriver.TableFirst(hndl: POCIEnv; err: POCIError;
  const tbl: POCITable; index: sb4): sword;
begin
  Result := OracleAPI.OCITableFirst(hndl, err, tbl, index);
end;

function TZOracle9iPlainDriver.TableLast(hndl: POCIEnv; err: POCIError;
  const tbl: POCITable; index: sb4): sword;
begin
  Result := OracleAPI.OCITableLast(hndl, err, tbl, index);
end;

function TZOracle9iPlainDriver.TableNext(hndl: POCIEnv; err: POCIError;
  index: sb4; const tbl: POCITable; next_index: psb4; exists: PBoolean): sword;
begin
  Result := OracleAPI.OCITableNext(hndl, err, index, tbl, next_index, exists);
end;

function TZOracle9iPlainDriver.TablePrev(hndl: POCIEnv; err: POCIError;
  index: sb4; const tbl: POCITable; prev_index: psb4; exists: PBoolean): sword;
begin
  Result := OracleAPI.OCITablePrev(hndl, err, index, tbl, prev_index, exists);
end;

function TZOracle9iPlainDriver.ObjectSetAttr(env: POCIEnv; err: POCIError;
  instance: Pointer; null_struct: pointer; tdo: POCIType;
  const names: PPAnsiChar; const lengths: pub4; const name_count: ub4;
  const indexes: pub4; const index_count: ub4; const null_status: POCIInd;
  const attr_null_struct: Pointer; const attr_value: Pointer): sword;
begin
  Result := OracleAPI.OCIObjectSetAttr(env, err, instance, null_struct, tdo,
    names, lengths, name_count, indexes, index_count, null_status,
    attr_null_struct, attr_value);
end;

function TZOracle9iPlainDriver.ObjectGetAttr(env: POCIEnv; err: POCIError;
  instance: Pointer; null_struct: Pointer; tdo: POCIType;
  const names: PPoratext; const lengths: pub4; const name_count: ub4;
  const indexes: pub4; const index_count: ub4; attr_null_status: POCIInd;
  attr_null_struct, attr_value: PPointer; attr_tdo: PPOCIType): sword;
begin
  Result := OracleAPI.OCIObjectGetAttr(env, err, instance, null_struct, tdo,
    names, lengths, name_count, indexes, index_count, attr_null_status,
    attr_null_struct, attr_value, attr_tdo);
end;

function TZOracle9iPlainDriver.Ping(svchp: POCISvcCtx; errhp: POCIError;
  mode: ub4 = OCI_DEFAULT): sword;
begin
  Result := OracleAPI.OCIPing(svchp, errhp, mode);
end;

function TZOracle9iPlainDriver.ServerAttach(srvhp: POCIServer;
  errhp: POCIError; dblink: text; dblink_len: sb4; mode: ub4): sword;
begin
  Result := OracleAPI.OCIServerAttach(srvhp, errhp, dblink, dblink_len,
    mode);
end;

function TZOracle9iPlainDriver.ServerDetach(srvhp: POCIServer;
  errhp: POCIError; mode: ub4): sword;
begin
  Result := OracleAPI.OCIServerDetach(srvhp, errhp, mode);
end;

function TZOracle9iPlainDriver.ServerVersion(hndlp: POCIHandle;
  errhp: POCIError; bufp: text; bufsz: ub4; hndltype: ub1): sword;
begin
  Result := OracleAPI.OCIServerVersion(hndlp, errhp, bufp, bufsz,
    hndltype);
end;

function TZOracle9iPlainDriver.ServerRelease(hndlp: POCIHandle;
  errhp: POCIError; bufp: text; bufsz: ub4; hndltype: ub1; version:pointer): sword;
begin
  Result:=OCI_ERROR;
  if assigned(OracleAPI.OCIServerRelease) then
    Result := OracleAPI.OCIServerRelease(hndlp, errhp, bufp, bufsz,
      hndltype, version);
end;

function TZOracle9iPlainDriver.SessionBegin(svchp: POCISvcCtx;
  errhp: POCIError; usrhp: POCISession; credt, mode: ub4): sword;
begin
  Result := OracleAPI.OCISessionBegin(svchp, errhp, usrhp, credt, mode);
end;

function TZOracle9iPlainDriver.SessionEnd(svchp: POCISvcCtx;
  errhp: POCIError; usrhp: POCISession; mode: ub4): sword;
begin
  Result := OracleAPI.OCISessionEnd(svchp, errhp, usrhp, mode);
end;

function TZOracle9iPlainDriver.StmtExecute(svchp: POCISvcCtx;
  stmtp: POCIStmt; errhp: POCIError; iters, rowoff: ub4; snap_in,
  snap_out: POCISnapshot; mode: ub4): sword;
begin
  Result := OracleAPI.OCIStmtExecute(svchp, stmtp, errhp, iters, rowoff,
    snap_in, snap_out, mode);
end;

function TZOracle9iPlainDriver.StmtFetch(stmtp: POCIStmt; errhp: POCIError;
  nrows: ub4; orientation: ub2; mode: ub4): sword;
begin
  Result := OracleAPI.OCIStmtFetch(stmtp, errhp, nrows, orientation, mode);
end;

function TZOracle9iPlainDriver.StmtGetPieceInfo(stmtp: POCIStmt;
  errhp: POCIError; var hndlpp: Pointer; var typep: ub4; var in_outp: ub1;
  var iterp, idxp: ub4; var piecep: ub1): sword;
begin
  Result := OracleAPI.OCIStmtGetPieceInfo(stmtp, errhp, hndlpp, typep,
    in_outp, iterp, idxp, piecep);
end;

function TZOracle9iPlainDriver.StmtPrepare(stmtp: POCIStmt;
  errhp: POCIError; stmt: text; stmt_len, language, mode: ub4): sword;
begin
  Result := OracleAPI.OCIStmtPrepare(stmtp, errhp, stmt, stmt_len,
    language, mode);
end;

function TZOracle9iPlainDriver.StmtSetPieceInfo(handle: Pointer;
  typep: ub4; errhp: POCIError; buf: Pointer; var alenp: ub4; piece: ub1;
  indp: Pointer; var rcodep: ub2): sword;
begin
  Result := OracleAPI.OCIStmtSetPieceInfo(handle, typep,
    errhp, buf, alenp, piece, indp, rcodep);
end;

function TZOracle9iPlainDriver.TransCommit(svchp: POCISvcCtx;
  errhp: POCIError; flags: ub4): sword;
begin
  Result := OracleAPI.OCITransCommit(svchp, errhp, flags);
end;

function TZOracle9iPlainDriver.TransDetach(svchp: POCISvcCtx;
  errhp: POCIError; flags: ub4): sword;
begin
  Result := OracleAPI.OCITransDetach(svchp, errhp, flags);
end;

function TZOracle9iPlainDriver.TransForget(svchp: POCISvcCtx;
  errhp: POCIError; flags: ub4): sword;
begin
  Result := OracleAPI.OCITransForget(svchp, errhp, flags);
end;

function TZOracle9iPlainDriver.TransPrepare(svchp: POCISvcCtx;
  errhp: POCIError; flags: ub4): sword;
begin
  Result := OracleAPI.OCITransPrepare(svchp, errhp, flags);
end;

function TZOracle9iPlainDriver.TransRollback(svchp: POCISvcCtx;
  errhp: POCIError; flags: ub4): sword;
begin
  Result := OracleAPI.OCITransRollback(svchp, errhp, flags);
end;

function TZOracle9iPlainDriver.TransStart(svchp: POCISvcCtx;
  errhp: POCIError; timeout: word; flags: ub4): sword;
begin
  Result := OracleAPI.OCITransStart(svchp, errhp, timeout, flags);
end;

function TZOracle9iPlainDriver.DateTimeAssign(hndl: POCIEnv;
  err: POCIError; const from: POCIDateTime; _to: POCIDateTime): sword;
begin
  Result := OracleAPI.OCIDateTimeAssign(hndl, err, from, _to);
end;

function TZOracle9iPlainDriver.DateTimeCheck(hndl: POCIEnv; err: POCIError;
  const date: POCIDateTime; var valid: ub4): sword;
begin
  Result := OracleAPI.OCIDateTimeCheck(hndl, err, date, valid);
end;

function TZOracle9iPlainDriver.DateTimeCompare(hndl: POCIEnv;
  err: POCIError; const date1, date2: POCIDateTime;
  var _result: sword): sword;
begin
  Result := OracleAPI.OCIDateTimeCompare(hndl, err, date1, date2, _result);
end;

function TZOracle9iPlainDriver.DateTimeConstruct(hndl: POCIEnv;
  err: POCIError; datetime: POCIDateTime; year: sb2; month, day, hour, min,
  sec: ub1; fsec: ub4; timezone: text; timezone_length: size_t): sword;
begin
  Result := OracleAPI.OCIDateTimeConstruct(hndl, err, datetime,
    year, month, day, hour, min, sec, fsec, timezone, timezone_length);
end;

function TZOracle9iPlainDriver.DateTimeConvert(hndl: POCIEnv;
  err: POCIError; indate, outdate: POCIDateTime): sword;
begin
  Result := OracleAPI.OCIDateTimeConvert(hndl, err, indate, outdate);
end;

function TZOracle9iPlainDriver.DateTimeFromText(hndl: POCIEnv;
  err: POCIError; const date_str: text; d_str_length: size_t;
  const fmt: text; fmt_length: ub1; const lang_name: text;
  lang_length: size_t; date: POCIDateTime): sword;
begin
  Result := OracleAPI.OCIDateTimeFromText(hndl, err,
    date_str, d_str_length, fmt, fmt_length, lang_name, lang_length, date);
end;

function TZOracle9iPlainDriver.DateTimeGetDate(hndl: POCIEnv;
  err: POCIError; const date: POCIDateTime; var year: sb2; var month,
  day: ub1): sword;
begin
  Result := OracleAPI.OCIDateTimeGetDate(hndl, err, date, year, month, day);
end;

function TZOracle9iPlainDriver.DateTimeGetTime(hndl: POCIEnv;
  err: POCIError; datetime: POCIDateTime; var hour, minute, sec: ub1;
  var fsec: ub4): sword;
begin
  Result := OracleAPI.OCIDateTimeGetTime(hndl, err, datetime,
    hour, minute, sec, fsec);
end;

function TZOracle9iPlainDriver.DateTimeGetTimeZoneName(hndl: POCIEnv;
  err: POCIError; datetime: POCIDateTime; var buf: ub1;
  var buflen: ub4): sword;
begin
  Result := OracleAPI.OCIDateTimeGetTimeZoneName(hndl, err, datetime,
    buf, buflen);
end;

function TZOracle9iPlainDriver.DateTimeGetTimeZoneOffset(hndl: POCIEnv;
  err: POCIError; const datetime: POCIDateTime; var hour,
  minute: sb1): sword;
begin
  Result := OracleAPI.OCIDateTimeGetTimeZoneOffset(hndl, err, datetime,
    hour, minute);
end;

function TZOracle9iPlainDriver.DateTimeSysTimeStamp(hndl: POCIEnv;
  err: POCIError; sys_date: POCIDateTime): sword;
begin
  Result := OracleAPI.OCIDateTimeSysTimeStamp(hndl, err, sys_date);
end;

function TZOracle9iPlainDriver.DateTimeToText(hndl: POCIEnv;
  err: POCIError; const date: POCIDateTime; const fmt: text; fmt_length,
  fsprec: ub1; const lang_name: text; lang_length: size_t;
  var buf_size: ub4; buf: text): sword;
begin
  Result := OracleAPI.OCIDateTimeToText(hndl, err, date, fmt, fmt_length,
    fsprec, lang_name, lang_length, buf_size, buf);
end;

{ort.h}
function TZOracle9iPlainDriver.TypeIterNew(env: POCIEnv; err: POCIError;
  const tdo: POCIType; iterator_ort: PPOCITypeIter): sword;
begin
  Result := OracleAPI.OCITypeIterNew(env, err, tdo, iterator_ort);
end;

function TZOracle9iPlainDriver.TypeIterSet(env: POCIEnv; err: POCIError;
  const tdo: POCIType; iterator_ort: POCITypeIter): sword;
begin
  Result := OracleAPI.OCITypeIterSet(env, err, tdo, iterator_ort);
end;

function TZOracle9iPlainDriver.TypeIterFree(env: POCIEnv; err: POCIError;
  iterator_ort: POCITypeIter): sword;
begin
  Result := OracleAPI.OCITypeIterFree(env, err, iterator_ort);
end;

function TZOracle9iPlainDriver.TypeByName(env: POCIEnv; err: POCIError;
  const svc: POCISvcCtx; schema_name: Poratext; const s_length: ub4;
  const type_name: Poratext; const t_length: ub4; version_name: Poratext;
  const v_length: ub4; const pin_duration: OCIDuration;
  const get_option: OCITypeGetOpt; tdo: PPOCIType): sword;
begin
  Result := OracleAPI.OCITypeByName(env, err, svc, schema_name, s_length,
    type_name, t_length, version_name, v_length, pin_duration, get_option, tdo);
end;

function TZOracle9iPlainDriver.TypeArrayByName(env: POCIEnv; err: POCIError;
  svc: POCISvcCtx; array_len: ub4; schema_name:  PPoratext; s_length: Pub4;
  type_name: PPoratext; t_length: Pub4; version_name: PPoratext;
  v_length: Pub4; pin_duration: OCIDuration; get_option: OCITypeGetOpt;
  tdo: PPOCIType): sword;
begin
  Result := OracleAPI.OCITypeArrayByName(env, err, svc, array_len, schema_name,
    s_length, type_name, t_length, version_name, v_length, pin_duration,
    get_option, tdo);
end;

function TZOracle9iPlainDriver.TypeByRef(env: POCIEnv; err: POCIError;
  type_ref: POCIRef; pin_duration: OCIDuration; get_option: OCITypeGetOpt;
  tdo: PPOCIType): sword;
begin
  Result := OracleAPI.OCITypeByRef(env, err, type_ref, pin_duration, get_option,
    tdo);
end;

function TZOracle9iPlainDriver.TypeArrayByRef(env: POCIEnv; err: POCIError;
  array_len: ub4; type_ref: PPOCIRef; pin_duration: OCIDuration;
  get_option: OCITypeGetOpt; tdo: PPOCIType): sword;
begin
  Result := OracleAPI.OCITypeArrayByRef(env, err, array_len, type_ref,
    pin_duration, get_option, tdo);
end;

function TZOracle9iPlainDriver.TypeName(env: POCIEnv; err: POCIError;
  tdo: POCIType; n_length: Pub4): poratext;
begin
  Result := OracleAPI.OCITypeName(env, err, tdo, n_length);
end;

function TZOracle9iPlainDriver.TypeSchema(env: POCIEnv; err: POCIError;
  const tdo: POCIType; n_length: Pub4): poratext;
begin
  Result := OracleAPI.OCITypeSchema(env, err, tdo, n_length);
end;

function TZOracle9iPlainDriver.TypeTypeCode(env: POCIEnv; err: POCIError;
  const tdo: POCIType): OCITypeCode;
begin
  Result := OracleAPI.OCITypeTypeCode(env, err, tdo);
end;

function TZOracle9iPlainDriver.TypeCollTypeCode(env: POCIEnv; err:POCIError;
  const tdo: POCIType): OCITypeCode;
begin
  Result := OracleAPI.OCITypeCollTypeCode(env, err, tdo);
end;

function TZOracle9iPlainDriver.TypeVersion(env: POCIEnv; err: POCIError;
  const tdo: POCIType; v_length: Pub4): poratext;
begin
  Result := OracleAPI.OCITypeVersion(env, err, tdo, v_length);
end;

function TZOracle9iPlainDriver.TypeAttrs(env: POCIEnv; err: POCIError;
  const tdo:POCIType): ub4;
begin
  Result := OracleAPI.OCITypeAttrs(env, err, tdo);
end;

function TZOracle9iPlainDriver.TypeMethods(env: POCIEnv; err: POCIError;
  const tdo: POCIType): ub4;
begin
  Result := OracleAPI.OCITypeMethods(env, err, tdo);
end;

function TZOracle9iPlainDriver.TypeElemName(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem; n_length:Pub4): poratext;
begin
  Result := OracleAPI.OCITypeElemName(env, err, elem, n_length);
end;

function TZOracle9iPlainDriver.TypeElemTypeCode(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem): OCITypeCode;
begin
  Result := OracleAPI.OCITypeElemTypeCode(env, err, elem);
end;

function TZOracle9iPlainDriver.TypeElemType(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem; elem_tdo:PPOCIType): sword;
begin
  Result := OracleAPI.OCITypeElemType(env, err, elem, elem_tdo);
end;

function TZOracle9iPlainDriver.TypeElemFlags(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem): ub4;
begin
  Result := OracleAPI.OCITypeElemFlags(env, err, elem);
end;

function TZOracle9iPlainDriver.TypeElemNumPrec(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem): ub1;
begin
  Result := OracleAPI.OCITypeElemNumPrec(env, err, elem);
end;

function TZOracle9iPlainDriver.TypeElemNumScale(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem): sb1;
begin
  Result := OracleAPI.OCITypeElemNumScale(env, err, elem);
end;

function TZOracle9iPlainDriver.TypeElemLength(env: POCIEnv; err: POCIError;
  const elem:POCITypeElem): ub4;
begin
  Result := OracleAPI.OCITypeElemLength(env, err, elem);
end;

function TZOracle9iPlainDriver.TypeElemCharSetID(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem): ub2;
begin
  Result := OracleAPI.OCITypeElemCharSetID(env, err, elem);
end;

function TZOracle9iPlainDriver.TypeElemCharSetForm(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem): ub2;
begin
  Result := OracleAPI.OCITypeElemCharSetForm(env, err, elem);
end;

function TZOracle9iPlainDriver.TypeElemParameterizedType(env: POCIEnv;
  err: POCIError; const elem: POCITypeElem; type_stored: PPOCIType): sword;
begin
  Result := OracleAPI.OCITypeElemParameterizedType(env, err, elem, type_stored);
end;

function TZOracle9iPlainDriver.TypeElemExtTypeCode(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem): OCITypeCode;
begin
  Result := OracleAPI.OCITypeElemExtTypeCode(env, err, elem);
end;

function TZOracle9iPlainDriver.TypeAttrByName(env: POCIEnv; err: POCIError;
  const tdo: POCIType; const name: Poratext; const n_length: ub4;
  elem: PPOCITypeElem): sword;
begin
  Result := OracleAPI.OCITypeAttrByName(env, err, tdo, name, n_length, elem);
end;

function TZOracle9iPlainDriver.TypeAttrNext(env: POCIEnv; err: POCIError;
  iterator_ort: POCITypeIter; elem: PPOCITypeElem): sword;
begin
  Result := OracleAPI.OCITypeAttrNext(env, err, iterator_ort, elem);
end;

function TZOracle9iPlainDriver.TypeCollElem(env: POCIEnv; err: POCIError;
  const tdo:POCIType; element: PPOCITypeElem): sword;
begin
  Result := OracleAPI.OCITypeCollElem(env, err, tdo, element);
end;

function TZOracle9iPlainDriver.TypeCollSize(env: POCIEnv; err: POCIError;
  const tdo: POCIType; num_elems: Pub4): sword;
begin
  Result := OracleAPI.OCITypeCollSize(env, err, tdo, num_elems);
end;

function TZOracle9iPlainDriver.TypeCollExtTypeCode(env: POCIEnv; err: POCIError;
  const tdo:POCIType; sqt_code: POCITypeCode): sword;
begin
  Result := OracleAPI.OCITypeCollExtTypeCode(env, err, tdo, sqt_code);
end;

function TZOracle9iPlainDriver.TypeMethodOverload(env: POCIEnv; err: POCIError;
  const tdo: POCIType; const method_name: Poratext;
  const m_length: ub4): ub4;
begin
  Result := OracleAPI.OCITypeMethodOverload(env, err, tdo, method_name,
    m_length);
end;

function TZOracle9iPlainDriver.TypeMethodByName(env: POCIEnv; err: POCIError;
  const tdo: POCIType; const method_name: Poratext; const m_length: ub4;
  mdos: PPOCITypeMethod): sword;
begin
  Result := OracleAPI.OCITypeMethodByName(env, err, tdo, method_name, m_length,
    mdos);
end;

function TZOracle9iPlainDriver.TypeMethodNext(env: POCIEnv; err: POCIError;
  iterator_ort: POCITypeIter; mdo: PPOCITypeMethod): sword;
begin
  Result := OracleAPI.OCITypeMethodNext(env, err, iterator_ort, mdo);
end;

function TZOracle9iPlainDriver.TypeMethodName(env:POCIEnv; err: POCIError;
  const mdo: POCITypeMethod; n_length: Pub4): poratext;
begin
  Result := OracleAPI.OCITypeMethodName(env, err, mdo, n_length);
end;

function TZOracle9iPlainDriver.TypeMethodEncap(env: POCIEnv; err: POCIError;
  const mdo: POCITypeMethod): OCITypeEncap;
begin
  Result := OracleAPI.OCITypeMethodEncap(env, err, mdo);
end;

function TZOracle9iPlainDriver.TypeMethodFlags(env: POCIEnv; err: POCIError;
    const mdo:POCITypeMethod): OCITypeMethodFlag;
begin
  Result := OracleAPI.OCITypeMethodFlags(env, err, mdo);
end;

function TZOracle9iPlainDriver.TypeMethodMap(env: POCIEnv; err: POCIError;
  const tdo: POCIType; mdo: PPOCITypeMethod): sword;
begin
  Result := OracleAPI.OCITypeMethodMap(env, err, tdo, mdo);
end;

function TZOracle9iPlainDriver.TypeMethodOrder(env: POCIEnv; err: POCIError;
  const tdo: POCIType; mdo: PPOCITypeMethod): sword;
begin
  Result := OracleAPI.OCITypeMethodOrder(env, err, tdo, mdo);
end;

function TZOracle9iPlainDriver.TypeMethodParams(env: POCIEnv; err: POCIError;
  const mdo: POCITypeMethod): ub4;
begin
  Result := OracleAPI.OCITypeMethodParams(env, err, mdo);
end;

function TZOracle9iPlainDriver.TypeResult(env: POCIEnv; err: POCIError;
  const mdo: POCITypeMethod; elem: PPOCITypeElem): sword;
begin
  Result := OracleAPI.OCITypeResult(env, err, mdo, elem);
end;

function TZOracle9iPlainDriver.TypeParamByPos(env: POCIEnv; err: POCIError;
  const mdo: POCITypeMethod; const position: ub4;
  elem: PPOCITypeElem): sword;
begin
  Result := OracleAPI.OCITypeParamByPos(env, err, mdo, position, elem);
end;

function TZOracle9iPlainDriver.TypeParamByName(env: POCIEnv; err: POCIError;
  const mdo: POCITypeMethod; const name: Poratext; const n_length: ub4;
  elem:PPOCITypeElem): sword;
begin
  Result := OracleAPI.OCITypeParamByName(env, err, mdo, name, n_length, elem);
end;

function TZOracle9iPlainDriver.TypeParamPos(env: POCIEnv; err: POCIError;
  const mdo: POCITypeMethod; const name: Poratext; const n_length: ub4;
  position: Pub4; elem: PPOCITypeElem): sword;
begin
  Result := OracleAPI.OCITypeParamPos(env, err, mdo, name, n_length, position,
    elem);
end;

function TZOracle9iPlainDriver.TypeElemParamMode(env: POCIEnv; err: POCIError;
  const elem: POCITypeElem): OCITypeParamMode;
begin
  Result := OracleAPI.OCITypeElemParamMode(env, err, elem);
end;

function TZOracle9iPlainDriver.TypeElemDefaultValue(env: POCIEnv;
  err: POCIError; const elem: POCITypeElem; d_v_length: Pub4): poratext;
begin
  Result := OracleAPI.OCITypeElemDefaultValue(env, err, elem, d_v_length);
end;

function TZOracle9iPlainDriver.TypeVTInit(env: POCIEnv; err: POCIError): sword;
begin
  Result := OracleAPI.OCITypeVTInit(env, err);
end;

function TZOracle9iPlainDriver.TypeVTInsert(env: POCIEnv; err: POCIError;
  const schema_name: Poratext; const s_n_length: ub4;
  const type_name: Poratext; const t_n_length: ub4;
  const user_version:Poratext; const u_v_length:ub4): sword;
begin
  Result := OracleAPI.OCITypeVTInsert(env, err, schema_name, s_n_length,
    type_name, t_n_length, user_version, u_v_length);
end;

function TZOracle9iPlainDriver.TypeVTSelect(env: POCIEnv; err: POCIError;
  const schema_name: Poratext; const s_n_length: ub4;
  const type_name: Poratext; const t_n_length: ub4; user_version: PPoratext;
  u_v_length: Pub4; version: Pub2): sword;
begin
  Result := OracleAPI.OCITypeVTSelect(env, err, schema_name, s_n_length,
    type_name, t_n_length, user_version, u_v_length, version);
end;

end.

