unit ddTemporaryStorage;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTemporaryStorage.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddTemporaryStorage" MUID: (57A08AEB0203)

interface

uses
 l3IntfUses
 , ddCustomIniStorage
 , IniFiles
 , ddConfigStorages
;

type
 TddTemporaryStorage = class(TddCustomIniStorage)
  private
   f_RealIni: TMemIniFile;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: IddConfigStorage; reintroduce;
 end;//TddTemporaryStorage

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *57A08AEB0203impl_uses*
 //#UC END# *57A08AEB0203impl_uses*
;

constructor TddTemporaryStorage.Create;
//#UC START# *57A08B4B02AC_57A08AEB0203_var*
//#UC END# *57A08B4B02AC_57A08AEB0203_var*
begin
//#UC START# *57A08B4B02AC_57A08AEB0203_impl*
 f_RealIni := TMemIniFile.Create('');
 inherited Create(f_RealIni);
//#UC END# *57A08B4B02AC_57A08AEB0203_impl*
end;//TddTemporaryStorage.Create

class function TddTemporaryStorage.Make: IddConfigStorage;
var
 l_Inst : TddTemporaryStorage;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TddTemporaryStorage.Make

procedure TddTemporaryStorage.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57A08AEB0203_var*
//#UC END# *479731C50290_57A08AEB0203_var*
begin
//#UC START# *479731C50290_57A08AEB0203_impl*
 FreeAndNil(f_RealIni);
 inherited;
//#UC END# *479731C50290_57A08AEB0203_impl*
end;//TddTemporaryStorage.Cleanup

end.
