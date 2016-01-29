unit alcuTaskExecutingList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/alcuTaskExecutingList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Server::Managers::alcuTaskExecutingList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  l3ProtoObject,
  l3ProtoDataContainer
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 TalcuTaskExecutionCounter = class(Tl3ProtoObject)
 private
 // private fields
   f_Task : TddProcessTask;
    {* Поле для свойства Task}
   f_Counter : Integer;
    {* Поле для свойства Counter}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTask: TddProcessTask); reintroduce;
 public
 // public properties
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

 PalcuTaskExecutionCounter = ^TalcuTaskExecutionCounter;
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  SysUtils,
  l3Base,
  l3MinMax,
  RTLConsts
  ;

// start class TalcuTaskExecutionCounter

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
//#UC START# *479731C50290_53D0ACC8010F_var*
//#UC END# *479731C50290_53D0ACC8010F_var*
begin
//#UC START# *479731C50290_53D0ACC8010F_impl*
 FreeAndNil(f_Task);
 Assert(Counter = 0);
 inherited Cleanup;
//#UC END# *479731C50290_53D0ACC8010F_impl*
end;//TalcuTaskExecutionCounter.Cleanup
// start class TalcuTaskExecutingList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_53D0AC2C0288_var*
//#UC END# *47B2C42A0163_53D0AC2C0288_var*
begin
//#UC START# *47B2C42A0163_53D0AC2C0288_impl*
 Assert(False);
//#UC END# *47B2C42A0163_53D0AC2C0288_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_53D0AC2C0288_var*
//#UC END# *47B99D4503A2_53D0AC2C0288_var*
begin
//#UC START# *47B99D4503A2_53D0AC2C0288_impl*
 Assert(False);
//#UC END# *47B99D4503A2_53D0AC2C0288_impl*
end;//CompareExistingItems

type _Instance_R_ = TalcuTaskExecutingList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$IfEnd} //AppServerSide
end.