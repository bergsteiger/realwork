////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/DependencyGraph.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::DependencyGraph
//
// Граф зависимости - представляет собой набор элементов дерева генерации, связанных между собой
// связями зависимости.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_DEPENDENCYGRAPH_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_DEPENDENCYGRAPH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <vector>

//#UC START# *476FA2AD0179_CUSTOM_INCLUDES*
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/adjacency_list.hpp>
//#UC END# *476FA2AD0179_CUSTOM_INCLUDES*


class ObjectTreeResolver;
// Граф зависимости - представляет собой набор элементов дерева генерации, связанных между собой
// связями зависимости.
class DependencyGraph {
	SET_OBJECT_COUNTER (DependencyGraph)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// тип для задаяния расстояний между вершинами
	typedef int Distance;

	// контэйнер, определяющий путь из одной вершины в другую
	typedef std::vector < const ObjectTreeResolver* > Path;

	// контэйнер для хранения расстояний между вершинами графа
	typedef std::vector < Distance > Distances;

	// блок констант
	static const Distance UNDEFINED_DISTANCE; // константа, определяющая неопределённое расстояние - используется для определения расстояний между недостижимыми вершинами графа

private:
	// строка в таблице путей
	typedef std::map < const ObjectTreeResolver*, Path > PathTableRow;

	// таблица  путей - на пересечении строки (элемент A) и столбца  (элемент B) находится путь от
	// элемента A к B
	typedef std::map < const ObjectTreeResolver*, PathTableRow > PathTable;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~DependencyGraph ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// добавляет ребро в граф между элементами, вес ребра всегда равен 1
	virtual void add_edge (const ObjectTreeResolver* from, const ObjectTreeResolver* to);

	// возвращает true, если элемент находится в графе
	virtual bool exists (const ObjectTreeResolver* obj) const;

	// возвращает кратчайшее расстояние между элементами в графе
	virtual Distance get_distance (const ObjectTreeResolver* from, const ObjectTreeResolver* to);

	// возвращает список вершин, которые были пройдены при вычислении кратчайшего пути от from к to
	virtual Path* get_path (const ObjectTreeResolver* from, const ObjectTreeResolver* to);

private:
	// //рассчитывает расстояния от всех вершин графа до достижимых вершин
	virtual void calculate_distances ();

	// находит кратчайший путь от вершины from к вершине to в графе
	virtual Path* find_shortest_path (const ObjectTreeResolver* from, const ObjectTreeResolver* to);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// отображение элемента дерева генерации в путь, который был пройден при вычислении кратчайшего
	// пути из вершины, связанной с элементом дерева ко всем остальным вершинам графа.
	PathTable m_search_paths;

//#UC START# *476FA2AD0179*
public:
	//typedef std::set<const ObjectTreeResolver*> ReachableItems;
	void print_path (const ObjectTreeResolver* from, const ObjectTreeResolver* to);

private:
	typedef  boost::adjacency_list <
		boost::vecS
		, boost::vecS
		, boost::directedS
		, boost::no_property
		, boost::property <boost::edge_weight_t, int>
	> Graph;
				
	typedef boost::graph_traits<Graph>::vertex_descriptor VertexDescriptor;
	typedef boost::graph_traits<Graph>::vertex_iterator VertexIterator;
	typedef boost::graph_traits<Graph>::edge_descriptor EdgeDescriptor;
	

	typedef std::map<const ObjectTreeResolver*, VertexDescriptor> OTR2Vertex;
	typedef std::map<std::pair<const ObjectTreeResolver*, const ObjectTreeResolver*>, Distance> OTR2Distance;
	typedef std::vector<const ObjectTreeResolver*> OTRVector;

private:
	static const VertexDescriptor UNDEFINDED_VERTEX;
	
	//добавить элемент в граф, возвращает вершину графа, соответствующую данному элементу otr
	VertexDescriptor add_vertex (const ObjectTreeResolver* otr);
	
	//возвращает вершину графа, соответствующую данному элементу otr 
	VertexDescriptor get_vertex (const ObjectTreeResolver* otr) const;

	//возвращает элемент дерева генерации, соответствующий вершине vertex в графе
	const ObjectTreeResolver* get_otr (const VertexDescriptor& vertex) const;

	// отображение элемента дерева генерации на список расстояний до вершин графа, если вершина
	// недостижима, расстояние до такой вершины будет равно константе undefined_distance
	OTR2Distance m_otr_distances;
	
	//два отображения: vertex->otr и otr->vertex
	OTR2Vertex m_otr2vertex;
	OTRVector m_vertex2otr;
	
	Graph m_graph;
//#UC END# *476FA2AD0179*
}; // class DependencyGraph



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_DEPENDENCYGRAPH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

