package dsparser.worker;

// ��� ����� ��������� ������������� (���������, ����������, �����)
public class Symbol {
	public String name;		// ���, ��� ��� ������������ � �������� ����
	public Integer line;	// ������ � ������� �������� �������������
	public Integer pos;		// �������, � ������� �������� �������������
	public Integer uses_count = 0; // ������� ��� ��� � ���� ������������
	
	public Symbol(
			String name,
			Integer line,
			Integer pos)
	{
			this.line = line;
			this.name = name;
			this.pos = pos;
	}
}
