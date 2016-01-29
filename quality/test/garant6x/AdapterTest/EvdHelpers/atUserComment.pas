unit atUserComment;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/EvdHelpers/atUserComment.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::EvdHelpers::TatUserComment
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atBaseEvdHelper,
  evdNativeWriter
  ;

type
 IatUserComment = interface(IUnknown)
   ['{4154A018-1A3E-4640-997F-FD9B825F8618}']
   function Get_CommentText: AnsiString;
   procedure Set_CommentText(const aValue: AnsiString);
   property CommentText: AnsiString
     read Get_CommentText
     write Set_CommentText;
 end;//IatUserComment

 TatUserComment = class(TatBaseEvdHelper, IatUserComment)
 private
 // private fields
   f_CommentText : AnsiString;
 protected
 // realized methods
   function Get_CommentText: AnsiString;
   procedure Set_CommentText(const aValue: AnsiString);
   procedure DoGenerate(anEVDNativeWriter: TevdNativeWriter); override;
 public
 // public methods
   class function Make: IatUserComment; reintroduce;
 end;//TatUserComment

implementation

uses
  evdStyles,
  k2Tags,
  TextPara_Const
  ;

// start class TatUserComment

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
end;

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