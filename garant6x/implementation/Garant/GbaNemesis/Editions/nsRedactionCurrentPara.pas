unit nsRedactionCurrentPara;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/nsRedactionCurrentPara.pas"
// Начат: 10.08.2009 14:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::CommonObjects::TnsRedactionCurrentPara
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  eeInterfaces,
  l3ProtoObject,
  EditionsInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsRedactionCurrentPara = class(Tl3ProtoObject)
 private
 // private fields
   f_Para : IeeLeafPara;
    {* Параграф для синхронизации}
 protected
 // realized methods
   function Get_RedactionCurrentPara: IeeLeafPara;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aPara: IeeLeafPara); reintroduce;
 end;//TnsRedactionCurrentPara
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsRedactionCurrentPara

constructor TnsRedactionCurrentPara.Create(const aPara: IeeLeafPara);
//#UC START# *4B5853E10268_4A7FF2C901C8_var*
//#UC END# *4B5853E10268_4A7FF2C901C8_var*
begin
//#UC START# *4B5853E10268_4A7FF2C901C8_impl*
 inherited Create;
 f_Para := aPara;
//#UC END# *4B5853E10268_4A7FF2C901C8_impl*
end;//TnsRedactionCurrentPara.Create

function TnsRedactionCurrentPara.Get_RedactionCurrentPara: IeeLeafPara;
//#UC START# *4A7FF1AC035C_4A7FF2C901C8get_var*
//#UC END# *4A7FF1AC035C_4A7FF2C901C8get_var*
begin
//#UC START# *4A7FF1AC035C_4A7FF2C901C8get_impl*
 Result := f_Para;
//#UC END# *4A7FF1AC035C_4A7FF2C901C8get_impl*
end;//TnsRedactionCurrentPara.Get_RedactionCurrentPara

procedure TnsRedactionCurrentPara.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Para := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsRedactionCurrentPara.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.