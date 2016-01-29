{$IfNDef k2TaggedDataHolder_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TaggedDataHolder.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::K2::TagHolder::k2TaggedDataHolder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define k2TaggedDataHolder_imp}
 _k2TaggedDataHolder_ = {mixin} class(_k2TaggedDataHolder_Parent_)
 private
 // private fields
   f_TaggedData : Tl3Tag;
    {* Поле для свойства TaggedData}
 protected
 // overridden protected methods
   procedure AfterDestroyCalled; override;
     {* Сигнатура метода AfterDestroyCalled }
   procedure InitAfterAlloc; override;
 protected
 // protected methods
   class function GetTaggedDataType: Tk2Type; virtual; abstract;
 public
 // public methods
   procedure SetTaggedData(aData: Tl3Tag);
 public
 // public properties
   property TaggedData: Tl3Tag
     read f_TaggedData;
 end;//_k2TaggedDataHolder_

{$Else k2TaggedDataHolder_imp}

// start class _k2TaggedDataHolder_

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

{$EndIf k2TaggedDataHolder_imp}
