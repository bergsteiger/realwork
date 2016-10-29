unit msmModelElementStringList;
 {* Список содержимого элемента в виде директории }

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementStringList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementStringList" MUID: (57B1674A02B6)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmViewOfModelElement
 , msmElementViews
 , msmModelElements
 , l3Interfaces
 , msmEvents
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , ImsmEventsSubscriberList
 , msmEventList
 , msmEventHandlers
;

type
 _msmEventsPublisher_Parent_ = TmsmViewOfModelElement;
 {$Include w:\common\components\gui\Garant\msm\msmEventsPublisher.imp.pas}
 _msmEventFire_Parent_ = _msmEventsPublisher_;
 {$Include w:\common\components\gui\Garant\msm\msmEventFire.imp.pas}
 _msmEventsSubscriber_Parent_ = _msmEventFire_;
 {$Include w:\common\components\gui\Garant\msm\msmEventsSubscriber.imp.pas}
 TmsmModelElementStringList = class(_msmEventsSubscriber_, ImsmModelElementStringList, ImsmEventsPublisher)
  {* Список содержимого элемента в виде директории }
  private
   f_List: ImsmModelElementList;
   f_Parent: ImsmModelElement;
  protected
   function IsDir: Boolean;
   function As_ImsmEventsPublisher: ImsmEventsPublisher;
    {* Метод приведения нашего интерфейса к ImsmEventsPublisher }
   function Get_Item(anIndex: Integer): ImsmModelElement;
   function Get_Count: Integer;
   function Get_Owner: ImsmModelElement;
   function Get_Strings(anIndex: Integer): Il3CString;
   function Publisher: ImsmEventsPublisher; override;
   function Get_StringsToFind(anIndex: Integer): Il3CString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure DoHandleEvent(anEvent: TmsmEvent); override;
   procedure ClearFields; override;
  public
   constructor Create(const anElement: TmsmModelElementView); reintroduce;
   class function Make(const anElement: TmsmModelElementView): ImsmModelElementStringList; reintroduce;
   function IndexOfElementView(const anElement: ImsmModelElement): Integer;
   procedure Add(anItem: TtfwWord);
 end;//TmsmModelElementStringList

implementation

uses
 l3ImplUses
 , tfwCStringFactory
 , SysUtils
 //#UC START# *57B1674A02B6impl_uses*
 , StrUtils
 , l3String
 , l3Base
 //#UC END# *57B1674A02B6impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmEventsPublisher.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmEventFire.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmEventsSubscriber.imp.pas}

constructor TmsmModelElementStringList.Create(const anElement: TmsmModelElementView);
//#UC START# *57B1682902FF_57B1674A02B6_var*
//#UC END# *57B1682902FF_57B1674A02B6_var*
begin
//#UC START# *57B1682902FF_57B1674A02B6_impl*
 if anElement.rIsDir then
 begin
  if (anElement.rElement = nil) then
   f_Parent := nil
  else
   f_Parent := anElement.rElement.Parent;
 end//anElement.rIsDir
 else
  f_Parent := nil;
 if (anElement.rElement = nil) then
  f_List := nil
 else
  f_List := anElement.rElement.MEList[anElement.rListName];
 inherited Create(anElement);
//#UC END# *57B1682902FF_57B1674A02B6_impl*
end;//TmsmModelElementStringList.Create

class function TmsmModelElementStringList.Make(const anElement: TmsmModelElementView): ImsmModelElementStringList;
var
 l_Inst : TmsmModelElementStringList;
begin
 l_Inst := Create(anElement);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmModelElementStringList.Make

function TmsmModelElementStringList.IsDir: Boolean;
//#UC START# *57B57DE500CF_57B1674A02B6_var*
//#UC END# *57B57DE500CF_57B1674A02B6_var*
begin
//#UC START# *57B57DE500CF_57B1674A02B6_impl*
 Result := Self.Element.rIsDir;
//#UC END# *57B57DE500CF_57B1674A02B6_impl*
end;//TmsmModelElementStringList.IsDir

function TmsmModelElementStringList.As_ImsmEventsPublisher: ImsmEventsPublisher;
 {* Метод приведения нашего интерфейса к ImsmEventsPublisher }
begin
 Result := Self;
end;//TmsmModelElementStringList.As_ImsmEventsPublisher

function TmsmModelElementStringList.Get_Item(anIndex: Integer): ImsmModelElement;
//#UC START# *57AAD86403AD_57B1674A02B6get_var*
//#UC END# *57AAD86403AD_57B1674A02B6get_var*
begin
//#UC START# *57AAD86403AD_57B1674A02B6get_impl*
 if (anIndex < 0) then
  Result := nil
 else
 begin
  if IsDir then
   if (f_Parent <> nil) then
   begin
    if (anIndex = 0) then
    begin
     Result := f_Parent;
     Exit;
    end;//anIndex = 0
    Dec(anIndex);
   end;//f_Parent <> nil
  Result := f_List[anIndex];
 end;//anIndex < 0
//#UC END# *57AAD86403AD_57B1674A02B6get_impl*
end;//TmsmModelElementStringList.Get_Item

function TmsmModelElementStringList.Get_Count: Integer;
//#UC START# *57AAD89C0277_57B1674A02B6get_var*
//#UC END# *57AAD89C0277_57B1674A02B6get_var*
begin
//#UC START# *57AAD89C0277_57B1674A02B6get_impl*
 Result := f_List.Count;
 if IsDir then
  if (f_Parent <> nil) then
   Inc(Result);
//#UC END# *57AAD89C0277_57B1674A02B6get_impl*
end;//TmsmModelElementStringList.Get_Count

function TmsmModelElementStringList.Get_Owner: ImsmModelElement;
//#UC START# *57AE2E140297_57B1674A02B6get_var*
//#UC END# *57AE2E140297_57B1674A02B6get_var*
begin
//#UC START# *57AE2E140297_57B1674A02B6get_impl*
 Result := Element.rElement;
//#UC END# *57AE2E140297_57B1674A02B6get_impl*
end;//TmsmModelElementStringList.Get_Owner

function TmsmModelElementStringList.Get_Strings(anIndex: Integer): Il3CString;
//#UC START# *57AEBED1018D_57B1674A02B6get_var*
//#UC END# *57AEBED1018D_57B1674A02B6get_var*
begin
//#UC START# *57AEBED1018D_57B1674A02B6get_impl*
 Result := Get_Item(anIndex).StringProp[Element.rTextName];
 if IsDir then
  if (anIndex = 0) AND (f_Parent <> nil) then
  begin
   if IsDir then
    Result := TtfwCStringFactory.Cat(TtfwCStringFactory.C('.. '), Result);
  end;//(anIndex = 0) AND (f_Parent <> nil)
//#UC END# *57AEBED1018D_57B1674A02B6get_impl*
end;//TmsmModelElementStringList.Get_Strings

function TmsmModelElementStringList.Publisher: ImsmEventsPublisher;
//#UC START# *57B6B9CD03B7_57B1674A02B6_var*
//#UC END# *57B6B9CD03B7_57B1674A02B6_var*
begin
//#UC START# *57B6B9CD03B7_57B1674A02B6_impl*
 if (f_List = nil) then
  Result := nil
 else
  Result := f_List.As_ImsmEventsPublisher;
//#UC END# *57B6B9CD03B7_57B1674A02B6_impl*
end;//TmsmModelElementStringList.Publisher

function TmsmModelElementStringList.Get_StringsToFind(anIndex: Integer): Il3CString;
//#UC START# *57B6C7D40215_57B1674A02B6get_var*
//#UC END# *57B6C7D40215_57B1674A02B6get_var*
begin
//#UC START# *57B6C7D40215_57B1674A02B6get_impl*
 Result := Get_Item(anIndex).StringProp['DefaultSearchText'];
//#UC END# *57B6C7D40215_57B1674A02B6get_impl*
end;//TmsmModelElementStringList.Get_StringsToFind

function TmsmModelElementStringList.IndexOfElementView(const anElement: ImsmModelElement): Integer;
//#UC START# *57D1327900BC_57B1674A02B6_var*
//#UC END# *57D1327900BC_57B1674A02B6_var*
begin
//#UC START# *57D1327900BC_57B1674A02B6_impl*
 if IsDir then
  if (f_Parent <> nil) then
   if f_Parent.IsSameElementView(anElement) then
   begin
    Result := 0;
    Exit;
   end;//f_Parent.IsSameElement(anElement)
 Result := f_List.IndexOfElementView(anElement);
 if (Result >= 0) then  
  if IsDir then
   if (f_Parent <> nil) then
    Inc(Result);
//#UC END# *57D1327900BC_57B1674A02B6_impl*
end;//TmsmModelElementStringList.IndexOfElementView

procedure TmsmModelElementStringList.Add(anItem: TtfwWord);
//#UC START# *58094B920194_57B1674A02B6_var*
//#UC END# *58094B920194_57B1674A02B6_var*
begin
//#UC START# *58094B920194_57B1674A02B6_impl*
 Assert(false);
//#UC END# *58094B920194_57B1674A02B6_impl*
end;//TmsmModelElementStringList.Add

procedure TmsmModelElementStringList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B1674A02B6_var*
//#UC END# *479731C50290_57B1674A02B6_var*
begin
//#UC START# *479731C50290_57B1674A02B6_impl*
 f_List := nil;
 f_Parent := nil;
 inherited;
//#UC END# *479731C50290_57B1674A02B6_impl*
end;//TmsmModelElementStringList.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TmsmModelElementStringList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_57B1674A02B6_var*
//#UC END# *47A6FEE600FC_57B1674A02B6_var*
begin
//#UC START# *47A6FEE600FC_57B1674A02B6_impl*
 Result := true;
//#UC END# *47A6FEE600FC_57B1674A02B6_impl*
end;//TmsmModelElementStringList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TmsmModelElementStringList.DoHandleEvent(anEvent: TmsmEvent);
//#UC START# *580A1AD9019C_57B1674A02B6_var*
//#UC END# *580A1AD9019C_57B1674A02B6_var*
begin
//#UC START# *580A1AD9019C_57B1674A02B6_impl*
 inherited;
 Self.Fire(anEvent);
//#UC END# *580A1AD9019C_57B1674A02B6_impl*
end;//TmsmModelElementStringList.DoHandleEvent

procedure TmsmModelElementStringList.ClearFields;
begin
 f_List := nil;
 f_Parent := nil;
 inherited;
end;//TmsmModelElementStringList.ClearFields

end.
