unit vcmEntityDefForContextMenu;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntityDefForContextMenu.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3CProtoObject
 , vcmInterfaces
 , vcmExternalInterfaces
 , vcmUserControls
;

type
 TvcmEntityDefForContextMenu = class(Tl3CProtoObject, IvcmEntityDef)
  private
   f_En: IvcmEntityDef;
  protected
   function Get_Hint: IvcmCString;
   function Get_LongHint: IvcmCString;
   function Get_ImageIndex: Integer;
   function Get_ID: TvcmControlID;
   function Get_OperationsDefIterator: IvcmOperationsDefIterator;
   function Get_ToolbarPos: TvcmToolBarPos;
   function pm_GetOptions: TvcmEntityOperationsOptions;
   function Get_Caption: IvcmCString;
   function Get_Name: TvcmString;
   function Get_ContextMenuWeight: Integer;
   procedure ClearFields; override;
  public
   constructor Create(const anEn: IvcmEntityDef); reintroduce;
   class function Make(const anEn: IvcmEntityDef): IvcmEntityDef; reintroduce;
 end;//TvcmEntityDefForContextMenu
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmOperationsDefIteratorForContextMenu
;

constructor TvcmEntityDefForContextMenu.Create(const anEn: IvcmEntityDef);
//#UC START# *51D148D100C2_51D148890323_var*
//#UC END# *51D148D100C2_51D148890323_var*
begin
//#UC START# *51D148D100C2_51D148890323_impl*
 inherited Create;
 f_En := anEn;
//#UC END# *51D148D100C2_51D148890323_impl*
end;//TvcmEntityDefForContextMenu.Create

class function TvcmEntityDefForContextMenu.Make(const anEn: IvcmEntityDef): IvcmEntityDef;
var
 l_Inst : TvcmEntityDefForContextMenu;
begin
 l_Inst := Create(anEn);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmEntityDefForContextMenu.Make

function TvcmEntityDefForContextMenu.Get_Hint: IvcmCString;
//#UC START# *4995616701BB_51D148890323get_var*
//#UC END# *4995616701BB_51D148890323get_var*
begin
//#UC START# *4995616701BB_51D148890323get_impl*
 Result := f_En.Hint;
//#UC END# *4995616701BB_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.Get_Hint

function TvcmEntityDefForContextMenu.Get_LongHint: IvcmCString;
//#UC START# *4995617802E8_51D148890323get_var*
//#UC END# *4995617802E8_51D148890323get_var*
begin
//#UC START# *4995617802E8_51D148890323get_impl*
 Result := f_En.LongHint;
//#UC END# *4995617802E8_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.Get_LongHint

function TvcmEntityDefForContextMenu.Get_ImageIndex: Integer;
//#UC START# *499561850334_51D148890323get_var*
//#UC END# *499561850334_51D148890323get_var*
begin
//#UC START# *499561850334_51D148890323get_impl*
 Result := f_En.ImageIndex;
//#UC END# *499561850334_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.Get_ImageIndex

function TvcmEntityDefForContextMenu.Get_ID: TvcmControlID;
//#UC START# *499561F90285_51D148890323get_var*
//#UC END# *499561F90285_51D148890323get_var*
begin
//#UC START# *499561F90285_51D148890323get_impl*
 Result := f_En.ID;
//#UC END# *499561F90285_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.Get_ID

function TvcmEntityDefForContextMenu.Get_OperationsDefIterator: IvcmOperationsDefIterator;
//#UC START# *499566FA0159_51D148890323get_var*
//#UC END# *499566FA0159_51D148890323get_var*
begin
//#UC START# *499566FA0159_51D148890323get_impl*
 Result := TvcmOperationsDefIteratorForContextMenu.Make(f_En.OperationsDefIterator);
//#UC END# *499566FA0159_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.Get_OperationsDefIterator

function TvcmEntityDefForContextMenu.Get_ToolbarPos: TvcmToolBarPos;
//#UC START# *4995671E031A_51D148890323get_var*
//#UC END# *4995671E031A_51D148890323get_var*
begin
//#UC START# *4995671E031A_51D148890323get_impl*
 Result := f_En.ToolbarPos;
//#UC END# *4995671E031A_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.Get_ToolbarPos

function TvcmEntityDefForContextMenu.pm_GetOptions: TvcmEntityOperationsOptions;
//#UC START# *49956D95016A_51D148890323get_var*
//#UC END# *49956D95016A_51D148890323get_var*
begin
//#UC START# *49956D95016A_51D148890323get_impl*
 Result := f_En.Options;
//#UC END# *49956D95016A_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.pm_GetOptions

function TvcmEntityDefForContextMenu.Get_Caption: IvcmCString;
//#UC START# *499E958E03B0_51D148890323get_var*
//#UC END# *499E958E03B0_51D148890323get_var*
begin
//#UC START# *499E958E03B0_51D148890323get_impl*
 Result := f_En.Caption;
//#UC END# *499E958E03B0_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.Get_Caption

function TvcmEntityDefForContextMenu.Get_Name: TvcmString;
//#UC START# *499E95A60064_51D148890323get_var*
//#UC END# *499E95A60064_51D148890323get_var*
begin
//#UC START# *499E95A60064_51D148890323get_impl*
 Result := f_En.Name;
//#UC END# *499E95A60064_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.Get_Name

function TvcmEntityDefForContextMenu.Get_ContextMenuWeight: Integer;
//#UC START# *51D12DBB014B_51D148890323get_var*
//#UC END# *51D12DBB014B_51D148890323get_var*
begin
//#UC START# *51D12DBB014B_51D148890323get_impl*
 Result := f_En.ContextMenuWeight;
//#UC END# *51D12DBB014B_51D148890323get_impl*
end;//TvcmEntityDefForContextMenu.Get_ContextMenuWeight

procedure TvcmEntityDefForContextMenu.ClearFields;
begin
 f_En := nil;
 inherited;
end;//TvcmEntityDefForContextMenu.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
