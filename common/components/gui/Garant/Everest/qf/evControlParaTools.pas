unit evControlParaTools;
 {* Утилиты для работы с параграфами, представляющие контролы ввода. }

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evControlParaTools.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evControlParaTools" MUID: (47CFFEDE0215)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evQueryCardInt
 , l3Interfaces
 , l3Variant
 , nevBase
 , evdTypes
;

function evGetEditorControl(aPara: Tl3Variant): IevEditorControl;
 {* Возвращает указатель на контрол для параграфа. }
function evGetCustomControl(aPara: Tl3Variant): IevCustomEditorControl;
 {* Возвращает указатель на контрол для параграфа }
function evGetQueryGroup(aPara: Tl3Variant): IevQueryGroup;
 {* Возвращает указатель на группу для параграфа }
function evGetField(aPara: Tl3Variant): IevEditorControlField;
 {* Возвращает указатель на поле для параграфа }
procedure evGetCustomImageList(const aPara: TnevControlInfo;
 out theImageInfo: TnevControlImageInfo;
 AType: TevControlType);
 {* Возвращает AImgIndex и ImageList, для контрола, если такие существуют }
function evChecked2State(aPara: Tl3Variant): Tl3ButtonState;
 {* Возвращает состояние кнопки, в зависимости от тега }
function evMakeDateMaskText: Il3CString;
 {* Возвращает шаблон для поля даты }
function evGetFullPathStr(const aTree: InevSimpleTree;
 const aNode: InevSimpleNode): Il3CString;
function evIsFieldSet(const aField: IevEditorControlField;
 IgnoreDefaultValue: Boolean): Boolean;
function evIsSomeFieldFilled(const aReq: IevReq;
 IgnoreDefaultValue: Boolean): Boolean;

implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , l3String
 , SysUtils
 , l3Date
 , l3TreeInterfaces
;

function evGetEditorControl(aPara: Tl3Variant): IevEditorControl;
 {* Возвращает указатель на контрол для параграфа. }
//#UC START# *47CFFF5D028A_47CFFEDE0215_var*
//#UC END# *47CFFF5D028A_47CFFEDE0215_var*
begin
//#UC START# *47CFFF5D028A_47CFFEDE0215_impl*
 aPara.QT(IevEditorControl, Result);
//#UC END# *47CFFF5D028A_47CFFEDE0215_impl*
end;//evGetEditorControl

function evGetCustomControl(aPara: Tl3Variant): IevCustomEditorControl;
 {* Возвращает указатель на контрол для параграфа }
//#UC START# *48DCFE370302_47CFFEDE0215_var*
//#UC END# *48DCFE370302_47CFFEDE0215_var*
begin
//#UC START# *48DCFE370302_47CFFEDE0215_impl*
 aPara.QT(IevCustomEditorControl, Result);
//#UC END# *48DCFE370302_47CFFEDE0215_impl*
end;//evGetCustomControl

function evGetQueryGroup(aPara: Tl3Variant): IevQueryGroup;
 {* Возвращает указатель на группу для параграфа }
//#UC START# *48DCFE4D00E0_47CFFEDE0215_var*
//#UC END# *48DCFE4D00E0_47CFFEDE0215_var*
begin
//#UC START# *48DCFE4D00E0_47CFFEDE0215_impl*
 aPara.QT(IevQueryGroup, Result);
//#UC END# *48DCFE4D00E0_47CFFEDE0215_impl*
end;//evGetQueryGroup

function evGetField(aPara: Tl3Variant): IevEditorControlField;
 {* Возвращает указатель на поле для параграфа }
//#UC START# *48DCFE6000C3_47CFFEDE0215_var*
//#UC END# *48DCFE6000C3_47CFFEDE0215_var*
begin
//#UC START# *48DCFE6000C3_47CFFEDE0215_impl*
 aPara.QT(IevEditorControlField, Result);
//#UC END# *48DCFE6000C3_47CFFEDE0215_impl*
end;//evGetField

procedure evGetCustomImageList(const aPara: TnevControlInfo;
 out theImageInfo: TnevControlImageInfo;
 AType: TevControlType);
 {* Возвращает AImgIndex и ImageList, для контрола, если такие существуют }
//#UC START# *48DCFE79022C_47CFFEDE0215_var*
//#UC END# *48DCFE79022C_47CFFEDE0215_var*
begin
//#UC START# *48DCFE79022C_47CFFEDE0215_impl*
 l3FillChar(theImageInfo, SizeOf(theImageInfo));
 theImageInfo.rImageList := nil;
 theImageInfo.rFirstIndex := -1;
 theImageInfo.rLastIndex := -1;
 if (aPara.rControl.HolderPrim <> nil) then
  aPara.rControl.HolderPrim.GetControlImg(aPara, theImageInfo);
 if (theImageInfo.rFirstIndex < 0) or
    (theImageInfo.rFirstIndex >= theImageInfo.rImageList.Count) then
 //для возможности делать заплатки на оболочке
  if (aPara.rControl.AsObject.IntA[k2_tiStateIndex] = -1) then
   if (aPara.rControl.AsObject.IntA[k2_tiImageIndex] <> -1) then
   begin
    theImageInfo.rFirstIndex := aPara.rControl.AsObject.IntA[k2_tiImageIndex];
    aPara.rControl.AsObject.IntA[k2_tiStateIndex] := aPara.rControl.AsObject.IntA[k2_tiImageIndex];
   end//aPara.rControl.IntA[k2_tiImageIndex] <> -1
   else
    theImageInfo.rFirstIndex := -1
  else
   theImageInfo.rFirstIndex := aPara.rControl.AsObject.IntA[k2_tiStateIndex];
//#UC END# *48DCFE79022C_47CFFEDE0215_impl*
end;//evGetCustomImageList

function evChecked2State(aPara: Tl3Variant): Tl3ButtonState;
 {* Возвращает состояние кнопки, в зависимости от тега }
//#UC START# *48DCFE9C0079_47CFFEDE0215_var*
//#UC END# *48DCFE9C0079_47CFFEDE0215_var*
begin
//#UC START# *48DCFE9C0079_47CFFEDE0215_impl*
 if aPara.BoolA[k2_tiChecked] then
  Result := l3_bsDown
 else
  Result := l3_bsUp;
//#UC END# *48DCFE9C0079_47CFFEDE0215_impl*
end;//evChecked2State

function evMakeDateMaskText: Il3CString;
 {* Возвращает шаблон для поля даты }
//#UC START# *48DCFEB301AB_47CFFEDE0215_var*
//#UC END# *48DCFEB301AB_47CFFEDE0215_var*
begin
//#UC START# *48DCFEB301AB_47CFFEDE0215_impl*
 Result := l3CStr('  ' + {$IfDef XE}FormatSettings.{$EndIf}DateSeparator + '  ' + {$IfDef XE}FormatSettings.{$EndIf}DateSeparator + '  ');
//#UC END# *48DCFEB301AB_47CFFEDE0215_impl*
end;//evMakeDateMaskText

function evGetFullPathStr(const aTree: InevSimpleTree;
 const aNode: InevSimpleNode): Il3CString;
//#UC START# *48DCFEC302C1_47CFFEDE0215_var*

 function GetPath(const aNode: InevSimpleNode): Il3CString;
 const
  cSeparatorLevels = '\';
 var
  l_P : InevSimpleNode;
 begin//GetPath
  Result := nil;
  l_P := aNode.Parent;
  if (l_P <> nil) and not aNode.IsSame(aTree.RootNode) then
  begin
   Result := GetPath(l_P);
   if not l3IsNil(Result) then
    Result := l3Cat(Result, cSeparatorLevels);
   Result := l3Cat([Result,  l3CStr(aNode)]);
  end;//l_P <> ni
 end;//GetPath

//#UC END# *48DCFEC302C1_47CFFEDE0215_var*
begin
//#UC START# *48DCFEC302C1_47CFFEDE0215_impl*
 // если передают рутовую ноду - показываем иначе строим путь без рутовой ноды (СКР в Немезисе)
 if aTree.ShowRoot and (aNode.Parent = nil) then
  Result := l3CStr(aNode)
 else
  Result := GetPath(aNode);
//#UC END# *48DCFEC302C1_47CFFEDE0215_impl*
end;//evGetFullPathStr

function evIsFieldSet(const aField: IevEditorControlField;
 IgnoreDefaultValue: Boolean): Boolean;
//#UC START# *48DCFEE70217_47CFFEDE0215_var*
var
 l_TF  : IevEditorFieldWithTree;
 l_T   : Il3CString;
 l_Cal : IevEditorCalendarField;
 l_DN  : Il3SimpleNode;
 l_Req : IevReq;
//#UC END# *48DCFEE70217_47CFFEDE0215_var*
begin
//#UC START# *48DCFEE70217_47CFFEDE0215_impl*
 if (aField = nil) then
  Result := false
 else
 begin
  if (aField.Para.AsObject.IntA[k2_tiType] = Ord(ev_ctCalEdit)) then
  begin
   if Supports(aField, IevEditorCalendarField, l_Cal) then
    try
     Result := (l_Cal.aDate <> NullDate);
    finally
     l_Cal := nil;
    end//try..finally
   else
   begin
    Assert(false);
    Result := false;
   end;//Supports(aField, IevEditorCalendarField, l_Cal)
  end//aField.Para.IntA[k2_tiType] = ev_ctCalEdit
  else
  begin
   l_T := aField.Text;
   Result := not l3IsNil(l_T);
   if Result AND IgnoreDefaultValue then
   begin
    if Supports(aField, IevEditorFieldWithTree, l_TF) then
     try
      l_DN := l_TF.DefaultNode;
      if Assigned(l_TF.Value) then
      begin
       //Assert(l_DN <> nil, 'Ниже почему-то считаем что нода по-умолчанию есть всегда');
       if l_TF.Value.IsSame(l_DN) then
        Result := false;
      end//Assigned(l_TF.Value)
(*      else
      if l3Same(l_DN.Text, l_T) then
      // http://mdp.garant.ru/pages/viewpage.action?pageId=159358927&focusedCommentId=160006882#comment-160006882
       Result := false*);
     finally
      l_TF := nil;
     end;//try..finally
    if Result then
    begin
     l_Req := aField.Req;
     if (l_Req <> nil) and
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=604485227
      l3Same(l_T, aField.Req.Para.AsObject.PCharLenA[k2_tiDefaultText]) then
      Result := false;
    end;
   end;//Result AND IgnoreDefaultValue
  end;//aField.Para.IntA[k2_tiType] = ev_ctCalEdit
 end;//aField = nil
//#UC END# *48DCFEE70217_47CFFEDE0215_impl*
end;//evIsFieldSet

function evIsSomeFieldFilled(const aReq: IevReq;
 IgnoreDefaultValue: Boolean): Boolean;
//#UC START# *48DCFEF8007D_47CFFEDE0215_var*
var
 l_Index : Integer;
 l_F     : IevEditorControlField;
 l_Cal   : IevEditorCalendarField;
 l_Phone : IevEditorPhoneField;
//#UC END# *48DCFEF8007D_47CFFEDE0215_var*
begin
//#UC START# *48DCFEF8007D_47CFFEDE0215_impl*
 Result := false;
 if (aReq <> nil) then
  for l_Index := 0 to aReq.FieldsCount - 1 do
  begin
   l_F := aReq.Fields[l_Index];
   if Supports(l_F, IevEditorPhoneField, l_Phone) then
   try
    Result := evIsFieldSet(l_F, IgnoreDefaultValue) and evIsFieldSet(l_Phone.GetOtherField, IgnoreDefaultValue)
   finally
    l_Phone := nil;
   end//try..finally
   else
    Result := evIsFieldSet(l_F, IgnoreDefaultValue);
   if Result then
    break;
   if Supports(l_F, IevEditorCalendarField, l_Cal) then
    try
     Result := evIsFieldSet(l_Cal.GetOtherField, IgnoreDefaultValue);
     if Result then
      break;
    finally
     l_Cal := nil;
    end;//try..finally
  end;//for l_Index
//#UC END# *48DCFEF8007D_47CFFEDE0215_impl*
end;//evIsSomeFieldFilled

end.
