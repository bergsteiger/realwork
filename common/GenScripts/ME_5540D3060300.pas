unit htJournal;

// Модуль: "w:\common\components\rtl\Garant\HT\htJournal.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , daJournal
 {$If NOT Defined(Nemesis)}
 , dt_BBLog
 {$IfEnd} // NOT Defined(Nemesis)
 , daInterfaces
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Date
 , daTypes
 , l3Tree
;

type
 TBigBrotherAccess = {final} class(TBigBrotherTbl)
 end;//TBigBrotherAccess

 ThtJournal = class(TdaJournal)
  private
   f_Table: TBigBrotherTbl;
  private
   function BigBrother: TBigBrotherAccess;
   function GetUserStatistic(const FromDate: TStDate;
    const ToDate: TStDate;
    UserOrGroupID: TdaUserID;
    UserGr: Boolean): ISab;
   function GetDocStatistic(const FromDate: TStDate;
    const ToDate: TStDate;
    aDocID: TdaDocID): ISab;
  protected
   procedure LogEvent(aOperation: TdaJournalOperation;
    aFamilyID: TdaFamilyID;
    aExtID: LongInt;
    aData: LongInt); override;
   procedure CheckUser(anUserID: TdaUserID); override;
   procedure UserChanged(anUserID: TdaUserID); override;
   procedure SessionChanged; override;
   procedure DoStartCaching; override;
   procedure DoStopCaching; override;
   function MakeResultSet(const FromDate: TStDate;
    const ToDate: TStDate;
    aDocID: TdaDocID;
    UserOrGroupID: TdaUserID;
    UserGr: Boolean): IdaResultSet; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory): IdaJournal; reintroduce;
 end;//ThtJournal

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , htResultSet
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , HT_Const
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_User
 {$IfEnd} // NOT Defined(Nemesis)
 , htInterfaces
 , daSelectFieldList
 , daScheme
 , Classes
 {$If NOT Defined(Nemesis)}
 , dt_Err
 {$IfEnd} // NOT Defined(Nemesis)
;

constructor ThtJournal.Create(const aFactory: IdaTableQueryFactory);
//#UC START# *5540D6BB015A_5540D3060300_var*
//#UC END# *5540D6BB015A_5540D3060300_var*
begin
//#UC START# *5540D6BB015A_5540D3060300_impl*
 inherited Create(aFactory);
//#UC END# *5540D6BB015A_5540D3060300_impl*
end;//ThtJournal.Create

class function ThtJournal.Make(const aFactory: IdaTableQueryFactory): IdaJournal;
var
 l_Inst : ThtJournal;
begin
 l_Inst := Create(aFactory);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtJournal.Make

function ThtJournal.BigBrother: TBigBrotherAccess;
//#UC START# *5549F376004F_5540D3060300_var*
//#UC END# *5549F376004F_5540D3060300_var*
begin
//#UC START# *5549F376004F_5540D3060300_impl*
 if f_Table = nil then
  f_Table := TBigBrotherTbl.Create;
 Result := TBigBrotherAccess(f_Table);
//#UC END# *5549F376004F_5540D3060300_impl*
end;//ThtJournal.BigBrother

function ThtJournal.GetUserStatistic(const FromDate: TStDate;
 const ToDate: TStDate;
 UserOrGroupID: TdaUserID;
 UserGr: Boolean): ISab;
//#UC START# *5563286A0387_5540D3060300_var*
var
 l_ResultSab: ISab;
 TmpOper  : Word;
//#UC END# *5563286A0387_5540D3060300_var*
begin
//#UC START# *5563286A0387_5540D3060300_impl*
 CorrectDates(FromDate, ToDate);
 Result := nil;

 l_ResultSab := MakeSab(BigBrother);

 try
  if UserOrGroupID <> 0 then
  begin
   // Если UserOrGroupID - это группа, то получаем список записей для пользователей из группы
   // Если нет, то получаем этого пользователя
   if UserGr then
   begin
    l_ResultSab := MakeSab(UserManager.LinkTbl.Table, UserManager.GetUserIDSabOnGroup(UserOrGroupID));
    l_ResultSab.TransferToPhoto(bbID_Ext, MakePhoto(BigBrother));
    l_ResultSab.RecordsByKey;
   end
   else
    l_ResultSab.Select(bbID_Ext, UserOrGroupID);

   // получаем список сессий
   TmpOper := Word(da_oobSessionBegin);
   l_ResultSab.SubSelect(bbID_Operation, TmpOper);
   // получаем сессии в диапазоне дат...
   l_ResultSab.SubSelect(bbDate, FromDate, ToDate);

   // получаем все операции выбранных сессий
   l_ResultSab.ValuesOfKey(bbID_Session);
   l_ResultSab.RecordsByKey;
  end
  else
   l_ResultSab.Select(bbDate, FromDate, ToDate);

  Result := l_ResultSab;
 finally
  l_ResultSab := nil;
 end;
//#UC END# *5563286A0387_5540D3060300_impl*
end;//ThtJournal.GetUserStatistic

function ThtJournal.GetDocStatistic(const FromDate: TStDate;
 const ToDate: TStDate;
 aDocID: TdaDocID): ISab;
//#UC START# *556328D003C8_5540D3060300_var*
var
 l_DocSab  : ISab;
 l_SessSab : ISab;
 l_SessEndSab: ISab;
 TmpOper  : Word;
//#UC END# *556328D003C8_5540D3060300_var*
begin
//#UC START# *556328D003C8_5540D3060300_impl*
 CorrectDates(FromDate, ToDate);
 Result := nil;

 l_DocSab := MakeSab(BigBrother);
 try
  // Если aDocID определен
  if aDocID <> 0 then
  begin
   // сначала найдем все вхождения aDocID
   l_DocSab.Select(bbID_Ext, aDocID);
   // выкинем входжения, относящиеся к User ID
   TmpOper:=Word(da_oobSessionBegin);
   l_DocSab.SubSelect(bbID_Operation, TmpOper, NOT_EQUAL);
   // теперь отфильтруем по дате
   l_DocSab.SubSelect(bbDate, FromDate, ToDate);

   // мы получили все записи, в которых что-то делается с искомым документом
   // теперь получим список сессий, в которых это происходит
   l_SessSab := MakeSabCopy(l_DocSab);
   try
    l_SessSab.ValuesOfKey(bbID_Session);
    // и все записи, которые принадлежат этим сессиям
    l_SessSab.RecordsByKey;

    // теперь найдем начала и концы сессий и приклеим их к вхождениям докдокументов
    l_SessEndSab := MakeSabCopy(l_SessSab);
    try
     TmpOper:=Word(da_oobSessionBegin);
     l_SessSab.SubSelect(bbID_Operation, TmpOper);
     TmpOper:=Word(da_oobSessionEnd);
     l_SessEndSab.SubSelect(bbID_Operation, TmpOper);

     l_DocSab.OrSab(l_SessSab);
     l_DocSab.OrSab(l_SessEndSab);
    finally
     l_SessEndSab := nil;
    end;
   finally
    l_SessSab := nil;
   end;
  end
  else // если aDocID документа не задано, то получаем все записи из диапазона дат
   l_DocSab.Select(bbDate, FromDate, ToDate);

  Result := l_DocSab;
 finally
  l_DocSab := nil;
 end;
//#UC END# *556328D003C8_5540D3060300_impl*
end;//ThtJournal.GetDocStatistic

procedure ThtJournal.LogEvent(aOperation: TdaJournalOperation;
 aFamilyID: TdaFamilyID;
 aExtID: LongInt;
 aData: LongInt);
//#UC START# *5549F6220397_5540D3060300_var*
Var
 TmpLI   : LongInt;
 l_Operation: Word;
//#UC END# *5549F6220397_5540D3060300_var*
begin
//#UC START# *5549F6220397_5540D3060300_impl*
// BigBrother.PutBBRec(aOperation, aFamilyID, aExtID, aData);


 if CurSessionID = BlankSession then
  raise EHtErrors.CreateInt(ecNotEnable);

 BigBrother.ClearFullRec;
 BigBrother.PutToFullRec(bbID_Session, CurSessionID);
 l_Operation := Word(aOperation);
 BigBrother.PutToFullRec(bbID_Operation, l_Operation);
 BigBrother.PutToFullRec(bbID_Family, aFamilyID);
 if aExtID <> 0 then
  BigBrother.PutToFullRec(bbID_Ext, aExtID);
 TmpLI:=CurrentDate;
 BigBrother.PutToFullRec(bbDate, TmpLI);
 TmpLI:=CurrentTime;
 BigBrother.PutToFullRec(bbTime, TmpLI);
 if aData <> 0 then
  BigBrother.PutToFullRec(bbAdditional, aData);

 BigBrother.AddFRec;


//#UC END# *5549F6220397_5540D3060300_impl*
end;//ThtJournal.LogEvent

procedure ThtJournal.CheckUser(anUserID: TdaUserID);
//#UC START# *559B6A290200_5540D3060300_var*
//#UC END# *559B6A290200_5540D3060300_var*
begin
//#UC START# *559B6A290200_5540D3060300_impl*
 Assert(BigBrother.UserID = anUserID);
//#UC END# *559B6A290200_5540D3060300_impl*
end;//ThtJournal.CheckUser

procedure ThtJournal.UserChanged(anUserID: TdaUserID);
//#UC START# *559B6A7C03AA_5540D3060300_var*
//#UC END# *559B6A7C03AA_5540D3060300_var*
begin
//#UC START# *559B6A7C03AA_5540D3060300_impl*
  BigBrother.fCurUser := anUserID;
//#UC END# *559B6A7C03AA_5540D3060300_impl*
end;//ThtJournal.UserChanged

procedure ThtJournal.SessionChanged;
//#UC START# *559B6A8C0034_5540D3060300_var*
//#UC END# *559B6A8C0034_5540D3060300_var*
begin
//#UC START# *559B6A8C0034_5540D3060300_impl*
 BigBrother.fCurSessionID := CurSessionID;
//#UC END# *559B6A8C0034_5540D3060300_impl*
end;//ThtJournal.SessionChanged

procedure ThtJournal.DoStartCaching;
//#UC START# *559B889B030B_5540D3060300_var*
//#UC END# *559B889B030B_5540D3060300_var*
begin
//#UC START# *559B889B030B_5540D3060300_impl*
 BigBrother.StartCaching;
//#UC END# *559B889B030B_5540D3060300_impl*
end;//ThtJournal.DoStartCaching

procedure ThtJournal.DoStopCaching;
//#UC START# *559B88B00126_5540D3060300_var*
//#UC END# *559B88B00126_5540D3060300_var*
begin
//#UC START# *559B88B00126_5540D3060300_impl*
 BigBrother.StopCaching;
//#UC END# *559B88B00126_5540D3060300_impl*
end;//ThtJournal.DoStopCaching

function ThtJournal.MakeResultSet(const FromDate: TStDate;
 const ToDate: TStDate;
 aDocID: TdaDocID;
 UserOrGroupID: TdaUserID;
 UserGr: Boolean): IdaResultSet;
//#UC START# *559CF9D300FA_5540D3060300_var*
var
 l_ResultSab: ISab;
 l_DocSab: ISab;
 l_SelectFields : TdaSelectFieldList;

 function lp_AddSelectField(aField: IdaFieldDescription): Boolean;
 begin
  Result := True;
  l_SelectFields.Add(Factory.MakeSelectField('', aField));
 end;

//#UC END# *559CF9D300FA_5540D3060300_var*
begin
//#UC START# *559CF9D300FA_5540D3060300_impl*
 try
  if UserOrGroupID <> 0 then
  begin
   l_ResultSab := GetUserStatistic(FromDate, ToDate, UserOrGroupID, UserGr);
   if aDocID <> 0 then
   begin
    l_DocSab := GetDocStatistic(FromDate, ToDate, aDocID);
    try
     l_ResultSab.AndSab(l_DocSab);
    finally
     l_DocSab := nil;
    end;
   end;
  end
  else
   l_ResultSab := GetDocStatistic(FromDate, ToDate, aDocID);
  // анализируем полученные данные
  l_ResultSab.Sort([bbID_Session, bbDate, bbTime]);
  l_SelectFields := TdaSelectFieldList.Make;
  try
   TdaScheme.Instance.Table(da_mtJournal).IterateFieldsF(L2DaTableDescriptionIteratorIterateFieldsFAction(@lp_AddSelectField));
   Result := ThtResultSet.Make(Factory.DataConverter as IhtDataConverter, l_ResultSab.HTSab, l_SelectFields, True);
  finally
   FreeAndNil(l_SelectFields);
  end;
 finally
  l_ResultSab := nil;
 end;
//#UC END# *559CF9D300FA_5540D3060300_impl*
end;//ThtJournal.MakeResultSet

procedure ThtJournal.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5540D3060300_var*
//#UC END# *479731C50290_5540D3060300_var*
begin
//#UC START# *479731C50290_5540D3060300_impl*
 FreeAndNil(f_Table);
 inherited;
//#UC END# *479731C50290_5540D3060300_impl*
end;//ThtJournal.Cleanup

end.
