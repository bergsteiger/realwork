unit arLockUtils;

// Модуль: "w:\archi\source\projects\Common\Utils\arLockUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "arLockUtils" MUID: (57E1136103D7)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , daTypes
 , dt_Types
 , l3DatLst
;

procedure AddToDenyList(aFamily: TdaFamilyID;
 aDocID: TDocID;
 aList: Tl3StringDataList;
 aReqUserNames: Boolean = False;
 const aIgnoredLockHandle: TJLHandle = -1);

implementation

uses
 l3ImplUses
 , daDataProvider
 {$If NOT Defined(Nemesis)}
 , dt_Lock
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , dt_LinkServ
 {$IfEnd} // NOT Defined(Nemesis)
 //#UC START# *57E1136103D7impl_uses*
 //#UC END# *57E1136103D7impl_uses*
;

const
 cUsersMsg = 'Пользователи : %s';
 cAccessHoldByUser = 'Доступ захвачен пользователем (';
 cDocAccessDeny = 'Невозможно получить доступ к документу [GarantID = %d].';
 cUserMsg = 'Пользователь : %s';

procedure AddToDenyList(aFamily: TdaFamilyID;
 aDocID: TDocID;
 aList: Tl3StringDataList;
 aReqUserNames: Boolean = False;
 const aIgnoredLockHandle: TJLHandle = -1);
//#UC START# *57E1137D00AE_57E1136103D7_var*
var
 l_Msg      : AnsiString;
 l_Station  : TStationNameArray;
 l_UserID   : TdaUserIDArray;
 l_UsersStr : AnsiString;
 I          : Integer;
 lImpId     : TDocID;
//#UC END# *57E1137D00AE_57E1136103D7_var*
begin
//#UC START# *57E1137D00AE_57E1136103D7_impl*
 l_Msg := '';
 if aReqUserNames then
 begin
  LockServer.WhoLockDoc(aFamily, aDocID, l_Station, l_UserID, aIgnoredLockHandle);
  //l_Msg := Format(cStationMsg, [l_Station]);
  if Length(l_UserID) > 0 then
  begin
   l_UsersStr := '';
   for I := Low(l_UserID) to High(l_UserID) do
   begin
    if l_UsersStr <> '' then
     l_UsersStr := l_UsersStr + ', ';
    l_UsersStr := l_UsersStr + GlobalDataProvider.UserManager.GetUserName(l_UserID[I]);
   end;

   if High(l_UserID) > 0 then
    l_Msg := l_Msg + Format(cUsersMsg, [l_UsersStr])
   else
    l_Msg := l_Msg + Format(cUserMsg, [l_UsersStr]);
   l_Msg := ^M + cAccessHoldByUser + l_Msg +')';
  end;
 end;
 lImpId := LinkServer(aFamily).Renum.GetExtDocID(aDocID);
 l_Msg := Format(cDocAccessDeny, [lImpId{, GetAssGroupName(aAssessItem)}]) + l_Msg;
 aList.AddStr(l_Msg, @lImpId);
//#UC END# *57E1137D00AE_57E1136103D7_impl*
end;//AddToDenyList

end.
