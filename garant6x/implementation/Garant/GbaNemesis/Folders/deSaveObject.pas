unit deSaveObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Folders"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Folders/deSaveObject.pas"
// Начат: 09.12.2009 12:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Основные прецеденты::Folders::Folders::Folders::TdeSaveObject
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
  FoldersDomainInterfaces,
  l3ProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeSaveObject = class(Tl3ProtoObject, IdeSaveObject)
 private
 // private fields
   f_ObjectType : TFoldersElementType;
   f_ObjectValue : IUnknown;
 protected
 // realized methods
   function pm_GetObjectType: TFoldersElementType;
   function pm_GetObjectValue: IUnknown;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(aType: TFoldersElementType;
     const anObject: IUnknown); reintroduce;
   class function Make(aType: TFoldersElementType = fetNone;
     const anObject: IUnknown = nil): IdeSaveObject; reintroduce;
 end;//TdeSaveObject
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeSaveObject

constructor TdeSaveObject.Create(aType: TFoldersElementType;
  const anObject: IUnknown);
//#UC START# *4B1F6E830244_4921953602C1_var*
//#UC END# *4B1F6E830244_4921953602C1_var*
begin
//#UC START# *4B1F6E830244_4921953602C1_impl*
 inherited Create;
 f_ObjectType := aType;
 f_ObjectValue := anObject;
//#UC END# *4B1F6E830244_4921953602C1_impl*
end;//TdeSaveObject.Create

class function TdeSaveObject.Make(aType: TFoldersElementType = fetNone;
  const anObject: IUnknown = nil): IdeSaveObject;
var
 l_Inst : TdeSaveObject;
begin
 l_Inst := Create(aType, anObject);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdeSaveObject.pm_GetObjectType: TFoldersElementType;
//#UC START# *4B1D0A0503A5_4921953602C1get_var*
//#UC END# *4B1D0A0503A5_4921953602C1get_var*
begin
//#UC START# *4B1D0A0503A5_4921953602C1get_impl*
 Result := f_ObjectType;
//#UC END# *4B1D0A0503A5_4921953602C1get_impl*
end;//TdeSaveObject.pm_GetObjectType

function TdeSaveObject.pm_GetObjectValue: IUnknown;
//#UC START# *4B1D0A35011E_4921953602C1get_var*
//#UC END# *4B1D0A35011E_4921953602C1get_var*
begin
//#UC START# *4B1D0A35011E_4921953602C1get_impl*
 Result := f_ObjectValue;
//#UC END# *4B1D0A35011E_4921953602C1get_impl*
end;//TdeSaveObject.pm_GetObjectValue

procedure TdeSaveObject.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ObjectValue := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdeSaveObject.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.