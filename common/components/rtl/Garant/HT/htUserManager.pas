unit htUserManager;

// Модуль: "w:\common\components\rtl\Garant\HT\htUserManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ThtUserManager" MUID: (5629E343023B)

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , daUserManager
 , daInterfaces
 , l3DatLst
 , daTypes
;

type
 ThtUserManager = class(TdaUserManager)
  protected
   procedure FillAllUsers(aList: Tl3StringDataList); override;
   procedure FillAllGroups(aList: Tl3StringDataList); override;
   function DoCheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError; override;
   function DoIsUserAdmin(anUserID: TdaUserID): Boolean; override;
  public
   constructor Create; reintroduce;
   class function Make: IdaUserManager; reintroduce;
 end;//ThtUserManager

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_User
 {$IfEnd} // NOT Defined(Nemesis)
;

constructor ThtUserManager.Create;
//#UC START# *5629F0F901C8_5629E343023B_var*
//#UC END# *5629F0F901C8_5629E343023B_var*
begin
//#UC START# *5629F0F901C8_5629E343023B_impl*
 inherited Create;
//#UC END# *5629F0F901C8_5629E343023B_impl*
end;//ThtUserManager.Create

class function ThtUserManager.Make: IdaUserManager;
var
 l_Inst : ThtUserManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtUserManager.Make

procedure ThtUserManager.FillAllUsers(aList: Tl3StringDataList);
//#UC START# *5715E71600DD_5629E343023B_var*
//#UC END# *5715E71600DD_5629E343023B_var*
begin
//#UC START# *5715E71600DD_5629E343023B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E71600DD_5629E343023B_impl*
end;//ThtUserManager.FillAllUsers

procedure ThtUserManager.FillAllGroups(aList: Tl3StringDataList);
//#UC START# *5715E74402CA_5629E343023B_var*
//#UC END# *5715E74402CA_5629E343023B_var*
begin
//#UC START# *5715E74402CA_5629E343023B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E74402CA_5629E343023B_impl*
end;//ThtUserManager.FillAllGroups

function ThtUserManager.DoCheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): TdaLoginError;
//#UC START# *5715E767013D_5629E343023B_var*
//#UC END# *5715E767013D_5629E343023B_var*
begin
//#UC START# *5715E767013D_5629E343023B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E767013D_5629E343023B_impl*
end;//ThtUserManager.DoCheckPassword

function ThtUserManager.DoIsUserAdmin(anUserID: TdaUserID): Boolean;
//#UC START# *5715E78F013E_5629E343023B_var*
//#UC END# *5715E78F013E_5629E343023B_var*
begin
//#UC START# *5715E78F013E_5629E343023B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E78F013E_5629E343023B_impl*
end;//ThtUserManager.DoIsUserAdmin

end.
