#ifndef POSTGRES_BASE_CHOOSER_H
#define POSTGRES_BASE_CHOOSER_H

namespace postgres {

class PostgresBaseChooser {

public:
	PostgresBaseChooser (const char* file_bd);
	~PostgresBaseChooser ();
		
	void create_bd ();
	void restore_db ();

private:
	std::string m_file_db;
};

}

#endif //POSTGRES_BASE_CHOOSER_H