package dsparser.worker;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.Map;
import java.util.TreeMap;

import org.antlr.runtime.tree.CommonTreeNodeStream;


public class AllUnits {
	
	// �������� ���������� � ���������� ������
	public class Unit
	{
		public final String name;			// ��� ������ ��� ��� ������������ � ����
		public final UnitContext context;	// �������� ������
		public CommonTreeNodeStream ast;	// ����������� ��������������� ������ ������
		public String file_name;			// ��� ����� � ������� ����� ������
		
		private Unit(String name)
		{
			this.name = name;
			this.context = new UnitContext(name, AllUnits.this);
		}
	}
	

	private final Map<String, Unit> data = new TreeMap<String, Unit>(String.CASE_INSENSITIVE_ORDER);
	
	// ��������� ������ � ��������� ������.
	public Unit Add(String name) 
	{		
		Unit unit = new Unit(name);
		data.put(name, unit);
		return unit;
	}
	
	// ������ ������ � ��������� ����� ��� null ���� �����������.
	public Unit Get(String name)
	{
		return data.get(name);
	}
	
	// ������ ��� ������ (��� �� �������� �������� � �����).
	public Collection<Unit> Units()
	{
		return data.values();
	}
	
	// ��������� ������ �� �����.
	public Unit AddFromFile(File file) throws IOException
	{
		Unit unit = Add(file.getName().replaceAll("(.*)\\.(.*)", "$1"));		
		unit.file_name = file.getCanonicalPath();
		return unit;
	}


}
