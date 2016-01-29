unit evStyleHeaderAdder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evStyleHeaderAdder.pas"
// �����: 30.09.2011 15:31
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevStyleHeaderAdder
//
// ������, ������������ ��������� ����� ����� ����������
// http://mdp.garant.ru/pages/viewpage.action?pageId=278837126
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant
  ;

type
 TevStyleHeaderAdder = class(TevdLeafParaFilter)
  {* ������, ������������ ��������� ����� ����� ����������
http://mdp.garant.ru/pages/viewpage.action?pageId=278837126 }
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* ������ ����������� ������ � ���������. ��������� ������� ��������� � ���������� ������ }
 end;//TevStyleHeaderAdder

implementation

uses
  evTextStyle_Const,
  TextPara_Const,
  k2Tags,
  l3String,
  l3Types,
  nevTools
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  
  ;

// start class TevStyleHeaderAdder

function TevStyleHeaderAdder.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_4E85A869034E_var*
//#UC END# *49E488070386_4E85A869034E_var*
begin
//#UC START# *49E488070386_4E85A869034E_impl*
 Result := k2_typTextPara;
//#UC END# *49E488070386_4E85A869034E_impl*
end;//TevStyleHeaderAdder.ParaTypeForFiltering

procedure TevStyleHeaderAdder.DoWritePara(aLeaf: Tl3Variant);
//#UC START# *49E4883E0176_4E85A869034E_var*
var
 l_Style     : Tl3Variant;
 l_Str       : Tl3PCharLen;
 l_Para      : InevPara;
//#UC END# *49E4883E0176_4E85A869034E_var*
begin
//#UC START# *49E4883E0176_4E85A869034E_impl*
 l_Style := aLeaf.Attr[k2_tiStyle];
 if not evAACStyle(l_Style.IntA[k2_tiHandle]) then
  if l_Style.BoolA[k2_tiHeaderHasOwnSpace] then
  begin
   l_Str := l_Style.PCharLenA[k2_tiShortName];
   if not l3IsNil(l_Str) then
   begin
    if aLeaf.BoolA[k2_tiCollapsed] then
     if aLeaf.QT(InevPara, l_Para) then
      if l_Para.TreatCollapsedAsHidden then
      begin
       inherited;
       Exit;
       // - �� ����� �������, � ������������� ���������
      end;//l_Para.TreatCollapsedAsHidden
     Generator.StartChild(k2_typTextPara);
     try
      if (l_Style.IntA[k2_tiHandle] = ev_saChangesInfo) then
       Generator.AddIntegerAtom(k2_tiStyle, ev_saSubHeaderForChangesInfo);
      Generator.AddStringAtom(k2_tiText, l_Str);
     finally
      Generator.Finish;
     end;//try..finally
   end;//not l3IsNil(l_Str)
  end;//l_Style.BoolA[k2_tiHeaderHasOwnSpace]
 inherited;
//#UC END# *49E4883E0176_4E85A869034E_impl*
end;//TevStyleHeaderAdder.DoWritePara

end.