unit nsJournalBookmarkNode;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsJournalBookmarkNode.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsWrapperNode
 , MainMenuDomainInterfaces
 , DocumentUnit
 , l3Interfaces
 , l3Tree_TLB
 , l3IID
;

type
 TnsJournalBookmarkNode = class(TnsWrapperNode, InsJournalBookmarkNode)
  private
   f_Bookmark: IJournalBookmark;
   f_DocName: Il3CString;
  protected
   function Get_DocName: Il3CString;
   function Get_Bookmark: IJournalBookmark;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* ���������� ������� ���������� }
  public
   constructor Create(const aBookmark: IJournalBookmark;
    aFullDocName: Boolean); reintroduce;
   class function Make(const aBookmark: IJournalBookmark;
    aFullDocName: Boolean = False): Il3Node; reintroduce;
 end;//TnsJournalBookmarkNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3String
 , IOUnit
 , nsTypes
 , BaseTypesUnit
;

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
  // ���������� ������ ���:
  if aFullDocName then
  begin
   Get_DocName;
    // - ������������� ���� f_DocName;
   with f_DocName.AsWStr do
    if SLen > c_MaxLenght then
    begin
     // �������� ������ ������ �� c_MaxLenght, �� ���������� � 170 �������
     // �������:
     for l_Index := Pred(c_MaxLenght) downto 0 do
      if l3Compare(S[l_Index], ' ') = 0 then
      begin
       l3SetLen(f_DocName, l_Index);
       Break;
      end;//if l3Compare(S[l_Index], ' ') = 0 then
     // ������� ���������:
     f_DocName := l3Cat(f_DocName, c_Suffix);
    end;//if SLen > c_MaxLenght then
   // ��������� ��������:
   pm_SetName(f_DocName.AsWStr);
  end//if aFullDocName then
  else
  // ���������� �������� ���:
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
end;//TnsJournalBookmarkNode.Make

function TnsJournalBookmarkNode.Get_DocName: Il3CString;
//#UC START# *4A8BAAA50229_4ADDF4D901D1get_var*
var
 l_Str : IString;
//#UC END# *4A8BAAA50229_4ADDF4D901D1get_var*
begin
//#UC START# *4A8BAAA50229_4ADDF4D901D1get_impl*
 Result := nil;
 // ��������� ����
 if not Assigned(f_Bookmark) then
  Exit;
 // ������� ��� ���������
 if not Assigned(f_DocName) then
 begin
  // Document
  try
   f_Bookmark.GetFullName(l_Str);
   f_DocName := nsCStr(l_Str);
  except
   // ��������� ���
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
 {* ������� ������� ����� �������. }
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
 {* ���������� ������� ���������� }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
