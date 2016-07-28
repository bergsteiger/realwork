unit ddExtObjectMachine;
 {* базовый объект для обработки объектов в документах }

// Модуль: "w:\common\components\rtl\Garant\dd\ddExtObjectMachine.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddExtObjectMachine" MUID: (57987C49023C)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , k2TagGen
 , l3Variant
 //#UC START# *57987C49023Cintf_uses*
 //#UC END# *57987C49023Cintf_uses*
;

type
 //#UC START# *57987C49023Cci*
 //#UC END# *57987C49023Cci*
 //#UC START# *57987C49023Ccit*
 //#UC END# *57987C49023Ccit*
 TddExtObjectMachine = class(TevdBufferedFilter)
  {* базовый объект для обработки объектов в документах }
  private
   f_DocID: Integer;
  protected
   procedure DocumentIDChanged; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   function NeedStartBuffering(aID: Integer): Boolean; override;
   function NeedFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer): Boolean; override;
  public
   class function SetTo(var theGenerator: Tk2TagGenerator): Pointer;
  protected
   property DocID: Integer
    read f_DocID;
 //#UC START# *57987C49023Cpubl*
 //#UC END# *57987C49023Cpubl*
 end;//TddExtObjectMachine

implementation

uses
 l3ImplUses
 //#UC START# *57987C49023Cimpl_uses*
 , l3Base

 , k2Tags

 , Document_Const
 , BitmapPara_Const
 , ExtDataPara_Const
 //#UC END# *57987C49023Cimpl_uses*
;

class function TddExtObjectMachine.SetTo(var theGenerator: Tk2TagGenerator): Pointer;
//#UC START# *57987CCE02C7_57987C49023C_var*
var
 l_Filter : TddExtObjectMachine;
//#UC END# *57987CCE02C7_57987C49023C_var*
begin
//#UC START# *57987CCE02C7_57987C49023C_impl*
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
//#UC END# *57987CCE02C7_57987C49023C_impl*
end;//TddExtObjectMachine.SetTo

procedure TddExtObjectMachine.DocumentIDChanged;
//#UC START# *57987D54034E_57987C49023C_var*
//#UC END# *57987D54034E_57987C49023C_var*
begin
//#UC START# *57987D54034E_57987C49023C_impl*
 // - ничего не делаем
//#UC END# *57987D54034E_57987C49023C_impl*
end;//TddExtObjectMachine.DocumentIDChanged

procedure TddExtObjectMachine.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57987C49023C_var*
//#UC END# *479731C50290_57987C49023C_var*
begin
//#UC START# *479731C50290_57987C49023C_impl*
 f_DocID := 0;
 inherited;
//#UC END# *479731C50290_57987C49023C_impl*
end;//TddExtObjectMachine.Cleanup

procedure TddExtObjectMachine.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_57987C49023C_var*
//#UC END# *4836D52400D9_57987C49023C_var*
begin
//#UC START# *4836D52400D9_57987C49023C_impl*
 if (AtomIndex = k2_tiInternalHandle)
    and CurrentType.IsKindOf(k2_typDocument) then
 begin
  if (f_DocID <> Value.AsInteger) then
  begin
   f_DocID := Value.AsInteger;
   DocumentIDChanged;
  end;//f_DocID <> Value.AsInteger 
 end;//AtomIndex = k2_tiInternalHandle
 inherited;
//#UC END# *4836D52400D9_57987C49023C_impl*
end;//TddExtObjectMachine.AddAtomEx

function TddExtObjectMachine.NeedStartBuffering(aID: Integer): Boolean;
//#UC START# *4C56D54B002A_57987C49023C_var*
//#UC END# *4C56D54B002A_57987C49023C_var*
begin
//#UC START# *4C56D54B002A_57987C49023C_impl*
 Result := (aID = -k2_idExtDataPara) or (aID = -k2_idBitmapPara);
//#UC END# *4C56D54B002A_57987C49023C_impl*
end;//TddExtObjectMachine.NeedStartBuffering

function TddExtObjectMachine.NeedFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer): Boolean;
//#UC START# *4CF7BC520161_57987C49023C_var*
//#UC END# *4CF7BC520161_57987C49023C_var*
begin
//#UC START# *4CF7BC520161_57987C49023C_impl*
 Result := (aTagID = -k2_idExtDataPara) or (aTagID = -k2_idBitmapPara);
//#UC END# *4CF7BC520161_57987C49023C_impl*
end;//TddExtObjectMachine.NeedFlushBuffer

//#UC START# *57987C49023Cimpl*
//#UC END# *57987C49023Cimpl*

end.
