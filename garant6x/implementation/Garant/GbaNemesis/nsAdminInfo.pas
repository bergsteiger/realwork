unit nsAdminInfo;
{* Контактные данные администратора. }

// Библиотека : Проект Немезис;
// Автор      : Морозов М.А.;
// Модуль     : nsAdminInfo;
// Начат      : 20.05.2007
// Версия     : $Id: nsAdminInfo.pas,v 1.9 2013/09/04 12:28:27 morozov Exp $

(*-------------------------------------------------------------------------------
  $Log: nsAdminInfo.pas,v $
  Revision 1.9  2013/09/04 12:28:27  morozov
  {RequestLink: 462553218}

  Revision 1.8  2013/04/24 09:35:55  lulin
  - портируем.

  Revision 1.7  2011/01/27 15:01:12  lulin
  {RequestLink:248195582}.
  - упрощаем программирование на форме.

  Revision 1.6  2011/01/27 12:13:08  lulin
  {RequestLink:248195582}.
  - избавляемся от развесистых макарон.

  Revision 1.5  2009/02/10 19:03:13  lulin
  - <K>: 133891247. Вычищаем морально устаревший модуль.

  Revision 1.4  2009/02/09 14:52:23  lulin
  - <K>: 133891247. Выделяем интерфейсы администратора.

  Revision 1.3  2008/01/10 07:23:10  oman
  Переход на новый адаптер

  Revision 1.2.4.2  2007/11/26 09:03:45  oman
  Перепиливаем на новый адаптер

  Revision 1.2.4.1  2007/11/22 13:27:45  oman
  Перепиливаем на новый адаптер

  Revision 1.2  2007/08/10 05:57:54  oman
  - fix: Убеждаемся, что в адаптер передается действительно _PChar
   (cq25680)

  Revision 1.1  2007/06/21 12:00:44  mmorozov
  - new: запрет авторегистрации (CQ: OIT5-25328);

-------------------------------------------------------------------------------*)

interface

uses
  l3Interfaces,

  vcmBase,

  StartUnit,

  AdminDomainInterfaces
  ;

type
  TnsAdminInfo = class(TvcmBase, InsAdminInfo)
  private
  // fields
    f_Email        : Il3CString;
    f_Phone        : Il3CString;
    f_Autorization : Integer;
  private
    function MakeNotNullStr(const AStr: Il3CString): PAnsiChar;
  private
  // InsAdminInfo
    function pm_GetEmail: Il3CString;
    procedure pm_SetEmail(const aValue: Il3CString);
      {* - в случае превышения длинны получаем EdsMaxLengthExceed. }
    function pm_GetPhone: Il3CString;
    procedure pm_SetPhone(const aValue: Il3CString);
      {* - в случае превышения длинны получаем EdsMaxLengthExceed. }
    function pm_GetHasEmail: Boolean;
      {-}
    function pm_GetHasPhone: Boolean;
      {-}
  private
  // property methods
    function pm_GetAutorization: IAuthorization;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property Autorization: IAuthorization
      read pm_GetAutorization;
      {-}
    property Phone: Il3CString
      read pm_GetPhone
      write pm_SetPhone;
      {-}
    property Email: Il3CString
      read pm_GetEmail
      write pm_SetEmail;
      {-}
    property HasEmail: Boolean
      read pm_GetHasEmail;
      {-}
    property HasPhone: Boolean
      read pm_GetHasPhone;
      {-}
  public
  // methods
    constructor Create(const aAutorization: IAuthorization);
      reintroduce;
      {-}
    class function Make(const aAutorization: IAuthorization): InsAdminInfo;
      {-}
  end;//TnsAdminInfo

implementation

uses
  l3String,

  SysUtils,
  
  IOUnit,

  DataAdapter,

  nsTypes
  ;

procedure TnsAdminInfo.Cleanup;
begin
 f_Phone := nil;
 f_Email := nil;
 f_Autorization := 0;
 inherited;
end;//Cleanup

constructor TnsAdminInfo.Create(const aAutorization: IAuthorization);
begin
 inherited Create;
 f_Autorization := Integer(aAutorization);
  // - нам нельзя хранить ссылку на честный интерфейс,
  //   см. Assert(CheckAutorizationInterfaceRefCount);
end;//Create

class function TnsAdminInfo.Make(const aAutorization: IAuthorization): InsAdminInfo;
var
 l_Class: TnsAdminInfo;
begin
 l_Class := Create(aAutorization);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TnsAdminInfo.pm_GetAutorization: IAuthorization;
begin
 Result := IAuthorization(f_Autorization);
end;//pm_GetAutorization

function TnsAdminInfo.MakeNotNullStr(const AStr: Il3CString): PAnsiChar;
// http://mdp.garant.ru/pages/viewpage.action?pageId=462553218
var
 l_Char: PAnsiChar;
begin
 l_Char := nsAStr(AStr).S;
 if (l_Char = nil) then
  l_Char := PAnsiChar('');
 Result := l_Char;
end;

function TnsAdminInfo.pm_GetEmail: Il3CString;
var
 l_Email: IString;
begin
 if f_Email = nil then
 begin
  Autorization.GetAdministratorEmail(l_Email);
  try
   f_Email := nsCStr(l_Email);
  finally
   l_Email := nil;
  end;//try..finally
 end;//if f_Email = nil then
 Result := f_Email;
end;//pm_GetEmail

function TnsAdminInfo.pm_GetHasEmail: Boolean;
begin
 Result := not l3IsNil(Email);
end;//pm_GetHasEmail

function TnsAdminInfo.pm_GetHasPhone: Boolean;
begin
 Result := not l3IsNil(Phone);
end;//pm_GetHasPhone

function TnsAdminInfo.pm_GetPhone: Il3CString;
var
 l_Phone: IString;
begin
 if f_Phone = nil then
 begin
  Autorization.GetAdministratorPhone(l_Phone);
  try
   f_Phone := nsCStr(l_Phone);
  finally
   l_Phone := nil;
  end;//try..finally
 end;//if f_Phone = nil then
 Result := f_Phone;
end;//pm_GetPhone

procedure TnsAdminInfo.pm_SetEmail(const aValue: Il3CString);
begin
 if not l3Same(f_Email, aValue) then
 begin
  f_Email := aValue;
  Autorization.SetAdministratorEmail((*nsIStr(f_Email)*) nsIStr(MakeNotNullStr(f_Email)));
 end;//if not l3Same(f_Email, aValue) then
end;//pm_SetEmail

procedure TnsAdminInfo.pm_SetPhone(const aValue: Il3CString);
begin
 if not l3Same(f_Phone, aValue) then
 begin
  f_Phone := aValue;
  Autorization.SetAdministratorPhone((*nsIStr(f_Phone)*) nsIStr(MakeNotNullStr(f_Phone)));
 end;//if not l3Same(f_Phone, aValue) then
end;//pm_SetPhone

end.