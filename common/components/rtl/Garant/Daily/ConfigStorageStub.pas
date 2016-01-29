unit ConfigStorageStub;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ConfigStorageStub.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Tests::DailyTest::AppConfigUtils::TConfigStorageStub
//
// Заглушка для эмуляции чтения настроек.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3ProtoObject,
  ddConfigStorages,
  l3Interfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TConfigStorageStub = class(Tl3ProtoObject, IddConfigStorage)
  {* Заглушка для эмуляции чтения настроек. }
 protected
 // realized methods
   function ReadBool(const Alias: AnsiString;
    Default: Boolean): Boolean; stdcall;
   function ReadDateTime(const Alias: AnsiString;
    Default: TDateTime): TDateTime; stdcall;
   function ReadInteger(const Alias: AnsiString;
    Default: Integer): Integer; stdcall;
   function ReadString(const Alias: AnsiString;
    const Default: AnsiString): Il3CString; stdcall;
   procedure WriteBool(const Alias: AnsiString;
    B: Boolean); stdcall;
   procedure WriteDateTime(const Alias: AnsiString;
    DT: TDateTime); stdcall;
   procedure WriteInteger(const Alias: AnsiString;
    I: Integer); stdcall;
   procedure WriteString(const Alias: AnsiString;
    const S: AnsiString); stdcall;
   function Get_Section: AnsiString; stdcall;
   procedure Set_Section(const aValue: AnsiString); stdcall;
 public
 // public methods
   class function Make: IddConfigStorage;
 end;//TConfigStorageStub
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TConfigStorageStub

class function TConfigStorageStub.Make: IddConfigStorage;
//#UC START# *51D55B7D0119_51D54BCD02DA_var*
var
 l_Config: TConfigStorageStub;
//#UC END# *51D55B7D0119_51D54BCD02DA_var*
begin
//#UC START# *51D55B7D0119_51D54BCD02DA_impl*
 l_Config := TConfigStorageStub.Create;
 try
  Result := l_Config;
 finally
  l3Free(l_Config);
 end;
//#UC END# *51D55B7D0119_51D54BCD02DA_impl*
end;//TConfigStorageStub.Make

function TConfigStorageStub.ReadBool(const Alias: AnsiString;
  Default: Boolean): Boolean;
//#UC START# *51D51983016F_51D54BCD02DA_var*
//#UC END# *51D51983016F_51D54BCD02DA_var*
begin
//#UC START# *51D51983016F_51D54BCD02DA_impl*
 Result := True;
//#UC END# *51D51983016F_51D54BCD02DA_impl*
end;//TConfigStorageStub.ReadBool

function TConfigStorageStub.ReadDateTime(const Alias: AnsiString;
  Default: TDateTime): TDateTime;
//#UC START# *51D519A40189_51D54BCD02DA_var*
//#UC END# *51D519A40189_51D54BCD02DA_var*
begin
//#UC START# *51D519A40189_51D54BCD02DA_impl*
 Result := 1;
//#UC END# *51D519A40189_51D54BCD02DA_impl*
end;//TConfigStorageStub.ReadDateTime

function TConfigStorageStub.ReadInteger(const Alias: AnsiString;
  Default: Integer): Integer;
//#UC START# *51D519B403D0_51D54BCD02DA_var*
//#UC END# *51D519B403D0_51D54BCD02DA_var*
begin
//#UC START# *51D519B403D0_51D54BCD02DA_impl*
 Result := 1;
//#UC END# *51D519B403D0_51D54BCD02DA_impl*
end;//TConfigStorageStub.ReadInteger

function TConfigStorageStub.ReadString(const Alias: AnsiString;
  const Default: AnsiString): Il3CString;
//#UC START# *51D519D00291_51D54BCD02DA_var*
//#UC END# *51D519D00291_51D54BCD02DA_var*
begin
//#UC START# *51D519D00291_51D54BCD02DA_impl*
  Result := l3CStr('Test');
//#UC END# *51D519D00291_51D54BCD02DA_impl*
end;//TConfigStorageStub.ReadString

procedure TConfigStorageStub.WriteBool(const Alias: AnsiString;
  B: Boolean);
//#UC START# *51D519FC00D5_51D54BCD02DA_var*
//#UC END# *51D519FC00D5_51D54BCD02DA_var*
begin
//#UC START# *51D519FC00D5_51D54BCD02DA_impl*

//#UC END# *51D519FC00D5_51D54BCD02DA_impl*
end;//TConfigStorageStub.WriteBool

procedure TConfigStorageStub.WriteDateTime(const Alias: AnsiString;
  DT: TDateTime);
//#UC START# *51D51A0D0133_51D54BCD02DA_var*
//#UC END# *51D51A0D0133_51D54BCD02DA_var*
begin
//#UC START# *51D51A0D0133_51D54BCD02DA_impl*

//#UC END# *51D51A0D0133_51D54BCD02DA_impl*
end;//TConfigStorageStub.WriteDateTime

procedure TConfigStorageStub.WriteInteger(const Alias: AnsiString;
  I: Integer);
//#UC START# *51D51A1E025E_51D54BCD02DA_var*
//#UC END# *51D51A1E025E_51D54BCD02DA_var*
begin
//#UC START# *51D51A1E025E_51D54BCD02DA_impl*

//#UC END# *51D51A1E025E_51D54BCD02DA_impl*
end;//TConfigStorageStub.WriteInteger

procedure TConfigStorageStub.WriteString(const Alias: AnsiString;
  const S: AnsiString);
//#UC START# *51D51A3201BA_51D54BCD02DA_var*
//#UC END# *51D51A3201BA_51D54BCD02DA_var*
begin
//#UC START# *51D51A3201BA_51D54BCD02DA_impl*

//#UC END# *51D51A3201BA_51D54BCD02DA_impl*
end;//TConfigStorageStub.WriteString

function TConfigStorageStub.Get_Section: AnsiString;
//#UC START# *51D51A48025D_51D54BCD02DAget_var*
//#UC END# *51D51A48025D_51D54BCD02DAget_var*
begin
//#UC START# *51D51A48025D_51D54BCD02DAget_impl*
 Result := '';
//#UC END# *51D51A48025D_51D54BCD02DAget_impl*
end;//TConfigStorageStub.Get_Section

procedure TConfigStorageStub.Set_Section(const aValue: AnsiString);
//#UC START# *51D51A48025D_51D54BCD02DAset_var*
//#UC END# *51D51A48025D_51D54BCD02DAset_var*
begin
//#UC START# *51D51A48025D_51D54BCD02DAset_impl*

//#UC END# *51D51A48025D_51D54BCD02DAset_impl*
end;//TConfigStorageStub.Set_Section

{$IfEnd} //nsTest AND not NoScripts

end.