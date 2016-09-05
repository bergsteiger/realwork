unit nsMainMenuSectionNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsMainMenuSectionNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsMainMenuSectionNode" MUID: (5707EE3A0158)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsNewCachableNode
 , MainMenuUnit
 , l3Interfaces
 , l3Tree_TLB
 , l3IID
;

type
 TnsMainMenuSectionNode = class(TnsNewCachableNode)
  private
   f_MainMenuSection: IMainMenuSection;
   f_Caption: Il3CString;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
  public
   constructor Create(const aSection: IMainMenuSection); reintroduce;
   class function Make(const aSection: IMainMenuSection): Il3Node; reintroduce;
 end;//TnsMainMenuSectionNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , nsTypes
 , IOUnit
 , l3String
 {$If NOT Defined(NoScripts)}
 , InterfacedNodeWords
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *5707EE3A0158impl_uses*
 //#UC END# *5707EE3A0158impl_uses*
;

constructor TnsMainMenuSectionNode.Create(const aSection: IMainMenuSection);
//#UC START# *5707EEF50342_5707EE3A0158_var*
//#UC END# *5707EEF50342_5707EE3A0158_var*
begin
//#UC START# *5707EEF50342_5707EE3A0158_impl*
 inherited Create(nil);
 f_MainMenuSection := aSection;
//#UC END# *5707EEF50342_5707EE3A0158_impl*
end;//TnsMainMenuSectionNode.Create

class function TnsMainMenuSectionNode.Make(const aSection: IMainMenuSection): Il3Node;
var
 l_Inst : TnsMainMenuSectionNode;
begin
 l_Inst := Create(aSection);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsMainMenuSectionNode.Make

procedure TnsMainMenuSectionNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5707EE3A0158_var*
//#UC END# *479731C50290_5707EE3A0158_var*
begin
//#UC START# *479731C50290_5707EE3A0158_impl*
 f_MainMenuSection := nil;
 f_Caption := nil;
 inherited;
//#UC END# *479731C50290_5707EE3A0158_impl*
end;//TnsMainMenuSectionNode.Cleanup

function TnsMainMenuSectionNode.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_5707EE3A0158_var*
var
 l_S: IString;
//#UC END# *47A869BB02DE_5707EE3A0158_var*
begin
//#UC START# *47A869BB02DE_5707EE3A0158_impl*
 if (f_Caption = nil) then
 begin
  f_MainMenuSection.GetCaption(l_S);
  if (l_S = nil) then
   f_Caption := l3CStr('')
  else
   f_Caption := nsCStr(l_S); 
 end;//f_Caption = nil
 Result := l3PCharLen(f_Caption);
//#UC END# *47A869BB02DE_5707EE3A0158_impl*
end;//TnsMainMenuSectionNode.GetAsPCharLen

function TnsMainMenuSectionNode.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_5707EE3A0158_var*
//#UC END# *4A60B23E00C3_5707EE3A0158_var*
begin
//#UC START# *4A60B23E00C3_5707EE3A0158_impl*
 Result.SetOk;
 if IID.EQ(IMainMenuSection) then
  IMainMenuSection(Obj) := f_MainMenuSection
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_5707EE3A0158_impl*
end;//TnsMainMenuSectionNode.COMQueryInterface
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
