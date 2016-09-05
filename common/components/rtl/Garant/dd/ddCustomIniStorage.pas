unit ddCustomIniStorage;
 {* Базовый класс.
Ini-файлом НЕ владеет. Надо убивать его снаружи. }

// Модуль: "w:\common\components\rtl\Garant\dd\ddCustomIniStorage.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddCustomIniStorage" MUID: (57A07B6903C1)

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddConfigStorages
 , IniFiles
 , l3Interfaces
;

type
 TddCustomIniStorage = class(Tl3ProtoObject, IddConfigStorage)
  {* Базовый класс.
Ini-файлом НЕ владеет. Надо убивать его снаружи. }
  private
   f_Section: AnsiString;
   f_Ini: TCustomIniFile;
  protected
   function ReadBool(const Alias: AnsiString;
    Default: Boolean): Boolean;
   function ReadDateTime(const Alias: AnsiString;
    Default: TDateTime): TDateTime;
   function ReadInteger(const Alias: AnsiString;
    Default: Integer): Integer;
   function ReadString(const Alias: AnsiString;
    const Default: AnsiString): Il3CString;
   procedure WriteBool(const Alias: AnsiString;
    B: Boolean);
   procedure WriteDateTime(const Alias: AnsiString;
    DT: TDateTime);
   procedure WriteInteger(const Alias: AnsiString;
    I: Integer);
   procedure WriteString(const Alias: AnsiString;
    const S: AnsiString);
   function Get_Section: AnsiString;
   procedure Set_Section(const aValue: AnsiString);
  public
   constructor Create(aIniFile: TCustomIniFile); reintroduce;
  protected
   property Ini: TCustomIniFile
    read f_Ini;
 end;//TddCustomIniStorage

implementation

uses
 l3ImplUses
 , l3Base
 //#UC START# *57A07B6903C1impl_uses*
 //#UC END# *57A07B6903C1impl_uses*
;

constructor TddCustomIniStorage.Create(aIniFile: TCustomIniFile);
//#UC START# *57A07CAA01B1_57A07B6903C1_var*
//#UC END# *57A07CAA01B1_57A07B6903C1_var*
begin
//#UC START# *57A07CAA01B1_57A07B6903C1_impl*
 inherited Create;
 f_Ini := aIniFile;
//#UC END# *57A07CAA01B1_57A07B6903C1_impl*
end;//TddCustomIniStorage.Create

function TddCustomIniStorage.ReadBool(const Alias: AnsiString;
 Default: Boolean): Boolean;
//#UC START# *51D51983016F_57A07B6903C1_var*
//#UC END# *51D51983016F_57A07B6903C1_var*
begin
//#UC START# *51D51983016F_57A07B6903C1_impl*
 Result:= f_Ini.ReadBool(f_Section, Alias, Default);
//#UC END# *51D51983016F_57A07B6903C1_impl*
end;//TddCustomIniStorage.ReadBool

function TddCustomIniStorage.ReadDateTime(const Alias: AnsiString;
 Default: TDateTime): TDateTime;
//#UC START# *51D519A40189_57A07B6903C1_var*
//#UC END# *51D519A40189_57A07B6903C1_var*
begin
//#UC START# *51D519A40189_57A07B6903C1_impl*
 Result:= f_Ini.ReadDateTime(f_Section, Alias, Default);
//#UC END# *51D519A40189_57A07B6903C1_impl*
end;//TddCustomIniStorage.ReadDateTime

function TddCustomIniStorage.ReadInteger(const Alias: AnsiString;
 Default: Integer): Integer;
//#UC START# *51D519B403D0_57A07B6903C1_var*
//#UC END# *51D519B403D0_57A07B6903C1_var*
begin
//#UC START# *51D519B403D0_57A07B6903C1_impl*
 Result:= f_Ini.ReadInteger(f_Section, Alias, Default);
//#UC END# *51D519B403D0_57A07B6903C1_impl*
end;//TddCustomIniStorage.ReadInteger

function TddCustomIniStorage.ReadString(const Alias: AnsiString;
 const Default: AnsiString): Il3CString;
//#UC START# *51D519D00291_57A07B6903C1_var*
//#UC END# *51D519D00291_57A07B6903C1_var*
begin
//#UC START# *51D519D00291_57A07B6903C1_impl*
 Result:= l3CStr(f_Ini.ReadString(f_Section, Alias, Default));
//#UC END# *51D519D00291_57A07B6903C1_impl*
end;//TddCustomIniStorage.ReadString

procedure TddCustomIniStorage.WriteBool(const Alias: AnsiString;
 B: Boolean);
//#UC START# *51D519FC00D5_57A07B6903C1_var*
//#UC END# *51D519FC00D5_57A07B6903C1_var*
begin
//#UC START# *51D519FC00D5_57A07B6903C1_impl*
 f_Ini.WriteBool(f_Section, Alias, B);
//#UC END# *51D519FC00D5_57A07B6903C1_impl*
end;//TddCustomIniStorage.WriteBool

procedure TddCustomIniStorage.WriteDateTime(const Alias: AnsiString;
 DT: TDateTime);
//#UC START# *51D51A0D0133_57A07B6903C1_var*
//#UC END# *51D51A0D0133_57A07B6903C1_var*
begin
//#UC START# *51D51A0D0133_57A07B6903C1_impl*
 f_Ini.WriteDateTime(f_Section, Alias, DT);
//#UC END# *51D51A0D0133_57A07B6903C1_impl*
end;//TddCustomIniStorage.WriteDateTime

procedure TddCustomIniStorage.WriteInteger(const Alias: AnsiString;
 I: Integer);
//#UC START# *51D51A1E025E_57A07B6903C1_var*
//#UC END# *51D51A1E025E_57A07B6903C1_var*
begin
//#UC START# *51D51A1E025E_57A07B6903C1_impl*
 f_Ini.WriteInteger(f_Section, Alias, I);
//#UC END# *51D51A1E025E_57A07B6903C1_impl*
end;//TddCustomIniStorage.WriteInteger

procedure TddCustomIniStorage.WriteString(const Alias: AnsiString;
 const S: AnsiString);
//#UC START# *51D51A3201BA_57A07B6903C1_var*
//#UC END# *51D51A3201BA_57A07B6903C1_var*
begin
//#UC START# *51D51A3201BA_57A07B6903C1_impl*
 f_Ini.WriteString(f_Section, Alias, S);
//#UC END# *51D51A3201BA_57A07B6903C1_impl*
end;//TddCustomIniStorage.WriteString

function TddCustomIniStorage.Get_Section: AnsiString;
//#UC START# *51D51A48025D_57A07B6903C1get_var*
//#UC END# *51D51A48025D_57A07B6903C1get_var*
begin
//#UC START# *51D51A48025D_57A07B6903C1get_impl*
 Result:= f_Section;
//#UC END# *51D51A48025D_57A07B6903C1get_impl*
end;//TddCustomIniStorage.Get_Section

procedure TddCustomIniStorage.Set_Section(const aValue: AnsiString);
//#UC START# *51D51A48025D_57A07B6903C1set_var*
//#UC END# *51D51A48025D_57A07B6903C1set_var*
begin
//#UC START# *51D51A48025D_57A07B6903C1set_impl*
 if f_Section <> aValue then
  f_Section:= aValue;
//#UC END# *51D51A48025D_57A07B6903C1set_impl*
end;//TddCustomIniStorage.Set_Section

end.
