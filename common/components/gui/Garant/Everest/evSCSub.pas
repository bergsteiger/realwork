unit evSCSub;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evSCSub.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::SubCompare::TevSCSub
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3ProtoObject,
  evSubCompareInterfaces,
  evSCSubAttrList
  ;

type
 TevSCSub = class(Tl3ProtoObject, IevSCSub)
 private
 // private fields
   f_AttrList : TevSCSubAttrList;
   f_ID : Integer;
   f_SubType : TevSCSubType;
 protected
 // realized methods
   function Get_Handle: Integer;
   procedure Set_Handle(aValue: Integer);
   function Get_AttrCount: Integer;
   function Get_Attr(aIdx: Integer): IevSCAttrElement;
   procedure Add(const aAttr: IevSCAttrElement);
   function Get_SubType: TevSCSubType;
   procedure Set_SubType(aValue: TevSCSubType);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aSubType: TevSCSubType); reintroduce;
   class function Make(aSubType: TevSCSubType): IevSCSub; reintroduce;
     {* Сигнатура фабрики TevSCSub.Make }
 end;//TevSCSub

implementation

uses
  SysUtils,
  l3Types
  ;

// start class TevSCSub

constructor TevSCSub.Create(aSubType: TevSCSubType);
//#UC START# *56559EBB00B3_56558EAC00D3_var*
//#UC END# *56559EBB00B3_56558EAC00D3_var*
begin
//#UC START# *56559EBB00B3_56558EAC00D3_impl*
 inherited Create;
 f_AttrList := TevSCSubAttrList.MakeSorted(l3_dupAccept);
 f_SubType := aSubType;
//#UC END# *56559EBB00B3_56558EAC00D3_impl*
end;//TevSCSub.Create

class function TevSCSub.Make(aSubType: TevSCSubType): IevSCSub;
var
 l_Inst : TevSCSub;
begin
 l_Inst := Create(aSubType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TevSCSub.Get_Handle: Integer;
//#UC START# *5655859F00A0_56558EAC00D3get_var*
//#UC END# *5655859F00A0_56558EAC00D3get_var*
begin
//#UC START# *5655859F00A0_56558EAC00D3get_impl*
 Result := f_ID;
//#UC END# *5655859F00A0_56558EAC00D3get_impl*
end;//TevSCSub.Get_Handle

procedure TevSCSub.Set_Handle(aValue: Integer);
//#UC START# *5655859F00A0_56558EAC00D3set_var*
//#UC END# *5655859F00A0_56558EAC00D3set_var*
begin
//#UC START# *5655859F00A0_56558EAC00D3set_impl*
 f_ID := aValue;
//#UC END# *5655859F00A0_56558EAC00D3set_impl*
end;//TevSCSub.Set_Handle

function TevSCSub.Get_AttrCount: Integer;
//#UC START# *565585AD02F0_56558EAC00D3get_var*
//#UC END# *565585AD02F0_56558EAC00D3get_var*
begin
//#UC START# *565585AD02F0_56558EAC00D3get_impl*
 Result := f_AttrList.Count;
//#UC END# *565585AD02F0_56558EAC00D3get_impl*
end;//TevSCSub.Get_AttrCount

function TevSCSub.Get_Attr(aIdx: Integer): IevSCAttrElement;
//#UC START# *5655864201F6_56558EAC00D3get_var*
//#UC END# *5655864201F6_56558EAC00D3get_var*
begin
//#UC START# *5655864201F6_56558EAC00D3get_impl*
 Result := f_AttrList.Items[aIdx];
//#UC END# *5655864201F6_56558EAC00D3get_impl*
end;//TevSCSub.Get_Attr

procedure TevSCSub.Add(const aAttr: IevSCAttrElement);
//#UC START# *565586C401C8_56558EAC00D3_var*
//#UC END# *565586C401C8_56558EAC00D3_var*
begin
//#UC START# *565586C401C8_56558EAC00D3_impl*
 f_AttrList.Add(aAttr);
//#UC END# *565586C401C8_56558EAC00D3_impl*
end;//TevSCSub.Add

function TevSCSub.Get_SubType: TevSCSubType;
//#UC START# *565F158700B1_56558EAC00D3get_var*
//#UC END# *565F158700B1_56558EAC00D3get_var*
begin
//#UC START# *565F158700B1_56558EAC00D3get_impl*
 Result := f_SubType;
//#UC END# *565F158700B1_56558EAC00D3get_impl*
end;//TevSCSub.Get_SubType

procedure TevSCSub.Set_SubType(aValue: TevSCSubType);
//#UC START# *565F158700B1_56558EAC00D3set_var*
//#UC END# *565F158700B1_56558EAC00D3set_var*
begin
//#UC START# *565F158700B1_56558EAC00D3set_impl*
 f_SubType := aValue;
//#UC END# *565F158700B1_56558EAC00D3set_impl*
end;//TevSCSub.Set_SubType

procedure TevSCSub.Cleanup;
//#UC START# *479731C50290_56558EAC00D3_var*
//#UC END# *479731C50290_56558EAC00D3_var*
begin
//#UC START# *479731C50290_56558EAC00D3_impl*
 FreeAndNil(f_AttrList);
 inherited;
//#UC END# *479731C50290_56558EAC00D3_impl*
end;//TevSCSub.Cleanup

end.