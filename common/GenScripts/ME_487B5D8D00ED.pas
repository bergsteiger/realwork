unit evBlockCursor;
 {* Курсор с выделением. }

// Модуль: "w:\common\components\gui\Garant\Everest\evBlockCursor.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evWindowCursor
 , nevTools
 , l3Variant
 , nevBase
 , l3Interfaces
 , l3IID
;

type
 TevBlockCursor = class(TevWindowCursor, InevTextModify, InevText, IevRange)
  {* Курсор с выделением. }
  private
   f_LockCursorChange: Integer;
   f_NoCaret: Boolean;
    {* Поле для свойства NoCaret }
   f_Persistent: Boolean;
    {* Поле для свойства Persistent }
   f_Start: InevLinkedPoint;
    {* Поле для свойства Start }
   f_Finish: InevLinkedPoint;
    {* Поле для свойства Finish }
   f_DrawLines: Boolean;
    {* Поле для свойства DrawLines }
   f_StartMark: InevPoint;
    {* Поле для свойства StartMark }
   f_FinishMark: InevPoint;
    {* Поле для свойства FinishMark }
   f_StartMarkForCtrlKBCtrlKK: InevPoint;
    {* Поле для свойства StartMarkForCtrlKBCtrlKK }
  protected
   function pm_GetStartMark: InevPoint;
   function pm_GetFinishMark: InevPoint;
   function pm_GetText: InevText;
   function pm_GetStartMarkForCtrlKBCtrlKK: InevPoint;
   procedure UpdateBlock;
   procedure AfterProcessCommand; virtual;
   function CanBeDeleted: Boolean;
   function Modify: InevTextModify;
   function InsertString(const aView: InevView;
    const aString: Il3CString;
    const anOp: InevOp = nil;
    InsertMode: Boolean = True;
    aFlags: TnevInsertStringFlags = []): Boolean;
    {* вставляет строку. }
   function InsertStream(const aView: InevView;
    const aStream: IStream;
    aFormat: TnevFormat;
    const anOp: InevOp = nil;
    aFlags: TevLoadFlags = nevBase.evDefaultLoadFlags;
    aCodePage: Integer = CP_DefaultValue): Boolean;
   function DeleteString(const aView: InevView;
    Count: Integer;
    const anOp: InevOp = nil;
    aFlags: TnevInsertStringFlags = []): Boolean;
    {* удаляет строку. }
   function DeleteChar(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean;
   function InsertBreak(const aView: InevView;
    aDrawLines: Boolean = False;
    const anOp: InevOp = nil): Boolean;
   function DeleteCharToLeft(const aView: InevView;
    aDrawLines: Boolean = False;
    const anOp: InevOp = nil): Boolean;
   function Split(const aView: InevView;
    aFlags: TnevInsertStringFlags;
    const anOp: InevOp): Il3TagRef;
   function JoinWith(const aView: InevView;
    aSecondPara: Tl3Variant;
    const anOp: InevOp = nil;
    MoveSubs: Boolean = True): Integer;
   function JoinWithNext(const aView: InevView;
    const anOp: InevOp = nil): Boolean;
   procedure AssignSel(const aView: InevView;
    const aSource: InevRange);
    {* присваивает одно выделение другому }
   function GetBlock: InevRange;
    {* получить текущий объект выделения }
   procedure SetToStart;
    {* установить выделение в начало }
   function Unselect(const aView: InevView): Boolean;
    {* снять выделение }
   procedure SetToFinish(aMoveUpInLines: Integer);
   function DoGetBlock(const aDocument: InevObject): InevRange; override;
   function DoAddBlock(const aStart: InevBasePoint;
    const aFinish: InevBasePoint): Boolean; override;
   function GetContains(const C: InevBasePoint): Boolean; override;
   procedure DoCursorChanged(const aCursor: InevBasePoint); override;
   procedure DoAssignSel(const aView: InevView;
    const aSource: InevRange;
    AllowAddToMulti: Boolean); override;
   procedure DoSetDocument(aValue: Tl3Tag); override;
   function NeedUnselectOnSelectPoint(const aPoint: InevBasePoint): Boolean; override;
    {* Нужно ли сбрасывать выделение в SelectPoint }
   function DoUnselect: Boolean; override;
    {* Снять выделение }
   function UpdateCursor(const aCursor: InevBasePoint): Boolean; override;
   function pm_GetCollapsed: Boolean; override;
   function IsBlockCursor(const aCursor: InevBasePoint): Boolean; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure ClearFields; override;
  public
   function SetAtom(anIndex: Cardinal;
    pSource: Tl3Variant;
    const anOpPack: InevOp = nil): Boolean;
   function ProcessCommand(aMsg: Integer;
    aCode: Cardinal;
    const anOp: InevOp;
    aCount: Integer): Boolean;
   function DeleteHyperlink(const anOpPack: InevOp = nil): Boolean;
   function ChangeParam(const aMarker: IevMarker;
    aValue: Integer;
    const anOpPack: InevOp = nil): Boolean;
   function SaveBlock(const aCheckCursor: InevBasePoint = nil): InevLocation;
    {* получить копию текущего объекта выделения }
   function AddIndentMarker(aValue: Integer;
    const anOpPack: InevOp = nil): Boolean;
   procedure SetFocus; override;
    {* Окно получило фокус }
   procedure ForceStore; override;
  public
   property NoCaret: Boolean
    read f_NoCaret
    write f_NoCaret;
   property Persistent: Boolean
    read f_Persistent
    write f_Persistent
    default False;
    {* Persistent-выделение? }
   property Start: InevLinkedPoint
    read f_Start;
    {* начало выделения }
   property Finish: InevLinkedPoint
    read f_Finish;
    {* конец выделения }
   property DrawLines: Boolean
    read f_DrawLines
    write f_DrawLines;
    {* режим рисования линий? }
   property StartMark: InevPoint
    read pm_GetStartMark;
   property FinishMark: InevPoint
    read pm_GetFinishMark;
   property Text: InevText
    read pm_GetText;
   property StartMarkForCtrlKBCtrlKK: InevPoint
    read pm_GetStartMarkForCtrlKBCtrlKK;
    {* [$296097324] }
 end;//TevBlockCursor

implementation

uses
 l3ImplUses
 , k2Base
 , l3InterfacesMisc
 , SysUtils
 , evEditorInterfaces
 , evExcept
 , evRange
 , k2TagGen
 , l3Base
 , evDocumentPartGenerator
 , evMsgCode
 , nevNavigation
 , k2Tags
 , evOp
;

function TevBlockCursor.pm_GetStartMark: InevPoint;
//#UC START# *48E3824C0136_487B5D8D00EDget_var*
//#UC END# *48E3824C0136_487B5D8D00EDget_var*
begin
//#UC START# *48E3824C0136_487B5D8D00EDget_impl*
 Result := CheckCursor(f_StartMark);
//#UC END# *48E3824C0136_487B5D8D00EDget_impl*
end;//TevBlockCursor.pm_GetStartMark

function TevBlockCursor.pm_GetFinishMark: InevPoint;
//#UC START# *48E3825D006C_487B5D8D00EDget_var*
//#UC END# *48E3825D006C_487B5D8D00EDget_var*
begin
//#UC START# *48E3825D006C_487B5D8D00EDget_impl*
 Result := CheckCursor(f_FinishMark);
//#UC END# *48E3825D006C_487B5D8D00EDget_impl*
end;//TevBlockCursor.pm_GetFinishMark

function TevBlockCursor.pm_GetText: InevText;
//#UC START# *48E39C450371_487B5D8D00EDget_var*
//#UC END# *48E39C450371_487B5D8D00EDget_var*
begin
//#UC START# *48E39C450371_487B5D8D00EDget_impl*
 Result := Self;
//#UC END# *48E39C450371_487B5D8D00EDget_impl*
end;//TevBlockCursor.pm_GetText

function TevBlockCursor.pm_GetStartMarkForCtrlKBCtrlKK: InevPoint;
//#UC START# *4EAA7C9502E7_487B5D8D00EDget_var*
//#UC END# *4EAA7C9502E7_487B5D8D00EDget_var*
begin
//#UC START# *4EAA7C9502E7_487B5D8D00EDget_impl*
 Result := CheckCursor(f_StartMarkForCtrlKBCtrlKK);
//#UC END# *4EAA7C9502E7_487B5D8D00EDget_impl*
end;//TevBlockCursor.pm_GetStartMarkForCtrlKBCtrlKK

procedure TevBlockCursor.UpdateBlock;
//#UC START# *48E38B850299_487B5D8D00ED_var*
//#UC END# *48E38B850299_487B5D8D00ED_var*
begin
//#UC START# *48E38B850299_487B5D8D00ED_impl*
 if (View <> nil) AND (View.Control <> nil) then
  View.Control.SetFlag(ev_uwfBlock);
//#UC END# *48E38B850299_487B5D8D00ED_impl*
end;//TevBlockCursor.UpdateBlock

procedure TevBlockCursor.AfterProcessCommand;
//#UC START# *48E38E83007A_487B5D8D00ED_var*
//#UC END# *48E38E83007A_487B5D8D00ED_var*
begin
//#UC START# *48E38E83007A_487B5D8D00ED_impl*
 // DoNothing;
//#UC END# *48E38E83007A_487B5D8D00ED_impl*
end;//TevBlockCursor.AfterProcessCommand

function TevBlockCursor.SetAtom(anIndex: Cardinal;
 pSource: Tl3Variant;
 const anOpPack: InevOp = nil): Boolean;
//#UC START# *48E391A7001E_487B5D8D00ED_var*
var
 l_Cursor : InevBasePoint;
 l_OpPack : InevOp;
 l_Block  : InevRange;
//#UC END# *48E391A7001E_487B5D8D00ED_var*
begin
//#UC START# *48E391A7001E_487B5D8D00ED_impl*
 if (anOpPack = nil) then
  l_OpPack := Processor.StartOp
 else
  l_OpPack := anOpPack;
 try
  l_Cursor := Cursor;
  if (l_Cursor = nil) then
   Result := False
  else
  if Contains(l_Cursor) then
  begin
   l_Block := GetBlock;
   Result := l_Block.Formatting.Modify(View).SetAtom(View, anIndex, pSource, l_OpPack);
   if (anIndex = Ord(k2_tiJustification)) and Result then
    l_Block.Formatting.Modify(View).DeleteIndentMarker(View, l_OpPack);
  end
  else
  begin
   Result := l_Cursor.Formatting.Modify(View).SetAtom(View, anIndex, pSource, l_OpPack);
   if (anIndex = Ord(k2_tiJustification)) and Result then
    l_Cursor.Formatting.Modify(View).DeleteIndentMarker(View, l_OpPack);
  end;
 finally
  l_OpPack := nil; 
 end;//try..finally
//#UC END# *48E391A7001E_487B5D8D00ED_impl*
end;//TevBlockCursor.SetAtom

function TevBlockCursor.ProcessCommand(aMsg: Integer;
 aCode: Cardinal;
 const anOp: InevOp;
 aCount: Integer): Boolean;
//#UC START# *48E3967B03AF_487B5D8D00ED_var*

 function ExtendingOp2Op(var Op          : Cardinal;
                         out ExtendBlock : Boolean): Boolean;
   {-}
 begin
  Result := true;
  Case OP of
   ev_ocExtLineDown    : Op := ev_ocLineDown;
   ev_ocExtLineEnd     : Op := ev_ocLineEnd;
   ev_ocExtLineHome    : Op := ev_ocLineHome;
   ev_ocExtCharLeft    : Op := ev_ocCharLeft;
   ev_ocExtPageDown    : Op := ev_ocPageDown;
   ev_ocExtPageUp      : Op := ev_ocPageUp;
   ev_ocExtCharRight   : Op := ev_ocCharRight;
   ev_ocExtLineUp      : Op := ev_ocLineUp;
   ev_ocExtPageBottom  : Op := ev_ocPageBottom;
   ev_ocExtTop         : Op := ev_ocTopLeft;
   ev_ocExtBottom      : Op := ev_ocBottomRight;
   ev_ocExtPageTop     : Op := ev_ocPageTop;
   ev_ocExtWordLeft    : Op := ev_ocWordLeft;
   ev_ocExtWordRight   : Op := ev_ocWordRight;
   ev_ocExtParaUp      : Op := ev_ocParaUp;
   ev_ocExtParaDown    : Op := ev_ocParaDown;
   ev_ocExtParaEnd     : Op := ev_ocParaEnd;
   else Result := false;
  end;{Case Op of..}
  ExtendBlock := Result;
 end;

var
 l_ExtendBlock  : Boolean;
 l_DrawLineTool : IevDrawLineTool;
 l_Extending    : Boolean;
 l_FI           : TnevFormatInfoPrim;
//#UC END# *48E3967B03AF_487B5D8D00ED_var*
begin
//#UC START# *48E3967B03AF_487B5D8D00ED_impl*
 if ((aMsg >= ev_msgFirstOp) AND (aMsg <= ev_msgLastOp)) then
 begin
  if (aMsg = ev_msgMove) then
  begin
   l_Extending := ExtendingOp2Op(aCode, l_ExtendBlock);
   if l_Extending then
   begin
    if DrawLines then
    begin
     if Supports(Cursor, IevDrawLineTool, l_DrawLineTool) then
      try
       case aCode of
        ev_ocLineUp:
         Result := l_DrawLineTool.DrawLine(View, ev_ldUp, ev_lsNormal, anOp);
        ev_ocLineDown:
         Result := l_DrawLineTool.DrawLine(View, ev_ldDown, ev_lsNormal, anOp);
        ev_ocCharLeft:
         Result := l_DrawLineTool.DrawLine(View, ev_ldLeft, ev_lsNormal, anOp);
        ev_ocCharRight:
         Result := l_DrawLineTool.DrawLine(View, ev_ldRight, ev_lsNormal, anOp);
        ev_ocParaUp:
         Result := l_DrawLineTool.DrawLine(View, ev_ldUp, ev_lsClear, anOp);
        ev_ocParaDown:
         Result := l_DrawLineTool.DrawLine(View, ev_ldDown, ev_lsClear, anOp);
        ev_ocWordLeft:
         Result := l_DrawLineTool.DrawLine(View, ev_ldLeft, ev_lsClear, anOp);
        ev_ocWordRight:
         Result := l_DrawLineTool.DrawLine(View, ev_ldRight, ev_lsClear, anOp);
        else
         Result := false;
       end;//case aCode
       if Result then
        Exit;
      finally
       l_DrawLineTool := nil;
      end;//try..finally
    end;//DrawLines
    if (Cursor.Compare(f_Start) = 0) then
     StartMark.AssignPoint(View, f_Finish)
    else
    if (Cursor.Compare(f_Finish) = 0) then
     StartMark.AssignPoint(View, f_Start)
    else
     StartMark.AssignPoint(View, Cursor);
   end//l_Extending
   else
   begin
    if DrawLines then
    begin
     if Supports(Cursor, IevDrawLineTool, l_DrawLineTool) then
      try
       case aCode of
        ev_ocLineHome:
         Result := l_DrawLineTool.DrawLine(View, ev_ldHome, ev_lsMove, anOp);
        ev_ocLineEnd:
         Result := l_DrawLineTool.DrawLine(View, ev_ldEnd, ev_lsMove, anOp);
        ev_ocParaUp:
         Result := l_DrawLineTool.DrawLine(View, ev_ldUp, ev_lsSymbol, anOp);
        ev_ocParaDown:
         Result := l_DrawLineTool.DrawLine(View, ev_ldDown, ev_lsSymbol, anOp);
        ev_ocWordLeft:
         Result := l_DrawLineTool.DrawLine(View, ev_ldLeft, ev_lsSymbol, anOp);
        ev_ocWordRight:
         Result := l_DrawLineTool.DrawLine(View, ev_ldRight, ev_lsSymbol, anOp);
        else
         Result := False;
       end;//case aCode
       if Result then
        Exit;
      finally
       l_DrawLineTool := nil;
      end;//try..finally
    end;//DrawLines
    l_ExtendBlock := False;
   end;//l_Extending
  end;//aMsg = ev_msgMove
  try
   case aMsg of
    ev_msgBreakPara:
     Result := InsertBreak(View, DrawLines, anOp);
    ev_msgBackspace:
     Result := DeleteCharToLeft(View, DrawLines, anOp);
    ev_msgDeleteHyperlink:
     Result := DeleteHyperlink(anOp);
    ev_msgMove:
    begin
     Result := True;
     case aCode of
      ev_ocLineUp:
       if (View = nil) then
        Result := False
       else
        View.Caret.LineUp(aCount);
      ev_ocLineDown:
       if (View = nil) then
        Result := False
       else
        View.Caret.LineDown(aCount);
      ev_ocPageUp :
       if (View = nil) then
        Result := False
       else
        View.Caret.PageUp;
      ev_ocPageDown :
       if (View = nil) then
        Result := False
       else
        Result := View.Caret.PageDown;
      ev_ocTopLeft:
       if (View = nil) then
        Result := False
       else
        View.Caret.Top;
      ev_ocBottomRight,
      ev_ocBottomRightIgnoreMergedCell:
       if (View = nil) then
        Result := False
       else
        View.Caret.Bottom;
      else
       if (Cursor = nil) then
        Result := False
       else 
        Result := Cursor.Move(View, aCode, anOp);
     end;//case aCode
     if Result OR
        (aCode = ev_ocCharLeft)
        // - почему-то она возвращает "неправильный" результат
        then
      Case aCode of
       ev_ocTopLeft,
       ev_ocPageUp,
       ev_ocLineUp,
       ev_ocCharLeft:
       begin
       // - при следующем проявлении ошибки - будем расширять список и анализировать
       //   направление движения
        if (View <> nil) then
        begin
         l_FI := View.FormatInfoByPara(Cursor.MostInner.Obj);
         if (l_FI <> nil) AND
            l_FI.IsHidden(false, true) then
          // проверка видимости параграфа для http://mdp.garant.ru/pages/viewpage.action?pageId=89106155
          Cursor.MostInner.Move(View, {ev_ocParaDown}ev_ocNextParaTopLeft);
          // http://mdp.garant.ru/pages/viewpage.action?pageId=252524393
        end;//
       end;//ev_ocTopLeft..
      end;//Case aCode
    end;//ev_msgMove
    else
     Result := False;
   end;//case aMsg
  except
   on EevReadOnly do
    Result := False;
  end;//try..except
  AfterProcessCommand;
  if (not l_ExtendBlock OR
     not AddBlock(StartMark, Cursor)) AND
     not Persistent then
   Unselect(View);
 end//aMsg >=..
 else
  Result := False;
//#UC END# *48E3967B03AF_487B5D8D00ED_impl*
end;//TevBlockCursor.ProcessCommand

function TevBlockCursor.DeleteHyperlink(const anOpPack: InevOp = nil): Boolean;
//#UC START# *48E39B6B033A_487B5D8D00ED_var*
//#UC END# *48E39B6B033A_487B5D8D00ED_var*
begin
//#UC START# *48E39B6B033A_487B5D8D00ED_impl*
 if not Persistent AND Contains(Cursor) then
  Result := GetBlock.Formatting.Modify(View).DeleteHyperlink(anOpPack)
 else
 begin
  if (Cursor = nil) then
   Result := False
  else
   Result := Cursor.Formatting.Modify(View).DeleteHyperlink(anOpPack);
 end;//not Persistent..
//#UC END# *48E39B6B033A_487B5D8D00ED_impl*
end;//TevBlockCursor.DeleteHyperlink

function TevBlockCursor.ChangeParam(const aMarker: IevMarker;
 aValue: Integer;
 const anOpPack: InevOp = nil): Boolean;
//#UC START# *48E39E220023_487B5D8D00ED_var*
var
 l_Cursor : InevBasePoint;
 l_OpPack : InevOp;
//#UC END# *48E39E220023_487B5D8D00ED_var*
begin
//#UC START# *48E39E220023_487B5D8D00ED_impl*
 if (anOpPack = nil) then
  l_OpPack := Processor.StartOp(ev_msgChangeParam)
 else
  l_OpPack := anOpPack;
 try
  l_Cursor := Cursor;
  if (l_Cursor = nil) then
   Result := false
  else
  if Contains(l_Cursor) then
   Result := GetBlock.Formatting.Modify(View).ChangeParam(View, aMarker, aValue, l_OpPack)
  else
   Result := l_Cursor.Formatting.Modify(View).ChangeParam(View, aMarker, aValue, l_OpPack);
 finally
  l_OpPack := nil; {* - Закрываем пачку операций. }
 end;//try..finally
//#UC END# *48E39E220023_487B5D8D00ED_impl*
end;//TevBlockCursor.ChangeParam

function TevBlockCursor.SaveBlock(const aCheckCursor: InevBasePoint = nil): InevLocation;
 {* получить копию текущего объекта выделения }
//#UC START# *48E39F8403B6_487B5D8D00ED_var*
var
 l_CC : InevBasePoint;
//#UC END# *48E39F8403B6_487B5D8D00ED_var*
begin
//#UC START# *48E39F8403B6_487B5D8D00ED_impl*
 if (aCheckCursor = nil) then
  l_CC := Cursor
 else
  l_CC := aCheckCursor;
 if Contains(l_CC) then
  Result := DocumentPara.Range(f_Start.ClonePoint(View), f_Finish.ClonePoint(View))
 else
  Result := l_CC.ClonePoint(View);
//#UC END# *48E39F8403B6_487B5D8D00ED_impl*
end;//TevBlockCursor.SaveBlock

function TevBlockCursor.AddIndentMarker(aValue: Integer;
 const anOpPack: InevOp = nil): Boolean;
//#UC START# *48E3A0BC0108_487B5D8D00ED_var*
var
 l_Cursor : InevBasePoint;
 l_OpPack : InevOp;
//#UC END# *48E3A0BC0108_487B5D8D00ED_var*
begin
//#UC START# *48E3A0BC0108_487B5D8D00ED_impl*
 if (anOpPack = nil) then
  l_OpPack := Processor.StartOp(ev_msgAddMarker)
 else
  l_OpPack := anOpPack;
 try
  l_Cursor := Cursor;
  if (l_Cursor = nil) then
   Result := false
  else
  if Contains(l_Cursor) then
   Result := GetBlock.Formatting.Modify(View).AddIndentMarker(View, aValue, anOpPack)
  else
   Result := l_Cursor.Formatting.Modify(View).AddIndentMarker(View, aValue, anOpPack);
 finally
  l_OpPack := nil; {* - Закрываем пачку операций. }
 end;//try..finally
//#UC END# *48E3A0BC0108_487B5D8D00ED_impl*
end;//TevBlockCursor.AddIndentMarker

function TevBlockCursor.CanBeDeleted: Boolean;
//#UC START# *47C5B23101DE_487B5D8D00ED_var*
//#UC END# *47C5B23101DE_487B5D8D00ED_var*
begin
//#UC START# *47C5B23101DE_487B5D8D00ED_impl*
 if not Persistent AND Contains(Cursor) then
  Result := GetBlock.Text.CanBeDeleted
 else
 if (Cursor = nil) then
  Result := False
 else
  Result := Cursor.Text.CanBeDeleted;
//#UC END# *47C5B23101DE_487B5D8D00ED_impl*
end;//TevBlockCursor.CanBeDeleted

function TevBlockCursor.Modify: InevTextModify;
//#UC START# *47C5B23D0301_487B5D8D00ED_var*
//#UC END# *47C5B23D0301_487B5D8D00ED_var*
begin
//#UC START# *47C5B23D0301_487B5D8D00ED_impl*
 Result := Self;
//#UC END# *47C5B23D0301_487B5D8D00ED_impl*
end;//TevBlockCursor.Modify

function TevBlockCursor.InsertString(const aView: InevView;
 const aString: Il3CString;
 const anOp: InevOp = nil;
 InsertMode: Boolean = True;
 aFlags: TnevInsertStringFlags = []): Boolean;
 {* вставляет строку. }
//#UC START# *47C5B31203AD_487B5D8D00ED_var*
var
 l_Text : InevText;  
//#UC END# *47C5B31203AD_487B5D8D00ED_var*
begin
//#UC START# *47C5B31203AD_487B5D8D00ED_impl*
 if not Persistent AND Contains(Cursor) then
 begin
  l_Text := GetBlock.Text;
  if (l_Text <> nil) AND (l_Text.Modify <> nil) then
  begin
   Cursor.AssignPoint(View, f_Finish);
   aFlags := aFlags + [misfForSelection];
  end;//(l_Text <> nil) AND (l_Text.Modify <> nil)
 end//not Persistent AND Contains(Cursor)
 else
 begin
  if (Cursor = nil) then
   l_Text := nil
  else
   l_Text := Cursor.Text;
 end;//not Persistent..
 if (l_Text = nil) OR (l_Text.Modify = nil) then
  Result := False
 else
 begin
  Result := l_Text.Modify.InsertString(aView, aString, anOp, InsertMode, aFlags);
  if Result AND not Persistent then
   Unselect(View);
 end;//l_Text = nil
//#UC END# *47C5B31203AD_487B5D8D00ED_impl*
end;//TevBlockCursor.InsertString

function TevBlockCursor.InsertStream(const aView: InevView;
 const aStream: IStream;
 aFormat: TnevFormat;
 const anOp: InevOp = nil;
 aFlags: TevLoadFlags = nevBase.evDefaultLoadFlags;
 aCodePage: Integer = CP_DefaultValue): Boolean;
//#UC START# *47C5B3410044_487B5D8D00ED_var*
var
 l_Text : InevText;
 l_Sel  : Boolean;
//#UC END# *47C5B3410044_487B5D8D00ED_var*
begin
//#UC START# *47C5B3410044_487B5D8D00ED_impl*
 l_Sel := false;
 if not Persistent AND Contains(Cursor) then
 begin
  l_Sel := true;
  l_Text := GetBlock.Text;
 end//not Persistent AND Contains(Cursor)
 else
 begin
  if (Cursor = nil) then
   l_Text := nil
  else
   l_Text := Cursor.Text;
 end;//not Persistent..
 if (l_Text = nil) OR (l_Text.Modify = nil) then
  Result := False
 else
 begin
  Result := l_Text.Modify.InsertStream(aView, aStream, aFormat, anOp, aFlags, aCodePage);
  if l_Sel then
   Cursor.AssignPoint(aView, Start);
 end;//l_Text = nil..
//#UC END# *47C5B3410044_487B5D8D00ED_impl*
end;//TevBlockCursor.InsertStream

function TevBlockCursor.DeleteString(const aView: InevView;
 Count: Integer;
 const anOp: InevOp = nil;
 aFlags: TnevInsertStringFlags = []): Boolean;
 {* удаляет строку. }
//#UC START# *47C5B48E01CF_487B5D8D00ED_var*
//#UC END# *47C5B48E01CF_487B5D8D00ED_var*
begin
//#UC START# *47C5B48E01CF_487B5D8D00ED_impl*
 if not Persistent AND Contains(Cursor) then
  Result := GetBlock.Text.Modify.DeleteString(aView, Count, anOp, aFlags)
 else
 begin
  if (Cursor = nil) then
   Result := False
  else
   Result := Cursor.Text.Modify.DeleteString(aView, Count, anOp, aFlags);
 end;//not Persistent..
//#UC END# *47C5B48E01CF_487B5D8D00ED_impl*
end;//TevBlockCursor.DeleteString

function TevBlockCursor.DeleteChar(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *47C5B4A30392_487B5D8D00ED_var*
//#UC END# *47C5B4A30392_487B5D8D00ED_var*
begin
//#UC START# *47C5B4A30392_487B5D8D00ED_impl*
 Result := False;
 try
  if not Persistent AND Contains(Cursor) then
   Result := GetBlock.Text.Modify.DeleteChar(aView, DrawLines, anOp)
  else
  if (Cursor <> nil) then
   Result := Cursor.Text.Modify.DeleteChar(aView, DrawLines, anOp);
  if Result AND not Persistent then
   Unselect(aView);
 except
  on EevReadOnly do ;
 end;//try..except
//#UC END# *47C5B4A30392_487B5D8D00ED_impl*
end;//TevBlockCursor.DeleteChar

function TevBlockCursor.InsertBreak(const aView: InevView;
 aDrawLines: Boolean = False;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C5B4B10123_487B5D8D00ED_var*
var
 l_Text : InevText;
//#UC END# *47C5B4B10123_487B5D8D00ED_var*
begin
//#UC START# *47C5B4B10123_487B5D8D00ED_impl*
 if not Persistent AND Contains(Cursor) then
  l_Text := GetBlock.Text
 else
 begin
  if (Cursor = nil) then
   l_Text := nil
  else
   l_Text := Cursor.Text;
 end;//not Persistent..
 if (l_Text = nil) then
  Result := False
 else
  Result := l_Text.Modify.InsertBreak(aView, aDrawLines, anOp);
//#UC END# *47C5B4B10123_487B5D8D00ED_impl*
end;//TevBlockCursor.InsertBreak

function TevBlockCursor.DeleteCharToLeft(const aView: InevView;
 aDrawLines: Boolean = False;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C5B4BF021F_487B5D8D00ED_var*
//#UC END# *47C5B4BF021F_487B5D8D00ED_var*
begin
//#UC START# *47C5B4BF021F_487B5D8D00ED_impl*
 if not Persistent AND Contains(Cursor) then
  Result := GetBlock.Text.Modify.DeleteCharToLeft(aView, aDrawLines, anOp)
 else
 begin
  if (Cursor = nil) then
   Result := False
  else
   Result := Cursor.Text.Modify.DeleteCharToLeft(aView, aDrawLines, anOp);
 end;//not Persistent..
//#UC END# *47C5B4BF021F_487B5D8D00ED_impl*
end;//TevBlockCursor.DeleteCharToLeft

function TevBlockCursor.Split(const aView: InevView;
 aFlags: TnevInsertStringFlags;
 const anOp: InevOp): Il3TagRef;
//#UC START# *47C5B4CF00D0_487B5D8D00ED_var*
//#UC END# *47C5B4CF00D0_487B5D8D00ED_var*
begin
//#UC START# *47C5B4CF00D0_487B5D8D00ED_impl*
 if (Cursor <> nil) then
  Result := Cursor.Text.Modify.Split(aView, aFlags, anOp)
 else
  Result := Tl3NullTag.Instance;
//#UC END# *47C5B4CF00D0_487B5D8D00ED_impl*
end;//TevBlockCursor.Split

function TevBlockCursor.JoinWith(const aView: InevView;
 aSecondPara: Tl3Variant;
 const anOp: InevOp = nil;
 MoveSubs: Boolean = True): Integer;
//#UC START# *47C5B4E001F9_487B5D8D00ED_var*
//#UC END# *47C5B4E001F9_487B5D8D00ED_var*
begin
//#UC START# *47C5B4E001F9_487B5D8D00ED_impl*
 if (Cursor <> nil) then
  Result := Cursor.Text.Modify.JoinWith(aView, aSecondPara, anOp, MoveSubs)
 else
  Result := -1;
//#UC END# *47C5B4E001F9_487B5D8D00ED_impl*
end;//TevBlockCursor.JoinWith

function TevBlockCursor.JoinWithNext(const aView: InevView;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C5B4FA0219_487B5D8D00ED_var*
//#UC END# *47C5B4FA0219_487B5D8D00ED_var*
begin
//#UC START# *47C5B4FA0219_487B5D8D00ED_impl*
 if (Cursor <> nil) then
  Result := Cursor.Text.Modify.JoinWithNext(aView, anOp)
 else
  Result := False;
//#UC END# *47C5B4FA0219_487B5D8D00ED_impl*
end;//TevBlockCursor.JoinWithNext

procedure TevBlockCursor.AssignSel(const aView: InevView;
 const aSource: InevRange);
 {* присваивает одно выделение другому }
//#UC START# *48E25C7E0366_487B5D8D00ED_var*
//#UC END# *48E25C7E0366_487B5D8D00ED_var*
begin
//#UC START# *48E25C7E0366_487B5D8D00ED_impl*
 DoAssignSel(aView, aSource, true);
//#UC END# *48E25C7E0366_487B5D8D00ED_impl*
end;//TevBlockCursor.AssignSel

function TevBlockCursor.GetBlock: InevRange;
 {* получить текущий объект выделения }
//#UC START# *48E25C980073_487B5D8D00ED_var*
//#UC END# *48E25C980073_487B5D8D00ED_var*
begin
//#UC START# *48E25C980073_487B5D8D00ED_impl*
 Result := inherited GetBlock;
//#UC END# *48E25C980073_487B5D8D00ED_impl*
end;//TevBlockCursor.GetBlock

procedure TevBlockCursor.SetToStart;
 {* установить выделение в начало }
//#UC START# *48E25CA5027C_487B5D8D00ED_var*
//#UC END# *48E25CA5027C_487B5D8D00ED_var*
begin
//#UC START# *48E25CA5027C_487B5D8D00ED_impl*
 SelectPoint(Start, True);
//#UC END# *48E25CA5027C_487B5D8D00ED_impl*
end;//TevBlockCursor.SetToStart

function TevBlockCursor.Unselect(const aView: InevView): Boolean;
 {* снять выделение }
//#UC START# *48E25CB3032B_487B5D8D00ED_var*
//#UC END# *48E25CB3032B_487B5D8D00ED_var*
begin
//#UC START# *48E25CB3032B_487B5D8D00ED_impl*
 Result := DoUnselect;
//#UC END# *48E25CB3032B_487B5D8D00ED_impl*
end;//TevBlockCursor.Unselect

procedure TevBlockCursor.SetToFinish(aMoveUpInLines: Integer);
//#UC START# *50AF18AD03DD_487B5D8D00ED_var*
//#UC END# *50AF18AD03DD_487B5D8D00ED_var*
begin
//#UC START# *50AF18AD03DD_487B5D8D00ED_impl*
 SelectPoint(Finish, False, True, aMoveUpInLines);
//#UC END# *50AF18AD03DD_487B5D8D00ED_impl*
end;//TevBlockCursor.SetToFinish

function TevBlockCursor.DoGetBlock(const aDocument: InevObject): InevRange;
//#UC START# *48E252D40298_487B5D8D00ED_var*
//#UC END# *48E252D40298_487B5D8D00ED_var*
begin
//#UC START# *48E252D40298_487B5D8D00ED_impl*
 if NoCaret then
  Result := aDocument.Range
 else
  Result := aDocument.Range(f_Start, f_Finish);
//#UC END# *48E252D40298_487B5D8D00ED_impl*
end;//TevBlockCursor.DoGetBlock

function TevBlockCursor.DoAddBlock(const aStart: InevBasePoint;
 const aFinish: InevBasePoint): Boolean;
//#UC START# *48E2719C019C_487B5D8D00ED_var*
var
 l_Pack    : InevOp;
 l_Context : IevCursorContext;
//#UC END# *48E2719C019C_487B5D8D00ED_var*
begin
//#UC START# *48E2719C019C_487B5D8D00ED_impl*
 Result := True;
 l_Pack := Processor.StartOp(ev_msgMove);
 try
  l_Context := l_Pack As IevCursorContext;
  l_Context.RecordCursor(f_Start);
  l_Context.RecordCursor(f_Finish);
  if (aStart.Compare(aFinish) <= 0) then
  begin
   CheckCursor(f_Start).AssignPoint(View, aStart);
   CheckCursor(f_Finish).AssignPoint(View, aFinish);
  end//aStart.Compare(aFinish) <= 0
  else
  begin
   CheckCursor(f_Start).AssignPoint(View, aFinish);
   CheckCursor(f_Finish).AssignPoint(View, aStart);
  end;//aStart.Compare(aFinish) <= 0
  f_Finish.Refresh;
 finally
  l_Pack := nil;
 end;//try..finally
//#UC END# *48E2719C019C_487B5D8D00ED_impl*
end;//TevBlockCursor.DoAddBlock

function TevBlockCursor.GetContains(const C: InevBasePoint): Boolean;
//#UC START# *48E271FC0130_487B5D8D00ED_var*
//#UC END# *48E271FC0130_487B5D8D00ED_var*
begin
//#UC START# *48E271FC0130_487B5D8D00ED_impl*
 if (C <> nil) AND not Collapsed then
  Result := (C.Compare(Start) >= 0) AND (C.Compare(Finish) <= 0)
 else
  Result := false;
//#UC END# *48E271FC0130_487B5D8D00ED_impl*
end;//TevBlockCursor.GetContains

procedure TevBlockCursor.DoCursorChanged(const aCursor: InevBasePoint);
//#UC START# *48E27228010F_487B5D8D00ED_var*
//#UC END# *48E27228010F_487B5D8D00ED_var*
begin
//#UC START# *48E27228010F_487B5D8D00ED_impl*
 if (f_LockCursorChange <= 0) then
  inherited;
//#UC END# *48E27228010F_487B5D8D00ED_impl*
end;//TevBlockCursor.DoCursorChanged

procedure TevBlockCursor.DoAssignSel(const aView: InevView;
 const aSource: InevRange;
 AllowAddToMulti: Boolean);
//#UC START# *48E274CF007B_487B5D8D00ED_var*
var
 BS   : InevBasePoint;
 BF   : InevBasePoint;
 Pack : InevOp;
 Ctx  : IevCursorContext;
//#UC END# *48E274CF007B_487B5D8D00ED_var*
begin
//#UC START# *48E274CF007B_487B5D8D00ED_impl*
 aSource.GetBorderPoints(BS, BF);
 if (BS = nil) then
 begin
  BS := aSource.Obj.MakePoint;
  BS.Move(aView, ev_ocTopLeft);
 end
 else
  BS := BS.ClonePoint(aView);
 try
  if (BF = nil) then
  begin
   BF := aSource.Obj.MakePoint;
   BF.Move(aView, ev_ocBottomRight);
  end
  else
   BF := BF.ClonePoint(aView);
  try
   Pack := Processor.StartOp(ev_msgMove);
   try
    Ctx := Pack As IevCursorContext;
    BS := BS.PointToParent(Self.Cursor.Obj^); {* - Выравниваем уровень курсоров. }
    BF := BF.PointToParent(Self.Cursor.Obj^);
    Ctx.RecordCursor(f_Start);
    Ctx.RecordCursor(f_Finish);
    with CheckCursor(f_Start) do
    begin
     AssignPoint(View, BS);
     Refresh;
    end;//with CheckCursor(f_Start)
    with CheckCursor(f_Finish) do
    begin
     AssignPoint(View, BF);
     Refresh;
    end;//with CheckCursor(f_Finish)
    if not Contains(Cursor) then
    begin
     Ctx.RecordCursor(Cursor);
     with CheckCursor do
     begin
      AssignPoint(View,  BS);
      Refresh;
     end;//with CheckCursor
    end;//if not Contains(Cursor)
   finally
    Pack := nil; {* - Закрываем пачку операций. }
   end;//try..finally
  finally
   BF := nil;
  end;//try..finally
 finally
  BS := nil;
 end;//try..finally
//#UC END# *48E274CF007B_487B5D8D00ED_impl*
end;//TevBlockCursor.DoAssignSel

procedure TevBlockCursor.DoSetDocument(aValue: Tl3Tag);
//#UC START# *48E276B10286_487B5D8D00ED_var*
//#UC END# *48E276B10286_487B5D8D00ED_var*
begin
//#UC START# *48E276B10286_487B5D8D00ED_impl*
 FreeCursor(f_Start);                         
 FreeCursor(f_Finish);
 FreeCursor(f_StartMark);
 FreeCursor(f_StartMarkForCtrlKBCtrlKK);
 FreeCursor(f_FinishMark);
 inherited;
 if (aValue <> nil) AND aValue.IsValid then
 begin
  CheckCursor(f_Start);
  CheckCursor(f_Finish);
 end;//Value <> nil
//#UC END# *48E276B10286_487B5D8D00ED_impl*
end;//TevBlockCursor.DoSetDocument

function TevBlockCursor.NeedUnselectOnSelectPoint(const aPoint: InevBasePoint): Boolean;
 {* Нужно ли сбрасывать выделение в SelectPoint }
//#UC START# *48E276D90043_487B5D8D00ED_var*
//#UC END# *48E276D90043_487B5D8D00ED_var*
begin
//#UC START# *48E276D90043_487B5D8D00ED_impl*
 Result := not Persistent and inherited NeedUnselectOnSelectPoint(aPoint);
//#UC END# *48E276D90043_487B5D8D00ED_impl*
end;//TevBlockCursor.NeedUnselectOnSelectPoint

function TevBlockCursor.DoUnselect: Boolean;
 {* Снять выделение }
//#UC START# *48E2771B024F_487B5D8D00ED_var*
var
 l_Pack    : InevOp;
 l_Context : IevCursorContext;
//#UC END# *48E2771B024F_487B5D8D00ED_var*
begin
//#UC START# *48E2771B024F_487B5D8D00ED_impl*
 Result := not Collapsed;
 if Result AND (Cursor <> nil) then
 begin
  if not Result then
   Inc(f_LockCursorChange);
  try
   l_Pack := Processor.StartOp(ev_msgMove);
   try
    l_Context := l_Pack As IevCursorContext;
    Lock;
    try
     if (f_Start <> nil) then
     begin
      l_Context.RecordCursor(f_Start);
      f_Start.AssignPoint(View, Cursor);
      f_Start.MostInner.SetAtEnd(View, false);
      if Result AND (f_Finish = nil) then
       f_Start.Refresh;
     end;//f_Start <> nil
     if (f_Finish <> nil) then
     begin
      l_Context.RecordCursor(f_Finish);
      f_Finish.AssignPoint(View, Cursor);
      f_Finish.MostInner.SetAtEnd(View, false);
      if Result then
       f_Finish.Refresh;
     end;//f_Finish <> nil
    finally
     Unlock;
    end;//try..finally
   finally
    l_Pack := nil;
   end;//try..finally
  finally
   if not Result then
    Dec(f_LockCursorChange);
  end;//try..finally 
 end//Cursor <> nil
 else
  Result := False;
//#UC END# *48E2771B024F_487B5D8D00ED_impl*
end;//TevBlockCursor.DoUnselect

procedure TevBlockCursor.SetFocus;
 {* Окно получило фокус }
//#UC START# *48E370FF0359_487B5D8D00ED_var*
//#UC END# *48E370FF0359_487B5D8D00ED_var*
begin
//#UC START# *48E370FF0359_487B5D8D00ED_impl*
 if (Caret <> nil) then
  with Caret do
  begin
   Linked := True;
   Refresh;
   Visible := not NoCaret AND (Persistent OR (Collapsed OR not Contains(Cursor)));
  end;//with Caret
//#UC END# *48E370FF0359_487B5D8D00ED_impl*
end;//TevBlockCursor.SetFocus

function TevBlockCursor.UpdateCursor(const aCursor: InevBasePoint): Boolean;
//#UC START# *48E372190135_487B5D8D00ED_var*
var
 l_NewVisible: Boolean;
//#UC END# *48E372190135_487B5D8D00ED_var*
begin
//#UC START# *48E372190135_487B5D8D00ED_impl*
 Result := inherited UpdateCursor(aCursor);
 if not Persistent then
 begin
  l_NewVisible := Collapsed OR not Contains(Cursor);
  if (Caret.Visible <> l_NewVisible) then
  begin
   Caret.Visible := not NoCaret AND l_NewVisible;
   Refresh;
  end;//Caret.Visible <> l_NewVisible
 end;//not Persistent
 if not Result then
 begin
  if IsBlockCursor(aCursor) then
  begin
   UpdateBlock;
   Result := True;
  end;//IsBlockCursor(aCursor)
 end;//not Result
//#UC END# *48E372190135_487B5D8D00ED_impl*
end;//TevBlockCursor.UpdateCursor

function TevBlockCursor.pm_GetCollapsed: Boolean;
//#UC START# *48E3723E0107_487B5D8D00EDget_var*
var
 l_B : InevRange;
//#UC END# *48E3723E0107_487B5D8D00EDget_var*
begin
//#UC START# *48E3723E0107_487B5D8D00EDget_impl*
 if (Start = nil) then
  Result := True
 else
 begin
  l_B := GetBlock;
  if (l_B = nil) then
   Result := True
  else
   Result := l_B.Collapsed(View);
 end;//Start = nil
//#UC END# *48E3723E0107_487B5D8D00EDget_impl*
end;//TevBlockCursor.pm_GetCollapsed

function TevBlockCursor.IsBlockCursor(const aCursor: InevBasePoint): Boolean;
//#UC START# *48E37364035C_487B5D8D00ED_var*
//#UC END# *48E37364035C_487B5D8D00ED_var*
begin
//#UC START# *48E37364035C_487B5D8D00ED_impl*
 Result := l3IEQ(aCursor, f_Start) OR l3IEQ(aCursor, f_Finish);
//#UC END# *48E37364035C_487B5D8D00ED_impl*
end;//TevBlockCursor.IsBlockCursor

function TevBlockCursor.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_487B5D8D00ED_var*
var
 l_Cursor      : InevBasePoint;
 l_TextPara    : IedTextParagraph;
 l_RangeSource : IedRangeSource;
 l_Range       : IedRange;
 l_Processor   : InevProcessor;
//#UC END# *4A60B23E00C3_487B5D8D00ED_var*
begin
//#UC START# *4A60B23E00C3_487B5D8D00ED_impl*
 if IID.EQ(IedRange) then
 begin
  Result.SetOk;
  l_Cursor := Cursor;
  if (View <> nil) then
   Supports(View.Control, IedTextParagraph, l_TextPara);
  try
   try
    l_Processor := Processor;
   except
    l_Processor := nil;
   end;//try..except
   if Contains(l_Cursor) then
    IedRange(Obj) := TedRange.Make(View, GetBlock, l_Processor, l_TextPara)
   else
    IedRange(Obj) := TedRange.Make(View, l_Cursor, l_Processor, l_TextPara);
  finally
   l_TextPara := nil;
  end;//try..finally
 end//IID.EQ(IedRange)
 else
 if IID.EQ(Ik2TagGeneratorWrap) then
 begin
  l_Cursor := Cursor;
  if (l_Cursor = nil) then
   Result.SetNoInterface
  else
  begin
   Assert(false, 'Кто это генератор так получает?');
   Result.SetNoInterface;
(*   Result.SetOk;
   if not Persistent AND Contains(l_Cursor) then
   begin
    Ik2TagGeneratorWrap(Obj) := TevDocumentPartGenerator.Make(View, l_Cursor, Processor.StartOp);
    if l3IOk(IUnknown(Obj).QueryInterface(IedRangeSource, l_RangeSource)) then
     try
      if l3IOk(QueryInterface(IedRange, l_Range)) then
       try
        l_RangeSource.Range := l_Range;
       finally
        l_Range := nil;
       end;//try..finally
     finally
      l_RangeSource := nil;
     end;//try..finally
   end//not Persistent AND Contains(l_Cursor)
   else
    Ik2TagGeneratorWrap(Obj) := TevDocumentPartGenerator.Make(View, l_Cursor, Processor.StartOp);*)
  end;//l_Cursor = nil
 end//IID.EQ(Ik2TagGeneratorWrap)
 else
 if IID.EQ(IevHyperlink) AND Contains(Cursor) then
 begin
  if Supports(GetBlock, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
 end//IID.EQ(IevHyperlink) AND Contains(Cursor)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_487B5D8D00ED_impl*
end;//TevBlockCursor.COMQueryInterface

procedure TevBlockCursor.ForceStore;
//#UC START# *4D9476CA029F_487B5D8D00ED_var*
//#UC END# *4D9476CA029F_487B5D8D00ED_var*
begin
//#UC START# *4D9476CA029F_487B5D8D00ED_impl*
 inherited;
 if (f_Start <> nil) then
  f_Start.AsObject.ForceStore;
 if (f_Finish <> nil) then
  f_Finish.AsObject.ForceStore;
//#UC END# *4D9476CA029F_487B5D8D00ED_impl*
end;//TevBlockCursor.ForceStore

procedure TevBlockCursor.ClearFields;
begin
 f_Start := nil;
 f_Finish := nil;
 f_StartMark := nil;
 f_FinishMark := nil;
 f_StartMarkForCtrlKBCtrlKK := nil;
 inherited;
end;//TevBlockCursor.ClearFields

end.
