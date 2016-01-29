unit nevStringItemPara;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevStringItemPara.pas"
// �����: 25.09.2001 17:21
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevStringItemPara
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevTools,
  nevTextPara,
  l3Variant,
  nevBase
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TnevStringItemPara = class(TnevTextPara)
 private
 // private fields
   f_StrID : Integer;
    {* ������ �� ����� ������ � ������}
 protected
 // overridden protected methods
   function GetPID: TnevParaIndex; override;
 public
 // public methods
   constructor Create(aTag: Tl3Variant;
    anIndex: Integer); reintroduce;
   class function Make(aTag: Tl3Variant;
    anIndex: Integer): InevTextPara; reintroduce;
 end;//TnevStringItemPara
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}

// start class TnevStringItemPara

constructor TnevStringItemPara.Create(aTag: Tl3Variant;
  anIndex: Integer);
//#UC START# *48D118B5038A_48D1184C02B9_var*
//#UC END# *48D118B5038A_48D1184C02B9_var*
begin
//#UC START# *48D118B5038A_48D1184C02B9_impl*
 inherited Create(aTag);
 f_StrID := anIndex;
//#UC END# *48D118B5038A_48D1184C02B9_impl*
end;//TnevStringItemPara.Create

class function TnevStringItemPara.Make(aTag: Tl3Variant;
  anIndex: Integer): InevTextPara;
var
 l_Inst : TnevStringItemPara;
begin
 l_Inst := Create(aTag, anIndex);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnevStringItemPara.GetPID: TnevParaIndex;
//#UC START# *48CFB61F01FA_48D1184C02B9_var*
//#UC END# *48CFB61F01FA_48D1184C02B9_var*
begin
//#UC START# *48CFB61F01FA_48D1184C02B9_impl*
 Result := f_StrID;
//#UC END# *48CFB61F01FA_48D1184C02B9_impl*
end;//TnevStringItemPara.GetPID

{$IfEnd} //k2ForEditor

end.