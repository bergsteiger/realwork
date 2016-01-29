unit nsChatMessage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/nsChatMessage.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Chat::Chat::ChatImpl::TnsChatMessage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  l3SimpleObject,
  ChatInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsChatMessage = class(Tl3SimpleObject, InsChatMessage)
 private
 // private fields
   f_Title : IStream;
   f_Body : IStream;
 protected
 // realized methods
   function Get_Title: IStream;
   function Get_Body: IStream;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTitle: IStream;
    const aBody: IStream); reintroduce;
   class function Make(const aTitle: IStream;
    const aBody: IStream): InsChatMessage; reintroduce;
 end;//TnsChatMessage
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsChatMessage

constructor TnsChatMessage.Create(const aTitle: IStream;
  const aBody: IStream);
//#UC START# *4A66EC1A00BB_4A66EB5F010C_var*
//#UC END# *4A66EC1A00BB_4A66EB5F010C_var*
begin
//#UC START# *4A66EC1A00BB_4A66EB5F010C_impl*
 inherited Create;
 f_Title := aTitle;
 f_Body := aBody;
//#UC END# *4A66EC1A00BB_4A66EB5F010C_impl*
end;//TnsChatMessage.Create

class function TnsChatMessage.Make(const aTitle: IStream;
  const aBody: IStream): InsChatMessage;
var
 l_Inst : TnsChatMessage;
begin
 l_Inst := Create(aTitle, aBody);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsChatMessage.Get_Title: IStream;
//#UC START# *4A66DD9D0246_4A66EB5F010Cget_var*
//#UC END# *4A66DD9D0246_4A66EB5F010Cget_var*
begin
//#UC START# *4A66DD9D0246_4A66EB5F010Cget_impl*
 Result := f_Title;
//#UC END# *4A66DD9D0246_4A66EB5F010Cget_impl*
end;//TnsChatMessage.Get_Title

function TnsChatMessage.Get_Body: IStream;
//#UC START# *4A66DDAD0124_4A66EB5F010Cget_var*
//#UC END# *4A66DDAD0124_4A66EB5F010Cget_var*
begin
//#UC START# *4A66DDAD0124_4A66EB5F010Cget_impl*
 Result := f_Body;
//#UC END# *4A66DDAD0124_4A66EB5F010Cget_impl*
end;//TnsChatMessage.Get_Body

procedure TnsChatMessage.Cleanup;
//#UC START# *479731C50290_4A66EB5F010C_var*
//#UC END# *479731C50290_4A66EB5F010C_var*
begin
//#UC START# *479731C50290_4A66EB5F010C_impl*
 f_Title := nil;
 f_Body := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4A66EB5F010C_impl*
end;//TnsChatMessage.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.