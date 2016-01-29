unit nevHAFPainterView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevHAFPainterView.pas"
// �����: 14.09.2001 17:33
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Views::TnevHAFPainterView
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevBase,
  nevTools,
  nevVirtualDrawView,
  nevObjectHolder
  ;

type
 TnevHAFPainterView = class(TnevVirtualDrawView)
 private
 // private fields
   f_DocView : InevView;
   f_Holder : TnevObjectHolder;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor Create(const aText: InevObjectList;
     const aCanvas: InevCanvas); reintroduce;
   class function Make(const aText: InevObjectList;
     const aCanvas: InevCanvas): InevView; reintroduce;
     {* ��������� ������� TnevHAFPainterView.Make }
 end;//TnevHAFPainterView

implementation

uses
  nevBaseDetachedView,
  SysUtils
  ;

// start class TnevHAFPainterView

constructor TnevHAFPainterView.Create(const aText: InevObjectList;
  const aCanvas: InevCanvas);
//#UC START# *4CB5BF260122_481DB3AA03CD_var*
//#UC END# *4CB5BF260122_481DB3AA03CD_var*
begin
//#UC START# *4CB5BF260122_481DB3AA03CD_impl*
 f_Holder := TnevObjectHolder.Create(aText);
 f_DocView := TnevBaseDetachedView.Make(aText, aCanvas);
 inherited Create(aText.Obj[0], f_DocView.RootFormatInfo, aCanvas, f_DocView.Metrics);
//#UC END# *4CB5BF260122_481DB3AA03CD_impl*
end;//TnevHAFPainterView.Create

class function TnevHAFPainterView.Make(const aText: InevObjectList;
  const aCanvas: InevCanvas): InevView;
var
 l_Inst : TnevHAFPainterView;
begin
 l_Inst := Create(aText, aCanvas);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnevHAFPainterView.Cleanup;
//#UC START# *479731C50290_481DB3AA03CD_var*
//#UC END# *479731C50290_481DB3AA03CD_var*
begin
//#UC START# *479731C50290_481DB3AA03CD_impl*
 f_DocView := nil;
 FreeAndNil(f_Holder);
 inherited;
//#UC END# *479731C50290_481DB3AA03CD_impl*
end;//TnevHAFPainterView.Cleanup

end.