unit bsHyperlinkProcessorContainerMaker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/bsHyperlinkProcessorContainerMaker.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Navigation::TbsHyperlinkProcessorContainerMaker
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject,
  NavigationInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsHyperlinkProcessorContainerMaker = class(Tl3ProtoObject {$If not defined(NoVCM)}, IvcmContainerMaker{$IfEnd} //not NoVCM
 )
 private
 // private fields
   f_Behaviour : TbsProcessHyperLinkBehaviour;
   f_Helper : Pointer;
 private
 // private methods
   function DoMakeContainer: IvcmContainer;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeContainer: IvcmContainer;
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aBehaviour: TbsProcessHyperLinkBehaviour;
     const aHelper: IbsHyperLinkProcessorHelper); reintroduce;
   class function Make(aBehaviour: TbsProcessHyperLinkBehaviour;
     const aHelper: IbsHyperLinkProcessorHelper): IvcmContainerMaker; reintroduce;
     {* Сигнатура фабрики TbsHyperlinkProcessorContainerMaker.Make }
 end;//TbsHyperlinkProcessorContainerMaker
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsHyperlinkProcessorTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TbsHyperlinkProcessorContainerMaker

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
end;

{$If not defined(NoVCM)}
function TbsHyperlinkProcessorContainerMaker.MakeContainer: IvcmContainer;
//#UC START# *53ABACBB02D0_5417E71801D2_var*
//#UC END# *53ABACBB02D0_5417E71801D2_var*
begin
//#UC START# *53ABACBB02D0_5417E71801D2_impl*
 Result := DoMakeContainer;
//#UC END# *53ABACBB02D0_5417E71801D2_impl*
end;//TbsHyperlinkProcessorContainerMaker.MakeContainer
{$IfEnd} //not NoVCM

procedure TbsHyperlinkProcessorContainerMaker.Cleanup;
//#UC START# *479731C50290_5417E71801D2_var*
//#UC END# *479731C50290_5417E71801D2_var*
begin
//#UC START# *479731C50290_5417E71801D2_impl*
 f_Helper := nil;
 inherited;
//#UC END# *479731C50290_5417E71801D2_impl*
end;//TbsHyperlinkProcessorContainerMaker.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.