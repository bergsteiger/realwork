unit nsChatMessage;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatMessage.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsChatMessage" MUID: (4A66EB5F010C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , ChatInterfaces
 , l3Interfaces
;

type
 TnsChatMessage = class(Tl3SimpleObject, InsChatMessage)
  private
   f_Title: IStream;
   f_Body: IStream;
  protected
   function Get_Title: IStream;
   function Get_Body: IStream;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTitle: IStream;
    const aBody: IStream); reintroduce;
   class function Make(const aTitle: IStream;
    const aBody: IStream): InsChatMessage; reintroduce;
 end;//TnsChatMessage
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4A66EB5F010Cimpl_uses*
 //#UC END# *4A66EB5F010Cimpl_uses*
;

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
end;//TnsChatMessage.Make

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A66EB5F010C_var*
//#UC END# *479731C50290_4A66EB5F010C_var*
begin
//#UC START# *479731C50290_4A66EB5F010C_impl*
 f_Title := nil;
 f_Body := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4A66EB5F010C_impl*
end;//TnsChatMessage.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
