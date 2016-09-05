
Unit Dt_ImpKW;

{ $Id: DT_IMPKW.pas,v 1.56 2016/06/16 05:40:06 lukyanets Exp $ }

// $Log: DT_IMPKW.pas,v $
// Revision 1.56  2016/06/16 05:40:06  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.55  2015/11/24 14:08:24  voba
// -bf убрал конкурентную запись дерева словаря. Теперь дерево переписываем только при апдейте, в спокойной обстановке
//
// Revision 1.54  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.53  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.52  2013/01/17 10:11:56  voba
// - перенес интерфейсы в отдельный модуль
//
// Revision 1.51  2011/07/05 08:59:46  narry
// Не работает импорт ключевых слов (272667341)
//
// Revision 1.50  2010/10/04 14:08:25  fireton
// - const перед Tl3WString и Il3CString
//
// Revision 1.49  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.48  2010/09/21 11:06:54  fireton
// - переводим деревья с PChar на Tl3WString
//
// Revision 1.47  2010/08/03 13:16:38  voba
// - k: 229672814
//
// Revision 1.46  2009/12/23 08:33:43  voba
// - bug fix : проблемы с захватом семейства (таблица ctrl)
//
// Revision 1.45  2009/12/14 11:46:49  lulin
// - готовимся к возврату более простых строк.
//
// Revision 1.44  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.43  2009/07/20 12:38:48  voba
// - Засунул renum в атрибуты
//
// Revision 1.42  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.41  2009/05/15 08:26:23  narry
// - ошибки импорта-экспорта некоторых словарей
//
// Revision 1.40  2009/04/09 09:47:17  narry
// - процедура импорта линков многоуровневого словаря
//
// Revision 1.39  2009/04/02 15:17:11  narry
// - сделан универсальный заливатор линков
//
// Revision 1.38  2008/07/17 10:44:08  voba
// - enh. сокращаем количество функций редактирования словаря
//
// Revision 1.37  2008/07/07 09:40:10  voba
// - refact. выделил объект для работы со словарем (TDictionary)
//
// Revision 1.36  2007/12/26 14:10:35  lulin
// - модуль l3Interfaces полностью переведен на модель.
//
// Revision 1.35  2007/10/24 10:46:29  voba
// - enh. NeedAddToDictionary - возможность заливки KW без пополнения словаря
//
// Revision 1.34  2007/10/09 08:53:53  voba
// - merge with b_archi_export_refact2
//
// Revision 1.33.2.1  2007/09/17 08:27:58  voba
// no message
//
// Revision 1.33  2007/09/17 07:23:41  voba
// no message
//
// Revision 1.31.4.1  2007/07/26 12:08:13  voba
// - refact. выкинул  ImportType, все равно он только ietMassive использовался
//
// Revision 1.31  2007/05/18 12:23:40  fireton
// - реорганизация Большого Брата:
//   * логика перенесена из вызывающего кода в ББ
//   * изничтожен OperationHandle
//
// Revision 1.30  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.29  2006/10/09 12:07:39  voba
// - del SavingType
//
// Revision 1.28  2006/10/04 08:34:37  voba
// - remove tdSingle
//
// Revision 1.27  2006/08/23 08:42:32  voba
// - merge with b_archi_ifltr_opt
//
// Revision 1.26.38.1  2006/04/14 13:48:22  voba
// no message
//
// Revision 1.26  2005/04/07 14:08:50  narry
// - bug fix: дублирование элементов второго уровня
//
// Revision 1.25  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.24  2004/08/03 08:52:50  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.23  2004/07/13 08:02:34  step
// слияние с веткой b_import_filter_optimization2
//
// Revision 1.22.2.2  2004/07/09 17:05:54  step
// исправлена опечатка
//
// Revision 1.22.2.1  2004/07/09 17:01:14  step
// использование TImportIdToRealIdMap для ускорения TKWImportServer
//
// Revision 1.22  2004/07/07 15:48:55  step
// no message
//
// Revision 1.21  2004/07/07 15:40:43  step
// использование TAbsHtTbl.IgnoreDuplicates
//
// Revision 1.20  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.19.2.2  2004/06/18 14:41:26  step
// замена Buffering на StartCaching/StopCaching
//
// Revision 1.19.2.1  2004/06/17 18:03:49  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.19  2004/05/20 14:48:01  step
// Замена fFreeTbl на GlobalHtServer.FreeTbl[fFamily]
//
// Revision 1.18  2004/05/13 16:32:18  step
// замена: "TFreeTbl.Create ..." --> "GlobalHtServer.FreeTbl[...]"
//
// Revision 1.17  2004/05/06 09:16:07  voba
// merge with adding_diapasons_table_free2
//
// Revision 1.16.40.1  2004/04/09 16:57:56  step
// Переделан класс TFreeTbl (теперь работает с диапазонами)
//
// Revision 1.16  2002/05/30 06:35:09  demon
// - separate TCacheTblData object in new unit
//
// Revision 1.15  2001/09/17 06:52:18  demon
// - byg fix: before unlock family all other tbls now closed, and after unlock all opened
//
// Revision 1.14  2001/01/11 10:59:56  demon
// fix some Delphi Warnings
//
// Revision 1.13  2000/12/15 15:36:15  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
Uses
    WinTypes,
    l3Interfaces,
    l3Base, l3DatLst, l3Tree_TLB,
    daTypes,
    HT_Const,
    Dt_Const, Dt_Types, dt_AttrSchema,
    Dt_IFltr, Dt_ReNum, DT_Free,
    DT_Dict,
    Dt_TblCache;

Type
 TDictLinkImportServer = class(Tl3Base)
  private
   f_DictID: TdaDictionaryType;
   f_ImportIdToRealIdMap: TImportIdToRealIdMap;
  protected
   fFamily       : TdaFamilyID;
   fReNum        : Boolean;
   fClearFlag    : Boolean;
   fNeedAddToDictionary : Boolean;
   fFamilyIsLock : Boolean;

   fCacheTblData : TCacheTblData;

   CurSavedCnt   : LongInt;

   f_RootNode    : TDictRootNode;

   fReNumTbl     : TReNumTbl;

   Procedure   SetReNum(aVal : Boolean);

   Procedure   BeforeRelease; override;
   Procedure   Cleanup; override;
  public
   constructor Create(aFamily: TdaFamilyID; aDictId: TdaDictionaryType; aClearDictionary, aNeedAddToDictionary: Boolean); reintroduce;

   function    GetRootKeyWord(const aName : String;Var aRootNode : Il3Node) : TDictID;

   procedure AddKeyWord(RootID          : TDictID;
                        const aRootNode : Il3Node;
                        var CurID       : TDictID;
                        const aName     : Tl3WString;
                        aDocID          : TDocID;
                        aSub            : TSubID); overload;

   procedure AddKeyWord(const aRootNode : Il3Node;
                        var CurID       : TDictID;
                        const aName     : Tl3WString;
                        aDocID          : TDocID;
                        aSub            : TSubID); overload;

   (* Renumerate from External IDs to Internal IDs,
         Default value TRUE *)
   Property    ReNum : Boolean read fReNum write SetReNum;
 end;

Implementation

Uses
  l3MinMax,
  l3TreeInterfaces,
  l3Nodes,
  l3String,

  HT_Dll,
  Dt_aTbl,
  Dt_Link, Dt_LinkServ, DT_Serv, SysUtils,
  Dt_err,DT_Lock, DT_DictConst, dt_DictIntf;

Const
 DataBufCapacity = 4000; {Maximum count elements in cache buffer}

(************************ TKWImportServer ****************************)

constructor TDictLinkImportServer.Create(aFamily: TdaFamilyID; aDictId: TdaDictionaryType; aClearDictionary, aNeedAddToDictionary:
    Boolean);
Begin
 Inherited Create;
 fFamily:=aFamily;
 f_DictID:= aDictID;

 f_ImportIdToRealIdMap := TImportIdToRealIdMap.Create(LinkServer(fFamily).Renum);
 //f_ImportIdToRealIdMap.LoadData;

 DictServer(fFamily).PO_Begin;

 fFamilyIsLock := LockServer.LockFamily(fFamily);
 fClearFlag := aClearDictionary;
 fNeedAddToDictionary := aNeedAddToDictionary;
 if fClearFlag then
 begin
  DictServer(fFamily).DictTbl[f_DictID].DropTblData;
  //DictServer(fFamily).DictRootNode[f_DictID].ClearAllData;
  DictServer(fFamily).DictRootNode[f_DictID].StartReload;
  LinkServer(fFamily).Links[f_DictID].Table.DropTblData;
 end;
 fCacheTblData := TCacheTblData.Create(LinkServer(fFamily).Links[f_DictID].Table);

 Renum:=True;

 DictServer(fFamily).DictTbl[f_DictID].StartCaching;
 DictServer(fFamily).DictTbl[f_DictID].IgnoreDuplicates := True;

 GlobalHtServer.FreeTbl[fFamily].ExclusiveUse := True;

 f_RootNode:=DictServer(fFamily).DictRootNode[f_DictID].Use;
end;

Procedure TDictLinkImportServer.BeforeRelease;
begin
 fCacheTblData.Save;
 DictServer(fFamily).DictTbl[f_DictID].StopCaching;
 DictServer(fFamily).DictTbl[f_DictID].IgnoreDuplicates := False;

 If fFamilyIsLock then
  //DictServer(fFamily).Dict[f_DictID].Update;
  DictServer(fFamily).DictRootNode[f_DictID].Save;

 GlobalHtServer.FreeTbl[fFamily].ExclusiveUse := False;
 LockServer.UnLockFamily(fFamily);

 DictServer(fFamily).PO_End;

 inherited;
end;

Procedure TDictLinkImportServer.Cleanup;
begin
 l3Free(fCacheTblData);

 l3Free(f_RootNode);
 l3Free(f_ImportIdToRealIdMap);
 Inherited;
end;

Procedure TDictLinkImportServer.SetReNum(aVal : Boolean);
Begin
 If Not Assigned(fReNumTbl) then
  fReNumTbl:=LinkServer(fFamily).Renum;
 fReNum:=aVal;
end;

Function TDictLinkImportServer.GetRootKeyWord(const aName : String;Var aRootNode : Il3Node) : TDictID;
Var
 SearchRes : Boolean;
Begin
 Result:=0;
 if (aName='') then
  exit;
 aRootNode:=Nil;
 SearchRes:=True;

 If Not fClearFlag then
  Begin
   aRootNode:=l3SearchByName(f_RootNode,aName,imOneLevel);
   If aRootNode<>Nil then
    Result:= (aRootNode as IDictItem).Handle
   else
   if fNeedAddToDictionary then
    SearchRes:=False
   else
    exit;
  end
 else
  SearchRes:=False;

 If Not SearchRes then
 Begin
  aRootNode := DictServer(fFamily).Dict[f_DictID].AddDictNode(cUndefDictID, l3PCharLen(aName), l3PCharLen(cEmptyEngName),  l3PCharLen, f_RootNode);
  Result:= (aRootNode as IDictItem).Handle;
 end;
end;

procedure TDictLinkImportServer.AddKeyWord(RootID            : TDictID;
                                           const aRootNode   : Il3Node;
                                           var CurID         : TDictID;
                                           const aName       : Tl3WString;
                                           aDocID            : TDocID;
                                           aSub              : TSubID);
Var
 TmpNode   : Il3Node;
 SearchRes : Boolean;
 l_RealId: longWord;
Begin
 If (RootID=0) or l3IsNil(aName) then
  Exit;
 SearchRes:=True;
 if CurID = 0 then
 begin
  if not fClearFlag then
  begin
   TmpNode := l3SearchByName(f_RootNode,aName, 0, aRootNode);
   if TmpNode <> Nil then
    CurID := (TmpNode as IDictItem).Handle
   else
    if fNeedAddToDictionary then
     SearchRes := False
    else
     Exit;
  end
  else
   SearchRes := False;

  if not SearchRes then
  begin
   TmpNode:= DictServer(fFamily).Dict[f_DictID].AddDictNode(cUndefDictID, aName, l3PCharLen(cEmptyEngName), l3PCharLen, aRootNode);
   CurID:= (TmpNode as IDictItem).Handle;
  end;
 end;

 If (aDocID <= 0) then exit;

 If fReNum then
  if f_ImportIdToRealIdMap.Find(aDocID, l_RealId) then
   aDocID := l_RealId
  else
   fReNumTbl.GetRNumber(aDocID);

 fCacheTblData.TblObj.ClearFullRec;
 fCacheTblData.TblObj.PutToFullRec(lnkDocIDFld,aDocID);
 fCacheTblData.TblObj.PutToFullRec(lnkDictIDFld,CurID);
 fCacheTblData.TblObj.PutToFullRec(lnkSubIDfld,aSub);
 fCacheTblData.AddCurDataToCache;
end;

procedure TDictLinkImportServer.AddKeyWord(const aRootNode : Il3Node;
                                           var CurID       : TDictID;
                                           const aName     : Tl3WString;
                                           aDocID          : TDocID;
                                           aSub            : TSubID);
Var
 TmpNode   : Il3Node;
 SearchRes : Boolean;
 l_RealId: longWord;
Begin
 If l3IsNil(aName) then
  Exit;
 SearchRes:=True;
 if CurID = 0 then
 begin
  if not fClearFlag then
  begin
   TmpNode := l3SearchByPath(f_RootNode, aName);
   if TmpNode <> Nil then
    CurID := (TmpNode as IDictItem).Handle
   else
    if fNeedAddToDictionary then
     SearchRes := False
    else
     Exit;
  end
  else
   SearchRes := False;

  if not SearchRes then
  begin
   TmpNode:= DictServer(fFamily).Dict[f_DictID].AddDictNode(cUndefDictID, aName, l3PCharLen(cEmptyEngName), l3PCharLen, aRootNode);
   CurID:= (TmpNode as IDictItem).Handle;
  end;
 end;

 If (aDocID <= 0) then exit;

 If fReNum then
  if f_ImportIdToRealIdMap.Find(aDocID, l_RealId) then
   aDocID := l_RealId
  else
   fReNumTbl.GetRNumber(aDocID);

 fCacheTblData.TblObj.ClearFullRec;
 fCacheTblData.TblObj.PutToFullRec(lnkDocIDFld,aDocID);
 fCacheTblData.TblObj.PutToFullRec(lnkDictIDFld,CurID);
 if fCacheTblData.TblObj.fldCount = 3 then
  fCacheTblData.TblObj.PutToFullRec(lnkSubIDfld,aSub);
 fCacheTblData.AddCurDataToCache;
end;

end.
