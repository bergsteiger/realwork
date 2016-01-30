unit kwPopQueryCardSetAttribute;
 {* ��������� ������� � ������� �������� �������.

*������:*
[code]
 ���::�����_�����_��������������_��������
 'AT_PHARM_NAME' '�������' Search:SetAttribute
 'AT_PHARM_ATC' 'A. ��������������� ����� � ����� �������' Search:SetAttribute
 'AT_PHARM_ATC' 'B. ��������� �������� �� ������������� � �����' Search:SetAttribute
 Ok
[code] }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardSetAttribute.pas"
// ���������: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , l3Interfaces
 , nevBase
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evQueryCardInt
;

type
 TkwPopQueryCardSetAttribute = class(TkwQueryCardFromStackWord)
  {* ��������� ������� � ������� �������� �������.

*������:*
[code]
 ���::�����_�����_��������������_��������
 'AT_PHARM_NAME' '�������' Search:SetAttribute
 'AT_PHARM_ATC' 'A. ��������������� ����� � ����� �������' Search:SetAttribute
 'AT_PHARM_ATC' 'B. ��������� �������� �� ������������� � �����' Search:SetAttribute
 Ok
[code] }
  private
   procedure DoModelImpl;
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardSetAttribute
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

procedure TkwPopQueryCardSetAttribute.DoModelImpl;
//#UC START# *4E81A3090197_4E808E3E026E_var*
//#UC END# *4E81A3090197_4E808E3E026E_var*
begin
//#UC START# *4E81A3090197_4E808E3E026E_impl*
 l_Value := aCtx.rEngine.PopString;
 l_Name := aCtx.rEngine.PopString;
 l_Op := aCard.StartOp;
 try
  CallIterator;
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *4E81A3090197_4E808E3E026E_impl*
end;//TkwPopQueryCardSetAttribute.DoModelImpl

procedure TkwPopQueryCardSetAttribute.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_4E808E3E026E_var*
//#UC END# *4E808E8B01BB_4E808E3E026E_var*
begin
//#UC START# *4E808E8B01BB_4E808E3E026E_impl*
 DoModelImpl(aCtx, aCard);
//#UC END# *4E808E8B01BB_4E808E3E026E_impl*
end;//TkwPopQueryCardSetAttribute.DoCard

class function TkwPopQueryCardSetAttribute.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:SetAttribute';
end;//TkwPopQueryCardSetAttribute.GetWordNameForRegister

initialization
 TkwPopQueryCardSetAttribute.RegisterInEngine;
 {* ����������� pop_QueryCard_SetAttribute }
{$IfEnd} // NOT Defined(NoScripts)

end.
