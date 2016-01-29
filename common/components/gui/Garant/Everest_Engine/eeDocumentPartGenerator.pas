unit eeDocumentPartGenerator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest Engine"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest_Engine/eeDocumentPartGenerator.pas"
// �����: 30.03.2011 20:21
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::eeDocumentContainer::TeeDocumentPartGenerator
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  evDocumentPartGenerator,
  nevTools
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeeDocumentPartGenerator = class(TevDocumentPartGenerator)
 protected
 // overridden protected methods
   procedure SetInsertionPoint(const aPoint: InevBasePoint;
     aPID: Integer); override;
 end;//TeeDocumentPartGenerator
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  evOp
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  CommentPara_Const
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TeeDocumentPartGenerator

procedure TeeDocumentPartGenerator.SetInsertionPoint(const aPoint: InevBasePoint;
  aPID: Integer);
//#UC START# *4D9359AA01A2_4D93589403E2_var*
//#UC END# *4D9359AA01A2_4D93589403E2_var*
begin
//#UC START# *4D9359AA01A2_4D93589403E2_impl*
 inherited;
 while true do
 begin
  if evInPara(aPoint.MostInner.Obj^.AsObject, k2_typCommentPara) then
   break;
  if not aPoint.Move(View, ev_ocPrevParaBottomRight, Context) then
   break; 
 end;//while true
//#UC END# *4D9359AA01A2_4D93589403E2_impl*
end;//TeeDocumentPartGenerator.SetInsertionPoint

{$IfEnd} //Nemesis

end.