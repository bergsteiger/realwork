{$IfNDef nsNodeNotifierBase_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNodeNotifierBase.imp.pas"
// Стереотип: "Impurity"

{$Define nsNodeNotifierBase_imp}

type
 PnsThreadCallParamsRec = ^TnsThreadCallParamsRec;

 TnsThreadCallParamsRec = record
  rNodeIndex: TVisibleIndex;
  rDelta: Integer;
  rIndexPath: INodeIndexPath;
  rChildIndex: TIndexInParent;
 end;//TnsThreadCallParamsRec

 _l3ThreadNotifier_Parent_ = _nsNodeNotifierBase_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3ThreadNotifier.imp.pas}
 _nsNodeNotifierPrim_Parent_ = _l3ThreadNotifier_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNodeNotifierPrim.imp.pas}
 _nsNodeNotifierBase_ = class(_nsNodeNotifierPrim_)
  private
   f_CountViewChanged: Boolean;
    {* Поле для свойства CountViewChanged }
   f_CountView: Integer;
    {* Поле для свойства CountView }
  protected
   function IsInGetByVisibleIndex: Boolean; virtual;
   function IsOneLevelPrim: Boolean; virtual;
   function DoChangeChildrenCount(aNodeIndex: TVisibleIndex;
    aDelta: Integer): Integer; virtual;
   procedure ChangeChildrenCountPrim(aNodeIndex: TVisibleIndex;
    aDelta: Integer;
    const aIndexPath: INodeIndexPath;
    aChildIndex: TIndexInParent); virtual;
   procedure ResetChildrenCountPrim; virtual;
   function GetShowRoot: Boolean; virtual;
   procedure ChangingPrim; virtual;
   procedure ChangedPrim; virtual;
   procedure InvalidatePrim; virtual;
   procedure ExternalInvalidate; virtual;
   procedure DropCurrent; virtual;
   procedure ExternalVisibleCountChanged(aNewCount: Integer;
    aNodeIndex: Integer;
    aDelta: Integer); virtual;
    {* нотификация визуальному дереву о смене количества видимых элементов }
   procedure DropCountView;
   procedure InvalidateThread(aDataPtr: Tl3DataHolder);
   procedure ChangingThread(aDataPtr: Tl3DataHolder);
   procedure ChangedThread(aDataPtr: Tl3DataHolder);
   procedure ChangeChildrenCountThread(aDataPtr: Tl3DataHolder);
   function HolderClass: Rl3DataHolder; override;
   procedure Cleanup; override;
  protected
   property CountViewChanged: Boolean
    read f_CountViewChanged
    write f_CountViewChanged;
   property CountView: Integer
    read f_CountView;
 end;//_nsNodeNotifierBase_

{$Else nsNodeNotifierBase_imp}

{$IfNDef nsNodeNotifierBase_imp_impl}

{$Define nsNodeNotifierBase_imp_impl}

type
 TnsNodeNotifierHolder = class(Tl3DataHolder)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//TnsNodeNotifierHolder

procedure TnsNodeNotifierHolder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48FD9AE5001C_var*
//#UC END# *479731C50290_48FD9AE5001C_var*
begin
//#UC START# *479731C50290_48FD9AE5001C_impl*
 if (Data <> nil) then
  PnsThreadCallParamsRec(Data)^.rIndexPath := nil; 
 inherited;
//#UC END# *479731C50290_48FD9AE5001C_impl*
end;//TnsNodeNotifierHolder.Cleanup

procedure TnsNodeNotifierHolder.InitFields;
//#UC START# *47A042E100E2_48FD9AE5001C_var*
//#UC END# *47A042E100E2_48FD9AE5001C_var*
begin
//#UC START# *47A042E100E2_48FD9AE5001C_impl*
 inherited;
 if (Data <> nil) then
  if (PnsThreadCallParamsRec(Data)^.rIndexPath <> nil) then
   PnsThreadCallParamsRec(Data)^.rIndexPath._AddRef;
   // - добавляем счетчик ссылок
//#UC END# *47A042E100E2_48FD9AE5001C_impl*
end;//TnsNodeNotifierHolder.InitFields

{$Include w:\common\components\rtl\Garant\L3\l3ThreadNotifier.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNodeNotifierPrim.imp.pas}

function _nsNodeNotifierBase_.IsInGetByVisibleIndex: Boolean;
//#UC START# *48FDA0CB01AD_48FD8F78038B_var*
//#UC END# *48FDA0CB01AD_48FD8F78038B_var*
begin
//#UC START# *48FDA0CB01AD_48FD8F78038B_impl*
 Result := false;
//#UC END# *48FDA0CB01AD_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.IsInGetByVisibleIndex

function _nsNodeNotifierBase_.IsOneLevelPrim: Boolean;
//#UC START# *48FDA0DD02E1_48FD8F78038B_var*
//#UC END# *48FDA0DD02E1_48FD8F78038B_var*
begin
//#UC START# *48FDA0DD02E1_48FD8F78038B_impl*
 Result := false;
//#UC END# *48FDA0DD02E1_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.IsOneLevelPrim

function _nsNodeNotifierBase_.DoChangeChildrenCount(aNodeIndex: TVisibleIndex;
 aDelta: Integer): Integer;
//#UC START# *48FDA0F500F9_48FD8F78038B_var*
//#UC END# *48FDA0F500F9_48FD8F78038B_var*
begin
//#UC START# *48FDA0F500F9_48FD8F78038B_impl*
 Result := -1;
//#UC END# *48FDA0F500F9_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.DoChangeChildrenCount

procedure _nsNodeNotifierBase_.ChangeChildrenCountPrim(aNodeIndex: TVisibleIndex;
 aDelta: Integer;
 const aIndexPath: INodeIndexPath;
 aChildIndex: TIndexInParent);
//#UC START# *48FDA11E02D1_48FD8F78038B_var*
//#UC END# *48FDA11E02D1_48FD8F78038B_var*
begin
//#UC START# *48FDA11E02D1_48FD8F78038B_impl*
 Assert(GetCurrentThreadID = MainThreadID);

 if (aDelta <> 0) then
 begin
  Inc(f_CountView, aDelta);

  if (aNodeIndex = -1) then
  // Специальный вызов, применяется при изменении состава дерева - вставка/удаление элементов
  begin
   Changing;
   try
    DropCurrent;
   finally
    Changed;
   end;//try..finally
  end//aNodeIndex = -1
  else
   // Нотифицируем визуалку об изменении количества видимых элементов
   ExternalVisibleCountChanged(f_CountView, DoChangeChildrenCount(aNodeIndex, aDelta), aDelta)
 end;//aDelta <> 0
//#UC END# *48FDA11E02D1_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.ChangeChildrenCountPrim

procedure _nsNodeNotifierBase_.ResetChildrenCountPrim;
//#UC START# *48FDA14302AE_48FD8F78038B_var*
//#UC END# *48FDA14302AE_48FD8F78038B_var*
begin
//#UC START# *48FDA14302AE_48FD8F78038B_impl*
 CallNotify(nne_ResetChildrenCount, 0);
//#UC END# *48FDA14302AE_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.ResetChildrenCountPrim

function _nsNodeNotifierBase_.GetShowRoot: Boolean;
//#UC START# *48FDA1A60056_48FD8F78038B_var*
//#UC END# *48FDA1A60056_48FD8F78038B_var*
begin
//#UC START# *48FDA1A60056_48FD8F78038B_impl*
 Result := false;
//#UC END# *48FDA1A60056_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.GetShowRoot

procedure _nsNodeNotifierBase_.ChangingPrim;
//#UC START# *48FDA1C3002E_48FD8F78038B_var*
//#UC END# *48FDA1C3002E_48FD8F78038B_var*
begin
//#UC START# *48FDA1C3002E_48FD8F78038B_impl*
 Changing;
//#UC END# *48FDA1C3002E_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.ChangingPrim

procedure _nsNodeNotifierBase_.ChangedPrim;
//#UC START# *48FDA1D0006F_48FD8F78038B_var*
//#UC END# *48FDA1D0006F_48FD8F78038B_var*
begin
//#UC START# *48FDA1D0006F_48FD8F78038B_impl*
 Changed;
//#UC END# *48FDA1D0006F_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.ChangedPrim

procedure _nsNodeNotifierBase_.InvalidatePrim;
//#UC START# *48FDA1DB0344_48FD8F78038B_var*
//#UC END# *48FDA1DB0344_48FD8F78038B_var*
begin
//#UC START# *48FDA1DB0344_48FD8F78038B_impl*
 ExternalInvalidate;
//#UC END# *48FDA1DB0344_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.InvalidatePrim

procedure _nsNodeNotifierBase_.ExternalInvalidate;
//#UC START# *48FDA1E701DF_48FD8F78038B_var*
//#UC END# *48FDA1E701DF_48FD8F78038B_var*
begin
//#UC START# *48FDA1E701DF_48FD8F78038B_impl*
//#UC END# *48FDA1E701DF_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.ExternalInvalidate

procedure _nsNodeNotifierBase_.DropCurrent;
//#UC START# *48FDA1F20208_48FD8F78038B_var*
//#UC END# *48FDA1F20208_48FD8F78038B_var*
begin
//#UC START# *48FDA1F20208_48FD8F78038B_impl*
//#UC END# *48FDA1F20208_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.DropCurrent

procedure _nsNodeNotifierBase_.ExternalVisibleCountChanged(aNewCount: Integer;
 aNodeIndex: Integer;
 aDelta: Integer);
 {* нотификация визуальному дереву о смене количества видимых элементов }
//#UC START# *48FDA30E0390_48FD8F78038B_var*
//#UC END# *48FDA30E0390_48FD8F78038B_var*
begin
//#UC START# *48FDA30E0390_48FD8F78038B_impl*
//#UC END# *48FDA30E0390_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.ExternalVisibleCountChanged

procedure _nsNodeNotifierBase_.DropCountView;
//#UC START# *48FDA6EE0028_48FD8F78038B_var*
//#UC END# *48FDA6EE0028_48FD8F78038B_var*
begin
//#UC START# *48FDA6EE0028_48FD8F78038B_impl*
 f_CountView := 0;
//#UC END# *48FDA6EE0028_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.DropCountView

procedure _nsNodeNotifierBase_.InvalidateThread(aDataPtr: Tl3DataHolder);
//#UC START# *48FDA6F902B8_48FD8F78038B_var*
//#UC END# *48FDA6F902B8_48FD8F78038B_var*
begin
//#UC START# *48FDA6F902B8_48FD8F78038B_impl*
 InvalidatePrim;
//#UC END# *48FDA6F902B8_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.InvalidateThread

procedure _nsNodeNotifierBase_.ChangingThread(aDataPtr: Tl3DataHolder);
//#UC START# *48FDA7060268_48FD8F78038B_var*
//#UC END# *48FDA7060268_48FD8F78038B_var*
begin
//#UC START# *48FDA7060268_48FD8F78038B_impl*
 ChangingPrim;
//#UC END# *48FDA7060268_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.ChangingThread

procedure _nsNodeNotifierBase_.ChangedThread(aDataPtr: Tl3DataHolder);
//#UC START# *48FDA725033E_48FD8F78038B_var*
//#UC END# *48FDA725033E_48FD8F78038B_var*
begin
//#UC START# *48FDA725033E_48FD8F78038B_impl*
 ChangedPrim;
//#UC END# *48FDA725033E_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.ChangedThread

procedure _nsNodeNotifierBase_.ChangeChildrenCountThread(aDataPtr: Tl3DataHolder);
//#UC START# *48FDA7330175_48FD8F78038B_var*
//#UC END# *48FDA7330175_48FD8F78038B_var*
begin
//#UC START# *48FDA7330175_48FD8F78038B_impl*
 with PnsThreadCallParamsRec(aDataPtr.Data)^ do
  ChangeChildrenCountPrim(rNodeIndex, rDelta, rIndexPath, rChildIndex);
//#UC END# *48FDA7330175_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.ChangeChildrenCountThread

function _nsNodeNotifierBase_.HolderClass: Rl3DataHolder;
//#UC START# *48FD9562004C_48FD8F78038B_var*
//#UC END# *48FD9562004C_48FD8F78038B_var*
begin
//#UC START# *48FD9562004C_48FD8F78038B_impl*
 Result := TnsNodeNotifierHolder;
//#UC END# *48FD9562004C_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.HolderClass

procedure _nsNodeNotifierBase_.Cleanup;
//#UC START# *48FD97BC0335_48FD8F78038B_var*
//#UC END# *48FD97BC0335_48FD8F78038B_var*
begin
//#UC START# *48FD97BC0335_48FD8F78038B_impl*
 f_CountViewChanged := false;
 inherited;
//#UC END# *48FD97BC0335_48FD8F78038B_impl*
end;//_nsNodeNotifierBase_.Cleanup

{$EndIf nsNodeNotifierBase_imp_impl}

{$EndIf nsNodeNotifierBase_imp}

