{$IfNDef l3UnknownPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3UnknownPrim.imp.pas"
// Стереотип: "Impurity"

{$Define l3UnknownPrim_imp}

 _l3CheckStamp_Parent_ = _l3UnknownPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3CheckStamp.imp.pas}
 _RefCountedPrim_Parent_ = _l3CheckStamp_;
 {$Include w:\common\components\rtl\Garant\L3\RefCountedPrim.imp.pas}
 _l3UnknownPrim_ = class(_RefCountedPrim_)
  {* Класс-примесь реализующий подсчет ссылок и кеширование. }
  protected
   procedure ClearFields; virtual;
   procedure BeforeClearFields; virtual;
   procedure AfterDestroyCalled; virtual;
   procedure AfterFree; virtual;
    {* функция, вызываемая после каждого уменьшении счетчика ссылок на объект, не приводящего к уничтожению объекта }
   procedure InitAfterAlloc; virtual;
   class function AllocInstanceMem: TObject; virtual;
   procedure FreeInstanceMem; virtual;
   procedure BeforeAddToCache; virtual;
    {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
   procedure InitFields; virtual;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; virtual;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure BeforeFree; virtual;
    {* функция, вызываемая при каждом уменьшении счетчика ссылок на 1. Вернув false может запретить уничтожение объекта. }
   {$If Defined(l3CheckUnfreedResources)}
   function CheckUnfreedResource(aPtrToResource: Pointer): Boolean; virtual;
    {* Является ли ссылка на поле объекта правильно не освобожденным ресурсом.
              Возвращает правильно ли не освобожден инткрфейс }
   {$IfEnd} // Defined(l3CheckUnfreedResources)
   function NeedCleanupFields: Boolean; virtual;
  public
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; overload; virtual;
   function _AddRef: Integer; stdcall;
    {* Увеличивает счетчик ссылок. }
   function _Release: Integer; stdcall;
    {* Уменьшает счетчик ссылок. }
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; overload; stdcall;
    {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//_l3UnknownPrim_

{$Else l3UnknownPrim_imp}

{$IfNDef l3UnknownPrim_imp_impl}

{$Define l3UnknownPrim_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3CheckStamp.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\RefCountedPrim.imp.pas}

procedure _l3UnknownPrim_.ClearFields;
//#UC START# *5000565C019C_47913F4E02E0_var*
//#UC END# *5000565C019C_47913F4E02E0_var*
begin
//#UC START# *5000565C019C_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5000565C019C_47913F4E02E0_impl*
end;//_l3UnknownPrim_.ClearFields

procedure _l3UnknownPrim_.BeforeClearFields;
//#UC START# *500056650395_47913F4E02E0_var*
//#UC END# *500056650395_47913F4E02E0_var*
begin
//#UC START# *500056650395_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *500056650395_47913F4E02E0_impl*
end;//_l3UnknownPrim_.BeforeClearFields

procedure _l3UnknownPrim_.AfterDestroyCalled;
//#UC START# *52BC2B9401F3_47913F4E02E0_var*
//#UC END# *52BC2B9401F3_47913F4E02E0_var*
begin
//#UC START# *52BC2B9401F3_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52BC2B9401F3_47913F4E02E0_impl*
end;//_l3UnknownPrim_.AfterDestroyCalled

procedure _l3UnknownPrim_.AfterFree;
 {* функция, вызываемая после каждого уменьшении счетчика ссылок на объект, не приводящего к уничтожению объекта }
//#UC START# *531EEB8503AE_47913F4E02E0_var*
//#UC END# *531EEB8503AE_47913F4E02E0_var*
begin
//#UC START# *531EEB8503AE_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *531EEB8503AE_47913F4E02E0_impl*
end;//_l3UnknownPrim_.AfterFree

procedure _l3UnknownPrim_.InitAfterAlloc;
//#UC START# *53AC02B602E3_47913F4E02E0_var*
//#UC END# *53AC02B602E3_47913F4E02E0_var*
begin
//#UC START# *53AC02B602E3_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC02B602E3_47913F4E02E0_impl*
end;//_l3UnknownPrim_.InitAfterAlloc

class function _l3UnknownPrim_.AllocInstanceMem: TObject;
//#UC START# *5453AC3702B2_47913F4E02E0_var*
//#UC END# *5453AC3702B2_47913F4E02E0_var*
begin
//#UC START# *5453AC3702B2_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5453AC3702B2_47913F4E02E0_impl*
end;//_l3UnknownPrim_.AllocInstanceMem

procedure _l3UnknownPrim_.FreeInstanceMem;
//#UC START# *5453AC66022A_47913F4E02E0_var*
//#UC END# *5453AC66022A_47913F4E02E0_var*
begin
//#UC START# *5453AC66022A_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5453AC66022A_47913F4E02E0_impl*
end;//_l3UnknownPrim_.FreeInstanceMem

function _l3UnknownPrim_.QueryInterface(const IID: TGUID;
 out Obj): HResult;
//#UC START# *561145D802BB_47913F4E02E0_var*
//#UC END# *561145D802BB_47913F4E02E0_var*
begin
//#UC START# *561145D802BB_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *561145D802BB_47913F4E02E0_impl*
end;//_l3UnknownPrim_.QueryInterface

procedure _l3UnknownPrim_.BeforeAddToCache;
 {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
//#UC START# *479F2B3302C1_47913F4E02E0_var*
//#UC END# *479F2B3302C1_47913F4E02E0_var*
begin
//#UC START# *479F2B3302C1_47913F4E02E0_impl*
 assert(false, '_l3UnknownPrim_.BeforeAddToCache not implemented');
//#UC END# *479F2B3302C1_47913F4E02E0_impl*
end;//_l3UnknownPrim_.BeforeAddToCache

procedure _l3UnknownPrim_.InitFields;
//#UC START# *47A042E100E2_47913F4E02E0_var*
//#UC END# *47A042E100E2_47913F4E02E0_var*
begin
//#UC START# *47A042E100E2_47913F4E02E0_impl*
 assert(false, '_l3UnknownPrim_.InitFields not implemented');
//#UC END# *47A042E100E2_47913F4E02E0_impl*
end;//_l3UnknownPrim_.InitFields

{$If NOT Defined(DesignTimeLibrary)}
class function _l3UnknownPrim_.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_47913F4E02E0_var*
//#UC END# *47A6FEE600FC_47913F4E02E0_var*
begin
//#UC START# *47A6FEE600FC_47913F4E02E0_impl*
 assert(false, '_l3UnknownPrim_.IsCacheable not implemented');
//#UC END# *47A6FEE600FC_47913F4E02E0_impl*
end;//_l3UnknownPrim_.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure _l3UnknownPrim_.BeforeFree;
 {* функция, вызываемая при каждом уменьшении счетчика ссылок на 1. Вернув false может запретить уничтожение объекта. }
//#UC START# *48B2BE560115_47913F4E02E0_var*
//#UC END# *48B2BE560115_47913F4E02E0_var*
begin
//#UC START# *48B2BE560115_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *48B2BE560115_47913F4E02E0_impl*
end;//_l3UnknownPrim_.BeforeFree

{$If Defined(l3CheckUnfreedResources)}
function _l3UnknownPrim_.CheckUnfreedResource(aPtrToResource: Pointer): Boolean;
 {* Является ли ссылка на поле объекта правильно не освобожденным ресурсом.
              Возвращает правильно ли не освобожден инткрфейс }
//#UC START# *4A4876C403B8_47913F4E02E0_var*
//#UC END# *4A4876C403B8_47913F4E02E0_var*
begin
//#UC START# *4A4876C403B8_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4876C403B8_47913F4E02E0_impl*
end;//_l3UnknownPrim_.CheckUnfreedResource
{$IfEnd} // Defined(l3CheckUnfreedResources)

function _l3UnknownPrim_.NeedCleanupFields: Boolean;
//#UC START# *4AF44EC401EE_47913F4E02E0_var*
//#UC END# *4AF44EC401EE_47913F4E02E0_var*
begin
//#UC START# *4AF44EC401EE_47913F4E02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF44EC401EE_47913F4E02E0_impl*
end;//_l3UnknownPrim_.NeedCleanupFields

function _l3UnknownPrim_._AddRef: Integer;
 {* Увеличивает счетчик ссылок. }
//#UC START# *47913C24007F_47913F4E02E0_var*
//#UC END# *47913C24007F_47913F4E02E0_var*
begin
//#UC START# *47913C24007F_47913F4E02E0_impl*
 assert(false, 'UnknownPrim.AddRef not implemented');
//#UC END# *47913C24007F_47913F4E02E0_impl*
end;//_l3UnknownPrim_._AddRef

function _l3UnknownPrim_._Release: Integer;
 {* Уменьшает счетчик ссылок. }
//#UC START# *47913C5301A1_47913F4E02E0_var*
//#UC END# *47913C5301A1_47913F4E02E0_var*
begin
//#UC START# *47913C5301A1_47913F4E02E0_impl*
 assert(false, 'UnknownPrim.Release not implemented');
//#UC END# *47913C5301A1_47913F4E02E0_impl*
end;//_l3UnknownPrim_._Release

function _l3UnknownPrim_.QueryInterface(const IID: TGUID;
 out Obj): HResult;
 {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
//#UC START# *47913CBF0265_47913F4E02E0_var*
//#UC END# *47913CBF0265_47913F4E02E0_var*
begin
//#UC START# *47913CBF0265_47913F4E02E0_impl*
 assert(false, 'UnknownPrim.QueryInterface not implemented');
//#UC END# *47913CBF0265_47913F4E02E0_impl*
end;//_l3UnknownPrim_.QueryInterface

{$EndIf l3UnknownPrim_imp_impl}

{$EndIf l3UnknownPrim_imp}

