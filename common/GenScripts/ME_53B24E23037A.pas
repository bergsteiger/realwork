{$IfNDef k2TaggedDataHolder_imp}

// Модуль: "w:\common\components\rtl\Garant\K2\k2TaggedDataHolder.imp.pas"
// Стереотип: "Impurity"

{$Define k2TaggedDataHolder_imp}

 _k2TaggedDataHolder_ = class(_k2TaggedDataHolder_Parent_)
  private
   f_TaggedData: Tl3Tag;
    {* Поле для свойства TaggedData }
  protected
   class function GetTaggedDataType: Tk2Type; virtual; abstract;
   procedure AfterDestroyCalled; override;
   procedure InitAfterAlloc; override;
  public
   procedure SetTaggedData(aData: Tl3Tag);
  public
   property TaggedData: Tl3Tag
    read f_TaggedData;
 end;//_k2TaggedDataHolder_

{$Else k2TaggedDataHolder_imp}

{$IfNDef k2TaggedDataHolder_imp_impl}

{$Define k2TaggedDataHolder_imp_impl}

procedure _k2TaggedDataHolder_.SetTaggedData(aData: Tl3Tag);
//#UC START# *53BFF56D0348_53B24E23037A_var*
//#UC END# *53BFF56D0348_53B24E23037A_var*
begin
//#UC START# *53BFF56D0348_53B24E23037A_impl*
 if (f_TaggedData <> nil) then
  f_TaggedData.Owner := nil;
 aData.SetRef(f_TaggedData);
 if (f_TaggedData <> nil) then
  f_TaggedData.Owner := Self;
//#UC END# *53BFF56D0348_53B24E23037A_impl*
end;//_k2TaggedDataHolder_.SetTaggedData

procedure _k2TaggedDataHolder_.AfterDestroyCalled;
//#UC START# *52BC2B9401F3_53B24E23037A_var*
//#UC END# *52BC2B9401F3_53B24E23037A_var*
begin
//#UC START# *52BC2B9401F3_53B24E23037A_impl*
 inherited;
 if (f_TaggedData <> nil) then
  f_TaggedData.Owner := nil;
 FreeAndNil(f_TaggedData);
//#UC END# *52BC2B9401F3_53B24E23037A_impl*
end;//_k2TaggedDataHolder_.AfterDestroyCalled

procedure _k2TaggedDataHolder_.InitAfterAlloc;
//#UC START# *53AC02B602E3_53B24E23037A_var*
//#UC END# *53AC02B602E3_53B24E23037A_var*
begin
//#UC START# *53AC02B602E3_53B24E23037A_impl*
 inherited;
 Assert(f_TaggedData = nil);
 GetTaggedDataType.MakeTag.AsObject.SetRef(f_TaggedData);
 if (f_TaggedData <> nil) then
  f_TaggedData.Owner := Self;
//#UC END# *53AC02B602E3_53B24E23037A_impl*
end;//_k2TaggedDataHolder_.InitAfterAlloc

{$EndIf k2TaggedDataHolder_imp_impl}

{$EndIf k2TaggedDataHolder_imp}

