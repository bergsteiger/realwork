unit NOT_FINISHED_nsWindowsListPrim;
 {* класс управляющий списком окон }

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\NOT_FINISHED_nsWindowsListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsWindowsListPrim" MUID: (4ADC5146016D)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3Tree_TLB
 , l3Interfaces
 , OfficeLikeAppInterfaces
 , vcmInterfaces
 , vcmEntityForm
 , l3TabbedContainersDispatcher
 , l3Core
;

type
 TnsUniqueName = class(Tl3ProtoObject)
  {* класс позволяющий получать уникальные имена в списке благодаря добавлению в конце повторяющихся слов значение счетчика повторения. Например Слово, Слово (1), Слово (2) и т.д }
  private
   function MakeName(const aName: Il3CString): Il3CString;
    {* возвращает уникальное имя }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
 end;//TnsUniqueName

 _vcmTabbedContainersListener_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainersListener.imp.pas}
 TnsWindowsListPrim = class(_vcmTabbedContainersListener_)
  {* класс управляющий списком окон }
  private
   f_Root: Il3Node;
    {* Поле для свойства Root }
  private
   function CheckLength(const aName: Il3CString): Il3CString;
    {* проверяет не выходит ли размер имени за допустимые пределы и корректирует при необходимости }
   function nsGetWindowCaption(aForm: TvcmEntityForm): Il3CString;
    {* отрезает префикс оставляю только информацию о текущем контенте, а именно _caption формы находящейся в Parent зоне главной формы }
  protected
   function pm_GetRoot: Il3Node;
   {$If NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   procedure ContainersChanged(aNotification: Tl3TabbedContainerNotificationType); override;
   {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   function FindNode(const aForm: IvcmEntityForm): Il3Node;
    {* возвращает Il3Node для формы aForm }
   procedure Remove(const aForm: IvcmEntityForm);
    {* удаляет форму из списка }
   procedure Reload;
    {* перезагружает список }
  public
   property Root: Il3Node
    read pm_GetRoot;
    {* Root дерева окон. Загружается при первом обращении }
 end;//TnsWindowsListPrim
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmMainForm
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , l3String
 , l3NodesModelPart
 , SysUtils
 , vcmBase
 , nsWindowNode
 , l3Chars
 , vcmStringList
;

function TnsUniqueName.MakeName(const aName: Il3CString): Il3CString;
 {* возвращает уникальное имя }
var l_PInt: PInteger;
var l_Indx: Integer;
//#UC START# *4ADC560A0041_4ADC55470317_var*
//#UC END# *4ADC560A0041_4ADC55470317_var*
begin
//#UC START# *4ADC560A0041_4ADC55470317_impl*
 Result := aName;
 l_Indx := f_Unique.IndexOf(Result);
 if (l_Indx = -1) then
 begin
  New(l_PInt);
  l_PInt^ := 0;
  f_Unique.AddObject(aName, TObject(l_PInt));
 end//l_Indx = -1
 else
 begin
  l_PInt := PInteger(f_Unique.Objects[l_Indx]);
  Inc(l_PInt^);
  Result := l3Fmt('%s (%d)', [aName, l_PInt^]);
 end;//l_Indx = -1
//#UC END# *4ADC560A0041_4ADC55470317_impl*
end;//TnsUniqueName.MakeName

constructor TnsUniqueName.Create;
//#UC START# *4ADC55A200AD_4ADC55470317_var*
//#UC END# *4ADC55A200AD_4ADC55470317_var*
begin
//#UC START# *4ADC55A200AD_4ADC55470317_impl*
 inherited Create;
 f_Unique := TvcmStringList.Make;
//#UC END# *4ADC55A200AD_4ADC55470317_impl*
end;//TnsUniqueName.Create

procedure TnsUniqueName.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4ADC55470317_var*
var
 lIndex : Integer;
 lPInt  : PInteger;
//#UC END# *479731C50290_4ADC55470317_var*
begin
//#UC START# *479731C50290_4ADC55470317_impl*
 for lIndex := 0 to Pred(f_Unique.Count) do
 begin
  lPInt := PInteger(f_Unique.Objects[lIndex]);
  Dispose(lPInt);
 end;
 f_Unique := nil;
 inherited;
//#UC END# *479731C50290_4ADC55470317_impl*
end;//TnsUniqueName.Cleanup

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainersListener.imp.pas}

function TnsWindowsListPrim.pm_GetRoot: Il3Node;
//#UC START# *4ADC531F03B4_4ADC5146016Dget_var*
//#UC END# *4ADC531F03B4_4ADC5146016Dget_var*
begin
//#UC START# *4ADC531F03B4_4ADC5146016Dget_impl*
 if not Assigned(f_Root) then
  Reload;
 Result := f_Root;
//#UC END# *4ADC531F03B4_4ADC5146016Dget_impl*
end;//TnsWindowsListPrim.pm_GetRoot

function TnsWindowsListPrim.CheckLength(const aName: Il3CString): Il3CString;
 {* проверяет не выходит ли размер имени за допустимые пределы и корректирует при необходимости }
//#UC START# *4ADC538702FA_4ADC5146016D_var*
const
 cMaxWordLength = 70;
   {* - максимальная длинна слова в списке. }
//#UC END# *4ADC538702FA_4ADC5146016D_var*
begin
//#UC START# *4ADC538702FA_4ADC5146016D_impl*
 if (l3Len(aName) > cMaxWordLength) then
  Result := l3Cat(l3Copy(aName, 0, cMaxWordLength - 3), '...')
 else
  Result := aName;
//#UC END# *4ADC538702FA_4ADC5146016D_impl*
end;//TnsWindowsListPrim.CheckLength

function TnsWindowsListPrim.FindNode(const aForm: IvcmEntityForm): Il3Node;
 {* возвращает Il3Node для формы aForm }
var l_Window: InsWindow;
//#UC START# *4ADC54290390_4ADC5146016D_var*
//#UC END# *4ADC54290390_4ADC5146016D_var*
begin
//#UC START# *4ADC54290390_4ADC5146016D_impl*
 Result := nil;
 if Assigned(f_Root) then
 begin
  l_Child := f_Root.ChildNode;
  while Assigned(l_Child) do
  begin
   if Supports(l_Child, InsWindow, l_Window) then
   try
    if l_Window.Form = aForm then
    begin
     Result := l_Child;
     Break;
    end;
   finally
    l_Window := nil;
   end;
   if l_Child.IsLast then
    l_Child := nil
   else
    l_Child := l_Child.NextNode;
  end;
 end;
//#UC END# *4ADC54290390_4ADC5146016D_impl*
end;//TnsWindowsListPrim.FindNode

procedure TnsWindowsListPrim.Remove(const aForm: IvcmEntityForm);
 {* удаляет форму из списка }
var l_Node: Il3Node;
//#UC START# *4ADC5467036A_4ADC5146016D_var*
//#UC END# *4ADC5467036A_4ADC5146016D_var*
begin
//#UC START# *4ADC5467036A_4ADC5146016D_impl*
 l_Node := FindNode(aForm);
 if Assigned(l_Node) then
  l_Node.Remove;
//#UC END# *4ADC5467036A_4ADC5146016D_impl*
end;//TnsWindowsListPrim.Remove

procedure TnsWindowsListPrim.Reload;
 {* перезагружает список }
var l_Unique: TnsUniqueName;
var l_Index: Integer;
var l_MainForm: IvcmEntityForm;
//#UC START# *4ADC54070106_4ADC5146016D_var*
//#UC END# *4ADC54070106_4ADC5146016D_var*
begin
//#UC START# *4ADC54070106_4ADC5146016D_impl*
 f_Root := nil;
 l_Unique := TnsUniqueName.Create;
 try
  f_Root := Tl3PlaceNode.Make;
  {$If not defined(Admin) AND not defined(Monitorings)}
  for l_Index := 0 to Pred(TvcmTabbedContainerFormDispatcher.Instance.MainFormsCount) do
  begin
   l_MainForm := TvcmTabbedContainerFormDispatcher.Instance.MainForms[l_Index];
   if (l_MainForm <> nil) then
   try
    f_Root.InsertChild(TnsWindowNode.Make(
     l_MainForm, l3PCharLen(l_Unique.MakeName(CheckLength(
      nsGetWindowCaption(l_MainForm.VCLWinControl As TvcmEntityForm))))));
   finally
    l_MainForm := nil;
   end;//try..finally
  end;//for l_Index := 0...
  {$Else}
  for l_Index := 0 to Pred(vcmDispatcher.FormDispatcher.MainFormsCount) do
   with vcmDispatcher.FormDispatcher do
    f_Root.InsertChild(TnsWindowNode.Make(
      MainForm[l_Index],
      l3PCharLen(l_Unique.MakeName(CheckLength(
        nsGetWindowCaption((MainForm[l_Index].VCLWinControl As TvcmMainForm)))))));
  {$IfEnd} //not Admin AND not Monitorings
 finally
  FreeAndNil(l_Unique);
 end;//try..finally
//#UC END# *4ADC54070106_4ADC5146016D_impl*
end;//TnsWindowsListPrim.Reload

function TnsWindowsListPrim.nsGetWindowCaption(aForm: TvcmEntityForm): Il3CString;
 {* отрезает префикс оставляю только информацию о текущем контенте, а именно _caption формы находящейся в Parent зоне главной формы }
//#UC START# *4ADC564B01E9_4ADC5146016D_var*
//#UC END# *4ADC564B01E9_4ADC5146016D_var*
begin
//#UC START# *4ADC564B01E9_4ADC5146016D_impl*
 if (aForm is TvcmMainForm) then
  Result := l3StringReplace(aForm.CCaption, l3PCharLen(TvcmMainForm(aForm).CaptionPrefix), l3PCharLen(''), [rfReplaceAll])
 else
  Result := aForm.CCaption;
 Result := l3LTrim(Result, cc_AllChars - cc_ANSILetter);
//#UC END# *4ADC564B01E9_4ADC5146016D_impl*
end;//TnsWindowsListPrim.nsGetWindowCaption

{$If NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
procedure TnsWindowsListPrim.ContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
//#UC START# *53DF430F028E_4ADC5146016D_var*
//#UC END# *53DF430F028E_4ADC5146016D_var*
begin
//#UC START# *53DF430F028E_4ADC5146016D_impl*
 if aNotification = tcnTabChanged then
  Reload;
//#UC END# *53DF430F028E_4ADC5146016D_impl*
end;//TnsWindowsListPrim.ContainersChanged
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

procedure TnsWindowsListPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4ADC5146016D_var*
//#UC END# *479731C50290_4ADC5146016D_var*
begin
//#UC START# *479731C50290_4ADC5146016D_impl*
 f_Root := nil;
 inherited;
//#UC END# *479731C50290_4ADC5146016D_impl*
end;//TnsWindowsListPrim.Cleanup

procedure TnsWindowsListPrim.ClearFields;
begin
 f_Root := nil;
 inherited;
end;//TnsWindowsListPrim.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
