unit m3DBProxyWriteStream;
 {* Поток, пишущий в базу }

// Модуль: "w:\common\components\rtl\Garant\m3\m3DBProxyWriteStream.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3DBProxyStream
 , l3Interfaces
;

type
 Tm3DBProxyWriteStream = class(Tm3DBProxyStream, Il3Rollback)
  {* Поток, пишущий в базу }
  private
   f_NeedCommit: Boolean;
    {* Сохранять ли изменения }
  protected
   function pm_GetIsNewVersion: Boolean; virtual;
   procedure Rollback;
    {* Откатить данные }
   procedure InitFields; override;
   procedure BeforeRelease; override;
  public
   property IsNewVersion: Boolean
    read pm_GetIsNewVersion;
    {* Новая версия документа }
 end;//Tm3DBProxyWriteStream

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

function Tm3DBProxyWriteStream.pm_GetIsNewVersion: Boolean;
//#UC START# *49BFE6600304_49BFC520008Aget_var*
//#UC END# *49BFE6600304_49BFC520008Aget_var*
begin
//#UC START# *49BFE6600304_49BFC520008Aget_impl*
 Result := false;
//#UC END# *49BFE6600304_49BFC520008Aget_impl*
end;//Tm3DBProxyWriteStream.pm_GetIsNewVersion

procedure Tm3DBProxyWriteStream.Rollback;
 {* Откатить данные }
//#UC START# *49C1040A0256_49BFC520008A_var*
//#UC END# *49C1040A0256_49BFC520008A_var*
begin
//#UC START# *49C1040A0256_49BFC520008A_impl*
 f_NeedCommit := false;
//#UC END# *49C1040A0256_49BFC520008A_impl*
end;//Tm3DBProxyWriteStream.Rollback

procedure Tm3DBProxyWriteStream.InitFields;
//#UC START# *47A042E100E2_49BFC520008A_var*
//#UC END# *47A042E100E2_49BFC520008A_var*
begin
//#UC START# *47A042E100E2_49BFC520008A_impl*
 inherited;
 f_NeedCommit := true;
//#UC END# *47A042E100E2_49BFC520008A_impl*
end;//Tm3DBProxyWriteStream.InitFields

procedure Tm3DBProxyWriteStream.BeforeRelease;
//#UC START# *49BFC98902FF_49BFC520008A_var*
//#UC END# *49BFC98902FF_49BFC520008A_var*
begin
//#UC START# *49BFC98902FF_49BFC520008A_impl*
 if f_NeedCommit then
  try
   if DB.IsExclusive then
   // - иначе нам не дадут записать новый поток
   //   как например в случае с Tm3SimpleDB в режиме MakeExclusive
    CloseInner;
   DB.Commit(Self);
  except
   on E: Exception do
   begin
    f_NeedCommit := false;
    l3System.Exception2Log(E);
   end;//on E: Exception
  end//try..except
 else
  DB.Revert(Self);
 inherited;
//#UC END# *49BFC98902FF_49BFC520008A_impl*
end;//Tm3DBProxyWriteStream.BeforeRelease

end.
