unit tfwKeyWordPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwKeyWordPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwKeyWordPrim" MUID: (4FFEEC080367)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , l3Interfaces
;

type
 TtfwKeyWordPrim = {abstract} class(Tl3PrimString)
  private
   f_AsCStr: Il3CString;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aKeyword: Il3CString); reintroduce;
  public
   property AsCStr: Il3CString
    read f_AsCStr;
 end;//TtfwKeyWordPrim

implementation

uses
 l3ImplUses
;

constructor TtfwKeyWordPrim.Create(const aKeyword: Il3CString);
//#UC START# *55A6967900B3_4FFEEC080367_var*
//#UC END# *55A6967900B3_4FFEEC080367_var*
begin
//#UC START# *55A6967900B3_4FFEEC080367_impl*
 inherited Create;
 f_AsCStr := aKeyword;
//#UC END# *55A6967900B3_4FFEEC080367_impl*
end;//TtfwKeyWordPrim.Create

procedure TtfwKeyWordPrim.ClearFields;
begin
 f_AsCStr := nil;
 inherited;
end;//TtfwKeyWordPrim.ClearFields

end.
