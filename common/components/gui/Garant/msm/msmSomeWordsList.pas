unit msmSomeWordsList;

// Модуль: "w:\common\components\gui\Garant\msm\msmSomeWordsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSomeWordsList" MUID: (5811C7710063)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmSomeWordsListPrim
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , msmElementViews
 , msmModelElements
;

type
 TmsmSomeWordsList = class(TmsmSomeWordsListPrim)
  private
   f_List: ItfwValueList;
  protected
   function pm_GetList: ItfwValueList;
   procedure pm_SetList(const aValue: ItfwValueList);
   function DoGetCount: Integer; override;
   function DoGetItem(anIndex: Integer): ImsmModelElement; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   class function Make(const anElement: TmsmModelElementView): ImsmModelElementStringList; reintroduce;
  protected
   property List: ItfwValueList
    read pm_GetList
    write pm_SetList;
 end;//TmsmSomeWordsList

implementation

uses
 l3ImplUses
 , msmModelElementMethodCaller
 //#UC START# *5811C7710063impl_uses*
 , msmModelElement
 //#UC END# *5811C7710063impl_uses*
;

function TmsmSomeWordsList.pm_GetList: ItfwValueList;
//#UC START# *5811CCB20392_5811C7710063get_var*
//#UC END# *5811CCB20392_5811C7710063get_var*
begin
//#UC START# *5811CCB20392_5811C7710063get_impl*
 if (f_List = nil) then
  pm_SetList(TmsmModelElementMethodCaller.CallAndGetList([], Self.Element.rListName));
 Result := f_List; 
//#UC END# *5811CCB20392_5811C7710063get_impl*
end;//TmsmSomeWordsList.pm_GetList

procedure TmsmSomeWordsList.pm_SetList(const aValue: ItfwValueList);
//#UC START# *5811CCB20392_5811C7710063set_var*
//#UC END# *5811CCB20392_5811C7710063set_var*
begin
//#UC START# *5811CCB20392_5811C7710063set_impl*
 if (f_List <> aValue) then
 begin
  f_List := aValue;
 end;//f_List <> aValue 
//#UC END# *5811CCB20392_5811C7710063set_impl*
end;//TmsmSomeWordsList.pm_SetList

class function TmsmSomeWordsList.Make(const anElement: TmsmModelElementView): ImsmModelElementStringList;
var
 l_Inst : TmsmSomeWordsList;
begin
 l_Inst := Create(anElement);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmSomeWordsList.Make

function TmsmSomeWordsList.DoGetCount: Integer;
//#UC START# *5811547001A8_5811C7710063_var*
//#UC END# *5811547001A8_5811C7710063_var*
begin
//#UC START# *5811547001A8_5811C7710063_impl*
 if (List = nil) then
  Result := 0
 else
  Result := List.Count;;
//#UC END# *5811547001A8_5811C7710063_impl*
end;//TmsmSomeWordsList.DoGetCount

function TmsmSomeWordsList.DoGetItem(anIndex: Integer): ImsmModelElement;
//#UC START# *581154A203C2_5811C7710063_var*
//#UC END# *581154A203C2_5811C7710063_var*
begin
//#UC START# *581154A203C2_5811C7710063_impl*
 if (List = nil) then
  Result := nil
 else
  Result := TmsmModelElement.MakeFromValue(List.Items[anIndex]);
//#UC END# *581154A203C2_5811C7710063_impl*
end;//TmsmSomeWordsList.DoGetItem

procedure TmsmSomeWordsList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5811C7710063_var*
//#UC END# *479731C50290_5811C7710063_var*
begin
//#UC START# *479731C50290_5811C7710063_impl*
 List := nil;
 inherited;
//#UC END# *479731C50290_5811C7710063_impl*
end;//TmsmSomeWordsList.Cleanup

procedure TmsmSomeWordsList.ClearFields;
begin
 List := nil;
 inherited;
end;//TmsmSomeWordsList.ClearFields

end.
