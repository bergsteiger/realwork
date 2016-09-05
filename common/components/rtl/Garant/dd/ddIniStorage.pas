unit ddIniStorage;

// Модуль: "w:\common\components\rtl\Garant\dd\ddIniStorage.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddIniStorage" MUID: (5214AF4C01AF)

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddCustomIniStorage
 , IniFiles
 , ddConfigStorages
;

type
 TddIniStorage = class(TddCustomIniStorage)
  private
   f_RealIni: TIniFile;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFileName: AnsiString); reintroduce;
   class function Make(const aFileName: AnsiString): IddConfigStorage; reintroduce;
 end;//TddIniStorage
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *5214AF4C01AFimpl_uses*
 //#UC END# *5214AF4C01AFimpl_uses*
;

constructor TddIniStorage.Create(const aFileName: AnsiString);
//#UC START# *57A084C801B6_5214AF4C01AF_var*
//#UC END# *57A084C801B6_5214AF4C01AF_var*
begin
//#UC START# *57A084C801B6_5214AF4C01AF_impl*
 f_RealIni := TIniFile.Create(aFileName);
 inherited Create(f_RealIni);
//#UC END# *57A084C801B6_5214AF4C01AF_impl*
end;//TddIniStorage.Create

class function TddIniStorage.Make(const aFileName: AnsiString): IddConfigStorage;
var
 l_Inst : TddIniStorage;
begin
 l_Inst := Create(aFileName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TddIniStorage.Make

procedure TddIniStorage.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5214AF4C01AF_var*
//#UC END# *479731C50290_5214AF4C01AF_var*
begin
//#UC START# *479731C50290_5214AF4C01AF_impl*
 FreeAndNil(f_RealIni);
 inherited;
//#UC END# *479731C50290_5214AF4C01AF_impl*
end;//TddIniStorage.Cleanup
{$IfEnd} // NOT Defined(Nemesis)

end.
