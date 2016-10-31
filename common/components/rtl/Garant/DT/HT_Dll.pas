(*
   Procedures & Functions

   DLL HyTech ��� Win95/NT

   HyTech 2.56  Copyright (c) 1993, 99 by SKAZ_M Ltd
*)

// $Id: HT_Dll.pas,v 1.25 2016/10/31 07:01:48 lukyanets Exp $

// $Log: HT_Dll.pas,v $
// Revision 1.25  2016/10/31 07:01:48  lukyanets
// �� ����������
//
// Revision 1.24  2016/10/28 14:32:06  voba
// no message
//
// Revision 1.23  2016/07/21 06:01:26  fireton
// - �� ����������
//
// Revision 1.22  2016/07/20 13:50:24  voba
// no message
//
// Revision 1.21  2014/07/10 14:40:49  voba
// - �������� var �� const ��� ����
//
// Revision 1.20  2014/02/18 11:02:44  voba
// - add some func
//
// Revision 1.19  2013/07/08 09:29:45  voba
// - ������� Function htExcludeResults, �� ��� ������ � ����� DLL :(
//
// Revision 1.18  2013/04/19 13:07:39  lulin
// - ���������.
//
// Revision 1.17  2012/11/07 09:42:05  voba
// - ����� ��������� ������ ��������� HT
//
// Revision 1.16  2009/09/11 08:27:26  voba
// - ������� ���������� �������� ���� ELEMENT �� ������ ThtElementInfo
//
// Revision 1.15  2007/03/09 07:34:41  voba
// no message
//
// Revision 1.14  2007/03/02 10:09:40  voba
// - bug fix htSubSearch Bug
//
// Revision 1.13  2007/03/02 10:00:04  voba
// no message
//
// Revision 1.12  2007/03/02 09:52:49  voba
// no message
//
// Revision 1.11  2007/02/22 13:35:39  fireton
// - ������� �� 64 ���� � HyTech
//
// Revision 1.10  2007/02/16 16:06:16  voba
// - rename type Condition ->ThtCondition
//
// Revision 1.9  2006/12/08 15:23:48  voba
// - rename type Format->htFormat
//
// Revision 1.8  2006/11/07 11:18:24  voba
// - bug fix
//
// Revision 1.7  2006/10/27 07:46:50  voba
// no message
//
// Revision 1.6  2006/09/07 10:33:58  voba
// - mode64 support
//
// Revision 1.5  2003/04/11 07:32:50  demon
// - ������� ���, ������������ ��������� htReadResults � Word �� Cardinal
// (��� ���������� ������ � �������� ��������)
//
// Revision 1.4  2002/01/16 10:42:22  demon
// - some new functions added
//
// Revision 1.3  2000/12/15 15:36:17  law
// - ��������� ��������� Log.
//

Unit HT_Dll;

Interface

Uses HT_Const;

{$I HTDefine.inc}

(*======================== ������� ���� =======================*)

(*-------------------- ������������� � ���������� -------------*)

(* ��������� ������������� ���������� API - ���� �� ��� ���������� *)
  Function  htGlobalInit( hInstance: Integer ):Integer; stdcall;
(* ��������� ���������� ���������� API - ���� �� ��� ���������� *)
  Procedure htGlobalShut;

(* ������������� ����. ����������� ���� ��� � ������ ���������. *)
(* ��� ������� ������ ���� ������� �� ������� ��������� � ���� *)
  Function htInit(
      fpInit:LPINIT;  (* ��������� ��� ������� ��� Nil *)
      nSize:SmallInt  (* ������ ����������� ����� ������ *)
  ):Integer;stdcall;

(* ���������� ������ ����             *)
(* ��� ��������� ���������� ��������� *)
  Procedure htShut;

(*------------------ ������ � ��������� ------------------*)

(* ������� ��� �������� ������� *)
  Procedure htCloseAllTables;

(* �������� ����������� ������ *)
(* =0 - ����������� ��������� �� ���� � �� �� ������� *)
  Function htCompareTabHandles(
      hTable1 : THANDLE;  (* ���������� ������� *)
      hTable2 : THANDLE   (* ������ ���������� ������� *)
  ):SmallInt;stdcall;

(* ����������� ���������� �������       *)
(* ����� �� ������ � ����� ����� ������ *)
  Function htDupTableHandle(
      hTable     : THANDLE;  (* �������� ���������� *)
      Var fpTable: THANDLE   (* ����� �����������   *)
  ):SmallInt;stdcall;

(* ������� ������� � ��������� � ��� ����� *)
(* ������� ������ ���� �������             *)
  Function htDropTable(
      fpTableName: PAnsiChar;  (* ��� ������� (����� ��� ����������) *)
      fpReadPswd : PAnsiChar;  (* ������ ��� ������� �� ������ *)
      fpWritePswd: PAnsiChar   (* ������ ��� ������� �� ������ *)
  ):SmallInt;stdcall;

(* ������� ���������, ����������� ��� ������� *)
(* ������� ������ ���� �������                *)
  Function htDropTableChanges(
      fpTableName: PAnsiChar; (* ��� ������� (����� ��� ����������) *)
      fpReadPswd : PAnsiChar; (* ������ ��� ������� �� ������       *)
      fpWritePswd: PAnsiChar  (* ������ ��� ������� �� ������       *)
  ):SmallInt;stdcall;

(* ������� ��� ������ ������� (�������� ���� ���������) *)
(* ������� ������ ���� ������� *)
  Function htDropTableData(
      fpTableName: PAnsiChar; (* ��� ������� (����� ��� ����������) *)
      fpReadPswd : PAnsiChar; (* ������ ��� ������� �� ������       *)
      fpWritePswd: PAnsiChar  (* ������ ��� ������� �� ������       *)
  ):SmallInt;stdcall;

(* ����� ������� �/� ������� �� ���� *)
(* ������� ����� �������� ���������� *)
  Function htFlushTable(
      hTable: THANDLE     (* ���������� ��� ������� *)
  ):SmallInt;stdcall;

(* ������� �������� ������� *)
  Function htTableClose(
      hTable: THANDLE     (* ���������� ��� ������� *)
  ):SmallInt;stdcall;

(* ���������� ������� � ������ *)
(* ���� ������� � �������� ������ ����������, ��� ����� ���������� *)
(* �������� ������� ������ ���� ������� *)
  Function htTableCopy(
      fpDstTable: PAnsiChar;     (* ��� �������-����� (����� ��� ����������) *)
      fpSrcTable: PAnsiChar;     (* ��� �������� ������� (����� ��� ����������) *)
      fpSrcRdPswd:PAnsiChar;     (* ������ ��� ������� �� ������ *)
      nSrcOpenMode: SmallInt (* ����� �������� �������� ������� *)
  ):SmallInt;stdcall;

(* ������� ����� ������� � �������� � ��� ������ *)
  Function htTableCreate(
      fpTableName: PAnsiChar;      (* ��� ������� (����� ��� ����������) *)
      fpElems     : LPELEMENT; (* ��������� ��������� �������        *)
      nElemCnt    : SmallInt;  (* ����� ���������� ���������         *)
      fpCryptoKey : PAnsiChar;     (* ���� ��� ������-�������� ������    *)
      fpReadPswd  : PAnsiChar;     (* ������ ��� ������� �� ������       *)
      fpWritePswd : PAnsiChar;     (* ������ ��� ������� �� ������       *)
      nOpenMode   : SmallInt;  (* ����� �������� (��������� TAB_????)*)
      Var fpHandle: THANDLE    (* ��� ������ ����������� �������     *)
  ):SmallInt;stdcall;

(* ���������� ��������� (����� �/��� ��������) � ������� *)
(* ������� ������ ���� ������� *)
  Function htTableAgregateAppend(
      fpTableName: PAnsiChar;    (* ��� ������� (����� ��� ����������) *)
      fpReadPswd:  PAnsiChar;    (* ������ ��� ������� �� ������ *)
      fpWritePswd: PAnsiChar;    (* ������ ��� ������� �� ������ *)
      fpAgres:     LPELEMENT;(* ������ �������� �������� ��������� *)
      nAgreCnt:    SmallInt  (* ����� ��������� *)
  ):SmallInt;stdcall;

(* �������� ��������� (����� �/��� ��������) �� ������� *)
(* ������� ������ ���� ������� *)
  Function htTableAgregateDelete(
      fpTableName: PAnsiChar;    (* ��� ������� (����� ��� ����������) *)
      fpReadPswd:  PAnsiChar;    (* ������ ��� ������� �� ������ *)
      fpWritePswd: PAnsiChar;    (* ������ ��� ������� �� ������ *)
      nPos:      SmallInt; (* ����� ������� �������� �� ������ *)
      nDelCnt:     SmallInt  (* ����� �������� ��������� *)
  ):SmallInt;stdcall;

(* ����������� ��������� (����� �/��� ��������) � ������� *)
(* ������� ������ ���� ������� *)
  Function htTableAgregateModify(
      fpTableName: PAnsiChar;    (* ��� ������� (����� ��� ����������) *)
      fpReadPswd:  PAnsiChar;    (* ������ ��� ������� �� ������ *)
      fpWritePswd: PAnsiChar;    (* ������ ��� ������� �� ������ *)
      fpAgres:     LPELEMENT;(* ������ �������� �������� ��������� *)
      nAgreCnt:    SmallInt; (* ����� ��������� *)
      nFirstNo:    SmallInt  (* ����� ������� �������� �� ������ *)
  ):SmallInt;stdcall;

(* �������� �������� �������� �������� �������.             *)
(* ������ ������� ������� ����� ����� 1, ������ - 2 � �.�.  *)
(* �������������� �������� ������� �� ��������� ����������. *)
(* ��� �������� ����������� �� ����� �������� �������, ���� *)
(* ����� ���� ������, ����� ���� ����� ������ �� ��������.  *)
  Function htTableElement(
      hTable   : THANDLE;   (* ���������� ��� �������                *)
      nElemNo  : SmallInt;  (* ����� �������� ������� (�� 1)         *)
      Var sElem: ThtElementInfo;   (* ��������� ��� �������� ��������       *)
      bReadName: Boolean    (* ��� true ������ ��� �������� �� ����� *)
  ):SmallInt;stdcall;

(* �������� �������� ���� ��������� �������� �������.      *)
(* ������ ������� ������� ����� ����� 1, ������ - 2 � �.�. *)
(* ���������� �������� ������ �������� ������ �� �����     *)
(* ��������� �������. ����� ����� ������ �� htTableInfo    *)
  Function htTableElementList(
      hTable   : THANDLE;   (* ���������� ��� �������             *)
      fpElement: LPELEMENT  (* ������ �������� �������� ��������� *)
  ):SmallInt;stdcall;

(* ���������� ���������� ��� �������� ������� �� ����� *)
  Function htTableHandleByName(
      fpTabName    : PAnsiChar;   (* ��� ������� (����� ��� ����������) *)
      Var fpHandle : THANDLE  (* ��� ������ ����������� �������     *)
  ):SmallInt;stdcall;

(* �������� ��������� �������� ������� *)
  Function htTableInfo(
      hTable    : THANDLE;   (* ���������� ��� �������         *)
      Var sTable: TABLE      (* ��������� ��� �������� ������� *)
  ):SmallInt;stdcall;

(* �������� ��������� �������� ������� *)
  Function htTableState(
      hTable    : THANDLE;   (* ���������� ��� �������         *)
      Var sStat : STATT      (* ��������� ��� �������� ������� *)
  ):SmallInt;stdcall;

(* ������� ������ � �������    *)
(* ������� ������ ���� ������� *)
  Function htTableOpen(
      fpTableName : PAnsiChar;    (* ��� ������� (����� ��� ����������)  *)
      fpReadPswd  : PAnsiChar;    (* ������ ������� �� ������            *)
      fpWritePswd : PAnsiChar;    (* ������ ������� �� ������            *)
      nOpenMode   : SmallInt; (* ����� �������� (��������� TAB_????) *)
      Var fpHandle: THANDLE   (* ��� ������ ����������� �������      *)
  ):SmallInt;stdcall;

(* ������������� �������                              *)
(* ������� ������ ���� �������                        *)
(* �������������� �������� ���� � �������� ���������� *)
  Function htTableRename(
      fpTableName: PAnsiChar;   (* ��� ������� (����� ��� ����������)          *)
      fpReadPswd : PAnsiChar;   (* ������ ������� �� ������                    *)
      fpWritePswd: PAnsiChar;   (* ������ ������� �� ������                    *)
      fpNewName  : PAnsiChar    (* ����� ��� ������� (����� � ������ ��������) *)
  ):SmallInt;stdcall;

(* ��������� ������� *)
(* ������� ������ ���� ������� *)
  Function htTableVerify(
      fpTableName: PAnsiChar;   (* ��� ������� (����� ��� ����������) *)
      fpReadPswd : PAnsiChar;   (* ������ ������� �� ������           *)
      fpWritePswd: PAnsiChar;   (* ������ ������� �� ������           *)
      nMode      : SmallInt (* ����� �������� (HTVF_????)         *)
  ):SmallInt;stdcall;

(* ������������ ������� ������� ���������� ����� *)
(* ������� ������ ���� �������                   *)
  Function htRepairTable(
      fpTableName: PAnsiChar;   (* ��� ������� (����� ��� ����������)          *)
      fpReadPswd : PAnsiChar;   (* ������ ������� �� ������                    *)
      fpWritePswd: PAnsiChar    (* ������ ������� �� ������                    *)
  ):LongInt;stdcall;

(* ������������ ������ ��������� ������� *)
(* ������� ������ ���� �������           *)
  Function htRepairTableLog(
      fpTableName: PAnsiChar;   (* ��� ������� (����� ��� ����������) *)
      fpReadPswd : PAnsiChar;   (* ������ ������� �� ������           *)
      fpWritePswd: PAnsiChar;   (* ������ ������� �� ������           *)
      gItemCnt   : LongInt  (* ����� ��������� � ��������������   *)
          (*   <0 - ����� ��������� �� HDN      *)
          (*   =0 - �� ���������                *)
          (*   >0 - ����� ��������� �� HDR      *)
  ):SmallInt;stdcall;

(* ��������� ��������� � ���������� ����� ������� *)
(* ������� ������ ���� �������                    *)
  Function htUpdateTable(
      fpTableName: PAnsiChar;   (* ��� ������� (����� ��� ����������)  *)
      fpReadPswd : PAnsiChar;   (* ������ ������� �� ������            *)
      fpWritePswd: PAnsiChar;   (* ������ ������� �� ������            *)
      bReIndex   : Boolean; (* ��� true �������������� ��������    *)
      bTestSpace : Boolean  (* ��� true �������� ����� �� �����    *)
  ):SmallInt;stdcall;

(*------------- ������ � ��������� ������� ------------*)

(* ���������� �������� ��� �������� ��������� *)
(* ������� ������ ���� �������                *)
(* ���������� ����� ����������� ������� ��� ��� ������ *)
  Function htBuildIndexes(
      fpTableName: PAnsiChar;    (* ��� ������� (����� ��� ����������)  *)
      fpReadPswd : PAnsiChar;    (* ������ ������� �� ������            *)
      fpWritePswd: PAnsiChar;    (* ������ ������� �� ������            *)
      bTestSpace : Boolean;  (* �������� ������������ �� �����      *)
      bDenyOut   : Boolean   (* ��� true ����� ����������� ������� � ������� *)
  ):LongInt;stdcall;

(* ������� ��� ����� ��� �������� ������� *)
(* ������� ������ ���� �������            *)
(* ���������� ����� ����������� ������� ��� ��� ������ *)
  Function htChangeKeyType(
      fpTableName: PAnsiChar;    (* ��� ������� (����� ��� ����������)           *)
      fpReadPswd : PAnsiChar;    (* ������ ������� �� ������                     *)
      fpWritePswd: PAnsiChar;    (* ������ ������� �� ������                     *)
      nElemNo    : SmallInt; (* ����� �������� ������� (�� 1)                *)
      nNewKeyType: SmallInt; (* ����� ��� �����                              *)
      bTestSpace : Boolean;  (* �������� ������������ �� �����               *)
      bDenyOut   : Boolean   (* ��� true ����� ����������� ������� � ������� *)
  ):LongInt;stdcall;

(* �������� ��������           *)
(* ������� ������ ���� ������� *)
  Function htDropIndexes(
      fpTableName: PAnsiChar;  (* ��� ������� (����� ��� ����������)  *)
      fpReadPswd : PAnsiChar;  (* ������ ������� �� ������            *)
      fpWritePswd: PAnsiChar   (* ������ ������� �� ������            *)
  ):SmallInt;stdcall;

(*------------- �������� ����������� ������� -------------*)

(* ���������� ������ � �������                    *)
(* ���������� ���������� ����� ����������� ������ *)
  Function htRecordAdd(
      hTable  : THANDLE;    (* ���������� ��� ������� *)
      fpRecord: Pointer     (* ���� ������            *)
  ):LongInt;stdcall;

(* �������� ������ �� ������� *)
  Function htRecordDelete(
      hTable    : THANDLE;  (* ���������� ��� �������            *)
      gRecordNo : LongInt   (* ���������� ����� ��������� ������ *)
  ):SmallInt;stdcall;

(* ����������� ������ � ������� *)
  Function htRecordModify(
      hTable    : THANDLE;  (* ���������� ��� �������                 *)
      gRecordNo : LongInt;  (* ���������� ����� �������������� ������ *)
      fpRecord  : Pointer   (* ���� ������                            *)
  ):SmallInt;stdcall;

(*----------- �������� �������� ����������� ------------*)

(* ���������� ������ ������� � ������� *)
(* ���������� ����� ����������� ������� ��� ��� ������ *)
  Function htAddRecords(
      hTable    : THANDLE;  (* ���������� ��� �������                     *)
      gAppendLim: LongInt;  (* ������������ ����� ������� ��� ����������  *)
      fpfAddProc: LPAFUNC;  (* ���������������� ������� ���������� ������ *)
      fpfErrProc: LPEFUNC;  (* ���������������� ������� ��������� ������  *)
          (* Nil - ������ �������� �������� *)
      fpUser    : Pointer;  (* ���.�������� ������������ *)
      bDenyOut  : Boolean   (* True - ����� ����������� ������� � ������� *)
  ):LongInt;stdcall;

(* ���������� ����� ������� � ���������� ����� ������� *)
(* ���������� ����� ����������� ������� ��� ��� ������ *)
  Function htLoadRecords(
      fpTableName: PAnsiChar;   (* ��� ������� *)
      fpReadPswd : PAnsiChar;   (* ������ ������� �� ������ *)
      fpWritePswd: PAnsiChar;   (* ������ ������� �� ������ *)
      gLoadLim   : LongInt; (* ������������ ����� ������� ��� ����������  *)
      fpfAddProc : LPAFUNC; (* ���������������� ������� ���������� ������ *)
      fpfErrProc : LPEFUNC; (* ���������������� ������� ��������� ������  *)
                            (* Nil - ������ �������� �������� *)
      fpUser     : Pointer; (* ���.�������� ������������ *)
      bDenyOut   : Boolean  (* ��� true ����� ����������� ������� � ������� *)
  ):LongInt;stdcall;

(* �������� ������������ ������� �� ������� *)
  Function htDeleteRecords(
      Var fpSrc: SAB    (* ����� ���, ����������� ������������ ������� *)
  ):LongInt;stdcall;

(* ����������� ������������ ������� �� ������� *)
(* ���������� ����� ����������� ������� ��� ��� ������ *)
  Function htModifyRecords(
      Var fpSrc : SAB;      (* ����� ���, ����������� ������������ ������� *)
      fpfMdfProc: LPMFUNC;  (* ������� ����������� �������                 *)
      fpfErrProc: LPEFUNC;  (* ���������������� ������� ��������� ������   *)
                            (* Nil - ������ �������� �������� *)
      fpUser    : Pointer;  (* ���.�������� ������������ *)
      bDenyOut  : Boolean   (* ��� true ����� ����������� ������� � ������� *)
  ):LongInt;stdcall;

(* ����������� ���������� ������ ������� � ������� *)
(* ����������� ���� ��� �������� ������, ���� ������ *)
(* ��������� ���������� ������� �������� � ������ �� �������� *)
  Function htPureAddRecords(
      hTable    : THANDLE;  (* ���������� ��� �������                     *)
      gAppendLim: LongInt;  (* ������������ ����� ������� ��� ����������  *)
      fpfAddProc: LPAFUNC;  (* ���������������� ������� ���������� ������ *)
      fpUser    : Pointer   (* ���.�������� ������������ *)
  ):SmallInt;stdcall;

(* ����������� ����������� ������������ ������� �� ������� *)
(* �������������� ���� ��� �������� ������, ���� ������ *)
(* ��������� ���������� ������� �������� � ������ �� �������� *)
  Function htPureModifyRecords(
      Var fpSrc : SAB;      (* ����� ���, ����������� ������������ ������� *)
      fpfMdfProc: LPMFUNC;  (* ������� ����������� �������                 *)
      fpUser    : Pointer   (* ���.�������� ������������ *)
  ):SmallInt;stdcall;

(*============== ��������� �������� � ������� ===============*)

(*----------------------- ��������� ����� ------------------------*)
(* �������� ������� (����, ������ � ���������) ����� ��������     *)
(* ��������� �� 1. ����� 0 ������� ��� ������� �� �����������     *)
(* ������ ������ (�������� �������� ��� LongInt).                 *)

(* ����� �� ������� ��� �������� ������� (����, ������, ���������) *)
(* ����� ������������ � �������� ��������� ������ ������� *)
  Function htSearch(
      fpPhoto   : LPSAB;    (* ��� "������" (Nil - ���� ������ ������) *)
      Var fpSave: SAB;      (* ��� ��� ���������� ���������� *)
      hTable    : THANDLE;  (* ���������� ��� ������� *)
      nElemNum  : SmallInt;  (* ����� �������� �������         *)
          (* (0-���.�����, 1-������ � �.�.) *)
      nCond     : ThtCondition;(* �������, ��. ��������� ������� *)
      fpValue1  : Pointer;  (* ��p��� ��������� �������� ��� ������� *)
      fpValue2  : Pointer   (* ������ ��������� �������� ��� �������� ������� *)
          (* Nil, ���� �� �����    *)
  ):LPSAB;stdcall;

(* ����� �� ������� ��� �������� ������� (����, ������, ���������) *)
(* ����� ������������ � �������� ���������� ������� ������� *)
  Function htSubSearch(
      Var fpSet : SAB;      (* ��� ��������� ������� *)
      Var fpSave: SAB;      (* ��� ��� ���������� ���������� *)
      hTable    : THANDLE;  (* ���������� ��� ������� *)
      nElemNum  : SmallInt;  (* ����� �������� �������         *)
          (* (0-���.�����, 1-������ � �.�.) *)
      nCond     : ThtCondition;(* �������, ��. ��������� ������� *)
      fpValue1  : Pointer;  (* ��p��� ��������� �������� ��� ������� *)
      fpValue2  : Pointer   (* ������ ��������� �������� ��� �������� ������� *)
          (* Nil, ���� �� �����    *)
  ):LPSAB;stdcall;


(*---------------- ������� ������ ������� ---------------*)

(* �������� ������ �� ������ �������� �������� *)
(* ���������� ������, ��� ������� ������� ��������� �������� �� ������ *)
  Function htRecordsByKey(
      Var fpDst : SAB;    (* ��� ������ ���������� *)
      Var fpList: SAB     (* ����� ���, ����������� ������ �������� *)
  ):LPSAB;stdcall;

(* ����� ������ �� �������� ����������� ����� *)
(* ���������� ���.����� ������ � �������� ��������� ����� *)
(* 0 ��� ����� �������, <0 - ��� ������ *)
  Function htRecordByUniq(
      fpPHO:     LPSAB; (* ��� "������" *)
      hTable:    THANDLE; (* ���������� ������� *)
      nKeyNo:    SmallInt;  (* ����� ����� (0-���.�����, 1-������ ���� � �.�.) *)
      fpValue:   Pointer; (* �������� �������� ����������� ����� *)
      fphRecord: LPRHANDLE  (* ��� ����������� ������ *)
  ):LongInt;stdcall;

(* �������� ������ ��� ��������� ����������� �������� ���� ��������� *)
(* ���������� ������, ��� ������� �������� �������� nElemNo1 �  *)
(* nElemNo2 ������������� ��������� ����������� �� ������������ *)
(* ������� fpSrc.  *)
  Function htRecordsForTwoKeys(
      Var fpDst: SAB;       (* ��� ������ ���������� *)
      Var fpSrc: SAB;       (* ����� ���, ����������� ������ ������� ������� *)
      nElemNo1 : SmallInt;   (* ����� ������� �������� ������ *)
      nCond    : ThtCondition; (* ������� ��������� (���� ������ EQUAL) *)
      nElemNo2 : SmallInt    (* ����� ������� �������� ������ *)
  ):LPSAB;stdcall;

(* ���������� ������������ ������� �������, �������� � ��������� ���������� *)
  Function htSortedRecords(
      Var fpDst : SAB;    (* ���� ��� ������ ���������� *)
      Var fpSort: SAB     (* ��������� ����������       *)
  ):LPSAB;stdcall;

(* ���������� ������������ ������� �������, �������� � ��������� ����������, *)
(* ��� ��������� ������ *)
  Function htSortedRecordsEx(
      Var fpDst : SAB;    (* ���� ��� ������ ���������� *)
      Var fpSort: SAB;    (* ��������� ����������       *)
      Var fpPhoto:SAB     (* ������ ��� ���������       *)
  ):LPSAB;stdcall;


(*------------ �������� ��� ���������� �������� ������ -------------*)

(* ���������� (�������) �������� ������� *)
  Function htDivision(
      Var fpDst: SAB;     (* ��� ������ ���������� *)
      const fpSET: SAB;     (* ������������ ������� *)
      nElemNo  : SmallInt;(* ����� ���� �������� *)
      const fpLST: SAB      (* ������ �������� �������� *)
  ):LPSAB;stdcall;

(* �������� ����������� �������� �������� ��� ������������ ������� *)
  Function htHistogramOfKey(
      Var fpDst: SAB;     (* ��� ������ ���������� *)
      nElemNo  : SmallInt;(* ����� �������� ������ *)
      const fpSrc: SAB      (* ������������ ������� *)
  ):SmallInt;stdcall;

(* �������� ����������� �������� �������� � �������� ������ �������� *)
  Function htHistogramByCount(
      Var  fpDst: SAB;     (* ��� ������ ���������� *)
      nElemNo   : SmallInt;(* ����� �������� ������ *)
      const fpSrc : SAB;     (* ������������ �������  *)
      gMin      : LongInt; (* ����������� ����� �������� (�� ����� 1) *)
      gMax      : LongInt  (* ������������ ����� �����p��             *)
  ):SmallInt;stdcall;

(* ��������� ������ �������� �������� � ������ ������� *)
(* ����� ���� ������������ ��� ����� ������ �������� *)
  Function htTransferToTable(
      Var fpSrc: SAB;     (* ��p�� ���, ����������� ������ �������� *)
      hTable   : THANDLE; (* ���������� ��� ������ �������          *)
      nElemNo  : SmallInt (* ����� �������� � ������ �������        *)
  ):LPSAB;stdcall;

(* ��������� ������ �������� �������� � �������� "������" ������ ������� *)
  Function htTransferToPhoto(
      Var fpSrc  : SAB;    (* ��p�� ���, ����������� ������ �������� *)
      const fpPhoto: SAB;    (* ����� ���, ����������� ������ ������ ������� *)
      nElemNo    : SmallInt (* ����� �������� � ������ �������              *)
  ):LPSAB;stdcall;

(* �������� ������ �������� �������� ��� ������������ ������� *)
  Function htValuesOfKey(
      Var fpDst: SAB;     (* ��� ������ ���������� *)
      nElemNo  : SmallInt;(* ����� �������� ������ *)
      const fpSrc: SAB      (* ������������ ������� *)
  ):LPSAB;stdcall;

(* �������� ������ �������� �������� � �������� ������ �������� *)
  Function htValuesByCount(
      Var  fpDst: SAB;     (* ��� ������ ���������� *)
      nElemNo   : SmallInt;(* ����� �������� ������ *)
      const fpSrc : SAB;     (* ������������ ������� *)
      gMin      : LongInt; (* ����������� ����� �������� (�� ����� 1) *)
      gMax      : LongInt  (* ������������ ����� �����p��             *)
  ):LPSAB;stdcall;


(*----------------- ��������� �������� �������� -------------------*)

(* �������� ������� �������� �������� ��� ������������ ������� *)
  Function htAverageOfKeyValues(
      Var fpSrc: SAB;     (* ����� ���, ����������� ������������ ������� *)
      nElemNo  : SmallInt; (* ����� �������� ������ *)
      fpAverage: Pointer  (* ���� �������� ������� �������� *)
       (* LongInt ��� - �������������, Double - ��� �������������� *)
  ):SmallInt;stdcall;

(* �������� ������������ �������� �������� ��� ������������ ������� *)
  Function htKeyMaximum(
      Var fpSrc: SAB;     (* ����� ���, ����������� ������������ ������� *)
      nElemNo  : SmallInt; (* ����� �������� ������ *)
      fpMax    : Pointer  (* ���� �������� ������������ �������� *)
  ):SmallInt;stdcall;

(* �������� ����������� �������� �������� ��� ������������ ������� *)
  Function htKeyMinimum(
     Var fpSrc: SAB;     (* ����� ���, ����������� ������������ ������� *)
     nElemNo  : SmallInt; (* ����� �������� ������ *)
      fpMin   : Pointer  (* ���� �������� ����������� �������� *)
  ):SmallInt;stdcall;

(* �������� ����� �������� �������� ��� ������������ ������� *)
  Function htSumOfKeyValues(
      Var fpSrc: SAB;     (* ����� ���, ����������� ������������ ������� *)
      nElemNo  : SmallInt; (* ����� �������� ������ *)
      fpSum    : Pointer  (* ���� �������� ����� �������� �������� *)
     (* LongInt ��� - �������������, Double - ��� �������������� *)
  ):SmallInt;stdcall;

(*--------- ���������� �������� ��� ������������ ������ ---------*)

(* ��������� ���������� �������� *)
  Function htAndResults(
      Var fpDst : SAB;    (* ���� ��� ������ ���������� *)
      const fpSrc1: SAB;    (* ���� � ������ �����������  *)
      const fpSrc2: SAB     (* ���� �� ������ ����������� *)
  ):LPSAB;stdcall;

(* ���������� ���������� �������� *)
  Function htOrResults(
     Var fpDst : SAB;    (* ���� ��� ������ ���������� *)
     const fpSrc1: SAB;    (* ���� � ������ �����������  *)
     const fpSrc2: SAB     (* ���� �� ������ ����������� *)
  ):LPSAB;stdcall;

(* ��������� ���������� *)
  Function htNotResults(
     Var fpDst: SAB;    (* ���� ��� ������ ����������    *)
     const fpSrc: SAB     (* ���� � ���������� ����������� *)
  ):LPSAB;stdcall;

(* ����������? ���������� *)
  Function htXorResults(
     Var fpDst : SAB;    (* ���� ��� ������ ����������    *)
     const fpSrc1: SAB;    (* ���� � ������ ���������       *)
     const fpSrc2: SAB     (* ���� �� ������ ���������      *)
  ):LPSAB;stdcall;

{$IFDEF HT_NEWDLL}
(* ���������� ���������� *)
  Function htExcludeResults(
     Var fpDst : SAB;    (* ���� ��� ������ ����������    *)
     const fpSrc1: SAB;    (* ���� � ������ ���������       *)
     const fpSrc2: SAB     (* ���� �� ������ ���������      *)
  ):LPSAB;stdcall;

(* ���������� ���������� *)
  Function htRecordsByValues(
     Var fpDst : SAB;       (* ���� ��� ������ ����������    *)
     fpPHO     : LPSAB;     (* ��� "������" *)
     nKeyNo    : SmallInt;  (* ����� ����� (0-���.�����, 1-������ ���� � �.�.) *)
     nCond     : SmallInt;  (*  0 - in, 1 - not in *)
     fpValues  : Pointer;   (* ������ �������� ����� *)
     gCount    : longint    (* ���������� �������� *)
  ):SmallInt;stdcall;

  (* ������� ���������� ��������� �� ������ ���������� ��������� *)
(* � ����������� �� ���� ������ (�/� ��� ������), ��������:    *)
(*  "��� ������ ��� ������" ���                                *)
(*  "������ �������� d:\xxxx ���� �� ������".                  *)
  Function  htLastErrorText(
      lpszBuff: PAnsiChar;   (* ����� ��� ������ ������ ��������� *)
      nBuffSize : longint
  ):longint;stdcall;
{$endif}

(*---------------- �������� ��� ��������  -----------------*)
(* � ���������� ���������� �������� ���������� ������ ���������. *)
(* ������ ������� �������� �������� �����, �������� � ������, �� *)
(* �������� ������� �������� ������������ ��� �������� �����.    *)

(* ��������� ��������� �������� �� ������������ ������� ������� *)
(* �� ������ �������������� �������� ������ ���������� �������  *)
(* fpfHavingTo, ������� ����� ��������� ��������� �������� �    *)
(* ������ ������� � ������ ������� �������� ������. *)
  Function htGroupByHavingTo(
      Var fpDst  : SAB;      (* ���� ��� ������ ����������              *)
      const fpSrc  : SAB;      (* ���, �������� ������������ �������      *)
      fpnGroup   : PSmallInt;(* ������ �����, ���������� ������         *)
      nGroupCnt  : SmallInt; (* ����� ����� ����� (�� MAX_SORT_ORDER+1) *)
      fpsFunc    : LPGROUP;  (* ��������� ���������� ���������          *)
      nFuncCnt   : SmallInt; (* �� �����                                *)
      fpfHavingTo: LPHAVING; (* �������, ����������� ������� HavingTo   *)
      fpUser     : Pointer   (* ���.�������� ������������ *)
  ):SmallInt;stdcall;

(* ��������� ��������� �������� �� ������������ ������� ������� *)
(* �������������� ������������� *)
  Function htGroupByUser(
      Var fpDst  : SAB;      (* ���� ��� ������ ����������              *)
      const fpSrc  : SAB;      (* ���, �������� ������������ �������      *)
      fpnGroup   : PSmallInt;(* ������ �����, ���������� ������         *)
      nGroupCnt  : SmallInt; (* ����� ����� ����� (�� MAX_SORT_ORDER+1) *)
      fpsFunc    : LPGROUP;  (* ��������� ���������� ���������          *)
      nFuncCnt   : SmallInt; (* �� �����                                *)
      fpfSort  : LPOFUNC;  (* ������� ��������� ��� ����������        *)
      fpfDiff  : LPOFUNC;  (* ������� ��������� ��� �����������       *)
      fpfHavingTo: LPHAVING; (* �������, ����������� ������� HavingTo   *)
      fpUser     : Pointer   (* ���.�������� ������������ *)
  ):SmallInt;stdcall;

(* ���������� ������ �������� ����� �� ����������� ����������� *)
(* ������ � �������� ����������� ������ ���� ������ *)
  Function htValuesFromGroup(
      Var fpDst  : SAB;      (* ���� ��� ������ ������ �������� �����    *)
      nKeyNo     : SmallInt; (* ����� ����, �������� �������� ���������� *)
      wOffset    : Word;     (* �������� ������ ���� � ������            *)
      const fpSrc  : SAB       (* ���, �������� ���������� �����������     *)
  ):LPSAB;stdcall;

(*---------------- ������������ ��������  -----------------*)

(* ������� ���� ������ ����� ����� ������� *)
  Function htTablesJoin(
      Var fpDst : SAB;       (* ���� ��� ������ ����������               *)
      Var fpFRST: SAB;       (* ������� ��� ������ �������               *)
      nFiElNo   : SmallInt;  (* ����� ��������-������ � ������ �������   *)
      nCond     : ThtCondition; (* ��� ������� (���� ������ EQUAL)          *)
      Var fpSCND: SAB;       (* ������� ��� ������ �������               *)
      nScElNo   : SmallInt;  (* ����� ��������-������ �� ������ �������  *)
      fpCOND    : LPSAB;     (* ���� �� Nil, ����������� �����  �������, *)
           (* �������� � JOIN, ��� ����� �� ������     *)
      bFirst    : Boolean;   (* ���� true, �� ����� ������� �� ������    *)
           (* �������                                  *)
      nMode     : SmallInt   (* ����� ������ �������� ��� *)
  ):LPSAB;stdcall;

(* �����������/������� ���������� ��������� ������ *)
  Function htTablesLink(
      Var fpDst: SAB;    (* ���� ��� ������ ����������         *)
      const fpGroup: SAB;  (* ������ ��������� ������            *)
      const fpPair: SAB;   (* ���� ��������� ������              *)
      bSkipLink: Boolean;(* ��� true �������� ������ ����� ��� *)
       (* �������-������                     *)
      nMode: SmallInt     (* ����� ������ (DRAFT_??? Or LINK_???*)
  ):LPSAB;stdcall;


(* ���������� ������������ ������� �������, �������� � ������� *)
  Function htJoinedRecords(
      fpStart    : LPSAB;  (* "������" ������� ��� ������������ *)
      Var fpDst  : SAB;    (* ���� ��� ������ ����������        *)
      const fpGroup: SAB;    (* ������ ��������� ������           *)
      nTabNo     : SmallInt (* ����� ������� ������ ������ (������ �� 0) *)
  ):LPSAB;stdcall;

(* ���������� ����� ������ � �������� ������ ������ � *)
(* ������� �� ������������. ���������� ����� ������ � *)
(* ��������� ������ ������������� ������ � ������� �� *)
(* ������������ � �������� ������. ������ ������� ��� *)
(* ������ ������������ ������ ������ ���� �� �����    *)
(* ��������� MAX_TAB_LINK                             *)
(* ���� ����������� �� �����, ����� ������ Nil        *)
  Function htTellJoinOrder(
      Var fpSrc: SAB;       (* ��������� �����                 *)
      fpHandles: LPTHANDLE  (* ���� ������� ����������� ������ *)
  ):SmallInt;stdcall;

(* ���������� �������������� �������� ����� �� ������,  *)
(* �������� � ������ �������. �������� �������� �����   *)
(* ���������� �� ������ ���������� ������, �.�. ������, *)
(* ��������� �� ������� ���� ������ ������.             *)
  Function htJoinElement(
      Var fpSrc: SAB;       (* ��������� �����                       *)
      nTableNo : SmallInt;   (* ����� ������� � ������ ������ (�� 1)  *)
      nElemNo  : SmallInt;   (* ����� �������� � ������� (�� 0, ������� ���.�����) *)
      fpElement: LPELEMENT; (* ��������� ��� �������� ��������       *)
      bReadName: Boolean    (* ��� true ������ ��� �������� �� ����� *)
  ):SmallInt;stdcall;

(*----------------------- �������� ----------------------*/

(* ������� ���������� ������� ��� ������ ������ *)
  Function htCreateClusterTable(
      Var fpLink:  SAB;       (* ��� �� ������� ������ *)
      fpTableName: PAnsiChar;     (* ��� ������� ��������� *)
      fpCryptoKey: PAnsiChar;     (* ���� ��� ������-�������� ������ *)
      fpReadPswd : PAnsiChar;     (* ������ ��� ������� �� ������ *)
      fpWritePswd: PAnsiChar;     (* ������ ��� ������� �� ������ *)
      bIndex:    Boolean    (* True - ������������� ������� ��������� *)
  ):SmallInt;stdcall;

(* ������������� ������ ���������� ������� � ��������� ����� ������ *)
  Function htClusterItemToLink(
      Var fpDst: SAB;     (* ��� ������ ���������� *)
      hTable:  THANDLE;     (* ������� ��������� *)
      hRecord: RHANDLE;     (* ������ ������� ��������� *)
      fpHandles: LPTHANDLE  (* ����������� ����������� ������ *)
  ):LPSAB;stdcall;

(* ������������� ������ ���������� ������� � ��������� ����� ������ *)
  Function htClusterRecsToLink(
      Var fpDst: SAB;     (* ��� ������ ���������� *)
      const fpSrc: SAB;     (* ������ ������� ��������� *)
      fpHandles: LPTHANDLE  (* ����������� ����������� ������ *)
  ):LPSAB;stdcall;

(*----------------------- ������� ----------------------*)

(* ���������� ������ ������� ������������� *)
(* ����� �������� ������� ��������� ����� ������ *)
  Function htFilterRecords(
      Var fpDst: SAB;      (* ��� ������ ���������� *)
      const fpSrc: SAB;      (* ����� ���, ����������� ������ ������� *)
      fpFieldNo: PSmallInt;(* ������ �����, ���������� ������� �� ������ *)
         (* Nil - ��� ���� ������ *)
      nFieldCnt: SmallInt; (* ����� ���������� ����� *)
      fpfFilter: LPSFUNC;  (* ����� ���������������� ������� ���������� *)
      fpUser   : Pointer   (* ���.�������� ������������ *)
  ):LPSAB;stdcall;

(* ���������� ������� ������ �������� ������ *)
  Function htFilterTables(
      Var fpDst: SAB;      (* ��� ������ ���������� *)
      fppSABs:   LPPSAB;   (* ������ ������ � ������������ ������� � ��� *)
      nTableCnt: SmallInt; (* ����� ������ (���'��) *)
      fpFieldNo: PSmallInt;(* ������ ����� ������ ��� ������� *)
      nFieldCnt: SmallInt; (* ����� ���������� ����� *)
      fpLinks:   LPLINK;   (* ��������� ������ ������ *)
      nLinkCnt:  SmallInt; (* ����� ������ *)
      fpfFilter: LPSFUNC;  (* ����� ���������������� ������� ���������� *)
      fpUser   : Pointer;  (* ���.�������� ������������ *)
      nMode    : SmallInt  (* ������ ���������� ������ *)
  ):LPSAB;stdcall;

(*------------ ������ � ������������ ������ ------------*)

(* ������� ���������� ������ ��� ��� {HTCOD2] *)
  Procedure htClearResults( Var fpSrc: SAB );stdcall;

(* ������� ������ � ����������� ������ � ��� *)
  Procedure htCloseResults(const fpSrc: SAB );stdcall;

(* ����������� ���������� ������                    *)
(* ������ � �������� ����������� ������ ���� ������ *)
  Function htCopyResults(
      var fpDst: SAB;      (* ����� ��� ��� ������ ����� *)
      const fpSrc: SAB       (* ����� ��������� ���        *)
  ):SmallInt;stdcall;

(* ������������� ���������� ������ �� �������� ����� *)
(* ������ � �������� ����������� ������ ���� ������  *)
  Function htDistinctResults(
      Var fpDst: SAB;      (* ��� ������ ��������������� ����������� *)
      const fpSrc: SAB;      (* ����������������� ���������� ������    *)
      fpFieldNo: PSmallInt;(* ������ ����� - ��������� ������������  *)
			   (* Nil - �� ���� ������ � ������������    *)
      nFieldCnt: SmallInt  (* ����� �����-���������                  *)
  ):SmallInt;stdcall;

(* ������������� ���������� ������ �� �������� �������� *)
(* ��������� �� ����������, ����� �������� ������� ��   *)
(* ��������� �������� �������� � ������������ ��������  *)
(* ������ � �������� ����������� ������ ���� ������ *)
  Function htDistinctResultsByCount(
      Var fpDst: SAB;      (* ��� ������ ��������������� ����������� *)
      const fpSrc: SAB;      (* ����������������� ���������� ������    *)
      fpFieldNo: PSmallInt;(* ������ ����� - ��������� ������������  *)
			   (* Nil - �� ���� ������ � ������������    *)
      nFieldCnt: SmallInt; (* ����� �����-���������                  *)
      gMin:	 LongInt;  (* ����������� ����� �������� *)
      gMax:	 LongInt   (* ������������ ����� �������� *)
  ):SmallInt;stdcall;

(* ������� ������ � ����������� ������ � ��� *)
  Function htOpenResults(
      const fpSrc: SAB;      (* ����� ��������� ���                       *)
      (* ��������� ��������� ����� ����� ������ ��� �����������-������� *)
      nMode   : SmallInt;  (* ����� �������� (��.ROPEN_????)            *)
      fpElemNo: PSmallInt; (* ������ �������� ��������� ������          *)
         (* ���� Nil - ��������� ��� �������� ������  *)
      nElemCnt: SmallInt   (* ����� ��������� ���������                 *)
  ):SmallInt;stdcall;

(* ������ ���������� ������ �� ���                      *)
(* ���������� ����� ��������� ������.                   *)
(* ������ ��������� ����� �� ����� MAX_BUF_LEN ������.  *)
(* ���� �������� �� MAX_BUF_LEN �� $FFFF - ���� ������ *)
  Function htReadResults(
      const fpSrc: SAB;        (* ����� ��������� ���     *)
      fpBuff   : Pointer;    (* ����� ��� ������ ������ *)
      wLen     : Cardinal    (* ����� ������            *)
  ):Cardinal;stdcall;

(* ���������� ����� ������ �������� ���������� *)
(* ������ � ����������� ������ ���� ������     *)
  Function htResultsItemLen(
      const fpSrc   : SAB;     (* ����� ��������� ��� *)
      Var wItemLen: Cardinal (* ����� ��������      *)
  ):SmallInt;stdcall;

(* ���������� ����� ����� ������ � �������� ���������� *)
  Function htResultsItemCnt(
      const fpSAB: SAB    (* ����� ��������� ��� *)
  ): SmallInt;stdcall;

(* �������� ��������� ����� ������ � �������� ���������� *)
  Function htResultsItemParm(
      const fpSAB: SAB;   (* ����� ��������� ��� *)
      fpParm: LPOPEL          (* ��� ������ ���������� *)
  ): SmallInt;stdcall;

(* ����������� ����������� ��������� �� ����������� ������ *)
  Function htSeekResults(
      const fpSrc : SAB;        (* ����� ��������� ���  *)
      gOffset   : LongInt;    (* �������� ����������� *)
      nFromWhere: RSEEK_MODE  (* ����� �����������    *)
  ):LongInt;stdcall;

(* �������� ���������� ����� ������ �� �� ����������� ������. *)
(* ������ �� 0. ������ � ����������� ������ ���� ������. *)
(* ����� ����� ��� ����������� ���� RES_RCRD *)
  Function htRecordOrdinalNumber(
      const fpSrc : SAB;        (* ����� ��������� ��� *)
      gNumber   : LongInt     (* ���������� ����� *)
  ):LongInt;stdcall;

(* ���������� ������ �� ������� ������ ��������� ���������� ������ *)
  Function htMarkRecord(
      const fpSrc   : SAB;   (* ����� ��������� ��� ������ ��� *)
      Var fpMark  : MARKER     (* ������ ������ *)
  ):SmallInt;stdcall;

(* ���������� ������ �� ������� ������ ����� �� ������ ������� *)
  Function htMarkJoinedRecord(
      const fpSrc   : SAB;   (* ����� ��������� ��� ������ ��� *)
      nTabNo      : SmallInt;  (* ����� ������� ������ ������ (������ �� 0) *)
      Var fpMark  : MARKER     (* ������ ������ *)
  ):SmallInt;stdcall;

(* ���������� ������ �� ������� ������ ������� ������ *)
  Function htMarkJoinedRecordEx(
      const fpSrc   : SAB;   (* ����� ��������� ��� ������ ��� *)
      fpMark   : LPMARK    (* ������ �������� (�� ����� ������) *)
  ):SmallInt;stdcall;

(* ����������� ����������� ��������� �� ������������� ����� ������ *)
  Function htSeekMarkedJoin(
      const fpSrc   : SAB;   (* ����� ��������� ��� ������ ��� *)
      nTabNo      : SmallInt;  (* ����� ������� ������ ������ (������ �� 0) *)
      Var fpMark  : MARKER     (* ������ ������ *)
  ):SmallInt;stdcall;

(* ����������� ����������� ��������� �� ������������� ������ *)
  Function htSeekMarkedJoinEx(
      const fpSrc   : SAB;   (* ����� ��������� ��� ������ ��� *)
      fpMark   : LPMARK    (* ������ �������� (�� ����� ������) *)
  ):SmallInt;stdcall;

(* ����������� ����������� ��������� �� ������������� ����� ������ *)
  Function htSeekMarkedRecord(
      const fpSrc   : SAB;   (* ����� ��������� ��� ������ ��� *)
      Var fpMark  : MARKER     (* ������ ������ *)
  ):SmallInt;stdcall;

(* ���������� ����������� ������ (���� ��� ������)       *)
(* ������������� ����� ����� - ���������� �� ����������� *)
(* ������������� ����� ����� - ���������� �� ��������    *)
  Function htSortResults(
      Var fpDst: SAB;        (* ��� ������ ����������        *)
      const fpSrc: SAB;        (* ����� ��������� ���          *)
      mOrder   : PSmallInt;  (* ������ ������ �������������� *)
      nOrderCnt: SmallInt    (* ����� ������ ��������������  *)
  ):SmallInt;stdcall;

(* ���������� ����������� ������ ��� ��������� ������������ *)
   Function htSortResultsByUser(
      Var fpDst: SAB;        (* ��� ������ ����������        *)
      const fpSrc: SAB;        (* ����� ��������� ���          *)
      mOrder   : PSmallInt;  (* ������ ������ �������������� *)
      nOrderCnt: SmallInt;   (* ����� ������ ��������������  *)
      fpfComp  : LPOFUNC;    (* ������� ��������� ���������  *)
      fpUser   : Pointer     (* �������� ������������ ��� ������� *)
   ):SmallInt;stdcall;

(* ��������� ������������ ����������� ������.        *)
(* ����� ����� ��� ���� �����������, ����� RES_JOIN. *)
  Function htIsResultObsolete(
      Var fpSrc   : SAB     (* ���������� ������  *)
  ):LPSAB;stdcall;

(* "��������" ���������� ������ (������), ��������  *)
(* �� � ������������ � �������� ���������� �������. *)
(* ������ � �������� ����������� ������ ���� ������ *)
  Function htSyncResults(
      Var fpFresh : SAB;    (* ���� ��� ������ "�������" ���������� *)
      const fpPhoto : SAB;    (* ���� � �������� ������� *)
      const fpOld   : SAB     (* ���� �� ������ �����������  *)
  ):LPSAB;stdcall;

(* "��������" ���������� ������ (������), ��������  *)
(* �� � ������������ � ������� ���������� �������.  *)
(* ������ � �������� ����������� ������ ���� ������ *)
  Function htTouchResults(
      Var fpFresh : SAB;    (* ���� ��� ������ "�������" ���������� *)
      const fpOld   : SAB     (* ���� �� ������ �����������  *)
  ):LPSAB;stdcall;

(* ���������� ����� ��������, ��� �������� ������� ��������� � ��� *)
(* ����� ����� ��� ����������� ���� RES_VALUE � RES_HISTO.         *)
  Function htResultsElement(
      const fpSrc   : SAB;     (* ����� ��������� ���  *)
      Var fpElemNo: SmallInt  (* ����� �������� *)
  ):SmallInt;stdcall;

(* ���������� �������, ��� ������� ������� ��������� � ��� *)
(* ����� ����� ��� ���� �����������, ����� RES_JOIN.       *)
  Function htResultsTable(
      const fpSrc   : SAB;    (* ����� ��������� ���                    *)
      Var fpHandle: THANDLE (* �������, ��� ������� ������� ��������� *)
  ):SmallInt;stdcall;

(* ���������� ��� ���������� ��� ���     *)
(* ���������� ���� �� �������� RES_????? *)
  Function htResultsType(const  fpSrc: SAB ):SmallInt;stdcall;

(* ���������� ������ ��-��� ����������   *)
(* ��������� ���������� �� ������ � ���� *)
  Function htResultsToHard( Var fpSrc: SAB ):SmallInt;stdcall;

(* ���������, ������ �� ������ � ����������� ������ *)
(* 0 - ���, !=0 - �� *)
  Function htIsResultOpen( Var fpSrc: SAB ):Boolean;stdcall;

(* ��������� ���������� ������� � ����������� �� ����� *)
(* ���������� ������ ���� ������� *)
  Function htReplaceResultsTable(
      const fpSrc : SAB;     (* ����� ��������� ���       *)
      hTable    : THANDLE; (* ������ ���������� ������� *)
      nTabNo    : SmallInt (* ���������� ����� ������� ��� JOIN (�� 0) *)
  ):SmallInt;stdcall;


(*---------- ������ � ���������� �������� ----------*)

(* ���������� ���������� ������ �� ���.������ � ������ *)
(* ���� ������ ���� (Nil), ������� ��������� ��������� ������� *)
  Function htHandleFromRecNo(
      fpPHO: LPSAB;   (* ������ ��� ������ *)
      hTable: THANDLE;  (* ���������� ������� *)
      gRecNo:LongInt;   (* ����� ������ *)
      Var fphHandle:RHANDLE (* ��� ������ ����������� *)
  ):SmallInt;stdcall;

(* ���������� ����� ������ �� ����������� *)
  Function htRecNoFromHandle(
      hTable: THANDLE;  (* ���������� ������� *)
      hHandle: RHANDLE  (* ���������� ������ *)
  ):LongInt;stdcall;

(* ���������� ������ � �������. ���������� htRecordAdd, *)
(* �� ���������� ����� ���������� ����������� ������. *)
  Function htHandleAdd(
      hTable: THANDLE;  (* ���������� ��� ������� *)
      fpRecord: Pointer;  (* ���� ������ *)
      Var fphRecord: RHANDLE  (* ���������� ����������� ������ *)
  ):LongInt;stdcall;

(* ����������� ������ � �������. ���������� htRecordModify, *)
(* �� ���������� ����� ���������� ���������������� ������. *)
  Function htHandleModify(
      hTable: THANDLE;  (* ���������� ������� *)
      gRecNumber: LongInt;  (* ����� �������������� ������ *)
      fpRecord: Pointer;  (* ���� ������ *)
      Var fphRecord: RHANDLE  (* ���������� ���������� ������ *)
  ):SmallInt;stdcall;

(* ������� ���� ������ �� �� ������ � �������� "������" *)
(* ���� ������ ��� (Nill), ������ ��������� ��������� ������ *)
  Function htReadRecord(
      fpPHO: LPSAB;   (* ������ ��� ������ *)
      hTable: THANDLE;  (* ���������� ������� *)
      gRecNo: LongInt;  (* ����� �������� ������ *)
      fpBody: Pointer   (* ��� ������ ���� ������ *)
  ):SmallInt;stdcall;

(* ������� ������ �� �� ����������� *)
(* �������� ������������ ����������� �� ������������ *)
  Function htReadRecordByHandle(
      hTable: THANDLE;  (* ���������� ������� *)
      hHandle: RHANDLE; (* ���������� �������� ������ *)
      fpRecord: Pointer (* ��� ������ ���� ������ C ������� *)
  ):SmallInt;stdcall;

(*---------- �������������� ����������� ������ ----------*)

(* ������� ������ ��������� ��� ������� *)
  Function htCreateEmptySAB(
      fpPHO: LPSAB;   (* ������ ������� *)
      Var fpSAB: SAB;   (* ����� ��� *)
      hTable: THANDLE;  (* ���������� ������� *)
      nItemNo: SmallInt;  (* ����� �������� *)
      nType: SmallInt   (* ��� ��� (��.RES_????) *)
  ):LPSAB;stdcall;

(* ������� ������ ��������� ��� ������ ������ *)
  Function htCreateEmptyJoin(
      Var fpSAB: SAB;   (* ��� *)
      fphTabs: LPTHANDLE; (* ����������� ������ *)
      nTabCnt: SmallInt (* ����� ������ *)
  ):LPSAB;stdcall;

(* ��������� ������� �� ����������� ������ *)
(* ������ � �������� ����������� ������ ���� ������ *)
  Function htExcludeResultsItem(
      const fpSrc: SAB;   (* ����� ��������� ��� *)
      gItemNo: LongInt  (* ���������� ����� �������� (�� 0) *)
                        (* RES_RECORD - ���.����� ������ *)
  ):SmallInt;stdcall;

(* ������� ������� ���������� ������ - ���������� ������(��) *)
(* ������ � �������� ����������� ������ ���� ������ *)
(* �������� ��� ����������� RES_SORTED � RES_JOIN *)
  Function htGetResultsItem(
      const fpSrc: SAB;   (* ����� ��������� ��� *)
      gItemNo: LongInt; (* ���������� ����� �������� (�� 0) *)
      fpItem: LPRHANDLE       (* ��� ������ �������� ���������� *)
      (* ����� �������� ������������ ����� ����������: *)
      (* RES_SORTED - sizeof(RHANDLE) *)
      (* RES_JOIN - sizeof(RHANDLE) * �����_������_������� *)
  ):SmallInt;stdcall;

(* �������� ����� ��������� � ���������� ������ *)
(* ������ � �������� ����������� ������ ���� ������ *)
  Function htIncludeResultsBlock(
      const fpSrc: SAB;         (* ����� ��������� ��� *)
      gInsPos: LongInt;       (* ������� ������� �������� (������ �� 0) *)
                              (* RES_RECORD - �� ����� ������ *)
      fpBlock: Pointer;       (* ����� ����� ��������� ���������� *)
      wBlockLen: Cardinal     (* ����� ����� � ������ *)
  ):SmallInt;stdcall;


(* �������� ������� � ���������� ������ *)
(* ������ � �������� ����������� ������ ���� ������ *)
  Function htIncludeResultsItem(
      const fpSrc: SAB;   (* ����� ��������� ��� *)
      gItemNo: LongInt; (* ������� ������� �������� (������ �� 0) *)
            (* RES_RECORD - ���.����� ������ *)
      fpNewItem: Pointer  (* ����� ������� ����������: *)
        (* RES_SORTED - ���������� ������ *)
        (* RES_JOIN - ������ ������������ ������� ��� ������ ������� *)
        (* RES_VALUE, RES_HISTO, RES_GROUP - ���� �������� *)
  ):SmallInt;stdcall;

(* �������� ������� � ����������� ������ *)
(* ������ � �������� ����������� ������ ���� ������ *)
  Function htReplaceResultsItem(
      const fpSrc: SAB;   (* ����� ��������� ��� *)
      gItemNo: LongInt; (* ������� �������� (������ �� 0) *)
      fpNewItem: Pointer  (* ����� ������� ����������: *)
        (* RES_SORTED - ���������� ������ *)
        (* RES_JOIN - ������ ������������ ������� ��� ������ ������� *)
        (* RES_VALUE, RES_HISTO, RES_GROUP - ���� �������� *)
  ):SmallInt;stdcall;

(*---------- ����� ����������� ������ � ������� ----------*)

(* �������������� ����������� � �������                                 *)
(* ����������� ������ ����������� � ������ �� � ������� hOutTable.      *)
(* �� ������ ������� ���������� ����������� ����� fpfRecProc(), ������� *)
(* ����� ���������� ����������� ��������� �������� ���������� �� ����-  *)
(* ������� ��� � ������ ������� hOutTable. ������ ������ ���� �������   *)
(* ����������� �� ������������ ��������. � ������ ������ ����������     *)
(* ������� fpfErrProc. ��� �����������-������� (RES_RECORD, RES_SORTED, *)
(* RES_JOIN) ����� ���� ������ ������ �����, ������� ����� ����������   *)
(* ��� ������������ �������� ������.                                    *)
(* ���������� ����� ����������� ������� ��� ��� ������ *)
  Function htResultsToTable(
      const fpSrc : SAB;      (* ����� ��������� ���                       *)
      hOutTable : THANDLE;  (* ���������� ��� ����������� �������        *)
      fpfRecProc: LPRFUNC;  (* ���������������� ������� ��������� ������ *)
          (* Nil - ��������� �� ����� (��� ������)     *)
      fpfErrProc: LPEFUNC;  (* ���������������� ������� ��������� ������ *)
          (* Nil - ������ ��������� ����               *)
      fpUser    : Pointer;  (* ���.�������� ������������                 *)
      (* ��������� ����� ����� ��� ����������� - ������� *)
      fpElemNo  : PSmallInt;(* ������ ��������� ��������� ���.������     *)
      nElemCnt  : SmallInt; (* ����� ��������� ���������                 *)
      bDenyOut  : Boolean;  (* ��� true ����� ����������� ������� � �������  *)
      bCorrect  : Boolean   (* ��� true ��������� ������������ � ����-������ *)
  ):LongInt;stdcall;

(*------------------- ���������� �������� ------------------*)

(* ������� ������-���� �������� ������ *)
(* ������� ������ ���� �������         *)
  Function htChangeCryptoKey(
      fpTableName: PAnsiChar;   (* ��� ������� (����� ��� ����������) *)
      fpReadPswd : PAnsiChar;   (* ������ ������� �� ������           *)
      fpWritePswd: PAnsiChar;   (* ������ ������� �� ������           *)
      fpOldCrypto: PAnsiChar;   (* ������ ������-���� �������� ������ *)
      fpNewCrypto: PAnsiChar;   (* ����� ������-���� �������� ������  *)
      bReIndex   : Boolean  (* ������������� ������� *)
  ):SmallInt;stdcall;

(* ������� ������ ������� �� ������ *)
(* ������� ������ ���� �������      *)
  Function htChangeReadPassword(
      fpTableName  : PAnsiChar; (* ��� ������� (����� ��� ����������) *)
      fpWritePswd  : PAnsiChar; (* ������ ������� �� ������           *)
      fpOldReadPswd: PAnsiChar; (* ������ ������ ������� �� ������    *)
      fpNewReadPswd: PAnsiChar  (* ����� ������ ������� �� ������     *)
  ):SmallInt;stdcall;

(* ������� ������ ������� �� ������ *)
(* ������� ������ ���� �������      *)
  Function htChangeWritePassword(
      fpTableName   : PAnsiChar;  (* ��� ������� (����� ��� ����������) *)
      fpReadPswd    : PAnsiChar;  (* ������ ������� �� ������           *)
      fpOldWritePswd: PAnsiChar;  (* ������ ������ ������� �� ������    *)
      fpNewWritePswd: PAnsiChar   (* ����� ������ ������� �� ������     *)
  ):SmallInt;stdcall;

(*-------------------- ������� ��������� -------------------*)

(* ���������� ��������� �� ������� ������ � ��������� �� *)
  Function htHoldFreeRecords(
      hTable   : THANDLE;  (* ���������� �������                           *)
      Var fdDst: SAB       (* ���� ��� ������ ��������� �� ������� ������� *)
  ):LPSAB;stdcall;

(* ��������� ������ ������� *)
  Function htHoldRecord(
      hTable: THANDLE;   (* ���������� �������         *)
      gRecNo: LongInt    (* ����� ������������� ������ *)
  ):SmallInt;stdcall;

(* ��������� ������ ������� � ������� �� ���� *)
  Function htHoldReadRecord(
      hTable  : THANDLE; (* ���������� �������         *)
      gRecNo  : LongInt; (* ����� ������������� ������ *)
      fpRecord: Pointer  (* ��� ������ ���� ������ *)
  ):SmallInt;stdcall;

(* ��������� ���������� ������ - ��������� ������� *)
  Function htHoldResults( Var fpSrc: SAB ):SmallInt;stdcall;

(* ��������� ������� ������� *)
  Function htHoldTable( hTable: THANDLE ):SmallInt;stdcall;

(* ���������� ����������� ������ ������� *)
  Function htReleaseRecord(
      hTable: THANDLE;   (* ���������� �������         *)
      gRecNo: LongInt    (* ����� ������������� ������ *)
  ):SmallInt;stdcall;

(* ���������� ����������� ���������� ������ - ��������� ������� *)
  Function htReleaseResults( Var fpSrc: SAB ):SmallInt;stdcall;

(* ���������� ����������� ������� *)
  Function htReleaseTable( hTable: THANDLE ):SmallInt;stdcall;

(* ���������� ������� ��� ������� �������� *)
  Procedure htSetLockTimeOut(
      Second:Word             (* �������� �������� � �������� *)
  );stdcall;

(*------------------- ��������� ���������� -----------------*)

(* ���������� ������� ��� ���������� *)
  Procedure htSetTransTimeOut(
      Second:Word             (* �������� �������� � �������� *)
  );stdcall;

(* ������ ���������� �� ������ ������ *)
  Function htStartTransaction(
      fpTables:   LPTHANDLE;  (* ������ ������������ ������ *)
      nTabCnt :   SmallInt;   (* ����� ������ � ������ *)
      Var fpTrans:TRID        (* ��� ������ �������������� ���������� *)
  ):SmallInt;stdcall;

(* �������� ���������� ���������� *)
  Function htCommitTransaction(
      Var fpTrans:TRID        (* ������������� ���������� *)
  ):SmallInt;stdcall;

(* ��������� ���������� ���������� *)
  Function htRollBackTransaction(
      Var fpTrans:TRID        (* ������������� ���������� *)
  ):SmallInt;stdcall;

(* ��������� ������������� ������ ���������� ��� ������� *)
(* ����� �������� ����� ��������� ������ HT_ERR_TRT_ROLLED *)
(* ��� ������ ������, ��������� ��� ������ � �� ���������� *)
  Function htIsNeedToRoll(
      hTable     : THANDLE;   (* ���������� ������� *)
      Var fpTrans:TRID        (* ������������� ���������� *)
  ):SmallInt;stdcall;

(* ��������� �������������� ������� �����-���� ���������� *)
  Function htIsTransactionalTable(
      hTable     : THANDLE    (* ���������� ������� *)
  ):SmallInt;stdcall;

(*--------------------- ������������ ----------------------*)
(* ����������� - ������������� ���� {����:����������}.     *)
(* ������������ ��� ������������ ���������� �������� ����� *)
(* ��� ��������� ������ �����������.                       *)
(* ����� ���������� ����� �� ����� ���� ������ �����.      *)
(* ����� �������������� ����������� ������ ���� ��������   *)
(* � ������.   *)

(* �������� ���������� � ������������ *)
  Function htCoderInfo(
      hCoder    : CHANDLE;      (* ���������� ������������ *)
      Var fpInfo: CODINF        (* ��������� ��� ���������� *)
  ):SmallInt;stdcall;

(* ����� ���� ��� ��������� ���������� *)
  Function htFindCoderKey(
      hCoder : CHANDLE;      (* ���������� ������������ *)
      fpKey  : Pointer;      (* ��� ������ �������� ����� *)
      fpValue: Pointer       (* ����������� �������� ���������� *)
  ):SmallInt;stdcall;

(* ����� ��� ��������� ����� ��� ���������� *)
  Function htFindCoderValue(
      hCoder : CHANDLE;      (* ���������� ������������ *)
      fpKey  : Pointer;      (* ����������� �������� ����� *)
      fpValue: Pointer       (* ��� ������ �������� ���������� *)
  ):SmallInt;stdcall;

(* ��������� ����������� � ������ *)
(* ������� ����� ���� ��� ������� *)
  Function htLoadCoder(
      fpTableName : PAnsiChar;    (* ��� ������� (����� ��� ����������) *)
      fpReadPswd  : PAnsiChar;    (* ������ ������� �� ������           *)
      nOpenMode   : SmallInt; (* ����� �� �������� (���� ��� �� �������) *)
      anFieldsNum : PSmallInt;(* ��������������� ������ ����� ������� *)
      (* ������ ����� - ����� ����� ��� ������������ *)
      (* ����������� ������ ������ ����, ���������� ���������� ����� *)
      nFieldCnt   : SmallInt; (* ����� ����� � ������� *)
      Var fpCoder : CHANDLE   (* ��� ������ ����������� ������������ *)
  ):SmallInt;stdcall;

(* ������� ����������� �� ������ *)
  Procedure htPurgeCoder(
      hCoder : CHANDLE        (* ���������� ������������ *)
  );stdcall;

(* ������� ����������� � ������ ��� �������� ������� *)
(* ������ ������� - ���������� �� �������� ���� *)
(* ����� �������� ���� {����:����������} *)
(* �������� ������� - ���������� �� �������� ���������� *)
(* ����� �������� ���� {����������:����} *)
  Function htReadCoder(
      hCoder  : CHANDLE;     (* ���������� ������������ *)
      fpBuf   : Pointer;     (* ����� ��� ������ *)
      bInverse: Boolean      (* true - ����� � �������� ������� *)
  ):SmallInt;stdcall;

(* ������� ������ � ����������� ������ � ��� *)
(* � ������, ���� ���� ������� ����� ������������ *)
  Function htOpenCodedResults(
      const fpSrc : SAB;       (* ����� ��������� ��� *)
      fpFields  : LPCDF;     (* ��������� �������� ��������� *)
      nFieldCnt : SmallInt   (* ����� �������� ��������� *)
  ):SmallInt;stdcall;

(* �������������� ������������ ����������� � ������� *)
(* ������� ���������� htResultsToTable, �� ��������� ��������� *)
(* ������������� �����.  *)
  Function htCodedResultsToTable(
      const fpSrc : SAB;      (* ����� ��������� ���                       *)
      hOutTable : THANDLE;  (* ���������� ��� ����������� �������        *)
      fpfRecProc: LPRFUNC;  (* ���������������� ������� ��������� ������ *)
          (* Nil - ��������� �� ����� (��� ������)     *)
      fpfErrProc: LPEFUNC;  (* ���������������� ������� ��������� ������ *)
          (* Nil - ������ ��������� ����               *)
      fpUser    : Pointer;  (* ���.�������� ������������                 *)
      fpElemNo  : LPCDF;    (* ������ ��������� ��������� ���.������     *)
      nElemCnt  : SmallInt; (* ����� ��������� ���������                 *)
      bDenyOut  : Boolean;  (* ��� true ����� ����������� ������� � ������� *)
      bCorrect  : Boolean   (* ��� true ��������� ������������ � ����-������ *)
  ):LongInt;stdcall;

(*------------------------ ������/������� --------------------------*)

(* �������� �������� ������ ������� � ����� ������ �������� *)
(* ������� ����� ���� ������� *)
  Function htExport(
      nMode:       EXPMODE;   (* ��� �������� *)
      fpSrcTabName:PAnsiChar; (* ��� ������� ��������� ����� *)
      fpReadPswd:  PAnsiChar;     (* ������ ������ *)
      nOpenMode:   SmallInt;  (* ����� �������� �������� ������� *)
      fpDstName:   PAnsiChar;     (* ��� ������������ ����� *)
      fpFmt:       PhtFormat (* ��������� �������� *)
  ):SmallInt;stdcall;

(* �������� ������� ������ ������� �� ������ ������ �������� *)
(* ������� ������ ���� ������� *)
  Function htImport(
      nMode:       IMPMODE;   (* ��� ������� *)
      fpDstTabName:PAnsiChar;     (* ��� �������, ���������� ��� ������� *)
      fpReadPswd:  PAnsiChar;     (* ������ ������� �� ������ *)
      fpWritePswd: PAnsiChar;     (* ������ ������� �� ������ *)
      nOpenMode:   SmallInt;  (* ����� �������� ���������� ������� *)
      fpSrcName:   PAnsiChar;     (* ��� ��������� ����� *)
      fpSrcTabName:PAnsiChar;     (* ��� ������� ��� ��������� ASCII ����� *)
      fpFmt:       PhtFormat;  (* ��������� �������� *)
      bLogFile:    Boolean;   (* !=0 ����� ������ ������� *)
      bToConst:    Boolean    (* !=0 ����� � ���������� ����� ������� *)
  ):LongInt;stdcall;

(* �������� ������� ��������� ������� �� ������ ������ �������� *)
(* ��������� ������ ���� dBase � HyTech1.6 *)
  Function htImportTitle(
      fpSrcName  : PAnsiChar;    (* ��� ��������� ����� dBase ��� HyTech 1.6 *)
      fpTableName: PAnsiChar;    (* ��� �������, ���������� ��� ������� *)
      fpCryptoKey: PAnsiChar;    (* ������ ���������� ������ *)
      fpReadPswd : PAnsiChar;    (* ������ ������� �� ������ *)
      fpWritePswd: PAnsiChar;    (* ������ ������� �� ������ *)
      bAnsi      : Boolean   (* �������� ANSI-�������    *)
  ):SmallInt;stdcall;

(* �������� ������ ������ ������� � ������ ������� *)
(* �������� ������� ����� ���� �������, *)
(* �������-�������� - ������ ���� ������� *)
  Function htOutTo(
      fpSrcTabName:  PAnsiChar; (* ��� ������� ��������� ����� *)
      fpReadPswd:    PAnsiChar; (* ������ ������ *)
      nOpenMode:     SmallInt;(* ����� �������� �������� ������� *)
      fpDstTabName:  PAnsiChar; (* ��� �������, ���������� ��� ������ *)
      fpDstReadPswd: PAnsiChar; (* ������ ������� �� ������ *)
      fpDstWritePswd:PAnsiChar; (* ������ ������� �� ������ *)
      fpFmt:         PhtFormat;(* ��������� �������� *)
      bLogFile:      Boolean; (* TRUE - ����� ������ ������ *)
      bCorrect:      Boolean  (* TRUE - ��������� ������������ � ����-������ *)
  ):LongInt;stdcall;

(*------------- ��������� �������������� ������ ------------*)

(* ������� ������ � ������� ��������� *)
  Procedure htLogClose(
      Var sLog:LOGON          (* ��������� ������� � ������� *)
  );stdcall;

(* ������� ������ � ������� ��������� *)
  Function htLogOpen(
      fpTableName: PAnsiChar;      (* ��� ������� (����� ��� ����������)*)
      fpReadPswd : PAnsiChar;      (* ������ ������� �� ������          *)
      fpWritePswd: PAnsiChar;      (* ������ ������� �� ������          *)
      fpElemNo:    PSmallInt;  (* ������ �������� ��������� ������  *)
             (* ���� Nil - �������� ��� �������� ������ *)
      nElemCnt:    SmallInt;   (* ����� �������� ��������� *)
      Var sLog:    LOGON       (* ��������� ������� � ������� *)
  ):SmallInt;stdcall;

(* ������� ����� ������� (��� �� �����) �� ������� ��������� *)
(* �������� �������� ������� ��������� �������, ������� � ���������.   *)
(* ������ ������� ������������ ������ � ��������� �������� (LOG_???).  *)
(* ��� ��������� ���������� ��� ������ � ������� ��� �� ��������� ����.*)
  Function htLogRead(
      Var sLog: LOGON;  (* ��������� ������� � ������� *)
      gStart:   LongInt;  (* ����� ������� ��������� �������� ������� (�� 0) *)
      fpBuf:    Pointer;      (* ����� ��� ������ ������� *)
      wBufLen:  Cardinal      (* ����� ������ *)
  ):Word;stdcall;

(*------------ ��������� �����������/�������������� ������� -----------*)

(* ������� ��������� ����� ������� �� ��������� ������. *)
(* ����� ������������ ����� ����������������� ���������� �����. *)
  Function htBackupTable(
	cpPhoto: LPSAB;       (* ������ ������� *)
	hTable: THANDLE;      (* ������� *)
	cpNewName: PAnsiChar      (* ��� ��������� ����� *)
  ):SmallInt;stdcall;

(* ������� ��������� ����� ������� �� ��������� ������. *)
(* ����� ������������ ����� ����������������� ���������� �����. *)
  Function htBackupTableGroup(
	ppNames: PPChar;      (* ����� ������ ������ *)
	ppRd: PPChar;         (* ������ ������ ��� ������ ������ *)
	ppWr: PPChar;         (* ������ ������ ��� ������ ������ *)
	ppNewNames: PPChar;   (* ����� ��������� ����� ������ ������ *)
	nNameCnt: Integer     (* ����� ������ *)
  ):SmallInt;stdcall;

(* ������������ ������� � ��������� ����� (�������� � �����������). *)
(* ��������� ���������� ������� � ����� � ������������ �������.     *)
(* ����������: ����� ����������� ��� �������������� ������� ��� ��� ������. *)
  Function htRestoreTable(
	pBackName :  PAnsiChar;  (* ��� ��������� ����� *)
	pReadPswd :  PAnsiChar;  (* ������ ������� �� ������ � ��������� ����� *)
	pWritePswd : PAnsiChar;  (* ������ ������� �� ������ � �������� ������� *)
	pTabName :   PAnsiChar   (* ��� ����������������� ������� *)
  ):LongInt;stdcall;

(*------------------------ ������ � ���������� ----------------------*)

(* ������� ������ � ��������� ��������� ������� *)
  Procedure htTableHeadClose( Var Head: THEAD ); stdcall;

(* ������� ������ � ��������� ������� *)
  Function htTableHeadOpen(
	pTabName: PAnsiChar;        (* ��� ������� *)
	pCryptoKey: PAnsiChar;      (* ������-���� �������� ������ *)
	pReadPswd: PAnsiChar;       (* ������ �� ������ *)
	pWritePswd: PAnsiChar;      (* ������ �� ������ *)
	nMode: SmallInt;        (* ����� �������� (HTHO_????) *)
	Var Head: THEAD         (* ��������� ��������� ������� *)
  ) : SmallInt; stdcall;

(* ���������� ������� ������� � ������� *)
  Function htTableHeadPswd(
        pTabName: PAnsiChar;        (* ��� ������� *)
	Var Mode: Integer       (* ��� ������ ������ ������� *)
  ) : SmallInt; stdcall;

(* ������� ����� ���������� ��������� ������� *)
  Function htTableHeadRead(
	Var HEad: THEAD; 	(* ��������� ��������� ������� *)
	pElem: LPELEMENT; 	(* ����� ��� ������ ���������� ��������� *)
	nElemCnt: SmallInt      (* ����� ���������� ��� ������ *)
  ) : SmallInt; stdcall;

(* �������� ����� ���������� ������� *)
  Function htTableHeadWrite(
	Var Head: THEAD;        (* ��������� ��������� ������� *)
	pElem: LPELEMENT;       (* ��������� ��������� ��� ������ *)
	nElemCnt: SmallInt;     (* ����� ���������� ��� ������ *)
	nMode: SmallInt;        (* ����� ������ (��.HTRW_????) *)
	ppError: LPELEMENT      (* ����� "�������" ��������� �������� *)
  ) : SmallInt; stdcall;

(*------------------------ ������ --------------------------*)

(* �������� ���������� ������� �������� HyTech         *)
(* �� ������ ���������� ��������� � ������ ����������. *)
(* ����� ��������, ��������, �� ����������� Ctrl-Break *)
  Procedure htBreak;stdcall;

(* ���������� �������� ������ ���� *)
  Procedure htSetPollDelay( wMSec: Word );stdcall;

(* �������� "������" ������� ��� ���������� ������ *)
  Function htMakePhoto(
      Var fpPhoto : SAB;  (* ��� ��� "������" *)
      hTable : THANDLE  (* ���������� ��� ������� *)
  ):LPSAB;stdcall;

(* �������� "������" ���������� ������ ������������ *)
  Function htMakeGroupPhoto(
      fpPhotos :  LPSAB;  (* ���'� ��� "�������" *)
      fphTables : LPTHANDLE;  (* ����������� ������ *)
      nTabCnt:    SmallInt  (* ����� ������ � ������ *)
  ):SmallInt;stdcall;

(* �������� ��������� ������ �� ���� ���������� ������� *)
(* ���������� ��������� ���� '��� ������ ��� ������'.   *)
  Function htErrorMessage(
      nCode: SmallInt;    (* ��� ���������� *)
      lpszBuff80: PAnsiChar  (* ����� ��� ������ ������ ��������� *)
  ):PAnsiChar;stdcall;

(* �������� �������������� ���������� � ��������� ������ HyTech *)
(* ���������� ��� �����, ��� ������ � ������� ��������� ������, *)
(* � ����� ��� ������ ��� � ��� ��������, ��������� � ������.   *)
(* ����������� ������ ������������ ������ � ����������.         *)
  Function htExtError(
      Var nDosError : SmallInt; (* ���� ������� ���, ������������ ���            *)
      Var nOperation: SmallInt; (* ���� ������� ��� ��������, ��������� /� ������ *)
      lpszBuff140: PAnsiChar       (* ����� ��� ������ ����� ����� *)
  ):PAnsiChar;stdcall;

(* �������� �������������� ���������� � ��������� ������ HyTech *)
(* ���������� ��������� ������, ���������� �������� ��������, *)
(* ��� ����� � ��������� ������� ������. *)
(* ����������� ������ ������������ ������ � ����������.         *)
  Function htIOMessage(
      lpszBuff220: PAnsiChar   (* ����� ��� ������ ������ ��������� *)
  ):PAnsiChar;stdcall;

(* ������� ���������� ��������� �� ������ ���������� ��������� *)
(* � ����������� �� ���� ������ (�/� ��� ������), ��������:    *)
(*  "��� ������ ��� ������" ���                                *)
(*  "������ �������� d:\xxxx ���� �� ������".                  *)
  Function  htMessage(
      nRetCode:  SmallInt; (* ��� ��������� *)
      lpszBuff220: PAnsiChar   (* ����� ��� ������ ������ ��������� *)
  ):PAnsiChar;stdcall;

(* �������� ���������� � ���������� ������ ���� *)
  Procedure htPurgeError;stdcall;

(* ���������� ������� ������� ������              *)
(* ��� �������� ����� ���������� '\'              *)
  Procedure htNetPath( Var stBuf: PathStr );stdcall;

(* ���������� ������� ��������� ������            *)
(* ��� �������� ����� ���������� '\'              *)
  Procedure htTmpPath( Var stBuf: PathStr );stdcall;

(* ���� � ����� ������������� HyTech *)
(* ������ ���� � ������� ��� ������� � ��� ��� ������ *)
(* ������� ����� �������� - �����, ������� - ����     *)
  Function htStartTimeDate: LongInt;stdcall;

(* �������� ��������� ���� � "������" �������� *)
  Function htIsFieldNull(
      nType  :SmallInt;         (* ��� ���� *)
      wLen   :Cardinal;         (* ����� ���� *)
      pField :Pointer   (* ���� ����������� ���� *)
  ):SmallInt;stdcall;

(* ��������� ���� � "������" �������� *)
  Function htNullField(
      nType   :SmallInt;        (* ��� ���� *)
      nKeyType:SmallInt;  (* ��� ����� *)
      wLen    :Cardinal;  (* ����� ���� *)
      fpField :Pointer    (* ���� ����� *)
  ):SmallInt;stdcall;

(* ��������� ������ � "������" �������� *)
  Function htNullRecord(
      hTable:THANDLE;   (* ���������� ������� *)
      fpRec :Pointer    (* ����� ���� ������ *)
  ):SmallInt;stdcall;

(* �������������� ������ � ������ ������ *)
(* �������� ������ � ������ � ��������� ��������� #0 *)
  Procedure htStringToArray(
      fpArray : Pointer;    (* ����� �������-��������� *)
      fpString: PAnsiChar;      (* ����� �������� ������ *)
      wDimens : Cardinal    (* ����� ������� *)
  );stdcall;

(* �������������� ������ � ������ �������� *)
(* �������� ������ � ������ � ��������� ��������� *)
  Procedure htStringToChars(
      fpChars : Pointer;    (* ����� ������� �������� *)
      fpString: PAnsiChar;      (* ����� �������� ������ *)
      wDimens : Cardinal    (* ����� ������� *)
  );stdcall;

(* �������� ������ �������� � �������� *)
(* =0 - �����, <>0 - �� ����� *)
  Function htWildCmp(
      fpArray : PAnsiChar;      (* ����� ������������ ������� *)
      wDimens : Word;       (* ����� ������� *)
      fpWild  : PAnsiChar;      (* ����� ������� (ASCIIZ-������) *)
      nCaseMode: CASE_MODE  (* ����� ������������� �������� *)
  ):SmallInt;stdcall;

(* �������������� ���� �� ���������� ������ (����� ��� �����) *)
(* ������� �������� ���� ���� �� ������ 0.                    *)
  Function htDateToWord( sDate: DATE ):Word;stdcall;

(* �������������� ���� �� ����������� ������� � ��������� *)
  Procedure htWordToDate( wWord: Word; Var sDate: DATE);stdcall;

(* �������� ��������� ������� (������) ��� ��� *)
  Function htTableSABStat(
      Var pSAB: SAB;          (* ��������� ������ *)
      Var pStat: STATT  (* ��������� ������� *)
  ):SmallInt;stdcall;

(* ���������� ����� ���.����� ��� ��� �� ������ ������ *)
  Function htGetDiffLength(Var fpSAB:SAB; Var aDiffLength:Int64):SmallInt; stdcall;

(* ������� ����� ���������� ��������� ��� � �������� ������� ������� *)
  Function htReadSABChanges(
      Var fpSAB:SAB;
      fpBuf:LPCHANGER;
      nCnt:SmallInt;
      Var gPos:LongInt
  ):SmallInt;stdcall;

(* ������� ����� ���������� ��������� � �������� ������� ������� *)
  Function htReadTableChanges(
      hTable:THANDLE;
      gStart:LongInt;
      fpBuf:LPCHANGER;
      nCnt:SmallInt;
      Var gPos:LongInt
  ):SmallInt;stdcall;

(* ���������� ���������� ������ *)
  Function htWhoLockRecord(
      fpTabName:PAnsiChar;
      gRecNo:LongInt;
      Var sOwner:OWNER
  ):SmallInt;stdcall;

(* ���������� ���������� ��������� ������� *)
  Function htWhoLockSet(Var sSAB:SAB;Var sOwner:OWNER):SmallInt;stdcall;

(* ���������� ���������� ������� *)
  Function htWhoLockTable(fpTabName: PAnsiChar; var sOwner: OWNER):SmallInt;stdcall;

(* ���������� ������ ������� ����������� CtrlBreak (����� SetConsoleCtrlHandler) *)
(* ���������� ������ ��������� ����� � ����������� ����� *)
(* ��������� ���� ��������� ������� ����������� � �������� HyTech *)
  Function htCtrlCtrl(NewState: Integer):Integer;stdcall;

(* ��������� ������ � �������� ���� �������� *)
(* hTask - ���������� � ������� ������� GetCurrentThreadID *)
(* bGlobal - 0 ��� 1 ��� ����... *)
  Function htMemoAvailByTask(hTask : LongWord;bGlobal : ShortInt) : LongInt;stdcall;

(* ������ �������� ���� �������� *)
(* ������ ���� � ���� HtHeap.dmp � ������� �������� *)
  Procedure htPrintHytechHeap(hTask : LongWord;bGlobal : ShortInt);stdcall;

{$IFDEF HT_NEWDLL}
//* �������� �������� � ���������� �������� ���� ���� */
//HTRET HTAPI htSetParam( const char* cpName, const char* cpValue );
 function htSetParam(aParamName: PAnsiChar; aParamValue: PAnsiChar): SmallInt; stdcall;
{$ENDIF HT_NEWDLL}

 // ��������� ��� ����������� ������
 const
  HT_34 = 1;
  HT_38 = 2;
  HT_48 = 3;

(* ����������� ������ � HT_MODE64 *)
  function htConvertTable(pSrcName, pDestName, pReadPswd, pWritePswd: PAnsiChar; cCnvType: SmallInt): SmallInt; stdcall;

(* ���������� ����� ������ ������� *)
 // �� �����������
//function htTableRecordLen(aTable : THANDLE; var aRecLen : Cardinal): SmallInt;

Implementation
 {$I htProcName.inc}

  Function  htAddRecords;                external HTDLL name sHTADDRECORDS;
  Function  htAndResults;                external HTDLL name sHTANDRESULTS;
  Function  htAverageOfKeyValues;        external HTDLL name sHTAVERAGEOFKEYVALUES;
  Function  htBuildIndexes;              external HTDLL name sHTBUILDINDEXES;
  Function  htBackupTable;               external HTDLL name sHTBACKUPTABLE;
  Function  htBackupTableGroup;          external HTDLL name sHTBACKUPTABLEGROUP;
  Function  htChangeCryptoKey;           external HTDLL name sHTCHANGECRYPTOKEY;
  Function  htChangeKeyType;             external HTDLL name sHTCHANGEKEYTYPE;
  Function  htChangeReadPassword;        external HTDLL name sHTCHANGEREADPASSWORD;
  Function  htChangeWritePassword;       external HTDLL name sHTCHANGEWRITEPASSWORD;
  Procedure htCloseResults;              external HTDLL name sHTCLOSERESULTS;
  Function  htClusterItemToLink;         external HTDLL name sHTCLUSTERITEMTOLINK;
  Function  htClusterRecsToLink;         external HTDLL name sHTCLUSTERRECSTOLINK;
  Function  htCodedResultsToTable;       external HTDLL name sHTCODEDRESULTSTOTABLE;
  Function  htCoderInfo;                 external HTDLL name sHTCODERINFO;
  Function  htCommitTransaction;         external HTDLL name sHTCOMMITTRANSACTION;
  Function  htCompareTabHandles;         external HTDLL name sHTCOMPARETABHANDLES;
  Function  htCopyResults;               external HTDLL name sHTCOPYRESULTS;
  Function  htCreateClusterTable;        external HTDLL name sHTCREATECLUSTERTABLE;
  Function  htCreateEmptySAB;            external HTDLL name sHTCREATEEMPTYSAB;
  Function  htCreateEmptyJoin;           external HTDLL name sHTCREATEEMPTYJOIN;
  Function  htDateToWord;                external HTDLL name sHTDATETOWORD;
  Function  htDeleteRecords;             external HTDLL name sHTDELETERECORDS;
  Function  htDistinctResults;           external HTDLL name sHTDISTINCTRESULTS;
  Function  htDistinctResultsByCount;    external HTDLL name sHTDISTINCTRESULTSBYCOUNT;
  Function  htDivision;                  external HTDLL name sHTDIVISION;
  Function  htDropIndexes;               external HTDLL name sHTDROPINDEXES;
  Function  htDropTable;                 external HTDLL name sHTDROPTABLE;
  Function  htDropTableChanges;          external HTDLL name sHTDROPTABLECHANGES;
  Function  htDropTableData;             external HTDLL name sHTDROPTABLEDATA;
  Function  htDupTableHandle;            external HTDLL name sHTDUPTABLEHANDLE;
  Function  htErrorMessage;              external HTDLL name sHTERRORMESSAGE;
  Function  htExcludeResultsItem;        external HTDLL name sHTEXCLUDERESULTSITEM;
  Function  htExport;                    external HTDLL name sHTEXPORT;
  Function  htExtError;                  external HTDLL name sHTEXTERROR;
  Function  htFilterRecords;             external HTDLL name sHTFILTERRECORDS;
  Function  htFilterTables;              external HTDLL name sHTFILTERTABLES;
  Function  htFindCoderKey;              external HTDLL name sHTFINDCODERKEY;
  Function  htFindCoderValue;            external HTDLL name sHTFINDCODERVALUE;
  Function  htFlushTable;                external HTDLL name sHTFLUSHTABLE;
  Function  htGetDiffLength;             external HTDLL name sHTGETDIFFLENGTH;
  Function  htGetResultsItem;            external HTDLL name sHTGETRESULTSITEM;
  Function  htGlobalInit;                external HTDLL name sHTGLOBALINIT;
  Procedure htGlobalShut;                external HTDLL name sHTGLOBALSHUT;
  Function  htGroupByHavingTo;           external HTDLL name sHTGROUPBYHAVINGTO;
  Function  htGroupByUser;               external HTDLL name sHTGROUPBYUSER;
  Function  htHandleAdd;                 external HTDLL name sHTHANDLEADD;
  Function  htHandleFromRecNo;           external HTDLL name sHTHANDLEFROMRECNO;
  Function  htHandleModify;              external HTDLL name sHTHANDLEMODIFY;
  Function  htHistogramByCount;          external HTDLL name sHTHISTOGRAMBYCOUNT;
  Function  htHistogramOfKey;            external HTDLL name sHTHISTOGRAMOFKEY;
  Function  htHoldFreeRecords;           external HTDLL name sHTHOLDFREERECORDS;
  Function  htHoldReadRecord;            external HTDLL name sHTHOLDREADRECORD;
  Function  htHoldRecord;                external HTDLL name sHTHOLDRECORD;
  Function  htHoldResults;               external HTDLL name sHTHOLDRESULTS;
  Function  htHoldTable;                 external HTDLL name sHTHOLDTABLE;
  Function  htImport;                    external HTDLL name sHTIMPORT;
  Function  htImportTitle;               external HTDLL name sHTIMPORTTITLE;
  Function  htIncludeResultsBlock;       external HTDLL name sHTINCLUDERESULTSBLOCK;
  Function  htIncludeResultsItem;        external HTDLL name sHTINCLUDERESULTSITEM;
  Function  htInit;                      external HTDLL name sHTINIT;
  Function  htIOMessage;                 external HTDLL name sHTIOMESSAGE;
  Function  htIsNeedToRoll;              external HTDLL name sHTISNEEDTOROLL;
  Function  htIsResultObsolete;          external HTDLL name sHTISRESULTOBSOLETE;
  Function  htIsResultOpen;              external HTDLL name sHTISRESULTOPEN;
  Function  htIsTransactionalTable;      external HTDLL name sHTISTRANSACTIONALTABLE;
  Function  htJoinedRecords;             external HTDLL name sHTJOINEDRECORDS;
  Function  htJoinElement;               external HTDLL name sHTJOINELEMENT;
  Function  htKeyMaximum;                external HTDLL name sHTKEYMAXIMUM;
  Function  htKeyMinimum;                external HTDLL name sHTKEYMINIMUM;
  Function  htLoadCoder;                 external HTDLL name sHTLOADCODER;
  Function  htLoadRecords;               external HTDLL name sHTLOADRECORDS;
  Procedure htLogClose;                  external HTDLL name sHTLOGCLOSE;
  Function  htLogOpen;                   external HTDLL name sHTLOGOPEN;
  Function  htLogRead;                   external HTDLL name sHTLOGREAD;
  Function  htMakeGroupPhoto;            external HTDLL name sHTMAKEGROUPPHOTO;
  Function  htMakePhoto;                 external HTDLL name sHTMAKEPHOTO;
  Function  htMarkJoinedRecord;          external HTDLL name sHTMARKJOINEDRECORD;
  Function  htMarkJoinedRecordEx;        external HTDLL name sHTMARKJOINEDRECORDEX;
  Function  htMarkRecord;                external HTDLL name sHTMARKRECORD;
  Function  htMemoAvailByTask;           external HTDLL name sHTMEMOAVAILBYTASK;
  Function  htMessage;                   external HTDLL name sHTMESSAGE;
  Function  htModifyRecords;             external HTDLL name sHTMODIFYRECORDS;
  Function  htNotResults;                external HTDLL name sHTNOTRESULTS;
  Function  htNullField;                 external HTDLL name sHTNULLFIELD;
  Function  htNullRecord;                external HTDLL name sHTNULLRECORD;
  Function  htOpenCodedResults;          external HTDLL name sHTOPENCODEDRESULTS;
  Function  htOpenResults;               external HTDLL name sHTOPENRESULTS;
  Function  htOrResults;                 external HTDLL name sHTORRESULTS;
  Function  htOutTo;                     external HTDLL name sHTOUTTO;
  Procedure htPrintHytechHeap;           external HTDLL name sHTPRINTHYTECHHEAP;
  Function  htPureAddRecords;            external HTDLL name sHTPUREADDRECORDS;
  Function  htPureModifyRecords;         external HTDLL name sHTPUREMODIFYRECORDS;
  Function  htReadCoder;                 external HTDLL name sHTREADCODER;
  Function  htReadRecord;                external HTDLL name sHTREADRECORD;
  Function  htReadRecordByHandle;        external HTDLL name sHTREADRECORDBYHANDLE;
  Function  htReadResults;               external HTDLL name sHTREADRESULTS;
  Function  htReadSABChanges;            external HTDLL name sHTREADSABCHANGES;
  Function  htReadTableChanges;          external HTDLL name sHTREADTABLECHANGES;
  Function  htRecNoFromHandle;           external HTDLL name sHTRECNOFROMHANDLE;
  Function  htRecordAdd;                 external HTDLL name sHTRECORDADD;
  Function  htRecordByUniq;              external HTDLL name sHTRECORDBYUNIQ;
  Function  htRecordDelete;              external HTDLL name sHTRECORDDELETE;
  Function  htRecordModify;              external HTDLL name sHTRECORDMODIFY;
  Function  htRecordOrdinalNumber;       external HTDLL name sHTRECORDORDINALNUMBER;
  Function  htRecordsByKey;              external HTDLL name sHTRECORDSBYKEY;
  Function  htRecordsForTwoKeys;         external HTDLL name sHTRECORDSFORTWOKEYS;
  Function  htReleaseRecord;             external HTDLL name sHTRELEASERECORD;
  Function  htReleaseResults;            external HTDLL name sHTRELEASERESULTS;
  Function  htReleaseTable;              external HTDLL name sHTRELEASETABLE;
  Function  htRepairTable;               external HTDLL name sHTREPAIRTABLE;
  Function  htRepairTableLog;            external HTDLL name sHTREPAIRTABLELOG;
  Function  htReplaceResultsItem;        external HTDLL name sHTREPLACERESULTSITEM;
  Function  htReplaceResultsTable;       external HTDLL name sHTREPLACERESULTSTABLE;
  Function  htRestoreTable;              external HTDLL name sHTRESTORETABLE;
  Function  htResultsElement;            external HTDLL name sHTRESULTSELEMENT;
  Function  htResultsItemCnt;            external HTDLL name sHTRESULTSITEMCNT;
  Function  htResultsItemLen;            external HTDLL name sHTRESULTSITEMLEN;
  Function  htResultsItemParm;           external HTDLL name sHTRESULTSITEMPARM;
  Function  htResultsTable;              external HTDLL name sHTRESULTSTABLE;
  Function  htResultsToHard;             external HTDLL name sHTRESULTSTOHARD;
  Function  htResultsToTable;            external HTDLL name sHTRESULTSTOTABLE;
  Function  htResultsType;               external HTDLL name sHTRESULTSTYPE;
  Function  htRollBackTransaction;       external HTDLL name sHTROLLBACKTRANSACTION;
  Function  htSearch;                    external HTDLL name sHTSEARCH;
  Function  htSeekMarkedJoin;            external HTDLL name sHTSEEKMARKEDJOIN;
  Function  htSeekMarkedJoinEx;          external HTDLL name sHTSEEKMARKEDJOINEX;
  Function  htSeekMarkedRecord;          external HTDLL name sHTSEEKMARKEDRECORD;
  Function  htSeekResults;               external HTDLL name sHTSEEKRESULTS;
  Function  htSortedRecords;             external HTDLL name sHTSORTEDRECORDS;
  Function  htSortedRecordsEx;           external HTDLL name sHTSORTEDRECORDSEX;
  Function  htSortResults;               external HTDLL name sHTSORTRESULTS;
  Function  htSortResultsByUser;         external HTDLL name sHTSORTRESULTSBYUSER;
  Function  htStartTimeDate;             external HTDLL name sHTSTARTTIMEDATE;
  Function  htStartTransaction;          external HTDLL name sHTSTARTTRANSACTION;
  Function  htSubSearch;                 external HTDLL name sHTSUBSEARCH;
  Function  htSumOfKeyValues;            external HTDLL name sHTSUMOFKEYVALUES;
  Function  htSyncResults;               external HTDLL name sHTSYNCRESULTS;
  Function  htTableClose;                external HTDLL name sHTTABLECLOSE;
  Function  htTableCopy;                 external HTDLL name sHTTABLECOPY;
  Function  htTableCreate;               external HTDLL name sHTTABLECREATE;
  Function  htTableElement;              external HTDLL name sHTTABLEELEMENT;
  Function  htTableElementList;          external HTDLL name sHTTABLEELEMENTLIST;
  Function  htTableHandleByName;         external HTDLL name sHTTABLEHANDLEBYNAME;
  Function  htTableInfo;                 external HTDLL name sHTTABLEINFO;
  Function  htTableOpen;                 external HTDLL name sHTTABLEOPEN;
  Function  htTableRename;               external HTDLL name sHTTABLERENAME;
  Function  htTableVerify;               external HTDLL name sHTTABLEVERIFY;
  Function  htTellJoinOrder;             external HTDLL name sHTTELLJOINORDER;
  Function  htTouchResults;              external HTDLL name sHTTOUCHRESULTS;
  Function  htTransferToPhoto;           external HTDLL name sHTTRANSFERTOPHOTO;
  Function  htTransferToTable;           external HTDLL name sHTTRANSFERTOTABLE;
  Function  htUpdateTable;               external HTDLL name sHTUPDATETABLE;
  Function  htValuesByCount;             external HTDLL name sHTVALUESBYCOUNT;
  Function  htValuesFromGroup;           external HTDLL name sHTVALUESFROMGROUP;
  Function  htValuesOfKey;               external HTDLL name sHTVALUESOFKEY;
  Function  htXorResults;                external HTDLL name sHTXORRESULTS;
  Procedure htBreak;                     external HTDLL name sHTBREAK;
  Procedure htClearResults;              external HTDLL name sHTCLEARRESULTS;
  Procedure htCloseAllTables;            external HTDLL name sHTCLOSEALLTABLES;
  Procedure htNetPath;                   external HTDLL name sHTNETPATH;
  Procedure htPurgeCoder;                external HTDLL name sHTPURGECODER;
  Procedure htPurgeError;                external HTDLL name sHTPURGEERROR;
  Procedure htSetLockTimeOut;            external HTDLL name sHTSETLOCKTIMEOUT;
  Procedure htSetPollDelay;              external HTDLL name sHTSETPOLLDELAY;
  Procedure htSetTransTimeOut;           external HTDLL name sHTSETTRANSTIMEOUT;
  Procedure htShut;                      external HTDLL name sHTSHUT;
  Procedure htStringToArray;             external HTDLL name sHTSTRINGTOARRAY;
  Procedure htStringToChars;             external HTDLL name sHTSTRINGTOCHARS;
  Function  htTableSABStat;              external HTDLL name sHTTABLESABSTAT;
  Procedure htTableHeadClose;		 external HTDLL name sHTTABLEHEADCLOSE;
  Function  htTableHeadOpen;		 external HTDLL name sHTTABLEHEADOPEN;
  Function  htTableHeadPswd;		 external HTDLL name sHTTABLEHEADPSWD;
  Function  htTableHeadRead;		 external HTDLL name sHTTABLEHEADREAD;
  Function  htTableHeadWrite;		 external HTDLL name sHTTABLEHEADWRITE;
  Function  htTablesJoin;                external HTDLL name sHTTABLESJOIN;
  Function  htTablesLink;                external HTDLL name sHTTABLESLINK;
  Procedure htTmpPath;                   external HTDLL name sHTTMPPATH;
  Function  htWhoLockRecord;             external HTDLL name sHTWHOLOCKRECORD;
  Function  htWhoLockSet;                external HTDLL name sHTWHOLOCKSET;
  Function  htWhoLockTable;              external HTDLL name sHTWHOLOCKTABLE;
  Function  htWildCmp;                   external HTDLL name sHTWILDCMP;
  Procedure htWordToDate;                external HTDLL name sHTWORDTODATE;
  Function  htTableState;                external HTDLL name sHTTABLESTATE;
  Function  htTableAgregateModify;       external HTDLL name sHTTABLEAGREGATEMODIFY;
  Function  htTableAgregateDelete;       external HTDLL name sHTTABLEAGREGATEDELETE;
  Function  htTableAgregateAppend;       external HTDLL name sHTTABLEAGREGATEAPPEND;
  Function  htIsFieldNull;               external HTDLL name sHTISFIELDNULL;
  Function  htCtrlCtrl;			 external HTDLL name sHTCTRLCTRL;
  function  htConvertTable;              external HTDLL name sHTCONVERTTABLE;
  //function  htTableRecordLen;            external HTDLL name shtTableRecordLen;
  {$IFDEF HT_NEWDLL}
  Function  htExcludeResults;            external HTDLL name sHTEXCLUDERESULTS;
  Function  htRecordsByValues;           external HTDLL name sHTRECORDSBYVALUES;
  Function  htLastErrorText;             external HTDLL name sHTLASTERRORTEXT;
  Function  htSetParam;                  external HTDLL name sHTSETPARAM;

  {$endif}

end.
