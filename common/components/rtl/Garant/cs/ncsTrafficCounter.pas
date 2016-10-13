unit ncsTrafficCounter;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTrafficCounter.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ncsTrafficCounter" MUID: (57F3833101A7)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3StopWatch
 , l3ProtoObject
;

type
 IncsTrafficCounter = interface
  ['{A75CEBEC-F0A7-4C0F-9464-84EDD9E2013E}']
  function Get_BytesProcessed: Int64;
  function Get_ProcessingTime: TDateTime;
  procedure Reset;
  procedure DoProgress(aDelta: Int64);
  procedure AddWatch(const aWatch: Tl3StopWatch);
  property BytesProcessed: Int64
   read Get_BytesProcessed;
  property ProcessingTime: TDateTime
   read Get_ProcessingTime;
 end;//IncsTrafficCounter

 TncsTrafficCounter = class(Tl3ProtoObject, IncsTrafficCounter)
  private
   f_Counter: Int64;
   f_Watch: Tl3StopWatch;
  protected
   function Get_BytesProcessed: Int64;
   procedure Reset;
   procedure DoProgress(aDelta: Int64);
   function Get_ProcessingTime: TDateTime;
   procedure AddWatch(const aWatch: Tl3StopWatch);
  public
   constructor Create; reintroduce;
   class function Make: IncsTrafficCounter; reintroduce;
 end;//TncsTrafficCounter
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *57F3833101A7impl_uses*
 //#UC END# *57F3833101A7impl_uses*
;

constructor TncsTrafficCounter.Create;
//#UC START# *57F383A802EA_57F3830802F2_var*
//#UC END# *57F383A802EA_57F3830802F2_var*
begin
//#UC START# *57F383A802EA_57F3830802F2_impl*
 inherited;
 f_Counter := 0;
//#UC END# *57F383A802EA_57F3830802F2_impl*
end;//TncsTrafficCounter.Create

class function TncsTrafficCounter.Make: IncsTrafficCounter;
var
 l_Inst : TncsTrafficCounter;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsTrafficCounter.Make

function TncsTrafficCounter.Get_BytesProcessed: Int64;
//#UC START# *57F382B203A9_57F3830802F2get_var*
//#UC END# *57F382B203A9_57F3830802F2get_var*
begin
//#UC START# *57F382B203A9_57F3830802F2get_impl*
 Result := f_Counter;
//#UC END# *57F382B203A9_57F3830802F2get_impl*
end;//TncsTrafficCounter.Get_BytesProcessed

procedure TncsTrafficCounter.Reset;
//#UC START# *57F382CC017D_57F3830802F2_var*
//#UC END# *57F382CC017D_57F3830802F2_var*
begin
//#UC START# *57F382CC017D_57F3830802F2_impl*
 f_Counter := 0;
 f_Watch.Reset;
//#UC END# *57F382CC017D_57F3830802F2_impl*
end;//TncsTrafficCounter.Reset

procedure TncsTrafficCounter.DoProgress(aDelta: Int64);
//#UC START# *57F382DC01D1_57F3830802F2_var*
//#UC END# *57F382DC01D1_57F3830802F2_var*
begin
//#UC START# *57F382DC01D1_57F3830802F2_impl*
 Inc(f_Counter, aDelta);
//#UC END# *57F382DC01D1_57F3830802F2_impl*
end;//TncsTrafficCounter.DoProgress

function TncsTrafficCounter.Get_ProcessingTime: TDateTime;
//#UC START# *57FB5C8F0014_57F3830802F2get_var*
//#UC END# *57FB5C8F0014_57F3830802F2get_var*
begin
//#UC START# *57FB5C8F0014_57F3830802F2get_impl*
 Result := f_Watch.Time;
//#UC END# *57FB5C8F0014_57F3830802F2get_impl*
end;//TncsTrafficCounter.Get_ProcessingTime

procedure TncsTrafficCounter.AddWatch(const aWatch: Tl3StopWatch);
//#UC START# *57FB5CB90232_57F3830802F2_var*
//#UC END# *57FB5CB90232_57F3830802F2_var*
begin
//#UC START# *57FB5CB90232_57F3830802F2_impl*
 f_Watch.Add(aWatch);
//#UC END# *57FB5CB90232_57F3830802F2_impl*
end;//TncsTrafficCounter.AddWatch
{$IfEnd} // NOT Defined(Nemesis)

end.
