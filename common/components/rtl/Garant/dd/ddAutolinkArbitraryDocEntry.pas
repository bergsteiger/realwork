unit ddAutolinkArbitraryDocEntry;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddAutolinkArbitraryDocEntry.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::Autolink::TddAutolinkArbitraryDocEntry
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3LongintList,
  dt_Types,
  l3ProtoObject,
  ddAutolinkInterfaces
  ;

type
 TddAutolinkArbitraryDocEntry = class(Tl3ProtoObject, IddAutolinkArbitraryDocEntry)
 private
 // private fields
   f_DocID : TDocID;
   f_TypesList : Tl3LongintList;
 protected
 // realized methods
   function Get_DocID: TDocID;
   function Get_TypesList: Tl3LongintList;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aDocID: TDocID;
     aTypesList: Tl3LongintList); reintroduce;
   class function Make(aDocID: TDocID;
     aTypesList: Tl3LongintList): IddAutolinkArbitraryDocEntry; reintroduce;
     {* Сигнатура фабрики TddAutolinkArbitraryDocEntry.Make }
 end;//TddAutolinkArbitraryDocEntry

implementation

uses
  SysUtils
  ;

// start class TddAutolinkArbitraryDocEntry

constructor TddAutolinkArbitraryDocEntry.Create(aDocID: TDocID;
  aTypesList: Tl3LongintList);
//#UC START# *51F269D40190_51F258B701B2_var*
//#UC END# *51F269D40190_51F258B701B2_var*
begin
//#UC START# *51F269D40190_51F258B701B2_impl*
 inherited Create;
 f_DocID := aDocID;
 if aTypesList <> nil then
  f_TypesList := aTypesList.Use;
//#UC END# *51F269D40190_51F258B701B2_impl*
end;//TddAutolinkArbitraryDocEntry.Create

class function TddAutolinkArbitraryDocEntry.Make(aDocID: TDocID;
  aTypesList: Tl3LongintList): IddAutolinkArbitraryDocEntry;
var
 l_Inst : TddAutolinkArbitraryDocEntry;
begin
 l_Inst := Create(aDocID, aTypesList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TddAutolinkArbitraryDocEntry.Get_DocID: TDocID;
//#UC START# *51F2529E003F_51F258B701B2get_var*
//#UC END# *51F2529E003F_51F258B701B2get_var*
begin
//#UC START# *51F2529E003F_51F258B701B2get_impl*
 Result := f_DocID;
//#UC END# *51F2529E003F_51F258B701B2get_impl*
end;//TddAutolinkArbitraryDocEntry.Get_DocID

function TddAutolinkArbitraryDocEntry.Get_TypesList: Tl3LongintList;
//#UC START# *51F252E8038B_51F258B701B2get_var*
//#UC END# *51F252E8038B_51F258B701B2get_var*
begin
//#UC START# *51F252E8038B_51F258B701B2get_impl*
 Result := f_TypesList;
//#UC END# *51F252E8038B_51F258B701B2get_impl*
end;//TddAutolinkArbitraryDocEntry.Get_TypesList

procedure TddAutolinkArbitraryDocEntry.Cleanup;
//#UC START# *479731C50290_51F258B701B2_var*
//#UC END# *479731C50290_51F258B701B2_var*
begin
//#UC START# *479731C50290_51F258B701B2_impl*
 FreeAndNil(f_TypesList);
 inherited;
//#UC END# *479731C50290_51F258B701B2_impl*
end;//TddAutolinkArbitraryDocEntry.Cleanup

end.