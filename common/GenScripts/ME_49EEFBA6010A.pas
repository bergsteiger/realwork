unit bsEditGroupName;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\bsEditGroupName.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoObject
 , AdminInterfaces
 , l3Interfaces
;

type
 TbsEditGroupName = class(Tl3ProtoObject, IbsEditGroupName)
  private
   f_Name: Il3CString;
  protected
   function Get_Name: Il3CString;
   procedure Set_Name(const aValue: Il3CString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aName: Il3CString); reintroduce;
   class function Make(const aName: Il3CString): IbsEditGroupName; reintroduce;
 end;//TbsEditGroupName
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

constructor TbsEditGroupName.Create(const aName: Il3CString);
//#UC START# *49EEFC1B007D_49EEFBA6010A_var*
//#UC END# *49EEFC1B007D_49EEFBA6010A_var*
begin
//#UC START# *49EEFC1B007D_49EEFBA6010A_impl*
 inherited Create;
 f_Name := aName;
//#UC END# *49EEFC1B007D_49EEFBA6010A_impl*
end;//TbsEditGroupName.Create

class function TbsEditGroupName.Make(const aName: Il3CString): IbsEditGroupName;
var
 l_Inst : TbsEditGroupName;
begin
 l_Inst := Create(aName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsEditGroupName.Make

function TbsEditGroupName.Get_Name: Il3CString;
//#UC START# *49EEFAAB0318_49EEFBA6010Aget_var*
//#UC END# *49EEFAAB0318_49EEFBA6010Aget_var*
begin
//#UC START# *49EEFAAB0318_49EEFBA6010Aget_impl*
 Result := f_Name;
//#UC END# *49EEFAAB0318_49EEFBA6010Aget_impl*
end;//TbsEditGroupName.Get_Name

procedure TbsEditGroupName.Set_Name(const aValue: Il3CString);
//#UC START# *49EEFAAB0318_49EEFBA6010Aset_var*
//#UC END# *49EEFAAB0318_49EEFBA6010Aset_var*
begin
//#UC START# *49EEFAAB0318_49EEFBA6010Aset_impl*
 f_Name := aValue;
//#UC END# *49EEFAAB0318_49EEFBA6010Aset_impl*
end;//TbsEditGroupName.Set_Name

procedure TbsEditGroupName.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49EEFBA6010A_var*
//#UC END# *479731C50290_49EEFBA6010A_var*
begin
//#UC START# *479731C50290_49EEFBA6010A_impl*
 f_Name := nil;
 inherited Cleanup;
//#UC END# *479731C50290_49EEFBA6010A_impl*
end;//TbsEditGroupName.Cleanup
{$IfEnd} // Defined(Admin)

end.
