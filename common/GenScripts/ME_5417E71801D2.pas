unit bsHyperlinkProcessorContainerMaker;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\bsHyperlinkProcessorContainerMaker.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TbsHyperlinkProcessorContainerMaker" MUID: (5417E71801D2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , NavigationInterfaces
;

type
 TbsHyperlinkProcessorContainerMaker = class(Tl3ProtoObject{$If NOT Defined(NoVCM)}
 , IvcmContainerMaker
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_Behaviour: TbsProcessHyperLinkBehaviour;
   f_Helper: Pointer;
  private
   function DoMakeContainer: IvcmContainer;
  protected
   {$If NOT Defined(NoVCM)}
   function MakeContainer: IvcmContainer;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aBehaviour: TbsProcessHyperLinkBehaviour;
    const aHelper: IbsHyperLinkProcessorHelper); reintroduce;
   class function Make(aBehaviour: TbsProcessHyperLinkBehaviour;
    const aHelper: IbsHyperLinkProcessorHelper): IvcmContainerMaker; reintroduce;
 end;//TbsHyperlinkProcessorContainerMaker
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsHyperlinkProcessorTypes
;

function TbsHyperlinkProcessorContainerMaker.DoMakeContainer: IvcmContainer;
//#UC START# *5417E8EB032B_5417E71801D2_var*
var
 l_Helper: IbsHyperLinkProcessorHelper;
//#UC END# *5417E8EB032B_5417E71801D2_var*
begin
//#UC START# *5417E8EB032B_5417E71801D2_impl*
 Assert(f_Helper <> nil);
 l_Helper := IbsHyperLinkProcessorHelper(f_Helper);
 try
  Result := nil;
  case f_Behaviour of
   phbInSameContainer:
    Result := l_Helper.MakeContainer;
   phbInNewTabActivate, phbInNewTabNoActivate:
    Result := l_Helper.MakeTabbedContainer(f_Behaviour = phbInNewTabActivate);
   phbInNewWindow:
    Result := l_Helper.MakeNewMainWindow;
  end;
 finally
  l_Helper := nil;
 end;
//#UC END# *5417E8EB032B_5417E71801D2_impl*
end;//TbsHyperlinkProcessorContainerMaker.DoMakeContainer

constructor TbsHyperlinkProcessorContainerMaker.Create(aBehaviour: TbsProcessHyperLinkBehaviour;
 const aHelper: IbsHyperLinkProcessorHelper);
//#UC START# *5417E940038E_5417E71801D2_var*
//#UC END# *5417E940038E_5417E71801D2_var*
begin
//#UC START# *5417E940038E_5417E71801D2_impl*
 inherited Create;
 f_Behaviour := aBehaviour;
 f_Helper := Pointer(aHelper);
//#UC END# *5417E940038E_5417E71801D2_impl*
end;//TbsHyperlinkProcessorContainerMaker.Create

class function TbsHyperlinkProcessorContainerMaker.Make(aBehaviour: TbsProcessHyperLinkBehaviour;
 const aHelper: IbsHyperLinkProcessorHelper): IvcmContainerMaker;
var
 l_Inst : TbsHyperlinkProcessorContainerMaker;
begin
 l_Inst := Create(aBehaviour, aHelper);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsHyperlinkProcessorContainerMaker.Make

{$If NOT Defined(NoVCM)}
function TbsHyperlinkProcessorContainerMaker.MakeContainer: IvcmContainer;
//#UC START# *53ABACBB02D0_5417E71801D2_var*
//#UC END# *53ABACBB02D0_5417E71801D2_var*
begin
//#UC START# *53ABACBB02D0_5417E71801D2_impl*
 Result := DoMakeContainer;
//#UC END# *53ABACBB02D0_5417E71801D2_impl*
end;//TbsHyperlinkProcessorContainerMaker.MakeContainer
{$IfEnd} // NOT Defined(NoVCM)

procedure TbsHyperlinkProcessorContainerMaker.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5417E71801D2_var*
//#UC END# *479731C50290_5417E71801D2_var*
begin
//#UC START# *479731C50290_5417E71801D2_impl*
 f_Helper := nil;
 inherited;
//#UC END# *479731C50290_5417E71801D2_impl*
end;//TbsHyperlinkProcessorContainerMaker.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
