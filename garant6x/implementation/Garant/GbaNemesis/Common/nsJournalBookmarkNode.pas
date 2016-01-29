unit nsJournalBookmarkNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsJournalBookmarkNode.pas"
// Начат: 21.10.2009 19:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::MainMenu::TnsJournalBookmarkNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  l3Interfaces,
  l3Tree_TLB,
  MainMenuDomainInterfaces,
  nsWrapperNode,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsJournalBookmarkNode = class(TnsWrapperNode, InsJournalBookmarkNode)
 private
 // private fields
   f_Bookmark : IJournalBookmark;
   f_DocName : Il3CString;
 protected
 // realized methods
   function Get_DocName: Il3CString;
   function Get_Bookmark: IJournalBookmark;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 public
 // public methods
   constructor Create(const aBookmark: IJournalBookmark;
    aFullDocName: Boolean); reintroduce;
   class function Make(const aBookmark: IJournalBookmark;
    aFullDocName: Boolean = False): Il3Node; reintroduce;
 end;//TnsJournalBookmarkNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3String,
  IOUnit,
  nsTypes,
  BaseTypesUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsJournalBookmarkNode

constructor TnsJournalBookmarkNode.Create(const aBookmark: IJournalBookmark;
  aFullDocName: Boolean);
//#UC START# *4ADF23C202CF_4ADDF4D901D1_var*

 procedure lp_MakeText;
 const
  c_MaxLenght = 170;
  c_Suffix    = ' ...';
 var
  l_Index   : Integer;
  l_Str     : IString;
 begin
  // Показывать полное имя:
  if aFullDocName then
  begin
   Get_DocName;
    // - инициализация поля f_DocName;
   with f_DocName.AsWStr do
    if SLen > c_MaxLenght then
    begin
     // Обрезаем размер текста до c_MaxLenght, по ближайшему к 170 символу
     // пробелу:
     for l_Index := Pred(c_MaxLenght) downto 0 do
      if l3Compare(S[l_Index], ' ') = 0 then
      begin
       l3SetLen(f_DocName, l_Index);
       Break;
      end;//if l3Compare(S[l_Index], ' ') = 0 then
     // Добавим троеточие:
     f_DocName := l3Cat(f_DocName, c_Suffix);
    end;//if SLen > c_MaxLenght then
   // Установим название:
   pm_SetName(f_DocName.AsWStr);
  end//if aFullDocName then
  else
  // Показывать короткое имя:
  begin
   // Name
   f_Bookmark.GetName(l_Str);
   try
    pm_SetName(nsWStr(l_Str));
   finally
    l_Str := nil;
   end;//try..finally
  end;//if aFullDocName then
 end;//lp_MakeText;

 procedure lp_MakeComment;
 var
  l_Str : IString;
 begin
  // Comment
  f_Bookmark.GetFullName(l_Str);
  try
   pm_SetComment(nsWStr(l_Str));
  finally
   l_Str := nil;
  end;//try..finally
 end;//lp_MakeComment

//#UC END# *4ADF23C202CF_4ADDF4D901D1_var*
begin
//#UC START# *4ADF23C202CF_4ADDF4D901D1_impl*
 inherited Create;
 if not Assigned(aBookmark) then
  Exit;
 f_Bookmark := aBookmark;
 lp_MakeText;
 lp_MakeComment;
//#UC END# *4ADF23C202CF_4ADDF4D901D1_impl*
end;//TnsJournalBookmarkNode.Create

class function TnsJournalBookmarkNode.Make(const aBookmark: IJournalBookmark;
  aFullDocName: Boolean = False): Il3Node;
var
 l_Inst : TnsJournalBookmarkNode;
begin
 l_Inst := Create(aBookmark, aFullDocName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsJournalBookmarkNode.Get_DocName: Il3CString;
//#UC START# *4A8BAAA50229_4ADDF4D901D1get_var*
var
 l_Str : IString;
//#UC END# *4A8BAAA50229_4ADDF4D901D1get_var*
begin
//#UC START# *4A8BAAA50229_4ADDF4D901D1get_impl*
 Result := nil;
 // Фиктивный узел
 if not Assigned(f_Bookmark) then
  Exit;
 // Получим имя документа
 if not Assigned(f_DocName) then
 begin
  // Document
  try
   f_Bookmark.GetFullName(l_Str);
   f_DocName := nsCStr(l_Str);
  except
   // Документа нет
   on ECanNotFindData do begin end;
  end;
  // DocName
 end;//not Assigned(f_Document)
 Result := f_DocName;
//#UC END# *4A8BAAA50229_4ADDF4D901D1get_impl*
end;//TnsJournalBookmarkNode.Get_DocName

function TnsJournalBookmarkNode.Get_Bookmark: IJournalBookmark;
//#UC START# *4A8BAACC02D5_4ADDF4D901D1get_var*
//#UC END# *4A8BAACC02D5_4ADDF4D901D1get_var*
begin
//#UC START# *4A8BAACC02D5_4ADDF4D901D1get_impl*
 Result := f_Bookmark;
//#UC END# *4A8BAACC02D5_4ADDF4D901D1get_impl*
end;//TnsJournalBookmarkNode.Get_Bookmark

procedure TnsJournalBookmarkNode.Cleanup;
//#UC START# *479731C50290_4ADDF4D901D1_var*
//#UC END# *479731C50290_4ADDF4D901D1_var*
begin
//#UC START# *479731C50290_4ADDF4D901D1_impl*
 f_Bookmark := nil;
 f_DocName := nil;
 inherited;
//#UC END# *479731C50290_4ADDF4D901D1_impl*
end;//TnsJournalBookmarkNode.Cleanup

function TnsJournalBookmarkNode.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_4ADDF4D901D1_var*
//#UC END# *4A60B23E00C3_4ADDF4D901D1_var*
begin
//#UC START# *4A60B23E00C3_4ADDF4D901D1_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
 begin
  if (f_Bookmark = nil) then
   Result.SetNOINTERFACE
  else
   Result := Tl3HResult_C(f_Bookmark.QueryInterface(IID.IID, Obj));
 end;
//#UC END# *4A60B23E00C3_4ADDF4D901D1_impl*
end;//TnsJournalBookmarkNode.COMQueryInterface

{$IfEnd} //not Admin AND not Monitorings

end.