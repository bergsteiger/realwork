unit m3DBProxyWriteStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3$DB"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/m3/m3DBProxyWriteStream.pas"
// Начат: 17.03.2009 18:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3$DB::m3DB::Tm3DBProxyWriteStream
//
// Поток, пишущий в базу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Interfaces,
  m3DBProxyStream
  ;

type
 Tm3DBProxyWriteStream = class(Tm3DBProxyStream, Il3Rollback)
  {* Поток, пишущий в базу }
 private
 // private fields
   f_NeedCommit : Boolean;
    {* Сохранять ли изменения}
 protected
 // property methods
   function pm_GetIsNewVersion: Boolean; virtual;
 protected
 // realized methods
   procedure Rollback;
     {* Откатить данные }
 protected
 // overridden protected methods
   procedure InitFields; override;
   procedure BeforeRelease; override;
 public
 // public properties
   property IsNewVersion: Boolean
     read pm_GetIsNewVersion;
     {* Новая версия документа }
 end;//Tm3DBProxyWriteStream

implementation

uses
  SysUtils,
  l3Base
  ;

// start class Tm3DBProxyWriteStream

function Tm3DBProxyWriteStream.pm_GetIsNewVersion: Boolean;
//#UC START# *49BFE6600304_49BFC520008Aget_var*
//#UC END# *49BFE6600304_49BFC520008Aget_var*
begin
//#UC START# *49BFE6600304_49BFC520008Aget_impl*
 Result := false;
//#UC END# *49BFE6600304_49BFC520008Aget_impl*
end;//Tm3DBProxyWriteStream.pm_GetIsNewVersion

procedure Tm3DBProxyWriteStream.Rollback;
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