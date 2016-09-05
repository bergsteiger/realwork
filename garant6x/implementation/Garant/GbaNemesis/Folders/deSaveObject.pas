unit deSaveObject;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Folders\deSaveObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeSaveObject" MUID: (4921953602C1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , FoldersDomainInterfaces
;

type
 TdeSaveObject = class(Tl3ProtoObject, IdeSaveObject)
  private
   f_ObjectType: TFoldersElementType;
   f_ObjectValue: IUnknown;
  protected
   function pm_GetObjectType: TFoldersElementType;
   function pm_GetObjectValue: IUnknown;
   procedure ClearFields; override;
  public
   constructor Create(aType: TFoldersElementType;
    const anObject: IUnknown); reintroduce;
   class function Make(aType: TFoldersElementType = FoldersDomainInterfaces.fetNone;
    const anObject: IUnknown = nil): IdeSaveObject; reintroduce;
 end;//TdeSaveObject
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4921953602C1impl_uses*
 //#UC END# *4921953602C1impl_uses*
;

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

class function TdeSaveObject.Make(aType: TFoldersElementType = FoldersDomainInterfaces.fetNone;
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
end;//TdeSaveObject.Make

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
begin
 f_ObjectValue := nil;
 inherited;
end;//TdeSaveObject.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
