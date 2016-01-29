unit nsVerifyValue;

(*-----------------------------------------------------------------------------
 Ќазвание:   nsVerifyValue
 јвтор:      ћорозов ћ.
 Ќазначение: ћодуль содержит реализации дл€ проверки введенных значений
 ¬ерси€:     $Id: nsVerifyValue.pas,v 1.4 2013/10/24 06:37:10 morozov Exp $
 »стори€:

 $Log: nsVerifyValue.pas,v $
 Revision 1.4  2013/10/24 06:37:10  morozov
 {RequestLink: 284165424}

 Revision 1.3  2013/10/23 11:45:16  morozov
 {RequestLink: 284165424}

 Revision 1.2  2010/09/10 11:29:30  lulin
 {RequestLink:197496539}.

 Revision 1.1  2010/09/10 10:29:12  lulin
 {RequestLink:197496539}.

 Revision 1.21  2009/07/31 17:29:55  lulin
 - убираем мусор.

 Revision 1.20  2009/04/22 12:05:09  lulin
 [$124453728]. ƒелаем проверку на то что ссылка находитс€ в домене √аранта.

 Revision 1.19  2009/02/10 19:03:55  lulin
 - <K>: 133891247. ¬ычищаем морально устаревший модуль.

 Revision 1.18  2009/02/09 19:17:25  lulin
 - <K>: 133891247. ¬ыдел€ем интерфейсы поиска.

 Revision 1.17  2008/10/24 16:48:36  lulin
 - чистка кода.

 Revision 1.16  2008/06/09 10:23:19  lulin
 - <CQ>: 29331.

 Revision 1.15  2007/08/14 19:31:50  lulin
 - оптимизируем очистку пам€ти.

 Revision 1.14  2007/04/05 13:42:47  lulin
 - избавл€емс€ от лишних преобразований строк.

 Revision 1.13  2007/03/06 09:30:56  lulin
 - cleanup.

 Revision 1.12  2007/03/06 09:09:18  lulin
 - bug fix: нельз€ было ввести пустой пароль.

 Revision 1.11  2007/02/13 14:33:26  lulin
 - cleanup.

 Revision 1.10  2007/02/08 13:55:40  lulin
 - bug fix: падали с Assert при проверке информации о пользователе (CQ OIT5-24388).

 Revision 1.9  2007/02/07 14:30:45  lulin
 - переводим на строки с кодировкой.

 Revision 1.8  2007/02/07 12:45:08  lulin
 - переводим на строки с кодировкой.

 Revision 1.7  2006/04/17 14:42:36  oman
 - new beh: перекладываем StdStr в _StdRes

 Revision 1.6  2006/03/16 11:36:07  oman
 - new beh: ѕерекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)

 Revision 1.5  2005/10/11 12:49:43  lulin
 - модуль регул€рных выражений переехал в правильную библиотеку.

 Revision 1.4  2005/08/19 08:54:33  mmorozov
 change: поправлена логика дл€ верификации почтового адреса;

 Revision 1.3  2005/05/12 11:30:24  mmorozov
 bugfix: при вводе парол€ не контролировалс€ символ пробела;

 Revision 1.2  2005/04/06 08:10:40  mmorozov
 change: пробел €вл€етс€ не допустимым символом в логине пользовател€;

 Revision 1.1  2005/03/24 13:40:43  mmorozov
 new: модуль описывающий реализации InsVerifyValue дл€ проверки правильности введенных значений;

-----------------------------------------------------------------------------*)

interface

uses
  l3Interfaces
  ;

type
  TnsVerifyValueResult = (vvrNone, vvrNormal, vvrInvalidTooLong, vvrInvalidTooShort,
   vvrInvalidHasWrongChars, vvrInvalidNotMatchPattern);

  InsVerifyValue = interface(IUnknown)
   {* - провер€ет правильность значени€. }
    ['{5B2E33BA-C96C-4F3C-9004-31EAD4AA03AD}']
    // private methods
      function  pm_GetErrorMessage : Il3CString;
      procedure pm_SetErrorMessage(const aValue : Il3CString);
      function pm_GetVerifyResult: TnsVerifyValueResult;
      procedure pm_SetVerifyResult(aValue: TnsVerifyValueResult);
        {-}
    // public methods
      function Verify(const aValue : Il3CString) : Boolean;
        overload;
        {-}
    // public properties
      property ErrorMessage : Il3CString
        read pm_GetErrorMessage
        write pm_SetErrorMessage;
        {* - сообщение об ошибке. }
      property VerifyResult: TnsVerifyValueResult
        read pm_GetVerifyResult
        write pm_SetVerifyResult;
  end;//InsVerifyValue

function nsEmailVerify : InsVerifyValue;
  {* - стратеги€ дл€ проверки email адреса. }
function nsLoginVerify : InsVerifyValue;
  {* - проверить логин. }
function nsPasswordVerify : InsVerifyValue;
  {* - проверить пароль. }

implementation

uses
  SysUtils,

  l3Chars,
  l3RegEx,
  l3String,
  l3Base,

  vcmBase,

  nsTypes,
  
  StdRes
  ;

////////////////////////////////////////////////////////////////////////////////
const
  cEmailRegExp = '^[A-Za-z0-9-_]+(\.[A-Za-z0-9-_]+)*@[A-Za-z0-9-_]+' +
   '(\.[A-Za-z0-9-_]+)*\.[a-zA-Z][a-zA-Z]+$';
   {* - регул€рное выражение дл€ проверки email адреса. }
const
  cValidLoginChars = cc_AllChars - [#0..#31];
  cValidPasswordChars = cc_AllChars - [#0..#31];
////////////////////////////////////////////////////////////////////////////////

type
 TnsVerifyValue = class;

 TnsVerifyValueClass = class of TnsVerifyValue;

 TnsVerifyValue = class(TvcmBase, InsVerifyValue)
 {* - введен дл€ общности стратегий проверки. }
 private
 // property fields
   fErrorMessage : Il3CString;
   fVerifyResult : TnsVerifyValueResult;
 private
 // InsVerifyValue
    function  pm_GetErrorMessage : Il3CString;
    procedure pm_SetErrorMessage(const aValue : Il3CString);
    function pm_GetVerifyResult: TnsVerifyValueResult;
    procedure pm_SetVerifyResult(aValue: TnsVerifyValueResult);
      {-}
 protected
 // protected methods
   procedure BeforeVerify;
     {-}
   procedure Cleanup;
     override;
     {-}
 public
 // InsVerifyValue
   function Verify(const aValue : Il3CString) : Boolean;
     overload;
     virtual;
     {-}
 public
 // public methods
   constructor Create;
     reintroduce;
     virtual;
     {-}
 public
 // public properties
   property ErrorMessage : Il3CString
     read pm_GetErrorMessage
     write pm_SetErrorMessage;
     {* - сообщение об ошибке. }
   property VerifyResult : TnsVerifyValueResult
     read pm_GetVerifyResult
     write pm_SetVerifyResult;
     {* - результат верификации. }
 end;//TnsVerifyValue

 TnsEmailVerify = class(TnsVerifyValue)
 {* - дл€ проверки email адреса. }
 public
 // public methods
   class function Make : InsVerifyValue;
     {-}
   function Verify(const aValue : Il3CString) : Boolean;
     override;
     {-}
 end;//TnsEmailVerify

 TnsLoginVerify = class(TnsVerifyValue)
 {* - дл€ проверки email адреса. }
 public
 // public methods
   class function Make : InsVerifyValue;
     {-}
   function Verify(const aValue : Il3CString) : Boolean;
     override;
     {-}
 end;//TnsLoginVerify

 TnsPasswordVerify = class(TnsVerifyValue)
 {* - дл€ проверки email адреса. }
 public
 // public methods
   class function Make : InsVerifyValue;
     {-}
   function Verify(const aValue : Il3CString) : Boolean;
     override;
     {-}
 end;//TnsPasswordVerify

{ TnsVerifyValue }

procedure TnsVerifyValue.BeforeVerify;
begin
 fErrorMessage := nil;
 fVerifyResult := vvrNone;
end;

function TnsVerifyValue.Verify(const aValue : Il3CString) : Boolean;
// overload;
// virtual;
{-}
begin
 BeforeVerify;
 Result := True;
end;

constructor TnsVerifyValue.Create;
// reintroduce;
// virtual;
{-}
begin
 inherited Create;
end;

procedure TnsVerifyValue.Cleanup;
  //override;
  {-}
begin
 fErrorMessage := nil;
 inherited;
end;

function TnsVerifyValue.pm_GetErrorMessage: Il3CString;
begin
 Result := fErrorMessage;
end;

procedure TnsVerifyValue.pm_SetErrorMessage(const aValue: Il3CString);
begin
 fErrorMessage := aValue;
end;

function TnsVerifyValue.pm_GetVerifyResult: TnsVerifyValueResult;
begin
 Result := fVerifyResult;
end;

procedure TnsVerifyValue.pm_SetVerifyResult(aValue: TnsVerifyValueResult);
begin
 fVerifyResult := aValue;
end;

{ TnsEmailVerify }

class function TnsEmailVerify.Make : InsVerifyValue;
{-}
var
 lTemp : TnsEmailVerify;
begin
 lTemp := Create;
 try
  Result := lTemp;
 finally
  vcmFree(lTemp);
 end;//try..finally
end;

function TnsEmailVerify.Verify(const aValue : Il3CString) : Boolean;
// override;
{-}
begin
 Result := inherited Verify(aValue);
 if Result and (not l3IsNil(aValue)) then
 begin
  Result := l3CheckStrByPattern(cEmailRegExp, l3PCharLen(aValue));
  if not Result then
   ErrorMessage := vcmFmt(str_FtEmailError, [aValue]);
 end;//Result
end;

var
 g_EmailVerify    : InsVerifyValue = nil;
 g_LoginVerify    : InsVerifyValue = nil;
 g_PasswordVerify : InsVerifyValue = nil;

function nsEmailVerify : InsVerifyValue;
  {* - стратеги€ дл€ проверки email адреса. }
begin
 if not Assigned(g_EmailVerify) then
  g_EmailVerify := TnsEmailVerify.Make;
 Result := g_EmailVerify;
end;

function nsLoginVerify : InsVerifyValue;
  {* - проверить логин. }
begin
 if not Assigned(g_LoginVerify) then
  g_LoginVerify := TnsLoginVerify.Make;
 Result := g_LoginVerify;
end;

function nsPasswordVerify : InsVerifyValue;
  {* - проверить пароль. }
begin
 if not Assigned(g_PasswordVerify) then
  g_PasswordVerify := TnsPasswordVerify.Make;
 Result := g_PasswordVerify;
end;

{ TnsLoginVerify }

class function TnsLoginVerify.Make: InsVerifyValue;
var
 lTemp : TnsLoginVerify;
begin
 lTemp := Create;
 try
  Result := lTemp;
 finally
  vcmFree(lTemp);
 end;//try..finally
end;

function TnsLoginVerify.Verify(const aValue: Il3CString): Boolean;
// override;
begin
 Result := inherited Verify(aValue);
 if Result then
 begin
  if (l3Len(aValue) > 31) then
   VerifyResult := vvrInvalidTooLong
  else
  if (l3Len(aValue) < 1) then
   VerifyResult := vvrInvalidTooShort
  else
  begin
   if (not l3AllCharsInCharSet(aValue, cValidLoginChars)) then
    VerifyResult := vvrInvalidHasWrongChars
   else
    VerifyResult := vvrNormal;
  end;
  Result := VerifyResult = vvrNormal;
  if not Result then
   ErrorMessage := vcmFmt(str_FtLoginError, [aValue]);
 end;//Result
end;

{ TnsPasswordVerify }

class function TnsPasswordVerify.Make: InsVerifyValue;
var
 lTemp : TnsPasswordVerify;
begin
 lTemp := Create;
 try
  Result := lTemp;
 finally
  vcmFree(lTemp);
 end;//try..finally
end;

function TnsPasswordVerify.Verify(const aValue: Il3CString): Boolean;
// override;
begin
 Result := inherited Verify(aValue);
 if Result then
 begin
  Result := l3IsNil(aValue) OR l3AllCharsInCharSet(aValue, cValidPasswordChars);
  if not Result then
   fErrorMessage := vcmCStr(str_PasswordError);
 end;//Result
end;

initialization

finalization
 g_EmailVerify    := nil;
 g_LoginVerify    := nil;
 g_PasswordVerify := nil;

end.
