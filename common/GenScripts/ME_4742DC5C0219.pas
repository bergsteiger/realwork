unit m3BaseObject;
 {* Базовая реализация объекта хранилища. }

// Модуль: "w:\common\components\rtl\Garant\m3\m3BaseObject.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3DBInterfaces
 , m3PrimDB
;

type
 Tm3BaseObject = {abstract} class(Tl3CProtoObject, Im3DBObject)
  {* Базовая реализация объекта хранилища. }
  private
   f_f_DB: Tm3PrimDB;
    {* Поле для свойства f_DB }
  protected
   function DB: Im3DB;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aDB: Tm3PrimDB); reintroduce;
  protected
   property f_DB: Tm3PrimDB
    read f_f_DB;
 end;//Tm3BaseObject

implementation

uses
 l3ImplUses
 , SysUtils
;

constructor Tm3BaseObject.Create(aDB: Tm3PrimDB);
//#UC START# *555B269800C2_4742DC5C0219_var*
//#UC END# *555B269800C2_4742DC5C0219_var*
begin
//#UC START# *555B269800C2_4742DC5C0219_impl*
 inherited Create;
 aDB.SetRefTo(f_f_DB);
//#UC END# *555B269800C2_4742DC5C0219_impl*
end;//Tm3BaseObject.Create

function Tm3BaseObject.DB: Im3DB;
//#UC START# *4720847C026F_4742DC5C0219_var*
//#UC END# *4720847C026F_4742DC5C0219_var*
begin
//#UC START# *4720847C026F_4742DC5C0219_impl*
 Result := f_DB.AsDB;
//#UC END# *4720847C026F_4742DC5C0219_impl*
end;//Tm3BaseObject.DB

procedure Tm3BaseObject.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4742DC5C0219_var*
//#UC END# *479731C50290_4742DC5C0219_var*
begin
//#UC START# *479731C50290_4742DC5C0219_impl*
 FreeAndNil(f_f_DB);
 inherited;
//#UC END# *479731C50290_4742DC5C0219_impl*
end;//Tm3BaseObject.Cleanup

end.
