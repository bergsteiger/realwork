unit atControlStatusConverter;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atControlStatusConverter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatControlStatusConverter" MUID: (504F47A401F7)

interface

uses
 l3IntfUses
 , atStringToBitMaskConverterBase
;

type
 TatControlStatusConverter = class(TatStringToBitMaskConverterBase)
  protected
   procedure InitConvertMap; override;
  public
   class function Instance: TatControlStatusConverter;
    {* Метод получения экземпляра синглетона TatControlStatusConverter }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TatControlStatusConverter

implementation

uses
 l3ImplUses
 , UnderControlUnit
 , SysUtils
 , l3Base
 //#UC START# *504F47A401F7impl_uses*
 //#UC END# *504F47A401F7impl_uses*
;

var g_TatControlStatusConverter: TatControlStatusConverter = nil;
 {* Экземпляр синглетона TatControlStatusConverter }

procedure TatControlStatusConverterFree;
 {* Метод освобождения экземпляра синглетона TatControlStatusConverter }
begin
 l3Free(g_TatControlStatusConverter);
end;//TatControlStatusConverterFree

procedure TatControlStatusConverter.InitConvertMap;
//#UC START# *503E3A040395_504F47A401F7_var*
  const
    CONVERT_MAP : array [0..6] of atStringToBitMaskConverterBase.Synonyms = (
      (First : 'Документ удален' ; Second : CS_DELETED),
      (First : 'Документ вступил в действие' ; Second : CS_ACTIVE),
      (First : 'Документ изменен' ; Second : CS_CHANGED),
      (First : 'Документ утратил силу' ; Second : CS_ABOLISHED),
      (First : 'Документ зарегистрирован в Минюсте РФ' ; Second : CS_REGISTERED),
      (First : 'Документу отказано в регистрации в Минюсте РФ' ; Second : CS_NOT_REGISTERED),
      (First : 'Документ не изменился' ; Second : CS_NONE)
    );
//#UC END# *503E3A040395_504F47A401F7_var*
begin
//#UC START# *503E3A040395_504F47A401F7_impl*
  InitConvertMap(CONVERT_MAP);
//#UC END# *503E3A040395_504F47A401F7_impl*
end;//TatControlStatusConverter.InitConvertMap

class function TatControlStatusConverter.Instance: TatControlStatusConverter;
 {* Метод получения экземпляра синглетона TatControlStatusConverter }
begin
 if (g_TatControlStatusConverter = nil) then
 begin
  l3System.AddExitProc(TatControlStatusConverterFree);
  g_TatControlStatusConverter := Create;
 end;
 Result := g_TatControlStatusConverter;
end;//TatControlStatusConverter.Instance

class function TatControlStatusConverter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TatControlStatusConverter <> nil;
end;//TatControlStatusConverter.Exists

end.
