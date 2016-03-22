unit atUserComment;

// Модуль: "w:\quality\test\garant6x\AdapterTest\EvdHelpers\atUserComment.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatUserComment" MUID: (4B6AE7650002)

interface

uses
 l3IntfUses
 , atBaseEvdHelper
 , evdNativeWriter
;

type
 IatUserComment = interface
  ['{4154A018-1A3E-4640-997F-FD9B825F8618}']
  function Get_CommentText: AnsiString;
  procedure Set_CommentText(const aValue: AnsiString);
  property CommentText: AnsiString
   read Get_CommentText
   write Set_CommentText;
 end;//IatUserComment

 TatUserComment = class(TatBaseEvdHelper, IatUserComment)
  private
   f_CommentText: AnsiString;
  protected
   function Get_CommentText: AnsiString;
   procedure Set_CommentText(const aValue: AnsiString);
   procedure DoGenerate(anEVDNativeWriter: TevdNativeWriter); override;
  public
   class function Make: IatUserComment; reintroduce;
 end;//TatUserComment

implementation

uses
 l3ImplUses
 , evdStyles
 , k2Tags
 , TextPara_Const
;

class function TatUserComment.Make: IatUserComment;
var
 l_Inst : TatUserComment;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TatUserComment.Make

function TatUserComment.Get_CommentText: AnsiString;
//#UC START# *484415F90238_4B6AE7650002get_var*
//#UC END# *484415F90238_4B6AE7650002get_var*
begin
//#UC START# *484415F90238_4B6AE7650002get_impl*
  Result := f_CommentText;
//#UC END# *484415F90238_4B6AE7650002get_impl*
end;//TatUserComment.Get_CommentText

procedure TatUserComment.Set_CommentText(const aValue: AnsiString);
//#UC START# *484415F90238_4B6AE7650002set_var*
//#UC END# *484415F90238_4B6AE7650002set_var*
begin
//#UC START# *484415F90238_4B6AE7650002set_impl*
  f_CommentText := aValue;
  Generate();
//#UC END# *484415F90238_4B6AE7650002set_impl*
end;//TatUserComment.Set_CommentText

procedure TatUserComment.DoGenerate(anEVDNativeWriter: TevdNativeWriter);
//#UC START# *4B6AE81E0267_4B6AE7650002_var*
//#UC END# *4B6AE81E0267_4B6AE7650002_var*
begin
//#UC START# *4B6AE81E0267_4B6AE7650002_impl*
  with anEVDNativeWriter do
  begin
    NeedOutHeader := true;
    SmallHeader := true;
    Binary := true;
    Start;
      StartChild(k2_typTextPara);
        AddIntegerAtom(k2_tiStyle, ev_saUserComment);
        AddStringAtom(k2_tiText, f_CommentText);
      Finish;
    Finish;
  end;
//#UC END# *4B6AE81E0267_4B6AE7650002_impl*
end;//TatUserComment.DoGenerate

end.
