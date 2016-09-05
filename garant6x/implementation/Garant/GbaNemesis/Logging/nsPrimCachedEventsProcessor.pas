unit nsPrimCachedEventsProcessor;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsPrimCachedEventsProcessor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsPrimCachedEventsProcessor" MUID: (4B139F5C025B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , LoggingInterfaces
 , InsDefferedEventList
;

type
 TnsPrimCachedEventsProcessor = class(Tl3SimpleObject, InsCachedEventsProcessor)
  private
   f_List: TInsDefferedEventList;
   f_CacheWasWritten: TDateTime;
  private
   procedure Notify;
  protected
   constructor Create; reintroduce;
   procedure RegisterEvent(const aEvent: InsDefferedEvent);
   procedure RequestWriteCache;
   procedure ForceWriteCache;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make: InsCachedEventsProcessor; reintroduce;
 end;//TnsPrimCachedEventsProcessor

implementation

uses
 l3ImplUses
 , DateUtils
 , SysUtils
 //#UC START# *4B139F5C025Bimpl_uses*
 //#UC END# *4B139F5C025Bimpl_uses*
;

procedure TnsPrimCachedEventsProcessor.Notify;
//#UC START# *4B139F9D008C_4B139F5C025B_var*
var
 l_IDX: Integer;
//#UC END# *4B139F9D008C_4B139F5C025B_var*
begin
//#UC START# *4B139F9D008C_4B139F5C025B_impl*
 for l_IDX := 0 to f_List.Count - 1 do
  f_List[l_IDX].FireLog;
//#UC END# *4B139F9D008C_4B139F5C025B_impl*
end;//TnsPrimCachedEventsProcessor.Notify

constructor TnsPrimCachedEventsProcessor.Create;
//#UC START# *4B139FDA0182_4B139F5C025B_var*
//#UC END# *4B139FDA0182_4B139F5C025B_var*
begin
//#UC START# *4B139FDA0182_4B139F5C025B_impl*
 inherited Create;
 f_CacheWasWritten := Now;
 f_List := TInsDefferedEventList.MakeSorted;
//#UC END# *4B139FDA0182_4B139F5C025B_impl*
end;//TnsPrimCachedEventsProcessor.Create

class function TnsPrimCachedEventsProcessor.Make: InsCachedEventsProcessor;
var
 l_Inst : TnsPrimCachedEventsProcessor;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsPrimCachedEventsProcessor.Make

procedure TnsPrimCachedEventsProcessor.RegisterEvent(const aEvent: InsDefferedEvent);
//#UC START# *4B139E6B00C1_4B139F5C025B_var*
//#UC END# *4B139E6B00C1_4B139F5C025B_var*
begin
//#UC START# *4B139E6B00C1_4B139F5C025B_impl*
 f_List.Add(aEvent);
//#UC END# *4B139E6B00C1_4B139F5C025B_impl*
end;//TnsPrimCachedEventsProcessor.RegisterEvent

procedure TnsPrimCachedEventsProcessor.RequestWriteCache;
//#UC START# *4B139E860009_4B139F5C025B_var*
const
 c_emFreqWriteInHours = 1;
//#UC END# *4B139E860009_4B139F5C025B_var*
begin
//#UC START# *4B139E860009_4B139F5C025B_impl*
 if HoursBetween(f_CacheWasWritten, Now) >= c_emFreqWriteInHours then
 begin
  Notify;
  f_CacheWasWritten := Now;
 end;
//#UC END# *4B139E860009_4B139F5C025B_impl*
end;//TnsPrimCachedEventsProcessor.RequestWriteCache

procedure TnsPrimCachedEventsProcessor.ForceWriteCache;
//#UC START# *56D435B2018B_4B139F5C025B_var*
//#UC END# *56D435B2018B_4B139F5C025B_var*
begin
//#UC START# *56D435B2018B_4B139F5C025B_impl*
 Notify;
//#UC END# *56D435B2018B_4B139F5C025B_impl*
end;//TnsPrimCachedEventsProcessor.ForceWriteCache

procedure TnsPrimCachedEventsProcessor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B139F5C025B_var*
//#UC END# *479731C50290_4B139F5C025B_var*
begin
//#UC START# *479731C50290_4B139F5C025B_impl*
 Notify;
 FreeAndNil(f_List);
 inherited Cleanup;
//#UC END# *479731C50290_4B139F5C025B_impl*
end;//TnsPrimCachedEventsProcessor.Cleanup

end.
