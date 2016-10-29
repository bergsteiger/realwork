unit msmListModelPrim;

// Модуль: "w:\common\components\gui\Garant\msm\msmListModelPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListModelPrim" MUID: (57B189990202)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeModel
 , msmConcreteModels
 , msmElementViews
 , msmModelElements
 , msmEvents
 , msmEventList
 , msmEventHandlers
;

type
 _msmEventsSubscriberPrim_Parent_ = TmsmListLikeModel;
 {$Include w:\common\components\gui\Garant\msm\msmEventsSubscriberPrim.imp.pas}
 TmsmListModelPrim = {abstract} class(_msmEventsSubscriberPrim_, ImsmListModel)
  private
   f_List: ImsmModelElementStringList;
  protected
   f_SubElementName: AnsiString;
  protected
   procedure CheckUnexisting(const anElement: ImsmModelElement;
    var theNewElement: ImsmModelElement;
    var theElementToSelect: ImsmModelElement); virtual;
   function DoGetList: ImsmModelElementStringList; override;
   procedure DoShowElementAsList(const anElement: ImsmModelElement); override;
   procedure SetList(const aList: ImsmModelElementStringList);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoGetCaption: AnsiString; override;
   procedure DoHandleEvent(anEvent: TmsmEvent); override;
   procedure ClearFields; override;
 end;//TmsmListModelPrim

implementation

uses
 l3ImplUses
 , msmModelElementStringList
 , msmListAndTreeInterfaces
 {$If NOT Defined(NoScripts)}
 , tfwWordRefList
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordsIterator
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3String
 //#UC START# *57B189990202impl_uses*
 //#UC END# *57B189990202impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmEventsSubscriberPrim.imp.pas}

procedure TmsmListModelPrim.CheckUnexisting(const anElement: ImsmModelElement;
 var theNewElement: ImsmModelElement;
 var theElementToSelect: ImsmModelElement);
//#UC START# *57F79A4F032E_57B189990202_var*
var
 l_Parent : ImsmModelElement;
//#UC END# *57F79A4F032E_57B189990202_var*
begin
//#UC START# *57F79A4F032E_57B189990202_impl*
 l_Parent := anElement.Parent;
 while (theNewElement = nil) AND (l_Parent <> nil) do
 begin
  theNewElement := l_Parent.ElementProp[f_SubElementName];
  if (theNewElement <> nil) then
   break;
  theElementToSelect := l_Parent; 
  l_Parent := l_Parent.Parent;
 end;//theNewElement = nil
//#UC END# *57F79A4F032E_57B189990202_impl*
end;//TmsmListModelPrim.CheckUnexisting

function TmsmListModelPrim.DoGetList: ImsmModelElementStringList;
//#UC START# *57D271E300C2_57B189990202_var*
//#UC END# *57D271E300C2_57B189990202_var*
begin
//#UC START# *57D271E300C2_57B189990202_impl*
 Result := f_List;
//#UC END# *57D271E300C2_57B189990202_impl*
end;//TmsmListModelPrim.DoGetList

procedure TmsmListModelPrim.DoShowElementAsList(const anElement: ImsmModelElement);
//#UC START# *57D2A7D900FE_57B189990202_var*
var
 l_NewElement : ImsmModelElement;
 l_ElementToSelect : ImsmModelElement;
//#UC END# *57D2A7D900FE_57B189990202_var*
begin
//#UC START# *57D2A7D900FE_57B189990202_impl*
 if (anElement = nil) then
 begin
  f_ElementView.rElement := nil;
  Self.SetList(nil);
  Exit;
 end;//anElement = nil

 if (f_ElementView.rElement <> nil)
    AND f_ElementView.rElement.IsSameElement(anElement)
    AND (f_List <> nil) then
  Exit;

 l_NewElement := anElement;

 if f_ElementView.rIsDir then
 begin
  Assert(f_SubElementName = '');
  if l_NewElement.BoolProp['IsSomeView'] then
   l_NewElement := l_NewElement.ElementProp['Viewed'];
 end//f_ElementView.rIsDir
 else
 begin
  if (f_SubElementName <> '') then
  begin
   l_NewElement := l_NewElement.ElementProp[f_SubElementName];
   if (l_NewElement = nil) then
   // - тут ищем диаграмму от родителя
   begin
    l_ElementToSelect := anElement;
    CheckUnexisting(anElement, l_NewElement, l_ElementToSelect);
   end;//l_NewElement = nil
  end;//f_SubElementName <> ''
 end;//f_ElementView.rIsDir

 if (f_ElementView.rElement <> nil)
    AND f_ElementView.rElement.IsSameElement(l_NewElement)
    AND (f_List <> nil) then
  Exit;
  
 f_ElementView.rElement := l_NewElement;
 if (f_ElementView.rElement = nil) then
  Self.SetList(nil)
 else
 if f_ElementView.rIsDir then
  Self.SetList(TmsmModelElementStringList.Make(f_ElementView.ChangeIsDir(true)))
 else
  Self.SetList(TmsmModelElementStringList.Make(f_ElementView.ChangeIsDir(false)));
 if (l_ElementToSelect <> nil) then
  Set_CurrentElement(l_ElementToSelect); 
//#UC END# *57D2A7D900FE_57B189990202_impl*
end;//TmsmListModelPrim.DoShowElementAsList

procedure TmsmListModelPrim.SetList(const aList: ImsmModelElementStringList);
//#UC START# *57E54FA00289_57B189990202_var*
//#UC END# *57E54FA00289_57B189990202_var*
begin
//#UC START# *57E54FA00289_57B189990202_impl*
 if (f_List <> aList) then
 begin
  if (f_List <> nil) then
   f_List.As_ImsmEventsPublisher.RemoveEventsSubscriber(Self);
  f_List := aList;
  if (f_List <> nil) then
   f_List.As_ImsmEventsPublisher.AddEventsSubscriber(Self);
  Self.Fire(ListChangedEvent.Instance);
 end;//f_StringList <> aList
//#UC END# *57E54FA00289_57B189990202_impl*
end;//TmsmListModelPrim.SetList

procedure TmsmListModelPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B189990202_var*
//#UC END# *479731C50290_57B189990202_var*
begin
//#UC START# *479731C50290_57B189990202_impl*
 SetList(nil);
 inherited;
//#UC END# *479731C50290_57B189990202_impl*
end;//TmsmListModelPrim.Cleanup

function TmsmListModelPrim.DoGetCaption: AnsiString;
//#UC START# *57E331B90378_57B189990202_var*
//#UC END# *57E331B90378_57B189990202_var*
begin
//#UC START# *57E331B90378_57B189990202_impl*
 if (f_SubElementName = '') OR (f_SubElementName = 'Viewed') then
  Result := inherited DoGetCaption
 else
 if (f_ElementView.rElement <> nil) then
  Result := l3Str(f_ElementView.rElement.Name)
 else
  Result := f_SubElementName; 
//#UC END# *57E331B90378_57B189990202_impl*
end;//TmsmListModelPrim.DoGetCaption

procedure TmsmListModelPrim.DoHandleEvent(anEvent: TmsmEvent);
//#UC START# *580A1AD9019C_57B189990202_var*
//#UC END# *580A1AD9019C_57B189990202_var*
begin
//#UC START# *580A1AD9019C_57B189990202_impl*
 inherited;
 Self.Fire(anEvent);
//#UC END# *580A1AD9019C_57B189990202_impl*
end;//TmsmListModelPrim.DoHandleEvent

procedure TmsmListModelPrim.ClearFields;
begin
 f_List := nil;
 inherited;
end;//TmsmListModelPrim.ClearFields

end.
