package dsparser.worker;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.Map;
import java.util.TreeMap;

import org.antlr.runtime.tree.CommonTreeNodeStream;


public class AllUnits {
	
	// Содержит информацию о конкретном модуле
	public class Unit
	{
		public final String name;			// имя модуля как оно используется в коде
		public final UnitContext context;	// контекст модуля
		public CommonTreeNodeStream ast;	// абстрактное синтаксическлое дерево модуля
		public String file_name;			// имя файла в котором лежит модуль
		
		private Unit(String name)
		{
			this.name = name;
			this.context = new UnitContext(name, AllUnits.this);
		}
	}
	

	private final Map<String, Unit> data = new TreeMap<String, Unit>(String.CASE_INSENSITIVE_ORDER);
	
	// Добавляет модуль с указанным именем.
	public Unit Add(String name) 
	{		
		Unit unit = new Unit(name);
		data.put(name, unit);
		return unit;
	}
	
	// Отдает модуль с указанным именм или null если отсутствует.
	public Unit Get(String name)
	{
		return data.get(name);
	}
	
	// Отдает все модули (для их удобного перебора в цикле).
	public Collection<Unit> Units()
	{
		return data.values();
	}
	
	// Добавляет модуль из файла.
	public Unit AddFromFile(File file) throws IOException
	{
		Unit unit = Add(file.getName().replaceAll("(.*)\\.(.*)", "$1"));		
		unit.file_name = file.getCanonicalPath();
		return unit;
	}


}
