unit alcuTaskExecutingList;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\alcuTaskExecutingList.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 PalcuTaskExecutionCounter = ^TalcuTaskExecutionCounter;

 TalcuTaskExecutionCounter = class(Tl3ProtoObject)
  private
   f_Task: TddProcessTask;
    {* Поле для свойства Task }
   f_Counter: Integer;
    {* Поле для свойства Counter }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTask: TddProcessTask); reintroduce;
  public
   property Task: TddProcessTask
    read f_Task;
   property Counter: Integer
    read f_Counter
    write f_Counter;
 end;//TalcuTaskExecutionCounter

 _ItemType_ = TalcuTaskExecutionCounter;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TalcuTaskExecutingList = class(_l3UncomparabeObjectRefList_)
 end;//TalcuTaskExecutingList
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

constructor TalcuTaskExecutionCounter.Create(const aTask: TddProcessTask);
//#UC START# *53D0ADC001F2_53D0ACC8010F_var*
//#UC END# *53D0ADC001F2_53D0ACC8010F_var*
begin
//#UC START# *53D0ADC001F2_53D0ACC8010F_impl*
 inherited Create;
 Assert(Assigned(aTask));
 aTask.SetRefTo(f_Task);
 f_Counter := 0;
//#UC END# *53D0ADC001F2_53D0ACC8010F_impl*
end;//TalcuTaskExecutionCounter.Create

procedure TalcuTaskExecutionCounter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53D0ACC8010F_var*
//#UC END# *479731C50290_53D0ACC8010F_var*
begin
//#UC START# *479731C50290_53D0ACC8010F_impl*
 FreeAndNil(f_Task);
 Assert(Counter = 0);
 inherited Cleanup;
//#UC END# *479731C50290_53D0ACC8010F_impl*
end;//TalcuTaskExecutionCounter.Cleanup

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_53D0AC2C0288_var*
//#UC END# *47B2C42A0163_53D0AC2C0288_var*
begin
//#UC START# *47B2C42A0163_53D0AC2C0288_impl*
 Assert(False);
//#UC END# *47B2C42A0163_53D0AC2C0288_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_53D0AC2C0288_var*
//#UC END# *47B99D4503A2_53D0AC2C0288_var*
begin
//#UC START# *47B99D4503A2_53D0AC2C0288_impl*
 Assert(False);
//#UC END# *47B99D4503A2_53D0AC2C0288_impl*
end;//CompareExistingItems

type _Instance_R_ = TalcuTaskExecutingList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // Defined(AppServerSide)

end.
