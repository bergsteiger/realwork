unit msmModelElementRootNode;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementRootNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementRootNode" MUID: (57C9A4830362)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmModelElementNode
 , msmModelElementNodeList
 , l3TreeInterfaces
 , msmElementViews
 , l3Interfaces
 //#UC START# *57C9A4830362intf_uses*
 //#UC END# *57C9A4830362intf_uses*
;

type
 //#UC START# *57E9111A02F9ci*
 TmsmModelElementRootNode = class;
 //#UC END# *57E9111A02F9ci*
 //#UC START# *57E9111A02F9cit*
 //#UC END# *57E9111A02F9cit*
 TmsmModelElementSubRootNode = class(TmsmModelElementNode)
  private
   f_Parent: TmsmModelElementRootNode;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetIsFirst: Boolean; override;
   function GetIsLast: Boolean; override;
   function GetChild: Il3SimpleNode; override;
   function GetPrev: Il3SimpleNode; override;
   function GetNext: Il3SimpleNode; override;
   function GetParent: Il3SimpleNode; override;
   function GetThisChildrenCount: Integer; override;
   function GetText: Tl3PCharLenPrim; override;
  public
   constructor Create(aParent: TmsmModelElementRootNode;
    const anElement: TmsmModelElementView;
    anIndex: Integer); reintroduce;
 //#UC START# *57E9111A02F9publ*
 //#UC END# *57E9111A02F9publ*
 end;//TmsmModelElementSubRootNode

 //#UC START# *57C9A4830362ci*
 //#UC END# *57C9A4830362ci*
 //#UC START# *57C9A4830362cit*
 //#UC END# *57C9A4830362cit*
 TmsmModelElementRootNode = class(TmsmModelElementNode)
  private
   f_SubRoots: TmsmModelElementNodeList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetIsFirst: Boolean; override;
   function GetIsLast: Boolean; override;
   function GetChild: Il3SimpleNode; override;
   function GetPrev: Il3SimpleNode; override;
   function GetNext: Il3SimpleNode; override;
   function GetParent: Il3SimpleNode; override;
   function GetThisChildrenCount: Integer; override;
   function GetText: Tl3PCharLenPrim; override;
  public
   constructor Create(const anElement: TmsmModelElementView); reintroduce;
   function AddSubRoot(const aSubRoot: Il3SimpleNode): Il3SimpleNode;
 //#UC START# *57C9A4830362publ*
 //#UC END# *57C9A4830362publ*
 end;//TmsmModelElementRootNode

implementation

uses
 l3ImplUses
 //#UC START# *57C9A4830362impl_uses*
 , SysUtils
 , l3String
 //#UC END# *57C9A4830362impl_uses*
;

constructor TmsmModelElementSubRootNode.Create(aParent: TmsmModelElementRootNode;
 const anElement: TmsmModelElementView;
 anIndex: Integer);
//#UC START# *57E911BC0322_57E9111A02F9_var*
//#UC END# *57E911BC0322_57E9111A02F9_var*
begin
//#UC START# *57E911BC0322_57E9111A02F9_impl*
 f_Parent := aParent;
 inherited Create(anElement, anIndex);
//#UC END# *57E911BC0322_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.Create

procedure TmsmModelElementSubRootNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E9111A02F9_var*
//#UC END# *479731C50290_57E9111A02F9_var*
begin
//#UC START# *479731C50290_57E9111A02F9_impl*
 f_Parent := nil;
 inherited;
//#UC END# *479731C50290_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.Cleanup

function TmsmModelElementSubRootNode.GetIsFirst: Boolean;
//#UC START# *57E90FC602BD_57E9111A02F9_var*
var
 l_Index : Integer;
//#UC END# *57E90FC602BD_57E9111A02F9_var*
begin
//#UC START# *57E90FC602BD_57E9111A02F9_impl*
 l_Index := pm_GetIndexInParent;
 Result := (l_Index = 0);
//#UC END# *57E90FC602BD_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.GetIsFirst

function TmsmModelElementSubRootNode.GetIsLast: Boolean;
//#UC START# *57E90FDF00A5_57E9111A02F9_var*
var
 l_Index : Integer;
//#UC END# *57E90FDF00A5_57E9111A02F9_var*
begin
//#UC START# *57E90FDF00A5_57E9111A02F9_impl*
 l_Index := pm_GetIndexInParent;
 Result := (l_Index = Pred(f_Parent.f_SubRoots.Count));
//#UC END# *57E90FDF00A5_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.GetIsLast

function TmsmModelElementSubRootNode.GetChild: Il3SimpleNode;
//#UC START# *57E90FF10291_57E9111A02F9_var*
//#UC END# *57E90FF10291_57E9111A02F9_var*
begin
//#UC START# *57E90FF10291_57E9111A02F9_impl*
 Result := inherited GetChild;
//#UC END# *57E90FF10291_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.GetChild

function TmsmModelElementSubRootNode.GetPrev: Il3SimpleNode;
//#UC START# *57E9100A01F2_57E9111A02F9_var*
var
 l_Index : Integer;
//#UC END# *57E9100A01F2_57E9111A02F9_var*
begin
//#UC START# *57E9100A01F2_57E9111A02F9_impl*
 l_Index := pm_GetIndexInParent;
 Assert(l_Index >= 0);
 if (l_Index > 0) then
  Result := f_Parent.f_SubRoots[l_Index - 1]
 else
  Result := nil; 
//#UC END# *57E9100A01F2_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.GetPrev

function TmsmModelElementSubRootNode.GetNext: Il3SimpleNode;
//#UC START# *57E9101E01C8_57E9111A02F9_var*
var
 l_Index : Integer;
//#UC END# *57E9101E01C8_57E9111A02F9_var*
begin
//#UC START# *57E9101E01C8_57E9111A02F9_impl*
 l_Index := pm_GetIndexInParent;
 Assert(l_Index >= 0);
 if (l_Index < Pred(f_Parent.f_SubRoots.Count)) then
  Result := f_Parent.f_SubRoots[l_Index + 1]
 else
  Result := nil; 
//#UC END# *57E9101E01C8_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.GetNext

function TmsmModelElementSubRootNode.GetParent: Il3SimpleNode;
//#UC START# *57E9107B0059_57E9111A02F9_var*
//#UC END# *57E9107B0059_57E9111A02F9_var*
begin
//#UC START# *57E9107B0059_57E9111A02F9_impl*
 Result := f_Parent;
//#UC END# *57E9107B0059_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.GetParent

function TmsmModelElementSubRootNode.GetThisChildrenCount: Integer;
//#UC START# *57E910B0002C_57E9111A02F9_var*
//#UC END# *57E910B0002C_57E9111A02F9_var*
begin
//#UC START# *57E910B0002C_57E9111A02F9_impl*
 Result := inherited GetThisChildrenCount;
//#UC END# *57E910B0002C_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.GetThisChildrenCount

function TmsmModelElementSubRootNode.GetText: Tl3PCharLenPrim;
//#UC START# *57E91213016A_57E9111A02F9_var*
//#UC END# *57E91213016A_57E9111A02F9_var*
begin
//#UC START# *57E91213016A_57E9111A02F9_impl*
 Result := inherited GetText;
//#UC END# *57E91213016A_57E9111A02F9_impl*
end;//TmsmModelElementSubRootNode.GetText

//#UC START# *57E9111A02F9impl*
//#UC END# *57E9111A02F9impl*

constructor TmsmModelElementRootNode.Create(const anElement: TmsmModelElementView);
//#UC START# *57C9A6470169_57C9A4830362_var*
var
 l_SR : TmsmModelElementSubRootNode;
//#UC END# *57C9A6470169_57C9A4830362_var*
begin
//#UC START# *57C9A6470169_57C9A4830362_impl*
 f_SubRoots := TmsmModelElementNodeList.Create;
 l_SR := TmsmModelElementSubRootNode.Create(Self, anElement, 0);
 try
  f_SubRoots.Add(l_SR);
 finally
  FreeAndNil(l_SR);
 end;//try..finally
 inherited Create(TmsmModelElementView_C(nil, anElement.rListName, anElement.rTextName), -1);
//#UC END# *57C9A6470169_57C9A4830362_impl*
end;//TmsmModelElementRootNode.Create

function TmsmModelElementRootNode.AddSubRoot(const aSubRoot: Il3SimpleNode): Il3SimpleNode;
//#UC START# *57E9297B014F_57C9A4830362_var*
var
 l_V : TmsmModelElementView;
 l_SR : TmsmModelElementSubRootNode;
//#UC END# *57E9297B014F_57C9A4830362_var*
begin
//#UC START# *57E9297B014F_57C9A4830362_impl*
 Result := nil;
 l_V := TmsmModelElementView_C((aSubRoot As ITmsmModelElementNodeWrap).GetSelf.Element.rElement, Self.Element.rListName, Self.Element.rTextName);
 l_SR := TmsmModelElementSubRootNode.Create(Self, l_V, f_SubRoots.Count);
 try
  f_SubRoots.Add(l_SR);
  Result := l_SR;
 finally
  FreeAndNil(l_SR);
 end;//try..finally
//#UC END# *57E9297B014F_57C9A4830362_impl*
end;//TmsmModelElementRootNode.AddSubRoot

procedure TmsmModelElementRootNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57C9A4830362_var*
//#UC END# *479731C50290_57C9A4830362_var*
begin
//#UC START# *479731C50290_57C9A4830362_impl*
 FreeAndNil(f_SubRoots);
 inherited;
//#UC END# *479731C50290_57C9A4830362_impl*
end;//TmsmModelElementRootNode.Cleanup

function TmsmModelElementRootNode.GetIsFirst: Boolean;
//#UC START# *57E90FC602BD_57C9A4830362_var*
//#UC END# *57E90FC602BD_57C9A4830362_var*
begin
//#UC START# *57E90FC602BD_57C9A4830362_impl*
 Result := true;
//#UC END# *57E90FC602BD_57C9A4830362_impl*
end;//TmsmModelElementRootNode.GetIsFirst

function TmsmModelElementRootNode.GetIsLast: Boolean;
//#UC START# *57E90FDF00A5_57C9A4830362_var*
//#UC END# *57E90FDF00A5_57C9A4830362_var*
begin
//#UC START# *57E90FDF00A5_57C9A4830362_impl*
 Result := true;
//#UC END# *57E90FDF00A5_57C9A4830362_impl*
end;//TmsmModelElementRootNode.GetIsLast

function TmsmModelElementRootNode.GetChild: Il3SimpleNode;
//#UC START# *57E90FF10291_57C9A4830362_var*
//#UC END# *57E90FF10291_57C9A4830362_var*
begin
//#UC START# *57E90FF10291_57C9A4830362_impl*
 Result := f_SubRoots.First;
//#UC END# *57E90FF10291_57C9A4830362_impl*
end;//TmsmModelElementRootNode.GetChild

function TmsmModelElementRootNode.GetPrev: Il3SimpleNode;
//#UC START# *57E9100A01F2_57C9A4830362_var*
//#UC END# *57E9100A01F2_57C9A4830362_var*
begin
//#UC START# *57E9100A01F2_57C9A4830362_impl*
 Result := nil;
//#UC END# *57E9100A01F2_57C9A4830362_impl*
end;//TmsmModelElementRootNode.GetPrev

function TmsmModelElementRootNode.GetNext: Il3SimpleNode;
//#UC START# *57E9101E01C8_57C9A4830362_var*
//#UC END# *57E9101E01C8_57C9A4830362_var*
begin
//#UC START# *57E9101E01C8_57C9A4830362_impl*
 Result := nil;
//#UC END# *57E9101E01C8_57C9A4830362_impl*
end;//TmsmModelElementRootNode.GetNext

function TmsmModelElementRootNode.GetParent: Il3SimpleNode;
//#UC START# *57E9107B0059_57C9A4830362_var*
//#UC END# *57E9107B0059_57C9A4830362_var*
begin
//#UC START# *57E9107B0059_57C9A4830362_impl*
 Result := nil;
//#UC END# *57E9107B0059_57C9A4830362_impl*
end;//TmsmModelElementRootNode.GetParent

function TmsmModelElementRootNode.GetThisChildrenCount: Integer;
//#UC START# *57E910B0002C_57C9A4830362_var*
//#UC END# *57E910B0002C_57C9A4830362_var*
begin
//#UC START# *57E910B0002C_57C9A4830362_impl*
 Result := f_SubRoots.Count;
//#UC END# *57E910B0002C_57C9A4830362_impl*
end;//TmsmModelElementRootNode.GetThisChildrenCount

function TmsmModelElementRootNode.GetText: Tl3PCharLenPrim;
//#UC START# *57E91213016A_57C9A4830362_var*
const
 cRoot = 'Root';
//#UC END# *57E91213016A_57C9A4830362_var*
begin
//#UC START# *57E91213016A_57C9A4830362_impl*
 Result := l3PCharLen(AnsiString(cRoot)); 
//#UC END# *57E91213016A_57C9A4830362_impl*
end;//TmsmModelElementRootNode.GetText

//#UC START# *57C9A4830362impl*
//#UC END# *57C9A4830362impl*

end.
