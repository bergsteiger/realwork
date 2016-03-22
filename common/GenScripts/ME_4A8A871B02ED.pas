unit nscCustomChatMemo;
 {* Мемо-поле для чата F1 }

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscCustomChatMemo.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscCustomChatMemo" MUID: (4A8A871B02ED)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evCustomChatMemo
 , evInternalInterfaces
 , nevTools
 , nevBase
 , l3Variant
 , evCustomMemo
 , evEditorWithOperations
;

type
 TnscCustomChatMemo = class(TevCustomChatMemo, IevF1LikeEditor)
  {* Мемо-поле для чата F1 }
  protected
   function ValidateInsertionPoint: Boolean;
    {* Проверить точку вставки на возможность оной, и если невозможно, то сместить курсор }
   function IsParaInF1Doc(aPara: Tl3Variant;
    out theDoc: InevPara): Boolean;
    {* Находится параграф ли в документе, скопированном из F1 }
   function IsInF1Doc(out theDoc: InevPara): Boolean;
    {* Находимся ли в документе, скопированном из F1 }
   function CanInsertParaOnMove: Boolean;
    {* Можно ли вставлять параграфы при движении курсора }
   function IsInReadOnlyPara(const aPara: InevPara;
    NeedDeleteIfReadOnly: Boolean): Boolean;
    {* Находимся ли в параграфе, в котором запрещено редактирование }
   procedure InitFields; override;
   function DoBreakPara(aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function TextSourceClass: RevCustomMemoTextSource; override;
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
    {* Какие операции публикуются компонентом. }
  public
   function Paste: Boolean; override;
    {* вставить из буфера обмена. }
 end;//TnscCustomChatMemo
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nscCustomChatMemoTextSource
 , evMsgCode
 , evOp
 , TextPara_Const
 , k2Tags
 , Document_Const
 , Para_Const
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TnscCustomChatMemo.ValidateInsertionPoint: Boolean;
 {* Проверить точку вставки на возможность оной, и если невозможно, то сместить курсор }
var l_Doc: InevPara;
var l_Point: InevBasePoint;
var l_Op: InevOp;
//#UC START# *4A8C12F70348_4A8A871B02ED_var*
//#UC END# *4A8C12F70348_4A8A871B02ED_var*
begin
//#UC START# *4A8C12F70348_4A8A871B02ED_impl*
 Result := true;
 if IsInF1Doc(l_Doc) then
 begin
  l_Op := StartOp;
  try
   l_Point := l_Doc.MakePoint;
   l_Point.Move(View, ev_ocBottomRight, l_Op);
   l_Point := l_Point.PointToParent;
   l_Point.Move(View, ev_ocParaDown, l_Op);
   InevSelection(Selection).SelectPoint(l_Point.PointToParentByLevel(MaxInt), false);
   if IsInF1Doc(l_Doc) then
   // - попали в ещё один документ
   begin
    l_Doc.OwnerPara.Modify.InsertDefaultPara(l_Doc.PID, l_Op);
    Selection.Cursor.Move(View, ev_ocParaUp, l_Op);
   end;//IsInF1Doc(l_Doc)
   with Selection.Cursor.MostInner do
    if Obj.AsObject.IsKindOf(k2_typTextPara) AND
       not evHasText(Obj^.AsObject) then
     Result := false;  
  finally
   l_Op := nil;
  end;//try..finally
 end;//evInPara(Selection.Cursor.MostInner.Obj^, k2_idDocument, l_Doc)
//#UC END# *4A8C12F70348_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.ValidateInsertionPoint

function TnscCustomChatMemo.IsParaInF1Doc(aPara: Tl3Variant;
 out theDoc: InevPara): Boolean;
 {* Находится параграф ли в документе, скопированном из F1 }
var l_Doc: Tl3Tag;
//#UC START# *4A8C16790143_4A8A871B02ED_var*
//#UC END# *4A8C16790143_4A8A871B02ED_var*
begin
//#UC START# *4A8C16790143_4A8A871B02ED_impl*
 Result := false;
 if evInPara(aPara.AsObject, k2_typDocument, l_Doc) then
 begin
  if l_Doc.Owner.IsKindOf(k2_typPara) AND
     (l_Doc.rLong(k2_tiExternalHandle, -1) > 0) then
  begin
   if not l_Doc.QT(InevPara, theDoc) then
    Assert(false);
   Result := true;
  end;//not l_Doc.Owner.IneritsFrom(k2_idPara)..
 end;//evInPara(aPara, k2_idDocument, l_Doc)
//#UC END# *4A8C16790143_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.IsParaInF1Doc

function TnscCustomChatMemo.IsInF1Doc(out theDoc: InevPara): Boolean;
 {* Находимся ли в документе, скопированном из F1 }
//#UC START# *4A8C249D02F4_4A8A871B02ED_var*
//#UC END# *4A8C249D02F4_4A8A871B02ED_var*
begin
//#UC START# *4A8C249D02F4_4A8A871B02ED_impl*
 Result := IsParaInF1Doc(Selection.Cursor.MostInner.Obj^.AsObject, theDoc);
//#UC END# *4A8C249D02F4_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.IsInF1Doc

function TnscCustomChatMemo.CanInsertParaOnMove: Boolean;
 {* Можно ли вставлять параграфы при движении курсора }
//#UC START# *4A8C083300C3_4A8A871B02ED_var*
//#UC END# *4A8C083300C3_4A8A871B02ED_var*
begin
//#UC START# *4A8C083300C3_4A8A871B02ED_impl*
 Result := true;
//#UC END# *4A8C083300C3_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.CanInsertParaOnMove

function TnscCustomChatMemo.IsInReadOnlyPara(const aPara: InevPara;
 NeedDeleteIfReadOnly: Boolean): Boolean;
 {* Находимся ли в параграфе, в котором запрещено редактирование }
//#UC START# *4A8C24130193_4A8A871B02ED_var*
var
 l_Doc : InevPara;
//#UC END# *4A8C24130193_4A8A871B02ED_var*
begin
//#UC START# *4A8C24130193_4A8A871B02ED_impl*
 Result := IsParaInF1Doc(aPara.AsObject, l_Doc);
 if Result then
  if NeedDeleteIfReadOnly then
   l_Doc.Edit.Delete(false, StartOp(ev_msgDeletePara));
//#UC END# *4A8C24130193_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.IsInReadOnlyPara

procedure TnscCustomChatMemo.InitFields;
//#UC START# *47A042E100E2_4A8A871B02ED_var*
//#UC END# *47A042E100E2_4A8A871B02ED_var*
begin
//#UC START# *47A042E100E2_4A8A871B02ED_impl*
 inherited;
 AutoSelect := false;
//#UC END# *47A042E100E2_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.InitFields

function TnscCustomChatMemo.DoBreakPara(aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *482BFCBF01F0_4A8A871B02ED_var*
var
 l_Op : InevOp;
//#UC END# *482BFCBF01F0_4A8A871B02ED_var*
begin
//#UC START# *482BFCBF01F0_4A8A871B02ED_impl*
 l_Op := StartOp(ev_msgInsertPara);
 try
  if not ValidateInsertionPoint then
   Result := true
  else
   Result := inherited DoBreakPara(aDrawLines, anOp);
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *482BFCBF01F0_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.DoBreakPara

function TnscCustomChatMemo.TextSourceClass: RevCustomMemoTextSource;
//#UC START# *482D9D1701E0_4A8A871B02ED_var*
//#UC END# *482D9D1701E0_4A8A871B02ED_var*
begin
//#UC START# *482D9D1701E0_4A8A871B02ED_impl*
 Result := TnscCustomChatMemoTextSource;
//#UC END# *482D9D1701E0_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.TextSourceClass

function TnscCustomChatMemo.DefineProvideOperations: TevEditorProvideOperationTypes;
 {* Какие операции публикуются компонентом. }
//#UC START# *48735C4A03C3_4A8A871B02ED_var*
//#UC END# *48735C4A03C3_4A8A871B02ED_var*
begin
//#UC START# *48735C4A03C3_4A8A871B02ED_impl*
 Result := inherited DefineProvideOperations - [potPrint, potTable, potFontStyle];
//#UC END# *48735C4A03C3_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.DefineProvideOperations

function TnscCustomChatMemo.Paste: Boolean;
 {* вставить из буфера обмена. }
//#UC START# *48C7C1A2010C_4A8A871B02ED_var*
//#UC END# *48C7C1A2010C_4A8A871B02ED_var*
begin
//#UC START# *48C7C1A2010C_4A8A871B02ED_impl*
 ValidateInsertionPoint;
 Result := inherited Paste;
//#UC END# *48C7C1A2010C_4A8A871B02ED_impl*
end;//TnscCustomChatMemo.Paste

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscCustomChatMemo);
 {* Регистрация TnscCustomChatMemo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
