Unit Dt_Fam;

{ $Id: dt_fam.pas,v 1.45 2015/11/25 14:01:48 lukyanets Exp $ }

// $Log: dt_fam.pas,v $
// Revision 1.45  2015/11/25 14:01:48  lukyanets
// «аготовки дл€ выдачи номеров+переезд констант
//
// Revision 1.44  2015/04/07 12:02:52  lukyanets
// »золируем пути
//
// Revision 1.43  2015/03/04 08:46:58  voba
// - «амена htReadRecord на htReadRecordByHandle bugfix
//
// Revision 1.42  2015/03/02 18:34:37  voba
// - «амена htReadRecord на htReadRecordByHandle bugfix
//
// Revision 1.41  2015/03/02 16:31:17  voba
// - «амена htReadRecord на htReadRecordByHandle
//
// Revision 1.40  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.39  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.38  2013/04/09 11:08:07  lulin
// - пытаемс€ отладитьс€ под XE.
//
// Revision 1.37  2011/05/18 12:08:41  lulin
// {RequestLink:266409354}.
//
// Revision 1.36  2009/12/18 08:58:01  voba
// - add comment
//
// Revision 1.34  2009/09/11 08:40:10  voba
// - помен€л невзрачное название типа ELEMENT на клевое ThtElementInfo
//
// Revision 1.33  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.32  2009/03/02 08:11:42  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.31  2007/12/19 12:59:32  fireton
// - Ok теперь локальна€ переменна€ (l_Ok)
//
// Revision 1.30  2007/12/06 11:41:00  lulin
// - cleanup.
//
// Revision 1.29  2007/08/14 20:25:15  lulin
// - bug fix: не собиралас€ јрхивариус.
//
// Revision 1.28  2007/08/14 19:31:56  lulin
// - оптимизируем очистку пам€ти.
//
// Revision 1.27  2007/08/14 08:30:23  narry
// - добавление финального разделител€ в путь к семейству
//
// Revision 1.26  2007/07/04 09:10:07  narry
// - рефакторинг процедуры инициализации HyTech
//
// Revision 1.25  2007/04/25 07:52:38  fireton
// - –ефакторинг. ”ходим от пр€мых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.24  2007/03/26 09:34:03  fireton
// - изменилс€ формат l3System.FreeLocalMem
//
// Revision 1.23  2007/03/26 08:21:40  narry
// - вместо пути к семейству возвращалс€ мусор
//
// Revision 1.22  2004/12/23 11:42:13  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.21  2004/09/21 12:04:21  lulin
// - Release заменил на Cleanup.
//
// Revision 1.20  2004/09/14 15:58:15  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.19  2004/08/03 08:52:50  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.18  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.17.2.1  2004/06/17 18:03:48  step
// ¬ методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.17  2004/05/18 12:01:09  step
// bug fix
//
// Revision 1.16  2004/05/18 09:49:28  step
// перенос MaxFamilyID из THtServer в TFamilyTbl;
// change: GlobalHTServer.MaxFamilyID --> GlobalHTServer.FamilyTbl.MaxFamilyID;
//
// Revision 1.15  2004/05/18 09:20:24  step
// change: GlobalFamPaths, GlobalFamAttrib перенесены в TFamilyTbl;
// new: TFamilyTbl.FamilyPath
//
// Revision 1.14  2004/05/13 16:32:18  step
// замена: "TFreeTbl.Create ..." --> "GlobalHtServer.FreeTbl[...]"
//
// Revision 1.13  2004/05/06 09:16:07  voba
// merge with adding_diapasons_table_free2
//
// Revision 1.12.10.1  2004/04/09 16:57:55  step
// ѕеределан класс TFreeTbl (теперь работает с диапазонами)
//
// Revision 1.12  2004/03/05 16:52:23  step
// чистка кода
//
// Revision 1.11  2003/06/03 15:26:26  voba
// - rename Tl3StringDataList AddData to Add
//
// Revision 1.10  2001/09/04 13:59:10  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.9  2000/12/15 15:36:18  law
// - вставлены директивы Log.
//

{$Include DtDefine.inc}

Interface
Uses
 Classes,
 l3ProtoObject,
 l3DatLst,

 HT_Const,
 Dt_Types,
 Dt_ATbl;

Const
 fmId_Key    = 1;
 fmGr_DocFld = 3;
Type
  TFamNameStr = TChArr50;
  TFamilyRec = Record
                ID     : TFamilyID;
                Name   : TFamNameStr;
                DocGr  : TUserGrID;
                Path   : TPathArr;
                Attrib : LongInt;
               end;
 TFamilyShortRec = Record
                    ID     : TFamilyID;
                    Name   : TFamNameStr;
                   end;

 TFamilyPathRec = Record
                   ID     : TFamilyID;
                   Path   : TPathArr;
                   Attrib : LongInt;
                  end;

 TFamilyTbl = Class(TPrometTbl)
  private
   // ”казатель на массив путей к семействам таблиц
   f_GlobalFamPaths    : PFamilyPaths;
   // ”казатель на массив атрибутов семейств таблиц
   f_GlobalFamAttrib   : PFamilyAttrib;

   f_MaxFamilyID       : TFamilyID;

   Procedure   CreateEmptyFamily(aPath : TPathStr;
                                 aID   : TFamilyID;
                                 aType : LongInt);
   Function    GetMaxFamilyID : TFamilyID;
  public
   Constructor Create(aSharing : Boolean); Reintroduce;
   procedure   Cleanup; override;
   Procedure   GetAllPathsAndAttrib(PathArr   : PFamilyPaths;
                                    AttribArr : PFamilyAttrib);
   Procedure   GetPathAndAttrib(aFamilyID : TFamilyID;Var CurPath : PAnsiString;
                                Var CurAttrib : LongInt);

   Procedure   GetFamilysList(aList : TPersistent);
   Function    GetFamilyName(aID : TFamilyID) : ShortString;
   Procedure   GetFamilyInfo(aID : TFamilyID;Var aDataRec : TFamilyRec);
   Procedure   AddFamily(aName : ShortString;aPath : TPathStr;aType : LongInt;
                         aDocGroup : TDictID;WithCreate : Boolean;
                         Var FamID : TFamilyID);
   Procedure   UpdFamily(aID : TFamilyID;
                         aName : ShortString;aPath : TPathStr;
                         aDocGroup : TDictID);
   Procedure   DelFamily(aID : TFamilyID);

   function    FamilyPath(aFamilyId: TFamilyID): TPathStr;
   property    MaxFamilyID: TFamilyID read f_MaxFamilyID;
 end;

 TdtFamily = class(Tl3ProtoObject)
  {* - объект дл€ хранени€/получени€ своств семейства, пока только захват, потом перетащим еще с }
 private
  fFamilyID  : TFamilyID;
  fPath      : TPathStr;
  fLockCount : Integer;
  fCtrlTblH  : ThtTblHandle;

  procedure Cleanup; override;
  procedure CloseCtrl;
 public
  constructor Create(aFamilyID : TFamilyID; aPath : TPathStr);
  procedure Lock(aShareMode : SmallInt);
  procedure Unlock;

  property Path : TPathStr read fPath;
 end;


implementation

uses
  SysUtils,

  daDataProvider,
  daSchemeConsts,

  HT_Dll,

  Dt_Const,
  Dt_Err,

  Dt_Serv,
  Dt_Free,
  Dt_Acces,
  Dt_Lock,

  l3Base,
  l3IniFile,
  l3String,
  l3FileUtils

  ;

{TdtFamily}
constructor TdtFamily.Create(aFamilyID : TFamilyID; aPath : TPathStr);
begin
 Inherited Create;
 fPath := aPath;
 FFamilyID := aFamilyID;
end;

procedure TdtFamily.Cleanup;
begin
 CloseCtrl;
 Inherited;
end;

procedure TdtFamily.Lock(aShareMode : SmallInt);
var
 hTable   : HT_Const.THANDLE;
 lCtrlName : AnsiString;
begin
 if fFamilyID = MainTblsFamily then exit;

 if (fLockCount = 0) then
 begin
  lCtrlName := ConcatDirName(fPath, TableName(FFamilyID, Ord(ftCtrl)));
  Ht(htTableOpen(PAnsiChar(lCtrlName), nil, nil, aShareMode, fCtrlTblH));
 end;

 Inc(fLockCount);
end;

procedure TdtFamily.Unlock;
begin
 if fFamilyID = MainTblsFamily then exit;
 
 Dec(fLockCount);
 if (fLockCount = 0) then
  CloseCtrl;
end;

procedure TdtFamily.CloseCtrl;
begin
 if (fCtrlTblH <> 0) then
 begin
  Ht(htTableClose(fCtrlTblH));
  fCtrlTblH := 0;
 end;
end;

(**************************** TFamilyTbl ***********************************)

Constructor TFamilyTbl.Create(aSharing : Boolean);
begin
  inherited Create(MainTblsFamily, Ord(mtFamily));

  f_MaxFamilyID := GetMaxFamilyID;
  l3System.GetLocalMem(f_GlobalFamPaths,(f_MaxFamilyID+1)*SizeOf(PAnsiString));
  l3System.GetLocalMem(f_GlobalFamAttrib,(f_MaxFamilyID+1)*SizeOf(LongInt));
  l3FillChar(f_GlobalFamPaths^,(f_MaxFamilyID+1)*SizeOf(PAnsiString));
  l3FillChar(f_GlobalFamAttrib^,(f_MaxFamilyID+1)*SizeOf(LongInt));
  GetAllPathsAndAttrib(f_GlobalFamPaths,f_GlobalFamAttrib);
end;

Procedure TFamilyTbl.GetAllPathsAndAttrib(PathArr   : PFamilyPaths;
                                          AttribArr : PFamilyAttrib);
Const
 FldCount = 3;
 FamFldArr : Array[1..FldCount] of SmallInt = (1,4,5);
Var
 FamRec   : TFamilyPathRec;
 TmpStr   : TPathStr;
 lSab     : Sab;
Begin
 lSab := MakeAllRecordsSab;
 try
  PathArr^[0]:=NewStr(GlobalHtServer.CurTblPath);
  If lSab.gFoundCnt=0 then
   exit;
  Ht(htOpenResults(lSab,ROPEN_READ,@FamFldArr,FldCount));
  Try
   While htReadResults(lSab,@FamRec,SizeOf(FamRec))<>0 do
    Begin
     TmpStr:=l3ArrayToString(FamRec.Path,SizeOf(FamRec.Path));
     PathArr^[FamRec.ID]:=NewStr(GlobalDataProvider.ConvertAliasPath(TmpStr));
     AttribArr^[FamRec.ID]:=FamRec.Attrib;
    end;
  finally
   htCloseResults(lSab);
  end;
 finally
  htClearResults(lSab);
 end;
end;

Procedure TFamilyTbl.GetPathAndAttrib(aFamilyID : TFamilyID;Var CurPath : PAnsiString;
                                      Var CurAttrib : LongInt);
Var
 TmpStr   : TPathStr;
 lRecNum  : LongInt;
 FamRec   : TFamilyRec;
 RecH     : RHandle;
Begin
 If aFamilyID = MainTblsFamily then
  Begin
   CurPath:=NewStr(GlobalHtServer.CurTblPath);
   CurAttrib:=0;
  end
 else
  Begin
   l3FillChar(FamRec,SizeOf(TFamilyPathRec));
   lRecNum := Ht(htRecordByUniq(nil,Handle,fmId_Key,@aFamilyID,@RecH));
   If lRecNum = 0 then
    raise EHtErrors.CreateInt(ecNotFound);
   Ht(htReadRecord(nil, Handle, RecH, @FamRec));
  
   TmpStr:=l3ArrayToString(FamRec.Path,SizeOf(FamRec.Path));
   CurPath:=NewStr(GlobalDataProvider.ConvertAliasPath(TmpStr));
   CurAttrib:=FamRec.Attrib;
  end;
end;

Procedure TFamilyTbl.GetFamilysList(aList : TPersistent);
Const
  FldCount = 2;
  FamFldArr : Array[1..FldCount] of SmallInt = (1,2);
Var
  FamRec   : TFamilyShortRec;
  TmpStr   : String[SizeOf(TFamNameStr)];
  TmpSab   : SAB;
  lSab     : Sab;
Begin
 If aList is TStrings then
  TStrings(aList).Clear
 else
  If aList is Tl3StringDataList then
   Begin
    Tl3StringDataList(aList).Clear;
    Tl3StringDataList(aList).DataSize:=SizeOf(TFamilyID);
    Tl3StringDataList(aList).NeedAllocStr:=True;
   end;


 lSab := MakeAllRecordsSab;
 (* возможна фильтраци€ списка ?!?! *)
 Try
  If lSab.gFoundCnt=0 then
   exit;

  Ht(htOpenResults(lSab,ROPEN_READ,@FamFldArr,FldCount));
  Try
   While htReadResults(lSab,@FamRec,SizeOf(FamRec))<>0 do
    Begin
     TmpStr:=l3ArrayToString(FamRec.Name,SizeOf(FamRec.Name))+#0;
     If aList is TStrings
      then
       TStrings(aList).AddObject(TmpStr,TObject(FamRec.ID));
     If aList is Tl3StringDataList
      then
       Begin
        TmpStr:=TmpStr+#0;
        Tl3StringDataList(aList).Add(@TmpStr[1],@FamRec.ID);
       end;
    end;
  finally
   htCloseResults(lSab);
  end;
 finally
  htClearResults(lSab);
 end;
end;

Function TFamilyTbl.GetFamilyName(aID : TFamilyID) : ShortString;
Var
  AbsN   : LongInt;
  FamRec : TFamilyRec;
  RecH   : RHandle;
  l_Ok : Longint;
Begin
  l_Ok:=Ht(htRecordByUniq(Nil,Handle,fmId_Key,@aID,@RecH));
  If l_Ok=0 then raise EHtErrors.CreateInt(ecNotFound);
  AbsN:=l_Ok;
  Ht(htReadRecord(Nil,Handle,AbsN,@FamRec));
  Result:=l3ArrayToString(FamRec.Name,SizeOf(FamRec.Name));
end;

Procedure TFamilyTbl.GetFamilyInfo(aID : TFamilyID;Var aDataRec : TFamilyRec);
var
 RecH   : RHandle;
 l_Ok : Longint;
Begin
  l_Ok:=Ht(htRecordByUniq(Nil,Handle,fmId_Key,@aID,@RecH));
  If l_Ok > 0
    then
      Ht(htReadRecord(Nil,Handle,l_Ok,@aDataRec))
    else
      raise EHtErrors.CreateInt(ecNotFound);
end;

Procedure TFamilyTbl.AddFamily(aName : ShortString;aPath : TPathStr;aType : LongInt;
                               aDocGroup : TDictID;WithCreate : Boolean;
                               Var FamID : TFamilyID);
Var
 FamRec : TFamilyRec;
 TmpStr : ShortString;
Begin
 FamRec.ID := GlobalHtServer.FreeTbl[TblFamily].GetFree(TblName);

 If WithCreate
  then
   CreateEmptyFamily(GlobalDataProvider.ConvertAliasPath(aPath),FamRec.ID,aType);

 With FamRec do
  Begin
   TmpStr:=aName+#0;
   htStringToChars(@Name,@TmpStr[1],SizeOf(TFamNameStr));
   DocGr:=aDocGroup;
   TmpStr:=aPath+#0;
   htStringToChars(@Path,@TmpStr[1],SizeOf(TPathArr));
   Attrib:=aType;
  end;

 AddRec(@FamRec);
 FamID:=FamRec.ID;

 If FamRec.ID > f_MaxFamilyID
  then
   Begin
    f_MaxFamilyID:=GetMaxFamilyID;
    If Assigned(f_GlobalFamPaths)
     then
      l3System.ReAllocLocalMem(f_GlobalFamPaths,
                               (f_MaxFamilyID+1)*SizeOf(PAnsiString));
    If Assigned(f_GlobalFamAttrib)
     then
      l3System.ReAllocLocalMem(f_GlobalFamAttrib,
                               (f_MaxFamilyID+1)*SizeOf(LongInt));
    LockServer.ReAllocLocks(f_MaxFamilyID);
   end
  else
   DisposeStr(f_GlobalFamPaths^[FamRec.ID]);

 f_GlobalFamPaths^[FamRec.ID]:=NewStr(GlobalDataProvider.ConvertAliasPath(aPath));
 f_GlobalFamAttrib^[FamRec.ID]:=FamRec.Attrib;
end;

Procedure TFamilyTbl.UpdFamily(aID : TFamilyID;
                               aName : ShortString;aPath : TPathStr;
                               aDocGroup : TDictID);
Var
  AbsNum  : LongInt;
  TmpRec  : TFamilyRec;
  RecH    : RHANDLE;
  TmpStr  : ShortString;
Begin
  AbsNum:=Ht(htRecordByUniq(Nil,Handle,fmId_Key,@aID,@RecH));
  If AbsNum=0 then raise EHtErrors.CreateInt(ecNotFound);
  Ht(htHoldReadRecord(Handle,AbsNum,@TmpRec));
  Try
    If StartTA then
     Try
      With TmpRec do
       Begin
        TmpStr:=aName+#0;
        htStringToChars(@Name,@TmpStr[1],SizeOf(TFamNameStr));
        DocGr:=aDocGroup;
        TmpStr:=aPath+#0;
        htStringToChars(@Path,@TmpStr[1],SizeOf(TPathArr));
       end;
      UpdRec(AbsNum,@TmpRec);
      SuccessTA;
      DisposeStr(f_GlobalFamPaths^[aID]);
      f_GlobalFamPaths^[aID]:=NewStr(GlobalDataProvider.ConvertAliasPath(aPath));
     except
      RollBackTA;
      raise EHtErrors.CreateInt(ecUnableUpd);
     end;
  finally
    FreeRec(AbsNum);
  end;
end;

Procedure TFamilyTbl.DelFamily(aID : TFamilyID);
Var
  AbsNum : LongInt;
  RecH   : RHandle;
  l_Ok : Longint;
Begin
  AbsNum:=Ht(htRecordByUniq(nil,Handle,fmId_Key,@aID,@RecH));
  If l_Ok<>0
    then
      Begin
        DelRec(AbsNum);
        LockServer.DelFamilyLocks(aID);
        If Assigned(f_GlobalFamPaths)
          then
            Begin
              DisposeStr(f_GlobalFamPaths^[aID]);
              f_GlobalFamPaths^[aID]:=Nil;
            end;

        If aID = f_MaxFamilyID
          then
            Begin
              f_MaxFamilyID:=GetMaxFamilyID;
              If Assigned(f_GlobalFamPaths)
                then
                 l3System.ReAllocLocalMem(f_GlobalFamPaths,
                                          (f_MaxFamilyID+1)*SizeOf(PAnsiString));
              If Assigned(f_GlobalFamAttrib)
                then
                 l3System.ReAllocLocalMem(f_GlobalFamAttrib,
                                          (f_MaxFamilyID+1)*SizeOf(LongInt));
              LockServer.ReAllocLocks(f_MaxFamilyID);
            end;

         GlobalHtServer.FreeTbl[TblFamily].PutFree(TblName, aID);
      end;
end;

Function TFamilyTbl.GetMaxFamilyID : TFamilyID;
Begin
  Result := MaxID;
end;

Procedure TFamilyTbl.CreateEmptyFamily(aPath : TPathStr;
                                       aID   : TFamilyID;
                                       aType : LongInt);
Const
  FileTblName = 'FILE';
  FileFldCnt = 10;
  FileTblStruct : Array [1..FileFldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_UNIQUE; mName:'AbsNum'#0),
     (wLength:70;  wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_NOTKEY or EK_NULL; mName:'ShortName'#0),
     (wLength:600; wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_NOTKEY or EK_NULL; mName:'FullName'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON or EK_NULL; mName:'PriceLevel'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON or EK_NULL; mName:'Active'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON or EK_NULL; mName:'Priority'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON or EK_NULL; mName:'SortDate'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_BYTE; cKey:EK_COMMON or EK_NULL; mName:'Typ'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_BYTE; cKey:EK_COMMON or EK_NULL; mName:'Flag'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_NOTKEY or EK_NULL; mName:'Related'#0));

  DT1TblName = 'DT#1';
  DT1FldCnt = 4;
  DT1TblStruct : Array [1..DT1FldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_UNIQUE; mName:'ID'#0),
     (wLength:200; wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_NOTKEY; mName:'Name'#0),
     (wLength:70;  wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_NOTKEY or EK_NULL; mName:'ShortName'#0),
     (wLength:800; wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_NOTKEY or EK_NULL; mName:'Sinonims'#0));

  DT2TblName : Array [1..4] of String[4] = ('DT#2','DT#4','DT#5','DT#6');
  DT2FldCnt = 2;
  DT2TblStruct : Array [1..DT2FldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_UNIQUE; mName:'ID'#0),
     (wLength:70;  wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_NOTKEY; mName:'Name'#0));

  DT3TblName = 'DT#3';
  DT3FldCnt = 3;
  DT3TblStruct : Array [1..DT3FldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_UNIQUE; mName:'ID'#0),
     (wLength:1000;wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_NOTKEY; mName:'Name'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON; mName:'UpDir'#0));

  DT4TblName = 'DT#7';
  DT4FldCnt = 5;
  DT4TblStruct : Array [1..DT4FldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_UNIQUE; mName:'ID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON or EK_NULL; mName:'Date'#0),
     (wLength:20;  wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_COMMON or EK_NULL; mName:'No'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_BYTE; cKey:EK_COMMON or EK_NULL; mName:'Tip'#0),
     (wLength:70;  wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_NOTKEY or EK_NULL; mName:'Coment'#0));

  SUBTblName = 'SUB';
  SUBFldCnt = 4;
  SUBTblStruct : Array [1..SUBFldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'DocID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'SubID'#0),
     (wLength:130; wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_NOTKEY or EK_NULL; mName:'SubName'#0),
     (wLength:2;   wOffset:1; cClass:EC_GROUP;  cType:ET_CHAR; cKey:EK_UNIQUE; mName:'BothKey'#0));

  LNK1TblName : Array [1..3] of String[5] = ('LNK#1','LNK#2','LNK#6');
  LNK1FldCnt = 3;
  LNK1TblStruct : Array [1..LNK1FldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'Doc_ID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON; mName:'Dict_ID'#0),
     (wLength:2;   wOffset:1; cClass:EC_GROUP;  cType:ET_CHAR; cKey:EK_UNIQUE; mName:'BothKey'#0));

  LNK2TblName : Array [1..2] of String[5] = ('LNK#3','LNK#5');
  LNK2FldCnt = 4;
  LNK2TblStruct : Array [1..LNK2FldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'Doc_ID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON; mName:'Dict_ID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON; mName:'Sub_ID'#0),
     (wLength:3;   wOffset:1; cClass:EC_GROUP;  cType:ET_CHAR; cKey:EK_UNIQUE; mName:'UniKey'#0));

  LNK3TblName = 'LNK#4';
  LNK3FldCnt = 3;
  LNK3TblStruct : Array [1..LNK3FldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON; mName:'Theme_ID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON; mName:'KW_ID'#0),
     (wLength:2;   wOffset:1; cClass:EC_GROUP;  cType:ET_CHAR; cKey:EK_UNIQUE; mName:'BothKey'#0));

  LNK4TblName = 'LNK#7';
  LNK4FldCnt = 3;
  LNK4TblStruct : Array [1..LNK4FldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'Doc_ID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'Dict_ID'#0),
     (wLength:2;   wOffset:1; cClass:EC_GROUP;  cType:ET_CHAR; cKey:EK_UNIQUE; mName:'BothKey'#0));

  HLNKTblName = 'HLINK';
  HLNKFldCnt = 6;
  HLNKTblStruct : Array [1..HLNKFldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'ID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'SourDoc'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'DestDoc'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_NOTKEY; mName:'DestSub'#0),
     (wLength:4;   wOffset:1; cClass:EC_GROUP;  cType:ET_CHAR; cKey:EK_UNIQUE; mName:'UniKey'#0),
     (wLength:2;   wOffset:3; cClass:EC_GROUP;  cType:ET_CHAR; cKey:EK_COMMON; mName:'DestKey'#0));

  PriorTblName = 'PRIOR';
  PriorFldCnt = 4;
  PriorTblStruct : Array [1..PriorFldCnt] of ThtElementInfo  =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON; mName:'Sour_ID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON; mName:'Type_ID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_WORD; cKey:EK_COMMON; mName:'Priority'#0),
     (wLength:2;   wOffset:1; cClass:EC_GROUP;  cType:ET_CHAR; cKey:EK_UNIQUE; mName:'BothKey'#0));

  RENUMTblName = 'RENUM';
  RENUMFldCnt = 2;
  RENUMTblStruct : Array [1..RENUMFldCnt] of ThtElementInfo =
    ((wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'RealID'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_COMMON; mName:'ImportID'#0));

  CtrlTblName = 'CTRL';
  CtrlFldCnt = 1;
  CtrlTblStruct : ThtElementInfo =
    (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_UNIQUE; mName:'Attributes'#0);

  FreeTblName = 'FREE';
  FreeFldCnt = 2;
  FreeTblStruct : Array [1..FreeFldCnt] of ThtElementInfo =
    ((wLength:8;   wOffset:0; cClass:EC_FIELD;  cType:ET_CHAR; cKey:EK_COMMON; mName:'TblName'#0),
     (wLength:0;   wOffset:0; cClass:EC_FIELD;  cType:ET_DWRD; cKey:EK_NOTKEY; mName:'FreeNum'#0));
  FreeRecs : Array [1..10] of TFreeRec = ((TblName : 'FILE    ';  FreeNum : 1;  Limit : NO_LIMIT),
                                          (TblName : 'HLINK   ';  FreeNum : 1;  Limit : NO_LIMIT),
                                          (TblName : 'DT#1    ';  FreeNum : 1;  Limit : NO_LIMIT),
                                          (TblName : 'DT#2    ';  FreeNum : 1;  Limit : NO_LIMIT),
                                          (TblName : 'DT#3    ';  FreeNum : 1;  Limit : NO_LIMIT),
                                          (TblName : 'DT#4    ';  FreeNum : 1;  Limit : NO_LIMIT),
                                          (TblName : 'DT#5    ';  FreeNum : 1;  Limit : NO_LIMIT),
                                          (TblName : 'DT#6    ';  FreeNum : 1;  Limit : NO_LIMIT),
                                          (TblName : 'DT#7    ';  FreeNum : 1;  Limit : NO_LIMIT),
                                          (TblName : 'DT#8    ';  FreeNum : 1;  Limit : NO_LIMIT));

  PassWord     = Nil;
Begin
  {MakeDir(aPath);
  Suffix:=IntToHex(aID,3)+#0;

  TmpName:=aPath+FileTblName+Suffix;
  Ht(htTableCreate(@TmpName[1],@FileTblStruct,FileFldCnt,
                   PassWord,PassWord,PassWord,
                   TAB_ANSI or TAB_CREATE,TmpTblH));
  Ht(htTableClose(TmpTblH));

  TmpName:=aPath+DLinkTblName+Suffix;
  Ht(htTableCreate(@TmpName[1],@DLinkTblStruct,DLinkFldCnt,
                   PassWord,PassWord,PassWord,
                   TAB_ANSI or TAB_CREATE,TmpTblH));
  Ht(htTableClose(TmpTblH));

  TmpName:=aPath+DirTblName+Suffix;
  Ht(htTableCreate(@TmpName[1],@DirTblStruct,DirFldCnt,
                   PassWord,PassWord,PassWord,
                   TAB_ANSI or TAB_CREATE,TmpTblH));
  Ht(htTableClose(TmpTblH));

  TmpName:=aPath+LogTblName+Suffix;
  Ht(htTableCreate(@TmpName[1],@LogTblStruct,LogFldCnt,
                   PassWord,PassWord,PassWord,
                   TAB_ANSI or TAB_CREATE,TmpTblH));
  Ht(htTableClose(TmpTblH));

  TmpName:=aPath+DossTblName+Suffix;
  Ht(htTableCreate(@TmpName[1],@DossTblStruct,DossFldCnt,
                   PassWord,PassWord,PassWord,
                   TAB_ANSI or TAB_CREATE,TmpTblH));
  Ht(htTableClose(TmpTblH));

  TmpName:=aPath+CtrlTblName+Suffix;
  Ht(htTableCreate(@TmpName[1],@CtrlTblStruct,CtrlFldCnt,
                   PassWord,PassWord,PassWord,
                   TAB_ANSI or TAB_CREATE,TmpTblH));
  Ht(htTableClose(TmpTblH));

  TmpName:=aPath+FreeTblName+Suffix;
  Ht(htTableCreate(@TmpName[1],@FreeTblStruct,FreeFldCnt,
                   PassWord,PassWord,PassWord,
                   TAB_ANSI or TAB_CREATE,TmpTblH));
  htRecordAdd(TmpTblH,@FreeRec1);
  htRecordAdd(TmpTblH,@FreeRec2);
  Ht(htTableClose(TmpTblH));
  Ht(htUpdateTable(@TmpName[1],PassWord,PassWord,True,False));

  CreateFIFamily(aID,aType,aPath);}
end;

function TFamilyTbl.FamilyPath(aFamilyId: TFamilyID): TPathStr;
begin
 if aFamilyId > f_MaxFamilyID then
  raise Exception.Create(Format('Ќеверный номер семейства: %d.', [aFamilyId]));

 Result := IncludeTrailingPathDelimiter(f_GlobalFamPaths^[aFamilyId]^);
end;

procedure TFamilyTbl.Cleanup;
var
 I: Integer;
 l_MaxFamily: TFamilyID;
begin
 If Assigned(GlobalHtServer) then
  l_MaxFamily:=f_MaxFamilyID
 else
  l_MaxFamily:=0;
 If Assigned(f_GlobalFamPaths) then
 Begin
  for I:=0 to l_MaxFamily do
   If f_GlobalFamPaths^[I]<>Nil then
    DisposeStr(f_GlobalFamPaths^[I]);
  l3System.FreeLocalMem(f_GlobalFamPaths);
 end;
 If Assigned(f_GlobalFamAttrib) then
  l3System.FreeLocalMem(f_GlobalFamAttrib);

 inherited;
end;

end.