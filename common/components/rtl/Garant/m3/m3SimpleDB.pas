unit m3SimpleDB;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3$DB"
// Модуль: "w:/common/components/rtl/Garant/m3/m3SimpleDB.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3$DB::m3DB::Tm3SimpleDB
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3DBInterfaces,
  m3DB,
  m3StorageInterfaces
  ;

type
 Tm3SimpleDB = class(Tm3DB)
 public
 // overridden public methods
   function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage; override;
     {* Возвращает корень постоянной части }
   function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage; override;
     {* Возвращает корень переменной части }
   function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage; override;
     {* Возвращает корень резервной копии }
   function NeedsFork: Boolean; override;
   function NeedProxy: Boolean; override;
 public
 // public methods
   class function Make(const aBaseName: AnsiString): Im3DB;
 end;//Tm3SimpleDB

implementation

uses
  m3StorageService
  ;

// start class Tm3SimpleDB

class function Tm3SimpleDB.Make(const aBaseName: AnsiString): Im3DB;
//#UC START# *5540F2810201_4742CA7E00BE_var*
//#UC END# *5540F2810201_4742CA7E00BE_var*
begin
//#UC START# *5540F2810201_4742CA7E00BE_impl*
 Result := MakeExclusive(aBaseName);
//#UC END# *5540F2810201_4742CA7E00BE_impl*
end;//Tm3SimpleDB.Make

function Tm3SimpleDB.MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
//#UC START# *49BFD4CE0235_4742CA7E00BE_var*
//#UC END# *49BFD4CE0235_4742CA7E00BE_var*
begin
//#UC START# *49BFD4CE0235_4742CA7E00BE_impl*
 Result := nil;
//#UC END# *49BFD4CE0235_4742CA7E00BE_impl*
end;//Tm3SimpleDB.MainStorage

function Tm3SimpleDB.GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
//#UC START# *49BFD4F3013E_4742CA7E00BE_var*
var
 l_US : Boolean;
//#UC END# *49BFD4F3013E_4742CA7E00BE_var*
begin
//#UC START# *49BFD4F3013E_4742CA7E00BE_impl*
 if NeedCreateVersionsStorage(aMode) then
 begin
  l_US := Tm3StorageService.Instance.SetUseSplitted(false);;
  try
   Result := inherited GetVersionsStorage(aMode);
  finally
   Tm3StorageService.Instance.SetUseSplitted(l_US);
  end;//try..finally
 end//NeedCreateVersionsStorage(aMode)
 else
  Result := inherited GetVersionsStorage(aMode);
//#UC END# *49BFD4F3013E_4742CA7E00BE_impl*
end;//Tm3SimpleDB.GetVersionsStorage

function Tm3SimpleDB.GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
//#UC START# *49BFD52D0076_4742CA7E00BE_var*
//#UC END# *49BFD52D0076_4742CA7E00BE_var*
begin
//#UC START# *49BFD52D0076_4742CA7E00BE_impl*
 Result := nil;
//#UC END# *49BFD52D0076_4742CA7E00BE_impl*
end;//Tm3SimpleDB.GetBackupStorage

function Tm3SimpleDB.NeedsFork: Boolean;
//#UC START# *5540ECC800D2_4742CA7E00BE_var*
//#UC END# *5540ECC800D2_4742CA7E00BE_var*
begin
//#UC START# *5540ECC800D2_4742CA7E00BE_impl*
 Result := false;
//#UC END# *5540ECC800D2_4742CA7E00BE_impl*
end;//Tm3SimpleDB.NeedsFork

function Tm3SimpleDB.NeedProxy: Boolean;
//#UC START# *5551EC2101DB_4742CA7E00BE_var*
//#UC END# *5551EC2101DB_4742CA7E00BE_var*
begin
//#UC START# *5551EC2101DB_4742CA7E00BE_impl*
 Result := true;
//#UC END# *5551EC2101DB_4742CA7E00BE_impl*
end;//Tm3SimpleDB.NeedProxy

end.