unit bsChangeRedationWorker;

{------------------------------------------------------------------------------}
{ ���������� : ������ ���� ������� "�������";                                  }
{ �����      : ������� �.�.;                                                   }
{ �����      : 14.07.2006;                                                     }
{ ������     : bsChangeRedationWorker                                          }
{ ��������   : �������� ���������� �������� �������� ���������;                }
{------------------------------------------------------------------------------}

// $Id: bsChangeRedationWorker.pas,v 1.4 2009/12/09 16:36:51 lulin Exp $
// $Log: bsChangeRedationWorker.pas,v $
// Revision 1.4  2009/12/09 16:36:51  lulin
// - ������ ��������� ��������� �� ������ � ������ �����������.
//
// Revision 1.3  2009/12/07 19:06:13  lulin
// - ������ �������� ������.
//
// Revision 1.2  2009/10/12 11:27:11  lulin
// - �������� ����� ������� CVS.
//
// Revision 1.1  2009/09/14 11:28:52  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.5  2008/12/25 12:19:30  lulin
// - <K>: 121153186.
//
// Revision 1.4  2008/12/24 19:49:12  lulin
// - <K>: 121153186.
//
// Revision 1.3  2008/12/04 14:58:41  lulin
// - <K>: 121153186.
//
// Revision 1.2  2008/01/10 07:23:00  oman
// ������� �� ����� �������
//
// Revision 1.1.8.1  2007/11/22 10:50:01  oman
// ������������ �� ����� �������
//
// Revision 1.1  2006/07/14 09:06:38  mmorozov
// - refactoring: ����������� �� ��������� ������� ChangeRedationXXX �� ���������� "��������" � ���������� �������;
// - new: ������ ������ ����� ���� �����������;
//

interface

uses
  bsBase,

  nsTypes,

  BaseTypesUnit,
  DocumentUnit,

  bsInterfaces,

  DocumentInterfaces,
  DocumentAndListInterfaces
  ;

type
  TbsChangeRedationById = class(TbsBase, IbsChangeRedactionWorker)
  {* �������� �������� �� ��������������. }
  private
  // internal fields
    f_ChangeType : TnsChangeRedactionType;
    f_Redaction  : TRedactionID;
  private
  // IbsChangeRedactionWorker
    function Change(const aDocInfo: IdeDocInfo): Boolean;
      {* - ������� �������� ���������, � ����������� �� �������� ������ (�������
           �� ������, �� ����, �� �������������� �������� � �.�.). }
  public
  // methods
    constructor Create(const aChangeType : TnsChangeRedactionType;
                       const aRedaction  : TRedactionID);
      reintroduce;
      {-}
    class function Make(const aChangeType : TnsChangeRedactionType;
                        const aRedaction  : TRedactionID = 0): IbsChangeRedactionWorker;
      {-}
  end;

  TbsChangeRelationByDate = class(TbsBase, IbsChangeRedactionWorker)
  {* ����������� �������� �� ����. }
  private
  // internal fields
    f_Date: BaseTypesUnit.TDate;
  private
  // IbsChangeRedactionWorker
    function Change(const aDocInfo: IdeDocInfo): Boolean;
      {* - ������� �������� ���������, � ����������� �� �������� ������ (�������
           �� ������, �� ����, �� �������������� �������� � �.�.). }
  public
  // methods
    constructor Create(const aDate: BaseTypesUnit.TDate);
      reintroduce;
      {-}
    class function Make(const aDate: BaseTypesUnit.TDate): IbsChangeRedactionWorker;
      {-}
  end;

  TbsChangeRelationByHyperlink = class(TbsBase, IbsChangeRedactionWorker)
  {* ����������� �������� �� ������. }
  private
  // internal fields
    f_Document: IDocument;
  private
  // IbsChangeRedactionWorker
    function Change(const aDocInfo: IdeDocInfo): Boolean;
      {* - ������� �������� ���������, � ����������� �� �������� ������ (�������
           �� ������, �� ����, �� �������������� �������� � �.�.). }
  public
  // methods
    constructor Create(const aDocument: IDocument);
      reintroduce;
      {-}
    class function Make(const aDocument: IDocument): IbsChangeRedactionWorker;
      {-}
  end;

implementation

uses
  SysUtils
  ;

{ TbsChangeRedationById }

function TbsChangeRedationById.Change(const aDocInfo: IdeDocInfo): Boolean;
begin
 Result := aDocInfo.ChangeRedaction(f_ChangeType, f_Redaction);
end;

constructor TbsChangeRedationById.Create(
  const aChangeType: TnsChangeRedactionType;
  const aRedaction: TRedactionID);
begin
 inherited Create;
 f_Redaction := aRedaction;
 f_ChangeType := aChangeType;
end;

class function TbsChangeRedationById.Make(
  const aChangeType: TnsChangeRedactionType;
  const aRedaction: TRedactionID): IbsChangeRedactionWorker;
var
 l_Class: TbsChangeRedationById;
begin
 l_Class := Create(aChangeType, aRedaction);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

{ TbsChangeRelationByDate }

function TbsChangeRelationByDate.Change(const aDocInfo: IdeDocInfo): Boolean;
begin
 Result := aDocInfo.ChangeRedaction(f_Date);
end;

constructor TbsChangeRelationByDate.Create(const aDate: BaseTypesUnit.TDate);
begin
 inherited Create;
 f_Date := aDate;
end;

class function TbsChangeRelationByDate.Make(
  const aDate: BaseTypesUnit.TDate): IbsChangeRedactionWorker;
var
 l_Class: TbsChangeRelationByDate;
begin
 l_Class := Create(aDate);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

{ TbsChangeRelationByHyperlink }

function TbsChangeRelationByHyperlink.Change(const aDocInfo: IdeDocInfo): Boolean;
begin
 Result := aDocInfo.ChangeRedaction(f_Document);
end;

constructor TbsChangeRelationByHyperlink.Create(
  const aDocument: IDocument);
begin
 inherited Create;
 f_Document := aDocument;
end;

class function TbsChangeRelationByHyperlink.Make(
  const aDocument: IDocument): IbsChangeRedactionWorker;
var
 l_Class: TbsChangeRelationByHyperlink;
begin
 l_Class := Create(aDocument);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

end.
