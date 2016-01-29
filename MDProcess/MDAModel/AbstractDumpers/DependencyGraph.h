////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/DependencyGraph.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::DependencyGraph
//
// ���� ����������� - ������������ ����� ����� ��������� ������ ���������, ��������� ����� �����
// ������� �����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
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
// ���� ����������� - ������������ ����� ����� ��������� ������ ���������, ��������� ����� �����
// ������� �����������.
class DependencyGraph {
	SET_OBJECT_COUNTER (DependencyGraph)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ��� ��� �������� ���������� ����� ���������
	typedef int Distance;

	// ���������, ������������ ���� �� ����� ������� � ������
	typedef std::vector < const ObjectTreeResolver* > Path;

	// ��������� ��� �������� ���������� ����� ��������� �����
	typedef std::vector < Distance > Distances;

	// ���� ��������
	static const Distance UNDEFINED_DISTANCE; // ���������, ������������ ������������� ���������� - ������������ ��� ����������� ���������� ����� ������������� ��������� �����

private:
	// ������ � ������� �����
	typedef std::map < const ObjectTreeResolver*, Path > PathTableRow;

	// �������  ����� - �� ����������� ������ (������� A) � �������  (������� B) ��������� ���� ��
	// �������� A � B
	typedef std::map < const ObjectTreeResolver*, PathTableRow > PathTable;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~DependencyGraph ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� ����� � ���� ����� ����������, ��� ����� ������ ����� 1
	virtual void add_edge (const ObjectTreeResolver* from, const ObjectTreeResolver* to);

	// ���������� true, ���� ������� ��������� � �����
	virtual bool exists (const ObjectTreeResolver* obj) const;

	// ���������� ���������� ���������� ����� ���������� � �����
	virtual Distance get_distance (const ObjectTreeResolver* from, const ObjectTreeResolver* to);

	// ���������� ������ ������, ������� ���� �������� ��� ���������� ����������� ���� �� from � to
	virtual Path* get_path (const ObjectTreeResolver* from, const ObjectTreeResolver* to);

private:
	// //������������ ���������� �� ���� ������ ����� �� ���������� ������
	virtual void calculate_distances ();

	// ������� ���������� ���� �� ������� from � ������� to � �����
	virtual Path* find_shortest_path (const ObjectTreeResolver* from, const ObjectTreeResolver* to);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ����������� �������� ������ ��������� � ����, ������� ��� ������� ��� ���������� �����������
	// ���� �� �������, ��������� � ��������� ������ �� ���� ��������� �������� �����.
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
	
	//�������� ������� � ����, ���������� ������� �����, ��������������� ������� �������� otr
	VertexDescriptor add_vertex (const ObjectTreeResolver* otr);
	
	//���������� ������� �����, ��������������� ������� �������� otr 
	VertexDescriptor get_vertex (const ObjectTreeResolver* otr) const;

	//���������� ������� ������ ���������, ��������������� ������� vertex � �����
	const ObjectTreeResolver* get_otr (const VertexDescriptor& vertex) const;

	// ����������� �������� ������ ��������� �� ������ ���������� �� ������ �����, ���� �������
	// �����������, ���������� �� ����� ������� ����� ����� ��������� undefined_distance
	OTR2Distance m_otr_distances;
	
	//��� �����������: vertex->otr � otr->vertex
	OTR2Vertex m_otr2vertex;
	OTRVector m_vertex2otr;
	
	Graph m_graph;
//#UC END# *476FA2AD0179*
}; // class DependencyGraph



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_DEPENDENCYGRAPH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

