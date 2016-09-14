unit Script.Code;

interface

uses
 Core.Obj,
 System.Generics.Collections,
 Script.WordsInterfaces
 ;

type
 TscriptCodeContainer = class(TList<IscriptWord>)
 end;//TscriptCodeContainer

 TscriptCode = class(TCoreInterfacedObject, IscriptCode, IscriptCompiler)
  private
   f_Code : TscriptCodeContainer;
  protected
  // interfaces methods
   procedure Run(aContext : TscriptRunContext);
    {* - ��������� ��������������� ���. }
   procedure CompileWord(const aWord: IscriptWord);
    {* - ����������� ��������� ����� � ���. }
   function CompiledCode: IscriptCode;
    {* - ���������������� ��� }
  protected
   procedure Cleanup; override;
  public
   class function Make: IscriptCompiler;
    {* - �������. }
 end;//TscriptCode

 TscriptCompiler = TscriptCode;

implementation

uses
 System.SysUtils
 ;

// TscriptCode

class function TscriptCode.Make: IscriptCompiler;
 {* - �������. }
begin
 Result := Create;
end;

procedure TscriptCode.Cleanup;
begin
 FreeAndNil(f_Code);
 inherited;
end;

procedure TscriptCode.Run(aContext : TscriptRunContext);
var
 l_Word : IscriptWord;
begin
 if (Self.f_Code <> nil) then
  for l_Word in Self.f_Code do
   l_Word.DoIt(aContext);
end;

procedure TscriptCode.CompileWord(const aWord: IscriptWord);
 {* - ����������� ��������� ����� � ���. }
begin
 if (Self.f_Code = nil) then
  Self.f_Code := TscriptCodeContainer.Create;
 Self.f_Code.Add(aWord);
end;

function TscriptCode.CompiledCode: IscriptCode;
 {* - ���������������� ��� }
begin
 Result := Self;
end;

end.
