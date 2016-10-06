unit msmListLikeModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmListLikeModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListLikeModel" MUID: (57B57EDB003F)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmModel
 , msmConcreteModels
 , msmElementViews
 , msmModelElements
 , l3Interfaces
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TmsmListLikeModel = {abstract} class(TmsmModel, ImsmListLikeModel, ImsmCaptionModel)
  private
   f_Selection: ImsmElementSelection;
   f_ElementToAction: ImsmModelElement;
  protected
   f_ElementView: TmsmModelElementView;
  protected
   function DoGetList: ImsmModelElementStringList; virtual; abstract;
   procedure DoShowElementAsList(const anElement: ImsmModelElement); virtual; abstract;
   function DoGetCaption: AnsiString; virtual;
   procedure ShowElementAsList(const anElement: ImsmModelElement);
   function Get_Caption: Il3CString;
   procedure Set_Caption(const aValue: Il3CString);
   function Get_ElementToAction: ImsmModelElement;
   procedure Set_ElementToAction(const aValue: ImsmModelElement);
   function Get_CurrentElement: ImsmModelElement;
   procedure Set_CurrentElement(const aValue: ImsmModelElement);
   function Get_List: ImsmModelElementStringList;
   function Get_Selection: ImsmElementSelection;
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   constructor Create(const anElementView: TmsmModelElementView); reintroduce;
   procedure Paste(const aSelection: ImsmElementSelection); overload;
   procedure Paste(const aDataObject: IDataObject); overload;
   procedure Paste; overload;
   procedure Paste(const anArray: ItfwArray); overload;
   function Drop(aFormat: Tl3ClipboardFormat;
    const aMedium: Tl3StoragePlace;
    var dwEffect: Integer;
    const aPoint: Tl3SPoint): Boolean; overload;
   function Drop(const anElement: ImsmModelElement;
    const aPoint: Tl3SPoint): Boolean; overload;
   function CanPaste(const aSelection: ImsmElementSelection): Boolean;
   function CanAddNewElement: Boolean;
   procedure AddNewElement(const anElementName: AnsiString;
    const anElementStereotype: ImsmModelElement);
  public
   property Selection: ImsmElementSelection
    read f_Selection;
 end;//TmsmListLikeModel

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 , msmElementSelection
 , tfwCStringFactory
 , msmModelElementMethodCaller
 {$If NOT Defined(NoScripts)}
 , tfwWordsIterator
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordRefList
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3SysUtils
 , l3Base
 //#UC START# *57B57EDB003Fimpl_uses*
 , Windows
 , l3TreeConst
 , l3TreeInterfaces
 , msmModelElementNode
 , msmModelElement
 , l3String
 //#UC END# *57B57EDB003Fimpl_uses*
;

function TmsmListLikeModel.DoGetCaption: AnsiString;
//#UC START# *57E331B90378_57B57EDB003F_var*
//#UC END# *57E331B90378_57B57EDB003F_var*
begin
//#UC START# *57E331B90378_57B57EDB003F_impl*
 Result := f_ElementView.rListName;
 if (Result = 'SelfList') then
  Result := f_ElementView.rTextName;
 if (Result = 'DocumentationNotEmpty') then
  Result := 'Doc';
//#UC END# *57E331B90378_57B57EDB003F_impl*
end;//TmsmListLikeModel.DoGetCaption

constructor TmsmListLikeModel.Create(const anElementView: TmsmModelElementView);
//#UC START# *57E410A500DD_57B57EDB003F_var*
//#UC END# *57E410A500DD_57B57EDB003F_var*
begin
//#UC START# *57E410A500DD_57B57EDB003F_impl*
 f_ElementView := anElementView;
 inherited Create;
//#UC END# *57E410A500DD_57B57EDB003F_impl*
end;//TmsmListLikeModel.Create

procedure TmsmListLikeModel.ShowElementAsList(const anElement: ImsmModelElement);
//#UC START# *57B1A3DA0382_57B57EDB003F_var*
//#UC END# *57B1A3DA0382_57B57EDB003F_var*
begin
//#UC START# *57B1A3DA0382_57B57EDB003F_impl*
 DoShowElementAsList(anElement);
//#UC END# *57B1A3DA0382_57B57EDB003F_impl*
end;//TmsmListLikeModel.ShowElementAsList

function TmsmListLikeModel.Get_Caption: Il3CString;
//#UC START# *57B1A47403C5_57B57EDB003Fget_var*
//#UC END# *57B1A47403C5_57B57EDB003Fget_var*
begin
//#UC START# *57B1A47403C5_57B57EDB003Fget_impl*
 Result := TtfwCStringFactory.C(DoGetCaption); 
//#UC END# *57B1A47403C5_57B57EDB003Fget_impl*
end;//TmsmListLikeModel.Get_Caption

procedure TmsmListLikeModel.Set_Caption(const aValue: Il3CString);
//#UC START# *57B1A47403C5_57B57EDB003Fset_var*
//#UC END# *57B1A47403C5_57B57EDB003Fset_var*
begin
//#UC START# *57B1A47403C5_57B57EDB003Fset_impl*
 // - ничего не делаем
//#UC END# *57B1A47403C5_57B57EDB003Fset_impl*
end;//TmsmListLikeModel.Set_Caption

function TmsmListLikeModel.Get_ElementToAction: ImsmModelElement;
//#UC START# *57B2B019009C_57B57EDB003Fget_var*
//#UC END# *57B2B019009C_57B57EDB003Fget_var*
begin
//#UC START# *57B2B019009C_57B57EDB003Fget_impl*
 Result := f_ElementToAction;
//#UC END# *57B2B019009C_57B57EDB003Fget_impl*
end;//TmsmListLikeModel.Get_ElementToAction

procedure TmsmListLikeModel.Set_ElementToAction(const aValue: ImsmModelElement);
//#UC START# *57B2B019009C_57B57EDB003Fset_var*
//#UC END# *57B2B019009C_57B57EDB003Fset_var*
begin
//#UC START# *57B2B019009C_57B57EDB003Fset_impl*
 f_ElementToAction := aValue;
 Fire(ActionElementEvent.Instance);
//#UC END# *57B2B019009C_57B57EDB003Fset_impl*
end;//TmsmListLikeModel.Set_ElementToAction

function TmsmListLikeModel.Get_CurrentElement: ImsmModelElement;
//#UC START# *57B31CF301D2_57B57EDB003Fget_var*
//#UC END# *57B31CF301D2_57B57EDB003Fget_var*
begin
//#UC START# *57B31CF301D2_57B57EDB003Fget_impl*
 Assert(f_Selection <> nil);
 Result := f_Selection.CurrentElement;
//#UC END# *57B31CF301D2_57B57EDB003Fget_impl*
end;//TmsmListLikeModel.Get_CurrentElement

procedure TmsmListLikeModel.Set_CurrentElement(const aValue: ImsmModelElement);
//#UC START# *57B31CF301D2_57B57EDB003Fset_var*
//#UC END# *57B31CF301D2_57B57EDB003Fset_var*
begin
//#UC START# *57B31CF301D2_57B57EDB003Fset_impl*
 if (f_Selection = nil) then
  f_Selection := TmsmElementSelection.Make(Self);
 Assert(f_Selection <> nil);
 f_Selection.CurrentElement := aValue;
//#UC END# *57B31CF301D2_57B57EDB003Fset_impl*
end;//TmsmListLikeModel.Set_CurrentElement

function TmsmListLikeModel.Get_List: ImsmModelElementStringList;
//#UC START# *57B6A4550271_57B57EDB003Fget_var*
//#UC END# *57B6A4550271_57B57EDB003Fget_var*
begin
//#UC START# *57B6A4550271_57B57EDB003Fget_impl*
 Result := DoGetList;
//#UC END# *57B6A4550271_57B57EDB003Fget_impl*
end;//TmsmListLikeModel.Get_List

function TmsmListLikeModel.Get_Selection: ImsmElementSelection;
//#UC START# *57D8F1B70265_57B57EDB003Fget_var*
//#UC END# *57D8F1B70265_57B57EDB003Fget_var*
begin
//#UC START# *57D8F1B70265_57B57EDB003Fget_impl*
 Result := f_Selection;
//#UC END# *57D8F1B70265_57B57EDB003Fget_impl*
end;//TmsmListLikeModel.Get_Selection

procedure TmsmListLikeModel.Paste(const aSelection: ImsmElementSelection);
//#UC START# *57E283A603D2_57B57EDB003F_var*
//#UC END# *57E283A603D2_57B57EDB003F_var*
begin
//#UC START# *57E283A603D2_57B57EDB003F_impl*
 Assert(aSelection <> nil);
 Paste(aSelection.AsArray);
//#UC END# *57E283A603D2_57B57EDB003F_impl*
end;//TmsmListLikeModel.Paste

procedure TmsmListLikeModel.Paste(const aDataObject: IDataObject);
//#UC START# *57E3F713019E_57B57EDB003F_var*
var
 l_Sel : ImsmElementSelection;
//#UC END# *57E3F713019E_57B57EDB003F_var*
begin
//#UC START# *57E3F713019E_57B57EDB003F_impl*
 if Supports(aDataObject, ImsmElementSelection, l_Sel) then
  try
   Self.Paste(l_Sel);
  finally
   l_Sel := nil;
  end;//try..finally
//#UC END# *57E3F713019E_57B57EDB003F_impl*
end;//TmsmListLikeModel.Paste

procedure TmsmListLikeModel.Paste;
//#UC START# *57E3F7330377_57B57EDB003F_var*
var
 l_IData : IDataObject;
//#UC END# *57E3F7330377_57B57EDB003F_var*
begin
//#UC START# *57E3F7330377_57B57EDB003F_impl*
 if not l3IFail(OleGetClipboard(l_IData)) then
  try
   Self.Paste(l_IData);
  finally
   l_IData := nil;
  end;//try..finally
//#UC END# *57E3F7330377_57B57EDB003F_impl*
end;//TmsmListLikeModel.Paste

procedure TmsmListLikeModel.Paste(const anArray: ItfwArray);
//#UC START# *57E3FC26029F_57B57EDB003F_var*
var
 l_A : ItfwArray;
//#UC END# *57E3FC26029F_57B57EDB003F_var*
begin
//#UC START# *57E3FC26029F_57B57EDB003F_impl*
 Assert(Self.Get_List <> nil);
 Assert(Self.Get_List.Owner <> nil);
 if Self.Get_List.Owner.BoolProp['IsDiagram'] then
  l_A := Self.Get_List.Owner.CallAndGetList([TtfwStackValue_C(anArray)], 'msm:Diagram:PasteElements')
 else
  Assert(false);
 Fire(ListContentChangedEvent.Instance);
 Selection.SelectElements(l_A); 
//#UC END# *57E3FC26029F_57B57EDB003F_impl*
end;//TmsmListLikeModel.Paste

function TmsmListLikeModel.Drop(aFormat: Tl3ClipboardFormat;
 const aMedium: Tl3StoragePlace;
 var dwEffect: Integer;
 const aPoint: Tl3SPoint): Boolean;
//#UC START# *57E410D101DC_57B57EDB003F_var*
var
 l_Data: Pl3TreeData;
 l_W : ITmsmModelElementNodeWrap;
//#UC END# *57E410D101DC_57B57EDB003F_var*
begin
//#UC START# *57E410D101DC_57B57EDB003F_impl*
 Result := false;
 if (aFormat = CF_TreeNode) then
 begin
  if (aMedium.tymed = TYMED_HGLOBAL) then
  begin
   l_Data := GlobalLock(aMedium.hGlobal);
   try
    if not l_Data.rMultiSelection AND (l_Data.rNode <> nil) then
    begin
     if Supports(l_Data.rNode, ITmsmModelElementNodeWrap, l_W) then
      try
       Result := Drop(l_W.GetSelf.Element.rElement, aPoint);
      finally
       l_W := nil;
      end;//try..finally
    end;//not l_Data.rMultiSelection AND (l_Data.rNode <> nil)
   finally
    GlobalUnlock(aMedium.hGlobal);
   end;//try..finally
  end;//aMedium.tymed = TYMED_HGLOBAL
 end;//aFormat = CF_TreeNode
//#UC END# *57E410D101DC_57B57EDB003F_impl*
end;//TmsmListLikeModel.Drop

function TmsmListLikeModel.Drop(const anElement: ImsmModelElement;
 const aPoint: Tl3SPoint): Boolean;
//#UC START# *57E4210F0225_57B57EDB003F_var*
var
 l_E : ImsmModelElement;
//#UC END# *57E4210F0225_57B57EDB003F_var*
begin
//#UC START# *57E4210F0225_57B57EDB003F_impl*
 Assert(Self.Get_List <> nil);
 Assert(Self.Get_List.Owner <> nil);
 if Self.Get_List.Owner.BoolProp['IsDiagram'] then
  l_E :=
   TmsmModelElement.MakeFromValue(
    Self.Get_List.Owner.Call(
     [TtfwStackValue_C(anElement.MainWord),
      TtfwStackValue_C(aPoint.X),
      TtfwStackValue_C(aPoint.Y)],
     'msm:Diagram:PasteElement'
    )
   )
 else
  Assert(false);
 Fire(ListContentChangedEvent.Instance);
 if (l_E <> nil) then
 begin
  Selection.Clear;
  Selection.CurrentElement := l_E;
 end;//l_E <> nil
 Result := true;
//#UC END# *57E4210F0225_57B57EDB003F_impl*
end;//TmsmListLikeModel.Drop

function TmsmListLikeModel.CanPaste(const aSelection: ImsmElementSelection): Boolean;
//#UC START# *57EB7E79022F_57B57EDB003F_var*
//#UC END# *57EB7E79022F_57B57EDB003F_var*
begin
//#UC START# *57EB7E79022F_57B57EDB003F_impl*
 Result := false;
 if (aSelection = nil) then
  Exit;
 if (Self.Get_List = nil) then
  Exit; 
 if (Self.Get_List.Owner = nil) then
  Exit; 
 if not Self.Get_List.Owner.BoolProp['IsDiagram'] then
  Exit;
 Result := true;
//#UC END# *57EB7E79022F_57B57EDB003F_impl*
end;//TmsmListLikeModel.CanPaste

function TmsmListLikeModel.CanAddNewElement: Boolean;
//#UC START# *57F4FE6D0164_57B57EDB003F_var*
//#UC END# *57F4FE6D0164_57B57EDB003F_var*
begin
//#UC START# *57F4FE6D0164_57B57EDB003F_impl*
 Result := false;
 if (Self.Get_List = nil) then
  Exit; 
 if (Self.Get_List.Owner = nil) then
  Exit; 
 if not Self.Get_List.Owner.BoolProp['IsDiagram'] then
  Exit;
 if (Self.Get_List.Owner.MEList['AllowedElements'].Count <= 0) then
  Exit;
 Result := true;
//#UC END# *57F4FE6D0164_57B57EDB003F_impl*
end;//TmsmListLikeModel.CanAddNewElement

procedure TmsmListLikeModel.AddNewElement(const anElementName: AnsiString;
 const anElementStereotype: ImsmModelElement);
//#UC START# *57F4FE8F022B_57B57EDB003F_var*
var
 l_E : ImsmModelElement;
//#UC END# *57F4FE8F022B_57B57EDB003F_var*
begin
//#UC START# *57F4FE8F022B_57B57EDB003F_impl*
 Assert(anElementName <> '');
 Assert(anElementStereotype <> nil);
 if Self.Get_List.Owner.BoolProp['IsDiagram'] then
  l_E :=
   TmsmModelElement.MakeFromValue(
    Self.Get_List.Owner.Call(
     [TtfwStackValue_C(TtfwCStringFactory.C(anElementName)),
      TtfwStackValue_C(anElementStereotype.MainWord)],
     'msm:Diagram:AddElement'
    )
   )
 else
  Assert(false);  
 if (l_E <> nil) then
 begin
  Selection.Clear;
  Selection.CurrentElement := l_E;
 end;//l_E <> nil
//#UC END# *57F4FE8F022B_57B57EDB003F_impl*
end;//TmsmListLikeModel.AddNewElement

procedure TmsmListLikeModel.InitFields;
//#UC START# *47A042E100E2_57B57EDB003F_var*
//#UC END# *47A042E100E2_57B57EDB003F_var*
begin
//#UC START# *47A042E100E2_57B57EDB003F_impl*
 inherited;
 if (f_Selection = nil) then
  f_Selection := TmsmElementSelection.Make(Self);
//#UC END# *47A042E100E2_57B57EDB003F_impl*
end;//TmsmListLikeModel.InitFields

procedure TmsmListLikeModel.ClearFields;
begin
 Finalize(f_ElementView);
 f_Selection := nil;
 f_ElementToAction := nil;
 inherited;
end;//TmsmListLikeModel.ClearFields

end.
