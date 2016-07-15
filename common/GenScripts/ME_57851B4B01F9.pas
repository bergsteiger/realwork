unit vcmOperationsForRegister;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmOperationsForRegister.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmOperationsForRegister" MUID: (57851B4B01F9)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , vcmExternalInterfaces
 , l3ProtoObject
 , vcmOperationStatesForRegister
;

type
 PvcmOPID = ^TvcmOPID;

 TvcmOperationForRegister = object
  public
   rEntityName: AnsiString;
   rOperationName: AnsiString;
   rEntityCaption: AnsiString;
   rOperationCaption: AnsiString;
   rNoPrefix: Boolean;
   rInternal: Boolean;
   rVar: PvcmOPID;
   rImageIndex: Integer;
  public
   function EQ(const anOther: TvcmOperationForRegister): Boolean;
 end;//TvcmOperationForRegister

 TvcmOperationForRegisterItem = class(Tl3ProtoObject)
  private
   f_States: TvcmOperationStatesForRegister;
  public
   Descr: TvcmOperationForRegister;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function EQ(anOther: TvcmOperationForRegisterItem): Boolean; overload;
   function EQ(const anOther: TvcmOperationForRegister): Boolean; overload;
   constructor Create(const aDescr: TvcmOperationForRegister); reintroduce;
   function AddState(const aState: TvcmOperationStateForRegister): PvcmOperationStateForRegister;
   procedure SetImageIndex(aValue: Integer);
  public
   property States: TvcmOperationStatesForRegister
    read f_States;
 end;//TvcmOperationForRegisterItem

 {$Define l3Items_NoSort}

 _ItemType_ = TvcmOperationForRegisterItem;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TvcmOperationsForRegister = class(_l3UncomparabeObjectRefList_)
  public
   class function AddOperation(const anOp: TvcmOperationForRegister): TvcmOperationForRegisterItem;
   class function Instance: TvcmOperationsForRegister;
    {* Метод получения экземпляра синглетона TvcmOperationsForRegister }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmOperationsForRegister

function TvcmOperationForRegister_C(const anEntityName: AnsiString;
 const anOperationName: AnsiString;
 const anEntityCaption: AnsiString;
 const anOperationCaption: AnsiString;
 aInternal: Boolean;
 aNoPrefix: Boolean;
 var theVar: TvcmOPID): TvcmOperationForRegister;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

var g_TvcmOperationsForRegister: TvcmOperationsForRegister = nil;
 {* Экземпляр синглетона TvcmOperationsForRegister }

function TvcmOperationForRegister_C(const anEntityName: AnsiString;
 const anOperationName: AnsiString;
 const anEntityCaption: AnsiString;
 const anOperationCaption: AnsiString;
 aInternal: Boolean;
 aNoPrefix: Boolean;
 var theVar: TvcmOPID): TvcmOperationForRegister;
//#UC START# *57851D5A0285_57851C14006F_var*
//#UC END# *57851D5A0285_57851C14006F_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57851D5A0285_57851C14006F_impl*
 Result.rEntityName := anEntityName;
 Result.rOperationName := anOperationName;
 Result.rEntityCaption := anEntityCaption;
 Result.rOperationCaption := anOperationCaption;
 Result.rInternal := aInternal;
 Result.rNoPrefix := aNoPrefix;
 Result.rVar := @theVar;
 Result.rImageIndex := -1;
//#UC END# *57851D5A0285_57851C14006F_impl*
end;//TvcmOperationForRegister_C

procedure TvcmOperationsForRegisterFree;
 {* Метод освобождения экземпляра синглетона TvcmOperationsForRegister }
begin
 l3Free(g_TvcmOperationsForRegister);
end;//TvcmOperationsForRegisterFree

function TvcmOperationForRegister.EQ(const anOther: TvcmOperationForRegister): Boolean;
//#UC START# *57851CA400DC_57851C14006F_var*
//#UC END# *57851CA400DC_57851C14006F_var*
begin
//#UC START# *57851CA400DC_57851C14006F_impl*
 Result := (rEntityName = anOther.rEntityName) AND
           (rOperationName = anOther.rOperationName);
//#UC END# *57851CA400DC_57851C14006F_impl*
end;//TvcmOperationForRegister.EQ

function TvcmOperationForRegisterItem.EQ(anOther: TvcmOperationForRegisterItem): Boolean;
//#UC START# *578613B903B3_5786136E0193_var*
//#UC END# *578613B903B3_5786136E0193_var*
begin
//#UC START# *578613B903B3_5786136E0193_impl*
 Result := Descr.EQ(anOther.Descr);
//#UC END# *578613B903B3_5786136E0193_impl*
end;//TvcmOperationForRegisterItem.EQ

function TvcmOperationForRegisterItem.EQ(const anOther: TvcmOperationForRegister): Boolean;
//#UC START# *578613FA02A9_5786136E0193_var*
//#UC END# *578613FA02A9_5786136E0193_var*
begin
//#UC START# *578613FA02A9_5786136E0193_impl*
 Result := Descr.EQ(anOther);
//#UC END# *578613FA02A9_5786136E0193_impl*
end;//TvcmOperationForRegisterItem.EQ

constructor TvcmOperationForRegisterItem.Create(const aDescr: TvcmOperationForRegister);
//#UC START# *578614320057_5786136E0193_var*
//#UC END# *578614320057_5786136E0193_var*
begin
//#UC START# *578614320057_5786136E0193_impl*
 inherited Create;
 Descr := aDescr;
//#UC END# *578614320057_5786136E0193_impl*
end;//TvcmOperationForRegisterItem.Create

function TvcmOperationForRegisterItem.AddState(const aState: TvcmOperationStateForRegister): PvcmOperationStateForRegister;
//#UC START# *5786158702D4_5786136E0193_var*
//#UC END# *5786158702D4_5786136E0193_var*
begin
//#UC START# *5786158702D4_5786136E0193_impl*
 if (f_States = nil) then
  f_States := TvcmOperationStatesForRegister.Create;
 Result := f_States.AddState(aState); 
//#UC END# *5786158702D4_5786136E0193_impl*
end;//TvcmOperationForRegisterItem.AddState

procedure TvcmOperationForRegisterItem.SetImageIndex(aValue: Integer);
//#UC START# *578615B20235_5786136E0193_var*
//#UC END# *578615B20235_5786136E0193_var*
begin
//#UC START# *578615B20235_5786136E0193_impl*
 Descr.rImageIndex := aValue;
//#UC END# *578615B20235_5786136E0193_impl*
end;//TvcmOperationForRegisterItem.SetImageIndex

procedure TvcmOperationForRegisterItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5786136E0193_var*
//#UC END# *479731C50290_5786136E0193_var*
begin
//#UC START# *479731C50290_5786136E0193_impl*
 FreeAndNil(f_States);
 inherited;
//#UC END# *479731C50290_5786136E0193_impl*
end;//TvcmOperationForRegisterItem.Cleanup

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57851B4B01F9_var*
//#UC END# *47B2C42A0163_57851B4B01F9_var*
begin
//#UC START# *47B2C42A0163_57851B4B01F9_impl*
 Assert(false);
//#UC END# *47B2C42A0163_57851B4B01F9_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57851B4B01F9_var*
//#UC END# *47B99D4503A2_57851B4B01F9_var*
begin
//#UC START# *47B99D4503A2_57851B4B01F9_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_57851B4B01F9_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmOperationsForRegister;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

class function TvcmOperationsForRegister.AddOperation(const anOp: TvcmOperationForRegister): TvcmOperationForRegisterItem;
//#UC START# *57851D310000_57851B4B01F9_var*
var
 l_Index : Integer;
 l_Op : TvcmOperationForRegisterItem;
//#UC END# *57851D310000_57851B4B01F9_var*
begin
//#UC START# *57851D310000_57851B4B01F9_impl*
 l_Op := TvcmOperationForRegisterItem.Create(anOp);
 try
  with Instance do
  begin
   l_Index := IndexOf(l_Op);
   if (l_Index < 0) then
    l_Index := Add(l_Op);
   Result := Items[l_Index]; 
  end;//with Instance
 finally
  FreeAndNil(l_Op);
 end;//try..finally
//#UC END# *57851D310000_57851B4B01F9_impl*
end;//TvcmOperationsForRegister.AddOperation

class function TvcmOperationsForRegister.Instance: TvcmOperationsForRegister;
 {* Метод получения экземпляра синглетона TvcmOperationsForRegister }
begin
 if (g_TvcmOperationsForRegister = nil) then
 begin
  l3System.AddExitProc(TvcmOperationsForRegisterFree);
  g_TvcmOperationsForRegister := Create;
 end;
 Result := g_TvcmOperationsForRegister;
end;//TvcmOperationsForRegister.Instance

class function TvcmOperationsForRegister.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmOperationsForRegister <> nil;
end;//TvcmOperationsForRegister.Exists
{$IfEnd} // NOT Defined(NoVCM)

end.
