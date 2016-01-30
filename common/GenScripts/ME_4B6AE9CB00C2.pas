unit atChatMessage;

// Модуль: "w:\quality\test\garant6x\AdapterTest\EvdHelpers\atChatMessage.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atBaseEvdHelper
 , evdNativeWriter
;

type
 IatChatMessage = interface
  ['{3CB60B5E-38D0-4476-80FB-C4338CE4D13E}']
  function Get_ChatMessage: AnsiString;
  procedure Set_ChatMessage(const aValue: AnsiString);
  property ChatMessage: AnsiString
   read Get_ChatMessage
   write Set_ChatMessage;
 end;//IatChatMessage

 TatChatMessage = class(TatBaseEvdHelper, IatChatMessage)
  private
   f_ChatMessage: AnsiString;
  protected
   procedure DoGenerate(anEVDNativeWriter: TevdNativeWriter); override;
   function Get_ChatMessage: AnsiString;
   procedure Set_ChatMessage(const aValue: AnsiString);
  public
   class function Make: IatChatMessage; reintroduce;
 end;//TatChatMessage

implementation

uses
 l3ImplUses
 , TextPara_Const
 , k2Tags
;

class function TatChatMessage.Make: IatChatMessage;
var
 l_Inst : TatChatMessage;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TatChatMessage.Make

procedure TatChatMessage.DoGenerate(anEVDNativeWriter: TevdNativeWriter);
//#UC START# *4B6AE81E0267_4B6AE9CB00C2_var*
//#UC END# *4B6AE81E0267_4B6AE9CB00C2_var*
begin
//#UC START# *4B6AE81E0267_4B6AE9CB00C2_impl*
  with anEVDNativeWriter do
  begin
    Binary := true;
    Start;
      StartChild(k2_typTextPara);
        AddStringAtom(k2_tiText, f_ChatMessage);
      Finish;
    Finish;
  end;
//#UC END# *4B6AE81E0267_4B6AE9CB00C2_impl*
end;//TatChatMessage.DoGenerate

function TatChatMessage.Get_ChatMessage: AnsiString;
//#UC START# *4B6AEA0B018F_4B6AE9CB00C2get_var*
//#UC END# *4B6AEA0B018F_4B6AE9CB00C2get_var*
begin
//#UC START# *4B6AEA0B018F_4B6AE9CB00C2get_impl*
  Result := f_ChatMessage;
//#UC END# *4B6AEA0B018F_4B6AE9CB00C2get_impl*
end;//TatChatMessage.Get_ChatMessage

procedure TatChatMessage.Set_ChatMessage(const aValue: AnsiString);
//#UC START# *4B6AEA0B018F_4B6AE9CB00C2set_var*
//#UC END# *4B6AEA0B018F_4B6AE9CB00C2set_var*
begin
//#UC START# *4B6AEA0B018F_4B6AE9CB00C2set_impl*
  f_ChatMessage := aValue;
  Generate();
//#UC END# *4B6AEA0B018F_4B6AE9CB00C2set_impl*
end;//TatChatMessage.Set_ChatMessage

end.
