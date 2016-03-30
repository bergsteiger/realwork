unit evStyleInterface;
 {* Инструмент для работы с таблицей стилей }

// Модуль: "w:\common\components\gui\Garant\Everest\evStyleInterface.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevStyleInterface" MUID: (480DB927035A)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evStyles_SH
 , l3Interfaces
 , evFontInterface
 , l3Variant
 , Classes
 , k2Base
 , evdStyles
 , k2Dictionary
 , l3Types
 , l3Tree_TLB
 , nevBase
 , k2Tags
 //#UC START# *480DB927035Aintf_uses*
 //#UC END# *480DB927035Aintf_uses*
;

type
 RevStyleInterface = class of TevStyleInterface;

 Tk2TagID = k2Tags.Tk2TagID;

 //#UC START# *480DB927035Aci*
 //#UC END# *480DB927035Aci*
 //#UC START# *480DB927035Acit*
 //#UC END# *480DB927035Acit*
 TevStyleInterface = class(SHevStyles, Il3Strings)
  {* Инструмент для работы с таблицей стилей }
  private
   f_Styles: TStrings;
   f_ForBlock: Boolean;
   f_Font: TevFontInterface;
    {* Поле для свойства Font }
   f_ParentInterface: TevStyleInterface;
    {* Поле для свойства ParentInterface }
  protected
   procedure pm_SetParentName(const aValue: AnsiString);
   function pm_GetCaption: AnsiString;
   procedure pm_SetCaption(const aValue: AnsiString);
   function pm_GetStyle: Tl3Variant;
   procedure pm_SetStyle(aValue: Tl3Variant);
   function pm_GetParentInterface: TevStyleInterface;
   function Get_Items: TStrings;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Changing; override;
   procedure ChangedEx(aCancel: Boolean); override;
   function IsDefault: Boolean; override;
   function pm_GetTag: Tl3Variant; override;
   procedure pm_SetTag(aValue: Tl3Variant); override;
   procedure pm_SetContext(const aValue: InevOp); override;
   function pm_GetIsOwn(anIndex: Integer): Boolean; override;
   procedure pm_SetIsOwn(anIndex: Integer;
    aValue: Boolean); override;
  public
   class function MakeList(aType: Tk2Type): Il3Strings;
   constructor Make(aType: Tk2Type = nil;
    aStyle: Integer = evdStyles.ev_saTxtNormalANSI); reintroduce;
   class function MakeListForBlock(aType: Tk2Type): Il3Strings;
   function GetVT: Tk2Dictionary;
    {* возвращает список стилей }
   procedure Add(const S: AnsiString;
    ID: Integer = 0);
    {* добавляет новый стиль и устанавливает курсор на него }
   procedure Delete;
    {* удаляет текущий выбранный стиль }
   procedure SelectStyledObjectType(aType: Tk2Type);
    {* настраивает инструмент на работу со стилями для заданного типа объектов }
   procedure SelectStyledObject(anObject: Tl3Variant);
    {* настраивает инструмент на работу со стилями для заданного типа объектов }
   function SelectStyle(const S: AnsiString): Tl3Variant; overload;
    {* устанавливает курсор на стиль по имени }
   function SelectStyle(ID: Integer): Tl3Variant; overload;
    {* устанавливает курсор на стиль по идентификатору }
   procedure IncFontSize;
   procedure DecFontSize;
   procedure IncAllFontSize;
   procedure DecAllFontSize;
   function Iterate(Action: Tl3IteratorAction): Integer;
    {* перебирает все элементы хранилища с aLo по aHi и освобождает заглушку для Action }
   function IterateF(Action: Tl3IteratorAction): Integer;
    {* перебирает все элементы хранилища с aLo по aHi и освобождает заглушку для Action }
   function MakeStylesTreeRoot(const aIncludeIdArray: array of Integer): Il3Node;
    {* создает дерево стилей и возвращает интерфейс на корневую ноду }
   constructor Create; override;
  public
   property Font: TevFontInterface
    read f_Font;
    {* шрифт текущего стиля }
   property ParentName: AnsiString
    write pm_SetParentName;
    {* имя родительского шрифта текущего стиля }
   property Caption: AnsiString
    read pm_GetCaption
    write pm_SetCaption;
    {* заголовок стиля }
   property Style: Tl3Variant
    read pm_GetStyle
    write pm_SetStyle;
    {* текущий стиль }
   property Items: TStrings
    read Get_Items;
    {* список стилей }
   property ParentInterface: TevStyleInterface
    read pm_GetParentInterface;
    {* родительский стиль текущего стиля }
 //#UC START# *480DB927035Apubl*
  public
   property Scalable: Boolean
     index k2_tiIsChangeableFont
     read pm_GetBoolParam
     write pm_SetBoolParam;
     {* - изменяется размер шрифта кнопками на тулбаре }
   property Visible: Boolean
     index k2_tiVisible
     read pm_GetBoolParam
     write pm_SetBoolParam;
     {* - признак видимости текущего стиля. }
   property VisibleToUser: Boolean
     index k2_tiVisibleToUser
     read pm_GetBoolParam
     write pm_SetBoolParam;
     {* - признак видимости текущего стиля в списке стилей. }
   property VisibleToBlock: Boolean
     index k2_tiVisibleToBlock
     read pm_GetBoolParam
     write pm_SetBoolParam;
     {* - признак видимости текущего стиля в списке стилей для блоков. }
   property FirstIndent: Integer
     index k2_tiFirstIndent
     read pm_GetLongParam
     write pm_SetLongParam;
     {* - отступ красной строки текущего стиля. }
   property LeftIndent: Integer
     index k2_tiLeftIndent
     read pm_GetLongParam
     write pm_SetLongParam;
     {* - левый отступ текущего стиля. }
   property RightIndent: Integer
     index k2_tiRightIndent
     read pm_GetLongParam
     write pm_SetLongParam;
     {* - правый отступ текущего стиля. }
   property Width: Integer
     index k2_tiWidth
     read pm_GetLongParam
     write pm_SetLongParam;
     {* - ширина текущего стиля. }
   property IndentType: Integer
     index k2_tiJustification
     read pm_GetLongParam
     write pm_SetLongParam;
     {* - тип выравнивания текущего стиля. }
   property Parent: Integer
     index k2_tiStyle
     read pm_GetLongParam
     write pm_SetLongParam;
     {* - идентификатор родителя для текущего стиля. }
   property Apply2Para: Boolean
     index k2_tiApply2Para
     read pm_GetBoolParam
     write pm_SetBoolParam;
     {* - признак применимости к параграфу текущего стиля. }
   property SpaceBefore: Integer
     index k2_tiSpaceBefore
     read pm_GetLongParam
     write pm_SetLongParam;
     {* - отступ сверху. }
   property SpaceAfter: Integer
     index k2_tiSpaceAfter
     read pm_GetLongParam
     write pm_SetLongParam;
     {* - отступ снизу. }
 //#UC END# *480DB927035Apubl*
 end;//TevStyleInterface

implementation

uses
 l3ImplUses
 , l3Base
 , TextPara_Const
 , l3Nodes
 , l3TreeInterfaces
 , k2SimpleTagList
 , l3Chars
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 //#UC START# *480DB927035Aimpl_uses*
 //#UC END# *480DB927035Aimpl_uses*
;

procedure TevStyleInterface.pm_SetParentName(const aValue: AnsiString);
//#UC START# *554CE4780115_480DB927035Aset_var*
//#UC END# *554CE4780115_480DB927035Aset_var*
begin
//#UC START# *554CE4780115_480DB927035Aset_impl*
 Tag.StrW[k2_tiStyle, Context] := aValue;
 f_Font.Style := Self;
//#UC END# *554CE4780115_480DB927035Aset_impl*
end;//TevStyleInterface.pm_SetParentName

function TevStyleInterface.pm_GetCaption: AnsiString;
//#UC START# *554CE4A00368_480DB927035Aget_var*
//#UC END# *554CE4A00368_480DB927035Aget_var*
begin
//#UC START# *554CE4A00368_480DB927035Aget_impl*
 Result := Tag.Attr[k2_tiShortName].AsString;
//#UC END# *554CE4A00368_480DB927035Aget_impl*
end;//TevStyleInterface.pm_GetCaption

procedure TevStyleInterface.pm_SetCaption(const aValue: AnsiString);
//#UC START# *554CE4A00368_480DB927035Aset_var*
//#UC END# *554CE4A00368_480DB927035Aset_var*
begin
//#UC START# *554CE4A00368_480DB927035Aset_impl*
 Tag.StrW[k2_tiShortName, Context] := aValue;
//#UC END# *554CE4A00368_480DB927035Aset_impl*
end;//TevStyleInterface.pm_SetCaption

function TevStyleInterface.pm_GetStyle: Tl3Variant;
//#UC START# *554CE4F2005A_480DB927035Aget_var*
//#UC END# *554CE4F2005A_480DB927035Aget_var*
begin
//#UC START# *554CE4F2005A_480DB927035Aget_impl*
 Result := pm_GetTag;
//#UC END# *554CE4F2005A_480DB927035Aget_impl*
end;//TevStyleInterface.pm_GetStyle

procedure TevStyleInterface.pm_SetStyle(aValue: Tl3Variant);
//#UC START# *554CE4F2005A_480DB927035Aset_var*
//#UC END# *554CE4F2005A_480DB927035Aset_var*
begin
//#UC START# *554CE4F2005A_480DB927035Aset_impl*
 pm_SetTag(aValue);
//#UC END# *554CE4F2005A_480DB927035Aset_impl*
end;//TevStyleInterface.pm_SetStyle

function TevStyleInterface.pm_GetParentInterface: TevStyleInterface;
//#UC START# *554CE6060046_480DB927035Aget_var*
var
 P: Tl3Variant;
//#UC END# *554CE6060046_480DB927035Aget_var*
begin
//#UC START# *554CE6060046_480DB927035Aget_impl*
 if (f_ParentInterface = nil) then
  f_ParentInterface := RevStyleInterface(ClassType).Create;
 P := Tag.Attr[k2_tiStyle];
 f_ParentInterface.Style := P;
 Result := f_ParentInterface;
//#UC END# *554CE6060046_480DB927035Aget_impl*
end;//TevStyleInterface.pm_GetParentInterface

class function TevStyleInterface.MakeList(aType: Tk2Type): Il3Strings;
//#UC START# *554CEC2A0191_480DB927035A_var*
var
 l_SI: TevStyleInterface;
//#UC END# *554CEC2A0191_480DB927035A_var*
begin
//#UC START# *554CEC2A0191_480DB927035A_impl*
 l_SI := TevStyleInterface.Create;
 try
  l_SI.TagType := aType;
  Result := l_SI;
 finally
  l3Free(l_SI);
 end;{try..finally}
//#UC END# *554CEC2A0191_480DB927035A_impl*
end;//TevStyleInterface.MakeList

constructor TevStyleInterface.Make(aType: Tk2Type = nil;
 aStyle: Integer = evdStyles.ev_saTxtNormalANSI);
//#UC START# *554CEC000039_480DB927035A_var*
//#UC END# *554CEC000039_480DB927035A_var*
begin
//#UC START# *554CEC000039_480DB927035A_impl*
 Create;
 f_ForBlock := False;
 if (aType = nil) then
  aType := k2_typTextPara;
 SelectStyledObjectType(aType);
 SelectStyle(aStyle);
//#UC END# *554CEC000039_480DB927035A_impl*
end;//TevStyleInterface.Make

class function TevStyleInterface.MakeListForBlock(aType: Tk2Type): Il3Strings;
//#UC START# *554CEC4F02F8_480DB927035A_var*
var
 l_SI: TevStyleInterface;
//#UC END# *554CEC4F02F8_480DB927035A_var*
begin
//#UC START# *554CEC4F02F8_480DB927035A_impl*
 l_SI := TevStyleInterface.Create;
 try
  l_SI.TagType := aType;
  l_SI.f_ForBlock := True;
  Result := l_SI;
 finally
  l3Free(l_SI);
 end;{try..finally}
//#UC END# *554CEC4F02F8_480DB927035A_impl*
end;//TevStyleInterface.MakeListForBlock

function TevStyleInterface.GetVT: Tk2Dictionary;
 {* возвращает список стилей }
//#UC START# *554CEC770101_480DB927035A_var*
//#UC END# *554CEC770101_480DB927035A_var*
begin
//#UC START# *554CEC770101_480DB927035A_impl*
 if (TagType = nil) then
  // - это возможно в случае инициализации таблицы тегов
  Result := nil
 else
 begin
  Result := TagType.ValueTable;
  Assert(Result <> nil);
 end;//TagType = nil
//#UC END# *554CEC770101_480DB927035A_impl*
end;//TevStyleInterface.GetVT

procedure TevStyleInterface.Add(const S: AnsiString;
 ID: Integer = 0);
 {* добавляет новый стиль и устанавливает курсор на него }
//#UC START# *554CECCB0076_480DB927035A_var*
var
 A: Tl3Variant;
 VT: Tk2Dictionary;
//#UC END# *554CECCB0076_480DB927035A_var*
begin
//#UC START# *554CECCB0076_480DB927035A_impl*
 VT := GetVT;
 A := TagType.MakeTag.AsObject;
 try
  A.IntW[k2_tiHandle, Context] := ID;
  Tag := A;
  Name := S;
  Tag := VT.Items[VT.Add(Tag)];
  //Tag := k2Tag(VT.Items[VT.Add(Tl3CustomString(Tag.AsObject))]);
 finally
  A := nil;
 end;//try..finally
//#UC END# *554CECCB0076_480DB927035A_impl*
end;//TevStyleInterface.Add

procedure TevStyleInterface.Delete;
 {* удаляет текущий выбранный стиль }
//#UC START# *554CECE7001A_480DB927035A_var*
var
 VT: Tk2Dictionary;
//#UC END# *554CECE7001A_480DB927035A_var*
begin
//#UC START# *554CECE7001A_480DB927035A_impl*
 if (Tag.IntA[k2_tiHandle] > 0) then
 begin
  VT := GetVT;
  VT.Delete(VT.IndexOf(Tag));
  Tag := nil;
 end;//Tag.IntA[k2_tiHandle]..
//#UC END# *554CECE7001A_480DB927035A_impl*
end;//TevStyleInterface.Delete

procedure TevStyleInterface.SelectStyledObjectType(aType: Tk2Type);
 {* настраивает инструмент на работу со стилями для заданного типа объектов }
//#UC START# *554CED1F006A_480DB927035A_var*
//#UC END# *554CED1F006A_480DB927035A_var*
begin
//#UC START# *554CED1F006A_480DB927035A_impl*
 if (aType <> nil) then
  // - это возможно в случае инициализации таблицы тегов
  TagType := Tk2Type(aType.Prop[k2_tiStyle].AtomType);
//#UC END# *554CED1F006A_480DB927035A_impl*
end;//TevStyleInterface.SelectStyledObjectType

procedure TevStyleInterface.SelectStyledObject(anObject: Tl3Variant);
 {* настраивает инструмент на работу со стилями для заданного типа объектов }
//#UC START# *554CED4F0071_480DB927035A_var*
//#UC END# *554CED4F0071_480DB927035A_var*
begin
//#UC START# *554CED4F0071_480DB927035A_impl*
 if anObject.IsValid then
  SelectStyledObjectType(Tk2Type(anObject.TagType));
//#UC END# *554CED4F0071_480DB927035A_impl*
end;//TevStyleInterface.SelectStyledObject

function TevStyleInterface.SelectStyle(const S: AnsiString): Tl3Variant;
 {* устанавливает курсор на стиль по имени }
//#UC START# *554CED730123_480DB927035A_var*
var
 VT: Tk2Dictionary;
//#UC END# *554CED730123_480DB927035A_var*
begin
//#UC START# *554CED730123_480DB927035A_impl*
 VT := GetVT;
 Tag := VT.DRByName[S];
 //Tag := k2Tag(VT.DRByName[S]);
 Result := Tag;
//#UC END# *554CED730123_480DB927035A_impl*
end;//TevStyleInterface.SelectStyle

function TevStyleInterface.SelectStyle(ID: Integer): Tl3Variant;
 {* устанавливает курсор на стиль по идентификатору }
//#UC START# *554CED8F018A_480DB927035A_var*
var
 VT: Tk2Dictionary;
//#UC END# *554CED8F018A_480DB927035A_var*
begin
//#UC START# *554CED8F018A_480DB927035A_impl*
 VT := GetVT;
 if (VT = nil) then
  // - это возможно в случае инициализации таблицы тегов
  Result := k2NullTag
 else
 begin
  Tag := VT.DRByID[ID];
  //Tag := k2Tag(VT.DRByID[ID]);
  Result := Tag;
 end;//VT = nil
//#UC END# *554CED8F018A_480DB927035A_impl*
end;//TevStyleInterface.SelectStyle

procedure TevStyleInterface.IncFontSize;
//#UC START# *554CEDBE0374_480DB927035A_var*
var
 l_Size: Integer;
 l_H: Integer;
//#UC END# *554CEDBE0374_480DB927035A_var*
begin
//#UC START# *554CEDBE0374_480DB927035A_impl*
 l_H := Self.Param[k2_tiHandle];
 if {IsStyleWithChangeableFont(l_H) AND} Tag.BoolA[k2_tiIsChangeableFont] then
  if (f_Font <> nil) then
  begin
   with f_Font do
    if (IsOwn[k2_tiSize] OR (l_H = ev_saTxtNormalANSI)) AND
      not IsTransparent[k2_tiSize] then
    begin
     l_Size := Size;
     Inc(l_Size);
     Size := l_Size;
    end;//IsOwn[k2_tiSize]
  end;//f_Font <> nil
//#UC END# *554CEDBE0374_480DB927035A_impl*
end;//TevStyleInterface.IncFontSize

procedure TevStyleInterface.DecFontSize;
//#UC START# *554CEDC503A4_480DB927035A_var*
var
 l_Size: Integer;
 l_H: Integer;
//#UC END# *554CEDC503A4_480DB927035A_var*
begin
//#UC START# *554CEDC503A4_480DB927035A_impl*
 l_H := Self.Param[k2_tiHandle];
 if {IsStyleWithChangeableFont(l_H) AND} Tag.BoolA[k2_tiIsChangeableFont] then
  if (f_Font <> nil) then
  begin
   with f_Font do
    if (IsOwn[k2_tiSize] OR (l_H = ev_saTxtNormalANSI)) AND
     not IsTransparent[k2_tiSize] then
    begin
     l_Size := Size;
     Dec(l_Size);
     if (l_Size > 0) then
      Size := l_Size;
    end;//IsOwn[k2_tiSize]
  end;//f_Font <> nil
//#UC END# *554CEDC503A4_480DB927035A_impl*
end;//TevStyleInterface.DecFontSize

procedure TevStyleInterface.IncAllFontSize;
//#UC START# *554CEDCD0089_480DB927035A_var*
 function ChangeStyle(aStyle: Pl3Variant; Index: Integer): Boolean;
 begin//ChangeStyle
  Result := true;
  IncFontSize;
 end;//ChangeStyle
//#UC END# *554CEDCD0089_480DB927035A_var*
begin
//#UC START# *554CEDCD0089_480DB927035A_impl*
 Changing;
 try
  IterateF(l3L2IA(@ChangeStyle));
 finally
  Changed;
 end;//try..finally
//#UC END# *554CEDCD0089_480DB927035A_impl*
end;//TevStyleInterface.IncAllFontSize

procedure TevStyleInterface.DecAllFontSize;
//#UC START# *554CEDD40305_480DB927035A_var*
 function ChangeStyle(aStyle: Pl3Variant; Index: Integer): Boolean;
 begin//ChangeStyle
  Result := true;
  DecFontSize;
 end;//ChangeStyle
//#UC END# *554CEDD40305_480DB927035A_var*
begin
//#UC START# *554CEDD40305_480DB927035A_impl*
 Changing;
 try
  IterateF(l3L2IA(@ChangeStyle));
 finally
  Changed;
 end;//try..finally
//#UC END# *554CEDD40305_480DB927035A_impl*
end;//TevStyleInterface.DecAllFontSize

function TevStyleInterface.Iterate(Action: Tl3IteratorAction): Integer;
 {* перебирает все элементы хранилища с aLo по aHi и освобождает заглушку для Action }
//#UC START# *554CEE0500C0_480DB927035A_var*
 function ChangeStyle(aStyle: Pl3Variant; Index: Integer): Boolean;
 begin//ChangeStyle
  SelectStyle(aStyle.IntA[k2_tiHandle]);
  Result := Action(aStyle, Index);
 end;//ChangeStyle

var
 VT: Tk2Dictionary;
//#UC END# *554CEE0500C0_480DB927035A_var*
begin
//#UC START# *554CEE0500C0_480DB927035A_impl*
 VT := GetVT;
 Result := VT.IterateAllF(l3L2IA(@ChangeStyle));
//#UC END# *554CEE0500C0_480DB927035A_impl*
end;//TevStyleInterface.Iterate

function TevStyleInterface.IterateF(Action: Tl3IteratorAction): Integer;
 {* перебирает все элементы хранилища с aLo по aHi и освобождает заглушку для Action }
//#UC START# *554CEE2302D6_480DB927035A_var*
//#UC END# *554CEE2302D6_480DB927035A_var*
begin
//#UC START# *554CEE2302D6_480DB927035A_impl*
 try
  Result := Iterate(Action);
 finally
  l3FreeIA(Action);
 end;//try..finally
//#UC END# *554CEE2302D6_480DB927035A_impl*
end;//TevStyleInterface.IterateF

function TevStyleInterface.MakeStylesTreeRoot(const aIncludeIdArray: array of Integer): Il3Node;
 {* создает дерево стилей и возвращает интерфейс на корневую ноду }
//#UC START# *554CEE6C02E7_480DB927035A_var*
 var
  l_RootNode: Il3Node absolute Result;

 function InsertStyle(aStyle: Pl3Variant; Index: Integer): Boolean;
 
  function IsValidId(const aId: Integer; const aIncludeIdArray: array of Integer): Boolean;
  var
   l_Index: Integer;
  begin
   Result := False;
   for l_Index := Low(aIncludeIdArray) to High(aIncludeIdArray) do
    if (aId = aIncludeIdArray[l_Index]) then
    begin
     Result := True;
     Break;
    end;
  end;
 var
  l_Id   : Integer;
  l_Node : Il3Node;
  l_St   : Tl3Variant;
 begin
  with aStyle^ do
   if IsValid then
   begin
    l_Id := AsLong;
    if (Length(aIncludeIdArray) = 0) or IsValidId(l_Id, aIncludeIdArray) then
    begin
     l_St := Attr[k2_tiStyle];
     while true do
     begin
      l_Node := l3SearchByName(l_RootNode, l_St.PCharLenA[k2_tiName]);
      if (l_Node <> nil) then
       break;
      if l_St.IsSame(l_St.Attr[k2_tiStyle]) then
      begin
       l_Node := l_RootNode;
       break;
      end;//l_St.IsSame(l_St.Attr[k2_tiStyle])
      l_St := l_St.Attr[k2_tiStyle];
     end;//while true
     try
      Assert(l_Node <> nil);
      with l_Node.InsertChild(MakeNode(PCharLenA[k2_tiName])) as Il3HandleNode do
       Handle := Integer(l_Id);
     finally
      l_Node := nil;
     end;//try..finally
    end;//Length(aIncludeIdArray) = 0юю
   end;//IsValid
  Result := True;
 end;
 //
 var
  l_VList: Tk2SimpleTagList;

 function SortStyle(aStyle: Pl3Variant; Index: Integer): Boolean;
 var
  l_Count  : Longint;
  l_Parent : Tl3Variant;
  l_Style  : Tl3Variant;
 begin
  with l_VList do
  begin
   l_Count := Count;
   l_Style := aStyle^.AsObject;
   //l_Style := k2Tag(aStyle^);
   with l_Style do
    while IsValid and (IndexOf(l_Style) < 0) do
    begin
     Insert(l_Count, l_Style);
     l_Parent := Attr[k2_tiStyle];
     if IsSame(l_Parent) then
      l_Style := k2NullTag
     else
      l_Style := l_Parent;
    end;
  end;
  Result := True;
 end;
 //
var
 l_Dictionary: Tk2Dictionary;
//#UC END# *554CEE6C02E7_480DB927035A_var*
begin
//#UC START# *554CEE6C02E7_480DB927035A_impl*
 Result := MakeNode(cc_EmptyStr);
 //
 l_Dictionary := GetVT;
 l_VList := Tk2SimpleTagList.Create;
 try
//  Assert(not l_VList.Sorted);
  l_Dictionary.IterateAllF(l3L2IA(@SortStyle));
  l_VList.IterateAllF(l3L2IA(@InsertStyle));
 finally
  l3Free(l_VList);
 end;
//#UC END# *554CEE6C02E7_480DB927035A_impl*
end;//TevStyleInterface.MakeStylesTreeRoot

function TevStyleInterface.Get_Items: TStrings;
//#UC START# *46A4746A03AF_480DB927035Aget_var*
var
 i: Integer;
 VT: Tk2Dictionary;
//#UC END# *46A4746A03AF_480DB927035Aget_var*
begin
//#UC START# *46A4746A03AF_480DB927035Aget_impl*
 if (f_Styles = nil) then
 begin
  VT := GetVT;
  f_Styles := TStringList.Create;
  for i := 0 to Pred(VT.Count) do
   if f_ForBlock then
   begin
    if VT.Items[i].BoolA[k2_tiVisibleToBlock] then
     f_Styles.AddObject(VT.Items[i].StrA[k2_tiName], VT.Items[i]);
   end // if l_ForBlock then
   else
    if VT.Items[i].BoolA[k2_tiVisibleTouser] then
     f_Styles.AddObject(VT.Items[i].StrA[k2_tiName], VT.Items[i]);
 end;
 Result := f_Styles;
//#UC END# *46A4746A03AF_480DB927035Aget_impl*
end;//TevStyleInterface.Get_Items

procedure TevStyleInterface.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_480DB927035A_var*
//#UC END# *479731C50290_480DB927035A_var*
begin
//#UC START# *479731C50290_480DB927035A_impl*
 f_ForBlock := False;
 l3Free(f_ParentInterface);
 l3Free(f_Styles);
 l3Free(f_Font);
 inherited;
//#UC END# *479731C50290_480DB927035A_impl*
end;//TevStyleInterface.Cleanup

constructor TevStyleInterface.Create;
//#UC START# *4DD3B7AB0108_480DB927035A_var*
//#UC END# *4DD3B7AB0108_480DB927035A_var*
begin
//#UC START# *4DD3B7AB0108_480DB927035A_impl*
 inherited Create;
 f_ForBlock := False;
 f_Font := TevFontInterface.Create;
//#UC END# *4DD3B7AB0108_480DB927035A_impl*
end;//TevStyleInterface.Create

procedure TevStyleInterface.Changing;
//#UC START# *554CE773030B_480DB927035A_var*
//#UC END# *554CE773030B_480DB927035A_var*
begin
//#UC START# *554CE773030B_480DB927035A_impl*
 {$If not defined(DesignTimeLibrary)}
 evNotifyStyleTableChanging;
 {$IfEnd}
 inherited;
 if (f_Font <> nil) then
  f_Font.Changing;
 {$If not defined(DesignTimeLibrary)}
 evNotifyStyleTableChanged;
 {$IfEnd}
//#UC END# *554CE773030B_480DB927035A_impl*
end;//TevStyleInterface.Changing

procedure TevStyleInterface.ChangedEx(aCancel: Boolean);
//#UC START# *554CE783008B_480DB927035A_var*
//#UC END# *554CE783008B_480DB927035A_var*
begin
//#UC START# *554CE783008B_480DB927035A_impl*
 if (f_Font <> nil) then
  f_Font.ChangedEx(aCancel);
 inherited ChangedEx(aCancel);
//#UC END# *554CE783008B_480DB927035A_impl*
end;//TevStyleInterface.ChangedEx

function TevStyleInterface.IsDefault: Boolean;
//#UC START# *554CE7CC01DE_480DB927035A_var*
//#UC END# *554CE7CC01DE_480DB927035A_var*
begin
//#UC START# *554CE7CC01DE_480DB927035A_impl*
 Result := (Tag.IntA[k2_tiHandle] = ev_saTxtNormalANSI);
//#UC END# *554CE7CC01DE_480DB927035A_impl*
end;//TevStyleInterface.IsDefault

function TevStyleInterface.pm_GetTag: Tl3Variant;
//#UC START# *554CE8390106_480DB927035Aget_var*
//#UC END# *554CE8390106_480DB927035Aget_var*
begin
//#UC START# *554CE8390106_480DB927035Aget_impl*
 Result := inherited pm_GetTag;
//#UC END# *554CE8390106_480DB927035Aget_impl*
end;//TevStyleInterface.pm_GetTag

procedure TevStyleInterface.pm_SetTag(aValue: Tl3Variant);
//#UC START# *554CE8390106_480DB927035Aset_var*
//#UC END# *554CE8390106_480DB927035Aset_var*
begin
//#UC START# *554CE8390106_480DB927035Aset_impl*
 inherited;
 if (f_Font <> nil) then
  f_Font.Style := Self;
//#UC END# *554CE8390106_480DB927035Aset_impl*
end;//TevStyleInterface.pm_SetTag

procedure TevStyleInterface.pm_SetContext(const aValue: InevOp);
//#UC START# *554CE92F02D5_480DB927035Aset_var*
//#UC END# *554CE92F02D5_480DB927035Aset_var*
begin
//#UC START# *554CE92F02D5_480DB927035Aset_impl*
 inherited;
 f_Font.Context := aValue;
//#UC END# *554CE92F02D5_480DB927035Aset_impl*
end;//TevStyleInterface.pm_SetContext

function TevStyleInterface.pm_GetIsOwn(anIndex: Integer): Boolean;
//#UC START# *554CEA2D01A9_480DB927035Aget_var*
//#UC END# *554CEA2D01A9_480DB927035Aget_var*
begin
//#UC START# *554CEA2D01A9_480DB927035Aget_impl*
 Result := inherited pm_GetIsOwn(anIndex) or IsDefault;
//#UC END# *554CEA2D01A9_480DB927035Aget_impl*
end;//TevStyleInterface.pm_GetIsOwn

procedure TevStyleInterface.pm_SetIsOwn(anIndex: Integer;
 aValue: Boolean);
//#UC START# *554CEA2D01A9_480DB927035Aset_var*
//#UC END# *554CEA2D01A9_480DB927035Aset_var*
begin
//#UC START# *554CEA2D01A9_480DB927035Aset_impl*
 inherited;
//#UC END# *554CEA2D01A9_480DB927035Aset_impl*
end;//TevStyleInterface.pm_SetIsOwn

//#UC START# *480DB927035Aimpl*
//#UC END# *480DB927035Aimpl*

end.
