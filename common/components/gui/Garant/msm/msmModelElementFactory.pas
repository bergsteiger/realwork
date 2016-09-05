unit msmModelElementFactory;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementFactory" MUID: (57AB39D10325)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmModelElementFactoryPrim
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , msmModelElements
 , l3Types
;

type
 _FindDataType_ = TtfwWord;
 _l3Searcher_Parent_ = TmsmModelElementFactoryPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TmsmModelElementFactory = class(_l3Searcher_)
  protected
   procedure InitFields; override;
  public
   class function Make(aWord: TtfwWord): ImsmModelElement;
   class function Instance: TmsmModelElementFactory;
    {* Метод получения экземпляра синглетона TmsmModelElementFactory }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmModelElementFactory

implementation

uses
 l3ImplUses
 , msmModelElement
 , l3Memory
 , SysUtils
 , l3Base
 //#UC START# *57AB39D10325impl_uses*
 , l3String
 //#UC END# *57AB39D10325impl_uses*
;

var g_TmsmModelElementFactory: TmsmModelElementFactory = nil;
 {* Экземпляр синглетона TmsmModelElementFactory }

procedure TmsmModelElementFactoryFree;
 {* Метод освобождения экземпляра синглетона TmsmModelElementFactory }
begin
 l3Free(g_TmsmModelElementFactory);
end;//TmsmModelElementFactoryFree

{$If not Declared(_ItemType_)}type _ItemType_ = TmsmModelElement;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_57AB39D10325_var*
//#UC END# *47B9BAFD01F4_57AB39D10325_var*
begin
//#UC START# *47B9BAFD01F4_57AB39D10325_impl*
 if (anItem.MainWord = aData) then
  Result := 0
 else
  Result := PAnsiChar(anItem.MainWord.GetRefForCompare) - PAnsiChar(aData.GetRefForCompare);
//#UC END# *47B9BAFD01F4_57AB39D10325_impl*
end;//CompareItemWithData

type _Instance_R_ = TmsmModelElementFactory;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

class function TmsmModelElementFactory.Make(aWord: TtfwWord): ImsmModelElement;
//#UC START# *57AB3A620365_57AB39D10325_var*
var
 l_E : TmsmModelElement;
 l_Index : Integer;
 l_Inst : TmsmModelElementFactory;
//#UC END# *57AB3A620365_57AB39D10325_var*
begin
//#UC START# *57AB3A620365_57AB39D10325_impl*
 l_Inst := Instance;
 if l_Inst.FindData(aWord, l_Index) then
  Result := l_Inst.Items[l_Index]
 else
 begin
  l_E := TmsmModelElement.Create(aWord);
  try
   l_Inst.Insert(l_Index, l_E);
   Result := l_E;
  finally
   FreeAndNil(l_E);
  end;//try..finally
 end;//Self.FindData(l_E, l_Index)
//#UC END# *57AB3A620365_57AB39D10325_impl*
end;//TmsmModelElementFactory.Make

class function TmsmModelElementFactory.Instance: TmsmModelElementFactory;
 {* Метод получения экземпляра синглетона TmsmModelElementFactory }
begin
 if (g_TmsmModelElementFactory = nil) then
 begin
  l3System.AddExitProc(TmsmModelElementFactoryFree);
  g_TmsmModelElementFactory := Create;
 end;
 Result := g_TmsmModelElementFactory;
end;//TmsmModelElementFactory.Instance

class function TmsmModelElementFactory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmModelElementFactory <> nil;
end;//TmsmModelElementFactory.Exists

procedure TmsmModelElementFactory.InitFields;
//#UC START# *47A042E100E2_57AB39D10325_var*
//#UC END# *47A042E100E2_57AB39D10325_var*
begin
//#UC START# *47A042E100E2_57AB39D10325_impl*
 inherited;
 //Sorted := true;
 //Duplicates := l3_dupError;
//#UC END# *47A042E100E2_57AB39D10325_impl*
end;//TmsmModelElementFactory.InitFields

end.
