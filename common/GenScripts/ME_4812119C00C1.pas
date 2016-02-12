unit nevPrintView;
 {* Область вывода для печати. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevPrintView.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevBaseDetachedView
 , nevTools
 , evdStyles
 , nevBase
;

type
 _PrintViewDecorationRules_Parent_ = TnevBaseDetachedView;
 {$Include w:\common\components\gui\Garant\Everest\PrintViewDecorationRules.imp.pas}
 TnevPrintView = class(_PrintViewDecorationRules_, InevPrintView)
  {* Область вывода для печати. }
  private
   f_HiddenStyles: TevStandardStyles;
   f_HoldedText: InevObject;
  protected
   procedure DoBeginDrawShape(const aShape: InevObject;
    const anAnchor: InevBasePoint;
    const anOrg: TnevPoint;
    var theMap: InevMap;
    aFake: Boolean;
    const aHacker: InevK235870994Hacker); override;
   function GetHiddenStyles: TevStandardStyles; override;
   function GetLimitWidth: Integer; override;
   function DoGetExcludeSuper: TevNormalSegLayerHandleSet; override;
   procedure ClearFields; override;
  public
   constructor Create(const aText: InevObject;
    const aCanvas: InevCanvas;
    aHiddenStyles: TevStandardStyles); reintroduce;
   class function Make(const aText: InevObject;
    const aCanvas: InevCanvas;
    aHiddenStyles: TevStandardStyles): InevPrintView; reintroduce;
 end;//TnevPrintView

implementation

uses
 l3ImplUses
 , l3MinMax
 , evdTypes
 , evTextStyle_Const
 , k2Tags
;

{$Include w:\common\components\gui\Garant\Everest\PrintViewDecorationRules.imp.pas}

constructor TnevPrintView.Create(const aText: InevObject;
 const aCanvas: InevCanvas;
 aHiddenStyles: TevStandardStyles);
//#UC START# *4CB5BEE50148_4812119C00C1_var*
//#UC END# *4CB5BEE50148_4812119C00C1_var*
begin
//#UC START# *4CB5BEE50148_4812119C00C1_impl*
 f_HoldedText := aText;
 // - чтобы ссылка не "протухла", т.к. предок держит ТОЛЬКО СЛАБУЮ ссылку
 inherited Create(aText, aCanvas);
 f_HiddenStyles := aHiddenStyles;
//#UC END# *4CB5BEE50148_4812119C00C1_impl*
end;//TnevPrintView.Create

class function TnevPrintView.Make(const aText: InevObject;
 const aCanvas: InevCanvas;
 aHiddenStyles: TevStandardStyles): InevPrintView;
var
 l_Inst : TnevPrintView;
begin
 l_Inst := Create(aText, aCanvas, aHiddenStyles);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevPrintView.Make

procedure TnevPrintView.DoBeginDrawShape(const aShape: InevObject;
 const anAnchor: InevBasePoint;
 const anOrg: TnevPoint;
 var theMap: InevMap;
 aFake: Boolean;
 const aHacker: InevK235870994Hacker);
//#UC START# *4811DB8A0323_4812119C00C1_var*
//#UC END# *4811DB8A0323_4812119C00C1_var*
begin
//#UC START# *4811DB8A0323_4812119C00C1_impl*
 Canvas.StartObject(aShape.AnchorID);
 inherited;
//#UC END# *4811DB8A0323_4812119C00C1_impl*
end;//TnevPrintView.DoBeginDrawShape

function TnevPrintView.GetHiddenStyles: TevStandardStyles;
//#UC START# *48120D32035F_4812119C00C1_var*
//#UC END# *48120D32035F_4812119C00C1_var*
begin
//#UC START# *48120D32035F_4812119C00C1_impl*
 Result := f_HiddenStyles;
//#UC END# *48120D32035F_4812119C00C1_impl*
end;//TnevPrintView.GetHiddenStyles

function TnevPrintView.GetLimitWidth: Integer;
//#UC START# *48121CB0013E_4812119C00C1_var*
//#UC END# *48121CB0013E_4812119C00C1_var*
begin
//#UC START# *48121CB0013E_4812119C00C1_impl*
 //Result := Min(Canvas.SectionExtent.X, inherited GetLimitWidth);
 Result := Canvas.SectionExtent.X;
//#UC END# *48121CB0013E_4812119C00C1_impl*
end;//TnevPrintView.GetLimitWidth

function TnevPrintView.DoGetExcludeSuper: TevNormalSegLayerHandleSet;
//#UC START# *4F66FDB60040_4812119C00C1_var*
//#UC END# *4F66FDB60040_4812119C00C1_var*
begin
//#UC START# *4F66FDB60040_4812119C00C1_impl*
 Result := [ev_slFoundWords];
//#UC END# *4F66FDB60040_4812119C00C1_impl*
end;//TnevPrintView.DoGetExcludeSuper

procedure TnevPrintView.ClearFields;
begin
 f_HoldedText := nil;
 inherited;
end;//TnevPrintView.ClearFields

end.
