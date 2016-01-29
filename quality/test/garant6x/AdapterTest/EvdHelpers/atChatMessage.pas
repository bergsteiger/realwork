unit atChatMessage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/EvdHelpers/atChatMessage.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::EvdHelpers::TatChatMessage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atBaseEvdHelper,
  evdNativeWriter
  ;

type
 IatChatMessage = interface(IUnknown)
   ['{3CB60B5E-38D0-4476-80FB-C4338CE4D13E}']
   function Get_ChatMessage: AnsiString;
   procedure Set_ChatMessage(const aValue: AnsiString);
   property ChatMessage: AnsiString
     read Get_ChatMessage
     write Set_ChatMessage;
 end;//IatChatMessage

 TatChatMessage = class(TatBaseEvdHelper, IatChatMessage)
 private
 // private fields
   f_ChatMessage : AnsiString;
 protected
 // realized methods
   procedure DoGenerate(anEVDNativeWriter: TevdNativeWriter); override;
   function Get_ChatMessage: AnsiString;
   procedure Set_ChatMessage(const aValue: AnsiString);
 public
 // public methods
   class function Make: IatChatMessage; reintroduce;
 end;//TatChatMessage

implementation

uses
  TextPara_Const,
  k2Tags
  ;

// start class TatChatMessage

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
end;

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